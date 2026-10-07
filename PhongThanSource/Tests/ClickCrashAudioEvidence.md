# Click crash investigation — 2026-09-08

Dump: `C:/Users/UCT/AppData/Local/CrashDumps/Game.exe.13804.dmp`.
Windows event: heap corruption 0xc0000374 detected by AcLayers.dll.
Raw stack address scan (not a symbol-unwound stack) matches current map symbols:
CoreClient +0x238A8 -> KNpcRes::PlaySound, Engine +0x27AD5 -> KWavSound::IsPlaying,
Engine +0x279E0 -> KWavSound::GetPlayBuffer, plus DirectSound/AudioSes/AcLayers addresses.
This localizes detection to sound-status handling; it does not prove which earlier write corrupted the heap.

Implemented: zero-initialize WAV format/header, require complete reads and valid
PCM/IMA fields, normalize PCM cbSize, reject audio data extending beyond file,
initialize decoded PCM average byte rate, guard null DirectSound on load and
release buffers without depending on a live global sound device.

Launcher now uses HIGHDPIAWARE without WINXPSP3. This avoids the XP shim on the
sound path but is not itself proof that all heap corruption is resolved.

WaveFormatTests passed against the newly built Engine.dll in isolated
Output/WaveFormatTest with Output/Client on PATH. An earlier test inadvertently
loaded stale Output/Tools/Engine.dll; that result is not acceptance evidence.
Native valid PCM format and truncated-data rejection tested. Graphical click/
movement/audio acceptance remains pending. No character data was changed.
