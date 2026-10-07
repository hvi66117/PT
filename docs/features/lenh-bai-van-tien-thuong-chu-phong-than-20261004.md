# Lệnh Bài Vạn Tiên Trận, Lệnh Bài Chiến Trường Thương Chu, bot tổ đội trong trận và quà chuẩn VNG

> Ngày: 2026-10-04 · Agent `vtcc` · Yêu cầu người dùng:
> 1. "Thêm lệnh bài Vạn Tiên Trận để vào Vạn Tiên trận, phát ở webadmin. Dùng là vào như thật, 1 giờ làm mới 1 lần, không theo quy định VNG. Lệnh bài Chiến trường Thương Chu cũng vậy."
> 2. "Thương Chu và Vạn Tiên trận bot chưa thấy tự động tổ đội và đánh boss cùng."
> 3. "Quà của Vạn Tiên trận và Thương Chu chuẩn VNG." và "Đánh boss Vạn Tiên trận không ra đồ lục hoặc bí kíp gì."
>
> Nhãn: **[VERIFIED]** = đã kiểm tra trên mã nguồn, dữ liệu hoặc trình mô phỏng. **[INFERRED]** = suy luận, cần thử trong game.

## Phần 1: Tổng quan

### Insight chính
- **Hai lệnh bài mới, dùng mãi không mất, hồi 60 phút** (giờ thật của máy chủ):

| Lệnh bài | magicscript | Task hồi | Script |
|---|---|---|---|
| Lệnh Bài Vạn Tiên Trận | 6/1/**61470** | **2670** | `script\phongthan\item\vantien_lenhbai.lua` |
| Lệnh Bài Chiến Trường Thương Chu | 6/1/**61471** | **2671** | `script\phongthan\item\thuongchu_lenhbai.lua` |

  - GlobalValue mới: **2670** = mã trận Thương Chu do lệnh bài mở, chờ tick servertimer nhận.
  - Đã quét toàn bộ PAK, script rời, settings, admin_bridge, AdminWeb và plug-in ptfix: không ai dùng 61470/61471, task 2660–2689, GV 2660–2689 [VERIFIED].
- **Dùng là vào ngay.** Trận đang đóng thì lệnh bài mở trận ngay rồi đưa người chơi vào; trận đang mở thì vào luôn. Bỏ giờ mở, phí, giới hạn cấp, giới hạn PK.
- **Thương Chu** chính là "Viễn Cổ chiến trường" của VNG (Mission 5, bản đồ 71 = runtime 1071). Agent `vienco` đã dựng thành **chiến trường PvE chơi một mình**: hai đạo quân đều là NPC. Không cần người hay bot phe đối địch.
- **Bot tổ đội** giờ theo người chơi vào 4 bản đồ Vạn Tiên trận (1079–1082) và chiến trường 1071, đánh quái, tiên, Thông Thiên và quân địch cùng người chơi.
- **Quà chuẩn VNG**:
  - Nguyên nhân boss Vạn Tiên không ra đồ: engine bản dựng lại **không đọc cột `DropRateFile` của Npcs.txt**. Trước đây không script nào phát đồ rơi.
  - Đã viết lại theo bảng rơi VNG của từng mẫu boss. Đồ vào thẳng hành trang người hạ, không rơi ra đất.
  - Bỏ các phần thưởng tự đặt, không có trong VNG: kinh nghiệm/lượng/nguyên liệu khi hạ Thông Thiên, thưởng mở rương, kinh nghiệm cuối trận Thương Chu, 3 vạn lượng và Lam bảo thạch khi nhận thưởng Vị Quốc Lập Công.

### Nhận định quan trọng
- **Bí kíp:** theo dữ liệu VNG, tiên Vạn Tiên (Huyễn) có bảng `jiuying.ini` chứa bí kíp và đồ lục, nhưng số lần rơi của bảng đó (`Treasure1`) là **0**. Các dòng bí kíp của Thông Thiên trong `tongtian5.ini` đều có tỉ lệ **0**. Vì vậy, đúng VNG thì boss Vạn Tiên **không rơi bí kíp**. Thứ rơi là vũ khí cấp 10, pháp bảo, đồ phổ Thất Bảo Kim Liên, Lam bảo thạch, thủy tinh, Huyễn Linh Nhãn. Theo yêu cầu người dùng, công tắc `PTVD_FORCE1` **đã được bật** (không chuẩn VNG): tiên có thêm lượt bí kíp/đồ lục, Thông Thiên chắc chắn rơi 1 bí kíp đúng phái, 1 pháp bảo, 3 đồ lục (mục 3.3).
- **Cách hiểu cặp cột [INFERRED, có bằng chứng thống kê]:** `Treasure` đi với `DropRateFile` và `Treasure1` đi với `DropRateFile1`.
  - Ví dụ: mẫu `冥·天绝卫魂` có Treasure 50 với `instencedrop-xianmo1.ini` và Treasure1 1 với `instencedrop-normal-xianmo1.ini`.
  - Ví dụ khác: boss mê cung có Treasure 90 với `boss2` và Treasure1 4 với `migong*.ini`.
  - Nguồn mã engine VNG không có trong dự án, nên đây là suy luận.
- Lượng đồ rơi theo VNG rất lớn: Thông Thiên có 80 lượt rơi bảng boss chung và 6 lượt bảng riêng. VNG để đồ rơi ra đất cho người chơi nhặt. Ở đây đồ vào thẳng hành trang theo thứ tự:
  1. bảng riêng;
  2. pháp bảo, thuốc, bảo thạch;
  3. đồ trắng.

  Túi đầy thì phần còn lại không nhận được và có thông báo.

## Phần 2: Chi tiết

### 2.1 Lệnh Bài Vạn Tiên Trận (61470)
- **Menu:** 4 dòng `Trận Thổ/Thủy/Hỏa/Phong [trạng thái], nên cấp 30/51/71/91+` và dòng `Đóng`.
- **Chọn trận:** gọi đúng đường của Thiên Hùng (`PTVT_EnterRequest`) nhưng bỏ kiểm tra cấp/mở khóa:
  - Trận đã phá mà trong trận không còn ai: đóng trận, mở lượt mới.
  - Trận đang đóng: gọi `PTVT_Open(n, 30)`. `InitMission` sinh 4 tiên, quái, Đại phu. Sau **30 giây chuẩn bị** thì vào 30 phút đánh như lịch VNG. Có tin toàn server.
  - Sau đó `PTVT_Join` đưa người chơi vào: NewWorld, `AddMSPlayer`, task 2003/2005, trạng thái chiến đấu.
- **Trạng thái dùng chung:** mission và GlobalValue 400–419 là đối tượng engine dùng chung cho mọi Lua state. Vì vậy tick `PTVT_Tick` (servertimer), timer `task02..09`, Đại phu, rương… đều thấy trận lệnh bài mở [VERIFIED: mô phỏng V2–V8].
- **Không giới hạn số lần trong ngày:** phần thưởng của mỗi lần vào là phần thưởng của một lượt VNG bình thường, không nhân thêm.
- **Chặn dùng** khi đang ở 1079–1082 (trong trận), 1071, Thiên Lao 1060, sự kiện, phó bản. Chỉ dùng ở bản đồ ngoài và thành (1001–1057, 1065, 1074–1078).
- **Cooldown:** task 2670 lưu số giây từ 2000-01-01 theo `date()`. Còn hạn thì hiện "còn X phút Y giây". Đồng hồ bị chỉnh lùi thì cho dùng lại ngay. Chỉ tính lượt khi đã vào trận thành công.
- Thiên Hùng vẫn giữ luật cấp VNG. Chỉ lệnh bài mới bỏ luật này.

### 2.2 Lệnh Bài Chiến Trường Thương Chu (61471)
- **Chiến trường là gì:** VNG `\script\新古战场\远古战场*.lua` (Mission 5, map 71 = 1071). Bản PvE của agent `vienco`:
  - quân Thương (camp 1) và quân Chu (camp 2) đều là NPC;
  - người chơi chọn phe, hạ binh, thám quân, phá vật tổ, đoạt soái kỳ;
  - mỗi giờ một trận, phút 00–44.
- **Menu:** `Vào phe Thương (Văn Trọng)`, `Vào phe Chu (Khương Thượng)`, `Đóng`. Nếu người chơi vẫn thuộc trận hiện tại (đã ra ngoài) thì có dòng `Trở lại chiến trường`, miễn phí, không tính lượt.
- **Trận đang mở, còn ≥ 5 phút:** vào ngay bằng `PTVC_Enter`, như Viễn Cổ Chiến Sứ nhưng không phí, không cấp 50, không PK 88.
- **Trận đang đóng (phút 45–59 hoặc sau trận ép):**
  1. Script vật phẩm tự mở trận 45 phút trên các GlobalValue dùng chung (trạng thái, mã trận, điểm, phút kết thúc, 20 ô người chơi).
  2. Đặt **GV 2670 = mã trận** rồi đưa người chơi vào doanh trại.
  3. Trong vòng 1 phút, tick `ext\vienco.lua` (`PTVC_Schedule`) nhận trận thành **trận ép** (`PTVC_FORCE_END`), sinh 38 quân NPC, cộng điểm AI, tổng kết đúng phút kết thúc.
  4. Lịch giờ không chen vào trận lệnh bài, kể cả khi mở lúc HH:59 [VERIFIED: sim C2, C4].
- **Còn < 5 phút:** báo đợi trận kết thúc, chưa tính lượt.
- **Một người:** không cần đủ người phe đối địch. Phe địch là quân NPC, phe mình cũng có quân NPC đồng minh. Bot tổ đội (2.3) đi cùng.

### 2.3 Bot tổ đội trong Vạn Tiên trận và Thương Chu
- `party.lua`, sinh từ `scratchpad\botparty\src\party.lua` bằng `gen.py`. Runtime trùng `out\party.lua` trước khi sửa [VERIFIED].
  - `PTBP_MAPS` thêm 1079–1082 (đúng `PTVT_MAPS`) và 1071.
  - Tick mỗi phút gọi lại bot trên bản đồ mới. Engine xóa bot AI 11 khi chủ đổi bản đồ.
- **Phe (bảng `KNpcSet::GenOneRelation`, đã đọc mã nguồn):**
  - camp 0 chỉ là địch với camp 5;
  - hai camp khác nhau thì là địch;
  - camp 6 không giao chiến.
  - Quái 53–60, tiên/Thông Thiên 1904–1923 và rương 1929 đều camp 5 trong Npcs.txt, nên bot camp 0 đánh được [VERIFIED].
  - Quân Thương Chu bị đổi camp thành 1/2 (`SetNpcCurCamp`). Bot camp 0 sẽ coi cả hai quân là đồng minh, nên **trên 1071 bot lấy camp = phe của người chơi** (task 2341). Camp được đặt lại mỗi tick (`PTBP_Camp`).
- **Vạn Tiên đang chuẩn bị (GV trạng thái = 1):** chưa gọi bot. Nếu không, bot có thể hạ tiên trước giờ đánh; `PTVT_BossDeath` bỏ qua kill trước trạng thái 2 và boss không hồi sinh. Bot đến ở phút kế tiếp sau khi trận bắt đầu.
- **Không làm hỏng cơ chế trận:**
  - bot là NPC, không `AddMSPlayer`, nên `PTVT_Inside`, slot chiến trường và thưởng chỉ thấy người thật;
  - bot chết không chạy script trận;
  - đòn của bot được engine tính cho chủ (`KNpc::CalcDamage`, AI 11), nên hạ binh, đoạt cờ, phá vật tổ do bot làm cũng là công trạng của người chơi, như mọi bản đồ khác.
- **Đã áp nóng** bằng bridge lúc 16:07 (`vtcc_bp OK`).
- Lưu ý: agent `dinhanbot` đang sửa tiếp `src\party.lua` (dùng biến `camp` của phần này) và sẽ tự triển khai phần của họ.

### 2.4 Quà Vạn Tiên trận chuẩn VNG
| Nguồn | VNG gốc | Trước đây (dự án) | Bây giờ |
|---|---|---|---|
| Tiên chết | `万仙阵\乌云仙.lua` (script.pak 1aa66db3…): `AddNormalItem(3,66..69)` lệnh cho **người hạ**, cộng nhiệm vụ ngày. Rơi đồ: Npcs.txt mẫu 1904… Treasure 18 × `npcdroprate-boss1.ini`, Treasure1 0 × `jiuying.ini` | Lệnh cho mọi người trong trận, không rơi đồ | Giữ lệnh cho mọi người trong trận (vật phẩm khóa của bẫy, xóa khi rời trận). **Thêm rơi đồ VNG:** 18 lượt boss1 |
| Thông Thiên chết | `通天教主.lua` (645af936): chỉ cộng nhiệm vụ ngày và sinh 4 rương, **không có exp/tiền/vật phẩm**. Rơi: Treasure 80 × boss1, Treasure1 6 × `tongtian5.ini` | 600–1200 × cấp exp, 1–5 vạn lượng, 1 nguyên liệu nguyên tố, giới hạn 2 lần/ngày | Bỏ thưởng tự đặt và giới hạn ngày. **Rơi VNG:** 6 lượt tongtian5 + 80 lượt boss1 cho người hạ |
| Bảo rương | `宝箱.lua` (e0b3d463): `OnDeath` rỗng (các dòng `AddNormalItem` bị comment). Rơi: mẫu 1929 Treasure 30 × boss1, Treasure1 6 × `baoxiang5.ini` | 300–600 × cấp exp, tiền, quay nguyên liệu | Bỏ thưởng tự đặt. **Rơi VNG:** 6 lượt baoxiang5 + 30 lượt boss1 cho người đập rương |
| Nhiệm vụ ngày Thiên Hùng | `b5deef29` | Đã chuyển đúng VNG (agent vantien2) | Không đổi |

- **Bảng rơi** (`scratchpad\vtcc\out\drop_report.txt` liệt kê từng dòng):
  - `tongtian5.ini` (35,5%/lượt, RandRange 1.000.000):
    - vũ khí 0/0/4–7 cấp 10: 4.000–5.000;
    - đồ phổ Thất Bảo Kim Liên 6/1/890–892: 500;
    - pháp bảo cấp 10 Khổn Tiên/Chấn Thiên Cung/Kim Bát Vu/Linh Lung Tháp 0/4/14–17: 20.000;
    - pháp bảo 0/4/0–5: 20.000–50.000;
    - Lam bảo thạch: 100.000;
    - Long Tích Cung / Càn Khôn Cung: 3.500 / 1.800;
    - bí kíp: **0**.
  - `baoxiang5.ini` (65%/lượt): Huyễn Linh Nhãn 350.000; Hồng thủy tinh, Lam thủy tinh, Thủy linh phù mỗi loại 100.000; vũ khí cấp 9–10: 80.
  - `npcdroprate-boss1.ini` (64%/lượt, RandRange 150.000): đồ trắng cấp 1–10, Trung Hồng đơn và Trung Hoàn đơn 30.000; pháp bảo 0/4/0–5: 5; Lam/Hồng bảo thạch: 30.
  - `jiuying.ini` (chỉ dùng khi bật `PTVD_FORCE1`): bí kíp hệ phái và đồ lục 0/2/3–5, 0/9/3–5, Minh Uyên 0/2/311, 0/9/311.
- **Kiểm tra tồn tại:** chỉ giữ vật phẩm có ở **cả Server và Client** (gồm ptfix). Riêng 6/1/2020 (VNG 230.000 / 150.000) không có trong dữ liệu Server nên bị bỏ [VERIFIED].
- **Bí kíp loại 7:** engine không cho dùng sách loại 7 (`ExecuteScript` thoát sớm). Vì vậy bí kíp hệ phái được phát dưới dạng bí kíp dùng được của dự án 6/1/(62000 + kỹ năng). Sách cung thủ 1701+ giữ nguyên dạng VNG.
- **Cấp đồ** trong khoảng MinItemLevel–MaxItemLevel, trọng số nội suy tuyến tính giữa MinItemLevelScale và MaxItemLevelScale [INFERRED].
- **Phát đồ:** `AddNormalItemPile` tự xếp chồng và trả về 0 khi túi đầy. Không có đồ nào rơi ra đất.
- **Thời điểm rơi:** khi boss/rương chết, cho người được engine ghi kill (`LastDamage`, PlayerIndex = người hạ; kill của bot tính cho chủ).

### 2.5 Quà Thương Chu chuẩn VNG
| Mục | VNG gốc | Trước đây | Bây giờ |
|---|---|---|---|
| Cuối trận | `远古战场.lua` BonusTime: không exp, không vật phẩm. Cộng điểm vào tổng (426), đặt kết quả nhiệm vụ, đưa về Phong Thần Đài, tin dũng sĩ đệ nhất | Cấp × công trạng × 30 exp (phe thắng × 1,5) | Bỏ exp. Giữ tổng công trạng, kết quả, tin |
| Kết quả Vị Quốc Lập Công | Nhiệm vụ đếm về mốc thì = 1. Phe thắng và (1 hoặc 5001) thì = 2. Task 410 = ngày có kết quả | 1 thì luôn = 2, 5001 cần thắng | Như VNG: 1 = xong (phe thua/hòa), 2 = xong và phe thắng. Task 2347 = ngày kết quả |
| Nhận nhiệm vụ | `闻仲.lua`: chỉ khi `lastday ~= task 410` (1 kết quả/ngày) | 3 lần nhận/ngày | 1 kết quả/ngày. Lệnh bài cho nhận thêm 1 lần mỗi lần vào (thưởng như VNG, không nhân) |
| Thưởng (Chiến Sứ) | `纣王.lua` / `武王.lua` reward_normal: exp = cấp × (đẳng cấp × 100 + trạng thái × 1000) × 2; đẳng cấp 10: cấp × (1000 + trạng thái × 1000) × 2. Không tiền | exp cấp × (đẳng cấp × 100 + 2000) × 2, cộng 3 vạn lượng, 1/3 Lam bảo thạch | Đúng công thức VNG cho cả trạng thái 1 và 2. Bỏ tiền và bảo thạch |
| Đẳng cấp chiến trường | 2 lần thưởng lên 1 cấp (task 373). Đẳng cấp 4 mà cấp nhân vật < 60 thì không lên | Có, thiếu luật cấp 60 | Như VNG |
| Trang bị khi lên cấp | reward_add: đẳng cấp 3→4 chọn 1 trong 5 món bộ 2 (Tinh Cang/Thái Ất/Giác Thú) cấp 5; 9→10 chọn 1 trong 3 món (Ngoa, Yêu Đái, Khôi) bộ 3 (Khai Thiên/Thông Thiên/Lam Điêu) cấp 7 | Tự cho giáp khi lên 4 và 10 | Như VNG: hộp chọn món ở Chiến Sứ. Túi đầy thì giữ nguyên để nhận lại |
| Phí vào | `神碑2.lua`: 5 vạn | 5 vạn | Giữ ở Chiến Sứ. Lệnh bài miễn phí (theo yêu cầu) |

- Ghi chú: script Võ Vương VNG có lỗi offset `420 + 20` làm thưởng không hiện ra. Ở đây dùng nghĩa đúng (Trụ Vương trừ 20).
- Nhiệm vụ chưa xong lúc tổng kết vẫn bị hủy như bản `vienco` (VNG để nguyên sang trận sau).

### 2.6 File đã sửa / thêm
| File | Loại | Ghi chú |
|---|---|---|
| `Server\script\phongthan\item\vantien_lenhbai.lua` | mới | `scratchpad\vtcc\gen.py` |
| `Server\script\phongthan\item\thuongchu_lenhbai.lua` | mới | `gen.py` |
| `Server\script\phongthan\vantien\vt_drop.lua` | mới | `scratchpad\vtcc\gen_drop.py` (bảng rơi VNG) |
| `Server\script\phongthan\vantien\vt_boss.lua`, `vt_chest.lua`, `vt_lib.lua`, `vt_thienhung.lua` | sửa | nguồn `scratchpad\vantien\impl\src` + `build.py` (build lại trùng runtime trước khi sửa) |
| `Server\script\phongthan\ext\vienco.lua`, `vienco\vc_lib.lua`, `vienco\vc_chiensu.lua` | sửa | `scratchpad\vienco\mk_vienco.py` (vá bằng `scratchpad\vtcc\patch_vienco.py`) |
| `Server\script\phongthan\bots\party.lua` | sửa | `scratchpad\botparty\src\party.lua` + `gen.py` |
| `scratchpad\ptfix\extra_vtcc.py` | mới | 2 dòng magicscript cho Server và Client. Sprite: Vạn Tiên Lệnh (Trưởng Thành) VNG 8333 và Cờ Thương Chu VNG 8270 |
| `AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html` | sửa | `VanTienToken` / `ThuongChuToken`; nút "Phát Lệnh Bài Vạn Tiên", "Phát Lệnh Bài Thương Chu" |
| `scratchpad\qtest\sim_vantien.lua`, `sim_vienco.lua` | sửa kỳ vọng | Bỏ các kiểm tra phần thưởng không phải VNG, thêm kiểm tra VNG |

- **Backup:** `E:\VL\Phong than\PT\_backup\20261004-vtcc\`. Gồm runtime cũ (`ext\vienco.lua`, `vienco\vc_*.lua`, `vantien\vt_*.lua`, `bots\party.lua`), AdminWeb, nguồn `vantien_impl`, `mk_vienco.py`, `botparty src`, hai sim. Không tự khôi phục.

### 2.7 Kiểm thử (`scratchpad\qtest`, PowerShell 32-bit)
| Sim | Chế độ | Kết quả |
|---|---|---|
| `sim_vtcc_vt.lua` (lệnh bài Vạn Tiên + rơi đồ) | `-Stack 100` (V8 bỏ qua: sim lồng 3 state trên một stack), `-Stack 0`, EMU 47 khung, cả `live` | 44 / 47 / 9 ok, **FAILS=0** |
| `sim_vtcc_tc.lua` (lệnh bài Thương Chu + quà) | `-Stack 100`, EMU (vật phẩm 44 khung, tick 38 khung) | 40 OK, **FAILS=0** |
| `sim_vtcc_bp.lua` (bot tổ đội, camp) | `-Stack 100`, EMU (tick 39 khung) | 20 ok, **FAILS=0** |
| `sim_vantien.lua` / `sim_vantien2.lua` (runtime) | lịch giờ, mission, nhiệm vụ ngày | 77/77, 74/74 |
| `sim_vienco.lua` (runtime) | EMU và `-Stack 100` | **FAILS=0** |
| `sim_botparty.lua` | runtime | 37 pass / 14 fail, **trùng y hệt với party.lua gốc** (lỗi có từ thay đổi partytown 03/10, không do vtcc) |

- **Build thử ptfix:** `scratchpad\vtcc\ptfix_test_client.pak` (42 mục) và `ptfix_test.pak` (617 mục). Có 61470/61471 ở cả hai phía; tên, mô tả, sprite đúng [VERIFIED `verify_pak.py`].

## Phần 3: Hành động

### 3.1 Việc của coordinator / người dùng
- [ ] Build ptfix chính thức có `extra_vtcc.py` (Client trước, Server sau), chép vào Server và Client, rồi **khởi động lại GameServer** để có 2 vật phẩm. Script runtime đã nằm sẵn.
- [ ] **Đóng và mở lại web admin** để có nút mới, rồi F5 trình duyệt.
- [x] Đã áp nóng qua bridge (không cần khởi động lại để có tác dụng):
  - bot tổ đội: 16:07;
  - rơi đồ Vạn Tiên chuẩn VNG, quà Thương Chu chuẩn VNG, nhận trận lệnh bài trong `ext\vienco.lua`: 16:31 (`vtcc_reload OK`).
- [ ] Ghi CHANGELOG `[COMPLETED]` (đã làm), README (đã làm).

### 3.2 Checklist thử trong game
- [ ] Web admin → Phát Lệnh Bài Vạn Tiên cho nhân vật → F4 thấy "Lệnh Bài Vạn Tiên Trận". Click phải → 4 trận.
- [ ] Chọn trận đang đóng: có tin "… dùng Lệnh Bài Vạn Tiên Trận mở Vạn Tiên trận (…)", vào trận. Sau 30 giây trận bắt đầu.
- [ ] Bot tổ đội xuất hiện trong vòng 1 phút sau khi trận bắt đầu và đánh tiên.
- [ ] Hạ tiên: nhận lệnh và thông báo "Vật phẩm rơi (bảng VNG): nhận N món…". Hạ Thông Thiên: đồ cấp 10 / pháp bảo / bảo thạch vào túi, không còn exp/lượng tự đặt. Đập rương: Huyễn Linh Nhãn, thủy tinh…
- [ ] Click phải lệnh bài lần nữa: "còn 59 phút … nữa".
- [ ] Phát Lệnh Bài Thương Chu. Lúc phút 45–59: chọn phe → vào doanh trại, có tin khai chiến. Trong 1 phút có 38 quân NPC. Bot đứng phe mình và đánh quân địch.
- [ ] Nhận Vị Quốc Lập Công, hoàn thành, đợi tổng kết. Về Chiến Sứ nhận exp đúng công thức VNG. Đủ đẳng cấp 3 → hộp chọn 1 món bộ.

### 3.3 Tùy chọn ĐÃ BẬT theo yêu cầu người dùng (không chuẩn VNG): bí kíp, pháp bảo, đồ lục
Người dùng chọn "Bật rơi bí kíp + đồ lục" và yêu cầu "Đánh Thông Thiên rơi bí kíp, pháp bảo, đồ lục" (2026-10-04, 16:50). Dữ liệu VNG gốc không cho boss Vạn Tiên rơi bí kíp (xem Phần 1), nên đây là **tùy chọn riêng của server, không chuẩn VNG**. Bật bằng `PTVD_FORCE1 = 1` trong mẫu Lua của `scratchpad\vtcc\gen_drop.py`, sinh lại `vantien\vt_drop.lua`. Bản chuẩn VNG trước đó sao lưu ở `_backup\20261004-vtcc\Server\script\phongthan\vantien\vt_drop.vng-default.lua` và `_backup\20261004-vtcc\scratchpad\gen_drop.vng-default.py`.

**Tiên (16 mẫu):** ngoài 18 lượt bảng boss chung, mỗi tiên tung thêm **1 lượt `jiuying.ini`** cho người hạ. Lượt này có 65,3% ra đồ, theo tỉ lệ VNG của bảng (RandRange 1.000.000):
- mỗi bí kíp hệ phái: 1.000–20.000 (khoảng 0,1–2%);
- đồ lục 0/2/3–5, 0/9/3–5, Minh Uyên 0/2/311, 0/9/311: mỗi món 20.000 (2%);
- pháp bảo 0/4/0–5: 20.000–100.000;
- vũ khí, cuốc/phủ cấp 10: phần còn lại.

**Thông Thiên Giáo Chủ (4 mẫu): mỗi lần hạ CHẮC CHẮN nhận** (ưu tiên vào túi trước mọi đồ rơi khác):

| Phần thưởng chắc chắn | Số lượng | Chọn món (trọng số = tỉ lệ VNG của dòng) | Cấp |
|---|---|---|---|
| Bí kíp hệ phái **đúng phái người hạ**, dạng dùng được 6/1/(62000 + kỹ năng) | 1 | Giáp Sĩ: Khai Sơn / Hồi Phong / Điện Quang Trảm mỗi cái 29%, Hoành Không 7,2%, Tinh Thông Đoản Đao 4,3%, Tinh Thông Trường Đao 1,4%. Đạo Sĩ: Thiên Phong Địa Nhận / Băng Cơ Tuyết Cốt / Phong Lâm Hỏa Sơn / Hạn Địa Lôi mỗi cái 22,5%, Tinh Thông Thổ Hệ 5,6%, Thiết Mã Băng Qua 3,4%, Tinh Thông Hỏa Hệ 1,1%. Dị Nhân: Thôi Thân / Bổ Tâm Chú, Trường Cung / Thiên Vũ Tế mỗi cái 21,3%, Cường Công Chú / Liên Nỗ Tế mỗi cái 5,3%, Phá Giáp Chú / Hỏa Lôi Tế mỗi cái 2,1% | — |
| Pháp bảo (0/4/x) | 1 | Hình Thiên Ấn 34,9%, Ngũ Quang Thạch 16,3%, Càn Khôn Xích / Hỗn Thiên Lăng / Bình Lưu Ly / Hỏa Long Tiêu mỗi cái 9,3%, Dây Khổn Tiên / Chấn Thiên Cung / Kim Bát Vu / Linh Lung Tháp mỗi cái 4,65% | theo trận; 4 pháp bảo 0/4/14–17 luôn cấp 10 |
| Đồ lục (trang bị bộ: Hoàng Kim Chấn Đán Giáp, Hồng Quân Đạo Bào, Kháng Long Hộ Giáp, Chấn Đán / Hồng Quân / Kháng Long phi phong-lệnh-kết, Minh Uyên Cách Giáp, Minh Uyên Phi Phong) | 3 | mỗi món 1/8 | theo trận |

- Cấp theo trận: Thổ 7, Thủy 8, Hỏa 9, Phong 10.
- Sau phần chắc chắn vẫn có đủ đồ rơi VNG: 6 lượt `tongtian5.ini` + 80 lượt bảng boss chung.
- Bảo rương giữ nguyên bảng VNG.
- Kiểm tra: 21 bí kíp, 22 dòng pháp bảo, 8 món đồ lục, mọi cấp đều có ở cả dữ liệu Server và Client (gồm ptfix) [VERIFIED `scratchpad\vtcc\verify_cat.py`, 0 thiếu].
- Sách loại 7 VNG không dùng được (cung thủ 1701–1756) đã **bỏ** khỏi bảng, chỉ phát bí kíp dùng được.
- Phát bằng `AddNormalItemPile`, không rơi ra đất. Túi đầy thì có thông báo; nên để trống khoảng 10 ô trước khi hạ Thông Thiên.
- Muốn quay về chuẩn VNG: chép lại `vt_drop.vng-default.lua` (chỉ làm khi người dùng đồng ý), rồi `ReLoadScript` `vt_boss.lua` / `vt_chest.lua`.
- Đã nạp nóng qua bridge (`vtcc_force1`).

## Phần 4: Tài liệu tham khảo
- **Script VNG đã đọc** (`scratchpad\vantien\eff\`, PAK):
  - `万仙阵\乌云仙.lua`, `通天教主.lua`, `宝箱.lua`, `万仙阵土.lua`, `土start/off/review.lua`;
  - `新古战场\远古战场.lua`, `远古战场on/start/bonustime/off.lua`, `闻仲.lua`;
  - `西岐\武王.lua`, `朝歌\纣王.lua` (`scratchpad\vtcc\wuwang.lua`, `zhouwang.lua`).
- **Dữ liệu:**
  - `settings\phongthan\Npcs.txt` (Kind, Camp, Treasure, Treasure1, DropRateFile 0–3);
  - `\settings\item\droprate\npcdroprate-boss1.ini`, `jiuying.ini`, `tongtian5.ini`, `baoxiang5.ini` (serverlist.pak);
  - bảng vật phẩm `\settings\item\001\*.txt` hai phía.
- **Engine:**
  - `KNpc.cpp` DoDeath (chỉ `DropRate` script, không đọc DropRateFile);
  - `KNpcSet.cpp` `GenOneRelation`;
  - `KNpcAI.cpp` `ProcessAIType11` / `PhongThanPetTargetOk`;
  - `ScriptFuns.cpp` `AddNormalItemPile` (`AddVngNormalItemToInventory`), `AddItem`;
  - `KItemList.cpp` NowEatItem (sách loại 7).
- **Tài liệu liên quan:** `van-tien-tran-phong-than-20261002.md`, `vien-co-giang-son-phong-than-20261003.md`, `to-doi-bot-phong-than-20261003.md`, `lenh-bai-luyen-cong-phong-than-20261003.md`, `bi-kip-he-phai-phong-than-20261002.md`.
