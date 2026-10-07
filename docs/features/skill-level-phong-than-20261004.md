# Chỉ số kỹ năng theo từng cấp như VNG (Giáp Sĩ, Đạo Sĩ, Dị Nhân)

Ngày: 2026-10-04. Mã bản vá: `skilllv`. Trạng thái: C++ đã sửa và build (CoreServer, CoreClient, GameClient 21:17); smoke test 4290/0. **Chưa triển khai.**

## Phần 1: Tổng quan

Người dùng báo: "Skill của 3 phái chưa có chỉ số theo từng level như VNG", gồm 3 vấn đề. Kết quả điều tra bằng mã thật và dữ liệu VNG thật:

- **Phía server tính sát thương đúng theo cấp từ trước.** Engine gọi đúng script cấp VNG (`GetSkillLevelData`) cho mọi cấp 1–63, cả server lẫn client, cache theo (kỹ năng, cấp) đúng. Kiểm 49 kỹ năng phái × 20 cấp × 2 thứ tự nạp cache: 4206/4206 giá trị khớp công thức VNG. Không có lỗi `FindSame` kẹt cấp 1 ở người chơi (lỗi đó chỉ ở đệ triệu hồi, đã sửa trong bản vá vancot).
- **Vấn đề 1 có thật và là nguyên nhân chính khiến người chơi thấy "không có chỉ số":** tooltip ẩn toàn bộ dòng sát thương, và mọi chuỗi tiếng Việt trong tooltip kỹ năng đã hỏng (ký tự thay thế U+FFFD) ngay từ bản nguồn gốc.
- **Vấn đề 2 có thật ở 3 chỗ:** kỹ năng sự kiện của Đạo Sĩ 21/25 luôn ở cấp 1; bị động Giáp Sĩ 33/34 mất hiệu quả ở cấp lẻ; bị động không nhận cấp cộng thêm từ trang bị.
- **Vấn đề 3 có thật:** client từ chối cấp lớn hơn MaxLevel (10) do server gửi xuống, và bị động không lên theo cấp cộng thêm. Script VNG không có bảng riêng cho cấp 11–20; mọi công thức là hàm tuyến tính theo `level`, nên engine tính cấp 11–20 bằng chính công thức đó (ngoại suy tuyến tính), giống hệt nhau ở server và client (script server và client giống nhau từng byte, 51/51).

## Phần 2: Chi tiết

### 2.1 Nguyên nhân từng vấn đề

| # | Vấn đề | Nguyên nhân (file, hàm) | Sửa |
|---|---|---|---|
| 1a | Tooltip không có dòng sát thương | `KSkill::GetDescAboutLevel` bỏ qua thuộc tính có `type >= magic_ignoredefense_p && type <= magic_seriesdamage_p`. Trong registry Phong Thần, `magic_seriesdamage_p` là id cũ ≥ 1000, nên khoảng này nuốt mọi id 58…1009: Thổ/Hỏa/Băng/Lôi sát, STCB, đánh tập trung, chí mạng đều bị ẩn. Chỉ còn dòng tiêu hao. | `PtSkillLvShowDamageAttrib`: chỉ bỏ `ignoredefense_p` và `seriesdamage_p` (hai dòng này đã in riêng). |
| 1b | Thuộc tính tức thời không hiện (ví dụ tốc độ đánh) | Vòng in `m_ImmediateAttribs` bị comment. | Vòng mới, chỉ in thuộc tính thường (id 84…356), không in lại sát thương/thuộc tính kỹ năng. |
| 1c | Chữ trong tooltip là ký tự rác | 30 chuỗi trong `GetDesc`/`GetDescAboutLevel` chứa EF BF BD (U+FFFD) thay cho byte TCVN3, có từ bản nguồn đầu tiên (mọi bản sao lưu đều hỏng). | Viết lại bằng TCVN3 (escape `\x..`, nguồn vẫn ASCII): "Đẳng cấp hiện thời", "Đẳng cấp kế tiếp", "Tiêu hao nội lực", "Phạm vi hiệu quả", "Tầng", "Ngũ hành tương khắc"… |
| 1d | Không hiện cấp hiện tại cho chiêu đánh Giáp Sĩ | `GetDesc` chỉ in cấp khi `!IsBaseSkill`; `IsBase()` là `Attrib <= 1`, chiêu đánh Giáp Sĩ có Attrib 1. | In cấp cho mọi kỹ năng phái; thêm dòng "Đẳng cấp tối đa: 10" (MaxLevel thật của skills.txt, cùng giá trị server dùng để chặn cộng điểm và lbdaosi dùng khi "nâng max"). |
| 1e | "Đẳng cấp kế tiếp" hiện cả khi đã tối đa | `GetDesc` luôn lấy cấp + 1. | Kỹ năng phái ở MaxLevel không hiện cấp kế; cấp hiện tại/kế > MaxLevel có dòng "(Vượt cấp tối đa: chỉ số ngoại suy theo công thức cấp VNG)". |
| 2a | Đạo Sĩ 21 Băng Phong Bạo, 25 Băng Phong Vạn Lý: hiệu ứng phụ không mạnh lên | Script VNG trả `skill_eventskilllevel = level`, nhưng tên trong registry là `skill_reserve2`, nên `ParseString2MagicAttrib` bỏ qua; kỹ năng sự kiện (149, 117) luôn ở cấp 1 (cột `EventSkillLevel`). | `PtSkillLvAttribAlias`: tên VNG `skill_eventskilllevel` → `magic_skill_eventskilllevel` (chỉ kỹ năng phái). |
| 2b | Giáp Sĩ 33/34 (Tinh thông đoản đao / trường đao): cấp lẻ mất đánh tập trung / chính xác | Công thức `3+level/2` cho "5.5,-1,0". `KSG_StringGetInt` dừng ở dấu chấm, không thấy dấu phẩy, giá trị 2 và 3 thành 0: mất cờ -1 (vĩnh viễn) nên thuộc tính rơi sang nhóm tức thời và **không được áp** khi bị động kích hoạt. | `PtSkillLvFixValue`: bỏ phần thập phân của từng số trước khi phân tích (cắt như C, đúng số engine đã dùng cho giá trị 1). |
| 2c / 3a | Bị động không nhận cấp cộng thêm (trang bị +kỹ năng) | Bị động (style 3) chỉ được cast một lần khi học/đăng nhập; `AllSkillV`/`SeriesSkillV` chỉ tăng `CurrentSkillLevel`, không cast lại. | `KSkillList::PtSkillLvRefreshPassive()` gọi cuối `KPlayer::UpdataCurData` (server): bị động phái có trạng thái khác `CurrentSkillLevel` thì gỡ trạng thái cũ (như `KNpc::IgnoreState`) rồi cast lại ở cấp hiện tại; tăng và giảm đều đúng. |
| 3b | Cấp > 10 do server gửi (SetSkillLevel, web admin) bị client giữ ở 10; giảm cấp cũng không cập nhật | `KSkillList::SetLevel` (client) gọi `IncreaseLevel`, hàm này chặn vượt MaxLevel và mọi lần giảm. | Client nhận nguyên giá trị server (server là nguồn đúng); vẫn dùng `IncreaseLevel` khi tăng hợp lệ. |

Cấp > MaxLevel bị cắt ở: `KSkillList::IncreaseLevel` (`maxLearned`, cả server và client). Server giữ nguyên chặn này cho việc cộng điểm (đúng VNG: học tối đa 10). Cấp 11–20 đến từ cấp cộng thêm (`AddLevel`) hoặc `SetSkillLevel`; `KSkillManager::InstanceSkill` không chặn và nạp được mọi cấp < 64.

### 2.2 Bảng kiểm chứng (engine thật, dữ liệu VNG thật)

"Server trước/sau" là giá trị `KSkill` thật (mã `LoadSkillLevelData` + `ParseString2MagicAttrib` trích từ nguồn, chạy trên Lua 4 thật của engine). "VNG" là công thức script tính độc lập bằng Python. Cấp 15 và 20 là ngoại suy tuyến tính theo công thức VNG.

| Kỹ năng | Thuộc tính | Cấp | VNG (công thức script) | Server trước | Server sau | Tooltip trước | Tooltip sau |
|---|---|---|---|---|---|---|---|
| Khai Sơn Trảm (Giáp Sĩ 29) | earthdamage_v | 1 | 26–72 | 26–72 | 26–72 | không hiện | Thổ sát:26đến 72điểm |
| | | 5 | 50–120 | 50–120 | 50–120 | không hiện | Thổ sát:50đến 120điểm |
| | | 10 | 80–180 | 80–180 | 80–180 | không hiện | Thổ sát:80đến 180điểm |
| | | 15 *(ngoại suy)* | 110–240 | 110–240 | 110–240 | không hiện | Thổ sát:110đến 240điểm |
| | | 20 *(ngoại suy)* | 140–300 | 140–300 | 140–300 | không hiện | Thổ sát:140đến 300điểm |
| Khuynh Thành Nhất Kích (Giáp Sĩ 42) | physicsenhance_p | 1 / 5 / 10 / 15 / 20 | 44 / 60 / 80 / 100 / 120 % | như VNG | như VNG | không hiện | STCB:44 % … STCB:120 % |
| Băng Tuyết Đạn (Đạo Sĩ 5) | colddamage_v | 1 | 15–30 (đóng băng 5) | 15–30 (5) | 15–30 (5) | không hiện | Băng sát:15đến 30 |
| | | 5 | 35–70 (25) | 35–70 (25) | 35–70 (25) | không hiện | Băng sát:35đến 70 |
| | | 10 | 60–120 (50) | 60–120 (50) | 60–120 (50) | không hiện | Băng sát:60đến 120 |
| | | 15 *(ngoại suy)* | 85–170 (75) | 85–170 (75) | 85–170 (75) | không hiện | Băng sát:85đến 170 |
| | | 20 *(ngoại suy)* | 110–220 (100) | 110–220 (100) | 110–220 (100) | không hiện | Băng sát:110đến 220 |
| Tam Muội Chân Hỏa (Đạo Sĩ 26) | firedamage_v | 1 / 5 / 10 / 15 / 20 | 330–440 / 450–600 / 600–800 / 750–1000 / 900–1200 | như VNG | như VNG | không hiện | Hỏa sát:330đến 440 … 900đến 1200 |
| Thôi Thân Chú (Dị Nhân 44) | physicsenhance_p | 1 / 5 / 10 / 15 / 20 | 20 / 36 / 56 / 76 / 96 % | như VNG | như VNG | không hiện | STCB:20 % … STCB:96 % |
| Vạn Cốt Toàn Khô (Dị Nhân 51) | fatallystrike_p | 1 / 5 / 10 / 15 / 20 | 18 / 26 / 36 / 46 / 56 % | như VNG | như VNG | không hiện | Đánh chí mạng:18 % … 56 % |

Các giá trị đổi theo bản vá:

| Kỹ năng | Giá trị | Cấp 1 | Cấp 5 | Cấp 10 | Cấp 15 | Cấp 20 |
|---|---|---|---|---|---|---|
| Đạo Sĩ 21 Băng Phong Bạo — cấp kỹ năng sự kiện 149 (VNG = level) | trước | 1 | 1 | 1 | 1 | 1 |
| | sau | 1 | 5 | 10 | 15 | 20 |
| Đạo Sĩ 25 Băng Phong Vạn Lý — cấp kỹ năng sự kiện 117 (VNG = level) | trước | 1 | 1 | 1 | 1 | 1 |
| | sau | 1 | 5 | 10 | 15 | 20 |
| Giáp Sĩ 33 đánh tập trung (deadlystrikeenhance_p) | trước | 3 (không áp) | 5 (không áp) | 8 | 10 (không áp) | 13 |
| | sau | 3 | 5 | 8 | 10 | 13 |
| Giáp Sĩ 34 chính xác (attackratingenhance_p) | trước | 3 (không áp) | 5 (không áp) | 8 | 10 (không áp) | 13 |
| | sau | 3 | 5 | 8 | 10 | 13 |
| Giáp Sĩ 33 STCB bị động, học cấp 5, trang bị +3 rồi +10 rồi bỏ | trước | 42 | +3 → 42 | +10 → 42 | bỏ → 42 | |
| | sau | 42 | +3 → 51 | +10 → 72 | bỏ → 42 | |
| Client `SetLevel` (server gửi 15, rồi 5, rồi 6; MaxLevel 10) | trước | 10 | 10 | 10 | | |
| | sau | 15 | 5 | 6 | | |

Tooltip giữ đúng định dạng chuỗi `MagicDesc.ini` của VNG (ví dụ `$Thổ sát:#d1-đến #d3-điểm`); bộ định dạng chung với tooltip vật phẩm nên không đổi khoảng trắng.

### 2.3 File đã sửa (mã dấu `skilllv`, sao lưu `_backup\20261004-skilllv\src\`)

| File | Nội dung |
|---|---|
| `PhongThanSource\Sources\Core\Src\KSkills.cpp` | Khối helper `PtSkillLvAttribAlias`, `PtSkillLvFixValue`, `PtSkillLvShowDamageAttrib`, `PtSkillLvShowImmediateAttrib`; gọi alias + sửa giá trị ở đầu `ParseString2MagicAttrib`; `GetDesc` (cấp hiện tại cho kỹ năng phái, cấp tối đa, ghi chú ngoại suy, chặn cấp kế ở MaxLevel); `GetDescAboutLevel` (bộ lọc sát thương, dòng tức thời); 30 chuỗi TCVN3. |
| `PhongThanSource\Sources\Core\Src\KSkillList.cpp` | Client `SetLevel` nhận cấp server; server `PtSkillLvRefreshPassive()`. |
| `PhongThanSource\Sources\Core\Src\KSkillList.h` | Khai báo `PtSkillLvRefreshPassive()` (khối `_SERVER`). |
| `PhongThanSource\Sources\Core\Src\KPlayer.cpp` | 1 lời gọi cuối `UpdataCurData` (`#ifdef _SERVER`). |

Không đổi dữ liệu: không cần plug-in ptfix (MaxLevel giữ 10, script VNG dùng nguyên). Mọi marker cũ còn nguyên (đếm trước/sau: engine2, KMission, KNpcSet, botheal, vancot, skillself, pet10, onepet, timduong, noexppenalty, desertexp, autofight, daosi… không đổi; `MAX_NPC` tăng 1 chỉ vì chuỗi con của `MAX_NPCSKILL`).

### 2.4 Kiểm thử

- Smoke test offline `scratchpad\skilllv\smoke\` (`run.ps1`): biên dịch mã thật trích từ nguồn (bản cũ từ backup và bản mới), Lua 4 thật (`Library\LuaLib`), `skills.txt` + 51 script cấp + `MagicDesc.ini` thật từ PAK.
  - Bản cũ: 4206 PASS / 0 FAIL; ghi nhận 38 sai cấp sự kiện (21, 25), 0 dòng sát thương trong tooltip, SetLevel kẹt 10, bị động kẹt 42.
  - Bản mới: **4290 PASS / 0 FAIL**, 0 lỗi Lua; 60 dòng sát thương hiện trong tooltip mẫu (12 kỹ năng × 6 cấp, có cấp 11).
- Build `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient`: cả 3 OK (21:16–21:17), 0 lỗi. Đã xác nhận chuỗi mới có trong `CoreClient.dll`, không còn chuỗi hỏng.

## Phần 3: Hành động

### Triển khai (người dùng tự làm, cần tắt GameServer + Bishop + game)
- [ ] Server: `CoreServer.dll` từ `Sources\Core\Modern\Win32ServerRelease\` (theo `_backup\20261002-modernbuild\Deploy-ModernServer.ps1`).
- [ ] Client: `CoreClient.dll` từ `Sources\Core\Modern\Win32ClientRelease\` và `Game.exe` từ `Sources\GameClient\Modern\Win32Release\`.
- [ ] Không cần ptfix mới, không cần sửa Lua. Triển khai cùng đợt với các bản C++ đang chờ (engine2, vancot, lbdaosi…) vì cùng một DLL.

### Kiểm tra trong game
- [ ] Rê chuột kỹ năng 29 / 5 / 44 cấp 1: thấy "Đẳng cấp hiện thời: 1", "Đẳng cấp tối đa: 10", "Tiêu hao nội lực", dòng "Thổ sát / Băng sát / STCB" và mục "Đẳng cấp kế tiếp" với số lớn hơn.
- [ ] Cộng điểm lên cấp 2: số trong tooltip tăng đúng bảng trên; đánh quái thấy sát thương tăng.
- [ ] Kỹ năng ở cấp 10: không còn mục "Đẳng cấp kế tiếp".
- [ ] Đeo trang bị +kỹ năng (hoặc web admin đặt cấp 15): tooltip hiện "Đẳng cấp hiện thời: 13 (10+3)" kèm dòng ngoại suy; Giáp Sĩ 33 tăng STCB theo cấp mới; bỏ trang bị thì trở về.
- [ ] Đạo Sĩ 21/25: hiệu ứng phụ mạnh lên theo cấp.

## Phần 4: Tài liệu tham khảo

- Script cấp VNG: `\script\skill\{daoshi,jiashi,yiren}\*.lua` (PAK `serverlist.pak`, giống hệt ở client); bản trích: `scratchpad\skilllv\lvl\`.
- `MagicDesc.ini` (vng00.pak), registry `Core\Src\KMagicAttribRegistry.inc`.
- Công cụ: `scratchpad\skilllv\patch_src.py` (vá byte), `markers.py` (sao lưu + đếm marker), `smoke\` (extract.py, oracle.py, skilllv_test.cpp, run.ps1, table.md).
- Liên quan: `lenh-bai-dao-si-phong-than-20261004.md` (nâng max kỹ năng dùng MaxLevel thật = 10), `van-cot-toan-kho-phong-than-20261004.md` (lỗi `FindSame` ở đệ triệu hồi).
- Còn lại (chưa làm, ngoài phạm vi 3 phái): 211 kỹ năng khác cũng dùng `skill_eventskilllevel`; có thể mở alias và sửa phần thập phân cho mọi kỹ năng sau khi kiểm thử quái/boss. Khi cấp bị động giảm (bỏ trang bị), `SetStateSkillEffect` phía client chỉ nâng chứ không hạ trạng thái, nên chỉ số hiển thị ở client có thể còn theo cấp cao hơn; server (nơi tính sát thương) luôn đúng.
