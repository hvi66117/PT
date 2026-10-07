# Gói vá ptfix.pak: chữ F11 và nút đóng cho script gốc VNG, sửa món đầu tiên của cửa hàng

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã cài; có hiệu lực sau khi khởi động lại server và client**. Test-ServerPakParity và Test-NativeRuntime đều PASS.

## Phần 1: Tổng quan

- **Vấn đề:** engine đọc PAK trước file rời, nên không thể sửa script gốc VNG bằng file rời. Trước đây gặp các giới hạn:
  - chỉ các NPC đã chép sang `npc_fix` mới có chữ F11 và nút đóng;
  - các giới hạn này tưởng như cần build lại C++.
- **Cách giải:** `KPakList::FindElemFile` trả về PAK **đầu tiên** chứa file. Một PAK nhỏ không nén đặt ở vị trí 0 sẽ thắng mọi PAK VNG, mà không cần build lại C++.
- **Nội dung `ptfix.pak`** (1,4 MB, 266 mục):
  - **265 script VNG** có gọi `TaskNote(` hoặc `SayTask(` được chèn dòng đầu `Include("\\script\\phongthan\\lib\\pt_compat.lua")`.
  - `\settings\buysell.txt` được thêm một cột đệm. Lỗi gốc: `KBuySell::Init` đọc từ cột 2 (KBuySell.cpp:283), nên **món đầu tiên của mọi cửa hàng bị mất**, ví dụ Tiểu Hồng đơn ở tiệm thuốc.

## Phần 2: Chi tiết

### 2.1 `script\phongthan\lib\pt_compat.lua` (file rời, sửa được không cần dựng lại PAK)
| Chức năng | Cách làm |
|---|---|
| Chữ F11 | Include `vng_tasknote.lua`, tức `TaskNote = PTTaskNote` |
| Nút "Kết thúc đối thoại" | Bọc `SayTask` và `Say`: nếu menu chưa có lựa chọn thoát thì thêm một dòng gọi `PTCompat_Close` |
| NPC gốc đứng hình | 30 hàm engine chưa đăng ký nhận hàm dự phòng: `GetNewPills`, `GetPillsState`, `IsMaster`, `IsHaveTongRight`, `IsTongMaster`, `GetCoin`, `BuildingOperator`, `AddTongContri`, `DelHandItem`, `RepairTaskValue`... Chúng trả 0 hoặc không làm gì, nên NPC vẫn mở được và đóng được |

### 2.2 Cài đặt (đã làm)
- Chép `ptfix.pak` vào `Server\data` và `Client\data`. Hai bản phải cùng kích thước vì Test-ServerPakParity kiểm tra điều này.
- `package.ini` (Server và Client giống hệt nhau): thêm `0=ptfix.pak`, dời các PAK còn lại xuống 1..22.
- `NATIVE_DEPLOYMENT.json`: thêm mục ptfix.pak, dời thứ tự ưu tiên, cập nhật `PackageIniSha256`, `PackageCount` = 23 và `TotalBytes`.
- Bản sao lưu nằm ở `_backup\20260929-ptfix\`, gồm 2 `package.ini`, receipt và ptfix.pak.

### 2.3 Kiểm chứng
- Cấu trúc PAK hợp lệ: chữ ký PACK, chỉ mục sắp theo id, `TYPE_NONE`.
- 265 script biên dịch được bằng Lua của engine.
- Mô phỏng 4.927 hội thoại của 265 script:
  - mọi menu `SayTask` đều có nút đóng;
  - 2 menu `Say` đặc biệt không bọc được vì dùng dạng tham số khác.
- Lỗi còn lại là phần hệ thống chưa có trong bản dựng lại: luyện đan (`StartMakePills`), bang hội và một số đoạn script VNG so sánh với nil.

### 2.4 Dựng lại gói (khi đổi danh sách script)
```bash
python build_ptfix.py Server ptfix_server.pak
```
- Script nằm ở `scratchpad\ptfix\build_ptfix.py` của phiên làm việc.
- Chép bản mới vào **cả hai** thư mục `data`, rồi cập nhật Length, Sha256 và TotalBytes trong `NATIVE_DEPLOYMENT.json`.

## Phần 3: Hành động
- [ ] Tắt server (bảng điều khiển → Dừng server) và client, rồi chạy `PhongThan-ChayTatCa.cmd`.
- [ ] Nói chuyện với NPC gốc chưa được sửa (ví dụ các NPC ở Tây Kỳ, Triều Ca): phải có "Kết thúc đối thoại", và F11 hiện chữ tiếng Việt.
- [ ] Mở tiệm thuốc: phải có Tiểu Hồng đơn (món đầu tiên).
- **Gỡ bỏ nếu cần:** chép lại 2 file `package.ini` và `NATIVE_DEPLOYMENT.json` từ `_backup\20260929-ptfix\`.

## Phần 4: Tài liệu tham khảo
- `PhongThanSource\Sources\Engine\Src\KPakList.cpp` (FindElemFile, Open), `XPackFile.cpp` (định dạng, TYPE_NONE)
- `PhongThanSource\Sources\Core\Src\KBuySell.cpp:283`, `PhongThanNpcDialogLua.inl` (SayTask)
- `kiem-thu-nhiem-vu-mo-phong-phong-than-20260929.md`, `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`
