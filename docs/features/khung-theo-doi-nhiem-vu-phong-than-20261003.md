# Khung theo dõi nhiệm vụ bên trái màn hình (như VNG)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent `questtrack`
> Trạng thái: **đã sửa C++ và build xong `Game.exe` (0 lỗi), smoke test native đạt 17/17 mục. Chưa triển khai.** Coordinator triển khai bằng `Deploy-ModernClient.ps1` (chỉ `Game.exe` đổi) và dựng ptfix có plug-in `extra_questtrack.py`. Chưa kiểm thử trong game.

## Phần 1: Tổng quan

### Insight chính
- **Client không có khung theo dõi nhiệm vụ trong mã nguồn.** Không có lớp `KUiTaskTrace`, `任务追踪` hay `任务提示` nào trong `GameClient\Ui`. Chỉ có `KUiTaskNote` (sổ F11) và `KUiMissionNote` (popup của `AddMissionNote`). Vì vậy đây không phải lỗi thiếu file ini như UiOptions: phần code chưa từng được viết.
- **Layout VNG thì vẫn còn trong PAK:** `\ui\ui3\任务提示.ini` (id `dd5ddfc2`, `serverlist.pak`, 1.442 byte). Nó mô tả đúng khung VNG:
  - `[Main]`: Left=0, Top=190, rộng 255, cao 320, `DummyWnd=1` (trong suốt, chuột xuyên qua);
  - `[List]`: danh sách chữ cỡ 14, màu 216,251,159, `HitText=1`;
  - `[Scroll]`: thanh cuộn bên trái, kèm bản `_800` cho màn hình 800×600.
- **Dữ liệu đã có sẵn ở client, không cần đổi giao thức.**
  - Server gửi ghi chú nhiệm vụ qua Lua `TaskNote`/`AddNote`: gói `0x5001`, view 203 → `UI_NOTEINFO` → `KUiTaskNote::WakeUp` → `MissionMemory.dat`.
  - Mỗi bản ghi gồm: ô 0..35 (= id nhiệm vụ mod 36), act (0 giải thích / 1 đang làm / 2 hoàn thành) và chữ TCVN3 dạng "Tên: bước hiện tại" có thẻ `<color=..>`.
  - Client không giữ danh sách nhiệm vụ đang làm trong RAM. Dữ liệu chỉ nằm trong file và chỉ được nạp khi mở F11.
- **Đã làm:** thêm lớp mới `KUiTaskTrace` trong `Game.exe`, dùng lại layout VNG. Khung hiện tối đa 5 nhiệm vụ chưa xong, mới nhất ở trên, cập nhật ngay khi server gửi ghi chú. Bật/tắt bằng **Alt+N**, trạng thái lưu trong `UserData\UiCommon.ini`.

### Nhận định quan trọng
- Không đổi CoreClient, CoreServer hay giao thức. Chỉ `Game.exe` thay đổi; danh sách import của nó giống hệt bản trước (376 hàm).
- Sửa kèm 3 lỗi cũ của sổ F11, vì khung theo dõi dùng chung dữ liệu với nó:
  - ghi tràn mảng khi có từ 12 bản ghi trở lên;
  - `strcpy` đọc chuỗi không có ký tự kết thúc;
  - `ClearAll` chỉ giải phóng nút đầu tiên (rò bộ nhớ).

## Phần 2: Chi tiết

### 2.1 Luồng dữ liệu

```
Lua TaskNote/AddNote (server) → 0x5001 view 203 → KPlayer UI_NOTEINFO → GDCNI_MISSION_RECORD
  → KUiTaskNote::WakeUp → KTaskDataFile (MissionMemory.dat)
                        → KUiTaskTrace::OnRecord   (mới: cập nhật khung ngay)
Vào game (UiStartGame) → KUiTaskTrace::OpenWindow → KUiTaskNote::FeedTaskTrace
  → đọc MissionMemory.dat từ mới đến cũ, lấy bản ghi mới nhất của mỗi ô
```

### 2.2 Cách hiển thị

| Quy tắc | Chi tiết |
|---|---|
| Chọn nhiệm vụ | Bản ghi mới nhất của mỗi ô (0..35). Ô nào có bản ghi mới nhất là act 2 (hoàn thành) thì bị ẩn. |
| Thứ tự | Nhiệm vụ vừa cập nhật lên đầu. Tối đa 5 (`[Main] MaxTrace`). Nhớ tối đa 48 ô; khi đầy, ô cũ nhất bị thay. |
| Dòng đầu | "Nhiệm vụ đang làm (Alt+N: ẩn/hiện)", màu 255,249,148. |
| Mỗi nhiệm vụ | Tên (phần trước dấu `:` đầu tiên) màu vàng 255,215,90. Xuống dòng, rồi bước hiện tại màu 216,251,159, giữ thẻ màu của taskinfo. Chữ C++ cũ "Task N - step S" vẫn hiện được. |
| Danh sách rỗng | Hiện "Chưa có nhiệm vụ đang làm. Nhấn F11 để xem sổ nhiệm vụ." |
| Chuột | Khung trong suốt với chuột (`DummyWnd` + `HitText`), không chặn click đi đường. Ctrl+click vào tên nhiệm vụ thì mở F11. Thanh cuộn chỉ hiện khi chữ dài hơn khung. |
| Lớp vẽ | `WL_LOWEST` (cùng lớp khung chat), nên mọi cửa sổ khác đè lên trên. |
| Mã hóa | Chữ giữ nguyên byte TCVN3 từ server. Chữ cố định viết bằng escape TCVN3 trong mã; file nguồn chỉ có ASCII. |

### 2.3 Layout và bật/tắt
- **Thứ tự nạp layout:**
  1. `<scheme>\UiTaskTrace.ini` (= `\ui\ui3\uitasktrace.ini`, plug-in ptfix ship);
  2. nếu không có: layout VNG `任务提示.ini`, đọc thẳng theo id PAK `dd5ddfc2`;
  3. nếu vẫn không có: giá trị mặc định trong mã (0,190, 255×320; 255×180 khi màn hình thấp dưới 700).
  - Vì vậy khung vẫn chạy cả khi chưa có ptfix mới.
- **Plug-in `extra_questtrack.py`** chép layout VNG và chỉnh nhẹ:
  - thêm `MaxTrace=5`, `TitleColor`, `CaptionColor`;
  - `Selable=0`, giữ `HitText=1`;
  - `TextLineShadow=0,0,0` với `TextLineShadowAlpha=60` để tạo nền tối nhẹ sau chữ cho dễ đọc.
- **Bật/tắt:**
  - **Alt+N** bật/tắt; chỉ có tác dụng khi `autoexec.lua` không gán phím này (hiện không gán).
  - Có thể gán phím khác bằng lệnh `Open([[tasktrace]])`.
  - Trạng thái lưu trong `UserData\UiCommon.ini`, mục `[TaskTrace] Show=0/1`, mặc định 1 (bật).

### 2.4 File

| File | Thay đổi | Sao lưu |
|---|---|---|
| `Sources\GameClient\Ui\UiCase\UiTaskTrace.h/.cpp` | **Mới**: lớp `KUiTaskTrace` | (file mới) |
| `Sources\GameClient\Ui\UiCase\UiTaskNote.h/.cpp` | `FeedTaskTrace()`; `WakeUp` gọi `KUiTaskTrace::OnRecord`; sửa `[i]`→`[j]` và chặn `j < 12`; thay `strcpy` bằng chép có giới hạn | `_backup\20261003-questtrack\src\GameClient\Ui\UiCase\` |
| `Sources\GameClient\Ui\UiCase\UiTaskDataFile.cpp` | `ClearAll` giải phóng cả danh sách | như trên |
| `Sources\GameClient\Ui\UiShell.cpp` | Mở khung khi vào game, đóng khi rời game | `_backup\20261003-questtrack\src\GameClient\Ui\` |
| `Sources\GameClient\Ui\UiBase.cpp` | Nạp lại layout khi đổi giao diện | như trên |
| `Sources\GameClient\Ui\ShortcutKey.cpp` | Alt+N; thêm cửa sổ `tasktrace` (số 22) cho `Open()` | như trên |
| `Sources\GameClient\PhongThanClient.dsp` | Thêm `UiTaskTrace.cpp/.h` vào project | `_backup\20261003-questtrack\src\GameClient\` |
| `scratchpad\ptfix\extra_questtrack.py` | **Mới**: `\ui\ui3\uitasktrace.ini` (id `2ea97962`) | (file mới) |

- Mọi file cũ có chú thích GBK đều được sửa ở mức byte (`scratchpad\questtrack\patch_src.py`). Bản diff nằm ở `scratchpad\questtrack\src.diff`.

### 2.5 Build và kiểm chứng offline

| Kiểm tra | Kết quả |
|---|---|
| `Build-Modern.ps1 -Targets GameClient` | **OK, 0 lỗi.** Có `OutputModern\Client\Game.exe` (876.544 byte). |
| Import của `Game.exe` so với bản trước | Giống hệt 376/376 hàm, không thêm phụ thuộc DLL. |
| ptfix thử (`build_ptfix.py Server scratchpad\questtrack\ptfix_test.pak`) | **OK**: `uitasktrace.ini 2ea97962 from serverlist.pak (1774 bytes)`; tổng 616 mục. |
| Smoke test native (`scratchpad\questtrack\smoke\`) | **PASSED 17/17.** Dùng đúng `uitasktrace.obj` và các obj `Elem` của bản build, link với `Engine.dll` thật. Đã thử: layout mặc định, layout ini, nạp từ journal (bỏ ô đã xong), cập nhật trực tiếp, giới hạn 5, chuỗi 511 byte, mã màu cụt, chuỗi chỉ có ":", 500 bản ghi trên 70 ô, bật/tắt, Ctrl+click mở F11, đổi giao diện, bản ghi đến sau khi đóng. |
| Mô phỏng trên `MissionMemory.dat` thật (`sim_tracker.py`) | Tài khoản `19ee3d746…` sẽ thấy "Task 8 - step 0" và "Task 9 - step 0"; Task 12 có bản ghi hoàn thành nên bị ẩn. |

## Phần 3: Hành động

### Coordinator
- [ ] Dựng ptfix thật có `extra_questtrack.py` (không phụ thuộc thứ tự, không đụng mục của plug-in khác). Chép sang cả Client và Server như thường lệ.
- [ ] Thoát hết client, chạy `_backup\20261003-coreclient\Deploy-ModernClient.ps1`. Chỉ `Game.exe` đổi; CoreClient, Engine, LuaLibDll và Represent2 giữ nguyên.
- [ ] Không cần build hay triển khai server.

### Người chơi kiểm thử trong game
- [ ] Vào game. Bên trái, dưới khung nhân vật và hàng buff (khoảng y=190), phải thấy dòng vàng "Nhiệm vụ đang làm (Alt+N: ẩn/hiện)".
- [ ] Nhận một nhiệm vụ, ví dụ ở NPC tân thủ. Khung phải hiện ngay tên nhiệm vụ và bước hiện tại, giống chữ trong F11.
- [ ] Làm tiếp một bước: dòng của nhiệm vụ đó cập nhật và nhảy lên đầu.
- [ ] Hoàn thành nhiệm vụ: dòng đó biến mất.
- [ ] Nhấn **Alt+N**: khung ẩn. Thoát game, vào lại: vẫn ẩn. Nhấn Alt+N lần nữa: khung hiện lại.
- [ ] Click chuột trái xuống đất ngay trên vùng chữ: nhân vật vẫn đi bình thường.
- [ ] Ctrl+click vào tên nhiệm vụ: sổ F11 mở ra.
- [ ] Mở F11 khi đã có từ 12 bản ghi trở lên: không crash (lỗi tràn mảng cũ đã sửa).

### Rủi ro
- **Chữ dài:** một bước có thể dài tới 480 byte và chiếm nhiều dòng. Khi tổng số dòng vượt khung, thanh cuộn hiện ra (chỉ kéo bằng chuột, không cuộn bằng bánh xe).
- **Bản ghi cũ:** `MissionMemory.dat` không bao giờ xóa bản ghi. Nhiệm vụ bỏ dở từ lâu vẫn hiện cho tới khi 5 nhiệm vụ mới hơn đẩy nó ra, hoặc server gửi bản ghi "hoàn thành" (act 2) cho ô đó.
- **Hai nhiệm vụ chung một ô:** ví dụ Vận lương và Lục Lâm cùng dùng ô 28. Khung chỉ hiện bản ghi mới hơn, giống cách F11 đang gộp.
- **Màu nền:** `TextLineShadowAlpha=60` chưa được xem bằng mắt. Nếu nền tối quá hoặc nhạt quá, chỉ cần sửa số này trong plug-in, không phải build lại.
- **Hiệu năng khi vào game:** đọc tối đa 2.000 bản ghi mới nhất, mỗi lần đăng nhập một lần. Lỗi O(n²) cũ của `InsertSystemRecord` khi file rất lớn vẫn còn (ngoài phạm vi).
- **Quay lại bản cũ:** chạy lại deploy với `Game.exe` cũ (Deploy-ModernClient lưu bản trước), hoặc trả 7 file nguồn từ `_backup\20261003-questtrack\src\` rồi build lại.

## Phần 4: Tài liệu tham khảo
- Mã nguồn: `GameClient\Ui\UiCase\UiTaskTrace.cpp`, `UiTaskNote.cpp` (`WakeUp`, `FeedTaskTrace`), `UiTaskDataFile.cpp`, `ShortcutKey.cpp` (`HandleKeyInput`, `l_WindowList`).
- Server: `Core\Src\ScriptFuns.cpp`: `LuaAddNote` (~900), `SendPhongThanTaskRecord` / `LuaTaskNoteCompat` (~1015–1092). Lua: `script\phongthan\lib\vng_tasknote.lua`.
- Layout VNG: `\ui\ui3\任务提示.ini` (`dd5ddfc2`) và `\ui\ui4\任务提示.ini` (`17388f9f`) trong `serverlist.pak`. Bản trích ra: `scratchpad\questtrack\vng_ui3_dd5ddfc2.ini`.
- Công cụ: `scratchpad\questtrack\patch_src.py`, `sim_tracker.py`, `smoke\smoke.cpp` + `smoke\b.cmd`, `chk.py`.
- Tính năng liên quan: `he-thong-nhiem-vu-f11-phong-than-20260928.md`, `ma-de-phuc-kim-luc-lam-f11-phong-than-20261003.md`.
