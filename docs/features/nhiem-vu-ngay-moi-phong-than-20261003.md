# Nhiệm vụ ngày đời mới: Thiên Cống, Thiên Cương Hồn, Siêu Độ, Hấp Hồn, Vận chuyển

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent `daily2`
> Trạng thái: **đã đặt file vào runtime, chưa nạp**. Cần coordinator thêm lời gọi tick vào `servertimer.lua` và người dùng tự khởi động lại server.
> Mô phỏng: 54/54 kiểm tra đạt (`qtest\sim_daily2.lua`, chạy cả trên bản stage lẫn bản đã đặt vào runtime). Chưa thử trong game.

## Phần 1: Tổng quan

### Insight chính
- Năm nhiệm vụ ngày đời mới mà bản kiểm toán ghi **Thiếu** (mục 10) giờ đã có NPC, hội thoại, mục tiêu, phần thưởng và giới hạn theo ngày. Ghi chép F11 dùng đúng id và câu chữ taskinfo của VNG:

| Taskinfo | Nhiệm vụ | NPC (vị trí taskinfo) | Cấp | Vòng/ngày |
|---|---|---|---|---|
| 56 | Thiên Cống | Tinh Quan, Triều Ca 224/190 và Tây Kỳ 178/188 | ≥ 40 | 5 |
| 53 | Thiên Cương Hồn | Ân Giao, Phong Thần Đài 184/193 | ≥ 60 | 6 |
| 48 | Siêu Độ Linh Hồn | Ân Hồng, Phong Thần Đài 189/199 | ≥ 20 | 5 |
| 70 | Hấp Hồn Âm Sát | Thuyền Phu, Đông Doanh 222/197 và Phương Trượng 225/199 | ≥ 80 | 4 |
| 61 | Nhiệm vụ vận chuyển | Tạp Thương, đứng cạnh Tạp hóa của 5 thành | ≥ 10 | 7 |

- **Chơi một mình được:**
  - Quái nhiệm vụ do chính nhiệm vụ gọi ra, ở cấp của bản đồ.
  - NPC đưa người chơi tới tận nơi.
  - Đồng đội giết hộ vẫn được tính cho chủ nhiệm vụ.
  - Thiên Cống có thể nộp bạc thay vật phẩm hoặc đổi yêu cầu.
- **Không sửa** `npcdeath\normal.lua` và **không sửa** `servertimer.lua`. Quái được đếm qua script gắn riêng cho từng con: `SetNpcScript` + `LastDamage`.
- **Vận chuyển không trùng Vận Lương.**
  - Vận Lương (taskinfo 64/300) thuộc agent `vantieu`, và chưa có tài liệu `van-luong-van-tieu-phong-than-20261003.md`.
  - Taskinfo 61 là chở đặc sản giữa các Tạp hóa trong thành, nên vẫn được làm ở đây.

### Nhận định quan trọng
- Script NPC gốc của VNG cho Tinh Quan, Thuyền phu (Đông Doanh) và Ân Giao không còn; bản Ân Giao chỉ là stub 148 byte. Toàn bộ logic vì vậy được **viết mới**, bám theo:
  - chữ taskinfo;
  - script vật phẩm còn sót: `招魂幡.lua` (Chiêu Hồn Phướn, danh sách 50 yêu ma), `吸魂符.lua` (Hấp Hồn Phù, 6 yêu quái đảo), `天罡星\*.lua`;
  - template NPC VNG: 招魂阵 551, 强招魂阵 672, 天罡星 549, 天罡星的影子 571, các yêu quái đảo 52 và 652–656.
- Có 3 chỗ lệch so với bản gốc, ghi rõ ở Phần 2.4.

## Phần 2: Chi tiết

### 2.1 Cách chơi từng nhiệm vụ

**Thiên Cống (56): Tinh Quan**
- Nhận nhiệm vụ: Tinh Quan yêu cầu ngẫu nhiên một trong các vật phẩm dưới đây. Đây đúng là các bước 24–28 và 30 của taskinfo.

| Yêu cầu | Vật phẩm | Nộp bạc thay |
|---|---|---|
| Đại Địa nhãn | (3,116) ×1 | 30.000 lượng |
| Hoàn Quan nhãn | (3,117) ×1 | 30.000 lượng |
| Liệt Diệm nhãn | (3,118) ×1 | 30.000 lượng |
| Phong Bạo nhãn | (3,119) ×1 | 30.000 lượng |
| Sơn thạch | (3,82) ×3 | 20.000 lượng |
| Đồng thau | (3,3) ×50 | 20.000 lượng |

- Các lựa chọn khi đang có yêu cầu:
  - Giao vật phẩm: lấy và trả thưởng trong một giao dịch `QuestExchange`, nên túi đầy thì không mất gì.
  - Nộp bạc thay.
  - Đổi yêu cầu: 10.000 lượng.
  - Hủy.
- Thưởng: cấp × 3.000 kinh nghiệm. Vòng thứ 5 trong ngày tặng 1 **Hồng thủy tinh** (3,28); các vòng khác có 10% cơ hội. Nộp bạc thì không có quà may mắn.

**Siêu Độ Linh Hồn (48): Ân Hồng**
- Ân Hồng chọn một bản đồ hợp cấp: loại B không cao hơn cấp người chơi + 3, loại A không thấp hơn cấp − 15. Có 41 điểm, sinh từ dữ liệu quái `spawn_<map>.lua`.
- Mỗi lần có 2 loại yêu ma, mỗi loại cần **3 linh hồn**.
- Chọn "Đưa ta tới Chiêu Hồn Trận" thì người chơi được dịch chuyển tới nơi. Tại đó hiện **Chiêu Hồn Trận** (template 551, trang trí) cùng 3 + 3 con "Oán Hồn <tên>", dùng đúng template quái của bản đồ.
- Thưởng do người chơi chọn: cấp × 2.500 kinh nghiệm **hoặc** cấp × 150 lượng. Đây là "Cấp*kinh nghiệm hoặc Cấp*Tiền" của taskinfo.

**Thiên Cương Hồn (53): Ân Giao**
- Ân Giao chọn ngẫu nhiên 1 trong 36 Thiên Cương Tinh và một tầng Bích Du Cung (1042–1046) hoặc Khổn Tiên Cung (1047–1051). Tầng được chọn có quái không cao hơn cấp người chơi và không thấp hơn cấp − 12.
- Tới nơi sẽ hiện **5 Ảnh Tử** (template 571). Diệt đủ 5 con thì **<tên> Tinh** (template 549, cấp bản đồ + 2) hiện ra.
- Hàng phục Thiên Cương Tinh thì nhận chân hồn (F11 bước 8). Về giao cho Ân Giao.
- Thưởng: cấp × 4.000 kinh nghiệm. Có 25% cơ hội nhận thêm 1 **Lam thủy tinh** (3,80).

**Hấp Hồn Âm Sát (70): Thuyền Phu**
- Mục tiêu là 1 trong 6 yêu quái đảo theo `吸魂符.lua`:

| Yêu quái | Template |
|---|---|
| Ải Nhân | 52 |
| Quang Quỷ | 652 |
| Lão Đồng | 653 |
| Sơn Tiêu | 654 |
| Vô Danh Thú | 655 |
| Thạch Di | 656 |

- Cần **6 hồn phách**.
- Chọn "Lập Hấp Hồn Trận": hiện **Hấp Hồn Trận** (template 672) cùng 6 con "Âm Hồn <tên>", cấp 88 ở Đông Doanh, cấp 90 ở Phương Trượng.
- Thưởng: cấp × 5.000 kinh nghiệm, kèm 1 **Chấn Thiên Tiễn** (3,177) **hoặc** 1 **Tam Tiêm Xoa** (3,178). Hai vật phẩm này dùng để tích danh vọng ở Diêu Trì.
- Thuyền Phu còn chở người qua lại giữa hai đảo, miễn phí.

**Nhiệm vụ vận chuyển (61): Tạp Thương**
- Tạp Thương ở thành A giao 3–5 đơn vị đặc sản của thành mình và giữ tiền cọc 1.000 lượng mỗi đơn vị. Đặc sản theo thành:

| Thành | Đặc sản |
|---|---|
| Sùng Thành | Tơ lụa |
| Ngọc Hư | Linh chi |
| Xi Vưu | Lưu huỳnh |
| Tây Kỳ | Bì cách |
| Triều Ca | Thủy tinh |

- Mang hàng tới Tạp Thương của thành B (ngẫu nhiên, khác A).
- Thưởng: hoàn tiền cọc, cộng cấp × 60 lượng và cấp × 1.500 kinh nghiệm. Chuyến thứ 7 tặng 1 **Mảnh Lam thủy tinh** (3,78); các chuyến khác có 15% cơ hội.
- Hủy thì mất tiền cọc, hàng vẫn giữ.

### 2.2 Kỹ thuật

| Thành phần | File (runtime `Server\script\phongthan\`) | Vai trò |
|---|---|---|
| Lõi chung | `daily2\d2_core.lua` | Biến nhiệm vụ, reset theo ngày, gọi quái theo đợt (pack), dữ liệu nhiệm vụ. Không có TaskNote, vì tick cũng Include file này |
| Dữ liệu sinh tự động | `daily2\d2_data.lua` | 41 điểm Siêu Độ, cấp/tọa độ 10 tầng Bích Du/Khổn Tiên, tên yêu ma. Sinh bởi `scratchpad\daily2\gen_spots.py` |
| Thư viện hội thoại | `daily2\d2_lib.lua` | Include `lib\vng_tasknote.lua` (F11 theo taskinfo), tên bản đồ, `QuestExchange` |
| NPC | `daily2\d2_tinhquan.lua`, `d2_anhong.lua`, `d2_angiao.lua`, `d2_thuyenphu.lua`, `d2_tapthuong.lua` | Hội thoại 5 nhiệm vụ |
| Quái nhiệm vụ | `daily2\d2_mob.lua` | `LastDamage` cộng cho **chủ** đợt quái (kiểm tra khóa của đợt). `DeathSelf` xóa quái (DelNpc hoãn, giống `extra_questfix.py`). `OnTimer` (600 giây) gia hạn khi chủ còn ở bản đồ, ngược lại thì xóa |
| Tick | `ext\daily2.lua` → `PTEXT_daily2_Tick()` | ReLoadScript 6 script ở tick đầu. Giữ 11 NPC (lưu index, kiểm tra tên + template, mất thì đặt lại). Người chơi tự đi tới bản đồ của vòng đang làm mà không còn quái thì được gọi đợt mới quanh mình |
| ptfix | `scratchpad\ptfix\extra_daily2.py` | `\script\封神台\殷郊.lua` (stub VNG, e7649562) thành 1 dòng Include sang `d2_angiao.lua` |

- **Tham số NPC của quái:** 5 = dấu 20261003, 6 = khóa đợt, 7 = PlayerIndex của chủ, 8 = mã nhiệm vụ × 1000 + loại (1, 2 = được đếm; 9 = trận trang trí).
- **Mỗi người chơi chỉ có một đợt quái tại một thời điểm.** Đợt mới làm các con cũ "lạc khóa", và timer của chúng sẽ tự xóa.
- **NPC đặt từ tick:**

| NPC | Bản đồ | Tọa độ | Template |
|---|---|---|---|
| Tinh Quan | 1021 | 1797/3046 | 202 |
| Tinh Quan | 1020 | 1424/3000 | 202 |
| Ân Hồng | 1001 | 1516/3192 | 165 |
| Ân Giao | 1001 | 1472/3088 | 164 |
| Thuyền Phu | 1055 | 1780/3166 | 160 |
| Thuyền Phu | 1056 | 1807/3188 | 160 |
| Tạp Thương | 1002 | 1745/3154 | 158 |
| Tạp Thương | 1003 | 1608/3209 | 158 |
| Tạp Thương | 1004 | 1560/3332 | 158 |
| Tạp Thương | 1020 | 1567/3025 | 158 |
| Tạp Thương | 1021 | 1776/3169 | 158 |

  Tọa độ lấy theo mappos taskinfo; Tạp Thương lệch 3 ô so với Tạp hóa. AddNpc dùng bBarrier 0.

### 2.3 Biến nhiệm vụ (dải 2140–2179 của daily2)

| Biến | Ý nghĩa |
|---|---|
| 2140 | Ngày reset gần nhất (yyyymmdd) |
| 2141 / 2142 / 2175 | Thiên Cống: số vòng hôm nay / yêu cầu đang làm / số lần đổi yêu cầu |
| 2143 / 2144 / 2145 / 2146 | Thiên Cương Hồn: số vòng / trạng thái / sao × 10000 + bản đồ / số Ảnh Tử đã diệt |
| 2147 / 2148 / 2149 / 2150 | Siêu Độ: số vòng / trạng thái / điểm / số đếm A × 100 + B |
| 2151 / 2152 / 2153 / 2154 | Hấp Hồn: số vòng / trạng thái / mục tiêu × 10 + đảo / số hồn |
| 2155 / 2169 / 2170 | Vận chuyển: số vòng / đích × 100000 + hàng × 1000 + số lượng / thành xuất phát |
| 2171–2174 | Đợt quái: khóa / mã nhiệm vụ / thời điểm gọi / số quái còn sống |

- **Đã bỏ qua** vì script VNG đang dùng:
  - 2156–2160: Thẻ Chí Hữu;
  - 2162: sự kiện Giáp Cốt Văn;
  - 2166: thẻ 11.11;
  - 2167: Đại lễ bao, Phúc Vận Bảo Rương;
  - 2168: thư mời liên server.
- 2140–2155 cũng nằm trong `G_TaskValueRange` của sự kiện Giáp Cốt Văn năm 2021. Sự kiện này không hoạt động, nhưng **không nên bật lại** sự kiện đó.

### 2.4 Chỗ lệch so với VNG (có chủ đích)
1. **Thiên Cống** không dùng các bước pháp bảo 0–5 (Âm Dương Kính…). Pháp bảo là trang bị, không đếm hoặc thu hồi an toàn bằng `QuestExchange` được. Chỉ dùng các bước nguyên liệu 24–28 và 30.
2. **Thiên Cương Hồn**: VNG thưởng may mắn "trang bị lục cấp 80". Bản này thay bằng Lam thủy tinh, vì chưa có hàm tạo trang bị ngẫu nhiên an toàn. Bước "giết quái thường để dụ Ảnh Tử" được rút gọn: Ảnh Tử hiện ngay khi tới nơi.
3. **Siêu Độ / Hấp Hồn**: không cần vật phẩm Chiêu Hồn Phướn hay Hấp Hồn Phù, vì NPC lập trận thay. Quái thường đứng cạnh trận **không** được tính, chỉ quái "Oán Hồn" / "Âm Hồn" của trận mới tính. **Mã Đế (81)** chưa làm; nó dùng chung câu chữ với Siêu Độ và có thể thêm sau như vòng mở rộng.

### 2.5 Mô phỏng (`scratchpad\qtest\sim_daily2.lua` → `out_daily2.txt`, `out_daily2_runtime.txt`)
- **Tick:** đặt đủ 11 NPC. Tick lần 2 không đặt thêm. NPC bị mất được đặt lại.
- **Thiên Cống:**
  - Dưới cấp bị từ chối. Giao thiếu vật phẩm bị từ chối.
  - Giao 50 Đồng thau thì nhận 180.000 kinh nghiệm (cấp 60).
  - Đổi yêu cầu và hủy chạy đúng. Nộp bạc chạy đúng.
  - Vòng 5 có Hồng thủy tinh. Vòng 6 bị chặn. Sang ngày mới thì reset và nhận lại được.
- **Siêu Độ:**
  - Nhận nhiệm vụ, dịch chuyển, trận + 6 Oán Hồn hiện ra.
  - Đồng đội giết vẫn được tính cho chủ.
  - Chủ rời bản đồ thì timer xóa đợt quái; quay lại thì tick gọi lại đúng số còn thiếu.
  - Thưởng bạc 6.000 (cấp 40). Đủ 5 vòng thì bị chặn; sang ngày mới nhận lại được. Hủy thì xóa khóa đợt.
- **Thiên Cương Hồn:**
  - Dưới cấp 60 bị từ chối.
  - 5 Ảnh Tử, sau đó Thiên Mãnh Tinh hiện, hàng phục, giao Hồn: 280.000 kinh nghiệm + Lam thủy tinh.
  - Đủ 6 vòng thì bị chặn; sang ngày mới nhận lại được. Người chơi tự đi tới bản đồ thì tick gọi 5 Ảnh Tử.
- **Hấp Hồn:**
  - Dưới cấp chỉ còn dòng chở đò. Đò sang Phương Trượng chạy đúng.
  - Trận + 6 Âm Hồn Sơn Tiêu.
  - Túi đầy thì không mất gì; khi có chỗ thì nhận Tam Tiêm Xoa.
  - Đủ 4 vòng thì bị chặn; sang ngày mới nhận lại được.
- **Vận chuyển:**
  - Triều Ca → Sùng Thành, 4 Thủy tinh, cọc 4.000.
  - Giao hàng: hoàn cọc + 1.800 lượng. Chuyến 7 có Mảnh Lam thủy tinh.
  - Đủ 7 chuyến thì bị chặn; sang ngày mới nhận lại được. Hủy chạy đúng.
- **F11** hiện đúng chữ taskinfo, ví dụ: "Thiên Cống: Giúp Tinh Quan tìm 50 Đồng thau", "Hấp Hồn Âm Sát: Lần này phải hút hồn của Sơn Tiêu".
- **Mô phỏng hồi quy** `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `t_st`: chạy bình thường.
- **ptfix thử nghiệm:** `scratchpad\daily2\ptfix_test.pak` dựng đạt, 464 mục. Log: `daily2: yin_jiao stub -> d2_angiao forwarder e7649562 (148 -> 245 bytes)`.

## Phần 3: Hành động

### Việc của coordinator
- [ ] Gọi `PTEXT_daily2_Tick()` mỗi phút từ `servertimer.lua`, trong lời gọi có bảo vệ. File: `\script\phongthan\ext\daily2.lua`.
- [ ] Dán dòng CHANGELOG và thêm dòng README (xem báo cáo của agent).
- [ ] Khi dựng ptfix thật: plug-in `extra_daily2.py` đã nằm trong `scratchpad\ptfix`, và không phụ thuộc thứ tự chạy với các plug-in khác.

### Checklist thử trong game (người dùng, sau khi tự khởi động lại server)
- [ ] Tìm thấy **Tinh Quan** ở Triều Ca (224/190) và Tây Kỳ (178/188); **Ân Hồng** và **Ân Giao** ở Phong Thần Đài; **Tạp Thương** cạnh Tạp hóa ở 5 thành; **Thuyền Phu** ở Đông Doanh và Phương Trượng.
- [ ] **Thiên Cống** (cấp ≥40):
  - [ ] Nhận nhiệm vụ, xem F11.
  - [ ] Giao vật phẩm hoặc nộp bạc.
  - [ ] Làm đủ 5 vòng, kiểm tra bị chặn ở vòng 6.
- [ ] **Siêu Độ** (cấp ≥20):
  - [ ] Chọn "Đưa ta tới Chiêu Hồn Trận". Kiểm tra Chiêu Hồn Trận và 6 Oán Hồn có hiện, tên hiển thị đúng.
  - [ ] Giết đủ, xem F11 cập nhật. Về Ân Hồng chọn thưởng.
- [ ] **Thiên Cương Hồn** (cấp ≥60):
  - [ ] Tới tầng Bích Du/Khổn Tiên. Diệt 5 Ảnh Tử, Thiên Cương Tinh phải hiện ra.
  - [ ] Hàng phục rồi về Ân Giao. **Báo lại nếu sao không hiện**, vì AddNpc gọi bên trong `LastDamage`.
- [ ] **Hấp Hồn** (cấp ≥80): lập trận, diệt 6 Âm Hồn, nhận Chấn Thiên Tiễn hoặc Tam Tiêm Xoa.
- [ ] **Vận chuyển** (cấp ≥10): nhận hàng (mất cọc), mang sang thành khác, giao hàng, kiểm tra được hoàn cọc.
- [ ] Đổi giờ máy hoặc chờ qua 0h: số vòng phải reset.
- [ ] Bỏ đi chỗ khác hơn 10 phút: quái nhiệm vụ cũ phải biến mất (kiểm tra `DelNpc` trong `OnTimer`).
- [ ] Nếu quái nhiệm vụ quá mạnh hoặc quá yếu khi solo, báo lại để chỉnh cấp. Cấp đang dùng: cấp bản đồ; Thiên Cương Tinh +2.

### Rủi ro cần để ý (chưa kiểm được ngoài game)

| Rủi ro | Dấu hiệu | Cách xử lý |
|---|---|---|
| `DelNpc` trong `OnTimer` | Server lỗi khi quái hết hạn | Đổi sang `SetNpcTimeout` hoặc tick dọn |
| Template trang trí 551/672 (kind 2) | Trận không hiện | Bỏ dòng trận (tag 9), không ảnh hưởng đếm |
| Tên TCVN3 qua `SetNpcName` | Tên lỗi font | Cùng cách với Thủ Khố, Thầy Bói của questfix; đã chạy |

## Phần 4: Tài liệu tham khảo
- **Nguồn VNG:**
  - `taskinfo.ini` (serverlist ba82ae3c), Task_48/53/56/61/70/71/81;
  - `\script\item\招魂幡.lua`, `吸魂符.lua`, `吸魂幡.lua` (file rời);
  - `\script\item\天罡星\*.lua`, `\script\封神台\殷郊.lua`;
  - `settings\phongthan\Npcs.txt`;
  - `settings\item\001\material.txt` (Hồng thủy tinh 3/28, Mảnh Lam 3/78, Lam thủy tinh 3/80, nhãn 3/116–119, Chấn Thiên Tiễn 3/177, Tam Tiêm Xoa 3/178).
- **Mã engine:** `KNpc.cpp` (LastDamage chạy với người giết, OnTimer), `ScriptFuns.cpp` (SetNpcParam/GetNpcParam 16 ô, SetNpcTimer, GetNpcPos theo ô), `PhongThanQuestExchange.inl`.
- **Nguồn ở scratchpad `daily2\`:**
  - `src\*.lua` (UTF-8);
  - `mk.py` (TCVN3 → runtime, `--stage` cho mô phỏng);
  - `gen_spots.py`, `walk.py` (kiểm tra ô đi được), `fi.py` / `rows.py` (tra vật phẩm), `tisel.py` (trích taskinfo).
- **Liên quan:**
  - `kiem-toan-nhiem-vu-phong-than-20261002.md` (mục 10);
  - `tu-linh-thu-thach-huyen-vu-phong-than-20261002.md` (mẫu tick + mô phỏng);
  - `quy-tinh-hoi-thoai-npc-phong-than-20261003.md` (Quy Tinh dùng biến 53 và 250–285, không trùng).
- **Việc tiếp theo có thể làm:** Mã Đế (81), Phúc Kim (71, Nhà chiêm tinh, Bá Lạc Nhãn 3/29–31), các bước pháp bảo của Thiên Cống khi có API thu trang bị.
