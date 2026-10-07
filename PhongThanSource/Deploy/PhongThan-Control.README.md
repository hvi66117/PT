# Phong Than runtime control

Open `D:\Lam game phong than\PhongThan-Control.cmd`.

- Bat server: uses Start-NativeServer.ps1, validates deployment, initializes LocalDB,
  starts Goddess, AccountServer, Relay, Bishop, GameServer and checks their ports.
- Mo client: uses Start-StagingClient.ps1 with 25-second initialization allowance.
- Dung server: signals Local\PhongThan.Stop.<PID>, waits for GameServer exit 0;
  then stops supporting services in reverse order. Client and LocalDB remain open.
- Trang thai: lists processes belonging to the exact runtime role directories.
- Cap nhat build: publishes only when server and client have exited.
- Tao tai khoan: opens a local account-creation form. Enter an ASCII alphanumeric
  account name (6-16 characters), password (6-16 printable ASCII characters, no
  spaces), and password confirmation. Password inputs are masked.

Account creation uses the `[account]` endpoint in runtime `Server\DataBase.ini`.
It works without a game-server restart while the configured database is reachable;
if LocalDB is stopped or its pipe has changed, start the server to refresh it first.
The new account has no character: log in and create one through the client.
Initial secondary/deletion password equals the login password. Local test playtime
is provisioned with the same one-year deposit fields used by the test accounts;
no items, levels, points, GM permissions or existing characters are modified.

Both `Account_Info` and `Account_Habitus` are inserted atomically. Existing names
(including a partially existing record in either table) are rejected, never
overwritten. Password proof must be uppercase MD5 to match
`Sources\Engine\Src\KSG_MD5_String.cpp` and the server's case-sensitive comparison;
this is legacy protocol compatibility, not suitable for a public registration site.
Passwords are not put on process command lines or written into control logs.
The account operation runs off the UI thread; closing is disabled until it finishes.

Backend: `Deploy\AccountRegistration.ps1`. UI: `Deploy\PhongThan-AccountForm.ps1`.
Focused validation (database changes are rolled back; no test account is retained):

```powershell
& .\Tests\Test-AccountRegistration.ps1 -Database
```

Direct form launch:

```powershell
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File .\Deploy\PhongThan-Control.ps1 -Action CreateAccount
```

Shutdown is not forced. On timeout or nonzero exit, supporting services remain
running for investigation. GameServer waits up to 30 seconds per active character
for SAVE_IDLE; failure is reported through exit 2 and gameserver_login_diag.log.
The UI operation runs separately so the control panel remains responsive.
Logs: PhongThanRuntime-Staging\ControlLogs.

Deployment note 2026-09-10: new GameServer binary built, not published over the
running old server. Old server does not expose the event and is refused by Stop.
Its last logs show a world-session timeout; do not claim a clean-save shutdown
has been validated on that process. A safe maintenance transition is required.

Validation: PowerShell syntax and status checked; native GameServer built.
Live save-and-shutdown acceptance remains pending deployment of the new binary.
