# Kỳ Trân Các bán đá quý và Bình Sinh Lực / Nội Lực Vĩnh Cửu

Ngày: 2026-10-04 · Agent: kytrancac · Trạng thái: đã build thử ptfix (đợt 2: sửa lệch tab), đã build thử CoreClient, đã sửa web admin, đã chép 2 script rời; **chưa triển khai ptfix/CoreClient**.

## Phần 1: Tổng quan

**Yêu cầu**
1. "Kỳ Trân Các bán các loại Hồng Bảo Thạch, Lam Bảo Thạch, Mảnh Hồng, Mảnh Lam."
2. Yêu cầu bổ sung: "Bán cả máu to và mana to vĩnh viễn ở Kỳ Trân Các. Máu này dùng vĩnh viễn: cứ dùng cái là đầy luôn."

**Kết quả**
- Kỳ Trân Các (F2) có thêm 6 loại đá ở **đầu tab 4 "Nâng cấp"** (`upgradegoods.txt`): Mảnh Hồng Thủy Tinh, Hồng Thủy Tinh, Hồng Bảo Thạch, Mảnh Lam Thủy Tinh, Lam Thủy Tinh, Lam Bảo Thạch.
- Hai vật phẩm mới **Bình Sinh Lực Vĩnh Cửu** (61520) và **Bình Nội Lực Vĩnh Cửu** (61521) nằm ở **đầu tab 2 "Dược phẩm"** (`potiongoods.txt`):
  - nhấp phải hoặc bấm phím thanh nhanh 1–0 là hồi **đầy** sinh lực / nội lực ngay;
  - không mất sau khi dùng;
  - hồi chiêu 2 giây;
  - không dùng được khi trọng thương.
- Tự đánh (Alt+A) dùng được hai bình này khi chúng nằm ở thanh phím nhanh. Việc này cần bản vá C++ `kytrancac:AF1` trong `CoreClient.dll`.
- Web admin có 2 nút phát bình (ô "Phát vật phẩm").

**Ba điểm cần biết**

| # | Điểm | Ảnh hưởng |
|---|---|---|
| 1 | Kỳ Trân Các **không thu Xu**. Mọi món có giá cố định **1 lượng** (`PHONGTHAN_IBSHOP_UNIT_PRICE = 1`, đơn vị `moneyunit_money`). Cột giá trong `ibshopgoods.txt` không được dùng. | Đá quý và bình vĩnh cửu hiện chỉ tốn 1 lượng mỗi món. Muốn thu theo giá thì phải sửa C++ (xem Phần 3). |
| 2 | VNG **không bán** các loại đá này lẻ ở Kỳ Trân Các. VNG chỉ có "Lễ bao Lam Bảo Thạch" (9 viên, 60 xu, không nằm trong tab nào) và "Quà Bảo Thạch" (3 Lam Bảo Thạch + 3 Trầm Điện, 50 xu). | Giá đề xuất được suy ra từ hai gói này. |
| 3 | (Đã sửa ở đợt 2, xem cuối tài liệu) Engine đọc tab **lệch một hàng** so với file VNG. Tab ghi số V thì engine hiện hàng V−1 (đếm từ 0), trong khi file VNG ghi số hàng đếm từ 0. Ví dụ: tab Dược phẩm hiện "Đội Trưởng Chiêu Tập Lệnh" thay cho "Quan Âm Thủy". | Lỗi có từ trước, không do đợt này. Các dòng mới đã ghi theo cách engine đọc nên hiện đúng. Xem Phần 3. |

## Phần 2: Chi tiết

### 2.1 Mã vật phẩm và giá

Mã đá lấy từ `material.txt` (vng00). Server và Client giống hệt nhau. Lam Thủy Tinh và Mảnh Lam cùng nhóm "đá đục lỗ / ép bí kíp" nên bán cả bộ.

| Vật phẩm | Mã | Xếp chồng | Giá thực thu (engine) | Giá đề xuất (ghi ở cột ShowPrice/ActualPrice) | Nguồn giá đề xuất |
|---|---|---|---|---|---|
| Mảnh Hồng Thủy Tinh | 3/77 | 100 | 1 lượng | 1 xu | Bậc thấp nhất, ngang Bảo Tá Thanh Lộ (1–2 xu) |
| Hồng Thủy Tinh | 3/28 | 100 | 1 lượng | 3 xu | Bậc giữa (Mảnh → Thủy Tinh → Bảo Thạch) |
| Hồng Bảo Thạch | 3/79 | 100 | 1 lượng | 7 xu | Ngang Lam Bảo Thạch |
| Mảnh Lam Thủy Tinh | 3/78 | 100 | 1 lượng | 1 xu | Như Mảnh Hồng |
| Lam Thủy Tinh | 3/80 | 100 | 1 lượng | 3 xu | Như Hồng Thủy Tinh |
| Lam Bảo Thạch | 3/41 | 10 | 1 lượng | 7 xu | VNG: Lễ bao 9 viên = 60 xu (≈ 6,7 xu/viên) |
| Bình Sinh Lực Vĩnh Cửu | 6/61520 (magicscript) | 1 | 1 lượng | 300 xu | Thanh Lộ VNG (200.000 điểm) giá 8 xu; bình dùng mãi ≈ 37 bình Thanh Lộ |
| Bình Nội Lực Vĩnh Cửu | 6/61521 (magicscript) | 1 | 1 lượng | 300 xu | Như trên (Chân Khí 8 xu) |

**Mua đúng số lượng:**
- Mỗi lượt mua tính 1 món (`StackCount` = 1).
- `KBuySell::Buy` thêm từng món bằng `KItemList::Add(..., bAutoStack = true)`, nên đá tự gộp vào chồng sẵn có theo MaxStack của `material.txt` (100, riêng Lam Bảo Thạch là 10).
- Ví dụ: mua 30 Lam Bảo Thạch được 3 chồng 10.
- Cần ít nhất 1 ô trống (`CanBuy` kiểm tra trước).
- Bình vĩnh cửu không xếp chồng: mỗi bình một ô.

### 2.2 Kỳ Trân Các trong dữ liệu và C++

- **Dữ liệu:**
  - `settings\ibshop\ibshopgoods.txt` là danh sách hàng (468 hàng VNG). Cột Genre, DetailType, ParticularType, Level, Series, StackCount, ShowPrice, ActualPrice, …, NewItem.
  - 8 file tab theo thứ tự: suggest, potion, charm, upgrade, promise, mics, pendant, special. Tab thứ 9 "Tất cả" do engine tự tạo.
  - Các file này có trong vng00/serverlist/settings.pak và bản loose. Hai phía giống hệt nhau. ptfix v27 không đụng tới.
- **C++ (`KBuySell.cpp`):**
  - `KBuySell::Init` tạo vật phẩm theo genre. Genre 3 gọi `Gen_Material(DetailType)`. Genre 6 gọi `Gen_MagicScript(DetailType)`, nên dòng magicscript phải ghi **mã 61520/61521 ở cột DetailType**.
  - Init cũng gán giá `SetNewPrice(PHONGTHAN_IBSHOP_UNIT_PRICE)`.
  - Tab: giá trị V → `pIBShopItemIndex[V-1]`.
  - `ibshop_loader_diag.log` của runtime ghi: `rows=469 generated=469 categories=8 unit_price=1 result=ready`. 469 = 468 hàng VNG + 1 hàng Truyền Tống tổng hợp.
- **Mở F2:**
  - `enumC2S_PLAYERCOMMAND_ID_SUPERSHOP` gọi `BuySell.OpenSale(nIndex, 0, moneyunit_money, 9, 95..103)`.
  - Mua: `KPlayer::BuyItem` → `KBuySell::Buy`, rồi `Player.Pay(1 × số lượng)`.
  - Kỳ Trân Các mua được ở mọi nơi.
  - Client cũng hiện giá 1 (`CoreShell.cpp`).
  - Không có script Lua nào xử lý mua.

### 2.3 Bình vĩnh cửu: vì sao chọn magicscript

| Cách | Lên thanh phím nhanh? | Không mất? | Kết luận |
|---|---|---|---|
| Thuốc genre 1 (`potion.txt`) | Có (`bShortKey = TRUE`) | Không: `NowEatItem` luôn `RemoveItem(nIdx, 1)` | Loại |
| IB genre 8 (`ibitem.txt`) | **Không**: `KItem = KBASICPROP_IBITEM` đặt `bShortKey = FALSE` | Có | Loại |
| **Magicscript genre 6** | **Có**: `KBPT_MagicScript::LoadRecord` đọc cột 20 (VNG "是否可放快捷栏") vào `m_bShortKey`; `CanShortKey()` cần 1×1 | **Có**: `NowEatItem` chỉ gọi `ExecuteScript`, script không xóa | **Chọn** |

- Dùng từ thanh nhanh: `KUiPlayerBar::OnUseItem` → `GOI_USE_ITEM` → `ApplyUseItem` → server `EatItemByID` chấp nhận `pos_immediacy` → `NowEatItem` → `main(nItemIdx)`.
- Hai dòng magicscript nhân bản từ token 61003/7308:
  - tên `#<c=red>Bình Sinh Lực Vĩnh Cửu<c>` / `#<c=blue>Bình Nội Lực Vĩnh Cửu<c>`;
  - hình VNG Đại Hồng Đơn `\spr\item\medecine\大红.spr` và Đại Hoàn Đơn `大蓝.spr` (có trong `spr.pak` Client);
  - cột 13 = 0 (không xếp chồng), cột 20 = 1 (thanh nhanh), cột 24 = 0 (không mất).
- **Script** `\script\phongthan\item\vinhcuu_sinhluc.lua` / `vinhcuu_noiluc.lua` (sinh bởi `scratchpad\kytrancac\gen_lua.py`, ASCII + TCVN3 dạng `\ddd`):
  - Chết hoặc đang hồi sinh (`IsPlayerInDeath()` = 1 hoặc `GetLife(0)` ≤ 0): báo và thoát. Không tính hồi chiêu.
  - Hồi chiêu 36 vòng lặp = **2 giây** (18 vòng/giây, `GetGameTime`), riêng từng nhân vật và từng loại bình. Bảng nằm trong Lua state của script nên reset khi khởi động lại server. Không có `GetGameTime` thì bỏ hồi chiêu, không chặn.
  - Máu đã đầy (`GetLife(0)` ≥ `GetLife(1)` = `m_CurrentLifeMax`): báo, không tính hồi chiêu.
  - Nội lực không kiểm "đã đầy", vì `GetMana(1)` trả `m_ManaMax` (gốc), còn `RestoreMana` nạp tới `m_CurrentManaMax`.
  - Sau đó gọi `RestoreLife()` / `RestoreMana()` (C++: `m_CurrentLife = m_CurrentLifeMax`).
- **Tự đánh (`PhongThanAutoFight.inl`, `PTAF_UseQuickPotion`, marker `kytrancac:AF1`):**
  - Ô thanh nhanh chứa magicscript 61520 được coi là bình đỏ, 61521 là bình xanh. Thuốc thường giữ nguyên.
  - Nhịp tự đánh 2,5 giây mỗi loại, dài hơn hồi chiêu 2 giây, nên không bao giờ bị từ chối.
  - Hàm cũ chỉ nhận `item_medicine`.
- Không chặn theo bản đồ. Bản đồ sự kiện cấm thuốc theo engine vẫn cho dùng bình, vì đây là vật phẩm script.

### 2.4 File

| File | Thay đổi | Sao lưu |
|---|---|---|
| `scratchpad\ptfix\extra_kytrancac.py` | Mới: plug-in ptfix (2 dòng magicscript, 8 dòng ibshopgoods, 2 tab), cả Server và Client, chạy lại không thêm trùng | (file mới) |
| `scratchpad\kytrancac\gen_lua.py` → `out\script\phongthan\item\vinhcuu_sinhluc.lua`, `vinhcuu_noiluc.lua` | Mới: script 2 bình (chưa chép vào runtime) | (file mới) |
| `PhongThanSource\Sources\Core\Src\PhongThanAutoFight.inl` | Vá `kytrancac:AF1` (+384 byte, chỉ thân `PTAF_UseQuickPotion`, giữ mọi marker khác), qua `scratchpad\kytrancac\apply_af.py` (mức byte, idempotent) | `_backup\20261004-kytrancac\Sources\Core\Src\PhongThanAutoFight.inl` |
| `AdminWeb\PhongThan-Admin.ps1` | `Get-ItemCode`: `BinhSinhLucVC` → 6/61520, `BinhNoiLucVC` → 6/61521 (ASCII thuần, parse 0 lỗi) | `_backup\20261004-kytrancac\AdminWeb\PhongThan-Admin.ps1` |
| `AdminWeb\index.html` | 2 nút "Phát Bình Sinh Lực / Nội Lực Vĩnh Cửu" và ghi chú dưới hàng lệnh bài, dùng ô nhân vật `givePlayer` | `_backup\20261004-kytrancac\AdminWeb\index.html` |
| `qtest\sim_kytrancac.lua` | Mới: mô phỏng 2 script | (file mới) |

### 2.5 Kiểm thử

- **Build thử ptfix** (Client trước, Server sau; không ghi đè `ptfix_v*.pak`):

  | Bản build | Số mục | v27 | Mục thêm | Mục thiếu |
  |---|---|---|---|---|
  | `scratchpad\kytrancac\ptfix_test_client.pak` | 45 | 42 | 3 | 0 |
  | `scratchpad\kytrancac\ptfix_test.pak` (Server) | 620 | 617 | 3 | 0 |

  - Ba mục thêm: `ibshopgoods.txt` (48a58ee0), `upgradegoods.txt` (ea921420), `potiongoods.txt` (184b853b).
  - `magicscript.txt` đã có trong v27; bản mới có thêm 2 dòng 61520/61521, cột 20 = 1, cột 13 = 0.
  - Ba file shop giống hệt nhau giữa Server và Client.
- **Mô phỏng tab theo `KBuySell::Init`** (`s7_verify.py`):
  - tab Nâng cấp, ô 0–5: 3/77, 3/28, 3/79, 3/78, 3/80, 3/41, rồi tới hàng VNG cũ;
  - tab Dược phẩm, ô 0–1: 61520, 61521.
- **Sim Lua `sim_kytrancac.lua`:**
  - `-Stack 100`: 22 ok / 0 lỗi;
  - EMU (`-Stack 0 -Args1 emu`, đệm 47 khung): 0 lỗi, còn trống tối thiểu 46 khung.
  - Các ca đã thử: hồi đầy, hồi chiêu 2 giây báo còn 2/1 giây, máu đầy không tốn hồi chiêu, hai nhân vật hồi chiêu riêng, chết bị từ chối, nội lực nạp tới max hiện tại, nhịp tự đánh 45 vòng × 20 lần đều hồi, thiếu `GetGameTime` không chặn, không gọi hàm xóa vật phẩm.
- **Build thử CoreClient:**
  - Bản sao cây nguồn `scratchpad\kytrancac\tree`, `Build-Modern.ps1 -Targets CoreClient`: OK.
  - DLL có hằng 61520/61521.
  - Bản DLL: `scratchpad\kytrancac\build\CoreClient.dll`. Đây chỉ là bản thử; DLL triển khai nên build lại từ cây thật.

## Phần 3: Hành động

**Triển khai** (coordinator; cần dừng GameServer theo quy trình thường):
- [ ] Gộp `extra_kytrancac.py` vào lần build ptfix chính thức kế tiếp (v28+). Cài cho cả Server và Client.
- [ ] Chép `scratchpad\kytrancac\out\script\phongthan\item\vinhcuu_sinhluc.lua` và `vinhcuu_noiluc.lua` vào `PhongThanRuntime-Staging\Server\script\phongthan\item\`. Script được đăng ký khi khởi động; nếu server đang chạy thì nạp nóng bằng `ReLoadScript("\\script\\phongthan\\item\\vinhcuu_sinhluc.lua")`.
- [ ] Build lại CoreClient từ cây thật (đã có `kytrancac:AF1`) và triển khai `CoreClient.dll` cho Client. Chỉ cần nếu muốn Tự đánh dùng bình; tay vẫn dùng được với DLL cũ.
- [ ] Mở lại web admin (người dùng tự mở) để thấy 2 nút mới.

**Kiểm thử trong game:**
- [ ] F2 → tab Nâng cấp: 6 loại đá ở đầu, có dấu "mới". Mua 30 Lam Bảo Thạch thì được 3 chồng 10, trừ 30 lượng.
- [ ] F2 → tab Dược phẩm: 2 bình ở đầu. Mua 1 bình, kéo lên ô phím nhanh 1, bấm 1 khi mất máu thì đầy ngay, bình còn nguyên. Bấm lại trong 2 giây thì có thông báo hồi chiêu.
- [ ] Alt+A, đặt bình ở thanh nhanh: máu dưới 50% thì tự dùng bình.

**Cần người dùng quyết định:**
1. **Giá thật:** Kỳ Trân Các đang bán mọi thứ 1 lượng. Muốn thu Xu theo cột ActualPrice thì phải sửa C++ ở 4 chỗ:
   - `KBuySell::Init` dùng ActualPrice;
   - `CanBuy` / `Buy` dùng `GetCurPrice()`;
   - F2 mở với `moneyunit_extpoint` hoặc trừ vật phẩm Xu (Nhiệm vụ 47);
   - `CoreShell` hiện đúng giá.
   Thay đổi này ảnh hưởng mọi món, nên chưa làm.
2. **Lệch tab:** sửa C++ `pIBShopItemIndex[nIBIndex]` (nhận cả giá trị 0), hoặc cộng +1 cho mọi số VNG trong 8 file tab qua ptfix. Nếu sửa C++ thì đổi `IBSHOP_INDEX_BASE = 0` trong `extra_kytrancac.py`.

## Đợt 2 (2026-10-05): sửa lệch tab, giữ giá 1 lượng

Người dùng quyết định:
1. **Giữ giá 1 lượng** như hiện tại, không sửa C++ phần giá.
2. **Sửa lỗi lệch tab.**

**Cách làm (ptfix, không sửa C++):**
- `extra_kytrancac.py` thêm `_shift_vng`: cộng +1 cho mọi số VNG trong cả 8 file tab (suggest 17, potion 34, charm 13, upgrade 37, promise 43, mics 39, pendant 6, special 10).
- Ô đầu dòng tiêu đề đổi `Index` → `IndexPT1` để đánh dấu file đã dịch. `KTabFile` đọc theo số cột nên tiêu đề không ảnh hưởng. Chạy lại không dịch hai lần.
- Hàm chạy trước khi thêm dòng mới. Dòng mới vẫn ghi theo cách engine đọc, nên `IBSHOP_INDEX_BASE` giữ nguyên = 1: sau khi dịch, mọi số trong tab đều là "hàng dữ liệu + 1".
- `micsgoods.txt` của VNG dùng xuống dòng LF, plug-in giữ nguyên kiểu xuống dòng của từng file.
- Không cần build CoreServer/CoreClient cho phần này.

**Kết quả:**
- Mỗi ô giờ hiện đúng món VNG đã định. Ví dụ tab Dược phẩm: trước hiện hàng 32/207/135 (Chuộc Hồn Châu…), giờ hiện 33/208/136 (Quan Âm Thủy…).
- Số 0 của VNG (Dao Tinh tán, tab Dược phẩm) trước bị engine bỏ qua, giờ đã hiện.

**Kiểm chứng `scratchpad\kytrancac\s8_tabs.py`:**
- Mô phỏng `KBuySell::Init` cho cả 9 tab ở cả Server và Client, gồm ô Truyền Tống tổng hợp 8/35/2 (hàng 476) ở đầu tab Giới thiệu và Bùa chú, cùng tab "Tất cả" 477 ô.
- Mọi tab khớp với "món VNG theo số VNG + đá/bình mới ở đầu tab": 0 lỗi.
- Chạy plug-in 2 lần trên cùng dữ liệu, lần 2 không đổi gì.

**Build thử lại** (không ghi đè `ptfix_v*.pak`):

| Bản build | Số mục | v27 | Mục thêm | Mục thiếu |
|---|---|---|---|---|
| `scratchpad\kytrancac\ptfix_test_client.pak` | 51 | 42 | 9 | 0 |
| `scratchpad\kytrancac\ptfix_test.pak` (Server) | 626 | 617 | 9 | 0 |

9 mục thêm gồm `ibshopgoods.txt` và 8 file tab.

**Script:**
- Đã chép `vinhcuu_sinhluc.lua` và `vinhcuu_noiluc.lua` vào `PhongThanRuntime-Staging\Server\script\phongthan\item\` (script rời).
- Script được đăng ký khi khởi động server. Nếu muốn có ngay thì nạp nóng bằng `ReLoadScript`; dù vậy vật phẩm vẫn cần ptfix mới.

**Còn lại khi triển khai:**
- ptfix chính thức có `extra_kytrancac.py`, cài cho cả Server và Client;
- CoreClient build lại từ cây thật (`kytrancac:AF1`, chỉ để Tự đánh dùng bình);
- mở lại web admin.

## Phần 4: Tài liệu tham khảo

- `PhongThanSource\Sources\Core\Src\KBuySell.cpp` (Init, CanBuy, Buy), `GameDataDef.h:1567–1570`, `KProtocolProcess.cpp:5326`, `KItemList.cpp` (Add, NowEatItem, EatItemByID, ExecuteScript), `KBasPropTbl.CPP` (magicscript/IB loader), `KItem.cpp:1337` (CanShortKey).
- Dữ liệu: `material.txt`, `ibitem.txt` hàng 233 / 296, `potion.txt`.
- Liên quan: `stack-gem-phong-than-20261003.md` (MaxStack đá), `lenh-bai-luyen-cong-phong-than-20261003.md` (mẫu token magicscript), `can-khon-luan-quay-cpp-phong-than-20261002.md` (Kỳ Trân Các).
- Công cụ: `scratchpad\kytrancac\` (`kpk.py`, `s1`–`s7`, `gen_lua.py`, `apply_af.py`), `scratchpad\qtest\sim_kytrancac.lua`.
