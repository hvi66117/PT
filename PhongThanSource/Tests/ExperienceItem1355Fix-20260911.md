# Item 1355: silent use failure

## Confirmed cause

`ScriptFuns.cpp::GetPlayerIndex` leaves `PlayerIndex` on the Lua C stack.
`LuaHaveNormalItemCompat` and `LuaDelNormalItemCompat` called it before
`GetVngNormalTuple`. For the four-argument call `(6,1,1355,1)`, the appended
player index was treated as the optional fifth argument (item series).
The starter bag creates item 1355 with runtime detail 1355, level 1, series 0;
the accidental positive series filter rejected it. Lua returned normally,
so `ExecuteScript_RESULT=1` did not mean consumption or EXP had occurred.

Both wrappers now restore the original argument stack after obtaining the
player index, before parsing the item tuple. Explicit series filtering remains.
No general `GetPlayerIndex` behavior, item schema, PAK policy or other Lua was changed.

## Lua and resource loading

The prior runtime edit of `script/item/³¬¼¶¾­Ñéµ¤.lua` remains in place:
no minimum level/daily counter; original EXP formula with a minimum of 1 EXP;
the existing level-200 buff branch remains. On 2026-09-11 the real runtime
`KPakFile`/`KLuaScript` selected the 1420-byte loose fallback (`packed=0`).
This is not an unverified PAK override issue.

## Verification

`Tests/Test-ExperienceItem1355.ps1` builds a regression using the runtime
Engine/Lua 4 binaries and the exact affected C++ functions extracted from
`ScriptFuns.cpp`; only inventory/world effects are fixtures, not a live character.

- Before fix: `HaveNormalItem(6,1,1355,1)==20` failed with 20 owned items.
- After fix: 12 consecutive uses at level 1 consume 12 items and add 12 EXP.
- Empty inventory, missing arguments, explicit incompatible series: no reward.
- Level 40: original 94100 EXP; level 200: confirmation and buff preserved.
- Incremental CoreServer and CoreClient builds: succeeded.

`PhongThanLoginProbe` mode `exp1355` uses normal authenticated gameplay packets
and the existing starter bag, not direct database edits. Live test against
the new CoreServer on account 123456 / character PhongThanPlay:

```
AUTH_RESULT=0
CHARACTERS=3
PERMIT=1 port=6666
PASS LIVE_1355 level=1 consumed_uid=101 exp=1 entity=2221
```

The test checks both removal of the newly granted item and the EXP response.
No claim of a GUI click test is made. The old server exited with 0xC0000005
while stopping for deployment, so complete saving of its last session was
not confirmed; the new service chain subsequently started successfully.

## Deployment

Only CoreServer.dll and CoreClient.dll were copied to the corresponding
PhongThanRuntime-Staging directories. Their entries in NATIVE_DEPLOYMENT.json
were updated; unrelated dirty source/content was not reverted or republished.
