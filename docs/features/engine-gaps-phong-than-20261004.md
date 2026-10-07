---
tinh-nang: Sửa khoảng trống engine đợt 2 (A4, C5, D1–D4)
ngay: 2026-10-04
agent: engine2
trang-thai: C++ đã build (CoreServer, CoreClient, Game.exe), smoke 2789/0, sim Lua 0 lỗi. CHƯA triển khai DLL. matdo.lua đã chép runtime và nạp nóng (tự đọc giới hạn, trên DLL cũ chạy y như trước).
file-chinh: GameDataDef.h, KMission.h, KNpcSet.h/.cpp, KNpc.h/.cpp, KNpcAttribModify.h/.cpp, KBasPropTbl.h/.CPP, ScriptFuns.cpp, PhongThanDieuTriLua.inl, PhongThanXichTungTuService.inl, KPlayerDBFuns.cpp, CoreShell.cpp, UiGame.cpp; Lua ext\matdo.lua, ibitem\pt_ibitem_lib.lua, npc_fix\1020_thai_tue.lua
---

# Sửa khoảng trống engine đợt 2 — Phong Thần

## Phần 1: Tổng quan

- **A4 — Giới hạn NPC 48.000 → 96.000.** Làm được nhờ tách sức chứa danh sách NPC của mission (`MAX_MISSION_NPC` 8.192). Tổng bộ nhớ ảo của GameServer **giảm khoảng 27 MB** so với hiện tại, dù số ô NPC gấp đôi.
  - Chỉ số NPC chia hai vùng: NPC thường dùng 1–47.999 như cũ, quái thêm của `matdo` dùng 48.000–95.999. Vì vậy 14 script Lua đang quét chỉ số 1..47.999 (bot, vienco, tienma, sudo_dongdi…) vẫn thấy đủ NPC của chúng.
  - `matdo.lua` tự đọc giới hạn từ engine: DLL cũ 48.000 / trần 44.000 (y như trước), DLL mới 96.000 / trần 92.000. Đã nạp nóng 20:36.
- **C5 — Đệ kỹ năng 450–461.** Nhánh `pet10` trong `KSkills.cpp` đã đặt chỉ số riêng từ trước, nên chỉ thêm native `GetSummonPetIdx()` và bỏ ghi chú "chưa áp dụng" trong tài liệu pet-exp.
- **D1 — `AddIBBuff(id)` áp hiệu quả của vật phẩm IB 8/id** (đọc các cột buff của `ibitem.txt`), chạy bằng trạng thái engine. Không còn tung nhầm kỹ năng cùng số hiệu.
  - Túi quà Võ Lâm Đại Hội (`AddIBBuff(176)`) giờ cho đúng kinh nghiệm +50 % trong 2 giờ, không cần sửa script.
  - Càn Khôn Luân vẫn dùng `pt_ibitem_lib.lua` như cũ. Thư viện này được vá để không áp buff hai lần khi có trạng thái engine.
- **D2 — `GetCredit` / `AddCredit` / `DecCredit` dùng chung Danh vọng** (task 210, ô F3). Ví ẩn cũ (task 4840) được cộng vào Danh vọng một lần lúc đăng nhập. Càn Khôn Luân nay chỉ còn một lệnh cộng.
- **D3 — Thêm hai cơ chế VNG.** Đọc cột `DeadlyStrikeResist` của `npcs.txt` (NPC kháng đánh tập trung theo mẫu). Thuộc tính 295 `enhance_fatallystrike_p` tăng lượng máu mất do đánh chí mạng.
- **D4 — Giữ chuột phải rồi di chuột thì tung chiêu tay phải lặp lại.** Lệnh chỉ gửi khi nhân vật rảnh tay và cách nhau ít nhất 150 ms, nên mỗi lần ra chiêu có tối đa 1 lệnh.

## Phần 2: Chi tiết

### 2.1 A4 — Giới hạn NPC

**Nguyên nhân giới hạn cũ:** `MAX_NPC` 48.000 (`GameDataDef.h`, chỉ server; client 256 ô riêng, không phụ thuộc). Mỗi ô NPC kéo theo nhiều mảng khác. Mảng lớn nhất là danh sách NPC của **mỗi** mission: 266 mission (128 bản đồ × 2 + 10 toàn cục), mỗi cái `MAX_NPC` × 16 byte dữ liệu + 2 danh sách liên kết × 8 byte trên heap.

**Các mảng phụ thuộc `MAX_NPC` (đo từ `CoreServer.map`):**

| Mảng | Byte mỗi ô | 48.000 (cũ) | 96.000 (mới) |
|---|---|---|---|
| `Npc[]` (`sizeof(KNpc)` 6.304 → 6.308 vì có thêm 1 trường D3) | 6.308 | 302,6 MB | 605,6 MB |
| `g_PhongThanNpcExt` | 60 | 2,9 MB | 5,8 MB |
| `s_PTSQCmd/At/NpcID/TargetID` (daosi) | 28 | 1,3 MB | 2,7 MB |
| `s_nPetDbgNext[2][MAX_NPC]` (petdebug) | 8 | 0,4 MB | 0,8 MB |
| `s_dwPtHealedAt` (botheal, agent khác) | 4 | 0,2 MB | 0,4 MB |
| `KNpcSet` danh sách tự do/đang dùng (heap) | 16 → 24 | 0,8 MB | 2,3 MB |
| Danh sách NPC của 266 mission (dữ liệu + heap) | 266 × 32 | **408,6 MB** | **69,7 MB** (8.192 ô) |

**Phép tính (tiến trình 32 bit, LARGEADDRESSAWARE, 4 GB địa chỉ):**

- Đo trên GameServer đang chạy (20:2x, chỉ đọc bằng `VirtualQueryEx`): ảnh DLL 1.025 MB, private 2.628 MB, reserve 959 MB, **còn trống 412 MB**, khối trống lớn nhất 323 MB. `CoreServer.dll` nằm 0x100A0000–0x4D97F000 (984 MB).
- Phương án 96.000 mà giữ mission theo `MAX_NPC`: Npc +303 MB, mission +409 MB, cộng thêm khoảng 715 MB, trong khi chỉ còn trống 412 MB. **Không chạy được.** Chỉ đổi `MAX_NPC` lên 64.000 thì thêm khoảng 238 MB, còn trống chưa tới 175 MB, rất sát.
- Phương án đã làm (96.000 + `MAX_MISSION_NPC` 8.192), số đo từ map trước/sau:
  - `.bss`: 975,3 MiB → 1.114,6 MiB (+146,1 MB); `.data` −6,4 MB.
  - Heap: mission −266 × 2 × 8 × (48.000 − 8.192) = −169,4 MB; `KNpcSet` +1,5 MB.
  - **Tổng thay đổi ≈ −28 MB (−27 MiB).** Sau triển khai còn trống khoảng 440 MB.
  - Bộ nhớ thật (working set) tăng khoảng +140 MB: hàm dựng `KNpc` chạm cả 605 MB, còn heap mission giảm 162 MB.
- Ảnh `CoreServer.dll` liền khối khoảng 1,12 GB (trước 0,98 GB). DLL nạp lúc khởi động, khi địa chỉ còn trống, có relocation nên vẫn nạp được nếu vị trí ưa thích bị chiếm.
- Mission mỗi cái giữ vài trăm NPC (Vạn Tiên: boss, quái, rương, đại phu). Danh sách đầy thì `AddMSNpc` chỉ trả 0, không hỏng gì.

**Kiểu dữ liệu chỉ số NPC:** chỉ số luôn là `int` ở server. Không có chỗ lưu dạng 16 bit hay ghép `<<16`; đã rà mọi `WORD`/`short`/`MAKELONG` trong `Sources`. Gói tin xuống client dùng `m_dwID` (DWORD), không dùng chỉ số server, nên client không cần sửa.

**Hai vùng chỉ số (`KNpcSet.cpp`, dấu `engine2:A4`):**

- 14 script Lua quét chỉ số `1..47999`: servertimer `PTADM_MAX_NPC`, bots, vienco, vanluong, tienma, tienma45, sudo_dongdi, daily3, congthanh, newbie2/nb2_lib, questfix2/3, npcnames. Nếu quái thêm chiếm hết ô thấp, NPC tính năng sinh sau sẽ nằm trên 48.000 và các script đó không thấy.
- `PtFindFree()`: NPC thường lấy vùng thấp trước, như cũ; vùng thấp đầy mới sang vùng cao.
- Native mới `SetNpcAllocZone(1)`: các `AddNpc` **trong cùng vòng game** chỉ lấy vùng cao, vùng cao đầy thì trả 0, không tràn xuống vùng thấp. Hết vòng game thì tự tắt, hoặc gọi `SetNpcAllocZone(0)`. `GetNpcLowZone()` trả 48.000.

**`matdo.lua` (sinh bởi `S\matdo\gen_matdo.py`):**

- `PTMD_Limits()` chạy mỗi tick:
  - `MAX_NPC = GetNpcCount() + GetFreeNpcCount() + 1`. Native `GetFreeNpcCount` có sẵn, bằng `MAX_NPC − 1 − số NPC`.
  - Trần `PTMD_CAP` = MAX − 4.000 (`PTMD_RESERVE`).
  - Có `SetNpcAllocZone` thì bật vùng cao quanh lệnh `AddNpc` của quái thêm, và giới hạn số quái thêm ≤ kích thước vùng cao (48.000).
- Vòng quét nhận lại quái thêm chạy tới `PTMD_MAXNPC`.
- Với DLL cũ: không có native vùng, giới hạn 48.000, kết quả trùng từng dòng với bản cũ (`out_matdo.txt` trước/sau chỉ khác số biến `PTMD_` được xóa: 88 → 90).
- Với DLL mới (sim): x2 cho **cả 57 bản đồ cùng lúc** (30.723 quái thêm; bản cũ chỉ được 39 % ở bản đồ không có người). x3 bị giới hạn ở 48.000 quái thêm.

### 2.2 C5 — Đệ kỹ năng 450–461

- Đã kiểm tra `KSkills.cpp` `SKILL_SS_CreateNpc`:
  - Nhánh `pet10` đặt cấp NPC = cấp học + 5 × (cấp − 1).
  - Sinh lực và sát thương gốc × (100 + 50 × (cấp − 1)) %, không cộng chỉ số chủ.
  - Kỹ năng ô 1–4 cùng id được đặt theo cấp đệ (bản vá vancot).
  - Đây đúng là bảng `PTPE_Stats` của đệ Lệnh Bài, nên **không cần sửa thêm**.
- Native mới `GetSummonPetIdx()` (`ScriptFuns.cpp`): trả `Npc[người chơi].m_nPetIdx` khi đệ còn sống, cùng chủ, còn trên bản đồ; ngược lại trả 0. Trước đây chưa có hàm nào trả chỉ số này, chỉ có `PetGetType` trả mẫu NPC.
- Đã sửa `pet-exp-phong-than-20261003.md` mục 2.3, 2.5 và "Bước tiếp theo".

### 2.3 D1 — `AddIBBuff` theo vật phẩm IB

**Nguyên nhân:** `ApplyNativeIBBuffState` tung **kỹ năng** có cùng số hiệu (175 → dấu hiệu vô hạn, 176 → chạy nhanh, 12/13 → kỹ năng bị động / chiêu đánh). Thời gian mặc định cũng lấy theo kỹ năng.

**Cách sửa:**

- `KBASICPROP_IBITEM` có thêm `m_nBuffSeconds` và 6 cặp thuộc tính.
  - Đọc cột 15 và cột 31–42 của `ibitem.txt`, tính lệch từ cột ảnh như các cột khác (`KBasPropTbl.CPP`).
  - Cùng cột với `S\ibitem\gen.py`.
- `ApplyNativeIBBuffState`: id có dòng `ibitem` thì áp các thuộc tính của dòng đó bằng `SetStateSkillEffect`.
  - Lợi ích của trạng thái engine: giữ qua mỗi lần engine tính lại chỉ số, tự hết hạn, có gửi xuống client.
  - Không vẽ hình trạng thái của kỹ năng trùng số.
  - Trạng thái cũ cùng id bị gỡ trước khi áp lại.
  - Id không có dòng `ibitem` thì giữ cách cũ.
- **Chỉ áp thuộc tính cộng thẳng, gỡ được:**
  - Danh sách `SAFE_ATTRS` mà `pt_ibitem_lib.lua` đã dùng, thêm 181 (kinh nghiệm) và 187 (kinh nghiệm kỹ năng ×2).
  - Không áp 87/91/95 (máu/nội lực tức thời), 221 (khóa di chuyển), 194/195 (engine không có hàm xử lý).
  - Dòng không còn thuộc tính nào thì là dấu hiệu, như trước.
- Thời gian mặc định = cột giây của `ibitem` (VNG).
- **Bản ghi cũ:** khi đăng nhập, `RestorePhongThanIBBuffs` xử lý các bản ghi lưu "vô hạn" bởi engine cũ mà dòng `ibitem` có thời hạn.
  - Bản ghi được tính lại thời hạn từ lúc đăng nhập. Ví dụ 215 Nhân giả: còn 30 phút để làm tiếp Trừ Yêu.
  - Riêng 12/13/175/176 (thưởng sai cũ của Càn Khôn Luân, cankhon3 cũng gỡ) thì bị xóa. Như vậy không tự bù ×2 cho ai, đúng ghi chú "không tự bù" của cankhon3.
- **`pt_ibitem_lib.lua`:**
  - Thêm `PTIB_ExpRate()` = `GetNpcExpRate()` trừ phần kinh nghiệm do trạng thái (native mới `GetNpcStateExpRate`).
  - Không có hàm này: bản cũ coi một trạng thái engine bắt đầu hoặc kết thúc là "engine tính lại chỉ số", rồi áp buff của thư viện **lần thứ hai** (sim: 202 thay vì 101).
  - DLL cũ không có native nên kết quả như trước.

**Kết quả theo dòng `ibitem.txt` thật (smoke):**

| id | Vật phẩm | Thời gian | Hiệu quả sau sửa | Dùng ở |
|---|---|---|---|---|
| 12 / 13 | Dao Linh tán / Dao Tô tán | 3.600 giây | hồi sinh lực / nội lực +10 | (Càn Khôn cũ) |
| 175 | Nhân đôi điểm kinh nghiệm | 3.600 giây | kinh nghiệm +100 % | (Càn Khôn cũ) |
| 176 | Nhân 1.5 điểm kinh nghiệm | 7.200 giây | kinh nghiệm +50 % | **túi quà Võ Lâm Đại Hội** |
| 330 | Lâm Tiên Lộ | 3.600 giây | kinh nghiệm kỹ năng ×2 | túi quà Võ Lâm Đại Hội |
| 228 | Thần Tài | 604.800 giây | dấu hiệu (194/195 chưa có trong engine) | túi quà Võ Lâm Đại Hội |
| 215 | Nhân giả | 1.800 giây | kinh nghiệm +100 % (đúng lời thoại Trừ Yêu) | sudo_dongdi, `normal.lua` |
| 216 | Dũng giả | 1.800 giây | sinh lực +20 %, chạy −20 % | thử thách sư đồ |
| 217, 326–350, 418, 783, 678 | dấu hiệu nhiệm vụ | theo dòng | dấu hiệu | nhiều script |
| 1359 / 1360 | Bánh Trôi | 600 giây | phép +5 / tốc độ đánh, ra chiêu +5 | sự kiện |
| 8691/8692/8716 | Huyền Vũ (hv_lib) | theo dòng | chỉ lưu bản ghi (id ≥ 4.096, như trước) | Tứ Linh |

**Túi quà Võ Lâm Đại Hội** (`script\活动脚本\武林大会大礼包.lua`):

- Lệnh gọi `AddIBBuff(176)` / `(330)` / `(228)` đúng theo VNG. Sai là ở engine, nên **không sửa script**.
- Bản loose của file này không được đọc (đường dẫn GBK), bản thật nằm trong PAK. Sửa trong PAK sẽ cần ptfix mới mà không cần thiết.
- Từ DLL mới: 176 = kinh nghiệm +50 % trong 2 giờ, đúng thông báo trong script.

### 2.4 D2 — Credit = Danh vọng

- `LuaGetCreditVng` / `LuaAddCreditVng` / `LuaDecCreditVng` (`PhongThanDieuTriLua.inl`) và dịch vụ Xích Tùng Tử (`PhongThanXichTungTuService.inl`): dùng `TASKVALUE_STATTASK_REPUTE` (210), có đồng bộ xuống client.
- **Chuyển dữ liệu một lần:** `PhongThanMigrateCreditToRepute`:
  - Danh vọng += ví ẩn `TASKVALUE_PT_CREDIT` (4840, có chặn tràn số), rồi ví ẩn = 0, ghi `[engine2] credit … added to repute …` vào log.
  - Gọi lúc đăng nhập (`KPlayerDBFuns.cpp`, ngay sau `RestorePhongThanIBBuffs`) và trước mỗi lệnh credit.
  - Chạy lại không cộng lần hai.
- Script dùng credit:
  - `xich_tung_tu.lua`, `赤松子.lua` (đổi 10 credit), `绿林好汉.lua`, `神秘镖头.lua`: đọc/trừ `GetCredit`/`DecCredit`.
  - 30 chỗ `AddCredit` của nhiệm vụ (Đặng Cửu Công, Vũ Vương, Dương Tiễn, Thủ Khố…).
  - Không script nào khác gọi cả `AddRepute` lẫn `AddCredit`, trừ Càn Khôn Luân.
- **Càn Khôn Luân:** `S\cankhon3\gen3.py`, `PT_CKL_Repute` chỉ còn `AddRepute(n)`. File `npc_fix\1020_thai_tue.lua` sinh lại, chỉ khác 3 dòng.
- Lưu ý: từ DLL mới, đổi đồ ở Xích Tùng Tử trừ vào Danh vọng F3. Shop dùng Danh vọng và yêu cầu Danh vọng khi lập bang vốn đã dùng task 210.

### 2.5 D3 — DeadlyStrikeResist và enhance_fatallystrike_p

- `PhongThanNpcDeadlyStrikeResist(mẫu)`: đọc cột `DeadlyStrikeResist` (cột 105) của `npcs.txt`, kẹp 0–100, có bộ nhớ đệm, cùng cách đọc `FatallyStrikeResist`.
  - Kết quả: 96 mẫu miễn nhiễm (gồm 2 dòng 200/300), 37 mẫu 50–95, còn lại 0.
- `ReceiveDamage`: sau khi tung `bIsDS` (đánh tập trung), mục tiêu là NPC thì có thêm một lần tung theo kháng của mẫu; trúng thì mất đánh tập trung. Người chơi không đổi.
  - Sim với xác suất 50 %: kháng 0 → 50,3 %, kháng 50 → 24,7 %, kháng 100 → 0 %, người chơi → 49,8 %.
- Thuộc tính 295 `enhance_fatallystrike_p` ("Tăng hiệu quả chí mạng dị nhân: +X%"):
  - Hàm xử lý mới `KNpcAttribModify::EnhanceFatallyStrikeP` cộng vào `KNpc::m_CurrentFatallyStrikeLifeP`. Giá trị này được đặt lại cùng các chỉ số khác.
  - `PhongThanFatallyStrike` nhân lượng máu mất (1/4 máu hiện tại) với (100 + X) %, tính bằng số 64 bit, kẹp ≤ máu − 1, nên vẫn không giết ngay.
  - Ví dụ: 10.000 máu, +32 % (Buff Tâm Pháp Phật Giáo) → 3.300; boss 130 triệu máu, +10 % → 35.750.000.

### 2.6 D4 — Giữ chuột phải

- `UiGame.cpp` `WM_MOUSEMOVE`: trước đây gọi `HandleMouseInput(0, VK_RBUTTON, …)`, đảo phím với tổ hợp phím, nên không tìm thấy lệnh nào. Nay gọi `HandleMouseInput(VK_RBUTTON, Ctrl/Shift/Alt, x, y)`.
- **Chặn tần suất:**
  - Chỉ gửi khi `PAIOperation('PTRB')` trả 1. Đây là truy vấn mới trong `CoreShell.cpp`: nhân vật `IsCanInput()` (không đang ra đòn, trúng đòn) và không giao dịch.
  - Hai lần lặp cách nhau ít nhất 150 ms.
  - Lúc đang ra chiêu không gửi gì, nên đường xếp hàng `daosi:Q2` không bị dồn lệnh.
- Sim (di chuột 8 ms/lần trong 5 giây): chiêu 600 ms → 9 lệnh, 0 lệnh lúc đang ra chiêu; chiêu cực nhanh → 34 lệnh (giới hạn 150 ms).

### 2.7 Các bản vá giữ nguyên

`verify_diff.py`:

- 16 file, chỉ thêm dòng ASCII.
- Số byte không phải ASCII giữ nguyên.
- Dòng bị thay đúng 15 dòng dự kiến (`MAX_NPC`, typedef mission, 5 lệnh danh sách tự do, 5 dòng credit, 2 dòng Xích Tùng Tử, lệnh chuột phải).
- Số lần xuất hiện của mọi dấu cũ giữ nguyên: petfight, PhongThanPetTargetOk, petrange, petdebug, onepet, pet10, skillself, dinhanbot, bot9x, daosi:, vancot, lbdaosi, weaponequip, noexppenalty, desertexp, m_bCanStack, partypanel, autofight, questtrack, items, botheal.

## Phần 3: Hành động

### Đã làm

- [x] Sao lưu `_backup\20261004-engine2\` (Core_Src 15 file, GameClient\UiGame.cpp, Lua 3 file, scratch gen_matdo/matdo_body/matdo_head/gen3.py, docs, CHANGELOG).
- [x] Vá C++ ở mức byte: `S\engine2\patch_src.py` (chạy lại không trùng, mọi chỗ có dấu `engine2:`).
- [x] Build `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả 3 OK, biên dịch lại toàn bộ.
- [x] Smoke C++ `S\engine2\smoke\` (`build.cmd`): **2.789 đạt / 0 lỗi**.
  - Trích đúng khối mã đã vá, chạy với mock.
  - Dữ liệu thật: 9.332 dòng `ibitem.txt` qua chính `KBPT_IBItem::LoadRecord`/`FindRecord`, 2.721 mẫu `Npcs.txt`.
- [x] Sim Lua (`S\qtest`):

| Sim | Kết quả |
|---|---|
| `sim_matdo.lua -Stack 100` và EMU (DLL cũ) | FAILS=0, headroom 39 |
| `sim_matdo_e2.lua -Stack 100` và EMU (DLL mới) | FAILS=0, headroom 39 |
| `sim_cankhon3_e2.lua` thường và EMU | FAILS=0 (gồm toàn bộ cankhon2), headroom 38 |
| `sim_cankhon3.lua` với script mới | chỉ 2 kiểm tra cũ "credit +15/+10" khác, đúng như thiết kế |
| `sim_ibstate_e2.lua` | FAILS=0; bản thư viện cũ FAILS=3 (áp hai lần) |

- [x] `matdo.lua` chép runtime, nạp nóng qua bridge 20:36: `max 48000 cap 44000 zone nil npc 43974 free 4025` (DLL cũ, chạy như trước).
- [x] `pt_ibitem_lib.lua`, `npc_fix\1020_thai_tue.lua` đã chép runtime, **không nạp nóng**: chúng chỉ có nghĩa với DLL mới.
  - Lần khởi động lại server khi triển khai sẽ tự nạp.
  - Thư viện IB trên DLL cũ chạy y như trước.
  - Càn Khôn trên DLL cũ chỉ cộng Danh vọng (sau triển khai credit = Danh vọng nên không mất gì).

### Coordinator cần làm (một đợt)

1. Tắt GameServer + Bishop, triển khai:
   - `Sources\Core\Modern\Win32ServerRelease\CoreServer.dll` → Server.
   - `Sources\Core\Modern\Win32ClientRelease\CoreClient.dll` + `Sources\GameClient\Modern\Win32Release\Game.exe` → Client.
   - Ba file phải đi cùng nhau: `sizeof(KNpc)` đổi, `Game.exe` đọc `Npc[]` của `CoreClient.dll`.
2. Không cần ptfix. Không cần chép thêm Lua: `matdo.lua`, `pt_ibitem_lib.lua`, `1020_thai_tue.lua` đã ở runtime.
3. Khởi động lại GameServer. Kiểm tra `admin_bridge\matdo.txt` dòng `total`, cột trần phải là 92000.
   - Web admin thẻ "Sức khỏe server" đang ghi cứng "/ 48.000", nên sửa thành đọc trần từ `matdo.txt`.
4. Kiểm thử trong game:
   - Giữ chuột phải và di chuột: chiêu tay phải lặp, không giật.
   - Mở túi quà Võ Lâm Đại Hội: nhận kinh nghiệm +50 % 2 giờ.
   - F3 Danh vọng cộng thêm credit cũ.
   - Xích Tùng Tử đổi 10 Danh vọng.
   - Bật x2 trong tab "Mật độ & hồi quái": mọi bản đồ đủ x2.

### Rủi ro còn lại

- Gấp đôi số quái làm tăng tải CPU và gói đồng bộ theo vùng. Ngân sách vẫn do tab Mật độ điều khiển.
- Id IB trùng với một kỹ năng trạng thái thật mà người chơi đang có thì hai trạng thái gộp làm một. Lỗi này đã có từ trước, nay hiếm hơn.
- Vật phẩm 8/175 dùng qua `pt_ibitem.lua` (thư viện Lua) và `AddIBBuff(175)` (trạng thái engine) là hai đường riêng, có thể cộng dồn nếu cùng lúc.

## Phần 4: Tài liệu tham khảo

- Báo cáo nguồn: `de-xuat-tinh-nang-phong-than-20261004.md` (A4, C5, D1–D4), `can-khon-luan-quay-cpp-phong-than-20261002.md` (Bổ sung 2026-10-04), `van-cot-toan-kho-phong-than-20261004.md`, `dao-si-nhieu-chieu-phong-than-20261004.md` (3.4), `mat-do-hoi-quai-phong-than-20261004.md`, `pet-exp-phong-than-20261003.md`.
- Script: `S\engine2\patch_src.py`, `verify_diff.py`, `smoke\extract.py` + `engine2_test.cpp` + `build.cmd`, `make_sim_e2.py`, `pending_matdo.lua`; `S\matdo\gen_matdo.py`; `S\cankhon3\gen3.py`.
- Rollback: chép lại `_backup\20261004-engine2\Core_Src\*` vào `Core\Src`, `GameClient\UiGame.cpp` vào `GameClient\Ui\UiCase`, build lại 3 target. Lua: chép 3 file trong `Lua\` về runtime. Lưu ý: credit đã chuyển vào Danh vọng thì không tự tách lại được.
