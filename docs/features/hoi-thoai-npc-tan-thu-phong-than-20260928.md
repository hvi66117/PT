# Tính năng 3: Hội thoại và nhiệm vụ NPC tân thủ

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai 20:03**. 27 script trong `Server\script\phongthan\npc_fix\` đều biên dịch OK; đã gắn 27/27 NPC; Khoa Phụ đã được đặt (template 175, 190/204); Tân Thủ tầm bảo đã bật lại ở Lỗ Hùng, Từ Hàng, Hình Thiên. Chưa kiểm thử chuỗi nhiệm vụ trong game.
> Nguồn: khảo sát 54 NPC trên 3 bản đồ tân thủ, đọc 37 script gốc trích từ PAK (`%TEMP%\ptnewbie`)

## Phần 1: Tổng quan

- **Mỗi phái có một bản đồ tân thủ riêng:**
  - 1002 Sùng Thành doanh: Giáp Sĩ.
  - 1003 Ngọc Hư Cung: Đạo Sĩ.
  - 1004 Xi Vưu Mộ: Dị Nhân.
- **Cả 54 NPC đều có script, không NPC nào thiếu.** Vấn đề nằm ở chất lượng script:
  1. **Menu nhiệm vụ không có dòng thoát** (lỗi E). Hàm `SayTask` của bản rebuild không tự thêm "Kết thúc đối thoại". Khi mọi dòng bị ẩn, hộp thoại có **0 lựa chọn** và người chơi bị kẹt. Lỗi này ảnh hưởng mọi NPC có nhiệm vụ.
  2. **20 NPC có nhiệm vụ bị bọc trong menu tạm** ("Vai tro… / Chuc nang VNG goc / Dong"). Người chơi phải bấm thêm một bước mới tới được nhiệm vụ.
  3. **8 NPC đang chạy thẳng script trong PAK**, không sửa được bằng file trên đĩa. Riêng Thủ Khố 1002 đã được sửa.
  4. **Hai nhiệm vụ Dị Nhân bị chặn hẳn:**
     - Task 30 (Khai Trí) cần NPC **Khoa Phụ**, nhưng NPC này chưa được đặt trên bản đồ 1004.
     - Task 35 (Thần Khí) kẹt ở NPC Cộng Công, vì `GetItemCount(28)` bị engine hiểu sai nghĩa.
  5. **Bước phát vật phẩm không an toàn:** script ghi tiến độ trước khi kiểm tra túi. Nếu túi đầy thì mất vật phẩm nhiệm vụ và bị kẹt.
- **Cơ chế sửa đã được kiểm chứng:** đặt script sửa ở `script\phongthan\npc_fix\` (PAK không có đường dẫn này), rồi gắn cho NPC qua `PTADM_NPC_FIX` trong `servertimer.lua`. Thủ Khố 1002 đã chạy theo cách này từ 17:52.

## Phần 2: Chi tiết

### 2.1 Luồng tân thủ theo phái

**Giáp Sĩ (1002):**

| Cấp | NPC nhận | Nhiệm vụ (task) | Chuỗi NPC |
|---|---|---|---|
| 1 | Tô Hộ | Hộp Gấm (20) | Tô Hộ → Thủ Khố → Sùng Ứng Loan / Triệu Lôi / Triệu Điền → Thủ Khố → Tô Hộ |
| 3 | Lỗ Hùng | Tân Thức (21) | Lỗ Hùng → Âu Thiên Hóa → Sùng Ứng Bưu → 10 Đoản Kiếm → Âu Thiên Hóa → Sùng Hầu Hổ → Lỗ Hùng → Sùng Hắc Hổ → Âu Thiên Hóa → Lỗ Hùng |
| 1+ | Thủ Khố | Mở rương (23), lặp nguyên liệu (26, từ cấp 6) | Nộp 5 Mảnh Giáp |
| 7 | Triệu Điền | Dũng Đao (25) | Triệu Điền → Yến Sơn → Triệu Điền → Âu Thiên Hóa → Triệu Điền |
| 12 | Sùng Ứng Loan | Kiêm Ái (24) | → Âu Thiên Hóa → giết Hoàn Cẩu tinh → Sùng Ứng Loan (hết tân thủ) |
| 25 | Sùng Hầu Hổ | Trung Thành (3) | Sùng Hầu Hổ → Trịnh Luân → Sùng Hầu Hổ |

**Đạo Sĩ (1003):**

| Cấp | NPC nhận | Nhiệm vụ (task) | Chuỗi NPC |
|---|---|---|---|
| 1 | Từ Hàng | Bách Lý (10) | Từ Hàng → Xích Tinh Tử / Nam Cực / Linh Bảo → Từ Hàng |
| 3 | Nam Cực | Ngũ Thất (11) | Nam Cực → Hoàng Long → 10 Băng cơ → Nam Cực → Nhiên Đăng → Nam Cực |
| 7 | Vân Trung Tử | Thăm Dò (15) | → Linh Bảo (3 câu đố, đáp án 2-1-3) → Vân Trung Tử → giết Tuyết Nguyên Cự Thú → Vân Trung Tử |
| 12 | Nhiên Đăng | Linh Lực (14) | Nộp 10 Ngọc cốt (hết tân thủ) |
| 25 | Hoàng Long | Chinh Đồ (1) | |

**Dị Nhân (1004):**

| Cấp | NPC nhận | Nhiệm vụ (task) | Chuỗi NPC |
|---|---|---|---|
| 1 | Thiếu Hạo | Khai Trí (30) | Thiếu Hạo → Phong Bá / **Khoa Phụ (chưa có NPC)** / Chúc Dung → Thiếu Hạo |
| 3 | Hậu Thổ | Tân Thức (31) | Hậu Thổ → Cao Giác → Cao Minh → Hình Thiên → Cao Minh → 10 Mặt Quỷ → Hậu Thổ |
| 7 | Chúc Dung | Thần Khí (35) | → Cộng Công → Cao Minh → Miêu Cương → **Cộng Công (lỗi GetItemCount)** → Chúc Dung |
| 12 | Phong Bá | Cứu Tế (34) | → Hình Thiên → Cự Lộc → Hình Thiên → Phong Bá (hết tân thủ) |
| 25 | Hình Thiên | Mao Lư (2) | |

### 2.2 Cách sửa chuẩn cho mỗi NPC
Mỗi NPC có nhiệm vụ sẽ có một tệp `Server\script\phongthan\npc_fix\<map>_<tên>.lua`, gồm script VNG gốc cộng các thay đổi:
- **(a)** Thêm `{"Kết thúc đối thoại","no";show=1}` (chữ TCVN3) vào mọi bảng `SayTask`.
- **(b)** Chuyển bước phát vật phẩm sang `QuestExchange(task, từ, đến, {cần}, {thưởng})`. Cách này đảm bảo trừ đồ, phát thưởng và tăng tiến độ cùng lúc, lỗi thì không đổi gì. Mẫu đã chạy ở Tô Hộ.
- **(c)** Bỏ lớp menu tạm để menu nhiệm vụ hiện ngay.
- **(d)** Sửa lỗi riêng:
  - Cộng Công và Xích Tinh Tử: đổi `GetItemCount(n)` thành `HaveEventItemCount(n)`.
  - Sùng Hắc Hổ và Thiếu Hạo: thay `DelHandItem` (không tồn tại) bằng `DelNormalItem`.
- Thêm 1 dòng vào `PTADM_NPC_FIX`. Chuỗi tên GBK đã tính sẵn trong báo cáo khảo sát.

### 2.3 Danh sách tệp dự kiến

| Bản đồ | NPC cần sửa | Số tệp |
|---|---|---|
| 1002 | Tô Hộ, Lỗ Hùng, Âu Thiên Hóa, Sùng Ứng Bưu, Sùng Ứng Loan, Triệu Điền, Triệu Lôi, Sùng Hầu Hổ, Sùng Hắc Hổ, Trịnh Luân, cùng bổ sung cho Thủ Khố (renwu3) | 10 mới + 1 sửa |
| 1003 | Từ Hàng, Xích Tinh Tử, Linh Bảo, Nam Cực, Hoàng Long, Nhiên Đăng, Vân Trung Tử | 7 |
| 1004 | Thiếu Hạo, Hậu Thổ, Phong Bá, Chúc Dung, Cộng Công, Hình Thiên, Cao Giác, Cao Minh | 8 |
| 1004 | Đặt NPC **Khoa Phụ** + script | 1 + dữ liệu vị trí |
| 1003/1004 | Đặt Thủ Khố, Tạp Hóa còn thiếu (tùy chọn) | 4 |
| chung | `servertimer.lua` (thêm dòng `PTADM_NPC_FIX`) | 1 |

26 NPC placeholder (Khảo Cổ Học, Thương Điếm, Lão Rùa…) đã có nút "Dong", không cần sửa.

### 2.4 Giới hạn cần C++ (khi có Visual C++ 6)
1. `LuaSayTaskCompat` tự thêm dòng thoát. Sửa một chỗ này sẽ xử lý lỗi E cho mọi script trong PAK.
2. `GetItemCount` với 1 tham số đếm event item theo đúng cách của VNG.
3. Đăng ký `DelHandItem` và `RepairTaskValue`.
4. Nút MsgBox đang là "OK/Cancel" tiếng Anh.

## Phần 3: Hành động

### Cần chủ server quyết định trước khi làm
1. **Xác nhận triển khai khoảng 27 tệp script** (quy định dự án yêu cầu xác nhận khi sửa quá 5 tệp).
2. **Tọa độ đặt NPC Khoa Phụ trên bản đồ 1004.** Tài liệu dự án cấm tự chọn tọa độ. Đề xuất gần các cột totem khác, khoảng 190/204, nhưng cần chủ server xác nhận.
3. **Có bật lại sự kiện "Tân Thủ tầm bảo"** (VNG đã tắt) không?

### Kế hoạch triển khai

| Bước | Nội dung | Kiểm thử |
|---|---|---|
| 1 | Cộng Công 1004 + Thủ Khố 1002 renwu3 (đang chặn hoặc gây mất đồ) | Task 35 qua bước 6→7; túi đầy không mất Hộp Gấm |
| 2 | 10 NPC 1002 (Giáp Sĩ) | Chạy trọn chuỗi task 20, 21, 25, 24 bằng nhân vật Giáp Sĩ |
| 3 | 7 NPC 1003 (Đạo Sĩ) | Chuỗi task 10, 11, 15, 14 |
| 4 | 7 NPC 1004 + Khoa Phụ | Chuỗi task 30, 31, 35, 34 |
| 5 | Dùng `PTTaskNote` để F11 hiện chữ nhiệm vụ thật | Xem tính năng 2 |

Mỗi bước đều: ghi CHANGELOG, sao lưu trước, nạp nóng bằng `ReLoadScript` qua cầu nối admin, rồi kiểm thử bằng nhân vật đúng phái.

## Phần 4: Tài liệu tham khảo
- Cơ chế gắn script: `PhongThanRuntime-Staging\Server\script\servertimer.lua` (`PTADM_NPC_FIX`, `PTAdm_FixNpcScripts`)
- Mẫu đã chạy: `Server\script\phongthan\npc_fix\1002_thu_kho.lua`, `Server\script\phongthan\npc_restore\1002_00.lua` (QuestExchange)
- Engine: `PhongThanSource\Sources\Core\Src\PhongThanNpcDialogLua.inl` (SayTask/MsgBox), `ScriptFuns.cpp` (`LuaGetItemCount` dòng 12932)
- Dữ liệu vị trí NPC: `Docs\NPC_RESTORATION_DEPLOYMENT.json`, `Server\settings\phongthan\npc_regions\100{2,3,4}\`
- Script gốc đã trích: `%TEMP%\ptnewbie\view\` (bảng tra `index.tsv`)
- Tính năng liên quan: `nhiem-vu-chinh-tuyen-phong-than-20260928.md`, `he-thong-nhiem-vu-f11-phong-than-20260928.md`
