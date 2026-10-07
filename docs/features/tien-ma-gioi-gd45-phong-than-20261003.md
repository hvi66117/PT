# Tiên Ma giới giai đoạn 4–5: Ngục Pháp Sơn (bước 28–46) và Thánh Địa (bước 47–50), 22 nhiệm vụ phụ

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent `tienma45`
> Trạng thái: **Đã triển khai script rời lên runtime** (`Server\script\phongthan\tienma45\`, `ext\tienma45.lua`). Plug-in ptfix `extra_tienma45.py` đã build thử thành công, **chờ coordinator gộp vào lần build ptfix chính thức**.
> Mô phỏng Lua 4: 81/81 kiểm tra đạt ở cả 3 chế độ (`-Stack 100`, giả lập stack engine 47/40 khung, đọc file runtime). Stub PAK: 8/8 đạt.

## Phần 1: Tổng quan

### Insight chính
1. **Bàn giao từ giai đoạn 3 theo đúng hợp đồng `S\tienma\HANDOVER.md`.**
   - Bắt đầu bước 28 khi `2222 >= 27` và cấp ≥ 55, tại Tu Hành Sư ở Ngục Pháp Sơn.
   - Tiến độ lưu ở biến riêng `2283` và **ghi gương sang `2222`** (28 → 50). Chỉ tienma45 ghi giá trị ≥ 28; script giai đoạn 1–3 coi mọi giá trị ≥ 27 là "đã xong".
2. **Dải biến 2280–2309 không sạch hoàn toàn.** Quét loose + mọi PAK thấy VNG dùng:
   - 2280–2282, 2289–2291, 2293, 2294: bảng linh sủng Phi Thăng (`属性灵宠.luax`);
   - 2285, 2286: quà hồi quy (`常用活动.luax`, `回归礼包.lua`).
   - tienma45 chỉ dùng **20 biến trống**: 2283, 2284, 2287, 2288, 2292, 2295–2309. Thêm 1465/1466 là biến La Bàn gốc của VNG cho Giải chú phù.
3. **Vật phẩm chính là vật phẩm thật của VNG**, script được viết lại:
   - Giải chú phù `6/1/518`: file `\script\item\解咒符.lua` tên GBK, không đọc được dạng loose, nên đưa stub vào ptfix.
   - Hà Đồ Lạc Thư `6/1/529`: `\script\item\hetuluoshu.lua` gốc dùng hàm Lua 5 và biến 1489/1490. Đã sao lưu bản gốc rồi thay bằng stub (cả loose lẫn ptfix).
   - Dẫn Tuyền Châm `6/1/575`.
   - Các vật phẩm khác (Lăng Nguyên Châu, Phong ấn Kính, Thanh Hoa tửu…) là trạng thái nhiệm vụ, không tạo vật phẩm.
4. **Chơi một mình được hết.**
   - Bỏ điều kiện tổ đội của 111; thay PvP của 1089 bằng Chiến Hồn triệu hồi.
   - Bỏ đồng hồ đếm giờ và khung giờ 18–24h, bỏ yêu cầu danh vọng 180.000.
   - NPC và quái do ext tick đặt và giữ sống mỗi phút. Đi theo tổ đội vẫn được tính quái cho cả đội.

### Kết quả
| Hạng mục | Số lượng |
|---|---|
| NPC thoại | 68 (12 tiếp nhận placeholder, 56 đặt mới) |
| Quái nhiệm vụ | 52 (7 đàn + 4 quái đơn: Ngục Pháp Thần, Ninh Vương, Lang Vương, Triết Phục) |
| Chủ tuyến | Bước 28–50 |
| Nhiệm vụ phụ / ngày | 104–113, 115/116, 118, 119, 1077, 1078, 1082–1089, 1097/1098 |

## Phần 2: Chi tiết

### 2.1 Chủ tuyến 86/87/88
| Bước | NPC / hành động | Biến |
|---|---|---|
| 28 | Tu Hành Sư 1075 (Tiên 230/223, Ma 235/209): nhận | 2283 = 28, 2222 = 28 |
| 29 | **Tứ Bất Tướng** (215/227) trao Giải chú phù 6/1/518 | 1465 byte1 = 2 |
| 30 | Dùng Giải chú phù trong La Bàn trận pháp (đa giác VNG quanh làng, ≈233/214): thất bại | byte1 = 3 |
| 31–33 | Tứ Bất Tướng sinh mật mã ngẫu nhiên. Hỏi 4 Pháp trụ: Bắc 252/199, Đông 263/238, Nam 200/235, Tây 203/200 | word2 = mật mã, 1466 = mặt nạ |
| 33→34 | Xoay 4 La Bàn (Bắc 234/212, Đông 238/214, Nam 232/217, Tây 229/215) theo mật mã | 1466 = góc xoay |
| 35 | Dùng phù, Cự Thú (1046) xuất hiện | byte1 = 7 |
| 36 / 37 | Hạ Cự Thú được 36. Cự Thú biến mất mà dùng lại phù thì sang 37: mật mã mới, hỏi lại Pháp trụ | byte1 8 / 4 |
| 38→39 | Tứ Bất Tướng thưởng, thu phù. Diệt 30 yêu ma Ngục Pháp Sơn (mọi quái trên 1075) | 2300 đếm |
| 39→41 | Cổng thời gian (231/216) đưa tới Khương Tử Nha lúc nhỏ (199/218), nhận Hà Đồ Lạc Thư 6/1/529 | |
| 43→44 | Dùng Hà Đồ trong trận pháp. Tu sửa Pháp trụ đúng thứ tự Bắc → Đông → Nam → Tây (sai thứ tự bị từ chối) | 2300 = thứ tự |
| 45 | Tại Tứ Bất Tướng: triệu và hạ hậu nhân Phục Hy (1143) | |
| 46 | Tu Hành Sư: bái biệt, thu Hà Đồ, nhận 1,5 triệu kinh nghiệm. Có lựa chọn đưa sang Thánh Địa | |
| 47 | Tu Hành Sư Thánh Địa (Tiên 247/238, Ma 205/202), cấp 75: nhận Dẫn Tuyền Châm 6/1/575. Hạ Thiên Niên Ninh Vương và Lang Vương (213/227), dùng châm gọi Vạn Trảo Thú (1230) | 2309 bit máu |
| 48→49→50 | Giao Ngọc Bội (2 triệu). Cấp 80 hỏi lại thì xong (3 triệu) | 2222 = 50 |

### 2.2 Nhiệm vụ phụ Ngục Pháp Sơn (1075)
| Nhiệm vụ | NPC | Cách làm (đơn giản hóa) | Biến |
|---|---|---|---|
| 104 Phù Hoa Độc (cấp 50) | Yển Phong 200/238 | Hái Độc Lan Thảo 207/205 và Long Thiệt Lan 248/232. Pha thuốc ở Nước suối 232/219 rồi giao. Điều tra Mật thám Ma, sau đó Mật thám Tiên | 2287 |
| 105–108 Mật thám (cấp 51–59) | Mật thám phe mình (Tiên 241/226, Ma 224/209) | **105:** Hám Long Phiên ở Pháp trụ, hạ Thủ Hộ Thú.<br>**106:** Yển Tử Minh → Thanh Hoa tửu → Huyền Thạch 261/203.<br>**107:** khiêu chiến Mật thám phe kia (1104/1105).<br>**108:** Khiếu Lôi 261/208, phong ấn hồn Thiết Tinh/Lê Linh Thi/Sơn Hầu, cấp 60 thả và hạ Khiếu Lôi (1108) | 2288 |
| 109–111 tộc Yển (cấp 57–65) | Yển Bá Ích / Yển Thúc Di (làng 233–235/214) | **109:** diệt 10 yêu ma, tìm Tộc nhân mất tích 263/231.<br>**110:** 10 Sơn Hầu, bảo vệ nghi thức ở Tinh quân điêu tượng 243/220 (4 yêu ma).<br>**111:** Phá Giới Thạch Đài 260/222, hạ 3 hóa thân rồi Ngu Cương | 2292 |
| 112/113 Sa La Song Thụ (cấp 65–70) | Yển Bá Ích (112) / Yển Thúc Di (113) | **Ở 1075:** Phù Du Tử 254/238 / Thanh Vân Khách 242/199, 10 Thương Long Giác (Lê Linh Thi), gặp lại ở 239/228 / 224/211.<br>**Ở 1076:** nhận Thụ Tâm, trồng Sa La Song Thụ 225/217, hạ Thụ Hồn | 2295 |
| 118 Đổ Vật Sinh Tình | Yển Vân 237/215 | 1 Thiết Tinh → Long Xà Thảo → 5 yêu ma → di vật | 2296 |
| 119 Diệt trừ hậu họa | Yển Bá Ích → Yển Tử Minh 237/213 | Hạ Ngục Pháp Thần (boss thế giới 256/231) | 2301 |
| 1077 / 1078 (lặp lại) | Yển Phong ↔ Yển Bá Ích | 5 Thiết Tinh (Lê Linh Thi) gọi Đại Vương (Phù Chú), có thể gọi lại | 2297 |
| 1082 (Tiên) / 1083 (Ma), lặp lại | Yển Thúc Di / Yển Tử Minh | Hạ Tộc nhân bị mê hoặc (đàn 220/229), tối đa 5 hồn, 40.000 mỗi hồn | 2298 |
| 1084 / 1085 (lặp lại) | Yển Thúc Di | 12 tượng Tinh quân quanh bản đồ (thứ tự theo ngày). 1084 đánh thức 1 tượng, 1085 đánh thức 6 tượng đúng thứ tự, rồi diệt 10 yêu ma hồi pháp lực | 2299 |

### 2.3 Thánh Địa (1076)
| Nhiệm vụ | NPC | Cách làm | Biến |
|---|---|---|---|
| 115 (Tiên) / 116 (Ma), ngày 4 vòng | Tu Hành Sư phe mình | Diệt Chúc Thần + Chu Lĩnh + Cẩu Mang, Long Hồn tự xuất hiện, hạ nó, giao. Phát sáng Băng Long Nhãn 247/212 / Hỏa Long Nhãn 249/210 | 2302, 2308 |
| 1086 Hồn Dũng Giả (cấp 67) | Hồn Dũng sĩ cổ đại 206/240 | Cứ 2 quái 1076 thì thả 1 Trung Hồn, cần 5 | 2303 |
| 1087 Tâm nguyện (cấp 70) | Cơ Huyền Phong 243/237 (Tiên) / Khương Ngu Tích 212/204 (Ma) | 2 mộ (245/235, 209/200) + hạ Triết Phục 224/225 | 2304 |
| 1088 Bí mật Bản Tuyền (cấp 75) | Tu Hành Sư | Lều 253/217 → Đống đất 252/222 → Vô Danh Lão Nhân 220/217 → 10 Chu Lĩnh → Thủ Lĩnh | 2305 |
| 1089 Thần Binh (cấp 75) | Tượng Hồn Khương Giai Minh / Cơ Thương Huyền (≈250–254/215) | 3 Chiến Hồn phe đối lập (thay PvP) → hạ cả 2 anh hồn (1174/1175) | 2306 |
| 1097 (Tiên) / 1098 (Ma), ngày 3 lần | Dược Sư phe mình | Hái 5 Thánh Địa Bách Hợp (≈223–227/231) | 2307, 2308 |

### 2.4 Kỹ thuật
- **Một script vai trò cho mỗi NPC** `n45_<vai>[_<idx>].lua`: đặt `PT45_ROLE`/`PT45_IDX` rồi `Include` file nhóm `n45_p4.lua` hoặc `n45_p5.lua`.
  - Không cần tra NPC đang thoại, vì engine không có hàm trả chỉ số NPC thoại, chỉ có tên.
- **Đếm quái:**
  - Quái của tienma45 tính qua `LastDamage` (`tm45_mob.lua`), đánh dấu bằng `GetNpcParam(npc,1)`: 7745 cho đàn, 7746 cho quái triệu hồi; tham số 2 là mã loài.
  - Quái triệu hồi tự xóa qua `Timeout` 1 giây sau khi chết, hoặc sau 5 phút nếu bỏ đó.
  - Quái sinh tự động của 1075 (spawn_1075: 739/740/743/783) tính là "yêu ma Ngục Pháp Sơn" qua death script trong PAK.
- **ptfix `extra_tienma45.py`** (Server, chạy sau `extra_tienma.py`):
  - 3 stub vật phẩm;
  - **bọc** `戾/狰` có sẵn từ `ctx["entries"]` của tienma: đổi tên `OnDeath` cũ, gọi nó trước rồi mới gọi phần tienma45;
  - thêm mới `仙·钦原`, `魔·钦原`;
  - 33 stub đường dẫn VNG `\script\狱法山\*`, `\script\阪泉圣地\*` (chỉ khi thiếu ở mọi nơi).
  - Không đụng `\script\东夷\*` (Đông Di) và không đụng mục nào của `extra_sudo_dongdi.py`.
- **Tiếp nhận placeholder:**
  - Chỉ trên map 1075/1076, đúng template và ô (±1).
  - Mật thám Ma (1796/3352) nằm ở ô không tới được, nên được dời bằng `SetNpcPos` sang 1792/3356 (cùng region).
  - Không đụng: placeholder "Y Giáp Ma" 1076, mọi NPC Đông Di trên 1073 (template 1008–1012 trùng), mọi NPC 1073/1074 của tienma23.
- **Stack 120 ô:**
  - Dữ liệu ext viết mỗi bản ghi một câu lệnh nhỏ.
  - Giả lập stack engine cho thấy mọi lối vào còn trống 44–47 khung (NPC/vật phẩm/quái) và 37 khung (ext tick), không tràn.
  - `t_tm45extload.lua` (`-Stack 100`) nạp `ext\tienma.lua` và `ext\tienma45.lua` qua chuỗi servertimer: đạt.

### 2.5 Mô phỏng
| Bài | Kết quả |
|---|---|
| `qtest\sim_tienma45.lua` (`-Stack 100`, `out_tienma45_stack100.txt`) | 81 OK / 0 FAIL / 0 lỗi Lua |
| Như trên, chế độ `emu` (`-Stack 0 -Args1 emu`, đệm stack về 47/40 khung) | 81/0 |
| Như trên, `runtime,emu` (đọc file đã triển khai) | 81/0 |
| `qtest\sim_tm45_stub.lua` (stub lấy từ `tienma45\ptfix_test.pak`) | 8/0 |
| Hồi quy `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `sim_tienma`, `t_st` | Kết quả trùng hệt trước khi thay đổi (t_st chỉ khác địa chỉ con trỏ) |

Nội dung `sim_tm45_stub.lua`: `戾` bọc vẫn chạy phần tienma (Phi Thố 1/20) và cộng yêu ma Ngục Pháp; quái đàn 7745 không bị đếm hai lần; `钦原` mới chỉ tính trên 1075; stub `解咒符`/`hetuluoshu` gọi đúng hàm; `狱法山\偃伯益` mở hội thoại Yển Bá Ích.

Nội dung `sim_tienma45.lua`:
- ext tick: tiếp nhận 12 placeholder, không đụng NPC khác; idempotent, đặt lại quái bị mất;
- bàn giao: `2222 = 26` bị từ chối, cấp 50 bị từ chối, 27 thì bắt đầu;
- trọn chủ tuyến 28→50, gồm nhánh thất bại 37 (Cự Thú bỏ chạy);
- mọi nhiệm vụ phụ phe Tiên, kèm thử nhanh phe Ma (28, 105, 1083, 116).

## Phần 3: Hành động

### Việc của coordinator
- [ ] Build ptfix chính thức (plug-in `S\ptfix\extra_tienma45.py`, chạy sau `extra_tienma.py` theo thứ tự tên). Chưa có ptfix mới thì chủ tuyến vẫn chạy tới bước 28, nhưng **Giải chú phù (bước 29+) và Dẫn Tuyền Châm (bước 47) cần ptfix**.
- [ ] `servertimer.lua` **không cần sửa**: `PTADM_EXT_NAMES` đã có `"tienma45"`, và hàm `PTEXT_tienma45_Tick()` chạy mỗi phút.
- [ ] Thêm dòng CHANGELOG và README (trong báo cáo cuối).
- [ ] Khởi động lại server theo cách thường lệ (người dùng tự làm).

### Checklist kiểm thử trong game
- [ ] Nhân vật có `2222 = 27` (xong Bất Chu Sơn), cấp ≥ 55: Tu Hành Sư Ngục Pháp Sơn (230/223 hoặc 235/209) có "Ta sẵn sàng", F11 hiện bước 28.
- [ ] Tứ Bất Tướng (215/227) trao **Giải chú phù**; nhấp phải trong làng Di Phương báo "không thể phá giải".
- [ ] Hỏi đủ 4 Pháp trụ, F11 hiện 4 mật mã. Xoay 4 La Bàn quanh làng đúng hướng, rồi dùng phù: **Cự Thú** xuất hiện, hạ nó, về Tứ Bất Tướng.
- [ ] Diệt 30 quái Ngục Pháp (cả quái sinh tự động) → Cổng thời gian (231/216) → Khương Tử Nha lúc nhỏ → **Hà Đồ Lạc Thư**.
- [ ] Hà Đồ: dùng trong làng, rồi ở Pháp trụ Bắc → Đông → Nam → Tây → Tứ Bất Tướng → hậu nhân Phục Hy.
- [ ] Bái biệt Tu Hành Sư → sang Thánh Địa → cấp 75 nhận Dẫn Tuyền Châm → hạ Ninh Vương và Lang Vương (213/227) → dùng châm → Vạn Trảo Thú → giao Ngọc Bội → cấp 80 hoàn thành.
- [ ] Thử ít nhất 1 nhiệm vụ mỗi nhóm: 104, 105, 109, 1077, 1082/1083, 1084, 115/116, 1097/1098.
- [ ] Báo lại nếu NPC/quái đứng vào chỗ không tới được, quái triệu hồi không biến mất, hoặc nhấp phải Giải chú phù không có phản ứng (nghĩa là chưa có ptfix mới).

### Việc còn lại / giới hạn
| Mục | Ghi chú |
|---|---|
| Đồng hồ VNG | Không có đồng hồ cho: Anh linh (bước 42 không xảy ra), 20 phút Huyền Thạch, 15 phút hộ tống, 10 phút Trầm Miên Nhãn, Ngọc Thanh Chân Khí, khung 18–24h Thụ Tâm |
| Điều kiện bị bỏ | 106 không đòi 24 lần Diệu Thủ Thần Y; 111 không đòi tổ đội; 112/113 không đòi danh vọng, chỉ 1 Thụ Hồn thay vì 4 |
| Thay thế | 1089 đánh Chiến Hồn thay PvP; 1085 thưởng Thạch Trung Ngọc quy ra kinh nghiệm |
| Ngoài phạm vi | 1080 Ngục Pháp Phong Yên (chiến trường phe) để giai đoạn 6 |
| Map 1076 | Không có quần thể quái sinh tự động (thiếu `spawn_1076.lua`); quái nhiệm vụ do ext đặt |

## Phần 4: Tài liệu tham khảo
- **Mã sinh** (scratchpad `tienma45\`):
  - `src_lib.py` (lib, quái, vật phẩm), `src_p4.py`, `src_p5.py` (hội thoại);
  - `mk45.py` (vị trí đi được qua `mapgrid`, ext, script vai trò, TCVN3, `--deploy`);
  - `positions45.json`, `varscan.py` / `varscan_out.txt` (quét biến 2280–2309), `getstubs.py`.
- **Plug-in:** `scratchpad\ptfix\extra_tienma45.py`. Build thử: `tienma45\ptfix_client_test.pak` (Client) và `tienma45\ptfix_test.pak` (Server, 539 mục).
- **Mô phỏng:** `qtest\sim_tienma45.lua`, `qtest\sim_tm45_stub.lua`, `qtest\t_tm45extload.lua`.
- **Liên quan:**
  - `tien-ma-gioi-phong-than-20261003.md` (giai đoạn 1, bản đồ nội dung);
  - `S\tienma\HANDOVER.md` (hợp đồng 2222 = 27);
  - script VNG gốc `item\解咒符.lua` (biến 1465/1466, đa giác La Bàn) và `item\hetuluoshu.lua` (tọa độ 4 Pháp trụ, Tứ Bất Tướng).
