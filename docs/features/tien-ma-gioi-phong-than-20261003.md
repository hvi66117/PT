# Tiên Ma giới: bản đồ nội dung, giai đoạn 1–3 (Bất Chu Thiên Quan + Bất Chu Sơn, chủ tuyến bước 0–27)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent `tienma` (giai đoạn 1), `tienma23` (giai đoạn 2–3)
> Trạng thái: **Giai đoạn 1–3 đã triển khai lên runtime** (`Server\script\phongthan\tienma\*.lua`, `ext\tienma.lua`, 21 file, khớp byte với `scratchpad\tienma\out\`). Backup bản giai đoạn 1 ở `_backup\20261002-tienma23\`.
> Mô phỏng Lua 4: `qtest\sim_tienma23.lua` **96/96 đạt, 0 lỗi**, cả với giả lập stack engine (`emu`: 47 khung NPC/vật phẩm, 40 khung tick) và còn dư ≥ 15 khung. Scratch build ptfix (Client rồi Server) đạt: `scratchpad\tienma23\ptfix_test.pak` (615 mục), `tienma stubs added: 75/75`, `hexagram scripts added: 8/8`.
> ptfix mới **chưa** vào runtime: coordinator build chính thức để có stub GBK, 8 quẻ Bát Quái và Huyễn Quang Kính mới (Phần 3).

> **Hợp đồng bàn giao giai đoạn 3 → 4 (agent `tienma23` → `tienma45`):** biến chủ tuyến **2222**. Xong giai đoạn 3 (đã nhận thưởng Hỏa thần, F11 hiện Step_26) thì **2222 = 27**. NPC bước 28 của tienma45 nhận khi `GetTask(2222) == 27` và cấp ≥ 55, rồi ghi 28 + `TaskNote(86+GetPlayerType(), 28)`. Trạng thái thất bại Step_27 không dùng giá trị 27 (lưu ở biến phụ). Phe: biến 2252 (1 Tiên, 2 Ma). Chi tiết: `scratchpad\tienma\HANDOVER.md`. Đã đối chiếu: `tienma45\tm45_lib.lua` dùng `PT45_HAND_MIN = 27` và chỉ ghi ≥ 28 vào 2222.

## Phần 1: Tổng quan

### Insight chính
1. **Dải biến được giao gần như đã có chủ.** Quét toàn bộ script rời và mọi PAK: 2260–2279 bị hệ linh sủng "Phi Thăng" của VNG (`common\属性灵宠.luax`, `taskvalue = {2260,2261,2262}` …) và hộp quà dùng hết, chỉ còn **2263, 2278**. Giai đoạn 2–3 vì vậy **dồn trạng thái vào các chữ số thập phân** của 9 biến cũ + 2 biến trống (bảng 2.5). 2222 và 2252 giữ nguyên giá trị nguyên để tienma45 đọc.
2. **Script vật phẩm GBK "có sẵn" thật ra không chạy được.** 8 quẻ `item\卦卷\*.lua` và Huyễn Quang Kính `item\幻光镜.lua` chỉ là file rời tên tiếng Trung (engine không đọc được), không có trong PAK. Plug-in `extra_tienma.py` đưa 8 quẻ vào ptfix nguyên văn (thêm `pt_compat`) và **thay** Huyễn Quang Kính bằng bản viết lại (bản VNG so `GetWorldPos()` với số map VNG 1–65 trong khi runtime là 1000+N, và dùng `math.*`, `^`).
3. **Tọa độ VNG trong taskinfo dùng được nguyên.** Chúc Dung (1668/3753), Nữ Oa (1656/3769), Người Hái Thuốc (1624/3686), vật tổ Thiên Kiếp (251/208, 242/202), các NPC Bất Chu Sơn (Vô Ương Tử, Lộc Thần, Kim Tra…) đều nằm trên ô đi được, cùng vùng liên thông với doanh trại.
4. **Ma Lễ Thọ không đụng Đông Di.** Ma Lễ Thọ của Đông Di (tpl 773, 1606/3880) ở túi đất tây nam không nối với khu chính; Ma Lễ Thọ Tiên Ma đặt riêng cạnh doanh Ma (1603/3235). Ext Đông Di gắn script theo chỉ số NPC của chính nó, không quét theo tên nên hai NPC độc lập.
5. **Chơi một mình được hết.** Các bước VNG cần tổ đội/đồng bộ 2 người (Hà Đồ), PK phe (1033/1034) hay giờ Tý (1036) được rút gọn thành bước đơn (bảng 2.3, 2.4); chữ F11 vẫn là chữ taskinfo gốc.

### Đã làm
| Giai đoạn | Nội dung | Kết quả cho người chơi |
|---|---|---|
| 1 (đã có) | Đường vào, chủ tuyến 0–7, 1024, 1025, 89, ngày 93/94 | Như bản trước; biến được chuyển sang trường thập phân, tương thích dữ liệu cũ |
| **2** (1073) | Chủ tuyến **8–19 Liên Hoa Thần Đăng** (Tiên 8–13, Ma 15–19 → 13 → 14), 96, 97, 1023/1028, 1026, 1027, 1030 (NPC ở 1074), 1042, 1043, 92 | 29 NPC + 36 đối tượng (12 đèn, 16 đóa hoa, 8 Linh Thạch) + 6 Khâm Nguyên; đặt Xích Tinh Tử, Cao Giác, Chúc Dung, Nữ Oa, Ma Lễ Thọ |
| **3** (1074) | Chủ tuyến **20–27** (Hỏa thần/Thủy thần, Thiên Niên Đại Thạch → Thạch Quái), 99/100, 103, 1031–1034, 1036, 1037, 1040/1041 | 23 NPC + 33 quái; Tu Hành Sư 1074 đưa sang Ngục Pháp Sơn khi 2222 ≥ 27 |

## Phần 2: Chi tiết

### 2.1 Bản đồ nội dung Tiên Ma giới (từ taskinfo + dữ liệu còn lại)
| Map (runtime / VNG) | Chủ tuyến 86–88 | Nhiệm vụ phụ / ngày | NPC chính (template) | Quái (template) |
|---|---|---|---|---|
| **1073 Bất Chu Thiên Quan** (73) | Bước 0–19 | 89, 92, 93/94, 95, 96, 97, 98, 1021/1022, 1023/1028, 1024, 1025, 1026, 1027, 1030, 1042, 1043 | Tu Hành Sư 765, Đắc Kỷ 164, Xích Tinh Tử 764, Cao Giác 774, Mộc Tra 763, Ma Lễ Thọ 773, Huyền Đô 779, Nữ Oa 780, Chúc Dung 781, Cửu Thiên Huyền Nữ 837, Liên Đăng Hộ Sứ 822 | Phi Thố 739, Trạnh/Nanh 740/741, Ưu Trùng 808, Khâm Nguyên 743/783, Ly Châu 744/745, Phong Thú Sơn Hồn 750/751, Liên Đăng Sứ Giả 821, Nguyên Thần 823–836 |
| **1074 Bất Chu Sơn** (74) | Bước 20–27 | 99/100, 102, 103, 1031–1034, 1036, 1037, 1040/1041 | Hỏa thần 856, Thủy thần 857, Lộc Thần 1047, Vô Ương Tử 842, Hồng Lư 850, Nam Minh Tử 843, Ly Cấu 849, Sơn Thần Hồng Bác 860 | Sói 746/885, Phong Yêu 748/749, Huyết Yêu 747, Thạch Quái 877, Thiên Yết 1059/1060, La Hầu 927, Sí Nha 921 |
| **1075 Ngục Pháp Sơn** (75) | Bước 28–46 (tienma45) | 104–113, 118, 119, 1077, 1078, 1080, 1082–1085 | Yển Thúc Di 1009, Yển Bá Ích 1008, Mật thám 1013/1014, Tứ Bất Tướng | Cự Thú 1046 |
| **1076 Thánh Địa** (76) | Bước 47–50 (tienma45) | 115/116, 1086–1089, 1097/1098 | Tu Hành Sư, Dược Sư, Khương Ngu Tích, Cơ Huyền Phong | Ninh Vương, Lang Vương |

- `taskinfo.ini` dùng số map VNG (73 = Bất Chu Thiên Quan…); tên chữ Hán trong `WorldSet.ini` chỉ là thư mục địa hình dùng lại (1073 = 佳梦关, 1074 = 狱法山).
- "Cấp Tiên Ma" = cấp nhân vật (`GetPlayerExtLevel()` compat), nên các mốc 15/30/45/55 mở ngay với nhân vật cấp 85+.

### 2.2 Chủ tuyến giai đoạn 2 (1073, Liên Hoa Thần Đăng)
| 2222 | F11 | Ai | Việc |
|---|---|---|---|
| 7 → 8 / 15 | Step_8 / Step_15 | Đắc Kỷ (cấp ≥ 30) | Phe Tiên → 8, phe Ma → 15 |
| 8 → 9 (Ma 15 → 16) | Step_9 / 16 | Liên Đăng Hộ Sứ của phe (Tiên: placeholder 1932/3656; Ma: 1652/3262) | Nhận việc thắp 6 ngọn đèn |
| 9/16 | — | 6 **Liên Hoa Thần Đăng** (tpl 819) quanh Hộ Sứ của phe | Mỗi ngọn bấm 1 lần; đèn phe kia và đèn đã thắp không tính |
| 9/11 → 10 (Ma 16/18 → 17) | Step_10 / 17 | Hộ Sứ, đủ 6 đèn | Gọi **Liên Đăng Sứ Giả** (821, cấp 80, 5 phút) |
| 10 → 11 (Ma 17 → 18) | Step_11 / 18 | Hộ Sứ, khi Sứ Giả đã biến mất | Thất bại: đèn tắt hết, thắp lại |
| 10 → 12 (Ma 17 → 19) | Step_12 / 19 | Giết Sứ Giả | |
| 12/19 → 13 | Step_13 | Hộ Sứ | Biết Phong Thần bảng ở Bất Chu Sơn |
| 13 → **14** | Step_14 | Đắc Kỷ | 300.000 tu luyện + 30.000 lượng |

### 2.3 Nhiệm vụ phụ giai đoạn 2
| Nhiệm vụ | NPC (vị trí) | Cách làm (đã rút gọn nếu cần) | Thưởng |
|---|---|---|---|
| 96 Bất Diệt Đăng (cấp 22) | Liên Đăng Hộ Sứ (cả 2 phe) | Trồng ấu ở **Liên Tọa** (874, 1946/3690) → Hộ Sứ (Không Trung Hỏa) → Nữ Oa (Thạch Trung Hỏa) → **Thợ Đồng** (777, doanh Tiên; Mộc Trung Hỏa) → Hộ Sứ (Tam Muội Hỏa) → **Kim Hà Đồng Tử** (đứng cạnh Hộ Sứ thay cho Ngọc Hư Cung) → Hộ Sứ hợp Nhân Gian Hỏa → thắp Liên Tọa → đối thoại | 600.000 + 60.000 |
| 97 Bát Quái Luân Hồi (3 lần/ngày) | Chúc Dung (209/235) | Rút ngẫu nhiên 1 Quái quyển (6,1,447–454), nhấp chuột phải mở (script VNG, biến 1340/1341); mở không được thì Chúc Dung mở hộ. Càn: 15 Phi Thố châu (50%/Phi Thố); Đoài: 5 hồn Trạnh Nanh; Ly: 10 Mạn Châu Sa; Chấn: 10 Mạn Đà La; Tốn: Người Hái Thuốc gọi Thực Dược Thú; Khảm: 30 Phi Thố; Cấn: diệt Khâm Nguyên (25%) gọi ra Ma Khâm Nguyên (Sơn); Khôn: 10%/Khâm Nguyên | cấp × 3.000 + 10.000 |
| 1023 / 1028 Song Sinh Bỉ Ngạn (ngày) | Tu Hành Sư Tiên / Ma | Hái 8 đóa (Tiên: Mạn Đà La 792; Ma: Mạn Châu Sa 793) ở 8 bóng cây; mỗi đóa tính 1 lần mỗi lượt | 300.000 + 20.000 |
| 1026 Hô Tiên Hoán Ma (6 vòng/ngày) | Nữ Oa (207/235) | Tiên mở **Hô Ma Tháp** (791) → 6 Phi Thố Ma; Ma mở **Hô Tiên Tháp** (790) → 6 Hung Tiên (3 phút); hết giờ thì mở lại số còn thiếu | cấp × 2.500 + 10.000 |
| 1027 Thiên Kiếp (ngày) | Cửu Thiên Huyền Nữ (placeholder 1996/3256) | Vật Tổ Tiên Kiếp (251/208) / Ma Kiếp (242/202) → 7 Nguyên Thần lần lượt (823…829 / 830…836) | 500.000 + 30.000 |
| 1042 Vạn Cảnh Viên (cấp 23) | Chúc Dung | Huyễn Quang Kính (6,1,483): nhấp phải xem cảnh (tên, map, tọa độ), đến đúng chỗ dùng lại; 7 cảnh trên 18 map thành | 800.000 + 50.000 |
| 1043 Hà Đồ Huyền Cảnh (cấp 28) | Người Hái Thuốc (203/230) | 8 **Linh Thạch** (946–949) theo thứ tự 1→8, mỗi khối phóng 1 Long Mã → **Huynh Đệ Người Hái Thuốc** (950, 227/216) | 500.000 + 30.000 |
| 92 Trư Lung Thảo (cấp 18) | **Đại Phu** (766, mỗi doanh 1 người) | Nói chuyện 9 người theo danh sách phe (F11), mỗi người 1 lần → 5 Trùng Hồn (40% khi diệt Trạnh Nanh) → Hộ Pháp Lục Giáp trận (215/237, Tiên) / Ngũ Hành trận (242/201, Ma) → Đại Phu | 600.000 + 40.000 |

- NPC trong danh sách 92: Tiên = Xích Tinh Tử, Tào Bảo (placeholder), Thủ Khố, Tu Hành Sư, Tiêu Thăng, Mộc Tra, Tiếp Dẫn, Bạch Hạc, Thanh Hư; Ma = Cao Giác, Tiếp Dẫn, Thủ Khố, Tu Hành Sư, Ma Lễ Thọ, Linh Nha, Ô Vân, Di Đầu, Kim Quang. Lần nói chuyện đầu dùng cho Trư Lung Thảo, lần sau trở về hội thoại thường.

### 2.4 Chủ tuyến và nhiệm vụ phụ giai đoạn 3 (1074 Bất Chu Sơn)
| 2222 | F11 | Ai | Việc |
|---|---|---|---|
| 14 | Step_14 | Tu Hành Sư 1073 (cấp 45) | "Đến Bất Chu Sơn" → doanh Tiên 1726/3572 hoặc Ma 1654/3540 |
| 14 → 20 | Step_20 | Tu Hành Sư 1074 (placeholder 1724/3560, 1652/3528) | Tìm Hỏa Thần (1800/3560) và Thủy Thần (1830/3580) |
| 20 → 21 | Step_21 | Nhận pháp lực của cả hai thần | |
| 21 → 22 | Step_22 | Thiên Niên Đại Thạch (876, 1988/3612) | Thạch Quái (877, cấp 82, 249/226) xuất hiện 5 phút |
| 22 (thất bại) | **Step_27** | Thạch Quái biến mất | Cờ thất bại; 2222 giữ 22; một trong hai thần nhập lại pháp lực → 21 |
| 22 → 23 | Step_23 | Giết Thạch Quái | |
| 23 → 24 → 25 | Step_24, 25 | Hỏa Thần bảo gặp Thủy Thần trước; Thủy Thần thưởng 400.000 | (gặp Thủy Thần ngay ở 23 cũng được) |
| 25 → **27** | **Step_26** | Hỏa Thần | 400.000 + 40.000; **bàn giao tienma45** |

| Nhiệm vụ | NPC | Cách làm | Thưởng |
|---|---|---|---|
| 99 / 100 Ngũ Sắc Hồn (5 vòng/ngày) | Vô Ương Tử (Tiên) / Hồng Lư Đơn Khách (Ma) | Diệt Sói, Sói Chúa, Phong Yêu: 50% ra Thạch Hồn, tối đa 5 | cấp × 400 × số viên (tu luyện) |
| 103 Thiên Yết Vi Hại (ngày) | Lộc Thần (240/201) | Thiên Yết (240/227) → 3 phân thân → Thiên Yết hồi sinh; mất dấu thì Lộc Thần ép hiện hình lại | 600.000 + 30.000 |
| 1031 Lĩnh Mệnh Quy Chân (cấp 30) | Tu Hành Sư 1074 | Thiết Quán → Bần Minh → Nam Minh Tử (Tiên) / Ly Cấu (Ma) → Tu Hành Sư (200.000) → cấp 31: 5 Phong Yêu → Tu Hành Sư | 200.000 + 300.000 |
| 1032 Âm Dương Chi Đạo (cấp 36) | Nam Minh Tử (Tiên) / Ly Cấu (Ma) | 30 Sói → phục mệnh (300.000) → cấp 37: 3 Sói Chúa → phục mệnh | 300.000 + 400.000 |
| 1033 / 1034 Vật tư chiến bị (ngày) | Phù Bật Đạo Nhân (Tiên) / Lý Hưng Bá (Ma) | Thay PK phe: 10 Phong Yêu của phe địch (Tiên diệt Phong Yêu (Ma) 749, Ma diệt 748) | 400.000 + 30.000 |
| 1036 Thiên Hành Thuận Nghịch (cấp 42) | Sơn Thần Hồng Bác (placeholder 1676/3192) | 40 Phong Thú Sơn Hồn phe địch (không giới hạn 30 phút) → 500.000 → cấp 43: luyện đơn, 5 Sí Nha (921) kéo tới → nhận đơn | 500.000 + 600.000 |
| 1037 Bách Xuyên Huy Tụ (cấp 46) | Dương Nhậm (Tiên) / Hồng Lư (Ma) | Khống chế 1 trong 3 Kình Thiên Tháp → hóa thân Đại Uy Thiên Long (1 phút) → Thiên Nhạc Hộ Pháp Trưởng Lão (đài phía bắc) → báo lại → cấp 47: diệt **La Hầu** (927, cấp 85, 205/207) | 700.000 |
| 1040 / 1041 Trùng Quy Tiên/Ma Vị (4 vòng/ngày) | Kim Tra (Tiên) / Dương Sâm (Ma) | Diệt Huyết Yêu → Ly Trần Trận → vào ảo ảnh cảnh (1 trong 4 ảo ảnh 980–983, 3 phút) → phục mệnh | cấp × 3.000 + 10.000 |
| 1030 Linh Quang Sạ Hiện | Thiên Toán Tử (1074, 1700/3600) | Diệt 1 Nanh (1073), 1 Phong Yêu, 1 Sói → 3 Hồn Châu | 400.000 + 30.000 |

### 2.5 Biến nhiệm vụ (trường thập phân, chữ số d0 = hàng đơn vị)
| Biến | Trường |
|---|---|
| **2222** | Chủ tuyến (giá trị nguyên): 0 chưa nhận, 1–7 giai đoạn 1, 8–19 Liên Hoa Thần Đăng, 14 xong giai đoạn 2, 20–25 Bất Chu Sơn, **27 = xong giai đoạn 3**; ≥ 28 của tienma45 |
| **2252** | Phe (giá trị nguyên): 1 Tiên, 2 Ma |
| 2223 | d0 1024 · d1–2 96 · d3 1042 · d4 1043 trạng thái · d5 1043 đếm · d6 1037 · d7 1030 trạng thái · d8 1030 mặt nạ Hồn Châu |
| 2258 | d0 1025 · d1–2 mặt nạ 6 đèn · d3 chủ tuyến phụ (1 Hỏa, 2 Thủy, 4 thất bại) · d4 1031 · d5 1031 đếm · d6 1032 · d7–8 1032 đếm |
| 2242 | d0 89 · d1 92 · d2–4 92 mặt nạ 9 người · d5 92 Trùng Hồn · d6 1036 · d7–8 1036 đếm |
| 2254 | d0–1 Ưu Trùng (1024) · d4–8 mặt nạ 16 đóa hoa |
| 2256 | d0–1 Phi Thố (1025) · *ngày:* d2 1040 vòng · d3 1040 · d4 1023/1028 · d5 1023/1028 đếm |
| 2259 | d0–4 chỉ số NPC triệu hồi gần nhất |
| 2263 | *ngày:* d0 97 vòng · d1 1026 vòng · d2 1026 · d3 1026 đếm · d4 1027 · d5 1027 đếm · d6 99/100 vòng · d7 99/100 · d8 Thạch Hồn |
| 2278 | d0–3 dấu ngày (MMDD) · *ngày:* d4 103 · d5 103 đếm · d6 1033/1034 · d7–8 đếm |
| 2245 | Ngày 93/94 (không đổi) |
| 1340 / 1341 / 1384 | Biến VNG của chính vật phẩm nhiệm vụ: quẻ Bát Quái (97) và Huyễn Quang Kính (1042) |

- Sang ngày mới: lần đọc trường "ngày" đầu tiên xóa 2263, chữ số ngày của 2256 và 2278 rồi ghi dấu ngày mới. Giá trị lớn nhất mỗi biến < 1,2 tỷ (dưới giới hạn 2^31).
- Dữ liệu giai đoạn 1 cũ (giá trị nhỏ ở hàng đơn vị) vẫn đọc đúng.

### 2.6 NPC, đối tượng và quái (ext\tienma.lua, mỗi phút)
- **Tiếp nhận placeholder** (đúng template và ô, chỉ đổi tên + script): 1073 Tu Hành Sư ×2, Đắc Kỷ, **Liên Đăng Hộ Sứ** (822), **Cửu Thiên Huyền Nữ** (837), **Tào Bảo** (759); 1074 **Tu Hành Sư ×2**, **Sơn Thần Hồng Bác** (860).
- **Không đụng:** Huyền Đô placeholder ở túi tây nam, Ngô Chân Nhân 1074, toàn bộ NPC Đông Di, mọi placeholder 1075–1076.
- **Đặt mới:** 100 NPC/đối tượng thoại (kể cả 12 đèn, 16 đóa hoa, 8 Linh Thạch, 3 Kình Thiên Tháp) và 71 quái giữ sống (32 cũ + 6 Khâm Nguyên ở 1073 + 33 ở 1074: 8 Sói, 2 Sói Chúa, 8 Phong Yêu, 6 Huyết Yêu, 8 Phong Thú Sơn Hồn, 1 La Hầu), quái mang `GetNpcParam(npc,1) = 7701`.
- Mọi ô kiểm tra bằng lưới Region_S (`positions2.py`): đi được, cùng vùng liên thông với doanh trại, cách nhau ≥ 2 ô.
- **Triệu hồi** (loại 7702–7716): gắn `mob_kill.lua`, chủ = người gọi, tự xóa 1 giây sau khi chết hoặc khi hết giờ; hóa thân Đại Uy Thiên Long là NPC thoại triệu hồi (script `npc_bcs2.lua`, có `Timeout`).
- Dữ liệu ext viết một lệnh cho mỗi bản ghi (`PTTM_N`, `PTTM_M`) để không vượt stack 120 ô.

### 2.7 ptfix (`scratchpad\ptfix\extra_tienma.py`)
1. 64 stub đường dẫn VNG `\script\不周天关\*.lua`, `\script\不周山\*.lua` → `Include` script rời tương ứng (danh sách do `mk_tienma.py` ghi vào `tienma\pak\stubs.json`).
2. 11 death script: 6 cũ + `噬狼`, `仙·风妖`, `魔·风妖`, `仙·钦原`, `魔·钦原` → `PTTM_OnKill`; bỏ qua quái/triệu hồi 7701–7799.
3. **Thay** `\script\item\幻光镜.lua` (Huyễn Quang Kính) bằng `tienma\pak\item_huanguang.lua`.
4. 8 quẻ `\script\item\卦卷\{乾,兑,离,震,巽,坎,艮,坤}.lua` chép từ file rời vào ptfix (thêm `pt_compat`).
- **Thứ tự:** phải chạy trước `extra_tienma45.py` (plug-in đó bọc stub 戾/狰/仙·钦原/魔·钦原 đang có trong `ctx["entries"]`); thứ tự tên file đã đảm bảo.

### 2.8 Mô phỏng
| Lần chạy | Kết quả |
|---|---|
| `sim_tienma23.lua` (stack thường, bản out) | 96/96 OK, 0 lỗi |
| `sim_tienma23.lua -Args1 emu` (giả lập stack engine 47/40) | 96/96 OK, 0 lỗi, headroom vào hàm 44–46 / tick 37 |
| `-Args1 "emu5/10/15"` (bớt 5/10/15 khung) | 96/96 OK; bớt 20 khung mới tràn → dư ≥ 15 khung |
| `-Args1 "runtime emu"` (đọc file đã triển khai) | 96/96 OK |
| `-Stack 100` thuần | 94/96 (8 lần "stack overflow" ở LastDamage); harness chạy sâu hơn engine 15–30 khung nên kết quả này phóng đại, xem `sim_nb2emu.lua` |
| `sim_tienma.lua` (giai đoạn 1, cập nhật số đếm ≥) | 40/40 OK |
| Hồi quy `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `t_st` | Chạy xong, 0 FAIL, kết quả trùng byte với lần chạy trước |

- Kiểm tra trọng điểm: bàn giao 2222 = 27 + F11 Step_26; thất bại Thạch Quái hiện Step_27 và nhập lại pháp lực; Sứ Giả bỏ đi → đèn tắt; đèn phe kia không tính; quẻ Càn qua đúng script vật phẩm VNG; Huyễn Quang Kính mới ghi đủ 7 cảnh; 9 người Trư Lung Thảo, lần nói thứ hai trở về hội thoại thường; sang ngày mới các nhiệm vụ ngày mở lại, 2222 không đổi; death stub `噬狼` lấy từ `ptfix_test.pak` đếm Sói sinh tự động, bỏ qua Sói của đàn.

## Phần 3: Hành động

### Triển khai
- [x] Script rời đã chép vào runtime bằng `python mk_tienma.py --deploy` (backup 10 file giai đoạn 1 vào `_backup\20261002-tienma23\script\...`).
- [ ] **Coordinator:** build ptfix chính thức (plug-in `extra_tienma.py` đã cập nhật). Thiếu bước này thì NPC vẫn chạy (script rời), nhưng **quẻ Bát Quái mở bằng chuột phải và Huyễn Quang Kính chưa dùng được** (Chúc Dung vẫn mở quẻ hộ được), quái sinh tự động trên 1074 chưa được tính.
- [ ] `servertimer.lua` không cần sửa (`PTAdm_ExtOne("tienma")` đã gọi `PTEXT_tienma_Tick()` mỗi phút).
- [ ] Người dùng khởi động lại server theo cách thường lệ.

### Checklist kiểm thử trong game
- [ ] Đắc Kỷ (244/206) khi 2222 = 7: chọn "Đi tìm Liên Đăng Hộ Sứ" → phe Tiên F11 Step_8, phe Ma Step_15.
- [ ] Liên Đăng Hộ Sứ Tiên (241/228) / Ma (206/203): nhận việc, thắp 6 ngọn Liên Hoa Thần Đăng quanh đó, gọi Sứ Giả, giết → báo Hộ Sứ → Đắc Kỷ → F11 Step_14.
- [ ] Để Sứ Giả hết 5 phút → nói với Hộ Sứ → F11 "thắp sáng lại", đèn phải thắp lại.
- [ ] Tu Hành Sư → "Đến Bất Chu Sơn" (cấp 45) → Tu Hành Sư 1074 → Hỏa Thần + Thủy Thần → Thiên Niên Đại Thạch → giết Thạch Quái (249/226) → Hỏa Thần → Thủy Thần → Hỏa Thần → F11 "Sau cấp 55… Ngục Pháp Sơn"; Tu Hành Sư 1074 có "Đến Ngục Pháp Sơn".
- [ ] Để Thạch Quái chạy mất → F11 "Nhiệm vụ thất bại!…" → xin nhập lại pháp lực.
- [ ] Chúc Dung (209/235): rút quẻ, nhấp phải mở (sau khi có ptfix mới), giải, nhận thưởng; quá 3 quẻ/ngày bị từ chối.
- [ ] Nữ Oa, Cửu Thiên Huyền Nữ, Người Hái Thuốc, Đại Phu, Tu Hành Sư (hái hoa): làm đủ mỗi nhiệm vụ một lần.
- [ ] Bất Chu Sơn: Vô Ương Tử/Hồng Lư, Lộc Thần, Nam Minh Tử/Ly Cấu, Phù Bật/Lý Hưng Bá, Sơn Thần, Dương Nhậm, Kim Tra/Dương Sâm, Thiên Toán Tử.
- [ ] Báo lại nếu NPC/quái đứng chỗ không tới được, triệu hồi không biến mất sau khi chết, hoặc F11 hiện sai bước.

### Việc còn lại
| Hạng mục | Ghi chú |
|---|---|
| Giai đoạn 4–5 (1075, 1076) | Agent `tienma45`, bàn giao ở 2222 = 27 (đã đối chiếu code) |
| 95, 102 (tổ đội 5), 98 Minh Di 19–23h, 1021/1022 Chiến Kỳ | Cần cờ phe PK, lịch giờ |
| 1033/1034 bản PK phe gốc, 1036 giới hạn 30 phút + giờ Tý, Hà Đồ đồng bộ 2 người | Đã rút gọn để chơi một mình |
| Ngũ Sắc Thạch / Ngọc Tinh (vật phẩm thưởng VNG chưa rõ mã) | Thay bằng tu luyện/lượng |
| Cấp Tiên Ma riêng (tách khỏi cấp nhân vật) | Cần C++ |

## Phần 4: Tài liệu tham khảo
- **Mã nguồn sinh** (`scratchpad\tienma\`): `lua_src.py` (giai đoạn 1 + tm_lib), `lua_src2.py` (giai đoạn 2–3, Huyễn Quang Kính), `mk_tienma.py` (TCVN3, ext, `--deploy` có backup), `positions.py`/`positions2.py` → `positions.json`/`positions2.json`, `HANDOVER.md`, `p2\varscan.py` (quét biến loose + PAK), `taskinfo_tm.txt`.
- **Plug-in:** `scratchpad\ptfix\extra_tienma.py`; file PAK sinh ra: `scratchpad\tienma\pak\`; scratch build `scratchpad\tienma23\ptfix_test.pak` (+ `ptfix_test_client.pak`).
- **Mô phỏng:** `scratchpad\qtest\sim_tienma23.lua` → `out_tienma23*.txt`; `tm23_stub_death.lua` (stub lấy từ PAK thử); `sim_tienma.lua` (giai đoạn 1).
- **Engine:** `KNpc.cpp` 1718 (LastDamage), 848 (Timeout); `KPlayer.cpp` 7546 (`main(nNpcIndex)` của NPC thoại); `ScriptFuns.cpp` 10983 (`GetVngNormalTuple`: HaveNormalItem so cả cấp vật phẩm), 4056 (`AddNpc` 6 tham số).
- **Liên quan:** `su-do-dong-di-phong-than-20261003.md` (Đông Di cùng map 1073), tài liệu giai đoạn 4–5 của `tienma45`, `kiem-toan-nhiem-vu-phong-than-20261002.md`.
