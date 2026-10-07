# Tiệm thuốc, tiệm vũ khí, Tạp Hóa (trang bị), cửa sổ cửa hàng, thủ khố và giao dịch

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **NPC đã có mặt trên server (nạp nóng, 37/37 NPC cầu nối còn sống)**. Giao diện cửa hàng, thủ khố và giao dịch đã cài, có hiệu lực sau khi mở lại client. Chưa kiểm thử mua bán trong game.

## Phần 1: Tổng quan
- **Nguyên nhân "không thấy tiệm":**
  1. NPC **Đại Phu** (医生, tiệm thuốc) và **Thợ Đồng** (铜匠, tiệm vũ khí) chưa được đặt trên các map 1002, 1003, 1004, 1020, 1021.
  2. Tạp Hóa (杂货商) thiếu ở 1020 và 1021.
- **Nguyên nhân "không hoạt động":**
  1. Client thiếu `UiShop.ini`, nên `Sale()` mở ra cửa sổ vô hình. Thủ khố (`UiStoreBox.ini`) và giao dịch (`UiTrade.ini`) cũng thiếu file tương tự.
  2. Script gốc có lỗi:
     - Đại Phu ở map tân thủ không có nút đóng.
     - Nhánh "Đập trứng" của Thợ Đồng dùng biến `tasks` bằng nil.
  3. Lỗi C++ làm mất món đầu tiên của mỗi tiệm. Đã vá bằng ptfix.pak.
- **Về "Bào thương":** trong dữ liệu VNG, đây là tính năng **chạy buôn 跑商** (thuê lạc đà chở hàng, StringResource 10710–10760), không phải tiệm áo. Áo và giáp được bán ở **Tạp Hóa**. Script NPC chạy buôn không có trong dữ liệu còn lại nên chưa dựng lại được.

## Phần 2: Chi tiết

### 2.1 NPC đã đặt
| Map | Đại Phu (thuốc) | Thợ Đồng (vũ khí) | Tạp Hóa (mũ, giáp, áo choàng, đai, giày) |
|---|---|---|---|
| 1002 Sùng Thành doanh | Sale 11 | Sale 2 (đao) | có sẵn, Sale 5 |
| 1003 Ngọc Hư Cung | Sale 11 | Sale 3 (kiếm) | Sale 6 |
| 1004 Xi Vưu Mộ | Sale 11 | Sale 4 (việt) | Sale 7 |
| 1020 Tây Kỳ | Sale 1 | Sale 12 | Sale 13 (mới) |
| 1021 Triều Ca | Sale 1 (cạnh Hồ Hỷ Mị) | Sale 12 | Sale 13 (mới) |

- **Tọa độ:** đặt cạnh Tạp Hóa hoặc Thương Điếm có sẵn. Tất cả đã kiểm tra là ô đi được. Đây **không phải** vị trí gốc VNG, vì dữ liệu gốc không còn.
- **Script:** `npc_fix\<map>_dai_phu.lua`, `<map>_tho_dong.lua`, `<map>_tap_hoa.lua`, chép từ script VNG trong PAK và sửa lỗi. Template: 149 (Đại Phu), 157 (Thợ Đồng), 158 (Tạp Hóa).
- **Tên hiển thị:** thêm `铜匠 → Tho Dong` vào NpcDisplayNames.

### 2.2 Giao diện đã cài (`Client\Ui\ui3\`, file mới)
| File | Cửa sổ | Ghi chú |
|---|---|---|
| `UiShop.ini` | Cửa hàng (Sale) | Nền `买卖面板.spr`, lưới 6×10 theo core, nút Mua/Bán/Sửa/Trang |
| `UiStoreBox.ini` | Thủ khố | Dựa trên layout VNG `储物箱.ini`, lưới 6×10 (nền vẽ 6×8) |
| `UiTrade.ini` | Giao dịch người chơi | Túi đồ đặt nổi bên phải bảng |
| `UiTradeConfirmWnd.ini` | Hộp xác nhận mua bán | Chép nguyên layout VNG `买卖确认.ini` |
| `UiGetMoney.ini` | Rút tiền ở thủ khố | Chép nguyên layout VNG `取钱界面.ini` |

- Ghi chú kỹ thuật đầy đủ (section/key mà C++ đọc, sprite, rủi ro): `_backup\20260929-uiini\notes-uiini.md`.

### 2.3 Giới hạn còn lại (cần C++)
- Thủ khố không có nút gửi tiền; click phải vào vật phẩm không làm gì, phải kéo thả.
- Giao dịch: `UiTrade.cpp:50-52` đọc tên đối phương trước khi kiểm tra NULL, có thể gây crash client.
- Lưới cửa hàng và thủ khố không trùng khít vạch trên hình nền; đây là chuyện thẩm mỹ.

## Phần 3: Hành động
- [ ] Thoát và mở lại client.
- [ ] Ở Sùng Thành doanh: tìm Đại Phu và Thợ Đồng cạnh Tạp Hóa, nói chuyện, chọn mua. Cửa sổ cửa hàng phải hiện có hàng.
- [ ] Thử mua thuốc, bán lại một món, sửa đồ.
- [ ] Thử thủ khố: kéo đồ vào kho, rồi rút tiền.
- [ ] Nếu cửa sổ lệch vị trí, chụp ảnh gửi lại để chỉnh file .ini.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KBuySell.cpp` (Init, OpenSale), `ScriptFuns.cpp:1790` (LuaSale), `GameClient\Ui\UiCase\UiShop.cpp`, `UiStoreBox.cpp`, `UiTrade.cpp`
- `goi-va-ptfix-pak-phong-than-20260929.md` (sửa món đầu tiên của cửa hàng)
- Backup: `_backup\20260929-shops\`, `_backup\20260929-uiini\`
