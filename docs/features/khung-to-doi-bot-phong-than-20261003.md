---
tính năng: Khung danh sách tổ đội (tổ đội bot và tổ đội thật) bên phải màn hình, theo đúng layout VNG
ngày: 2026-10-03
agent: partypanel
trạng thái: đã sửa C++ và build xong CoreClient.dll + Game.exe (0 lỗi); smoke test offline đạt 27/27 (logic Core) và 40/40 (giao diện). Chưa triển khai, chưa kiểm thử trong game.
phạm vi: client (Game.exe, CoreClient.dll). Không đổi server, không đổi giao thức, không cần ptfix.
---

# Khung danh sách tổ đội bot (giống VNG)

## Phần 1: Tổng quan

### Insight chính
- **Lỗi người dùng báo ("tổ đội với bot chưa hiện danh sách") là do client chưa từng có khung danh sách tổ đội.**
  - Bot tổ đội là NPC gọi bằng `AddTotemNpc` (chủ là người chơi, AiMode 11). Chúng không vào hệ thống tổ đội thật, nên cửa sổ tổ đội (phím G, `KUiTeamManage`) trống.
  - Trong mã nguồn client cũng không có lớp nào vẽ danh sách đồng đội cạnh khung nhân vật. Chỉ có `KUiTeamManage`, một hộp thoại có nút Mời / Đuổi / Giao đội trưởng. Các nút này gửi lệnh tổ đội lên server, nên không thể "nhồi" bot giả vào đó.
- **Layout gốc của VNG vẫn còn trong PAK.** Đây là ini danh sách đồng đội của VNG, PAK id `d180f81d`, có trong `serverlist.pak` và `ui.pak`; tên tiếng Trung chưa giải được, tìm ra bằng cách quét nội dung.
  - Bản trong `serverlist.pak` là bản được dùng: rộng 240, `Left=550 Top=190`, `CalculateWay=2` (bám mép phải, ngay dưới bản đồ nhỏ).
  - Mỗi người một hàng cao 30 điểm. Hàng gồm tên chữ xanh lá, tên đội trưởng màu vàng `239,247,74`, huy hiệu nghề có số cấp, thanh máu nằm trong viền, và đầu lâu khi chết.
  - Sprite VNG đã kiểm tra là có trong PAK client:
    - `主界面\血条.spr` (thanh máu, 105×2), `主界面\血条边框.spr` (viền, 111×8);
    - `主界面\jiashi|daoshi|yiren.spr` (huy hiệu Giáp Sĩ / Thuật Sĩ / Dị Nhân, 40×18);
    - `头顶图标\话框\骷髅.spr` (đầu lâu), `组队\旗子红.spr` (cờ đội trưởng).
- **Cách đã làm: dùng lại layout và sprite VNG**, viết lớp vẽ mới `KUiPartyPanel` theo đúng các khóa ini đó. Không tự vẽ kiểu mới.
  - Khung đặt **bên phải, dưới bản đồ nhỏ**, đúng chỗ VNG đặt. Vì vậy không đè lên khung theo dõi nhiệm vụ ở bên trái (`KUiTaskTrace`, y=190).
- **Dữ liệu lấy hoàn toàn ở client.** Không đổi giao thức, không sửa server.
  - **Tổ đội thật:** lấy từ `g_Team[0]` (đội trưởng trước, rồi các thành viên). Máu, cấp và nghề lấy từ NPC nếu người đó đang trong tầm nhìn. Người ở xa hiện tên màu xám, không có thanh máu.
  - **Tổ đội bot:** client không biết chủ của NPC (`m_nOwnerIdx` chỉ có ở server). Bot được nhận theo ba điều kiện:
    - template 2703–2720;
    - tên bắt đầu bằng byte TCVN3 của "[Tổ đội] ";
    - đứng trong vòng 1280 điểm quanh người chơi. Server giữ bot trong khoảng 900 điểm và xóa bot khi xa quá 34 ô.
  - Người chơi đứng đầu danh sách với vai trò đội trưởng (tên vàng và cờ). Sau đó tối đa 7 bot, gần trước xa sau. Đang ở tổ đội thật thì không liệt kê bot, vì server đã cho bot rời đội.

### Nhận định quan trọng
- Phím **Alt+G** bật/tắt khung. Trạng thái lưu ở `UserData\UiCommon.ini`, mục `[PartyPanel] Show=0/1`, mặc định bật.
  - G là phím mở cửa sổ tổ đội của VNG.
  - Alt+G chưa được gán trong `autoexec.lua` (cả bản PAK lẫn bản rời) hay trong `ShortcutKey.cpp`.
  - Không trùng Alt+N (questtrack), Alt+A/S/D (autofight), Alt+T và Alt+E (bản autoexec rời).
- Dòng tiêu đề: **"Đồng đội bot: N (Alt+G)"** hoặc **"Tổ đội: N người (Alt+G)"**. Khi N = 0 thì không vẽ gì.
- Khung trong suốt với chuột: `PtInWindow` luôn trả 0, click xuống đất vẫn đi bình thường. Khung nằm ở lớp `WL_LOWEST`, mọi cửa sổ khác đè lên trên.
- An toàn khi NPC biến mất: mỗi 200 ms lấy lại danh sách bằng bản sao dữ liệu. Không giữ con trỏ hay chỉ số NPC giữa các lần lấy.

## Phần 2: Chi tiết

### 2.1 Luồng dữ liệu

```
KUiPartyPanel::Breathe (mỗi 200 ms, khi khung đang bật)
  → g_pCoreShell->PAIOperation('PTPP' = 0x50545050, &KPTPartyInfo, sizeof)   [cửa riêng, như autofight 'PTAF']
  → CoreClient: PTPartyPanel_Query (PhongThanPartyPanel.inl, chỉ build client)
       ├─ đang có tổ đội thật (m_cTeam.m_nFlag và g_Team[0].m_nCaptain > 0) → các hàng của tổ đội
       └─ không có → quét NpcSet: template 2703–2720 + tên "[Tổ đội] " + ≤1280 điểm → người chơi + tối đa 7 bot
  → KPTPartyInfo { nMode, nBots, nCount, aMember[8] { tên (đã bỏ tiền tố), cấp, % máu, nghề, cờ } }
KUiPartyPanel::PaintWindow → tiêu đề + mỗi hàng: huy hiệu/cấp hoặc đầu lâu, tên, cờ đội trưởng, viền + thanh máu
```

- Không thêm hàm vào interface `iCoreShell`, không đổi enum `GDI_`/`GPI_`. Danh sách import của `Game.exe` giống hệt bản questtrack (376/376).
- Chạy lệch phiên bản vẫn an toàn:
  - `Game.exe` mới với `CoreClient.dll` cũ: mã `PTPP` không được xử lý, dữ liệu trả về rỗng, khung không hiện.
  - `CoreClient.dll` mới với `Game.exe` cũ: không ai gọi đến mã này.

### 2.2 Hiển thị từng hàng (tọa độ theo ini VNG, gốc là góc khung)

| Phần | Vị trí / quy tắc |
|---|---|
| Tiêu đề | (83, 0), cỡ chữ 12, màu 255,249,148 |
| Hàng thứ i | Bắt đầu ở y = 16 + 30·i |
| Huy hiệu nghề + cấp | Ảnh ở (83, 12). Số cấp cỡ chữ 12 nằm trên phần màu của huy hiệu. Bot: nghề = (template − 2703) / 6. Người chơi: nghề nhân vật |
| Đầu lâu (chết) | (83, 15), thay cho huy hiệu. Tên màu xám 180, không có thanh máu |
| Tên | (123, 0), cỡ chữ 14, cắt theo `NameWidth` = 112 (khoảng 16 ký tự). Màu xanh 0,255,0; đội trưởng 239,247,74; ở xa 160,160,160 |
| Cờ đội trưởng | Cuối dòng tên (123 + 112 − 13, 1) |
| Viền máu / thanh máu | Viền ở (123, 18). Thanh máu ở (125, 21), rộng = 105 × %máu. Còn máu mà dưới 1% thì vẫn hiện 1% |

- **Thứ tự nạp layout:**
  1. `<scheme>\UiPartyPanel.ini` (file rời tùy chọn, ví dụ `Client\Ui\ui3\UiPartyPanel.ini`);
  2. nếu không có: ini VNG đọc thẳng theo PAK id `d180f81d`;
  3. nếu vẫn không có: cùng các số VNG viết sẵn trong mã.
  - Vì vậy **không cần ptfix**.
- **Màn hình rộng hơn 800:** khung dời sang phải thêm (rộng màn hình − 800), giống bản đồ nhỏ. Ví dụ 1024×768: x = 774, nội dung hiện từ x=857 đến x=1009.
- **Layout VNG cũ** trong `ui.pak` (rộng 124, tên ở x=12, không có khóa huy hiệu): nếu được dùng thì khung bỏ huy hiệu và đầu lâu, để không đè lên tên.
- **Khóa thêm của Phong Thần** (tùy chọn, mục `[Main]`): `MemberTop`, `MaxMember`, `CaptionLeft/Top/Font/Color`, `LevelFont`, `LevelColor`, `FarNameColor`, `DeadNameColor`, `LeaderImg`, `LeaderLeft/Top`.
- **Mã hóa:** tên lấy nguyên byte TCVN3 từ server. Chữ cố định viết bằng escape TCVN3, đường dẫn sprite viết bằng escape GBK. Các file nguồn mới chỉ chứa ASCII.
- Ảnh mô phỏng dựng từ sprite VNG thật theo danh sách lệnh vẽ của smoke test: `scratchpad\partypanel\png\mock_panel.png`.

### 2.3 File

| File | Thay đổi | Sao lưu |
|---|---|---|
| `Sources\Core\Src\PhongThanPartyPanel.h` | **Mới.** Struct dùng chung `KPTPartyInfo`/`KPTPartyMember`, mã `PTPP_GPI_QUERY` | (file mới) |
| `Sources\Core\Src\PhongThanPartyPanel.inl` | **Mới.** `PTPartyPanel_Query`, chỉ có trong bản build client | (file mới) |
| `Sources\Core\Src\CoreShell.cpp` | `PAIOperation`: chuyển mã `PTPP` sang `PTPartyPanel_Query` (H1). Cuối file: include inl (H2). Cả hai trong `#ifndef _SERVER` | `_backup\20261003-partypanel\src\Core\Src\` |
| `Sources\GameClient\Ui\UiCase\UiPartyPanel.h/.cpp` | **Mới.** Lớp `KUiPartyPanel` | (file mới) |
| `Sources\GameClient\Ui\UiShell.cpp` | Mở khung khi vào game, đóng khi rời game | `_backup\20261003-partypanel\src\GameClient\Ui\` |
| `Sources\GameClient\Ui\UiBase.cpp` | Nạp lại layout khi đổi giao diện | như trên |
| `Sources\GameClient\Ui\ShortcutKey.cpp` | Alt+G; thêm cửa sổ `partypanel` (số 23) cho `Open()` | như trên |
| `Sources\GameClient\PhongThanClient.dsp` | Thêm `UiPartyPanel.cpp/.h` | `_backup\20261003-partypanel\src\GameClient\` |

- Mọi file cũ đều được sửa ở mức byte (`scratchpad\partypanel\patch_src.py`; chạy lại nhiều lần không sao; có `--dry-run`).
- Bản diff: `scratchpad\partypanel\src.diff`.

### 2.4 Build và kiểm chứng offline

| Kiểm tra | Kết quả |
|---|---|
| `Build-Modern.ps1 -Targets CoreClient,GameClient` | **OK, 0 lỗi.** `OutputModern\Client\CoreClient.dll` (936.960 byte) và `Game.exe` (884.736 byte, build lại sau bản sửa layout cũ) |
| Ký hiệu | `PTPartyPanel_Query` có trong `CoreClient.map` (coreshell.obj) |
| Import của `Game.exe` | 376/376, giống hệt bản questtrack. CoreClient vẫn xuất 164 hàm như trước |
| `smoke\core_test.exe`: chạy **đúng file `PhongThanPartyPanel.inl`** trên bản giả lập `Npc[]`/`NpcSet`/`g_Team`/`Player` | **PASSED 27/27.** Đã thử: tham số sai; không có ai; 4 bot cùng 7 loại NPC gây nhiễu (hộ vệ không có tiền tố, sai template, kind player, khác bản đồ, ngoài region, tên chỉ có tiền tố, ở xa 2000 điểm); bot chết; còn 1 máu thì hiện 1%; giới hạn 7 bot gần nhất có sắp xếp; tên 32 byte không có ký tự kết thúc; máu tối đa bằng 0; tổ đội thật (đội trưởng ở xa, chính mình, thành viên trong tầm); có cờ tổ đội mà không có đội trưởng; đang tải bản đồ; 20.000 lần NPC xuất hiện/biến mất ngẫu nhiên |
| `smoke\ui_test.exe`: link **đúng `uipartypanel.obj`, `wndwindow.obj`, `uiimage.obj`** của bản build, renderer giả ghi lại lệnh vẽ | **PASSED 40/40.** Đã thử: layout VNG và vị trí bám phải ở 1024/800/640; click xuyên qua; không có CoreShell thì không vẽ; tiêu đề, tên, màu đội trưởng, cờ, đầu lâu, huy hiệu, 4 thanh máu (84/52/1/105 px); cắt tên dài; tổ đội thật có người ở xa; Alt+G kèm lưu `[PartyPanel] Show` và thông báo BẬT/TẮT; đổi giao diện vẫn giữ dữ liệu; layout cũ của ui.pak; dữ liệu rác (count 99); mở lại khi đang tắt |

## Phần 3: Hành động

### Coordinator
- [ ] Thoát hết client, chạy `_backup\20261003-coreclient\Deploy-ModernClient.ps1`. Hai file đổi là **`CoreClient.dll` và `Game.exe`**; Engine, LuaLibDll và Represent2 giữ nguyên.
- [ ] Không cần build hay triển khai server. Không cần dựng ptfix.
- [ ] Ghi CHANGELOG theo các dòng trong báo cáo.

### Người chơi kiểm thử trong game
- [ ] Ra bãi quái (ví dụ 1005) khi đang bật tổ đội bot. Trong khoảng 1 phút bot vào đội. Bên phải, dưới bản đồ nhỏ, phải hiện "Đồng đội bot: 4 (Alt+G)".
  - Dòng đầu là tên mình màu vàng, có cờ đỏ.
  - Bốn dòng sau là tên bot (không có "[Tổ đội]"), có huy hiệu nghề, số cấp và thanh máu đỏ.
- [ ] Để bot bị đánh: thanh máu của bot giảm. Bot chết thì hiện đầu lâu và tên xám.
- [ ] Về thành: bot biến mất, khung tự ẩn (không vẽ gì).
- [ ] Nhấn **Alt+G**: khung ẩn, kênh hệ thống báo "Khung tổ đội: TẮT". Thoát game, vào lại: vẫn ẩn. Nhấn Alt+G lần nữa: khung hiện lại, báo "BẬT".
- [ ] Click chuột trái xuống đất ngay trên vùng khung: nhân vật vẫn đi bình thường.
- [ ] Mở khung theo dõi nhiệm vụ (Alt+N) cùng lúc: hai khung ở hai bên, không đè nhau.
- [ ] (Nếu có người chơi thứ hai) Lập tổ đội thật: khung đổi thành "Tổ đội: N người". Đội trưởng có tên vàng và cờ. Người ở xa có tên xám, không có thanh máu.

### Rủi ro
- **Nhiều người chơi đứng sát nhau:** client không biết chủ của bot, nên bot "[Tổ đội]" của người khác trong vòng 1280 điểm cũng được tính. Danh sách lấy 7 con gần nhất.
  - Trên server local một người chơi thì không gặp.
  - Nếu cần chính xác tuyệt đối thì phải gửi chủ của NPC xuống client, tức là đổi giao thức hoặc thêm một gói từ script. Bản này cố ý chưa làm.
- **Chồng lấn bên phải:** khung chiếm khoảng y 190–446 (8 hàng) ở mép phải.
  - Chưa xem bằng mắt trong game xem có đè thanh công cụ hay thông báo nào ở mép phải không.
  - Nếu đè thì chép ini VNG ra `Client\Ui\ui3\UiPartyPanel.ini` và sửa `Left`/`Top`. Không phải build lại.
- **Huy hiệu và cấp:** vị trí số cấp trên huy hiệu là suy ra từ ini (`LevelLeft=83`, `LevelTop=14`), vì client không có mã gốc VNG để đối chiếu.
- **Bot chết khi chưa có bản vá C++ P3 của botparty:** xác bot nằm lại, khung vẫn hiện đầu lâu cho tới khi Lua xóa bot (tối đa khoảng 1 phút).
- **Quay lại bản cũ:** chạy lại deploy với `CoreClient.dll` và `Game.exe` cũ, hoặc trả 5 file từ `_backup\20261003-partypanel\src\`, xóa 4 file mới khỏi `.dsp` và build lại.

## Phần 4: Tài liệu tham khảo
- Mã nguồn:
  - `GameClient\Ui\UiCase\UiPartyPanel.cpp` (`ApplyLayout`, `PaintRow`, `Breathe`);
  - `Core\Src\PhongThanPartyPanel.inl` (`PTPP_QueryBots`, `PTPP_QueryTeam`);
  - `CoreShell.cpp` (`KCoreShell::PAIOperation`).
- Layout VNG đã trích ra:
  - `scratchpad\partypanel\hits\serverlist.pak_d180f81d.ini` (bản đang dùng);
  - `ui.pak_d180f81d.ini` (bản cũ);
  - `serverlist.pak_378cc105.ini` (bản skin "00").
  - Công cụ quét: `scratchpad\partypanel\scan_ini.py`, `chk_spr.py`.
- Smoke test: `scratchpad\partypanel\smoke\` (`core_test.cpp` + `bcore.cmd`, `ui_test.cpp` + `bui.cmd`, `gen_fake.py`). Kết quả ở `core_out.txt` và `ui_out.txt`.
- Tính năng liên quan:
  - `to-doi-bot-phong-than-20261003.md` (bot tổ đội, tiền tố `PTBP_TAG`);
  - `khung-theo-doi-nhiem-vu-phong-than-20261003.md` (khung mẫu bên trái);
  - `tu-dong-danh-phong-than-20261003.md` (mẫu cửa riêng `PAIOperation` 'PTAF').
