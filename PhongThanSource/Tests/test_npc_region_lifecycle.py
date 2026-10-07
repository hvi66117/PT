from pathlib import Path
import unittest

ROOT = Path(__file__).parents[1]


class ClientNpcRegionLifecycleTests(unittest.TestCase):
    def test_min_and_full_snapshots_reject_previous_world_before_lookup(self):
        source = (ROOT / "Sources/Core/Src/KProtocolProcess.cpp").read_bytes()
        for signature in (b"void KProtocolProcess::SyncNpc(BYTE* pMsg)",
                          b"void KProtocolProcess::SyncNpcMin(BYTE* pMsg)"):
            body = source[source.index(signature):]
            self.assertLess(body.index(b"NpcSync->MapId !="),
                            body.index(b"NpcSet.SearchID"))

    def test_world_transition_clears_old_cached_entities_but_preserves_self(self):
        source = (ROOT / "Sources/Core/Src/KSubWorld.cpp").read_bytes()
        source = source[source.index(b"BOOL KSubWorld::LoadMap(int nId, int nRegion)"):]
        start = source.index(b"if (nId != m_SubWorldID)")
        end = source.index(b"m_SubWorldID = nId;")
        transition = source[start:end]
        self.assertIn(b"nOldNpc != Player[CLIENT_PLAYER_INDEX].m_nIndex", transition)
        self.assertIn(b"NpcSet.Remove(nOldNpc)", transition)
        self.assertLess(transition.index(b"SubWorld[0].Close()"),
                        transition.index(b"NpcSet.Remove(nOldNpc)"))

    def test_production_uses_tested_lifecycle_implementations(self):
        npc_set = (ROOT / "Sources/Core/Src/KNpcSet.cpp").read_bytes()
        subworld = (ROOT / "Sources/Core/Src/KSubWorld.cpp").read_bytes()
        self.assertIn(b'#include "PhongThanClientNpcReattach.inl"', npc_set)
        self.assertIn(b'#include "PhongThanClientNpcChangeRegion.inl"', subworld)


if __name__ == "__main__":
    unittest.main()
