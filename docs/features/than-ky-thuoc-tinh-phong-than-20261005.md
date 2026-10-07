---
tinh-nang: Thần Kỹ (kỹ năng VNG 1986–2000) và 14 Viên / Túi Thuộc Tính
ngay: 2026-10-05
agent: thanky (việc #4 trong báo cáo khoảng trống VNG)
trang-thai: Đã làm, chờ cài ptfix. Script rời, móc boss thế giới và web admin đã đặt vào runtime; ptfix build thử đạt; sim 41/0 (cả -Stack 100 và EMU), admin 14/0 + 8/0.
tom-tat: 6 Thần Kỹ VNG có đủ dữ liệu kỹ năng ở hai phía nhưng thiếu toàn bộ script (sách chỉ là bản khóa BLOCKED_SPEC, script chỉ số cấp không tồn tại). Đã viết lại 40 sách, 6 loại mảnh ghép sách, 12 viên + 2 túi thuộc tính, 9 script chỉ số kỹ năng, nguồn nhận ở Kỳ Trân Các, boss thế giới và web admin. Không cần native mới, không sửa C++.
---

# Thần Kỹ và Viên Thuộc Tính — Phong Thần (bản local)

## Phần 1: Tổng quan

### Insight chính
1. **Kỹ năng Thần Kỹ đã có nhưng "rỗng".** Các dòng 1986–2000 của `skills.txt` có ở cả Server lẫn Client, đủ biểu tượng, đạn (`Missles.txt` 325–334) và hình ảnh. Tuy vậy, 9 script chỉ số cấp (`\script\skill\giapsy|daosy|dinhan\*.lua`) không có trong PAK nào. Vì thế kỹ năng nạp lên mà không có sát thương hay tiêu hao.
2. **Sách và viên chỉ là bản khóa.** 54 script ở `script\vnevent\features\thanky\` và `thuoctinh\items\` đều là bản `BLOCKED_SPEC ... item was not consumed`. Không có script VNG gốc nào trong dữ liệu local. Cũng không có script VNG nào phát các vật phẩm này: đã quét toàn bộ script rời và PAK, không tìm thấy lệnh nào.
3. **Hai lỗi engine chặn Thần Kỹ, cả hai sửa được bằng dữ liệu, không cần C++:**
   - `KSkill::IsBase()` coi `Attrib <= 1` là kỹ năng cơ bản và ẩn nó khỏi ô kỹ năng chuột. Huyết Nguyệt Trảm (1986) có Attrib 1, nên đã đổi thành 2 trong ptfix.
   - Tên thuộc tính VNG `skill_eventskilllevel` chỉ được engine đổi sang `skill_reserve2` với kỹ năng phái (3–51). Vì vậy chiêu nối (Huyết Nguyệt Trảm 1–3, Phật Nộ Hỏa Liên 2…) luôn ở cấp 1. Các dòng 1986–2000 trong ptfix đã ghi thẳng `skill_reserve2`, nên chiêu nối tăng theo cấp chiêu chính.
4. **Viên Thuộc Tính cộng điểm gốc thật** bằng `AddProp(n)` + `AddStrg/AddEng/AddVit/AddDex(n)`, đúng cách web admin đang làm. Điểm được lưu cùng nhân vật, nên còn nguyên sau khi đăng nhập lại. Mỗi chỉ số cộng tối đa 100 điểm từ viên, đếm ở task 2690–2693.

### Nhận định quan trọng
- Chưa có thông số VNG gốc (tỉ lệ, cấp yêu cầu, số điểm). Các con số dưới đây là **thiết kế mới cho người chơi một mình**, có thể chỉnh trong `scratchpad\thanky\gen.py` rồi sinh lại.
- Thần Kỹ không có ô trong cửa sổ kỹ năng F5, vì ô của client viết cứng (giống kỹ năng chuyển sinh). Kỹ năng vẫn chọn được ở **ô kỹ năng chuột**.

## Phần 2: Chi tiết

### 2.1 Danh sách Thần Kỹ

| Kỹ năng (chiêu nối) | Phái | Sách cấp 1 / 2 / 3 / 4 / 5 (magicscript 6/1/…) | Mảnh | Chuột | Chỉ số cấp L (1–10) |
|---|---|---|---|---|---|
| 1986 Huyết Nguyệt Trảm (1987–1989) | Giáp Sĩ | 8375 / 8381, 8621 / 8387 / 8393 / 8399 | 8352 | trái hoặc phải | vật lý +120+12L% (chiêu nối +60+6L%, +80+8L%), nội lực 30+3L; cần vũ khí loại 1 như VNG (EqtLimit 1) |
| 1996 Huyền Ảnh Tàn Hoa (1997–1999) | Dị Nhân | 8376 / 8382, 8622 / 8388 / 8394 / 8400 | 8353 | phải | vật lý +80+8L%, giảm chí mạng phép của đối phương 5+L, nội lực 40+3L (VNG không có) |
| 1990 Phật Nộ Hỏa Liên (2000) | Đạo Sĩ | 8377, 8360 / 8383, 8623 / 8389 / 8395 / 8401 | 8354 | phải | hỏa 400+50L – 600+70L (L10: 900–1300), nội lực 50+4L |
| 1991 Lôi Hỏa Toàn Phong (1992) | Đạo Sĩ | 8378, 8361 / 8384, 8624 / 8390 / 8396 / 8402 | 8355 | phải | lôi 100+20L – 700+90L, tăng hiệu quả hỏa 10+2L%, nội lực 50+4L |
| 1993 Truy Hồn Tán Hoa | Đạo Sĩ | 8379, 8362 / 8385, 8625 / 8391 / 8397 / 8403 | 8356 | phải | băng 350+45L – 550+65L, làm chậm 30+3L khung, nội lực 50+4L |
| 1994 Vạn Kiếm Quy Tông (1995) | Đạo Sĩ | 8380, 8363 / 8386, 8626 / 8392 / 8398 / 8404 | 8357 | phải | thổ 300+40L – 500+60L, bỏ qua phòng thủ 10+2L%, nội lực 50+4L |

- **Nguồn VNG:** dòng magicscript 8352–8357, 8360–8363, 8375–8404, 8621–8626 trong `vng00.pak`. Script VNG là bản khóa LUA-1518…1562. Kỹ năng 1986–2000 lấy từ `skills.txt` của `vng00.pak`, mô tả có ghi "(VNG)".
- **Sách** (`PTTK_UseBook`):
  - Kiểm tra đúng phái và cấp nhân vật ≥ 60.
  - Sách cấp 1–4: học, hoặc nâng lên đúng cấp sách. Sách cấp 5: nâng lên 5; nếu kỹ năng đã từ cấp 5 thì mỗi cuốn +1 cấp, tối đa 10.
  - Sách cấp thấp hơn hoặc bằng cấp hiện có thì không mất.
  - Chỉ xóa sách khi `GetMagicLevel` xác nhận cấp mới. `AddMagic` gửi gói kỹ năng xuống client, nên kỹ năng hiện ngay ở ô chuột.
- **Mảnh** (`PTTK_UseManh`): trong một chồng đủ 30 mảnh thì nhấp phải để ghép. Sách nhận được:
  - chưa học: sách cấp 1;
  - đang ở cấp L: sách cấp L+1, tối đa cấp 5;
  - mảnh của phái khác: sách cấp 1 (đem cho hoặc đổi được).
  - Mảnh chỉ bị trừ sau khi sách đã vào túi. Cần 1 ô trống.
- Sách, viên, túi trong ptfix đều **vĩnh viễn** (VNG để viên 30 ngày, túi 7 ngày), không bị engine tự tiêu.

### 2.2 Viên / Túi Thuộc Tính

| Mã | Vật phẩm (VNG) | Tác dụng | Ô F3 |
|---|---|---|---|
| 6855 / 6856 / 6857 | Viên Sức Mạnh-Sơ / Trung / Cao | +2 / +5 / +10 vĩnh viễn | Sức mạnh |
| 6858 / 6859 / 6860 | Viên Ngộ Tính-Sơ / Trung / Cao | +2 / +5 / +10 | Nội công |
| 6861 / 6862 / 6863 | Viên Thể Chất-Sơ / Trung / Cao | +2 / +5 / +10 | Sinh khí |
| 6864 / 6865 / 6866 | Viên Thân Pháp-Sơ / Trung / Cao | +2 / +5 / +10 | Thân pháp |
| 6854 | Túi Thuộc Tính | 1 viên ngẫu nhiên: Sơ 60%, Trung 30%, Cao 10%, chỉ số ngẫu nhiên | – |
| 6982 | Túi Thuộc Tính (Trung) | 1 viên: Trung 70%, Cao 30% | – |

- **Nguồn VNG:** magicscript 6854–6866 và 6982, sprite `\spr\item\vng\20160325\` và `20161101\`. Script VNG là bản khóa LUA-1568…1581.
- **Giới hạn:** mỗi chỉ số cộng tối đa 100 điểm từ viên (task 2690 Sức Mạnh, 2691 Ngộ Tính, 2692 Thể Chất, 2693 Thân Pháp). Viên cuối chỉ cộng phần còn thiếu. Khi đã đủ 100 thì viên không mất.
- **Điểm tiềm năng không đổi.** Nếu chỉ số không tăng (lỗi engine), điểm tiềm năng được trả lại đúng như trước và viên không mất.
- "Tẩy điểm" (`ResetProp`) trả cả điểm từ viên về thành điểm tiềm năng, nên không mất điểm. Bộ đếm task vẫn giữ nguyên.

### 2.3 Nguồn nhận trong game (người chơi một mình)
- **Kỳ Trân Các (F2), tab 8 "Đặc biệt"**, 8 ô đầu:
  - 6 loại Mảnh Thần Kỹ, mỗi lượt mua 10 mảnh, tự gộp chồng 250;
  - Túi Thuộc Tính và Túi Thuộc Tính (Trung).
  - Giá theo quyết định hiện hành: 1 lượng mỗi món (`PHONGTHAN_IBSHOP_UNIT_PRICE`).
- **Boss thế giới**, phần thưởng cho người hạ đòn cuối:
  - Mảnh Thần Kỹ của một kỹ năng đúng phái: 3 / 5 / 8 / 12 mảnh theo bậc boss 40 / 60 / 80 / 100.
  - Túi Thuộc Tính: 30 / 40 / 50 / 60%.
  - Túi Thuộc Tính (Trung): 0 / 0 / 10 / 25%.
  - Phần này chạy trong `call(..., "x", PTAdm_TickErr)`: lỗi chỉ ghi `tick_error.log`, không làm dừng vòng boss hay cầu nối admin.
- **Web admin** → tab "Bí kíp / Kỹ năng" → thẻ "Thần Kỹ & Viên Thuộc Tính":
  - Phát sách theo cấp 1–5, phát mảnh, dạy ngay cấp 1–10.
  - Phát viên / túi, xem cấp Thần Kỹ và số điểm đã cộng.
  - Lệnh "Tăng level" giờ giữ lại cả Thần Kỹ 1986–2000.

### 2.4 Tệp đã sửa / thêm

| Tệp | Thay đổi | Sao lưu |
|---|---|---|
| `scratchpad\ptfix\extra_thanky.py` | Mới. Plug-in ptfix: 53 script, 60 dòng magicscript, 15 dòng `skills.txt`, 8 dòng `ibshopgoods.txt` + tab `specialgoods.txt`. Chạy sau `extra_kytrancac.py` | (file mới) |
| `scratchpad\thanky\gen.py`, `thanky_data.json`, `out\` | Mới. Sinh mọi Lua (ASCII, TCVN3 dạng `\ddd`) và dữ liệu plug-in | (file mới) |
| `Server\script\phongthan\thanky\tk_lib.lua`, `tk_manh.lua`, `tk_boss.lua` | Mới, script rời (đăng ký khi khởi động server) | (file mới) |
| `Server\script\phongthan\boss\wb_lib.lua` | Thêm 7 dòng móc `PTTK_BossLoot` trong `PTWB_GiveLoot`, chạy có bảo vệ | `_backup\20261005-thanky\wb_lib.lua` |
| `AdminWeb\PhongThan-Admin.ps1` | Thêm `$ThanKy`, `$ThanKyStones`, hành động `thanky` (book / manh / teach / stone / info); `level` giữ 1986–2000. Vẫn thuần ASCII | `_backup\20261005-thanky\PhongThan-Admin.ps1` |
| `AdminWeb\index.html` | Thẻ "Thần Kỹ & Viên Thuộc Tính" trong tab Bí kíp / Kỹ năng | `_backup\20261005-thanky\index.html` |

- Không sửa script rời BLOCKED_SPEC nào. Bản trong ptfix đè lên chúng (PAK đọc trước), còn file rời giữ nguyên để đường dẫn vẫn được đăng ký lúc khởi động.
- Không ghi `admin_bridge\pending.lua`. Không động vào GameServer, LocalDB, C++.

### 2.5 Kiểm thử
- **`qtest\sim_thanky.lua`:** 41 kiểm tra, FAILS=0 ở cả `-Stack 100` và EMU (khoảng trống nhỏ nhất 46 khung). Chạy lại trên file đã đặt vào runtime (`live`, `emu live`): cũng 41/0.
  - 72 giá trị chỉ số cấp của 9 script khớp bảng sinh.
  - Đủ 40 sách: đúng phái thì học đúng cấp; khác phái thì từ chối. Cấp 59 từ chối; sách trùng VNG 8360/8623 chạy như bản chính; nhảy cấp 2→4; cấp 5 lên dần tới 10; `AddMagic` không có tác dụng thì giữ sách.
  - Mảnh: 29 mảnh từ chối; 30 mảnh ra sách cấp 1 và chồng biến mất; 75 mảnh ở cấp 2 ra sách cấp 3, còn 45; túi đầy hoặc thêm lỗi thì giữ mảnh; 6 loại × cấp 0..6.
  - Viên: +2 đúng chỉ số, điểm tự do không đổi; 95/100 chỉ +5; 100/100 từ chối; lỗi thì trả điểm; đủ 12 viên; nạp lại script (giả lập đăng nhập lại) bộ đếm vẫn tiếp tục.
  - Túi: 3.000 lần mở ra 1784 / 915 / 301 (Sơ / Trung / Cao), chỉ ra mã viên. Túi (Trung) không bao giờ ra Sơ.
  - Boss: bậc 100 Đạo Sĩ ra 12 mảnh. `PTWB_GiveLoot` đã vá vẫn phát đồ VNG cộng thêm mảnh; lỗi trong phần Thần Kỹ bị bắt và đồ VNG vẫn được tính.
- **`qtest\test_admin_thanky.ps1`:** 14/0, gồm PS1 0 lỗi cú pháp, thuần ASCII, đúng mã vật phẩm, từ chối lựa chọn rỗng, `level` giữ 1986–2000.
- **`qtest\sim_thanky_admin.lua`:** Lua do web admin sinh, chạy trong state `servertimer.lua`: 8/0. Phát sách, mảnh xếp chồng, viên, dạy cấp 7, xem thông tin, đổi level vẫn giữ Thần Kỹ, người chơi offline thì FAIL.
- **JavaScript `index.html`:** `node --check` đạt.
- **Build thử** (Client trước, Server sau): `scratchpad\thanky\ptfix_test_client.pak` 104 mục, `ptfix_test.pak` 679 mục, đủ 33 plug-in. `thanky\verify.py` 0 lỗi:
  - không thiếu mục nào so với v27 và bản build thử kytrancac r2;
  - chỉ đổi 4 bảng chung, thêm đúng 53 script;
  - Server và Client giống hệt nhau;
  - mô phỏng `KBuySell::Init`: tab Đặc biệt ô 0–7 là 8 món mới, các tab khác không lệch, ô Truyền Tống tổng hợp chuyển sang hàng 484.

### 2.6 Native còn thiếu
- **Không cần native mới.** Mọi hàm đã có: `AddMagic`, `HaveMagic`, `GetMagicLevel`, `SetSkillLevel`, `GetStackItem`, `RemoveItem`, `AddNormalItem(Pile)`, `CalcFreeItemCellCount`, `AddProp`, `AddStrg/Eng/Vit/Dex`, `GetStrg/Eng/Vit/Dex`, `GetProp`, `GetTask/SetTask`.
- **Đề xuất C++ (không bắt buộc, cho agent natives):**
  - `KSkillList::RollBackSkills` (tẩy điểm kỹ năng, `SetLevel`) đưa Thần Kỹ về 0 và hoàn điểm kỹ năng như mọi kỹ năng không phải "cơ bản". Nên bỏ qua 1986–2000 (và 1478–1489). Web admin đã tự giữ lại khi đổi level.
  - Nếu muốn Thần Kỹ hiện trong cửa sổ F5 thì phải thêm ô ở giao diện client.

## Phần 3: Hành động
- [ ] **Coordinator:** build ptfix chính thức (v28, có `extra_thanky.py`; Client trước, Server sau), cài cho Server và Client, rồi khởi động lại GameServer. Script rời `script\phongthan\thanky\*.lua` và `wb_lib.lua` đã vá chỉ có hiệu lực sau lần khởi động này.
- [ ] **Người dùng:** đóng và mở lại web admin (không khởi động từ shell của Claude), F5 trình duyệt.
- [ ] Đạo Sĩ cấp ≥ 60: F2 → tab Đặc biệt → mua 30 Mảnh Phật Nộ Hỏa Liên → gộp một chồng → nhấp phải ra sách cấp 1 → nhấp phải sách → ô kỹ năng chuột phải có Phật Nộ Hỏa Liên → đánh thử (có sát thương, tốn nội lực).
- [ ] Web admin: dạy Phật Nộ Hỏa Liên cấp 10 → rê chuột xem chỉ số (hỏa 900–1300) → đánh thử chiêu nối.
- [ ] Giáp Sĩ: cầm vũ khí loại 1 (như khi dùng Lạc Địa Trảm) → học Huyết Nguyệt Trảm → kiểm tra hiện ở ô chuột trái/phải.
- [ ] Mua Túi Thuộc Tính → mở → dùng viên → F3 thấy chỉ số gốc tăng, điểm tiềm năng không đổi → thoát game vào lại, chỉ số vẫn còn → web admin "Xem cấp Thần Kỹ & điểm đã cộng".
- [ ] Hạ một boss thế giới: túi nhận thêm mảnh đúng phái (và có thể có Túi Thuộc Tính).

## Phần 4: Tài liệu tham khảo
- **Mã nguồn:**
  - `Core\Src\KSkills.cpp`: `LoadSkillLevelData` 2442, `PtSkillLvAttribAlias` 2757, `ParseString2MagicAttrib` 2812, `CanCastSkill` (EqtLimit) 206;
  - `KSkills.h` `IsBase()` 199;
  - `KSkillList.cpp`: `Add` 453, danh sách chuột 762/840, `RollBackSkills` 985;
  - `ScriptFuns.cpp`: `LuaAddMagic` 3536, `LuaSetPlayerStrength` 6613, `LuaAddPropPoint` 9198, `LuaRemoveItemIdx` 12655;
  - `KItemList.cpp`: `RemoveItem(idx, n)` 4433, `ExecuteScript` 4795;
  - `KSortScript.cpp`: đăng ký script rời, `ReLoadScript`.
- **Dữ liệu VNG:** `vng00.pak` `\settings\item\001\magicscript.txt`, `\settings\skills.txt` (1986–2000), `\settings\missles.txt` (325–334).
- **Công cụ:**
  - `scratchpad\thanky\`: `gen.py`, `verify.py`, `patch_wb.py`, `fix_ps1_ascii.py`; khảo sát `s1_ms.py` … `s8_src.py`;
  - `qtest\sim_thanky.lua`, `qtest\sim_thanky_admin.lua`, `qtest\test_admin_thanky.ps1`.
- **Liên quan:**
  - `de-xuat-khoang-trong-vng-phong-than-20261004.md` (việc #4);
  - `ky-nang-chuyen-sinh-60-120-180-phong-than-20261001.md` (cách viết script chỉ số);
  - `bi-kip-he-phai-phong-than-20261002.md` (mẫu sách học kỹ năng);
  - `ky-tran-cac-da-quy-phong-than-20261004.md` (tab, giá 1 lượng);
  - `boss-the-gioi-lenh-bai-phong-than-20260930.md`.
- **Việc tiếp theo:** Thần Kỹ đời sau 8885–8895 (Hình Thiên Chiến Ý, Triệu Hồi, Khô Mộc Phùng Xuân, Đoản Binh Giao Tiếp, Họa Địa Vi Lao, Xung Phong Hãm Trận, Nam Minh Ly Hỏa, Thiên Toàn Địa Chuyển, Băng Hồn Tuyết Phách) ứng với kỹ năng 1547–1557. Kiểu kỹ năng khác (Attrib 12/52, style 2/17), chưa làm ở đợt này.
