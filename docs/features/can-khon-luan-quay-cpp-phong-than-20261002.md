# Càn Khôn Luân: vòng quay phía server (C++) cho Thái Tuế Sư

## Phần 1: Tổng quan

- **Trước đây:** engine không có hàm `Roulette`. Script Thái Tuế Sư (`npc_fix\1020_thai_tue.lua`) rơi vào hàm dự phòng, gọi `Finished()` ngay nên người chơi nhận thưởng tức thì, không có cảm giác "quay".
- **Bây giờ (phương án B1, chỉ C++ server):**
  - `CoreServer.dll` có hàm Lua `Roulette(k[, "tên0|tên1|..."])` và `RouletteBusy()`.
  - Khi quay, server gửi dòng chữ giữa màn hình (TopMessage) với tên ô đang được chiếu sáng. Các ô đổi nhanh lúc đầu rồi chậm dần, khoảng 5–6 giây.
  - Vòng quay dừng đúng ô `k`, nghỉ 1 giây, rồi engine gọi `Finished()` của script để phát thưởng.
- **Không cần build lại client.** Hiệu ứng chỉ là chữ, không có hình bánh xe (giới hạn của B1).
- **An toàn:**
  - mỗi nhân vật chỉ có một vòng quay tại một thời điểm;
  - nếu vòng quay bị gián đoạn (thoát game, mất kết nối, chết, đổi bản đồ) thì xóa trạng thái và **không** phát thưởng.
- **Tương thích ngược:** script vẫn giữ hàm dự phòng. Server cũ (chưa có `Roulette`) vẫn phát thưởng ngay như trước.

## Phần 2: Chi tiết

### 2.1 Luồng xử lý mới

1. Người chơi chọn "Xoay Càn Khôn Luân" → `yes_2` → `MsgBox` → `yes_3`.
   - Nếu đang quay (`RouletteBusy()==1`), cả `yes_2` lẫn `yes_3` dừng lại, báo "Càn Khôn Luân đang quay, hãy chờ kết quả!" và không trừ lượt hay vật phẩm.
2. `rolling()` bốc `k`, ghi task 72/73/764 như bản gốc, rồi gọi `Roulette(k, PT_CKL_NAMES)`.
   - Nếu engine từ chối (trả về nil), script gọi `Finished()` ngay để người chơi không mất lượt.
3. `LuaRoulette` lấy script đang chạy từ `Npc[player].m_ActionScriptID`. `ExecuteScript` gán giá trị này trước mỗi lần gọi Lua, kể cả callback của dialog. Nếu bằng 0 thì dùng `m_dwTaskExcuteScriptId`. Sau đó hàm gọi `KPlayer::PhongThanRouletteStart`.
4. `KPlayer::Active()` (server, mỗi khung, 18 FPS) gọi `PhongThanRouletteActive()`:
   - **20 bước.** Mỗi bước tiến 1 ô, bước cuối rơi đúng ô `k`.
   - **Thời gian giữa hai bước:** `2 + step²/40` khung, tức khoảng 0,1 giây lúc đầu và 0,6 giây ở cuối, tổng khoảng 5,5 giây.
   - **Bước cuối:** hiện "Càn Khôn Luân dừng tại: <màu vàng>tên ô", nghỉ 18 khung (1 giây).
   - **Kết thúc:** xóa trạng thái **trước**, rồi mới gọi `ExecuteScript(id, "Finished", k)`. Nhờ vậy, khi `Finished` mở lượt quay lại (ô Ngũ Quỷ → `MsgBox(...,"rolling")`), lượt mới vẫn bắt đầu được.
5. **Hủy vòng quay (không thưởng):**

| Tình huống | Nơi phát hiện | Báo người chơi |
|---|---|---|
| Mất kết nối / thoát game / chuyển server | nhánh `m_nNetConnectIdx == -1 \|\| m_bExchangeServer` đầu `Active()` | Không (đã offline) |
| Nhân vật bị giải phóng hoặc tái sử dụng slot | `KPlayer::Release()` gọi `PhongThanRouletteClear()` | Không |
| Chết / đang hồi sinh / máu ≤ 0 | `PhongThanRouletteActive()` | "Càn Khôn Luân bị gián đoạn, lượt quay này không có phần thưởng." |
| Đổi bản đồ (subworld khác lúc bắt đầu) | `PhongThanRouletteActive()` | Như trên |

### 2.2 Tên 12 ô

- Script truyền chuỗi `PT_CKL_NAMES` (TCVN3) theo đúng thứ tự `Finished()` (task 72 = k): Ngũ Quỷ, Đại Hao, Bạch Hổ, Thiên Cẩu, Bách Việt, Tử Vi, Thiên Đức, Thái Âm, Thái Dương, Thái Tuế, Tiểu Hao, Dịch Mã.
- C++ tách chuỗi theo dấu `|`, tối đa 16 ô, mỗi tên tối đa 31 byte.
- Nếu không có tham số thứ hai, hoặc chuỗi có dưới 2 tên, C++ dùng 12 tên mặc định giống hệt (hằng TCVN3 dạng `\x..` trong `KPlayer.cpp`). Như vậy bản VNG `\script\彩票\太岁.lua` trong ptfix, vốn gọi `Roulette(k)` một tham số, cũng chạy được.

### 2.3 Thay đổi mã nguồn (tóm tắt diff chính xác)

Thư mục gốc: `E:\VL\Phong than\PT\PhongThanSource\Sources\Core\Src`. Các file đều là UTF-8 hợp lệ (không phải GBK). Kết thúc dòng gốc (LF, một số dòng CRLF) đã được giữ nguyên. Toàn bộ code mới là ASCII.

| File | Vị trí | Thay đổi |
|---|---|---|
| `KPlayer.h` | sau `BOOL m_PlayerDBLoad;` trong khối `#ifdef _SERVER` (dòng 140) | +17 dòng: `enum { PT_ROULETTE_MAX_SECTORS = 16, PT_ROULETTE_NAME_LEN = 32 }`, các biến `m_nRouletteK` (-1 = rảnh), `m_nRouletteCount`, `m_nRouletteStep`, `m_nRouletteSubWorld`, `m_dwRouletteNextFrame`, `m_dwRouletteScriptId`, `m_szRouletteNames[16][32]`; khai báo `PhongThanRouletteStart/Abort/Active/Clear/Send` |
| `KPlayer.cpp` | `Release()`, sau `m_ImagePlayer = 0;` (khối `_SERVER`) | +1 dòng `PhongThanRouletteClear();` |
| `KPlayer.cpp` | `Active()`, nhánh return sớm | `return;` → `{ PhongThanRouletteAbort("offline", FALSE); return; }` |
| `KPlayer.cpp` | `Active()`, sau `SendCurNormalSyncData();` | +1 dòng `PhongThanRouletteActive();` |
| `KPlayer.cpp` | ngay sau hàm `KPlayer::Active()` | +~170 dòng `#ifdef _SERVER`: `PT_ROULETTE_STEPS 20`, `PT_ROULETTE_FINAL_PAUSE GAME_FPS`, bảng tên mặc định TCVN3, 3 chuỗi thông báo TCVN3, thân 5 hàm. `PhongThanRouletteSend` dựng `KPhongThanScriptAction{PHONGTHAN_SCRIPT_SHOW, UI_TOPMESSAGE, ServerOwned=1}` → `DoScriptAction`, cùng đường với Lua `TopMessage` |
| `ScriptFuns.cpp` | trước `#ifndef _SERVER` / `LuaPlaySound` (ngay trên bảng `GameScriptFuns`) | +42 dòng `#ifdef _SERVER`: `LuaRoulette` (trả 1 khi bắt đầu, nil khi bận / thiếu script / thiếu player) và `LuaRouletteBusy` (1/0) |
| `ScriptFuns.cpp` | bảng `GameScriptFuns`, sau `{"ChatRoom_AddTime", ...}` (nhánh `_SERVER`) | +3 dòng: `{"Roulette", LuaRoulette}`, `{"RouletteBusy", LuaRouletteBusy}` |

Không đụng tới các bản sửa khác trong ngày (shop, `RepairAllEquip`, CRT handler trong `KCore.cpp`, `PhongThanUpdateSetAura`...). Diff so với bản sao lưu chỉ gồm các khối "insert" ở trên.

### 2.4 Thay đổi Lua

File: `PhongThanRuntime-Staging\Server\script\phongthan\npc_fix\1020_thai_tue.lua`. File chứa TCVN3/GBK nên được sửa ở mức byte bằng Python, giữ CRLF.

- Cập nhật chú thích đầu file.
- Thêm `PT_CKL_NAMES` (12 tên TCVN3).
- Hàm dự phòng `Roulette` thêm `return 1`, để `rolling()` không gọi `Finished()` hai lần.
- Thêm `PT_CKL_Busy()`.
- Dòng đầu `yes_2()` và `yes_3()`: `if PT_CKL_Busy() then return end`.
- `rolling()`: `Roulette(k)` → `if not Roulette(k, PT_CKL_NAMES) then Finished() end`.
- Phần phát thưởng trong `Finished()` giữ nguyên.

### 2.5 Kiểm chứng

- **Build:** `CoreServer` OK, 0 lỗi. Không có warning mới trong `KPlayer.cpp` / `ScriptFuns.cpp` (chỉ còn các warning có sẵn C5208/C4005).
  - Kết quả: `PhongThanSource\OutputModern\Server\CoreServer.dll` (10/2/2026 6:23 PM, 10.017.280 byte).
  - Trong DLL có chuỗi `Roulette`, `RouletteBusy` và các tên ô TCVN3.
- **Simulator** (`qtest\sim_ckl.lua`), tất cả đạt:
  - engine cũ: thưởng ngay, đúng 1 lần;
  - engine mới: không thưởng trước khi gọi `Finished`. Bấm lại khi đang quay bị chặn, không trừ lượt. Sau `Finished` nhận thưởng 1 lần;
  - engine từ chối: thưởng ngay 1 lần;
  - đếm được đủ 12 tên.

## Phần 3: Hành động (checklist test trong game)

Điều kiện: coordinator đã deploy `CoreServer.dll` mới khi server dừng, người dùng tự bật lại server.

- [ ] Nhân vật cấp ≥ 40 đến Thái Tuế Sư (map 1020) → "Xoay Càn Khôn Luân" → đồng ý. Kỳ vọng: dialog đóng, giữa màn hình hiện "Càn Khôn Luân đang quay: <tên ô>", đổi nhanh rồi chậm dần trong khoảng 5–6 giây.
- [ ] Vòng quay dừng ở "Càn Khôn Luân dừng tại: <tên ô màu vàng>". Khoảng 1 giây sau hiện Talk phát thưởng **đúng ô đó**, kèm EXP (cấp × 100).
- [ ] Trong lúc quay, bấm lại NPC → "Xoay Càn Khôn Luân". Kỳ vọng: thông báo "đang quay, hãy chờ kết quả", không trừ lượt hay Cây/Hình thế thân.
- [ ] Quay trúng Ngũ Quỷ → MsgBox "quay lại một lần" → đồng ý. Kỳ vọng: vòng quay mới chạy bình thường.
- [ ] Đang quay thì dùng Thổ Địa Phù hoặc đổi map. Kỳ vọng: "Càn Khôn Luân bị gián đoạn...", không có thưởng.
- [ ] Đang quay thì thoát game, đăng nhập lại. Kỳ vọng: không có thưởng, không lỗi, quay lại được.
- [ ] Kiểm tra log server có `[Roulette] start ...` / `finished ...` / `abort ... reason=...`.
- [ ] (Tùy chọn) Nếu TopMessage của client chồng nhiều dòng thay vì thay thế: báo lại để chuyển sang kênh hiển thị khác.

## Phần 4: Tài liệu tham khảo

- Chẩn đoán: `scratchpad\features3\features3_report.md`, mục 2.2 (B. Càn Khôn Luân), phương án B1.
- **Bản sao lưu:** `E:\VL\Phong than\PT\_backup\20261002-cankhon\`
  - `KPlayer.cpp`, `KPlayer.h`, `ScriptFuns.cpp`;
  - `1020_thai_tue.lua`.
- Simulator: `scratchpad\qtest\sim_ckl.lua` → `out_ckl.txt`.
- Liên quan:
  - đường hiển thị `LuaTopMessage` → `LuaSendPhongThanPlayerText(UI_TOPMESSAGE)` (`ScriptFuns.cpp`);
  - `KPlayer::DoScriptAction` (`PhongThanPlayerDialog.inl`).
- **Bước tiếp theo:**
  - Nếu muốn có hình bánh xe thật, xem phương án B2 (thanh tiến trình có sẵn + ini) hoặc B3 (UI client) trong báo cáo chẩn đoán.

---

# Bổ sung 2026-10-03 (cankhon2): Thái Tuế Sư không thấy, không quay được

## Phần 1: Tổng quan

Người dùng báo: "càn khôn luân chưa thấy và chưa quay được". Phân tích tĩnh (GameServer đang dừng) cho ra 3 nguyên nhân:

| # | Nguyên nhân | Bằng chứng |
|---|---|---|
| 1 | **NPC đứng ở chỗ không tới được, lại là tượng đá.** `servertimer.lua` (dòng 354) đặt template **1116** `太岁星君的石像` tại 1020 (49296, 97296). Template này dùng `passerby024`: hình tượng 1 khung, 1 hướng. Ô đó nằm sát tường nhà ở góc đông bắc Tây Kỳ | Lưới vật cản client (`maps.pak`, `Region_C`): ô gần nhất đi được cách 6,7 ô (khoảng 214 điểm). BFS từ điểm hồi sinh Tây Kỳ (44864, 97216) qua 32.348 ô đi được **không chạm tới** chỗ đứng. Người chơi bấm vào thì không đi tới được để mở hội thoại |
| 2 | **Không có ở Triều Ca**, cũng không đúng chỗ VNG | Bản đồ nhỏ gốc VNG (`maps\西岐24.jpg`, `朝歌24.jpg`) có nhãn **"Thái Tuế"** cạnh Cửa Nam Tây Kỳ và **"Càn Khôn Luân"** giữa quảng trường Triều Ca. Bản dựng lại chỉ có 1 tượng ở chỗ khác |
| 3 | **Dưới cấp 40 dòng "Xoay" bị ẩn mà không giải thích.** Lượt 2 trở đi thiếu vật phẩm thì báo sai tên (VNG đảo chữ Hình/Cây thế thân), không nói mua ở đâu | Nhân vật test `KyUc1Thoi` cấp 1 (`admin_bridge\online.txt`). `ui_action_diag.log` có hội thoại map 1020 với `options=4`, đúng bằng 3 dòng hiện + "Kết thúc đối thoại" khi dòng Xoay bị ẩn |

- Đường C++ `Roulette` không có lỗi. `CoreServer.dll` đang cài (10/3 14:44) có `Roulette`/`RouletteBusy`. Log cũ không có dấu vết `thai_tue`/`Roulette`, vì chưa từng quay thành công lần nào.
- **Cách sửa (chỉ Lua + 1 plug-in ptfix, không C++):**
  - NPC mới template **1130** `太岁星君的石像复苏` (`passerby034`: hình người 8 hướng, 40 khung, cao 220), tên TCVN3 **"Thái Tuế Sư (Càn Khôn Luân)"**, đặt ở **cả Tây Kỳ và Triều Ca**, đúng vị trí nhãn VNG;
  - hội thoại luôn hiện dòng Xoay và giải thích luật cấp 40;
  - thiếu vật phẩm thì chỉ chỗ mua (Kỳ Trân Các, F2, 1 xu) hoặc cho trả bạc thay thế;
  - giữ nguyên đường `Roulette` C++ và hàm dự phòng phát thưởng ngay.

## Phần 2: Chi tiết

### 2.1 Vị trí NPC mới (ext `cankhon2`, spawn mỗi phút, idempotent)

| Thành | Nhãn VNG trên bản đồ nhỏ | Điểm mps | Toạ độ hiển thị | Kiểm tra |
|---|---|---|---|---|
| Tây Kỳ (1020) | "Thái Tuế", cạnh Cửa Nam | 44464, 102256 | 173/199 | Ô trống, 5×5 ô xung quanh đều đi được, cùng vùng liên thông với điểm hồi sinh. Server không có `Region_S` ở vùng này nên không chặn `AddNpc` |
| Triều Ca (1021) | "Càn Khôn Luân", quảng trường giữa (sau tượng đá trên nền bản đồ) | 55216, 95984 | 215/187 | Ô mở gần tượng nhất nằm trong vùng liên thông 49.639 ô của phố Triều Ca. Điểm nhãn gốc (55360, 96128) bị tượng bao quanh, cách 4,2 ô |

- **File:** `Server\script\phongthan\ext\cankhon2.lua` (mới, ASCII). Tên NPC viết bằng escape TCVN3, dài 27 byte.
  - `PTEXT_cankhon2_Tick()`: tick đầu `ReLoadScript("\\script\\phongthan\\npc_fix\\1020_thai_tue.lua")`.
  - Mỗi tick kiểm tra NPC còn sống bằng chỉ số đã lưu + tên + map, mất thì `AddNpc(1130, 1, sw, x, y, 0)` (thử lệch 64 điểm nếu thất bại), rồi `SetNpcName` và `SetNpcScript`.
  - Ghi `PTAdm_Log("cankhon2", ...)` khi spawn.
- **Tượng cũ 1116** (servertimer dòng 354) vẫn còn và vẫn gắn script qua `PTADM_NPC_FIX` dòng 256. Coordinator nên **xóa dòng 354** để khỏi có 2 Thái Tuế ở Tây Kỳ (một cái không tới được). Dòng FIX 256 giữ hay xóa đều được.

### 2.2 Script `npc_fix\1020_thai_tue.lua` (sinh lại ở mức byte bằng `scratchpad\cankhon2\gen_thai_tue.py`, từ bản backup)

- **`main`:**
  - dòng "Xoay Càn Khôn luân" luôn hiện;
  - thêm dòng "Vật phẩm để xoay mua ở đâu?" (gọi `PT_CKL_HowTo`).
- **`yes_2` / `yes_3` / `PT_CKL_PayMoney`:** dưới cấp 40 thì báo "chỉ ứng với người từ cấp 40… Ngươi mới cấp N".
- **`yes_3`:** giữ đúng luật VNG.

| Lượt trong ngày | Chi phí |
|---|---|
| 1 | Miễn phí (ngày tính bằng `ceil(SystemTime/86400)`) |
| 2–3 | 1 Hình thế thân (8/135 hoặc 8/178) |
| 4–6 | 1 Cây thế thân (8/174 hoặc 8/179) |
| ≥ 7 | Bị chặn |

- **Thiếu vật phẩm:** `PT_CKL_NeedItem` mở `Say` với 3 lựa chọn:
  - "Trả 5 vạn lượng để xoay" (lượt 2–3) hoặc "Trả 10 vạn lượng để xoay" (lượt 4–6);
  - "Cách có <vật phẩm>";
  - "Để lúc khác".
  - Mức bạc lớn hơn phần thưởng bạc cao nhất (5 vạn), nên không thể dùng để kiếm lời.
- **`PT_CKL_PayMoney`:**
  - tính lại chi phí từ task 764, không lưu biến toàn cục dùng chung giữa người chơi;
  - kiểm tra `GetCash()`, rồi `Pay(cost)` phải trả về 1 mới quay;
  - nếu đã sang ngày mới thì chuyển sang lượt miễn phí.
- **Vật phẩm có thật:** `settings\ibshop\ibshopgoods.txt` hàng 136/173 (1 xu) và 175/176 (9/10 xu), nằm trong tab `potiongoods`. Nhấn F2 để mở Kỳ Trân Các.
- **`rolling()`:** thêm `if PT_CKL_Busy() then return end` ở đầu.
  - MsgBox Ngũ Quỷ gọi thẳng `rolling`. Nếu khi đó đang quay, `Roulette` trả nil, và trước đây hàm dự phòng sẽ phát thưởng ngay, tức thưởng 2 lần. Lỗ hổng này đã đóng.
- **Dự phòng:** `PT_CKL_FallbackRoulette` (gọi `Finished()`, trả 1) chỉ được gán cho `Roulette` khi engine không có hàm này. Engine từ chối (nil) thì vẫn phát thưởng ngay 1 lần.
- **Trace:** `admin_bridge\cankhon2_trace.log`, mỗi dòng gồm `ngày giờ, tên, sự kiện, map, n764, roulette=cpp|fallback`. Sự kiện gồm `free spin`, `pay item`, `pay item+`, `pay money N`, `spin k=`, `finished k=`.

### 2.3 ptfix: `scratchpad\ptfix\extra_cankhon2.py`

- Chỉ chạy phía Server. Thay `\script\彩票\太岁.lua` (id `828485f4`, bản VNG chỉ có trong PAK, không có hàm dự phòng) bằng stub `Include("\\script\\phongthan\\npc_fix\\1020_thai_tue.lua")`.
- Nếu sau này có NPC gắn đường dẫn VNG, NPC đó chạy bản đã sửa.
- Hiện không script loose nào tham chiếu `彩票`.
- **Build thử:**
  - Client: `scratchpad\cankhon2\ptfix_test_client.pak`, 40 entry;
  - Server: `scratchpad\cankhon2\ptfix_test.pak`, 499 entry, log `cankhon2: taisui.lua 828485f4 -> Include ...`.
  - Không ghi vào `AdminWeb\pending` hay `Server\data`.

### 2.4 Kiểm thử simulator (`scratchpad\qtest\sim_cankhon2.lua`)

| Lệnh | Kết quả |
|---|---|
| `run.ps1 -Main sim_cankhon2.lua -Stack 100` | `FAILS=0` (33 kiểm tra) |
| `run.ps1 -Main sim_cankhon2.lua -Stack 0 -Args1 EMU` (đệm stack về 47 frame cho entry NPC, 40 cho ext tick, như `sim_nb2emu.lua`) | `FAILS=0`, headroom thấp nhất 39, không tràn stack |
| `sim_ckl.lua` (test cũ) | Đạt (engine cũ / mới / từ chối, 12 tên ô) |
| Hồi quy `sim_questfix`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b`, `t_st` | `TOTAL FAILS = 0` |

- Các nhóm kiểm tra:
  - cấp 1;
  - lượt miễn phí qua C++ `Roulette`;
  - bấm lại khi đang quay;
  - `rolling` khi đang quay;
  - thiếu vật phẩm → `Say` 3 lựa chọn;
  - không đủ bạc / đủ bạc (trừ đúng 50.000 và 100.000);
  - trừ đúng 1 Hình hoặc Cây thế thân;
  - chặn lượt 7;
  - sang ngày mới;
  - Ngũ Quỷ;
  - engine cũ;
  - engine từ chối;
  - trace;
  - ext spawn 2 NPC (template 1130, 1020 + 1021), tick sau không spawn lại, NPC mất thì spawn lại, `ReLoadScript` đúng 1 lần.
- Script tool:
  - `scratchpad\cankhon2\gen_thai_tue.py`;
  - ảnh kiểm tra vị trí `mm_tayky_ann.png`, `tk_crop.png`, `tc_crop.png`.

## Phần 3: Hành động (checklist test trong game)

- [ ] **Coordinator:** xóa dòng `{ 1020, 1116, 1, 49296, 97296, ... }` (servertimer dòng 354), rồi chép `ptfix_test.pak` (bản Server build mới) khi server dừng. Người dùng tự bật lại server.
- [ ] Sau khoảng 1 phút: ở Tây Kỳ, đi tới Cửa Nam, toạ độ khoảng 173/199. Thấy NPC hình người tên "Thái Tuế Sư (Càn Khôn Luân)". Ở Triều Ca, quảng trường giữa cạnh tượng đá, toạ độ khoảng 215/187.
- [ ] Nhân vật dưới cấp 40: bấm "Xoay Càn Khôn luân". Kỳ vọng: thông báo luật cấp 40, không trừ gì.
- [ ] Nhân vật ≥ 40, lượt đầu trong ngày → đồng ý. Kỳ vọng: giữa màn hình chạy "Càn Khôn Luân đang quay: …" khoảng 5–6 giây, rồi phát thưởng đúng ô.
- [ ] Lượt 2 không có Hình thế thân. Kỳ vọng: hộp chọn "Trả 5 vạn lượng để xoay / Cách có Hình thế thân / Để lúc khác". Trả bạc thì bị trừ 50.000 rồi quay.
- [ ] Mua Hình thế thân ở Kỳ Trân Các (F2, 1 xu) → lượt 3 trừ 1 cái. Lượt 4–6 dùng Cây thế thân hoặc 10 vạn lượng. Lượt 7 bị chặn.
- [ ] Kiểm tra `admin_bridge\cankhon2_trace.log` có `roulette=cpp`, `spin k=`, `finished k=`.

## Phần 4: Tài liệu tham khảo

- **Backup:** `E:\VL\Phong than\PT\_backup\20261003-cankhon2\` gồm `1020_thai_tue.lua` (bản 10/02) và file tài liệu này trước khi bổ sung.
- **Hook servertimer:** đã có sẵn. `PTADM_EXT_NAMES` chứa `cankhon2`, nên `PTEXT_cankhon2_Tick()` trong `script\phongthan\ext\cankhon2.lua` chạy mỗi phút (protected).
- **Task:** chỉ dùng task VNG 72/73/75/764. Không dùng dải 2400–2409.
- **Ghi chú ngoài phạm vi:** Bào Thương Tây Kỳ (50576, 96784, servertimer dòng 338) cũng cách vùng đi được 8,1 ô theo lưới client, có thể cũng không tới được.


---

# Bổ sung 2026-10-04 (cankhon3): thưởng báo "nhận được" nhưng client không thấy

## Phần 1: Tổng quan

Người dùng báo: "Vật phẩm xoay Càn Khôn Luân thấy thông báo có, nhưng lại không thấy xuất hiện trên client."

- **Càn Khôn Luân không phát vật phẩm nào.** 12 ô chỉ cho kinh nghiệm, bạc, danh vọng hoặc trạng thái (buff). Vì vậy các giả thuyết về vật phẩm (túi đầy, rơi xuống đất, thiếu dòng dữ liệu ở client, id sai) không áp dụng. Client đang dùng đúng `ptfix.pak` bản Server v26 (MD5 trùng nhau).
- **Lỗi thật nằm ở các ô buff và ô danh vọng.** Thông báo vẫn hiện, nhưng hiệu quả không có hoặc sai, và client không hiện gì tương ứng:

| Ô | Thông báo | Thực tế trước khi sửa | Nguyên nhân |
|---|---|---|---|
| Tử Vi | Nhân đôi kinh nghiệm 1 giờ | Không tăng kinh nghiệm. Nhận một trạng thái "đánh dấu" id 175 **không bao giờ hết hạn** | `AddIBBuff(175)`: engine cast **kỹ năng** 175 (Thái Nguyên Đan). Ở cấp 1 kỹ năng này không có thuộc tính trạng thái, nên thời hạn = 0 (vĩnh viễn) |
| Thái Tuế | ×1,5 kinh nghiệm 2 giờ | Không tăng kinh nghiệm. Nhận trạng thái của kỹ năng 176 (Thái Ngư Đan, chạy nhanh) khoảng 1 giờ | `AddIBBuff(176)`, như trên |
| Đại Hao | Hồi sinh lực +10 trong 1 giờ | Không hồi. Id 12 là kỹ năng bị động "Tinh Thông Thổ Hệ" | `AddIBBuff(12)` |
| Bạch Hổ | Hồi nội lực +10 trong 1 giờ | Không hồi. Id 13 là chiêu đánh "Thiết Mã Băng Qua" | `AddIBBuff(13)` |
| Thiên Cẩu / Bách Việt | +15 / +10 danh vọng | Ô "Danh vọng" trong bảng nhân vật không đổi | `AddCredit` ghi vào ví ẩn `TASKVALUE_PT_CREDIT` (chỉ Xích Tùng Tử dùng). Bảng nhân vật (`UiStatus`, mục `StatusPage_Credit`) hiện `TASKVALUE_STATTASK_REPUTE` (task 210) |

- **Bằng chứng lúc chạy** (admin bridge, chỉ đọc, 15:41, nhân vật KyUc1Thoi sau 6 lượt quay 15:30–15:35):
  - `ib175=1/-1` (có, thời hạn vô hạn), `ib176=1/3235 giây`;
  - task 1906/1907 (buff kinh nghiệm thật) = 0, `GetNpcExpRate()=1`: chỉ có +1 % "dấu hiệu" của bình máu đang dùng, **không có** ×2 hay ×1,5;
  - `credit=10`, `repute=0`: 10 danh vọng của Bách Việt nằm ở ví ẩn.
- **Ý nghĩa VNG của `AddIBBuff(id)`:** id là **mã chi tiết của ibitem 8/id**. 8/12 Dao Linh tán (hồi sinh lực +10, 3600 giây), 8/13 Dao Tô tán (hồi nội lực +10, 3600 giây), 8/175 "Nhân đôi điểm kinh nghiệm" (thuộc tính 181 +100, 3600 giây), 8/176 "Nhân 1.5 điểm kinh nghiệm" (181 +50, 7200 giây). Đúng 4 phần thưởng mà Thái Tuế Sư thông báo.

## Phần 2: Chi tiết sửa (chỉ Lua, không C++, không ptfix)

File: `Server\script\phongthan\npc_fix\1020_thai_tue.lua`, sinh lại ở mức byte bằng `scratchpad\cankhon3\gen3.py` từ bản sao lưu (giữ TCVN3/GBK, CRLF).

- **Include thêm `\script\phongthan\ibitem\pt_ibitem_lib.lua`.** Đây là thư viện hiệu quả ibitem đang dùng cho Thiên Hương, Lâm Tiên Lộ, Thanh Lộ… `PT_CKL_Lib()` nạp lại lúc gọi nếu Include đầu file thất bại. Nếu vẫn không có thì không phát buff, ghi trace và không làm hỏng `Finished()`.
- **`PT_CKL_Reward(k)`** thay cho cụm `HaveIBBuff/RemoveIBBuff/AddIBBuff` của 4 ô:

| Ô | Hiệu quả mới | Cơ chế |
|---|---|---|
| Đại Hao | Hồi sinh lực +10 (thuộc tính 88), 3600 giây | `PTIB_GrantGen(PTIB_GenId("Dao Linh tán"))`, ô buff chung 1921–1938. Quay trúng lại thì cộng thêm giờ, không cộng dồn chỉ số |
| Bạch Hổ | Hồi nội lực +10 (thuộc tính 92), 3600 giây | Như trên, "Dao Tô tán" |
| Tử Vi | Kinh nghiệm +100 % (thuộc tính 181), 3600 giây | `PT_CKL_ExpBuff(3600, 100)` trên ô buff kinh nghiệm (task 1906–1908) |
| Thái Tuế | Kinh nghiệm +50 %, 7200 giây | `PT_CKL_ExpBuff(7200, 50)` |

- **Quy tắc `PT_CKL_ExpBuff`:** không bao giờ yếu hơn hay ngắn hơn lời hứa, và không lấy mất buff đang chạy.
  - Chưa có buff: đặt mới.
  - Buff đang chạy **mạnh bằng hoặc hơn**: giữ %, cộng thêm thời gian của phần thưởng.
  - Buff đang chạy **yếu hơn**: nâng lên % mới, hạn = muộn hơn giữa hạn cũ và (bây giờ + thời gian thưởng). Cờ ×2 kinh nghiệm kỹ năng được giữ.
- **Giữ và hết hạn:** `servertimer.lua` (`PTAdm_IbTick` → `PTIB_Tick`) áp lại mỗi phút khi engine tính lại chỉ số (mặc/tháo đồ, đăng nhập lại) và gỡ khi hết hạn, kèm thông báo "Hiệu quả … đã hết".
- **Danh vọng:** `PT_CKL_Repute(n)` gọi `AddRepute(n)` để ô "Danh vọng" trong bảng nhân vật tăng (task 210 tự đồng bộ xuống client) và vẫn gọi `AddCredit(n)` (ví VNG, đổi đồ ở Xích Tùng Tử). Sau đó báo "Bạn nhận được n điểm danh vọng, hiện có R."
- **Dọn trạng thái sai cũ:** đầu `Finished()` gọi `PT_CKL_PurgeOldIB()`, gỡ IB 12/13/175/176 nếu người chơi đang mang (trạng thái 175 vô hạn, 176 chạy nhanh). Việc này chỉ xảy ra khi chính người đó quay lần tiếp theo.
- **Hiển thị trên client:** engine không có thanh biểu tượng IB buff, nên:
  - khi nhận thưởng có thêm dòng "Hiệu quả kinh nghiệm +100%, thời hạn còn 60 phút." (hoặc hồi sinh lực / nội lực);
  - mục "Càn Khôn Luân" của NPC có trang thứ 3 "Hiệu quả đang có: …" (kinh nghiệm %, hồi sinh lực, hồi nội lực, thời gian còn lại, danh vọng hiện có).
- **Tên vật phẩm để xoay:** client hiển thị 8/135, 8/178 là **"Chỉ nhân"** và 8/174, 8/179 là **"Mộc nhân"**, không phải "Hình/Cây thế thân". Lời thoại nay ghi "Chỉ nhân (Hình thế thân)", "Mộc nhân (Cây thế thân)" để tìm được trong Kỳ Trân Các (F2). Các dòng này có trong `ibshopgoods.txt` của cả Server và Client (dòng 137, 174, 176, 177).

### Kiểm thử

| Lệnh (`scratchpad\qtest`) | Kết quả |
|---|---|
| `run.ps1 -Main sim_cankhon3.lua -Stack 100` | Phần 1 (toàn bộ `sim_cankhon2`, 33 kiểm tra) `FAILS=0`; phần 2 (18 kiểm tra mới) `FAILS=0` |
| `run.ps1 -Main sim_cankhon3.lua -Stack 0 -Args1 EMU` (đệm stack về 47 khung như engine) | `TOTAL FAILS=0`, headroom thấp nhất 38 |
| `run.ps1 -Main sim_ckl.lua -Stack 100` | Đạt: engine cũ / mới / từ chối, đủ 12 tên ô |

- Phần 2 kiểm tra:
  - Tử Vi đặt +100 % trong 3600 giây, `ModifyAttrib(181)` = 101 (100 + dấu hiệu 1);
  - gỡ IB 12/175/176 cũ, không còn gọi `AddIBBuff`;
  - Thái Tuế chồng lên ×2 đang chạy thì giữ 100 % và cộng 7200 giây; Thái Tuế đơn lẻ +50 % trong 7200 giây;
  - Tử Vi chồng lên 50 % dài hơn thì nâng % và giữ hạn; chồng lên 50 % ngắn thì đủ 3600 giây và giữ cờ kỹ năng ×2;
  - Đại Hao / Bạch Hổ vào ô chung gid 116 / 124 (+10 thuộc tính 88 / 92); trúng lại thì cộng giờ, không cộng dồn;
  - Thiên Cẩu / Bách Việt tăng cả danh vọng lẫn credit, thông báo đúng tổng;
  - trang "Hiệu quả đang có";
  - hết 1 giờ: `PTIB_Tick` gỡ sạch (thuộc tính về 0);
  - quay qua đường C++ trúng Tử Vi thì có buff ×2.

## Phần 3: Hành động

- [x] Sao lưu `_backup\20261004-cankhon3\` (`1020_thai_tue.lua`, tài liệu này, `CHANGELOG.md.before`).
- [x] Ghi file mới và áp nóng bằng `ReLoadScript` qua admin bridge. NPC được ext `cankhon2` gắn lại script mỗi phút. **Không cần build ptfix, không cần khởi động lại server hay client.**
- [ ] Kiểm thử trong game (nhân vật cấp ≥ 40, ngày mới hoặc còn lượt):
  - quay trúng Tử Vi hoặc Thái Tuế: có dòng "Hiệu quả kinh nghiệm +…%, thời hạn còn …", đánh quái thấy kinh nghiệm tăng tương ứng;
  - quay trúng Thiên Cẩu / Bách Việt: số "Danh vọng" trong bảng nhân vật (F3) tăng;
  - NPC → "Càn Khôn Luân" → trang 3 liệt kê hiệu quả đang có;
  - `admin_bridge\cankhon2_trace.log` có dòng `reward k=… left=…`.
- [ ] **Người dùng quyết định** có bù cho KyUc1Thoi hay không (xem Phần 4). Không tự bù.

## Phần 4: Tài liệu tham khảo

- **Thưởng KyUc1Thoi đã mất hôm nay** (theo `cankhon2_trace.log`):
  - 15:31:12 Tử Vi: không được ×2 kinh nghiệm 1 giờ (chỉ nhận trạng thái đánh dấu 175 vô hạn);
  - 15:34:56 Thái Tuế: không được ×1,5 kinh nghiệm 2 giờ (nhận trạng thái chạy nhanh 176 khoảng 1 giờ);
  - 15:31:51 Bách Việt: 10 danh vọng chỉ vào ví ẩn (credit = 10), bảng nhân vật vẫn 0;
  - 3 lần Thái Dương (bạc) và kinh nghiệm mỗi vòng (cấp × 100): đã nhận đủ.
- Trạng thái sai còn trên KyUc1Thoi: IB 175 (vô hạn) và IB 176 (hết khoảng 16:35). Tự gỡ ở lượt quay tiếp theo của nhân vật này. Muốn gỡ ngay thì cần một lệnh bridge `RemoveIBBuff(175)`, `RemoveIBBuff(176)` (chưa chạy, chờ người dùng đồng ý).
- **Ngoài phạm vi, cùng loại lỗi:** `script\活动脚本\武林大会大礼包.lua` cũng gọi `AddIBBuff(176)`, nên cũng phát nhầm "chạy nhanh". Nên rà tất cả `AddIBBuff(id)` có id trùng kỹ năng có trạng thái (đã ghi ở `tu-linh-thu-thach-huyen-vu-phong-than-20261002.md`, mục 2.7). Sửa tận gốc là ánh xạ `AddIBBuff` sang hiệu quả ibitem trong C++ (`ApplyNativeIBBuffState`). Tương tự, `AddCredit`/`GetCredit` nên dùng chung giá trị với ô "Danh vọng" (`StatusPage_Credit`).
- Mã nguồn tham chiếu:
  - `Core\Src\ScriptFuns.cpp`: `GetIBBuffDefaultSeconds`, `ApplyNativeIBBuffState`, `LuaAddIBBuffCompat` (khoảng 11990–12300);
  - `PhongThanDieuTriLua.inl:332` (`LuaAddCreditVng`);
  - `ScriptFuns.cpp:8713` (`LuaAddPlayerReputeValue`);
  - `GameClient\Ui\UiCase\UiStatus.cpp:221` (`StatusPage_Credit` = `nRepute`);
  - `CoreShell.cpp:2148` (`GDI_NPC_STATE_SKILL`).
- Script: `scratchpad\cankhon3\gen3.py`, `pk.py` (đọc PAK), `diag1.lua` (chẩn đoán chỉ đọc), `qtest\sim_cankhon3.lua` → `out_cankhon3*.txt`.
