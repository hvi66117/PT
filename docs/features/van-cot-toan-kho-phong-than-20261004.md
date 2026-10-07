# Vạn Cốt Toàn Khô (Dị Nhân) không làm quái mất máu (2026-10-04)

## Phần 1: Tổng quan

- **Lỗi người dùng báo:** Dị Nhân (KyUc1Thoi, cấp 55+) dùng Vạn Cốt Toàn Khô nhưng đối phương không mất máu.
- **Cơ chế VNG (có nguồn):**
  - Kỹ năng 51 "Vạn Cốt Toàn Khô" (bản NPC phó bản: 921) chỉ có một thuộc tính là `fatallystrike_p`, không có sát thương (`AddBaseDamage 0`, `IsUseAR 0`).
    - Nguồn: `vng00.pak \settings\skills.txt`, dòng 51; script cấp `\script\skill\yiren\万骨全枯.lua` (trong `serverlist.pak`).
  - Xác suất theo cấp: `16 + 2 × cấp` %, tức cấp 1 = 18 %, cấp 10 = 36 %.
  - Mô tả VNG (cột `SkillDesc`): "Giảm 1/4 sinh lực và độ chí mạng của đối phương". `MagicDesc.ini` gọi `fatallystrike_p` là "Đánh chí mạng". Nghĩa là: mỗi lần trúng có X % cơ hội đánh chí mạng, khiến đối phương mất **1/4 sinh lực hiện tại**.
  - Giới hạn boss là **dữ liệu VNG**, không phải danh sách tự đặt: `vng00.pak \settings\npcs.txt` có cột 105 `FatallyStrikeResist` (kháng chí mạng của từng mẫu NPC).
    - 306 mẫu có giá trị 100, tức miễn nhiễm, gồm boss thế giới Giao Long 97, Ly Long 98, Di Long 99.
    - 79 mẫu có giá trị 30–99.
    - Còn lại là 0.
- **Nguyên nhân:**
  1. `KNpc::CalcDamage` thoát ngay khi min + max = 0, mà chiêu 51 không có sát thương nào.
  2. Cờ chí mạng `bIsFS` (đã tính đúng trong `ReceiveDamage`) chỉ được dùng trong nhánh phản đòn (`bReturn`). Nhánh đó không bao giờ nhận `bIsFS = TRUE`, nên với mọi chiêu, "đánh chí mạng" là mã chết.
  3. Engine chưa đọc cột `FatallyStrikeResist`.
  4. Missile 20 (đứng yên, đánh lan ±7 ô) sinh tại người tung. Bản vá `skillself` chỉ áp cho `TargetOnly = 1`, còn chiêu 51 có `TargetOnly = 0`. Kết quả: hiệu ứng sấm nổ trên người tung, vùng đánh lan quanh người tung.
- **Cách sửa (C++, đã build, CHƯA triển khai):**
  - Thêm cơ chế đánh chí mạng ở server.
  - Đọc kháng chí mạng của từng mẫu NPC.
  - Missile của 51/921 sinh tại kẻ địch (cả client lẫn server).
  - Sửa thêm lỗi đệ triệu hồi đánh cấp 1 (việc coordinator giao thêm).

## Phần 2: Chi tiết

### 2.1. Cơ chế đánh chí mạng mới (`KNpc.cpp`, dấu `vancot`)

`KNpc::ReceiveDamage` vẫn tung xác suất như cũ:

```
bIsFS = g_RandPercent(fatallystrike_p + m_CurrentFatallyStrikeEnhanceP − m_CurrentFatallyStrikeResP)
```

Điểm mới: chỉ khi chính chiêu mang thuộc tính `fatallystrike_p` (`bPtFsSkill`) thì mới gọi `PhongThanFatallyStrike`:

| Bước | Quy tắc | Nguồn |
|---|---|---|
| 1 | Mục tiêu đã chết, đang hồi sinh hoặc còn ≤ 1 máu thì bỏ qua | an toàn |
| 2 | NPC (không phải người chơi) tung thêm `g_RandPercent(FatallyStrikeResist)`; trúng thì kháng được, không mất máu | `npcs.txt` cột 105 (VNG) |
| 3 | Lượng máu mất = 25 % sinh lực **hiện tại**. Tính tách phần nguyên/dư nên không tràn số với boss 130 triệu máu | `SkillDesc` "Giảm 1/4 sinh lực" (VNG) |
| 4 | NPC tinh anh (kind_normal, `m_btSpecial` xanh/vàng/hồng) chỉ mất `SpecialRate` % lượng đó (mặc định 50 %) | công thức chí mạng gốc của engine (nhánh `bReturn`), `PK.ini SpecialRate` |
| 5 | Trừ máu qua `CalcDamage(..., damage_magic)` | engine |

Bước 5 giữ nguyên mọi quy tắc của engine: khiên nội lực, chuỗi chủ đệ → bot → người chơi (dinhanbot), chia kinh nghiệm `m_cDeathCalcExp`, `LastDamage` và xử lý chết.

Vì luôn tính theo máu hiện tại nên chiêu **không bao giờ giết ngay**: mỗi lần chỉ lấy 1/4 phần còn lại.

Những gì không đổi:

- `m_CurrentFatallyStrikeEnhanceP` (thuộc tính `fatallystrikeenhance_p` của trang bị hoặc kỹ năng 1488 Cổ Hoặc Chúng Sinh) chỉ tăng xác suất cho chiêu có `fatallystrike_p`. Nó **không** biến mọi chiêu thành chí mạng.
- `magic_heart_damage_resistance_p` ("Kháng sát thương chí mạng") vẫn trừ vào xác suất như trước.
- Chiêu có `fatallystrike_p` trong dữ liệu chỉ có 51, 921 và 1369 (Phá Quân Chú-Tụy Hồn, chiêu này có thêm sát thương thường).

Đánh lên người chơi khi PK: VNG cho phép, vì chiêu là `TargetEnemy` và mô tả không loại trừ người chơi. Người chơi mất 1/4 máu hiện tại, không có kháng theo mẫu, chỉ có kháng chí mạng từ trang bị.

Ví dụ ở cấp 10 (36 %):

| Mục tiêu | Máu hiện tại | Kháng mẫu | Xác suất thực | Mất mỗi lần trúng chí mạng |
|---|---|---|---|---|
| Quái thường (mẫu 86) | 10 000 | 0 | 36 % | 2 500 |
| Quái tinh anh vàng | 8 000 | 0 | 36 % | 1 000 |
| Mẫu 448 (12 triệu máu) | 12 000 000 | 50 | ≈ 18 % | 3 000 000 |
| Ly Long (98) | 100 000 000 | 100 | 0 % | 0 |
| Người chơi (PK) | 8 000 | – | 36 % (trừ kháng trang bị) | 2 000 |

### 2.2. Missile sinh tại kẻ địch (`KSkills.cpp`, mở rộng `skillself`, dấu `vancot`)

Trong `CastMissles`, nhánh `SKILL_MF_Line`, biến mới `bPtStandAtTarget` thay cho điều kiện cũ của `skillself`. Missile Stand sinh tại NPC đích khi thỏa một trong hai điều kiện:

- `TargetOnly = 1`: như `skillself`, 42 kỹ năng, không đổi.
- **Mới:** kỹ năng chỉ đánh địch, thỏa đồng thời:
  - `TargetEnemy = 1`, không có `TargetAlly`/`TargetSelf`;
  - không có missile event;
  - `0 < AttackRadius ≤ 600`;
  - quan hệ với đích là `relation_enemy`.

Rà toàn bộ 63 kỹ năng gốc dạng Line có missile Stand, nhánh mới chỉ thêm **51 và 921**. Các kỹ năng sau giữ người tung:

- Bổ Tâm Chú 45/106/416/1120–1126, Trị liệu/Kích hoạt đồng loạt 197/198, Khô Mộc Phùng Xuân 1508/1509 (đều là `TargetAlly`);
- npc Bổ Tâm Chú Pháp 415/852 (có `StartEvent` 416);
- Hồng Sa Tiễn 810 (`AttackRadius 9999`).

Client và server chạy cùng mã này, nên hiệu ứng sấm (`thunder-04.spr`, ảnh va chạm của missile 20) hiện trên kẻ địch. Vùng đánh lan ±7 ô đặt quanh kẻ địch đó.

### 2.3. Đệ triệu hồi đánh cấp 1 (`KSkills.cpp` pet10, `PhongThanBotPet.h`, dấu `vancot`)

- **Nguyên nhân** (bot9x phát hiện, đã xác minh):
  - `KSkillList::FindSame` trả ô **đầu tiên** có id cần tìm. `GetCurrentLevel`/`GetActiveSkill` dùng hàm này.
  - Mẫu đệ 359–1346 có cùng một id ở cả 4 ô, ví dụ 359/360 có 63 ×4, 361 có 141 ×4, 1346 có 388 ×4.
  - pet10 chỉ nâng ô 4, nên đệ ra chiêu theo cấp của ô 1, tức cấp 1.
- **Sửa:**
  - Đệ kỹ năng 450–461 (`SKILL_SS_CreateNpc`): các ô 1–3 có cùng id với chiêu của đệ được đặt cùng cấp với ô 4. Mẫu 2032 (85/86/87/88, khác id) vẫn chỉ ô 4 như trước. Mẫu 1345 (không có chiêu) chỉ có ô 4 = chiêu 1.
  - Đệ của bot Dị Nhân (`AddNpcPet`, `PhongThanBotPet.h`): cũng nâng các ô cùng id. Đây là lớp phòng hờ trong C++; Lua bot9x vòng 2 đã tự đặt cả 4 ô.
- **Đệ Lệnh Bài (`petexp_lib.lua PTPE_Apply`):** đã **đúng**, không sửa.
  - Lua gọi `SetNpcSkill(idx, sk, s, i)` với i = 1..4.
  - Thứ tự tham số đúng như `LuaSetNpcSkill`: npc, id, cấp, ô.
  - Cả 4 ô cùng id, cùng cấp, nên `FindSame` lấy ô 1 vẫn ra cấp đúng.

### 2.4. Phía client

- Missile sinh tại đích: mã dùng chung (`KSkills.cpp`), cần `CoreClient.dll` mới. Client cũ vẫn vẽ hiệu ứng ở người tung, nhưng sát thương do server tính nên vẫn đúng.
- Lượng máu mất được đồng bộ bình thường. Client không cần sửa gì thêm cho phần chí mạng.
- Không cần ptfix: dữ liệu `skills.txt`, `missles.txt`, `npcs.txt` của VNG đã đủ.

## Phần 3: Hành động

### File đã sửa

Tất cả là vá byte bằng Python, chỉ chèn ASCII, script: `scratchpad\vancot\patch_src.py`.

| File | Thay đổi | Backup |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\KNpc.cpp` | `PhongThanNpcFatallyStrikeResist`, `PhongThanFatallyStrikeLife`, `PhongThanFatallyStrike`; `bPtFsSkill` và lệnh gọi trong `ReceiveDamage` | `_backup\20261004-vancot\KNpc.cpp` |
| `PhongThanSource\Sources\Core\Src\KSkills.cpp` | `bPtStandAtTarget` (mở rộng skillself), vòng nâng ô 1–3 của đệ (pet10) | `_backup\20261004-vancot\KSkills.cpp` |
| `PhongThanSource\Sources\Core\Src\PhongThanBotPet.h` | nâng ô 1–3 cùng id của đệ bot | `_backup\20261004-vancot\PhongThanBotPet.h` |
| `CHANGELOG.md`, `docs\features\README.md` | ghi nhận | `_backup\20261004-vancot\` |

Các dấu bản vá cũ vẫn còn nguyên: `skillself`, `onepet`, `pet10` trong `KSkills.cpp`; `dinhanbot`, `daosi` trong `KNpc.cpp`. Không chạm `KNpcAI.cpp`.

### Build và kiểm tra

- [x] Smoke test offline `scratchpad\vancot\smoke\` (`build.cmd`): **816 đạt / 0 lỗi**.
  - `extract.py` trích nguyên văn khối mã thật đã vá, rồi biên dịch cùng mock và dữ liệu thật: cột `FatallyStrikeResist` của `Npcs.txt` (2 721 mẫu), cùng 63 kỹ năng Line + Stand.
  - Kết quả mô phỏng: xác suất thực 35,8 % ở kháng 0 và 18,1 % ở kháng 50; Ly Long miễn nhiễm; boss 130 triệu máu không tràn số; chỉ 51/921 là kỹ năng mới sinh missile tại đích; đệ 359 cấp 7 ra chiêu cấp 7.
- [x] `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả ba OK lúc 17:38, biên dịch lại đầy đủ `KNpc.cpp` và `KSkills.cpp`, không có lỗi. Kết quả:
  - `Core\Modern\Win32ServerRelease\CoreServer.dll`;
  - `Core\Modern\Win32ClientRelease\CoreClient.dll`;
  - `GameClient\Modern\Win32Release\Game.exe`.
  - Log: `PhongThanSource\Build\LogsModern\*.log`, `scratchpad\vancot\build.log`.
- [ ] **Coordinator:** triển khai `CoreServer.dll` (server), `CoreClient.dll` + `Game.exe` (client), khởi động lại GameServer, mở lại game.
- [ ] Kiểm thử trong game với KyUc1Thoi (đã học 51):
  - [ ] Đứng cách quái thường khoảng 150–200 px, tung Vạn Cốt Toàn Khô nhiều lần. Khoảng 1/3 số lần (cấp 10), quái mất 1/4 máu hiện tại; sấm nổ trên quái chứ không nổ trên nhân vật.
  - [ ] Đánh quái tinh anh (tên màu): mỗi lần trúng chí mạng chỉ mất khoảng 1/8 máu.
  - [ ] Đánh Ly Long / Di Long / Giao Long: không mất máu (VNG miễn nhiễm).
  - [ ] Quái chết do đòn khác sau khi trúng chí mạng: kinh nghiệm và rơi đồ tính cho người chơi như thường.
  - [ ] PK (nếu có nhân vật thứ hai): đối thủ mất 1/4 máu hiện tại khi trúng chí mạng.
  - [ ] Gọi đệ triệu hồi cấp cao (450–461): tên `[cấp]Tên chủ`, sát thương tăng theo cấp kỹ năng.
  - [ ] Chưởng Tâm Lôi / Băng Tuyết Đạn (skillself) và Bổ Tâm Chú vẫn như trước.

**Cần triển khai cả server lẫn client.** Chỉ cập nhật server thì quái đã mất máu, nhưng client cũ vẫn vẽ sấm ở người tung. Chỉ cập nhật client thì không có tác dụng gì.

## Phần 4: Tài liệu tham khảo

- `skill-self-target-phong-than-20261004.md`: bản vá `skillself` gốc mà bản này mở rộng.
- `dinhan-bot-phong-than-20261004.md`: chuỗi chủ đệ → bot → người chơi; bot9x vòng 2 ghi nhận lỗi `FindSame`.
- `pet-exp-phong-than-20261003.md`: đệ Lệnh Bài và `PTPE_Apply`.
- Script phân tích: `scratchpad\vancot\rd.py` (đọc PAK), `survey2.py` (rà kỹ năng Line + Stand), `magicdesc_client.ini`, `npcs_vng.txt`, `npcs_server.txt`.
- Chưa làm (ngoài phạm vi): `enhance_fatallystrike_p` ("Tăng hiệu quả chí mạng dị nhân", magic 295) chưa có hàm xử lý thuộc tính trong engine, nên chưa tăng được tỉ lệ 1/4. Cột `DeadlyStrikeResist` của `npcs.txt` cũng chưa được đọc.
- Rollback: chép lại 3 file trong `_backup\20261004-vancot\` vào `Core\Src` rồi build lại.
