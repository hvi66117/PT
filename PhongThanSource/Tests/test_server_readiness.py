from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).parents[1]
START = ROOT / "Deploy/Start-NativeServer.ps1"


class ServerReadinessTests(unittest.TestCase):
    def check_marker(self, content, offset=0, expected=True):
        with tempfile.TemporaryDirectory(prefix="phongthan-ready-") as tmp:
            marker = Path(tmp) / "ready.log"
            marker.write_bytes(content)
            # Load only this read-only parser function, never the startup body.
            script = """
            $source=[IO.File]::ReadAllText('%s')
            $tokens=$null; $errors=$null
            $ast=[Management.Automation.Language.Parser]::ParseInput($source,[ref]$tokens,[ref]$errors)
            if($errors.Count){throw $errors[0]}
            $func=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq 'Read-NativeWorldReadyMarker'},$true)
            Invoke-Expression $func.Extent.Text
            $result=Read-NativeWorldReadyMarker -Path '%s' -AfterOffset %d -BishopPid 1234 -ServiceId 1001 -ExpectedMapCount 102
            if($result){'READY'}else{'NOT_READY'}
            """ % (str(START).replace("'", "''"), str(marker).replace("'", "''"), offset)
            result = subprocess.run(["powershell", "-NoProfile", "-NonInteractive", "-Command", script],
                                    capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.strip(), "READY" if expected else "NOT_READY")

    def test_current_complete_registration(self):
        self.check_marker(b"WORLD_READY bishop_pid=1234 service=1001 maps=102\n")

    def test_stale_session_and_partial_map_count_rejected(self):
        self.check_marker(b"WORLD_READY bishop_pid=55 service=1001 maps=102\n"
                          b"WORLD_READY bishop_pid=1234 service=1001 maps=52\n", expected=False)

    def test_old_offset_and_reused_pid_not_accepted(self):
        old = b"WORLD_READY bishop_pid=1234 service=1001 maps=102\n"
        self.check_marker(old, len(old), expected=False)
        self.check_marker(old + old, len(old))

    def test_partial_line_and_wrong_service_rejected(self):
        self.check_marker(b"WORLD_READY bishop_pid=1234 service=1001 maps=102", expected=False)
        self.check_marker(b"WORLD_READY bishop_pid=1234 service=1002 maps=102\n", expected=False)

    def test_readiness_wait_is_outside_force_cleanup(self):
        source = START.read_text()
        self.assertLess(source.index("Stop-Process -Id $process.Id -Force"), source.index("$readyDeadline="))
        self.assertNotIn("Stop-Process", source[source.index("$readyDeadline="):])
        bishop = (ROOT / "Sources/MultiServer/Bishop/GameServer.cpp").read_bytes()
        body = bishop[bishop.index(b"bool CGameServer::_UpdateMapRegistry"):]
        self.assertLess(body.index(b"RegisterServer((UINT)pMapIds[i]"), body.index(b"WORLD_READY bishop_pid="))


if __name__ == "__main__":
    unittest.main()
