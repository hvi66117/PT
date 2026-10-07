---
tinh-nang: Báo cáo khoảng trống so với VNG (chỉ đọc, chưa sửa gì)
ngay: 2026-10-04
agent: gaps (6 agent quét song song: native, ui, vnevent, activity, equip, econworld)
trang-thai: Phân tích tĩnh trên PAK + script loose + mã nguồn + log. Không sửa code, không đụng server, không ghi admin_bridge.
tom-tat: 91 hệ thống VNG được đối chiếu. Đủ 17, một phần 25, chưa chạy 49. Phần lớn khoảng trống không nằm ở nội dung mà ở bốn "nút cổ chai" — 210 native thiếu, script loose tên GBK không được đọc, ini client tiếng Trung không được nạp, script VNG Việt Nam bị thay bằng bản khóa. Gỡ được bốn nút này thì mở lại hàng trăm vật phẩm, kỹ năng và sự kiện với công sức thấp.
---

# Khoảng trống so với VNG — Phong Thần (bản local)

## Phần 1: Tổng quan

### Insight chính

1. **Khoảng trống lớn nhất là bốn nút cổ chai kỹ thuật, không phải thiếu nội dung.** Dữ liệu VNG gần như còn đủ. Nó không chạy vì:
   - **210 hàm Lua mà script VNG gọi nhưng engine chưa có** (762 native đã đăng ký). Có 577 file gọi trần, không có hàm dự phòng; 530 file trong số đó đang được bảng dữ liệu trỏ tới (magicscript, Skills, Missles, ibitem, Npcs). Chỉ khoảng 12 hàm đọc/alias (công sức Thấp) đã mở lại được khoảng 350 script vật phẩm.
   - **Script loose tên tiếng Trung (GBK) không được engine đọc.** Ví dụ: 1.269/2.178 dòng vật phẩm `item\` (58%), 44/46 file `活动脚本`, toàn bộ `凶兽活动`, `新服活动`, túi quà `签到`. Cách sửa duy nhất là đóng gói vào ptfix.
   - **Client chỉ đọc ini tên tiếng Anh `\Ui\ui3\UiXxx.ini`.** Bộ ui4 không bao giờ được dùng (`Ui\Setting.ini` `[Theme]` đều là ui3). 114/200 cửa sổ VNG không có mã client. 42 lớp C++ có mã nhưng thiếu ini, nên cửa sổ mở ra vô hình: hộp xác nhận, menu Esc, tự bơm máu, tin tức, bảng xếp hạng, tổ đội…
   - **`script\vnevent\` không chứa mã VNG thật.** 2.029 file là bản khóa (`BLOCKED_SPEC ... item was not consumed`), 1.100 file là "seal" chỉ gọi `AddSkillState`. 41 mẫu NPC/boss vnevent (1956–2047) trỏ tới 33 script không tồn tại.
2. **Server hiện ổn định.** `tick_error.log` không tồn tại (0 lỗi tick). `result.log` có 1.167 dòng, 100 FAIL, tất cả là "offline". `script_runtime.log` 0 lỗi. `script_registry_diag.log`: nạp 5.265, lỗi 69.
3. **Phát hiện trái với tài liệu cũ.** `\script\player\playerlogin.lua` không nằm trong PAK nào (băm `d562aec3` không có trong 87.364 mục của 23 PAK). Engine chạy bản loose, nhưng bản đó là tàn dư server VLTK lậu:
   - `Include` các file không tồn tại: `LockIPnguoichoi.lua`, `lib\worldlibrary.lua`, `header\taskid.lua`;
   - gọi `split`, `TaoBang`, `SaveData` (không có);
   - `playerlogout.lua` gọi `huyhamthu()` (không có).

   Vậy hook đăng nhập hỏng **vì script lỗi, không phải vì bị PAK che** như ghi trong `noi-dung-moi-phong-than-20261004.md`. Sửa được chỉ bằng Lua, và sẽ mở đường cho quà đăng nhập, phát lệnh bài, migrate dữ liệu chạy ngay khi vào game.
4. **Nhiều thứ đã build xong nhưng chưa triển khai** (engine2, tìm đường, Hành Trang, lbdaosi đợt 2, Vạn Tiên/Thương Chu ptfix, skillself, đệ Dị Nhân bot…). Trước khi làm thêm, nên triển khai gộp một lần và thử trong game. Đây là "đợt 0" của Phần 3.
5. **Không nên đầu tư cho người chơi một mình:** bang hội thật, gia tộc, thư, đấu giá, bày bán, quốc chiến tức thời, liên server. Tất cả cần C++ + client + DB, mà giá trị Thấp vì không có người chơi khác.

### Số hệ thống theo trạng thái

| Nhóm | Số hệ thống | Đủ | Một phần | Chưa chạy |
|---|---|---|---|---|
| 2.1 Nhân vật & kỹ năng | 11 | 1 | 4 | 6 |
| 2.2 Trang bị | 7 | 2 | 2 | 3 |
| 2.3 Pháp bảo / Linh thú / Thú cưỡi | 8 | 2 | 4 | 2 |
| 2.4 Nhiệm vụ & sự kiện | 12 | 3 | 3 | 6 |
| 2.5 Hoạt động & bản đồ | 17 | 4 | 5 | 8 |
| 2.6 Xã hội | 8 | 2 | 1 | 5 |
| 2.7 Kinh tế | 8 | 2 | 4 | 2 |
| 2.8 Giao diện client | 14 | 1 | 0 | 13 |
| 2.9 Khác (nền tảng) | 6 | 0 | 2 | 4 |
| **Tổng** | **91** | **17** | **25** | **49** |

Ký hiệu cột "Cần": **C++** = sửa CoreServer; **Client** = sửa CoreClient/Game.exe hoặc ini client; **Lua** = script rời/ext; **ptfix** = đóng gói vào ptfix.pak. Công sức: T = Thấp, TB = Trung bình, C = Cao. Giá trị (GT) tính cho người chơi một mình có bot.

## Phần 2: Chi tiết

### 2.1 Nhân vật & kỹ năng

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Chuyển sinh | Engine có `m_byTranslife` (lưu DB, bảng kinh nghiệm theo lần, biểu tượng). 0 script gọi `AddTranslife` | Một phần | NPC + nhiệm vụ chuyển sinh; native không đồng bộ xuống client | Cao | T | Lua (+ đồng bộ nhỏ C++) |
| Kỹ năng chuyển sinh 60/120/180 | 1481–1489, `ky-nang-chuyen-sinh-...20261001.md` | Đủ | — | Cao | — | — |
| Hiệu ứng trúng đích của kỹ năng missile | 10 script `skill\missle\*` (9 có trong `Missles.txt`), `OnHitTarget` gọi `IsPlayer`, `GetNpcLightResist`, `GetNpcColdResist` | Một phần | 3 native, đều là hàm đọc | Cao | T | C++ |
| Thần Kỹ | 60 STUB (vật phẩm 8360–8868). Kỹ năng 1986–2000 có ở cả server lẫn client | Chưa chạy | Script gọi `AddMagic`, nguồn phát | Cao | T | Lua + ptfix |
| Viên Thuộc Tính (Sức Mạnh / Ngộ Tính / Thể Chất / Thân Pháp) | 14 STUB (6854–6866, 6982) | Chưa chạy | Script `AddProp`/`AddStrg` (đã có native) | Cao | T | Lua |
| Ấn Tu Chân (6 cảnh giới: Trúc Cơ, Kim Đan, Nguyên Anh, Hóa Thần…) | 1.100 file "seal" (vật phẩm 5776+, 6241–6490, 6602–6851, 7590–7839). Client `Skills.txt` có trạng thái 2800–3898; server `skills.txt` hiệu lực (ptfix `ec1243ff`) chỉ 1.615 dòng, mã cao nhất 2000. File loose `Server\settings\Skills.txt` có đủ nhưng bị PAK che | Một phần (dùng được nhưng **không có tác dụng**) | 1.100 dòng trạng thái trong ptfix `skills.txt`; nguồn phát (NPC Tu Chân Huyền Vũ 1966, Tâm Ma 1975 không có script) | Cao | T–TB | ptfix + Lua |
| Danh hiệu | `ActiveTitleQualify`/`SetCurTitle` có. `RankSetting.txt` là 81 danh hiệu môn phái JX1, nên id VNG hiện sai chữ. 35 script `item\2015称号*` gọi `GetTitleFunc`; 58 file gọi `HaveNormalItemInQuick` | Một phần | Bảng tên VNG; 2 native; danh hiệu không cộng thuộc tính | TB | T | ptfix + C++ nhỏ |
| Sức mạnh / công lực | Chỉ `KItem::GetUpgradePower` cho tooltip; `\settings\powervalue` (7 bảng) không nạp | Chưa chạy | Tổng công lực, hiển thị | Thấp | TB | Lua / web admin |
| Hook đăng nhập / đăng xuất | `player\playerlogin.lua` loose (không có trong PAK), `KPlayer.cpp:6418` chạy mỗi lần đăng nhập; script lỗi (xem Insight 3) | Chưa chạy (hỏng) | Bản sạch gọi các hook của dự án | Cao | T | Lua |
| Nghĩa Tử (đồng hành) | 60 STUB + 591 dòng mất file; skill buff không có ở cả hai phía | Chưa chạy | Toàn bộ hệ đồng hành | TB | C | C++ + client |
| Yêu Quyết (Vô Tự Thiên Thư) | 8 STUB + 165 dòng mất file | Chưa chạy | Script, skill buff | TB | TB–C | Lua + skill client |

### 2.2 Trang bị (cường hóa, khảm, ghép, đồ bộ)

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Thăng cấp / cường hóa +1..+12 | Xích Tùng Tử (mẫu 206, Diêu Trì 1052). Bảng hợp thành `e1cb8a0e` 48.395 dòng; server chấp nhận 41.483 (91,7%), trong đó 40.761 dòng thăng cấp. `xich_tung_tu_diag.log` ghi 3 lần +0→+3 | Một phần (gần đủ) | Không có native/nút web đặt cấp cường hóa (`ApplyUpgradeState` chưa xuất ra Lua); pháp bảo và loại 0.14 không thăng cấp | Cao | T | C++ nhỏ (`SetItemUpgrade`) |
| Hợp thành (合成) | 96/657 công thức nguyên liệu chạy | Một phần | Ghép bảo thạch nhóm 7 (288, tỉ lệ < 100%), ghép pháp bảo (273), đồ cam (285), nhóm 8 (2.201) | TB | TB | C++ (nới bộ lọc) |
| Đục lỗ / khảm bảo thạch (打孔镶嵌) | 28 bảng, 371 quy tắc, 53 bảo thạch; C++ không nạp. Lớp `KUiEnchase` có nhưng thiếu ini | Chưa chạy | Lưu lỗ trên vật phẩm (DB), giao thức, giao diện | TB | C | C++ + client |
| Điểm lam / tẩy luyện (点蓝) | 165 nhóm thuộc tính, không nạp | Chưa chạy | Toàn bộ | TB | C | C++ |
| Đồ bộ (đồ lục) | `GetGoldEquipEnhance`, vòng sáng `PhongThanUpdateSetAura` | Đủ | — | TB | — | — |
| Mài mòn / sửa đồ | `AbradeEquip`, `RepairAllEquip`, lệnh bài sửa toàn bộ | Đủ | — | TB | — | — |
| Truyền thừa / nâng phẩm chất / hoán hồn / nâng ô trang bị | 241 / 504 / 864 / 427 dòng bảng; không nạp | Chưa chạy | Toàn bộ | Thấp | C | C++ + client |

### 2.3 Pháp bảo / Linh thú / Thú cưỡi

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Pháp bảo | amulet 1.920 dòng, vá 3 ô (`o-phap-bao-...20260930.md`) | Một phần | Thăng cấp pháp bảo (338 công thức, bảng `法宝升级数值表` không nạp); 35 tổ hợp kích hoạt (`法宝组合激活表`) | Cao | TB | C++ (nạp bảng, cộng trong `ReCalcEquip`) |
| Pháp khí | Đang làm tạm bằng dòng amulet 200–237. 6 file `法器灵石` gọi `IsInstrumentEquip`, `GetInstrumentGrowthDegree`, `AddInstrumentPolyAura` | Một phần | Ô Pháp khí thật, độ trưởng thành 201 mức, hào quang | TB | C | C++ + client |
| Thần Ấn | Đang làm tạm bằng dòng amulet 250–259 | Một phần | Ô Thần Ấn thật, cường hóa ấn (26 dòng) | TB | TB | C++ |
| Linh thú (bản Lua của dự án) | `sinhhoat\lt_*`: 8 con × 4 giai đoạn, đi theo, lên cấp, tiến hóa | Một phần | Không có thuộc tính/kỹ năng, không đổi màu, không nhặt đồ, không có giao diện | Cao | TB | Lua (cộng thuộc tính bằng trạng thái) |
| Linh thú VNG (百变灵宠盒, 胡喜媚卷轴, 摄印伏魔铃) | ~150 script gọi `PetIsAdd/PetIsSleep/PetSetType/PetGetTime`; 6 thẻ bán ở IB thiếu `GenPet`/`GetPetHonor` | Chưa chạy | Cả hệ pet VNG (`PetSetType` đã chủ động từ chối ở doc Linh thú) | TB | C | C++ + client; hoặc ánh xạ sang đệ hiện có (TB) |
| Thú cưỡi | horse.txt 6.210 dòng, cưỡi, hình, tặng Trác | Đủ (cơ bản) | Không nâng cấp ngựa | TB | — | — |
| Thần Thú Hồn Phách (horse_vision) | 52 file dùng `table.getn` kiểu Lua 5, không Include `pt_compat` nên lỗi; đổi mảnh lấy hồn bị chặn `BLOCKED_SPEC` | Chưa chạy | Sửa cho Lua 4, nguồn phát, phần thưởng | TB | TB | Lua + ptfix |
| Đệ tử Dị Nhân (dự án) | Lệnh Bài Triệu Hồi, 450–461, pet-exp, petfight | Đủ | Khung tên/máu đệ trên màn hình (xem 2.8) | Cao | — | — |

### 2.4 Nhiệm vụ & sự kiện

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Chính tuyến 3 phái, tân thủ, F11, nhiệm vụ ngày, Tiên Ma | 52 chuỗi / 539 bước trong Lệnh Bài Nhiệm Vụ; nhiều doc 09/28–10/04 | Đủ | Kiểm thử trong game | Cao | — | — |
| Lịch VNG (`systemtimetask.txt`, `predayevent.txt`) | `d88bafab` 25 KB gọi 124 script, **102 không tồn tại**. C++ chỉ nạp `servertimer.lua` (`CoreServerShell.cpp:1121`), không đọc file lịch | Một phần (đã thay bằng ext `eventsched` 4 loại) | Loại sự kiện quái theo giờ, hỏi đáp, lễ hội | Cao | T | Lua |
| 活动脚本 (sự kiện VNG) | 46 file, 2 trong PAK (`baguabisai`, `guimenkai`/`guijie*`) | Chưa chạy | Quỷ Môn Khai (quái ở Mạnh Tân) và Tìm quẻ chưa có giờ chạy; 44 file loose GBK; ~12 native nhỏ (`SendGlobalMessage`, `EarnBind`, `AddEmoteBalloon`, `Get/SetGlobalStoreValueByte`…) | TB | T–TB | Lua + ptfix (+ native nhỏ) |
| 凶兽活动 (Hung thú) | 5 file loose (封印卡, 王母…) | Chưa chạy | Script sinh hung thú; `SearchNearNpcByTemplateId`, `SetNpcBelonger` | TB | TB | Lua + 2 native |
| 新服活动 / 国际版 2–3 năm / 烈火两周年 | Túi quà loose; `烈火两周年活动\刷怪.lua` (BOSS Hoàng Kim ở Mạnh Tân) trong PAK | Chưa chạy | 刷怪 chỉ thiếu `SendGlobalMessage`; phần còn lại cần 17 native | TB (刷怪) | T | Lua |
| Sự kiện VN theo mùa (vnevent event*, eventfree, bánh chưng…) | ~300 dòng event*, eventfree 256, tích lũy 2019: 91 — đều STUB | Chưa chạy | Script, NPC, timer (phải tự thiết kế) | Thấp–TB | TB mỗi sự kiện | Lua |
| Hỏi đáp (题库) | `\script\题库.lua` 32 KB câu hỏi tiếng Việt trong PAK, không có chỗ gọi; `\settings\questionlib` 23 file | Chưa chạy | NPC/sự kiện hỏi đáp dùng `题库.lua` | TB | T | Lua |
| Điểm danh tháng | `月度签到任务/奖励.txt` + 5 túi quà loose + ini `签到界面` | Một phần (quà 1 + 7 ngày của dự án) | Lịch tháng VNG | TB | T | Lua + ptfix |
| Boss/NPC vnevent | 41 mẫu (1956–2047: Thần Nông, Xi Vưu, rồng Tiên Ma, Niên Thú, Thân Công Báo, Tâm Ma…), 33 script mất, không con nào sống | Chưa chạy | AI, rơi đồ, spawn | Cao | TB | Lua (khung boss thế giới) |
| Boss thế giới (boss刷新) | 12 boss, lệnh bài, `worldboss.txt` | Đủ | 4 script VNG thiếu (元素神, 悟真人, 激发龙力, 岁寒地气) | Cao | — | — |
| Hoa thần (神秘花卉任务) | 15 script ptfix, NPC sống | Đủ | — | TB | — | — |
| Xổ số 28 Tinh Tú / Âm Dương thuật / Ứng Thiêm (彩票) | 10 script; Thái Tuế (Càn Khôn Luân) đã chạy | Một phần | 6 native (`Lottery`, `IsDrawing`, `WinnerCount`, `GetPicks`, `Jackpot`, `BigSmall`) + giao diện | TB | TB | Lua (menu Say) |

### 2.5 Hoạt động & bản đồ (Tống Kim, công thành, phó bản…)

Bản đồ: WorldSet có **118 map**. 62 map có quái, 13 map chỉ có NPC, **27 map đã nạp nhưng trống**, 16 map không nạp (thiếu dữ liệu). Chi tiết ở `S\gaps\econworld\maps.tsv`.

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Vạn Tiên trận Huyễn 1079–1082 | 18–19 NPC/trận, lệnh bài 61470, bot | Đủ | Bật lịch 6 lượt/ngày (dòng 2 eventsched đang tắt) | Cao | — | — |
| Thương Chu / 新古战场 1071 | 47 NPC, vienco PvE, lệnh bài 61471 | Đủ (PvE) | Không có PvP thật | Cao | — | — |
| Vận Tiêu / Vận Lương / Bào Thương | C++ `SendCarriage`, Lua | Đủ | — | Cao | — | — |
| Tiên Ma giới, 阪泉圣地 1076 | tienma/tienma45, 323 NPC/quái | Đủ | — | Cao | — | — |
| Công thành / lãnh địa | `congthanh` (lãnh địa cá nhân, lính 850–874, thủ thành theo lịch) | Một phần | Thành/công trình/科技 thật (`settings\city` 49 file không nạp, 23 native thiếu) | TB | C | C++ + client |
| 狱法山 1074/1075 | 17 script ptfix, 343/352 NPC | Một phần | Sự kiện 狱法烽烟 (script lịch thiếu, VNG 4 lượt/ngày) | TB | TB | Lua |
| Viễn Cổ 1064 | 16 script VNG, 3 NPC Đồ Đằng sống | Một phần | Đại phu, Thủ khố, Khoa Phụ, Thiếu Hạo, Chúc Dung, Dung Thành Tử, Chiến Hồn | TB | T | Lua (spawn) |
| Không Tang 1078 | 283 quái (bãi 95–150) | Một phần | 8 NPC/boss VNG (吴龙, 常昊, 戴礼, 朱子真, 杨显, 金大升, 袁洪, 灵山老翁) | TB | T | Lua |
| Khai Minh đảo 1072, Bích Du Cung 1042–1046 | Thuyền Phu, quái, Đại phu | Một phần | 准提道人, 特产商人; 多宝道人 | Thấp | T | Lua |
| Vạn Tiên thường 1067–1070 | 32 script `万仙阵`; chỉ 1068 nạp (1 file `.wor`) | Chưa chạy | Dữ liệu map 3/4 trận | Thấp | C | Dữ liệu |
| Quốc chiến tức thời (即时国战) | 32 script, 23 native thiếu, không có map thành | Chưa chạy | Toàn bộ | Thấp | C | C++ + client |
| Liên server / Động Thiên 1086–1088 | 11 file loose; map có 0 NPC | Chưa chạy | Toàn bộ (map dùng lại được) | Thấp–TB | C | Lua + ptfix |
| Phó bản `\settings\instance` (斧头帮试炼, 乾坤幻境, 天绝阵) | Chỉ còn `*_npc_load.txt` | Chưa chạy | Script, map, cơ chế phó bản | Cao | C | Lua + mission (dùng lại Vạn Tiên) |
| Thiên Lao 1060/1089 | 6 script (刑天, 蚩尤, 禄星…), 0 NPC | Chưa chạy | NPC, cơ chế | Thấp | T | Lua |
| Trư Lung Trại 1066 | 5 script, 0 NPC | Chưa chạy | NPC (包猪公/婆, Đại phu) | Thấp | T | Lua |
| Thập Nhị Tầng Yêu Tháp | 289 dòng vật phẩm mất file | Chưa chạy | Map, mission, buff chìa khóa | TB–Cao | C | Lua + skill client |
| Map trống còn lại | Diễn Võ Trường 1103–1107, Đấu Trường 1109–1118, Diêm La 1090, Hoàng Tuyền 1091, Nam Kha 1092, Khe nứt Viễn Cổ 1085, Thương Chu phó bản 1108 | Chưa chạy | Quái/NPC | TB | T | Lua (spawn kiểu matdo) |

Tống Kim (宋金) là nội dung VLTK, không có trong Phong Thần VNG; `missions\宋金战场pk战` chỉ là stub. Thương Chu đã đóng vai chiến trường.

### 2.6 Xã hội (bang hội, sư đồ, kết hôn, bạn bè, thư)

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Bang hội | `KPlayerTong.cpp`, native `CreateTong/GetTong*`, `UiTongManager`; nhưng `KSOServer.cpp:437-438` gán `m_pTongClient = NULL`; TongDB dừng ghi từ 04/09 | Chưa chạy | Máy chủ bang (S3Relay KTongControl có mã nhưng không triển khai) | Thấp–TB | C | C++ |
| Gia tộc / thị tộc | Chỉ có spr/ini 家氏族 | Chưa chạy (không có trong engine) | Toàn bộ | Thấp | C | C++ + client |
| Tổ đội | `KPlayerTeam`, `KUiPartyPanel` (Alt+G), bot `party.lua` | Đủ | Bot không vào `g_Team` | Cao | — | — |
| Bạn bè / kẻ thù | `MakeBrother/MakeEnemy` gửi vào hàng đợi tong rồi mất; `c2s_extendfriend` bị bỏ | Chưa chạy | FriendMgr/dbfriend | Thấp | TB–C | C++ |
| Sư đồ | Hoàng Phi Hổ sư phụ ảo, nhiệm vụ 42–46 solo | Đủ | — | Cao | — | — |
| Kết hôn | `LuaCanMarryVng/LuaDoMarryVng`, Tây Vương Mẫu Diêu Trì | Một phần | Cần 2 người thật khác giới, không có ly hôn | Thấp | TB | Lua (phối ngẫu ảo) |
| Thư (mail) | Chỉ có ini 邮箱; engine không có | Chưa chạy | Toàn bộ | Thấp | C | C++ + client + DB |
| Chat kênh | Client gửi `c2s_extendchat`, server bỏ gói (`KSOServer.cpp:2324-2330`) | Chưa chạy | Xử lý kênh thế giới/đội/riêng ngay trong KSOServer | Thấp–TB | TB | C++ |

### 2.7 Kinh tế (chợ, bày bán, Kỳ Trân Các)

| Hệ thống | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Cửa hàng NPC | `KBuySell` + `buysell.txt`/`goods.txt`; bán từ xa, dọn túi | Đủ | — | Cao | — | — |
| Kỳ Trân Các (F2) | `ibshopgoods.txt` 468 hàng; log `rows=469 ... unit_price=1` | Một phần | **Mọi món giá 1 lượng**, bỏ qua cột ActualPrice, không thu Xu/KNB; tab đọc lệch 1 hàng | Cao (đang phá cân bằng) | TB | C++ `KBuySell.cpp` + `CoreShell.cpp` |
| KNB / Xu | KNB = vật phẩm 3/1183; 禄星/福星 Diêu Trì rút KNB từ `ExtPoint(2)`, đổi 1 KNB → 15 Xu | Một phần | Không có nguồn kiếm KNB khi chơi một mình, và không có chỗ tiêu (Kỳ Trân Các 1 lượng) | Cao | T–TB | Lua (nguồn) + C++ (giá) |
| Ngân hàng / tiền kho | Tiền gửi Rương, `BankMoney`; `bankrate.ini` không ai đọc | Một phần | Lãi tiền gửi | Thấp–TB | T | Lua |
| Chạy thương VNG (跑商) | 9 script 货商 gọi 8 native `GetGoods*`, `PlayerSellGoods`, `InputDialog`; `商店价格配置.txt` 243 dòng giá thả nổi không đọc | Một phần (Bào Thương Lua đã thay) | Giá thả nổi | TB | TB | C++ |
| Giao dịch 2 người | `TradeApply*`, `UiTrade` | Đủ | Bot không nhận giao dịch | Thấp | — | — |
| Bày bán (摆摊) | Server có `TradeSet/TradeStart/...`; `UiItem.cpp:558` có `m_MakeStallBtn` nhưng ini VNG không có `[MakeStallBtn]` | Chưa chạy | Nút mở sạp; không có người mua | Thấp | T (ini) / C (bot mua) | Client |
| Đấu giá (拍卖行) | Không có dòng mã nào; chỉ có bảng tìm kiếm | Chưa chạy | Toàn bộ | Thấp | C | C++ + client |

### 2.8 Giao diện client

Thống kê: 200 tên ini VNG (ui3 198 + ui4 198, chung 196). 54 có mã chạy được, 114 không có mã client, 27 tên VNG thuộc lớp C++ thiếu ini, 5 là dữ liệu. 22 phím/nút trỏ tới chỗ không có mã. Danh sách đủ ở `S\gaps\ui\vng_ui_windows.tsv`.

| Cửa sổ | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Các khung đã làm (theo dõi nhiệm vụ, tổ đội bot, Tùy chọn, thanh buff, hợp thành VNG, rương) | `uitasktrace.ini`, `uioptions.ini`, `UiVngCompose.ini`… | Đủ | — | Cao | — | — |
| Hộp xác nhận 2–3 nút | `KUiInformation` đọc `UiInformation.ini`, không có (VNG `提示.ini` trùng 4/4 mục) | Chưa chạy (vô hình, theo phân tích tĩnh) | ini đổi tên | Cao | T | Client (ini, qua ptfix hoặc loose) |
| Menu Esc | `KUiESCDlg` đọc `UiESCDlg.ini`, không có (VNG `esc打开的界面.ini`) | Cần thử trong game (doc âm thanh ghi ESC → Tùy chọn) | ini | Cao | T | Client (ini) |
| Tự bơm máu/mana (phím I, Alt+Z) | `KUiAutoPlay` đọc `UiAutoPlay.ini`, không có; `OpenAutoBloodMana`/`AutoBloodMana` chưa đăng ký | Chưa chạy | ini (VNG 137 mục, JX 188 mục) + 2 hàm Lua client | Cao | TB | Client |
| Khung tên/cấp/máu đệ tử (召唤兽顶部控制条) | Lớp `Player_Pet*` không có | Chưa chạy | Lớp C++ mới | Cao | TB | C++ client |
| Thanh tiến trình (rèn đá, `OpenProgressBar`) | `KUiProgressBarLoading`, thiếu ini; VNG `打造物品.ini` trùng 11/12 mục | Chưa chạy | ini | TB | T | Client (ini) |
| Tin tức / thông báo đầu màn hình | `KUiNewsSysMsg`, `KUiNewsMessage` thiếu ini | Chưa chạy | ini (từ 系统公告, 新闻消息来了) | TB | T | Client (ini) |
| Tách chồng vật phẩm, người chơi xung quanh | `KUiBreakItem`, `KUiSelPlayerNearby` thiếu ini | Chưa chạy | ini | TB | T | Client (ini) |
| Trợ giúp F1, phím F10 | `KUiHelper2` thiếu ini; F10 gọi `Open("tongmanager")` không có trong `l_WindowList` | Chưa chạy | ini + sửa `autoexec.lua` (trong PAK) | TB | T | Client + ptfix |
| Bảng xếp hạng | `KUiRankData`/`KUiStrengthRank` thiếu ini; server có ladder nhưng 0 script cấp dữ liệu | Chưa chạy | ini + nguồn dữ liệu (thành tích, bot) | TB | TB | Client + Lua |
| Bản đồ thế giới | `KUiWorldMap` thiếu ini | Chưa chạy | ini + sửa C++ nhỏ | TB | TB | Client |
| Tra bản đồ / tìm NPC (地图查询) | Không có mã | Chưa chạy | Lớp mới (tạm: Lệnh Bài Nhiệm Vụ/Luyện Công + Alt+F) | Cao | C | C++ client |
| Quản lý tổ đội (phím G) | `KUiTeamManage` thiếu ini | Chưa chạy | ini | TB | TB | Client (ini) |
| Phím/nút chết | 22 mục: `` ` `` chatroom, Alt+X/Alt+C/Alt+T/Insert, L liveSkill, Alt+W, Ctrl+D, Shift+1/2…; nút DivineInfusion rỗng | Chưa chạy | Gỡ hoặc nối vào chức năng dự án | Thấp | T | ptfix (autoexec) |

### 2.9 Khác (nền tảng)

| Hạng mục | Bằng chứng | Trạng thái | Thiếu gì | GT | Công sức | Cần |
|---|---|---|---|---|---|---|
| Vật phẩm VNG đời mới (túi quà, thẻ, ibitem, biến thân, thời trang) | ~350 script `item\` dừng ở dòng đầu `main`: `FindAValidItemID` 161 file, `GetItemGen/Detail` 129, `HaveNormalItemInQuick` 58, `AddNormalItem4` 41, `Time2LocalYMD` 37, `GetTitleFunc` 35, `EarnBind` 32, `GetServerStartTime` 29, `GetCompeteFlag` 27, `CanPolyMorph` 21, `GlobalStore*` 16, `AddItemPileNum` 14, `GetNpcLifeMax` 12, `IsItemBind` 10 | Chưa chạy | ~14 native đọc/alias | Cao | T | C++ |
| Hàm dự phòng `pt_compat.lua` | Có `FindAValidItemID`, `IsItemBind`, `GetItemGen/Detail`… nhưng chỉ file ptfix mới Include; 0/161 file gọi `FindAValidItemID` được che | Một phần | Chuyển thành native để mọi Lua state đều có | Cao | T | C++ |
| 80 vật phẩm nhận/mua được mà dùng không có tác dụng | 18 túi quà IB 8/230–748, 17 biến phù tổ đội/Vô Ảnh 8/220–435, 14 ibitem, 16 phối phương, 6 linh thạch (`S\gaps\vnevent\obtainable_broken.txt`) | Chưa chạy | Script hoặc đóng gói | TB | TB | Lua + ptfix |
| Script loose tên GBK | 1.269 dòng vật phẩm + sự kiện chỉ có ở loose | Chưa chạy | Đóng gói vào ptfix sau khi có native (ưu tiên Quẻ 卦卷: 275 dòng không thiếu native nào) | TB | TB | ptfix |
| `AddItemIDStack(idx)` 1 đối số | `servertimer.lua:42` (`PTAdm_GiveTo`), `nhiemvu_data.lua:381`; `ScriptFuns.cpp:3397` cần ≥ 2 | Chưa sửa (lỗi đã biết) | Vật phẩm xếp chồng từ web admin không vào túi dù log OK | Cao | T | Lua |
| Bản build đang chờ triển khai | engine2, tìm đường, hanhtrang, lbdaosi r2, vtcc, skillself, dinhanbot, vancot, daosi, desertexp… (README) | Một phần | Triển khai gộp CoreServer + CoreClient + Game.exe + ptfix, khởi động lại, thử trong game | Cao | T | — |

## Phần 3: Hành động

Nguyên tắc xếp: giá trị cho người chơi một mình trước, gom theo loại triển khai (Lua nóng → một lần build C++ → client/ptfix → nội dung lớn) để mỗi đợt chỉ khởi động lại một lần.

### Đợt 0 — Triển khai những gì đã build (trước mọi việc)
- [ ] Triển khai gộp CoreServer.dll + CoreClient.dll + Game.exe + ptfix chính thức (gồm `extra_vtcc`, `extra_hanhtrang`, `extra_lbdaosi`, `extra_skillself`…), thêm `hanhtrang` vào `PTADM_EXT_NAMES`, chép `party.lua`.
- [ ] Thử trong game theo checklist từng doc; ghi lỗi trước khi mở đợt mới.

### Đợt 1 — Chỉ Lua / ptfix, công sức Thấp (áp nóng được phần lớn)

| # | Việc | Lý do | Công sức | Cần |
|---|---|---|---|---|
| 1 | Thay `player\playerlogin.lua` / `playerlogout.lua` bằng bản sạch gọi hook dự án | Hook đăng nhập đang hỏng; quà đăng nhập, phát lệnh bài, migrate sẽ chạy đúng lúc vào game | T | Lua |
| 2 | Sửa `AddItemIDStack` 1 đối số ở `servertimer.lua` và `nhiemvu_data.lua` | Vật phẩm xếp chồng từ web admin đang mất | T | Lua |
| 3 | Thần Kỹ (60 vật phẩm → `AddMagic` 1986–2000) và 14 viên Thuộc Tính | Kỹ năng/chỉ số có sẵn hai phía, chỉ thiếu script | T | Lua + ptfix |
| 4 | Ấn Tu Chân: `extra_tuchan.py` gộp 1.100 dòng trạng thái vào ptfix `skills.txt` | 1.100 ấn đang không có tác dụng; client đã có | T–TB | ptfix |
| 5 | Chuyển sinh: NPC + nhiệm vụ dùng `AddTranslife` | Engine đã lưu được, chỉ thiếu điểm vào | T | Lua |
| 6 | Thêm loại `quiz` (dùng `题库.lua`) và `invasion` (Quỷ Môn Khai, BOSS Hoàng Kim Mạnh Tân) vào eventsched | Có nhịp sự kiện như VNG mà không cần native | T | Lua |
| 7 | Spawn NPC còn thiếu: Không Tang 1078 (8), Viễn Cổ 1064 (7), Thiên Lao 1060, Trư Lung 1066, 多宝道人 | Script VNG có sẵn, chỉ thiếu NPC | T | Lua |
| 8 | Nguồn KNB/Xu: thưởng từ boss thế giới, nhiệm vụ ngày, rương Vạn Tiên | Chuẩn bị cho Kỳ Trân Các thu giá thật ở đợt 2 | T | Lua |

### Đợt 2 — Một lần build C++ (native nhỏ)

| # | Việc | Lý do | Công sức | Cần |
|---|---|---|---|---|
| 1 | `IsPlayer`, `GetNpcLightResist`, `GetNpcColdResist` | Hiệu ứng trúng đích của 10 kỹ năng missile | T | C++ |
| 2 | Gói native vật phẩm: `FindAValidItemID`, `GetItemGen/Detail`, `HaveNormalItemInQuick`, `EarnBind`, `GetServerStartTime`, `GetCompeteFlag`, `CanPolyMorph`, `Time2LocalYMD`, `AddItemPileNum`, `IsItemBind`, `Get/SetGlobalStoreValue*`, `GetNpcLifeMax`, `GetIBItemGenTime`, `SendGlobalMessage`, `AddEmoteBalloon` (không làm gì) | Mở lại ~350 script vật phẩm và sự kiện | T–TB | C++ |
| 3 | `GetTitleFunc` + bảng tên danh hiệu VNG trong ptfix | 35 script danh hiệu, hiện sai chữ | T | C++ + ptfix |
| 4 | Native `SetItemUpgrade` (đặt cấp cường hóa) + nút +1..+12 trên web admin | Cường hóa đã chạy, thiếu công cụ quản trị | T | C++ + web |
| 5 | Kỳ Trân Các thu giá thật (ActualPrice, Xu/KNB) + sửa lệch tab | Hiện mọi món 1 lượng, phá cân bằng | TB | C++ server + CoreShell |
| 6 | `AddNormalItem4`, `AddBlueEquip` | Túi trang bị xanh/tân thủ VNG | TB | C++ |

### Đợt 3 — Client ini và đóng gói ptfix

| # | Việc | Lý do | Công sức | Cần |
|---|---|---|---|---|
| 1 | Bộ ini cơ bản: `UiInformation`, `UiESCDlg`, `UiProgressBarLoading`, `UiNewsSysMsg`, `UiNewsMessage`, `UiBreakItem`, `UiSelPlayerNearby`, `UiHelper2` | 8 cửa sổ có mã sẵn, chỉ thiếu ini (nhiều file VNG trùng mục gần 100%) | T | Client (ini) |
| 2 | `UiAutoPlay.ini` + đăng ký `OpenAutoBloodMana`/`AutoBloodMana` (phím I, Alt+Z) | Thiết lập tự bơm máu/mana bằng giao diện | TB | Client |
| 3 | Sửa `autoexec.lua` qua ptfix: F10 → `tong`, gỡ/nối 22 phím chết | Bấm phím không còn "không có gì xảy ra" | T | ptfix |
| 4 | `UiRankData`/`UiStrengthRank` + nguồn dữ liệu từ bảng thành tích và bot | Bảng xếp hạng có ý nghĩa với bot | TB | Client + Lua |
| 5 | Đóng gói script VNG tên GBK vào ptfix sau đợt 2: Quẻ (275 dòng), 18 túi quà đang bán ở IB, 17 biến phù | Mở lại hàng trăm vật phẩm thật của VNG | TB | ptfix |
| 6 | Sửa 80 vật phẩm nhận/mua được mà dùng không có tác dụng | Hết vật phẩm "chết" trong túi | TB | Lua + ptfix |
| 7 | horse_vision sửa cho Lua 4 + điểm danh tháng nối dailygift | Hai hệ nhỏ, script có sẵn | T–TB | Lua + ptfix |

### Đợt 4 — Nội dung lớn (TB–Cao)

| # | Việc | Lý do | Công sức | Cần |
|---|---|---|---|---|
| 1 | Boss vnevent 41 mẫu (Thần Nông, Xi Vưu, Niên Thú, Tâm Ma…) qua khung boss thế giới, rơi Ấn Tu Chân/Thần Kỹ | Nguồn phát cho đợt 1, hợp với tổ đội bot | TB | Lua |
| 2 | Phó bản một người từ 3 bộ `settings\instance` trên khung mission Vạn Tiên, đặt ở map trống 1086–1088 hoặc 1103–1107 | Nội dung lặp lại giá trị cao nhất còn thiếu | C | Lua + mission |
| 3 | Thăng cấp pháp bảo (338 công thức) + 35 tổ hợp pháp bảo | Pháp bảo là trục sức mạnh chính | TB | C++ |
| 4 | Ghép bảo thạch nhóm 7 (288) + ghép pháp bảo (273) | Mở rộng hợp thành | TB | C++ |
| 5 | Linh thú có thuộc tính theo giai đoạn (Lua) + khung đệ tử trên màn hình | Linh thú/đệ tử có giá trị chiến đấu thật | TB | Lua + C++ client |
| 6 | Map trống thành khu cày cấp cao/boss solo (Đấu Trường 1109–1118, Diễn Võ 1103–1107, Diêm La/Hoàng Tuyền 1090–1091, Nam Kha 1092) | 27 map đã nạp đang bỏ không | T–TB | Lua (matdo) |
| 7 | Kỹ năng sống mở rộng theo 128 công thức VNG | Bản Lua hiện có 9 công thức | TB | Lua + ptfix |
| 8 | Xổ số 28 Tinh Tú bản Lua (menu Say, quay 20:00 qua eventsched) | Sự kiện hằng ngày nhẹ | TB | Lua |

**Không đề xuất** (giá trị Thấp khi chơi một mình, công sức Cao): bang hội thật, gia tộc, thư, đấu giá, bày bán, quốc chiến tức thời, liên server, truyền thừa/phẩm chất/hoán hồn, đục lỗ/khảm và điểm lam bản đầy đủ (cân nhắc lại sau đợt 4).

## Phần 4: Tham khảo

- **Dữ liệu quét (scratchpad `S\gaps\`):**
  - `txt\` (5.388 entry văn bản PAK hiệu lực), `vng\` (bản VNG bị ptfix đè), `names.tsv` (11.790 id đã giải tên), `loose_files.txt`, `loose_dirs.txt`; công cụ `extract.py`, `resolve.py`.
  - `native\`: `top_missing.tsv`, `systems.tsv`, `missing_reach.tsv`, `defined_elsewhere.tsv`, `natives.txt` (762 native).
  - `ui\`: `vng_ui_windows.tsv` (201 dòng), `client_classes_missing_ini.tsv`, `hotkeys_toolbar_dead.tsv`, `en_presence.tsv`.
  - `vnevent\`: `bao-cao-vnevent-item-20261004.md`, `final_stats.txt`, `obtainable_broken.txt`, `eff_missing_api.txt`.
  - `activity\`: `ket-qua-hoat-dong-xa-hoi-20261004.md`, `stt.txt` (124 script lịch VNG), `api.txt`.
  - `equip\`: `equip_A.md`, `vng_tables.txt`, `script_api_gaps.txt`, `ui_ini_usage.txt`.
  - `econworld\`: `maps.tsv` (118 map), `knb_grep.txt`.
- **Mã nguồn:** `ScriptFuns.cpp` 14.281–15.135 (bảng `GameScriptFuns`), `KSOServer.cpp:437-438, 2324-2330`, `CoreServerShell.cpp:1121`, `KPlayer.cpp:6418`, `KBuySell.cpp`, `UiItem.cpp:558`.
- **Log:** `admin_bridge\result.log`, `newbie2_error.log`, `Server\script_runtime.log`, `script_registry_diag.log`, `ibshop_loader_diag.log`, `xich_tung_tu_diag.log`.
- **Tài liệu liên quan:** `de-xuat-tinh-nang-phong-than-20261004.md` (đề xuất trước, đã làm A–E), `engine-gaps-phong-than-20261004.md`, `noi-dung-moi-phong-than-20261004.md` (cần sửa ghi chú về playerlogin), `le-quan-sinh-hoat-linh-thu-phong-than-20261003.md`, `o-phap-bao-phap-khi-an-phong-than-20260930.md`, `cong-thanh-lanh-dia-phong-than-20261003.md`, `goi-va-ptfix-pak-phong-than-20260929.md`.
- **Giới hạn:** đây là phân tích tĩnh. Các kết luận về cửa sổ vô hình và "loose GBK không đọc được" dựa trên mã và ghi chú dự án, chưa thử trong game. Region của `maps.pak` không quét được, nên kết luận "script NPC không có tham chiếu" chỉ chắc ở mức trung bình.
