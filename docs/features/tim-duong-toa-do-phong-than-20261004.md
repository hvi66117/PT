# Tìm đường theo tọa độ (Alt+F) — Phong Thần local

> Yêu cầu 2026-10-04: "Client chưa cho phép nhập tọa độ để tìm quái."
> Agent: timduong. Trạng thái: C++ đã build 20:33 (CoreServer, CoreClient, GameClient), smoke test 32/0, **chưa triển khai**.

## Phần 1: Tổng quan

- **Hiện trạng trước khi sửa**: client đã có sẵn một ô nhập tọa độ của TamLTM (bấm vào dòng tọa độ trên bản đồ nhỏ, `UiMiniMap.cpp`), nhưng phần tự chạy (`KPlayerAI::MoveToRunPlayer`) chỉ là heuristic né vật cản theo hướng: gửi lệnh chạy mỗi khung hình, không có tìm đường thật. Gặp tường thì kẹt, gửi gói di chuyển dồn dập. `KNpcFindPath` của engine chỉ né cục bộ một bước (rẽ 8 hướng, bỏ cuộc sau 30 lần). Bản đồ lớn (`UiWorldMap`) không có danh sách quái để chạy tới.
- **Đã làm**: tính năng "Tìm đường theo tọa độ" giống VNG.
  - Alt+F mở ô nhập; ô được điền sẵn tọa độ của nhiệm vụ mới nhất trong khung theo dõi nhiệm vụ (Alt+N).
  - Bấm vào dòng tọa độ trên bản đồ nhỏ cũng mở đúng ô này, thay cho ô cũ của TamLTM.
  - Nhân vật tự chạy tới đích, tìm đường vòng qua vật cản trên **toàn bản đồ** bằng A* trên lưới vật cản thật của client (`Region_C.dat`).
  - Đi theo từng đoạn, nhịp gửi lệnh giống người chơi bấm chuột.
  - Hủy bằng chuột, Esc hoặc Alt+F lần nữa; báo khi tới nơi.
  - Tùy chọn bật tự đánh khi tới nơi.
- **Hệ tọa độ**: tọa độ hiển thị = tọa độ bản đồ nhỏ = tọa độ trong chữ F11:
  - x = Mps x / 256 (8 ô vật cản);
  - y = Mps y / 512 (16 ô vật cản).
  - Ví dụ "Thủ Dương Sơn giết Yểm Hỏa (168.192)" là Mps (43136, 98560), region (84, 96) của bản đồ 1010 (rect region 60..107 × 85..112).
- **Không đổi giao thức, không đổi server**. Mỗi bước đi dùng đúng hai lời gọi như khi bấm chuột xuống đất (`Npc.SendCommand(do_run)` + `SendClientCmdRun`), server kiểm tra như với cú bấm chuột.

## Phần 2: Chi tiết

### 2.1 Cách dùng

| Thao tác | Kết quả |
|---|---|
| **Alt+F** | Mở ô "Tìm đường - nhập tọa độ x/y". Ô được điền sẵn tọa độ `(x.y)`/`(x/y)` của nhiệm vụ chưa xong mới nhất trong khung Alt+N, nếu không có thì là chữ nhập lần trước. Gõ hoặc sửa, rồi bấm Enter. |
| Bấm vào dòng tọa độ dưới bản đồ nhỏ | Mở cùng ô trên. |
| Alt+F khi đang chạy | Hủy chuyến đi. |
| Esc khi đang chạy | Hủy chuyến đi. Esc chỉ mở menu hệ thống như cũ khi không có chuyến đi. |
| Bấm hoặc kéo chuột trong màn chơi | Hủy, người chơi điều khiển lại. |
| Bật Alt+A/S/D hoặc cắm cờ trên bản đồ nhỏ | Hủy, chuyển sang chế độ người chơi vừa chọn. |

**Cú pháp**:
- Dạng tọa độ được nhận: `168/192`, `168.192`, `168 192`, `168,192`, `(168.192)`, `168:192`, `168-192`.
- Chữ cái phía sau (tùy chọn) quyết định tự đánh khi tới nơi:

| Hậu tố | Ví dụ | Khi tới nơi |
|---|---|---|
| (không có) | `168/192` | Nếu lúc bắt đầu đang tự đánh thì bật lại đúng chế độ đó, nếu không thì đứng yên. |
| `a` | `168/192 a` | Bật Alt+A (chiêu tay trái). |
| `s` | `168/192 s` | Bật Alt+S (chiêu tay phải). |
| `d` | `168/192 d` | Bật Alt+D (đứng tại chỗ). |
| `-`, `0` hoặc `n` | `168/192 -` | Không bao giờ tự đánh. |

**Thông báo** (dòng trên cùng + kênh hệ thống, TCVN3):
- Khi bắt đầu: "Tìm đường tới (x/y)[, tới nơi tự đánh] - bấm chuột hoặc Esc để hủy."
- Khi tới nơi: "Đã tới nơi (x/y)."
- Khi hủy: "Đã hủy tìm đường."
- Khi không đi được: "Không tìm được đường tới (x/y)." / "Tọa độ (x/y) nằm ngoài bản đồ này." / "Tọa độ (x/y) nằm trong vật cản." / "Tọa độ không hợp lệ..."
- Khi dừng giữa đường: "Dừng tìm đường - đã đổi bản đồ / nhân vật bị trọng thương / đang mở hội thoại / đang giao dịch / bị kẹt, không đi tiếp được."

**Phím Alt**: Alt+F chưa được dùng ở đâu. `autoexec.lua` VNG gán Alt+A S D B X Q Z C L W T E và 0–9; các phím dự phòng trong `ShortcutKey.cpp` là N (questtrack), R (daosi), G (partypanel), P (agent hanhtrang/items, tự nhặt). Nếu sau này `autoexec.lua` gán Alt+F thì bản gán đó được ưu tiên.

### 2.2 Thuật toán tìm đường

1. **Dữ liệu bản đồ** (`PhongThanGoTo.inl` → `PTGO_PrepareMap`):
   - Thư mục bản đồ lấy từ `\settings\WorldSet.ini` `[List] <map id>`, giống `KScenePlaceC::OpenPlace`.
   - Khung region lấy từ `\Maps\<tên>.wor` `[MAIN] rect`. Nếu không đọc được thì lấy 24 region quanh nhân vật.
   - Mỗi region đọc **khi cần lần đầu**, cùng file với cảnh (`\Maps\<tên>\v_<ry>\<rx>_Region_C.dat`, đọc PAK trước, fallback `OBSTACLE.DAT` + `Trap.dat` như `KScenePlaceRegionC::Load`). Kết quả được lưu đệm theo bản đồ.
   - Mã ô:
     - kind 0 → trống;
     - hình tam giác (LT/RT/LB/RB) → nửa ô;
     - kind ≠ 0 dạng đầy → chặn;
     - ô có trap (lối ra bản đồ, sự kiện) → trap;
     - region không có file → chặn (server cũng từ chối di chuyển tới đó);
     - region có file nhưng không có phần vật cản → trống, như `LoadObstacle(NULL)` của engine.
2. **A\*** (`PhongThanGoToPath.h` → `PTGP_FindPath`):
   - 8 hướng trên ô 32 × 32 Mps, chi phí 10 (thẳng) / 14 (chéo), heuristic octile × 1,2.
   - Không cắt góc qua ô chặn.
   - Nửa ô ×3, trap ×30 (gần như không bao giờ đi qua lối ra bản đồ), ô sát tường +4 để đường đi không bám tường.
   - Đích rơi vào vật cản → lấy ô trống gần nhất trong bán kính 12 ô.
   - Giới hạn 900.000 ô mở rộng.
3. **Làm thẳng đường** (string pulling): từ mỗi điểm neo, chọn ô xa nhất của đường còn đi thẳng được. `PTGP_LineFree` duyệt mọi ô mà đoạn thẳng chạm vào (Amanatides–Woo); đi qua đúng góc ô thì xét cả hai ô bên. Đoạn thẳng được kiểm tra thêm 4 đường lệch ±2 Mps vì vị trí NPC là số chấm cố định, hơi lệch khỏi đường lý tưởng. Chỉ ô trống mới tính là đi thẳng được.
4. **Đi theo đường** (`PTGoTo_Tick`, gọi mỗi khung từ `KPlayerAI::Active`):
   - Quyết định tối đa 10 lần/giây.
   - Tới gần điểm rẽ (40 Mps) thì sang điểm sau. Mỗi lần quyết định thử đi tắt thẳng tới một trong 6 điểm rẽ kế tiếp.
   - Mỗi lệnh đi xa tối đa 640 Mps, để luôn nằm trong vùng client đã nạp.
   - Chỉ gửi lệnh khi đổi điểm rẽ, khi điểm cắt 640 Mps đã trôi xa 160 Mps, hoặc khi đứng yên quá 0,9 giây. Hai lệnh cách nhau ít nhất 400 ms và qua cổng `m_nSendMoveFrames` như cú bấm chuột.
   - Bị đẩy lệch khỏi đường (quái, engine tự né) thì tính lại đường, tối đa 1 lần/giây.
   - Không tiến được 24 Mps trong 3 giây thì tính lại đường; 4 lần liên tiếp thì dừng và báo kẹt.
   - Đang ra chiêu hoặc trúng đòn thì không tính là kẹt.
5. **Một người lái tại một thời điểm**:
   - Khi bắt đầu: tắt tự đánh (nhớ chế độ để bật lại), tắt auto cũ TamLTM (`m_bIsActive`), tắt chạy bản đồ nhỏ cũ (`m_bAutoRunMap/FlagMap`), bỏ mục tiêu theo sau.
   - Bản đồ nhỏ vẽ đường tới đích như ô tọa độ cũ (`g_ScenePlace.DirectFindPos`); đường này tắt khi dừng.

### 2.3 Số liệu đo (smoke test trên dữ liệu client thật)

| Bản đồ | Lưới ô | Chuyến ngẫu nhiên | Hợp lệ | TB / max thời gian | Ô mở rộng max |
|---|---|---|---|---|---|
| 1010 Thủ Dương Sơn | 768 × 896 | 300 | 300 | 2,4 / 18 ms | 91.234 |
| 1002 Sùng Thành doanh | 352 × 416 | 200 | 200 | 1,7 / 7 ms | 31.611 |
| 1005 Sùng Thành ngoại | 384 × 640 | 200 | 200 | 0,4 / 6 ms | 25.491 |

- Lấy tọa độ F11 làm đích: (168/192) từ (183/221) cho ra 11 điểm rẽ trong 24 ms, kể cả thời gian đọc 46/1344 region từ đĩa.
- Đích nằm trong vùng kín: trả "không có đường" sau khi duyệt hết vùng đang đứng.
- Phần vật cản của `Region_C.dat` (client) và `region_s.dat` (server, file rời) của Thủ Dương Sơn trùng nhau ở 710/711 region đối chiếu được.

### 2.4 File đã sửa / thêm

| File | Thay đổi | Dấu |
|---|---|---|
| `Core\Src\PhongThanGoToPath.h` (mới) | Thuật toán thuần (đọc tọa độ, tìm `(x.y)` trong chữ nhiệm vụ, giải mã region, lưới, A*, làm thẳng đường), không phụ thuộc engine | — |
| `Core\Src\PhongThanGoTo.inl` (mới) | Gắn vào engine: đọc bản đồ, tick, thông báo TCVN3, `PTGoTo_Operation` / `PTGoTo_Tick` / `PTGoTo_OnManualInput` | — |
| `Core\Src\KPlayerAI.cpp` | Gọi tick sau tick tự đánh; `#include "PhongThanGoTo.inl"` ở cuối, sau `PhongThanAutoFight.inl` | `timduong:H1`, `H5` |
| `Core\Src\KPlayer.cpp` | `ProcessMouse`: bấm chuột trong màn chơi thì hủy chuyến đi | `timduong:H2` |
| `Core\Src\CoreShell.cpp` | `PAIOperation` mã riêng `0x5054474F` ('PTGO') | `timduong:H3` |
| `GameClient\Ui\ShortcutKey.cpp` | Esc hủy chuyến đi (đặt trước autoexec); Alt+F (dự phòng nếu autoexec không gán) | `timduong:K1`, `K2` |
| `GameClient\Ui\UiCase\UiMiniMap.cpp` | `PTGoto_OpenInput()` + requester ẩn cho `KUiGetString`; bấm dòng tọa độ bản đồ nhỏ → ô mới (thay `OpenWindow(... 5, 9)` cũ) | `timduong` |
| `GameClient\Ui\UiCase\UiTaskTrace.h/.cpp` | `KUiTaskTrace::PTFindCoord` lấy tọa độ nhiệm vụ mới nhất để điền sẵn | `timduong` |

- Mọi đoạn chèn đều là ASCII, vá ở mức byte bằng anchor duy nhất.
- So với backup chỉ thêm dòng, trừ 2 dòng lời gọi ô tọa độ cũ trong `UiMiniMap.cpp`.
- Backup nằm ở `_backup\20261004-timduong\`.
- Mã `PAIOperation` của tính năng: 1 = chữ tọa độ, 2 = hủy, 3 = đang chạy?, 4 = đi tới (x, y) số.

## Phần 3: Hành động

### Checklist triển khai (người dùng tự làm, khi đã tắt game client)

- [ ] Chép `PhongThanSource\Sources\Core\Modern\Win32ClientRelease\CoreClient.dll` (20:33) vào `PhongThanRuntime-Staging\Client\`.
- [ ] Chép `PhongThanSource\Sources\GameClient\Modern\Win32Release\Game.exe` (20:33) vào `PhongThanRuntime-Staging\Client\`.
- [ ] **Không cần** CoreServer.dll: tính năng chỉ có ở client; bản CoreServer build 20:33 không có thay đổi của timduong. **Không cần** ptfix, **không cần** khởi động lại server.
- [ ] Hai file trên chứa luôn các thay đổi đang chờ của agent khác (botheal, hanhtrang, daosi, lbdaosi, autofight...), vì bản build lấy toàn bộ nguồn hiện tại.

### Kiểm thử trong game

1. Vào Thủ Dương Sơn, Alt+F, gõ `168/192`, Enter. Bản đồ nhỏ vẽ đường tới đích, nhân vật vòng qua vách núi, tới nơi báo "Đã tới nơi (168/192)."
2. Nhận nhiệm vụ có tọa độ, Alt+F: ô đã điền sẵn tọa độ đó.
3. Đang chạy: bấm chuột, Esc hoặc Alt+F → "Đã hủy tìm đường."
4. `168/192 a`: tới nơi tự bật Alt+A.
5. Bấm vào dòng tọa độ dưới bản đồ nhỏ → cùng ô nhập.

### Giới hạn đã biết

- Chỉ đi trong bản đồ hiện tại. Không tự qua cổng hay xa phu; ô trap bị tránh.
- Hai vùng của cùng một bản đồ chỉ nối với nhau bằng trap dịch chuyển: Thủ Dương Sơn có 464 vùng rời, vùng lớn nhất 174.248 ô, vùng thứ hai 73.162 ô. Khi đó tính năng báo "Không tìm được đường".
- Vật cản động (cửa, vật thể `AddObstacle` lúc chạy) không có trong dữ liệu region. Nếu bị chặn, cơ chế phát hiện kẹt sẽ tính lại đường hoặc dừng.
- Chuyến đầu tiên trên bản đồ rất lớn có thể khựng một nhịp ngắn khi đọc nhiều region; các lần sau dùng bộ đệm.
- **Chưa làm** danh sách "Quái trên bản đồ này". Client chỉ biết quái trong tầm nhìn; quái thật do script server sinh (`matdo`), nên cần thêm một kênh đồng bộ server → client. Có thể làm sau bằng Lua (`SyncTaskValue`/tin nhắn) + một khung UI.
- **Chưa làm** bấm thẳng vào chữ tọa độ trong F11. Thay vào đó Alt+F tự điền tọa độ của nhiệm vụ mới nhất, chỉ cần Alt+F rồi Enter.

## Phần 4: Tài liệu tham khảo

- Smoke test: `scratchpad\timduong\smoke\` (`build.cmd`, `path_test.cpp`, `extract_maps.py`, `out.txt` = 32 OK / 0 FAIL). Test biên dịch đúng `PhongThanGoToPath.h` đang ship, trên các file region thật mà `KPakFile` trả về (thứ tự PAK của `package.ini`, rồi file rời).
- Kiểm tra diff: `scratchpad\timduong\verify_diff.py`. Vá: `scratchpad\timduong\patch_hooks.py`. Chuỗi TCVN3: `scratchpad\timduong\gen_tcvn.py`.
- Liên quan: `tu-dong-danh` (PhongThanAutoFight.inl, Alt+A/S/D), `questtrack` (Alt+N), `dao-si-nhieu-chieu-phong-than-20261004.md` (Alt+R).

## Phần 5: Sửa lỗi 2026-10-05 — bấm dòng tọa độ trên bản đồ nhỏ không mở ô nhập

- **Hiện tượng**: Alt+F chạy bình thường, nhưng bấm vào dòng "160/189 tìm" dưới tên bản đồ (góc trên phải) thì không có gì xảy ra.
- **Nguyên nhân**: trong cả 4 file `Client\Ui\ui3\UiMiniMap{Small,Big,BigEX,Nopic}.ini`, mục `[ScenePos]` có `DummyWnd=1`. `KWndWindow::Init` biến giá trị này thành cờ `WND_S_SIZE_WITH_ALL_CHILD`. Khi có cờ đó, `KWndWindow::PtInWindow` không xét khung của chính nút mà chỉ xét các cửa sổ con. Nút chữ `KWndPureTextBtn` không có con nào, nên không bao giờ nhận chuột, và click rơi xuống bản đồ bên dưới. Ô nhập cũ của TamLTM cũng chưa từng mở được vì lý do này.
- **Cách sửa** (`UiMiniMap.cpp`, `KUiMiniMap::LoadScheme`, dấu `timduong:M1`):
  - Ngay sau `m_ScenePos.Init`, bỏ cờ `WND_S_SIZE_WITH_ALL_CHILD`. Cả khung 130 × 14 của dòng tọa độ (cả chữ "tìm") nhận click và gọi `PTGoto_OpenInput()`.
  - Đặt màu khi rê chuột (mặc định 0,255,255) và khi bấm, vì ini không có các màu này và chữ sẽ biến mất khi rê chuột.
  - Áp dụng cho mọi chế độ bản đồ nhỏ. Không phải sửa ini.
- **Kiểm thử**: smoke `scratchpad\timduong\fix2\smoke\` 4/0, dùng `PtInWindow` thật và dòng vá thật trên khung `[ScenePos]` của từng file ini (trước khi sửa 0/308 điểm nhận click, sau khi sửa 308/308). Build GameClient OK 20:52.
- **Triển khai**: chép `GameClient\Modern\Win32Release\Game.exe` (20:52) vào `PhongThanRuntime-Staging\Client` khi game đã tắt.
