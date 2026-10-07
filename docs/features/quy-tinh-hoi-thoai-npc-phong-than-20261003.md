---
title: Quy Tinh đủ 6 Phong Ấn Tháp và dòng thoát cho hội thoại NPC (Phong Thần)
date: 2026-10-03
agent: questfix2
tóm tắt: Mô phỏng trọn chuỗi Quy Tinh (task 53) qua cả 6 Phong Ấn Tháp, 36 Thiên Cương Tinh và phần thưởng cuối. Sửa 2 lỗi chặn thật sự. Thứ nhất, Cương Tinh bị giết không bao giờ biến mất (template có DeathScript nên engine bỏ qua DeathSelf). Thứ hai, bộ đếm toàn server hay giao lại Cương Tinh người chơi đã thu, bắt họ về Dương Tiễn lấy phướn lại. Tọa độ (217,197) của Bắc Hải và Cự Lộc đều đúng theo dữ liệu VNG, nên không dời tháp nào. 41 script `npc_restore` có menu SayTask được thêm dòng "Kết thúc đối thoại". 5 NPC Con bạc, Chủ cầm đồ, Tiểu Bảo, Võ Cát, Tống Dị Nhân có thêm câu thoại riêng khi người chơi không có nhiệm vụ.
---

# Quy Tinh đủ 6 Phong Ấn Tháp và dòng thoát cho hội thoại NPC

## Phần 1: Tổng quan

### Insight chính
- **Quy Tinh trước đây chỉ chạy "trên giấy" ở tháp 1.** Khi mô phỏng đủ 36 bước, lộ ra 2 lỗi mà mô phỏng 1 tháp không thấy được:
  1. **Cương Tinh không bao giờ biến mất.**
     - Template 123 (Thiên Cương Tinh) và 124 (Thiên Cương Ma Tinh) trong `Npcs.txt` có `DeathScript = \script\npcdeath\normal.lua`.
     - Vì vậy `KNpc::DoDeath` đi nhánh death-script (`KNpc.cpp:1870`): chạy OnDeath của normal.lua, rồi hồi sinh NPC tại chỗ và `return`.
     - `DeathSelf` không bao giờ được gọi. Lệnh `DelNpc` mà `extra_questfix.py` hoãn sang DeathSelf vì thế không chạy.
     - Hậu quả: mỗi lần thả tháp lại thêm 1 Cương Tinh hồi sinh mãi trên map. Người khác có thể ăn công Cương Tinh của mình.
  2. **Bộ đếm toàn server giao lại Cương Tinh đã thu.**
     - Tháp chọn Cương Tinh theo `GetGlobalValue(73..78)`, dùng chung cho mọi người chơi.
     - Nếu ra đúng con mình đã thu (task 250..285 = 1), giết xong không nhận gì. Người chơi phải về Tây Kỳ gặp Dương Tiễn đổi phướn rồi quay lại.
     - Con thứ 6 của mỗi tháp có thể mất tới 5 chuyến đi về như vậy.
- **Tọa độ tháp giữ nguyên.**
  - Bắc Hải và Cự Lộc cùng ghi (217,197) không phải lỗi dịch: bản taskinfo tiếng Trung gốc (`serverlist.pak`, task 23) cũng ghi `北海的封印之塔(217,197)` và `巨鹿的封印之塔(217,197)`.
  - VNG không có file region NPC nào cho 6 map này. Bản đồ nhỏ cũng không ghi nhãn tháp.
  - Ô (1736,3152) đi được trên cả 2 map, và nối liền với cổng ra (Xi Vưu Mộ, Mục Dã ở Cự Lộc; vùng Đại phu ở Bắc Hải).
  - Không có dữ liệu VNG nào chỉ ra vị trí khác, nên dời tháp là đoán mò.
- **Hội thoại cụt nhiều hơn 5 NPC được báo.**
  - Quét toàn bộ `npc_restore\*.lua` và `npc_fix\*.lua` thấy **35 file `npc_restore`** có ít nhất một nhánh mở menu SayTask không có dòng nào. Mô phỏng ngẫu nhiên: 98–151/151 trạng thái ra hộp thoại cụt.
  - `npc_fix` không có file nào bị: các file này đều có dòng thoát, hoặc đã Include `pt_compat.lua`.

### Kết quả mô phỏng (`S\qtest\sim_questfix2.lua` → `out_questfix2.txt`): **TOTAL FAILS = 0**
| Kịch bản | Kết quả |
|---|---|
| 1 người chơi, 6 tháp × 6 Cương Tinh | 36/36 bước, 36 lần giết, 0 lần phải về Dương Tiễn |
| Server đông (người khác đẩy bộ đếm tháp giữa mỗi lần thả) | 36/36, 0 lần về lại |
| Phần thưởng cuối | Vũ khí theo hệ (0,0,31/32 cấp 6) + 500.000 kinh nghiệm. Dòng "Quy Tinh" ẩn sau bước 36 |
| Dọn Cương Tinh | 74/74 Cương Tinh đã chết bị xóa ở tick kế tiếp. Cương Tinh còn sống được giữ 29 phút, tới phút 30 thì bị xóa |
| Hội thoại NPC, so bản gốc với bản mới (151 trạng thái/file) | 41/41 file nạp được. 0 hộp thoại thiếu dòng thoát. Dòng nhiệm vụ giống hệt bản gốc. 0 lỗi mới |

## Phần 2: Chi tiết

### 2.1 Chuỗi Quy Tinh (task 53)
Cấu trúc task 53: byte 1 là trạng thái (0 → 1 có phướn 42 → 2 đã thả, giữ vật 43 → 3 có chân khí 44); byte 2 là số bước 0..35. Tháp thứ `floor(bước/6)+1`.

| Tháp | Map | Tọa độ (hiển thị) | GlobalValue | Task Cương Tinh |
|---|---|---|---|---|
| 1 | 1006 Bắc Hải | 217/197 | 73 | 250–255 |
| 2 | 1007 Yến Sơn | 201/209 | 74 | 256–261 |
| 3 | 1012 Miêu Cương | 196/198 | 75 | 262–267 |
| 4 | 1013 Cự Lộc | 217/197 | 76 | 268–273 |
| 5 | 1010 Thủ Dương Sơn | 136/198 | 77 | 274–279 |
| 6 | 1009 Tây Côn Lôn | 207/203 | 78 | 280–285 |

Đã kiểm tra cả 36 script Cương Tinh: id task = 250 + 6×(tháp−1) + j, nhóm tháp khớp. Cương Tinh thứ 6 của mỗi tháp là Ma Tinh (tpl 124, cấp 80). Cả 6 tọa độ đều đi được trên lưới Region_S và nằm cùng vùng liên thông với lối vào map (`S\questfix2\cells.py`, `conn.py`).

### 2.2 Sửa trong PAK: plug-in `S\ptfix\extra_questfix2.py`
Plug-in chạy **sau** `extra_questfix.py` (thứ tự tên: `questfix.py` < `questfix2.py`) và vá chồng lên bản đã có trong `ctx["entries"]`. Idempotent, marker `questfix2`.
1. **6 script tháp** (`\script\item\天罡星\封印之塔1..6.lua`): trước `SetGlobalValue(7x,j)`, bỏ qua các Cương Tinh người chơi đã giữ (`GetTask(250+6(t−1)+j)==1`), tối đa 6 lần. Logic VNG còn lại giữ nguyên.
2. **36 script Cương Tinh** (`\script\item\天罡星\天*星.lua`):
   - bọc thêm `LastDamage`: sau OnDeath, nếu VNG đã gọi `DelNpc`, thì đổi tên NPC thành `PTQ2_DEAD`;
   - không xóa NPC ngay trong lúc engine đang xử lý cái chết.

Build thử: `python S\ptfix\build_ptfix.py Server S\questfix2\ptfix_test.pak`. Kết quả: 448 mục; log ghi `questfix2: towers 6/6, stars 36/36`, `questfix: 5/5, 36/36, 6/6`.

### 2.3 Tick riêng: `script\phongthan\ext\questfix2.lua`
`PTEXT_questfix2_Tick()` được `PTAdm_ExtTick` gọi mỗi phút (đã có sẵn trong servertimer.lua, không cần sửa):
- **Dọn Cương Tinh:** quét NPC tpl 123/124 trên 6 map tháp. Xóa con mang tên `PTQ2_DEAD`, và con nào sống quá `PTQ2_STAR_TTL = 30` phút (người chơi bỏ đi; Dương Tiễn đổi phướn lại được). Template 123 ở map khác không bị đụng tới.
- **Dời tháp (để sẵn, mặc định không dùng):** `PTQ2_TOWER_POS = { {map, ôX, ôY} }`. Tick tìm tháp theo map + template 1002 rồi gọi `SetNpcPos`. Tháp vẫn giữ index và tên, nên `PTAdm_EnsureNpcs` không spawn lại. Hiện để trống. `SetNpcPos` (`KNpc::SetPos`) chưa được thử trên engine thật với quãng dời xa, nếu cần dời thì thử trên server trước.
- Không dùng biến task nào (dải 2080–2099 để trống).

### 2.4 Hội thoại cụt trong `npc_restore`
**Nguyên nhân:**
- Menu VNG chỉ chứa dòng nhiệm vụ, mặc định `show=0`.
- `LuaSayTaskCompat` (`PhongThanNpcDialogLua.inl`) chỉ đẩy các dòng đang hiện. Không có nhiệm vụ thì ra hộp thoại 0 lựa chọn.
- Các file này không Include `pt_compat.lua`, nên cũng không có hàm bọc tự thêm dòng thoát.

**Cách sửa (ở mức byte, file TCVN3, có backup):**
- Trong phần VNG (trước `pt_original_main = main`), đổi `SayTask(` thành `PTQ2_SayTask(`. Không đổi gì khác.
- Thêm vào cuối file một khối ASCII + escape TCVN3 gồm `PTQ2_EXIT`, `PTQ2_IDLE`, `PTQ2_FLAV`, `PTQ2_Close` và `PTQ2_SayTask`:
  - có dòng nhiệm vụ: giữ nguyên lời VNG và các dòng, thêm "Kết thúc đối thoại" nếu menu chưa có dòng thoát;
  - không có dòng nào: NPC có `PTQ2_FLAV` thì nói câu thoại riêng kèm 1 dòng thoát. NPC khác giữ lời chào VNG (StringResource) kèm dòng thoát.
- Kiểm chứng: bỏ phép đổi tên và khối thêm vào thì 41/41 file trùng byte với bản backup.

**Câu thoại riêng (TCVN3):**
| NPC | File | Câu thoại khi không có nhiệm vụ |
|---|---|---|
| Con bạc (Triều Ca) | 1021_04 | Hôm nay vận đen quá! Đừng đứng đó nhìn nữa, kẻo ta xui thêm. |
| Chủ tiệm cầm đồ | 1021_05 | Tiệm nhỏ làm ăn khó khăn, hôm nay chưa có món gì đáng bàn với khách quan. |
| Tiểu Bảo (Tây Kỳ) | 1020_14 | Thúc thúc vẫn đứng khóc trong vòng Bạch Khuyên. Đại hiệp có việc thì lúc khác ghé nhé! |
| Võ Cát | 1020_05 | Hu! Hu!... Bị nhốt trong vòng tròn này, ta chẳng còn lòng dạ nào mà nói chuyện. |
| Tống Dị Nhân | 1021_06 | Duyên phận chưa tới, ngươi hãy quay lại sau. |

**41 file đã vá:**
- **35 file có nhánh cụt:**
  - Sùng Thành: 1002_00, 02, 03, 04, 05, 06, 07, 08, 09, 10;
  - Ngọc Hư: 1003_02, 03;
  - Xi Vưu Mộ: 1004_00, 01, 02, 03, 04, 05, 07;
  - Mạnh Tân: 1015_02, 03;
  - Tây Kỳ: 1020_04, 05, 12, 13, 14;
  - Triều Ca: 1021_02, 03, 04, 05, 06, 07, 15, 16;
  - Trần Đường: 1065_00.
- **6 file chưa từng cụt**, vá cho đồng bộ: 1015_01, 1020_01, 1020_02, 1021_00, 1021_01, 1021_14.

### 2.5 Không hồi quy
- `sim_tta.lua`, `sim_tutuong_b.lua`: không khác dòng nào.
- `t_st.lua`: servertimer nạp được.
- `sim_questfix.lua`: TOTAL FAILS = 0. Chuỗi Minh Châu, Vi Lao, Yên Phúc vẫn tới đích. Các cờ `NO_EXIT_ROW` của Con bạc, Cầm đồ, Tiểu Bảo, Võ Cát, Tống Dị Nhân đã hết.
- `sim_questaudit.lua`: kết quả nhiệm vụ không đổi. Thêm nữa, 9 cờ `NO_EXIT_ROW` (gồm cả Nhậm đại ca/đại tẩu, Thầy tướng số bản `npc_restore`) đã hết.

## Phần 3: Hành động

### Việc của coordinator / người dùng
- [ ] Build ptfix có `extra_questfix2.py` rồi deploy qua web admin. Plug-in phải chạy sau `extra_questfix.py`; thứ tự tên file đã đảm bảo điều này.
- [ ] Khởi động lại GameServer. Script `npc_restore` và file ext chỉ được nạp lúc khởi động hoặc ở tick đầu tiên.
- [ ] Không cần sửa `servertimer.lua`: `PTADM_EXT_NAMES` đã có `"questfix2"`.

### Checklist thử trong game
- [ ] Nhân vật cấp 59+ gặp Dương Tiễn (Tây Kỳ 166/185) → Quy Tinh → nhận Bách Linh phướn.
- [ ] Đến Phong Ấn Tháp Bắc Hải (217/197), bấm vào tháp: 1 Cương Tinh xuất hiện cạnh người chơi.
- [ ] Giết Cương Tinh: có thông báo "đã đánh bại …", có Thiên Cương chân khí. **Xác chết biến mất trong vòng 1 phút**, không hồi sinh lại.
- [ ] Về Dương Tiễn trả chân khí, nhận phướn mới, lặp lại. Trong 6 lần ở cùng một tháp, không lần nào gặp lại Cương Tinh đã thu.
- [ ] Đi tiếp Yến Sơn (201/209), Miêu Cương (196/198), Cự Lộc (217/197), Thủ Dương Sơn (136/198), Tây Côn Lôn (207/203). Con thứ 6 mỗi tháp là Ma Tinh cấp 80.
- [ ] Bước 36: nhận vũ khí theo hệ và 500.000 kinh nghiệm. Dòng Quy Tinh ẩn đi.
- [ ] Thả Cương Tinh rồi bỏ đi: sau khoảng 30 phút Cương Tinh tự biến mất. Dương Tiễn đổi phướn lại được.
- [ ] Con bạc, Chủ cầm đồ, Tống Dị Nhân (Triều Ca), Tiểu Bảo, Võ Cát (Tây Kỳ) → "Chức năng VNG gốc" khi không có nhiệm vụ: hiện câu thoại riêng và dòng **Kết thúc đối thoại**.
- [ ] Một NPC Sùng Thành bất kỳ (ví dụ Tô Hộ) → "Chức năng VNG gốc": có dòng Kết thúc đối thoại.
- [ ] Con bạc ở cấp 43+ chưa làm Minh Châu: vẫn có dòng "Minh Châu", nằm trên dòng thoát.

## Phần 4: Tài liệu tham khảo
- **Công cụ** (`S\questfix2\`):
  - `stars.py`: tháp ↔ Cương Tinh ↔ id task, xuất bản sao PAK để mô phỏng;
  - `mm.py`: bản đồ nhỏ có lưới tọa độ;
  - `cells.py`, `conn.py`: lưới vật cản, vùng liên thông;
  - `scan_tower.py`, `scan_coord.py`: tìm trong toàn bộ PAK server và client;
  - `scan_dlg.py`: tìm menu cụt;
  - `fix_dlg.py`: vá byte, kèm backup;
  - `strres.py`: tra StringResource.
- **Nguồn engine:**
  - `KNpc.cpp:1700–1720` (LastDamage), `1870–1885` (nhánh DeathScript bỏ qua DeathSelf), `7719` (DeathScript lấy từ template);
  - `PhongThanNpcDialogLua.inl` (SayTask chỉ đẩy dòng đang hiện);
  - `ScriptFuns.cpp` (`LuaAddNpc` 6 tham số, `LuaSetNpcPos` nhận ô, `LuaGetNpcPos` trả về map + ô).
- **Dữ liệu VNG:**
  - `serverlist.pak` client: taskinfo tiếng Trung task 23, bảng tên NPC `<color=red>封印之塔<color>` → "Phong Ấn tháp", Npcs row 镇魂塔;
  - `maps\*24.jpg` + `.wor`.
- **Tài liệu liên quan:** `kiem-toan-nhiem-vu-phong-than-20261002.md` (questfix, mục "Còn lại" 1 và 2 đã xử lý ở đây).
