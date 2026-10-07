---
title: Bot tổ đội Dị Nhân không đánh + đệ tử của bot Dị Nhân
slug: dinhan-bot
date: 2026-10-04
status: Lua xong (chờ cài runtime), C++ đã build (chờ triển khai CoreServer)
tags: [bot-to-doi, di-nhan, de-tu, ai11, cpp, lua]
summary: >
  Bot tổ đội Dị Nhân (mẫu 2715–2720) chỉ dùng kỹ năng ô 4 là 49 Trảm Tâm Chú. Đây là chú nguyền giảm lực tấn
  công của địch, không có thuộc tính sát thương, nên bot "đánh" mà quái không mất máu. Cách sửa: party.lua đổi ô 4
  sang 44 Thôi Thân Chú. Ngoài ra bot Dị Nhân giờ gọi 1 đệ tử theo cấp người chơi; đệ đi theo bot và đánh quái.
  Phần đệ tử cần C++ mới (AddNpcPet, GetNpcPetIdx, chuỗi chủ trong CalcDamage).
  Phần 6 (botheal): bot Dị Nhân hồi máu bằng Bổ Tâm Chú (ô 1 = 45), Bổ Tâm Chú tung lên đồng minh thì hồi
  quanh đồng minh đó, bot chết được thay sau 5–10 giây.
---

# Bot tổ đội Dị Nhân không đánh + đệ tử của bot Dị Nhân

## Phần 1: Tổng quan

- **Nguyên nhân là dữ liệu, không phải engine.** AI 11 của bot (`KNpcAI::ProcessAIType11`, `KNpcAI.cpp` dòng 1828) luôn gọi `SetActiveSkill(4)`. Bot Dị Nhân có ô 4 là **49 Trảm Tâm Chú**. Chiêu này là chú nguyền (debuff): chỉ gắn trạng thái giảm lực tấn công lên địch, không gây sát thương. Bot vẫn niệm chú, nhưng quái không mất máu.
- Giáp Sĩ (ô 4 = 41 Thiên Quân Trảm) và Đạo Sĩ (ô 4 = 18 Thập Phương Liệt Hỏa) có ô 4 là chiêu sát thương, nên đánh bình thường.
- **Người chơi Dị Nhân không bị lỗi engine.** 47 Phá Giáp Chú và 49 Trảm Tâm Chú là chú nguyền theo thiết kế VNG: người chơi dùng cũng không ra sát thương. Chiêu đánh của Dị Nhân là 44 Thôi Thân Chú; chiêu này dùng MisslesForm 6 (AtTarget) với missile 128 đứng yên tại mục tiêu, giống hệt cách Giáp Sĩ 41 dùng missile 123. Lỗi nổ về bản thân của Chưởng Tâm Lôi / Băng Tuyết Đạn / Tích Lịch Hỏa (dạng Line) đã được bản vá skillself sửa; lỗi này không liên quan.
- **Đệ tử của bot Dị Nhân:** trước đây bot không có đệ. Giờ mỗi bot Dị Nhân gọi 1 đệ. Mẫu đệ chọn theo cấp người chơi, cùng bảng `PTTH_LIST` của Lệnh Bài Triệu Hồi; cấp đệ 1–10 theo công thức pet10. Chủ của đệ là chính bot NPC. Kinh nghiệm, đồ rơi và LastDamage từ đòn đánh của đệ được tính cho người chơi.

## Phần 2: Chi tiết

### 2.1 Bằng chứng dữ liệu

| Kỹ năng | Dữ liệu (`settings\skills.txt`, ptfix) | Script cấp (`script\skill\yiren\*.lua`) | Kết luận |
|---|---|---|---|
| 49 Trảm Tâm Chú (ô 4 của bot) | StateSpecialId 14, LvlSetting1 `addphysicsdamage_v`, child 127 (MoveKind 0, DmgRange 10) | `addphysicsdamage_v = -(20 + 5·lv)` trong `72 + 18·lv` khung | Chỉ trừ lực tấn công, **0 sát thương** |
| 47 Phá Giáp Chú | StateSpecialId 12, `addexdefense_v`, `allres_p`, child 131 | `-(30 + 2·lv)` phòng thủ, `-(15 + lv)`% kháng | Chú nguyền, 0 sát thương |
| 44 Thôi Thân Chú | IsPhysical 1, `physicsenhance_p`, MisslesForm 6, child 128 (Stand, CollidRange 1) | `physicsenhance_p = 16 + 4·lv` | **Chiêu đánh** (giống 41 của Giáp Sĩ) |
| 45 Bổ Tâm Chú | TargetAlly / TargetSelf, `lifepotion_v` | — | Hồi máu đồng minh |

Dòng dữ liệu bot trong `settings\phongthan\Npcs.txt` (file rời, server và client giống nhau): dòng file 2716–2721, tức mẫu 2715–2720, có Skill1..4 = 44 / 45 / 47 / 49, Level `10|0`. Cách đọc `10|0` không có lỗi: Giáp Sĩ và Đạo Sĩ ghi cùng dạng và đánh bình thường.

Những nghi phạm khác đã loại trừ:
- Missile 127 / 128 / 131: không phải lỗi va chạm. 128 có cùng dạng với 123 của Giáp Sĩ (Stand, CollidRange 1).
- `CastMissles` với `SKILL_MF_AtTarget` (`KSkills.cpp` 1185): không phân biệt NPC hay người chơi.
- Mana / vũ khí: NPC không bị trừ cost (`m_Kind != kind_player || Cost(...)`).

### 2.2 Sửa kỹ năng (chỉ Lua)

`script\phongthan\bots\party.lua` (nguồn `scratchpad\botparty\src\party.lua`, sinh bằng `gen.py`), hàm `PTBP_DnTick`:
- Với mọi bot tổ đội mẫu 2715–2720, gọi `SetNpcSkill(bot, 44, 10, 4)` và `SetNpcSkill(bot, 49, 10, 1)` (đổi chỗ ô 1 và ô 4). Mỗi bot chỉ làm 1 lần, đánh dấu bằng NpcParam 3 = 1.
- Không sửa `Npcs.txt` vì file rời này nhiều tính năng dùng chung. Nếu đưa vào ptfix thì các lần sửa file rời sau này sẽ bị ptfix che mất.
- Engine hiện tại đã có `SetNpcSkill`, nên phần này có hiệu lực ngay khi cài party.lua, không cần khởi động lại.

### 2.3 Đệ tử của bot Dị Nhân

**Lua (`party.lua`):**
- `PTBP_PetPick(lv)` chọn hàng cao nhất của `PTBP_PET` (= `PTTH_LIST`: 359/5 … 2032/120) có cấp học ≤ cấp người chơi. Cấp đệ = `(lv - cấp học) / 5 + 1`, giới hạn 1–10. Cấp NPC = `cấp học + 5·(cấp đệ - 1)`, không vượt cấp người chơi. Ví dụ người chơi cấp 50 được 403 Hỏa Lôi tế, NPC cấp 50, đệ cấp 2.
- Mỗi phút (`PTBP_Player`), nếu bot Dị Nhân chưa có đệ thì gọi `AddNpcPet(bot, mẫu, cấp NPC, cấp đệ)` và đặt tên `"[Đệ tử] <tên bot>"`. Mỗi tick, phe hiện tại của đệ được đồng bộ theo bot (chiến trường Thương Chu: phe 1/2).
- `PTBP_DelBot` xóa đệ cùng bot (bot chết hoặc lạc, giảm số bot, tắt tổ đội, `PTBP_DismissAll`).
- Giới hạn toàn server `PTBP_PET_MAX_TOTAL = 60` đệ (lấy số của tick trước và tick đang chạy).
- Nếu engine chưa có `AddNpcPet` / `GetNpcPetIdx` (C++ cũ) thì không gọi đệ, chỉ sửa kỹ năng. Không báo lỗi.

**C++ (build, chưa triển khai):**

| File | Thay đổi |
|---|---|
| `PhongThanBotPet.h` (mới) | `AddNpcPet(owner, tpl, npclevel, petlevel)`: chủ phải là NPC sống, không phải người chơi. Đệ có AiMode 11; `m_nOwnerIdx` = bot; `Owner[]` = tên bot; `bot.m_nPetIdx` = đệ (mỗi bot 1 đệ, đệ cũ bị xóa). Phe, hệ và tốc độ lấy theo bot. Máu và sát thương gốc nhân `(100 + 50·(lv-1))%`, ô 4 = kỹ năng của mẫu ở cấp đệ, giống pet10. `GetNpcPetIdx(owner)` trả về đệ đang sống hoặc 0. |
| `ScriptFuns.cpp` | `#include "PhongThanBotPet.h"` sau `PhongThanPartyBot.h`; đăng ký `AddNpcPet`, `GetNpcPetIdx`. |
| `KNpc.cpp` (`CalcDamage`) | Trước đây chỉ 1 bước `nAttacker = owner`, nên đòn của đệ bị tính cho bot (một NPC): không ai nhận kinh nghiệm, phần kinh nghiệm của người chơi bị hụt đúng bằng sát thương của đệ, đồ rơi và LastDamage rơi vào bot. Giờ engine đi theo chuỗi chủ tối đa 3 bước (đệ → bot → người chơi). |
| `KNpcAI.cpp` (`ProcessAIType11`) | Xóa đệ khi slot của chủ đã trống (`m_dwID == 0`). Lý do: `KNpc::Init` để SubWorld 0 và máu 100, nên đệ ở subworld 0 cứ đi theo một slot rỗng. Với chủ là NPC, xóa đệ cả khi slot đó đã có NPC khác (so tên `Owner` với tên chủ). |

Các trường hợp xóa đệ, không để sót NPC:
- Bot chết, bị xóa, đổi map hoặc ẩn: AI 11 của đệ tự xóa đệ.
- Đệ chết: đoạn botparty:P3 trong `KNpc.cpp` xóa đệ và xóa `m_nPetIdx` của bot.
- Lua xóa bot: `PTBP_DelBot` xóa đệ trước.

Cách cũ là cho bot dùng kỹ năng gọi đệ 450–461 qua `NpcCastSkill`. Không dùng cách này vì: (1) cấp đệ lấy theo kỹ năng đang chọn của bot (luôn là 10); (2) gói SKILL_CAST `DirectEffect` gửi xuống client khiến client chạy cả nhánh `SKILL_SS_CreateNpc`; (3) Lua không lấy được chỉ số đệ để dọn.

### 2.4 Những gì cần triển khai

| Phần | Cần? | Ghi chú |
|---|---|---|
| Lua `party.lua` | Có | `scratchpad\botparty\out\party.lua` (đã sinh, khớp `scratchpad\dinhanbot\out\party.lua`), chép vào `Server\script\phongthan\bots\party.lua`. Lệnh chép đã bị hệ thống quyền từ chối, coordinator chép giúp. servertimer nạp lại ở tick sau. |
| ptfix | Không | Không đổi dữ liệu PAK. |
| C++ server | Có (cho đệ tử và kinh nghiệm của đệ) | `CoreServer.dll` (Modern\Win32ServerRelease, 16:22). |
| C++ client | Không | Mọi thay đổi nằm trong phần `_SERVER` hoặc chỉ chạy ở server. CoreClient và Game.exe được build lại cho chắc, hành vi không đổi. |

## Phần 3: Kiểm tra

- Build `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả 3 OK (16:22). `CoreServer.dll` có chuỗi `AddNpcPet` / `GetNpcPetIdx`. Các bản vá cũ giữ nguyên (chỉ thay đúng 4 đoạn có nhãn `dinhanbot`).
- Mô phỏng `scratchpad\qtest\sim_dinhanbot.lua` (dựng từ `sim_botparty_orig.lua`, giả lập engine: AI 11 chủ là NPC, xóa đệ chết, `SetNpcSkill`, `AddNpcPet`, `GetNpcPetIdx`):
  - `-Stack 100`: pass 66 / fail 14. `-Args1 emu`: pass 66 / fail 14, không tràn stack, không có FLAG `ORPHAN_PET`.
  - 14 FAIL **trùng y hệt** bản gốc `out_botparty_orig.txt`. Đó là kỳ vọng cũ "thành không có bot", sai từ khi có partytown. Không phải lỗi mới.
  - 29 kiểm tra mới đều đạt: bảng đệ = PTTH_LIST; chọn mẫu và cấp theo cấp 3 / 50 / 64 / 200; bot Dị Nhân ô 4 = 44 cấp 10, ô 1 = 49, bot hệ khác không bị đổi; mỗi bot Dị Nhân có đúng 1 đệ (AI 11, chủ = bot, đúng tên, phe, map); không gọi đệ lại khi đệ còn sống; đệ chết thì có đệ mới; bot chết hoặc lạc thì bot và đệ cùng mất; DismissAll; đổi map; phe Thương Chu = 2; giới hạn server 1 rồi 60; engine cũ (không có `AddNpcPet`) chỉ sửa kỹ năng, không lỗi; người chơi cấp 3 được đệ 359 cấp 3.
- Không kiểm tra trực tiếp trong game: việc cài runtime bị từ chối quyền, và C++ chưa triển khai.

## Phần 4: Hành động và tham khảo

- [ ] Coordinator: chép `scratchpad\botparty\out\party.lua` vào `Server\script\phongthan\bots\party.lua` (bot Dị Nhân đánh ngay ở tick sau).
- [ ] Đợt triển khai C++ tiếp theo: `CoreServer.dll` (gồm dinhanbot cùng các bản vá đang chờ). Sau khi triển khai, bot Dị Nhân tự gọi đệ ở tick kế tiếp.
- [ ] Kiểm tra trong game: lập tổ đội bot có bot Dị Nhân, xem bot ra chiêu Thôi Thân Chú và quái mất máu; xem đệ "[Đệ tử] …" đi theo bot và đánh; quái do đệ hạ phải cộng kinh nghiệm cho người chơi.
- Backup: `_backup\20261004-dinhanbot\` (KNpc.cpp, KNpcAI.cpp, ScriptFuns.cpp, party.lua src/out/runtime, CHANGELOG, README).
- Script làm việc: `scratchpad\dinhanbot\` (`patch_cpp.py`, `make_sim.py`, `dump_*.py`, `pakread.py`).
- Liên quan: `to-doi-bot-phong-than-20261003.md`, `petfight-tokenmenu-phong-than-20261003.md`, `pet-exp-phong-than-20261003.md`, `skill-self-target-phong-than-20261004.md`.

## Phần 5: Bot dùng chiêu 9x (bot9x, 2026-10-04)

Yêu cầu: "Bot tổ đội đánh chiêu 9x nhé". AI 11 chỉ dùng ô 4, nên ô 4 của mọi bot tổ đội được đặt thành chiêu cấp 90 của phái.

### 5.1 Chiêu 9x theo phái

Nguồn: `vng00.pak \settings\item\001\skillbook.txt` (sách "Sách kỹ năng <phái> cấp 90"), dữ liệu kỹ năng `settings\skills.txt` (ptfix), script cấp `script\skill\<phái>\*.lua` (serverlist.pak).

| Phái (mẫu bot) | Chiêu cấp 90 | Dạng khi NPC dùng | Ô 4 mới | Cấp đặt |
|---|---|---|---|---|
| Giáp Sĩ (2703–2708) | 42 Khuynh Thành Nhất Kích | IsPhysical, `physicsenhance_p = 40 + 4·lv`; AtFirer, missile 124 (Stand, DmgRange 10 ô) + start 147 (6 missile 133). Đánh lan mọi quái quanh bot, AttackRadius 120. | **42** (thay 41) | 10 → 20 |
| Đạo Sĩ (2709–2714) | 26 Tam Muội Chân Hỏa | `firedamage_v = 300+30·lv … 400+40·lv`; Wall đặt tại mục tiêu, missile 51 (DmgRange 15), TimePerCast 40 (bằng 18 cũ). | **26** (thay 18) | 10 → 20 |
| Dị Nhân (2715–2720) | 51 Vạn Cốt Toàn Khô | Chỉ có `fatallystrike_p`, AddBaseDamage 0, IsUseAR 0. `KNpc::CalcDamage` thoát khi min + max = 0, và `bIsFS` chỉ dùng cho sát thương phản đòn. Ngoài ra đây là dạng Line + missile Stand sinh tại người tung (bản vá skillself không áp vì TargetOnly 0). **Không gây sát thương.** | giữ **44** Thôi Thân Chú | 10 → 20 |

- Ngũ hành không tách chiêu: trong Phong Thần, `GetSeries()` của người chơi là phái (0 Giáp Sĩ, 1 Đạo Sĩ, 2 Dị Nhân; xem các script tân thủ). Series trong `Npcs.txt` của bot chỉ là ngũ hành NPC, và không kỹ năng nào có cột Series. Vì vậy mỗi phái có đúng 1 chiêu cấp 90, không phụ thuộc Series của mẫu bot.
- Bốn chiêu "Ma pháp tối cao" của Đạo Sĩ là 23 Lôi Động Cửu Thiên (cấp 78), 24 Huyền Nữ Bổ Thiên (82), 25 Băng Phong Vạn Lý (86) và 26 Tam Muội Chân Hỏa (90). Chỉ 26 là chiêu cấp 90. 23 có TimePerCast 125: bot chỉ có ô 4 nên sẽ đứng yên khoảng 6 giây giữa hai lần ra chiêu.
- Không chiêu nào được chọn là dạng Line + Stand nổ tại người tung. 42 là AtFirer theo thiết kế: vùng sát thương 10 ô quanh bot, rộng hơn tầm đánh 120.
- Dị Nhân không có chiêu 9x đánh được: 458 Phong Quyển Tàn Vân (cấp 85) là chiêu gọi đệ, phần này đã có đệ tử bot lo.

### 5.2 Cấp kỹ năng

- Bot cấp dưới 90: cấp 10, bằng cấp mẫu và MaxLevel 10.
- Từ cấp 90: cứ 3 cấp nhân vật thêm 1, tối đa 20 (bot cấp 120). Engine nạp được mọi cấp < 64 từ script cấp: `KSkillManager::InstanceSkill` quét lại bảng một lần rồi cache.
- Cấp bot lấy bằng `GetNpcLevel(bot)`; nếu engine không có hàm này thì lấy cấp người chơi.

### 5.3 Lua (`party.lua`, nguồn `scratchpad\botparty\src\party.lua`)

- Thêm bảng `PTBP_SK` (mẫu → chiêu), `PTBP_SkLevel(lv)` và `PTBP_SkTick(bot, lv)`. `PTBP_Player` gọi `PTBP_SkTick` cho mọi bot ngay trong tick sinh bot, trước `PTBP_DnTick`.
- `SetNpcSkill(bot, chiêu, cấp, 4)` chỉ ghi ô 4; ô 1–3 giữ chiêu của mẫu. Riêng Dị Nhân vẫn đặt ô 1 = 49 như dinhanbot.
- Chỉ đặt một lần: NpcParam 3 = 2. Bot do bản dinhanbot sinh ra (NpcParam 3 = 1) được nâng ở tick kế tiếp, nên bot đang sống cũng đổi chiêu sau khi nạp nóng.
- `PTBP_DnTick` không còn tự đổi kỹ năng, chỉ lo đệ tử. Toàn bộ phần đệ tử (dinhanbot) và map, phe (vtcc) giữ nguyên.
- Không cần C++ mới: `SetNpcSkill` và `GetNpcLevel` đã có trong engine hiện tại.

### 5.4 Kiểm tra

- `scratchpad\qtest\sim_bot9x.lua` (sinh từ `sim_dinhanbot.lua` bằng `scratchpad\bot9x\make_sim.py`, thêm mục 15): pass 82 / fail 14 ở cả `-Stack 100` lẫn emu. 14 FAIL trùng y hệt `out_dinhanbot.txt` (kỳ vọng cũ "thành không có bot"). Không có ERR hay FLAG. Headroom tick 37 khung, bằng bản dinhanbot.
- 16 kiểm tra mới đều đạt: công thức cấp; 18/18 mẫu nhận đúng chiêu; quái và mẫu 2721 không bị đụng; 7 bot đủ 3 phái có ô 4 = 42/26/44, cấp 10, cờ 2; ô 1–3 không đổi; đệ Dị Nhân vẫn có; tick ổn định không gọi lại `SetNpcSkill`; người chơi cấp 110 → chiêu cấp 16/17 theo cấp bot; bot cũ (cờ 0/1) được nâng; không có `GetNpcLevel` thì lấy cấp người chơi (120 → 20); không có `SetNpcSkill` thì bot vẫn ra, không lỗi; đổi map thì bot mới có chiêu ngay trong tick sinh.
- `sim_vtcc_bp.lua` (thường và emu): FAILS=0, kết quả giống hệt trước khi sửa.

### 5.5 Triển khai

- [ ] Coordinator: chép `scratchpad\botparty\out\party.lua` (22073 byte, gồm cả dinhanbot và vtcc) vào `Server\script\phongthan\bots\party.lua`. Bản `scratchpad\dinhanbot\out\party.lua` đã cũ, đừng dùng. servertimer nạp lại ở tick sau, bot đang sống đổi chiêu trong 1 phút.
- Không cần ptfix, không cần C++, không cần khởi động lại.
- Kiểm tra trong game: bot Giáp Sĩ ra Khuynh Thành Nhất Kích (đánh lan quanh bot), bot Đạo Sĩ ra Tam Muội Chân Hỏa, bot Dị Nhân vẫn ra Thôi Thân Chú và quái mất máu.
- Backup: `_backup\20261004-bot9x\` (src/out party.lua, sim_dinhanbot.lua, CHANGELOG, tài liệu này).

### 5.6 Vòng 2: Đạo Sĩ đánh luân phiên 3 chiêu, đệ Dị Nhân là Phong Quyển Tàn Vân

Bảng chiêu mới (cấp chiêu vẫn theo công thức 5.2):

| Phái | Ô 1 | Ô 2 | Ô 3 | Ô 4 |
|---|---|---|---|---|
| Giáp Sĩ 2703–2708 | 42 | 42 | 42 | 42 Khuynh Thành Nhất Kích |
| Đạo Sĩ 2709–2714 | 26 | 23 Lôi Động Cửu Thiên | 25 Băng Phong Vạn Lý | 26 Tam Muội Chân Hỏa |
| Dị Nhân 2715–2720 | 44 | 44 | 44 | 44 Thôi Thân Chú (bỏ 49) |

- 23 Lôi Động Cửu Thiên: AtTarget, 8 missile 18 (Stand tại vùng mục tiêu, DmgRange 4), `lightingdamage_v = 1 … 200+20·lv`, TimePerCast 125.
- 25 Băng Phong Vạn Lý ("Băng Hồng Vạn Lý"): AtTarget, missile 1 rồi vòng 117 (32 missile), `colddamage_v = 120+15·lv … 200+25·lv`, TimePerCast 20.
- Cả hai gây sát thương thật, AddBaseDamage 1. Không chiêu nào là dạng Line + Stand.

**C++ (`KNpcAI.cpp`, marker `bot9x`, build CoreServer 17:16, chưa triển khai):**
- `ProcessAIType11` không còn gọi `SetActiveSkill(4)` cố định. Thay vào đó gọi `PhongThanAi11PickSkill`, hàm này lấy các ô 1–4 thỏa đủ ba điều kiện:
  - id và cấp > 0;
  - chiêu thuộc style Missles, Melee hoặc PhongThanAttack;
  - đã hết TimePerCast (`KSkillList::CanCast`, đúng phép thử của `KNpc::DoSkill`).
- Trong các ô đó chọn ngẫu nhiên một ô. Nhờ vậy chiêu đang hồi (ví dụ 23) bị bỏ qua, bot không đứng yên.
- Không ô nào sẵn sàng thì dùng ô 4, như cũ.
- NPC chỉ có ô 4 và đệ triệu hồi (cùng một id ở cả 4 ô) có hành vi không đổi.
- Engine cũ (chưa có bản này): bot chỉ dùng ô 4, tức Đạo Sĩ ra 26, Giáp Sĩ ra 42, Dị Nhân ra 44.

**Đệ của bot Dị Nhân:**
- Luôn là Phong Quyển Tàn Vân: kỹ năng 458 → mẫu 407 (bảng summon `vng00.pak`, PTTH_LIST hàng 9, cấp học 85).
- Cấp đệ theo pet10: `(cấp người chơi − 85) / 5 + 1`, giới hạn 1–10. Cấp NPC = `85 + 5·(cấp đệ − 1)`, không vượt cấp người chơi.
- Cả 4 ô đặt chiêu 145 (tên VNG "arrow thổ 3": mũi tên vật lý bắn tỏa, `physicsenhance_p`) ở cấp đệ.
- Lý do đặt cả 4 ô: `AddNpcPet` chỉ nâng ô 4, mà engine ra chiêu theo cấp của ô đầu tiên có cùng id (`KSkillList::FindSame`), nên đệ thực tế chỉ đánh cấp 1.
- Đệ mẫu khác do bản dinhanbot sinh ra bị xóa và gọi lại ở tick sau.

**Kiểm tra:**
- `sim_bot9x.lua` (round 2): 86 pass / 14 fail ở cả `-Stack 100` lẫn emu. 14 fail trùng y hệt bản gốc. Headroom tick 37 khung, không có FLAG.
- Các kiểm tra mới đều đạt:
  - 18/18 mẫu nhận đủ 4 ô;
  - 7 bot đủ 3 phái, cờ 3;
  - đệ là 407 với chiêu 145 ở cấp đệ (người chơi cấp 110 thì đệ cấp 6);
  - đệ mẫu cũ bị thay, không sót NPC;
  - bot cờ 0/1/2 được nâng;
  - không có `GetNpcLevel` hoặc `SetNpcSkill` thì không lỗi.
- `sim_vtcc_bp` FAILS=0, giống hệt trước.
- Bộ chọn chiêu C++ không chạy được trong mô phỏng Lua; mới kiểm bằng build và đọc code.

**Triển khai:** chép `scratchpad\botparty\out\party.lua` vào runtime; `CoreServer.dll` (Modern\Win32ServerRelease) trong đợt C++ tới. Không cần ptfix, client không đổi.

## Phần 6: Hồi máu và thay bot (botheal, 2026-10-04)

Ba việc C1–C3 của `de-xuat-tinh-nang-phong-than-20261004.md`.

### 6.1 Cơ chế Bổ Tâm Chú (45)

**VNG gốc.** Dữ liệu ptfix (trùng vng00), script cấp `serverlist.pak \script\skill\yiren\补心咒.lua`:

| Thành phần | Giá trị |
|---|---|
| `skills.txt` 45 | SkillStyle 0 (Missles), MisslesForm 1 (Line), 1 missile con số 5, TargetAlly 1, TargetSelf 1, TargetEnemy 0, TargetOnly 0, AttackRadius 200, TimePerCast 0 |
| Missile 5 | MoveKind 0 (Stand), CollidRange 12, DmgRange 12, DmgInterval 14, LifeTime 13, AutoExplode 1 |
| Script cấp | `lifepotion_v` = 20 + 20 × cấp, trong 10 khung (cấp 10 hồi 220); `skill_cost_v` = 10 + 5 × cấp |

Engine xử lý như sau:
- Bấm đất hoặc không chọn ai: `KSkill::CanCastSkill` đổi thành tung lên chính mình (TargetSelf).
- `CastMissles` dạng Line sinh missile ở người tung.
- `KMissle::ProcessCollision` quét ±DmgRange/2 = ±6 ô (khoảng ±192 điểm) quanh missile. Mỗi ô lấy NPC có quan hệ ally hoặc self với người tung (`KRegion::FindNpc`) rồi hồi qua `lifepotion_v`.
- LifeTime 13 nhỏ hơn DmgInterval 14 nên chỉ hồi một lượt.
- Quan hệ: bot camp 0 (camp_begin) với người chơi là ally (`KNpcSet::GenOneRelation`); đồng đội cùng team là ally; đệ cùng camp là ally.

Như vậy Bổ Tâm Chú VNG vốn hồi theo vùng quanh người tung, gồm cả bot và đệ đứng gần. Có hai lý do khiến người chơi thấy "chỉ hồi bản thân":
1. Chọn một đồng minh rồi tung (`do_skill(45, -1, đồng minh)`) thì missile vẫn sinh ở người tung, vì nhánh Line dùng chung cho mọi kỹ năng. Đứng ở tầm 200 mà tung thì đồng minh có thể ở ngoài ±6 ô. Kết quả: chỉ người tung được hồi, hiệu ứng cũng hiện trên người tung.
2. Tự đánh (lbdaosi) chỉ tung 45 khi chính người chơi dưới 60 %, và tung tại chỗ.

**Sau khi sửa (C2).**
- `KSkills.cpp`, dấu `botheal`, chạy ở cả server lẫn client: kỹ năng thỏa đủ các điều kiện dưới đây, khi tung lên một NPC khác không phải địch, thì missile sinh tại NPC đó. Vùng ±6 ô nằm quanh đồng minh; người tung đứng gần vẫn trong vùng. Tung lên chính mình hoặc bấm đất thì giữ nguyên vùng quanh người tung như VNG.
  - Dạng Line, missile Stand.
  - TargetAlly, không TargetEnemy.
  - Không có sự kiện missile.
  - Tầm từ 1 đến 600.
- Có 16 dòng dữ liệu chịu ảnh hưởng: 45, 106, 110, 197, 198, 416, 853, 1120–1126, 1508, 1509. Các bản vá khác giữ nguyên:
  - skillself (TargetOnly) và vancot (51);
  - 415/852 (có StartEvent) vẫn sinh ở người tung;
  - 810 (AttackRadius 9999) vẫn sinh ở người tung.
- Tự đánh (`PhongThanAutoFight.inl`, chỉ CoreClient): nếu Lệnh Bài Dị Nhân có chọn 45 và bản thân từ 60 % trở lên, tự đánh tìm đồng minh dưới 60 % trong tầm (200 − 16 điểm) rồi tung 45 lên người đó, cách nhau ít nhất 1,5 giây. Đồng minh gồm:
  - thành viên team;
  - bot `[Tổ đội] `;
  - đệ bot `[Đệ tử] `.

### 6.2 Bot Dị Nhân hồi máu (C1)

- `party.lua`: `PTBP_SK[3] = { 2715, 2720, 45, 44, 44, 44 }`, `PTBP_SK_DONE = 4`. Bot đang sống (cờ 0–3) được đặt lại ở tick kế. Cấp 45 theo `PTBP_SkLevel` (10–20).
- `KNpcAI.cpp`, dấu `botheal`:
  - `PhongThanAi11PickSkill` bỏ qua kỹ năng chỉ dành cho đồng minh (không TargetEnemy, có Ally hoặc Self). Vì vậy 45 không bao giờ bị chọn làm chiêu đánh; ô 2–4 (44) vẫn đánh như cũ.
  - `PhongThanAi11Heal` chạy trong `ProcessAIType11`, sau phần xích 900 và trước phần chọn mục tiêu. Chỉ áp cho NPC có kỹ năng hồi ở ô 1–4 (Missles, TargetAlly, không TargetEnemy, không phải hào quang).
- Chọn mục tiêu:
  - Ưu tiên chủ (người chơi) nếu dưới 50 % và cách bot không quá 600.
  - Nếu chủ không cần, chọn NPC máu thấp nhất (dưới 50 %) trong region của bot và 8 region quanh đó, thuộc tổ đội: chính bot, NPC AI 11 khác cùng chủ (bot khác, đệ triệu hồi của người chơi), hoặc đệ của các bot đó.
  - Mục tiêu phải có quan hệ ally hoặc self, còn sống, cùng bản đồ, không ẩn.
  - Quái, bot của người khác và người lạ bị bỏ qua.
- Ra chiêu:
  - Ngoài tầm 45 (200): bot chạy tới trước.
  - Trong tầm: `SetActiveSkill(ô)` rồi `do_skill(45, -1, đích)`; missile sinh tại đích (mục 6.1).
  - Đang ra chiêu: bot giữ lượt và hồi ngay khi chiêu xong, vì `KNpc::DoSkill` bỏ qua lệnh mới trong lúc đang ra chiêu.
- Nhịp:
  - Mỗi bot hồi cách nhau 54 khung (3 giây).
  - Đích vừa được một bot hồi thì các bot khác để yên 27 khung (1,5 giây).
  - Không ai cần hồi: 9 khung sau mới quét lại.
- Engine đang chạy (bản triển khai 19:29, có bot9x nhưng chưa có botheal): bot9x chọn ngẫu nhiên ô 1–4, nên khoảng 1/4 lượt bot Dị Nhân chọn 45. Khi đó `FollowAttack` tung chiêu đồng minh tại chân bot, hồi vùng quanh bot (người chơi đứng gần cũng được hồi), và lượt đó bot không đánh. Hiện tượng này hết khi CoreServer botheal được triển khai.

### 6.3 Thay bot chết (C3, chỉ Lua)

- Tick phút (`PTBP_Player`) gọi `PTBP_WatchArm`, tức `SetNpcTimer(NPC của người chơi, party_npc.lua, 5)`. Region người chơi đứng luôn hoạt động, nên timer chắc chắn chạy. NPC của bot không dùng được vì timer mất theo bot.
- `party_npc.lua` có `OnTimer(ni)` gọi `PTBP_Watch(ni)`: lấy `NpcIdx2PIdx` làm `PlayerIndex`, rồi `PTBP_WatchPlayer` xét 7 ô tổ đội:
  - Ô trống: bỏ qua. Timer không bao giờ thêm ô mới, nên `PTBP_MAX_TOTAL` và giới hạn đệ giữ nguyên như tick phút để lại.
  - Bot còn sống: không làm gì.
  - Bot đã mất (botparty:P3 xóa bot AI 11 chết sau hoạt cảnh chết) hoặc còn xác (`PTBP_Dead`, engine cũ): ghi thời điểm. Đủ 90 khung (5 giây) thì:
    - xóa xác nếu còn;
    - nạp `PTBPC_Load` (tỉ lệ phái trên web của adminops);
    - `PTBP_Spawn` vào đúng ô đó, rồi `PTBP_SkTick` và đệ Dị Nhân;
    - báo "[Tổ đội] N đồng đội mới vào thay đồng đội bị trọng thương."
  - Tối đa 4 lần thay cho mỗi người chơi trong 60 giây.
  - Người chơi chết, vào tổ đội thật, ra khỏi bản đồ có bot, hoặc tắt tổ đội: không thay và timer dừng. Tick phút xử lý như cũ.
- Timer tự đặt lại 5 giây khi còn ô được theo dõi. Kết quả: bot chết được thay sau 5–10 giây (trước đây phải chờ tối đa 1 phút).
- `PTBP_Register` theo phiên bản (`PTBP_REG_VER = 2`): sau khi nạp nóng `party.lua`, tick kế nạp lại một lần bản đăng ký của `party_npc.lua` và `bots.lua`.
- Lưu ý engine: khung nào timer chạy thì `KNpc::Activate` của NPC người chơi bỏ phần còn lại của khung đó, giống mọi NPC có timer. Mất 1 khung mỗi 5 giây, không thấy được trong game.

### 6.4 Kiểm thử

- Build `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả 3 OK (20:23). Bản build này có cả thay đổi của agent khác đang làm cùng lúc (ví dụ `MAX_NPC` 96000 trong `GameDataDef.h`).
- Smoke C++ `scratchpad\botheal\smoke\` (`build.cmd`): biên dịch đúng các khối đã vá (PickSkill, khối botheal của AI 11, lời gọi trong ProcessAIType11, `bPtStandAtTarget` + `bPtHealAtTarget` cùng nhánh dùng) với mock, và 63 dòng Line/Stand thật của ptfix. Kết quả 29/0:
  - 45 không bao giờ bị chọn đánh (4000 lượt);
  - hồi chủ trước; khóa đích giữa hai bot hồi;
  - thời gian hồi 54 khung; quét lại sau 9 khung;
  - hồi bot máu thấp nhất, hồi đệ bot, tự hồi;
  - chạy tới khi ngoài tầm, bỏ qua mục tiêu quá 600;
  - chờ chiêu đang ra; bỏ qua mục tiêu ẩn hoặc là địch;
  - slot NPC dùng lại không thừa hưởng thời gian hồi; hào quang không bị coi là kỹ năng hồi;
  - 16 dòng hồi sinh missile tại đồng minh; tung lên chính mình thì không dòng nào đổi; vancot, 415/852, 810 giữ nguyên.
- Lua `qtest\sim_botheal.lua` (sinh bằng `scratchpad\botheal\make_sim.py` từ `sim_bot9x.lua`, thêm mục 16): 115 pass / 14 fail ở cả `-Stack 100` lẫn EMU. 14 FAIL trùng y hệt bản cũ (kỳ vọng "thành không có bot"). Không có ERR hay FLAG. Headroom: tick 37 khung, OnTimer 46 khung. Các kiểm tra mới đều đạt:
  - Dị Nhân 45/44/44/44 với cờ 4; bot cũ (cờ 0–3) được nâng;
  - tick phút đặt timer 5 giây cho người chơi có tổ đội, không đặt cho người không có;
  - bot chết được thay sau đúng 90 khung, cùng ô, không trùng, không rò; có thông báo; tick phút sau đó không làm gì;
  - xác (engine cũ) bị xóa rồi thay;
  - cả tổ đội chết: thay đủ 4, các ô khác nhau dù chỉ số NPC bị dùng lại chéo ô;
  - lần chết thứ 5 trong 1 phút phải chờ cửa sổ sau;
  - bot Dị Nhân thay thế có 45 và đệ;
  - người chơi chết, vào team, ở bản đồ không có bot, tắt tổ đội: không thay, timer dừng;
  - OnTimer trên NPC không phải người chơi: bỏ qua;
  - engine thiếu `GetPlayerNpcIdx` / `NpcIdx2PIdx`: không lỗi;
  - nạp lại bản đăng ký một lần theo phiên bản.
- `qtest\sim_vtcc_bp_botheal.lua` (sim_vtcc_bp trỏ vào bản mới), thường và EMU: FAILS=0.
- Server thật: `party.lua` và `party_npc.lua` chép runtime lúc 20:25. Bridge 20:26 ghi `botheal OK party.lua reloaded, PTBP_REG_VER 2`; tick 20:27 chạy, không có `tick_error.log`. Lúc đó tổ đội bot đang tắt trong cấu hình (`bots.txt`: `cfg 0`, `party 0`), nên chưa thấy được trong game.

### 6.5 Triển khai

| Phần | Trạng thái |
|---|---|
| Lua `party.lua` + `party_npc.lua` | Đã chép runtime và nạp nóng (20:26). Bản này có cả khối C4 của adminops (không có `botparty_config.lua` thì hành vi như cũ). Có hiệu lực ngay: C3 thay bot nhanh; Dị Nhân ô 1 = 45. |
| `CoreServer.dll` | Cần triển khai, gồm C1 (bot hồi máu) và C2 phía server (missile sinh tại đồng minh). File `Modern\Win32ServerRelease\CoreServer.dll` (20:23). |
| `CoreClient.dll` | Cần triển khai, gồm C2 phía client (vẽ missile tại đồng minh) và tự đánh hồi đồng minh. File `Modern\Win32ClientRelease\CoreClient.dll` (20:23). `Game.exe` build lại, không có thay đổi riêng của botheal. |
| ptfix | Không cần. |

Kiểm tra trong game sau khi triển khai:
- Bật tổ đội bot, có bot Dị Nhân. Để máu xuống dưới 50 %: bot Dị Nhân chạy lại và tung Bổ Tâm Chú lên người chơi; hiệu ứng hiện trên người chơi, máu tăng khoảng 20 + 20 × cấp.
- Chọn một bot và tung Bổ Tâm Chú từ xa 150–200: bot đó được hồi.
- Để một bot chết: bot mới vào thay trong 5–10 giây.

Backup `_backup\20261004-botheal\`:
- `src\` gồm KNpcAI.cpp, KSkills.cpp, PhongThanAutoFight.inl. `PhongThanAutoFight.inl.pre-botheal` là bản ngay trước khi vá: agent hanhtrang đã sửa file này sau lần sao lưu đầu.
- `party.lua` / `party_npc.lua` bản src, out và runtime; bots.lua; CHANGELOG; tài liệu này.

Script làm việc ở `scratchpad\botheal\`: `patch_cpp.py`, `survey.py`, `make_sim.py`, `sim_sec16.lua`, `smoke\`.
