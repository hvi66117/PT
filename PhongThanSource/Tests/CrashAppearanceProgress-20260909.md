# Crash and appearance progress

- Dump: `C:/Users/UCT/AppData/Local/CrashDumps/Game.exe.2144.dmp`.
- Engine RVA 0x17c3b maps to g_MemCopy (VA 0x10017c20), NOT
  KMp3Music assignment. The previous mapping confused section offsets with RVA.
- Stack scan includes Engine+0xed1d (KIniFile::SetKeyValue) and
  Engine+0xf194 (KIniFile::WriteInteger). This is a raw stack scan.
- KIniFile replacement allocated on every write; KMemStack::Free is a no-op.
  Replacement now reuses a sufficiently long existing value and preserves the
  old value if allocation fails. New-section/key allocations are checked.
- Engine and CoreClient incremental Release builds passed.
- Native IniUpdateStress passed 2,000,000 repeated integer updates against the
  newly built Engine.dll. Variable-length values can still grow the arena;
  this is not proof of absence of every client crash.
- KSprControl resets frame/direction on sprite change. Set64DirFrame now uses
  the converted sprite direction, not the original 64-way index.
- Mounted sprite catalog: 38 paths, 800 frames, 18 header failures. Catalog
  includes speculative hb paths; failures are NOT proof all are required.
  Some Seaweed mount headers report 1 direction while containing 40 frames.
- No graphical equip/mount/relog acceptance performed in this pass. Appearance
  issue remains open; do not report it as fixed solely from build success.
