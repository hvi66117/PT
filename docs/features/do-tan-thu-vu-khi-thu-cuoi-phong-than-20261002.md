# Đồ tân thủ: vũ khí cấp 1 và thú cưỡi cấp 1 thuộc tính tối đa

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã làm**, có hiệu lực sau khi khởi động lại (ptfix v13 + `servertimer.lua`).

## Phần 1: Tổng quan
- **Vấn đề:** nhân vật mới tạo không có vũ khí, đánh tay không ra 0 sát thương (xem `sat-thuong-tay-khong-phong-than-20261002.md`).
- **Giải pháp:** mỗi phút, server kiểm tra nhân vật online **cấp ≤ 10** chưa nhận quà và phát:

| Phái | Vũ khí (mới, ptfix) | Thú cưỡi (VNG) |
|---|---|---|
| Giáp Sĩ | Đại Đao Tân Thủ (Max), particular 900 | Trác Mã (horse 24) |
| Đạo Sĩ | Pháp Kiếm Tân Thủ (Max), 901 | Trác Tước (25) |
| Dị Nhân | Hỗn Thế Phủ Tân Thủ (Max), 902 | Trác Điệp (26) |

- **Vũ khí:**
  - yêu cầu cấp 1 và đúng phái;
  - sát thương cố định ở mức cao nhất của dòng VNG (5 / 9), độ bền 100;
  - thêm các dòng phép xanh cố định lấy từ vũ khí lục cùng loại (dòng 311/331/341).
- **Thú cưỡi:** Trác yêu cầu cấp 1, có 4 thuộc tính cố định (40% tốc chạy và 3 dòng khác). Đây là thú cưỡi cấp 1 nhiều thuộc tính nhất trong bảng VNG.

## Phần 2: Chi tiết
- **Vì sao phải tạo dòng vũ khí mới:** `KItemGenerator::Gen_Equipment` lấy thuộc tính chỉ từ dòng dữ liệu và lấy ngẫu nhiên trong khoảng min–max (`SetAttrib_CBR`). Tham số cấp phép hay may mắn của `AddItem` không ép được mức tối đa.
- **ptfix v13** (`build_ptfix.py`, backup `.v12`): thêm 3 dòng `meleeweapon` 900–902 (ngũ hành 1000, cấp đồ 1, giá 1000). 391 mục, hash F35C71C2…, đặt ở `AdminWeb\pending\ptfix.pak`. Bản này gồm toàn bộ v9–v12.
- **Script:** `Server\script\phongthan\newbie\starter_gear.lua` (sinh từ `scratchpad\skill180\mknewbie.py`):
  - Task 1950: 0 = chưa xét, 1 = đã phát, 2 = lúc gặp đã trên cấp 10.
  - Chỉ đánh dấu đã phát khi vũ khí tạo được, nên quà chờ đến khi cài ptfix v13.
- **`servertimer.lua`** (sửa ở mức byte, backup `_backup\20261002-newbie\`): thêm `PTAdm_NbTick()` và gọi sau `PTAdm_WbTick()`.
- **Kiểm tra (mô phỏng Lua 4):**
  - trước khi có dòng vũ khí: không phát, không đánh dấu;
  - Đạo Sĩ cấp 1: nhận 901 và Trác Tước 25;
  - cấp 50: đánh dấu 2;
  - đã nhận rồi: bỏ qua.
- **Lưu ý:** nhân vật cũ đang ở cấp ≤ 10 (ví dụ alt cấp thấp) cũng nhận một lần.

## Phần 3: Hành động
- [ ] Tắt server, thoát game, đóng web admin, chạy `PhongThan-ChayTatCa.cmd game` để cài ptfix v13 và nạp `servertimer.lua` mới.
- [ ] Tạo nhân vật mới, vào game, chờ tối đa 1 phút, mở hành trang: có vũ khí và thú cưỡi.

## Phần 4: Tài liệu tham khảo
- `KItemGenerator.CPP` (`Gen_Equipment` 226), `ScriptFuns.cpp` (`LuaAddItem` 3266), `KBasPropTbl.CPP` (đọc bảng trang bị).
- `sat-thuong-tay-khong-phong-than-20261002.md`, `vu-khi-luc-do-max-cuong-hoa-phong-than-20260928.md`.
