# Đệ tử triệu hồi của Dị Nhân (Lực Sĩ tế … Huyền Ảnh Tán Hoa)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-01
> Trạng thái: **Đã làm bằng Lua** (người dùng chọn "Lua: vật phẩm triệu hồi").
> - Script đã đăng ký nóng lúc 13:55.
> - Vật phẩm Lệnh Bài Triệu Hồi (magicscript 61003) nằm trong **ptfix v11**, cần khởi động lại để cài.

## Phần 1: Tổng quan
- **Triệu chứng:** web admin không có kỹ năng đệ tử của Dị Nhân.
- **Nguyên nhân (kiểm chứng):**
  - VNG không để 12 kỹ năng gọi đệ tử trong `skills.txt` mà trong bảng riêng `\settings\summonskill.txt` (có trong vng00/serverlist/settings.pak). Bảng gồm: id 450–461, tên, `summonnpcid`, mana, icon, mô tả.
  - Engine này **không đọc** bảng đó (không có mã nào tham chiếu tới).
  - Mọi bản `skills.txt` (server và client) đều không có dòng 450–458. Giao diện trang 2 của Dị Nhân có ô nhưng không có kỹ năng nào để gắn vào.
  - Kỹ năng 1551 "Triệu hồi" chỉ kéo con thú đang có về bên cạnh (`magic_move_creature_b`).
  - Kiểu kỹ năng tạo thú của engine (`SKILL_SS_CreateNpc`) gán đòn đánh cho thú bằng mã `1574 + mẫu − 2152`. Với các mẫu 359–407 kết quả ra số âm, dùng có nguy cơ sập server.
- **Cách làm:** dùng vật phẩm **Lệnh Bài Triệu Hồi**, gọi đệ tử bằng các hàm có sẵn của engine:
  - `AddTotemNpc`: đặt chủ là người chơi và bật **AI 11**, tức AI thú cưng. Đệ tử đi theo chủ, đánh mục tiêu của chủ, và bị engine xóa khi chủ chết hoặc đổi bản đồ.
  - `SetNpcOwner(npc, tên, 0)`: chép sát thương, phòng thủ, tốc độ và sinh lực tối đa của chủ sang đệ tử.
  - `SetNpcCurCamp`: cho đệ tử cùng phe với chủ.

## Phần 2: Chi tiết
| Mã VNG | Đệ tử | Mẫu NPC | Cấp gọi |
|---|---|---|---|
| 450 | Lực Sĩ tế | 359 | 5 |
| 451 | Trường Cung tế | 360 | 15 |
| 452 | Thiên Vũ tế | 361 | 25 |
| 453 | Liên Nỗ tế | 362 | 35 |
| 454 | Hỏa Lôi tế | 403 | 45 |
| 455 | Toái Cốt tế | 404 | 55 |
| 456 | Lưu Tinh tế | 405 | 65 |
| 457 | Truy Hồn tế | 406 | 75 |
| 458 | Phong Quyển Tàn Vân | 407 | 85 |
| 459 | Cuồng Đào tế | 1345 | 95 |
| 460 | Ngự Sậu Bạo Phong | 1346 | 105 |
| 461 | Huyền Ảnh Tán Hoa | 2032 | 120 |

- Cấp gọi lấy theo sách kỹ năng VNG (`skillbook.txt`: "Sách kỹ năng dị nhân cấp N"). Ba con 459–461 không có sách nên tự đặt mốc 95/105/120.
- **Script:** `Server\script\phongthan\item\trieuhoi_lenhbai.lua`, sinh từ `scratchpad\skill180\mktrieuhoi.py`.
  - Menu chỉ hiện các đệ tử đủ cấp, kèm "Gọi đệ tử về bên cạnh", "Thu hồi đệ tử" và "Đóng".
  - Task 1941 lưu chỉ số NPC của đệ tử, task 1942 lưu mẫu NPC.
  - Trước khi xóa con cũ, script kiểm tra cả chủ lẫn mẫu NPC, để không xóa nhầm một NPC khác đã dùng lại cùng chỉ số.
- **Vật phẩm:** magicscript 61003, sao từ mẫu lệnh bài; vĩnh viễn, không mất khi dùng, không giao dịch được. Thêm trong `build_ptfix.py` (danh sách `TOKENS`, backup `.v10`). ptfix **v11**: 390 mục, hash 29E18868…, đặt ở `AdminWeb\pending\ptfix.pak`. Bản này gồm cả nội dung v9 (kỹ năng chuyển sinh) và v10 (giá sửa đồ).
- **Web admin:**
  - Mã vật phẩm `SummonToken`.
  - Tab "Bí kíp / Kỹ năng": khi chọn phái Dị Nhân thì hiện khung "Đệ tử triệu hồi" với nút "Phát Lệnh Bài Triệu Hồi".
- **Kiểm tra:**
  - Mô phỏng Lua 4:
    - sai phái: từ chối;
    - cấp 60: hiện 6 đệ tử;
    - gọi Lực Sĩ tế rồi gọi Toái Cốt tế: xóa đúng con cũ;
    - gọi về: đặt vị trí cạnh chủ;
    - thu hồi lần 2: báo "chưa gọi đệ tử".
  - `PhongThan-Admin.ps1`: 0 lỗi cú pháp; `node --check` cho JavaScript của `index.html`: đạt.
- **Giới hạn:**
  - Đệ tử không hiện trong cửa sổ kỹ năng.
  - Sau khi đổi bản đồ hoặc tử vong phải dùng lệnh bài gọi lại.
  - Chưa trừ mana khi gọi.
  - Tên đệ tử hiện bằng tiếng Việt qua `SetNpcName`.
  - Muốn làm kỹ năng thật thì cần sửa C++ (`KSkills.cpp`, đoạn tính `skillidpet`) và thêm dòng 450–461 vào `skills.txt`.

### 2.1 Báo lỗi "click Trường Cung tế không có hành vi gì" (20:27)
- Bridge kiểm tra EmlaAi1: Dị Nhân **cấp 10**, task 1941 = 13425 là Lực Sĩ tế còn sống, chủ là EmlaAi1, sinh lực 523. Nghĩa là lệnh gọi đệ tử chạy đúng.
- Trường Cung tế cần cấp 15 nên không có trong menu. Ô "Trường Cung tế" trong cửa sổ kỹ năng chỉ là nhãn giao diện, không gắn kỹ năng nào.
- Sửa (bản 2): menu hiện đủ 12 đệ tử; con chưa đủ cấp ghi "(cần cấp N)", bấm vào sẽ báo bằng hộp thoại.
- Ghi nhận thêm: khi chủ sang bản đồ khác, đệ tử nằm lại bản đồ cũ (khu vực không còn người chơi nên AI không chạy để tự xóa). Lần gọi tiếp theo sẽ xóa con cũ.
- **Kỹ Năng Quyển (Dị Nhân)** (5626) trước đây là bản khóa BLOCKED_SPEC. Nay dạy đủ kỹ năng phái 43–51 còn thiếu và tặng Lệnh Bài Triệu Hồi.

### 2.2 "Dị Nhân đánh nhưng đệ tử không đánh" (20:40)
- **Nguyên nhân (kiểm chứng `KNpcAI.cpp` 1640–1720):** AI thú cưng (AI 11) chỉ chọn mục tiêu theo ba cách:
  - kẻ vừa đánh trúng chủ (`m_nLastDamageIdx` của chủ);
  - kẻ vừa đánh trúng đệ tử;
  - `m_nPeopleIdx` của chủ.
- Phía server, `m_nPeopleIdx` chỉ được gán cho **nạn nhân** khi bị đánh (`KNpc.cpp` 4319), không gán khi người chơi ra đòn. Khi Dị Nhân đánh xa và quái chưa chạm tới ai, đệ tử không có mục tiêu nên đứng yên.
- Mẫu NPC không có lỗi: ô kỹ năng 4 có sẵn đòn đánh, ví dụ 63 "npc tấn công vật lý", 141, 142…
- **Sửa C++** (`KNpcAI.cpp`, `ProcessAIType11`): khi không có mục tiêu thì lấy `GetNearestNpc(relation_enemy)`, tức kẻ địch gần nhất, giống AI của quái thường. Backup ở `_backup\20261001-repairall\KNpcAI.cpp.orig`. **Cần build lại CoreServer bằng VC6**, chung đợt với `RepairAllEquip` và vòng sáng set đồ.
- Trước khi có bản build: đệ tử chỉ đánh khi quái đã tấn công chủ hoặc đệ tử (quái chủ động thấy đệ tử sẽ lao vào, và lúc đó đệ tử đánh trả).

## Phần 3: Hành động
- [ ] Tắt server, thoát game, đóng web admin, chạy `PhongThan-ChayTatCa.cmd game` để cài ptfix v11.
- [ ] Web admin → "Bí kíp / Kỹ năng" → chọn Dị Nhân → "Phát Lệnh Bài Triệu Hồi" → click phải trong game → chọn đệ tử.

## Phần 4: Tài liệu tham khảo
- `KSkills.cpp` 480–560 (`SKILL_SS_CreateNpc`), `KNpcAI.cpp` 1640 (`ProcessAIType11`), `PhongThanLuaWave7.h` 294 (`LuaAddTotemNpcCompat`), `ScriptFuns.cpp` 4775 (`LuaSetNpcOwner`).
- `scratchpad\skill180\summon_tbl_vng00.pak.txt` (bản sao `summonskill.txt`).

## Bổ sung 2026-10-02: đệ tử không đánh khi chủ đánh (sửa C++)
- **Nguyên nhân 1:** AI đệ tử kéo nó về cạnh chủ khi cách quá 250, và làm vậy ở mỗi lượt AI. Chủ Dị Nhân đánh từ xa, nên đệ tử vừa chạy tới quái đã bị kéo về, không bao giờ ra đòn.
- **Nguyên nhân 2:** server không lưu mục tiêu của chủ cho đệ tử. Đệ tử triệu hồi bằng lệnh bài còn giữ phe theo mẫu NPC, có thể trùng phe quái.
- **Sửa:**
  - chỉ kéo đệ tử về khi cách chủ hơn 900, hoặc khi không có mục tiêu;
  - đệ tử đánh đúng mục tiêu chủ đang dùng kỹ năng nhắm vào, nếu không có thì đánh quái gần nhất (trong vòng 1000 quanh chủ);
  - đệ tử từ lệnh bài nhận phe của chủ.
- **Tệp:** Core\Src\KNpcAI.cpp, Core\Src\PhongThanLuaWave7.h (backup _backup\20261002-petai\). CoreServer build 0 lỗi.
- **Kiểm tra:**
  - [ ] Tắt server → triển khai → mở server.
  - [ ] Gọi đệ tử, click chọn quái rồi đánh bằng kỹ năng: đệ tử chạy tới đánh cùng con đó.
  - [ ] Đứng yên khi có quái gần: đệ tử tự đánh.
## Bổ sung 2026-10-02 (lần 2): nguyên nhân gốc là dữ liệu kỹ năng
- Engine đọc cột Skill1..4 của Npcs.txt dưới dạng **số** (toi). 12 mẫu đệ tử lại ghi **tên** kỹ năng kiểu VNG (#npc tấn công vật lý, #arrow hỏa 2...), nên đọc ra 0 và đệ tử không có kỹ năng nào để đánh. Một số mẫu còn có cấp kỹ năng 0.
- **Đã sửa:** đổi sang mã số theo skills.txt. Cả 4 ô dùng kỹ năng chính, cấp ≥ 1.

| Mẫu | Kỹ năng | Mẫu | Kỹ năng |
|---|---|---|---|
| 359 Lực Sĩ | 63 | 405 Lưu Tinh | 144 |
| 360 Trường Cung | 141 | 406 Truy Hồn | 140 |
| 361 Thiên Vũ | 139 | 407 Phong Quyển | 145 |
| 362 Liên Nỗ | 132 | 1345 Cuồng Đào | 388 |
| 403 Hỏa Lôi | 142 | 1346 Ngũ Sấu Bạo Phong | 297 |
| 404 Toái Cốt | 143 | 2032 Huyễn Ảnh Tán Hoa | 1996 |

- **Tệp:** Server và Client\settings\phongthan\Npcs.txt (hai file vẫn giống nhau), backup _backup\20261002-petskill\.
- **Cần khởi động lại server và client** để nạp lại Npcs.txt.