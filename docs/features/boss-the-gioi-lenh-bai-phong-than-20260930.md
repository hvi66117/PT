# Boss thế giới: lịch xuất hiện, trạng thái và Lệnh Bài Boss Thế Giới

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái:
> - **Vòng lặp boss:** đã nạp nóng lúc 14:14 và đang chạy. Đã gọi thử Cửu Linh lúc 14:15, xuất hiện thành công.
> - **Lệnh bài, script chết bọc, tab web admin:** có hiệu lực sau khi khởi động lại server, game và web admin, vì ptfix v7 phải được cài.

## Phần 1: Tổng quan
- **Dữ liệu boss thế giới VNG còn lại:** 12 boss trong `\script\boss刷新\*.lua` (script.pak), lịch trong `settings\systemtimetask.txt`, trạng thái dùng GlobalValue 101–112. Các boss VNG kiểu mới (`vnevent\features\boss*`) **không còn file**, nên không dựng lại được.
- **Trước đây không chạy:**
  - Engine chỉ chạy `servertimer.lua`, không đọc lịch.
  - Script VNG gọi `AddNpc` 5 tham số (engine cần 6) và dùng mã map cũ.
  - Script chết của boss không được đăng ký.
- **Đã làm:**
  1. `servertimer.lua` gọi boss đúng phút theo lịch VNG nếu boss chưa còn sống, phát thông báo toàn server, theo dõi còn sống/bị diệt, ghi trạng thái cho web.
  2. Script chết VNG (thông báo người hạ boss, phần thưởng "Đầu …" cho nhiệm vụ) được giữ nguyên và bọc thêm một lớp để ghi lại người hạ.
  3. **Lệnh Bài Boss Thế Giới** (6/61001): dùng vĩnh viễn, không mất, không giao dịch/vứt/bán. Xem trạng thái 12 boss và dịch chuyển tới nơi boss xuất hiện.
  4. Web admin có tab **Boss thế giới**: bảng trạng thái, giờ xuất hiện, giờ bị diệt, người hạ, lần tới, lịch, nút "Gọi ngay" và nút phát lệnh bài.

## Phần 2: Chi tiết
### 2.1 Danh sách boss (theo VNG)
| Boss | Map | Tọa độ | Cấp | Lịch |
|---|---|---|---|---|
| Cửu Linh | 1016 Tam Sơn | 198,208 | 40 | mỗi giờ :59 (19:58) |
| Thiết Bố | 1026 | 220,183 | 60 | 00:01, 12:01 |
| Kim Trại | 1041 Long Uyên | 224,217 | 60 | 00:16, 12:16 |
| Côn Bối | 1031 Hiên Viên 5 | 248,192 | 60 | 00:31, 12:31 |
| Lam Bá | 1036 Băng Xuyên | 161,204 | 60 | 00:46, 12:46 |
| Bàn Cổ | 1051 Khổn Tiên 5 | 197,212 | 80 | 18:02 |
| Đại Điêu | 1046 Bích Du 5 | 200,185 | 80 | 18:32 |
| Nhị Lang Thần | 1065 Trần Đường | 219,206 | 80 | 18:45 |
| Giao Long | 1055 Đông Doanh | 213,184 | 100 | 19:30 |
| Ly Long | 1056 Phương Trượng | 218,191 | 100 | 19:50 |
| Di Long | 1054 Bồng Lai | 203,186 | 100 | 20:30 |
| Bất Nghĩa Hầu | 1062 Ngọc Hư 10 năm sau | 210,202 | 60 | 19:59 |

- Bàn Cổ dùng điểm (1581, 3400) thay cho (1587, 3400), vì điểm gốc nằm trong một vùng server không có dữ liệu, `AddNpc` sẽ thất bại.
- Điểm dịch chuyển của lệnh bài cách chỗ boss xuất hiện 10 ô, có đường đi thẳng tới boss.

### 2.2 File
| File | Vai trò |
|---|---|
| `Server\script\phongthan\boss\wb_data.lua` | Bảng 12 boss (chuỗi TCVN3), sinh bằng `scratchpad\boss\gen_worldboss.py` |
| `Server\script\phongthan\boss\wb_lib.lua` | `PTWB_Tick` (mỗi phút): gọi boss, phát hiện bị diệt, ghi `admin_bridge\worldboss.txt`. `PTWB_SpawnKey` cho web |
| `Server\script\phongthan\item\boss_lenhbai.lua` | Script lệnh bài: 2 trang × 6 boss; chọn boss thì `NewWorld` tới điểm dịch chuyển, `SetFightState(1)` |
| `Server\script\servertimer.lua` | `PTAdm_WbTick()` được gọi sau `PTAdm_HandTick()` |
| `ptfix.pak` v7 | Thêm dòng `magicscript.txt` 61001 (mẫu từ "Lệnh Bài VIP"); bọc 12 script chết |
| `AdminWeb\PhongThan-Admin.ps1`, `index.html`, `data\worldboss.json` | API `GET /api/worldboss`, hành động `wbspawn`, mã vật phẩm `BossToken` |

### 2.3 Trạng thái (GlobalValue)
| Ô | Ý nghĩa |
|---|---|
| 101–112 (theo VNG) | 1 = đang sống, -1 = đã bị diệt, 0 = chưa xuất hiện |
| 4101–4112 | Giờ xuất hiện (hhmm) |
| 4121–4132 | Giờ bị diệt |
| 4141–4152 | Giờ lần tới |
| 4161–4172 | PlayerIndex của người hạ |
| 4181–4192 | Chỉ số NPC của boss |

- Lệnh bài chỉ đọc GlobalValue nên không phụ thuộc thư viện ngày giờ của Lua.
- Mỗi script chết VNG còn đặt ô của **một boss khác** về 0 (cơ chế nối chuỗi). Lớp bọc giữ nguyên các ô khác, và vòng lặp mỗi phút đồng bộ trạng thái theo việc boss có thật sự còn trên bản đồ hay không, nên không gọi trùng boss.
- Giờ bị diệt được ghi ở lần chạy vòng lặp kế tiếp, nên có thể lệch tối đa 1 phút.

### 2.4 Kiểm thử
- **Mô phỏng Lua 4** (`qtest\sim_wb.lua`), đều đạt:
  - 18:02 Bàn Cổ xuất hiện, có thông báo toàn server;
  - script chết đã bọc (lấy từ v7) ghi đúng người hạ, giữ nguyên ô của boss khác, phần thưởng gốc vẫn chạy;
  - 18:03 trạng thái "đã bị diệt", có tên người hạ;
  - lệnh bài hiện đúng 2 trang và dịch chuyển tới `NewWorld(1051, 1581, 3410)`.
- **Trên server thật:**
  - 14:14 vòng lặp chạy, `worldboss.txt` được ghi;
  - 14:15 `PTWB_SpawnKey("cuu_linh")` cho NPC 30980, template 86, tại 1016 (1590, 3336), ô 101 = 1.

### 2.5 Sửa lỗi "click lệnh bài không thấy gì" (20:46)
- **Triệu chứng:** log `item_action_diag.log` ghi `ExecuteScript_RESULT … boss_lenhbai.lua … value2=0`, tức `KPlayer::ExecuteScript` trả FALSE vì không tìm thấy script.
- **Nguyên nhân:** khi server quét thư mục script lúc khởi động, thư mục làm việc là thư mục của từng script. `dofile` với đường dẫn tương đối đặt ở đầu file bị lỗi, nên script không được đăng ký.
- **Cách sửa:**
  - Dữ liệu boss được nạp bằng `PTWB_Load()`, gọi bên trong hàm lúc chạy (khi đó thư mục làm việc là Server), không nạp ở đầu file nữa.
  - Đã `ReLoadScript` nóng, không cần khởi động lại.
- **Lưu ý khi viết script rời:** không đặt `dofile` tương đối ở đầu file của script sẽ được đăng ký (script vật phẩm, NPC).

### 2.6 Chọn boss: đi tới boss hoặc gọi boss (20:50)
- **Boss đang sống:** dịch chuyển tới điểm cách chỗ xuất hiện 10 ô. Nếu boss đã đi xa hơn 30 ô thì dịch chuyển tới đúng vị trí hiện tại của boss.
- **Boss chưa tới giờ hoặc đã bị diệt:** `PTWB_Summon` gọi boss ra ngay tại điểm của VNG, thông báo toàn server "… được <người chơi> triệu hồi …", ghi chung các ô GlobalValue với vòng lặp, rồi dịch chuyển tới.
- Mô phỏng Lua 4 đạt cả 3 trường hợp. Đã nạp nóng lúc 20:50.

### 2.7 Phần thưởng khi hạ boss: bảng "Tăng cường" (2026-10-01)
- **Trước đây không rơi đồ** (kiểm chứng):
  - Engine dựng lại không đọc file `npcdroprate-*.ini` nào. Chỉ có `ExecuteScript(m_DropScriptID, "DropRate")` hoặc script gọi `AddItem`/`ThrowItem` mới tạo đồ.
  - Script chết VNG chỉ phát "Đầu …" cho nhiệm vụ (và "Sách chư hầu" với Bất Nghĩa Hầu).
  - Bảng rơi boss gốc của VNG (`npcdroprate-boss1/2/3.ini`) chỉ gồm đồ trắng cấp 1–10, thuốc và pháp bảo rất hiếm (5–50/150.000), **không có bí kíp và đồ lục**.
- **Người dùng chọn "Tăng cường".** Bảng thưởng ở `Server\script\phongthan\boss\wb_loot.lua`, sinh bằng `scratchpad\boss\gen_loot.py`:

| Cấp boss | Đồ trắng VNG | Bí kíp phái | Đồ lục cùng cấp | Pháp bảo / pháp khí / ấn |
|---|---|---|---|---|
| 40 (Cửu Linh) | 2 | 1 | 1 | 10% |
| 60 | 3 | 1 | 1 | 20% |
| 80 | 4 | 1 | 1 | 35% |
| 100 | 5 | 1 | 2 | 50% |

- **Nguồn từng nhóm đồ:**
  - **Đồ trắng:** cùng loại đồ với bảng rơi VNG (vũ khí 0/0–3, áo 2, giày 5, lưng 6, mũ 7, phi phong 9), cấp trang bị 3–5, 5–7, 7–9 và 9–10 theo cấp boss.
  - **Bí kíp:** "Kỹ Năng Quyển" đúng phái người hạ (MagicScript 5624/5625/5626, `GetProfession`).
  - **Đồ lục:** các món của bộ cấp 40/60/80/100 đúng phái, lấy từ `/api/gearsets` của web admin, không gồm bản nhiệm vụ.
  - **Đồ quý:** 100 pháp bảo cấp 10, pháp khí cấp 10 và 10 ấn (144 mã).
- **Cách trao:** `PTWB_GiveLoot` trong `wb_lib.lua` trao thẳng vào túi người hạ đòn cuối, dùng `PTAdm_GiveTo` (AddItem + AddItemID).
  - Chỉ trao **một lần mỗi lượt hạ**, ở lần chạy vòng lặp đầu tiên sau khi script chết đã bọc ghi PlayerIndex người hạ.
  - Boss bị xóa bằng tay (không có người hạ) không có thưởng.
  - Có thông báo riêng cho người hạ; nhận đồ quý thì báo toàn server.
- **Kiểm tra:**
  - Mô phỏng Lua 4: Bàn Cổ cho 4 đồ trắng cấp 7–9, bí kíp Đạo Sĩ, 1 đồ lục cấp 80 đúng phái và 1 pháp khí; chỉ trao 1 lần.
  - Trên server thật lúc 07:52: `AddItem` tạo được đủ mọi mã (đồ trắng 57/57 và 38/38, đồ lục 10/10, bí kíp 3/3, đồ quý 144/144).
  - Đã nạp nóng `wb_lib`, không cần khởi động lại.
- **Lưu ý:** túi đầy thì món đồ không vào được.

## Phần 3: Hành động
- [ ] Tắt server, thoát game, **đóng cửa sổ web admin**, rồi chạy `PhongThan-ChayTatCa.cmd game` để cài ptfix v7 (lệnh bài, script chết bọc) và mở lại web admin.
- [ ] Web admin → tab "Boss thế giới" → chọn nhân vật → "Phát Lệnh Bài Boss Thế Giới". Trong game, click phải lệnh bài, chọn Cửu Linh.
- [ ] Đánh Cửu Linh: tab "Boss thế giới" phải hiện "Đã bị diệt", kèm giờ bị diệt và tên người hạ.

## Phần 4: Tài liệu tham khảo
- Nghiên cứu: `scratchpad\boss\boss_table.json`, `boss_scripts_decoded.txt`, `systemtimetask_loose.txt`.
- Engine: `KItemList::ExecuteScript` (KItemList.cpp 4770: chỉ gọi `main`, không trừ vật phẩm); `PhongThanRunNpcDeathScript` (PhongThanQuestDeathContext.inl: `OnDeath(npc)` với `PlayerIndex` là người hạ); `ReLoadScript` (KSortScript.cpp 283, đọc ưu tiên PAK); `KBPT_MagicScript::FindRecord` (tra theo cột loại chi tiết).
- Backup: `_backup\20260930-worldboss\`.
