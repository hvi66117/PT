# Đệ tử Dị Nhân có kinh nghiệm và cấp riêng (petexp)

Ngày: 2026-10-03. Yêu cầu: "Quái chết đệ tử chưa tăng kinh nghiệm và lên level". Người dùng chọn phương án **đệ tử có kinh nghiệm riêng**, không trừ kinh nghiệm của chủ.

> **Cập nhật 2026-10-04 (pet10):** cấp đệ tử nay là 1–10 và chỉ số là của riêng đệ tử. Xem mục "Thiết kế lại cấp 1–10 theo VNG" ngay dưới. Các mục 2.1, 2.2, 2.3 (phần đệ tử kỹ năng) và 2.5 bên dưới là thiết kế cũ ngày 2026-10-03, chỉ giữ để tra cứu.

## Thiết kế lại cấp 1–10 theo VNG (2026-10-04, pet10)

Yêu cầu nguyên văn: "đệ tử chỉ tối đa cấp 10, có kỹ năng độc lập và có chỉ số như VNG".

### A. Dữ liệu VNG tìm được

Đã quét nội dung mọi entry văn bản trong 19 PAK của `Server\data` (bỏ `spr`, `maps`, `sound`, `font`). Từ khóa: 召唤兽, 召唤, 宠物, 灵兽, 宝宝, summon, zhaohuan, beast, pet, cùng các cụm TCVN3 "triệu hồi", "đệ tử", "thú cưng". Script quét: `scratchpad\pet10\scan.py`. Kết quả nằm ở `scan_*.txt` và `hits\`.

| Dữ liệu | Nguồn (PAK, id entry) | Dùng vào việc gì |
|---|---|---|
| `settings\summonskill.txt`: 450–461, mẫu NPC, mana; `adddamagescale` = 1, `scaleparam` = 512, `maxcorpse` = 6 | `vng00.pak` 27955344 (bản rút gọn ở `settings.pak`) | Mẫu NPC của từng đệ. Hệ số cấp: 512/1024 = +50% mỗi cấp (**suy luận**) |
| `Npcs.txt` dòng 359–362, 403–407, 1345, 1346, 2032: cột Life/AR/Defense/Min-MaxDamage Param1, Param2, kỹ năng | `vng00.pak` 38ebcb17. Trùng từng số với `settings\phongthan\Npcs.txt` | Chỉ số gốc của đệ |
| `standard.lua`: giá trị = Param1 + Param2 × cấp NPC | `\script\npclevelscript\standard.lua` | Công thức chỉ số theo cấp NPC |
| `skills.txt`: kỹ năng NPC 141, 139, 132, 142, 143, 144, 140, 145, 388, 297, 1996 đều `MaxLevel` = 10; script cấp `arrow*.lua`, `狂涛祭.lua`, `暴雨梨花.lua` | `vng00.pak` ec1243ff; script trong `serverlist.pak` | Kỹ năng riêng của từng đệ, cấp 1–10 |
| Mã gốc `KSkills.cpp` `SKILL_SS_CreateNpc` | Mã nguồn engine | Cấp kỹ năng ô 4 của đệ = cấp kỹ năng triệu hồi. VNG coi **cấp đệ = cấp kỹ năng triệu hồi (1–10)** |
| `magic_summon_beast_inherit_player_v`: "Tỷ lệ X% thuộc tính thú triệu hồi từ người chơi"; `magic_bless_summon_p`; `magic_reduce_summon_damage_v` | `vng00.pak` 93f6768d (magicdesc), `KMagicAttribRegistry.inc` | Chứng tỏ bản VNG về sau cho thú triệu hồi thừa hưởng một phần chỉ số chủ qua trang bị. Lần này không dùng |
| Trang kỹ năng 召唤兽 của Dị Nhân | `ui.pak` ca5aa31c | Chỉ là giao diện |

**Không tìm thấy** trong VNG: bảng cấp/kinh nghiệm thú triệu hồi, bảng chỉ số theo cấp, script thú triệu hồi riêng. Ở VNG, đệ lên cấp bằng điểm kỹ năng. `settings\pet.ini` (`vng00.pak` 7a25a1ee) là tiểu đệ nhặt đồ. Các item "Nội đơn - Lực Sĩ Tế…" (3/536–544) thuộc hệ Linh Thú khác. Cả hai không liên quan.

Mã gốc của VNG gọi đệ ở cấp NPC bằng cấp chủ, rồi cộng thêm máu tối đa, chính xác, phòng thủ của chủ và chép sát thương của chủ. Đó chính là cái "chép chỉ số chủ" mà người dùng không muốn. Vì vậy bảng dưới đây là **bảng suy ra** từ dữ liệu VNG ở trên, không phải bảng VNG có sẵn.

### B. Công thức (dùng chung cho đệ Lệnh Bài và đệ kỹ năng)

| Mục | Công thức | Nguồn |
|---|---|---|
| Cấp đệ | 1–10. Đệ Lệnh Bài: task 2505. Đệ kỹ năng: cấp kỹ năng 450–461 | VNG `MaxLevel` 10 |
| Cấp NPC E | cấp học kỹ năng (5, 15, 25, 35, 45, 55, 65, 75, 85, 95, 105, 120) + 5 × (cấp đệ − 1) | Suy luận: cấp 1 bằng cấp mở khóa, cấp 10 thêm 45 cấp |
| Sinh lực | (LifeParam1 + LifeParam2 × E) × (100 + 50 × (cấp − 1)) % | Npcs.txt VNG + hệ số `scaleparam` |
| Chính xác, né tránh | Param1 + Param2 × E | Npcs.txt VNG |
| Sát thương gốc | MinDamageParam1 × (100 + 50 × (cấp − 1)) % | Npcs.txt VNG + hệ số `scaleparam` |
| Kỹ năng | Kỹ năng riêng của mẫu, cấp = cấp đệ, đặt ở ô 1–4 (Lệnh Bài) hoặc ô 4 (đệ kỹ năng) | VNG skills.txt |
| Tốc độ đánh, kháng | Theo mẫu Npcs.txt | VNG |
| Tốc độ chạy | Đệ Lệnh Bài: theo mẫu (8). Đệ kỹ năng: theo chủ, để kịp đi theo | Mã gốc VNG |
| Kinh nghiệm (chỉ đệ Lệnh Bài) | Mỗi quái được số kinh nghiệm bằng cấp quái. Cần `200 × cấp × (cấp + 1)` để lên cấp: 400, 1.200, 2.400, 4.000, 6.000, 8.400, 11.200, 14.400, 18.000 (tổng 66.000) | Tự đặt, vì VNG không có bảng |
| Chuyển dữ liệu cũ | task 2505 > 10 thì về 10 và task 2506 về 0. Áp khi lệnh bài hoặc hook giết quái đọc cấp | — |

Bỏ khỏi thiết kế cũ: giới hạn theo cấp chủ, nhân 4 khi đuổi cấp, chia 4 với quái xám, máu theo % máu chủ, và `SetNpcOwner` (hàm chép chỉ số chủ). `AddTotemNpc` vốn đã tự đặt chủ, phe và AI 11. Đệ kỹ năng không còn cộng kinh nghiệm vào task 2505.

### C. Bảng cấp 1 / 5 / 10

So sánh với Huyễn Linh (mẫu 47, bản đồ 1047, nơi KyUc1Thoi cấp 55 đang luyện): sinh lực 7.350, chính xác 222, né tránh 128, sát thương 218–235, kháng nguyên tố 40%, kháng vật lý 0%. Cột "ST/đòn" là ước lượng sát thương mỗi mũi sau kháng. Cột cuối là số đòn trúng Huyễn Linh cần để hạ đệ (226 mỗi đòn).

| Đệ (kỹ năng) | Cấp | Cấp NPC | Sinh lực | Chính xác | Né tránh | Sát thương gốc | Kỹ năng NPC (cấp = cấp đệ) | ST/đòn vào Huyễn Linh | Số đòn hạ Huyễn Linh | Huyễn Linh cần đánh trúng |
|---|---|---|---|---|---|---|---|---|---|---|
| Lực Sĩ tế (450) | 1 | 5 | 70 | 40 | 35 | 10 | đánh thường (kỹ năng 63) | 10 | 735 | 1 |
| Lực Sĩ tế (450) | 5 | 25 | 810 | 40 | 135 | 30 | đánh thường (kỹ năng 63) | 30 | 245 | 4 |
| Lực Sĩ tế (450) | 10 | 50 | 2860 | 40 | 260 | 55 | đánh thường (kỹ năng 63) | 55 | 134 | 13 |
| Trường Cung tế (451) | 1 | 15 | 200 | 210 | 95 | 20 | vật lý +25% (kỹ năng 141) | 25 | 294 | 1 |
| Trường Cung tế (451) | 5 | 35 | 1200 | 410 | 195 | 60 | vật lý +45% (kỹ năng 141) | 87 | 85 | 6 |
| Trường Cung tế (451) | 10 | 60 | 3575 | 660 | 320 | 110 | vật lý +70% (kỹ năng 141) | 187 | 40 | 16 |
| Thiên Vũ tế (452) | 1 | 25 | 330 | 350 | 155 | 30 | vật lý +46% (kỹ năng 139) | 43 | 171 | 2 |
| Thiên Vũ tế (452) | 5 | 45 | 1590 | 550 | 255 | 90 | vật lý +70% (kỹ năng 139) | 153 | 49 | 8 |
| Thiên Vũ tế (452) | 10 | 70 | 4290 | 800 | 380 | 165 | vật lý +100% (kỹ năng 139) | 330 | 23 | 19 |
| Liên Nỗ tế (453) | 1 | 35 | 450 | 550 | 400 | 40 | vật lý 33–66, 3 mũi (kỹ năng 132) | 49 | 150 | 2 |
| Liên Nỗ tế (453) | 5 | 55 | 1950 | 750 | 600 | 120 | vật lý 45–90, 5 mũi (kỹ năng 132) | 67 | 110 | 9 |
| Liên Nỗ tế (453) | 10 | 80 | 4950 | 1000 | 850 | 220 | vật lý 60–120, 8 mũi (kỹ năng 132) | 90 | 82 | 22 |
| Hỏa Lôi tế (454) | 1 | 45 | 825 | 1425 | 530 | 50 | hỏa 220–330, 2 mũi (kỹ năng 142) | 165 | 45 | 4 |
| Hỏa Lôi tế (454) | 5 | 65 | 3375 | 1925 | 730 | 150 | hỏa 300–450, 6 mũi (kỹ năng 142) | 225 | 33 | 15 |
| Hỏa Lôi tế (454) | 10 | 90 | 8250 | 2550 | 980 | 275 | hỏa 400–600, 11 mũi (kỹ năng 142) | 300 | 25 | 37 |
| Toái Cốt tế (455) | 1 | 55 | 1025 | 2050 | 650 | 60 | lôi 110–240 (kỹ năng 143) | 105 | 70 | 5 |
| Toái Cốt tế (455) | 5 | 75 | 3975 | 2650 | 850 | 180 | lôi 150–400 (kỹ năng 143) | 165 | 45 | 18 |
| Toái Cốt tế (455) | 10 | 100 | 9350 | 3400 | 1100 | 330 | lôi 200–600 (kỹ năng 143) | 240 | 31 | 42 |
| Lưu Tinh tế (456) | 1 | 65 | 1225 | 2775 | 1125 | 70 | vật lý +60% (kỹ năng 144) | 112 | 66 | 6 |
| Lưu Tinh tế (456) | 5 | 85 | 4575 | 3475 | 1425 | 210 | vật lý +100% (kỹ năng 144) | 420 | 18 | 21 |
| Lưu Tinh tế (456) | 10 | 110 | 10450 | 4350 | 1800 | 385 | vật lý +150% (kỹ năng 144) | 962 | 8 | 47 |
| Truy Hồn tế (457) | 1 | 75 | 1425 | 3600 | 1325 | 80 | vật lý 260–420 (kỹ năng 140) | 340 | 22 | 7 |
| Truy Hồn tế (457) | 5 | 95 | 5175 | 4400 | 1625 | 240 | vật lý 300–500 (kỹ năng 140) | 400 | 19 | 23 |
| Truy Hồn tế (457) | 10 | 120 | 11550 | 5400 | 2000 | 440 | vật lý 350–600 (kỹ năng 140) | 475 | 16 | 52 |
| Phong Quyển Tàn Vân (458) | 1 | 85 | 1625 | 4525 | 1525 | 90 | vật lý +60%, 5 mũi (kỹ năng 145) | 144 | 52 | 8 |
| Phong Quyển Tàn Vân (458) | 5 | 105 | 5775 | 5425 | 1825 | 270 | vật lý +100%, 7 mũi (kỹ năng 145) | 540 | 14 | 26 |
| Phong Quyển Tàn Vân (458) | 10 | 130 | 12650 | 6550 | 2200 | 495 | vật lý +150%, 10 mũi (kỹ năng 145) | 1237 | 6 | 56 |
| Cuồng Đào tế (459) | 1 | 95 | 2300 | 5075 | 1675 | 90 | vật lý +180% (kỹ năng 388) | 252 | 30 | 11 |
| Cuồng Đào tế (459) | 5 | 115 | 8100 | 5975 | 1975 | 270 | vật lý +300% (kỹ năng 388) | 1080 | 7 | 36 |
| Cuồng Đào tế (459) | 10 | 140 | 17600 | 7100 | 2350 | 495 | vật lý +450% (kỹ năng 388) | 2722 | 3 | 78 |
| Ngự Sậu Bạo Phong (460) | 1 | 105 | 4050 | 7500 | 3025 | 100 | vật lý +80%, 31 mũi (kỹ năng 297) | 180 | 41 | 18 |
| Ngự Sậu Bạo Phong (460) | 5 | 125 | 13950 | 8700 | 3525 | 300 | vật lý +160%, 43 mũi (kỹ năng 297) | 780 | 10 | 62 |
| Ngự Sậu Bạo Phong (460) | 10 | 150 | 29700 | 10200 | 4150 | 550 | vật lý +260%, 58 mũi (kỹ năng 297) | 1980 | 4 | 132 |
| Huyền Ảnh Tán Hoa (461) | 1 | 120 | 7600 | 9200 | 4000 | 1000 | kỹ năng 1996 (thiếu script cấp) (kỹ năng 1996) | 1000 | 8 | 34 |
| Huyền Ảnh Tán Hoa (461) | 5 | 140 | 24600 | 10400 | 4500 | 3000 | kỹ năng 1996 (thiếu script cấp) (kỹ năng 1996) | 3000 | 3 | 109 |
| Huyền Ảnh Tán Hoa (461) | 10 | 165 | 49225 | 11900 | 5125 | 5500 | kỹ năng 1996 (thiếu script cấp) (kỹ năng 1996) | 5500 | 2 | 218 |

Nhận định ở cấp nhân vật 55 (dùng được tới Toái Cốt tế):

- Toái Cốt tế cấp 10: chịu khoảng 42 đòn trúng của Huyễn Linh. Né tránh 1.100 so với chính xác 222 của quái, nên quái trượt nhiều. Đệ cần khoảng 31 đòn để hạ một con.
- Hỏa Lôi tế cấp 10: mỗi lần bắn 11 mũi hỏa, mỗi mũi khoảng 300 sau kháng.
- Đệ đánh được và đỡ đòn tốt, nhưng yếu hơn hẳn đệ cũ (đệ cũ chép chủ, sinh lực khoảng 98.000).
- Lực Sĩ tế, Trường Cung tế là đệ cấp thấp nên yếu ở cấp 55. Đó là đúng thứ bậc của VNG.
- Kỹ năng 1996 (Huyền Ảnh) thiếu script cấp trong PAK, nên sát thương chỉ tính theo sát thương gốc.

### D. File đã sửa

| File | Thay đổi |
|---|---|
| `scratchpad\skill180\mktrieuhoi.py` | Đọc chỉ số mẫu từ Npcs.txt (`PET_STAT`). Thư viện mới: `PTPE_NpcLevel`, `PTPE_Base`, `PTPE_Stats`, `PTPE_ScalePct`; `PTPE_Apply` đặt `SetNpcLife/AR/Defense/Damage` + `SetNpcSkill`; kinh nghiệm cấp 1–10. `PTTH_Summon` gọi `AddTotemNpc` ở cấp E và không gọi `SetNpcOwner` nữa (chỉ gọi khi thiếu thư viện, như cũ) |
| `Server\script\phongthan\lib\petexp_lib.lua`, `...\item\trieuhoi_lenhbai.lua` | Sinh lại từ generator. **Đã áp nóng** |
| `PhongThanSource\Sources\Core\Src\KSkills.cpp` (`SKILL_SS_CreateNpc`, dấu `pet10`) | 12 mẫu Dị Nhân: cấp NPC = E theo cấp kỹ năng (kẹp 1–10); sinh lực và sát thương gốc nhân hệ số; bỏ cộng chỉ số chủ, chỉ giữ phe, ngũ hành và tốc độ chạy. Tên và kỹ năng ô 4 theo cấp đệ. Mẫu khác giữ nguyên luật cũ. **Đã build, chưa triển khai** |
| `npc_quests\normal.lua` | Không đổi. Được nạp lại để Include thư viện mới |

Giữ nguyên các bản vá: `petfight`, `PhongThanPetTargetOk`, `petrange`, `petdebug`, `petdebug2`, `onepet`, `weaponequip`, `noexppenalty`, `desertexp`, `m_bCanStack`. Giữ tên `"[cấp]" .. GetName()` và `DelPet()`.

### E. Kiểm thử và áp nóng

- `sim_petexp.lua` (viết lại cho pet10, 51 kiểm tra): `-Stack 100`, `emu`, `live`, `emu,live` đều FAILS=0. Khoảng trống stack nhỏ nhất 46 khung.
- `sim_petmorph_pe.lua` (22 kiểm tra), thường và `live`: FAILS=0. `sim_petskill_pe.lua`: không có ERR.
- 3 kiểm tra tên cũ (`[1]Luc Si te`, `[31]…`, `no lib`) đã đổi theo tên chủ: `[1]EmLaAi`, `[6]EmLaAi`, và khi thiếu thư viện thì `EmLaAi` + `SetNpcOwner`.
- Áp nóng qua `admin_bridge\pending.lua`: `ReLoadScript` cho thư viện, lệnh bài và `normal.lua`. Kết quả: `result.log` 15:10:01 dòng `pet10 OK`, có đủ native `SetNpcAR`, `SetNpcDefense`, `SetNpcDamage`, `SetNpcLife`. Lúc đó không có nhân vật Dị Nhân online, nên task 2505 = 55 của KyUc1Thoi sẽ về 10 khi nhân vật này mở lệnh bài hoặc giết quái cùng đệ.

### F. Người dùng cần làm

- [ ] Mở Lệnh Bài Triệu Hồi. Dòng xanh phải là "Đệ tử cấp 10 (cấp tối đa)" (cấp 55 cũ đã về 10).
- [ ] Thu hồi đệ đang đứng ngoài (nếu có) rồi gọi lại. Tên `[10]KyUc1Thoi`, sinh lực theo bảng trên (Toái Cốt tế cấp 10: 9.350).
- [ ] Đệ kỹ năng 450–461 chỉ đổi sau khi triển khai CoreServer mới (coordinator triển khai, rồi khởi động lại GameServer).

## Phần 1: Tổng quan

- Mỗi quái thường chết do chủ hoặc đệ tử hạ, nếu đệ tử đang được gọi ra và ở gần, thì đệ tử nhận kinh nghiệm riêng. Kinh nghiệm của chủ giữ nguyên.
- Kinh nghiệm và cấp của đệ tử lưu theo nhân vật: **task 2505 = cấp**, **task 2506 = kinh nghiệm trong cấp hiện tại**. Đăng xuất hay khởi động lại máy chủ vẫn giữ.
- Một cặp task dùng chung cho cả 12 loại đệ tử. Lý do:
  - Người chơi nuôi một đệ tử; lệnh bài chỉ chọn hình thái để gọi ra.
  - Nếu tách riêng thì tốn 24 task, và đổi loại đệ tử là mất công nuôi lại từ đầu.
  - Đệ tử gọi bằng kỹ năng 450–461 cũng góp chung vào cặp task này.
- Đủ kinh nghiệm thì đệ tử lên cấp, có thông báo. Đệ tử lệnh bài đang đứng ngoài được áp cấp mới ngay: hồi đầy máu, máu tối đa và cấp kỹ năng tăng.
- Toàn bộ làm bằng Lua, áp nóng được, không cần sửa C++. `KNpcDeathCalcExp.cpp` không bị đụng tới.

## Phần 2: Chi tiết

### 2.1 Công thức

| Mục | Giá trị |
|---|---|
| Cấp ban đầu | 1 (task 2505 = 0 được đọc là cấp 1) |
| Kinh nghiệm cần để lên cấp kế | `2 × cấp × (cấp + 10)`: cấp 1 cần 22, cấp 10 cần 400, cấp 50 cần 6.000, cấp 100 cần 22.000, cấp 149 cần 47.382 |
| Kinh nghiệm mỗi quái | Bằng cấp quái (tối thiểu 1) |
| Đuổi cấp | Gấp 4 khi đệ tử thấp hơn giới hạn cấp từ 10 cấp trở lên |
| Quái xám | Chia 4 (tối thiểu 1) khi quái thấp hơn đệ tử quá 10 cấp |
| Giới hạn cấp | Không vượt cấp chủ, tối đa 150 (giống VNG: thú nuôi không vượt chủ). Khi đã bằng cấp chủ, thanh kinh nghiệm dừng ở mức đầy; chủ lên cấp thì quái kế tiếp đẩy đệ tử lên tiếp |
| Nhiều cấp một lần | Có, phần dư được chuyển sang cấp sau |

Ví dụ: chủ cấp 60, đệ tử cấp 30 đánh quái cấp 50 thì mỗi con được 200 kinh nghiệm (50 × 4).

### 2.2 Đệ tử mạnh lên theo cấp (đệ tử lệnh bài)

`SetNpcOwner(idx, tên, 0)` trong C++ (`ScriptFuns.cpp` `LuaSetNpcOwner`) sao chép từ chủ sang đệ tử: sát thương vật lý và nguyên tố, chính xác, phòng thủ, tốc độ, `m_CurrentLifeMax`, `m_CurrentManaMax`. Nó không đặt máu hiện tại, nên trước đây đệ tử ra đời với máu theo mẫu NPC chứ không đầy.

Cấp NPC truyền vào `AddTotemNpc` chỉ ảnh hưởng chỉ số mẫu (bị `SetNpcOwner` ghi đè), cấp hiển thị, và cấp kỹ năng tính từ cột `Level1..4` của mẫu. Cột này của cả 12 mẫu đều là `1`, nên kỹ năng đệ tử luôn ở cấp 1. Vì vậy cấp đệ tử phải tác động trực tiếp qua native có sẵn:

| Cách áp | Native | Công thức |
|---|---|---|
| Cấp NPC khi gọi | `AddTotemNpc(tpl, cấp đệ tử, ...)` | Thay cho `GetLevel()` của chủ |
| Máu tối đa (và hồi đầy) | `GetNpcLife(npc chủ)`, `SetNpcLife(idx, v, 1)` | Máu tối đa của chủ × (100 + cấp) %. Cấp 50 là 150%, cấp 150 là 250% |
| Cấp kỹ năng đệ tử | `SetNpcSkill(idx, kỹ năng, cấp, ô 1..4)` | `1 + cấp/15`, tối đa 10 (`MaxLevel` trong skills.txt). Kỹ năng cung của đệ tử có `physicsenhance_p = 20 + 5 × cấp`, tức từ 25% lên 70% |
| Tên | `SetNpcName` | `[cấp]Tên`, giống cách VNG đặt tên đệ tử kỹ năng `[%d]%s` |

Kỹ năng theo mẫu (Npcs.txt): 360→141, 361→139, 362→132, 403→142, 404→143, 405→144, 406→140, 407→145, 1345→388, 1346→297, 2032→1996. Mẫu 359 Lực Sĩ tế dùng 63 (đánh thường, `MaxLevel` 0) nên không đổi cấp kỹ năng, chỉ tăng máu.

Không có native đọc hay đặt sát thương nguyên tố, phòng thủ riêng cho NPC theo %, nên phần sát thương vẫn sao chép từ chủ và tăng nhờ cấp kỹ năng.

### 2.3 Khi nào được tính kinh nghiệm

- Death script quái thường: `KNpcTemplate` chuyển `\script\npcdeath\normal.lua` sang `\script\phongthan\npc_quests\normal.lua`. Trong `Npcs.txt` có 399 mẫu quái thường (Kind 0) dùng file này. 157 mẫu không có death script; trong đó 58 có kinh nghiệm, toàn là rương, boss sự kiện, totem và mẫu biến hình. Boss có death script riêng **không** cho đệ tử kinh nghiệm.
- `PlayerIndex` trong `OnDeath` là người `KNpcDeathCalcExp::CalcExp` chọn. Sát thương của đệ tử được ghi cho chủ, nên khi đệ tử hạ quái thì vẫn là chủ.
- Đệ tử lệnh bài (task 1941/1942) được tính khi: chủ đúng tên, mẫu đúng (kể cả hình 2651–2656), NPC còn sống, cùng bản đồ với chủ và cách chủ không quá 60 ô theo mỗi trục.
- Đệ tử kỹ năng 450–461: Lua không có native lấy `m_nPetIdx`. Dùng `PetGetType()`: hàm này trả mẫu NPC của đệ tử kỹ năng khi nó còn sống. Có thì được tính kinh nghiệm, nhưng không kiểm tra được khoảng cách. (Từ CoreServer engine2 có `GetSummonPetIdx()` trả chỉ số NPC của đệ này.)
- Chỉ phái Dị Nhân (`GetProfession() == 2`).

### 2.4 Lệnh bài

- Lời thoại menu chính thêm một đoạn màu xanh lá: "Đệ tử cấp N, kinh nghiệm E/Cần". Khi bằng cấp chủ có thêm "(đã bằng cấp chủ)"; ở cấp 150 là "(cấp tối đa)".
- Menu vẫn 7 dòng, không thêm dòng.
- Gọi đệ tử: "Đã gọi đệ tử: Tên (cấp N)".

### 2.5 Đệ tử từ kỹ năng 450–461

- **Kinh nghiệm: đã áp dụng.** Giết quái khi đệ tử kỹ năng còn sống thì được tính vào cùng cặp task 2505/2506.
- **Sức mạnh theo cấp: đã áp dụng trong C++ (cập nhật 2026-10-04, engine2).** Nhánh `pet10` của `KSkills.cpp` `SKILL_SS_CreateNpc` đã đặt chỉ số riêng cho 12 mẫu đệ Dị Nhân: cấp NPC = cấp học + 5 × (cấp đệ − 1), sinh lực và sát thương gốc × (100 + 50 × (cấp − 1)) %, không cộng chỉ số chủ, kỹ năng ô 1–4 cùng id theo cấp đệ. Đó cũng là bảng đệ Lệnh Bài dùng (`PTPE_Stats`), nên không cần gọi lại `PTPE_Apply` từ Lua.
- Native `GetSummonPetIdx()` đã có (engine2, `ScriptFuns.cpp`): trả chỉ số NPC của đệ kỹ năng (`Npc[người chơi].m_nPetIdx`) khi đệ còn sống, cùng chủ, còn trên bản đồ; không có thì 0. Lua dùng được để kiểm tra khoảng cách hoặc đọc chỉ số đệ. Cần CoreServer engine2 (xem `engine-gaps-phong-than-20261004.md`).

### 2.6 File và cách sinh

| File | Vai trò |
|---|---|
| `scratchpad\skill180\mktrieuhoi.py` | Generator. Sinh cả lệnh bài lẫn thư viện; không sửa tay file runtime |
| `Server\script\phongthan\lib\petexp_lib.lua` (mới) | Thư viện `PTPE_*`: cấp, công thức, kiểm tra đệ tử, áp sức mạnh, hook giết quái, dòng thông tin |
| `Server\script\phongthan\item\trieuhoi_lenhbai.lua` | Include thư viện (có bảo vệ); gọi đệ tử theo cấp đệ tử; thông tin trong lời thoại |
| `Server\script\phongthan\npc_quests\normal.lua` | Nối thêm cuối file: Include thư viện và bọc `OnDeath` gọi `PTPE_OnKill` trong `call(..., "x", ...)`. Phần trên giữ nguyên từng byte |
| `scratchpad\petexp\patch_normal.py` | Bản vá ở mức byte cho `normal.lua`, chạy lại nhiều lần không trùng (có dấu `-- 2026-10-03 petexp:`) |

An toàn khi lỗi:

- Include trong lệnh bài và trong `normal.lua` đều được bọc `call`. Nếu thiếu thư viện thì lệnh bài chạy như cũ (cấp chủ, tên thường).
- Lỗi trong hook đệ tử không làm dừng `OnDeath` gốc và hook Tứ Linh.
- Hàm nào dùng native mới cũng kiểm tra native đó có tồn tại trước khi gọi.

### 2.7 Chọn số task

- Đã quét bằng `scratchpad\petexp\taskscan.py`, bản mở rộng từ `daily3\taskscan.py`. Phạm vi quét: mọi entry văn bản của mọi PAK, `script.pak`, `ptfix.pak` đang chạy, toàn bộ `Server\script` rời, toàn bộ `Server\settings` rời và `admin_bridge`.
- Dải 2505–2509 không có `GetTask` hay `SetTask` nào. Các số 2500–2502 chỉ xuất hiện dưới dạng hằng (tỉ lệ rơi, khoảng cách, tọa độ).
- Engine giữ riêng 4800–4999, nên không dùng dải đó. Dải 1943–1950 gần task đệ tử cũ thì đã bị script liên server của VNG dùng.

## Phần 3: Hành động

### 3.1 Kiểm thử đã chạy (Lua 4, `scratchpad\qtest`)

| Mô phỏng | Kết quả |
|---|---|
| `sim_petexp.lua -Stack 100` (bản nháp và bản đã triển khai `-Args1 live`) | FAILS=0, 43 kiểm tra |
| `sim_petexp.lua -Stack 0 -Args1 emu` / `emu,live` (khoảng trống stack như engine, 47 khung) | FAILS=0, khoảng trống nhỏ nhất 46 khung, không tràn stack |
| `sim_petmorph.lua` thường và `emu` (bản gốc) | FAILS=0 |
| `sim_petskill.lua` (bản gốc) | Không có lỗi |
| `sim_petmorph_pe.lua` thường, `emu`, `live`, `emu,live` (chạy nguyên sim_petmorph trên lệnh bài mới có thư viện; chỉ đổi kiểm tra menu 17 dòng thành 7 dòng theo menu của coordinator) | FAILS=0 |
| `sim_petskill_pe.lua` (sim_petskill trên lệnh bài mới) | Không có lỗi; khác bản cũ đúng ở menu 7 dòng và "AddTotemNpc lv1 / (cấp 1)" |
| `t_qnormal.lua` (normal.lua đã triển khai) | wrapper=1 hits=1, sau lỗi vẫn chạy |

`sim_petexp` kiểm tra:

- menu 7 dòng có dòng cấp đệ tử;
- gọi ở cấp 1 và cấp 30: cấp NPC, tên, máu 101% và 130%, kỹ năng 143 cấp 3 ở 4 ô;
- hook giết quái: `OnDeath` gốc và hook Tứ Linh vẫn chạy;
- được +200 khi đuổi cấp; không được khi đệ tử xa 61 ô, khác bản đồ, hoặc ô 1941 là NPC của người khác;
- đệ tử kỹ năng (kể cả hình VNG) được tính; không có đệ tử thì không được;
- lên cấp áp ngay cho đệ tử đang đứng ngoài; lên nhiều cấp một lần; quái xám chia 4;
- giới hạn bằng cấp chủ: dừng ở mức đầy, chủ lên cấp thì đệ tử lên theo; cấp 150 có thông báo tối đa;
- khác phái hoặc `PlayerIndex` = 0: không tính;
- lỗi trong hook không làm dừng `OnDeath`;
- thiếu thư viện: lệnh bài vẫn chạy kiểu cũ;
- luồng đổi hình (Thỏ Vàng), gọi về, thu hồi, học kỹ năng, trang 2 vẫn đúng.

### 3.2 Áp nóng

- Đã ghi `admin_bridge\pending.lua`, chỉ ghi khi file chưa có. Nội dung: `ReLoadScript` cho `petexp_lib.lua`, `trieuhoi_lenhbai.lua`, `npc_quests\normal.lua`, rồi `PTAdm_Log("petexp", ...)` kèm kiểm tra native.
- Kết quả, `result.log` lúc 20:15:00:
  - dòng `petexp OK`;
  - `SetNpcSkill`, `SetNpcLife`, `GetNpcLife`, `PetGetType`, `SetNpcName` đều có;
  - `ReLoadScript` trả `nil`. Đây là bình thường: `LuaReLoadScript` không trả giá trị.
- Không cần khởi động lại máy chủ.

### 3.3 Người dùng cần làm

- [ ] Vào game bằng nhân vật Dị Nhân, dùng Lệnh Bài Triệu Hồi. Lời thoại phải có "Đệ tử cấp 1, kinh nghiệm 0/22".
- [ ] Gọi một đệ tử. Tên hiện `[1]Tên`, thông báo "(cấp 1)".
- [ ] Đánh vài quái cùng đệ tử. Có thông báo "Đệ tử lên cấp N! ...". Mở lại lệnh bài thì kinh nghiệm tăng.
- [ ] Đệ tử đang đứng ngoài đổi tên `[N]` ngay trên máy chủ. Máy khách có thể chỉ hiện tên mới sau khi gọi lại đệ tử.
- [ ] Nếu đã gọi đệ tử trước lúc áp nóng: thu hồi rồi gọi lại để đệ tử nhận cấp đệ tử.

## Phần 4: Tài liệu tham khảo

- Tài liệu liên quan: `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `ky-nang-de-tu-di-nhan-phong-than-20261002.md`, `doi-hinh-dang-de-tu-phong-than-20261003.md`, `petfight-tokenmenu-phong-than-20261003.md`, `desert-exp-phong-than-20261003.md`.
- Mã C++ đã đọc (không sửa):
  - `ScriptFuns.cpp`: `LuaSetNpcOwner`, `LuaSetNpcLife`, `LuaSetNpcSkill`, `LuaPetGetTypeCompat`;
  - `PhongThanLuaWave7.h`: `LuaAddTotemNpcCompat`;
  - `KNpc.cpp`: `DoDeath`, `ApplyPhongThanNpcLevelData`;
  - `KNpcDeathCalcExp.cpp` `CalcExp`;
  - `KSkills.cpp` `SKILL_SS_CreateNpc`;
  - `KSkillManager.cpp` `InstanceSkill`.
- Backup: `_backup\20261003-petexp\` (trieuhoi_lenhbai.lua, normal.lua, mktrieuhoi.py, CHANGELOG.md, README.md).
- Bước tiếp theo, nếu muốn:
  - ~~thêm native C++ `GetSummonPetIdx`~~ đã làm (engine2, 2026-10-04); đệ kỹ năng 450–461 mạnh theo cấp nhờ nhánh `pet10` trong C++;
  - thêm bảng kinh nghiệm riêng cho boss.
