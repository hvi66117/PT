# Lâm Tiên Lộ, Tiểu Thiên Hương Tục Mệnh Lộ, Thanh Lộ, Sơn Thủy Chân Khí: làm bằng Lua

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 (chẩn đoán), 2026-09-30 (triển khai Lua theo yêu cầu) · Trạng thái: **Đã triển khai, có hiệu lực ở lần khởi động lại server kế tiếp** (gói `ptfix.pak` bản 2 tự cài lúc bật server). Mô phỏng đạt; chưa kiểm thử trong game.

## Phần 1: Tổng quan
- **Nguyên nhân gốc:**
  - Cột script của các món này là `NONE`.
  - Loader ibitem của bản dựng lại không đọc các cột thời gian, loại buff, thuộc tính hay dung lượng bình.
  - Server nhận lệnh dùng nhưng không làm gì.
- **Cách làm (không cần C++):**
  1. `ptfix.pak` trỏ cột script của **61 dòng** ibitem (28 bình máu/mana, 29 buff kinh nghiệm…) sang `\script\phongthan\ibitem\pt_ibitem.lua`.
  2. Script đọc loại qua `GetItemPartByID`: 3 là bình máu, 4 là bình mana, 0 là buff.
  3. Buff kinh nghiệm dùng thẳng thuộc tính engine: `ModifyAttrib(181, %)` cho +% kinh nghiệm, `ModifyAttrib(187, 100)` cho ×2 kinh nghiệm kỹ năng.

## Phần 2: Chi tiết

### 2.1 Bình máu / mana (Thanh Lộ, Bảo Tá Thanh Lộ, Chân Khí, Sơn Thủy Chân Khí, bản Như ý, bản Siêu Cấp…) — bản 2 (09:15)
- **Bản 1 (hồi đầy một lần) đã bỏ.** Trong túi, bình có số lượng là 1 chứ không phải dung lượng, nên dùng một lần là mất.
- **Bản 2, theo quyết định "tính theo dung lượng":**
  - Dùng 1 bình thì trừ 1 bình và bật **hồi phục liên tục** bằng thuộc tính gốc của engine: `lifereplenish_v` (88) cho sinh lực, `manareplenish_v` (92) cho nội lực.
  - Mức hồi mỗi nhịp đúng chỉ số của bình: 50, 200, 250… (VNG ghi là "mỗi nửa giây").
  - **Thời gian = dung lượng ÷ 50.000 ngày.** Dùng thêm bình thì cộng dồn thời gian; mức hồi lấy theo bình mạnh nhất.

| Bình | Hồi / nhịp | Dung lượng | Thời gian |
|---|---|---|---|
| Thanh Lộ (tiểu), Chân Khí (tiểu), bản Như ý (tiểu) | 50 | 50.000 | 24 giờ |
| Thanh Lộ, Chân Khí, Thanh Lộ/Chân Khí (Như ý) | 50 | 200.000 | 96 giờ |
| Bảo Tá Thanh Lộ, Sơn Thủy Chân Khí | 250 | 35.000 | 16,8 giờ |
| Tá Thanh Lộ / Thủy Chân Khí (Như ý) | 250 | 180.000 | 86,4 giờ |
| Tá Thanh Lộ / Thủy Chân Khí Siêu Cấp (Như ý) | 200 | 120.000 | 57,6 giờ |
| Thanh Lộ Phúc Hộ / Chân Khí Sơn Thủy Siêu Cấp | 250 | 140.000 | 67,2 giờ |

- Các món dung lượng 1 ("Hoàn Mệnh") là cơ chế khác nên không đưa vào.
- **Biến nhiệm vụ:** 1911/1912 hạn và mức hồi sinh lực; 1913/1914 hạn và mức hồi nội lực; 1917–1920 lưu phần đang áp. Có thêm +1% kinh nghiệm làm "dấu hiệu" khi đang có hiệu ứng, để nhận biết lúc engine tính lại chỉ số.

### 2.2 Buff kinh nghiệm (Tiểu Thiên Hương Tục Mệnh Lộ, Thiên Hương, Lâm Tiên Lộ, bánh Trung Thu, Buff x2…)
| Vật phẩm (ví dụ) | Hiệu quả | Thời hạn |
|---|---|---|
| Tiểu Thiên Hương Tục Mệnh Lộ | Kinh nghiệm +50%, kinh nghiệm kỹ năng ×2 | 1 ngày |
| Thiên Hương / Thiên Hương (Như ý) | Kinh nghiệm +50%, kinh nghiệm kỹ năng ×2 | 7 ngày |
| Lâm Tiên Lộ / Như ý Lâm Tiên Lộ | Kinh nghiệm kỹ năng ×2 | 1 giờ |

- Toàn bộ 29 món lấy thẳng số liệu từ `ibitem.txt` (bảng `PTIB_BUFF` trong `pt_ibitem_data.lua`).
- Dùng thêm một món **cùng loại** thì cộng dồn thời gian. Dùng món **khác loại** thì thay buff cũ.
- **Giữ buff khi mặc/tháo đồ hoặc đăng nhập lại:** mỗi phút `servertimer.lua` (`PTAdm_IbTick`) kiểm tra từng người chơi online.
  - Nếu engine đã tính lại chỉ số (làm mất buff) thì áp lại.
  - Hết hạn thì gỡ buff và báo "Hiệu quả tăng kinh nghiệm đã hết".
  - Sau khi đăng nhập lại, buff có thể trễ tối đa 1 phút mới áp lại.
- **Biến nhiệm vụ dùng:** 1906 hạn dùng, 1907 % kinh nghiệm, 1908 ×2 kỹ năng, 1909 mốc kiểm tra, 1910 đang bật.

### 2.3 Tệp
| Tệp | Vai trò |
|---|---|
| `Server\script\phongthan\ibitem\pt_ibitem.lua` | Script của vật phẩm |
| `...\pt_ibitem_lib.lua` | Áp, gỡ, kiểm tra buff (dùng chung cho vật phẩm và servertimer) |
| `...\pt_ibitem_data.lua` | Bảng 29 buff, sinh từ `ibitem.txt` |
| `scratchpad\ibitem\gen.py` | Bộ sinh 3 file trên và danh sách dòng cần trỏ script |
| `scratchpad\ptfix\build_ptfix.py` | Thêm ghi đè `\settings\item\001\ibitem.txt` vào `ptfix.pak` |
| `AdminWeb\pending\ptfix.pak` | Gói bản 2 chờ cài; `PhongThan-ClientPatch.ps1` tự cài khi GameServer và client đều tắt, rồi cập nhật `NATIVE_DEPLOYMENT.json` |

## Phần 3: Hành động
- [ ] Dừng server (bảng điều khiển), thoát game, chạy `PhongThan-ChayTatCa.cmd game`. Cửa sổ lệnh phải báo "Da cai ptfix.pak moi".
- [ ] Mất bớt máu rồi click phải Thanh Lộ hoặc Sơn Thủy Chân Khí: máu/mana đầy lại, số lượng của bình giảm đúng số điểm đã hồi.
- [ ] Dùng Tiểu Thiên Hương Tục Mệnh Lộ: có thông báo "kinh nghiệm +50%, kinh nghiệm kỹ năng x2, thời hạn còn 1440 phút"; đánh quái thấy kinh nghiệm tăng.
- **Khi có trình biên dịch C++:** có thể làm đúng kiểu VNG (hồi đều mỗi nửa giây) bằng cách sửa `KBPT_IBItem::LoadRecord` và `NowEatItem`.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KNpcAttribModify.cpp:1071-1091` (ExpEnhanceP / ExpSkillsEnhanceP), `KMagicAttribRegistry.inc` (181, 187), `ScriptFuns.cpp` (ModifyAttrib 10136, SetStackItem 12641, RemoveItem 12416, GetItemPartByID 3809)
- `goi-va-ptfix-pak-phong-than-20260929.md`
