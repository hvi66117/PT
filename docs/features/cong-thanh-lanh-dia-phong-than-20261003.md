# Công thành / Lãnh địa: chế độ "lãnh địa cá nhân" cho người chơi solo

> Ngày: 2026-10-03 · Agent `congthanh`, phần tiếp theo agent `congthanh2` (mục 2.10–2.15)
> Phạm vi: nhiệm vụ lãnh địa (30, 31, 34, 69, 78, 79), lính đánh thuê và sát thủ (850–874), tân thủ đời mới 894 (Khảo nghiệm điện Phong Thần) và 908 (Phương pháp mới).
> Nguồn gốc: kiểm toán nhiệm vụ mục 14 (`S\questaudit\quest_audit.md`) và `tan-thu-moi-phong-than-20261003.md` (894/908 để lại).
> Trạng thái:
> - Tên ext `congthanh` đã có trong `PTADM_EXT_NAMES`. ptfix đang chạy đã chứa bản vá `extra_congthanh.py` (4 script công trình trong `ptfix.pak` có dòng `ptfix congthanh`).
> - congthanh2 (chiều 03/10): đã deploy Lua mới (bóng Cửu Linh cho 908, 23 Đại phu dã ngoại cho 31, thủ thành theo lịch, nâng cấp công trình). **Có hiệu lực sau khi người dùng khởi động lại server**, vì servertimer chỉ `dofile` file ext một lần. Không cần build lại ptfix (plug-in không đổi).
> - Bản vá C++ là **tùy chọn**, chưa áp dụng. congthanh2 không cần C++.

## Phần 1: Tổng quan

### Insight chính

1. **Hệ thống bang hội của server này chết từ gốc, không phải thiếu script.**
   - GameServer không bao giờ nối tới máy chủ bang hội: `m_pTongClient = NULL` ở `KSOServer.cpp:438` và không được gán lại ở đâu.
   - Relay đang chạy (`PhongThanRelay.exe`) không có mã bang hội.
   - Hệ quả: lệnh tạo bang bị bỏ qua và không ai có bang. Mọi hàm Lua dạng "bang/thành" trả 0.
   - Không có map công thành nào: `MapList.ini` / `WorldSet.ini` không có 夏日/秋风/红叶/黄沙/黑暗之城.
   - Dù relay có chạy, `citywar.ini` vẫn đòi 60 thành viên và bang cấp 18. Đây là thiết kế cho nhóm, không thể chơi solo.
2. **Phần lõi nhiệm vụ lãnh địa VNG vẫn còn đủ trong PAK, chỉ thiếu "chủ thành".**
   - 4 script công trình chứa toàn bộ nhiệm vụ: `即时国战\神殿` (Điện Phong Thần: 894, 34), `兵营` (Trại lính: 850–874), `炼丹炉` (Phòng luyện thuốc: 908, 30), `靶场` (Thao trường: 31).
   - Chúng chỉ hỏi vài câu: "người này có sở hữu thành không" (`IsOwnerCity`), "công trình đã xây chưa" (`GetBuildingState`), "biến thành thị" (`GetCityTask`/`SetCityTask`), "cống hiến" (`GetTongContri`), "cấp thành" (`GetCityInfo`).
   - Phần đếm quái cho 894 và lính đánh thuê **đã chạy sẵn** trong `npc_quests\normal.lua`.
3. **Giải pháp: "lãnh địa cá nhân", Lua-only.**
   - Người chơi tự lập lãnh địa ở *Lãnh địa quan* (Tây Kỳ). Trạng thái lãnh địa nằm trong task riêng của nhân vật (2430–2479).
   - Một lớp API Lua (`ct_api.lua`) được nối vào cuối 4 script VNG qua ptfix. Lớp này trả lời các câu hỏi trên từ task của người chơi.
   - Kết quả: **script VNG chạy nguyên bản**: cùng bước, cùng phần thưởng, cùng chữ taskinfo trong F11.
4. **69, 78, 79 không có mã VNG** (script công trình là stub hoặc thiếu hẳn). Ba nhiệm vụ này được viết mới theo chữ taskinfo, bản solo.
5. **C++ không bắt buộc.** Bản vá đã soạn chỉ thêm native "chế độ bang hội" cho 8 hàm còn thiếu. Nó trơ (trả 0) khi không có bang, và Lua tự nhận biết có hay chưa có bản vá.

6. **(congthanh2) Bốn việc còn lại đã xong, Lua-only:**
   - 908 bước 1 làm một mình được: **bóng Cửu Linh** (cùng hình Cửu Anh 九婴, sức mạnh theo cấp người chơi) gọi ở Lãnh địa quan hoặc Phòng luyện thuốc. Boss thế giới Cửu Linh vẫn được tính như cũ, không động vào hệ thống boss thế giới.
   - Nhiệm vụ 31 của VNG không dùng một Đại phu, mà dùng **46 Đại phu dã ngoại** (mỗi map dã ngoại/mê cung một người, task 304 = 5–19 và 21–51, chọn ngẫu nhiên theo cấp). 23 người đã đứng sẵn (dữ liệu vùng map 1014/1015/1016, `sudo_dongdi` 1022–1041). Ext đặt thêm 23 người còn thiếu, không trùng.
   - **Thủ thành theo lịch** (12:30 và 20:30 hằng ngày) và nút **Khiêu chiến ngay** để thủ thành một mình. Quân công thành là quái phe địch; hộ vệ là bot giả người chơi phe 0.
   - **Nâng cấp từng công trình** cấp 1–5, hiệu quả nối vào cả 4 script VNG qua `ct_api` và vào 3 công trình viết mới.

### Nhận định quan trọng

- 894/908 nay làm được: 894 đi hết 5 bước trong mô phỏng; 908 bước 1 hạ boss thế giới **Cửu Linh** (VNG gọi 九婴 là "Cửu Linh") hoặc bóng Cửu Linh riêng (mục 2.10).
- Nhiệm vụ lính đánh thuê đi đủ 3 loại × 4 cấp (Truy sát, Thu thập, Đưa tin). Riêng nhiệm vụ PK của VNG cũng chỉ là khung rỗng.
- Tỷ lệ solo đã chỉnh (xem 2.4). Mốc gốc của VNG (1.000–20.000 lượt lính đánh thuê cho cả bang) đổi thành 20–150 lượt cho một người.

## Phần 2: Chi tiết

### 2.1 Hệ thống VNG cần gì

| Công trình (NPC) | Script VNG (PAK) | Nhiệm vụ | Hàm "lãnh địa" script gọi |
|---|---|---|---|
| Điện Phong Thần | `\script\即时国战\神殿.lua` d2683bb5 | 894 Khảo nghiệm (5 bước, cấp 30), 34 Hoa thần bí (ngày, 5 + 15 lượt) | IsOwnerCity, GetBuildingState, BuildingOperator, IsHaveTongRight, AddCityIndexRes(1), AddTongContri, Msg2TongMember, DestroyBuilding |
| Trại lính đánh thuê | `\script\即时国战\兵营.lua` ad7f1d51 | 852–874 Sát thủ / Thu thập / Đưa tin C.1–4 | + GetCityInfo (cấp thành), GetCityTask/SetCityTask (biến 21–38) |
| Phòng luyện thuốc | `\script\即时国战\炼丹炉.lua` 17c5b8e1 | 908 Phương pháp mới (cấp 40, cống hiến ≥ 100), 30 Luyện tiên đơn | + GetTongContri, AddCityIndexRes(2) |
| Thao trường | `\script\即时国战\靶场.lua` 8448eaa4 | 31 Thao trường thí luyện (cần Đại phu dã ngoại báo gián điệp) | + AddTongAttr(0,1) |
| Sân luyện thú | `怪物牧场.lua` (stub) | 69 Trừ ma | không có mã nhiệm vụ |
| Phòng chiến xa | `兵工厂.lua` (stub) | 78 Thu thập Xích Đồng Thảo | không có mã nhiệm vụ |
| Hý viện | `戏院.lua` **thiếu** | 79 Điệp báo (thâm nhập thành bang khác) | — |
| Mở khóa công trình | `OnBuild` (script 4fb5f518) | cần số lượt lính đánh thuê theo loại (biến thành thị 21–36) | GetCityTask |
| Hoa thần Cửu Di (15 map) | `\script\神秘花卉任务\任务-<map>.lua` | 34: tìm hoa | VNG di chuyển hoa bằng `DelNpc(DialogNpcIdx)` + `AddNpc` 5 tham số, nên lỗi |

**Lịch công thành VNG:**
- `systemtimetask` (engine không đọc).
- Sự kiện "quái công thành cấp 4": script thiếu.
- `IsInMonsterAttackDay` (C++ Wave 8) trả thứ Tư / thứ Bảy.

Không có phần nào chạy được khi không có bang.

### 2.2 Hàm Lua: đã có và còn thiếu

| Hàm | Trạng thái trước | Sau thay đổi |
|---|---|---|
| IsOwnerCity, GetCityInfo, Msg2TongMember, AddTongAttr | C++ (Wave 8, Carriage), trả 0 khi không có bang | Lua ghi đè trong 4 script công trình; native vẫn là đường dự phòng |
| GetCityTask, SetCityTask, AddCityIndexRes, GetOwnCityLevel, GetTongContri | **Thiếu** (script dừng lỗi) | Lua; native trong bản vá C++ (tùy chọn) |
| IsHaveTongRight, AddTongContri, GetBuildingState, BuildingOperator | Stub `pt_compat` (0 / không làm gì) | Lua; IsHaveTongRight / AddTongContri cũng có native trong bản vá |
| DestroyBuilding | Thiếu | Lua (lãnh địa cá nhân không phá công trình) |
| SetByte/GetByte/GetBit/SetBit, HaveNormalItem, DelNormalItem, GetItemLevel2, DelItem2, HaveIBBuff, RemoveIBBuff, FindAValidIBItem, CostIBItem, MsgBox, Say, SayTask | C++ có | — |

**Lỗi engine phát hiện thêm:** `LuaSelectUI` cắt "nhãn/hàm" ở dấu `/` **đầu tiên**.
- Nhãn VNG như "N/v lính đánh thuê" sẽ gọi một hàm tên "v lính đánh thuê…", nên menu chết.
- `ct_api.lua` đổi `/` trong nhãn thành `.` (Say, SayTask, BuildingOperator), chỉ trong 4 script công trình.
- Các script VNG khác có nhãn chứa `/` cũng bị lỗi này. Ngoài phạm vi, đề xuất xử lý chung trong `pt_compat.lua`.

### 2.3 Bang hội có dùng được không?

Không. Chi tiết:
- **Tạo bang:** `KPlayerTong::CheckCreateCondition` cho phép tạo một mình (cấp 60, 2.000 vạn lượng, vật phẩm 195, danh vọng 300, phúc duyên 500). Nhưng gói tin gửi qua `m_pTongClient`, mà biến này luôn NULL, nên bị vứt.
- **Dữ liệu bang:** BerkeleyDB `TongDB` của S3Relay cũ không còn được ghi từ 2026-09-04.
- **Sở hữu thành:** chỉ có qua Lua `LoadTongMap`. `danhsachthanhthi.lua` gắn map 1 cho bang "Tuyệt Kiếm" (một phát hiện phụ: người không cùng bang phải chịu thuế +15% ở cửa hàng).
- **Client:** có giao diện bang (UiTongManager…), không có giao diện thành/công thành.

### 2.4 Thiết kế lãnh địa cá nhân

**Task (đã kiểm tra trống trong script rời và script PAK; engine giữ 4800+):**

| Task | Ý nghĩa |
|---|---|
| 2430 | 1 = đã lập lãnh địa |
| 2431 | Cấp thành thị 1–4 |
| 2432–2435 | Tài nguyên: Hương liệu (từ Hoa thần bí), Gỗ (Luyện tiên đơn), Xích đồng (78), Lương thảo (69) |
| 2436 | Cống hiến cá nhân (`GetTongContri` / `AddTongContri`) |
| 2437 / 2438 | Hưng thịnh (`AddTongAttr` loại 0) / các loại khác |
| 2439 | Ngày thu thuế |
| 2440–2446 | Cấp công trình 1–7 (0 = chưa xây, 1–5; congthanh2) |
| 2447 | Ngày lập lãnh địa |
| 2448 | Quyên góp: ngày × 100 + số điểm đã quyên trong ngày (congthanh2 gộp từ 2448/2449) |
| 2449 | Thủ thành: ngày × 100 + số lần đã nhận thưởng trong ngày (congthanh2) |
| 2450–2467 | Biến thành thị VNG 21–38: 21–36 số lượt lính đánh thuê theo loại, 37 ngày reset, 38 seed ngày |
| 2468–2470 | 69 (vật phẩm/số lượng, ngày, số lượt) |
| 2471–2473 | 78 (đang làm/số bụi, ngày, số lượt) |
| 2474–2476 | 79 (bước, ngày, số lượt) |
| 2477 | Trạm dịch: ngày × 100 + số thư trong ngày (congthanh2 gộp từ 2477/2478) |
| 2478 | Phút gọi bóng Cửu Linh gần nhất (908, congthanh2) |
| 2479 | Thời điểm thao tác bụi cỏ gần nhất (chống spam) |

- Cả dải 2430–2479 đã dùng hết từ bản đầu (2468–2479 cho 69/78/79, trạm dịch, chống spam), nên congthanh2 **không lấy thêm biến**: gộp hai cặp "ngày + số đếm" thành một biến `ngày × 100 + số`, giải phóng 2449 và 2478.
- Giá trị cũ (chỉ là số ngày, nhỏ hơn 1.000.000) được hiểu là "ngày khác", nên bộ đếm trong ngày bắt đầu lại từ 0, không lỗi.
- **GlobalValue 2430–2479** (đã kiểm tra không script rời hay script PAK nào dùng) giữ trạng thái thủ thành, vì ext tick, Lãnh địa quan và `ct_mob.lua` chạy ở ba Lua state khác nhau. Bảng chi tiết ở mục 2.12.

**Lập lãnh địa:** cấp ≥ 20, nộp 100.000 lượng, tặng 20 cống hiến.

**Công trình** (xây ở Lãnh địa quan, trả bằng ngân lượng):

| # | Công trình | Mở ở cấp | Giá (lượng) | Nhiệm vụ |
|---|---|---|---|---|
| 1 | Điện Phong Thần | 1 | 50.000 | 894, 34 |
| 2 | Trại lính đánh thuê | 1 | 50.000 | 850–874 |
| 3 | Sân luyện thú | 1 | 30.000 | 69 |
| 4 | Phòng chiến xa | 1 | 30.000 | 78 |
| 5 | Phòng luyện thuốc | 2 | 100.000 | 908, 30 |
| 6 | Thao trường | 3 | 150.000 | 31 |
| 7 | Hý viện | 4 | 200.000 | 79 |

**Nâng cấp thành thị** (cống hiến và số lượt lính đánh thuê chỉ cần đạt; tài nguyên và ngân lượng bị trừ):

| Lên cấp | Cấp nhân vật | Cống hiến | Lượt lính đánh thuê | Hương liệu | Gỗ | Ngân lượng |
|---|---|---|---|---|---|---|
| 2 | 40 | 50 | 20 | 5 | 0 | 300.000 |
| 3 | 50 | 150 | 60 | 15 | 5 | 600.000 |
| 4 | 60 | 300 | 150 | 30 | 15 | 1.000.000 |

Cấp thành thị quyết định cấp nhiệm vụ sát thủ được mở: Sát thủ C.k cần thành cấp ≥ k (giữ luật VNG trong `show_buttons`), cùng với cấp nhân vật 20 / 40 / 60 / 70.

**Nguồn cống hiến:**
- Mỗi nhiệm vụ lính đánh thuê: +1 (VNG).
- Hoa thần bí: +1 mỗi 5 lượt (VNG).
- Luyện đơn: +1 mỗi 10 lượt (VNG).
- 69 và 79: +1 mỗi lượt.
- Quyên góp: 10.000 lượng = 1 điểm, tối đa 30 điểm/ngày.

**Thuế ngày:** 10.000 × cấp thành thị + 500 × hưng thịnh (tối đa tính 100 điểm hưng thịnh).

**Trạm dịch:** đưa thư "Đưa tin" thay người chơi, 5.000 lượng/thư, tối đa 10 thư/ngày.
- Lý do: các NPC nhận thư VNG (Đại phu, Tạp hóa, Võ sư, Thợ đồng ở 7 thành) phần lớn không đứng trên map.
- Vật phẩm phải mang về vẫn phải tự tìm.

**Giảm theo solo:** bước 5 của 894 cần 40 thay vì 200 mỗi loại nguyên liệu (`PTCT_SHENDIAN_ITEM_DIV = 5`).

### 2.5 Từng nhiệm vụ làm thế nào

| Nhiệm vụ | Đường đi |
|---|---|
| **894** Khảo nghiệm điện Phong Thần | Điện Phong Thần (cấp ≥ 30): hạ Ngưu Sát/Giáp Cốt/Hắc Phong ×50 → Dạ Xoa/Giang Quy ×50 → Thiên Hạo ×50 → Sa Hồn ×50 → nộp 6 nguyên liệu ×40 (Hỏa vũ, Ngọc cốt, Đoản Kiếm, Mảnh Giáp, Mặt Quỷ, Băng cơ). Đếm quái bằng `normal.lua` có sẵn. |
| **34** Hoa thần bí | Sau 894: nộp 50.000 lượng (lượt 6–20 cần thêm Thiên Tiên Thủy). Đi map được chỉ định, tìm **Hoa thần Cửu Di** (15 map, ext đặt), về Điện. Mỗi 5 lượt được +1 Hương liệu và +1 cống hiến. |
| **850–874** Lính đánh thuê | Trại lính: Truy sát (hạ 2 loại quái ×50), Thu thập (2 loại nguyên liệu ×50, hoặc 1 đầu boss ở cấp 3–4), Đưa tin (2 NPC + mang vật phẩm về, có thể nhờ trạm dịch). 5 điểm hành động/ngày, tối đa 2 lần mỗi loại. |
| **908** Phương pháp mới | Thành cấp 2, nhân vật cấp ≥ 40, cống hiến ≥ 100: hạ **Cửu Linh/Cửu Anh** (boss thế giới slot 101, hoặc bóng Cửu Linh riêng, mục 2.10) → nộp Toàn Tâm đinh, Lạc Hồn chung, Hồng Hồ Lô, Ngọc Hư Phù, Lam Bảo Thạch, Hồng Bảo Thạch → quay Càn Khôn Luân lấy Bạch Hổ hoặc Đại Hao Tinh Quân → 25 vạn kinh nghiệm. |
| **30** Luyện tiên đơn | Sau 908: mỗi ngày 10 lượt (lượt 11–30 cần Lò luyện đơn). Mỗi 10 lượt được +1 Gỗ. |
| **31** Thao trường thí luyện | Thành cấp 3: nhận tin gián điệp → **Đại phu dã ngoại** của map được chỉ định báo (task 304 = 100; mục 2.11) → phục mệnh; lượt 10 được +1 Hưng thịnh (×2/×3 theo cấp Thao trường). |
| **69** Trừ ma | Sân luyện thú: mang về 20 chứng vật quái theo cấp; 2 lượt/ngày; thưởng kinh nghiệm, 50.000 lượng, +1 cống hiến, +1 Lương thảo. |
| **78** Xích Đồng Thảo | Phòng chiến xa: hái 5 bụi ở bãi tây nam Tây Kỳ; 20 lượt/ngày; thưởng kinh nghiệm, +1 Xích đồng, 30% được +1 Hưng thịnh. |
| **79** Điệp báo | Hý viện (cấp 4): gặp **Vệ quân** ở Triều Ca → phá hoại Xích Đồng Thảo → phục mệnh; 5 lượt/ngày; thưởng kinh nghiệm, +1 cống hiến, +1 tài nguyên ngẫu nhiên. |

### 2.6 NPC (ext `congthanh`)

| NPC | Map | Ô (x, y) | Template | Script |
|---|---|---|---|---|
| Lãnh địa quan | Tây Kỳ 1020 | 1535, 3026 | 768 | `congthanh\ct_steward.lua` |
| Điện Phong Thần* | 1020 | 1530, 3026 | 1130 | VNG 神殿 |
| Trại lính đánh thuê* | 1020 | 1525, 3026 | 211 | VNG 兵营 |
| Phòng luyện thuốc* | 1020 | 1520, 3026 | 149 | VNG 炼丹炉 |
| Thao trường* | 1020 | 1557, 3026 | 158 | VNG 靶场 |
| Sân luyện thú | 1020 | 1562, 3026 | 151 | `ct_muchang.lua` |
| Phòng chiến xa | 1020 | 1567, 3026 | 157 | `ct_chienxa.lua` |
| Hý viện | 1020 | 1562, 3036 | 2081 | `ct_hyvien.lua` |
| Xích Đồng Thảo ×3 | 1020 | (1520, 3044), (1525, 3048), (1520, 3052) | 151 | `ct_herb.lua` |
| Vệ quân | Triều Ca 1021 | 1622, 2944 | 211 | `ct_vequan.lua` |
| Hoa thần Cửu Di* ×15 | 1001–1065 | ô đầu bảng `pos` của từng script VNG | 255 | VNG `神秘花卉任务\任务-<map>.lua` |
| Đại Phu ×23 (congthanh2) | 1005–1013, 1017–1019, 1042–1051, 1065 | bảng mục 2.11 | 149 | VNG `龙套\野外医生-<map>.lua` |
| Bóng Cửu Linh (theo yêu cầu) | 1020 | 1509, 3047 | 123 | `congthanh\ct_mob.lua` |
| Quân công thành / Tướng công thành (khi thủ thành) | 1020 | 16 ô, mục 2.12 | 116 | `congthanh\ct_mob.lua` |
| Hộ vệ lãnh địa (khi thủ thành) | 1020 | 6 ô, mục 2.12 | 2703–2720 | `congthanh\ct_mob.lua` |

- Hàng NPC ở Tây Kỳ nằm 10 ô phía nam dãy cửa hàng. Đã kiểm ô trống 5×5 trên lưới server (Region_S) và lưới client (Region_C trong maps.pak), và ô nối liền khu cửa hàng.
- Hoa: kiểm ô trống 3×3 cả hai lưới.
- Template đều là kind 3 (đối thoại). Template "building" kind 9 của VNG (372/374/379/381) **không dùng**, vì engine chỉ có kind 0–5.
- (*) Chỉ đặt khi ptfix mới đã deploy. Ext dò file đánh dấu `\script\phongthan\congthanh\ct_pakmark.lua`, file này chỉ có trong ptfix: dò ở tick 1, sau đó cứ 30 phút một lần.

### 2.7 File và cổng an toàn

| File | Vai trò |
|---|---|
| `Server\script\phongthan\congthanh\ct_lib.lua` | Hằng số, task, bảng công trình / cấp, helper |
| `…\ct_api.lua` | Lớp API cho 4 script VNG, sửa nhãn có `/`, giảm số nguyên liệu 894 |
| `…\ct_steward.lua` | Lãnh địa quan |
| `…\ct_muchang.lua`, `ct_chienxa.lua`, `ct_herb.lua`, `ct_hyvien.lua`, `ct_vequan.lua` | 69, 78, 79 |
| `…\ct_boss.lua` (congthanh2) | Bóng Cửu Linh cho 908 bước 1: gọi, tính điểm hạ |
| `…\ct_def.lua` (congthanh2) | Thủ thành: lịch, đợt quân, hộ vệ, kết quả, thưởng/phạt (trạng thái trong GlobalValue 2430–2479) |
| `…\ct_mob.lua` (congthanh2) | Action script của mọi NPC lãnh địa tự sinh: `LastDamage`, `Revive`, `DeathSelf`, `Timeout` |
| `Server\script\phongthan\ext\congthanh.lua` | `PTEXT_congthanh_Tick`: ReLoadScript, đặt và giữ NPC (cả 23 Đại phu dã ngoại), dọn thủ thành của state cũ, nhịp thủ thành |
| `S\ptfix\extra_congthanh.py` | Nối `ct_api` vào 4 script VNG, tắt bước di chuyển hoa ở 15 script hoa, thêm file đánh dấu |
| `S\congthanh\src\*.lua` + `gen.py` | Mã nguồn UTF-8; `gen.py` sinh Lua ASCII (TCVN3 dạng `\ddd`) |
| `S\congthanh\cpp_patch.md`, `apply_patch.py`, `PhongThanLuaCongThanh.h` | Bản vá C++ tùy chọn và trình áp dụng |

**Cổng:**
1. Chưa có tên ext `congthanh` trong `PTADM_EXT_NAMES`: không NPC nào xuất hiện, tính năng tắt hoàn toàn.
2. Có ext nhưng ptfix cũ: chỉ đặt Lãnh địa quan, 69, 78, 79 và Vệ quân. 4 công trình VNG và 15 hoa chờ file đánh dấu.
3. Bản vá C++: `ct_api` bắt native lúc nạp. Có lãnh địa cá nhân thì luôn dùng task; không có thì gọi native nếu có, không thì trả 0.

### 2.8 Kiểm thử mô phỏng

- **Bản build ptfix nháp:** Client `S\congthanh\ptfix_test_client.pak` rồi Server `S\congthanh\ptfix_test.pak`, cả hai thành công. Log Server ghi `congthanh: shendian d2683bb5, bingying ad7f1d51, liandan 17c5b8e1, bachang 8448eaa4, flowers 15/15, pakmark`. Áp plug-in lần 2 không đổi byte nào (idempotent).
- **`qtest\sim_congthanh.lua`:** 143 kiểm tra, **0 lỗi**, trên bản runtime ở cả hai chế độ:
  - `-Stack 100`;
  - `-Stack 0 -Args1 EMU` (mỗi lối vào được đệm xuống đúng khoảng trống stack của engine: 47 khung cho NPC, 40 cho ext). Khoảng trống nhỏ nhất ghi được: 34 khung (lời gọi lồng `liandan_open`), ext 37.
  - Phạm vi: lập lãnh địa → xây → 894 đủ 5 bước (đếm quái thật qua `normal.lua`) → 34 ×5 (dùng script hoa VNG đã vá) → Sát thủ / Thu thập / Đưa tin C.1 (có trạm dịch) → lên cấp 2 → 908 → 30 → cấp 3 → 31 → 69 / 78 / 79 → cấp 4, mở Sát thủ C.4 → quyên góp / thuế / sang ngày. Thêm chế độ bang hội với stub C++ (`qtest\ct_cpp_stubs.lua`), ext tick (idempotent, đặt lại khi mất, cổng đánh dấu), và kiểm tra chỉ ghi task 2430–2479.
- **Hồi quy:** `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `t_st` đều chạy (TOTAL FAILS = 0).

### 2.9 Các giai đoạn

| Giai đoạn | Nội dung | Trạng thái |
|---|---|---|
| 1 | Lãnh địa cá nhân, 7 công trình, 894/908/30/31/34/69/78/79, lính đánh thuê, hoa, trạm dịch, thuế | **Xong** (mô phỏng). Chờ bật ext và deploy ptfix |
| 1b | Bản vá C++ native chế độ bang hội (8 hàm) + sửa tràn `KGameData` (tùy chọn) | Đã soạn và thử applier trên bản sao; chờ coreclient |
| 2 | **Thủ thành theo lịch**: 12:30 và 20:30 hằng ngày + "Khiêu chiến ngay" ở Lãnh địa quan; 3 đợt quân công thành ở hàng công trình Tây Kỳ, hộ vệ là bot giả người chơi; đếm quái bằng NPC-script (`LastDamage` / `Revive`), không sửa `normal.lua` (mục 2.12) | **Xong** (congthanh2, mô phỏng) |
| 2b | Nâng cấp từng công trình cấp 1–5, `GetBuildingState` trả cấp (mục 2.13); 908 bước 1 có bóng Cửu Linh riêng (mục 2.10); 23 Đại phu dã ngoại cho 31 (mục 2.11) | **Xong** (congthanh2, mô phỏng) |
| 3 | Bang hội thật (khi có relay xử lý bang): `LoadTongMap` đặt chủ thành, bản vá C++ đã có sẵn đường | Phụ thuộc relay |

### 2.10 Nhiệm vụ 908 bước 1: bóng Cửu Linh (congthanh2)

**Đường VNG vẫn giữ nguyên.** Script chết của boss thế giới `\script\npcdeath\九婴.lua` (đã bọc trong ptfix v7) đặt 908 = 2 cho người hạ và cả tổ đội cùng map, nếu 908 đang là 1. Không sửa gì ở hệ thống boss thế giới (`wb_data.lua`, `wb_lib.lua`, lớp bọc).

**Đường một mình** (`ct_boss.lua`):

| Mục | Giá trị |
|---|---|
| Gọi ở đâu | Lãnh địa quan → "Khiêu chiến bóng Cửu Linh (một mình)"; hoặc bảng Phòng luyện thuốc (dòng thêm trong `ct_api`). Chỉ hiện khi task 908 = 1 |
| Template | 123 天罡星: cùng thân `ani039` với Cửu Anh 86, death script `normal.lua`. **Không dùng 86**, vì death script 九婴 ghi GlobalValue 101/4161 và `wb_lib` sẽ phát thưởng boss thế giới |
| Vị trí | Tây Kỳ (1509, 3047), bãi trống phía tây hàng công trình; người gọi được đưa tới (1514, 3042) và bật chiến đấu. Đã kiểm ô trống 5×5 trên lưới server + client, liền vùng với Lãnh địa quan |
| Sức mạnh | Cấp = cấp người chơi (tối thiểu 40); máu 900 × cấp (cấp 45: 40.500), sát thương 2–3 × cấp. Boss thế giới có 100.000 máu cố định |
| Giới hạn | 5 phút một lần gọi (task 2478); bóng tự biến mất sau 15 phút nếu chưa bị hạ |
| Tính điểm | `ct_mob.lua`: `LastDamage` (người hạ và tổ đội cùng map, giống VNG); bị bot, hộ vệ hay người khác kết liễu thì `Revive` (sau 36 khung) cộng cho người gọi. Mỗi bóng chỉ tính một lần |

### 2.11 Nhiệm vụ 31: Đại phu dã ngoại (congthanh2)

- Thao trường (`靶场.lua check`) chọn ngẫu nhiên theo cấp một trong 46 giá trị task 304: cấp ≤ 30 nhận 5–19; cấp cao hơn có thêm các map mê cung 21–41; cấp cao nhất thêm 42–51. Mỗi giá trị ứng với **một Đại phu dã ngoại** `\script\龙套\野外医生-<map>.lua`. Script đó đặt 304 = 100 rồi người chơi về Thao trường phục mệnh.
- Bản đồ: N = 5–18 là map 1005–1018; 19 là Trần Đường quan (1065); 21 là Tuyệt Long lĩnh (1019); 22–51 là map 1022–1051.
- Đã đứng sẵn: 1014, 1015, 1016 (dữ liệu vùng map) và 1022–1041 (`ext\sudo_dongdi.lua`, 20 người). **Không đặt trùng.**
- Ext `congthanh` đặt 23 người còn thiếu: template 149, tên "Đại Phu", gắn đúng script VNG (GBK, có trong `ptfix.pak`), `ReLoadScript` có bảo vệ ở tick đầu. Ô đặt cách điểm vào map khoảng 4–5 ô (điểm vào lấy từ các trap `NewWorld`), đi được trên lưới server, cả 8 ô quanh đi được, không nằm trên trap (`S\sudo_dongdi\findpos.py`).

| 304 | Map | Ô (x, y) | 304 | Map | Ô (x, y) |
|---|---|---|---|---|---|
| 5 | 1005 Sùng Thành ngoại | 1804, 2939 | 21 | 1019 Tuyệt Long lĩnh | 1346, 2933 |
| 6 | 1006 Bắc Hải | 1918, 2794 | 42 | 1042 Bích Du cung 1 | 1660, 3142 |
| 7 | 1007 Yến Sơn | 1605, 3200 | 43 | 1043 Bích Du cung 2 | 1273, 3215 |
| 8 | 1008 Côn Lôn sơn lộc | 1680, 3006 | 44 | 1044 Bích Du cung 3 | 1627, 3177 |
| 9 | 1009 Tây Côn Lôn | 1839, 3758 | 45 | 1045 Bích Du cung 4 | 1268, 3271 |
| 10 | 1010 Thủ Dương sơn | 1588, 3191 | 46 | 1046 Bích Du cung 5 | 1497, 2801 |
| 11 | 1011 Du Hồn quan | 1822, 3611 | 47 | 1047 Khổn Tiên cung 1 | 1825, 3131 |
| 12 | 1012 Miêu Cương | 1467, 3033 | 48 | 1048 Khổn Tiên cung 2 | 1686, 2943 |
| 13 | 1013 Cự Lộc | 1580, 3208 | 49 | 1049 Khổn Tiên cung 3 | 1622, 2971 |
| 17 | 1017 Kỳ Sơn | 1923, 3031 | 50 | 1050 Khổn Tiên cung 4 | 1629, 2973 |
| 18 | 1018 Mục Dã | 1792, 2910 | 51 | 1051 Khổn Tiên cung 5 | 1629, 2972 |
| 19 | 1065 Trần Đường quan | 1510, 3293 | | | |

- Cùng các Đại phu này còn trả lời task 314 (chuỗi Hoàng Thiên Hóa) theo script VNG.
- Khổn Tiên cung 1: điểm vào từ Phong Thần đài (1846, 3118) là một túi nhỏ (586 ô), nên Đại phu đặt cạnh điểm vào từ Dao Trì (1825, 3131), vùng lớn 76.941 ô.

### 2.12 Thủ thành theo lịch (congthanh2)

| Mục | Nội dung |
|---|---|
| Lịch | 12:30 và 20:30 hằng ngày: tin toàn server, **2 phút tập hợp** (lãnh chúa nhận "Tham gia thủ thành" ở Lãnh địa quan), rồi 3 đợt. Không ai tham gia thì không đánh, không phạt |
| Một mình | Lãnh địa quan → Thủ thành → **Khiêu chiến ngay**: bắt đầu đợt 1 ngay theo cấp của người gọi. Đang có trận thì nút đổi thành "Tham gia thủ thành" |
| Nơi đánh | Hàng công trình Tây Kỳ: 16 ô quân (sân phía tây x 1512–1528, y 3032–3042 và khối phía đông x 1562–1574), 6 ô hộ vệ (y 3028/3034). Mọi ô trống 5×5 trên lưới server + client, liền vùng với Lãnh địa quan |
| Quân công thành | Template 116 商军校尉 (phe 5, địch của người chơi và bot), đặt phe 5 lại cho chắc. Cấp = cấp trung bình người thủ thành. Số quân đợt w: 4 + 2w + 2 × (số người − 1), tối đa 16 (một người: 6 / 8 / 10). Máu (100 + 30w) × cấp, sát thương 1–2 × cấp. Đợt 3 có **Tướng công thành** (máu 700 × cấp, sát thương 2–3 × cấp) |
| Hộ vệ ("bot giả") | Template bot 2703–2720 (phe 0, chỉ đánh quái phe 5, không đánh người), tên "Hộ vệ lãnh địa". Số lượng = 1 + cấp Thao trường + cấp Trại lính / 2 (tối đa 6), lấy theo người thủ thành có công trình cao nhất. Hộ vệ chết thì phút sau có người thay |
| Người thủ thành | Tối đa 8 người, bật chiến đấu khi tham gia. Rời Tây Kỳ hoặc thoát game là ra khỏi trận; không còn ai thì trận kết thúc (không thưởng, không phạt) |
| Thắng/thua | Đợt thắng khi mọi quân của đợt đã chết (người hạ, hộ vệ hạ hay bot hạ đều tính). Mỗi đợt 5 phút; hết giờ còn quân là **thua** |
| Thưởng thắng | Mỗi người: cấp × 5.000 kinh nghiệm, 20.000 × cấp thành thị lượng, 2 cống hiến, 1 Hưng thịnh, 1 Xích đồng, 1 Lương thảo. Tối đa **2 lần thưởng mỗi ngày** (task 2449) |
| Thua | Hưng thịnh −1 (không âm) |
| Đếm quái | `ct_mob.lua`: `LastDamage` khi người chơi hạ (báo "Hạ quân công thành: k/N"); quân có death script nên engine cho hồi sinh, `SetNpcRevTime(36)` làm `Revive` chạy sau 2 giây để tính quân bị hộ vệ/bot hạ rồi xóa NPC. Hộ vệ không có death script, chết thì `DeathSelf` xóa |
| An toàn | Trước mọi `DelNpc` theo chỉ số đã lưu đều kiểm `GetNpcID ≠ 0` và NpcParam (khóa 24307 + mã trận), để không xóa nhầm NPC khác hay xóa ô đã trống. Tick đầu của một servertimer state mới kết thúc trận còn dở của state cũ và dọn quân/hộ vệ của nó (giữ bóng Cửu Linh) |

**GlobalValue (2430–2479):**

| GV | Ý nghĩa | GV | Ý nghĩa |
|---|---|---|---|
| 2430 | 0 rảnh, 1 đang thủ thành | 2437 | Cấp quân |
| 2431 | Mã trận (phút bắt đầu) = NpcParam 2 | 2438 | Tổng quân bị hạ trong trận |
| 2432 | Đợt (0 = tập hợp) | 2439 | Lịch đã chạy: ngày × 10000 + hhmm |
| 2433 | Phút kết thúc tập hợp / đợt | 2440–2447 | 8 ô người thủ thành (PlayerIndex) |
| 2434 / 2435 | Quân bị hạ / quân của đợt | 2448–2455 | Mã người chơi (mod 1.000.000) của 8 ô |
| 2436 | Kết quả gần nhất: mã × 10 + 1 thắng / 2 thua / 3 không ai | 2456–2461 / 2462–2477 | Chỉ số NPC 6 hộ vệ / 16 quân |
| 2478 / 2479 | Số hộ vệ / 1 lịch, 2 khiêu chiến ngay | | |

NpcParam của NPC lãnh địa tự sinh: 1 = 24307, 2 = mã trận (hoặc phút gọi bóng), 3 = vai (1 quân, 2 bóng Cửu Linh, 3 hộ vệ), 4 = 1 khi đã tính chết, 5/6 = PlayerIndex / mã người gọi bóng.

### 2.13 Nâng cấp công trình (congthanh2)

- Mỗi công trình có cấp 1–5 (task 2440–2446 lưu cấp; bản cũ lưu 1 = đã xây, nên công trình đã xây là cấp 1). Cấp tối đa = cấp thành thị + 1.
- Nâng ở Lãnh địa quan → **Nâng cấp công trình**. Chi phí lên cấp L + 1: ngân lượng = giá xây × L, Xích đồng 2L, Lương thảo 2L (bị trừ); cần cống hiến 30L (không trừ). Từ nay Xích đồng (78) và Lương thảo (69) có chỗ dùng.
- `GetBuildingState` trả cấp (VNG chỉ so ≠ 0 nên vẫn đúng); bảng công trình VNG hiện "Cấp công trình: L/5".

| Công trình | Hiệu quả | Nối vào |
|---|---|---|
| Điện Phong Thần | Hương liệu từ Hoa thần bí ×2 ở cấp 3–4, ×3 ở cấp 5 | `ct_api` `AddCityIndexRes` (VNG 神殿 gọi `AddCityIndexRes(1,1)`) |
| Trại lính | +1 điểm hành động mỗi ngày cho mỗi cấp trên 1 (cấp 5: 9 điểm); cứ 2 cấp thêm 1 hộ vệ khi thủ thành | `ct_api` bọc `reset_stamina` của VNG 兵营 |
| Sân luyện thú | +1 lượt Trừ ma/ngày và +25% ngân quỹ cho mỗi cấp trên 1 | `ct_muchang.lua` |
| Phòng chiến xa | Bớt 1 bụi Xích Đồng Thảo ở cấp 3 và cấp 5 (5 → 4 → 3); +10% cơ hội Hưng thịnh mỗi cấp | `ct_chienxa.lua`, `ct_herb.lua` |
| Phòng luyện thuốc | Gỗ từ Luyện tiên đơn ×2 ở cấp 3–4, ×3 ở cấp 5 | `ct_api` `AddCityIndexRes` (VNG 炼丹炉 `AddCityIndexRes(2,1)`) |
| Thao trường | Hưng thịnh từ nhiệm vụ 31 ×2 / ×3; mỗi cấp thêm 1 hộ vệ khi thủ thành | `ct_api` `AddTongAttr(0,n)` (VNG 靶场) |
| Hý viện | +1 lượt Điệp báo/ngày và +20% kinh nghiệm cho mỗi cấp trên 1 | `ct_hyvien.lua` |

### 2.14 Kiểm thử congthanh2

- **`qtest\sim_congthanh.lua`: 231 kiểm tra, 0 lỗi** ở cả 4 lần chạy: `-Stack 100` và `-Stack 0 -Args1 EMU`, mỗi chế độ chạy cả bản sinh nháp (`S\congthanh\out`) lẫn bản runtime đã deploy (`rt`). Khoảng trống stack nhỏ nhất: 35 khung (`liandan_open`, như trước), ext tick 37, `PTCT_S_DefNowOk` 44, `ct_mob` 45.
- Phần mới trong mô phỏng:
  - **908:** dòng gọi bóng ở Phòng luyện thuốc và Lãnh địa quan; bóng đúng template/vị trí/chỉ số/phe; thời gian chờ 5 phút; `LastDamage` → 908 = 2; `Revive` không cộng lần hai; bot kết liễu thì người gọi vẫn được tính; `Timeout` không cộng; GlobalValue 101/4161 của boss thế giới không bị đụng.
  - **31:** 23 Đại phu với đúng script GBK (không trùng 1014–1016, 1022–1041); script VNG thật (lấy từ `ptfix.pak`) của Đại phu 304 = 5 và 51 đặt 100; Thao trường nhận báo cáo.
  - **Thủ thành:** khiêu chiến ngay → 3 đợt 6/8/10 quân, tướng đợt 3, 5 hộ vệ; tính quân do người hạ và do bot hạ; hộ vệ chết được thay; thắng → thưởng đủ; lần thắng thứ 3 trong ngày không thưởng; hết giờ → thua, Hưng thịnh −1; lịch 20:30 mở tập hợp, không mở lần hai cùng phút, không ai tham gia → hủy không phạt; lịch 12:30 có người tham gia → đợt 1; người thủ thành duy nhất rời Tây Kỳ → kết thúc; state mới dọn trận cũ; không có `DelNpc` nào lên NPC đã xóa.
  - **Nâng cấp:** chi phí, giữ cống hiến, cấp tối đa theo thành thị, thiếu tài nguyên thì báo, `GetBuildingState` = cấp, 6 điểm hành động ở Trại lính cấp 2, 2 Gỗ ở Phòng luyện thuốc cấp 3, lượt Trừ ma thứ 3 + 75.000 lượng ở Sân luyện thú cấp 3, 4 bụi đủ ở Phòng chiến xa cấp 3, lượt Điệp báo thứ 6 ở Hý viện cấp 2, Hưng thịnh ×2 ở Thao trường cấp 3.
  - Kiểm tra dải task: các script lãnh địa chỉ ghi 2430–2479 (cộng bit trạm dịch 868–874 và 908 khi hạ bóng).
- **Hồi quy** (sau khi deploy): `sim_questfix` TOTAL FAILS = 0; `sim_tta` TOTAL FAILS = 0; `sim_questaudit` không lỗi chạy (9 cờ NATIVE_TASKNOTE cũ của các NPC khác); `sim_tutuong_b` không cờ; `t_st` nạp servertimer OK; `sim_vienco` (runtime, giả lập stack và `-Stack 100`) FAILS = 0; `sim_daily3` (runtime, `-Stack 100` và emu) ERRORS 0.
- **Build ptfix nháp:** Client `S\congthanh2\ptfix_test_client.pak` rồi Server `S\congthanh2\ptfix_test.pak` (615 mục), log congthanh giữ nguyên: `shendian d2683bb5, bingying ad7f1d51, liandan 17c5b8e1, bachang 8448eaa4, flowers 15/15, pakmark`. Plug-in `extra_congthanh.py` không đổi.

### 2.15 Giới hạn còn lại

- Lua không có lệnh "đi tới": quân công thành đứng quanh ô xuất hiện (AIMode 1) và đánh người/hộ vệ trong tầm nhìn, không tự đi phá công trình.
- Tây Kỳ là thành: người không bật chiến đấu thì quái không đánh (engine coi là "không quan hệ"). Người thủ thành được bật chiến đấu khi tham gia và tắt khi trận kết thúc.
- Bóng Cửu Linh dùng thân 天罡星 (cùng `ani039`, cùng khung hình với Cửu Anh), bảng máu không hiện phần trăm như boss thế giới.
- Đổi file ext chỉ có hiệu lực sau khi khởi động lại server (servertimer `dofile` file ext một lần).

## Phần 3: Hành động

### Coordinator

- [x] Thêm `"congthanh"` vào `PTADM_EXT_NAMES` trong `Server\script\servertimer.lua` (đã có).
- [x] Build ptfix thật với plug-in `S\ptfix\extra_congthanh.py` (đã có trong `ptfix.pak` đang chạy). congthanh2 không đổi plug-in, không cần build lại vì việc của congthanh2.
- [ ] congthanh2: không cần hook servertimer mới (mọi việc chạy trong `PTEXT_congthanh_Tick`). Chỉ cần người dùng khởi động lại server để state servertimer nạp lại `ext\congthanh.lua`.
- [ ] (Tùy chọn) Sau khi coreclient xong: `python S\congthanh\apply_patch.py --check`, rồi `python S\congthanh\apply_patch.py [--with-gamedata-fix]`, rồi build lại Core.
- [ ] Dán dòng CHANGELOG và README trong báo cáo agent.

### Người dùng thử trong game (sau khi khởi động lại)

- [ ] Tây Kỳ, khoảng 10 ô phía nam dãy cửa hàng: thấy **Lãnh địa quan**, Sân luyện thú, Phòng chiến xa, Hý viện, 3 bụi Xích Đồng Thảo.
- [ ] Nếu ptfix mới đã deploy, có thêm Điện Phong Thần, Trại lính, Phòng luyện thuốc, Thao trường.
- [ ] Lãnh địa quan → **Lập lãnh địa riêng** (cấp ≥ 20, 10 vạn lượng) → **Xây dựng công trình** cấp 1.
- [ ] Điện Phong Thần → **Khảo nghiệm** (cấp ≥ 30) → kiểm tra F11 hiện "Khảo nghiệm điện Phong Thần" kèm số quái.
- [ ] Trại lính → N.v lính đánh thuê → Truy sát → Sát thủ C.1. Hạ quái và xem thông báo "(x/50)". Đưa tin: dùng **Nhờ trạm dịch đưa thư** ở Lãnh địa quan.
- [ ] Sau 894, nhận Hoa thần bí → đến map được chỉ định tìm **Hoa thần Cửu Di**.
- [ ] Báo lại: NPC đứng sai chỗ hoặc bị kẹt, menu không phản hồi khi bấm (đặc biệt các dòng có "N.v"), F11 hiện "Task N - step S".

**congthanh2:**
- [ ] **908:** nhận Phương pháp mới ở Phòng luyện thuốc (bước diệt Cửu Linh) → bảng Phòng luyện thuốc hoặc Lãnh địa quan có "Khiêu chiến bóng Cửu Linh (một mình)" → xác nhận: được đưa ra bãi trống phía tây, bóng Cửu Linh (cùng hình Cửu Anh) xuất hiện. Hạ nó: thông báo "Bạn đã hạ sát thành công Cửu Linh", quay lại Phòng luyện thuốc nhận bước tiếp. Boss thế giới Cửu Linh ở Tam Sơn vẫn tính như cũ.
- [ ] **31:** nhận Thao trường thí luyện, xem map được chỉ định (F11), đến gần điểm vào map đó tìm **Đại Phu** → nói chuyện → về Thao trường "Tình báo". Đặc biệt thử Sùng Thành ngoại (1005), Bắc Hải (1006), Bích Du/Khổn Tiên cung.
- [ ] **Thủ thành một mình:** Lãnh địa quan → Thủ thành (bảo vệ lãnh địa) → Khiêu chiến ngay → 6 "Quân công thành" xuất hiện quanh dãy công trình, vài "Hộ vệ lãnh địa" (hình người chơi) giúp đánh. Hạ hết: phút sau đợt 2 (8 quân), rồi đợt 3 (10 quân + Tướng công thành). Thắng: thông báo thưởng. Để hết 5 phút một đợt: thua, Hưng thịnh −1.
- [ ] **Thủ thành theo lịch:** 12:30 hoặc 20:30 có tin toàn server; trong 2 phút vào Lãnh địa quan → "Thủ thành: đang có quân công thành!" → Tham gia.
- [ ] **Nâng cấp công trình:** Lãnh địa quan → Nâng cấp công trình → chọn công trình → xem chi phí và hiệu quả → nâng. Tình hình lãnh địa hiện "cấp L"; bảng công trình VNG hiện "Cấp công trình: L/5". Thử Trại lính cấp 2: ngày hôm sau có 6 điểm hành động.
- [ ] Báo lại nếu quân công thành/hộ vệ đứng trong vật cản, quái không đánh khi đã tham gia (kiểm tra đã bật chiến đấu), hoặc hộ vệ không đánh quái.

## Phần 4: Tài liệu tham khảo

- Kiểm toán: `S\questaudit\quest_audit.md` mục 14 và 2.13; `docs\features\tan-thu-moi-phong-than-20261003.md`.
- Script VNG đã trích: `S\congthanh\vng\*.u8.txt` (đọc được) / `*.raw`; công cụ `S\congthanh\dump.py`, `apis.py`, `grid2.py`, `flowers.py`, `pakx.py`.
- Engine: `PhongThanLuaWave8.h` (IsOwnerCity, GetCityInfo, PersistentGroup), `PhongThanLuaCarriage.h` (AddTongAttr), `ScriptFuns.cpp` (`LuaSelectUI` cắt ở dấu "/" đầu tiên), `KSOServer.cpp:438`, `KSubWorld.cpp:547` (LoadTong).
- Mẫu ext / NPC: `script\phongthan\ext\cankhon2.lua`, `newbie2.lua`.
- Skill / agent liên quan: `questfix2` (mẫu đếm quái bằng NPC-script, dùng cho giai đoạn 2), `vantieu` (AddTongAttr), `newbie2` (894/908 chuyển sang đây).
- congthanh2:
  - Boss thế giới: `docs\features\boss-the-gioi-lenh-bai-phong-than-20260930.md`, `script\phongthan\boss\wb_data.lua` / `wb_lib.lua`, script chết đã bọc `\script\npcdeath\九婴.lua` (ptfix).
  - Đại phu: `docs\features\su-do-dong-di-phong-than-20261003.md` (20 Đại phu mê cung), script VNG `\script\龙套\野外医生-*.lua` (bảng 304 → script ở `S\sudo_dongdi\pak\*.u.txt`), `S\congthanh2\anchors31.txt` (điểm vào map), `S\sudo_dongdi\findpos.py`.
  - Thủ thành: mẫu phe/NPC của `docs\features\vien-co-giang-son-phong-than-20261003.md` (`vc_mob.lua`, `gs_mob.lua`), bot `docs\features\bot-gia-nguoi-choi-phong-than-20261002.md` (template 2703–2720).
  - Engine: `KNpc.cpp` 1710–1718 (`LastDamage` chỉ khi có người chơi), 1870–1885 (death script → hồi sinh, không có thì `DeathSelf`), 7995–8012 (`Revive`); `ScriptFuns.cpp` `SetNpcLife`, `SetNpcDamage`, `SetNpcRevTime`, `SetNpcParam` (16 ô, xóa khi `AddNpc`); `KNpcSet.cpp` 1252–1265 (người không bật chiến đấu thì quái không đánh).
  - Công cụ congthanh2: `S\congthanh2\` (`chk2.py` kiểm ô và script, `mkdocs.py` sinh dòng Đại phu, `tkmap2.py` bản đồ ô trống quanh lãnh địa, `traps2.py` điểm vào map, `scanrange.py` kiểm dải biến).
