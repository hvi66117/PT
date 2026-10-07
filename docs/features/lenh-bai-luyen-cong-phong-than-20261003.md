---
tinh-nang: Lệnh Bài Luyện Công
ngay: 2026-10-03
agent: luyencong
trang-thai: Script và web admin đã xong; chờ ptfix bản chính thức + khởi động lại server
tom-tat: Lệnh bài vĩnh viễn (magicscript 61420). Nhấp phải hiện 20 bãi luyện công chia theo cấp 1–150, chọn là dịch chuyển tới ngay chỗ có quái. Dòng đầu "Bãi hợp cấp nhất" tự chọn theo cấp hiện tại; có "Về thành gần nhất". Mọi nhân vật cũ và mới tự được phát 1 lệnh bài (task 2610); web admin phát thêm được.
---

# Lệnh Bài Luyện Công – tự dịch chuyển tới bãi luyện công theo cấp

## Phần 1: Tổng quan

- **Insight chính:** chơi một mình thì mất nhiều thời gian nhất ở khâu tìm bãi quái hợp cấp. Bản đồ có quái là do `spawn_*.lua` sinh ra, không giống VNG gốc nên khó nhớ. Lệnh bài này đưa người chơi tới **đúng ô có cụm quái dày nhất** của dải cấp, chỉ cần 2 cú nhấp.
- **Cách dùng:** nhấp phải lệnh bài. Menu chính có 7 dòng:
  - Bãi hợp cấp nhất;
  - 4 trang bãi: cấp 1–24, 25–49, 50–74, 75–150;
  - Về thành gần nhất;
  - Đóng.

  Mỗi trang có 5 bãi, cùng nút "Quay lại" và "Đóng". Dấu `*` đánh dấu bãi hợp cấp.
- **Nhận lệnh bài:**
  - Nhân vật cũ và mới tự được phát 1 lệnh bài trong vòng 1 phút sau khi online. Nếu túi đầy thì thử lại mỗi phút.
  - Nếu đã có lệnh bài trong túi hoặc rương, kể cả do admin phát, thì không phát thêm.
  - Web admin có nút **"Phát Lệnh Bài Luyện Công"** trong mục Lệnh bài hủy đồ.
- **Vĩnh viễn:** không mất khi dùng, không hết hạn. Không bán, vứt, giao dịch hay bày bán được.
- **An toàn:**
  - Chỉ dùng được ở bản đồ ngoài và thành: 1001–1057, 1065, 1074–1078.
  - Bị chặn ở sự kiện, phó bản, chiến trường, Vạn Tiên trận, Tiên Ma, Huyền Vũ và Thiên Lao (1060).
  - Bản đồ đích chưa mở thì không gọi `NewWorld`, để tránh bị đẩy sang máy chủ khác.
  - Tới bãi thì bật `SetFightState(1)`. Về thành thì `SetFightState(0)`.
- **Giới hạn dữ liệu:** dữ liệu quái của server chỉ lên tới cấp ~102 (Không Tang Lĩnh 95–102). Vì vậy cả dải cấp 95–150 đều về Không Tang Lĩnh.

## Phần 2: Chi tiết

### 2.1 Mã số

| Thành phần | Giá trị |
|---|---|
| Vật phẩm | magicscript genre 6, detail 1, particular **61420**. Runtime: (6, 61420, 0) |
| Cờ đã phát | task **2610** (1 = đã có lệnh bài). Dải 2600–2619 đã quét toàn bộ PAK, script rời, settings và bridge: không ai dùng |
| Script vật phẩm | `\script\phongthan\item\luyencong_lenhbai.lua` (file rời, ASCII, chữ TCVN3 dạng `\ddd`) |
| Script phát | `\script\phongthan\item\luyencong_give.lua` (không có `main()`, được dofile vào state servertimer) |
| Biến toàn cục | tiền tố `PTLC_` (đã kiểm tra không trùng) |
| Hình ảnh | `\spr\item\ibitem\野外传送符1.spr`, lấy từ dòng VNG 5575 "Ma Phù" (bùa dịch chuyển dã ngoại); có trong PAK cả Client và Server |
| Khóa web admin | `LuyenCongToken` → `@{ g = 6; d = 61420 }`, đi chung đường phát với `SummonToken` |

### 2.2 Bảng 20 bãi luyện công

Toạ độ `NewWorld` tính theo ô (= mps / 32). Toạ độ màn hình là [x/8, y/16]. Cột cuối kiểm tra **trên server đang chạy lúc 20:38–20:40** qua admin bridge: số quái sống trong vòng 30 ô quanh điểm đến.

| # | Cấp người chơi | Bản đồ | Cấp quái | NewWorld (ô) | Màn hình | Quái sống ≤ 30 ô |
|---|---|---|---|---|---|---|
| 1 | 1–5 | 1005 Sùng thành | 3 | 1665, 3060 | [208,191] | 14 (cấp 3) |
| 2 | 6–9 | 1006 Bắc Hải | 7 | 1725, 2862 | [215,178] | 17 (cấp 7) |
| 3 | 10–14 | 1009 Tây Côn Lôn | 12 | 1688, 3344 | [211,209] | 13 (cấp 12) |
| 4 | 15–19 | 1014 Đồng Quan (quái VNG gốc) | 15 | 1337, 3250 | [167,203] | 17 (cấp 15) |
| 5 | 20–24 | 1015 Mạnh Tân | 20 | 1634, 3233 | [204,202] | 14 (cấp 15–20) |
| 6 | 25–29 | 1017 Kỳ Sơn | 25 | 1655, 3411 | [206,213] | 9 (cấp 25) |
| 7 | 30–34 | 1022 Hoang mạc | 30 | 1520, 3524 | [190,220] | 15 (cấp 30) |
| 8 | 35–39 | 1024 Phong Than sa mạc | 36–38 | 1748, 3344 | [218,209] | 15 (cấp 36–38) |
| 9 | 40–44 | 1025 Lục Châu | 43 | 1753, 3115 | [219,194] | 15 (cấp 38–43) |
| 10 | 45–49 | 1026 Sa Mạc chết | 45 | 1507, 3119 | [188,194] | 13 (cấp 45–50) |
| 11 | 50–54 | 1034 Đại Phong | 54 | 1476, 2974 | [184,185] | 9 (cấp 54) |
| 12 | 55–59 | 1035 Đại Thạch | 56 | 1782, 3559 | [222,222] | 13 (cấp 56) |
| 13 | 60–64 | 1043 Bích Du tầng 2 | 61 | 1450, 3427 | [181,214] | 17 (cấp 61) |
| 14 | 65–69 | 1047 Khốn Tiên tầng 1 | 66–68 | 1467, 3123 | [183,195] | 8 (cấp 66–68) |
| 15 | 70–74 | 1048 Khốn Tiên tầng 2 | 70 | 1524, 3052 | [190,190] | 17 (cấp 70) |
| 16 | 75–79 | 1050 Khốn Tiên tầng 4 | 75–77 | 1594, 3090 | [199,193] | 20 (cấp 75–77) |
| 17 | 80–84 | 1053 Đại Hải | 80 | 1612, 3607 | [201,225] | 8 (cấp 80) |
| 18 | 85–89 | 1077 Lưu Ba sơn | 85 | 1584, 3853 | [198,240] | 6 (cấp 85) |
| 19 | 90–94 | 1056 Phương Trượng | 90–92 | 1771, 2955 | [221,184] | 9 (cấp 90–92) |
| 20 | 95–150 | 1078 Không Tang Lĩnh | 95 | 1756, 3166 | [219,197] | 10 (cấp 95) |

**Về thành gần nhất:** chọn thành gần nhất theo `MapPos` của `WorldSet.ini`. Toạ độ là điểm đến của Chỉ Nam Phù VNG (`script\item\指南符.lua`).

| Thành | NewWorld (ô) |
|---|---|
| Sùng Thành doanh 1002 (mặc định) | 1608, 3196 |
| Ngọc Hư cung 1003 | 1692, 3138 |
| Tây Kỳ 1020 | 1452, 3086 |
| Triều Ca 1021 | 1723, 3075 |
| Diêu Trì 1052 | 1541, 3190 |

### 2.3 Cách chọn toạ độ (dữ liệu thật, đi được, gần quái)

1. **Quái:**
   - Lấy từ `script\phongthan\spawn\spawn_<map>.lua`, tức quần thể quái mà `spawn_main.lua` thực sự sinh ra khi server khởi động. Mỗi dòng gồm template, cấp, mpsX, mpsY.
   - Riêng Đồng Quan 1014 dùng bản ghi NPC VNG gốc trong `Region_S` (`%TEMP%\ptspawn\orig.pkl`).
2. **Bản đồ ứng viên:**
   - Lọc theo cấp quái. Kiểm chéo với các điểm dịch chuyển VNG: Như Ý Phù sa mạc, Hiên Viên, Băng Xuyên, Đông Hải, Bích Du, Khốn Tiên, và Chỉ Nam Phù.
   - Loại bản đồ sự kiện và phó bản: 1060–1064, 1066–1073, 1079+.
   - Loại 1072 (đảo hồng danh) và 1073–1076: không có quái sinh sẵn, hoặc là bản đồ của Tiên Ma.
3. **Tâm cụm:** chọn con quái có nhiều quái cùng dải cấp nhất trong bán kính 20 ô. Bỏ qua mọi điểm cách boss thế giới dưới 40 ô.
4. **Ô đến:** ô gần tâm cụm nhất thoả cả 4 điều kiện:
   - đi được trên lưới client (`Region_C`) **và** lưới server (`Region_S` obstacle 0, hoặc region không có `Region_S` = không vật cản), kiểm tra cả 8 ô xung quanh;
   - không phải trap;
   - cách mọi con quái ít nhất 3 ô;
   - nằm trong vùng đi được liền mạch lớn (57.942–362.774 ô).
5. **Công cụ:**
   - `scratchpad\luyencong\pick.py` chọn ô;
   - `town.py` tính thành gần nhất;
   - `gen.py` sinh Lua;
   - `diag_bridge.lua` và `diag2_bridge.lua` kiểm tra trên server thật (chỉ đọc).

### 2.4 Phát tự động

- `starter_gear.lua` (`PTNB_Tick`, gọi mỗi phút từ `servertimer.lua` → `PTAdm_NbTick`) có thêm ở cuối: `if PTAdm_Safe then PTAdm_Safe(PTNB_LcTick) end`.
  - `PTNB_LcTick` dofile `luyencong_give.lua` một lần, rồi gọi `PTLC_GiveTick()`.
  - Chạy bảo vệ: lỗi được ghi vào `admin_bridge\tick_error.log`, không làm dừng bridge.
- `PTLC_GiveOne()` xử lý cho từng người chơi online:

  | Trường hợp | Xử lý |
  |---|---|
  | task 2610 ≠ 0 | Bỏ qua |
  | Đã có lệnh bài (`HaveNormalItem(6,1,61420,-1)` > 0) | Đặt task = 1, không phát |
  | Còn lại | `AddNormalItem(6,1,61420,1,0,0)` |

  - Task chỉ được đặt khi `AddNormalItem` tạo được vật phẩm. Vì vậy trước khi có ptfix, hoặc khi túi đầy, hệ thống sẽ thử lại phút sau, không bao giờ phát trùng.
- Không sửa `servertimer.lua`.

### 2.5 PAK (ptfix)

- Plug-in `scratchpad\ptfix\extra_luyencong.py` chạy cho cả Client và Server. Nó thêm **đúng 1 dòng** vào `settings\item\001\magicscript.txt`, nhân bản cột từ dòng 61003:
  - tên `<c=orange>Lệnh Bài Luyện Công`;
  - stack 1, không tiêu hao;
  - không rơi, giao dịch, bày bán hay bán cửa hàng;
  - vĩnh viễn.
- Plug-in chạy được nhiều lần mà không thêm trùng, và vá chồng lên `ctx["entries"]` nên không ảnh hưởng dòng của plug-in khác.
- Build thử vào `scratchpad\luyencong\`, không ghi đè `ptfix_v25.pak`:
  - `ptfix_test_client.pak` (Client, 42 entry) và `ptfix_test.pak` (Server, 617 entry);
  - `magicscript.txt` có 5778 dòng (v25 có 5777), dòng 61420 đủ 34 cột.

### 2.6 Kết quả mô phỏng

| Mô phỏng | Kết quả |
|---|---|
| `sim_luyencong.lua` với `-Stack 100` | FAILS=0 (54 kiểm tra) |
| `sim_luyencong.lua` chế độ EMU (47 frame lối vào vật phẩm, 40 frame tick) | FAILS=0, headroom tối thiểu 39 frame, không tràn stack |
| `sim_luyencong.lua` dùng file đã triển khai (`live`, `emulive`) | FAILS=0 |
| `sim_nb.lua` (đồ tân thủ) với `starter_gear.lua` đã sửa | Output giống hệt trước khi sửa |

Nội dung kiểm tra:
- menu ≤ 7 dòng, mọi callback đều tồn tại;
- dải cấp liền mạch 1–150;
- "Bãi hợp cấp nhất" đúng với mọi cấp 1–150 (cấp 200 → bãi cuối);
- G1–G20 dịch chuyển đúng ô và bật chiến đấu;
- 8 bản đồ cấm bị chặn;
- bản đồ chưa mở hoặc `NewWorld` thất bại thì người chơi đứng yên;
- về thành đúng thành gần nhất;
- tự phát: người mới được phát, người đã có không bị phát thêm, túi đầy thì thử lại, chưa có dòng ptfix thì chờ, lỗi được bắt;
- đồ tân thủ vẫn được phát;
- không ghi đè `main()` của servertimer.

## Phần 3: Hành động

### 3.1 Coordinator

- [ ] Build ptfix chính thức (Client trước, Server sau). Plug-in `extra_luyencong.py` tự được nạp.
- [ ] Triển khai ptfix cho Server **và** Client (client cần dòng magicscript để hiện tên, mô tả và hình).
- [ ] Người dùng khởi động lại GameServer. Script rời mới được đăng ký lúc khởi động; `starter_gear.lua` mới được nạp lại.
- [ ] Người dùng đóng và mở lại web admin (sửa `PhongThan-Admin.ps1`), rồi F5 trình duyệt.

### 3.2 Người chơi kiểm tra trong game

- [ ] Vào game, chờ tối đa 1 phút: nhận thông báo "Bạn nhận được Lệnh Bài Luyện Công…" và thấy lệnh bài trong túi (hình bùa dịch chuyển).
- [ ] Rê chuột lên lệnh bài: tên màu cam, mô tả tiếng Việt đúng dấu.
- [ ] Nhấp phải: menu 7 dòng. Dòng 1 ghi đúng bãi theo cấp hiện tại.
- [ ] Chọn "Bãi hợp cấp nhất": tới bãi, thấy quái ngay quanh mình, trạng thái chiến đấu bật.
- [ ] Mở từng trang, kiểm tra 5 bãi + "Quay lại" + "Đóng". Thử vài bãi ở các trang khác nhau.
- [ ] "Về thành gần nhất": về đúng thành, trạng thái phi chiến đấu.
- [ ] Đăng nhập lại: không được phát thêm lệnh bài thứ hai.
- [ ] Web admin: nút "Phát Lệnh Bài Luyện Công" phát được (cho nhân vật khác hoặc khi lỡ mất).
- [ ] Vào Vạn Tiên trận hoặc Thiên Lao rồi dùng lệnh bài: phải hiện thông báo không dùng được.

### 3.3 Rollback

- Khôi phục `starter_gear.lua`, `PhongThan-Admin.ps1` và `index.html` từ `_backup\20261003-luyencong\` (cùng đường dẫn tương đối).
- Xóa 2 file `luyencong_*.lua` và plug-in `extra_luyencong.py`, rồi build lại ptfix.
- Task 2610 vô hại nếu để lại.

## Phần 4: Tài liệu tham khảo

### Tệp liên quan

| Loại | Đường dẫn |
|---|---|
| Script vật phẩm | `PhongThanRuntime-Staging\Server\script\phongthan\item\luyencong_lenhbai.lua` |
| Script phát | `PhongThanRuntime-Staging\Server\script\phongthan\item\luyencong_give.lua` |
| Đã sửa | `PhongThanRuntime-Staging\Server\script\phongthan\newbie\starter_gear.lua` |
| Đã sửa (web admin) | `AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html` |
| Plug-in PAK | `scratchpad\ptfix\extra_luyencong.py` |
| Công cụ | `scratchpad\luyencong\` (`pick.py`, `town.py`, `gen.py`, `patch_starter.py`, `spots_final.json`) |
| Mô phỏng | `scratchpad\qtest\sim_luyencong.lua` |
| Sao lưu | `_backup\20261003-luyencong\` |

### Mẫu tham chiếu

- Lệnh Bài Triệu Hồi: 61003, `trieuhoi_lenhbai.lua`, phân trang `PTTH_Page`.
- Lệnh Bài Boss Thế Giới: 61001, dịch chuyển bằng `NewWorld` + `SetFightState`.
- Chỉ Nam Phù và Như Ý Phù VNG.

### Bước tiếp theo

- Thêm bãi thứ hai cho các dải đông người chơi.
- Có thể thêm điều kiện cấp tối thiểu cho bãi cấp cao.
