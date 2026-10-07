# Kỹ năng đệ tử (triệu hồi) cho Dị Nhân

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02 · Người làm: agent petskill
> Trạng thái: **Đã làm, chờ cài.** Dữ liệu kỹ năng nằm trong plug-in ptfix `extra_petskill.py` (bản build thử đạt). Có tác dụng sau khi build/cài ptfix mới và khởi động lại server, game, web admin.

## Phần 1: Tổng quan
- **Lỗi người dùng báo:** web admin chỉ liệt kê 9 kỹ năng phái của Dị Nhân (43–51), không có kỹ năng đệ tử.
- **Nguyên nhân gốc:**
  - VNG để 12 kỹ năng triệu hồi (450–461) trong `\settings\summonskill.txt`. Engine này không bao giờ nạp file đó.
  - `skills.txt` không có dòng nào kiểu `SkillStyle 4` (`SKILL_SS_CreateNpc`). Vì vậy kỹ năng không tồn tại với server, client lẫn web admin.
  - Trước đây chỉ có đường vòng bằng Lua: Lệnh Bài Triệu Hồi (61003).
- **Cách làm:**
  - Thêm 12 dòng kỹ năng thật vào `skills.txt` qua plug-in ptfix. ptfix là một file dùng chung cho Server và Client.
  - Web admin có nhóm riêng "Kỹ năng đệ tử (triệu hồi)".
  - Lệnh Bài Triệu Hồi có thêm mục "Học kỹ năng triệu hồi".
- **Lưu ý quan trọng:** khi gọi đệ tử bằng *kỹ năng*, engine ghi đè ô kỹ năng số 4 của đệ tử bằng một mã sai (âm). Đệ tử vẫn đi theo chủ nhưng **không đánh** cho đến khi sửa C++ (xem 2.5). Gọi đệ tử bằng *lệnh bài* vẫn đánh bình thường.

## Phần 2: Chi tiết

### 2.1 Bảng kỹ năng (mã giữ đúng VNG, đã kiểm tra còn trống)
| Mã | Tên | Mẫu NPC | Cần cấp | Nội lực |
|---|---|---|---|---|
| 450 | Lực Sĩ tế | 359 | 5 | 29 |
| 451 | Trường Cung tế | 360 | 15 | 59 |
| 452 | Thiên Vũ tế | 361 | 25 | 79 |
| 453 | Liên Nỗ tế | 362 | 35 | 99 |
| 454 | Hỏa Lôi tế | 403 | 45 | 119 |
| 455 | Toái Cốt tế | 404 | 55 | 139 |
| 456 | Lưu Tinh tế | 405 | 65 | 159 |
| 457 | Truy Hồn tế | 406 | 75 | 179 |
| 458 | Phong Quyển Tàn Vân | 407 | 85 | 199 |
| 459 | Cuồng Đào tế | 1345 | 95 | 180 |
| 460 | Ngự Sậu Bạo Phong | 1346 | 105 | 250 |
| 461 | Huyền Ảnh Tán Hoa | 2032 | 120 | 250 |

- **Mã 450–461:** không trùng `skills.txt` (dải 440–470 trống) và không trùng plug-in nào khác. Các plug-in khác không động tới kỹ năng; 61001–61019 là mã vật phẩm magicscript.
- **Cách tạo dòng:**
  - Nhân bản dòng 45 (Bổ Tâm Chú) để đủ và đúng 99 cột.
  - `SkillStyle 4`, `Attrib` = mẫu NPC.
  - `TargetSelf 1`, các cờ mục tiêu khác 0. `EqtLimit -2`: không cần vũ khí.
  - `ReqLevel` = cấp yêu cầu, `MaxLevel 10`.
  - Thời gian hồi `TimePerCast 270` khung hình (15 giây, như VNG).
  - Icon và nội lực lấy từ `summonskill.txt` của VNG. Tên TCVN3 lấy theo `trieuhoi_lenhbai.lua`.
- **Icon:** cả 12 icon đều có trong PAK client (`spr.pak`, `update0_122-163/164-166.pak`, `vng00.pak`).
- **Chỉ số theo cấp:**
  - `LvlSetScript` = `\script\phongthan\skill\pt_summon_lvl.lua`. Đường dẫn ASCII, đóng trong ptfix.
  - Hàm `GetSkillLevelData("skill_cost_v", nội_lực, cấp)` trả về `"nội_lực,0,0"`.
  - Nhờ vậy `LoadSkillLevelData` luôn tìm thấy script, không lỗi.

### 2.2 Engine (đã đọc mã nguồn)
- **`KSkill::CanCastSkill`:** nếu kỹ năng đang dùng có style 4 thì nhảy thẳng tới `relationisvalid`. Nghĩa là gọi được khi không chọn mục tiêu.
- **Ô kỹ năng chuột trái/phải:** `GetLeft/RightSkillSortList` luôn đưa style 4 vào danh sách. Client ẩn kỹ năng khi nhân vật chưa đủ `ReqLevel`.
- **`KSkill::Cast` (style 4):**
  - xóa đệ tử cũ (`m_nPetIdx`);
  - tạo NPC `MAKELONG(cấp chủ, Attrib)` với AiMode 11, chủ nhân, phe và hệ của chủ;
  - cộng sinh lực, chính xác, phòng thủ của chủ;
  - đặt tên `[cấp]tên`.
- **Bỏ qua bộ lọc phái:** 450–461 nằm ngoài dải 3–51, nên `PhongThanProfessionOwnsSkill` không lọc. Nạp từ DB vẫn giữ kỹ năng.

### 2.3 Học trong game (Lệnh Bài Triệu Hồi)
- **Menu chính** thêm dòng "Học kỹ năng triệu hồi". Tổng 16 lựa chọn, dưới giới hạn 20. Các dòng gọi, gọi về và thu hồi giữ nguyên.
- **Menu học:**
  - chỉ liệt kê kỹ năng đã đủ cấp mà chưa học;
  - có thêm "Học tất cả" khi còn từ 2 kỹ năng trở lên;
  - học bằng `AddMagic(mã, 1)`, sau đó nâng cấp bằng điểm kỹ năng.
- **An toàn khi server còn ptfix cũ:** nếu chưa có dòng kỹ năng, `AddMagic` trả về 0 nhưng vẫn chiếm một ô. Script gọi `DelMagic` để dọn ô đó và báo "Máy chủ chưa có dữ liệu kỹ năng triệu hồi".
- **Nguồn sinh:** `scratchpad\skill180\mktrieuhoi.py`, có thêm tham số đường dẫn để xuất bản thử.

### 2.4 Web admin
- **`PhongThan-Admin.ps1`:**
  - thêm danh sách `$PetSkills` (mã, cấp yêu cầu, tên) với thuộc tính `pet = 1`, `req`, `style = 4`, `max = 10`;
  - đưa 12 mã vào `$RebirthByProf[2]`, tức danh sách cho phép của lệnh `skills` khi phái = 2;
  - lệnh "level" giữ lại thêm kỹ năng 450–461 khi đổi cấp.
- **Sửa kèm (cùng khối danh sách kỹ năng):**
  - tên kỹ năng chuyển sinh trước đây là chữ UTF-8 trong file không BOM, nên Windows PowerShell 5.1 hiển thị lỗi font ("Huyáº¿t…");
  - nay tên kỹ năng chuyển sinh và đệ tử đều viết dạng `\uXXXX` rồi `[regex]::Unescape`;
  - lý do: byte UTF-8 của chữ "ố" (E1 BB **91**) bị PowerShell 5.1 đọc thành dấu nháy ‘, làm vỡ chuỗi.
- **`index.html`:**
  - nhóm "Kỹ năng đệ tử (triệu hồi)" ở cuối danh sách Dị Nhân, xếp theo cấp;
  - mỗi dòng hiện "Triệu hồi · cần cấp X · mã Y".

### 2.5 Giới hạn và việc còn lại
- **C++ (chưa sửa, ngoài phạm vi):**
  - `KSkills.cpp`, `KSkill::Cast` đặt `m_Skills[4].SkillId = 1574 + Attrib - 2152`, cho kết quả âm với các mẫu 359–2032;
  - `ProcessAIType11` gọi `SetActiveSkill(4)` nhưng thất bại, nên đệ tử gọi bằng kỹ năng không tấn công;
  - bản vá đề xuất: `scratchpad\petskill\KSkills_pet_slot4.patch` (chỉ ghi đè khi `Attrib >= 2152`).
- **Bảng kỹ năng client (`ui_yiren`):**
  - có 2 trang × 9 ô; trang 2 ghi sẵn nhãn 9 kỹ năng 450–458;
  - ô được lấp theo thứ tự học, nên nhãn chỉ khớp khi học theo thứ tự 450→458 và chưa có kỹ năng chuyển sinh;
  - 459–461 không có ô trong bảng, nhưng vẫn chọn được ở ô kỹ năng chuột.
- **Hai đường gọi đệ tử độc lập:** đệ tử gọi bằng kỹ năng (`m_nPetIdx`) và đệ tử gọi bằng lệnh bài (task 1941) không thay thế nhau. Có thể đứng cùng lúc 2 con.

### 2.6 Kiểm tra
- **Build thử** `ptfix_test.pak` (Server, đủ 4 plug-in):
  - log `petskill: added [450..461] rows=1616`;
  - `skills.txt` 1617 dòng (bản đang cài 1605), 1604 dòng đầu giống hệt bản đang cài;
  - 12 dòng mới đủ 99/99 cột, có `pt_summon_lvl.lua`.
  - Bản build Client cho kết quả giống hệt.
- **Mô phỏng Lua 4** (`qtest\sim_petskill.lua`, kết quả ở `out_petskill.txt`):
  - script cấp: `skill_cost_v` 29 → `29,0,0`, 250 cấp 10 → `250,0,0`;
  - cấp 60: menu học có 6 kỹ năng và dòng "Học tất cả"; học 455; học lại thì bỏ qua; 456 bị chặn vì thiếu cấp; "Học tất cả" học thêm 5; hết thì báo "Không còn…";
  - sai phái: không làm gì;
  - ptfix cũ: `AddMagic` trả về 0 → gọi `DelMagic` → báo lỗi, không còn ô rác;
  - gọi đệ tử bằng lệnh bài vẫn chạy.
- **Cú pháp:** `PhongThan-Admin.ps1` 0 lỗi (`ParseFile`, đọc như PowerShell 5.1); JavaScript của `index.html` qua `node --check`.

## Phần 3: Hành động
- [ ] Điều phối viên build và cài ptfix mới (có `extra_petskill.py`), rồi tắt/mở lại server, thoát/vào lại game.
- [ ] Mở lại web admin (người dùng tự mở).
- [ ] Web admin → "Bí kíp / Kỹ năng" → phái Dị Nhân: thấy nhóm "Kỹ năng đệ tử (triệu hồi)" với 12 dòng → tích chọn → dạy.
- [ ] Trong game, Dị Nhân click phải Lệnh Bài Triệu Hồi → "Học kỹ năng triệu hồi" → học → mở ô kỹ năng chuột thấy icon.
- [ ] Gán kỹ năng vào chuột phải → bấm: tốn nội lực, hiện đệ tử tên `[1]Lực Sĩ tế`, hồi chiêu 15 giây.
- [ ] Sau khi áp bản vá C++ 2.5: đệ tử gọi bằng kỹ năng phải tự đánh quái.

## Phần 4: Tài liệu tham khảo
- **Mã nguồn:**
  - `KSkills.cpp`: `CanCastSkill` 138, `Cast` style 4 khoảng 480, `GetInfoFromTabFile` 2210, `LoadSkillLevelData` 2332;
  - `KSkillList.cpp`: `Add` 391, Left/Right sort list 669–800;
  - `UiSkills.cpp`: bảng kỹ năng;
  - `KNpcAI.cpp`: `ProcessAIType11` 1640;
  - `ScriptFuns.cpp`: `LuaAddMagic` 3533, `LuaDelMagic` 3579.
- **Plug-in:** `scratchpad\ptfix\extra_petskill.py`.
- **Generator:** `scratchpad\skill180\mktrieuhoi.py`.
- **Kiểm thử:** `scratchpad\qtest\sim_petskill.lua`.
- **Tài liệu liên quan:** `ky-nang-chuyen-sinh-60-120-180-phong-than-20261001.md`, `web-admin-quan-tri-phong-than-20260928.md`.
