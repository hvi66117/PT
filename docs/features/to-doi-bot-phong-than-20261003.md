---
tính năng: Tổ đội bot tự động ở bãi quái (đánh cùng, tính kinh nghiệm như tổ đội VNG)
ngày: 2026-10-03
trạng thái: Lua đã triển khai lên runtime và chạy simulator đạt; bản vá C++ (cộng thêm kinh nghiệm tổ đội + xóa xác bot) đã soạn sẵn, chờ coordinator áp dụng và build sau questtrack
phạm vi: script\phongthan\bots\ (bots.lua, party.lua, party_npc.lua), AdminWeb tab "Bot giả người chơi", bản vá C++ server (KNpcDeathCalcExp.cpp, KNpc.cpp, ScriptFuns.cpp, PhongThanPartyBot.h)
---

# Tổ đội bot tự động cho Phong Thần

## Phần 1: Tổng quan

- **Người chơi một mình vẫn có tổ đội như trên server VNG.** Khi ra bản đồ có quái, server tự đưa **4 đồng đội bot** vào tổ đội (chỉnh được 0–7, vì tổ đội VNG tối đa 8 người tính cả người chơi).
  - Đồng đội đi theo người chơi và đánh đúng mục tiêu người chơi đang đánh. Không có mục tiêu thì đánh con quái gần nhất.
  - Cấp đồng đội bằng cấp người chơi ±2. Tên có tiền tố **[Tổ đội]**, ví dụ "[Tổ đội] ThiênLong".
- **Quái do đồng đội hạ được tính như người chơi tự hạ.** Người chơi nhận kinh nghiệm, đồ rơi và số đếm nhiệm vụ.
  - Phần này engine đã làm sẵn, không cần sửa. `KNpc::CalcDamage` chuyển mọi sát thương của NPC có chủ (AiMode 11) sang tên người chủ.
  - Vì vậy **không** thêm Lua cộng kinh nghiệm cho chủ. Nếu thêm, kinh nghiệm sẽ bị cộng hai lần.
- **Thưởng kinh nghiệm tổ đội kiểu VNG:** mỗi đồng đội đứng gần (trong tầm chia kinh nghiệm 768 điểm ≈ 24 ô) cộng thêm **+15%** kinh nghiệm cho mỗi con quái người chơi hạ.
  - Ví dụ 4 đồng đội cộng +60%. Mức 15% lấy theo hệ số tổ đội của engine (`k = 100 + 15 × (số người − 1)`).
  - Bot không lấy phần kinh nghiệm nào.
  - Phần thưởng này **cần bản vá C++** (chưa build). Trước khi có bản vá, đồng đội vẫn đánh giúp và quái vẫn tính cho người chơi, chỉ chưa có phần cộng thêm.
- **Đồng đội tự rời đội** trong các trường hợp sau:
  - người chơi về thành hoặc sang bản đồ không có quái;
  - người chơi chết, ẩn thân hoặc thoát game (engine tự xóa ngay);
  - người chơi vào tổ đội thật;
  - người chơi tự tắt, hoặc quản trị tắt.
- **Gọn gàng, không chen chúc:** bot tự do (chế độ "đi theo người chơi", 40 bot) không tụ quanh người chơi đang có tổ đội bot nữa. Chúng chuyển sang người chơi khác hoặc đi dạo nơi khác. Quanh người chơi chỉ còn nhóm đồng đội nhỏ.
- **Bật/tắt:**
  - quản trị bật/tắt, chọn số đồng đội và % thưởng ở tab web "Bot giả người chơi";
  - người chơi tự bật/tắt và chọn số đồng đội ở NPC mới **"Hỗ Trợ Tổ Đội"**, đứng cạnh Quân Sư (Tân thủ) ở Sùng Thành, Ngọc Hư, Xi Vưu.

## Phần 2: Chi tiết

### 2.1 Cách hoạt động (Lua)

| Thành phần | Việc làm |
|---|---|
| `bots.lua` → `PTBOT_Tick` (servertimer, mỗi phút) | Gọi `PTBP_Tick(cfg)` sau phần bot tự do. `PTBOT_AdminApply` (nút Áp dụng trên web) cũng gọi để áp dụng ngay |
| `party.lua` → `PTBP_Player` | Với từng người chơi online: kiểm tra 7 ô đồng đội, xóa bot hỏng/chết/lạc/thừa, gọi bot còn thiếu, đặt mức thưởng `SetPartyBotBonus` |
| Gọi bot | `AddTotemNpc(template, cấp, bản đồ, x, y)` gán chủ là người chơi và AiMode 11. Sau đó đặt tên "[Tổ đội] …", camp 0 (chỉ quái là địch, không bao giờ đánh người chơi), bong bóng chat riêng (`PTBOT_LINES[4]`) |
| Bám theo, đánh cùng | Engine `KNpcAI::ProcessAIType11`: đánh mục tiêu của chủ, không có thì đánh quái gần nhất. Bot cách chủ hơn 900 điểm thì chạy về. Chủ đổi bản đồ, chết hoặc ẩn thân thì bot bị xóa |
| Bản đồ có quái | 57 bản đồ: tất cả `spawn_<map>.lua` (1005–1013, 1015, 1017–1019, 1022–1051, 1053–1056, 1065, 1072–1078) cộng 1014, 1016 (quái gốc VNG). Không có các thành 1002–1004, 1020, 1021 và Phong Thần đài 1001 |
| Bot chết | AiMode 11 không có hồi sinh, xác nằm lại. Lua nhận ra bot chết qua `GetNpcEnmityItem` (sát thương ≥ máu tối đa) hoặc khi bot cách người chơi quá 34 ô, rồi xóa và gọi bot mới trong phút kế. Bản vá C++ P3 xóa xác ngay sau hoạt cảnh chết |
| Giới hạn | Tối đa 7 đồng đội mỗi người, toàn server tối đa 160 bot tổ đội |

**Biến nhiệm vụ** (dải 2070–2079 của bot; đã kiểm tra không dùng trong script rời lẫn PAK):

| Biến | Ý nghĩa |
|---|---|
| 2070 | 0 = theo máy chủ (bật), 1 = bật, 2 = tắt |
| 2071 | 0 = theo máy chủ, 1–7 = số đồng đội riêng |
| 2072–2078 | Chỉ số NPC của đồng đội 1–7. Trước khi dùng luôn kiểm tra template 2703–2720, tiền tố tên và `GetNpcOwner` = tên người chơi. Nhờ vậy ô cũ bị NPC khác chiếm thì không xóa nhầm |
| 2079 | Chưa dùng |

**Cấu hình web** (`admin_bridge\bots_config.lua`, thêm 3 khóa; file cũ không có khóa thì dùng mặc định):

```lua
PTBOT_CFG = { enabled = 1, follow = 1, followCount = 40, party = 1, partyCount = 4, partyBonus = 15, spots = { ... } }
```

- Trạng thái `admin_bridge\bots.txt` có thêm dòng cuối: `party  <bật> <số đồng đội> <%/người> <số người chơi có tổ đội> <số bot tổ đội> <C++ có thưởng 0/1>`.
- Nút "Áp dụng" gửi lệnh bridge `if not PTBP_Tick then dofile(bots.lua) end PTBOT_AdminApply()`. Server đang chạy bản bots.lua cũ sẽ nạp bản mới ngay, không cần khởi động lại.

### 2.2 Kinh nghiệm: đối chiếu engine

| Trường hợp | Trước | Sau (Lua + bản vá C++) |
|---|---|---|
| Người chơi tự hạ quái, có 4 bot ở gần | 100% | 160% |
| Bot tổ đội hạ quái | Engine đã tính cho chủ: 100% | 160% (vẫn tính cho chủ) |
| Đệ tử Dị Nhân (AiMode 11) hạ quái | Tính cho chủ | Như cũ (không tính vào số đồng đội, không cộng hai lần) |
| Người chơi trong tổ đội thật | Chia kinh nghiệm tổ đội của engine | Như cũ; bot tổ đội rời đội |
| Quái chết xa người chơi hơn 768 điểm | Không có kinh nghiệm | Như cũ (giống VNG: ngoài tầm thì không nhận) |

### 2.3 Bản vá C++ (soạn sẵn, chưa áp dụng)

- File: `scratchpad\botparty\cpp_patch.md` và trình áp dụng `scratchpad\botparty\apply_patch.py`.
  - Trình áp dụng sửa ở mức byte, an toàn với GBK, kiểm tra anchor, chạy lại nhiều lần không sao, có `--dry-run`.
  - Trước khi sửa, nó sao lưu vào `_backup\<ngày>-botparty\Core\Src\`.
- P1, P2 (`KNpcDeathCalcExp.cpp`): bảng mức thưởng theo người chơi, hết hạn sau 3 phút nếu tick Lua dừng. Mức thưởng cộng vào kinh nghiệm ở nhánh **không tổ đội** của `CalcExp`.
- P3 (`KNpc.cpp`, `OnDeath`): NPC AiMode 11 có chủ mà chết thì bị xóa sau hoạt cảnh chết, đồng thời xóa `m_nPetIdx` của chủ. Bản vá này sửa luôn lỗi xác đệ tử Dị Nhân nằm lại mãi.
- P4–P6 (`ScriptFuns.cpp`, `PhongThanPartyBot.h`): thêm hàm Lua `SetPartyBotBonus(pct)` và `GetPartyBotBonus()`. Lua dùng `if SetPartyBotBonus then` để biết server đã có bản vá chưa.
- Mọi đoạn sửa đều nằm trong `#ifdef _SERVER`, nên client build không đổi.

### 2.4 Kiểm thử simulator

| Bài | Kết quả |
|---|---|
| `sim_botparty.lua -Stack 100` (mới, 51 kiểm tra) | 51 đạt / 0 lỗi |
| `sim_botparty.lua -Stack 0 -Args1 emu` (đệm chồng như engine: tick 40, NPC 47) | 51 / 0. Còn dư: tick chạy được ở 28 khung, menu ở 18 khung |
| `sim_bots.lua`, `sim_botadmin.lua` (30 kiểm tra), `sim_botvisual.lua` (13 kiểm tra), `-Stack 100` | Đạt, 0 FLAG |
| `sim_questfix.lua`, `t_st.lua` | Đạt (TOTAL FAILS = 0; t_st chỉ khác địa chỉ con trỏ) |
| Hàm PowerShell `Set-Bots` / `Get-Bots` (chạy riêng) | Ghi đúng khóa party, giới hạn 0–7 và 0–50, đọc đúng dòng trạng thái |
| `index.html` (node --check) | Không lỗi cú pháp |
| `apply_patch.py` trên bản sao mã nguồn | Lần 1 áp 5 đoạn + tạo header, lần 2 bỏ qua hết, dry-run sau đó 0 thay đổi |

## Phần 3: Hành động

### 3.1 Coordinator / quản trị

- [ ] Server **đang chạy**: mở web admin → tab "Bot giả người chơi" → bấm **Áp dụng**. Bridge nạp bots.lua mới, không cần khởi động lại. Hoặc khởi động lại server như bình thường.
- [ ] Web admin: khởi động lại `PhongThan-Admin` để nạp ps1 và index.html mới. Agent không tự khởi động lại.
- [ ] Sau questtrack: `python scratchpad\botparty\apply_patch.py --dry-run`, rồi chạy không có `--dry-run`. Build CoreServer, triển khai DLL, khởi động lại server.
- [ ] Ghi CHANGELOG (các dòng ở báo cáo).

### 3.2 Người chơi thử trong game

- [ ] Đứng ở Sùng Thành: không có đồng đội bot. Có NPC "Hỗ Trợ Tổ Đội" cạnh Quân Sư (Tân thủ).
- [ ] Ra bãi quái (ví dụ ngoại thành 1005): trong vòng 1 phút có 4 bot "[Tổ đội] …" đứng sát bên. Kênh hệ thống báo "4 đồng đội bot đã vào tổ đội…".
- [ ] Đánh một con quái: bot lao vào đánh cùng con đó. Đứng yên thì bot đánh quái gần.
- [ ] Để bot hạ quái: thanh kinh nghiệm tăng, đồ rơi thuộc về mình, nhiệm vụ giết quái được đếm.
- [ ] (Sau bản vá C++) So kinh nghiệm một con quái khi có và không có bot: có 4 bot thì gấp khoảng 1,6 lần. Hỏi NPC "Hỗ Trợ Tổ Đội" → "Cách tính kinh nghiệm" cho thấy "+60%" khi đang ở bãi.
- [ ] Không còn 40 bot tự do chen quanh mình ở bãi quái.
- [ ] Về thành: bot biến mất ngay. Ra bãi khác: bot quay lại.
- [ ] NPC "Hỗ Trợ Tổ Đội": "Tắt tổ đội bot" làm bot rời đội. "Chọn số đồng đội" → 2 cho ra 2 bot.
- [ ] Lập tổ đội thật với người khác: bot rời đội.
- [ ] Web admin: bỏ chọn "Tự động tổ đội bot" → Áp dụng: mọi bot tổ đội biến mất. Dòng trạng thái "Tổ đội bot" hiện số bot và số người chơi.

## Phần 4: Tài liệu tham khảo

- Mã Lua: `Server\script\phongthan\bots\party.lua`, `party_npc.lua`, `bots.lua`. Nguồn UTF-8 và bộ chuyển TCVN3: `scratchpad\botparty\src\`, `gen.py`.
- Simulator: `scratchpad\qtest\sim_botparty.lua` (kết quả `out_botparty.txt`, `out_botparty_emu.txt`).
- Engine: `KNpc.cpp` (CalcDamage chuyển sát thương AiMode 11 cho chủ, OnDeath), `KNpcDeathCalcExp.cpp` (CalcExp), `KPlayer.cpp` (AddExp chia tổ đội, `PLAYER_TEAM_EXP_ADD`), `KNpcAI.cpp` (ProcessAIType11), `PhongThanLuaWave7.h` (AddTotemNpc).
- Tài liệu liên quan: `bot-gia-nguoi-choi-phong-than-20261002.md`, `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `ky-nang-de-tu-di-nhan-phong-than-20261002.md`.
- Bản sao lưu: `_backup\20261003-botparty\` (bots.lua, PhongThan-Admin.ps1, index.html).
- Việc nên làm tiếp: sửa `KNpcAI::ProcessAIType11` để xóa `m_nPetIdx` của chủ khi xóa đệ tử. Hiện tại lần triệu hồi kỹ năng kế tiếp có thể xóa nhầm NPC đã dùng lại ô đó. Lỗi này có từ trước, không thuộc bản vá này.

## Cập nhật 2026-10-03 20:41: tổ đội theo về thành

- Bot tổ đội nay cũng đi theo ở các thành 1002, 1003, 1004, 1020, 1021, 1052: về thành không mất tổ đội, thưởng kinh nghiệm vẫn giữ.
- Mỗi lần đổi bản đồ, engine xóa bot AI 11; tick mỗi phút gọi lại ở bản đồ mới (chờ tối đa 1 phút).
