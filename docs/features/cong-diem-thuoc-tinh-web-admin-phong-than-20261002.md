# Web admin: cộng điểm thuộc tính cho nhân vật

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã làm.** Web admin đã khởi động lại lúc 08:29, không cần khởi động lại server.

## Phần 1: Tổng quan
- Khung mới **"Điểm thuộc tính"** trong tab "Phát đồ", ngay dưới "Tăng level nhân vật". Dùng tên nhân vật ở ô trên cùng của tab.
- Ba nút:
  - **Cộng điểm cho nhân vật trên:**
    - Cộng thẳng vào Sức mạnh, Thân pháp, Sinh khí, Nội công, không trừ điểm tiềm năng nhân vật đang có.
    - Có thể cộng thêm điểm tiềm năng tự do để nhân vật tự phân phối ở F3.
  - **Xem chỉ số hiện tại:** ghi vào Lịch sử chỉ số gốc, điểm tự do và chính xác (thân pháp × 4 − 28).
  - **Tẩy điểm:** hoàn toàn bộ điểm đã cộng thành điểm tiềm năng. Có hộp xác nhận trước khi làm.
- Lý do làm: nhân vật Đạo Sĩ/Dị Nhân mới có thân pháp 3, tức chính xác −16, nên trượt toàn bộ (xem `sat-thuong-tay-khong-phong-than-20261002.md`).

## Phần 2: Chi tiết
- **Lua của engine** (`ScriptFuns.cpp`):
  - `AddStrg/AddDex/AddVit/AddEng(n)` cộng n vào chỉ số gốc, trừ n điểm tiềm năng và tự đồng bộ về client (`KPlayer::SetBaseStrength`…).
  - `AddProp(n)` cộng điểm tiềm năng.
  - `ResetProp()` tẩy điểm.
- **Web admin** (`PhongThan-Admin.ps1`, lệnh `attr`): gọi `AddProp(tổng)` trước rồi mới `AddStrg/AddDex/...`, nên điểm tiềm năng của nhân vật không đổi. Mỗi chỉ số tối đa 5.000 điểm/lần, tiềm năng tối đa 10.000. Kết quả ghi vào Lịch sử kèm chỉ số sau khi cộng.
- **Giao diện** (`index.html`): 4 ô chỉ số, 1 ô tiềm năng, 3 nút. Cũng cập nhật lại mô tả Lệnh Bài Hủy Đồ (menu 5 mục).
- **Kiểm tra:**
  - Đoạn Lua đọc chỉ số chạy đúng trên server: EmLaAi2 str 5, dex 3, vit 5, eng 7, tự do 95, chính xác −16.
  - `PhongThan-Admin.ps1`: 0 lỗi cú pháp. `node --check` cho JavaScript: đạt.
- **Lưu ý:** web admin và các lệnh thử thủ công dùng chung `admin_bridge\pending.lua`. Gửi lệnh cùng một phút có thể ghi đè nhau. Web admin đã gom lệnh của chính nó.

## Phần 3: Hành động
- [ ] Tải lại trang web admin (F5) → "Phát đồ" → nhập tên nhân vật → "Xem chỉ số hiện tại".
- [ ] Nhập Thân pháp (ví dụ 20) → "Cộng điểm cho nhân vật trên" → vào game đánh thử.

## Phần 4: Tài liệu tham khảo
- `ScriptFuns.cpp` (`LuaSetPlayerStrength` 6610, `LuaAddPropPoint` 9195, `LuaResetProp` 6517), `KPlayer.cpp` (`SetBaseStrength` 2337, `SetNpcAttackRating` 2549).
- `web-admin-quan-tri-phong-than-20260928.md`, `sat-thuong-tay-khong-phong-than-20261002.md`.
