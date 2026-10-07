# VNG frame-compressed RGB SPR, 2026-09-09

`update0_171-171.pak` contains `\spr\npcres\human\jsx07_hh_rs0.spr`:
stored flag 0x111AE30C, expanded size 2346851, canvas 800x800,
centre 400x400, 40 frames, 256 declared colours, 8 directions.
After its 32-byte SPR header comes the compressed-frame table, not a
768-byte global palette. The previous indexed-only PAK loader rejected it.

XPackFile now tries a bounded palette-free frame decode if indexed loading
fails, validates every RGB RLE frame, then uses NormalizeSeaweedSpr to build
the same per-frame palette format already supported by Represent2.
PAK assets are unchanged. Existing indexed loading remains first.

Engine Release build passed. SprLoaderAudit against the new Engine:
Tests/EquippedSpritePaths.txt: 5 files, 200 frames, 0 failures (previously
160 frames, 1 failure). The wider 38-path speculative mount catalog still
has 16 failures, including hb filenames; it is not an all-assets acceptance.

F4 was separately changed to centre the original-sized icon and only scale
down, avoiding enlargement of low-resolution inventory art. This does not
create higher-resolution artwork. In-game equip/mount acceptance is pending.
