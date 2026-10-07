# Không đổi hoặc mặc được đồ trong túi

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái: **Đã sửa bằng Lua, nạp nóng lúc 11:55**, không cần khởi động lại. Đã gỡ món kẹt cho nhân vật EmLaAi.

## Phần 1: Tổng quan
- **Triệu chứng:** bấm chuột phải hoặc kéo đồ từ túi vào ô trang bị thì không có gì xảy ra; túi đồ bị khóa vài giây.
- **Nguyên nhân gốc (kiểm chứng qua log và truy vấn server):**
  - Server đang giữ một vật phẩm **"trên tay"** (vật phẩm đang cầm để kéo thả), nhưng client không hiển thị nó. Lúc kiểm tra, nhân vật EmLaAi có món số 3 (0/4/102, cấp 10) nằm ở vị trí 1 (`pos_hand`).
  - Lệnh mặc đồ của client (chuyển thẳng từ túi sang ô trang bị) đi vào nhánh mới trong `KItemList::ExchangeItem`. Nhánh này có dòng `if (m_Hand) return;`, nên **mọi lệnh mặc đồ bị bỏ qua**, server không trả lời, và client khóa túi chờ.
- **Món đồ bị kẹt lên tay theo hai đường:**
  1. Thả đồ vào ô đang có đồ khác: server đổi chỗ, món bị đẩy ra nằm trên tay. Client và server đã lệch nhau về ô đó, nên người chơi không thấy món này.
  2. Thoát game khi tay còn đồ: `SavePlayerItemList` lưu món đó với `Container = pos_hand`. Lần đăng nhập sau `LoadPlayerItemList` lại đặt nó vào tay, nên lỗi lặp lại sau mỗi lần vào game.

## Phần 2: Chi tiết
### 2.1 Cách sửa: `PTAdm_HandTick()` trong `servertimer.lua` (chạy mỗi phút)
1. Với mỗi người chơi online, quét chỉ số vật phẩm 1–30.000 bằng `FindItem(k)` để tìm món có vị trí 1 (đang ở trên tay).
2. `AddItemIdx(k, 0)` nhân bản món đó (giữ nguyên hạt giống ngẫu nhiên, cấp, dòng thuộc tính, độ bền, số lượng chồng).
3. `AddItemID(n, 3, 0)` đặt bản sao vào ô trống trong túi.
4. **Chỉ khi** bản sao đã nằm trong danh sách đồ của người chơi thì mới `RemoveItem(k, 0, 0)` xóa bản trên tay. Nếu túi đầy, món đồ giữ nguyên trên tay, không bị mất.
5. Ghi log `handfix` vào `admin_bridge\result.log`.

- **Nạp nóng:** hàm được móc sau `PTAdm_IbTick` qua admin bridge. Từ lần khởi động server sau, `PTAdm_Tick` gọi thẳng hàm này.
- **Kết quả thực tế lúc 11:55:** `EmLaAi hand item 3 -> bag 38`. Kiểm tra lại lúc 11:56: tay trống, món 38 nằm ở túi ô (0,5), mã 0/4/102 cấp 10 giữ nguyên.

### 2.2 Giới hạn
- Việc lệch hiển thị giữa client và server khi thả đồ lên ô đang có đồ **vẫn còn**: đây là lỗi mã C++, cần biên dịch lại. Bản sửa Lua chỉ dọn tay trong vòng tối đa 1 phút, nên có thể phải đợi một chút rồi thao tác lại.
- Nếu đúng lúc tick chạy bạn đang cầm đồ trên chuột, món đó sẽ được cất vào túi.
- Món vừa trả về có thể chưa hiện ngay trên client; mở lại túi hoặc đăng nhập lại là thấy.

### 2.3 Sửa gốc khi có trình biên dịch
- `KItemList::ExchangeItem`, nhánh chuyển giữa hai vị trí khác nhau: nếu `m_Hand` đang có đồ thì cất nó vào túi (`SearchPosition`) trước, thay vì `return` im lặng.
- `KPlayer::LoadPlayerItemList`: không nạp `Container == pos_hand` vào tay mà tìm ô trống trong túi.

## Phần 3: Hành động
- [ ] Mở túi, kiểm tra món 0/4/102 ở ô (0,5); nếu chưa thấy thì đăng nhập lại.
- [ ] Bấm chuột phải lên một món trang bị trong túi: phải mặc được. Nếu lần đầu không được, đợi khoảng 1 phút rồi thử lại.
- [ ] Tránh thả đồ đè lên ô đang có đồ khác cho tới khi có bản C++.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KItemList.cpp` (`ExchangeItem` dòng 1988–2044, `Add` dòng 283, `Remove` dòng 585, `RemoveItem` dòng 4423).
- `Core\Src\KPlayerDBFuns.cpp` (lưu dòng 734–746, nạp dòng 470).
- `Core\Src\ScriptFuns.cpp` (`LuaAddItemIdx` 3299, `LuaAddItemID` 3322, `LuaRemoveItemIdx` 12416, `LuaFindItem` 13600).
- Log: `Server\item_action_diag.log` (`Move_SERVER_BEGIN` … `hand=`), `Client\item_action_diag.log` (`Move_CLIENT_LOCK locked=1`).
- Backup: `_backup\20260930-handfix\servertimer.lua`.
