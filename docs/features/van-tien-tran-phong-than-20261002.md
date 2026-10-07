# Vạn Tiên trận chơi được trên máy chủ Phong Thần local

> Ngày: 2026-10-02 · Người thực hiện: agent `vantien`, bổ sung bởi agent `vantien2` (hình dạng Thiên Hùng, chuỗi nhiệm vụ ngày, nút web admin) · Loại: tính năng mới, chỉ dùng Lua và dữ liệu, không sửa C++, không sửa `npcs.txt`, không cần ptfix.
> Nhãn: **[VERIFIED]** = đã kiểm tra trên mã nguồn, dữ liệu bản đồ hoặc trình mô phỏng. **[INFERRED]** = suy luận, cần thử trong game.

## Phần 1: Tổng quan

### Insight chính
- Vạn Tiên trận giờ là **phó bản PvE có giờ, vào được một mình**. Người chơi nói chuyện với **Thiên Hùng ở Tây Kỳ (1020)**. Nếu trận đang đóng, Thiên Hùng **mở trận ngay**: chuẩn bị 20 giây rồi đánh 30 phút. Ngoài ra trận vẫn tự mở theo giờ VNG.
- Có 4 trận, dùng 4 bản đồ **Huyễn**:

| Trận | Mission | Bản đồ | Cấp vào | Mở khóa sớm |
|---|---|---|---|---|
| Thổ | 1 | 1079 | 30+ | — |
| Thủy | 2 | 1080 | 51+ | đã phá trận Thổ |
| Hỏa | 3 | 1081 | 71+ | đã phá trận Thủy |
| Phong | 4 | 1082 | 91+ | đã phá trận Hỏa |

- **Luồng chơi**:
  1. Vào trận.
  2. Hạ 4 tiên (Ô Vân, Cầu Thủ, Linh Nha, Kim Quang). Mỗi người trong trận nhận 1 lệnh (Thanh long, Chu tước, Huyền võ, Bạch hổ).
  3. Khi đủ 4 tiên, Thông Thiên Giáo Chủ xuất hiện ở **Thần Bí Trận Điểm**. Vào đó bằng trận nhãn VNG (cần đủ 4 lệnh) hoặc nhờ Đại phu đưa vào.
  4. Hạ Thông Thiên thì nhận thưởng phá trận, và 4 **Bảo rương Thông Thiên** xuất hiện.
  5. Đại phu cho **tiến thẳng sang trận kế tiếp**. Người chơi có thể đi liền từ trận 1 đến trận 4.
- **Thân thiện khi chơi một mình hoặc với bot**: mọi người đứng trong trận đều nhận lệnh và thưởng, kể cả khi đòn cuối do bot hoặc người ngoài trận đánh.
- Sáu lớp chặn trong báo cáo nghiên cứu đều đã gỡ bằng Lua (bảng ở 2.1).
- **Bổ sung (agent `vantien2`)**:
  - Thiên Hùng giờ có **hình người** (mẫu 202 `passerby054`, dáng tiên nhân) thay cho hình cổng dịch chuyển.
  - **Chuỗi nhiệm vụ ngày VNG của Thiên Hùng** đã được chuyển sang: nhiệm vụ mở đầu "điều tra Lục Hồn Phiên", nhiệm vụ ngày (diệt quái, diệt tiên, diệt Thông Thiên, hỏi Đại phu), 11 đẳng cấp Vạn Tiên trận, **trang bị bộ** ở đẳng cấp 1, 4, 7, 9 (xem 2.7).
  - Web admin có tab **Vạn Tiên trận** với nút **Mở Vạn Tiên trận** cho từng trận và bảng trạng thái (xem 2.8).

### Nhận định quan trọng
- **Không có mẫu NPC riêng cho "Thiên Hùng"** trong `npcs.txt`. Tên gốc VNG là `赏金猎人` (bảng tên NPC trong vng00.pak), nhưng không có mẫu nào mang tên này. Bản đầu dùng mẫu 247 `passerby099` (cổng Vạn Tiên trận VNG), trông như cổng dịch chuyển. Từ bản `vantien2` dùng **mẫu 202 `passerby054`** (Kind 3), hình tiên nhân đã có người chơi thấy trong game: Đa Bảo Đạo Nhân (`PTADM_NPC_SPAWN`, map 1044) và hai mẫu Nam Minh Tử, Vân Trung Tử cũng dùng hình này [VERIFIED trong `settings\phongthan\Npcs.txt`]. Tên vẫn đặt bằng `SetNpcName`. Không sửa `npcs.txt`.
- Vị trí 4 tiên, Thông Thiên và rương là **[INFERRED]**, vì dữ liệu đặt NPC gốc đã mất. Mọi ô đã được kiểm tra trên Region_S của bản đồ Huyễn **[VERIFIED]**:
  - không có vật cản;
  - tiên và quái nằm trong vùng đi bộ chính, thông với điểm vào;
  - Thông Thiên và rương nằm trong vùng kín "Thần Bí Trận Điểm", đúng nơi trận nhãn VNG dịch chuyển tới.
- Chuỗi **nhiệm vụ ngày VNG của Thiên Hùng** (script `b5deef29`) dùng task 405–409, bit 1 của 404 và 767/768. Các script loose VNG `npcdeath\强化*.lua` (DeathScript của mẫu quái 53–60) vẫn đọc ghi 407–409, nên bản chuyển dùng **task 2006–2013** trong dải của Vạn Tiên để tránh va chạm [VERIFIED: grep loose].

## Phần 2: Chi tiết

### 2.1 Gỡ từng lớp chặn
| Lớp chặn trong báo cáo | Cách gỡ |
|---|---|
| (a) Engine không đọc `missions.txt`/`timertask.txt`, chỉ gọi `mission%02d.lua` và `task%02d.lua:OnMissionTimer` | Viết `script\missions\mission01..04.lua` và `script\timertask\task02..09.lua` mới. Các file này mỏng, gọi `vt_lib.lua`. `mission01.lua` và `task01.lua` cũ (VLTK) đã được backup rồi thay. |
| (b) Mã map cũ 67–70 làm `SubWorldID2Idx` trả về -1 | Dùng thẳng 1079–1082 cho `SubWorldID2Idx`, `NewWorld` và `AddNpc`. |
| (c) Map 1067/1069/1070 không có Region_S | Dùng 4 map Huyễn: đã nạp, đủ Region_S, có trap VNG. |
| (d) Thiếu API `GetNextPlayer`, `LockCamp`, `KillNpcByIdx`, `SendGlobalMessage`, `DelHandItem` | Thay bằng vòng `GetMSPlayerCount`/`MSDIdx2PIdx`/`GetPMParam` và `AddGlobalNews`. Các API còn lại không còn cần. |
| (e) `SetMissionV` 2 tham số và `AddNpc` 5 tham số không có tác dụng | Trạng thái lưu ở GlobalValue 400–419. `AddNpc` luôn gọi đủ 6 tham số. |
| (f) Không có lịch mở | Tick `PTVT_Tick` chạy mỗi phút, mở trận theo giờ VNG. Ngoài ra Thiên Hùng mở trận theo yêu cầu. |
| Death script của NPC sinh bằng script không chạy | Gắn ActionScript bằng `SetNpcScript`. Engine gọi `LastDamage(npc)` với `PlayerIndex` là người hưởng kill (`KNpc::DoDeath`) [VERIFIED mã nguồn]. Boss và rương được đặt `SetNpcRevTime` 24 giờ để không hồi sinh. |
| 8 script trap VNG chỉ có trong PAK, chưa đăng ký | Tick lần đầu chạy `ReLoadScript` cho 8 đường dẫn GBK, nên không cần ptfix. Id trap trong Region_S trùng hash các script này [VERIFIED]. |
| Rương VNG không có thưởng | `vt_chest.lua` phát thưởng (2.4). |

### 2.2 Luồng mission (giống nhau cho cả 4 trận)
1. **Mở**: Thiên Hùng (theo yêu cầu, chuẩn bị 20 giây) hoặc tick (theo giờ, chuẩn bị 5 phút) gọi `OpenMission(n)`. Hàm `InitMission` của mission:
   - sinh 4 tiên (mẫu Huyễn 1904–1923), 12 quái 强化 (mẫu 53–60) và 2–3 Đại phu (mẫu 766);
   - gắn mọi NPC vào mission bằng `AddMSNpc`;
   - đặt GV trạng thái = 1 và tạo khóa lượt;
   - bật timer bắt đầu (`task06..09`).
2. **Bắt đầu**: timer bắt đầu gọi `RunMission`. Trạng thái = 2, người trong trận được `SetFightState(1)`, và timer kết thúc 30 phút (`task02..05`) bắt đầu chạy.
3. **Đánh**:
   - Mỗi tiên chết cho mọi người trong trận 1 lệnh (3,66..69).
   - Đủ 4 tiên thì Thông Thiên xuất hiện.
   - Thông Thiên chết: trạng thái = 3 (đã phá), sinh 4 rương, phát thưởng phá trận, ghi tiến độ mở khóa.
4. **Rời trận**: Đại phu "Rời trận" hoặc đổi map đều gọi `OnLeave`. `OnLeave` tắt trạng thái chiến đấu, xóa lệnh và đánh dấu slot mission không còn hiệu lực.
5. **Kết thúc**: timer kết thúc gọi `CloseMission`. `EndMission` đưa mọi người đang đứng trên map về Tây Kỳ, rồi engine xóa toàn bộ NPC của mission.
6. **Mở lại**: trận đã phá mà không còn ai bên trong thì lần vào sau tạo lượt mới. Trận đang chạy thì người vào sau nhập chung lượt, giữ nguyên tiến độ (ví dụ khi chết rồi quay lại).

### 2.3 Đại phu trong trận
Có 1 Đại phu ở điểm vào, 1 trong vùng Thông Thiên, và 1 trong vùng trap thứ hai nếu vùng đó kín (trận Thổ, Thủy, Phong), nên không ai bị kẹt. Menu gồm:
- Tình hình trận: số tiên đã hạ, thời gian còn lại.
- Hỏi về Lục Hồn Phiên / Hỏi về lệnh bài đặc biệt: chỉ hiện khi đang làm nhiệm vụ Thiên Hùng tương ứng (2.7).
- Đưa đến Thần Bí Trận Điểm: hiện khi đã hạ đủ 4 tiên, hoặc khi người chơi đã có quyền vào không cần lệnh bài (task 2011, nhận ở đẳng cấp Vạn Tiên 7).
- Tiến vào trận kế tiếp: sau khi phá trận.
- Mua thuốc (`Sale(1)`, như Đại phu Tây Kỳ).
- Về điểm vào.
- Rời trận về Tây Kỳ.

### 2.4 Phần thưởng (cân cho chơi một mình)
Phần thưởng dùng vật phẩm có sẵn trong `material.txt` [VERIFIED].

| Nguồn | Thổ | Thủy | Hỏa | Phong |
|---|---|---|---|---|
| Hạ Thông Thiên: EXP | 600 × cấp | 800 × cấp | 1000 × cấp | 1200 × cấp |
| Hạ Thông Thiên: ngân lượng | 10.000 | 20.000 | 30.000 | 50.000 |
| Hạ Thông Thiên: nguyên liệu | 1 Địa Tâm (3,110) | 1 Thủy Hồn (3,112) | 1 Hỏa Linh (3,113) | 1 Phong Lệ (3,111) |
| Mỗi rương (×4): EXP | 300 × cấp | 400 × cấp | 500 × cấp | 600 × cấp |
| Mỗi rương: ngân lượng | 3.000 | 6.000 | 10.000 | 15.000 |

- Mỗi rương có thêm một lần quay vật phẩm:
  - 45%: nguyên liệu nguyên tố của trận;
  - 20%: Mảnh Hồng thủy tinh (3,77);
  - 20%: Mảnh Lam thủy tinh (3,78);
  - 10%: Hoàn Nguyên Thạch (3,136);
  - 5%: không có gì.
- Ví dụ cấp 45, trận Thổ: khoảng 81.000 EXP, 22.000 lượng và 3–5 nguyên liệu mỗi lần phá. Mức này gần một lượt nhiệm vụ ngày Vạn Tiên của VNG.
- **Giới hạn**: mỗi trận nhận thưởng tối đa **2 lần mỗi ngày** cho mỗi nhân vật (`PTVT_DAILY_CAP`). Rương chỉ thưởng cho người đã nhận thưởng Thông Thiên trong lượt đó (task 2004 = khóa lượt).
- Mọi con số nằm trong `vt_data.lua`. Muốn chỉnh thì sửa `scratchpad\vantien\impl\build.py` rồi build lại.

### 2.5 Biến dùng
- **GlobalValue 400–419**, 5 giá trị cho mỗi trận: trạng thái, mặt nạ kill, khóa lượt, số giây chuẩn bị, số rương đã mở. Chỉ script Vạn Tiên VNG (không chạy) dùng dải này [VERIFIED: grep loose và quét toàn bộ PAK].
- **Task 2000–2005**: 2000 tiến độ (bit n = đã phá trận n), 2001 ngày, 2002 số lần thưởng trong ngày, 2003 khóa lượt đã vào, 2004 khóa lượt được mở rương, 2005 map đang ở. Dải 2000–2019 được giao cho agent `vantien`, chưa ai dùng [VERIFIED].
- **Task 2006–2013** (nhiệm vụ ngày, thay task VNG): 2006 đẳng cấp Vạn Tiên + 1 (VNG 405), 2007 số nhiệm vụ còn cần để lên cấp (406), 2008 số quái còn phải diệt (407), 2009 trạng thái nhiệm vụ (408), 2010 ngày nhận nhiệm vụ YYYYMMDD (409), 2011 quyền vào Thần Bí Trận Điểm không cần lệnh bài (404 bit 1), 2012 ngày và 2013 số lần dùng Thưởng Kim Bài (767/768). Task 2014–2019 còn trống.
- **Mission timer**: id 2–5 (kết thúc) và 6–9 (bắt đầu), khớp `timertask.txt` của VNG.

### 2.6 Vị trí [VERIFIED trên Region_S, INFERRED về thiết kế]
- **Thiên Hùng**: Tây Kỳ 1020, mps (50464, 96896) = ô (1577, 3028), cạnh Bảo Thương (ô 1580, 3024). Ô này trống trong Region_S loose vùng (98, 94). Về thành tại ô (1580, 3030).
- **Điểm vào** (VNG):
  - Thổ (1325, 3280);
  - Thủy (1752, 3567);
  - Hỏa (1647, 3397): điểm VNG (1650, 3400) không có Region_S nên dời sang ô trống gần nhất;
  - Phong (1671, 3035).
- **Thông Thiên**: cách điểm đến của trận nhãn khoảng 5–6 ô, trong vùng kín. Riêng trận Hỏa dùng điểm đến của trap 2 (1708, 3181), vì trap 1 rơi vào vùng chính.
- Toàn bộ bảng tọa độ nằm trong `script\phongthan\vantien\vt_data.lua`.

### 2.7 Chuỗi nhiệm vụ ngày của Thiên Hùng (agent `vantien2`, chuyển từ VNG `b5deef29`)
Logic: `vt_thienhung.lua` (hội thoại, hàm `thq_*`) và `vt_quest.lua` (bảng dữ liệu, cộng tiến độ khi hạ quái, tiên, Thông Thiên, khi hỏi Đại phu). Mọi chuỗi chữ hiển thị là TCVN3, giống script VNG.

**Mở đầu (cấp 30+)**: Thiên Hùng → "Nhiệm vụ: điều tra Lục Hồn Phiên" → nhận → vào trận bất kỳ, hỏi Đại phu → về báo Thiên Hùng: 5.000 EXP, đẳng cấp Vạn Tiên 0. Bản VNG có lỗi: không script nào hoàn thành bước này (Đại phu VNG chỉ xử lý trạng thái 10). Bản chuyển cho Đại phu xử lý cả hai trạng thái 1 và 10.

**Nhiệm vụ ngày** (1 nhiệm vụ mỗi ngày, phải xong và báo trong ngày, giống VNG):

| Loại | Mục tiêu | Cộng tiến độ cho |
|---|---|---|
| 2 / 3 | Diệt N quái 强化 (loại 2: mẫu 53/55/57/59; loại 3: mẫu 54/56/58/60). Tên quái hiển thị theo bậc cấp người chơi | Người hạ đòn cuối + đồng đội đứng cùng bản đồ (như VNG) |
| 4–7 | Hạ 1 tiên (Ô Vân, Cầu Thủ, Linh Nha, Kim Quang) | Mọi người trong trận (như phần thưởng lệnh) |
| 8 | Hạ đủ 4 tiên (ghi nhận dần qua các lượt trong ngày) | Mọi người trong trận |
| 9 | Hạ Thông Thiên Giáo Chủ | Mọi người trong trận |
| 10 | Đẳng cấp 7, lần cuối trước khi lên cấp: hỏi Đại phu về lệnh bài đặc biệt | Người hỏi |

- Bảng chọn nhiệm vụ theo đẳng cấp giữ nguyên VNG. **Số quái chia 5** (`PTVT_Q_KILL_DIV`) cho hợp chơi một mình: VNG 50–500 → 10–100 (mỗi trận có 12 quái, quái hồi sinh).
- **Thưởng mỗi nhiệm vụ**: EXP = `{400,500,500,600,600,700,700,800,800,900,1000}[đẳng cấp+1] × cấp nhân vật × 2`; ngân lượng 5.000–50.000.
- **Lên đẳng cấp**: cần `{3,5,8,12,18,25,35,50,100}` nhiệm vụ. Đẳng cấp tối đa theo bậc cấp nhân vật: cấp 30–50 → 1, 51–70 → 4, 71–90 → 7, 91+ → 10 (VNG `level_req`).
- **Trang bị bộ** (nhiệm vụ cuối của đẳng cấp 1, 4, 7, 9), chọn 1 món, `AddNormalItem(0, phần, phái+6, cấp)`. Cả 60 món đều có trong `settings\item\001\armor/boot/belt/helm/pendant.txt` [VERIFIED]:

| Đẳng cấp | Cấp đồ | Giáp Sĩ | Đạo Sĩ | Dị Nhân |
|---|---|---|---|---|
| 1 | 3 | Vũ Khúc | Xích Tùng | Báo Thần |
| 4 | 5 | Tinh Cang | Thái Ất | Giác Thú |
| 7 | 7 (chỉ Ngoa, Yêu Đái/Cân, Khôi/Quán/Trụ) | Khai Thiên | Thông Thiên | Lam Điêu |
| 9 | 9 | Chấn Đán | Hồng Quân | Kháng Long |

- Ở đẳng cấp 7 còn nhận **quyền vào Thần Bí Trận Điểm không cần lệnh bài** (task 2011): Đại phu đưa vào ngay khi trận đang chiến đấu.
- Túi đầy: không phát đồ, giữ nguyên trạng thái để quay lại chọn (VNG làm mất phần thưởng).
- **Thưởng Kim Bài** (IB 8,138): sau khi xong nhiệm vụ hôm nay, đổi lấy nhiệm vụ mới, tối đa 2 lần mỗi ngày.
- Nhiệm vụ quá ngày bị hủy khi hạ quái hoặc khi nói chuyện với Thiên Hùng (như VNG).

### 2.8 Nút "Mở Vạn Tiên trận" trên web admin (agent `vantien2`)
- Tab **Vạn Tiên trận** (`AdminWeb\index.html`): bảng 4 trận gồm trạng thái (Đóng / Đang chuẩn bị / Đang chiến đấu / Đã phá trận), số tiên đã hạ, Thông Thiên, số người trong trận, thời gian còn lại, và nút **Mở Vạn Tiên trận**. Tự làm mới mỗi 30 giây.
- Nút gửi `POST /api/action {type:'vtopen', tran:n}`. `PhongThan-Admin.ps1` ghi vào `admin_bridge\pending.lua`, cùng cách với nút "Gọi ngay" của boss thế giới:
  ```lua
  if not PTVT_AdminOpen then dofile("script\\phongthan\\vantien\\vt_timer.lua") end local r = PTVT_AdminOpen(n) if r == 1 then PTAdm_Log(ID, "OK", ...) elseif r == 2 then PTAdm_Log(ID, "OK", "... dang mo san") else PTAdm_Log(ID, "FAIL", ...) end
  ```
- `PTVT_AdminOpen(n)` mở trận với **5 phút chuẩn bị** (như lịch tự động), báo toàn server, trả về 1 (đã mở), 2 (đang mở sẵn), 0 (bản đồ chưa nạp), -1 (n sai). Hàm giữ nguyên `SubWorld` và `PlayerIndex` của state servertimer.
- **Trạng thái**: `PTVT_WriteStatus()` ghi `admin_bridge\vantien.txt` mỗi phút (trong tick) và ngay sau khi mở bằng web, theo mẫu `worldboss.txt`. `GET /api/vantien` đọc file này. Hàm chỉ ghi khi chạy trong state servertimer (có `PTADM_DIR`).

## Phần 3: Hành động

### 3.1 Việc của coordinator (agent không được sửa các file này)
- [ ] Thêm hook vào `Server\script\servertimer.lua`, ngay sau `PTAdm_WbTick`:
  ```lua
  -- 2026-10-02 Van Tien tran (4 tran tren map Huyen 1079..1082, Thien Hung o Tay Ky).
  -- Logic in script\phongthan\vantien\vt_timer.lua (GV 400..419, task 2000..2005).
  function PTAdm_VtTick()
  	if not PTVT_Tick then dofile("script\\phongthan\\vantien\\vt_timer.lua") end
  	if PTVT_Tick then PTVT_Tick() end
  end
  ```
  rồi thêm dòng `PTAdm_VtTick()` vào `PTAdm_Tick()`, sau `PTAdm_WbTick()`. Hook chạy mỗi phút.
- [ ] Ghi `CHANGELOG.md` và `docs\features\README.md`.
- [x] Nút "Mở Vạn Tiên trận" trên web admin: đã làm (agent `vantien2`, 2.8). Không cần thêm hook servertimer mới, vẫn dùng `PTAdm_VtTick`.

### 3.2 Checklist thử trong game (người dùng tự khởi động lại server)
- [ ] Khởi động lại GameServer. Sau tối đa 1 phút, **Thiên Hùng** xuất hiện ở Tây Kỳ, cạnh Bảo Thương.
- [ ] Nhân vật dưới cấp 30 bị từ chối. Nhân vật cấp 30–50 chỉ vào được trận Thổ.
- [ ] Chọn "Vạn Tiên trận (Thổ)": được đưa vào map 1079, thấy Đại phu, 4 tiên và quái. Sau 20 giây có thông báo "Trận chiến bắt đầu".
- [ ] Hạ từng tiên: mỗi lần nhận 1 lệnh và có thông báo "(k/4)". Thử để bot đánh đòn cuối, vẫn phải nhận lệnh.
- [ ] Đủ 4 tiên: Thông Thiên xuất hiện. Thử bước vào trận nhãn (cần 4 lệnh), hoặc nhờ Đại phu đưa đến Thần Bí Trận Điểm.
- [ ] Hạ Thông Thiên: nhận EXP, lượng và nguyên liệu, thấy 4 Bảo rương. Đập rương nhận thêm thưởng.
- [ ] Đại phu → "Tiến vào Vạn Tiên trận (Thủy)": vào được dù chưa đủ cấp 51. Lặp lại đến trận Phong.
- [ ] "Rời trận": về Tây Kỳ, mất trạng thái chiến đấu, lệnh bị xóa.
- [ ] Phá cùng một trận lần thứ 3 trong ngày: báo đã đủ lượt, rương không có thưởng.
- [ ] Thoát game trong trận rồi vào lại: về điểm hồi sinh (thường là thành). Nếu vẫn đứng trong trận đang mở, tick sẽ đăng ký lại; nếu trận đã đóng, tick đưa về Tây Kỳ.
- [ ] Đợi hết 30 phút: mọi người bị đưa về Tây Kỳ, NPC trong trận biến mất.
- [ ] Theo dõi `result.log` và log server: không có lỗi script `vt_*.lua`, `mission0x.lua`, `task0x.lua`.

**Bổ sung `vantien2` (cần khởi động lại GameServer và web admin):**
- [ ] Thiên Hùng ở Tây Kỳ có hình người (tiên nhân), không còn hình cổng.
- [ ] Nhân vật cấp 30+: menu Thiên Hùng có "Nhiệm vụ: điều tra Lục Hồn Phiên". Nhận → vào trận → Đại phu có dòng "Hỏi về Lục Hồn Phiên" → về Thiên Hùng nhận 5.000 EXP.
- [ ] Menu đổi thành "Nhiệm vụ ngày Vạn Tiên trận" và "Đẳng cấp Vạn Tiên trận". Nhận nhiệm vụ diệt 10 quái → vào trận diệt quái, mỗi con có thông báo "còn phải diệt …" → xong báo Thiên Hùng nhận EXP và lượng.
- [ ] Hỏi lại trong ngày: Thiên Hùng báo đã xong, đề nghị dùng Thưởng Kim Bài.
- [ ] (Tùy chọn, nếu có công cụ đặt task) Thử nhanh trang bị: task 2006 = 2, 2007 = 1, 2009 = 100000, 2010 = ngày hôm nay (YYYYMMDD) → nói chuyện Thiên Hùng → chọn 1 trong 5 món bộ cấp 3 đúng phái.
- [ ] Web admin → tab **Vạn Tiên trận** → bấm **Mở Vạn Tiên trận** ở trận Thủy: trong 1 phút có thông báo toàn server, tab Lịch sử lệnh báo "Thành công", bảng chuyển sang "Đang chuẩn bị" rồi "Đang chiến đấu".

### 3.3 Rủi ro cần để ý [INFERRED]
- **Sức mạnh boss**: cấp tiên và Thông Thiên lần lượt là 45/50, 65/70, 85/90, 100/105. Nếu quá khó khi chơi một mình, giảm `lv_tien`, `lv_tt`, `lv_mob` trong `build.py`.
- **Chạm trận nhãn khi chưa đủ 4 tiên**: nếu người chơi còn lệnh từ trước, trap VNG vẫn dịch chuyển vào vùng kín. Đại phu trong vùng đó có lựa chọn "Về điểm vào trận".
- **Hình Thiên Hùng**: đã đổi sang mẫu 202 (`passerby054`). Muốn hình khác (ví dụ tướng quân `passerby029`/`passerby030`) thì đổi `PTVT_TH[4]` trong `build.py`. Tick tự xóa NPC mẫu cũ và sinh lại khi mẫu khác `PTVT_TH[4]`.
- **Độ khó nhiệm vụ ngày**: nếu diệt quái quá lâu hoặc quá nhanh, chỉnh `PTVT_Q_KILL_DIV` trong `vt_quest.lua` (src) rồi build lại.
- **Cộng tiến độ quái** dựa trên ActionScript `vt_mob.lua` gắn khi sinh quái [INFERRED: giống cơ chế boss, đã chạy ở trình mô phỏng; cần thử trong game].

## Phần 4: Tài liệu tham khảo
- **Mã nguồn đã đọc**:
  - `Core\Src\ScriptFuns.cpp`: InitMission, RunMission, CloseMission, timer, `AddMSPlayer`, `SetNpcRevTime`, `NewWorld`, `AddNpc`, `AddNormalItem`;
  - `KMission.cpp/.h`: `OnLeave` qua `RemovePlayer`, `StopMission` xóa NPC mission;
  - `KTaskFuns.cpp`: `task%02d.lua:OnMissionTimer`, khung hình 18 FPS;
  - `KNpc.cpp`: `LastDamage`, `DoRevive`;
  - `KSortScript.cpp`: quét `\script` lúc khởi động, `ReLoadScript`;
  - `KRegion.cpp`, `SceneDataDef.h`: Region_S gồm obstacle và trap.
- **File runtime mới**: `Server\script\phongthan\vantien\vt_data.lua`, `vt_lib.lua`, `vt_timer.lua`, `vt_thienhung.lua`, `vt_daiphu.lua`, `vt_boss.lua`, `vt_chest.lua`; `script\missions\mission01..04.lua`; `script\timertask\task01..09.lua`.
- **Backup**: `E:\VL\Phong than\PT\_backup\20261002-vantien\Server\script\missions\mission01.lua`, `...\timertask\task01.lua` (bản VLTK). Không tự khôi phục; chỉ khôi phục khi người dùng đồng ý.
- **Nguồn build và kiểm thử**:
  - `scratchpad\vantien\impl\src\` (UTF-8), `build.py`, `mapgrid.py`;
  - trình mô phỏng `scratchpad\qtest\sim_vantien.lua`. Kết quả: `out_vantien.txt` (bản build) và `out_vantien_runtime.txt` (bản đã triển khai), **80/80 ok, 0 flag**.
- **Tài liệu liên quan**: `scratchpad\vantien\vantien_report.md` (nghiên cứu), `boss-the-gioi-lenh-bai-phong-than-20260930.md` (mẫu tick), `loi-ra-ban-do-cong-dich-chuyen-phong-than-20260928.md` (đăng ký script trap).
- **Bổ sung `vantien2`**:
  - file mới: `vt_quest.lua`, `vt_mob.lua`; file sửa: `vt_data.lua`, `vt_lib.lua`, `vt_timer.lua`, `vt_thienhung.lua`, `vt_daiphu.lua`; `AdminWeb\PhongThan-Admin.ps1`, `AdminWeb\index.html`;
  - backup: `E:\VL\Phong than\PT\_backup\20261002-vantien2\` (Lua runtime, AdminWeb, tài liệu, nguồn build);
  - kiểm thử: `scratchpad\qtest\sim_vantien2.lua` (nhiệm vụ, hình Thiên Hùng, đường mở từ web admin) **74/74 ok, 0 flag**; `test_admin_vt.ps1` (sinh lệnh Lua từ chính mã PS1, đọc `vantien.txt`) **5/5 ok**; `sim_vantien.lua` chạy lại **80/80 ok, 0 flag**.
- **Việc tiếp theo có thể làm**:
  - mở lại dòng menu Vạn Tiên của Sùng Hắc Hổ, Từ Hàng, Thiếu Hạo để trỏ sang `PTVT_EnterRequest`.
