---
tinh-nang: Lệnh Bài Nhiệm Vụ + Lệnh Bài Tiếp Tế Nhiệm Vụ
ngay: 2026-10-04
agent: lenhbainv
trang-thai: Đã cài (ptfix v27 19:29); bãi quái 20:06 (lenhbainv2); từng bước + chi tiết mọi nhiệm vụ 21:21 (lenhbainv3/4)
tom-tat: Hai lệnh bài vĩnh viễn. Lệnh Bài Nhiệm Vụ (magicscript 61430) có "Nhiệm vụ đang làm" (đọc biến task của 51 chuỗi) và 5 nhóm NPC nhận/trả nhiệm vụ; chọn là dịch chuyển tới cạnh NPC. Lệnh Bài Tiếp Tế (61431) phát đúng số vật phẩm nhiệm vụ còn thiếu của bước đang làm. Tự phát cho mọi nhân vật (task 2611/2612); web admin phát được.
---

# Lệnh Bài Nhiệm Vụ và Lệnh Bài Tiếp Tế – dịch chuyển tới NPC nhiệm vụ, nhận đủ đồ nhiệm vụ

## Phần 1: Tổng quan

- **Insight chính:** chơi một mình thì phần tốn thời gian nhất là đi tìm NPC và gom vật phẩm nhiệm vụ. Server có khoảng 50 chuỗi nhiệm vụ rải trên 40 bản đồ, NPC đặt lại bằng script nên khác bản VNG. Hai lệnh bài này đọc thẳng biến task của từng chuỗi, nên biết bạn đang ở bước nào, NPC kế tiếp là ai và bước đó còn thiếu vật phẩm gì.
- **Lệnh Bài Nhiệm Vụ** (nhấp phải), menu chính 7 dòng:
  1. **Nhiệm vụ đang làm (N):** danh sách chuỗi đang dở. Chọn một dòng để xem bước hiện tại, rồi bấm "Dịch chuyển tới <NPC>".
  2. **Tân thủ (cấp 1-24):** chỉ hiện NPC của thôn đúng phe.
  3. **Chính tuyến (cấp 25-85).**
  4. **Thế giới, thành thị (cấp 23-70).**
  5. **Hàng ngày, lặp lại.**
  6. **Sự kiện, hoạt động:** chỉ NPC đứng ở bản đồ thường; không đưa vào phó bản hay map sự kiện.
  7. **Đóng.**

  Mỗi trang tối đa 7 dòng: 4 NPC + "Trang sau" + "Quay lại" + "Đóng", hoặc 5 NPC ở trang cuối. Mỗi dòng ghi mốc cấp, dấu `*` nghĩa là chưa đủ cấp.
- **Lệnh Bài Tiếp Tế Nhiệm Vụ** (nhấp phải): danh sách chuỗi đang làm kèm trạng thái "thiếu N món / đủ đồ / tự đánh / không cần đồ". Chọn một chuỗi thì hiện từng vật phẩm "có x/cần y, thiếu z" và nút **"Xác nhận nhận đồ còn thiếu"**.
- **An toàn:**
  - Chỉ dùng được ở bản đồ ngoài, thành, map nhiệm vụ 1061–1065 và Tiên Ma 1073–1078. Bị chặn ở Thiên Lao 1060, Trư Lung 1066, Vạn Tiên 1067–1070 và 1079–1082, chiến trường 1071, Khai Minh đảo 1072, Huyền Vũ 1084 và mọi phó bản 1083 trở lên.
  - Bản đồ đích chưa mở thì không gọi `NewWorld`.
  - Tới thành thì `SetFightState(0)`, ra ngoài thì `SetFightState(1)`.
  - Map nhiệm vụ đi qua NPC dịch chuyển có khóa tiến độ giống chính NPC đó: Tiên Ma 1073–1076, Viễn Cổ và Ngọc Hư/Triều Ca "10 năm" 1061–1064, Đông Di. Lệnh bài không giúp nhảy cóc chuỗi.
- **Vĩnh viễn:** không mất khi dùng, không hết hạn. Không bán, vứt, giao dịch hay bày bán được.

## Phần 2: Chi tiết

### 2.1 Mã số

| Thành phần | Giá trị |
|---|---|
| Lệnh Bài Nhiệm Vụ | magicscript genre 6, detail 1, particular **61430**. Script `\script\phongthan\item\nhiemvu_lenhbai.lua`. Hình `\spr\item\another\令牌1.spr` (dòng VNG 1439 "Sát Ma Mật Lệnh") |
| Lệnh Bài Tiếp Tế Nhiệm Vụ | particular **61431**. Script `\script\phongthan\item\tiepte_lenhbai.lua`. Hình `\spr\item\other\卷轴紫.spr` (dòng VNG 33 "Chỉ Nam Phù") |
| Thư viện + dữ liệu chung | `\script\phongthan\item\nhiemvu_data.lua` (121 KB, không có `main`). Hai script vật phẩm `dofile` lúc chạy (cwd = Server), không `dofile` ở top-level |
| Tự phát | `\script\phongthan\item\nhiemvu_give.lua`, gọi từ `starter_gear.lua` (`PTNB_NvTick`, chạy bảo vệ bằng `PTAdm_Safe`) |
| Cờ đã phát | task **2611** (Lệnh Bài Nhiệm Vụ), **2612** (Lệnh Bài Tiếp Tế). Dải 2600–2619 đã được agent luyencong quét toàn bộ PAK; script rời không có `GetTask/SetTask(2611..2619)` |
| Biến toàn cục | tiền tố `PTNV_` (thư viện, lệnh bài nhiệm vụ) và `PTTT_` (lệnh bài tiếp tế) |
| Khóa web admin | `NhiemVuToken` → `@{ g = 6; d = 61430 }`, `TiepTeToken` → `@{ g = 6; d = 61431 }`. Nút "Phát Lệnh Bài Nhiệm Vụ", "Phát Lệnh Bài Tiếp Tế" ở mục Lệnh bài hủy đồ |
| Plug-in PAK | `scratchpad\ptfix\extra_lenhbainv.py` (thêm 2 dòng magicscript, chạy cả Client và Server) |

### 2.2 Toạ độ là toạ độ thật

1. **Vị trí NPC:** lấy trực tiếp trên server đang chạy (2026-10-04 15:16) qua admin bridge. `diag_npcdump.lua` duyệt mọi NPC (trừ 29.555 quái của `spawn_main`), ghi chỉ số, template, map, ô, cấp, tên vào `admin_bridge\lbnv_npcs.txt` (1.932 dòng). Mọi điểm đến kiểu NPC đều khớp một NPC sống trong vòng 1 ô.
2. **Đối chiếu nguồn đặt NPC:** `PTADM_NPC_SPAWN` và `PTADM_MOB_SPAWN` trong `servertimer.lua`, `npc_regions` (khôi phục 2004), `ext\newbie2.lua`, `ext\sudo_dongdi.lua`, `ext\daily2/daily3/vanluong/sinhhoat/cankhon2/congthanh/vienco/tienma/tienma45.lua`, `vantien\vt_data.lua`, `tutuong\tt_tick.lua`. Cột "Nguồn" ở bảng dưới.
3. **Ô đến** (`cells.py`, `pick_all.py`):
   - cách NPC 1–3 ô (ưu tiên 2 ô, phía dưới NPC); quái nhiệm vụ cách 3–7 ô;
   - đi được trên lưới client (`Region_C`) và lưới server (`Region_S`, hoặc region không có `Region_S`), kiểm tra cả 8 ô xung quanh;
   - không phải trap, không trùng NPC khác;
   - nằm trong vùng đi được liền mạch (≥ 200 ô; Tạp Hóa Triều Ca nằm trong sân nhỏ ≥ 40 ô).
   - Kết quả: 248/250 điểm đến đạt bậc 1. **Tây Vương Mẫu** đứng trên bục kín 15 ô, nên ô đến đặt ngoài bục, cách 5 ô (1770, 3015).

### 2.3 "Nhiệm vụ đang làm": làm được tới đâu

- **51 chuỗi, 536 dòng bước.** Mỗi dòng gồm biến task, khoảng giá trị, phe (`GetPlayerType`), biến điều kiện thứ hai, NPC kế tiếp, bộ vật phẩm, và cờ "tự đánh".
- Nguồn là chính script trả nhiệm vụ: `npc_fix\*.lua`, `npc_restore\*.lua`, `nb2_data.lua` (nhập thẳng từ `gen_nb2.py`), `daily2/3`, `vanluong`, `tienma/tienma45`, `vienco\gs_data.lua`, `vantien`, và script PAK đã giải mã trong `scratchpad\questfix\pak`, `sudo_dongdi\pak`.
- **Bước dạng bit** được tách thành từng giá trị, chỉ thẳng NPC còn thiếu. Ví dụ: Hộp Gấm 10–16, Bách Lý, Khai Trí, chính tuyến Đạo Sĩ 10–16, cá Minh Châu 20–26, 3 Tiền Thế ở bước 63.
- **Dòng "chưa nhận"** chỉ có ở tân thủ (tới cấp 20–30), tân thủ mới (tới cấp 30), chính tuyến (từ cấp 25) và Tiên Ma (từ cấp 85). Nhiệm vụ thế giới chưa nhận thì xem trong nhóm 4.
- **Chuỗi tùy biến:**
  - Quy Tinh: task 53 gồm byte trạng thái và byte bước, đi tới đúng Phong Ấn Tháp.
  - Thám Quân: 314 = map Đại Phu dã ngoại.
  - Vận chuyển: 2169 gồm thành đích, hàng và số lượng.
  - Thí luyện sư đồ: 899–902, Đại Phu tầng mê cung.
  - Giang Sơn Y Cựu: 2355/2356/2360, có 19 bãi quái.

### 2.4 Lệnh Bài Tiếp Tế: phát đồ thế nào

- **Phát gì:** chỉ vật phẩm mà script trả nhiệm vụ kiểm tra.
  - `HaveEventItem`/`QuestExchange {4,n,0,0,0,0,c}` → `AddEventItem(n)`.
  - `HaveNormalItem`/`QuestExchange {g,d,p,lv,…}` → `AddNormalItemPile(g,d,p,lv,0,0)`, đúng level mà `QuestExchange` so khớp. Ví dụ nguyên liệu genre 3 level 0, Giải Chú Phù/Hà Đồ/Dẫn Tuyền Châm `6,1,x` level 1.
  - Bí kíp tân thủ mới (`book`): phát sách `6,1,62xxx` nếu chưa học kỹ năng.
  - **Không phát** tiền, thưởng, thú cưỡi, pháp bảo, hay trạng thái biến thân.
- **Chỉ phát phần còn thiếu:** thiếu = cần − đang có. Vì vậy các bước đòi đúng 1 cái không bao giờ bị phát thừa, ví dụ EV3, EV9, EV18, EV39, EV40, EV42, EV43.
  - Bước 12 Dị Nhân (Cạnh tinh rượu) không phát, vì NPC chỉ hiện menu khi chưa có.
  - Bước 63: chỉ phát sách của Tiền Thế đã hạ (bit task 42 đã bật).
- **Xếp chồng và chỗ trống:**
  - `AddNormalItemPile` và `AddEventItem` đều xếp chồng, và trả 0 khi túi đầy (vật phẩm bị hủy, không rơi ra đất).
  - Trước khi phát, kiểm tra `CalcFreeItemCellCount() ≥ số loại còn thiếu`, thiếu thì báo cần bao nhiêu ô.
  - Phát từng cái. Đầy giữa chừng thì dừng và báo đã nhận bao nhiêu.
  - Nếu engine không có `AddNormalItemPile`, dùng đúng cách của `PTAdm_GiveTo`: `AddItem` → `GetMaxStackItem > 1 ? AddItemIDStack : AddItemID`, chỉ khi còn ô trống.
- **Bước "giết quái đếm số" (cờ tự đánh):** **lựa chọn là KHÔNG đặt biến đếm.** Lệnh bài ghi "Bước này cần tự đánh hoặc tự làm (quái, đèn, hộ tống...): lệnh bài không thay được và không đặt biến đếm." Lệnh Bài Nhiệm Vụ vẫn dịch chuyển tới cạnh quái hoặc bãi quái nếu có toạ độ cố định.
  - Lý do: nhiều bước đếm vừa tăng biến vừa sinh quái hoặc rơi đồ theo phe. Đặt tắt biến dễ làm hỏng chuỗi, và cũng là bỏ qua lối chơi.
- **Kiểm tra trên server thật** (bridge 15:54): engine biên dịch `nhiemvu_data.lua` được 250 điểm đến, 536 dòng. Đủ các hàm `GetByte`, `AddNormalItemPile`, `AddEventItem`, `HaveEventItemCount`, `HaveNormalItem`, `HaveMagic`, `CalcFreeItemCellCount`, `GetPlayerType`, `date`. `ReLoadScript` hai script vật phẩm OK.

### 2.5 Lỗi chuỗi phát hiện khi đọc script (đã xử lý ngày 2026-10-04, xem `questfix3-phong-than-20261004.md`)

| Chuỗi | Bước kẹt | Chi tiết | Kết quả questfix3 |
|---|---|---|---|
| Khảo nghiệm Đạo Sĩ (task 15) | 5 → 6 | Không script nào đặt 15 = 6 khi hạ Tuyết Nguyên Cổ Thụ (template 103, Tây Côn Lôn); `mob_drop.lua` không có luật cho template 103 | **Đã sửa.** VNG đặt bước này ở death script của Yểm Hỏa (tpl 8). `mob_drop.lua` nay xử lý tpl 8 và tpl 103. Lệnh bài trỏ tới Yểm Hỏa ở Thủ Dương Sơn |
| Cứu Tế Dị Nhân (task 34) | 2 → 3 và 4 → 5 | Không có `SetTask(34,3)` hoặc `SetTask(34,5)` ở đâu | **Đã sửa.** Đặt NPC VNG "Thủ lĩnh tộc nhân" ở Cự Lộc [239,192] (`ext\questfix3.lua`). Lệnh bài tách bước 4 và 5 |
| Tân thủ tầm bảo (task 339) | 1 → 2 | Thư cho Đại phu Đông Hải: không script nào đặt 339 = 2 | **Không kẹt.** Script PAK của Đại phu Đông Hải Hải Câu (`ext\sudo_dongdi.lua`, map 1039) đặt 339 = 2 |
| Thiên Thụ thu hoạch | – | Tì Bà / Bá Giám không có script rời đọc task 320–327 | **Không kẹt.** Script PAK của Bá Giám có "Lấy được quả". Lệnh bài thêm chuỗi 24 "Thiên Thụ - chăm sóc, thu hoạch" |

Sau questfix3, dữ liệu lệnh bài có 52 chuỗi, 539 dòng bước và 253 điểm đến.

### 2.6 Bãi quái cho các bước đánh quái (lenhbainv2, 2026-10-04 20:06)

**Yêu cầu:** "Lệnh bài nhiệm vụ đang thiếu một số bước chỉ ra các bản đồ chỉ định để đánh quái."

**Kết quả:**
- Mọi bước "tự đánh" và mọi bước cần vật phẩm rơi từ quái đều có điểm đến là bãi quái thật.
- Dữ liệu mới gồm 52 chuỗi, 661 dòng bước và 345 điểm đến. 186 dòng có bãi quái: 162 dòng tự đánh và 24 dòng đồ rơi.
- Đã áp nóng qua bridge lúc 20:06 bằng `ReLoadScript` hai script vật phẩm. Engine biên dịch đủ 345/661/186.
- Không cần ptfix, không cần khởi động lại.

**Cách hoạt động:**
- **Bước tự đánh:** "Nhiệm vụ đang làm" đưa thẳng tới bãi quái. Hộp chi tiết ghi "Bãi quái: <tên> [x,y]", dòng 1 là "Dịch chuyển tới <bãi>", và vẫn có "Tới NPC: …" để về trả nhiệm vụ.
- **Bước cần đồ rơi:**
  - Còn thiếu vật phẩm thì đưa tới bãi quái.
  - Đủ vật phẩm thì đưa tới NPC trả nhiệm vụ.
  - Hộp chi tiết có cả hai lựa chọn.
- **Lệnh Bài Tiếp Tế:** vẫn ghi "tự đánh" và thêm dòng "Cần tự đánh: dùng Lệnh Bài Nhiệm Vụ (Nhiệm vụ đang làm) để tới bãi quái <tên>". Ở bước đồ rơi, ghi "Vật phẩm này rơi từ quái… Bãi quái: <tên>". Lệnh bài này vẫn không đặt biến đếm.

**Bãi quái lấy từ đâu (`scratchpad\lenhbainv\farm.py`):**
- **Vị trí quái:**
  - `spawn_<map>.lua`: `PT_SPAWN_DATA` và `PT_SPAWN_SPECIAL` (servertimer sinh cả hai).
  - Region VNG của 1014/1016, lấy từ dump NPC sống.
  - `PTADM_MOB_SPAWN`.
- **Template quái theo bước:** lấy từ `mob_drop.lua` (`PTDROP_MAT`, `PTDrop_Special`), `nb2_data` (tids, maps) và F11 taskinfo.
  - F11 khớp toạ độ, ví dụ: Kiếm Nhân Tướng Quân [234,208], Phản Quân Đội Trưởng [213,187], Thảo Tiên Bà Bà [199,206], Thi Thú [212,211], Độc Lục quái [236,191].
- **Tâm bãi:** con quái đúng template có nhiều đồng loại nhất trong 20 ô. Nếu được chọn nhiều bản đồ thì ưu tiên cụm cấp thấp.
- **Ô đến:** cách quái 3–7 ô, đi được cả 8 ô quanh trên lưới client và server, không trap, không trùng NPC.
- **Bước daily mà quái sinh quanh người chơi tại điểm do script chọn:**
  - Siêu Độ / Mã Đế: `PTD2_SD_SPOTS[2149 | 2313]`, 41 điểm.
  - Thiên Cương Hồn: `PTD2_TCH_POS[2145 mod 10000]`, 10 điểm.
  - Hấp Hồn: `PTD2_HH_ISLANDS[2153 mod 10]`, 2 điểm.
  - Lục Lâm: `PTD3_LL_SPOTS[2326]`, 3 điểm.
  - Dùng đúng toạ độ đó, chỉ kiểm tra lại là đi được (bán kính 0–4).
- **Kiểm chứng trên server thật** (bridge 20:03, `diag_farm.lua`, chỉ đọc):
  - Cả 35 bãi đều có quái sống đúng template trong 25 ô, từ 1 đến 59 con.
  - Ba bãi chỉ có 1 con, đúng là quái duy nhất của nhiệm vụ: Kiếm Nhân Tướng Quân, Thảo Tiên Bà Bà, Thi Thú.
- **Dữ liệu và khóa:**
  - Thêm cột `farm` (bãi quái) và `m2` (so biến thứ hai theo modulo) vào dòng bước.
  - Hàm mới `PTNV_Target(r)` chọn điểm đến.
  - Bãi Đông Di trên 1072/1073/1076 dùng khóa 597 ≥ 9. Bãi Lam Cốt ở 1045 là map thường nên không khóa.
  - Bãi Ngục Pháp Sơn dùng khóa 2222 ≥ 27.
  - Bãi Phi Thố ở Khai Minh đảo 1072: lệnh bài đưa vào được, nhưng 1072 vẫn chặn dùng lệnh bài để đi ra (đảo hồng danh). Về bằng Thuyền Phu trên đảo.

**Trước đây thiếu điểm đến hoặc chỉ trỏ NPC phát nhiệm vụ, nay có bãi quái:**

| Chuỗi | Bước (biến = giá trị) | Loại | Bãi quái | Bản đồ | Ô đến | Quái sống ≤ 25 ô |
|---|---|---|---|---|---|---|
| Tân thủ mới (Giáp Sĩ) | 2184 = 1 (2180 = 2), 1 (2180 = 6) | tự đánh | Bãi Kiếm Nhân (Sùng Thành dã ngoại) | 1005 | 1660, 3058 [207,191] | 12 |
| Tân thủ mới (Giáp Sĩ) | 2184 = 1 (2180 = 7) | tự đánh | Bãi Hoàn Cẩu (Yến Sơn) | 1007 | 1612, 3396 [201,212] | 11 |
| Tân thủ mới | 2184 = 1 (2180 = 10), 1 (2180 = 11) | tự đánh | Bãi Giáp Cốt, Hoàn Cẩu (Mạnh Tân) | 1015 | 1637, 3236 [204,202] | 26 |
| Tân thủ mới | 2184 = 1 (2180 = 11), 1 (2180 = 13), 4 (2180 = 10), 4 (2180 = 11) | tự đánh | Bãi quái Tam Sơn | 1016 | 1686, 3354 [210,209] | 59 |
| Tân thủ mới | 2184 = 7 (2180 = 10), 7 (2180 = 11) | tự đánh | Bãi Ngưu Sát (Đồng Quan) | 1014 | 1429, 3332 [178,208] | 16 |
| Tân thủ mới | 2184 = 4 (2180 = 11), 4 (2180 = 13) | tự đánh | Bãi quái Mạnh Tân | 1015 | 1640, 3237 [205,202] | 38 |
| Tân thủ mới | 2184 = 7 (2180 = 11), 7 (2180 = 13) | tự đánh | Bãi quái Kỳ Sơn | 1017 | 1654, 3412 [206,213] | 12 |
| Tân thủ mới | 2184 = 9 (2180 = 11), 9 (2180 = 13) | tự đánh | Bãi quái Thủ Dương sơn | 1010 | 1444, 3275 [180,204] | 24 |
| Tân thủ mới (Đạo Sĩ) | 2184 = 1 (2180 = 2), 1 (2180 = 6) | tự đánh | Bãi Tuyết Quái (Chân núi Côn Lôn) | 1008 | 1761, 3243 [220,202] | 12 |
| Tân thủ mới (Đạo Sĩ) | 2184 = 1 (2180 = 7) | tự đánh | Bãi Băng Lang | 1008 | 2006, 3040 [250,190] | 7 |
| Tân thủ mới (Dị Nhân) | 2184 = 1 (2180 = 2), 1 (2180 = 4), 1 (2180 = 7) | tự đánh | Bãi Hỏa Diện (Cự Lộc) | 1013 | 1687, 3071 [210,191] | 15 |
| Tân thủ mới (Dị Nhân) | 2184 = 1 (2180 = 8) | tự đánh | Bãi Lục Quái | 1011 | 1822, 3439 [227,214] | 27 |
| Tân thủ mới (Dị Nhân) | 2184 = 1 (2180 = 12) | tự đánh | Bãi quái Du Hồn | 1011 | 1822, 3439 [227,214] | 30 |
| Tân Thức (Sùng Thành) (Giáp Sĩ) | 21 = 3 | đồ rơi | Bãi Kiếm Nhân (Sùng Thành dã ngoại) | 1005 | 1660, 3058 [207,191] | 12 |
| Mở rương (Sùng Thành) (Giáp Sĩ) | 23 = 1 | đồ rơi | Bãi Xà Thần (Bắc Hải) | 1006 | 1728, 2869 [216,179] | 22 |
| Thu thập Thủ Khố (Sùng Thành) (Giáp Sĩ) | 26 = 10 | đồ rơi | Bãi Kiếm Nhân (Sùng Thành dã ngoại) | 1005 | 1660, 3058 [207,191] | 12 |
| Thu thập Thủ Khố (Sùng Thành) (Giáp Sĩ) | 26 = 11 | đồ rơi | Bãi Xà Thần (Bắc Hải) | 1006 | 1728, 2869 [216,179] | 22 |
| Dũng Đao (Giáp Sĩ) | 25 = 1 | đồ rơi | Kiếm Nhân Tướng Quân (Yến Sơn) | 1007 | 1876, 3340 [234,208] | 1 |
| Kiêm Ái (Giáp Sĩ) | 24 = 2 | tự đánh | Phản Quân Đội Trưởng (Yến Sơn) | 1007 | 1708, 3004 [213,187] | 3 |
| Ngũ Thất (Đạo Sĩ) | 11 = 2 | đồ rơi | Bãi Tuyết Quái (Chân núi Côn Lôn) | 1008 | 1761, 3243 [220,202] | 12 |
| Linh lực (Đạo Sĩ) | 14 = 1 | đồ rơi | Bãi Băng Lang, Yểm Hỏa | 1009 | 1691, 3347 [211,209] | 11 |
| Mở rương (Ngọc Hư) (Đạo Sĩ) | 13 = 1 | đồ rơi | Bãi Băng Lang, Yểm Hỏa | 1009 | 1691, 3347 [211,209] | 11 |
| Thu thập Thủ Khố (Ngọc Hư) (Đạo Sĩ) | 16 = 9 | đồ rơi | Bãi Băng Lang, Yểm Hỏa | 1009 | 1691, 3347 [211,209] | 11 |
| Thu thập Thủ Khố (Ngọc Hư) (Đạo Sĩ) | 16 = 13 | đồ rơi | Bãi Tuyết Quái (Chân núi Côn Lôn) | 1008 | 1761, 3243 [220,202] | 12 |
| Tân Thức (Xi Vưu) (Dị Nhân) | 31 = 5 | đồ rơi | Bãi Hỏa Diện (Cự Lộc) | 1013 | 1687, 3071 [210,191] | 15 |
| Thần Khí (Dị Nhân) | 35 = 3–5 | tự đánh | Thảo Tiên Bà Bà (Miêu Cương) | 1012 | 1596, 3308 [199,206] | 1 |
| Mở rương (Xi Vưu) (Dị Nhân) | 33 = 1 | đồ rơi | Bãi Cuồng Điêu (Du Hồn) | 1011 | 1679, 3250 [209,203] | 34 |
| Thu thập Thủ Khố (Xi Vưu) (Dị Nhân) | 36 = 8 | đồ rơi | Bãi Cuồng Điêu (Du Hồn) | 1011 | 1679, 3250 [209,203] | 34 |
| Thu thập Thủ Khố (Xi Vưu) (Dị Nhân) | 36 = 12 | đồ rơi | Bãi Hỏa Diện (Cự Lộc) | 1013 | 1687, 3071 [210,191] | 15 |
| Thiên Thụ - tưới nước | 321 = 8 | đồ rơi | Bãi Cuồng Điêu (Du Hồn) | 1011 | 1679, 3250 [209,203] | 34 |
| Thiên Thụ - tưới nước | 321 = 9 | đồ rơi | Bãi Băng Lang, Yểm Hỏa | 1009 | 1691, 3347 [211,209] | 11 |
| Thiên Thụ - tưới nước | 321 = 10 | đồ rơi | Bãi Kiếm Nhân (Sùng Thành dã ngoại) | 1005 | 1660, 3058 [207,191] | 12 |
| Thiên Thụ - tưới nước | 321 = 11 | đồ rơi | Bãi Xà Thần (Bắc Hải) | 1006 | 1728, 2869 [216,179] | 22 |
| Thiên Thụ - tưới nước | 321 = 12 | đồ rơi | Bãi Hỏa Diện (Cự Lộc) | 1013 | 1687, 3071 [210,191] | 15 |
| Thiên Thụ - tưới nước | 321 = 13 | đồ rơi | Bãi Tuyết Quái (Chân núi Côn Lôn) | 1008 | 1761, 3243 [220,202] | 12 |
| Tiên Ma giới | 2283 = 38 | tự đánh | Bãi quái Ngục Pháp Sơn | 1075 | 1695, 3340 [211,208] | 13 |
| Vi Lao | 50 = 5 | đồ rơi | Thi Thú (Bích Du tầng 2) | 1043 | 1700, 3388 [212,211] | 1 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 13) | tự đánh | Trừ Yêu - bãi Ngưu Sát | 1014 | 1429, 3332 [178,208] | 16 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 16) | tự đánh | Trừ Yêu - bãi Dạ Xoa | 1016 | 1528, 3339 [191,208] | 38 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 17) | tự đánh | Trừ Yêu - bãi Thiên Hao | 1018 | 1711, 3019 [213,188] | 11 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 18) | tự đánh | Trừ Yêu - bãi Sa Hồn | 1022 | 1796, 3478 [224,217] | 19 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 20) | tự đánh | Trừ Yêu - bãi Lục Quỷ | 1037 | 1589, 3196 [198,199] | 11 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 23) | tự đánh | Trừ Yêu - bãi Lão Hồ Lô | 1028 | 1608, 3053 [201,190] | 22 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 28) | tự đánh | Trừ Yêu - bãi Băng Linh | 1032 | 1978, 3054 [247,190] | 16 |
| Trừ Yêu (sư môn) | 898 = 1–999 (897 = 30) | tự đánh | Trừ Yêu - bãi Anh Chiêu Thần | 1033 | 1733, 3225 [216,201] | 15 |
| Đông Di | 597 = 3 | tự đánh | Bãi Lam Cốt (Bích Du) | 1045 | 1492, 3096 [186,193] | 16 |
| Đông Di | 597 = 7 | đồ rơi | Bãi Lam Cốt (Bích Du) | 1045 | 1492, 3096 [186,193] | 16 |
| Đông Di | 597 = 13 | tự đánh | Bãi Phi Thố (Khai Minh đảo) | 1072 | 1534, 3236 [191,202] | 27 |
| Đông Di | 597 = 300 | đồ rơi | Bãi Phi Thố (Khai Minh đảo) | 1072 | 1534, 3236 [191,202] | 27 |
| Đông Di | 597 = 30 | đồ rơi | Bãi Chúc Thần, Thiết Tinh (Thánh Địa) | 1076 | 1797, 3560 [224,222] | 13 |
| Đông Di - Yển Long | 589 = 2–21 | tự đánh | Bãi Thiết Cốt (Giai Mộng Quan) | 1073 | 2031, 3746 [253,234] | 9 |
| Đông Di - Yển Hổ | 590 = 2–21 | tự đánh | Bãi Huyết Yêu (Giai Mộng Quan) | 1073 | 2054, 3303 [256,206] | 8 |
| Đông Di - Yển Lang | 591 = 2–21 | tự đánh | Bãi Thiết Tinh (Thánh Địa) | 1076 | 1756, 3512 [219,219] | 6 |
| Thiên Cương Hồn | 2144 (theo điểm được giao) | tự đánh | Bãi Ảnh Tử (Thiên Cương Hồn) × 10 điểm | 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051 | ô do script chọn, kiểm tra đi được | điểm cố định |
| Siêu Độ | 2148 (theo điểm được giao) | tự đánh | Chiêu Hồn Trận (Siêu Độ, Mã Đế) × 41 điểm | 1005, 1007, 1008, 1010, 1011, 1013, 1015, 1017, 1018, 1019,  | ô do script chọn, kiểm tra đi được | điểm cố định |
| Hấp Hồn | 2152 (theo điểm được giao) | tự đánh | Đảo hút hồn (Hấp Hồn) × 2 điểm | 1055, 1056 | ô do script chọn, kiểm tra đi được | điểm cố định |
| Mã Đế | 2312 (theo điểm được giao) | tự đánh | Chiêu Hồn Trận (Siêu Độ, Mã Đế) × 41 điểm | 1005, 1007, 1008, 1010, 1011, 1013, 1015, 1017, 1018, 1019,  | ô do script chọn, kiểm tra đi được | điểm cố định |
| Lục Lâm | 2321 (theo điểm được giao) | tự đánh | Chỗ xe lương (Lục Lâm) × 3 điểm | 1016 | ô do script chọn, kiểm tra đi được | điểm cố định |

| Bãi quái | Bản đồ | Quái (template) | Tâm cụm (ô) | Ô đến | Cụm ≤ 20 ô | Nguồn |
|---|---|---|---|---|---|---|
| Bãi Kiếm Nhân (Sùng Thành dã ngoại) | 1005 | 0 | 1664, 3057 | 1660, 3058 | 8 | spawn_1005.lua tpl 0 |
| Bãi Xà Thần (Bắc Hải) | 1006 | 3 | 1728, 2865 | 1728, 2869 | 12 | spawn_1006.lua tpl 3 |
| Bãi Tuyết Quái (Chân núi Côn Lôn) | 1008 | 1 | 1765, 3242 | 1761, 3243 | 7 | spawn_1008.lua tpl 1 |
| Bãi Hỏa Diện (Cự Lộc) | 1013 | 2 | 1687, 3067 | 1687, 3071 | 7 | spawn_1013.lua tpl 2 |
| Bãi Băng Lang | 1008 | 4 | 2006, 3036 | 2006, 3040 | 6 | spawn_1008.lua tpl 4 |
| Bãi Băng Lang, Yểm Hỏa | 1009 | 4,8 | 1691, 3343 | 1691, 3347 | 9 | spawn_1009.lua tpl 4,8 |
| Bãi Cuồng Điêu (Du Hồn) | 1011 | 6 | 1679, 3246 | 1679, 3250 | 8 | spawn_1011.lua tpl 6 |
| Bãi Lục Quái | 1011 | 5 | 1822, 3435 | 1822, 3439 | 9 | spawn_1011.lua tpl 5 |
| Bãi Hoàn Cẩu (Yến Sơn) | 1007 | 7 | 1612, 3392 | 1612, 3396 | 6 | spawn_1007.lua tpl 7 |
| Kiếm Nhân Tướng Quân (Yến Sơn) | 1007 | 102 | 1876, 3336 | 1876, 3340 | 1 | spawn_1007.lua tpl 102 |
| Phản Quân Đội Trưởng (Yến Sơn) | 1007 | 101 | 1708, 3000 | 1708, 3004 | 3 | spawn_1007.lua tpl 101 |
| Thảo Tiên Bà Bà (Miêu Cương) | 1012 | 105 | 1596, 3304 | 1596, 3308 | 1 | spawn_1012.lua tpl 105 |
| Bãi Giáp Cốt, Hoàn Cẩu (Mạnh Tân) | 1015 | 13 | 1637, 3232 | 1637, 3236 | 8 | spawn_1015.lua tpl 13 |
| Bãi quái Tam Sơn | 1016 | mọi quái | 1686, 3350 | 1686, 3354 | 14 | Region VNG 1016 (dump NPC sống 15:16) (mọi quái) |
| Bãi Ngưu Sát (Đồng Quan) | 1014 | 12 | 1433, 3331 | 1429, 3332 | 7 | Region VNG 1014 (dump NPC sống 15:16) tpl 12 |
| Bãi quái Du Hồn | 1011 | mọi quái | 1822, 3435 | 1822, 3439 | 10 | spawn_1011.lua (mọi quái) |
| Bãi quái Mạnh Tân | 1015 | mọi quái | 1640, 3233 | 1640, 3237 | 11 | spawn_1015.lua (mọi quái) |
| Bãi quái Kỳ Sơn | 1017 | mọi quái | 1654, 3408 | 1654, 3412 | 8 | spawn_1017.lua (mọi quái) |
| Bãi quái Thủ Dương sơn | 1010 | mọi quái | 1444, 3271 | 1444, 3275 | 6 | spawn_1010.lua (mọi quái) |
| Thi Thú (Bích Du tầng 2) | 1043 | 114 | 1700, 3384 | 1700, 3388 | 1 | spawn_1043.lua tpl 114 |
| Bãi quái Ngục Pháp Sơn | 1075 | mọi quái | 1695, 3336 | 1695, 3340 | 8 | spawn_1075.lua (mọi quái) |
| Bãi Lam Cốt (Bích Du) | 1045 | 44 | 1492, 3092 | 1492, 3096 | 9 | spawn_1045.lua tpl 44 |
| Bãi Phi Thố (Khai Minh đảo) | 1072 | 421,422,423 | 1534, 3232 | 1534, 3236 | 15 | spawn_1072.lua tpl 421,422,423 |
| Bãi Thiết Cốt (Giai Mộng Quan) | 1073 | 750,751 | 2031, 3742 | 2031, 3746 | 5 | spawn_1073.lua tpl 750,751 |
| Bãi Huyết Yêu (Giai Mộng Quan) | 1073 | 747 | 2054, 3299 | 2054, 3303 | 5 | spawn_1073.lua tpl 747 |
| Bãi Thiết Tinh (Thánh Địa) | 1076 | 930 | 1756, 3508 | 1756, 3512 | 4 | spawn_1076.lua tpl 930 |
| Bãi Chúc Thần, Thiết Tinh (Thánh Địa) | 1076 | 930,934 | 1797, 3556 | 1797, 3560 | 4 | spawn_1076.lua tpl 930,934 |
| Trừ Yêu - bãi Ngưu Sát | 1014 | 12 | 1433, 3331 | 1429, 3332 | 7 | Region VNG 1014 (dump NPC sống 15:16) tpl 12 |
| Trừ Yêu - bãi Dạ Xoa | 1016 | 15 | 1528, 3343 | 1528, 3339 | 12 | Region VNG 1016 (dump NPC sống 15:16) tpl 15 |
| Trừ Yêu - bãi Thiên Hao | 1018 | 16 | 1711, 3015 | 1711, 3019 | 8 | spawn_1018.lua tpl 16 |
| Trừ Yêu - bãi Sa Hồn | 1022 | 17 | 1796, 3474 | 1796, 3478 | 9 | spawn_1022.lua tpl 17 |
| Trừ Yêu - bãi Lục Quỷ | 1037 | 19 | 1589, 3192 | 1589, 3196 | 5 | spawn_1037.lua tpl 19 |
| Trừ Yêu - bãi Lão Hồ Lô | 1028 | 22 | 1608, 3049 | 1608, 3053 | 10 | spawn_1028.lua tpl 22 |
| Trừ Yêu - bãi Băng Linh | 1032 | 27 | 1978, 3050 | 1978, 3054 | 8 | spawn_1032.lua tpl 27 |
| Trừ Yêu - bãi Anh Chiêu Thần | 1033 | 29 | 1733, 3221 | 1733, 3225 | 8 | spawn_1033.lua tpl 29 |

Điểm cố định do script nhiệm vụ chọn (quái sinh quanh người chơi khi tới): sd × 41, tch × 10, hh × 2, ll × 3.

**Còn lại không có bãi cố định (ghi rõ trong lệnh bài):**
- Vận Lương/Vận Tiêu là hộ tống xe; điểm đến là nơi giao xe.
- Vạn Tiên trận đánh trong phó bản 1079–1082, lệnh bài không vào phó bản; điểm đến là Thiên Hùng.
- Các bước Tiên Ma đánh quái gọi ra tại chỗ đã trỏ đúng chỗ gọi: Linh Xà Thụ, Liên Đăng Hộ Sứ, Thiên Niên Đại Thạch, La Bàn, Pháp trụ, Tứ Bất Tướng, vùng Ninh/Lang Vương [214,228].
- Chính tuyến, Minh Châu, Vi Lao, Phi Tiên, Quy Tinh, Khảo nghiệm, Cứu Tế, Giang Sơn: bước đánh quái đã trỏ quái nhiệm vụ từ trước.
- Thiên Thụ bón phân (Địa tâm, Phong lộ, Thủy hàn, Hỏa linh), Tân Miễn, Tứ Tượng: không script nào cho các vật phẩm này rơi từ quái, nên không có bãi; dùng Lệnh Bài Tiếp Tế.

### 2.8 Từng bước và chi tiết cho mọi nhiệm vụ (lenhbainv3 + lenhbainv4, 2026-10-04 21:21)

**Yêu cầu:**
- "Nhiệm vụ chính tuyến ở lệnh bài chưa có từng bước một và đưa đến vị trí chỉ định."
- Sau đó: "Ở Lệnh Bài Nhiệm Vụ phải chi tiết của từng nhiệm vụ nhé, rà soát lại toàn bộ."

**Kết quả:**
- Mỗi nhóm của menu chính (Tân thủ, Chính tuyến, Thế giới, Hàng ngày, Sự kiện) giờ là danh sách nhiệm vụ.
  - Chọn một nhiệm vụ để mở danh sách từng bước: `[>]` là bước đang làm, `[x]` là bước đã xong. Danh sách tự mở ở trang có bước hiện tại.
  - Chọn một bước để mở hộp chi tiết, có nút dịch chuyển.
  - Dòng cuối mỗi nhóm vẫn là "Danh sách NPC theo mốc cấp", tức menu cũ.
- Font client là TCVN3, không có ký tự ► và ✓, nên dùng `[>]` và `[x]`.

**Hộp chi tiết của một bước** (chia trang "Tiếp (trang x của y)" khi dài; mỗi dòng ≤ 100 byte, mỗi trang ≤ 420 byte):
- Tên nhiệm vụ, "Bước k/n", trạng thái: đang làm / đã xong / chưa tới / chuỗi của phái khác.
- "Việc cần làm": soạn từ chính script trả nhiệm vụ.
- "F11": dòng sổ nhiệm vụ mà script hiện khi tới bước này.
  - Lấy từ cặp `SetTask` / `QuestExchange` đi kèm `TaskNote`, bằng bộ taskinfo f11fix. Tân thủ mới lấy theo ghi chú của `nb2_data`.
  - Có cho 269 bước.
- NPC: tên, bản đồ, toạ độ hiển thị x.y.
- Quái: tên bãi, cấp quái, bản đồ, toạ độ hiển thị.
- Khóa tiến độ chưa đạt: ghi rõ cần làm gì, ví dụ "Cần chính tuyến tới bước 50…".
- Vật phẩm cần: tên, đang có, cần bao nhiêu (đọc trực tiếp từ túi).
- "Phải tự đánh…" ở các bước đánh quái.
- Điều kiện: cấp và phái.
- Thưởng theo F11, nếu taskinfo có dòng thưởng (29 nhiệm vụ).
- Nút "Dịch chuyển tới …", tối đa 4 nút: NPC giao/trả, bãi quái, điểm đặc biệt. Điểm do NPC giao (Quy Tinh, Thám Quân, Vận chuyển, Siêu Độ…) lấy theo biến task hiện tại.
- Từ "Nhiệm vụ đang làm" có thêm dòng "Chi tiết từng bước" để mở thẳng hộp chi tiết của bước hiện tại.

**Số liệu:**

| Nhóm | Nhiệm vụ | Bước | Bước có chữ F11 |
|---|---|---|---|
| Tân thủ (theo phái) | 21 | 224 | 133 |
| Chính tuyến | 4 (Giáp Sĩ 31 bước, Đạo Sĩ 31, Dị Nhân 32, Tiên Ma 44) | 138 | 66 |
| Thế giới | 17 | 93 | 43 |
| Hàng ngày | 14 | 59 | 27 |
| Sự kiện | 2 | 21 | 0 |
| **Tổng** | **58** (52 chuỗi; chuỗi theo phái tách theo phái) | **535** (gộp từ 661 dòng) | **269** |

**Gộp bước chính tuyến:**
- Mỗi giá trị biến là một bước. Bước dạng bit-mask là một bước có nhiều nút: Đạo Sĩ 10–16 (Hoàng Phi Hổ, Lý Tĩnh, Đặng Cửu Công), Giáp Sĩ 21–23 (Lý Tĩnh, Đặng Cửu Công).
- Bước 63 có 4 nút: Can Tương, Tôn Vũ, Biển Thước Tiền Thế và Võ Vương.
- Không có bước chính tuyến nào thiếu điểm đến. Các bước đánh quái trỏ tới quái nhiệm vụ.
- Các bước ở Viễn Cổ, Triều Ca/Ngọc Hư 10 năm giữ khóa tiến độ, nhưng nay nói rõ cần bước mấy.

**Lưu trữ:**
- Dữ liệu bước: `nhiemvu_data.lua`, mỗi nhiệm vụ một hàm nhỏ `PTNV_DQ<q>`.
- Chữ F11, thưởng và tên bản đồ: file mới `nhiemvu_detail.lua`, chỉ nạp khi mở hộp chi tiết đầu tiên.
- Ngữ cảnh chọn của từng người chơi lưu ở `PTNV_CX[tên]`, nên callback không cần tham số.

#### Rà soát chéo (review.py, dump NPC sống qua bridge lúc 21:18, chỉ đọc)

| Kiểm tra | Kết quả |
|---|---|
| (a) Điểm đến NPC có thật và đứng đúng chỗ | 192/192 NPC đích có NPC sống trong 2 ô. Bãi quái đã quét ở lenhbainv2: 35/35 có quái đúng template |
| (a) Ô đến đi được | 346/346 điểm có ô đi được trên lưới client/server (bậc 1: 344, Tạp Hóa Triều Ca bậc 2, Tây Vương Mẫu ngoài bục) |
| (b) Chữ mô tả khớp script | Chữ "Việc cần làm" soạn từ chính script trả (5 agent đọc `npc_fix`, `npc_restore`, PAK đã giải mã). So với chữ F11 script hiện tại cùng giá trị: 16 chỗ bị nghi, kiểm tay thì 5 chỗ F11 lệch script (bảng dưới), 11 chỗ khớp (khác cách viết tên) |
| (c) Mã vật phẩm và quái đúng | 137 cặp (biến, vật phẩm): 106 có trong script dạng số cố định. 31 tính từ biến trong script, kiểm tay đúng: Thu thập Thủ Khố, Thiên Thụ, Thiên Cống, Phúc Kim, Tứ Tượng (`3,d,0` theo biến), Tiên Ma 45 (`PT45_Has`). Template quái của 35 bãi khớp `mob_drop`, `nb2_data` và F11 |

#### Sai lệch tìm thấy và đã sửa

| # | Chỗ | Sai lệch | Đã sửa |
|---|---|---|---|
| 1 | Thám Quân (task 314) | Lệnh bài lấy Đại Phu của bản đồ `1000 + giá trị`. Script Đại Phu thật: giá trị 19 là Trần Đường 1065, giá trị 21 là Tuyệt Long lĩnh 1019, giá trị 20 không bao giờ được giao. Với 19 và 21, lệnh bài đưa tới Đại Phu không nhận tin | Thêm `PTNV_TQD(v)`, thêm điểm Đại Phu 1065. Sim kiểm 19, 21, 14, 22, 5 |
| 2 | Lệnh Bài Tiếp Tế, nhánh dự phòng | `AddItemIDStack(idx)` 1 đối số, engine từ chối khi < 2 nên vật phẩm xếp chồng không vào túi | `AddItemIDStack(idx, 0)`. Sim giả lập engine từ chối < 2 đối số |
| 3 | F11 lệch script: Tân Thức Sùng Thành 21=8, Linh lực 14=1, Tân Thức Xi Vưu 31=5, Vi Lao 50=3, Đông Di 597=14 | `TaskNote` của script còn dòng cũ, nói NPC hoặc việc khác với điều script kiểm | Không hiện dòng F11 ở 5 bước này, chỉ hiện "Việc cần làm" đúng script. Script gốc không sửa (ngoài phạm vi) |
| 4 | Chính tuyến | Chỉ thấy qua "Nhiệm vụ đang làm", từng điểm một | Danh sách từng bước, bit-mask và bước 63 hiện đủ nút |

#### Mô phỏng (`sim_lenhbainv.lua`, 4 chế độ: FAILS=0, 297 kiểm tra)
- Duyệt toàn bộ cho cả 3 phái: 5 nhóm → 126 lượt xem nhiệm vụ → 1.145 hộp chi tiết → 1.344 nút dịch chuyển.
  - Mỗi trang ≤ 7 dòng, nhãn menu không có "/", dòng menu ≤ 100 byte, dòng chi tiết ≤ 100 byte.
  - Mỗi hộp đều có "Bước k/n", "Việc cần làm", "Điều kiện" và ít nhất một nút, hoặc ghi "Điểm cụ thể do NPC giao".
  - Mọi nút dịch chuyển tới đúng ô khi đã mở khóa.
- Cả 58 nhiệm vụ đều có trong nhóm của nó. Dấu `[>]`/`[x]` đúng (Đạo Sĩ ở 31; xong chính tuyến ở 81 thì toàn `[x]`).
- Khóa Viễn Cổ ghi đúng điều kiện. "Chi tiết từng bước" mở từ "Nhiệm vụ đang làm".
- Thám Quân ánh xạ đúng Đại Phu. Nhánh dự phòng phát vật phẩm xếp chồng bằng `AddItemIDStack(idx, 0)`.
- Headroom: EMU `-Stack 100` 20 frame, EMU `-Stack 0` 39 frame.
- Áp nóng qua bridge 21:21 (`lbnv4_reload`): 346 điểm, 661 dòng, 58 nhiệm vụ, 535 bước, file chi tiết biên dịch được (269 F11).

### 2.9 Lệnh Bài Thám Quân (lenhbainv5, 2026-10-04 21:26)

**Yêu cầu:** "Lệnh bài Thám Quân: đưa hết đến nơi làm nhiệm vụ Thám Quân để hoàn thành, hoặc cũng có tính năng hoàn thành ngay."

**Chuỗi Thám Quân** (taskinfo 33, Hoàng Thiên Hóa ở Triều Ca, `npc_fix\1021_hoang_thien_hoa.lua`):

| Biến | Ý nghĩa |
|---|---|
| 314 | 0 = chưa nhận. 5–51 = Đại Phu dã ngoại phải gặp. 100 = đã lấy tin, về báo |
| 315 / 316 / 317 | Ngày / cờ hủy / số lượt đã xong trong ngày (tối đa 10) |

- **Nhận lượt:** Hoàng Thiên Hóa (`check_2`) chọn 314 ngẫu nhiên theo mốc cấp: ≤ 30, 31–40, 41–50, > 50.
- **Điểm kích hoạt:** nói chuyện với Đại Phu dã ngoại có script `\script\龙套\野外医生-<map>.lua`. Script kiểm `GetTask(314) == v`, rồi `SetTask(314, 100)`, chỉ vậy. Không có trap, không có quái.
- **Trả lượt:** Hoàng Thiên Hóa (`wancheng_1`) cần 314 = 100. Nộp `(cấp/10 − 3) × 2000 + 2000` lượng, nhận kinh nghiệm, đặt 314 = 0, tăng 317.
- **Ánh xạ giá trị → Đại Phu** (đọc từ 46 script Đại Phu và nơi gắn chúng: `ext\congthanh.lua`, `ext\sudo_dongdi.lua`, region 1014/1015/1016):
  - giá trị = số bản đồ (1005–1018, 1022–1051), trừ hai ngoại lệ:
    - 19 = Trần Đường 1065;
    - 21 = Tuyệt Long lĩnh 1019;
  - 20 không bao giờ được giao;
  - 1023/1026/1029/1030 dùng script chung (nhận 10, 23, 26, 29, 30);
  - 1014/1015/1016 là Đại Phu region VNG (Đồng Quan 1572,3373; Mạnh Tân; Tam Sơn), không phải Đại phu tân thủ.

**Vật phẩm:**
- "Lệnh Bài Thám Quân", magicscript **61432**. Đã quét lại `extra_*.py`: các id 61420, 61430–61431, 61470–61471, 61480–61482, 61500, 61520–61521 đã dùng.
- Hình: VNG dòng 7010 "Lệnh Bài Giải Đấu" (`\spr\item\vng\20170208\lenh_bai_giai_dau.spr`).
- Script `\script\phongthan\item\thamquan_lenhbai.lua`. Dòng magicscript do plug-in `extra_lenhbainv.py` thêm (dòng thứ 3).
- Dùng mãi, không mất. Web admin: khóa `ThamQuanToken`, nút "Phát Lệnh Bài Thám Quân".

**Menu** (≤ 6 dòng):
- Tiêu đề: trạng thái (chưa nhận / điểm được giao [x,y] / đã lấy tin, về báo) và "Hôm nay đã xong N của 10 lượt".
- Các dòng:
  1. "Tới điểm được giao: Đại Phu <bản đồ>": dịch chuyển cạnh Đại Phu. Người chơi tự nói chuyện, script gốc ghi nhận như khi tự đi tới.
     - Không có lượt: "Tới Hoàng Thiên Hóa nhận lượt".
     - Đã lấy tin: "Về báo Hoàng Thiên Hóa".
  2. "Đi lần lượt điểm còn thiếu": mỗi lần dùng đưa tới chỗ kế tiếp của vòng (Đại Phu được giao → Hoàng Thiên Hóa → …). Mỗi lượt chỉ có 1 điểm.
  3. "Hoàn thành ngay điểm được giao" (chỉ khi 314 = 5–51, có hộp xác nhận): đặt `SetTask(314, 100)`, đúng như script Đại Phu.
     - Không phát thưởng, không đổi 315/316/317. Thưởng và trừ lượng bạc vẫn diễn ra ở Hoàng Thiên Hóa khi về báo.
     - Ghi log `thamquan` vào `result.log`.
  4. "Danh sách điểm thám quân": 46 điểm trên 12 trang, `[>]` ở điểm đang được giao. Chọn để dịch chuyển.
  5. "Về Hoàng Thiên Hóa".
  6. "Đóng".
- Chặn dùng ở Thiên Lao, Vạn Tiên, chiến trường, Khai Minh đảo, Huyền Vũ và phó bản.

**Mô phỏng `sim_thamquan.lua`:** FAILS=0 (39 kiểm tra) ở `-Stack 100` và EMU (headroom 36 frame).
- Với mọi giá trị 5–51: menu, "đi lần lượt" tới đúng Đại Phu nhận giá trị đó, xác nhận rồi "hoàn thành ngay" chỉ ghi đúng 314 = 100 (317 không đổi), sau đó "đi lần lượt" về Hoàng Thiên Hóa.
- Không ghi gì khi 314 = 0, 100 hoặc 20.
- Danh sách 46 điểm, bản đồ cấm, bản đồ chưa mở.

**Triển khai:**
- File rời đã cài.
- Đã đăng ký nóng qua bridge (`ReLoadScript`, có giữ lại `main()` của servertimer khi kiểm tra biên dịch).
- Web admin đã sửa: người dùng tự mở lại web admin.
- Build thử ptfix `scratchpad\lenhbainv\ptfix_test*.pak` (Client 45 / Server 620 entry) có dòng 61432. Vật phẩm cần **ptfix chính thức mới** (coordinator build), cài cho Server + Client, rồi khởi động lại GameServer để client thấy tên/hình.

### 2.7 Kết quả mô phỏng

| Mô phỏng | Kết quả |
|---|---|
| `sim_lenhbainv.lua -Stack 100` | **FAILS=0** (254 kiểm tra) |
| lenhbainv2 `sim_lenhbainv.lua` (`-Stack 100`, EMU `-Stack 100`, live, emulive `-Stack 0`) | **FAILS=0** (266 kiểm tra), headroom tối thiểu 25 frame (EMU `-Stack 100`) / 39 frame (EMU `-Stack 0`). Thêm kiểm tra: cả 232 bước tự đánh có điểm đến, 162 bước đưa đúng bãi và dịch chuyển được; bước đồ rơi đưa tới bãi khi thiếu đồ và về NPC khi đủ; 11 kịch bản bãi quái |
| `sim_lenhbainv.lua -Stack 100 -Args1 emu` | FAILS=0, headroom tối thiểu 27 frame |
| `sim_lenhbainv.lua -Stack 0 -Args1 emu` (như `sim_luyencong`: lối vào vật phẩm 47 frame, tick 40) | FAILS=0, headroom tối thiểu 39 frame |
| `-Args1 live` / `emulive` (file đã cài) | FAILS=0 |
| `sim_nb.lua` (đồ tân thủ) với `starter_gear.lua` đã sửa | Giống hệt trước khi sửa |
| `sim_luyencong.lua live` | 1 kiểm tra đếm số lần `AddNormalItem` ở tick 2 lệch, do tick giờ phát thêm 2 lệnh bài mới cho người túi đầy. Hành vi Lệnh Bài Luyện Công không đổi |

Nội dung kiểm tra:
- menu ≤ 7 dòng, mọi callback tồn tại;
- 250 lệnh `PTNV_G<i>` đều tới đúng ô, thành bật trạng thái phi chiến đấu, ra ngoài bật chiến đấu;
- khóa tiến độ 1074/1075/1076/1064/1061;
- duyệt mọi trang của 5 nhóm cho cả 3 phe, không hiện NPC phe khác;
- bản đồ cấm, map chưa mở, `NewWorld` thất bại;
- 18 kịch bản "đang làm";
- **cả 536 dòng bước đều nhận ra đúng giá trị task**, hộp chi tiết của cả hai lệnh bài hợp lệ, và "Xác nhận" phát đủ, không thừa;
- túi đầy, tạo vật phẩm thất bại, bước tự đánh không đổi biến task;
- phân trang danh sách đang làm;
- tự phát: người mới được phát, người đã có không bị phát thêm, túi đầy thì thử lại, chưa có dòng ptfix thì chờ, lỗi được bắt.

## Phần 3: Hành động

### 3.1 Coordinator

- [ ] Build ptfix chính thức (Client trước, Server sau). Plug-in `extra_lenhbainv.py` tự được nạp. Bản thử `scratchpad\lenhbainv\ptfix_test_client.pak` (42 entry) và `ptfix_test.pak` (617 entry) có `magicscript.txt` 5.779 dòng, gồm 61420, 61430 và 61431 đủ 34 cột.
- [ ] Triển khai ptfix cho Server **và** Client (client cần dòng magicscript để hiện tên, mô tả, hình).
- [ ] Người dùng khởi động lại GameServer. Script rời mới được đăng ký lúc khởi động, và `starter_gear.lua` mới được nạp lại.
- [ ] Người dùng đóng, mở lại web admin rồi F5 trình duyệt.

### 3.2 Người chơi kiểm tra trong game

- [ ] Trong 1 phút sau khi online: nhận 2 thông báo và thấy 2 lệnh bài trong túi.
- [ ] Lệnh Bài Nhiệm Vụ → "Nhiệm vụ đang làm": thấy chuỗi đang làm. Chọn → "Dịch chuyển tới …": đứng cạnh NPC.
- [ ] Mở 5 nhóm, lật trang, thử vài NPC ở mỗi nhóm. "Quay lại" về đúng trang trước.
- [ ] Lệnh Bài Tiếp Tế ở bước cần đồ (ví dụ Tân Thức Xi Vưu bước 5 = 10 Mặt Quỷ; Thiên Cống; Phúc Kim): xem danh sách → Xác nhận → đem nộp NPC được ngay.
- [ ] Để túi đầy rồi xác nhận: phải hiện thông báo cần ô trống, không rơi đồ ra đất.
- [ ] Vào Vạn Tiên trận hoặc Thiên Lao rồi dùng lệnh bài: phải bị chặn.
- [ ] Web admin: hai nút "Phát Lệnh Bài Nhiệm Vụ" và "Phát Lệnh Bài Tiếp Tế".

### 3.3 Rollback

- Khôi phục `starter_gear.lua`, `PhongThan-Admin.ps1`, `index.html` từ `_backup\20261004-lenhbainv\` (cùng đường dẫn tương đối).
- Xóa 4 file `item\nhiemvu_*.lua`, `item\tiepte_lenhbai.lua` và plug-in `extra_lenhbainv.py`, rồi build lại ptfix.
- Task 2611/2612 vô hại nếu để lại.

## Phần 4: Tài liệu tham khảo

### Tệp

| Loại | Đường dẫn |
|---|---|
| Script vật phẩm | `Server\script\phongthan\item\nhiemvu_lenhbai.lua`, `tiepte_lenhbai.lua` |
| Thư viện + dữ liệu | `Server\script\phongthan\item\nhiemvu_data.lua` |
| Tự phát | `Server\script\phongthan\item\nhiemvu_give.lua`; đã sửa `Server\script\phongthan\newbie\starter_gear.lua` |
| Web admin (đã sửa) | `AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html` |
| Plug-in PAK | `scratchpad\ptfix\extra_lenhbainv.py` |
| Generator và dữ liệu nguồn | `scratchpad\lenhbainv\`: `gen.py`, `chains.py`, `chains2.py`, `dests.py`, `dests2.py`, `cells.py`, `pick_all.py`, `patch_starter.py`, `npcs_live.txt`, `dests_final.json` |
| Chẩn đoán bridge | `scratchpad\lenhbainv\diag_npcdump.lua`, `diag_load.lua` |
| Mô phỏng | `scratchpad\qtest\sim_lenhbainv.lua` → `out_lenhbainv*.txt` |
| Sao lưu | `_backup\20261004-lenhbainv\` |

### Bước tiếp theo

- ~~Sửa 4 chỗ kẹt chuỗi ở 2.5.~~ Đã xong (questfix3, 2026-10-04).
- Thêm dòng "chưa nhận" cho nhiệm vụ thế giới nếu muốn gợi ý theo cấp.

### Bảng điểm đến

Toạ độ tính theo ô (= mps/32, đơn vị của `NewWorld`). Màn hình là [x/8, y/16].

| Nhóm | Điểm đến | Cấp | Bản đồ | NPC (ô) | Ô đến (màn hình) | Nguồn |
|---|---|---|---|---|---|---|
| Tân thủ | Cao Giác (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1644, 3160 | 1644, 3162 [205,197] | npc_regions 1004 |
| Tân thủ | Cao Minh (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1652, 3176 | 1652, 3178 [206,198] | npc_regions 1004 |
| Tân thủ | Chúc Dung - Thần Khí (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1548, 3272 | 1548, 3274 [193,204] | npc_regions 1004 |
| Tân thủ | Cộng Công (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1540, 3272 | 1540, 3274 [192,204] | npc_regions 1004 |
| Tân thủ | Hậu Thổ - Tân Thức (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1620, 3272 | 1620, 3274 [202,204] | npc_regions 1004 |
| Tân thủ | Hình Thiên - Tầm bảo (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1556, 3208 | 1556, 3210 [194,200] | npc_regions 1004 |
| Tân thủ | Hoàng Long Chân Nhân (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1636, 3128 | 1636, 3130 [204,195] | npc_regions 1003 |
| Tân thủ | Khoa Phụ (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1524, 3272 | 1526, 3273 [190,204] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Linh Bảo Đại Pháp Sư (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1652, 3128 | 1652, 3130 [206,195] | npc_regions 1003 |
| Tân thủ | Nam Cực Tiên Ông - Ngũ Thất (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1676, 3064 | 1676, 3066 [209,191] | npc_regions 1003 |
| Tân thủ | Phong Bá - Cứu Tế (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1564, 3272 | 1564, 3274 [195,204] | npc_regions 1004 |
| Tân thủ | Quân Sư tân thủ (chuỗi mới) (Giáp Sĩ) | 1 | 1002 Sùng Thành doanh | 1632, 3200 | 1632, 3202 [204,200] | ext\\newbie2.lua PTNB2_NPCS |
| Tân thủ | Quân Sư tân thủ (chuỗi mới) (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1688, 3120 | 1688, 3122 [211,195] | ext\\newbie2.lua PTNB2_NPCS |
| Tân thủ | Quân Sư tân thủ (chuỗi mới) (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1560, 3216 | 1560, 3218 [195,201] | ext\\newbie2.lua PTNB2_NPCS |
| Tân thủ | Tạp Hóa Thương (Giáp Sĩ) | 1 | 1002 Sùng Thành doanh | 1660, 3176 | 1660, 3178 [207,198] | npc_regions 1002 |
| Tân thủ | Tạp Hóa Thương (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1729, 3221 | 1729, 3223 [216,201] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Tạp Hóa Thương (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1623, 3230 | 1623, 3232 [202,202] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Thiếu Hạo - Khai Trí (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1588, 3272 | 1588, 3274 [198,204] | npc_regions 1004 |
| Tân thủ | Thợ Đồng (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1737, 3237 | 1737, 3239 [217,202] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Thợ Đồng (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1631, 3246 | 1631, 3248 [203,203] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Thủ Khố - Thu thập (Giáp Sĩ) | 1 | 1002 Sùng Thành doanh | 1620, 3176 | 1620, 3178 [202,198] | npc_regions 1002 |
| Tân thủ | Thủ Khố - Thu thập (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1739, 3202 | 1739, 3200 [217,200] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Thủ Khố - Thu thập (Dị Nhân) | 1 | 1004 Xi Vưu mộ | 1576, 3219 | 1574, 3220 [196,201] | servertimer PTADM_NPC_SPAWN |
| Tân thủ | Tô Hộ - Hộp Gấm (Giáp Sĩ) | 1 | 1002 Sùng Thành doanh | 1604, 3272 | 1604, 3274 [200,204] | npc_regions 1002 (Tô Hộ) |
| Tân thủ | Triệu Lôi (Giáp Sĩ) | 1 | 1002 Sùng Thành doanh | 1732, 3160 | 1732, 3162 [216,197] | npc_regions 1002 |
| Tân thủ | Từ Hàng Đạo Nhân - Bách Lý, Tầm bảo (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1652, 3144 | 1652, 3146 [206,196] | npc_regions 1003 |
| Tân thủ | Xích Tinh Tử (Đạo Sĩ) | 1 | 1003 Ngọc Hư cung | 1708, 3160 | 1708, 3162 [213,197] | npc_regions 1003 |
| Tân thủ | Âu Thiên Hóa (Giáp Sĩ) | 3 | 1002 Sùng Thành doanh | 1652, 3144 | 1652, 3146 [206,196] | npc_regions 1002 |
| Tân thủ | Lỗ Hùng - Tân Thức, Tầm bảo (Giáp Sĩ) | 3 | 1002 Sùng Thành doanh | 1556, 3192 | 1556, 3194 [194,199] | npc_regions 1002 |
| Tân thủ | Sùng Ứng Bưu (Giáp Sĩ) | 3 | 1002 Sùng Thành doanh | 1691, 3176 | 1691, 3178 [211,198] | npc_regions 1002 |
| Tân thủ | Triệu Điền - Dũng Đao (Giáp Sĩ) | 7 | 1002 Sùng Thành doanh | 1748, 3176 | 1748, 3178 [218,198] | npc_regions 1002 |
| Tân thủ | Vân Trung Tử - Khảo nghiệm (Đạo Sĩ) | 7 | 1003 Ngọc Hư cung | 1724, 3112 | 1724, 3114 [215,194] | npc_regions 1003 |
| Tân thủ | Nhiên Đăng Đạo Nhân - Linh lực (Đạo Sĩ) | 12 | 1003 Ngọc Hư cung | 1652, 3080 | 1652, 3082 [206,192] | npc_regions 1003 |
| Tân thủ | Sùng Ứng Loan - Kiêm Ái (Giáp Sĩ) | 12 | 1002 Sùng Thành doanh | 1700, 3176 | 1700, 3178 [212,198] | npc_regions 1002 |
| Tân thủ | Sinh Hoạt Sư thôn (Giáp Sĩ) | 20 | 1002 Sùng Thành doanh | 1596, 3208 | 1596, 3210 [199,200] | npc_regions 1002 |
| Tân thủ | Sinh Hoạt Sư thôn (Đạo Sĩ) | 20 | 1003 Ngọc Hư cung | 1740, 3240 | 1740, 3242 [217,202] | npc_regions 1003 |
| Tân thủ | Sinh Hoạt Sư thôn (Dị Nhân) | 20 | 1004 Xi Vưu mộ | 1602, 3207 | 1602, 3209 [200,200] | npc_regions 1004 |
| Tân thủ | Đại phu Đồng Quan (tân thủ mới) | 21 | 1014 Đồng Quan | 1368, 3106 | 1368, 3104 [171,194] | ext\\newbie2.lua |
| Tân thủ | Đại phu Mạnh Tân (tân thủ mới) | 21 | 1015 Mạnh Tân | 1540, 3400 | 1540, 3402 [192,212] | npc_regions 1015 |
| Tân thủ | Đại phu Tam Sơn (tân thủ mới) | 21 | 1016 Tam Sơn | 1511, 3122 | 1511, 3124 [188,195] | ext\\newbie2.lua |
| Chính tuyến | Hình Thiên (Dị Nhân) | 25 | 1004 Xi Vưu mộ | 1556, 3208 | 1556, 3210 [194,200] | npc_regions 1004 |
| Chính tuyến | Hoàng Long Chân Nhân (Đạo Sĩ) | 25 | 1003 Ngọc Hư cung | 1636, 3128 | 1636, 3130 [204,195] | npc_regions 1003 |
| Chính tuyến | Sùng Hầu Hổ (Giáp Sĩ) | 25 | 1002 Sùng Thành doanh | 1700, 3096 | 1700, 3098 [212,193] | npc_regions 1002 |
| Chính tuyến | Trịnh Luân (Giáp Sĩ) | 25 | 1002 Sùng Thành doanh | 1604, 3256 | 1604, 3258 [200,203] | npc_regions 1002 |
| Chính tuyến | Chủ Tửu Điếm (Dị Nhân) | 35 | 1021 Triều Ca | 1820, 3128 | 1820, 3130 [227,195] | npc_regions 1021 |
| Chính tuyến | Đặng Cửu Công | 35 | 1016 Tam Sơn | 1635, 3173 | 1635, 3175 [204,198] | region 1016 (VNG) |
| Chính tuyến | Hoàng Phi Hổ | 35 | 1021 Triều Ca | 1852, 2968 | 1853, 2970 [231,185] | npc_regions 1021 |
| Chính tuyến | Lôi Chấn Tử (Đạo Sĩ) | 35 | 1020 Tây Kỳ | 1308, 3000 | 1308, 3002 [163,187] | npc_regions 1020 |
| Chính tuyến | Lý Tĩnh | 35 | 1065 Trần Đường | 1548, 3320 | 1548, 3322 [193,207] | npc_regions 1065 |
| Chính tuyến | Ngô Long (Dị Nhân) | 35 | 1015 Mạnh Tân | 1676, 3128 | 1676, 3130 [209,195] | npc_regions 1015 |
| Chính tuyến | Phong Lâm (Dị Nhân) | 35 | 1015 Mạnh Tân | 1538, 3399 | 1538, 3401 [192,212] | npc_regions 1015 |
| Chính tuyến | Sùng Hắc Hổ (Giáp Sĩ) | 35 | 1002 Sùng Thành doanh | 1708, 3208 | 1708, 3210 [213,200] | npc_regions 1002 |
| Chính tuyến | Hoàng Thiên Hóa | 45 | 1021 Triều Ca | 1716, 2952 | 1716, 2954 [214,184] | npc_regions 1021 |
| Chính tuyến | Khương Tử Nha | 45 | 1020 Tây Kỳ | 1268, 3032 | 1268, 3034 [158,189] | npc_regions 1020 |
| Chính tuyến | Thương Hạo (Dị Nhân) | 45 | 1015 Mạnh Tân | 1652, 3128 | 1652, 3130 [206,195] | npc_regions 1015 |
| Chính tuyến | Đa Bảo Đạo Nhân (Dị Nhân) | 55 | 1044 Bích Du 3 | 1924, 3080 | 1924, 3082 [240,192] | servertimer PTADM_NPC_SPAWN |
| Chính tuyến | Dương Tiễn | 55 | 1020 Tây Kỳ | 1324, 2968 | 1324, 2970 [165,185] | npc_regions 1020 |
| Chính tuyến | Hồ Hỷ Mị | 55 | 1021 Triều Ca | 1644, 2952 | 1644, 2954 [205,184] | npc_regions 1021 |
| Chính tuyến | Thổ Hành Tôn | 55 | 1021 Triều Ca | 1708, 2952 | 1708, 2954 [213,184] | npc_regions 1021 |
| Chính tuyến | Văn Thái Sư (Dị Nhân) | 55 | 1014 Đồng Quan | 1550, 3323 | 1550, 3325 [193,207] | region 1014 (VNG) |
| Chính tuyến | Đắc Kỷ | 65 | 1021 Triều Ca | 1764, 2872 | 1764, 2874 [220,179] | npc_regions 1021 |
| Chính tuyến | Tây Vương Mẫu | 70 | 1052 Diêu Trì | 1773, 3010 | 1770, 3015 [221,188] | region 1052 (VNG) |
| Chính tuyến | Tiếp Dẫn Đạo Nhân - Tiên Ma giới | 75 | 1020 Tây Kỳ | 1476, 3060 | 1476, 3062 [184,191] | ext\\tienma.lua |
| Chính tuyến | Tiếp Dẫn Đạo Nhân - Tiên Ma giới | 75 | 1021 Triều Ca | 1776, 3047 | 1776, 3049 [222,190] | ext\\tienma.lua |
| Chính tuyến | Võ Vương | 75 | 1020 Tây Kỳ | 1276, 3032 | 1276, 3034 [159,189] | npc_regions 1020 |
| Thế giới, thành thị | Sư đồ - Hoàng Phi Hổ | 20 | 1021 Triều Ca | 1852, 2968 | 1853, 2970 [231,185] | npc_regions 1021 |
| Thế giới, thành thị | Thầy Tướng Số Triều Ca | 23 | 1021 Triều Ca | 1716, 3128 | 1716, 3130 [214,195] | npc_regions 1021_03 |
| Thế giới, thành thị | Yên Phúc - Tống Dị Nhân | 23 | 1021 Triều Ca | 1532, 3032 | 1532, 3034 [191,189] | npc_regions 1021_06 |
| Thế giới, thành thị | Phu Thê - Nhậm Đại Tẩu | 27 | 1020 Tây Kỳ | 1362, 3127 | 1362, 3129 [170,195] | npc_regions 1020_13 |
| Thế giới, thành thị | Thám Quân - Hoàng Thiên Hóa | 30 | 1021 Triều Ca | 1716, 2952 | 1716, 2954 [214,184] | npc_regions 1021_16 |
| Thế giới, thành thị | Tứ Tượng - Thủ Khố Tây Kỳ | 31 | 1020 Tây Kỳ | 1469, 3063 | 1470, 3065 [183,191] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Tứ Tượng - Thủ Khố Triều Ca | 31 | 1021 Triều Ca | 1715, 3036 | 1716, 3038 [214,189] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Thiên Thụ - Bá Giám | 35 | 1001 Phong Thần Đài | 1652, 3120 | 1652, 3122 [206,195] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Thiên Thụ - Tì Bà | 35 | 1021 Triều Ca | 1792, 2874 | 1792, 2876 [224,179] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Phi Tiên - Người Tây Vực | 39 | 1020 Tây Kỳ | 1484, 3080 | 1484, 3082 [185,192] | npc_regions 1020_03 |
| Thế giới, thành thị | Minh Châu - Chủ Cầm Đồ | 43 | 1021 Triều Ca | 1676, 3176 | 1676, 3178 [209,198] | npc_regions 1021_05 |
| Thế giới, thành thị | Minh Châu - Con Bạc | 43 | 1021 Triều Ca | 1636, 3144 | 1636, 3146 [204,196] | npc_regions 1021_04 |
| Thế giới, thành thị | Minh Châu - Cù Lưu Tôn | 43 | 1003 Ngọc Hư cung | 1654, 3166 | 1652, 3167 [206,197] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Minh Châu - Đồ Thư Quán | 43 | 1001 Phong Thần Đài | 1468, 3256 | 1468, 3258 [183,203] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Thầy Bói - Thất Quải, Long Châu | 45 | 1020 Tây Kỳ | 1420, 3151 | 1420, 3153 [177,197] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Thu thập - Tân Miễn | 50 | 1020 Tây Kỳ | 1524, 3046 | 1524, 3048 [190,190] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Vi Lao - Người Hái Thuốc | 57 | 1020 Tây Kỳ | 1428, 3084 | 1428, 3086 [178,192] | servertimer PTADM_NPC_SPAWN |
| Thế giới, thành thị | Vi Lao - Tiểu Bảo | 57 | 1020 Tây Kỳ | 1460, 3113 | 1460, 3115 [182,194] | npc_regions 1020_14 |
| Thế giới, thành thị | Vi Lao - Võ Cát | 57 | 1020 Tây Kỳ | 1452, 3128 | 1452, 3130 [181,195] | npc_regions 1020_05 |
| Thế giới, thành thị | Quy Tinh - Dương Tiễn | 59 | 1020 Tây Kỳ | 1324, 2968 | 1324, 2970 [165,185] | npc_regions 1020_01 |
| Thế giới, thành thị | Đông Di - Đặng Cửu Công | 70 | 1016 Tam Sơn | 1635, 3173 | 1635, 3175 [204,198] | region 1016 (VNG) |
| Thế giới, thành thị | Đông Di - Tôn Tử Vũ | 70 | 1002 Sùng Thành doanh | 1708, 3112 | 1708, 3114 [213,194] | ext\\sudo_dongdi.lua PTSD_NPCS |
| Hàng ngày, lặp lại | Vận chuyển - Tạp Thương Tây Kỳ | 10 | 1020 Tây Kỳ | 1567, 3025 | 1567, 3027 [195,189] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Bào Thương (chạy buôn) | 20 | 1020 Tây Kỳ | 1580, 3024 | 1580, 3026 [197,189] | servertimer PTADM_NPC_SPAWN |
| Hàng ngày, lặp lại | Lục Lâm Hảo Hán | 20 | 1016 Tam Sơn | 1373, 3465 | 1373, 3467 [171,216] | daily3\\d3_core.lua PTD3_LL_NPC |
| Hàng ngày, lặp lại | Siêu Độ, Mã Đế - Ân Hồng | 20 | 1001 Phong Thần Đài | 1516, 3192 | 1517, 3194 [189,199] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Trừ Yêu - Võ Sư (Giáp Sĩ) | 20 | 1002 Sùng Thành doanh | 1674, 3214 | 1674, 3216 [209,201] | ext\\sudo_dongdi.lua PTSD_NPCS |
| Hàng ngày, lặp lại | Trừ Yêu - Võ Sư (Đạo Sĩ) | 20 | 1003 Ngọc Hư cung | 1668, 3136 | 1668, 3138 [208,196] | ext\\sudo_dongdi.lua PTSD_NPCS |
| Hàng ngày, lặp lại | Trừ Yêu - Võ Sư (Dị Nhân) | 20 | 1004 Xi Vưu mộ | 1548, 3216 | 1548, 3218 [193,201] | ext\\sudo_dongdi.lua PTSD_NPCS |
| Hàng ngày, lặp lại | Vận Lương - Lương Thảo Quan | 20 | 1014 Đồng Quan | 1498, 3500 | 1498, 3502 [187,218] | ext\\vanluong.lua |
| Hàng ngày, lặp lại | Vận Lương - Tiêu Sư Đồng Quan | 20 | 1014 Đồng Quan | 1454, 3150 | 1454, 3152 [181,197] | region 1014 (VNG) |
| Hàng ngày, lặp lại | Thí luyện Hoang Mạc - Thổ Hành Tôn | 26 | 1021 Triều Ca | 1708, 2952 | 1708, 2954 [213,184] | npc_regions 1021_15 |
| Hàng ngày, lặp lại | Phúc Kim - Nhà Chiêm Tinh | 30 | 1020 Tây Kỳ | 1434, 3049 | 1434, 3051 [179,190] | ext\\daily3.lua |
| Hàng ngày, lặp lại | Phúc Kim - Nhà Chiêm Tinh Triều Ca | 30 | 1021 Triều Ca | 1724, 3018 | 1724, 3020 [215,188] | ext\\daily3.lua |
| Hàng ngày, lặp lại | Vận Tiêu - Tổng Tiêu Đầu | 30 | 1019 Tuyệt Long lĩnh | 1609, 2954 | 1609, 2956 [201,184] | ext\\vanluong.lua |
| Hàng ngày, lặp lại | Thí luyện Đông Hải - Na Tra | 31 | 1020 Tây Kỳ | 1336, 2960 | 1336, 2962 [167,185] | ext\\sudo_dongdi.lua PTSD_NPCS |
| Hàng ngày, lặp lại | Thí luyện Hiên Viên - Hoàng Thiên Hóa | 36 | 1021 Triều Ca | 1716, 2952 | 1716, 2954 [214,184] | npc_regions 1021_16 |
| Hàng ngày, lặp lại | Càn Khôn Luân - Thái Tuế Sư | 40 | 1020 Tây Kỳ | 1389, 3195 | 1389, 3197 [173,199] | ext\\cankhon2.lua |
| Hàng ngày, lặp lại | Thiên Cống - Tinh Quan | 40 | 1020 Tây Kỳ | 1424, 3000 | 1424, 3002 [178,187] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Thiên Cống - Tinh Quan Triều Ca | 40 | 1021 Triều Ca | 1797, 3046 | 1797, 3048 [224,190] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Thí luyện Băng Xuyên - Dương Tiễn | 41 | 1020 Tây Kỳ | 1324, 2968 | 1324, 2970 [165,185] | npc_regions 1020_01 |
| Hàng ngày, lặp lại | Thiên Cương Hồn - Ân Giao | 60 | 1001 Phong Thần Đài | 1472, 3088 | 1472, 3090 [184,193] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Tứ Linh - Thầy Tướng Số | 65 | 1020 Tây Kỳ | 1396, 3016 | 1396, 3018 [174,188] | npc_regions 1020_04 |
| Hàng ngày, lặp lại | Hấp Hồn - Thuyền Phu Đông Doanh | 80 | 1055 Đông Doanh | 1780, 3166 | 1780, 3168 [222,198] | ext\\daily2.lua |
| Hàng ngày, lặp lại | Hấp Hồn - Thuyền Phu Phương Trượng | 80 | 1056 Phương Trượng | 1807, 3188 | 1805, 3189 [225,199] | ext\\daily2.lua |
| Sự kiện, hoạt động | Lễ Quan - quà ngày, lễ hội | 1 | 1020 Tây Kỳ | 1472, 3052 | 1472, 3054 [184,190] | ext\\sinhhoat.lua |
| Sự kiện, hoạt động | Linh Thú Sứ | 1 | 1021 Triều Ca | 1763, 3074 | 1763, 3076 [220,192] | ext\\sinhhoat.lua |
| Sự kiện, hoạt động | Sinh Hoạt Sư - kỹ năng sống | 1 | 1020 Tây Kỳ | 1571, 3032 | 1571, 3034 [196,189] | ext\\sinhhoat.lua |
| Sự kiện, hoạt động | Công thành, Lãnh địa - Lãnh địa quan | 20 | 1020 Tây Kỳ | 1535, 3026 | 1535, 3028 [191,189] | ext\\congthanh.lua |
| Sự kiện, hoạt động | Giang Sơn Y Cựu - Dư Khánh | 30 | 1021 Triều Ca | 1560, 3200 | 1560, 3202 [195,200] | ext\\vienco.lua |
| Sự kiện, hoạt động | Vạn Tiên Trận - Thiên Hùng | 30 | 1020 Tây Kỳ | 1577, 3028 | 1577, 3030 [197,189] | vantien\\vt_data.lua PTVT_TH |
| Sự kiện, hoạt động | Viễn Cổ chiến trường - Chiến Sứ | 50 | 1001 Phong Thần Đài | 1514, 3284 | 1514, 3286 [189,205] | ext\\vienco.lua |
| Sự kiện, hoạt động | Thử Thách Huyền Vũ - Thí Luyện Thần Sứ | 70 | 1021 Triều Ca | 1723, 3121 | 1723, 3123 [215,195] | tutuong\\tt_tick.lua |
| Sự kiện, hoạt động | Tiếp Dẫn Đạo Nhân - Tiên Ma giới | 75 | 1021 Triều Ca | 1776, 3047 | 1776, 3049 [222,190] | ext\\tienma.lua |

| Điểm đến chỉ dùng cho "Nhiệm vụ đang làm" | Bản đồ | NPC/quái (ô) | Ô đến | Khóa tiến độ | Nguồn |
|---|---|---|---|---|---|
| Tạp Thương Sùng Thành | 1002 Sùng Thành doanh | 1745, 3154 | 1745, 3156 |  | ext\\daily2.lua |
| Tạp Thương Ngọc Hư | 1003 Ngọc Hư cung | 1608, 3209 | 1608, 3211 |  | ext\\daily2.lua |
| Tạp Thương Xi Vưu | 1004 Xi Vưu mộ | 1560, 3332 | 1560, 3334 |  | ext\\daily2.lua |
| Bắc Hải Thần Oanh (Bắc Hải) | 1006 Bắc Hải | 1708, 3272 | 1708, 3276 |  | PTADM_MOB_SPAWN |
| Phong Ấn Tháp Bắc Hải | 1006 Bắc Hải | 1736, 3152 | 1736, 3154 |  | servertimer PTADM_NPC_SPAWN |
| Phong Ấn Tháp Yến Sơn | 1007 Yến Sơn | 1608, 3344 | 1608, 3346 |  | servertimer PTADM_NPC_SPAWN |
| Phong Ấn Tháp Tây Côn Lôn | 1009 Tây Côn Lôn | 1656, 3248 | 1656, 3250 |  | servertimer PTADM_NPC_SPAWN |
| Dược Lâu Tử (Thủ Dương sơn) | 1010 Thủ Dương sơn | 1090, 3274 | 1090, 3278 |  | PTADM_MOB_SPAWN |
| Phong Ấn Tháp Thủ Dương | 1010 Thủ Dương sơn | 1088, 3168 | 1088, 3170 |  | servertimer PTADM_NPC_SPAWN |
| Phong Ấn Tháp Miêu Cương | 1012 Miêu Cương | 1568, 3168 | 1568, 3170 |  | servertimer PTADM_NPC_SPAWN |
| Phong Ấn Tháp Cự Lộc | 1013 Cự Lộc | 1736, 3152 | 1736, 3154 |  | servertimer PTADM_NPC_SPAWN |
| Thương Quân Hiệu Úy (Mạnh Tân) | 1015 Mạnh Tân | 1708, 3160 | 1708, 3164 |  | PTADM_MOB_SPAWN |
| Kim Hà Thú (Tam Sơn) | 1016 Tam Sơn | 1443, 3384 | 1443, 3388 |  | PTADM_MOB_SPAWN |
| Trấn Điện Tướng Quân (Mục Dã) | 1018 Mục Dã | 1500, 3032 | 1500, 3036 |  | PTADM_MOB_SPAWN |
| Nhậm Đại Ca | 1020 Tây Kỳ | 1364, 3128 | 1364, 3130 |  | npc_regions 1020_12 |
| Tạp Hóa Tây Kỳ | 1020 Tây Kỳ | 1556, 3016 | 1556, 3018 |  | servertimer PTADM_NPC_SPAWN |
| Tạp Hóa Triều Ca | 1021 Triều Ca | 1706, 3175 | 1707, 3177 |  | servertimer PTADM_NPC_SPAWN |
| Tạp Thương Triều Ca | 1021 Triều Ca | 1776, 3169 | 1776, 3171 |  | ext\\daily2.lua |
| Hoa Trư (Hoang Mạc) | 1022 Hoang mạc | 1463, 3073 | 1463, 3077 |  | PTADM_MOB_SPAWN |
| Bất Tử Thần Mộc (Phong Than) | 1024 Phong Than | 1700, 2904 | 1700, 2908 |  | PTADM_MOB_SPAWN |
| Chúc Ngư (Thủy Vực) | 1037 Thủy Vực | 1794, 3306 | 1794, 3310 |  | PTADM_MOB_SPAWN |
| Thể Ngư (Thủy Vực) | 1037 Thủy Vực | 1632, 2832 | 1632, 2836 |  | PTADM_MOB_SPAWN |
| Thố Ngư (Thủy Vực) | 1037 Thủy Vực | 1776, 2864 | 1776, 2868 |  | PTADM_MOB_SPAWN |
| Đông Hải Thần Long (Long Cung) | 1038 Long Cung | 1652, 2808 | 1652, 2812 |  | PTADM_MOB_SPAWN |
| An Cư Thú (Bích Du tầng 4) | 1045 Bích Du 4 | 1452, 3192 | 1452, 3196 |  | PTADM_MOB_SPAWN |
| Tranh Nanh (Khốn Tiên tầng 1) | 1047 Khốn Tiên 1 | 1580, 3400 | 1580, 3404 |  | PTADM_MOB_SPAWN |
| Biển Thước Tiền Thế (Khốn Tiên 2) | 1048 Khốn Tiên 2 | 1572, 3032 | 1572, 3036 |  | PTADM_MOB_SPAWN |
| Can Tương Tiền Thế (Khốn Tiên 3) | 1049 Khốn Tiên 3 | 1684, 3016 | 1684, 3020 |  | PTADM_MOB_SPAWN |
| Tôn Vũ Tiền Thế (Khốn Tiên 4) | 1050 Khốn Tiên 4 | 1436, 3160 | 1436, 3164 |  | PTADM_MOB_SPAWN |
| Đắc Kỷ lúc nhỏ | 1061 Ngọc Hư 10 năm trước | 1612, 3320 | 1612, 3322 | chính tuyến ≥ 80 | servertimer PTADM_NPC_SPAWN |
| Đội Trưởng Lục Soát | 1062 Ngọc Hư 10 năm sau | 1652, 3272 | 1652, 3276 | chính tuyến ≥ 72 | PTADM_MOB_SPAWN |
| Nguyên Thủy Thiên Tôn | 1062 Ngọc Hư 10 năm sau | 1612, 3304 | 1612, 3306 | chính tuyến ≥ 72 | servertimer PTADM_NPC_SPAWN |
| Đắc Kỷ (Triều Ca 10 năm sau) | 1063 Triều Ca 10 năm sau | 1522, 3286 | 1520, 3287 | chính tuyến ≥ 71 | servertimer PTADM_NPC_SPAWN |
| Hiên Viên (Viễn Cổ) | 1064 Viễn Cổ | 1580, 3208 | 1580, 3210 | chính tuyến ≥ 50 | servertimer PTADM_NPC_SPAWN |
| Thần Nông (Viễn Cổ) | 1064 Viễn Cổ | 1564, 3224 | 1564, 3226 | chính tuyến ≥ 50 | servertimer PTADM_NPC_SPAWN |
| Xi Vưu (Viễn Cổ) | 1064 Viễn Cổ | 1596, 3224 | 1596, 3226 | chính tuyến ≥ 50 | servertimer PTADM_NPC_SPAWN |
| Bạch Di | 1073 Bất Chu Thiên Quan | 1636, 3858 | 1636, 3860 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Liễu Nhân | 1073 Bất Chu Thiên Quan | 1642, 3842 | 1642, 3844 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Thiếu Nữ Di Tộc | 1073 Bất Chu Thiên Quan | 1628, 3864 | 1628, 3866 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Bá Ích | 1073 Bất Chu Thiên Quan | 1648, 3850 | 1648, 3852 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Hổ | 1073 Bất Chu Thiên Quan | 1648, 3870 | 1648, 3872 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Lang | 1073 Bất Chu Thiên Quan | 1656, 3870 | 1656, 3872 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Long | 1073 Bất Chu Thiên Quan | 1640, 3870 | 1640, 3872 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Phong | 1073 Bất Chu Thiên Quan | 1658, 3860 | 1658, 3862 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Yển Thúc Di | 1073 Bất Chu Thiên Quan | 1655, 3850 | 1655, 3852 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Đông Di - Ma Lễ Thọ (Giai Mộng Quan) | 1073 Bất Chu Thiên Quan | 1606, 3880 | 1606, 3882 | 597 ≥ 9 | ext\\sudo_dongdi.lua PTSD_NPCS |
| Đắc Kỷ (Bất Chu Thiên Quan) | 1073 Bất Chu Thiên Quan | 1956, 3304 | 1956, 3306 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Liên Đăng Hộ Sứ (phe Ma) | 1073 Bất Chu Thiên Quan | 1652, 3262 | 1652, 3264 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Liên Đăng Hộ Sứ (phe Tiên) | 1073 Bất Chu Thiên Quan | 1932, 3656 | 1932, 3658 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Linh Xà Thụ | 1073 Bất Chu Thiên Quan | 1776, 3600 | 1776, 3602 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Tu Hành Sư (phe Ma) | 1073 Bất Chu Thiên Quan | 1612, 3208 | 1612, 3210 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Tu Hành Sư (phe Tiên) | 1073 Bất Chu Thiên Quan | 1996, 3784 | 1994, 3785 | cấp 75 + đã chọn phe (2252) | ext\\tienma.lua |
| Hỏa Thần | 1074 Bất Chu Sơn | 1800, 3560 | 1800, 3562 | 2222 = 14 hoặc ≥ 20 | ext\\tienma.lua |
| Thiên Niên Đại Thạch | 1074 Bất Chu Sơn | 1988, 3612 | 1988, 3614 | 2222 = 14 hoặc ≥ 20 | ext\\tienma.lua |
| Thủy Thần | 1074 Bất Chu Sơn | 1830, 3580 | 1830, 3582 | 2222 = 14 hoặc ≥ 20 | ext\\tienma.lua |
| Tu Hành Sư Bất Chu Sơn (Ma) | 1074 Bất Chu Sơn | 1652, 3528 | 1652, 3530 | 2222 = 14 hoặc ≥ 20 | ext\\tienma.lua |
| Tu Hành Sư Bất Chu Sơn (Tiên) | 1074 Bất Chu Sơn | 1724, 3560 | 1724, 3562 | 2222 = 14 hoặc ≥ 20 | ext\\tienma.lua |
| Cổng thời gian | 1075 Ngục Pháp Sơn | 1848, 3464 | 1848, 3466 | 2222 ≥ 27 | ext\\tienma45.lua |
| La Bàn (vòng La Bàn) | 1075 Ngục Pháp Sơn | 1836, 3440 | 1836, 3442 | 2222 ≥ 27 | ext\\tienma45.lua |
| Pháp trụ Bắc | 1075 Ngục Pháp Sơn | 2023, 3196 | 2023, 3198 | 2222 ≥ 27 | ext\\tienma45.lua |
| Tứ Bất Tướng | 1075 Ngục Pháp Sơn | 1722, 3644 | 1722, 3646 | 2222 ≥ 27 | ext\\tienma45.lua |
| Tu Hành Sư Ngục Pháp Sơn (Ma) | 1075 Ngục Pháp Sơn | 1884, 3352 | 1884, 3354 | 2222 ≥ 27 | ext\\tienma45.lua |
| Tu Hành Sư Ngục Pháp Sơn (Tiên) | 1075 Ngục Pháp Sơn | 1844, 3576 | 1844, 3574 | 2222 ≥ 27 | ext\\tienma45.lua |
| Vùng Ninh Vương, Lang Vương (Thánh Địa) | 1076 Thánh Địa | 1712, 3648 | 1712, 3652 | 2283 ≥ 46 | tienma45\\tm45_lib.lua |
| Tu Hành Sư Thánh Địa (Ma) | 1076 Thánh Địa | 1644, 3240 | 1644, 3242 | 2283 ≥ 46 | ext\\tienma45.lua |
| Tu Hành Sư Thánh Địa (Tiên) | 1076 Thánh Địa | 1980, 3816 | 1980, 3818 | 2283 ≥ 46 | ext\\tienma45.lua |

Đại Phu dã ngoại (Thám Quân, Thí luyện): 47 bản đồ 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051.
Bãi quái Giang Sơn Y Cựu: 19 bước (vienco\\gs_data.lua), ô đến cách điểm sinh quái 3–7 ô.

| Mã | Chuỗi | Biến task | Số bước | Có phát đồ |
|---|---|---|---|---|
| 1 | Tân thủ mới | 2180, 2184 | 144 | có (3 bước) |
| 2 | Hộp Gấm | 20 | 11 | có (1 bước) |
| 3 | Tân Thức (Sùng Thành) | 21 | 9 | có (1 bước) |
| 4 | Mở rương (Sùng Thành) | 23 | 1 | có (1 bước) |
| 5 | Thu thập Thủ Khố (Sùng Thành) | 26 | 2 | có (2 bước) |
| 6 | Dũng Đao | 25 | 4 | có (3 bước) |
| 7 | Kiêm Ái | 24 | 4 | có (1 bước) |
| 8 | Bách Lý | 10 | 9 | không |
| 9 | Ngũ Thất | 11 | 5 | có (2 bước) |
| 10 | Khảo nghiệm | 15 | 5 | không |
| 11 | Linh lực | 14 | 2 | có (1 bước) |
| 12 | Mở rương (Ngọc Hư) | 13 | 1 | có (1 bước) |
| 13 | Thu thập Thủ Khố (Ngọc Hư) | 16 | 2 | có (2 bước) |
| 14 | Khai Trí | 30 | 9 | không |
| 15 | Tân Thức (Xi Vưu) | 31 | 6 | có (2 bước) |
| 16 | Thần Khí | 35 | 6 | có (2 bước) |
| 17 | Cứu Tế | 34 | 6 | có (1 bước) |
| 18 | Mở rương (Xi Vưu) | 33 | 1 | có (1 bước) |
| 19 | Thu thập Thủ Khố (Xi Vưu) | 36 | 2 | có (2 bước) |
| 20 | Chính tuyến | 1, 2, 3 | 123 | có (55 bước) |
| 21 | Thiên Thụ - tưới nước | 321 | 6 | có (6 bước) |
| 22 | Thiên Thụ - bón phân | 322 | 4 | có (4 bước) |
| 23 | Thiên Thụ - bắt sâu | 323 | 1 | có (1 bước) |
| 40 | Thiên Cống | 2142 | 6 | có (6 bước) |
| 41 | Thiên Cương Hồn | 2144 | 2 | không |
| 42 | Siêu Độ | 2148 | 2 | không |
| 43 | Hấp Hồn | 2152 | 2 | không |
| 44 | Vận chuyển | 2169 | tùy biến | có |
| 45 | Mã Đế | 2312 | 2 | không |
| 46 | Phúc Kim | 2316 | 5 | có (5 bước) |
| 47 | Lục Lâm | 2318, 2321 | 2 | không |
| 48 | Vận Lương | 2121 | 1 | không |
| 49 | Vận Tiêu | 2130 | 1 | không |
| 50 | Vạn Tiên trận | 2009 | 2 | không |
| 60 | Tiên Ma giới | 2222, 2283 | 51 | có (7 bước) |
| 70 | Giang Sơn Y Cựu | 2355, 2356, 2360 | tùy biến | không |
| 30 | Minh Châu | 41 | 13 | có (11 bước) |
| 31 | Vi Lao | 50 | 8 | có (3 bước) |
| 32 | Phi Tiên | 51 | 5 | có (1 bước) |
| 33 | Quy Tinh | 53 (byte trạng thái + bước) | tùy biến | có |
| 34 | Phu Thê | 92 | 3 | có (2 bước) |
| 35 | Yên Phúc | 91 | 3 | có (1 bước) |
| 36 | Thám Quân | 314 | tùy biến | không |
| 37 | Thu thập (Tân Miễn) | 310 | 14 | có (12 bước) |
| 38 | Tứ Tượng | 55 | 4 | có (4 bước) |
| 51 | Trừ Yêu (sư môn) | 898 | 6 | không |
| 52 | Thí luyện (sư đồ) | 899–902 | tùy biến | không |
| 53 | Đông Di | 597 | 32 | có (13 bước) |
| 54 | Đông Di - Yển Long | 589 | 3 | có (1 bước) |
| 55 | Đông Di - Yển Hổ | 590 | 3 | có (1 bước) |
| 56 | Đông Di - Yển Lang | 591 | 3 | có (1 bước) |


### Ghi chú 2026-10-05 (ktnfix): bước đầu chính tuyến

- Mô phỏng trên file runtime (`sim_ktnfix_lb.lua`, 19/0): với task = 0, từ cấp 25, "Nhiệm vụ đang làm" và danh sách "Chính tuyến" từng bước đều chỉ đúng NPC đầu chuỗi: Sùng Hầu Hổ 1002, Hoàng Long Chân Nhân 1003, Hình Thiên 1004. Generator không phải sửa.
- Lệnh bài cho phép dịch chuyển tới bước chưa tới, ví dụ bước 2 "đưa Thư tiến cử cho Khương Tử Nha". Người chơi tới đó khi chưa nhận chuỗi sẽ chỉ thấy câu chào VNG. Nay Khương Tử Nha có dòng "Chính tuyến - hướng dẫn" chỉ về NPC đầu chuỗi. Xem `ktn-chinh-tuyen-phong-than-20261005.md`.
