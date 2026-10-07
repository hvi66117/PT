# Tính năng 1: Bóc tách nhiệm vụ chính tuyến 3 phái theo NPC

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai 20:49**: 28 script NPC chính tuyến (bỏ menu tạm, QuestExchange), đặt 7 NPC thiếu (1044, 1061–1064), 11 quái nhiệm vụ + Kim Hà thú đã spawn với script khi chết (`npc_fix\mob_*.lua`). Chưa kiểm thử trong game; tọa độ ở 1044/1061–1064 là suy luận
> Nguồn: script gốc VNG trích từ PAK server (`%TEMP%\ptquest`), đối chiếu với runtime hiện tại

## Phần 1: Tổng quan

- **Mỗi phái có một biến tiến độ riêng, và cả 3 cùng kết thúc ở giá trị 81:**

| Phái | Biến tiến độ | Sổ nhiệm vụ (F11) | Số bước TaskNote |
|---|---|---|---|
| Giáp Sĩ | `GetTask(3)` | `TaskNote(27, step)` | 0–32 |
| Đạo Sĩ | `GetTask(1)` | `TaskNote(28, step)` | 0–36 |
| Dị Nhân | `GetTask(2)` | `TaskNote(29, step)` | 0–31 |

- **Chuỗi chia 2 phần:**
  - Từ giá trị 0 tới 40 là **phần riêng của từng phái**, bắt đầu từ cấp 25 tại bản đồ tân thủ.
  - Từ 40 tới 81 là **phần chung** (Đắc Kỷ, Tây Vương Mẫu, Võ Vương, Viễn Cổ, Tương Lai).
- **Hiện không phái nào đi hết được chuỗi.** Chỗ tắc:

| Phái | Tắc ở bước | Lý do |
|---|---|---|
| Giáp Sĩ | 25→26 | Quái 镇殿将军 (Trấn Điện tướng quân) chưa gắn script khi chết |
| Đạo Sĩ | 22→23 | Quái 北海神莺 (Bắc Hải thần oanh) chưa gắn script khi chết |
| Dị Nhân | 21→22 | Quái 商军校尉 (Thương quân hiệu úy) chưa gắn script khi chết |

- Tổng cộng **11 quái nhiệm vụ** thiếu script khi chết (cột DeathScript trống) và **7 NPC** có script trong PAK nhưng chưa được đặt trên bản đồ. Chi tiết ở Phần 2.4.
- Phân nhánh theo phái dùng `GetPlayerType()` (0 Giáp Sĩ, 1 Đạo Sĩ, 2 Dị Nhân). Hội thoại dùng ID số trong `\settings\StringResource.txt`.

## Phần 2: Chi tiết

Ký hiệu cột **Runtime**:
- **W**: NPC bọc trong menu tạm; phải chọn "Chuc nang VNG goc" mới vào được chức năng gốc.
- **O**: script gốc chạy trực tiếp.
- **X**: chưa có NPC hoặc quái nào dùng script này.

### 2.1 Giáp Sĩ (task 3, TaskNote 27)

| Bước | NPC / hành động | Bản đồ (x/y) | Vật phẩm / thưởng | Runtime |
|---|---|---|---|---|
| 0→1 | Sùng Hầu Hổ, cấp ≥25 | 1002 (212/193) | Nhận nhiệm vụ | W |
| 1→2 | Trịnh Luân | 1002 (200/203) | Nhận Huyết thư (event 11) | W |
| 2→10 | Sùng Hầu Hổ | 1002 | Nộp event 11; +300 EXP, +30.000 lượng | W |
| 10→11 | Sùng Hắc Hổ, cấp ≥35 | 1002 (213/200) | Nhận Gỗ trầm hương (event 45) | W |
| 11→20 | Hoàng Phi Hổ | 1021 (231/185) | Nộp event 45; sách (7,59,128) | W |
| 20→24 | Hoàng Phi Hổ (cấp ≥45) → Lý Tịnh (1065) +1, Đặng Cửu Công (1016) +2 | | Báo tin | W/O |
| 24→25 | Hoàng Phi Hổ | 1021 | Đi đoạt ấn tín | W |
| 25→26 | **Giết Trấn Điện tướng quân** | ? | Ấn tín (event 12) | **X** |
| 26→27 | Hoàng Phi Hổ | 1021 | Nộp event 12 | W |
| 27→30 | Khương Tử Nha | 1020 (158/189) | Đao (0,0,30+i,4) | O |
| 30→31 | Dương Tiễn, cấp ≥55 | 1020 (165/185) | | W |
| 31→32 | **Giết Đông Hải thần long** | Đông Hải 1037–1041 | Râu Thần Long (event 13) | **X** |
| 32→40 | Hồ Hỷ Mị, cấp ≥55 | 1021 (205/184) | Bá Lạc nhãn (3,46) | W |

### 2.2 Đạo Sĩ (task 1, TaskNote 28)

| Bước | NPC / hành động | Bản đồ | Vật phẩm / thưởng | Runtime |
|---|---|---|---|---|
| 0→1 | Hoàng Long chân nhân, cấp ≥25 | 1003 (204/195) | Thư tiến cử (event 0) | O |
| 1→2 | Khương Tử Nha | 1020 | Nộp event 0; +300 EXP, +30.000 | O |
| 2→10 | Lôi Chấn Tử, cấp ≥35 | 1020 (163/187) | Khuyên hàng 3 tướng | O |
| 10→17 | Hoàng Phi Hổ +1, Lý Tịnh +2, Đặng Cửu Công +4 (thứ tự tùy ý) | 1021 / 1065 / 1016 | | W/W/O |
| 17→20 | Lôi Chấn Tử | 1020 | Sách (7,59,128) | O |
| 20→22 | Khương Tử Nha (cấp ≥45) → Hoàng Thiên Hóa | 1020 → 1021 (214/184) | Đi Bắc Hải | O/W |
| 22→23 | **Giết Bắc Hải thần oanh** | Bắc Hải 1006 | Event 1 | **X** |
| 23→24 | Thổ Hành Tôn | 1021 (213/184) | Nộp event 1 | W |
| 24→30 | Hoàng Thiên Hóa | 1021 | Kiếm (0,0,33,4) | W |
| 30→32 | Thổ Hành Tôn (cấp ≥55) → Hồ Hỷ Mị | 1021 | | W |
| 32→33 | **Giết Bất Tử thần mộc** | ? | Thần mộc (event 2) | **X** |
| 33→40 | Hồ Hỷ Mị | 1021 | Bá Lạc nhãn (3,46) | W |

### 2.3 Dị Nhân (task 2, TaskNote 29)

| Bước | NPC / hành động | Bản đồ | Vật phẩm / thưởng | Runtime |
|---|---|---|---|---|
| 0→1 | Hình Thiên, cấp ≥25 | 1004 (194/200) | | W |
| 1→2 | Hồ Hỷ Mị | 1021 | Thiếp mời (event 15) | W |
| 2→10 | Hình Thiên | 1004 | Nộp event 15; +300 EXP, +30.000 | W |
| 10→11 | Phong Lâm, cấp ≥35 | 1015 (192/212) | Dịch chuyển | W |
| 11→13 | Ngô Long → Chủ tửu điếm | 1015 → 1021 (227/195) | Canh tỉnh rượu (event 16) | W |
| 13→20 | Ngô Long | 1015 | Nộp event 16; sách (7,59,128) | W |
| 20→21 | Thường Hạo, cấp ≥45 | 1015 (206/195) | | W |
| 21→22 | **Giết Thương quân hiệu úy** | ? | | **X** |
| 22→30 | Thường Hạo | 1015 | Event 17; rìu (0,0,34,4) | W |
| 30→31 | Văn Thái Sư, cấp ≥55 | 1014 (193/208) | Nộp event 17 | O |
| 31→32 | Giết Kim Hà thú | 1016 | Event 18 | O |
| 32→33 | Đa Bảo đạo nhân | Bích Du cung 1042–1046 | Nộp event 18; Ma huyết (event 19) | **X** |
| 33→40 | Văn Thái Sư → Hồ Hỷ Mị | 1014 → 1021 | Bá Lạc nhãn | O/W |

### 2.4 Phần chung cả 3 phái (40→81)

| Bước | NPC / hành động | Bản đồ | Vật phẩm / thưởng | Runtime |
|---|---|---|---|---|
| 40→41 | Đắc Kỷ, cấp ≥65 | 1021 (220/179) | | W |
| 41→42 | Tây Vương Mẫu | 1052 (221/188) | | O |
| 42→43 | **Giết An Cư thú** | ? | An Cư đồ (event 3) | **X** |
| 43→50 | Tây Vương Mẫu | 1052 | Sách ngẫu nhiên | O |
| 50→51 | Thần Nông (Giáp Sĩ) / Hiên Viên (Đạo Sĩ) / Xi Vưu (Dị Nhân), cấp ≥55–70 | Viễn Cổ 1064 | | **X** |
| 51→52 | **Giết Tranh Nanh** | Khổn Tiên cung 1047–1051 | Thần Dụ Kính (event 4) | **X** |
| 52→60 | Thần Nông / Hiên Viên / Xi Vưu | 1064 | (3,41) + pháp bảo/vũ khí | **X** |
| 60→61 | Đắc Kỷ, cấp ≥75 | 1021 | Nộp vật phẩm phái; nhận Phong Thần bảng (event 9) | W |
| 61→62 | Khương Tử Nha | 1020 | | O |
| 62→63 | Võ Vương | 1020 (159/189) | Nộp event 4 | W |
| @63 | **Giết Tôn Vũ / Biển Thước / Can Tương tiền thế**, cấp ≥65 | ? | Event 6/7/8, task 42 = 7 khi đủ | **X** |
| 63→70 | Võ Vương | 1020 | Pháp bảo (0,4,14..17) | W |
| 70→71 | Tây Vương Mẫu, cấp ≥80 | 1052 | | O |
| 71→74 | Đắc Kỷ tương lai → Nguyên Thủy Thiên Tôn → **giết Đội trưởng lục soát** | 1063 / 1061 (suy luận) | Event 10 | **X** |
| 74→80 | Nguyên Thủy Thiên Tôn | 1061 | (3,41) + (6,1,34) | **X** |
| 80→81 | Đắc Kỷ thời trẻ, cấp ≥85 | ? | Nộp event 9, **kết thúc chuỗi** | **X** |

### 2.5 Danh sách còn thiếu để chạy trọn chuỗi
- **11 quái thiếu script khi chết:** 镇殿将军, 东海神龙, 北海神莺, 不死神木, 商军校尉, 安居兽, 狰狞, 孙武前世, 干将前世, 扁鹊前世, 搜索队长.
- **7 NPC chưa được đặt:** Đa Bảo đạo nhân, Thần Nông, Hiên Viên, Xi Vưu, Đắc Kỷ tương lai, Nguyên Thủy Thiên Tôn, Đắc Kỷ thời trẻ.
- **14 NPC chính tuyến bị bọc menu tạm (W).** Bỏ lớp menu này theo cách của tính năng 3.
- **Nhật ký F11** chỉ hiện "Task 27 - step N". Cách khắc phục xem tính năng 2 (dùng `taskinfo.ini`).
- **API chưa đăng ký nhưng không nằm trên đường chính tuyến:** `RepairTaskValue`, `DelHandItem`, nhóm sư đồ (`AddMasterPRValue`, `DoMasterPR`…).

## Phần 3: Hành động

| Thứ tự | Việc | Cách làm | Phụ thuộc |
|---|---|---|---|
| 1 | Bỏ lớp menu tạm cho 14 NPC chính tuyến | Tạo script `npc_fix` như tính năng 3 | Tính năng 3 xong |
| 2 | Gắn script khi chết cho 11 quái | Tìm vị trí xuất hiện; gắn DeathScript qua dữ liệu hoặc `SetNpcScript` từ cầu nối | Cần xác định quái có xuất hiện trên bản đồ không |
| 3 | Đặt 7 NPC còn thiếu | `AddNpc` từ `servertimer.lua` hoặc qua pipeline `NpcRestoration` | Cần tọa độ (chủ server xác nhận) |
| 4 | Chữ nhiệm vụ trong F11 | `PTTaskNote` + `taskinfo.ini` | Tính năng 2, giai đoạn 2 |
| 5 | Kiểm thử trọn chuỗi 3 phái | Dùng web admin nâng level, phát event item để test nhanh từng đoạn | Bước 1–3 |

Mức chắc chắn:
- **Đã kiểm chứng:** mã script lấy từ PAK, đối chiếu với runtime.
- **Suy luận:** bản đồ của các NPC Viễn Cổ, Tương Lai, Bích Du; và việc quái có xuất hiện hay không.

## Phần 4: Tài liệu tham khảo
- Dữ liệu trích: `%TEMP%\ptquest\` (`compact.txt` tóm tắt từng NPC, `scan*.txt` chứa mọi lệnh gọi `Get/SetTask(1|2|3)` và `TaskNote(27|28|29)`)
- Tọa độ NPC: `PhongThanSource\Deploy\ProjectContent\NpcRestoration\coordinates.json`
- Hội thoại: `\settings\StringResource.txt` (PAK client, 4.866 dòng)
- Vật phẩm nhiệm vụ: `\settings\item\001\questkey.txt` (event 0–19, 45)
- Tính năng liên quan: `hoi-thoai-npc-tan-thu-phong-than-20260928.md`, `he-thong-nhiem-vu-f11-phong-than-20260928.md`
