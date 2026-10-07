---
tính năng: Bot giả người chơi (20–30 NPC mang hình người chơi)
ngày: 2026-10-02
trạng thái: Đã viết và chạy thử trong simulator, chờ khởi động lại server + client và gắn hook servertimer
phạm vi: Npcs.txt (Server + Client), script\phongthan\bots\bots.lua, không sửa C++
---

# Bot giả người chơi cho Phong Thần

## Phần 1: Tổng quan

- **Mục tiêu:** người chơi một mình vẫn thấy thế giới có người. Server luôn giữ 26 bot (chỉnh được trong khoảng 20–30). Bot có thân, giáp, mũ, vũ khí, ngựa của người chơi và mang tên kiểu người chơi Việt (ThiênLong, TiểuYến, ĐộcCôKiếm, KhóiSương…).
- **Bot làm được 4 việc:**
  1. Đứng và đi lại quanh trung tâm 5 thành: Sùng Thành doanh, Ngọc Hư cung, Xi Vưu Mộ, Tây Kỳ, Triều Ca.
  2. Đánh quái ở 20 bãi luyện công (cấp quái 3–45), dùng kỹ năng của phái mình.
  3. Nói chuyện. Bong bóng chat hiện trên đầu bot, bot chào người chơi đi ngang qua bằng tên, và thỉnh thoảng có một dòng "[Thế giới] Tên bot: …" gửi cho cả server.
  4. Tụ tập ở khu sự kiện. Trước giờ boss thế giới 10 phút đến sau giờ đó 15 phút, 4 bot sự kiện đứng quanh chỗ boss xuất hiện. Ngoài giờ boss, các bot này đứng ở Phong Thần đài (map 1001).
- **Cách làm:** chỉ dùng dữ liệu và Lua, không đụng C++.
  - Thêm 18 template mới (id 2703–2720) vào `Npcs.txt`. Template dùng thân người chơi (`男甲士/女甲士`, `男术士/女术士`, `男异人/女异人`), camp 0, AIMode 1, kỹ năng ghi bằng id số.
  - Một script `bots.lua` lo việc spawn, giữ đủ số lượng, đổi chỗ đứng và chat.
- **Phải khởi động lại cả server lẫn client.** Engine đọc `Npcs.txt` một lần lúc khởi động. File `Npcs.txt` của **client** cũng đã đổi: client cũ không có template 2703–2720 nên sẽ không vẽ được bot.
- **Bot an toàn với người chơi:** camp 0 là đồng minh với mọi phe trừ quái (camp 5), nên bot không đánh người chơi và người chơi cũng không đánh được bot.

## Phần 2: Chi tiết

### 2.1 Engine đọc Npcs.txt bản nào

| Phía | Đường dẫn engine đọc | Có trong PAK? | Bản có hiệu lực |
|---|---|---|---|
| Server | `\settings\phongthan\Npcs.txt` (`CoreUseNameDef.h:93`, `KCore.cpp:297`) | Không. `core_server_pak_diag.log` hôm nay ghi `found=0`; đã quét cả 23 PAK, kể cả `ptfix.pak` | File loose `Server\settings\phongthan\Npcs.txt` |
| Client | Cùng đường dẫn (KCore dùng chung) | Không. Đã quét 23 PAK của client | File loose `Client\settings\phongthan\Npcs.txt` |

PAK chỉ chứa bản cũ `\settings\npcs.txt` (vng00/serverlist/settings.pak), mà engine này không đọc bản đó. Vì vậy **không cần plug-in ptfix**. Hai file loose vẫn giống hệt nhau sau khi sửa (SHA-256 `05D92DEA…AA50F88`).

### 2.2 Template 2703–2720

Các dòng được nối vào cuối file ở mức byte:
- giữ 122 cột, CRLF, mã GBK;
- tên viết bằng TCVN3;
- phần đầu file giữ nguyên từng byte so với bản backup.

| Id | Thân | Tên template (dự phòng) | Giáp/Mũ | Vũ khí | Ngựa / cưỡi | Kỹ năng (id) |
|---|---|---|---|---|---|---|
| 2703–2705 | 男甲士 (Giáp Sĩ nam) | Thiết Hán, Cuồng Đao, Bá Vương | 3/4/5 | 25/27/29 | 3 đi bộ, 4 và 5 cưỡi | 29 Khai Sơn, 31 Điện Quang, 38 Liên Hoàn, 41 Thiên Quân |
| 2706–2708 | 女甲士 (Giáp Sĩ nữ) | Hồng Đao, Nữ Hiệp, Kim Phượng | 3/4/5 | 26/28/30 | như trên | như trên |
| 2709–2711 | 男术士 (Thuật Sĩ nam) | Đạo Trưởng, Lôi Pháp, Hỏa Vân | 3/4/5 | 5/7/9 | 3 đi bộ, 4 và 5 cưỡi | 5 Băng Tuyết Đạn, 6 Tích Lịch Hỏa, 15 Phong Vân Lôi Động, 18 Thập Phương Liệt Hỏa |
| 2712–2714 | 女术士 (Thuật Sĩ nữ) | Băng Nhi, Tiên Cô, Thủy Tiên | 3/4/5 | 6/8/10 | như trên | như trên |
| 2715–2717 | 男异人 (Dị Nhân nam) | Quỷ Kiến, Âm Phong, Huyết Chú | 3/4/5 | 5/7/9 | như trên | 44 Thôi Thân, 45 Bổ Tâm, 47 Phá Giáp, 49 Trảm Tâm Chú |
| 2718–2720 | 女异人 (Dị Nhân nữ) | Yêu Nữ, Linh Hồ, Dạ Lan | 3/4/5 | 6/8/10 | như trên | như trên |

Các bộ giáp, mũ, vũ khí và ngựa đều lấy từ những dòng VNG đang dùng cùng thân (靶场, 心魔…). Như vậy client chắc chắn có sẵn hình.

Các cột chung của 18 template:

| Nhóm cột | Giá trị |
|---|---|
| `Kind`, `Camp` | 0, 0 |
| Kỹ năng | `Level1..4` = `10\|0` (cấp kỹ năng 10) |
| AI | `AIMode` 1. `AIParam` = 40, 25, 25, 25, 25, 0, 0. `VisionRadius` 450, `ActiveRadius` 700, `AIMaxTime` 10 |
| Chỉ số theo cấp (`standard.lua`: giá trị = P1 + P2 × cấp) | Máu 800 + 120 × cấp. AR 150 + 6 × cấp. Né 60 + 3 × cấp. Thủ 30 + 3 × cấp. Sát thương 20 + 3 × cấp đến 40 + 5 × cấp. Kinh nghiệm 0 |
| Hồi sinh | `ReviveFrame` 540 (30 giây). Không có `DeathScript` |
| Hẹn giờ | `TimerScript` = `\script\phongthan\bots\bots.lua`, `TimerValue` 30 (bong bóng chat) |

Cấp của bot được truyền lúc `AddNpc`:
- ở thành: cấp 40–90;
- ở bãi quái: cấp quái + 8 đến 15;
- ở chỗ boss: bằng cấp boss.

### 2.3 Script `Server\script\phongthan\bots\bots.lua`

File được sinh ra từ `scratchpad\bots\gen_bots.py` cùng với `bots_template.lua`. File thuần ASCII; chuỗi TCVN3 viết dạng `\ddd`.

| Hàm | Việc làm |
|---|---|
| `PTBOT_Tick()` | servertimer gọi mỗi phút. Lần đầu chạy `PTBot_Init`. Sau đó, với từng bot: nếu bot mất thì spawn lại; nếu hết thời gian đứng một chỗ (8–20 phút) thì đổi chỗ (mỗi phút tối đa 4 bot). Bot sự kiện đổi chỗ ngay khi cửa sổ boss mở hoặc đóng. Cuối tick là chào người chơi và gửi chat thế giới |
| `PTBot_Init()` | Gọi `ReLoadScript` cho chính file này để `OnTimer` chạy được. Xoá các bot "mồ côi" còn sót khi state của servertimer bị nạp lại: duyệt 48 000 NPC, `GetNpcID ≠ 0` và template nằm trong 2703–2720 |
| `PTBot_Place(b)` | Chọn chỗ theo vai trò của bot, kiểm tra map đã nạp (`SubWorldID2Idx`), lệch ngẫu nhiên ±6 ô, rồi `AddNpc` (thử 9 điểm lệch có kiểm tra vật cản, cuối cùng đặt không kiểm tra). Sau đó `SetNpcName`, `SetNpcParam(1 = loại chỗ, 2 = số thứ tự bot)` và `SetNpcTimer` |
| `PTBot_BossWindow()` | Đọc `PTWB_LIST` (`boss\wb_data.lua`). Chọn boss có giờ ra nằm trong khoảng −10/+15 phút, ưu tiên boss cấp cao. Map của boss phải đã nạp |
| `PTBot_Greet()` | Với người chơi online đứng cách bot ≤ 20 ô (cùng map): bot nói "Chào <tên>!" hoặc một câu tương tự. Mỗi phút tối đa 3 câu; mỗi người chơi được chào lại sau ít nhất 10 phút |
| `PTBot_WorldChat()` | Cứ 2–5 phút gửi một dòng `Msg2SubWorld("<color=yellow>[Thế giới] Tên<color>: …")` |
| `OnTimer(npcIndex)` | Chạy trong state đã đăng ký. 45% khả năng nói một câu `NpcChat` hợp ngữ cảnh (thành / bãi quái / sự kiện), sau đó hẹn lần kế tiếp sau 25–75 giây |

Phân bổ 26 bot:
- 11 bot ở thành, 11 bot ở bãi quái, 4 bot sự kiện.
- Mỗi lần đổi chỗ, bot thành có 30% khả năng đi luyện công. Ngược lại, bot luyện công có 30% khả năng về thành.

Các biến cấu hình đầu file:
- `PTBOT_COUNT` = 26
- `PTBOT_MOVE_PER_TICK` = 4
- `PTBOT_STAY_MIN/MAX` = 8/20
- `PTBOT_WORLD_CHAT` = 1
- `PTBOT_GREET_CD` = 10
- `PTBOT_ARENA_DUEL` = nil

Tất cả hàm Lua dùng trong script đều có trong bảng đăng ký của `ScriptFuns.cpp`: `AddNpc`, `DelNpc`, `SetNpcName`, `GetNpcName`, `GetNpcID`, `GetNpcTemplateID`, `GetNpcPos`, `SetNpcParam`, `GetNpcParam`, `SetNpcTimer`, `SetNpcCamp`, `SetNpcCurCamp`, `NpcChat`, `Msg2SubWorld`, `SubWorldID2Idx`, `ReLoadScript`, `GetName`, `GetWorldPos`. Không dùng biến task nào.

### 2.4 Giới hạn của cách chỉ dùng Lua (không sửa C++)

| Giới hạn | Nguyên nhân trong engine | Cách xử lý |
|---|---|---|
| Không ra lệnh "đi bộ tới X" được | Lua không có walk-to. `SetNpcPos` dịch chuyển tức thời và không đổi điểm gốc AI | Đi lại tại chỗ dựa vào AIMode 1 (tuần tra quanh điểm gốc trong bán kính 700, đuổi quái trong tầm 450). Muốn đổi chỗ thì `DelNpc` rồi `AddNpc` nơi mới, nên người chơi sẽ thấy bot biến mất ở chỗ cũ và xuất hiện ở chỗ mới |
| Ngoại hình cố định theo template | Không có hàm Lua nào đổi giáp hay thân của NPC | 18 bộ ngoại hình xoay vòng cho 30 tên |
| Chat thế giới chỉ là dòng hệ thống | Client bỏ tên người gửi ở kênh −1 | Ghi tên bot vào đầu nội dung |
| Bấm vào bot thì thấy là NPC, không có bang hội, danh hiệu hay tổ đội | Bot là `kind_normal` | Không dùng `kind_player`: đường `AddBot` có hơn 100 chỗ truy cập `Player[0]` (xem `scratchpad\bots\bots_report.md`) |
| AIParam có thể "dính" từ NPC cũ | `KNpc::LoadDataFromTemplate` chỉ chép `m_AiParam` (gồm cả bán kính đánh) lần đầu tiên một ô NPC được dùng (`m_AiSkillRadiusLoadFlag`) | Khi đổi chỗ, `DelNpc` + `AddNpc` dùng lại đúng ô vừa trả (danh sách ô trống kiểu LIFO), nên bot thường giữ AIParam của bot. Nếu một bot nhận ô cũ của quái thì có thể đánh hơi khác, nhưng tự hết ở lần đổi chỗ sau |
| Quái do bot giết chạy death script mà không có người chơi | `m_nDeathScriptPlayerIdx = 0`. Engine đã chặn `DropRate` và `LastDamage` khi `nPlayer = 0` (`KNpc.cpp:1712-1718`) | Không rơi đồ, không cộng nhiệm vụ cho ai. Bot sẽ "giành quái" với người chơi như người thật |
| Bot ở khu boss có thể tranh đòn kết liễu boss | Bot đánh mọi kẻ địch trong tầm 450 | Bot sự kiện đứng cách chỗ boss 18–26 ô, ngoài tầm nhìn của boss. Bot chỉ vào đánh nếu boss đi lại gần |
| PK giữa bot | Bot camp 1 gặp bot camp 2 là địch, nhưng bot camp 1/2 cũng đánh người chơi thuộc camp khác 0 | Tắt mặc định (`PTBOT_ARENA_DUEL = nil`). Bật lên thì bot ở Phong Thần đài chia hai phe và đánh nhau |

## Phần 3: Hành động

### 3.1 Việc của người điều phối (agent bots không tự sửa các file dùng chung)

- [ ] Thêm hook vào `Server\script\servertimer.lua`, **đặt sau `PTAdm_WbTick()`** (bot cần `PTWB_LIST`):
  ```lua
  -- 2026-10-02 bot gia nguoi choi (20-30 NPC hinh nguoi choi o thanh, bai quai, khu boss/PK, chat).
  -- Logic trong script\phongthan\bots\bots.lua (template 2703-2720 trong settings\phongthan\Npcs.txt).
  function PTAdm_BotTick()
  	if not PTBOT_Tick then dofile("script\\phongthan\\bots\\bots.lua") end
  	if PTBOT_Tick then PTBOT_Tick() end
  end
  ```
  Sau đó gọi `PTAdm_BotTick()` trong `PTAdm_Tick()`, ngay sau dòng `PTAdm_WbTick()`. Tần suất: mỗi phút (theo nhịp servertimer).
- [ ] Ghi `CHANGELOG.md` và `docs\features\README.md`.

### 3.2 Người dùng kiểm tra trong game

1. [ ] **Khởi động lại server**, vì `Npcs.txt` chỉ được nạp lúc khởi động và `bots.lua` được đăng ký lúc quét script.
2. [ ] **Khởi động lại client** (thoát hẳn rồi mở lại), vì `Client\settings\phongthan\Npcs.txt` đã đổi.
3. [ ] Đợi 1–2 phút sau khi server lên. Về Sùng Thành doanh (1002) hoặc Tây Kỳ (1020): thấy vài bot mang tên người chơi, có thân, giáp, vũ khí, một số cưỡi ngựa, đi lại quanh khu NPC bán hàng.
4. [ ] Đứng gần bot khoảng 1 phút: bot chào "Chào <tên bạn>!" hoặc một câu tương tự; thỉnh thoảng có bong bóng chat trên đầu bot.
5. [ ] Trong khung hệ thống, cứ vài phút có một dòng "[Thế giới] <tên bot>: …".
6. [ ] Ra bãi quái, ví dụ Sùng Thành ngoài thành (1005), Mạnh Tân (1015) hoặc Hoang Mạc (1022): bot dùng kỹ năng phái đánh quái, quái hồi sinh thì bot đánh tiếp.
7. [ ] Bật chế độ chiến đấu rồi thử đánh bot: không đánh được. Bot cũng không đánh bạn.
8. [ ] Khoảng phút 50–59 mỗi giờ (Cửu Linh ra lúc :59 ở Tam Sơn 1016): thấy 4 bot đứng cách chỗ boss khoảng 20 ô.
9. [ ] Đứng nhìn một con bot 10–20 phút: nó biến mất và xuất hiện ở chỗ khác. Đây là cách đổi chỗ có chủ ý.
10. [ ] Nếu không thấy bot nào: mở `Server` log tìm `[AddNpc] invalid template` (nghĩa là server chưa nạp `Npcs.txt` mới), và kiểm tra hook servertimer đã được thêm chưa.

### 3.3 Hoàn tác

- Bản gốc nằm ở `E:\VL\Phong than\PT\_backup\20261002-bots\{Server,Client}\settings\phongthan\Npcs.txt`. Theo CLAUDE.md, **chỉ khôi phục khi người dùng đồng ý**.
- Cách tắt bot nhanh mà không phải khôi phục: bỏ dòng `PTAdm_BotTick()` khỏi servertimer, hoặc đặt `PTBOT_COUNT = 0` (lần tick sau sẽ xoá hết bot).

## Phần 4: Tài liệu tham khảo

- Nghiên cứu gốc: `scratchpad\bots\bots_report.md`.
- Bộ sinh dữ liệu: `scratchpad\bots\gen_bots.py` (`rows` | `lua`) và `scratchpad\bots\bots_template.lua`.
- Test simulator: `scratchpad\qtest\sim_bots.lua`, kết quả ở `out_bots.txt`. Kết quả:
  - 26/26 bot sống ở mọi tick;
  - 3 bot bị xoá từ bên ngoài được spawn lại ở tick sau;
  - bot mồ côi bị dọn; ô NPC đã trả với template cũ không bị `DelNpc` lần hai;
  - bot sự kiện chuyển tới Bàn Cổ (1051) lúc 17:55;
  - `PTBOT_COUNT = 20` thì 6 bot thừa bị xoá;
  - bật duel thì 3 bot ở 1001 nhận camp đấu;
  - không có lỗi runtime.
- Mã engine:
  - spawn: `ScriptFuns.cpp:4056` (`AddNpc`), `4095` (`DelNpc`), `4669` (`SetNpcTimer`), `9490` (`NpcChat`), `2477` (`Msg2SubWorld`);
  - hồi sinh: `KNpc.cpp:1817-1906`, `2309-2370`, `7995-8020`;
  - AI: `KNpcAI.cpp:1172-1427`;
  - phe: `KNpcSet.cpp:158-195`;
  - template: `KNpcTemplate.cpp`, `KNpc.cpp:265-360`, `7655-7786`.
- Liên quan: `boss\wb_data.lua` (lịch boss thế giới), `spawn\spawn_<map>.lua` (toạ độ bãi quái), `revivepos.ini` (toạ độ Phong Thần đài).

## Bổ sung 2026-10-02 (lần 2): bot đi theo người chơi
- **Yêu cầu:** đi đến đâu cũng có khoảng 30–50 bot chơi cùng.
- **Trước đây:** 26 bot rải cố định ở 5 thành và 20 bãi luyện công, nên người chơi hiếm khi gặp.
- **Nay (PTBOT_FOLLOW = 1):**
  - Có **40 bot** (PTBOT_COUNT). Danh sách tên tăng lên 46.
  - Mỗi phút, mỗi bot được gán cho một người chơi đang online. Bot nào cách mọi người chơi hơn 45 ô sẽ được đưa tới quanh người chơi đó, cách 6–28 ô, tối đa 50 bot mỗi phút. Vì vậy dịch chuyển sang bản đồ khác thì khoảng 1 phút sau bot sẽ có mặt.
  - Cấp của bot bằng cấp người chơi ±5, nên bot đánh được quái quanh đó (quái đã có kỹ năng thật).
  - Ở thành, bot nói câu kiểu "thành"; ở bãi quái, bot nói câu kiểu "luyện công".
  - Khi không ai online, bot quay về cách cũ (thành, bãi quái, boss).
- **Chỉnh nhanh** (đầu file ots.lua):
  - PTBOT_COUNT: tối đa 46;
  - PTBOT_NEAR;
  - PTBOT_RING_MIN / PTBOT_RING_MAX.
- **Lưu ý:** bản runtime script\phongthan\bots\bots.lua giờ là bản gốc. Đừng chạy lại gen_bots.py, vì nó sẽ ghi đè phần đi theo người chơi.
- Backup _backup\20261002-botfollow\. Mô phỏng: 40/40 bot sống ở mọi tick, chia đều quanh 2 người chơi.
- **Cần khởi động lại server.**

## Bổ sung 2026-10-02 (lần 3): bật bot theo địa điểm và số lượng từ web admin (agent `botadmin`)

### Tổng quan
- **Yêu cầu:** web admin có chức năng bật bot ở các địa điểm và số lượng tùy chọn.
- **Kết quả:** tab mới **"Bot giả người chơi"** trên web admin. Ở tab này có thể:
  - bật hoặc tắt toàn bộ bot;
  - đặt số **bot tự do**, và chọn cho chúng đi theo người chơi hay không;
  - lập danh sách **địa điểm** (bản đồ, X/Y, số bot, cấp).
- Cấu hình được lưu thành file nên **không mất khi khởi động lại server**.
- Server đọc lại file cấu hình mỗi phút. Ngoài ra nút **Áp dụng** gửi lệnh `PTBOT_AdminApply()` qua cầu nối để cân bằng bot ngay trong phút đó.

### Chi tiết
**1. File cấu hình `Server\admin_bridge\bots_config.lua`**
- Do web ghi, ASCII, ghi kiểu nguyên tử (file tạm rồi thay thế).
- Ví dụ nội dung:
  ```lua
  PTBOT_CFG = { enabled = 1, follow = 1, followCount = 40, spots = {
  	{ map = 1002, x = 0, y = 0, count = 10, level = 0 },
  	{ map = 1015, x = 1700, y = 3150, count = 15, level = 60 },
  } }
  ```
- Ý nghĩa các trường:
  - `enabled = 0`: xóa toàn bộ bot. Bot không tự tạo lại cho tới khi bật lại.
  - `followCount`: số **bot tự do**.
    - Khi `follow = 1` và có người online, bot tụ quanh người chơi như bản lần 2.
    - Khi `follow = 0` hoặc không ai online, bot dạo thành, bãi luyện cấp và Phong Thần đài như bản đầu.
  - `spots`: tối đa 20 địa điểm.
    - `x`, `y` tính bằng **ô**, cùng đơn vị với cột "Vị trí" ở tab Tổng quan.
    - `x`/`y` bằng 0 thì dùng điểm mặc định của bản đồ, theo thứ tự: bãi luyện trong `PTBOT_FIELDS`, khu thành `PTBOT_TOWNS`, Phong Thần đài `PTBOT_ARENAS`, cuối cùng là **giữa bản đồ**. Bảng `PTBOT_CENTRES` (79 bản đồ) được tính từ `rect=` trong `maps\*.wor`, mỗi vùng 512 × 1024 mps.
    - `level = 0` là cấp tự động:
      - bãi luyện: cấp quái + 8 đến 15;
      - thành: 40–90;
      - bản đồ khác: 30–80.
    - `level` > 0 thì bot có cấp bằng `level` ± 3.
- Không có file cấu hình thì server dùng mặc định: bật, 40 bot tự do đi theo người chơi, không có địa điểm. Như vậy hành vi giữ nguyên như bản lần 2.
- File bị lỗi cú pháp thì server giữ cấu hình đúng gần nhất. Trạng thái nguồn cấu hình là `error`, và không phát sinh lỗi mỗi phút.

**2. Bot theo địa điểm**
- Bot được tạo trong ô vuông ±10 ô quanh điểm đã chọn (`PTBOT_SPOT_R`). Sau đó engine (AIMode 1) cho bot tự đi lại và đánh quái quanh điểm đó.
- Bot đi xa hơn 45 ô (`PTBOT_NEAR`) sẽ được đưa về, tối đa 30 bot mỗi phút.
- Bot bị giết thì engine hồi sinh tại chỗ sau 30 giây. Bot biến mất (bị xóa) thì script tạo lại ở phút kế tiếp.
- Bản đồ chưa nạp thì địa điểm đó có 0 bot. Khi bản đồ được nạp, bot tự xuất hiện.
- Câu chat trên đầu bot theo loại địa điểm: thành dùng câu "thành", Phong Thần đài dùng câu "PK", còn lại dùng câu "luyện công".

**3. Giới hạn và tên bot**
- Tổng bot = bot tự do + tổng số bot ở các địa điểm, **tối đa 100** (`PTBOT_MAX_TOTAL`). Bot ở địa điểm được ưu tiên; phần vượt quá cắt vào bot tự do trước, rồi đến các địa điểm cuối danh sách.
- Danh sách có 46 tên.
  - Từ bot thứ 47 trở đi, tên được dùng lại kèm hậu tố số, ví dụ `Thiên Long2`, `Thiên Long3`. Hậu tố là chữ số ASCII nối sau tên TCVN3 nên tên vẫn hợp lệ.
  - Mẫu (template) của các bot này xoay vòng trong 2703–2720.
  - 46 bot đầu vẫn giữ mẫu như cũ.
- Khi đổi cấu hình, chỉ bot nào thay đổi vị trí hoặc tên mới bị tạo lại; bot giữ nguyên thì không bị động đến.

**4. File trạng thái `Server\admin_bridge\bots.txt`**
- Server ghi file này mỗi phút và ngay sau khi bấm Áp dụng.
- Định dạng (các cột cách nhau bằng tab):
  - dòng 1: thời điểm ghi;
  - `cfg enabled follow followCount nguồn(default/file/error) 100`;
  - `total sống mục_tiêu`;
  - `follow sống mục_tiêu số_người_chơi_đang_theo`;
  - mỗi địa điểm một dòng: `spot i map x y mục_tiêu sống cấp bản_đồ_đã_nạp`.

**5. Web admin**
- Hành động `bots` (`Set-Bots`):
  - kiểm tra bản đồ có trong `$Maps`;
  - kẹp số lượng 0–100, cấp 0–200, X/Y 0–65535;
  - tối đa 20 địa điểm;
  - ghi `bots_config.lua` và bản sao `AdminWeb\data\bots.json`;
  - xếp lệnh cầu nối `if not PTBOT_AdminApply then dofile("script\\phongthan\\bots\\bots.lua") end local n = PTBOT_AdminApply() PTAdm_Log(...)`.
- `GET /api/bots` trả về cấu hình cùng trạng thái.
- Tab tự làm mới mỗi 30 giây.

**6. Mã nguồn**
- Các hàm mới trong `bots.lua`:
  - `PTBot_ReadCfg`, `PTBot_Configure`, `PTBot_Sync`;
  - `PTBot_SpotPos`, `PTBot_SlotSpec`, `PTBot_PlaceSpot`, `PTBot_NearSpot`;
  - `PTBot_Balance`, `PTBot_WriteStatus`, `PTBOT_AdminApply`.
- `PTBOT_Tick` vẫn được servertimer gọi mỗi phút như cũ, nên **không phải sửa servertimer.lua**.
- Chat, chào người chơi, "thế giới" và OnTimer giữ nguyên.

**7. Kiểm thử bằng mô phỏng**
- `scratchpad\qtest\sim_botadmin.lua`: **30/30 kiểm tra đạt**, không có cờ lỗi. Nội dung đã kiểm tra:
  - nạp nóng từ bản cũ;
  - đọc cấu hình, địa điểm mặc định và giữa bản đồ;
  - kết hợp bot tự do với bot địa điểm;
  - bot đi xa hoặc bị xóa được đưa về hoặc tạo lại;
  - giới hạn 100 bot và hậu tố tên;
  - tắt chế độ đi theo;
  - file cấu hình lỗi, giá trị sai bị kẹp;
  - tắt toàn bộ, xóa file thì về mặc định;
  - file trạng thái.
- `sim_bots.lua` (kiểm thử cũ, không có file cấu hình) cho kết quả giống hệt từng dòng so với trước khi sửa.

### Hành động (người dùng kiểm tra)
- [ ] **Tự khởi động lại web admin** để nạp `PhongThan-Admin.ps1` mới, rồi mở tab "Bot giả người chơi".
- [ ] Bấm **Áp dụng** với một địa điểm, ví dụ Sùng Thành, X/Y để trống, 10 bot.
  - Trong 1 phút, lệnh ở tab Lịch sử báo "Thành công" kèm "bot dang song: N / tổng".
  - Ô trạng thái hiện số bot sống trên mục tiêu.
- [ ] Đến địa điểm đó trong game: thấy khoảng 10 bot quanh điểm. Giết một bot thì khoảng 30 giây sau bot hồi lại.
- [ ] Chọn nhân vật đang online rồi bấm **"+ Thêm tại vị trí này"**, sau đó bấm Áp dụng: bot xuất hiện quanh chỗ nhân vật đứng.
- [ ] Bấm **"Tắt hết bot"**: toàn bộ bot biến mất trong 1 phút. Bấm Áp dụng với ô "Bật" được tích thì bot trở lại.
- [ ] Khởi động lại server: cấu hình vẫn còn (đọc từ `bots_config.lua`).
- [ ] Về việc nạp `bots.lua` mới:
  - Servertimer chỉ `dofile` `bots.lua` một lần cho mỗi trạng thái script, nên **bản mới được nạp chắc chắn khi khởi động lại server**.
  - Nếu server đang chạy bản cũ, lệnh Áp dụng đầu tiên sẽ tự nạp `bots.lua` mới, vì bản cũ không có `PTBOT_AdminApply`.
- [ ] Hoàn tác:
  - chép `_backup\20261002-botadmin\bots.lua`, `PhongThan-Admin.ps1`, `index.html` về chỗ cũ;
  - xóa `Server\admin_bridge\bots_config.lua` để quay về cấu hình mặc định.

### Tài liệu tham khảo
- `Server\script\phongthan\bots\bots.lua`, `Server\script\servertimer.lua` (`PTAdm_BotTick`, đoạn chạy `pending.lua`)
- `AdminWeb\PhongThan-Admin.ps1` (`Get-Bots`, `Set-Bots`, hành động `bots`, `GET /api/bots`), `AdminWeb\index.html` (tab `bots`)
- Bản sao lưu: `_backup\20261002-botadmin\`

## Bổ sung 2026-10-03: bot "mất thân" và các ô trống khoanh đỏ (agent `botvisual`)

### Phần 1: Tổng quan
- **Yêu cầu:** ảnh chụp ở map 1004 cho thấy phần lớn bot chỉ còn tên và thanh máu đỏ, kèm nhiều ô màu nâu sẫm viền vàng không có chữ (thường hai ô xếp chồng). Người dùng yêu cầu sửa các chỗ khoanh đỏ.
- **Ô trống không phải bong bóng chat, cũng không phải bảng tên lỗi mã chữ.** Đó là **khung nền thanh máu** (`\spr\ui4\barback.spr`) của chính các NPC/bot, bị client vẽ lệch **160 px sang trái và 192 px lên trên** so với vạch máu đỏ. Lỗi nằm ở client, gặp với mọi NPC loại `kind_normal` hiện thanh máu, không riêng bot.
- **Thân bot vẫn được vẽ.** Log client ghi đủ các phần hình của cả 18 mẫu 2703–2720 và không có dòng `body=0` nào. Map 1004 là rừng trúc dày: bot đứng dưới tán trúc bị lá cây che, giống hệt người chơi thật đi vào rừng. Bot đứng chỗ trống thì hiện đầy đủ, ví dụ LăngTửGió (thú có cánh), ThầnSầm (bộ giáp vàng), KhóiSương (giáp tím).
- **Đã sửa:**
  1. Ô trống: một plug-in ptfix cho **client** chỉnh 1 byte trong header `barback.spr` để engine thôi dời khung.
  2. Tên và thanh máu "bay" cao trên đầu bot: hạ `Stature` của 18 mẫu bot từ 180 xuống đúng độ cao của người chơi (đi bộ 114, cưỡi ngựa 152).
  3. `bots.lua`: mọi câu chat đi qua `PTBot_Say`, không bao giờ gửi chuỗi rỗng, `nil` hay không phải chuỗi.

### Phần 2: Chi tiết

**2.1 Ô trống là gì (đã kiểm chứng)**

| Bằng chứng | Nội dung |
|---|---|
| Ai vẽ | `KScenePlaceC.cpp:131-197` `PaintPhongThanLifeBarOverlay`: vẽ `barback.spr` bằng `RUIMAGE_RENDER_FLAG_REF_SPOT`, sau đó tô vạch đỏ bằng `RU_T_SHADOW` ở đúng toạ độ. Chỉ hàm này dùng `barback.spr` |
| Vì sao lệch | `barback.spr` rộng 163 × cao 15, tâm (0, 0). `KRepresentShell2.cpp:343-356` (đoạn "to be modify"): sprite **rộng hơn 160** mà tâm bằng 0 bị coi là khung nhân vật 320 × 384 và bị trừ (160, 192). Vạch đỏ không đi qua nhánh này nên vẫn đúng chỗ |
| Đo trên ảnh | Ô ở (330–490, 378) ứng với vạch đỏ của SátThủ (494–647, 570). Ô ở (368–528, 489) ứng với MinhChâu (532–685, 681). Ô ở (724–885, 183) ứng với ThầnSầm (888–…, 375). Cả ba đều lệch đúng (+160, +192). Bot đứng gần mép trên màn hình có ô nằm ngoài màn hình, nên không thấy ô của chúng |
| Hai ô chồng nhau | Là hai NPC đứng gần nhau. Phóng to ảnh: vạch đỏ dưới tên không có khung bao quanh |
| Không phải chat | `NpcChat` hiện dạng chữ, không có khung, ví dụ "ThầnSầm: Ai có bình m… bán lại không?". Mọi câu trong `PTBOT_LINES`, `PTBOT_GREETS` và `PTBOT_WORLD_LINES` đều khác rỗng; `OnTimer` có dự phòng `PTBOT_LINES[1]` |

**2.2 Thân bot (đã kiểm chứng)**

- `Client\client_npc_render_diag.log` (phiên 03/10, map 1004), với các bot trong ảnh:

  | Bot | Mẫu | Trạng thái | Phần hình được vẽ |
  |---|---|---|---|
  | ThiênLong | 2705 | cưỡi ngựa | `jsm05_hd/bd_rs0`, vũ khí `jsm00_rw059_rs2`, ngựa `jsx06_hh/ht` |
  | KiếmThần | 2703 | đi bộ | `jsm03_hd/bd_st0` |
  | LongVương | 2711 | cưỡi ngựa | `ssm05_*` cùng ngựa `ssx06_*` |

- Đã đối chiếu từng đường dẫn `.spr` với 23 PAK của client. Đều có trong `spr.pak`, trừ hai nhóm cũng thiếu ở người chơi thật vì VNG không phát hành:
  - tóc nam (`jsm*_hr`, `ssm03/04_hr`, `yrm*_hr`);
  - vũ khí lúc đứng nghỉ của Thuật Sĩ (`ssm00/ssf00_rw000_st0`).
- `body=0` (không phần hình nào được vẽ) xuất hiện **0 lần** với template 2703–2720.
- Cắt phóng to ảnh tại chỗ chân của ThiênLong, SátThủ, TiểuYến: thấy một phần thân và ngựa lẫn dưới lá trúc.

**2.3 Thay đổi**

| File | Thay đổi |
|---|---|
| `Server\settings\phongthan\Npcs.txt` và `Client\settings\phongthan\Npcs.txt` (sửa ở mức byte, hai file giống hệt nhau, SHA-256 `038872FC…3EB0F61`) | Cột 94 `Stature` của 2703–2720: 180 → **114** (2703, 2706, 2709, 2712, 2715, 2718 đi bộ) và **152** (12 mẫu cưỡi ngựa). Đây là độ cao người chơi trong `KNpc::GetNpcPate` (114, cộng 38 khi cưỡi). Tên, thanh máu và bong bóng chat sẽ nằm sát đầu bot. Chỉ 18 dòng này đổi |
| `Server\script\phongthan\bots\bots.lua` (ASCII) | Thêm `PTBot_Say(ni, s)`. `PTBot_Greet` và `OnTimer` chat qua hàm này. `PTBot_Pick` trả `nil` khi đầu vào không phải bảng. `PTBot_WorldChat` bỏ qua câu rỗng. `OnTimer` chịu được `GetNpcParam` trả `nil` |
| `scratchpad\ptfix\extra_botvisual.py` (plug-in mới, chỉ chạy cho Client) | Lấy `\spr\ui4\barback.spr` bản đang có hiệu lực (`update0_122-163.pak`) và đổi `CenterY` 0 → 1 (byte thứ 10). Kích thước và điểm ảnh giữ nguyên. Client đọc PAK trước file rời (`g_SetPakFileMode(1)`), và `ptfix.pak` đứng đầu `package.ini`, nên bản này thắng |

**2.4 Sửa C++ đề xuất (không làm, chỉ ghi lại)**
- `Core\Src\Scene\KScenePlaceC.cpp`, hàm `PaintPhongThanLifeBarOverlay`: đổi `Background.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;` thành `Background.bRenderFlag = 0;`.
- Sau khi build lại CoreClient, plug-in `extra_botvisual.py` không còn cần nhưng giữ lại cũng vô hại.

**2.5 Kiểm thử**
- `sim_bots.lua` và `sim_botadmin.lua`: kết quả **giống hệt từng byte** so với trước khi sửa (`fc /b`).
- `sim_botvisual.lua` (mới): **13/13 đạt**. Các trường hợp đã thử:
  - `Say` với `nil`, chuỗi rỗng, số, NPC 0;
  - `OnTimer` khi tham số là `nil` hoặc 9;
  - bảng câu rỗng hoặc mất bảng;
  - chat thế giới với bảng rỗng.
- Hồi quy `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `t_st`: đều chạy xong, `status=0`.
- Build thử ptfix:
  - Client: plug-in báo `barback.spr 163x15 centre 0,0 -> 0,1`, chỉ byte 10 khác bản gốc;
  - Server: không có mục `barback.spr`.

### Phần 3: Hành động
- [ ] **Người điều phối:** build lại `ptfix.pak` cho **Client** bằng `build_ptfix.py Client` (đã có `extra_botvisual.py`) rồi triển khai vào `Client\data\ptfix.pak`.
- [ ] **Khởi động lại server**, vì `Npcs.txt` và `bots.lua` chỉ nạp lúc khởi động.
- [ ] **Thoát hẳn rồi mở lại client.** Client phải nạp `Npcs.txt` mới (Stature) và `ptfix.pak` mới (`barback.spr`).
- [ ] Vào map 1004 hoặc Sùng Thành:
  - không còn ô nâu trống trôi nổi;
  - mỗi vạch máu đỏ dưới tên bot và quái có khung nâu viền vàng bao quanh.
- [ ] Tên và thanh máu của bot nằm sát đầu, giống người chơi. Bot cưỡi ngựa có tên cao hơn bot đi bộ.
- [ ] Đứng ở bãi trống, chờ bot đi ra khỏi rừng trúc: thấy đủ thân, giáp, vũ khí, ngựa. Bot đứng dưới tán trúc dày vẫn bị lá che. Đây là cách map vẽ cây, người chơi thật cũng vậy.
- [ ] Hoàn tác (chỉ làm khi người dùng đồng ý):
  - chép `_backup\20261003-botvisual\{Server,Client}\settings\phongthan\Npcs.txt` và `Server\script\phongthan\bots\bots.lua` về chỗ cũ;
  - xoá `scratchpad\ptfix\extra_botvisual.py` rồi build lại ptfix Client.

### Phần 4: Tài liệu tham khảo
- `Core\Src\Scene\KScenePlaceC.cpp:131-330` (vẽ tên và thanh máu lớp cuối), `Represent\Represent2\KRepresentShell2.cpp:316-358` (dời theo tâm sprite).
- `Core\Src\KNpc.cpp:9780-9805` (`GetNpcPate`), `KNpcRes.cpp:645-770` (vẽ thân, log `body=`), `CoreDrawGameObj.cpp:24-125`.
- `Engine\Src\KPakFile.cpp:627-651`, `Core\Src\KCore.cpp:206` (client đọc PAK trước).
- Bảng hình: `\settings\npcres\人物类型.txt`, `术士未骑马关联表.txt`, `男术士右手武器.txt`.
- Công cụ: `scratchpad\botvisual\scanlog.py` (đối chiếu log render với PAK client), `cpak.py`, `cmpbar.py`, `stature.py`, `chkpak.py`. Test: `scratchpad\qtest\sim_botvisual.lua` → `out_botvisual.txt`.
- Bản sao lưu: `_backup\20261003-botvisual\`.