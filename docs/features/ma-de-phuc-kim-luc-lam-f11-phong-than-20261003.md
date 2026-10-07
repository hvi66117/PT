# Mã Đế, Phúc Kim, Lục Lâm Hảo Hán và F11 giai đoạn 2

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent `daily3`
> Trạng thái: **đã đặt file vào runtime, chưa nạp**. Tick `PTEXT_daily3_Tick()` đã có sẵn trong `servertimer.lua` (`PTADM_EXT_NAMES`). Cần coordinator dựng ptfix thật (Client + Server) và người dùng tự khởi động lại server.
> Mô phỏng: `sim_daily3.lua` 58/58 đạt ở cả `-Stack 100` và chế độ giả lập headroom của engine (47 khung cho NPC, 40 khung cho tick). Hồi quy không đổi. Chưa thử trong game.

## Phần 1: Tổng quan

### Insight chính
- **F11 của chuỗi 2004 hiện chữ sai, không chỉ thiếu.** `vng_tasknote_data.lua` sinh từ `taskinfo.ini` đời mới (serverlist.pak, 401 nhiệm vụ). Script chuỗi 2004 lại đánh số bước theo `taskinfo.ini` đời 2004 vẫn còn trong `ui.pak` (65 nhiệm vụ).
  - Ví dụ Hộp gấm (7) bước 1: bản mới ghi "Kim Quỳ, Mai Vũ", đúng ra là "Sùng Ứng Loan, Triều Lôi, Triều Điền".
  - Bách Lý (1) bước 5–8, Tân Thức (8) bước 4–8, Thu thập quân tình (31) bước 6–51: F11 báo **"Nhiệm vụ hoàn thành"** khi người chơi còn đang làm.
  - Thu thập quân tình (31) bước 0–1 rơi về chữ C++ "Task 31 - step 0".
- **Vẫn còn 44 script rời gọi `TaskNote` bằng bản C++.** Gồm 40 file `npc_restore` (bản sao 2004 của NPC trên bản đồ), `npc_quests\normal.lua` (script chết của mọi quái: Sư môn trừ yêu, nhiệm vụ hoa cỏ, liệt sát thành) và 3 script vật phẩm. Ngoài ra `NewTaskNote` (thi ném tuyết) chưa được bọc.
- **Đã sửa cả hai.** Kiểm toán lại (`scratchpad\daily3\f11_audit.py`):
  - 188/188 script PAK có hook;
  - mọi script rời đều có hook (riêng `sudo_dongdi_lib.lua` được các script include nó hook sẵn);
  - 567/569 cặp (id, bước) viết cứng có chữ đúng. 2 cặp còn lại: 24/3 không có chữ trong cả hai bản taskinfo; 36/30 nằm trong đoạn đã comment.
- **Mã Đế (81)** và **Phúc Kim (71)** chơi được: Mã Đế là vòng siêu độ liên tục sau 5 lần Siêu Độ hằng ngày; Phúc Kim là giao Bá Lạc Nhãn đổi bạc lớn.
- **Lục Lâm Hảo Hán** (phía cướp của Vận Lương) chơi được một mình, không cần IB buff:
  - Hảo Hán giao việc chặn đường xe lương quan phủ ở Tam Sơn.
  - Phá được xe thì có cờ Lua kèm **danh hiệu hiển thị** "Lục Lâm Đạo Tặc" / "Kim Bài Lục Lâm Đạo Tặc".
  - Về gặp Hảo Hán nhận thưởng theo công thức VNG.

### Nhận định quan trọng
- **IB buff 302/1306 không dùng được.** Engine này coi id IB buff là id kỹ năng (`ApplyNativeIBBuffState` → `CastStateSkill`). Skill 302 là "Phá Quân Chú" (cộng chí mạng), skill 1306 là "Phi Sa Tẩu Thạch". Gọi `AddIBBuff(302)` sẽ phát nhầm buff chiến đấu. Vì vậy dùng cờ task 2318 kèm danh hiệu rank 200/201.
- **Không sửa file của daily2 hay vanluong.**
  - Ân Hồng của daily2 được tick daily3 gắn sang `d3_anhong.lua`. File này Include nguyên `d2_anhong.lua` (chỉ đọc) và thêm một menu trước.
  - Phần nối với xe Vận Lương của người khác cần sửa `vl_core.lua`. Thay đổi đó viết ở Phần 3 để coordinator quyết.

## Phần 2: Chi tiết

### 2.1 Mã Đế (taskinfo 81), Ân Hồng, Phong Thần Đài 1516/3192
- Ân Hồng mở menu trước:
  1. "Siêu Độ Linh Hồn (hằng ngày)": hội thoại daily2, giữ nguyên.
  2. "Mã Đế": dòng mới.
  3. Kết thúc.
  Người chơi dưới cấp 40 vào thẳng hội thoại daily2.
- **Điều kiện:** cấp ≥ 40, và đã làm xong 5/5 lần Siêu Độ hôm nay. Hai giá trị này đọc từ biến 2140/2147 của daily2, chỉ đọc.
- **Mỗi vòng:**
  - Một điểm Chiêu Hồn Trận lấy từ dữ liệu `PTD2_SD_SPOTS` của daily2 (chọn hợp cấp bằng `PTD2_SdPick`).
  - 2 loại "Oán Linh <tên>", mỗi loại 3 con.
  - Chọn "Đưa ta tới" để dịch chuyển, hoặc tự đi tới (tick gọi đợt quái trong vòng 1 phút).
- **F11:** `TaskNote(81, 0/1/2/-1)` dùng đúng chữ taskinfo, ví dụ "Mã Đế: Hiện ngươi đã siêu độ được: A(2), B(1)".
- **Thưởng ("liên tục"):** cấp × 2.500 kinh nghiệm × (1 + 10% × số vòng đã làm hôm nay).
  - Vòng 5 thêm 1 **Mảnh Lam thủy tinh** (3,78); vòng 10 thêm 1 **Lam thủy tinh** (3,80).
  - Quà phát qua `QuestExchange`, túi đầy thì không mất gì.
  - Tối đa 10 vòng mỗi ngày.

### 2.2 Phúc Kim (taskinfo 71), Nhà Chiêm Tinh
- **Vị trí:** Triều Ca 1724/3018 và Tây Kỳ 1434/3049 (mappos taskinfo). Tick đặt NPC, dùng template 202.
- **Yêu cầu ngẫu nhiên:** 1 **Bá Lạc Nhãn cấp k** (vật phẩm 3/28+k), với tỉ lệ như bảng:

| Cấp | Tỉ lệ | Hứa tối thiểu | Thực nhận |
|---|---|---|---|
| 1 | 40% | 5 vạn | 5–7,5 vạn |
| 2 | 30% | 12 vạn | 12–18 vạn |
| 3 | 18% | 25 vạn | 25–37,5 vạn |
| 4 | 9% | 50 vạn | 50–75 vạn |
| 5 | 3% | 100 vạn | 100–150 vạn |

- Giao hàng qua `QuestExchange` có khóa biến 2316. Đổi yêu cầu tốn 20.000 lượng; có nút hủy. Tối đa 5 lần/ngày, cấp ≥ 30.
- **F11:** "Phúc Kim: Lần này ngươi phải mang Bá Lạc Nhãn cấp 2 đến cho Tinh Quân, sẽ nhận được ít nhất 12 vạn lượng!"
- **Nguồn Bá Lạc Nhãn:** Hoàng Minh ở Triều Ca hoàn nguyên thú cưỡi. Script PAK có `AddNormalItem(3,29..32)`.

### 2.3 Lục Lâm Hảo Hán (Tam Sơn 1016, 1373/3465)
- **NPC:**
  - Đây là NPC bản đồ VNG `绿林好汉`; script gốc `\script\运镖\绿林好汉.lua` chỉ có dạng file rời tên GBK nên engine không đọc được.
  - Tick daily3 tìm NPC theo tên, đổi tên thành "Lục Lâm Hảo Hán" và gắn `d3_luclam.lua`. Nếu bản đồ không có NPC này thì tick tự đặt ở vị trí VNG.
  - ptfix cũng biến đường dẫn GBK thành 1 dòng Include sang file rời.
- **Nhận việc:**
  - "Chặn đường cướp xe lương quan phủ" (cấp ≥ 20): 1 **Xe Lương Quan Phủ** (template 364 商车, đứng yên, đánh được) và 3 **Quan Binh Áp Lương** (template 891, cấp người chơi − 2, máu 800 + cấp²).
  - "Cướp xe quân lương Triều Ca" (cấp ≥ 50): 5 **Cấm Quân Áp Lương** (cấp người chơi, máu × 1,5).
  - Đoàn xe đứng ở 1 trong 3 bãi trống, cách Hảo Hán 30–40 ô: (1401,3448), (1373,3495), (1396,3438). Có 15 phút; tối đa 6 lần/ngày.
- **Phá xe:**
  - Bất kỳ ai trong đội phá xe đều tính cho chủ việc (khóa đợt quái giống daily2).
  - Chủ việc nhận cờ 2318 = 1 hoặc 2, hạn 60 phút. Danh hiệu rank 200/201 được bật bằng `ActiveTitleQualify` và `SetCurTitle`; `KNpc::SetRank` phát danh hiệu cho người chơi xung quanh, client hiện trong bảng thông tin nhân vật.
  - Danh hiệu cũ được lưu ở biến 2325 để trả lại sau.
- **Nhận thưởng** (giữ công thức của `绿林好汉.lua` VNG):
  - cấp × random(250, 500) lượng;
  - lần đầu mỗi ngày × 4;
  - Kim Bài × 1,5, và nếu có bang thì `AddTongAttr(0, 2)` (cần DLL mới của vanluong, có kiểm tra hàm tồn tại).
  - Nhận xong thì mất cờ và trả lại danh hiệu cũ.
- **Tick mỗi phút:** cờ hết hạn thì gỡ danh hiệu; việc quá 15 phút thì hủy; người chơi ở Tam Sơn mà đoàn xe đã mất thì gọi lại.
- **F11:** không có id taskinfo riêng, nên ghi bằng `AddNote` ở ô 28 (cùng ô với Vận lương, taskinfo 64).

### 2.4 F11 giai đoạn 2

| Lỗ hổng | Cách sửa | File |
|---|---|---|
| Id chuỗi 2004 đánh số theo taskinfo 2004 | `gen_data.py` lấy taskinfo đời 2004 từ `ui.pak`. Chỉ thay những id có **bước được gọi** mà bản mới không có còn bản 2004 có: 1, 2, 7, 8, 10, 13, 16, 31. Với các id này, dùng tiêu đề và bước 2004, bỏ bước đời mới. Các id khác giữ nguyên chữ (ví dụ 28/1 "cấp 35" khớp với Lôi Chấn Tử trong npc_fix, bản 2004 ghi cấp 15). **Vẫn một câu lệnh nhỏ mỗi dòng** (`s={} PT_TASKINFO[id]={t=..,s=s}` / `s[k]=..`), các bản ghi khác giữ nguyên từng byte | `lib\vng_tasknote_data.lua` (281.842 → 283.420 byte) |
| `NewTaskNote(id, bước, cờ, ...)` ra "Task N - step S" | Thêm `PTNewTaskNote`: bỏ tham số cờ, chuyển sang `PTTaskNote` | `lib\vng_tasknote.lua` |
| 44 script rời không có hook | Thêm 1 dòng `Include(vng_tasknote.lua)` **vào cuối file** (mức byte; phần thân TCVN3 không đổi) | 40 × `npc_restore\*.lua`, `npc_quests\normal.lua`, `item\hetuluoshu.lua`, `item\nuanlu.lua`, `item\shoutao.lua` |
| Script PAK | Đã đủ: `build_ptfix.py` chèn `pt_compat.lua` vào 359 script; kiểm toán thấy 188/188 script có lời gọi đều có hook | (không đổi) |

### 2.4b Vòng sửa f11fix (2026-10-03 tối): kiểm tra theo nghĩa
- **Lỗi người dùng gặp:** ở Xi Vưu Mộ, Hậu Thổ gọi `TaskNote(14,0)`, F11 ghi "Gặp Thợ Đồng…" (chữ đời mới). Chuỗi 2004 thật là Hậu Thổ → Cao Giác → Cao Minh → Hình Thiên → Cao Minh → Hậu Thổ.
- **Cách kiểm:** với mọi cặp (id, bước) mà script 2004 gọi (`npc_fix`, `npc_restore`, script PAK 2004), so chữ đời mới với chữ 2004 (`ui.pak`) theo hai tiêu chí:
  - NPC hoặc quái được nêu trong chữ có khớp với NPC/script gọi bước kế tiếp không;
  - phần thưởng nêu trong chữ có khớp với phần thưởng script thực sự phát không.
  Công cụ: `scratchpad\daily3\sem_audit.py` → `sem_audit.txt`, `sem_decide.py`.
- **Kết quả:**

| Nhóm | Quyết định | Lý do (ví dụ) |
|---|---|---|
| 1–18 (tân thủ Sùng Thành / Ngọc Hư / Xi Vưu) | Dùng nguyên bản 2004 (tiêu đề + mọi bước) | 14/0 "Tìm Cao Giác" thay cho "Gặp Thợ Đồng"; 13 "Khoa Phụ, Chúc Dung, Phong Bá" thay cho "Khoa Phụ, Hậu Thổ"; 17/1 "Tìm Cao Minh" (Cao Minh gọi bước 2); 5/4 và 4/1, 10/3, 16/6: script phát pháp bảo cấp 10 / sách khai khoáng đúng như chữ 2004 |
| 20 Minh Châu | Dùng 2004 | Cù Lưu Tôn chỉ đòi Bảo châu + 3 loại máu; chữ mới còn đòi Tha Sơn Thạch và đồng thau |
| 31 Thu thập quân tình, 43–46 Thí luyện | Dùng 2004 | Bản mới là nhiệm vụ khác (31), hoặc mất số bước "bước <trống>" (43–46) |
| 27/28/29 chuỗi chính | Giữ chữ mới, **trừ** 27/32–34, 28/36–37, 29/31–32 | Script npc_fix dùng mốc cấp đời mới (35/45/55/65/80) và thưởng đời mới (Nguyên Thủy cho Lam bảo thạch). Các bước cuối đời mới viết lại thành Bàn Cổ / Hàn Băng Chân Khí; script vẫn là "giao Phong Thần bảng cho Đắc Kỷ lúc nhỏ", "Sùng Ứng Bưu: đến tìm Sùng Hầu Hổ" |
| 21, 22, 24, 25, 26, 33, 35, 36, 42 | Giữ chữ mới | Cùng nghĩa với 2004. Riêng 21/4 (1 Liễu Mộc, 1 Côn Lôn Kính, 2 Đèn thần) và 26/5 (5000 kinh nghiệm + 20 sức lực) khớp script hơn chữ 2004 |

- **Trùng id giữa hai thời kỳ:** chỉ có 42/8, do `ext\sudo_dongdi_lib.lua` (đời mới) gọi. Đây vẫn là cùng nhiệm vụ Sư môn trừ yêu nên giữ chữ mới, không xung đột. newbie2/daily2/daily3/tienma không dùng id nào của taskinfo 2004.
- **File:** `vng_tasknote_data.lua` sinh lại từ bản trước daily3 (281.842 → 279.373 byte), vẫn một câu lệnh nhỏ mỗi dòng. Sao lưu ở `_backup\20261003-f11fix\`.

### 2.5 Biến nhiệm vụ (dải 2310–2339)
Đã quét file rời, `script.pak`, bộ đệm mọi PAK (`tutuong\eff`) và ptfix thử nghiệm. Chỉ trùng tọa độ (2320/2325/2331 trong `NewWorld`/`SetPos`), không có lời gọi `Get/SetTask` nào.

| Biến | Ý nghĩa |
|---|---|
| 2310 | Ngày reset (yyyymmdd) |
| 2311 / 2312 / 2313 / 2314 | Mã Đế: số vòng hôm nay / trạng thái / điểm / đếm A × 100 + B |
| 2315 / 2316 / 2317 / 2331 | Phúc Kim: số lần giao / cấp Bá Lạc Nhãn yêu cầu / số vạn hứa / số lần đổi yêu cầu |
| 2318 / 2319 / 2320 | Lục Lâm: cờ (1 thường, 2 Kim Bài) / hạn cờ / ngày nhận thưởng ×4 gần nhất |
| 2321 / 2322 / 2323 / 2324 / 2325 / 2326 | Việc cướp: đang làm / loại / hạn / số lần hôm nay / danh hiệu cũ / bãi xe |
| 2327–2330 | Đợt quái: khóa / mã (1 Mã Đế, 2 đoàn xe) / thời điểm / số con còn sống |

### 2.6 File
- **Runtime (`Server\script\phongthan\`):**
  - `daily3\d3_core.lua`, `d3_lib.lua`, `d3_anhong.lua`, `d3_chiemtinh.lua`, `d3_luclam.lua`, `d3_mob.lua`;
  - `ext\daily3.lua`;
  - sửa `lib\vng_tasknote.lua`, `lib\vng_tasknote_data.lua` và 44 file được thêm dòng Include.
- **Scratchpad `daily3\`:**
  - `src\*.lua` (UTF-8) và `mk.py` (chuyển sang TCVN3, CJK thành escape `\ddd`);
  - `gen_data.py`, `ti_conv.py` (port Python của `convert_taskinfo.ps1`), `f11_patch.py`, `f11_audit.py`, `era.py`, `taskscan.py`, `spots.py`, `pkx.py`;
  - `ti_Server_ui_0.ini` (taskinfo 2004) và `ti_Server_serverlist_0.ini` (taskinfo mới).
- **ptfix:** `scratchpad\ptfix\extra_daily3.py`, không phụ thuộc thứ tự chạy.
  - Server: forwarder `c90e3287` và 2 dòng danh hiệu trong `\settings\RankSetting.txt`.
  - Client: 2 dòng danh hiệu.

## Phần 3: Hành động

### Việc của coordinator
- [ ] Dựng ptfix thật có `extra_daily3.py`, **Client trước rồi Server**. Bản thử: `scratchpad\daily3\ptfix_test_client.pak` (41 mục) và `ptfix_test.pak` (541 mục). Log có `daily3: luclam forwarder c90e3287` và `RankSetting 1f0e43b1 +2 rows`.
- [ ] Client phải dùng ptfix mới thì danh hiệu 200/201 mới hiện chữ.
- [ ] Dán dòng CHANGELOG và thêm dòng README (xem báo cáo).
- [ ] (Tùy chọn) Nối Vận Lương thật: ai phá xe Vận Lương/Vận Tiêu của **người khác** thì thành Lục Lâm Đạo Tặc/Kim Bài. Phải sửa `script\phongthan\vanluong\vl_core.lua` (nguồn `scratchpad\vantieu\src\vl_core.lua`, sinh lại bằng `gen.py`):
  ```lua
  -- đầu file, sau Include vl_lib.lua
  Include("\\script\\phongthan\\daily3\\d3_lib.lua")
  function PTVL_D3Err(m) end

  function LastDamage(npc)
  	local mg = GetNpcParam(npc, 0)
  	if mg == PTVL_MG_BANDIT then
  		PTVL_BanditKilled(npc)
  	elseif mg == PTVL_MG_CART or mg == PTVL_MG_TIEU then
  		-- daily3: kẻ phá xe của người khác thành Lục Lâm Đạo Tặc (xe tiêu: Kim Bài)
  		if PTD3_LL_GrantFlag and PlayerIndex and PlayerIndex > 0 and PlayerIndex ~= GetNpcParam(npc, 1) then
  			local kind = 1
  			if mg == PTVL_MG_TIEU then kind = 2 end
  			call(PTD3_LL_GrantFlag, { kind }, "x", PTVL_D3Err)
  		end
  		PTVL_OnCartDown(npc)
  	end
  end
  ```
  `PTD3_LL_GrantFlag(kind)` là hàm công khai trong `d3_core.lua`, chạy với `PlayerIndex` là kẻ cướp.

### Checklist thử trong game (người dùng, sau khi tự khởi động lại server)
- [ ] **Ân Hồng** (Phong Thần Đài): menu có 3 dòng. Dòng 1 vẫn là Siêu Độ của daily2.
- [ ] **Mã Đế:**
  - [ ] Làm đủ 5 Siêu Độ, nhận Mã Đế, chọn "Đưa ta tới". Kiểm tra Chiêu Hồn Trận và 6 Oán Linh có hiện.
  - [ ] Giết đủ, về nhận thưởng. Vòng 5 có Mảnh Lam thủy tinh.
- [ ] **Nhà Chiêm Tinh** ở Triều Ca và Tây Kỳ: nhận Phúc Kim, xem F11, giao Bá Lạc Nhãn nhận bạc.
- [ ] **Tam Sơn:**
  - [ ] Thấy **Lục Lâm Hảo Hán** (1373/3465 ≈ minimap 171/216), nhận chặn đường.
  - [ ] Tới bãi xe, phá Xe Lương Quan Phủ. Kiểm tra danh hiệu "Lục Lâm Đạo Tặc" trong bảng thông tin nhân vật.
  - [ ] Về nhận thưởng (lần đầu trong ngày × 4); danh hiệu cũ được trả lại.
- [ ] **F11:**
  - [ ] Làm Hộp gấm (Tô Hộ, Sùng Thành): các bước báo đúng tên "Sùng Ứng Loan / Triều Lôi / Triều Điền".
  - [ ] Bước 7–10 không còn báo "hoàn thành" sớm.
  - [ ] Thu thập quân tình (thao trường) hiện "Đến Đại Phu ... thu thập quân tình".
- [ ] **Báo lại nếu:**
  - quan binh quá mạnh khi solo (đang dùng cấp − 2, máu 800 + cấp²);
  - xe không bị đánh được (template 364 phe 5);
  - danh hiệu không hiện (cần client có ptfix mới).

### Rủi ro

| Rủi ro | Dấu hiệu | Cách xử lý |
|---|---|---|
| Tên NPC bản đồ không phải `绿林好汉` | Có 2 Hảo Hán ở Tam Sơn | Xóa NPC tự đặt; thêm tên thật vào `PTD3X_LUCLAM_*` |
| `SetCurTitle(0)` khi người chơi chưa từng có danh hiệu | Không có (title 0 luôn hợp lệ) | — |
| Quét 48.000 NPC để tìm Ân Hồng / Hảo Hán | Tick chậm | Chỉ quét ở tick đầu, rồi 30 phút/lần (5 phút/lần khi còn thiếu) |

## Phần 4: Tài liệu tham khảo
- **Nguồn VNG:**
  - `taskinfo.ini` mới (serverlist.pak) và đời 2004 (`ui.pak`, 65 nhiệm vụ), Task_71/81;
  - `\script\运镖\绿林好汉.lua` (file rời GBK);
  - `material.txt` (Bá Lạc Nhãn 3/29–33);
  - `RankSetting.txt`.
- **Engine:**
  - `ScriptFuns.cpp`: `LuaAddIBBuffCompat` / `ApplyNativeIBBuffState` (11960–12300), `LuaSetCurTitleCompat` (11752), `LuaTaskNoteCompat` (1080);
  - `KNpc.cpp` `SetRank` (9988);
  - `CoreShell.cpp` RANKSTR (588, 806).
- **Liên quan:**
  - `nhiem-vu-ngay-moi-phong-than-20261003.md` (daily2);
  - `van-luong-van-tieu-phong-than-20261003.md`;
  - `he-thong-nhiem-vu-f11-phong-than-20260928.md`;
  - `tan-thu-moi-phong-than-20261003.md` (nb2fix, giới hạn stack).
- **Mô phỏng (`scratchpad\qtest`):**
  - `sim_daily3.lua` → `out_daily3*.txt`;
  - `t_d3_parse.lua` (44/44 file vẫn nạp được và có hook);
  - `t_d3_d2old.lua` / `t_d3_d2emu.lua` (đối chứng daily2).

## Bổ sung 2026-10-03 16:45 (coordinator): đã nối Lục Lâm với Vận Lương
- **Đã áp** đoạn sửa ở Phần 3 vào scratchpad\vantieu\src\vl_core.lua (sinh lại bằng gen.py). Người phá xe lương/xe tiêu của người khác nhận cờ Lục Lâm (task 2318: Đạo Tặc / Kim Bài). Chủ xe không nhận.
- **Sửa kèm:** engine gọi main(npcIndex) và không có biến DialogNpcIdx. l_core.main nay dùng tham số. PTVL_TieuNear đo từ vị trí người chơi.
- **Kiểm tra:** sim_vanluong 47/47; qtest\t_luclam_link.lua: người chơi thứ 2 phá xe → cờ = 1, chủ xe = 0, chuyến của chủ thất bại.