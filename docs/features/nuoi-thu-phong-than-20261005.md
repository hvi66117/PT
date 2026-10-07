# Nuôi thú: thức ăn linh thú và đệ tử, mục Nuôi thú trong Lệnh Bài Hành Trang, web admin

Ngày: 2026-10-05. Yêu cầu: "Chưa có đồ để nuôi thú, cho ăn trong lệnh bài và webadmin."

Trạng thái:
- Lua đã chép vào runtime và áp nóng lúc 21:10 (`result.log`: `nuoithu OK ... lib=1 ltlib=1 pelib=1 pile=1 main_kept=1`). Mục **Nuôi thú** trong Lệnh Bài Hành Trang dùng được ngay. Nhận Linh Thú Đơn mỗi ngày cũng dùng được ngay.
- Hai vật phẩm mới, **Đệ Tử Linh Đơn** (61550) và **Linh Thú Đại Đơn** (61551), cần ptfix mới có `extra_nuoithu.py`, sau đó khởi động lại server và client.
- Phần web admin cần người dùng tự đóng rồi mở lại web admin.

## Phần 1: Tổng quan

- **Không thú nào có độ đói.** Cả linh thú, đệ tử Dị Nhân lẫn thú cưỡi đều không có cơ chế đói, nên cũng không có cho ăn tự động. Thức ăn chỉ để tăng kinh nghiệm và cấp.
- **Linh thú đã có thức ăn nhưng người chơi thiếu nguồn.** Linh Thú Đơn (+30 kinh nghiệm) có từ 2026-10-03, nhưng chỉ Sinh Hoạt Sư chế tạo và Lễ Quan tặng 2 viên mỗi ngày. Nay người chơi nhận 20 viên mỗi ngày ở lệnh bài, và admin phát được tới 1.000 viên một lần.
- **Đệ tử Dị Nhân trước đây chưa có đồ nuôi nào.** Đệ tử chỉ lên cấp khi cùng chủ đánh quái (tổng 66.000 kinh nghiệm để từ cấp 1 lên 10). Nay có thêm Đệ Tử Linh Đơn (+1.000), nhận 10 viên mỗi ngày.
- **Dữ liệu VNG không có thức ăn dùng được cho các hệ thú này.** "Thức ăn" của VNG thuộc hệ thú cưng nhặt đồ (宠物), engine không có hệ này. Nội đơn của VNG là nguyên liệu học kỹ năng Linh Thú, cần giao diện client mà engine cũng không có. Vì vậy hai vật phẩm mới là **thiết kế của Phong Thần**. Hai vật phẩm chỉ mượn hình Nội Đơn của VNG.

| Hệ thú | Cấp và kinh nghiệm | Độ đói | Thức ăn sau thay đổi |
|---|---|---|---|
| Linh thú (Linh Thú Sứ, Linh Thú Lệnh) | Task 2392–2399. Cấp tối đa của mỗi giai đoạn = giai đoạn × 10 (tối đa cấp 40) | Không có | Linh Thú Đơn 61379 (+30, đã có), **Linh Thú Đại Đơn 61551** (+300, mới) |
| Đệ tử Dị Nhân (Lệnh Bài Triệu Hồi) | Cấp 1–10 ở task 2505, kinh nghiệm trong cấp ở task 2506 | Không có | **Đệ Tử Linh Đơn 61550** (+1.000, mới) |
| Thú cưỡi | Không có cấp hay kinh nghiệm (horse.txt và mã engine) | Không có | Không cần |

## Phần 2: Chi tiết

### 2.1 Dữ liệu VNG đã tra

Cách tra:
- Quét nội dung văn bản của 19 PAK phía Server bằng `scratchpad\nuoithu\scanfood.py`. Từ khóa GBK: 饲料, 喂食, 喂养, 饱食, 饥饿, 宠物经验, 坐骑经验, 马料, 内丹. Từ khóa ASCII: siliao, FeedPet, PetFeed, Hunger, HorseExp. Từ khóa TCVN3: "thức ăn", "cho ăn", "Nội đơn", "độ no", "đói bụng".
- Đọc các bảng magicscript, material, ibitem, questkey, horse bằng `scan1.py` và `rows.py`.
- Tìm trong mã nguồn engine (`PhongThanSource\Sources`).

| Vật phẩm / dữ liệu VNG | Mã | Tác dụng trong VNG | Script | Dùng được ở đây? |
|---|---|---|---|---|
| Bao quà Thức ăn | ibitem 8/474/2 | Mở ra 10 "Thức ăn" cho thú cưng nhặt đồ (宠物) | `\script\item\礼包\siliaolibao.lua` | Không. Engine không có hệ thú cưng nhặt đồ: không có `pet.ini`, `FeedPet` hay độ đói trong mã nguồn |
| Gói Thức Ăn (Lớn) | magicscript 6/1/1593 | Gói 250 Thức Ăn | `\script\item\卦卷\开包操作.lua` (không có trong PAK) | Không |
| Giao diện cho thú cưng ăn | `ui\ui3\宠物喂养界面.ini`, nút `Pet_BtnAutoFeedPet` (tự cho ăn) | Bảng thú cưng VNG ở client | — | Không (client không có bảng này) |
| Nội đơn kỹ năng Linh Thú | material 3/487–544 (3/536–544 mang tên đệ tử Dị Nhân: Lực Sĩ Tế … Phong Quyển Tàn Vân); 3/5538–5550 | "Giúp Linh thú lĩnh ngộ kỹ năng, giúp chủ nhân tăng hiệu quả kỹ năng" | Không có (nguyên liệu, genre 3) | Không. Hệ kỹ năng Linh Thú cần bảng thú ở client |
| Nội Đơn (thấp / trung / cao) | material 3/554 / 3/555 / 3/556 | Thầy tướng số ở Tây Kỳ giám định ra nội đơn kỹ năng cấp 1–30 / 31–60 / 61–90 | Không có | Không. Chỉ mượn **hình** `\spr\item\内丹\中级内丹.spr` và `高级内丹.spr` (có ở cả Server và Client) |
| Bột Nội đơn, túi Nội Đơn | 3/1012; 6/1/2240–2243 | Hợp thành Nội Đơn (thấp); gói 250 viên | `开包操作.lua` (thiếu) | Không |
| Linh Sủng thuộc tính (属性灵宠) | magicscript 6/1/1339–1348, 1541… | Thú dạng vật phẩm, cộng chỉ số qua IBBuff 1784–1793 | `\common\属性灵宠.luax` | Không (đã kết luận ở `le-quan-sinh-hoat-linh-thu-phong-than-20261003.md`) |
| Đan Châu Phù Dung Đỗ | magicscript 6/1/648, 666; ibitem 8/965, 983 | "Thức ăn cấp 10": người chơi ăn để hóa giải Thổ sát | — | Không phải đồ cho thú |
| Thức ăn (Thành Thị) | material 3/137 | Thức ăn cho Thất Thạch cầu (sự kiện) | — | Không phải đồ cho thú |
| Thức ăn của Dị nhân | questkey 4/30 | Vật phẩm nhiệm vụ tộc Xi Vưu | — | Không phải đồ cho thú |
| Hồn Phách Thần Thú | magicscript 6/1/2027… | Thu thập hồn phách cho ngoại trang thú cưỡi | `horse_vision…` | Không phải thức ăn |
| Thú cưỡi | horse.txt | Không có cột độ đói hay kinh nghiệm | — | Không cần cho ăn |
| Đệ tử triệu hồi | summonskill.txt, Npcs.txt | VNG lên cấp bằng điểm kỹ năng, không có bảng kinh nghiệm thú (xem `pet-exp-phong-than-20261003.md`) | — | Dùng bảng của Phong Thần: cần 200 × cấp × (cấp + 1) |

Kết luận: không có vật phẩm VNG nào đúng nghĩa "thức ăn" cho linh thú hay đệ tử chạy được trên engine này. Theo yêu cầu, ưu tiên đồ tăng kinh nghiệm và cấp, **không thêm cơ chế đói**.

### 2.2 Vật phẩm

Hai dòng mới trong `settings\item\001\magicscript.txt` ở cả Server và Client, giống hệt nhau. Thêm bằng plug-in `scratchpad\ptfix\extra_nuoithu.py`.

| Mã 6/1/… | Tên | Tác dụng khi nhấp phải | Chồng | Giao dịch | Script |
|---|---|---|---|---|---|
| 61379 (đã có) | Linh Thú Đơn | Linh thú hiện tại +30 kinh nghiệm | 100 | Có | `sinhhoat\lt_don.lua` |
| **61550** | **Đệ Tử Linh Đơn** | Đệ tử Dị Nhân +1.000 kinh nghiệm. Ở cấp 10 thì không mất | 100 | Có | `item\nuoithu_detudon.lua` |
| **61551** | **Linh Thú Đại Đơn** | Linh thú hiện tại +300 kinh nghiệm (bằng 10 Linh Thú Đơn). Không vượt giới hạn cấp của giai đoạn. Khi đã đầy cấp thì không mất | 100 | Có | `item\nuoithu_ltdaidon.lua` |

Các thuộc tính khác: vĩnh viễn, không rơi khi chết, không cược, không bán cho cửa hàng, cho bày bán. Engine không tự trừ vật phẩm (cột 23 = 0), script trừ khi dùng có tác dụng. Hình: Nội Đơn (trung) và Nội Đơn (cao) của VNG.

Khối mã 61550–61559 đã được kiểm tra trên cả magicscript Server và Client (bản ptfix v28), mọi `extra_*.py`, generator, file json trong scratchpad và cả dự án: chưa ai dùng.

### 2.3 Lệnh Bài Hành Trang → "Nuôi thú"

Lệnh Bài Hành Trang (61500) tự phát cho mọi nhân vật. Menu chính có thêm một dòng **"Nuôi thú: cho ăn, nhận thức ăn"**, đặt trước "Đóng". Menu chính tối đa 7 dòng.

Không tạo lệnh bài riêng, vì 3 lý do:
- ai cũng đã có Lệnh Bài Hành Trang;
- không tốn thêm mã vật phẩm;
- phần này áp nóng được ngay, không cần chờ ptfix.

Menu Nuôi thú (`nuoithu_lib.lua`, hàm `PTNT_Main`):

| Dòng | Việc |
|---|---|
| Lời thoại | Linh thú hiện tại (tên, giai đoạn, cấp, kinh nghiệm/cần). Dị Nhân thì có thêm cấp và kinh nghiệm đệ tử. Báo "Hôm nay chưa nhận thức ăn" nếu còn lượt. Ghi rõ thú không bị đói |
| Cho linh thú ăn | Cho ăn 1 Linh Thú Đơn (+30), 10 Linh Thú Đơn (+300), 1 Linh Thú Đại Đơn (+300), hoặc **Ăn đến đầy cấp giai đoạn**: dùng Đại Đơn khi vừa đủ chỗ, rồi Linh Thú Đơn, cuối cùng 1 Đại Đơn nếu còn thiếu ít. Không bao giờ ăn quá giới hạn giai đoạn. Đầy cấp thì nhắc tiến hóa ở Linh Thú Sứ; ở giai đoạn 4 cấp 40 thì báo cấp tối đa |
| Cho đệ tử ăn (chỉ Dị Nhân) | 1 viên (+1.000), 10 viên (+10.000), hoặc **Ăn đến cấp tối đa (10)**. Dùng `PTPE_AddExp`: lên cấp có thông báo; đệ tử đang đứng ngoài được áp chỉ số và kỹ năng cấp mới ngay |
| Nhận thức ăn hôm nay | Miễn phí, mỗi ngày 1 lần: **20 Linh Thú Đơn** cho mọi phái, thêm **10 Đệ Tử Linh Đơn** cho Dị Nhân. Cần 1 ô trống (Dị Nhân 2 ô). Không phát được gì thì không tính lượt. Thiếu dòng Đệ Tử Linh Đơn (chưa cài ptfix) thì vẫn phát Linh Thú Đơn và báo thiếu |
| Xem trạng thái thú | Mọi linh thú đang có, đánh dấu con đang dùng; cấp đệ tử; thú cưỡi không cần cho ăn; số thức ăn đang có |
| Quay lại | Về menu Lệnh Bài Hành Trang |

- Thức ăn chỉ lấy trong hành trang (`DelNormalItem`), không lấy trong rương. Số "đang có" tính cả rương.
- Đổi linh thú hiện tại vẫn làm ở Linh Thú Lệnh. Linh Thú Lệnh vẫn giữ mục "Cho ăn Linh Thú Đơn".
- Linh thú đang triệu hồi được đổi tên `Tên [cấp]` ngay sau khi ăn.
- Lý do chọn lượng mỗi ngày: linh thú cần 1.950 kinh nghiệm từ cấp 1 lên 40, tức 65 Linh Thú Đơn, chưa tính kinh nghiệm khi chiến đấu và nguyên liệu tiến hóa. 20 viên mỗi ngày giúp lên khoảng một giai đoạn mỗi 1–2 ngày. Đệ tử cần 66.000 kinh nghiệm; 10.000 mỗi ngày cộng thêm đánh quái thì khoảng 1 tuần lên cấp 10.

### 2.4 Web admin

Tab **Thú cưỡi**, thẻ mới **"Nuôi thú (thức ăn linh thú, đệ tử Dị Nhân)"**:

| Nút | Hành động | Lua qua bridge |
|---|---|---|
| Phát đồ nuôi thú (chọn loại + số lượng 1–1.000) | `nuoithugive`, khóa `NuoiThuLTDon` / `NuoiThuLTDai` / `NuoiThuDTDon` | `PTAdm_Give(...)`: `AddItem` + `AddItemIDStack`, tự gộp chồng 100 |
| Cho thú ăn đầy | `nuoithu` mode 1 | `PTNT_AdminFeed(id, tên, 1)`: mọi linh thú lên đầy cấp của giai đoạn hiện tại; đệ tử Dị Nhân +1 cấp |
| Tăng cấp thú tối đa (có hỏi xác nhận) | `nuoithu` mode 2 | `PTNT_AdminFeed(id, tên, 2)`: mọi linh thú lên giai đoạn 4 cấp 40, bỏ qua nguyên liệu tiến hóa; đệ tử cấp 10 |

- Nhân vật phải online. Nếu offline, `result.log` ghi `FAIL offline`.
- Linh thú đang triệu hồi được đổi tên. Nếu đổi giai đoạn thì được gọi lại bằng mẫu NPC mới.
- Ba khóa mới cũng dùng được với nút "Phát cho người chơi" chung (tối đa 50).
- `PhongThan-Admin.ps1` vẫn thuần ASCII (0 byte > 127, CRLF, không lỗi cú pháp). File đã được đọc lại và so với bản sao lưu ngay trước khi ghi.

### 2.5 Task và file

| Mục | Giá trị |
|---|---|
| Task **2646** | Ngày nhận thức ăn gần nhất (yyyymmdd). Dải 2646–2669 đã quét bằng `petexp\taskscan.py` (mọi PAK, `script.pak`, ptfix đang chạy, script rời, settings, bridge): không có `GetTask`/`SetTask`, chỉ có tọa độ và tỉ lệ rơi trùng số |
| Task đọc/ghi lại | Linh thú 2388, 2389, 2390–2399 (sinhhoat); đệ tử 2505, 2506, 1941/1942 (petexp) |

| File | Thay đổi |
|---|---|
| `scratchpad\nuoithu\gen.py` (mới) | Generator: sinh `nuoithu_lib.lua`, `nuoithu_detudon.lua`, `nuoithu_ltdaidon.lua` (ASCII, TCVN3 dạng `\ddd`, CRLF) |
| `Server\script\phongthan\item\nuoithu_lib.lua` (mới) | `PTNT_*`: menu, cho ăn, nhận theo ngày, trạng thái, dùng vật phẩm, `PTNT_AdminFeed`. **Không có `main()`**: Include vào Lệnh Bài Hành Trang lúc chạy, dofile vào servertimer khi admin gọi |
| `Server\script\phongthan\item\nuoithu_detudon.lua`, `nuoithu_ltdaidon.lua` (mới) | `main` của 61550 và 61551 |
| `scratchpad\items\gen.py` | Thêm dòng "Nuôi thú" và hàm `PTHT_NuoiThu`. Hàm Include `nuoithu_lib.lua` lúc chạy, có `call` bảo vệ; thiếu lib thì báo chưa cài. Sinh lại: `hanhtrang_lib.lua` và `ext\hanhtrang.lua` giống từng byte, `hanhtrang_lenhbai.lua` chỉ thêm 19 dòng ASCII |
| `Server\script\phongthan\item\hanhtrang_lenhbai.lua` | Bản sinh lại ở trên |
| `scratchpad\ptfix\extra_nuoithu.py` (mới) | 2 dòng magicscript 61550/61551 cho Server + Client |
| `AdminWeb\PhongThan-Admin.ps1` | `Get-ItemCode` có 3 khóa mới; hành động `nuoithugive` và `nuoithu` |
| `AdminWeb\index.html` | Thẻ Nuôi thú ở tab Thú cưỡi, 3 nút |

Sao lưu: `_backup\20261005-nuoithu\` gồm `hanhtrang_lenhbai.lua`, `items_gen.py`, `PhongThan-Admin.ps1`, `index.html`, `CHANGELOG.md`, `features_README.md`.

### 2.6 Kiểm thử

| Kiểm thử | Kết quả |
|---|---|
| `qtest\sim_nuoithu.lua`: lib thật, `sh_lib.lua` và `petexp_lib.lua` thật từ runtime | 86/0 ở cả 4 chế độ: `-Stack 100`, `emu` (khoảng trống nhỏ nhất 45 khung), `live`, `emu,live` |
| `qtest\sim_hanhtrang_nt.lua`: sim Hành Trang cũ đổi sang menu 6/7 dòng, cộng 10 kiểm tra cho dòng Nuôi thú | 116/0 ở cả 4 chế độ (khoảng trống 39 khung, bằng bản cũ) |
| `qtest\test_admin_nuoithu.ps1`: trích hàm từ `.ps1` bằng AST, không chạy web | 16/0. Lua sinh ra được `sim_nuoithu` chạy lại qua bridge giả (4/4 lệnh) |
| ptfix thử `scratchpad\nuoithu\ptfix_test.pak` (Server, 679 entry) và `ptfix_test_client.pak` (Client, 104 entry) | So với v28, chỉ khác `magicscript.txt`, đúng +2 dòng 61550/61551. Hai dòng giống hệt nhau giữa Server và Client. Hình 中级内丹/高级内丹 có ở cả hai phía |
| Áp nóng 21:10 | `nuoithu OK reloaded ... lib=1 ltlib=1 pelib=1 pile=1 main_kept=1 incerr=nil`. Không có lỗi tick |

`sim_nuoithu` kiểm tra:
- menu 4/5/6 dòng hợp lệ (≤ 7 dòng, < 100 byte, callback có thật);
- Giáp Sĩ không thấy dòng đệ tử;
- nhận theo ngày: túi đầy, đã nhận, sang ngày mới, tạo thất bại thì không tính lượt, Dị Nhân cần 2 ô, thiếu dòng Đệ Tử Linh Đơn;
- cho linh thú ăn đúng số kinh nghiệm, dừng ở giới hạn giai đoạn (180/570/1.160), không lấy trong rương, "ăn đến đầy" phối hợp đúng 2 loại, đổi tên linh thú đang triệu hồi;
- đệ tử: 1 → 2 → 5 → 10, đệ tử đang đứng ngoài đổi tên `[10]Tên` và kỹ năng 143 cấp 10, cấp 10 từ chối;
- nhấp phải 2 vật phẩm: chỉ mất khi có tác dụng;
- admin mode 1, mode 2, offline, không có thú, mode lạ, gọi lại linh thú khi đổi giai đoạn, `PlayerIndex` được trả về nil.

## Phần 3: Hành động

### 3.1 Coordinator cần làm

- [ ] Build ptfix chính thức (ví dụ v29) bằng `scratchpad\ptfix\build_ptfix.py`: Client trước, Server sau. `extra_nuoithu.py` đã nằm sẵn trong thư mục ptfix. Bản thử ở `scratchpad\nuoithu\` chỉ khác v28 ở 2 dòng magicscript.
- [ ] Chép ptfix vào `Server\data` và `Client\data`, rồi khởi động lại GameServer và client. Từ lúc này mới có 61550/61551.
- [ ] Ghi vào `CHANGELOG.md`, README và tài liệu Hành Trang: menu chính Hành Trang nay có thêm dòng "Nuôi thú". Bản sim cũ `sim_hanhtrang.lua` còn kiểm tra menu 5/6 dòng nên sẽ báo sai; từ nay dùng `sim_hanhtrang_nt.lua`.

### 3.2 Người dùng cần làm

- [ ] Đóng web admin rồi mở lại bằng launcher thường dùng, sau đó F5 trình duyệt. Claude không tự khởi động lại web admin.
- [ ] Trong game (dùng được ngay, chưa cần ptfix): mở Lệnh Bài Hành Trang → "Nuôi thú" → "Nhận thức ăn hôm nay". Phải nhận 20 Linh Thú Đơn; bấm lại thì báo đã nhận.
- [ ] Có linh thú: "Cho linh thú ăn" → "Ăn đến đầy cấp giai đoạn". Linh thú lên tới giới hạn giai đoạn, linh thú đang triệu hồi đổi tên `[cấp]`.
- [ ] Sau khi cài ptfix mới và khởi động lại: Dị Nhân nhận thêm 10 Đệ Tử Linh Đơn; nhấp phải 1 viên thì đệ tử +1.000 kinh nghiệm; "Ăn đến cấp tối đa" lên cấp 10.
- [ ] Web admin, tab Thú cưỡi → Nuôi thú: phát 100 Linh Thú Đơn; bấm "Cho thú ăn đầy" và "Tăng cấp thú tối đa" với nhân vật đang online. Kiểm tra lịch sử lệnh và `result.log`.

### 3.3 Gỡ bỏ (nếu cần)

- Khôi phục `hanhtrang_lenhbai.lua`, `PhongThan-Admin.ps1`, `index.html` và `scratchpad\items\gen.py` từ `_backup\20261005-nuoithu\`.
- Xóa 3 file `nuoithu_*.lua` và `extra_nuoithu.py`, rồi build lại ptfix. Task 2646 để lại cũng không ảnh hưởng gì.

## Phần 4: Tài liệu tham khảo

- `le-quan-sinh-hoat-linh-thu-phong-than-20261003.md`: hệ linh thú, Linh Thú Đơn, tiến hóa.
- `pet-exp-phong-than-20261003.md`: cấp và kinh nghiệm đệ tử Dị Nhân 1–10.
- `hanh-trang-phong-than-20261004.md`: Lệnh Bài Hành Trang.
- `do-tan-thu-vu-khi-thu-cuoi-phong-than-20261002.md`, `mat-nguoi-khi-cuoi-thu-phong-than-20260929.md`: thú cưỡi.
- Công cụ tra cứu: `scratchpad\nuoithu\scanfood.py`, `scan1.py`, `rows.py`, `show.py`, `hit.py`, `ids.py`, `verify_pak.py`.
- Bước tiếp theo nếu muốn:
  - cho Lễ Quan hoặc quái thả Đệ Tử Linh Đơn;
  - bán Linh Thú Đại Đơn ở Kỳ Trân Các;
  - nếu sau này có C++ cho hệ kỹ năng Linh Thú, Nội đơn VNG (3/487–556) có thể dùng đúng tác dụng gốc.
