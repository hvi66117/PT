# Cửa hàng (NPC và Lệnh Bài Hủy Đồ) không mua, bán, sửa được

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-01
> Trạng thái: **Đã sửa bằng Lua, nạp nóng lúc 08:27.** Đây cũng là lời giải cho mục "Dược điếm / Thợ Đồng chưa hoạt động" còn tồn đọng.

## Phần 1: Tổng quan
- **Triệu chứng** (người dùng thử theo hướng dẫn): cửa hàng có hiện và có hàng; nút Mua/Bán/Sửa có đổi hình; hộp xác nhận mua có hiện. Nhưng bấm "Đồng ý" không mua được, Shift + chuột phải không bán được, sửa đồ cũng không được. Cửa hàng NPC bị y hệt Lệnh Bài Hủy Đồ.
- **Nguyên nhân gốc** (kiểm chứng trong mã server):
  - `KBuySell::CanBuy` (KBuySell.cpp 427), `KBuySell::Sell` (671) và `KPlayer::RepairItem` (KPlayer.cpp 8759) đều **từ chối khi nhân vật đang ở trạng thái chiến đấu** (`m_FightMode`).
  - Server có gửi thông báo `enumMSG_ID_FIGHT_MODE_ERROR1`, nhưng client không hiển thị thông báo này, nên người chơi chỉ thấy "bấm không ăn".
  - Nhiều đường vào thành **không** đặt lại trạng thái chiến đấu về 0, ví dụ lệnh bài boss luôn đặt về 1. Lúc kiểm tra (08:24), EmLaAi ở map 1041 có `fight=1`.
- **Các nghi vấn đã loại trừ** bằng log và mã:
  - khóa thao tác túi đồ: lúc bấm đang tắt;
  - ảnh giao diện: có đủ trong PAK;
  - file `UiShop.ini` / `UiTradeConfirmWnd.ini`: được dùng đúng;
  - so vị trí khi mua/bán: hai bên dùng cùng công thức `Map2Mps`;
  - cửa sổ xác nhận: có hiện, cùng lớp hiển thị với cửa hàng.

## Phần 2: Chi tiết
- **`script\phongthan\lib\vng_tasknote.lua`**:
  - Bọc hàm `Sale`: nếu đang chiến đấu thì `SetFightState(0)` và ghi task 1940 = 1, rồi gọi hàm gốc với đủ tham số.
  - File này được mọi script trong `npc_fix` nạp, và được `pt_compat.lua` nạp trong 359 script PAK (qua ptfix). Script PAK nhận thay đổi ở lần khởi động server kế tiếp.
- **`script\phongthan\item\huydo_lenhbai.lua`** (bản 3): cả "Bán / hủy đồ" và "Sửa đồ đang mặc" đều tắt chiến đấu trước khi mở cửa hàng; "Bật lại chiến đấu" bật lại khi task 1940 = 1.
- **Nạp nóng:** `ReLoadScript` 14 script cửa hàng trong `npc_fix` và thẻ hủy đồ (`shop-fight OK reloaded 15`).
- **Kiểm tra bằng mô phỏng Lua 4:** `Sale` đã bọc tắt chiến đấu và ghi task 1940; nạp file hai lần vẫn đúng; gọi hàm gốc đúng tham số; menu thẻ chạy đúng cả 4 mục.
- **Backup:** `_backup\20261001-shop-fight\` (`vng_tasknote.lua.orig`, dựng lại đúng 3.895 byte, và `huydo_lenhbai.lua.v2`).
- **Lưu ý:**
  - Sau khi mua/bán ở bản đồ luyện cấp bằng thẻ, cần chọn "Bật lại chiến đấu" để đánh quái tiếp.
  - Rời thành bằng cổng hoặc Truyền Tống thì script cổng tự bật lại chiến đấu.
  - Việc client không hiện thông báo lỗi của server (`s2c_msgshow`) là lỗi riêng, chưa sửa.

### 2.1 Kiểm thử trực tiếp trong game (08:45–08:56, người dùng cho phép điều khiển)
- Nhân vật EmLaAi ở map 1007 (bản đồ luyện cấp), mở cửa hàng bằng Lệnh Bài Hủy Đồ:
  - **Mua: đạt.** Tiểu Hồng Đơn giá 100: lượng 57 → 47.
  - **Bán: đạt.** Bấm nút "Bán" rồi click món đồ trong túi: món đồ biến mất, lượng 47 → 49.
  - **Sửa:** bấm "Sửa" rồi click vũ khí đang mặc (Tinh Quân Viêm Đế Kiếm, độ bền 48/90) → hiện hộp "Tu sửa" có tên món đồ → bấm "Xác định". Nếu chưa bật chế độ Sửa mà click thì vũ khí bị **nhấc lên tay**; click lại vào ô để mặc lại.
- **Lỗi phát hiện thêm:** dòng "Bán / hủy đồ trong túi" của lệnh bài chứa dấu `/`. Hàm `Say` dùng `/` để tách nhãn và tên hàm, nên game chỉ hiện "Bán" và gọi sai hàm. Đã đổi thành "Bán hoặc hủy đồ trong túi" (bản 4, nạp nóng 08:57). Backup bản 3: `_backup\20261001-shop-fight\huydo_lenhbai.lua.v3`.

## Phần 3: Hành động
- [ ] Bấm vào Đại Phu, Thợ Đồng hoặc Tạp Hóa: mua bằng chuột trái → Đồng ý; bán bằng nút Bán hoặc Shift + chuột phải.
- [ ] Dùng Lệnh Bài Hủy Đồ ở bản đồ luyện cấp: Bán, Sửa, rồi "Bật lại chiến đấu".

## Phần 4: Tài liệu tham khảo
- `Core\Src\KBuySell.cpp` (`CanBuy` 427, `Buy` 503, `Sell` 666), `KPlayer.cpp` (`BuyItem`/`SellItem` 1050–1126, `RepairItem` 8757), `CoreShell.cpp` (`GDI_TRADE_ITEM_PRICE` 276).
- `GameClient\Ui\UiCase\UiItem.cpp` (`OnClickItem`), `UiShop.cpp`, `UiTradeConfirmWnd.cpp`.
- `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`, `lenh-bai-huy-do-phong-than-20260930.md`.
