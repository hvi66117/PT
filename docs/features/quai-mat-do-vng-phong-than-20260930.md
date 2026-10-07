# Quái các bản đồ: sinh lại theo mật độ và kiểu rải VNG

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái: **Đã thay 55 file `spawn_<map>.lua`**, có hiệu lực ở lần khởi động server kế tiếp. Người dùng chọn "làm tất cả một lần".

## Phần 1: Tổng quan
- **Quái ít** (kiểm chứng): bộ sinh cũ `%TEMP%\ptspawn\gen_spawn.py` đặt 1 quái cho mỗi 1.000 ô đi được và giới hạn 50–150 con mỗi map. Bản đồ VNG gốc 1014 có **311 ô/quái**, 1016 có 192 ô/quái, tức VNG dày hơn 3–6 lần.
- **Không giống VNG** (kiểm chứng): bản cũ gom quái thành khoảng 38 cụm 3–5 con, cách nhau 60–87 ô. VNG rải đều: 1014 có 517 nhóm, trong đó 363 con đứng lẻ, 100 cặp, 38 nhóm 3, 15 nhóm 4, khoảng cách tới con gần nhất khoảng 6 ô.
- **Dữ liệu đặt quái gốc của VNG chỉ còn ở 1014, 1016 và 1052** (1052 không có quái). Đã quét 90.016 mục trong các PAK: không có script nào rải quái ngoài bản đồ. Vì vậy các map khác chỉ có thể **sinh lại theo mật độ và kiểu rải của 1014**, vị trí không phải bản gốc.

## Phần 2: Chi tiết
### 2.1 Bộ sinh mới `scratchpad\mobs\gen_spawn_v2.py`
- Dùng lại dữ liệu của bản cũ: lưới ô đi được `grid_<map>.pkl`, mẫu quái và cấp quái theo bằng chứng nhiệm vụ trong `plan.py`, vùng trống 12 ô quanh cổng và 8 ô quanh NPC.
- **Mật độ:** 311 ô/quái, mỗi map 150–700 con.
- **Kiểu rải:** tâm nhóm rải đều bằng Poisson-disc. Kích thước nhóm: 1 con 70%, 2 con 19%, 3 con 7%, 4 con 3%; các con trong nhóm cách nhau 1–3 ô.
- **Dải cấp:** mẫu quái cấp thấp đặt gần cổng vào, 15% nhóm được trộn sang dải bên cạnh. Mỗi map có đúng **1 tinh anh** ở dải xa nhất.
- **Giữ nguyên** mọi phần sau các khối quái sinh tự động: `PT_SPAWN_SPECIAL` (quái mục tiêu nhiệm vụ), Phản quân đội trưởng ×3 ở 1007, Thi Thú ×3 ở 1043.

### 2.2 Số lượng
| Map | Trước | Sau |
|---|---|---|
| 1005 | 98 | 287 |
| 1006 | 149 | 676 |
| 1007 | 143 | 459 |
| 1015 | 151 | 615 |
| 1043 | 156 | 637 |
| 1065 | 150 | 727 |
| 1078 | 154 | 703 |
| **Tổng 55 map** | ~7.260 | **29.542** |

- Map nhỏ (1042, 1044, 1046–1051, 1054–1056, 1072) có 146–339 con. Map lớn bị giới hạn khoảng 700 con.
- **Giới hạn engine:** server cho tối đa 48.000 NPC. Sau khi sinh lại tổng khoảng 31.000 (tính cả khoảng 1.300 NPC gốc và NPC dịch vụ), vẫn còn dư.
- **Tải server:** quái chỉ hoạt động ở vùng có người chơi (`KSubWorld.cpp` Activate). Trong tầm nhìn khoảng 15–25 con, dưới mức 256 của client.
- **Kiểm tra:** cả 55 file đều nạp được bằng Lua 4 (`qtest\sim_spv2.lua`), tổng 29.542 dòng. Cộng thêm 17 quái nhiệm vụ đặc biệt khi server chạy.

### 2.3 Thời gian nạp
- `servertimer.lua` đổi `PTSpawn_Run(2500)` thành `PTSpawn_Run(4000)`: mỗi phút đặt tối đa 4.000 con, nạp xong khoảng 8 phút sau khi bật server.
- Script sinh quái chỉ chạy **một lần mỗi lần khởi động**. Nạp nóng sẽ nhân đôi số quái, nên phải khởi động lại server.

### 2.4 Nhãn tên và thanh máu chồng lên nhau (phản hồi lúc 13:15)
- **Kết quả nạp:** lúc 13:17 server đã đặt đủ **29.555** con (`done=1`).
- **Kiểm chứng:** cạnh EmLaAi (map 1028) có 3 con Lão Hồ Lô: một con trùng đúng tọa độ nhân vật, hai con cách 2 đơn vị. Quái đuổi đánh thì dồn vào cùng một điểm (engine không chặn NPC đứng chồng NPC), mỗi con vẽ riêng một tên và một thanh máu (`KScenePlaceC.cpp`, `PaintPhongThanNpcNameOverlay`).
- **Thanh máu mọi quái** hiện vì tùy chọn ShowLife đang bật (`UiConfig.ini` ShowLife=4). **Phím F8** tắt/bật; khi tắt chỉ con đang chọn làm mục tiêu hiện thanh máu.
- Tên quái luôn được vẽ. Muốn chỉ hiện tên khi di chuột hoặc chọn mục tiêu thì phải sửa C++ (điều kiện trong `PaintPhongThanNpcNameOverlay`).

- **Khung thanh máu rỗng lơ lửng** (ảnh lúc 13:25; VNG không có): quái vừa bị giết đang chờ hồi sinh không có hình xác (thiếu `*_die.spr` VNG), nhưng `PaintPhongThanLifeBarOverlay` vẫn vẽ khung `barback.spr` với 0% máu. Vá `CoreClient.dll` 0x7A44B: phần trăm máu ≤ 0 thì thoát hàm (nhảy tới phần kết thúc 0x1007A60B). Có tác dụng khi mở lại game bằng `PhongThan-MoGame.cmd`.

### 2.5 Rủi ro
- Người chơi lên cấp và nhận đồ rơi nhiệm vụ nhanh hơn khoảng 3–4 lần (quái nhiệm vụ gắn `mob_drop.lua`).
- Map có độ tin cậy "L" (mẫu quái suy luận) vẫn có thể sai loại quái.
- Log đồng bộ NPC (`server_npc_sync_diag.log`) sẽ lớn hơn.

## Phần 3: Hành động
- [ ] Tắt server và thoát game, chạy `PhongThan-ChayTatCa.cmd game`, chờ khoảng 8 phút cho quái nạp đủ. `admin_bridge\result.log` phải báo `spawn added≈29.5xx … done`.
- [ ] Vào 1006 hoặc 1015 kiểm tra mật độ quái. Nếu thấy quá dày hay quá thưa thì báo lại để chỉnh `CELLS_PER_MOB`.
- [ ] **Khôi phục bản cũ** (chỉ khi bạn đồng ý): chép `_backup\20260930-spawn-v2\spawn\*` về `Server\script\phongthan\spawn\` và `_backup\20260930-spawn-v2\servertimer.lua` về `Server\script\`.

## Phần 4: Tài liệu tham khảo
- `quai-cac-ban-do-phong-than-20260928.md` (bản sinh đầu tiên), `kinh-nghiem-danh-quai-phong-than-20260930.md`.
- Phân tích: `scratchpad\mobs\a1.py`…`a5_out.txt`; dữ liệu gốc đã tách sẵn: `%TEMP%\ptspawn\orig.pkl`.
- Mã chạy: `Server\script\phongthan\spawn\spawn_main.lua`, `Server\script\servertimer.lua` (`PTAdm_Spawn`).
- `PhongThanSource\Sources\Core\Src\GameDataDef.h` (`MAX_NPC` 48000 server / 256 client).
