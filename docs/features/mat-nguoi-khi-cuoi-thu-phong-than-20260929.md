# Sửa lỗi: nhân vật biến mất khi cưỡi thú (chỉ thấy con thú)

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã sửa dữ liệu**. Có hiệu lực sau khi khởi động lại server và client, rồi mặc lại đồ hoặc đăng nhập lại. Chưa kiểm thử trong game.

## Phần 1: Tổng quan
- **Triệu chứng:** cưỡi thú thì chỉ thấy con thú, thanh máu và tên EmLaAi; không thấy đầu và thân người.
- **Nguyên nhân (đã kiểm chứng bằng log):**
  - `Client\client_npc_render_diag.log` ghi `ride=1 helm=9 armor=9 weapon=42 horse=5`, và chỉ có 4 phần hình được vẽ: vũ khí, áo choàng, đầu và đuôi ngựa. **Thiếu đầu và thân người.**
  - Bảng hình `男甲士头部.txt` và `男甲士躯体.txt` (trong PAK) chỉ có mã **0–8**; không có hình `jsm09_*` nào. Các phái khác cũng dừng ở mã 8. Không có dòng cho mã 9 thì phần đó không được vẽ.
  - Mã 9 đến từ `settings\item\VNG_ArmorPart.txt`: 290 món mũ/giáp có giá trị 10, trừ 1 thành mã hình 9. Gồm các bản ghi 182–271, 302–331, 362–391, 3012–3101, 3162–3191, 3202–3211, 3222–3231 (đa số là đồ lục và đồ cao cấp).
  - **Không phải lỗi thú cưỡi:** cùng con thú đó, khi mặc đồ thường (mũ/giáp mã 5) vẫn vẽ đủ người.
  - Suy luận: không cưỡi thú mà mặc các món này thì người cũng bị mất hình.

## Phần 2: Chi tiết
- **Sửa:** đổi giá trị `10` → `9` ở cột 2 của 290 dòng. Các món này giờ dùng hình mã 8 (`jsm08`, bộ hình cao cấp nhất có sẵn).
- **Phạm vi sửa:** file của cả Server và Client (`PhongThanRuntime-Staging\{Server,Client}\settings\item\VNG_ArmorPart.txt`). File này không có trong PAK, nên sửa file rời là có tác dụng.
- **Phân bố giá trị sau khi sửa:** 2 = 1, 3/4/5/6 = 32 mỗi loại, 7 = 2.662, 9 = 480.
- **Chưa rõ:** VNG có định lệch 2 thay vì 1 hay không. Nếu có thì toàn bộ bảng lệch 1 bậc hình. Chọn cách sửa tối thiểu để không đổi hình các món đang hiển thị đúng.
- **Ghi chú phụ:** hình `jsx06_hb_*.spr` (phần giữa của thú 6) không có trong PAK nào. Đây là thiếu dữ liệu gốc, không gây mất người.
- **Bản sao lưu:** `_backup\20260929-armorpart\`.

## Phần 3: Hành động
- [ ] Khởi động lại server và mở lại client (`PhongThan-ChayTatCa.cmd game`).
- [ ] Tháo rồi mặc lại mũ và giáp (hoặc đăng nhập lại), rồi cưỡi thú: phải thấy người trên lưng thú.
- [ ] Không cưỡi thú cũng phải thấy đầy đủ người.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KItemList.cpp:1190-1206`, `KPhongThanAppearance.cpp:31`, `KNpcRes.cpp:1206-1444`, `KNpcResNode.cpp:302-320`
- Bảng PAK: `\settings\npcres\人物类型.txt`, `男甲士头部.txt`, `男甲士躯体.txt`, `甲士骑马关联表.txt`
