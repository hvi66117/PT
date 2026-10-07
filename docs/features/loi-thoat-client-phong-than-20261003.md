---
tiêu đề: Lỗi thoát client Game.exe (0xc0000005 offset ...a350, 0xc0000094 CoreClient)
ngày: 2026-10-03
phạm vi: Client (CoreClient.dll, Engine.dll), dữ liệu ptfix dùng chung Server/Client
trạng thái: đã sửa dữ liệu (plug-in ptfix); đã sửa tận gốc trong C++ và dựng client VS2022 (mục 2.6), chờ triển khai
---

# Lỗi thoát client Phong Thần ngày 2026-10-02/03

## Phần 1: Tổng quan

**Kết luận chính:**

1. **Lỗi "unknown" + offset kết thúc bằng `a350` là lỗi lúc THOÁT game, không xảy ra khi đang chơi.**
   - Minidump cho thấy luồng `exit()` → `LdrShutdownProcess` → hàm `atexit` của CoreClient hủy biến tĩnh `g_SoundCache`.
   - `g_SoundCache` gọi `KWavSound::Free` (Engine.dll) → `IDirectSoundBuffer::Release` trên các buffer mà DirectSound đã giải phóng từ trước (`KMyApp::GameExit` → `m_Sound.Exit()`).
   - Con trỏ vtable trỏ vào vùng heap đã giải phóng nên EIP nhảy vào heap. Vì vậy Windows ghi module là "unknown" và offset là địa chỉ heap. Đuôi `a350` lặp lại vì bố cục heap giống nhau ở mỗi lần chạy.
   - Lỗi này **có từ 2026-09-28**: WER ghi hàng chục lần với chữ ký `StackHash_2beb` hoặc `Engine.dll+0x27b50`. Nó không phải lỗi mới do ptfix v19 hay Npcs.txt.
2. **Lần thoát lúc 14:42:53 là hệ quả của GameServer sập lúc 14:42:02** (CoreServer.dll, 0xc0000094, offset 0x8521).
   - Client mất kết nối, `client_login_trace.log` kết thúc bằng chuỗi kết nối lại.
   - Người chơi đóng game, lúc đóng thì dính lỗi thoát ở trên.
   - Lần 14:29:47 là đóng game bình thường (client mới mở lại lúc 14:29:57), cũng dính lỗi thoát.
3. **Lỗi thật trong lúc chơi là chia cho 0 (0xc0000094) trong CoreClient**, cùng gốc với lỗi server:
   - `+0xae18` (2026-10-02 08:13) = `KSkill::CastExtractiveLineMissle`, chia cho `Missle.m_nSpeed` = 0. Server sập lúc 14:01 và 14:42 hôm nay (`CoreServer+0x8521`) cũng chính là phép chia này: `g_GetDistance(...) / speed`, rồi `m_nCellWidth / speed`.
   - `+0xb82f` (2026-10-02 08:33 và 20:59) = `KSkill::CastSpread`, chia cho `nDistance` = 0. Đây đúng là lỗi đã sửa ở server (`if (nDistance <= 0) nDistance = 1;`). Lúc 20:59:32 client sập và 1 giây sau server sập.
4. **Nguyên nhân dữ liệu của lỗi tốc độ 0:** missile 9 (冰雪弹, Băng Tuyết Đạn) có `MoveKind=1` (Line) và `Speed=0`.
   - Skill 5 (Băng Tuyết Đạn) và skill 67 (npc Băng Tuyết Đạn) có `MisslesForm=1` và `ChildSkillNum=1`, nên đi vào đúng nhánh `CastExtractiveLineMissle`.
   - Từ 2026-10-02 quái được gán skill thật và có 40 bot đứng gần người chơi. Mỗi lần skill 67 hoặc 5 được tung, cả server lẫn client đều chia cho 0.

**Đã làm:**
- Plug-in mới `S\ptfix\extra_clientcrash.py`: đặt `Speed=2` cho missile rơi vào nhánh này (hiện chỉ có missile 9). Bản dựng thử đã chạy thành công.
- Đề xuất 3 bản vá byte cho CoreClient.dll (đã kiểm tra trên bản sao) và phương án dựng lại CoreClient bằng C++.

## Phần 2: Chi tiết

### 2.1 Bằng chứng từ dump

| Dump (LocalAppData\CrashDumps) | Giờ | Mã | Ngăn xếp chính |
|---|---|---|---|
| Game.exe.42828.dmp | 03/10 14:43 | 0xc0000005 tại 0x0107a350 (heap) | `0x107a350` ← `Engine+0x27b56` (KWavSound::Free) ← DllMain DETACH của CoreClient ← `LdrShutdownProcess` ← `exit` ← `Game+0x82564` |
| Game.exe.45084.dmp | 03/10 14:29 | 0xc0000005 tại 0x03aba350 | giống hệt; CoreClient bị relocate về 0x00cf0000 |
| Game.exe.2700/2328/31828.dmp | 02/10 20:39–20:55 | 0xc0000005 ...a350 | giống hệt |
| Game.exe.3752.dmp | 02/10 20:59 | 0xc0000094 tại CoreClient+0xb82f | `CastSpread` (CoreClient.map 0001:0000a730 = 0x1000b730); `nLauncher=3`, `eParentType=2` (missile), `nTargetId=2` |

Mã máy tại 0x1000b80c..b82f (CastSpread): `imul/add` → `fsqrt` → `_ftol` → `mov ecx,eax` → `shl eax,0Ah` → `idiv ecx`, tức `nXFactor = (dx<<10)/nDistance`. Khi tên lửa cha đã tới đúng vị trí mục tiêu thì `nDistance = 0`.

Mã máy tại 0x1000ae18 (CastExtractiveLineMissle, 0001:00009b70): `idiv dword ptr [esi+Missle+0x64]`, tức `m_nSpeed`, thuộc các dòng 1565/1566 trong KSkills.cpp.

Thứ tự hủy khi thoát (`PhongThanClient.cpp` dòng 333–361):
- `g_pCoreShell->Release()` → `g_ReleaseCore()`. Hàm này **không** giải phóng `g_SoundCache`.
- `m_Sound.Exit()` giải phóng DirectSound.
- `exit()` → `atexit` của CoreClient (0x10056220, đăng ký tại 0x10056210) → `KSoundCache::~KSoundCache` → Release buffer đã chết.

### 2.2 Các lỗi khác trong WER (không thuộc phạm vi lần này)
- `Engine.dll+0x2ac9f` (29/09, 01/10) và `windows.storage.dll 0xc00001a5` cùng lúc: một chuỗi lỗi khác, xảy ra ít.
- Không thấy dấu hiệu lỗi do `Npcs.txt` (Stature bot), `barback.spr`, `UiOptions.ini` hay item hover. Không dump nào có ngăn xếp đi qua phần vẽ NPC, UI hay item.

### 2.3 Sửa dữ liệu: `extra_clientcrash.py`
- Đọc `\settings\missles.txt` và `\settings\skills.txt` (ưu tiên bản đã nằm trong `entries`, sau đó tới bản hiệu lực).
- Tìm skill có `MisslesForm` = 1 hoặc 2, có `ChildSkillNum = 1` (hoặc có LvlSetting `skill_misslenum_v`), và missile con có `MoveKind = 1` (hoặc 7 khi form = 1) với `Speed < 2`.
- Đặt `Speed = 2` cho các missile đó. Chọn 2 vì `KNpc::ModifyMissleSpeed` chia đôi tốc độ khi trúng hiệu ứng làm chậm, nên 1 sẽ thành 0 lại.
- Kết quả hiện tại: `missles.txt speed fix: 9(0->2 skills 5,67)`. Chỉ đúng dòng missile 9 thay đổi, số dòng và kiểu xuống dòng giữ nguyên.
- 357 missile `Stand` và 23 missile `Line` tốc độ 0 khác (dùng cho skill AoE, AtTarget...) **không bị đụng tới**, vì chúng không đi qua phép chia.
- Kết quả không phụ thuộc SIDE: bản dựng Server và Client cho ra entry `missles.txt` giống hệt nhau. Missles.txt gốc ở vng00.pak của cả 2 bên cũng giống hệt.
- Ảnh hưởng gameplay: Băng Tuyết Đạn trôi 2 px/khung trong 12 khung (khoảng 24 px). Trước đây đứng yên, nên nhìn gần như không khác. Muốn thành đạn bay thật thì tăng `MIN_SPEED`, ví dụ lên 24.

### 2.4 Đề xuất vá byte CoreClient.dll (TimeStamp 0x6aaa74c1)

File offset = RVA (`.text` có VA 0x1000 và raw 0x1000). Cả ba vùng đã được kiểm tra: không có relocation trong cave và tại điểm gọi; ở vùng destructor chỉ đổi byte opcode, còn 2 relocation ở 0x56221/0x56227 nằm trong phần không bao giờ chạy tới.

| # | Mục đích | Context | Before | After |
|---|---|---|---|---|
| A | Bỏ hủy `g_SoundCache` lúc thoát (atexit 0x10056220 → `ret`), sửa lỗi thoát `...a350` | 0x56220 | `b908630011ff2590700810` | `c308630011ff2590700810` |
| B1 | Code cave cho CastSpread (14 byte NOP đệm ở 0x1000b722): `mov ecx,eax / cmp ecx,1 / adc ecx,0 / mov eax,edi / shl eax,0Ah / ret` | 0xb722 | `9090909090909090909090909090` | `8bc883f90183d1008bc7c1e00ac3` |
| B2 | CastSpread gọi cave: `call 0x1000b722 / nop / nop`, nghĩa là `nDistance == 0` thì thành 1 | 0xb827 | `8bc88bc7c1e00a` | `e8f6feffff9090` |

- Vá A chỉ làm mất phần giải phóng bộ nhớ lúc tiến trình đã kết thúc (hệ điều hành tự thu hồi). Không ảnh hưởng gì khi đang chơi.
- B1 phải nằm **trước** B2 trong danh sách `$Patches`. Nếu chỉ vá B2 mà thiếu B1 thì sẽ nhảy vào NOP rồi chạy tiếp vào CastSpread, gây sập.
- Đã thử trên bản sao `S\clientcrash\CoreClient_patched_test.dll`: cdb disassemble ra đúng mã mong muốn.
- Lỗi tốc độ 0 (0xae18) không vá byte được an toàn, vì lệnh `idiv [esi+abs32]` có relocation. Lỗi này đã được xử lý bằng dữ liệu ở mục 2.3.

### 2.5 Đề xuất dựng lại CoreClient bằng C++ (`Build-Modern.ps1 -Targets CoreClient`)

Mã nguồn hiện tại đã có `PT_SAFE_SPEED` và guard `nDistance <= 0` cho cả client (không nằm trong `#ifdef _SERVER`). Cần thêm hoặc chuyển vào nguồn:

| Hạng mục | Trạng thái trong nguồn | Việc cần làm |
|---|---|---|
| `KItemList::UseItem` nhận player index 0 (vá 0x4f7e7) | Đã có (`#else if (m_PlayerIdx < 0)`) | Không |
| `KItemList::NowEatItem` (vá 0x4f66a) | Đã có | Không |
| `KItemList::Fit` x2, pháp bảo vào ô Talisman (vá 0x4f389, 0x4f4ad) | Đã có | Không |
| Thanh máu 0% không vẽ (vá 0x7a44b, `PaintPhongThanLifeBarOverlay`) | **Chưa có**: nguồn vẫn kẹp `nPercent<0 → 0` rồi vẽ | `KScenePlaceC.cpp` dòng 138–140: đổi thành `if (nPercent <= 0) return;` |
| Lỗi thoát `g_SoundCache` (vá A) | **Chưa có** | `KCore.cpp` `g_ReleaseCore()`, nhánh `#else` (client): thêm `g_SoundCache.Release();`. Hàm này chạy trước `m_Sound.Exit()` nên an toàn |
| CastSpread `nDistance` (vá B) | Đã có (dòng 1933) | Không |
| Tốc độ missile 0 (0xae18) | Đã có `PT_SAFE_SPEED` | Không |
| Represent2 "npcres\" | Thuộc Represent2.dll, không thuộc CoreClient | Không |

Rủi ro khi dựng lại:
- CoreClient bản mới (MSVC v143) liên kết với `Engine.lib` bản mới, nên phải triển khai **cùng** Engine.dll (và LuaLibDll) bản mới. Không ghép với Engine.dll VC6 cũ, vì `new/delete` và ABI lớp chạy chéo giữa hai CRT khác nhau.
- `PhongThan-ClientPatch.ps1` tự bỏ qua các vá CoreClient khi TimeStamp khác 0x6aaa74c1, nên không vá nhầm.
- Cần cập nhật `NATIVE_DEPLOYMENT.json` (Sha256) giống cách script vá đang làm.

### 2.6 Sửa tận gốc: dựng lại client bằng VS2022 (2026-10-03, chờ triển khai)

**Kết luận:** mọi bản vá byte phía client giờ đã nằm trong mã nguồn C++. Bộ client mới (MSVC v143) đã dựng xong, 0 lỗi, nằm ở `PhongThanSource\OutputModern\Client\`. Phải triển khai **cùng lúc 5 module** sau, không được ghép lẻ với bản VC6:

| Module | Lý do phải đi cùng | TimeStamp mới | SHA256 (đầu) |
|---|---|---|---|
| `Game.exe` | Import 103 hàm/lớp C++ của Engine.dll | 0x6ac0bb6a | 90AB2729… |
| `CoreClient.dll` | Chứa các bản sửa; import 101 hàm của Engine, 18 hàm của LuaLibDll | 0x6ac0bb1a | 64C210F0… |
| `Engine.dll` | Dùng chung CRT (ucrtbase) với các module trên; trùng khít bản server đang chạy | 0x6abf7ba1 | 43FD3602… |
| `LuaLibDll.dll` | Trùng khít bản server đang chạy | 0x6abf7207 | 53CBC379… |
| `Represent2.dll` | Bản vá 0xB0C3 nay nằm trong nguồn; import 46 hàm C++ của Engine | 0x6ac0bb1b | 13CA843F… |

- Lý do không thay riêng CoreClient: Game.exe, CoreClient, Represent2 gọi Engine qua lớp C++ và `new/delete`. Bản VC6 dùng `msvcrt/msvcp60`, bản mới dùng `ucrtbase/vcruntime140`. Ghép lẫn thì bộ nhớ cấp phát ở CRT này có thể bị giải phóng ở CRT kia.
- Giữ nguyên bản VC6: `Represent3.dll` (chỉ dùng khi `config.ini` đặt `Represent=3`; hiện đang là 2), `Heaven/Rainbow/ExpandPackage/FilterText.dll`. Các module này giao tiếp qua giao diện C/COM, giống cách server bản mới đang chạy. FilterText ở Game.exe nay được liên kết tĩnh từ bản dựng mới.
- Game.exe giữ cờ như bản VC6: **không** bật LARGEADDRESSAWARE, **không** bật NX/DEP (`Build-Modern.ps1` chỉ đặt riêng cho GameClient).
- Máy chạy client cần Visual C++ 2015–2022 Redistributable **x86**. Máy này đã có sẵn (14.51).

**Bảng ánh xạ vá byte → mã nguồn**

| Vá byte (`PhongThan-ClientPatch.ps1`) | Mã nguồn tương ứng | Trạng thái |
|---|---|---|
| CoreClient 0x4f7e7 `KItemList::UseItem` nhận player index 0 | `KItemList.cpp` (`#else if (m_PlayerIdx < 0)`) | Đã có từ trước |
| CoreClient 0x4f66a `KItemList::NowEatItem` | `KItemList.cpp` | Đã có từ trước |
| CoreClient 0x4f389 / 0x4f4ad `KItemList::Fit` x2 (pháp bảo vào 2 ô Talisman) | `KItemList.cpp` (`equip_amulet` → amulet/ring1/ring2) | Đã có từ trước |
| CoreClient 0x7a44b: thanh máu 0% không vẽ | `Scene\KScenePlaceC.cpp` `PaintPhongThanLifeBarOverlay`: `if (nPercent <= 0) return;` | **Mới thêm** |
| CoreClient 0x56220: lỗi thoát `g_SoundCache` | `KCore.cpp` `g_ReleaseCore()` nhánh client: `g_SoundCache.Release();` (chạy trước `m_Sound.Exit()`, nên destructor lúc thoát gặp danh sách rỗng) | **Mới thêm** |
| (Đề xuất B1/B2) CastSpread `nDistance = 0` | `KSkills.cpp` `if (nDistance <= 0) nDistance = 1;` | Đã có từ trước |
| (Không vá được) tốc độ missile 0 | `KSkills.cpp` `PT_SAFE_SPEED` + dữ liệu `extra_clientcrash.py` | Đã có từ trước |
| Represent2 0xB0C3 `npcres\passerby\` → `npcres\` | `Represent\iRepresent\PhongThanSpriteAnchor.h`: `PhongThanUsesActorCanvas` nhận mọi đường dẫn `npcres\` cho canvas 510×510 | **Mới thêm** (tài liệu 2026-09-30 ghi "đã sửa gốc" nhưng nguồn chưa có) |
| (Thêm) `barback.spr` bị lệch (−160, −192) | `KScenePlaceC.cpp`: `Background.bRenderFlag = 0` (vẽ theo góc trên trái). Bản sửa dữ liệu `extra_botvisual.py` vẫn giữ, vô hại | **Mới thêm** |

Không còn vá byte client nào khác: so sánh từng byte bản runtime với `_backup\client-patch\*.orig` chỉ thấy đúng các vị trí trên.

**Các chỗ sửa để biên dịch được bằng VS2022** (không đổi hành vi): `KPlayer.h` (friend thiếu kiểu trả về), `KNpc.cpp` (bỏ `gets()` đọc stdin, vốn luôn trả NULL trong client GUI), `ScriptFuns.cpp` và 2 file GameClient (thêm `winsock2.h`), `KProtocolProcess.cpp` (bảng con trỏ hàm phía client dùng `&KProtocolProcess::`), 18 dòng nối chuỗi với macro (`"..." MACRO`), `FilterTextLib.h` (liên kết bản FilterText tĩnh mới).

**Kiểm tra offline (không cần chạy game):**
- So export/import (`dumpbin`): Engine, LuaLibDll, CoreClient, Represent2 bản mới **không thiếu export nào** so với bản VC6. Mọi import của Game.exe, CoreClient, Represent2 bản mới, cùng 17 import của Represent3 VC6, đều có trong Engine bản mới.
- Harness 32-bit (`S\coreclient\harness.ps1`) nạp đủ 5 DLL và tìm thấy `CoreGetShell`, `CreateRepresentShell`, 7 hàm `lua_*` mà Game.exe dùng. Sau đó harness chạy đúng trình tự khởi động như `KMyApp::GameInit`: `g_SetRootPath` → `KPakList::Open(\package.ini)` → `CoreGetShell()`.
  - Kết quả: `g_InitCore COMPLETED 100OK!`. Log khởi tạo giống hệt bản VC6 chạy cùng harness.
  - Tiếp theo harness gọi `iCoreShell::Release()` (trong đó có `g_SoundCache.Release()`), rồi thoát tiến trình bằng `ExitProcess` (chạy destructor atexit của CoreClient): tiến trình thoát sạch.
  - Harness **không** có DirectSound, nên lỗi thoát `...a350` phải kiểm tra lại trong game.

**Triển khai (coordinator làm, lúc client đã đóng):**
- `_backup\20261003-coreclient\Deploy-ModernClient.ps1`: báo lỗi nếu Game.exe đang chạy hoặc file bị khóa (`-WhatIf` chỉ kiểm tra; đã chạy thử `-WhatIf`: OK).
  - Chép 5 module (kèm pdb; map vào Output) vào `PhongThanRuntime-Staging\Client` và `PhongThanSource\Output\Client`.
  - Cập nhật SHA256 Client trong `NATIVE_DEPLOYMENT.json`.
  - Sao lưu bản VC6 vào `_backup\client-deploy-<giờ>`. Bản VC6 đầu tiên được ghi vào `_backup\client-vc6-LATEST.txt`.
  - In TimeStamp để xác nhận script vá byte sẽ bỏ qua CoreClient/Represent2.
- `_backup\20261003-coreclient\Rollback-ModernClient.ps1`: khôi phục bản VC6 (đã vá byte). Mặc định chỉ tính lại hash Client; thêm `-FullReceipt` để chép lại cả receipt cũ.
- Sau khi triển khai, `PhongThan-ClientPatch.ps1` ghi `Bo qua (khac phien ban)` cho 6 vá CoreClient và vá Represent2, vì script kiểm TimeStamp trước khi so byte. Có thể giữ nguyên danh sách vá.

## Phần 3: Hành động

### Checklist cho người dùng
- [ ] Coordinator dựng ptfix v20 (có `extra_clientcrash.py`) và cài cho cả Server lẫn Client (log phải có `clientcrash: missles.txt speed fix: 9(0->2 skills 5,67)`).
- [ ] Đảm bảo GameServer đang chạy bản CoreServer có `PT_SAFE_SPEED` (bản dựng 14:44 ngày 03/10, TimeStamp 0x6ac0b26d). Bản 0x6abfbafc sập ở `+0x8521`.
- [ ] (Tùy chọn, cần duyệt) Thêm vá A, B1, B2 vào `AdminWeb\PhongThan-ClientPatch.ps1`, đóng game rồi chạy script vá.
- [ ] Kiểm tra trong game:
  - [ ] Đứng gần quái hoặc bot dùng Băng Tuyết Đạn (skill 67/5) khoảng 10 phút: client và server không sập.
  - [ ] Đứng chồng lên quái hoặc bot đang tung skill dạng tỏa (Spread) như Tam Vị Chân Hỏa, Băng Phong Bạo: không còn 0xc0000094 tại `CoreClient+0xb82f` (cần vá B).
  - [ ] Thoát game bằng menu và bằng nút X: Event Viewer không còn Id 1000 "Game.exe / unknown / ...a350" (cần vá A).
  - [ ] Hiệu ứng Băng Tuyết Đạn trông như cũ (đứng gần như yên tại chỗ).
- [ ] **Sửa tận gốc (sau khi coordinator chạy `Deploy-ModernClient.ps1`):**
  - [ ] Mở game, đăng nhập, đi lại 5 phút: giao diện, chat, túi đồ, cửa hàng, giao dịch, bản đồ nhỏ hoạt động như cũ.
  - [ ] Quái đứng đúng dưới tên, di chuột vào thân quái hiện biểu tượng đánh (Represent2 mới).
  - [ ] Thanh máu quái: khung `barback.spr` nằm đúng chỗ thanh đỏ; quái chết không còn thanh rỗng.
  - [ ] Uống thuốc bằng chuột phải, mặc pháp bảo vào 2 ô Pháp bảo.
  - [ ] Thoát bằng menu và bằng nút X: Event Viewer không còn Id 1000 "Game.exe / unknown / ...a350".
  - [ ] Nếu có lỗi lạ: chạy `Rollback-ModernClient.ps1` và gửi dump.
- [ ] Nếu vẫn sập: gửi file mới nhất trong `%LOCALAPPDATA%\CrashDumps\Game.exe.*.dmp` cùng giờ sập.

### Timeline
| Bước | Người làm | Khi nào |
|---|---|---|
| Dựng và cài ptfix v20 | Coordinator | Lần cài ptfix kế tiếp |
| Duyệt và thêm vá byte A/B | Người dùng / Coordinator | Sau khi kiểm tra ptfix v20 |
| Dựng client bản mới (C++, mục 2.6) | Dev | **Xong** 2026-10-03 15:23 |
| Triển khai `Deploy-ModernClient.ps1` rồi kiểm tra trong game | Coordinator / người dùng | Lúc client đã đóng |

## Phần 4: Tài liệu tham khảo
- Plug-in: `C:\Users\LICHNT~1.OFF\AppData\Local\Temp\claude\...\scratchpad\ptfix\extra_clientcrash.py`
- Bản dựng thử: `S\clientcrash\ptfix_test.pak` (Server), `S\clientcrash\ptfix_test_client.pak` (Client)
- Script phân tích: `S\clientcrash\an_missle.py`, `an_risk.py`, `q4.py` (relocation), `q7.py` (vá thử)
- Nguồn: `Sources\Core\Src\KSkills.cpp` (CastSpread dòng 1897, CastExtractiveLineMissle dòng 1487), `KCore.cpp` (`g_ReleaseCore` dòng 603), `Engine\Src\KWavSound.cpp`, `KSoundCache.cpp`, `GameClient\PhongThanClient.cpp` (`GameExit` dòng 333)
- Map: `PhongThanSource\Output\Client\CoreClient.map` (TimeStamp 0x6aaa74c1)
- Liên quan: vá server `KSkills.cpp` (CastSpread, `PT_SAFE_SPEED`) ngày 2026-10-02/03
