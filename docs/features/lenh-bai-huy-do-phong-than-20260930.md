# Lệnh Bài Hủy Đồ: bán đồ trong túi từ xa

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái: **Đã làm.** Script đã được đăng ký nóng. Vật phẩm lệnh bài (magicscript 61002) nằm trong ptfix v8, có hiệu lực sau khi khởi động lại server, game và web admin.

## Phần 1: Tổng quan
- **Lệnh Bài Hủy Đồ** (6/61001 là lệnh bài boss; lệnh bài này là **6/61002**):
  - dùng vĩnh viễn, không mất khi dùng;
  - không vứt, giao dịch, bày bán hay bán cho shop được.
- **Cách dùng:** click phải trong túi → cửa hàng mở ngay tại chỗ → bấm **Bán** → click vào đồ trong túi để bán (hủy) đồ và nhận lượng.
- **Phát từ web admin:** tab "Phát đồ" → nhập tên nhân vật → "Phát Lệnh Bài Hủy Đồ". Cạnh đó có thêm nút "Phát Lệnh Bài Boss Thế Giới".

## Phần 2: Chi tiết
- **Vì sao mở cửa hàng từ xa được** (kiểm chứng trong mã nguồn):
  - `KBuySell::OpenSale` lưu **bản đồ và vị trí của chính người chơi** lúc mở cửa hàng.
  - Hàm bán đồ của `KPlayer` (KPlayer.cpp 1118) chỉ kiểm tra người chơi vẫn đứng đúng vị trí đó, không kiểm tra khoảng cách tới NPC.
  - Vì vậy gọi `Sale(1)` ở đâu cũng bán được, miễn là **đứng yên** trong lúc bán.
- **Script:** `Server\script\phongthan\item\huydo_lenhbai.lua`. `main` báo hướng dẫn rồi gọi `Sale(1)` (cửa hàng thuốc, ít hàng); không tự xóa vật phẩm. Không đặt `dofile` ở đầu file, vì lúc đăng ký script thư mục làm việc là thư mục của script.
- **Dòng vật phẩm** (ptfix v8, `build_ptfix.py`, danh sách `TOKENS`): sao từ "Lệnh Bài VIP (Cấp 4)" (7308); tên và mô tả TCVN3; không mất sau khi dùng; không có thời gian tồn tại; mọi cờ vứt, giao dịch, bày bán, bán shop đều bằng 0.
- **Web admin:** mã vật phẩm `SellToken` trong `Get-ItemCode`, nút `btnSellToken` và `btnBossToken` ở tab "Phát đồ".
- **Kiểm tra:**
  - Lua 4 mô phỏng: `main` gọi `Sale(1)`, trả về 0.
  - `ReLoadScript` trên server lúc 20:52 thành công.
  - `PhongThan-Admin.ps1` không lỗi cú pháp.
- **Phụ thuộc:** dùng chung giao diện cửa hàng NPC (`UiShop.ini`). Nếu cửa hàng NPC có lỗi (Dược điếm/Thợ Đồng vẫn đang chờ kiểm tra) thì lệnh bài này cũng bị ảnh hưởng theo.

### 2.1 Thêm chức năng sửa đồ đang mặc (2026-10-01, người dùng chọn "Làm bản Lua ngay")
- **Kiểm chứng:**
  - Engine không có hàm Lua nào sửa đồ hoặc đặt độ bền. `AbradeEquip` và `KItemList::AutoDurationItem` chỉ làm giảm độ bền.
  - Server sửa từng món qua `KPlayer::RepairItem` (KPlayer.cpp 8757): không kiểm tra vị trí cửa hàng, **từ chối khi đang chiến đấu** (`m_FightMode`), trả lượng theo `GetRepairPrice`, đồ độ bền 0 không sửa được.
  - Client gửi lệnh sửa khi ở chế độ "Sửa" của cửa hàng và bấm vào món đồ, kể cả đồ đang mặc ở F3 (`UiStatus.cpp` 673).
- **Menu lệnh bài** (`huydo_lenhbai.lua` v2):
  1. **Bán / hủy đồ trong túi**: `Sale(1)`.
  2. **Sửa đồ đang mặc**: nếu đang chiến đấu thì `SetFightState(0)` và ghi task 1940 = 1, rồi `Sale(1)`. Người chơi bấm "Sửa" và click từng món ở F3.
  3. **Bật lại chiến đấu**: chỉ bật lại nếu task 1940 = 1 (tức chính lệnh bài đã tắt).
  4. **Kết thúc**.
- **Giới hạn:** chưa sửa toàn bộ đồ trong một lần bấm được; muốn vậy phải thêm hàm Lua bằng C++.
- **Kiểm tra:** mô phỏng Lua 4 đạt (menu 4 mục; bán; sửa tắt chiến đấu và ghi dấu; bật lại; bấm bật lại lần 2 không thay đổi gì). Đã `ReLoadScript` trên server.

### 2.2 Sửa nhãn menu (2026-10-01 08:57)
- Nhãn trong `Say` không được chứa `/` (dấu này tách nhãn và tên hàm). Mục 1 đổi thành **"Bán hoặc hủy đồ trong túi"**.
- Kiểm thử trực tiếp: mua, bán và hộp "Tu sửa" cho đồ đang mặc đều hoạt động khi đã tắt chiến đấu (xem `cua-hang-trang-thai-chien-dau-phong-than-20261001.md` mục 2.1).

### 2.3 Hủy đồ bằng hộp bỏ đồ (2026-10-01, bản 5)
- Menu có thêm mục **"Hủy đồ (bỏ vào hộp rồi xác nhận)"**: gọi `GiveItemUI` để mở hộp bỏ đồ của engine.
- Người chơi kéo đồ vào hộp rồi bấm Xác nhận → `PTHD_DestroyOK` đếm số món trong hộp (`GetItemCountRoom(14)`, pos_give) → `RemoveRoom(12)` (room_give) xóa vĩnh viễn toàn bộ.
- Kiểm chứng:
  - `KPlayer::ExecuteScript` đặt `m_ActionScriptID` bằng script lệnh bài, nên lời gọi lại chạy đúng trong lệnh bài.
  - Sau lời gọi lại, `BackLocal()` trả phần còn lại về túi; lúc đó hộp đã trống.
- Mô phỏng: hộp trống báo "không có món nào bị hủy"; hộp có 3 món thì xóa và báo số món.

### 2.4 Sửa toàn bộ đồ đang mặc (2026-10-01, bản 6)
- **Vì sao sửa ở cửa hàng không ăn** (kiểm chứng lúc thử, hộp "Tu sửa" báo giá **0**):
  - `KPlayer::RepairItem` thoát ngay khi `GetRepairPrice()` = 0.
  - Giá sửa = giá món đồ × 50% × độ bền mất / độ bền tối đa × …
  - Đồ giá gốc 0 hoặc thấp (đồ max, đồ phát từ admin) cho giá sửa 0, server bỏ qua không báo gì.
- **Engine không có hàm Lua đặt độ bền.** Đã viết hàm C++ `RepairAllEquip()` (`ScriptFuns.cpp`, đăng ký cạnh `RemoveItem`):
  - sửa miễn phí mọi món đang mặc về độ bền tối đa và đồng bộ client;
  - đồ đã hỏng (độ bền 0) vẫn hỏng, đúng luật VNG.
  - Backup: `_backup\20261001-repairall\ScriptFuns.cpp.orig`.
  - **Cần build lại CoreServer bằng VC6** (chung đợt với vòng sáng set đồ).
- Mục menu đổi tên thành **"Sửa toàn bộ đồ đang mặc"**. Script tự dùng `RepairAllEquip` khi engine có hàm này; chưa có thì mở cửa hàng để sửa từng món như cũ (chỉ ăn với đồ có giá sửa > 0).
- **Gốc lỗi thật (kiểm tra bảng `vng00.pak`, 2026-10-01 09:30):**
  - Cột giá (cột 11) của trang bị VNG gần như toàn bộ là **1**:
    - vũ khí: 3.371/3.411 dòng;
    - giáp, mũ, đai, giày, dây chuyền: 100%.
  - Giá sửa vì vậy luôn bằng 0, nên **mọi lần sửa đều bị bỏ qua**, ở cả NPC Thợ Đồng lẫn lệnh bài.
  - **Sửa (ptfix v10):** đổi giá 1 thành 1000 cho 19.721 dòng ở meleeweapon/armor/helm/belt/boot/pendant. Giá sửa khi mất toàn bộ độ bền khoảng 500 × (4 + tổng cấp thuộc tính)/4 lượng; mất ít độ bền thì tối thiểu 1 lượng.
  - Tác dụng phụ: món trang bị bán cho cửa hàng được nhiều tiền hơn, cửa hàng NPC bán trang bị cũng đắt hơn (1 → 1000).
  - Có hiệu lực sau khi khởi động lại (vật phẩm nhận giá mới khi nạp lại từ bảng).
- Phương án vá byte DLL đã cân nhắc nhưng bỏ: `SetFortune` là hàm inline, Lua không đọc được độ bền tối đa, `.text` không có vùng trống đủ cho code cave.

## Phần 3: Hành động
- [ ] Tắt server, thoát game, **đóng web admin**, rồi chạy `PhongThan-ChayTatCa.cmd game` để cài ptfix v8.
- [ ] Web admin → "Phát đồ" → phát Lệnh Bài Hủy Đồ → click phải trong game → bấm Bán → bán thử một món.
- [ ] Nếu cửa hàng không mở hoặc không bán được, báo lại triệu chứng (liên quan lỗi cửa hàng NPC).

## Phần 4: Tài liệu tham khảo
- `Core\Src\KBuySell.cpp` (`OpenSale` 753), `KPlayer.cpp` (mua 1082, bán 1118), `ScriptFuns.cpp` (`LuaSale` 1790).
- `boss-the-gioi-lenh-bai-phong-than-20260930.md`, `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`.
