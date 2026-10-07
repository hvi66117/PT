---
tinh-nang: Lệnh Bài Hành Trang (B1 tự nhặt đồ có lọc, B2 dọn túi, B3 mở rương ở mọi nơi) và thanh biểu tượng buff vật phẩm IB (B5)
ngay: 2026-10-04
agent: items
trang-thai: Lua đã chép vào runtime (chưa đăng ký tick), ptfix build thử đạt, C++ CoreServer/CoreClient/Game.exe đã build 20:3x; CHƯA triển khai DLL/EXE/ptfix/ini, chưa thêm "hanhtrang" vào PTADM_EXT_NAMES
tom-tat: Một lệnh bài dùng mãi (magicscript 61500) gộp ba việc: mở khung rương chứa đồ (Rương 1–5) ở mọi bản đồ thường, "Dọn túi" bán trang bị rác theo đúng giá cửa hàng của engine sau danh sách xác nhận (có nhật ký, có chế độ tự dọn khi túi gần đầy), và chọn loại đồ tự nhặt. Tự nhặt chạy ở client (CoreClient) khi tự đánh hoặc khi đứng yên (Alt+P đổi chế độ), gửi đúng gói nhặt của cú click, có chống spam. Thanh buff VNG cạnh thanh máu nay hiện biểu tượng và thời gian còn lại của buff kinh nghiệm / hồi máu / hồi nội lực / Bạch Hổ / buff thuộc tính của vật phẩm IB và Càn Khôn Luân.
---

# Lệnh Bài Hành Trang và thanh biểu tượng buff (2026-10-04)

## Phần 1: Tổng quan

- **Yêu cầu:** nhóm B và B5 trong `de-xuat-tinh-nang-phong-than-20261004.md`: tự nhặt đồ có lọc (B1), "Dọn túi" bán đồ rác (B2), lệnh bài mở Rương 2–5 ở mọi nơi (B3), thanh biểu tượng buff phía client (B5), kèm nút phát lệnh bài và khung cài đặt trên web admin.
- **Insight chính:**
  - Túi đầy là nguyên nhân mất đồ lặp lại nhiều lần. Ba việc B1–B3 cùng giải quyết một vấn đề nên được gộp vào **một lệnh bài**: "Lệnh Bài Hành Trang".
  - Engine **đã có sẵn** gần như mọi mảnh ghép; chỉ thiếu chỗ gọi:
    - Nhặt đồ: `KPlayer::PickUpObj` (gói `PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST`). Server tự kiểm tra chủ đồ, khoảng cách và chỗ trống, giống hệt cú click chuột.
    - Mở rương: `OpenBox(2)` không cần NPC, không kiểm tra khoảng cách (giống Thủ Khố).
    - Thanh buff: `KUiPlayerControlBar` (Game.exe) đã vẽ biểu tượng và thời gian còn lại cho mọi mục `GDI_NPC_STATE_SKILL`, ngay bên phải thanh máu. Buff vật phẩm IB là thuộc tính lưu trong task chứ không phải trạng thái kỹ năng, nên trước giờ không hiện.
    - Kênh server → client: `SyncTaskValue` (như Lệnh Bài Đạo Sĩ), không đổi giao thức.
  - Thứ duy nhất phải thêm ở server C++ là một hàm Lua **chỉ đọc** `PTItemSaleInfo(idx)`. Lý do: Lua không đọc được giá bán, độ "xanh/hoàng kim" và cờ khóa bán của vật phẩm.
- **Cách dùng (người chơi):**
  1. Mọi nhân vật tự nhận 1 Lệnh Bài Hành Trang trong vòng 1 phút sau khi online. Admin cũng phát được.
  2. Nhấp phải lệnh bài. Menu gồm: **Mở rương chứa đồ (Rương 1 - 5)** · **Dọn túi: bán đồ rác** · **Cài đặt tự nhặt đồ** · **Cài đặt dọn túi** · (Bật lại trạng thái chiến đấu) · Đóng.
  3. Tự nhặt mặc định chạy **khi bật tự đánh** (Alt+A / Alt+S / Alt+D). Nó nhặt mọi thứ **trừ đồ trắng và thuốc**.
  4. **Alt+P** (phím mới) đổi vòng: *theo lệnh bài* → *luôn bật* (nhặt cả khi đứng yên, không cần tự đánh) → *tắt*.
  5. Biểu tượng buff vật phẩm IB hiện cạnh thanh máu. Rê chuột lên biểu tượng để xem tên, mô tả và giờ:phút:giây còn lại.

## Phần 2: Chi tiết

### 2.1 Mã số

| Thành phần | Giá trị |
|---|---|
| Vật phẩm | magicscript genre 6, detail 1, particular **61500**. Runtime (engine) là 6/61500/0. Hình `\spr\item\other\乾坤袋.spr` (Túi Càn Khôn VNG, dòng 272) |
| Script vật phẩm | `\script\phongthan\item\hanhtrang_lenhbai.lua` (file rời, ASCII, chữ TCVN3 dạng `\ddd`) |
| Thư viện server | `\script\phongthan\item\hanhtrang_lib.lua` (không có `main`, dofile vào state servertimer) |
| Tick phút | `\script\phongthan\ext\hanhtrang.lua` → `PTEXT_hanhtrang_Tick` (**cần thêm `"hanhtrang"` vào `PTADM_EXT_NAMES`**) |
| Task **2640** | Bộ lọc nhặt đồ. 0 = mặc định, khác 0 = 2^30 + bit (bảng 2.2). Gửi xuống client |
| Task **2641** | Bộ lọc dọn túi. 0 = mặc định (đồ trắng + đồ hỏng), khác 0 = 2^30 + bit: 0 đồ trắng, 1 đồ hỏng, 2 đồ xanh dưới cấp X, 3 tự dọn khi túi còn ≤ 3 ô |
| Task **2642** | Cấp X của đồ xanh được bán (2..11, ngoài khoảng đó = 5). Menu xoay vòng 3 → 5 → 7 → 9 → 11 (11 = mọi cấp) |
| Task **2643** | 1 = đã phát lệnh bài (tự phát) |
| Task **2644** | Mã bản đồ nơi lệnh bài tắt trạng thái chiến đấu để mở rương (0 = không) |
| Task **2645** | `SystemTime()` lúc gửi. Client dùng để tính độ lệch đồng hồ cho thanh buff |
| Task gửi thêm mỗi phút | 1906, 1907, 1911, 1913, 2021, 1921–1932 (buff vật phẩm IB của `pt_ibitem_lib.lua`, chỉ đọc) |
| Hàm Lua mới (CoreServer) | `PTItemSaleInfo(idx)` → nơi để (3 = túi), chất lượng (0 trắng, 1 xanh, 2 hỏng, 3 hoàng kim), tiền bán cửa hàng, 1 nếu cửa hàng mua được |
| Phím mới | **Alt+P**: `PAIOperation(0x50544146, 0x20)`, truy vấn bằng 0x21 |
| Biểu tượng buff | Id giả 90001–90006, là các dòng `Buff_62..67` thêm vào `Ui\ui3\UiPlayerControlBar.ini`, kèm id có sẵn 212 / 213 |
| Biến toàn cục Lua | tiền tố `PTHT_` (đã kiểm tra không trùng) |
| Biến C++ | `s_nPTAFPick*`, `PTAF_Pick*`, `PTAF_SyncedTask`, `PTBB_*`, `PTBuffBar_Fill` |
| Khóa web admin | `HanhTrangToken` → 6/61500, hành động `hanhtrang`, `GET /api/hanhtranglog` |

**Quét trùng:** `scratchpad\items\scan_ids.py` quét mọi mục văn bản của mọi PAK (Server + Client), script rời, settings, admin_bridge, AdminWeb, docs và scratchpad.
- Task 2640–2649: không ai dùng làm task. 2651–2656 chỉ là giá trị (mẫu hình dạng đệ).
- magicscript 61500–61519: không ai dùng (chỉ trùng số tọa độ 61504 trong `revivepos.ini`).

### 2.2 B1 – Tự nhặt đồ có lọc (client, `PhongThanAutoFight.inl`)

**Bit bộ lọc (task 2640, giống `PTAF_PK_*`):**

| Bit | Loại | Cách client nhận biết | Mặc định |
|---|---|---|---|
| 0 | Tiền | `Obj_Kind_Money` | nhặt |
| 1 | Đồ trắng | trang bị, chất lượng 0 hoặc 2 (hỏng) | không |
| 2 | Đồ xanh, lục (có thuộc tính) | trang bị, `equip_magic` | nhặt |
| 3 | Đồ hoàng kim (đồ bộ) | trang bị, `equip_set` | nhặt |
| 4 | Bí kíp, sách kỹ năng | genre 7; magicscript 62000–62999 và 61011–61019 | nhặt |
| 5 | Pháp bảo, pháp khí, ấn | trang bị detail 4 (`equip_amulet`), mọi màu | nhặt |
| 6 | Nguyên liệu, đá quý | genre 3 | nhặt |
| 7 | Đồ nhiệm vụ | genre 4 | nhặt |
| 8 | Thuốc | genre 1 | không |
| 9 | Đồ khác | sự kiện, lệnh bài, vật phẩm IB, … | nhặt |
| 10 | Tự nhặt khi bật tự đánh | | bật |

Mặc định là 0x6FD = 1789. Snapshot đồ dưới đất có genre, detail và màu (chất lượng) nên client phân loại được, không cần gửi thêm dữ liệu.

**Ba chế độ Alt+P (`s_nPTAFPickState`):**
- **0 – theo lệnh bài (mặc định khi mở game):** nhặt khi tự đánh nếu bit 10 bật.
- **1 – luôn bật:** nhặt cả khi tự đánh lẫn khi tắt tự đánh. Khi không tự đánh, chỉ nhặt sau khi đứng yên 1,5 giây, trong bán kính 192 quanh nhân vật. Đang tự đi hoặc đang ngồi thì không nhặt.
- **2 – tắt hẳn.**

**Luật nhặt:**

| Luật | Giá trị |
|---|---|
| Khi tự đánh | Chỉ nhặt **giữa hai mục tiêu**: mục tiêu cũ đã chết hoặc mất, trước khi tìm con mới. Đang có mục tiêu hợp lệ thì đồ phải chờ. Đã bắt đầu đi nhặt thì nhặt xong rồi mới đánh tiếp |
| Bán kính khi tự đánh | 400 quanh nhân vật và trong vòng dây 960 quanh điểm bắt đầu. Chế độ đứng tại chỗ (Alt+D): 192 quanh điểm bắt đầu |
| Gửi yêu cầu | Khi cách đồ ≤ 96 (giới hạn server là 200, vị trí server trễ hơn). Xa hơn thì chạy tới (`PTAF_MoveTo`, có giới hạn nhịp như tự đánh) |
| Chống spam | Mỗi yêu cầu cách nhau ≥ 400 ms. Mỗi món tối đa 2 yêu cầu. Món vẫn còn sau 1,5 giây kể từ yêu cầu thứ 2 (không phải đồ của mình, đang trong 33 giây bảo vệ) bị bỏ qua 45 giây. Không tới được trong 6 giây cũng bị bỏ qua 45 giây. Danh sách bỏ qua có 32 ô |
| Không bao giờ nhặt | Đồ do người chơi vứt ra hoặc rơi khi chết (`m_bOverLook`). Đồ thuộc loại đang tắt. Vật thể chỉ có ở client (id < 1000) |
| Túi đầy | Kiểm tra `SearchPosition` trước, nên `PickUpObj` không bao giờ in "không đủ chỗ". Đồ bị bỏ qua, tiền vẫn nhặt. Thông báo "Túi đầy…" tối đa 1 lần mỗi phút |
| Bấm chuột tay | Tạm dừng nhặt 4 giây, như tự đánh |
| Luật chủ đồ | Do server quyết định như cú click (`KPlayer::ServerPickUpItem`: `m_nBelong`, tổ đội, khoảng cách). Client không biết chủ, nên dùng cơ chế "thử 2 lần rồi bỏ qua" ở trên |

**Móc vào code:**
- `PTAutoFight_Tick`: khi tắt tự đánh thì gọi `PTAF_PickIdle()`. Khi tự đánh, trong nhánh `if (!t)` có thêm `PTAF_PickStep(...)` trước `PTAF_FindTarget`.
- `PTAutoFight_Operation`: thêm 0x20 / 0x21 trước nhánh tắt tự đánh.
- `PTAutoFight_OnManualInput`: thêm tạm dừng nhặt.
- `ShortcutKey.cpp` (Game.exe): thêm Alt+P sau Alt+G. Phím chỉ có tác dụng khi `autoexec.lua` không gán Alt+P (hiện không gán).
- `PTAF_SyncedTask(id)` là bộ nhớ đệm giá trị task theo từng nhân vật, dùng chung cho tự nhặt và thanh buff. Lý do: `KPlayer::SyncCurPlayer` xóa `m_cTask` mỗi lần vào bản đồ.

### 2.3 B2 – Dọn túi (server Lua + hàm `PTItemSaleInfo`)

**Chỉ bán** trang bị (genre 0) nằm **trong túi** (nơi để 3), có detail 0–3 hoặc 5–9 (vũ khí, áo, nhẫn, giày, đai, mũ, bao tay, ngọc bội), thỏa đủ các điều kiện sau:
- chất lượng 0 (trắng) và bật bit 0;
- hoặc chất lượng 2 (hỏng, độ bền 0) và bật bit 1;
- hoặc chất lượng 1 (xanh) có cấp vật phẩm < X và bật bit 2;
- engine chịu mua (không khóa, không khóa bán), giá > 0;
- `GetLockItem` = 0;
- tên không chứa "tân thủ".

**Danh sách loại trừ (không bao giờ bán):**

| Loại | Cách chặn |
|---|---|
| Đồ đang mặc, đồ ở thanh dùng nhanh, đồ trong rương | Chỉ quét túi (`FindItemEx(3, x, y, 0)`), kiểm tra lại nơi để = 3 bằng `PTItemSaleInfo` |
| Đồ khóa, đồ khóa vĩnh viễn / khóa theo nhân vật, đồ đang mở khóa | `GetLockItem(idx) ~= 0`, `IsLock()` của engine |
| Đồ khóa bán (`bLockSell`), đồ nhiệm vụ | Cờ "cửa hàng mua được" = 0 (engine luôn coi genre 4 là khóa bán); genre 4 cũng bị loại theo genre |
| Bí kíp, sách kỹ năng, lệnh bài (mọi magicscript) | genre 6 và 7 bị loại |
| Pháp bảo, pháp khí, ấn | trang bị detail 4 |
| Ngựa, ấn (signet), trang sức đặc biệt | detail 10, 11, 12 |
| Đồ hoàng kim (đồ bộ) | chất lượng 3 |
| Nguyên liệu, đá quý, thủy tinh, nguyên liệu ép sách (3/28, 3/77, 3/79, Không Thư 8/139–142) | genre 3 và 8 bị loại |
| Thuốc, đồ sự kiện, bùa dịch chuyển | genre 1, 2, 5 bị loại |
| Đồ tân thủ | tên chứa "tân thủ" |
| Đồ giá 0 (không có tiền) | tiền ≤ 0 |

**Giá bán:** đúng như `KBuySell::Sell`, tức `GetSalePrice() * GetStackNum()`, với `GetSalePrice() = bLockTrade ? 0 : (nPrice / 4) * nStackNum`. Trang bị có stack 1 nên bằng giá hiện trong cửa hàng. Bán = `RemoveItem(idx, 0, 0)` rồi `Earn(tiền)`, giống thứ tự xử lý của cửa hàng.

**Luồng bấm "Dọn túi":**
1. Quét túi theo bộ lọc. Danh sách từng món kèm giá hiện ở khung chat. Hộp xác nhận ghi "Sẽ bán N món, thu X lượng" với 3 lựa chọn: Đồng ý · Cài đặt dọn túi · Hủy.
2. Chọn "Đồng ý": từng món được **kiểm tra lại**: còn trong túi, đúng genre / detail / particular và vẫn khớp bộ lọc. Món đã bị chuyển đi hoặc thay bằng món khác cùng chỉ số thì không bán. Báo "đã bán n/N món, thu X lượng".
3. Danh sách chỉ dùng được 1 lần. Bấm "Đồng ý" lần nữa sẽ báo hết hạn.

**Tự dọn (bit 3, mặc định tắt):** tick phút, khi `CalcFreeItemCellCount()` ≤ 3 thì bán theo bộ lọc mà không hỏi (người chơi đã bật). Có thông báo và ghi vào nhật ký bridge.

**Nhật ký:** `admin_bridge\hanhtrang_sell.log`, mỗi dòng gồm giờ, nhân vật, `tay` / `tu dong`, tên món (TCVN3), tiền. Web admin xem ở thẻ 5.

**Bản đồ:** chỉ bản đồ ngoài và thành (1001–1057, 1065, 1074–1078). Bị chặn ở sự kiện, phó bản, chiến trường, Vạn Tiên, Tiên Ma, Thiên Lao 1060.

**Chưa có CoreServer mới:** "Dọn túi" báo cần bản server mới và không bán gì. Tự dọn cũng không chạy.

### 2.4 B3 – Mở rương ở mọi nơi

- Gọi `OpenBox(2)` như Thủ Khố, mở trang "Rương chứa đồ". Mũi tên phải trong khung rương sang Rương 2–5 (đã mở ở Thủ Khố hoặc web admin).
- Engine không cho **cất** đồ vào rương khi đang chiến đấu (`KItemList::ExchangeItem`). Vì vậy nếu đang chiến đấu, lệnh bài tắt trạng thái chiến đấu và ghi mã bản đồ vào task 2644. Có 2 cách bật lại:
  - Chọn "Bật lại trạng thái chiến đấu" trên lệnh bài.
  - Hoặc tick sẽ tự bật lại ở lần thứ 3 (khoảng 3 phút), **chỉ khi còn ở cùng bản đồ**. Đã đổi bản đồ (ví dụ về thành) thì chỉ xóa cờ, không ép bật chiến đấu.
- Cùng giới hạn bản đồ như Dọn túi.

### 2.5 B5 – Thanh biểu tượng buff (CoreClient + Game.exe + ini)

| Task (server, `SystemTime()`) | Biểu tượng | Tên trong ini |
|---|---|---|
| 1906 (+ 1907 ≥ 100 %) | 90001, gương tím | Nhân đôi kinh nghiệm |
| 1906 (1907 < 100 %) | 90002, gương vàng | Tăng kinh nghiệm |
| 1911 | 90003, gương đỏ | Hồi phục sinh lực |
| 1913 | 90004, gương xanh | Hồi phục nội lực |
| 2021 | 90005, Bát Cảnh Nhật Nguyệt Đan | Đặc quyền Bạch Hổ |
| ô buff chung 1921 + 2k / 1922 + 2k, gid 116 | 212 (dòng VNG có sẵn) | Đại Hao tinh quân (Càn Khôn Luân) |
| gid 124 | 213 (dòng VNG có sẵn) | Bạch Hổ tinh quân |
| gid khác | 90006, Quán Âm Thủy | Hiệu quả vật phẩm |

- **Cách làm:** `PhongThanBuffBar.inl`, hàm `PTBuffBar_Fill`, được gọi ở cả hai nhánh `GDI_NPC_STATE_SKILL` của `CoreShell.cpp`.
  - Nhánh đếm cộng thêm số buff đang chạy.
  - Nhánh điền viết sau các trạng thái kỹ năng, **không bao giờ vượt quá số ô UI đã cấp phát**, và điền 0 vào các ô thừa.
  - Thời gian còn lại = hạn − (giờ client + độ lệch). Độ lệch = task 2645 − `time(NULL)`, tính lại mỗi khi server gửi giá trị mới. Tối đa 5.000.000 giây để không tràn `int`.
- **Server gửi task mỗi phút** (`PTHT_SyncAll`). Biểu tượng xuất hiện hoặc biến mất chậm tối đa 1 phút sau khi dùng vật phẩm hoặc hết hạn. Trong lúc chờ, client vẫn đếm lùi theo hạn đã biết.
- **ini:** `scratchpad\items\deploy\Client\Ui\ui3\UiPlayerControlBar.ini` là bản đã thêm `Buff_62..67` và đổi `BuffCount` 62 → 68. Hình được chép nguyên byte từ các dòng VNG 45 / 46 / 12 / 13 / 44 / 50. **Chưa chép vào runtime.** Thiếu file này thì UI bỏ qua các mục 90001–90006 (không lỗi), chỉ 212 / 213 hiện được.
- **Sửa rò bộ nhớ có sẵn (Game.exe, `UiPlayerControlBar.cpp`):** `Breathe()` cấp phát danh sách mỗi lần gọi mà không giải phóng. Trước đây danh sách thường rỗng nên không lộ; buff IB kéo dài hàng giờ sẽ làm rò liên tục. Nay giải phóng bản cũ trước khi cấp phát; hàm hủy dùng `free` thay `delete`.

### 2.6 Web admin

- **Phát đồ:** nút "Phát Lệnh Bài Hành Trang" cạnh các lệnh bài khác.
- **Thẻ 5 "Lệnh Bài Hành Trang (tự nhặt đồ, dọn túi, rương)"** (cạnh thẻ Lệnh Bài Đạo Sĩ / Dị Nhân):
  - ô tên nhân vật;
  - nút phát lệnh bài;
  - 11 ô tích loại đồ được nhặt;
  - 4 ô tích loại được bán;
  - chọn cấp đồ xanh;
  - nút "Áp dụng cài đặt" và "Khôi phục mặc định";
  - danh sách loại trừ;
  - "Xem nhật ký" (200 dòng cuối của `hanhtrang_sell.log`, mới nhất ở trên).
- **Backend `PhongThan-Admin.ps1` (vẫn thuần ASCII):**
  - `HanhTrangToken`;
  - hành động `hanhtrang` → lệnh bridge `PTHT_AdminSet(id, tên, nhặt, bán, cấp)`. Online thì áp ngay và gửi xuống client; offline thì lưu `admin_bridge\hanhtrang_pending.txt`, áp khi đăng nhập;
  - `Get-HanhTrangLog` + `GET /api/hanhtranglog`.

### 2.7 Kiểm thử

| Kiểm thử | Kết quả |
|---|---|
| `qtest\sim_hanhtrang.lua -Stack 100` | **FAILS=0** (106 kiểm tra) |
| `sim_hanhtrang.lua` chế độ EMU (lối vào 47 khung, tick 40) | **FAILS=0**, không tràn stack |
| `sim_hanhtrang.lua` với file đã chép vào runtime (`live`, `emulive`) | **FAILS=0** |
| `qtest\test_admin_hanhtrang.ps1` (AST của .ps1 thật, không chạy web) | 12 đạt / 0 lỗi. 2 lệnh bridge sinh ra được chạy trong sim phần 5 |
| Parser PowerShell trên `PhongThan-Admin.ps1` sau khi sửa | 0 lỗi |
| Smoke C++ `scratchpad\items\smoke\` (biên dịch nguyên `PhongThanAutoFight.inl` + `PhongThanBuffBar.inl` thật) | **73 đạt / 0 lỗi** |
| Smoke lbdaosi trên file `.inl` đã vá (hồi quy) | 60/0 lúc 20:24. Bản harness mới của agent lbdaosi r2 lúc 20:32: 75/1; lỗi đó thuộc phần "hết nội lực" họ đang làm, không liên quan tự nhặt |
| ptfix build thử `scratchpad\items\ptfix_test_client.pak` (42 mục) / `ptfix_test.pak` (617 mục) | `magicscript.txt` 5785 dòng, 61500 đủ 34 cột, hình Túi Càn Khôn có ở cả hai bên |
| `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient` | Cả 3 OK (lần cuối gồm cả thay đổi đang làm của botheal / lbdaosi r2) |

Nội dung sim:
- Menu: ≤ 7 dòng, một dấu "/", dưới 100 byte, mọi callback tồn tại.
- Rương:
  - tắt rồi bật lại chiến đấu, hoặc tự bật sau 3 tick;
  - đổi bản đồ thì không ép bật;
  - Thiên Lao, sự kiện, phó bản bị chặn.
- Dọn túi:
  - 19 loại đồ, chỉ đúng 3 món bị bán, tổng 850 lượng;
  - đồ 2×3 ô chỉ tính 1 lần;
  - danh sách chỉ dùng 1 lần;
  - đồ rời túi hoặc bị thay giữa chừng thì không bán;
  - đồ xanh dưới cấp X, vòng cấp 3/5/7/9/11;
  - bộ lọc rỗng;
  - chưa có hàm C++ thì không bán gì;
  - mỗi lần bán ghi 1 dòng nhật ký.
- Bộ lọc nhặt: 3 trang, bật/tắt từng bit, gửi xuống client, khôi phục mặc định.
- Tick:
  - phát lệnh bài, không phát trùng;
  - túi đầy hoặc chưa có ptfix thì thử lại phút sau;
  - 19 lần gửi task mỗi nhân vật;
  - tự dọn chỉ khi ≤ 3 ô trống, có bật bit và ở bản đồ hợp lệ;
  - admin online/offline, file chờ giữ qua khởi động lại server;
  - lỗi trong tick được bắt.

Nội dung smoke C++:
- Phân loại 15 kiểu đồ.
- Mặt nạ mặc định / đã gửi / bộ nhớ đệm khi vào bản đồ / nhân vật khác.
- Nhặt món gần nhất, bỏ qua đồ trắng, đồ vứt ra, đồ quá xa, đồ chỉ có ở client.
- Không quá 2 yêu cầu, cách nhau ≥ 400 ms; bỏ qua 45 giây rồi thử lại.
- Chạy tới tiền ở xa 300; vòng dây; quá 6 giây; túi đầy (bỏ đồ, vẫn nhặt tiền, 1 thông báo); túi vừa đầy; chỉ số bị dùng lại.
- Tích hợp tick:
  - không có quái thì đi nhặt thay vì về chỗ cũ;
  - đang nhặt dở thì nhặt xong rồi đánh;
  - có mục tiêu thì đồ chờ.
- Alt+P đủ 3 trạng thái. Nhặt khi đứng yên, tạm dừng khi bấm chuột, bán kính 192.
- Thanh buff: đếm và điền, độ lệch đồng hồ, giới hạn nMax, điền 0 ô thừa, bộ nhớ đệm, giới hạn thời gian.

## Phần 3: Hành động

### 3.1 File đã sửa / thêm

| File | Loại | Nội dung |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\PhongThanAutoFight.inl` | sửa (vá byte, ASCII, dấu `hanhtrang`) | Tự nhặt, Alt+P, `PTAF_SyncedTask` |
| `…\Core\Src\PhongThanBuffBar.inl` | mới | `PTBuffBar_Fill` |
| `…\Core\Src\CoreShell.cpp` | sửa (dấu `hanhtrang:B5`) | 2 nhánh `GDI_NPC_STATE_SKILL` + include |
| `…\Core\Src\ScriptFuns.cpp` | sửa (dấu `hanhtrang`) | `LuaPTItemSaleInfo` + đăng ký `"PTItemSaleInfo"` (server) |
| `…\GameClient\Ui\ShortcutKey.cpp` | sửa | Alt+P |
| `…\GameClient\Ui\UiCase\UiPlayerControlBar.cpp` | sửa | Sửa rò bộ nhớ `Breathe` / hàm hủy |
| `PhongThanRuntime-Staging\Server\script\phongthan\item\hanhtrang_lenhbai.lua` | mới (đã chép runtime) | Script lệnh bài |
| `…\item\hanhtrang_lib.lua` | mới (đã chép runtime) | Tick, admin, file chờ, phát lệnh bài, gửi task, tự dọn |
| `…\ext\hanhtrang.lua` | mới (đã chép runtime) | `PTEXT_hanhtrang_Tick` |
| `scratchpad\ptfix\extra_hanhtrang.py` | mới | Dòng magicscript 61500 (Server + Client) |
| `scratchpad\items\deploy\Client\Ui\ui3\UiPlayerControlBar.ini` | mới (chờ chép) | 6 dòng buff |
| `AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html` | sửa | `HanhTrangToken`, `hanhtrang`, `/api/hanhtranglog`, thẻ 5, nút Phát đồ |
| `CHANGELOG.md`, `docs\features\README.md` | sửa | Mục mới |

Không sửa: `servertimer.lua`, `pt_ibitem_lib.lua`, `starter_gear.lua`, `build_ptfix.py`, các script Thủ Khố, Headers, giao thức.

Sao lưu: `_backup\20261004-items\` (đường dẫn tương đối như gốc; web admin có thêm bản `*.before-items-HHMMSS` chụp ngay trước khi chèn).

### 3.2 Cần triển khai (coordinator / người dùng)

- [ ] Thêm `"hanhtrang"` vào `PTADM_EXT_NAMES` trong `Server\script\servertimer.lua` (chỉ coordinator sửa). Có thể kích hoạt nóng qua bridge: `ReLoadScript("\\script\\phongthan\\item\\hanhtrang_lenhbai.lua")` + thêm tên vào bảng.
- [ ] Build ptfix chính thức (Client trước, Server sau). Plug-in `extra_hanhtrang.py` tự được nạp. Triển khai cho **cả Server và Client**.
- [ ] Triển khai **CoreServer.dll** (`PTItemSaleInfo` cho Dọn túi), **CoreClient.dll** (tự nhặt + thanh buff) và **Game.exe** (Alt+P + sửa rò bộ nhớ). Lấy từ `Core\Modern\Win32ServerRelease`, `Win32ClientRelease`, `GameClient\Modern\Win32Release`. Các bản build này có cả thay đổi của agent khác cùng đợt.
- [ ] Sao lưu rồi chép `scratchpad\items\deploy\Client\Ui\ui3\UiPlayerControlBar.ini` đè lên `PhongThanRuntime-Staging\Client\Ui\ui3\UiPlayerControlBar.ini`. File này không nằm trong PAK, client đọc bản rời.
- [ ] Người dùng khởi động lại GameServer (đăng ký script lệnh bài rời), đóng và mở lại web admin, rồi F5.

### 3.3 Kiểm thử trong game

1. Chờ ≤ 1 phút: nhận "Lệnh Bài Hành Trang" (hình Túi Càn Khôn). Rê chuột: tên màu cam, mô tả đúng dấu.
2. Ở bãi luyện công, nhấp phải → "Mở rương chứa đồ": khung rương mở, mũi tên phải sang Rương 2–5. Cất 1 món. Chọn "Bật lại trạng thái chiến đấu". Lần khác bỏ quên: sau khoảng 3 phút tự bật lại.
3. Bỏ vài đồ trắng / xanh vào túi → "Dọn túi": khung chat liệt kê, hộp xác nhận ghi số món và tiền, giá khớp giá cửa hàng. Đồng ý → tiền tăng đúng tổng. Đồ đang mặc, pháp bảo, đồ khóa, bí kíp, đá quý vẫn còn.
4. Bật tự đánh (Alt+S): giết quái, nhân vật chạy nhặt đồ rơi (trừ đồ trắng, thuốc) rồi đánh tiếp. Vứt 1 món xuống đất: không bị nhặt lại.
5. Alt+P ba lần: thông báo "THEO LỆNH BÀI" → "LUÔN BẬT" → "TẮT". Ở "LUÔN BẬT", tắt tự đánh, đứng gần đồ: sau 1,5 giây tự nhặt.
6. Dùng một vật phẩm nhân đôi kinh nghiệm hoặc quay Càn Khôn Luân: trong ≤ 1 phút, biểu tượng hiện cạnh thanh máu, có số phút còn lại; rê chuột thấy tên và giờ:phút:giây. Đổi bản đồ: biểu tượng vẫn còn.
7. Web admin, thẻ 5: bỏ tích "Tiền", Áp dụng → trong game không nhặt tiền nữa. Bấm "Xem nhật ký" → thấy các món đã bán.

### 3.4 Rollback

- Chép lại 5 file C++ từ `_backup\20261004-items\PhongThanSource\...`, xóa `PhongThanBuffBar.inl`, build lại. Hoặc triển khai lại DLL/EXE cũ.
- Chép lại `PhongThan-Admin.ps1`, `index.html` từ bản `*.before-items-*`.
- Xóa 3 file Lua `hanhtrang*` và plug-in `extra_hanhtrang.py`, build lại ptfix, bỏ `"hanhtrang"` khỏi `PTADM_EXT_NAMES`. Task 2640–2645 vô hại nếu để lại.
- ini: chép lại bản trong `_backup\20261004-items\PhongThanRuntime-Staging\Client\Ui\ui3\`.

### 3.5 Giới hạn

- Client không biết chủ của đồ dưới đất. Đồ của người khác hoặc đồ đang trong thời gian bảo vệ tốn tối đa 2 yêu cầu (server từ chối, có 1 dòng thông báo của engine) rồi bị bỏ qua 45 giây.
- Đồ chồng được (nguyên liệu) khi túi đã hết ô trống: `SearchPosition` báo không có chỗ nên không nhặt, kể cả khi lẽ ra gộp được vào chồng cũ.
- Thanh buff cập nhật theo tick phút: biểu tượng mới xuất hiện chậm tối đa 1 phút. `pt_ibitem_lib.lua` không được sửa để gửi ngay.
- Mỗi lần quét túi, engine ghi các dòng "[error] FindItem1/2" vào debug log, mỗi ô phụ của đồ nhiều ô một dòng (vô hại).
- `UiPlayerControlBar` chỉ hiện tối đa 20 biểu tượng (gồm cả trạng thái kỹ năng).

## Phần 4: Tài liệu tham khảo

- `de-xuat-tinh-nang-phong-than-20261004.md`: đề xuất nhóm B, B5.
- `lenh-bai-dao-si-phong-than-20261004.md`: kênh `SyncTaskValue`, `PTAF_TaskValue`, mẫu tick + admin offline.
- `lenh-bai-luyen-cong-phong-than-20261003.md`: mẫu lệnh bài dùng mãi + tự phát.
- `mo-ruong-2-5-phong-than-20261003.md`: Rương 2–5 (`SetExpandBox`, `OpenBox`).
- `lenh-bai-huy-do-phong-than-20260930.md`: bán đồ qua cửa hàng tại chỗ, task 1940.
- `vat-pham-ibitem-lo-buff-phong-than-20260929.md`, `can-khon-luan-quay-cpp-phong-than-20261002.md`: buff vật phẩm IB, task 1906–1938, 2021.
- Mã engine:
  - `KPlayer.cpp`: `PickUpObj`, `ServerPickUpItem`, `CheckObject`;
  - `KObj.h`;
  - `KProtocolProcess.cpp`: `SyncObjectAdd`;
  - `KBuySell.cpp`: `Sell`;
  - `KItem.cpp`: `GetQuality`, `GetSalePrice`;
  - `ScriptFuns.cpp`: `FindItemEx`, `RemoveItem`, `OpenBox`;
  - `CoreShell.cpp`: `GDI_NPC_STATE_SKILL`;
  - `GameClient\Ui\UiCase\UiPlayerControlBar.cpp`.
- Công cụ `scratchpad\items\`:
  - `gen.py` sinh Lua;
  - `patch_cpp.py`, `patch_admin.py`, `gen_ini.py`;
  - `extra_hanhtrang.py`, `verify_pak.py`, `scan_ids.py`;
  - `smoke\` (mk_smoke.py, mocks.inc, tests.inc).
- Mô phỏng: `scratchpad\qtest\sim_hanhtrang.lua`, `test_admin_hanhtrang.ps1`.
