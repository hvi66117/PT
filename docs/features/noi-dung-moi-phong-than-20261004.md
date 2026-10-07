---
tinh-nang: Nội dung mới đợt 4 — Lịch sự kiện tự động (E1), Quà đăng nhập 7 ngày (E2), Bảng thành tích (E4), Nhị Lang Thần (D5), tên NPC Sùng Thành (D6)
ngay: 2026-10-04
agent: content
trang-thai: Đã cài file rời và áp nóng qua admin bridge lúc 20:46 (kiểm lại 20:49). Không cần ptfix, không cần khởi động lại GameServer. Web admin cần người dùng tự đóng và mở lại để thấy 2 tab mới.
tom-tat: Server tự chạy lịch sự kiện theo ngày/giờ (Vạn Tiên, Thương Chu, boss thế giới, nhân đôi kinh nghiệm) có báo trước 5 phút; quà đăng nhập mỗi ngày + quà 7 ngày liên tiếp, túi đầy thì giữ lại; bảng thành tích 6 hạng mục có mốc thưởng, xem ở Lễ Quan và web admin; Nhị Lang Thần ở Diêu Trì đổi được 3 Liễu Mộc lấy 1 Hạt thần bí; Thủ Khố, Tạp Hóa, Sinh Hoạt Sư ở Sùng Thành và 5 con lạc đà có tên tiếng Việt. Task 2540–2553.
---

# Nội dung mới đợt 4: lịch sự kiện, quà đăng nhập, thành tích, Nhị Lang Thần, tên NPC Sùng Thành

## Phần 1: Tổng quan

- **Insight chính:**
  - **Nhị Lang Thần không hề thiếu.** VNG đã đặt NPC này ở Diêu Trì (dữ liệu vùng `maps\瑶池_S`, template 223, ô 1630/3226 = màn hình [203,201]); NPC đang sống trong game (idx 1323). Người chơi không thấy vì tên GBK hiện chữ lỗi, còn script VNG gọi `GetItemCount(39)` (engine hiểu 39 là *nhóm* vật phẩm) nên luôn báo thiếu Liễu Mộc. Vì vậy **không spawn thêm** (sẽ ra 2 con), chỉ đổi tên và gắn script đã sửa.
  - **Engine không có ExpRate đổi nóng được.** `g_ExpRate` chỉ đọc một lần lúc khởi động. Nhân đôi kinh nghiệm theo lịch dùng hiệu ứng **Đặc quyền Bạch Hổ** (+100% kinh nghiệm đánh quái, task 2021, tự hết hạn) cộng cho từng người chơi, nên không bao giờ phải "trả lại hệ số cũ".
  - **Không có hook đăng nhập dùng được** (`player\playerlogin.lua` bị bản PAK che). Quà đăng nhập chạy bằng tick mỗi phút: quà vào túi trong vòng 1 phút sau khi vào game.
  - **Thành tích gần như không cần sửa file của tính năng khác.** Boss, Vạn Tiên, Thương Chu, nhiệm vụ hằng ngày, tân thủ, cấp đệ đều đọc được bằng cách "dò" task mỗi phút. Chỉ số quái đã hạ cần một wrapper nhỏ nối vào cuối `npc_quests\normal.lua`.
- **Phát hiện ngoài phạm vi (quan trọng):** `PTAdm_GiveTo` trong `servertimer.lua` (dòng 42) và `nhiemvu_data.lua:381` gọi `AddItemIDStack(idx)` với 1 đối số. Theo `ScriptFuns.cpp:3397`, hàm này cần ít nhất 2 đối số, nên vật phẩm xếp chồng (nguyên liệu, Không Thư, thuốc IB) được tạo bằng `AddItem` nhưng **không vào túi**, trong khi log vẫn ghi OK. Nút "Nguyên liệu ép sách" và "Phát đồ" vật phẩm chồng của web admin bị ảnh hưởng. Các tính năng mới ở đây dùng `AddNormalItemPile` nên không dính lỗi này. Chưa sửa vì chạm vào servertimer ngoài danh sách ext.

| Tính năng | Cách làm | Trạng thái |
|---|---|---|
| E1 Lịch sự kiện tự động | ext `eventsched` + `content\ev_lib.lua`; cấu hình `admin_bridge\eventsched_config.lua`; tab web "Lịch sự kiện" | Đang chạy; mặc định bật x2 kinh nghiệm T7 + CN 20:00–22:00 |
| E2 Quà đăng nhập | ext `dailygift` + `content\dg_lib.lua`; Lễ Quan → "Quà đăng nhập 7 ngày"; tab web "Quà & thành tích" | Đang chạy (DaoSi1 đã nhận quà ngày 1 lúc 20:46) |
| E4 Bảng thành tích | ext `thanhtich` + `content\ac_lib.lua`; wrapper đếm quái trong `normal.lua`; Lễ Quan → "Bảng thành tích"; tab web | Đang chạy |
| D5 Nhị Lang Thần | `npc_fix\1052_nhi_lang_than.lua` + dòng EXTRA của `gen_npcnames.py` | Đã đổi tên, gắn script (idx 1323) |
| D6 Tên NPC Sùng Thành | `gen_npcnames.py` (FORCE/EXTRA) + ext `noidung` (lạc đà) | Đã đổi tên 4 NPC 1002 + 5 lạc đà, không NPC trùng |

## Phần 2: Chi tiết

### 2.1 Task đã dùng (dải 2540–2579)

- Đã quét: mọi entry của 23 PAK Server và 23 PAK Client (giải nén, 6.067 entry), 13.264 file rời (script, settings, admin_bridge, AdminWeb, mã C++), plug-in ptfix và mọi dải task khai báo trong docs. Danh sách 1.421 id đang dùng: `S\content\research\task_ids_used.txt`.
- Dải 2540–2579 không có ở đâu dưới dạng task (chỉ trùng số dòng bảng vật phẩm, toạ độ). 2400–2439 và 2500–2539 đã có người dùng (Càn Khôn, sư đồ, lãnh địa, pet exp).
- **Giới hạn lưu:** mỗi nhân vật lưu tối đa 255 task khác rỗng (`PHONGTHAN_CHARACTER_MAX_TASKS`). Vì vậy chỉ dùng 14 id, gói nhiều giá trị vào một số, và chỉ ghi task khi giá trị khác 0.

| Task | Ý nghĩa |
|---|---|
| 2540 | E1: thời điểm kết thúc (SystemTime) của sự kiện x2 mà người chơi đã nhận |
| 2541 | E2: ngày đăng nhập cuối đã tính (yyyymmdd) |
| 2542 | E2: chuỗi ngày (0–7) + 10 × quà ngày đang giữ (0–7) + 100 × quà 7 ngày đang giữ (0–3) |
| 2543 | E2: tổng số ngày đăng nhập |
| 2544 | E4: boss thế giới đã hạ |
| 2545 | E4: việc hằng ngày đã xong (daily2 + daily3, cộng dồn suốt đời) |
| 2546 | E4: tổng các bộ đếm `*_DONE` của daily2/daily3 lần dò trước (các bộ đếm này về 0 mỗi ngày) |
| 2547 | E4: số lần vào Vạn Tiên trận (mỗi phiên một lần) |
| 2548 | E4: số quái đã hạ |
| 2549 | E4: cấp đệ tử cao nhất từng thấy |
| 2550 | E4: mốc đã nhận, chữ số thứ k = hạng mục k |
| 2551 | E4: khoá phiên Vạn Tiên đã đếm (task 2003) |
| 2552 | E4: số lần vào chiến trường Thương Chu (mỗi trận một lần) |
| 2553 | E4: khoá trận Thương Chu đã đếm (task 2340) |
| 2554–2579 | Để dành cho các tính năng này |

### 2.2 E1 — Lịch sự kiện tự động

- **Chạy trong game**, không phụ thuộc web admin (khác tab "Sự kiện" cũ, vốn chỉ chạy khi cửa sổ web admin đang mở).
- **Cấu hình:** `admin_bridge\eventsched_config.lua`, server đọc lại mỗi phút. File hỏng cú pháp thì giữ cấu hình trước. Trạng thái các lần đã chạy lưu ở `admin_bridge\eventsched_state.lua`, nên khởi động lại giữa chừng không chạy lặp.
- **Mỗi dòng lịch:** bật/tắt, các ngày trong tuần, giờ:phút, loại, tham số, tiêu đề thông báo (để trống thì tự đặt).
  - Mỗi dòng chạy **một lần mỗi ngày**, trong 3 phút kể từ giờ hẹn (bù cho tick trễ).
  - `AddGlobalNews` trước N phút (mặc định 5, chỉnh 1–30) và khi bắt đầu. Vạn Tiên, Thương Chu và boss tự đăng tin khi mở, nên lịch không đăng trùng.

| Loại | Thực hiện | Tham số |
|---|---|---|
| Mở Vạn Tiên trận | `PTVT_AdminOpen(n)` | trận 1–4, hoặc 0 = cả 4 |
| Mở chiến trường Thương Chu | `PTVC_ForceOpen()` | — |
| Gọi boss thế giới | `PTWB_SpawnKey(key)` | 12 boss (ly_long, giao_long…) |
| Nhân đôi kinh nghiệm | `PTIB_BaihuExtend(thời gian còn lại)` cho mỗi người online và người vào game trong lúc sự kiện; mỗi người nhận 1 lần/sự kiện (task 2540) | số phút (1–1440) |

- **Không xung đột lịch VNG (cách xử lý):**
  - *Vạn Tiên:* lịch VNG `PTVT_SCHED` (02:00, 10:00, 13:00, 18:00, 21:00, 23:00, trận 2/3/4 lệch 5/10/15 phút) giữ nguyên. Nếu trận đang mở, `PTVT_AdminOpen` trả 2 → lịch chỉ ghi "đã mở sẵn / lịch VNG", không mở lại, không reset.
  - *Thương Chu:* VNG mở **mỗi giờ** phút 00–44. Dòng lịch rơi vào lúc trận đang mở bị bỏ qua và ghi "busy" (không gọi `PTVC_ForceOpen`, vì hàm này kết toán trận đang chạy). Web admin cảnh báo vàng nếu hẹn phút < 45.
  - *Boss:* boss đang sống thì `PTWB_SpawnKey` trả 0 → ghi "đang sống", không gọi thêm. Lịch VNG của boss giữ nguyên.
  - *Nhân đôi kinh nghiệm:* không đụng `ExpRate`. Ai đang có thẻ Bạch Hổ được cộng thêm thời gian sự kiện, không mất thời gian thẻ. Khi hết, game hiện thông báo hết hạn Đặc quyền Bạch Hổ (tên VNG của hiệu ứng). Nút "Tắt nhân đôi kinh nghiệm ngay" chỉ dừng cấp thêm; thời gian đã cộng cho người chơi vẫn giữ.
- **Mặc định** (file tạo lúc 20:44): x2 kinh nghiệm T7 + CN 20:00, 120 phút (**bật**); mẫu Vạn Tiên trận 1 T7 20:30, Thương Chu CN 20:50, boss Ly Long hằng ngày 21:30 (**tắt**).
- **Web admin, tab "Lịch sự kiện":**
  - Bảng sửa trực tiếp: thêm / xóa dòng, bật / tắt, chọn ngày, giờ, loại, tham số, tiêu đề.
  - Cột "Lần tới" do web admin tính; "Lần gần nhất" và kết quả lấy từ `eventsched.txt`.
  - Nút "Chạy ngay" (bridge `PTEV_AdminRun`), "Tắt nhân đôi kinh nghiệm ngay" (`PTEV_AdminStopExp`).
  - Route `GET/POST /api/eventsched`, action `evrun`, `evstopexp`.

### 2.3 E2 — Quà đăng nhập hằng ngày và tích lũy 7 ngày

- **Đếm ngày:** lần tick đầu tiên của ngày (hoặc khi nói chuyện với Lễ Quan).
  - Hôm qua đã tính thì chuỗi + 1, không thì về 1. Đủ 7 thì vòng sau bắt đầu lại từ 1.
  - Mỗi ngày xếp 1 quà ngày; ngày thứ 7 xếp thêm quà lớn.
- **Phát an toàn:**
  - Chỉ phát khi `CalcFreeItemCellCount()` đủ cho **mọi dòng** quà (mỗi dòng cần ⌈số lượng / chồng tối đa⌉ ô).
  - Vật phẩm phát bằng `AddNormalItemPile` (bộ VNG, tự xếp chồng; engine hủy chứ không làm rơi khi lỗi, và bước kiểm ô trống chặn trường hợp đó).
  - Túi thiếu ô thì quà **được giữ lại** (tối đa 7 quà ngày, 3 quà 7 ngày), có thông báo mỗi 30 phút; dọn túi là nhận ở tick sau hoặc ở Lễ Quan.
- **Nhận quà:** tự vào túi kèm thông báo, hoặc **Lễ Quan → "Quà đăng nhập 7 ngày"** (5 thành và Diêu Trì/Phong Thần Đài), hiện chuỗi ngày, quà đang giữ và danh sách quà.
- **Danh sách quà mặc định.** Mọi vật phẩm có ở cả Server và Client: thuốc và nguyên liệu nằm trong các PAK VNG giống hệt nhau hai bên; dòng IB nằm trong `ptfix.pak` Server = Client.

| Quà | Vật phẩm (bộ VNG g/d/p) | Số lượng |
|---|---|---|
| Mỗi ngày | Đại Hồng đơn 1/2/0 (cấp 1) | 10 |
| | Đại Hoàn đơn 1/5/0 (cấp 1) | 10 |
| | Hồng Thủy Tinh 3/28/0 | 1 |
| | Tiền | 20.000 lượng |
| Ngày thứ 7 | Buff x2 kinh nghiệm 24 giờ 8/1380/0 | 1 |
| | Không Thư (Bạch) 8/139/2 | 5 |
| | Hồng Thủy Tinh 3/28/0 | 5 |
| | Đại Hồng đơn 1/2/0 | 30 |
| | Tiền | 200.000 lượng |

- Không chọn Lệnh Bài Tiếp Tế làm quà ngày: lệnh bài này đã được tự phát một lần cho mọi nhân vật (task 2612) và dùng mãi. Buff x2 (+100%, kiểu IB) cộng dồn được với Bạch Hổ của E1 vì là hai cơ chế khác nhau.
- Lễ Quan vẫn giữ "Nhận lễ vật hằng ngày" cũ (sinhhoat); hai quà độc lập với nhau.
- **Web admin, tab "Quà & thành tích":**
  - Bật / tắt, tiền quà ngày / quà 7 ngày.
  - Hai bảng quà: sửa số lượng, chồng tối đa, xóa. Thêm vật phẩm bằng ô tìm kiếm của danh mục; mã runtime được đổi sang bộ VNG (`ConvertTo-DgRow`).
  - Ghi `admin_bridge\dailygift_config.lua`, server đọc lại mỗi phút.

### 2.4 E4 — Bảng thành tích

| # | Hạng mục | Nguồn đếm | Mốc thưởng |
|---|---|---|---|
| 1 | Hạ boss thế giới | Dò `PTWB_KILLER` (wb_lib, cùng state servertimer): người hạ đòn cuối được cộng 1, mỗi lần hạ một lần | 1 / 5 / 20 / 50 / 100 |
| 2 | Hoàn thành nhiệm vụ | Tân thủ newbie2 (task 2180 − 1) + việc hằng ngày daily2/daily3 (hiệu số các bộ đếm `*_DONE`, cộng dồn ở 2545) | 5 / 20 / 50 / 100 / 200 |
| 3 | Cấp đệ tử cao nhất | task 2505 + 1 (petexp, tối đa 10) | 3 / 5 / 7 / 9 / 10 |
| 4 | Vào Vạn Tiên trận | task 2003 (khoá phiên do `PTVT_Join` ghi) đổi giá trị | 1 / 5 / 20 / 50 / 100 |
| 5 | Vào chiến trường Thương Chu | task 2340 (khoá trận do `PTVC_Enter` ghi) đổi giá trị | 1 / 5 / 20 / 50 / 100 |
| 6 | Tổng quái đã hạ | Wrapper `OnDeath` nối cuối `npc_quests\normal.lua` (399 mẫu quái thường, người được tính kinh nghiệm) | 500 / 5.000 / 20.000 / 100.000 / 500.000 |

- **Phần thưởng mỗi mốc** (tự nhận khi đạt, cần 1 ô trống, túi đầy thì chờ):

| Mốc | Thưởng |
|---|---|
| 1 | 20.000 lượng + 10 Đại Hồng đơn |
| 2 | 50.000 lượng + 20 Đại Hoàn đơn |
| 3 | 100.000 lượng + 3 Hồng Thủy Tinh |
| 4 | 200.000 lượng + 2 Không Thư (Hoàng) |
| 5 | 500.000 lượng + 2 Hồng Bảo Thạch |

- **Không đếm:**
  - Chuỗi nhiệm vụ chính VNG chạy từ script.pak (chỉ hook được nếu sửa PAK).
  - 157 mẫu quái không có death script (rương, totem, mẫu biến hình), 12 boss thế giới (đã đếm ở hạng mục 1), quái tính năng dùng death script riêng.
  - Việc "Cướp tiêu" Lục Lâm (daily3 tăng bộ đếm lúc *nhận* việc).
- **Xem:**
  - Trong game: **Lễ Quan → "Bảng thành tích"** (6 dòng: giá trị hiện tại + mốc kế).
  - Web admin: tab "Quà & thành tích", bảng theo nhân vật (đọc `admin_bridge\thanhtich.txt`, giữ dòng của nhân vật đã thoát).

### 2.5 D5 — Nhị Lang Thần ở Diêu Trì (1052)

- **Toạ độ VNG:** `Server\maps\瑶池_S\v_100\101_region_s.dat`, template 223 (Kind 3), ô 1630/3226. Ô này đi được trên cả lưới client và server. Tây Vương Mẫu ở ô 1773/3010.
- **Script mới** `npc_fix\1052_nhi_lang_than.lua` (ASCII + TCVN3 escape, có `pt_compat`):
  - Menu VNG (`SayTask(11267)`): "Thiên Thụ: đổi 3 Liễu Mộc lấy 1 Hạt thần bí" (cấp ≥ 35 như VNG), "Cây thần bí" (giữ nguyên hai lời thoại VNG chỉ đường tới Tỳ Bà và Bá Giám), "Kết thúc đối thoại".
  - Đếm bằng `HaveEventItemCount(39)`, đúng cách đã sửa cho Võ Cát / Xích Tinh Tử.
  - Trước khi đổi có hỏi lại, kèm lưu ý Liễu Mộc còn dùng cho nhiệm vụ Vi Lao.
  - Thứ tự an toàn: kiểm 1 ô trống → thêm Hạt thần bí (4/48) trước → xóa 3 Liễu Mộc (4/39). Xóa không đủ 3 thì lấy lại Hạt và trả Liễu Mộc.
  - Lời VNG 11268/11269 ghi "2 cây" nhưng code VNG cần 3. Dùng lời mới ghi đúng 3.
- **Gắn vào NPC:** dòng EXTRA trong `gen_npcnames.py` → `ext\npcnames.lua` đổi tên GBK 二郎神 ở map 1052 thành "Nhị Lang Thần" và gắn script.
  - Chỉ khớp tên GBK + map 1052, nên Dương Tiễn (cùng template 223 ở 1020) không bị ảnh hưởng.
  - Không spawn, không theo dõi theo tên, nên không thể sinh NPC trùng.
  - Boss thế giới "Nhị Lang Thần" ở Trận Đường (1065, tpl 96) theo dõi theo idx, không đụng.

### 2.6 D6 — Tên NPC ở Sùng Thành (1002)

- Dump lúc 15:16 và quét lại lúc 20:46: map 1002 có đúng 4 NPC tên GBK.

| NPC | Template | Tên mới (TCVN3) | Cách làm | Script |
|---|---|---|---|---|
| 仓库管理员 Thủ Khố (idx 12) | 151 | Thủ Khố | `FORCE` trong `gen_npcnames.py`. Trước đây bị bỏ qua vì tên GBK xuất hiện trong `ext\tienma.lua`, nhưng chỉ nằm trong **đường dẫn** script (dương tính giả, đã kiểm) | `npc_fix\1002_thu_kho.lua` (như dòng FIX) |
| 杂货商 Tạp Hóa (idx 14) | 158 | Tạp Hóa | dòng `EXTRA`, chỉ đổi tên | giữ script VNG của vùng (`Sale(5)`) |
| 生活技能老师（大营）(idx 18) | 1359 | Sinh Hoạt Sư (Đại Doanh) | dòng `EXTRA` | trước là placeholder `npc_restore\1002_18.lua`; nay gắn `sinhhoat\sh_master.lua`, đúng ý forwarder ptfix của đường dẫn VNG |
| 骆驼 lạc đà (idx 5359; cả 1003/1004/1020/1021) | 366 | Lạc Đà | ext `noidung`: đổi `s[6]` của dòng `PTADM_NPC_SPAWN` **và** tên NPC đang theo dõi **trong cùng một lần**, nên `PTAdm_EnsureNpcs` không thấy "mất NPC" | không có |

- **newbie2:** alias được sinh lại (63 tên). Tên mới của Thủ Khố và Tạp Hóa trùng tên TCVN3 đã có alias; thêm alias "Sinh Hoạt Sư (Đại Doanh)" → GBK 大营 cho nhiệm vụ 898 bước 3, và alias "Nhị Lang Thần". Quân Sư đã được `ReLoadScript` để nạp alias mới.
- **Chọn tên "Sinh Hoạt Sư (Đại Doanh)"** thay vì đúng "Sinh Hoạt Sư": tránh trùng với Sinh Hoạt Sư do sinhhoat đặt ở 1002, tránh `PTAdm_FixNpcScripts` gắn nhầm. Sau này đổi tên giáo viên 1003/1004 theo cùng cách cũng không đụng alias.
- **Không có NPC trùng:** diag 20:49 đếm đúng 1 lạc đà mỗi thành.
- Còn tên GBK ở map khác (ngoài phạm vi):
  - 1003: Xích Tinh Tử, giáo viên 玉虚, Kim Hà Đồng Tử;
  - 1004: Cao Giác, giáo viên 蚩尤墓;
  - 1020: Dương Tiễn, Chuẩn Đề…;
  - 1021: Trụ Vương, Tống Dị Nhân…;
  - Diêu Trì: khoảng 25 NPC.

### 2.7 File đã sửa / thêm

| File | Thay đổi | Sao lưu |
|---|---|---|
| `Server\script\phongthan\content\ev_lib.lua`, `dg_lib.lua`, `ac_lib.lua` | **Mới** (sinh bởi `S\content\gen_e1.py`, `gen_e2.py`, `gen_e4.py`) | — |
| `Server\script\phongthan\ext\eventsched.lua`, `dailygift.lua`, `thanhtich.lua`, `noidung.lua` | **Mới** (ext tick; `noidung` sinh bởi `gen_misc.py`) | — |
| `Server\script\phongthan\npc_fix\1052_nhi_lang_than.lua` | **Mới** (`gen_d5.py`) | — |
| `Server\script\servertimer.lua` | Chỉ dòng `PTADM_EXT_NAMES`: thêm `"eventsched", "dailygift", "thanhtich", "noidung"` (sửa ở mức byte, `patch_servertimer.py`) | `_backup\20261004-content\…\servertimer.lua` |
| `Server\script\phongthan\npc_quests\normal.lua` | Nối cuối wrapper đếm quái (task 2548); phần trên giữ nguyên từng byte (`apply_hooks.py`) | có |
| `Server\script\phongthan\sinhhoat\lq_npc.lua` | Menu Lễ Quan 5 → 7 dòng + 2 hàm gọi lib lúc hội thoại (`apply_hooks.py`) | có |
| `Server\script\phongthan\ext\npcnames.lua`, `lib\pt_npcalias.lua` | Sinh lại: +3 dòng đổi tên 1002, +1 dòng 1052, dòng không có script thì giữ script cũ; alias 63 tên | có |
| `Server\admin_bridge\eventsched_config.lua` | **Mới**, cấu hình lịch mặc định (`gen_cfg.py`) | — |
| `AdminWeb\PhongThan-Admin.ps1` | Chèn khối hàm content, 5 route, 2 action. Thuần ASCII, kiểm cú pháp 0 lỗi | có |
| `AdminWeb\index.html` | 2 nút tab, 2 section, khối JS (`node --check` OK) | có |
| `S\npcnames\gen_npcnames.py`, `vn_names.json` | `FORCE`, `EXTRA`, `NPCNAMES_OUT` (chạy thử), nhãn mới | có (`_backup\…\scratchpad\npcnames\`) |

### 2.8 Kết quả kiểm thử (`S\qtest`, PowerShell 32-bit, LuaLibDll của server)

| Mô phỏng | Kết quả |
|---|---|
| `sim_content.lua -Stack 100` (bản staged / `live`) | **FAILS=0**, 103 kiểm tra: E1 (báo trước, chạy 1 lần, khởi động lại giữa cửa sổ, x2 cho người online, người vào sau và người có thẻ Bạch Hổ, hết hạn, Vạn Tiên / Thương Chu bận / boss, ngày trong tuần, cấu hình hỏng, tắt, chạy ngay), E2 (7 ngày, vòng mới, mất chuỗi, túi đầy giữ quà, giới hạn giữ, quà 7 ngày khi thiếu ô, cấu hình web, tắt), E4 (6 hạng mục, mốc, túi đầy, file trạng thái), Lễ Quan 7 dòng, D5, D6 |
| `sim_content.lua -Stack 100 -Args1 emu` / `emu,live` / `-Stack 0 emu` | **FAILS=0** (EMU: tick 40 khung, hội thoại 47 khung; headroom thấp nhất 33 / 40 khung) |
| `sim_petexp_content.lua` (bản sao `sim_petexp` chạy trên `normal.lua` đã vá), thường + emu + live | **FAILS=0**; giống hệt `out_petexp.txt` cũ, chỉ thêm 2 dòng kiểm (14/14 lần hạ được đếm, lần PlayerIndex 0 không đếm) |
| `sim_d6names.lua` (bản sao `sim_taphoa` với 3 NPC 1002 đã đổi tên + alias mới) | **FAILS=0** (26 tên). Đối chứng với alias cũ: STUCK at 898:4, FAILS=3, tức là alias mới là bắt buộc |
| `test_admin_content.ps1` (hàm web admin thật, `-Live`) | **22/22**; file cấu hình Lua do web ghi nạp được trong Lua 4 (`t_cfgload.lua`) |
| `t_content_hot.lua` (chạy thử khối áp nóng) | FAILS=0 |
| Chạy lại `sim_vantien2`, `sim_vienco`, `sim_newbie2`, `sim_taphoa` sau khi cài | 74/0, 0, 0, 0; **giống hệt từng dòng** với bản chạy trước khi cài |

### 2.9 Áp nóng (admin bridge)

| Giờ | Lệnh | Kết quả `result.log` |
|---|---|---|
| 20:46 | `S\content\hot_content.lua` | `content_hot OK ext+= eventsched dailygift thanhtich noidung reloaded=8 … alias_thukho=y alias_teacher=y noidung=5/5`. `content_names`: 12 = Thủ Khố, 14 = Tạp Hóa, 18 = Sinh Hoạt Sư (Đại Doanh), 1323 = Nhị Lang Thần, 5 lạc đà = Lạc Đà |
| 20:49 | `S\content\diag_content.lua` (chỉ đọc) | `camels 1002=1 1003=1 1004=1 1021=1 1020=1`; DaoSi1: 2541 = 20261004, 2542 = 1, 2543 = 1 (đã nhận quà ngày 1); ext = 20, cuối = noidung. Không có `tick_error.log` |

- Chỉ ghi `pending.lua` khi chưa có `pending.lua` và `running.lua` (ghi file tạm rồi `os.rename`).
- `ReLoadScript`: Nhị Lang Thần, `lq_npc.lua`, `normal.lua`, 4 forwarder Lễ Quan (đường dẫn GBK trong ptfix), Quân Sư newbie2.

## Phần 3: Hành động

### 3.1 Không cần
- [x] Không cần ptfix: không thêm vật phẩm hay sửa dữ liệu PAK; mọi vật phẩm quà đã có sẵn ở Server và Client.
- [x] Không cần khởi động lại GameServer: đã áp nóng. `servertimer.lua` trên đĩa đã có 4 ext cho lần khởi động sau.

### 3.2 Người dùng cần làm
- [ ] **Đóng và mở lại web admin** (`PhongThan-Admin.cmd`), rồi F5 trình duyệt, để thấy tab **"Lịch sự kiện"** và **"Quà & thành tích"**. Agent không tự khởi động lại web admin.
- [ ] Kiểm tra trong game:
  - Lễ Quan (ví dụ Sùng Thành, 199/197) có 2 dòng mới; "Quà đăng nhập 7 ngày" hiện chuỗi 1/7; "Bảng thành tích" hiện 6 hạng mục.
  - Sùng Thành: Thủ Khố, Tạp Hóa, Sinh Hoạt Sư (Đại Doanh), Lạc Đà hiện chữ tiếng Việt. Thủ Khố mở rương bình thường, Tạp Hóa mở cửa hàng, Sinh Hoạt Sư (Đại Doanh) mở menu kỹ năng sống.
  - Diêu Trì [203,201]: Nhị Lang Thần → "Thiên Thụ: đổi 3 Liễu Mộc…" (cấp ≥ 35, cần 3 Liễu Mộc và 1 ô trống).
  - Thứ Bảy 10/10 lúc 19:55 có tin báo trước, 20:00 bắt đầu nhân đôi kinh nghiệm 120 phút.
- [ ] Muốn sửa lỗi `AddItemIDStack(idx)` một đối số (phát hiện ở Phần 1) thì giao riêng cho coordinator: đổi thành `AddItemIDStack(idx, 0)` hoặc `AddNormalItemPile` trong `servertimer.lua` (`PTAdm_GiveTo`) và `nhiemvu_data.lua`.

### 3.3 Rollback
- Chép lại từ `_backup\20261004-content\` (cùng đường dẫn tương đối): `servertimer.lua`, `normal.lua`, `lq_npc.lua`, `npcnames.lua`, `pt_npcalias.lua`, `PhongThan-Admin.ps1`, `index.html`, generator npcnames.
- Xóa `script\phongthan\content\`, 4 file ext mới, `npc_fix\1052_nhi_lang_than.lua`, `admin_bridge\eventsched_*`, `dailygift_config.lua`, `thanhtich.txt`.
- Áp nóng ngược:
  - bỏ 4 tên khỏi `PTADM_EXT_NAMES`;
  - `ReLoadScript` `normal.lua`, `lq_npc.lua` và 4 forwarder Lễ Quan;
  - dofile lại alias và npcnames cũ;
  - đổi tên lạc đà về GBK cùng dòng spawn (như `noidung`, nhưng theo chiều ngược).

## Phần 4: Tài liệu tham khảo

| Loại | Đường dẫn |
|---|---|
| Generator | `S\content\common.py`, `tasks.py`, `gen_e1.py`, `gen_e2.py`, `gen_e4.py`, `gen_misc.py`, `gen_d5.py`, `gen_cfg.py`, `apply_hooks.py`, `patch_servertimer.py`, `web_insert.py`, `mk_hot.py`; khối web `S\content\web\` |
| Nghiên cứu | `S\content\research\` (`task_ids_used.txt`, quét PAK, lưới 1052) |
| Mô phỏng | `S\qtest\sim_content.lua`, `sim_petexp_content.lua`, `sim_d6names.lua`, `test_admin_content.ps1`, `t_content_hot.lua`, `t_cfgload.lua`; kết quả `out_content*.txt`, `out_petexp_content*.txt`, `out_d6names*.txt`; bản chạy trước khi cài `qtest\content_base\` |
| Liên quan | `de-xuat-tinh-nang-phong-than-20261004.md` (E1, E2, E4, D5, D6), `questfix3-phong-than-20261004.md` (Thiên Thụ, mục 2.4), `taphoa-npcnames-phong-than-20261003.md`, `le-quan-sinh-hoat-linh-thu-phong-than-20261003.md`, `van-tien-tran-phong-than-20261002.md`, `vien-co-giang-son-phong-than-20261003.md`, `boss-the-gioi-lenh-bai-phong-than-20260930.md`, `pet-exp-phong-than-20261003.md` |
| Sao lưu | `_backup\20261004-content\` |

**Bước tiếp theo (đề xuất):** sửa `AddItemIDStack` của `PTAdm_GiveTo`; đổi tên các NPC GBK còn lại ở 1003/1004/1020/1021/Diêu Trì bằng cùng cơ chế `EXTRA`; thêm "tổ đội bot vào trận" vào lịch nếu muốn.
