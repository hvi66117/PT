# Rơi vật phẩm nhiệm vụ khi giết quái

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã triển khai và gắn nóng cho 811 quái**. Chưa kiểm thử trong game.

## Phần 1: Tổng quan

- **Vấn đề (phát hiện nhờ mô phỏng):** các nhiệm vụ thu thập ở tân thủ và thủ khố không làm được.
  - Engine bản dựng lại không đọc `DropRateFile`.
  - Các file VNG `\script\npcdeath\*.lua` bị thiếu.
  - Vì vậy quái không bao giờ rơi vật phẩm nhiệm vụ.
- **Cách giải:** `npc_fix\mob_drop.lua` gắn vào quái bằng `SetNpcScript`. Khi quái chết, engine gọi `LastDamage(npc)` với người giết là `PlayerIndex`. Script nhận diện quái bằng `GetNpcTemplateID`.
- **Nguyên tắc:**
  - Chỉ rơi khi người giết **đang làm đúng bước nhiệm vụ**.
  - Không rơi quá số lượng nhiệm vụ cần.
  - Không ảnh hưởng người chơi khác.

## Phần 2: Chi tiết

### 2.1 Vật liệu (genre 3), 35% mỗi lần giết (VNG gốc là 2%)
| Vật phẩm | Quái (template) | Bản đồ | Khi đang ở bước |
|---|---|---|---|
| Đoản Kiếm (3,10) | Kiếm Nhân (0) | 1005, 1007 | task 21=3, 26=10, 321=10 |
| Mảnh Giáp (3,11) | Xạ Thần (3) | 1006 | task 23=1, 26=11, 321=11 |
| Mặt Quỷ (3,12) | Hỏa Diện (2) | 1013 | task 31=5, 36=12, 321=12 |
| Băng Cơ (3,13) | Tuyết Quái (1) | 1008 | task 11=2, 16=13, 321=13 |
| Ngọc Cốt (3,9) | Băng Lang (4), Yểm Hỏa (8) | 1008, 1009, 1010 | task 14=1, 13=1, 16=9, 321=9 |
| Hỏa Vũ (3,8) | Cuồng Điêu (6) | 1011 | task 33=1, 36=8, 321=8 |

### 2.2 Quái đầu lĩnh (vật phẩm sự kiện, theo script VNG pak3)
| Vật phẩm | Quái | Điều kiện |
|---|---|---|
| Lưỡi / Thân / Cán đao (4,21..23) | Kiếm Nhân tướng quân (102), Yến Sơn | Giáp Sĩ, task 25=1, 50% mỗi lần giết ra một món còn thiếu |
| Thư tạo phản (4,25) | Phản quân đội trưởng (101), **mới thêm 3 con ở Yến Sơn [213,187]** | task 24=2 → 3 |
| Mảnh Thần Khí (4,28) | Thảo Tiên bà bà (105), Miêu Cương | Dị Nhân, task 35 từ 3 đến 5, mỗi lần +1 |
| Thức ăn (4,30) | Độc Đài yêu (106), Cù Lộc | Dị Nhân, task 34=3 → 4 |

### 2.2b Nguồn mới cho các nhánh tân thủ còn thiếu (thêm 13:53 ngày 2026-09-29, theo yêu cầu "có")
| Nhánh | Vật phẩm | Nguồn mới |
|---|---|---|
| Thiên Thụ (Sùng Ứng Bưu / Linh Bảo / Cao Giác / Bá Giám) | Mầm cây thần bí (4,49) + task 804 = 1 | Mọi quái có gắn `mob_drop.lua`, **3%** mỗi lần giết. Điều kiện: cấp ≥ 35, task 321 = 322 = 0, task 804 = 0, chưa có hạt giống |
| Côn Lôn kính (Xích Tinh Tử) | Côn Lôn kính (4,40) | **Thi Thú (114)**, mới thả 3 con ở Bích Du Cung tầng 2 [212,211][196,213][190,223]. Rơi 1/3 khi task 50 = 5 và task 52 = 1 |
| Vạn Tiên trận | Linh phù, Tứ tượng lệnh | **Không làm.** Đây là sự kiện PvP hẹn giờ (mission 1: `InitMission` → `SetGlobalValue(1,1)`, 15 phút), không phải nhiệm vụ tân thủ. Muốn chạy được phải dựng lịch mở mission và nối map sự kiện; có vật phẩm thôi thì không đủ |

### 2.3 Tệp liên quan
- `npc_fix\mob_drop.lua`: luật rơi. Muốn đổi tỉ lệ thì sửa `PTDROP_RATE`.
- `spawn\spawn_main.lua`: `PTSpawn_BindDrop` tự gắn script khi server thả quái.
- `spawn\spawn_1007.lua`: thêm 3 Phản quân đội trưởng.
- Bản sao lưu: `_backup\20260929-drops\`.

### 2.4 Chưa có nguồn (không tìm thấy trong dữ liệu VNG)
- Bách Linh phướn (4,43).
- Mầm cây (4,49 và 4,164), dùng cho chuỗi Thiên Thụ.
- Tứ tượng lệnh (3,66..69), dùng cho Vạn Tiên trận.
- Côn Lôn kính (4,40): quái Thi Thú (114) chưa được thả.
- Mảnh pháp khí (4,114): script VNG `乘黄.lua` bị lỗi biến.

## Phần 3: Hành động
- [ ] Nhận nhiệm vụ Tân Thức (Lỗ Hùng), đến Sùng Thành dã ngoại đánh Kiếm Nhân: phải nhặt được Đoản Kiếm.
- [ ] Giáp Sĩ nhận Dũng Đao (Triệu Điền), đánh Kiếm Nhân tướng quân ở Yến Sơn [234,208].
- [ ] Nếu tỉ lệ quá cao hoặc quá thấp, báo lại để chỉnh `PTDROP_RATE`.

## Phần 4: Tài liệu tham khảo
- Bảng nghiên cứu: `scratchpad\drops\quest_item_sources.tsv` (phiên làm việc)
- `kiem-thu-nhiem-vu-mo-phong-phong-than-20260929.md`, `quai-cac-ban-do-phong-than-20260928.md`
