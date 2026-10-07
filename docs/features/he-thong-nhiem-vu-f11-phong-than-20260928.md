# Tính năng 2: Hiển thị hệ thống nhiệm vụ khi nhấn F11

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Giai đoạn 1 (layout) và giai đoạn 2 (chữ nhiệm vụ từ taskinfo.ini qua `script\phongthan\lib\vng_tasknote.lua`, gắn vào 67 script npc_fix) đã triển khai 20:49**; chờ kiểm thử trong game

## Phần 1: Tổng quan

- **Đường dữ liệu nhiệm vụ từ server tới client đã chạy.** Lua `TaskNote` / `AddNote` trên server gửi gói `0x5001` (view `203` NOTE). Client nhận, lưu vào `Client\UserData\<tài khoản>\MissionMemory.dat` và phân vào 3 tab. Đã kiểm chứng qua log `ui_action_diag.log` ở cả 2 phía. File của lichnt đang có 2 bản ghi: "Task 12 - step 0: Đoản Kiếm" và "Task 9 - step 0".
- **Nguyên nhân F11 không hiện gì:** phím F11 gọi đúng `Open([[tasknote]])` → `KUiTaskNote::OpenWindow()`, nhưng file layout `\Ui\ui3\UiTaskNote.ini` **không tồn tại** (cả trong PAK lẫn trên đĩa). Không có layout thì cửa sổ không có kích thước, nền hay nút, tức là mở ra một cửa sổ vô hình.
- **Dữ liệu chữ nhiệm vụ gốc của VNG có sẵn trong PAK:** `\ui\ui3\taskinfo.ini` (510 KB) gồm 401 nhiệm vụ, có `Title`, `Intro`, `Step_n`, `St_n`, NPC, bản đồ, cấp yêu cầu. Chữ viết bằng TCVN3 và có tham số `%s`/`%d`.
- **Chữ hiện tại còn thô:** server đang ghi nhiệm vụ dạng `"Task 12 - step 0: Đoản Kiếm"` mà chưa tra `taskinfo.ini`.

## Phần 2: Chi tiết

### 2.1 Luồng hoạt động

```
Lua script NPC: TaskNote(id, step, ...)  hoặc  AddNote(header, act, text, 0)
   → CoreServer: LuaTaskNoteCompat / SendPhongThanTaskRecord (ScriptFuns.cpp ~1019-1102)
   → gói 0x5001, view 203 (PHONGTHAN_VIEW_NOTE), op 100 (SHOW)
   → Client: KPlayer::OnScriptAction case UI_NOTEINFO (KPlayer.cpp:6925)
   → KTaskDataFile::InsertSystemRecord → MissionMemory.dat
   → F11: KUiTaskNote (UiTaskNote.cpp) đọc \Ui\ui3\UiTaskNote.ini và vẽ 3 tab × 12 ô
```

| Thành phần | Trạng thái |
|---|---|
| Phím F11 → `Open([[tasknote]])` | Đã có sẵn |
| Server gửi nhiệm vụ (`TaskNote`, `NewTaskNote`, `TaskCheck`, `AddNote`, `AddMissionNote`) | Chạy được với binary hiện tại |
| Client lưu `MissionMemory.dat` | Chạy được |
| Layout `UiTaskNote.ini`, `UiTaskNote-MissionNote.ini` | **Đã bổ sung ngày 2026-09-28** |
| Chữ nhiệm vụ thật từ `taskinfo.ini` | Chưa làm (giai đoạn 2) |

### 2.2 Giai đoạn 1: layout F11 (đã làm)
- Tệp mới `PhongThanRuntime-Staging\Client\Ui\ui3\UiTaskNote.ini`, lưu mã GBK:
  - Khung: `\Spr\Ui4\任务记事\任务记事.spr` (349×372), nút đóng `\spr\Ui4\按钮\关闭键.spr`.
  - 3 nút tab dùng tạm 3 sprite 任务追踪 / 取消追踪 / 取消所有追踪. Chữ vẽ sẵn trên sprite là "theo dõi", còn tooltip là "Cot truyen / Nhiem vu / Su kien".
  - 36 biểu tượng nhóm dùng `\spr\item\other\推荐信.spr` (biểu tượng mặc định `icon_task_003.spr` không có trong PAK).
  - Danh sách nhiệm vụ `[RList]` rộng 297×250, có thanh cuộn.
- Tệp mới `UiTaskNote-MissionNote.ini`: popup khi server gọi `AddMissionNote`.
- Client cũng ưu tiên PAK, nhưng PAK không có 2 file này nên file trên đĩa được dùng.
- `Test-NativeRuntime` vẫn PASS sau khi thêm file.

### 2.3 Giai đoạn 2: chữ nhiệm vụ thật (chưa làm, không cần build lại)
1. Chuyển `taskinfo.ini` thành bảng Lua `script\phongthan\lib\vng_tasknote.lua`, đồng thời đổi tag màu: `<c=g>`→`<color=Green>`, `<c=yel>`→`<color=Yellow>`, `<c>`→ màu mặc định, và bỏ tiền tố `$`.
2. Viết hàm `PTTaskNote(id, step, ...)`: tra `Title` + `Step_n`, điền `%s`/`%d`, rồi gọi `AddNote(mod(id,36), act, text, 0)`.
3. Trong các script NPC sửa lại (thư mục `npc_fix`, xem tính năng 3), gán `TaskNote = PTTaskNote`.
- **Giới hạn:** script VNG còn nằm trong PAK vẫn dùng `TaskNote` bản C++, nên vẫn ra "Task N - step S".

### 2.4 Giai đoạn 3: cần build lại C++ (khi có Visual C++ 6)

| Thành phần | Việc cần sửa |
|---|---|
| `CoreServer.dll` | `LuaTaskNoteCompat` tra `taskinfo.ini` một lần lúc khởi động. Hiểu đúng ngữ nghĩa VNG: step 0 là một bước hợp lệ, −1 là hoàn thành. Cách này sửa cho cả 946 lời gọi trong mọi script. |
| `Game.exe` | Sửa lỗi trong `KUiTaskNote::UpdateData`: dùng `m_TBtnTaskSel[i]` thay vì `[j]`, gây ghi tràn khi có từ 12 bản ghi trở lên. Xóa bản ghi khi nhiệm vụ hoàn thành. Sửa `ClearAll` bị rò bộ nhớ. |
| `Game.exe` (tùy chọn) | Viết lại cửa sổ theo layout VNG `任务记事.ini` (danh sách, mô tả, bước, theo dõi) và bảng theo dõi `任务提示.ini`. |

## Phần 3: Hành động

### Kiểm thử giai đoạn 1 (người chơi thực hiện)
- [ ] Thoát client đang mở, mở lại bằng `PhongThan-MoGame.cmd` hoặc nút "Mo client". Layout chỉ được nạp lần đầu mở cửa sổ.
- [ ] Vào game, nhấn **F11**: phải thấy khung sổ nhiệm vụ.
- [ ] Bấm 3 nút tab dưới đáy, xem các bản ghi "Task 12 / Task 9".
- [ ] Nếu cửa sổ lệch vị trí hoặc thiếu hình, báo lại để chỉnh `UiTaskNote.ini`. Chỉ cần sửa file, không cần build lại.

### Rủi ro cần lưu ý
- **Lỗi tràn khi từ 12 bản ghi trở lên** (C++). Nếu client bị crash khi mở F11, đổi tên `MissionMemory.dat` của tài khoản đó để xóa sổ nhiệm vụ trên máy. Bản sao lưu nằm ở `_backup\20260928-f11\`.

### Timeline đề xuất

| Bước | Nội dung | Phụ thuộc |
|---|---|---|
| 1 | Kiểm thử layout F11 | Người chơi |
| 2 | Chuyển `taskinfo.ini` sang Lua + `PTTaskNote` | Bước 1 đạt |
| 3 | Dùng `PTTaskNote` trong script NPC tân thủ đã sửa | Tính năng 3 |
| 4 | Build lại C++ | Có Visual C++ 6 |

## Phần 4: Tài liệu tham khảo
- Client: `PhongThanSource\Sources\GameClient\Ui\UiCase\UiTaskNote.cpp` (LoadScheme dòng 94–140), `UiTaskDataFile.cpp`, `ShortcutKey.cpp` (dòng 233)
- Server: `Sources\Core\Src\ScriptFuns.cpp` (AddNote dòng 897, TaskNote dòng 1007–1102, đăng ký 14140–14151, 14573)
- Giao thức: `Headers\PhongThanProtocol.h` (0x5001), `Headers\PhongThanUiProtocol.h` (VIEW_NOTE=203)
- Dữ liệu VNG trong PAK: `\ui\ui3\taskinfo.ini`, `\ui\ui3\任务记事.ini`, `\ui\ui3\任务提示.ini`
- Tính năng liên quan: `nhiem-vu-chinh-tuyen-phong-than-20260928.md`, `hoi-thoai-npc-tan-thu-phong-than-20260928.md`
