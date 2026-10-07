# Đợt Lua "luawave": hook đăng nhập sạch, chuyển sinh, NPC VNG còn thiếu, quái Khoáng trường

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-05 · Agent `luawave`
> Trạng thái: **Đã triển khai và áp nóng lúc 09:09** qua admin bridge. Không cần ptfix, không sửa C++. Chỉ phần mật độ (matdo) của map 1057 cần khởi động lại server mới có hiệu lực.
> Sao lưu: `_backup\20261005-luawave\` (bản gốc của mọi file bị thay, kèm `deploy_log.txt`). Nguồn sinh: `scratchpad\luawave\`.

## Phần 1: Tổng quan

### Insight chính
1. **Hook đăng nhập giờ chạy thật.** `script\player\playerlogin.lua` cũ là tàn dư VLTK: `main()` gọi `split()` ngay dòng đầu nên lần đăng nhập nào cũng dừng, không dòng nào chạy được. Bản mới chỉ gọi hook của dự án, mỗi hook bọc `call()` riêng: quà đăng nhập, lệnh bài, Lệnh Bài Đạo Sĩ/Giáp Sĩ/Dị Nhân (kể cả cài đặt admin đặt lúc vắng mặt), đồng bộ task client. Người chơi nhận ngay khi vào game, không phải đợi tick phút.
2. **Chuyển sinh theo dữ liệu VNG khác với giả định "60/120/180".** VNG ghi rõ điều kiện là **cấp 121** (lời thoại Xích Tinh Tử / Cao Minh). Còn 60/120/180 là cấp mở **kỹ năng chuyển sinh**, tính **sau khi** đã chuyển sinh. Bằng chứng: skills ini của VNG có `NewBirthSkill=1` + `PlayerLevel=60/120`; bảng cấp có cột `newbirthexp`; có file "thuộc tính gốc mới sau chuyển sinh". Vậy VNG cho **cấp quay về 1**. Bản này làm đúng như thế, nhưng giữ nguyên kỹ năng và điểm thưởng.
3. **24 NPC VNG đã đứng đúng chỗ** ở 4 map: Không Tang 1078 (8), Viễn Cổ 1064 (7), Thiên Lao 1060 (6), Trư Lung 1066 (3).
   - Mỗi NPC chạy script VNG gốc trong PAK. Không có file GBK rời nên không cần ptfix.
   - NPC được theo dõi theo **chỉ số dòng**, không theo tên, nên không nhân đôi.
   - Đa Bảo Đạo Nhân **đã có sẵn** ở 1044 (servertimer + `npc_fix\1044_da_bao.lua`), nên không đặt thêm.
4. **Khoáng trường 1057 có 258 quái cấp 20/23**, lấp khoảng cấp 21–24 mà chưa map nào có. Lưu ý: dữ liệu VNG coi 矿场 là bản đồ **không chiến đấu**:
   - Chỉ Nam Châu đặt `SetFightState(0)` khi tới 57, giống các thành.
   - Nhiệm vụ Hoa thần xếp 矿场 ngay sau các thành.

   Quái được thêm theo quyết định của người dùng. Muốn bỏ thì xem Phần 3.

### Nhận định
- Mô phỏng `sim_luawave.lua`: **90 kiểm tra, 0 lỗi**, chạy được ở 4 chế độ: `-Stack 100`, `emu`, `live`, `emu,live`. Các sim liên quan cho kết quả giống hệt bản trước khi sửa (bảng 2.6).
- Áp nóng thành công: `luawave OK npc spawned 24, alive 24/24`, `hot_1057 OK rows=258 added=258 failed=0`. Lệnh kiểm tra lại cũng xác nhận 24 NPC đứng đúng map, 258 quái 1057 còn sống.

## Phần 2: Chi tiết

### 2.1 #1 Hook đăng nhập / đăng xuất
| Mục | Nội dung |
|---|---|
| Engine gọi | `KPlayer::LaunchPlayer` → `ExecuteScript("\script\player\playerlogin.lua", "main")` mỗi lần vào thế giới. `KPlayerSet::PrepareRemove` → `playerlogout.lua` `OnLogout`. Lệnh "offline" của client (`KProtocolProcess`) → `playerlogout.lua` `main`. File loose, không có trong PAK |
| Bản cũ (đã sao lưu) | `Include` các file không tồn tại (`LockIPnguoichoi`, `worldlibrary`, `taskid`…), gọi `split`/`TaoBang`/`SaveData`/`PhongThanGiveStarterPack` (không có), vòng sáng 1565 và reset task của VLTK. Logout gọi `huyhamthu()` và `NewWorld(53,…)` của map VLTK 396 |
| Bản mới | `playerlogin.lua` / `playerlogout.lua` chỉ nạp `script\phongthan\luawave\lw_login.lua` lúc gọi (không dofile ở top-level), rồi `call(PTLW_Login)` |
| Việc làm khi đăng nhập (mỗi bước một `call` riêng) | 1. Ghi `admin_bridge\login.log`. 2. Quà tân thủ (`newbie\starter_gear.lua`, task 1950). 3. Lệnh Bài Luyện Công (2610). 4. Lệnh Bài Nhiệm Vụ / Tiếp Tế (2611/2612). 5. `PTLB_TickOne`: cài đặt admin chờ trong `lbdaosi_pending.txt`, lệnh bài theo phái, gửi task 2613/2614/2619/2617 xuống client. 6. `PTHT_SyncAll`: gửi task Hành Trang 2640, 2645, buff IB. 7. Quà đăng nhập ngày + 7 ngày (`content\dg_lib.lua` `PTDG_Player`) |
| Lỗi | Ghi vào `admin_bridge\login_error.log`; các bước sau vẫn chạy |
| Tick phút | Không đổi. `ext\luawave.lua` xóa bảng pending lbdaosi/hanhtrang trong state servertimer mỗi phút, buộc đọc lại file, nên cài đặt đã áp lúc đăng nhập không bị áp lần hai |
| Bỏ đi | Mọi phần VLTK (khóa IP, `print`, Msg2SubWorld "vừa vào game", túi máu 0/2/0, gói UAT tài khoản 123456 gọi native không tồn tại) |

### 2.2 #6 Chuyển sinh
**Nguồn VNG:**
- Bảng chuỗi 6f91bd22: 赤精子 / 高明 là "接引人"; điều kiện "人界等级达到121级" + 5000 danh vọng phe; "转生后获得20点潜能点".
- `serverlist.pak \settings\npc\player\转生初始属性设定.ini`: `MAXREBIRTHTIMES=3`; mỗi thuộc tính +50/+20/+20 cho lần 1/2/3.
- File 62e777bc: thuộc tính gốc mới theo phái, `NewBirthPoint=20`.
- `vng00.pak` skills ini và bảng cấp.

| Mục | Quy tắc |
|---|---|
| NPC | **Xích Tinh Tử** (Ngọc Hư 1003, Tiên giới), **Cao Minh** (Xi Vưu 1004, Ma giới): thêm dòng "Chuyển sinh", hiện khi cấp ≥ 100 hoặc đã chuyển sinh. **Chuyển Sinh Lão Lão** (5 thành; trước đây là NPC giữ chỗ ghi "chưa đổi cấp"): thêm dòng "Chuyển sinh", cho chọn Tiên/Ma nếu chưa có phe |
| Điều kiện | Cấp ≥ 121 (`PTCS_LV = {121,121,121}`), tối đa 3 lần. Không trái phe đã chọn (task 2800) và không trái phe Tiên Ma giới của tienma (2252, chỉ đọc). Danh vọng phe 5000 của VNG không có trên server này nên không đòi |
| Hiệu quả | `AddTranslife(1)`, rồi `SetLevel(1)` (kinh nghiệm về 0). Khôi phục **mọi kỹ năng** đúng cấp (cách web admin "level") và **điểm kỹ năng chưa cộng**. 4 thuộc tính gốc = giá trị VNG theo phái + thưởng lần (bảng dưới). Điểm tiềm năng = 20 (VNG) + **điểm thưởng ngoài cấp** (vật phẩm, nhiệm vụ) để không mất gì đã kiếm |
| Xác nhận | 2 bước (menu → "Ta muốn chuyển sinh" → "Xác nhận chuyển sinh", có cảnh báo về cấp 1 và trang bị cấp cao) |
| Nhật ký | `admin_bridge\chuyensinh.log`: dòng trước/sau (cấp, kinh nghiệm, thuộc tính, điểm, danh sách kỹ năng) để admin dựng lại nếu cần |
| Task | 2800 phe (1 Tiên, 2 Ma), 2801 cấp trước lần chuyển sinh gần nhất, 2802 ngày (yyyymmdd). Đã quét: không script rời/PAK nào dùng |

| Phái | Lần 1 (Str/Dex/Vit/Eng) | Lần 2 | Lần 3 |
|---|---|---|---|
| Giáp Sĩ | 400/250/350/200 | 420/270/370/220 | 440/290/390/240 |
| Đạo Sĩ | 300/200/250/450 | 320/220/270/470 | 340/240/290/490 |
| Dị Nhân | 350/250/300/300 | 370/270/320/320 | 390/290/340/340 |

- Biểu tượng chuyển sinh trên đầu chỉ hiện sau khi thoát game vào lại, vì `AddTranslife` không gửi xuống client. Hộp thoại có nhắc điều này.
- Sách kỹ năng chuyển sinh 1481–1489 vẫn chỉ xét cấp 60/120/180 như trước, không đòi đã chuyển sinh, để không khóa kỹ năng người chơi đã học.
- VNG nhân đôi kinh nghiệm sau chuyển sinh (cột `newbirthexp`). Bản này **chưa làm**: `level_exp.txt` của server chỉ có 2 cột, muốn làm phải đưa cả server lẫn client vào ptfix.

### 2.3 #10 NPC còn thiếu (ext `luawave`, tick phút)
Tọa độ: VNG không còn dữ liệu đặt NPC cho các map này (Region_S trống; taskinfo/hyperlink không có map 57/60/64/66/78). Vì vậy chọn ô **đi được trên cả lưới server (Region_S) lẫn client (Region_C)**:
- cùng vùng liên thông với điểm đến hoặc điểm hồi sinh;
- không nằm trên ô bẫy;
- cách nhau ≥ 3 ô.

Script `scratchpad\luawave\pos\positions.py`. Mẫu NPC lấy theo NPC cùng tên đang có trên server; tên TCVN3 lấy từ bảng tên VNG aa7f6d50.

| Map | NPC | Mẫu | Tọa độ (điểm / hiển thị) | Script |
|---|---|---|---|---|
| 1078 Không Tang | Ngô Long | 156 | 1602,3182 / 200,198 | `\script\空桑\吴龙.lua` |
| 1078 | Thường Hạo | 156 | 1606,3181 / 200,198 | `空桑\常昊.lua` |
| 1078 | Đái Lễ | 181 | 1610,3182 / 201,198 | `空桑\戴礼.lua` |
| 1078 | Chu Tử Chân | 180 | 1614,3184 / 201,199 | `空桑\朱子真.lua` |
| 1078 | Dương Hiển | 183 | 1616,3188 / 202,199 | `空桑\杨显.lua` |
| 1078 | Kim Đại Thăng | 184 | 1616,3192 / 202,199 | `空桑\金大升.lua` |
| 1078 | Viên Hồng | 190 | 1614,3196 / 201,199 | `空桑\袁洪.lua` |
| 1078 | Linh Sơn Lão Ông | 165 | 1611,3199 / 201,199 | `空桑\灵山老翁.lua` |
| 1064 Viễn Cổ | Dung Thành Tử | 202 | 1604,3244 / 200,202 | `\script\远古\容成子.lua` (ptfix: về Diêu Trì, vào 3 doanh) |
| 1064 | Thiếu Hạo | 171 | 1567,3236 / 195,202 | `luawave\lw_1064_thieu_hao.lua` → doanh tây (1397,3207) |
| 1064 | Chúc Dung | 172 | 1586,3215 / 198,200 | `luawave\lw_1064_chuc_dung.lua` → doanh bắc (1565,3056) |
| 1064 | Khoa Phụ | 175 | 1602,3227 / 200,201 | `luawave\lw_1064_khoa_phu.lua` → doanh đông (1802,3232) |
| 1064 | Đại Phu | 766 | 1582,3253 / 197,203 | `远古\医生.lua` (cửa hàng 15) |
| 1064 | Thủ Khố | 768 | 1590,3246 / 198,202 | `远古\仓库管理员.lua` (rương, cần task 13/23/33 = 2) |
| 1064 | Chiến Hồn | 529 | 1580,3220 / 197,201 | `远古\战魂.lua` (tế lễ, task 822/823) |
| 1060 Thiên Lao | Đại Phu | 766 | 1551,3309 / 193,206 | `\script\天牢\医生.lua` (cửa hàng 16, bật chiến đấu) |
| 1060 | Thủ Khố | 768 | 1563,3309 / 195,206 | `天牢\仓库管理员.lua` |
| 1060 | Rương Chứa Đồ | 1759 | 1567,3312 / 195,207 | `天牢\储物箱.lua` |
| 1060 | Hình Thiên | 176 | 1549,3323 / 193,207 | `天牢\刑天.lua` (VNG để trống hội thoại) |
| 1060 | Xi Vưu | 211 | 1557,3327 / 194,207 | `luawave\lw_1060_xi_vuu.lua` (Include `天牢\蚩尤.lua` + `GetCheatTime` dự phòng = 0) |
| 1060 | Lộc Tinh | 206 | 1565,3325 / 195,207 | `天牢\禄星.lua` (Nguyên Bảo) |
| 1066 Trư Lung | Bao Trư Công | 156 | 1646,3243 / 205,202 | `\script\猪笼城寨\包猪公.lua` |
| 1066 | Bao Trư Bà | 165 | 1650,3245 / 206,202 | `猪笼城寨\包猪婆.lua` |
| 1066 | Đại Phu | 766 | 1634,3255 / 204,203 | `猪笼城寨\医生.lua` (cửa hàng 1) |

**Điểm khác VNG có chủ ý (Viễn Cổ):** 少昊/祝融/夸父 của VNG gọi `SetCamp(2/3/4)` vĩnh viễn và `SetRevPos(64, …)` theo số map VNG.
- Đổi camp vĩnh viễn sẽ làm tổ đội bot coi người chơi là địch, nên 3 wrapper giữ đúng hội thoại VNG (chuỗi 10600/10622/10594) và đúng điểm nhảy vào doanh, nhưng **không đổi camp và không đổi điểm hồi sinh**.
- Điểm nhảy của Khoa Phụ được dời 1 ô (1801 → 1802) để khỏi đứng lên dải bẫy.

### 2.4 Khoáng trường 1057
| Mục | Nội dung |
|---|---|
| File | `script\phongthan\spawn\spawn_1057.lua`, 258 dòng: 148 Ngưu Sát (mẫu 12, cấp 20, gần lối vào) + 110 Dạ Xoa (mẫu 15, cấp 23, phía xa) |
| Cách sinh | Bản sao `gen_spawn_v2.py` (cùng mật độ 311 ô/quái, cùng tỉ lệ nhóm 70/19/7/3, lưới Region_C + Region_S). Không quái nào trong bán kính 18 ô quanh điểm hồi sinh (1607,3102), Hoa thần Cửu Di (1599,2959) và điểm đến từ Ngọc Hư (1608,3094) |
| Vì sao cấp 20/23 | Phía Ngọc Hư có 1008 (cấp 3/7), 1010 (7/10), 1009 (12/15). 1014 Đồng Quan cấp 15/20, 1017 Kỳ Sơn cấp 25/27. Chưa map nào có quái cấp 21–24. Hai mẫu đều là mẫu Region_S gốc VNG (1014/1016) và có death script trong ptfix (tính kill Trừ Yêu) |
| Đăng ký | `spawn_main.lua`: thêm 1057 vào `PT_SPAWN_MAPS`. `matdo.lua`: `PTMD_MAPS[58] = 1057`, sinh lại bằng `scratchpad\matdo\gen_matdo.py`. Bot tổ đội: `PTBP_MAPS[1057] = 1` (sửa `scratchpad\botparty\src\party.lua`, chạy `gen.py`; trước khi sửa đã kiểm tra out = runtime; diff chỉ đúng 1 dòng). Đã gán nóng `PTBP_MAPS[1057]` |
| Lệnh Bài Luyện Công | **Chưa thêm.** `gen.py` cố định đúng 20 bãi (4 trang × 5). Khung 20–24 hiện là 1015 Mạnh Tân; thêm 1057 tức là phải bỏ Mạnh Tân. Nếu muốn đổi: `pick.py` dòng 19 → `(20, 24, 1057, [20, 23], "Khoáng trường")`, bãi đề xuất 1599,3199 [199,199] |
| Web admin mật độ | `$MatDoMaps` trong `PhongThan-Admin.ps1` chưa có 1057. Không sửa, vì agent natives đang sửa web admin |

### 2.5 Tệp đã sửa / thêm (runtime `PhongThanRuntime-Staging\Server\`)
| Tệp | Loại |
|---|---|
| `script\player\playerlogin.lua`, `playerlogout.lua` | Thay (bản cũ trong backup) |
| `script\phongthan\luawave\lw_login.lua`, `cs_lib.lua`, `lw_1064_thieu_hao.lua`, `lw_1064_chuc_dung.lua`, `lw_1064_khoa_phu.lua`, `lw_1060_xi_vuu.lua` | Mới |
| `script\phongthan\ext\luawave.lua` | Mới (tick NPC) |
| `script\phongthan\npc_fix\1003_xich_tinh_tu.lua`, `1004_cao_minh.lua` | Thêm dòng "Chuyển sinh" (sửa mức byte) |
| `script\phongthan\npc_restore\1002_14.lua`, `1003_09.lua`, `1004_10.lua`, `1020_11.lua`, `1021_13.lua` | Chuyển Sinh Lão Lão: dòng "Chuyển sinh", sửa lời giới thiệu |
| `script\servertimer.lua` | `PTADM_EXT_NAMES` += `"luawave"` (chỉ dòng đó, đọc lại ngay trước khi ghi) |
| `script\phongthan\spawn\spawn_1057.lua` (mới), `spawn_main.lua`, `ext\matdo.lua`, `bots\party.lua` | Khoáng trường |
| Scratchpad | `matdo\gen_matdo.py`, `botparty\src\party.lua` + `out\party.lua` (bản cũ `.bak_luawave`), `qtest\sim_matdo.lua` (đếm 57 → 58 map) |

### 2.6 Mô phỏng (PowerShell 32-bit)
| Lần chạy | Kết quả |
|---|---|
| `sim_luawave.lua -Stack 100` / `-Stack 0 -Args1 emu` / `live` / `emu,live` | 90/90, FAILS = 0 (emu: dư ≥ 40 khung ở mọi lối vào) |
| `sim_content` live, emu+live | FAILS = 0 |
| `sim_matdo` live, emu+live | FAILS = 0, sau khi đổi số map kỳ vọng 57 → 58 |
| `sim_botparty` (thường/emu), `sim_botheal` | pass 37/fail 14 và 115/14, **giống hệt khi chạy với `party.lua` gốc**. Các lỗi có từ trước, không liên quan 1057 |
| `sim_newbie2` (stack mặc định) | FAILS = 0. `-Stack 100` thuần tràn stack như ghi chú cũ của newbie2; không file nào của newbie2 bị đụng |

Các trường hợp `sim_luawave` kiểm:
- **Đăng nhập:**
  - lần đầu nhận đủ quà, lệnh bài, đồng bộ task;
  - lần hai trong ngày không nhận lại;
  - pending admin được áp rồi xóa khỏi file (giữ dòng của người khác);
  - túi đầy thì quà xếp hàng, lần sau mới nhận;
  - một hook lỗi thì các bước khác vẫn chạy;
  - đăng xuất / offline có ghi log.
- **NPC:**
  - lần đầu sinh đủ 24, lần sau không nhân đôi, dofile lại cũng không nhân đôi;
  - mất 1 NPC thì sinh lại đúng 1;
  - map chưa nạp thì không lỗi;
  - các wrapper không đổi camp; Xi Vưu hiện thời gian giam = 0.
- **Chuyển sinh:**
  - dòng menu ẩn/hiện đúng;
  - lần 1, 2, 3 đúng thuộc tính, giữ kỹ năng, giữ điểm kỹ năng và điểm thưởng; lần 4 bị từ chối;
  - từ chối khi cấp thấp, sai phe, phe Tiên Ma giới ngược, hoặc `AddTranslife` không ăn (không có gì thay đổi);
  - Lão Lão cho chọn phe.

## Phần 3: Hành động

### Đã xong
- [x] Sao lưu → chép runtime → áp nóng 09:09 (pending.lua được tạo khi file chưa tồn tại). Đã kiểm tra lại lúc 09:10: 24/24 NPC, 258/258 quái 1057.
- [x] CHANGELOG `[COMPLETED]`, mục lục README.

### Người dùng kiểm tra trong game
- [ ] Thoát game rồi vào lại: `admin_bridge\login.log` có dòng `login <tên>`; lệnh bài/quà còn thiếu được phát ngay; `login_error.log` trống.
- [ ] Ngọc Hư → Xích Tinh Tử (hoặc Chuyển Sinh Lão Lão): dòng "Chuyển sinh" → "Điều kiện và phần thưởng". **Chỉ xác nhận chuyển sinh khi chấp nhận về cấp 1.** Nếu lỡ tay: dòng "before" trong `chuyensinh.log` đủ để dựng lại bằng web admin (level, kỹ năng, điểm).
- [ ] Không Tang (vào từ Lưu Ba sơn): 8 NPC quanh điểm đến. Viễn Cổ (Tây Vương Mẫu): Dung Thành Tử, 3 người dẫn doanh, Đại Phu, Thủ Khố, Chiến Hồn.
- [ ] Khoáng trường: quái cấp 20/23, khu Hoa thần và điểm đến không có quái.

### Cần khởi động lại (không gấp)
- [ ] matdo mới nhận 1057 sau khi khởi động lại (bảng map/seed của matdo dựng một lần). Lúc đó `spawn_main` tự sinh 1057. Bản nóng không chạy lại, vì `pending.lua` đã tiêu thụ.
- [ ] Muốn chỉnh mật độ 1057 trên web admin: thêm 1057 vào `$MatDoMaps` (`PhongThan-Admin.ps1` dòng ~579) khi agent natives xong, rồi người dùng tự mở lại web admin.

### Gỡ / đổi
- Bỏ quái 1057 ngay: gửi `PTH57_Clear()` qua bridge, rồi bỏ 1057 khỏi `PT_SPAWN_MAPS`, `PTMD_MAPS`, `PTBP_MAPS`.
- Đổi điều kiện cấp chuyển sinh: `PTCS_LV` trong `scratchpad\luawave\gen_luawave.py` (ví dụ `{60, 120, 180}`). Chạy lại generator, chép `cs_lib.lua`; có hiệu lực ngay ở lần bấm NPC tiếp theo của state mới (hoặc `ReLoadScript` script NPC).
- Rollback toàn bộ: chép `_backup\20261005-luawave\Server\*` về runtime, xóa các file đánh dấu `.NEW`, bỏ `"luawave"` khỏi `PTADM_EXT_NAMES`.

## Phần 4: Tài liệu tham khảo
- `de-xuat-khoang-trong-vng-phong-than-20261004.md` (mục #1, #5/#6, #7/#10, map trống), `ky-nang-chuyen-sinh-60-120-180-phong-than-20261001.md`, `noi-dung-moi-phong-than-20261004.md` (quà đăng nhập), `lenh-bai-dao-si-phong-than-20261004.md`, `hanh-trang-phong-than-20261004.md`, `mat-do-hoi-quai-phong-than-20261004.md`, `to-doi-bot-phong-than-20261003.md`, `vien-co-giang-son-phong-than-20261003.md`.
- Mã nguồn: `KPlayer.cpp` (`LaunchPlayer` 6400, `SetLevel` 4511), `KPlayerSet.cpp` (`PrepareRemove`), `ScriptFuns.cpp` (`LuaAddPlayerTranslifeValue`, `LuaAddPropPoint`, `LuaSetPlayerStrength`, `LuaAddMagicPoint`), `CoreUseNameDef.h` (`LOGIN_SCRIPT`).
- Scratchpad: `luawave\gen_luawave.py`, `patch_npcs.py`, `deploy_luawave.py`, `mkhot.py`, `pos\`, `m1057\`, `qtest\sim_luawave.lua`.
