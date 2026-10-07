# Càn Khôn Luân (Thái Tuế Sư), Dược điếm, Thợ Đồng

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái:
> - **Càn Khôn Luân:** đã chạy, nạp nóng lúc 09:57, không cần khởi động lại.
> - **Dược điếm, Thợ Đồng:** phía server đã kiểm tra hết, không có lỗi; chờ kiểm thử trong game.

## Phần 1: Tổng quan
| Tính năng | Nguyên nhân gốc (đã kiểm chứng) | Cách sửa |
|---|---|---|
| Quay Càn Khôn Luân | (1) NPC Thái Tuế Sư (太岁师) **không được đặt ở bản đồ nào**, nên không có chỗ để quay. (2) Script VNG `\script\彩票\太岁.lua` gọi hàm engine `Roulette(k)` để mở vòng quay ở client, nhưng bản dựng lại **không có hàm này**, không có giao diện, cũng không có gói tin. Script dừng giữa chừng sau khi đã trừ lượt và vật phẩm | Script mới `npc_fix\1020_thai_tue.lua`: giữ nguyên toàn bộ logic VNG, thêm hàm dự phòng `Roulette(k)` gọi thẳng `Finished()`. **Thưởng được phát ngay, không có hoạt ảnh vòng quay.** NPC đặt ở Tây Kỳ (1020), cạnh Đại Phu |
| Dược điếm (Đại Phu), Thợ Đồng | Chưa tìm ra lỗi phía server: NPC sống đủ ở 5 thành, script gắn đúng, hàm hội thoại có đăng ký, buysell đã đệm cột | Cần kiểm thử trong game để biết lỗi nằm ở bước nào (xem Phần 3) |

## Phần 2: Chi tiết
### 2.1 Luật chơi Càn Khôn Luân (giữ nguyên bản VNG)
- **Điều kiện:** cấp ≥ 40 và có dưới 16 trạng thái IB (`GetIBBuffCount`).
- **Lượt quay mỗi ngày** (task 764; task 73 là lần quay cuối, task 72 là ô trúng):

| Lượt | Chi phí |
|---|---|
| 1 | Miễn phí |
| 2–3 | Hình thế thân (8/135 hoặc 8/178) |
| 4–6 | Cây thế thân (8/174 hoặc 8/179) |
| ≥ 7 | Bị chặn |

- **12 ô thưởng:** mỗi lượt được thêm cấp × 100 kinh nghiệm, cộng thưởng theo ô trúng:

| Ô | Thưởng |
|---|---|
| Ngũ Quỷ | Quay lại (không mất lượt) |
| Đại Hao | Hồi sinh lực +10 trong 1 giờ |
| Bạch Hổ | Hồi nội lực +10 trong 1 giờ |
| Thiên Cẩu | 15 danh vọng |
| Bách Việt | 10 danh vọng |
| Tử Vi | Nhân đôi kinh nghiệm trong 1 giờ |
| Thiên Đức | 5 vạn lượng |
| Thái Âm / Thái Dương | 2 vạn lượng (một nửa nếu khác giới) |
| Thái Tuế | ×1,5 kinh nghiệm trong 2 giờ |
| Tiểu Hao | 3 vạn kinh nghiệm |
| Dịch Mã | 10 vạn kinh nghiệm, kèm thông báo toàn server |

- **Mô phỏng Lua 4 đạt:**
  - lượt 1 miễn phí;
  - lượt 2 không có vật phẩm thì bị chặn;
  - có vật phẩm thì trừ đúng một cái;
  - tối đa 6 lượt/ngày;
  - các ô ra đúng thưởng.
- **Vật phẩm dùng nhiều lượt:** script có Include `pt_compat.lua`, nên `CostIBItem` đếm lượt (xem `quai-hien-thi-lech-va-luot-dung-vat-pham-phong-than-20260930.md`).

### 2.2 Giới hạn
- **Không có hình vòng quay xoay.** Muốn có phải viết C++: hàm `Roulette` phía server, gói tin s2c/c2s, lớp giao diện `KUiRoulette` kèm ini và spr ở client. Không tìm thấy tài nguyên giao diện này của VNG.
- **Đồng nhân (8/227) và Như ý Chỉ nhân (8/634)** không được script VNG nào dùng cho vòng quay (chúng chỉ nằm trong túi quà). Vì vậy chưa tính các món này là vé quay.

### 2.3 File đã thay đổi
- `Server\script\phongthan\npc_fix\1020_thai_tue.lua` (mới).
- `Server\script\servertimer.lua`: thêm 1 dòng vào `PTADM_NPC_SPAWN` (template 1116, 49296/97296) và 1 dòng vào `PTADM_NPC_FIX`.
- `NpcDisplayNames.txt` (Server, Client, ProjectContent): thêm `太岁师 → Can Khon Luan`. Tên hiển thị này có hiệu lực khi mở lại client.
- Backup: `_backup\20260930-cankhon\`.

### 2.4 Dược điếm và Thợ Đồng: những gì đã kiểm tra
- **NPC:** truy vấn lúc 09:48 thấy đủ Đại Phu (template 149) và Thợ Đồng (template 157) ở 1002, 1003, 1004, 1020, 1021.
- **Script:** `1002_dai_phu.lua` gọi `Sale(11)`, bản 1020 gọi `Sale(1)`; Thợ Đồng gọi `Sale(2)` / `Sale(12)`. `MsgBox`, `SayTask` và `Sale` đều có trong danh sách API đã đăng ký.
- **Hàng bán:** `ptfix.pak` đang cài có buysell đã đệm cột `PTPAD`. Ví dụ Sale(1) = hàng 1, 4, 2, 5 (Tiểu Hoàn Đan, Trung Hồng Đan…), Sale(2) = 19 món đao, kích, kiếm, ngựa.
- **Giao diện:** client dùng giao diện `ui3`; `Ui\ui3\UiShop.ini` có đủ các mục Main, ItemBox và các nút.

## Phần 3: Hành động
- [ ] Đến Tây Kỳ (1020), bấm vào NPC Thái Tuế Sư, chọn "Xoay Càn Khôn luân" rồi đồng ý: phải nhận thưởng ngay.
- [ ] Đăng nhập, bấm vào Đại Phu hoặc Thợ Đồng, rồi báo lại lỗi thuộc trường hợp nào:
  - (a) không hiện hội thoại;
  - (b) có hội thoại nhưng không mở cửa hàng;
  - (c) cửa hàng trống hoặc không mua được.
- [ ] Mở lại client để hiện tên "Can Khon Luan".

## Phần 4: Tài liệu tham khảo
- Script gốc: id `828485f4` (bản dump ở `%TEMP%\ptexits\dump\828485f4.bin`); chuỗi 11079–11104.
- `Core\Src\ScriptFuns.cpp` (`LuaSale` dòng 1790), `KBuySell.cpp` (`Init`, `OpenSale`), `GameClient\Ui\UiCase\UiShop.cpp`.
- `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`, `bao-thuong-chay-buon-phong-than-20260929.md`.
