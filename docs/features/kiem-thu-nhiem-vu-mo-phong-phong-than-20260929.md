# Kiểm thử trọn chuỗi nhiệm vụ 3 phái và nhiệm vụ tân thủ (bộ mô phỏng)

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Chuỗi chính tuyến cả 3 phái đi hết 0→81 trong mô phỏng**. Chưa có người chơi đi thật từ đầu đến cuối.

## Phần 1: Tổng quan

- **Cách kiểm thử:** chạy script NPC thật (`npc_fix\*.lua`) bằng chính Lua 4 của engine (`LuaLibDll.dll`, PowerShell 32-bit).
  - Toàn bộ API engine được giả lập: task, vật phẩm, QuestExchange, hội thoại.
  - Mỗi script giữ biến toàn cục riêng, giống engine thật.
  - Một "người chơi ảo" thử mọi NPC, mọi lựa chọn trong hội thoại và mọi quái nhiệm vụ. Nó chọn bước làm tăng tiến độ.
  - Khi bị tắc, nó thử tăng cấp hoặc cấp vật phẩm cần nhặt/mua, rồi ghi lại.
- **Kết quả:**

| Phái | Biến tiến độ | Kết quả | Số bước | Cấp cuối |
|---|---|---|---|---|
| Giáp Sĩ | task 3 | **0 → 81 (hoàn thành)** | 111 | 85 |
| Đạo Sĩ | task 1 | **0 → 81 (hoàn thành)** | 112 | 85 |
| Dị Nhân | task 2 | **0 → 81 (hoàn thành)** | 113 | 85 |

- **Không có** lỗi runtime, không có menu thiếu nút đóng, không có bước lùi tiến độ.
- **Lỗi mô phỏng đã phát hiện và sửa:**
  - F11 hiện "Task N - step S" ở 14 bước nhiệm vụ tân thủ (task 1, 2, 7, 8, 13) vì `taskinfo.ini` không có chữ cho các bước đó.
  - Đã sửa trong `vng_tasknote.lua`: bước sau bước cuối hiện "Nhiệm vụ hoàn thành"; bước bị hổng dùng chữ của bước gần nhất trước đó.
- **Lỗ hổng phát hiện ở nhiệm vụ tân thủ:** các nhiệm vụ thu thập cần vật phẩm rơi từ quái, mà engine không cho quái rơi đồ. Đã xử lý trong `roi-vat-pham-nhiem-vu-phong-than-20260929.md`.

## Phần 2: Chi tiết

### 2.1 Mốc cấp của chuỗi (giống nhau cho 3 phái)
| Mốc tiến độ | Cấp cần | NPC / quái chính |
|---|---|---|
| 0→10 | 25 | NPC tân thủ của phái (Sùng Hầu Hổ / Hoàng Long / Hình Thiên) |
| 10→20 | 35 | Sùng Hắc Hổ, Hoàng Phi Hổ / Lôi Chấn Tử / Phong Lâm, Ngô Long |
| 20→30 | 45 | Lý Tịnh, Đặng Cửu Công, quái nhiệm vụ (Trấn Điện tướng quân / Bắc Hải thần oanh / Thương quân hiệu úy) |
| 30→40 | 55 | Dương Tiễn, Hồ Hỷ Mị, Thần Long / Thần Mộc / Kim Hà thú, Đa Bảo đạo nhân |
| 40→50 | 65 | Đắc Kỷ, Tây Vương Mẫu, An Cư thú |
| 50→60 | 65–70 | Thần Nông / Hiên Viên / Xi Vưu, Tranh Nanh |
| 60→70 | 75 | Đắc Kỷ, Khương Tử Nha, Võ Vương (Tôn Vũ / Biển Thước / Can Tương tiền thế) |
| 70→81 | 80–85 | Tây Vương Mẫu, Đắc Kỷ tương lai, Nguyên Thủy Thiên Tôn, Đội trưởng lục soát, Đắc Kỷ thời trẻ |

### 2.2 Vật phẩm người chơi phải tự kiếm (mô phỏng phải cấp)
- Vật liệu `(3,8..13)`: Hỏa Vũ, Ngọc Cốt, Đoản Kiếm, Mảnh Giáp, Mặt Quỷ, Băng Cơ. Dùng cho các nhiệm vụ thu thập tân thủ. Giờ đã rơi từ quái.

### 2.3 Nhiệm vụ tân thủ (mô phỏng 3 phái, kèm vật phẩm rơi từ quái)
> "Hoàn thành" = mô phỏng đi hết. "Làm được" = luồng script đúng khi có vật phẩm, nhưng mô phỏng **không mô phỏng việc giết quái thường**, nên phần rơi đồ (`mob_drop.lua`) mới chỉ kiểm tra bằng biên dịch và đọc logic, chưa thử trong game.
| Nhiệm vụ (task) | NPC | Kết quả |
|---|---|---|
| Khai Trí (30) | Thiếu Hạo → Chúc Dung → Khoa Phụ → Phong Bá | Hoàn thành |
| Bách Lý (10) | Từ Hàng → Linh Bảo, Nam Cực, Xích Tinh Tử | Hoàn thành |
| Hộp gấm (20) | Tô Hộ → Thủ Khố → Triệu Điền, Triệu Lôi | Hoàn thành |
| Tân Thức (21 / 31) | Lỗ Hùng, Âu Thiên Hóa, Sùng Ứng Bưu / Hậu Thổ, Cao Giác, Cao Minh | Hoàn thành (Đoản Kiếm, Mặt Quỷ giờ rơi từ quái) |
| Mở rương 3 thành (23 / 13 / 33), Thu thập Thủ Khố (26 / 16 / 36) | Thủ Khố 1002 / 1003 / 1004 | Làm được, lặp lại theo lượt (vật liệu rơi từ quái) |
| Kiêm Ái (24), Dũng Đao (25) | Sùng Ứng Loan, Âu Thiên Hóa / Triệu Điền | Làm được (Thư tạo phản; lưỡi/thân/cán đao rơi từ quái đầu lĩnh ở Yến Sơn) |
| Ngũ Thất (11), Linh Lực (14), Khảo Nghiệm (15) | Nam Cực, Hoàng Long / Nhiên Đăng / Vân Trung Tử, Linh Bảo | Làm được (Băng Cơ, Ngọc Cốt rơi từ quái) |
| Thần Khí (35), Cứu Tế (34) | Chúc Dung, Cộng Công, Cao Minh / Phong Bá, Hình Thiên | Làm được (mảnh Thần Khí, thức ăn rơi từ quái đầu lĩnh) |
| Tân Thủ tầm bảo (338–345) | Lỗ Hùng / Từ Hàng / Hình Thiên | Hoàn thành theo mốc cấp 11 / 21 / 31 |
| Thiên Thụ (321–323), Côn Lôn kính | Sùng Ứng Bưu, Linh Bảo, Cao Giác / Xích Tinh Tử | Làm được từ 2026-09-29 13:53 (hạt giống 3% từ quái khi cấp ≥35; Thi Thú ở Bích Du Cung tầng 2) |
| Vạn Tiên trận | Sùng Hắc Hổ, Từ Hàng, Thiếu Hạo | Không làm: đây là sự kiện PvP hẹn giờ (mission), không phải nhiệm vụ tân thủ |

### 2.4 Công cụ (scratchpad của phiên làm việc)
- `qtest\sim.lua`: stub API, mô phỏng trạng thái riêng từng script, bắt hội thoại, kiểm tra nút đóng.
- `qtest\sim_main.lua`: bộ tìm đường chuỗi nhiệm vụ. Chạy `run.ps1 -Main sim_main.lua -Args1 main:0|1|2` hoặc `newbie:0|1|2`.
- `qtest\sim_pak.lua`: quét 265 script VNG vá qua ptfix.pak.
- `registered.txt`: 734 hàm Lua mà engine có đăng ký (lấy từ `ScriptFuns.cpp`).

## Phần 3: Hành động

- [ ] Người chơi kiểm thử thật (nên dùng nhân vật mới):
  - Dùng web admin nâng cấp theo mốc ở bảng 2.1.
  - Nói chuyện theo thứ tự NPC trong `nhiem-vu-chinh-tuyen-phong-than-20260928.md`.
  - Mở F11 xem chữ nhiệm vụ.
- [ ] Nếu tắc ở bước nào, báo lại phái, giá trị tiến độ (task 3/1/2) và NPC đang nói chuyện.

## Phần 4: Tài liệu tham khảo
- `nhiem-vu-chinh-tuyen-phong-than-20260928.md`, `hoi-thoai-npc-tan-thu-phong-than-20260928.md`, `he-thong-nhiem-vu-f11-phong-than-20260928.md`
- `goi-va-ptfix-pak-phong-than-20260929.md`, `roi-vat-pham-nhiem-vu-phong-than-20260929.md`
