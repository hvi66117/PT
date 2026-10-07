# PAK cache race fix (2026-09-08)

Dump `Game.exe.18164.dmp`, exception 0xc0000005 in ntdll. Raw stack scan (not a debugger unwind) includes:
- CoreClient+0x74CA7: KScenePlaceRegionC::Load
- Engine+0x1D1B1: KPakFile::Read
- Engine+0x2AEA2: XPackFile::ElemFileRead
- Engine+0x2ADBD: XPackFile::AddElemFileToCache
- Engine+0x2AA0F: XPackFile::FreeElemCache

Code defect: `ms_ElemFileCache` and its count are static across archives, while read/eviction/close used each archive's individual critical section. Region-loader and render/audio reads across different PAKs could race the same cache allocation/free. A shared recursive critical section now covers these operations. Cache lookup also checks archive identity, so a lower-priority archive's cached entry cannot impersonate a higher-priority entry with the same ID.

`Tests/Native/PakConcurrentReadTests.cpp`: four native threads, 17 entries spanning overridden items and original settings, 2040 total reads, cache capacity 10. New Engine test: exit 0, zero byte mismatches. This exercises eviction under contention; it does not prove every graphical gameplay path is crash-free. No save data edited.
