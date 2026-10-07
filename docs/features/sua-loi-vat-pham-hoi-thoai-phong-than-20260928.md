# Sửa lỗi: nút đóng hội thoại NPC, gói Đoản Kiếm, tiền đồng, thú cưỡi, Thanh Lộ / Lâm Tiên Lộ

> Dự án: Phong Thần (bản local) · Ngày yêu cầu: 2026-09-28 (bổ sung tài liệu 2026-09-29) · Trạng thái: xem cột "Trạng thái" trong từng mục

## Phần 1: Tổng quan
| Lỗi người chơi báo | Nguyên nhân gốc | Trạng thái |
|---|---|---|
| Hộp thoại NPC (Thủ khố Sùng Thành) không có nút tắt | `SayTask` bản dựng lại không tự thêm dòng thoát. Bản sửa ghi đè trên đĩa không có tác dụng vì server đọc `script.pak` trước | **Đã sửa**: script ở `npc_fix\`, gắn lại mỗi phút bằng `PTAdm_FixNpcScripts`. Từ 2026-09-29 mọi script VNG có thêm nút đóng qua `ptfix.pak` |
| Gói Đoản Kiếm (Lớn) click phải không có gì | Script `开包操作.lua` đọc item ở tham số 4 (server truyền ở tham số 1), gọi hàm không tồn tại, và `GetItemPartByID` trả 0 cho gói 1571–1593 | **Đã sửa** (xác nhận 18:10, `deleted=1`): nhận diện gói bằng `GetItemCount(6, mã)`, nhiều loại thì hiện menu chọn, trừ bằng `DelItem(1,6,mã)` |
| Không thấy tiền đồng trong túi | `KUiItem` đọc mục `[Gold]` mà `UiItem.ini` không có | **Đã sửa**: thêm `[Gold]`; ghi `nExtPoint` vào DB. Cần mở lại client |
| Ngựa không lên/xuống được | Server kẹt trạng thái "đang cầm đồ trên tay" (`m_Hand` ≠ 0), nên mọi lệnh kéo đồ bị bỏ qua | **Cách gỡ**: thoát nhân vật và vào lại |
| Áo đồ lục không mặc được | Cùng nguyên nhân kẹt `m_Hand` / yêu cầu phái | **Cách gỡ**: vào lại; web chỉ phát đồ đúng phái |
| Dùng Thanh Lộ, Lâm Tiên Lộ không có tác dụng | Cột script của ibitem là `NONE`. `KItemList::NowEatItem` chỉ gọi `ExecuteScript`, không gọi hệ IBBuff | **Chưa sửa được**. Vật phẩm không bị mất |

## Phần 2: Chi tiết
- **Thanh Lộ / Lâm Tiên Lộ:** bảng `ibitem` nằm trong PAK. Có thể dùng `ptfix.pak` để trỏ cột script sang một script Lua gọi `AddIBBuff` rồi trừ vật phẩm, nhưng cần xác định đúng mã buff và thời gian của từng loại. Đây là việc tiếp theo có thể làm, không cần build lại C++.
- **Bản sao lưu:** `_backup\20260928-thukho`, `_backup\20260928-openpack`, `_backup\20260928-uiitem-gold`.

## Phần 3: Hành động
- [ ] Mở lại client để thấy tiền đồng.
- [ ] Nếu kéo đồ không được, thoát ra rồi vào lại nhân vật.
- [ ] Muốn làm Thanh Lộ / Lâm Tiên Lộ qua ptfix.pak thì báo để triển khai.

## Phần 4: Tài liệu tham khảo
- `Server\script\item\卦卷\开包操作.lua`, `Client\Ui\ui3\UiItem.ini`, `Core\Src\KItemList.cpp` (1584-1595, ExchangeItem)
- `goi-va-ptfix-pak-phong-than-20260929.md`
