---
tinh-nang: Đạo Sĩ đánh nhiều chiêu (phím chiêu nhanh, đệm lệnh tung chiêu, tự đánh luân phiên)
ngay: 2026-10-04
agent: daosi
trang-thai: C++ đã build (CoreServer, CoreClient, Game.exe), CHƯA triển khai
tom-tat: Đạo Sĩ có nhiều hệ nhưng client chỉ cho dùng gọn 1 chiêu. Có 3 lỗi: tay trái không nhận các chiêu lớn của Đạo Sĩ; bấm chiêu khi còn đang trong động tác thì lệnh bị bỏ (client và server); tự đánh chỉ dùng 1 chiêu. Đã sửa cả 3. Thêm phím Alt+R để bật/tắt luân phiên khi tự đánh. Tốc độ đánh và thời gian chờ từng chiêu giữ nguyên như VNG.
---

# Đạo Sĩ đánh nhiều chiêu (2026-10-04)

## Phần 1: Tổng quan

- **Yêu cầu:** "Đạo Sĩ ở client chưa cho đánh nhiều chiêu cùng lúc, vì Đạo Sĩ có nhiều hệ mà." Người dùng xác nhận 3 lỗi: phím tắt bị giới hạn, không tung xen kẽ được, tự đánh chỉ dùng 1 chiêu.
- **Engine không có thời gian hồi chung.** Mỗi chiêu chỉ có thời gian chờ riêng (`TimePerCast` trong `skills.txt`). Cảm giác "phải chờ lâu" đến từ chỗ khác: lệnh tung chiêu bấm trong lúc nhân vật còn đang ra đòn bị **vứt bỏ**, ở cả client lẫn server.
- **Phím chiêu nhanh của VNG vẫn có, nhưng tay trái thiếu 4 chiêu mạnh nhất.** VNG dùng 9 phím Q W E / A S D / Z X C (không phải F1–F12; các phím F là phím mở cửa sổ). Bốn chiêu lớn của Đạo Sĩ (18, 23, 25, 26) mang cờ "chỉ tay phải", nên không thể đặt hai chiêu lớn khác hệ lên hai nút chuột.
- **Cách sửa:**
  1. Tay trái nhận thêm 4 chiêu tấn công lớn của Đạo Sĩ.
  2. Một lệnh tung chiêu bấm trong lúc đang ra đòn được giữ lại và chạy ngay khi động tác kết thúc, ở cả client lẫn server.
  3. Tự đánh (Alt+A / Alt+S / Alt+D) luân phiên nhiều chiêu, bật/tắt bằng **Alt+R**.
- **Cân bằng giữ nguyên.** Độ dài động tác (CastSpeed/AttackSpeed), thời gian chờ từng chiêu, nội lực và tầm đánh đều không đổi. Server vẫn kiểm tra lại tất cả khi lệnh chạy. Thay đổi không cho tung nhanh hơn người bấm đúng nhịp; người chơi chỉ không còn phải canh nhịp.

## Phần 2: Chi tiết

### 2.1 Lỗi 1: phím tắt / chuột

**Hiện trạng (đúng như VNG):**
- `\Ui\autoexec.lua` gán Q W E A S D Z X C = `ShortcutSkill(0..8)`, tổng 9 ô (`SKILLTREE_SHORTCUT_SKILL_COUNT 9`, `UiSkillTree.h`).
- Mỗi ô nhớ 1 chiêu và 1 tay (trái/phải), lưu ở `UserData\<tài khoản>\UiConfig.ini` mục `[ShortSkill]`.
- Cách gán: bấm ô chiêu tay trái/phải trên thanh nhân vật để mở bảng chọn, rê chuột lên chiêu, bấm Q…C. Từ đó bấm phím đó là đổi chiêu của tay tương ứng.
- Không chặn chiêu khác ngũ hành. F1–F11 do VNG dùng mở cửa sổ (F1 trợ giúp, F2 cửa hàng, F3 trạng thái, F4 hành trang, F5 kỹ năng, F6 bạn bè, F7/F8 tên/máu, F9 PK, F10 bang, F11 nhiệm vụ). Giữ nguyên.

**Nguyên nhân:**
- `KSkillList::GetLeftSkillSortList` (`Core\Src\KSkillList.cpp`, khoảng dòng 700) chỉ đưa vào bảng tay trái các chiêu `LRSkill = 0` (cả hai) hoặc `1` (trái).
- Trong `skills.txt`, 4 chiêu lớn của Đạo Sĩ có `LRSkill = 2` (chỉ phải):

| Id | Chiêu | Hệ | TimePerCast (khung, 18 khung = 1 giây) | Tầm |
|---|---|---|---|---|
| 18 | Thập Phương Liệt Hỏa | Hỏa | 40 (≈2,2 s) | 500 |
| 23 | Lôi Động Cửu Thiên | Lôi | 125 (≈6,9 s) | 500 |
| 25 | Băng Phong Vạn Lý | Băng | 20 (≈1,1 s) | 500 |
| 26 | Tam Muội Chân Hỏa | Hỏa | 40 (≈2,2 s) | 500 |

- Hệ quả: nút phải chỉ giữ được 1 trong 4 chiêu, nút trái chỉ có chiêu nhỏ.

**Sửa (`daosi:L1`):**
- Bảng tay trái nhận thêm chiêu "chỉ phải" khi thỏa đủ: là chiêu phái (3–51), không phải hào quang, `TargetEnemy = 1`, không nhắm đồng đội/bản thân.
- Kiểm tra trên `skills.txt`: đúng 4 chiêu 18/23/25/26 được thêm. Buff (9, 19, 22), Bổ Tâm Chú của Dị Nhân (45) và các hào quang Giáp Sĩ/Dị Nhân vẫn chỉ tay phải.
- Server không kiểm tra tay trái/phải: thời gian chờ và nội lực áp dụng như nhau cho hai nút.

### 2.2 Lỗi 2: tung xen kẽ phải chờ lâu

**Nguyên nhân (engine, có ở cả client và server):**
1. `KNpc::ProcCommand` (`Core\Src\KNpc.cpp`, khoảng dòng 1090): khi nhân vật đang trong động tác (`m_ProcessAI = 0`: tung chiêu `do_magic`, đánh `do_attack`/`do_special1`, trúng đòn `do_hurt`), lệnh `do_skill` rơi vào nhánh `else` rồi bị xóa ở cuối hàm (`m_Command.CmdKind = do_none`).
   - Server: lệnh client gửi tới sớm hơn 1 khung so với lúc động tác bên server kết thúc cũng bị xóa. Client đã vẽ chiêu nhưng server không tung.
2. `KCoreShell::UseSkill` (`Core\Src\CoreShell.cpp`, khoảng dòng 3683; dùng cho chuột phải, Shift+chuột trái, phím `UseSkill`): `if (!IsCanInput()) return 0;`. Cú bấm trong lúc ra đòn bị bỏ hẳn, không gửi lên server.
- Độ dài động tác người chơi: `m_CastFrame = 20` khung (≈1,1 s) chia cho tốc độ xuất chiêu (`cppbatch:G4/G5`, `KNpc.cpp` khoảng dòng 2858/2887). Phần này đúng VNG, không đổi.
- Dữ liệu: các chiêu Đạo Sĩ 3–6, 8, 10, 11, 13, 15, 16, 20, 24 có `TimePerCast = 0`. Chỉ có 18/21/23/25/26 và buff là có thời gian chờ riêng. Không chiêu nào có thời gian chờ chung.

**Sửa:**
- `daosi:Q1` (`KNpc.cpp`, đầu `ProcCommand`, server và client):
  - Với NPC là người chơi đang ở `do_magic/do_attack/do_special1/do_hurt`, lệnh `do_skill` được giữ vào 1 ô đệm (mảng tĩnh theo chỉ số NPC, không đổi `KNpc.h`). Lệnh chạy ở khung đầu tiên khi AI mở lại.
  - Lệnh bị bỏ nếu: cũ hơn 24 khung (≈1,3 s); slot NPC đã thuộc người khác; mục tiêu đã chết hoặc slot mục tiêu có NPC khác (so `m_dwID`); người chơi ra lệnh đi/chạy/nhảy/đứng/ngồi trong lúc đó; có lệnh mới hơn.
  - Quái và NPC không đổi gì.
- `daosi:Q2` (`CoreShell.cpp`, `PTDS_UseSkillWhileBusy`):
  - Cú bấm trong lúc ra đòn được kiểm tra bằng chính chiêu vừa bấm: mục tiêu, `CanCast` (thời gian chờ riêng), nội lực, tầm. Rồi nó được gửi như một cú bấm thường.
  - Chiêu của động tác đang chạy không bị đổi (`OnSkill` vẫn tung đúng chiêu cũ ở 60 % động tác).
  - Hào quang và chiêu nhắm vật phẩm không đi đường này.

### 2.3 Lỗi 3: tự đánh chỉ dùng 1 chiêu

**Nguyên nhân:** `PTAF_PickSkill` (`Core\Src\PhongThanAutoFight.inl`) chỉ xét chiêu ưu tiên của chế độ (trái hoặc phải), cộng tay trái làm dự phòng.

**Sửa (luân phiên, mặc định BẬT):**
- **Danh sách chiêu:**
  - Gồm chiêu ưu tiên, chiêu tay trái, chiêu tay phải và các chiêu đang gán ở 9 phím Q…C.
  - Chỉ giữ chiêu tấn công (bỏ buff, hào quang, bị động, chiêu nhắm vật phẩm). Bỏ đòn đánh thường của vũ khí khi đã có chiêu thật.
  - Nếu còn dưới 2 chiêu, lấy mọi chiêu tấn công phái đã học: Đạo Sĩ 3–26 đủ các hệ, Giáp Sĩ 27–42, Dị Nhân 43–51.
- **Chọn chiêu mỗi lần tung:**
  1. Ưu tiên chiêu với tới mục tiêu.
  2. Trong các chiêu với tới, chiêu có thời gian chờ riêng (chiêu lớn mỗi hệ) được dùng ngay khi hồi xong. Các chiêu này **luân phiên**: chiêu dùng lâu nhất trước, nên hệ nào cũng tới lượt.
  3. Chiêu không có thời gian chờ lấp chỗ trống, cũng luân phiên.
  4. Không chiêu nào với tới: lấy chiêu tầm xa nhất, rồi tự đánh tiến lại gần.
  - Ví dụ khi đứng trong tầm 250: 23 → 18 → 26 → 25 → 18 → 26 → 25 → 23 …
- **Tắt luân phiên** (Alt+R): trở về đúng hành vi cũ (chiêu ưu tiên, tay trái dự phòng).
- **Danh sách phím nhanh:** Game.exe gửi qua `PAIOperation(0x50544146, 0x11/0x12, id)` mỗi lần bật tự đánh, mỗi lần bấm Alt+R và mỗi lần gán lại một phím Q…C (`KUiSkillTree::PTPushShortcutSkills`). Không đổi giao thức mạng; server kiểm tra như lệnh chuột.

### 2.4 Phím

| Phím | Tác dụng | Ghi chú |
|---|---|---|
| Q W E / A S D / Z X C | Đổi chiêu tay đã gán (VNG) | Gán: mở bảng chọn chiêu trái/phải, rê chuột lên chiêu, bấm phím |
| Chuột phải / Shift+chuột trái | Tung chiêu tay phải / trái; bấm trong lúc ra đòn thì chiêu được xếp hàng | Mới: không còn mất cú bấm |
| Alt+A / Alt+S / Alt+D | Tự đánh (tay trái / tay phải / đứng tại chỗ) | Thông báo kèm "luân phiên N chiêu" |
| **Alt+R** (mới) | Bật/tắt luân phiên chiêu khi tự đánh | Dùng được lúc đang hay chưa tự đánh; chỉ là phím dự phòng trong C++ (như Alt+N/Alt+G), `autoexec.lua` gán Alt+R thì phím đó thắng |

Không trùng với Alt+N, Alt+A, Alt+S, Alt+D, Alt+G, Alt+T, Alt+E hay các phím Alt khác trong `autoexec.lua` (Alt+0–9, B, C, L, Q, W, X, Z).

### 2.5 Ảnh hưởng tới các phái

- **Giáp Sĩ, Dị Nhân:** không có chiêu tấn công "chỉ phải" nên bảng tay trái không đổi. Đệm lệnh áp như nhau cho mọi người chơi: chiêu cận chiến (`do_attack`, `do_special1`) cũng được xếp hàng.
- **Tự đánh của Giáp Sĩ/Dị Nhân:** luân phiên giữa các chiêu đã gán. Có 2 chiêu thì giữ cả 2, kể cả đòn đánh thường.
- **Quái, NPC, đệ tử, bot:** không đổi. Đệm chỉ áp cho `kind_player`.

## Phần 3: Hành động

### 3.1 File đã sửa (vá mức byte, chỉ chèn ASCII; đã so từng dòng với bản sao lưu)

| File | Dấu | Nội dung |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\KNpc.cpp` | `daosi:Q1` | Ô đệm lệnh tung chiêu trong `ProcCommand` (+44 dòng) |
| `PhongThanSource\Sources\Core\Src\CoreShell.cpp` | `daosi:Q2` | `PTDS_UseSkillWhileBusy` và nhánh `else` của `UseSkill` |
| `PhongThanSource\Sources\Core\Src\KSkillList.cpp` | `daosi:L1` | Tay trái nhận chiêu tấn công "chỉ phải" của phái |
| `PhongThanSource\Sources\Core\Src\PhongThanAutoFight.inl` | `daosi` | Luân phiên, mã `PTAF_OP_*`, thông báo TCVN3 |
| `PhongThanSource\Sources\GameClient\Ui\UiCase\UiSkillTree.h/.cpp` | `daosi:K1` | `PTPushShortcutSkills()`, gọi khi gán phím |
| `PhongThanSource\Sources\GameClient\Ui\ShortcutKey.cpp` | `daosi:K2` | Gửi danh sách trước Alt+A/S/D; phím dự phòng Alt+R |

Sao lưu: `_backup\20261004-daosi\` (7 file nguồn, `CHANGELOG.md`, `docs\features\README.md`).

### 3.2 Build và kiểm thử

- [x] `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả 3 OK lúc 17:11 (`Core\Modern\Win32ServerRelease\CoreServer.dll`, `Win32ClientRelease\CoreClient.dll`, `GameClient\Modern\Win32Release\Game.exe`).
- [x] Smoke test offline `scratchpad\daosi\smoke\` (`build.cmd`): **45 OK / 0 FAIL**. Bản test biên dịch đúng mã sẽ chạy thật:
  - `PhongThanAutoFight.inl` được include nguyên file.
  - Khối `daosi:Q1` và hàm `daosi:Q2` được `extract.py` cắt nguyên văn từ `KNpc.cpp` và `CoreShell.cpp`.
  - Các trường hợp: thứ tự luân phiên, tầm, nội lực, danh sách dự phòng, tắt luân phiên ra hành vi cũ, mã Alt+R, gửi đúng mã mục tiêu; đệm lệnh (giữ, chạy, hết hạn, mục tiêu đổi, lệnh di chuyển hủy, lệnh mới thắng, quái không đổi); cú bấm lúc ra đòn (gửi, không đổi chiêu đang chạy, bỏ hào quang, hồi chiêu, ngoài tầm).
- [x] Kiểm tra dữ liệu `skills.txt`: chỉ 18/23/25/26 được thêm vào tay trái.
- [x] Các bản vá cũ còn nguyên: petfight/PhongThanPetTargetOk, petrange, petdebug/petdebug2, onepet, pet10, skillself, dinhanbot, weaponequip, noexppenalty, desertexp, m_bCanStack, partypanel, autofight, questtrack.

### 3.3 Cần làm (coordinator)

- [ ] Triển khai **server**: `CoreServer.dll` (đệm lệnh phía server, `daosi:Q1`). Theo `Deploy-ModernServer.ps1`, khi GameServer và Bishop đã tắt.
- [ ] Triển khai **client**: `CoreClient.dll` và `Game.exe`.
- [ ] **ptfix:** không cần. Không đổi dữ liệu, không đổi `autoexec.lua`.
- [ ] Nên triển khai server và client cùng lúc.
  - Chỉ client mới: cú bấm lúc ra đòn được gửi nhưng server cũ có thể bỏ, gây lệch hình.
  - Chỉ server mới: vẫn có lợi (không bỏ lệnh tới sớm 1 khung), nhưng client cũ vẫn bỏ cú bấm.
- [ ] Kiểm thử trong game với một Đạo Sĩ đã học 18/23/25/26:
  1. Mở bảng chọn chiêu tay trái: có 18/23/25/26. Đặt 25 trái, 26 phải; gán Q = 23, W = 18.
  2. Bấm chuột phải liên tục, đổi Q/W giữa chừng: chiêu ra liền nhau, quái mất máu theo từng chiêu (server tung thật).
  3. Alt+S: thông báo "Tự động đánh: BẬT (chiêu tay phải) - luân phiên N chiêu (Alt+R bật/tắt)". Quan sát luân phiên các hệ. Alt+R: "Luân phiên chiêu khi tự đánh: TẮT (chỉ dùng 1 chiêu)".
  4. Giáp Sĩ và Dị Nhân: đánh tay, tự đánh bình thường.

### 3.4 Hạn chế còn lại (chưa sửa, ngoài phạm vi)

- `UiGame.cpp` dòng 113: giữ chuột phải rồi di chuột gọi `HandleMouseInput(0, VK_RBUTTON, …)` (đảo tham số) nên không tung lặp. Sửa thì phải chặn tần suất gửi gói, nên chưa làm.
- Đặt chiêu có thời gian chờ dài lên tay trái rồi click khóa quái: AI theo đuổi (`KNpcAI::FollowPeople`) gửi lệnh mỗi khung khi chiêu còn hồi. Server từ chối đúng, chỉ tốn gói tin. Chiêu 21 (TPC 50, cả hai tay) vốn đã như vậy.

## Phần 4: Tài liệu tham khảo

- `tu-dong-danh-phong-than-20261003.md`: tính năng tự đánh gốc (Alt+A/S/D).
- `skill-self-target-phong-than-20261004.md`: id và missile các chiêu Đạo Sĩ.
- `bi-kip-he-phai-phong-than-20261002.md`: danh sách kỹ năng 3 phái.
- Script: `scratchpad\daosi\patch_knpc.py`, `patch_coreshell.py`, `patch_kskilllist.py`, `patch_gameclient.py`, `gen_tcvn.py`, `verify_diff.py`, `smoke\`.
- Rollback: chép lại 7 file từ `_backup\20261004-daosi\` rồi build lại 3 target.
