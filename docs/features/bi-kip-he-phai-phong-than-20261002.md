# Bí kíp hệ phái: mua, ép (đóng sách) và click phải để học

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02 · Người làm: agent bikip
> Trạng thái: **Đã làm, chờ cài.** Script Lua đã nằm trong `Server\script`. Dữ liệu PAK nằm trong plug-in `extra_bikip.py`; bản build thử (Server và Client) đạt. Có tác dụng sau khi build/cài ptfix mới và khởi động lại server, game.
>
> **Đợt 2 (2026-10-03, agent bikip2):** Võ sư **mọi thành** có menu bí kíp; web admin có thẻ phát nguyên liệu ép sách và phát bí kíp theo phái. Xem mục 2.7. Plug-in `extra_bikip2.py`, build thử đạt; chờ coordinator cài ptfix mới, khởi động lại server và người dùng tự mở lại web admin.

## Phần 1: Tổng quan
- **Người dùng báo:** "Các bí kíp của hệ phái chưa ép và mua được, click dùng được."
- **Bí kíp hệ phái là gì:** sách kỹ năng VNG (`\settings\item\001\skillbook.txt`, loại vật phẩm 7). Có 60 cuốn cho 3 phái:
  - Giáp Sĩ 16 cuốn (kỹ năng 27–42);
  - Đạo Sĩ 24 cuốn (3–26);
  - Dị Nhân 18 cuốn (43–51 và đệ tử 450–458);
  - 2 sách kỹ năng sống dùng chung (62 Bàn Cổ Khai Thiên, 128 Ban Môn Lộng Phủ).
- **Cơ chế VNG:**
  - Sách cấp thấp (đến cấp 30) **mua** ở Võ sư. Tân Thủ thôn: `Sale(8)` Giáp Sĩ, `Sale(9)` Đạo Sĩ, `Sale(10)` Dị Nhân. Thư viện: `Sale(19)`. Võ sư Tây Kỳ/Triều Ca: `Sale(14)`.
  - Sách cấp cao **"ép"** ở Võ sư Tây Kỳ/Triều Ca, mục "Đóng sách": nộp Không Thư (Bạch/Lam/Hồng/Hoàng) cùng Mảnh Hồng Thủy Tinh, Hồng Thủy Tinh hoặc Hồng Bảo Thạch. Phép này có tỉ lệ (10–50%); thất bại thì nhận vật phẩm an ủi.
  - Học: click phải vào sách.
- **Vì sao hỏng (engine dựng lại):**
  1. **Click không làm gì:** `KItemList::ExecuteScript` thoát sớm với loại 7, và bảng `skillbook.txt` không có cột script. `item_action_diag.log` có 20 lần click loại 7 (`EatItemByID_EXECUTE genre=7`) nhưng không có dòng `ExecuteScript_BEGIN` nào.
  2. **Không mua được:** `GenerateShopItem` trong `KBuySell.cpp` thiếu nhánh `item_skillbook`. 80 dòng sách trong `goods.txt` bị bỏ qua.
     - Tệ hơn: mỗi dòng bị bỏ làm **mọi dòng hàng phía sau lùi 1 ô**. Vì vậy các tiệm dùng hàng sau dòng 452 (Sale 2–65) đang hiện và bán sai món.
  3. **Ép ra sách vô dụng:** script Võ sư VNG vẫn cho sách loại 7. Script này cũng trừ nguyên liệu trước mà không kiểm tra chỗ trống trong hành trang.
     - `HaveNormalItem` đếm cả rương chứa đồ, còn `DelNormalItem` chỉ lấy trong hành trang. Do đó có thể ép "miễn phí" khi nguyên liệu nằm trong rương.
- **Cách làm (chỉ Lua và dữ liệu, không sửa C++):**
  - Mỗi cuốn có thêm bản **magicscript 6/1/(62000 + mã kỹ năng)** tên "Bí Kíp …". Bản này có script riêng, click phải để học.
  - Các dòng sách trong `goods.txt` được đổi sang bí kíp. Nhờ vậy các tiệm VNG bán được, và mọi tiệm không còn bị lệch hàng do sách.
  - Thêm 3 tiệm "Bí kíp hệ phái" bán đủ sách của phái.
  - Viết lại "Đóng sách" an toàn, và thêm mục đổi sách cũ (loại 7) thành bí kíp.

## Phần 2: Chi tiết

### 2.1 Click phải để học (`script\phongthan\lib\pt_bikip.lua`, `PTBK_UseBook`)
- Mỗi bí kíp gọi `script\phongthan\item\bikip_<mã kỹ năng>.lua`. Có 60 file, tất cả `Include` thư viện chung.
- Các bước:
  1. Kiểm tra đúng phái (`GetProfession`). Sách kỹ năng sống thì phái nào cũng dùng được.
  2. Kiểm tra đủ cấp. Mốc cấp lấy theo mô tả VNG "Sách kỹ năng … cấp N".
  3. Chưa có kỹ năng: học cấp 1 (`AddMagic`). Nếu kỹ năng đang ở cấp 0 thì `SetSkillLevel` trước.
  4. Đọc lại `GetMagicLevel`. Chỉ khi học được thật mới `RemoveItem(idx, 1, 0)`.
  5. Đã có kỹ năng: báo "đã lĩnh hội" và giữ lại sách. Theo VNG, sách chỉ dạy cấp 1; cấp cao hơn tăng bằng điểm kỹ năng.
- Kết quả hiện bằng hộp thoại và dòng chat. Có ghi log `admin_bridge\token.log` (thẻ `bikip`).
- `bikip_sach7.lua` (`PTBK_UseSkillBook7`): dùng cho sách loại 7 cũ (mã kỹ năng = `GetItemPartByID`). File này chỉ chạy khi C++ gọi nó (xem 2.6).

### 2.2 Mua
- **Tiệm VNG** đã hiện bí kíp đúng món, đúng vị trí:
  - `Sale(8)`: 4 cuốn Giáp Sĩ;
  - `Sale(9)`: 8 cuốn Đạo Sĩ;
  - `Sale(10)`: 5 cuốn Dị Nhân;
  - `Sale(14)`: 3 cuốn;
  - `Sale(19)`: 20 cuốn.
- **Tiệm mới** (mục "Mua bí kíp hệ phái" ở Võ sư Tây Kỳ/Triều Ca, mở tiệm theo phái của người chơi):

| Sale | Phái | Số món |
|---|---|---|
| 66 | Giáp Sĩ | 16 + 2 sách sống |
| 67 | Đạo Sĩ | 24 + 2 |
| 68 | Dị Nhân | 18 + 2 |

- **Giá (bạc):**
  - Sách VNG vốn bán ở tiệm: giữ giá VNG, 40–30.000.
  - Sách VNG chỉ ép được: `cấp × 2.000`, tức 68.000–180.000.
  - Sách kỹ năng sống: 2.000.
- **Lưu ý:** 17 dòng sách Vũ Sĩ (hệ phái không có trong bản này) không khớp sách nào. Các dòng đó thành món giữ chỗ, và được gỡ khỏi các tiệm (12 ô ở Sale 14, 19, 65).

### 2.3 Ép bí kíp: "Đóng sách (ép bí kíp)" ở Võ sư Tây Kỳ/Triều Ca
- Công thức và tỉ lệ giữ đúng VNG, ví dụ:

| Bí kíp | Nguyên liệu | Tỉ lệ |
|---|---|---|
| Hoành Không Trảm | 1 Bạch Không Thư + 1 Mảnh Hồng Thủy Tinh | 2/10 |
| Lôi Phong Giáp | 2 Lam Không Thư + 1 Hồng Thủy Tinh | 2/10 |
| Khuynh Thành Nhất Kích | 1 Hoàng Không Thư + 3 Hồng Bảo Thạch | 1/10 |
| Bàn Cổ Khai Thiên | 1 Bạch Không Thư | 100% |

- Không Thư mua ở tiệm IB (tab Cường hóa / Tạp hóa, dòng 141–144). Hồng Thủy Tinh có ở `goods.txt`. Mảnh Hồng Thủy Tinh và Hồng Bảo Thạch lấy từ rơi đồ hoặc ghép.
- **Trình tự an toàn:**
  1. Cần 3 ô trống trong hành trang.
  2. Kiểm tra đủ số lượng.
  3. Lấy thủy tinh/bảo thạch trong hành trang (có đếm). Lấy thiếu thì trả lại và báo "phải để trong hành trang".
  4. Lấy Không Thư (có đếm). Lấy thiếu thì trả lại toàn bộ.
  5. Tung tỉ lệ. Thành công: nhận **bí kíp 6/1/62xxx** (click phải dùng được ngay). Thất bại: nhận vật phẩm an ủi VNG theo màu Không Thư (Hồi Thành Phù, Thổ Linh Phù, Tuyết Quái Phù ×3 …).
- **Đổi sách cũ:** mục "Đổi sách kỹ năng cũ thành bí kíp" đổi 1:1 mọi sách loại 7 trong hành trang. Nếu không thêm được bí kíp thì trả lại sách cũ.
  - Nguồn sách cũ: quà, nhiệm vụ VNG (khoảng 14 script còn `AddNormalItem(7, …)`), hoặc sách có sẵn trong hành trang.

### 2.4 Tệp
- **Mới, trong `Server\script\phongthan\`:**
  - `lib\pt_bikip.lua`
  - `item\bikip_<3..51, 62, 128, 450..458>.lua` (60 file)
  - `item\bikip_sach7.lua`
  - Toàn bộ là ASCII, chữ Việt viết bằng mã thoát TCVN3. Sinh từ `scratchpad\bikip\gen_bikip.py`.
- **Plug-in `scratchpad\ptfix\extra_bikip.py`**, đọc dữ liệu `scratchpad\bikip\bikip_data.json`:
  - `magicscript.txt` +60 dòng;
  - `goods.txt`: 80 dòng loại 7 được đổi;
  - `buysell.txt`: gỡ ô Vũ Sĩ, thêm 3 dòng tiệm;
  - Chỉ phía Server: nối thêm phần ghi đè menu vào `\script\西岐\教师.lua` và `\script\朝歌\教师.lua`. Hai đường dẫn GBK này phải nằm trong PAK. Phần nối thêm gồm `main`, `books` và `PTBK_SHOP_SALE`; `songxin`, `yes_2` và `Sale(14)` giữ nguyên.
- Không sửa file dự án nào có sẵn, nên không cần backup. `ky_nang_quyen_*.lua` và `sach_kn_*.lua` (61011–61019) giữ nguyên.

### 2.5 Kiểm tra
- **Mô phỏng Lua 4** (`qtest\sim_bikip.lua`, `out_bikip.txt`): mọi tình huống đều đạt.
  - Học: sai phái, thiếu cấp, học được, đã có, kỹ năng cấp 0, sách sống, sách đệ tử 453, sách loại 7 qua `bikip_sach7`, sách lạ.
  - Menu Võ sư: mở Sale 66/67/68 theo phái.
  - Đóng sách: thiếu đồ, túi chỉ còn 2 ô, thành công, thất bại (nhận quà an ủi), thủy tinh nằm trong rương (không mất gì), sai phái, Khuynh Thành, Bàn Cổ, Lôi Phong Giáp.
  - Đổi sách cũ: 3 cuốn; không có cuốn nào; thêm bí kíp lỗi thì trả lại sách cũ.
- **`qtest\sim_bikip_all.lua`:** cả 60 script bí kíp nạp được, học được và mất đúng 1 cuốn.
- **Build thử** `scratchpad\bikip\ptfix_test.pak` (Server, 406 mục, đủ 5 plug-in) và `ptfix_test_client.pak`:
  - `goods`, `buysell`, `magicscript` giống hệt nhau giữa Server và Client;
  - mô phỏng KBuySell: Sale 8/9/10/14/19/66/67/68 đúng vị trí, không lệch.

### 2.6 Giới hạn, cần C++ (đề xuất cho coordinator)
1. **Click phải sách loại 7 cũ:** trong `KItemList::ExecuteScript`, với `item_skillbook` hãy gọi `\script\phongthan\item\bikip_sach7.lua` (`main(nIdx)`). Lua đã sẵn.
2. **`KBuySell::Init`:** khi một dòng `goods.txt` không sinh được, nên giữ ô trống thay vì `continue`, để chỉ số không lệch.
   - Hiện còn 46 dòng hỏng (dòng 933 loại 4, và 45 dòng IB từ 1036 trở đi). Các tiệm dùng hàng sau dòng 933 vẫn lệch.
   - Nên thêm nhánh `item_skillbook`.
3. **`GenerateShopItem` với magicscript** dùng cột 2 của `goods.txt` làm khóa. Các dòng VNG "6 1 X" vì vậy hiện vật phẩm khóa 1 (Thái Ngự Đơn) thay vì X, ví dụ 本样变身符 ở tiệm Võ sư.
   - Bí kíp ghi khóa ở cột 2. Nếu sửa C++, hãy giữ quy tắc: cột 2 khác 1 thì dùng cột 2 làm khóa.

### 2.7 Đợt 2 (2026-10-03, agent bikip2): Võ sư mọi thành và thẻ web admin
- **Người dùng báo:** "Thêm tính năng ở web admin để cung cấp nguyên liệu ép sách cho các phái, võ sư ở các thành ở tiệm chưa có bán bí kíp các phái."
- **Nguyên nhân:** đợt 1 chỉ vá Võ sư Tây Kỳ và Triều Ca. Võ sư các thành khác vẫn chạy script VNG gốc: chỉ có tiệm sách VNG (Sale 8/9/10/19), không có tiệm bí kíp theo phái, không đóng sách được.

#### Danh sách Võ sư (教师) có script VNG

| Bản đồ | Script PAK (id) | NPC trên server | Menu VNG giữ nguyên | Vá bởi |
|---|---|---|---|---|
| 1020 Tây Kỳ | `\script\西岐\教师.lua` (a1175c2f) | Có (ext `sudo_dongdi.lua`) | Sách = Sale(14) | `extra_bikip.py` (đợt 1) |
| 1021 Triều Ca | `\script\朝歌\教师.lua` (b081bc9e) | Có (ext `sudo_dongdi.lua`) | Sách = Sale(14) | `extra_bikip.py` (đợt 1) |
| 1002 Sùng Thành doanh | `\script\崇城大营\教师.lua` (95ca852d) | Có (ext `sudo_dongdi.lua`) | Học kỹ năng → Sale(8) (chỉ Giáp Sĩ), Trừ Yêu | `extra_bikip2.py` + `extra_sudo_dongdi.py` |
| 1003 Ngọc Hư cung | `\script\玉虚宫\教师.lua` (176efdac) | Có (ext `sudo_dongdi.lua`) | Học kỹ năng → Sale(9) (chỉ Đạo Sĩ), Trừ Yêu | `extra_bikip2.py` + `extra_sudo_dongdi.py` |
| 1004 Xi Vưu mộ | `\script\蚩尤墓\教师.lua` (94a2d951) | Có (ext `sudo_dongdi.lua`) | Học kỹ năng → Sale(10) (chỉ Dị Nhân), Trừ Yêu | `extra_bikip2.py` + `extra_sudo_dongdi.py` |
| 1052 Dao Trì | `\script\瑶池\教师.lua` (9aa5b28c) | Có (dữ liệu vùng bản đồ) | Mua sách kỹ năng = Sale(19) | `extra_bikip2.py` |
| 1001 Phong Thần Đài | `\script\封神台\教师.lua` (1a469ad5) | **Không có NPC** | Minh Châu, Mua sách kỹ năng = Sale(19) | `extra_bikip2.py` (script vá sẵn) |

- Không còn script Võ sư nào khác. `生活技能老师` là thầy kỹ năng sống (agent sinhhoat), `图书馆` là Đồ Thư quán, không thuộc phạm vi này.
- **Phong Thần Đài chưa có Võ sư.** Đề xuất cho coordinator (ô đi được, tìm bằng `sudo_dongdi\findpos.py` cạnh Bá Giám): thêm vào danh sách spawn
  `{ "vosu1001", 1001, 154, 53024, 99488, "V\226 S\173", "\\script\\\183\226\201\241\204\168\\\189\204\202\166.lua" },`
  (cùng dạng `PTSD_NPCS` của `ext\sudo_dongdi.lua`; script này phải được `ReLoadScript` như các Võ sư khác).

#### Cách làm
- **Thư viện chung mới** `Server\script\phongthan\lib\pt_bikip2.lua` (ASCII, chữ Việt bằng mã thoát TCVN3), `Include` lại `pt_bikip.lua` của đợt 1 nên dùng chung tiệm, đóng sách, đổi sách cũ, không chép lại logic.
  - `PTBK2_Main(sel)` chạy **nguyên văn `main` VNG**. Trong lúc chạy, menu `SayTask` đầu tiên được thêm 3 dòng trước dòng thoát: "Mua bí kíp hệ phái" (`PTBK_ShopMenu`), "Đóng sách (ép bí kíp)" (`PTBK_CraftMenu`), "Đổi sách kỹ năng cũ thành bí kíp" (`PTBK_ConvertOld`).
  - Võ sư chỉ có `MsgBox(…, "yes_2", "no")` (Dao Trì) được đổi thành menu "Mua sách kỹ năng" (vẫn `yes_2` → Sale 19) cùng 3 dòng trên.
  - Hội thoại nhiệm vụ của `main` VNG (`songxin` giao thư, Trừ Yêu, Minh Châu) và các tiệm sách VNG không đổi. Lỗi Lua trong `main` VNG không để lại móc (lần sau vẫn đúng).
- **Plug-in `scratchpad\ptfix\extra_bikip2.py`** (chỉ phía Server): nối thêm vào 5 script trên một đoạn tự chứa:
  ```lua
  Include("\\script\\phongthan\\lib\\pt_bikip2.lua")
  PTBK_SHOP_SALE = { [0] = 66, [1] = 67, [2] = 68 }
  PTBK2_ORIG_MAIN = main
  function main(sel)
  	PTBK2_Main(sel)
  end
  ```
  - Số tiệm 66/67/68 đọc từ bản Tây Kỳ mà `extra_bikip.py` vừa vá (tức các dòng `buysell` nó thêm), không viết cứng.
  - Dao Trì không có `SayTask`/`TaskNote` nên build không thêm `pt_compat.lua`; plug-in tự thêm dòng `Include` này ở đầu.
  - **Thứ tự plug-in:** `extra_bikip.py` < `extra_bikip2.py` < `extra_sudo_dongdi.py`. `extra_sudo_dongdi.py` nối đoạn của nó (định nghĩa lại `judge_relation`, `judge_times`, `mission_PR_confirm`, không đụng `main`) sau đoạn của bikip2, và bỏ qua mục nào chứa chữ `sudo_dongdi` (đoạn bikip2 không chứa chữ này). Đã thử đảo thứ tự (sudo trước, bikip2 sau): cùng tập dòng, cùng kết quả. Dấu chống vá lặp: `PTBK2_ORIG_MAIN`.
- **Web admin** (`AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html`), tab **Bí kíp / Kỹ năng**, thẻ mới "3. Bí kíp hệ phái & nguyên liệu ép sách":
  - **Nguyên liệu ép sách:** 7 ô số lượng (0–50): Bạch / Lam / Hồng / Hoàng Không Thư (8/139–142/2), Mảnh Hồng Thủy Tinh 3/77, Hồng Thủy Tinh 3/28, Hồng Bảo Thạch 3/79. Hành động `bikipmats` với `mats`.
  - **Bộ nguyên liệu ép sách:** N lần ép (1–10) cho các bậc được tích. Một lần ép mỗi bậc = công thức lớn nhất của bậc đó trong `recipes_vng.json`:

| Bậc | Không Thư | Thủy tinh / bảo thạch |
|---|---|---|
| Bạch (139) | 2 | 1 Mảnh Hồng Thủy Tinh |
| Lam (140) | 2 | 1 Hồng Thủy Tinh |
| Hồng (141) | 2 | 1 Hồng Bảo Thạch |
| Hoàng (142) | 1 | 3 Hồng Bảo Thạch |

  - Bộ 1 lần ép đủ 4 bậc = 13 món (7 Không Thư, 1 Mảnh HTT, 1 HTT, 4 HBT). Tối đa 200 món mỗi lệnh.
  - **Phát bí kíp theo phái:** chọn phái (tự nhận khi gõ tên nhân vật đang online), chọn 1 cuốn hoặc "Phát tất cả bí kíp của phái" (Giáp Sĩ 18, Đạo Sĩ 26, Dị Nhân 20, đã gồm 2 sách kỹ năng sống), 1–10 cuốn mỗi loại. Hành động `bikip`. Khóa vật phẩm `BiKip<mã>` (ví dụ `BiKip32`) cũng dùng được cho `give`, `giveall` và Sự kiện.
  - Mỗi lệnh là **một** lệnh cầu nối: chuỗi `PTAdm_GiveTo(pi, g, d, p, 1, 0, n)` phẳng (không có bảng lớn, an toàn với stack 120 ô). Kết quả ở Lịch sử lệnh: `OK +n` hoặc `FAIL created k/n (hanh trang day?)`; trong game hiện "Admin tặng nguyên liệu ép sách: k/n".

#### Kiểm tra đợt 2
- **Build thử:** Client rồi Server → `scratchpad\bikip2\ptfix_test_client.pak`, `ptfix_test.pak` (617 mục, đủ 24 plug-in). `bikip2\verify_pak.py` đọc byte cuối của 7 mục Võ sư:
  - Tây Kỳ, Triều Ca: đoạn đợt 1, không đổi (giống hệt bản `bk_teacher.lua` của đợt 1);
  - Phong Thần Đài, Dao Trì: `pt_compat` + đoạn bikip2;
  - Sùng Thành, Ngọc Hư, Xi Vưu: `pt_compat` + đoạn bikip2 + đoạn sudo_dongdi;
  - cả 7 có `PTBK_SHOP_SALE = { [0] = 66, [1] = 67, [2] = 68 }` và giữ `Sale(14/19/8/9/10)` VNG.
- **Mô phỏng `qtest\sim_bikip2.lua`** trên byte cuối của 7 mục: `-Stack 100` FAILS=0; EMU (`-Stack 0 -Args1 EMU`, mỗi lối vào đệm tới 47 khung như engine) FAILS=0, 86 lối vào, khoảng trống nhỏ nhất 45 khung.
  - Mỗi thành: menu có 3 dòng mới + dòng VNG + dòng thoát cuối; tiệm sách VNG đúng Sale; "Mua bí kíp hệ phái" ra Sale 66/67/68 theo phái; Đóng sách Hoành Không Trảm ra 6/1/62032 và trừ nguyên liệu; đổi sách cũ; `songxin` vẫn trả lời trước; lỗi Lua trong `main` không làm mất menu ở lần sau; 3 dòng chỉ thêm 1 lần.
  - Sùng Thành: Trừ Yêu, Tìm hiểu vẫn hiện; đoạn sudo_dongdi vẫn nạp.
- **Mô phỏng lệnh web admin `qtest\sim_bikip2_admin.lua`:** Lua do `Invoke-Action` sinh (bộ 1 lần ép, tất cả bí kíp Đạo Sĩ) chạy trong state servertimer `-Stack 100`: `OK +13`, `OK +26`, đúng vật phẩm.
- **Hồi quy:** `sim_bikip` (không lỗi), `sim_bikip_all` (60/60 học được; `sach7` báo BAD vì kỹ năng 3 đã học ở vòng trước, như cũ), `sim_sudo_dongdi` và bản chạy trên build mới `sim_sudo_dongdi_bk2` (TOTAL FAILS = 0), `sim_questfix` (TOTAL FAILS = 0), `t_st` (servertimer nạp được).
- **Web admin:** PS1 phân tích cú pháp 0 lỗi, vẫn toàn ASCII; `node --check` phần script của `index.html` đạt; hai hành động mới chạy thử ngoài server (trích hàm từ AST) đúng như mong đợi.

## Phần 3: Hành động (kiểm tra trong game)
- [ ] Coordinator build ptfix chính thức cho Server **và** Client (có `extra_bikip.py`), cài, rồi người dùng khởi động lại server và game. Script loose mới chỉ được đăng ký khi server khởi động.
- [ ] Giáp Sĩ cấp 6 trở lên ở Tân Thủ thôn: Võ sư → Học kỹ năng → tiệm có "Bí Kíp Tế Huyết Trảm" … Mua 1 cuốn, click phải: học được, sách mất.
- [ ] Click lại một bí kíp đã học: báo "đã lĩnh hội", sách còn.
- [ ] Võ sư Tây Kỳ → "Mua bí kíp hệ phái": mở tiệm đúng phái (18/26/20 món). Mua một cuốn cấp cao, kiểm tra giá.
- [ ] Mua 1 Bạch Không Thư ở tiệm IB, mang theo 1 Mảnh Hồng Thủy Tinh → Võ sư Tây Kỳ → "Đóng sách (ép bí kíp)" → Hoành Không Trảm. Thử vài lần: thành công ra bí kíp; thất bại ra Hồi Thành Phù/Thăm/Thổ Linh Phù.
- [ ] Để thủy tinh trong rương rồi ép: phải báo "để trong hành trang" và không mất Không Thư.
- [ ] Có sách loại 7 cũ (ví dụ phần thưởng nhiệm vụ) → "Đổi sách kỹ năng cũ thành bí kíp" → click phải học.
- [ ] Mở thử vài tiệm khác (vũ khí `Sale(2)`, thời trang …). Món hiện ra nay phải khớp tên VNG; trước đây bị lệch.

**Đợt 2 (bikip2):**
- [ ] Coordinator cài ptfix mới (có `extra_bikip2.py`), khởi động lại server. Người dùng tự đóng và mở lại web admin, rồi F5 trình duyệt.
- [ ] Võ sư Sùng Thành / Ngọc Hư / Xi Vưu: menu có "Học kỹ năng", Trừ Yêu, "Tìm hiểu n/v" và 3 dòng bí kíp. "Học kỹ năng" vẫn mở tiệm sách VNG của trại (Sale 8/9/10).
- [ ] Võ sư Dao Trì: menu "Mua sách kỹ năng" (Sale 19) + 3 dòng bí kíp.
- [ ] Ở mỗi Võ sư: "Mua bí kíp hệ phái" mở đúng tiệm của phái; "Đóng sách (ép bí kíp)" ép được; "Đổi sách kỹ năng cũ thành bí kíp" chạy.
- [ ] Nhận Trừ Yêu một mình ở Sùng Thành vẫn chạy (không bị đoạn bikip2 làm hỏng).
- [ ] Web admin → Bí kíp / Kỹ năng → thẻ 3: gõ tên nhân vật online → "Phát bộ nguyên liệu ép sách" (N = 1, đủ 4 bậc) → Lịch sử lệnh `OK +13`, hành trang có 7 Không Thư, 1 Mảnh Hồng Thủy Tinh, 1 Hồng Thủy Tinh, 4 Hồng Bảo Thạch → đến Võ sư ép thử.
- [ ] Nhập tay vài nguyên liệu → "Phát số nguyên liệu đã nhập".
- [ ] "Phát cuốn đã chọn" và "Phát tất cả bí kíp của phái" → click phải học được.
- [ ] (Tùy coordinator) Thêm Võ sư Phong Thần Đài theo dòng đề xuất ở 2.7.

## Phần 4: Tài liệu tham khảo
- **Mã nguồn:**
  - `Core\Src\KItemList.cpp` (`NowEatItem` 1557, `ExecuteScript` 4771);
  - `KBuySell.cpp` (`GenerateShopItem` 50, `Init` 134–195);
  - `KBasPropTbl.CPP` (`KBPT_MagicScript::LoadRecord` 875, `KBPT_SkillBook` 1418);
  - `ScriptFuns.cpp` (`LuaAddMagic` 3533, `LuaGetItemPartByID` 3809, `LuaDelNormalItemCompat` 11191);
  - `PhongThanQuestItemTuple.h`.
- **Dữ liệu VNG:**
  - `vng00.pak`: `\settings\item\001\skillbook.txt`, `\settings\goods.txt`, `\settings\buysell.txt`;
  - script Võ sư `\script\西岐\教师.lua` (id a1175c2f), `\script\朝歌\教师.lua` (b081bc9e), Tân Thủ thôn `技能教师`.
- **Liên quan:**
  - `ky-nang-chuyen-sinh-60-120-180-phong-than-20261001.md` (sách 61011–61019);
  - `ky-nang-de-tu-di-nhan-phong-than-20261002.md` (kỹ năng 450–461);
  - `goi-va-ptfix-pak-phong-than-20260929.md` (cột đệm `buysell`).
- **Công cụ:**
  - `scratchpad\bikip\gen_bikip.py`, `verify_pak.py`, `parse_vosu.py` (bảng công thức `recipes_vng.json`), `simgoods.py`;
  - `qtest\sim_bikip.lua`, `sim_bikip_all.lua`.
- **Đợt 2 (bikip2):**
  - Lua: `Server\script\phongthan\lib\pt_bikip2.lua`; plug-in `scratchpad\ptfix\extra_bikip2.py`;
  - công cụ: `scratchpad\bikip2\dump.py` (bản VNG và bản đang cài của 7 Võ sư), `verify_pak.py`, `order_test.py` (đảo thứ tự plug-in), `dump_tpak.py`;
  - mô phỏng: `qtest\sim_bikip2.lua`, `sim_bikip2_admin.lua`, `sim_sudo_dongdi_bk2.lua`;
  - web admin: `AdminWeb\PhongThan-Admin.ps1` (`$BiKipByProf`, `$BiKipMats`, `$BiKipTier`, khóa `BiKip<mã>`, hành động `bikipmats`, `bikip`), `AdminWeb\index.html` (thẻ 3 tab Bí kíp / Kỹ năng);
  - bản sao lưu: `_backup\20261003-bikip2\`;
  - liên quan: `su-do-dong-di-phong-than-20261003.md` (Võ sư 3 trại tân thủ, Trừ Yêu một mình).
