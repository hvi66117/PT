# Chưởng Tâm Lôi, Băng Tuyết Đạn, Tích Lịch Hỏa đánh vào bản thân (2026-10-04)

## Phần 1: Tổng quan

- **Lỗi người dùng báo:** bấm chuột tung Chưởng Tâm Lôi, Băng Tuyết Đạn, Tích Lịch Hỏa thì hiệu ứng nổ ngay trên nhân vật, quái không mất máu. Lỗi xảy ra cả khi chưa bật tự đánh (Alt+A), nên không do autofight.
- **Nguyên nhân gốc nằm ở engine, không do ptfix.** Ba chiêu này trong dữ liệu VNG có `MisslesForm = 1` (Line), một missile, `Param1 = 0`, và missile không di chuyển. `KSkill::CastMissles` (bản nguồn JX1) sinh missile Line ở **vị trí người tung** rồi lùi theo hướng `Param1 × (i+1)`, tức là 0 px. Missile đứng yên nên hiện trên nhân vật. `CheckNearestCollision` chỉ quét ±1 ô quanh missile nên không bao giờ chạm quái cách 300 px (AttackRadius).
- **Cách sửa:**
  - C++ (`KSkills.cpp`, dấu `skillself`): với kỹ năng `TargetOnly`, khi missile con là `MoveKind Stand` và đích là một NPC khác người tung, missile sinh tại vị trí NPC đích. Áp dụng cho cả server lẫn client.
  - ptfix (plug-in `extra_skillself.py`): missile 9 (Băng Tuyết Đạn) đổi `MoveKind 1 → 0`. Missile này vốn có Speed 0 trong dữ liệu VNG, tức thực chất đứng yên. Sau khi đổi, nó đi cùng nhánh sửa ở trên, không còn qua `CastExtractiveLineMissle`, nơi sinh missile ở người tung và chỉ trôi 2 px/khung.

## Phần 2: Chi tiết

### Id kỹ năng và missile (`\settings\skills.txt`, `\settings\missles.txt` trong `vng00.pak`)

| Kỹ năng | Id người chơi / npc | MisslesForm | ChildSkill (missile) | Missile: MoveKind / Speed / LifeTime | AttackRadius |
|---|---|---|---|---|---|
| Chưởng Tâm Lôi | 3 / 65 | 1 (Line) | 17 (掌心雷) | 0 Stand / 0 / 15 | 300 |
| Băng Tuyết Đạn | 5 / 67 | 1 (Line) | 9 (冰雪弹) | 1 Line / 0 (ptfix v26: 2) / 12 | 300 |
| Tích Lịch Hỏa | 6 / 68 | 1 (Line) | 57 (霹雳火) | 0 Stand / 0 / 8 | 300 |
| Lưu Tinh Thạch (cùng lỗi, người dùng chưa báo) | 4 / 66 | 1 (Line) | 44 | 0 Stand / 14 / 6 | 300 |

Các chiêu này đều có `SkillStyle 15`, `BaseSkill 1`, `ChildSkillNum 1`, `TargetOnly 1`, `TargetEnemy 1`, `Param1 0`.

### Đã loại trừ

- **ptfix không làm lệch dòng.** Dòng skill 3/5/6 trong `ptfix_v26.pak` giống hệt `vng00.pak`, cùng vị trí dòng 3/5/6. `extra_petskill.py` chỉ nối thêm 450–461 vào cuối bảng; `skill180` sửa 9 dòng chuyển sinh. Trong `missles.txt`, v26 chỉ khác VNG ở dòng 9 (`Speed 0 → 2`, do `extra_clientcrash.py`). Missile 9 đứng yên từ trước, nên bản vá đó không gây ra lỗi.
- **C++ các ngày 02–04/10 không chạm nhánh Line.** So `KSkills.cpp` hiện tại với bản gốc `_backup\20261002-castspread\KSkills.cpp`: chỉ khác `PT_SAFE_SPEED`, `cppbatch:G1`, sửa chia 0 trong `CastSpread`, và các bản vá pet (`pet10`, `onepet`, `petslot4`). `KMissle.cpp` chỉ có `cppbatch:G2/G3`.
- **`KNpc::DoSkill`/`OnSkill`** gọi `Cast(m_Index, -1, idxĐích)`, đích đúng là quái. `Param2PCoordinate` trả đúng tọa độ quái, nhưng nhánh Line lại dùng tọa độ người tung (`nSrcPX/nSrcPY`).
- **Autofight** bị loại vì người dùng xác nhận lỗi xảy ra khi bấm chuột thường.

### Đoạn mã đã sửa

`KSkill::CastMissles`, `case SKILL_MF_Line`, nhánh đích không phải hướng, launcher là NPC:

```cpp
if (m_nChildSkillNum == 1 && (MoveKind == Line || MoveKind == Parabola))
    CastExtractiveLineMissle(...);                      // không đổi
else if (m_bBaseSkill && m_bTargetOnly && nTargetId > 0 && nTargetId < MAX_NPC && nTargetId != nLauncher &&
         g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Stand)
    CastLine(&SkillParam, nDir, nDesPX, nDesPY);        // mới: sinh tại NPC đích
else
    CastLine(&SkillParam, nDir, nSrcPX, nSrcPY);        // như cũ
```

### Phạm vi ảnh hưởng

Trong dữ liệu có 63 kỹ năng gốc dạng Line với missile Stand. Bản sửa chỉ áp cho 42 kỹ năng `TargetOnly = 1` (đánh vào một NPC cụ thể). Tất cả đều có lợi khi missile sinh tại đích:

- 3 chiêu trên cùng bản npc (65/67/68), Lưu Tinh Thạch 4/66, Toái Xa 723;
- đánh thường 1/2 và đánh thường của quái 63/64/104/118/847/848;
- chiến xa 181–185; Bàn Cổ khai thiên 62; Quỷ Phủ Thần Công 392/742–744;
- Lực Sĩ Tế Chiến ý 1593; Gây Nổ 1711/1860–1866/1970–1972; Hồng Liên Tiễn Ngục 1985.

Những trường hợp sau giữ nguyên hành vi cũ:

- 21 kỹ năng con hồi máu/buff `TargetOnly = 0`, `Param1 = 1` (Bổ Tâm Chú 45/106/415/416/1120–1126, Vạn Cốt Toàn Khô 51/921, Trị liệu/Kích hoạt đồng loạt 197/198, Khô Mộc Phùng Xuân 1508/1509, Hồng Sa Tiễn 810…): vẫn sinh ở người tung;
- đích là chính người tung;
- tung vào một điểm trên đất (`nParam1` là tọa độ);
- tung theo hướng.

## Phần 3: Hành động

### File đã sửa

| File | Thay đổi | Backup |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\KSkills.cpp` | Nhánh `skillself` trong `CastMissles` (vá byte, chỉ chèn ASCII) | `_backup\20261004-skillself\KSkills.cpp` |
| `scratchpad\ptfix\extra_skillself.py` (mới) | Missile 9 `MoveKind 1 → 0` | không cần (file mới) |
| `CHANGELOG.md`, `docs\features\README.md` | Ghi nhận | `_backup\20261004-skillself\` |

### Build và kiểm tra

- [x] `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả ba OK lúc 15:15 (`Core\Modern\Win32ServerRelease\CoreServer.dll`, `Win32ClientRelease\CoreClient.dll`, `GameClient\Modern\Win32Release\Game.exe`). Bản build đã gồm các bản vá đang có (pet10, onepet, petfight…).
- [x] Build thử ptfix vào `scratchpad\skillself\ptfix_skillself_test.pak`: 617 entry, giống `ptfix_v26.pak` từng byte trừ `missles.txt`, và trong đó chỉ dòng 9 đổi `MoveKind 1 → 0`. Log: `"skillself": "missles.txt: 9(MoveKind 1->0)"`.
- [ ] **Coordinator:** build ptfix chính thức (v27, có `extra_skillself.py`) rồi chép vào Server và Client.
- [ ] **Coordinator:** triển khai `CoreServer.dll` (server), `CoreClient.dll` và `Game.exe` (client). Khởi động lại GameServer, mở lại game.
- [ ] Kiểm thử trong game: đứng cách quái khoảng 250–300 px, tung lần lượt Chưởng Tâm Lôi, Băng Tuyết Đạn, Tích Lịch Hỏa, Lưu Tinh Thạch. Hiệu ứng phải nổ trên quái và quái mất máu.
- [ ] Kiểm thử thêm đánh thường (cận chiến và tầm xa), quái dùng npc Chưởng Tâm Lôi/Băng Tuyết Đạn lên người chơi, và bot Thuật Sĩ.

**Cần triển khai đồng bộ.** Chỉ cập nhật server thì sát thương trúng quái nhưng client cũ vẫn vẽ hiệu ứng trên người. Chỉ cập nhật ptfix mà không có C++ mới thì Băng Tuyết Đạn vẫn sinh ở người tung.

## Phần 4: Tài liệu tham khảo

- `loi-thoat-client-phong-than-20261003.md`: nguồn gốc bản vá Speed 2 của missile 9.
- Script phân tích: `scratchpad\skillself\extract.py`, `dump.py`, `mdump.py`, `survey.py`, `cmp.py`, `patch_kskills.py`.
- Rollback: chép lại `_backup\20261004-skillself\KSkills.cpp` rồi build lại, xóa `extra_skillself.py` rồi build lại ptfix.
