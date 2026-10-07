---
tinh-nang: Sửa 4 chỗ chuỗi nhiệm vụ bị kẹt (questfix3)
ngay: 2026-10-04
agent: questfix3
trang-thai: Đã cài file rời và áp nóng qua admin bridge lúc 16:42. Không cần ptfix, không cần khởi động lại server.
tom-tat: Khảo nghiệm Đạo Sĩ (task 15) 5→6 nay chạy khi hạ Yểm Hỏa, đúng thiết kế VNG (death script của template 8). Cứu Tế Dị Nhân (task 34) có lại NPC "Thủ lĩnh tộc nhân" ở Cự Lộc [239,192], chạy script VNG gốc. Hai chỗ còn lại không kẹt thật. Task 339 bước 1→2 do Đại phu Đông Hải Hải Câu (map 1039) đẩy, NPC này có từ 2026-10-03. Thiên Thụ đã có script thu hoạch VNG ở Bá Giám từ 2026-10-02. Lệnh Bài Nhiệm Vụ được cập nhật theo: 52 chuỗi, 539 bước, 253 điểm đến.
---

# Sửa 4 chỗ chuỗi nhiệm vụ bị kẹt: Khảo nghiệm, Cứu Tế, Tân thủ tầm bảo, Thiên Thụ

## Phần 1: Tổng quan

- **Insight chính:** chỉ 2 trong 4 chỗ kẹt thật. Agent lenhbainv chỉ quét script rời trong `script\phongthan`. Hai bước còn lại do script VNG trong PAK đẩy, mà NPC chạy các script đó đã được đặt từ trước:
  - Đại phu Đông Hải Hải Câu: do `ext\sudo_dongdi.lua` đặt ngày 2026-10-03.
  - Tì Bà và Bá Giám: do `servertimer.lua` đặt ngày 2026-10-02 (questfix).
- **Hai chỗ kẹt thật đều do thiếu "người kích hoạt", không phải thiếu logic.** Logic VNG còn nguyên trong PAK:
  - Khảo nghiệm: death script của Yểm Hỏa trỏ tới file không có trong PAK nào.
  - Cứu Tế: NPC "Thủ lĩnh tộc nhân" chưa từng được đặt lên bản đồ.
- **Cách sửa bám VNG:**
  - Không viết lại hội thoại. Dùng nguyên script VNG gốc (bản ptfix có `pt_compat`).
  - Lấy toạ độ từ chữ F11 (taskinfo).
  - Chỉ bổ sung phần engine thiếu: death script của quái và việc đặt NPC.

| # | Chuỗi | Bước | Kết luận | Đã làm |
|---|---|---|---|---|
| 1 | Khảo nghiệm Đạo Sĩ (task 15) | 5 → 6 | **Kẹt thật** | `mob_drop.lua`: hạ Yểm Hỏa (tpl 8) hoặc Tuyết Nguyên Cự Thú (tpl 103) khi task 15 = 5 → 6 |
| 2 | Cứu Tế Dị Nhân (task 34) | 2 → 3, 4 → 5 | **Kẹt thật** | `ext\questfix3.lua` đặt NPC Thủ lĩnh tộc nhân (Cự Lộc [239,192]), chạy script VNG `蚩尤墓\失踪的族人.lua` |
| 3 | Tân thủ tầm bảo (task 339) | 1 → 2 | Không kẹt | Không sửa code. Đại phu Đông Hải Hải Câu (1039) chạy script VNG `龙套\野外医生-东海海沟.lua`, đặt 339 = 2. Đã mô phỏng |
| 4 | Thiên Thụ thu hoạch | – | Không kẹt | Không sửa code. Bá Giám chạy script VNG `封神台\柏鉴.lua`, có "Lấy được quả" thưởng theo độ trưởng thành. Đã mô phỏng trọn vòng. Lệnh Bài Nhiệm Vụ thêm dòng "chăm sóc / thu hoạch" |

## Phần 2: Chi tiết

### 2.1 Khảo nghiệm Đạo Sĩ (task 15), bước 5 → 6

- **Nguyên nhân:**
  - Trong `npcs.txt` VNG, template **8 厌火 (Yểm Hỏa)** có `DeathScript = \script\npcdeath\雪原巨兽.lua`. File này không có trong PAK nào.
  - Template 103 雪原巨兽 chỉ có `normal.lua`.
  - Engine bản này cũng không gọi DeathScript (xem `spawn_main.lua`). Vì vậy giết bao nhiêu Yểm Hỏa thì task 15 vẫn đứng ở 5.
- **Cách VNG làm:**
  - Nội dung death script còn nguyên ở `\script\怪物\雪原巨兽.lua` (yichuan 2004): `if GetTask(15)==5 then SetTask(15,6); Msg2Player("Đã diệt được Yểm Hỏa, quay về phục mệnh Vân Trung Tử."); TaskNote(5,3)`.
  - F11 (taskinfo 5) ghi "Đến **Thủ Dương Sơn** giết **Yểm Hỏa (168.192)**".
  - Vân Trung Tử nói "đi giết Tuyết Nguyên Cự Thú ở Thủ Dương Sơn". Đó là tên tiếng Việt của 雪原巨兽, nhưng thứ thật sự kích hoạt bước là Yểm Hỏa.
- **Đã sửa** `Server\script\phongthan\npc_fix\mob_drop.lua` (file ASCII, sửa ở mức byte bằng `S\questfix3\patch_mobdrop.py`):
  - Thêm `PTDrop_Task15()`, chép đúng logic và câu thông báo VNG (byte TCVN3 lấy thẳng từ bản PAK).
  - `PTDrop_Special` gọi hàm này cho tpl **8** và **103**. Tpl 103 là con Tuyết Nguyên Cự Thú duy nhất mà `spawn_1009.lua` đặt ở Tây Côn Lôn. Tính cả nó để khớp với lời Vân Trung Tử.
  - `PTDrop_Death` nay chạy `PTDrop_Special` cho **mọi** template, kể cả template có luật nguyên liệu. Trước đây đây là `if/else`. Tpl 8 vẫn rơi Ngọc Cốt cho Linh lực/Thu thập như cũ.
- **Gắn script:**
  - Yểm Hỏa đã được gắn `mob_drop.lua` (spawn_main) và `newbie2\nb2_mob.lua` (ext newbie2 gắn lại; `nb2_mob` Include `mob_drop.lua` và gọi `PTDrop_Death`). Hai đường đều chạy được logic mới.
  - Tpl 103 chưa có ActionScript. `ext\questfix3.lua` gắn `mob_drop.lua` cho mọi NPC tpl 103 sau khi quần thể quái đặt xong (`PT_SPAWN_DONE`), rồi kiểm lại mỗi 30 phút.

### 2.2 Cứu Tế Dị Nhân (task 34), bước 2 → 3 và 4 → 5

- **Nguyên nhân:**
  - `SetTask(34,3)` và `SetTask(34,5)` chỉ có trong `\script\蚩尤墓\失踪的族人.lua` (script.pak, có bản ptfix kèm `pt_compat`).
  - Script này là của NPC **"Thủ lĩnh tộc nhân bị mất tích"**. Không có dữ liệu vùng nào đặt NPC đó. Vì vậy sau Hình Thiên (34 = 2), người chơi không còn ai để gặp.
- **Cách VNG làm (taskinfo 16 và script):**
  1. Phong Bá: 0 → 1.
  2. Hình Thiên: 1 → 2, "Đến Cự Lộc tìm đầu lĩnh mất tích (tọa độ [239,192])".
  3. Thủ lĩnh tộc nhân: 2 → 3 (chỉ Dị Nhân), "giết Độc Lục quái".
  4. Độc Lục quái (tpl 106, `\script\怪物\毒苔妖.lua`) ở [236,191] [221,194] [209,178]: rơi Thức ăn (4,30), 3 → 4.
  5. Thủ lĩnh tộc nhân (còn giữ Thức ăn): 4 → 5, "Giao thức ăn cho Hình Thiên".
  6. Hình Thiên lấy Thức ăn: 5 → 6.
  7. Phong Bá: 6 → 7, thưởng sách kỹ năng Bàn Cổ Khai Thiên.
  - Bước 4 đã có sẵn: `mob_drop.lua` có luật cho tpl 106. `spawn_1013.lua` đặt 3 con Độc Lục quái đúng 3 toạ độ VNG (`PT_SPAWN_SPECIAL`).
- **Đã sửa:** file mới `Server\script\phongthan\ext\questfix3.lua` (`PTEXT_questfix3_Tick`, gọi mỗi phút qua `PTAdm_ExtTick`, có bảo vệ). Mỗi state chỉ chạy một lần:
  - `ReLoadScript` script PAK (script PAK không được đăng ký lúc khởi động).
  - Đặt NPC và giữ NPC: nếu mất (tên hoặc map không khớp) thì đặt lại.

  | Thuộc tính | Giá trị |
  |---|---|
  | Map, ô | 1013 Cự Lộc, ô 1916/3080 (mps 61312/98560) = màn hình [239,192] |
  | Template | 1097 `失踪的族人` (Kind 3, hình nam Dị Nhân) |
  | Tên hiển thị | "Thủ Lĩnh Tộc Nhân" (TCVN3) |
  | Script | `\script\蚩尤墓\失踪的族人.lua`, bản ptfix có `pt_compat`, nên có dòng "Kết thúc đối thoại" |
  | Kiểm tra ô | Đi được trên lưới client và server, 3×3 trống, nằm trong vùng liền mạch lớn. Cách 3 con Độc Lục quái 20–60 ô |

- `servertimer.lua`: thêm `"questfix3"` vào cuối `PTADM_EXT_NAMES`. Chỉ đổi đúng dòng này, sửa ở mức byte bằng `patch_servertimer.py`.
- Bỏ qua script `其余失踪的族人.lua` (các tộc nhân khác). Script này chỉ chạy sau khi xong (34 = 7) và ghi đè task 340, mà Hình Thiên đang dùng làm cờ nhận sách.

### 2.3 Tân thủ tầm bảo (task 339), bước 1 → 2: không kẹt

- Lỗ Hùng, Từ Hàng, Hình Thiên (cấp 15–19) giao thư và đặt 339 = 1: "chuyển thư cho Đại phu ở **Đông Hải Hải Câu**".
- Bước 1 → 2 nằm trong `\script\龙套\野外医生-东海海沟.lua`:
  - Đặt `SetTask(339,2)`.
  - Tặng vũ khí theo hệ: Giáp Sĩ Hóa Huyết đao hoặc Tấn Thiết mâu, Đạo Sĩ Diệt Diệm kiếm, Dị Nhân Trường Sinh phủ.
- NPC này là `dp1039` của `ext\sudo_dongdi.lua` (map 1039, ô 1613/3090). Bridge 16:42 xác nhận NPC còn sống (idx 5482).
- Lưu ý: nếu người chơi đang ở Thám Quân với task 314 = 39 cùng lúc, Đại phu ưu tiên Thám Quân trước. Nói chuyện thêm lần nữa là nhận 339. Đây là hành vi VNG.
- Lệnh Bài Nhiệm Vụ chưa có chuỗi 339 nên không phải sửa dữ liệu.

### 2.4 Thiên Thụ: đã có thu hoạch theo VNG

| Bước | NPC / nguồn | Biến |
|---|---|---|
| Có mầm | Quái cấp ≥ 35 rơi 3% (`mob_drop.lua`, nguồn tự thêm), hoặc Tì Bà "Đổi mầm" (1 Hạt thần bí 4/48 + 10.000 lượng → Mầm cây 4/49) | 804 = 1 (mầm đặc biệt 4/164: 804 = 2) |
| Chăm sóc 10 lần | Linh Bảo tưới nước (321), Cao Giác bón phân (322), Sùng Ứng Bưu bắt sâu (323). Mỗi lần: nhận yêu cầu + nộp = 2 lượt (task 320); +4 hoặc +1 độ trưởng thành (327) | 320 = 20 thì 3 NPC từ chối |
| Thu hoạch | **Bá Giám** (Phong Thần Đài) → "Lấy được quả" → xác nhận | Xoá mầm, đặt lại 320–327, 804, 815 |

- **Phần thưởng VNG (`封神台\柏鉴.lua`)**:
  - Kinh nghiệm = độ trưởng thành × 5 × cấp (× 25 nếu là cây đầu tiên trong ngày, task 813 = 1).
  - Vật phẩm theo độ trưởng thành:

  | Độ trưởng thành | Phần thưởng |
  |---|---|
  | ≥ 55 | 1 trong 12 vũ khí cấp 75/85/95 + thông báo toàn server. Đặt GlobalValue 6, từ đó cả server khó vượt 50 |
  | 50–54 | Bá Lạc nhãn cấp 13 |
  | 45–49 | Bá Lạc nhãn cấp 10–12 |
  | 40–44 | Bá Lạc nhãn cấp 6–9 |
  | 35–39 | Hạt thần bí (4/48), đem đổi mầm ở Tì Bà |
  | 30–34 | Liễu Mộc (4/39), dùng cho Vi Lao |

- **Không có cây thật trên bản đồ, không có hẹn giờ.** "Mầm cây" là vật phẩm. Thời gian VNG chỉ gồm thưởng ×5 cho cây đầu tiên trong ngày (task 813/816) và giới hạn 3 mầm đặc biệt mỗi ngày (task 805/814).
- **Chưa có:** Nhị Lang Thần ở Diêu Trì (VNG: đổi 3 Liễu Mộc lấy 1 Hạt thần bí) chưa có dữ liệu đặt NPC. Script của NPC này còn lỗi `GetItemCount(39)` giống Võ Cát. Nguồn hạt vẫn đủ nhờ 3% rơi từ quái và thưởng 35–39 của Bá Giám.

### 2.5 Lệnh Bài Nhiệm Vụ / Tiếp Tế: dữ liệu cập nhật

Generator `S\lenhbainv\`: `chains.py`, `dests2.py`, `gen.py` (thêm điều kiện `cond 4` = 321, 322, 323 đều bằng 0). Đã chạy lại `pick_all.py` và `gen.py`. 250 điểm đến cũ giữ nguyên toạ độ.

| Chuỗi | Trước | Sau |
|---|---|---|
| Khảo nghiệm 15 = 5 | "hạ Tuyết Nguyên Cổ Thụ ở Tây Côn Lôn", không điểm đến | "hạ Yểm Hỏa ở Thủ Dương Sơn (hoặc Tuyết Nguyên Cự Thú ở Tây Côn Lôn)" → điểm đến mới `mob_yemhoa` (1010, ô đến 1300/3084) |
| Cứu Tế 34 = 2 | "tìm người lạc ở Cự Lộc" (tự đánh) | "gặp Thủ lĩnh tộc nhân mất tích ở Cự Lộc" → `toclinh1013` (ô đến 1916/3082) |
| Cứu Tế 34 = 3 | "hạ Độc Đại yêu", không điểm đến | "hạ Độc Lục quái ở Cự Lộc lấy lại lương thực" → `mob_docluc` (ô đến 1892/3068) |
| Cứu Tế 34 = 4 | gộp với 5: Hình Thiên | "mang Thức ăn về cho Thủ lĩnh tộc nhân" → `toclinh1013`, đồ: Thức ăn (4,30) |
| Cứu Tế 34 = 5 | (gộp) | Hình Thiên, Thức ăn (4,30), như cũ |
| Mới: chuỗi 24 "Thiên Thụ - chăm sóc, thu hoạch" | – | 804 ∈ {1,2}, không có bước chăm sóc đang mở. 320 < 20 → Linh Bảo ("chăm sóc Mầm cây..."). 320 ≥ 20 → **Bá Giám** ("mang Mầm cây tới Bá Giám thu hoạch"). Không phát đồ |

Tổng: **52 chuỗi, 539 dòng bước, 253 điểm đến.** Đã kiểm bằng diff ngữ nghĩa (chỉ số điểm đến quy về khoá). Ngoài 6 dòng trên, 2 dòng mới và 3 điểm đến mới thì không dòng nào đổi. Menu 5 nhóm giữ nguyên. Đã cài `nhiemvu_data.lua` và `nhiemvu_lenhbai.lua` (thêm `PTNV_G251..253`). `tiepte_lenhbai.lua` và `nhiemvu_give.lua` không đổi.

### 2.6 Áp nóng (admin bridge)

| Giờ | Lệnh | Kết quả |
|---|---|---|
| 16:37 | `hot_apply.lua` lần 1 | Dừng ở dòng đầu: `ReLoadScript` không trả giá trị, và `tostring()` không có đối số thì báo lỗi. Chỉ `mob_drop.lua` kịp nạp lại |
| 16:41 | `diag1.lua` (chỉ đọc) | Xác nhận ext chưa nạp, `PT_SPAWN_DONE = 1` |
| 16:42 | `hot_apply.lua` đã sửa | Nạp lại `mob_drop`, `nb2_mob`, 2 lệnh bài. Thêm `questfix3` vào `PTADM_EXT_NAMES` (vị trí 14). NPC Thủ lĩnh tộc nhân idx 31495 tại 1013 (1916,3080), tên đúng. Gắn 1 NPC tpl 103. dp1039 idx 5482 còn sống. Tì Bà 5410, Bá Giám 5411 còn sống |
| 16:44 | `diag2.lua` (chỉ đọc) | Sau 2 tick ext tự chạy: `toc_nhan_count=1 idx=31495 ticks=3 ext_pos=14 tpl103_npcs=1 last_spawned=0`. Không đặt trùng, không có `tick_error.log` |

Mỗi lần chỉ ghi `pending.lua` khi chưa có `pending.lua` hoặc `running.lua`: ghi file tạm, rồi `os.rename`, lệnh này báo lỗi nếu đích đã tồn tại.

### 2.7 Kết quả mô phỏng

| Mô phỏng | Kết quả |
|---|---|
| `sim_questfix3.lua -Stack 100` | **FAILS=0** (84 kiểm tra) |
| `sim_questfix3.lua -Stack 100 -Args1 emu` | **FAILS=0**, headroom tối thiểu 37 frame |
| `sim_lenhbainv.lua -Stack 100` / `emu` / `-Stack 0 emu` / `live` / `emulive` | Đều **FAILS=0** (254 kiểm tra). 539 dòng bước đều nhận đúng. Headroom emu 27 / 39 frame. So với bản trước chỉ khác số điểm đến (253) và số dòng (539) |
| `sim_questfix.lua -Stack 100` | TOTAL FAILS = 0, giống hệt bản trước (0 dòng khác) |
| `sim_newbie2.lua` (stack mặc định, như hướng dẫn của sim) | FAILS=0, giống hệt bản trước |
| `sim_newbie2.lua -Stack 100` | Harness tràn stack ngay từ bản cũ. Bản `mob_drop.lua` cũ và mới cho output giống hệt nhau (`qf3_sim_nb2_oldmob.lua`) |

Nội dung `sim_questfix3`:
- **Khảo nghiệm:** chạy trọn 0 → 7.
  - Bản `mob_drop` cũ (sao lưu) tái hiện lỗi: task 15 đứng ở 5.
  - Có tpl 103. Task 15 ≠ 5 thì không đổi.
  - Ngọc Cốt vẫn rơi, cả khi đang ở cùng lúc task 14 = 1 và 15 = 5.
  - Đi qua `nb2_mob.lua` vẫn chạy.
- **Cứu Tế:** chạy trọn 0 → 7 với script PAK của tộc nhân.
  - Có dòng thoát. Giáp Sĩ không thấy dòng nhiệm vụ.
  - Không có Thức ăn thì không có dòng.
  - Lục Quái thường không rơi.
- **Task 339:** Hình Thiên → Đại phu 1039 → Hình Thiên (2 Thạch cầu). Từ Hàng (Đạo Sĩ). Ưu tiên Thám Quân 314 = 39.
- **Thiên Thụ:**
  - Mầm rơi từ quái, không rơi mầm thứ hai.
  - Bá Giám hiện "Lấy được quả".
  - 10 lần chăm sóc Linh Bảo / Cao Giác, lần thứ 11 bị từ chối.
  - Thu hoạch: kinh nghiệm đúng công thức, đặt lại các task.
  - Bảng thưởng 6 mức. Tì Bà đổi mầm.
- **ext questfix3:** chạy qua `PTAdm_ExtOne` của `servertimer.lua` thật.
  - Đặt NPC đúng map, template, ô, tên, script; `ReLoadScript` 1 lần.
  - Tick sau không đặt thêm. Mất NPC thì đặt lại.
  - Tpl 103 chỉ được gắn sau `PT_SPAWN_DONE`, kiểm lại mỗi 30 tick.

## Phần 3: Hành động

### 3.1 Không cần
- [x] Không cần ptfix: mọi script VNG dùng tới đã có trong `ptfix.pak` đang chạy. Không tạo `extra_questfix3.py`.
- [x] Không cần khởi động lại GameServer: đã áp nóng. Lần khởi động sau, `servertimer.lua` trên đĩa đã có `questfix3`.
- [x] Không đụng web admin, Vạn Tiên / Thương Chu, `bots\party.lua`.

### 3.2 Kiểm tra trong game (người chơi)
- [ ] Dị Nhân cấp 12: Phong Bá → Hình Thiên → Lệnh Bài Nhiệm Vụ "Cứu Tế" → dịch chuyển tới **Thủ Lĩnh Tộc Nhân** (Cự Lộc 239/192) → hội thoại → hạ Độc Lục quái → quay lại tộc nhân → Hình Thiên → Phong Bá.
- [ ] Đạo Sĩ cấp 7+: Vân Trung Tử → Linh Bảo (đáp án 2-1-3) → Vân Trung Tử → hạ 1 Yểm Hỏa ở Thủ Dương Sơn (lệnh bài có điểm đến) → thấy "Đã diệt được Yểm Hỏa..." → Vân Trung Tử nhận pháp bảo.
- [ ] Cấp 15–19: Hình Thiên / Lỗ Hùng / Từ Hàng "Tân Thủ tầm bảo" → Đại phu Đông Hải Hải Câu (map 1039, 201/193) → nhận vũ khí → quay lại nhận Thạch cầu.
- [ ] Cấp 35+ có Mầm cây: chăm sóc đủ 10 lần → Lệnh Bài hiện "Thiên Thụ - chăm sóc, thu hoạch: ... Bá Giám" → Bá Giám "Lấy được quả".
- [x] Bridge 16:44 (`questfix3_diag2`): đúng 1 Thủ Lĩnh Tộc Nhân, tick ext chạy đều, không lỗi.

### 3.3 Rollback
- Chép lại từ `_backup\20261004-questfix3\` (cùng đường dẫn tương đối): `mob_drop.lua`, `servertimer.lua`, `item\nhiemvu_data.lua`, `item\nhiemvu_lenhbai.lua`. Generator: `_backup\...\scratchpad\lenhbainv\`.
- Xoá `script\phongthan\ext\questfix3.lua`.
- Áp nóng: bridge `DelNpc(PTQ3_SPAWNED[1])`, bỏ `"questfix3"` khỏi `PTADM_EXT_NAMES`, rồi `ReLoadScript` `mob_drop.lua`, `nb2_mob.lua` và 2 lệnh bài.

## Phần 4: Tài liệu tham khảo

| Loại | Đường dẫn |
|---|---|
| File runtime đã sửa | `Server\script\phongthan\npc_fix\mob_drop.lua`, `Server\script\servertimer.lua` (1 dòng), `Server\script\phongthan\item\nhiemvu_data.lua`, `nhiemvu_lenhbai.lua` |
| File runtime mới | `Server\script\phongthan\ext\questfix3.lua` |
| Generator Lệnh Bài | `S\lenhbainv\chains.py`, `dests2.py`, `gen.py`, `dests_final.json`, `out\` |
| Công cụ questfix3 | `S\questfix3\`: `backup.py`, `patch_mobdrop.py`, `patch_servertimer.py`, `semdiff.py`, `rd.py`, `cellchk.py`, `hot_apply.lua`, `diag1.lua`, `diag2.lua`, `put_pending.py`, `pak\` (bản giải mã script VNG) |
| Mô phỏng | `S\qtest\sim_questfix3.lua` → `out_questfix3.txt`, `out_questfix3_emu.txt`; `t_qf3_bridge.lua` (chạy thử chunk bridge); `qf3_sim_nb2_oldmob.lua` |
| Nguồn VNG | `npcs.txt` (tpl 8 DeathScript), `\script\怪物\雪原巨兽.lua`, `\script\蚩尤墓\失踪的族人.lua`, `\script\怪物\毒苔妖.lua`, `\script\龙套\野外医生-东海海沟.lua`, `\script\封神台\柏鉴.lua`, `\script\朝歌\琵琶.lua`, `\script\瑶池\二郎神.lua`, taskinfo 5 / 16 / 60 |
| Liên quan | `lenh-bai-nhiem-vu-phong-than-20261004.md` (mục 2.5), `kiem-toan-nhiem-vu-phong-than-20261002.md`, `roi-vat-pham-nhiem-vu-phong-than-20260929.md`, `su-do-dong-di-phong-than-20261003.md` |
| Sao lưu | `_backup\20261004-questfix3\` |

**Bước tiếp theo (đề xuất):** đặt Nhị Lang Thần ở Diêu Trì nếu tìm được toạ độ VNG, rồi sửa `GetItemCount(39)` trong script của NPC này bằng ptfix. Có thể thêm chuỗi 339 vào Lệnh Bài Nhiệm Vụ.
