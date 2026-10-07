# Nhiệm vụ tân thủ thôn ở Sùng Thành doanh, Ngọc Hư cung, Xi Vưu Mộ (1002/1003/1004)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent: newbiefix · Trạng thái: **Đã sửa lỗi Thủ Khố, đã chạy lại toàn bộ mô phỏng**. Cần GameServer khởi động lại và người chơi thử trong game.

## Phần 1: Tổng quan

- **Báo lỗi:** nhiệm vụ tân thủ thôn chưa hoạt động ở Sùng Thành doanh (1002), Ngọc Hư cung (1003) và Xi Vưu Mộ (1004).
- **Nguyên nhân thật (đã sửa):** NPC **Thủ Khố** của cả 3 thành bị lệch chỉ số menu.
  - Ngày 2026-10-02 lúc 17:01, agent `thukho` chèn dòng "Mở rương chứa đồ" (`mo_ruong`) vào **đầu** bảng `tasks` trong `main()`.
  - Mã bên dưới vẫn bật menu theo chỉ số cũ (`tasks[1]`, `tasks[2]`, `tasks[3]`), nên mọi lựa chọn bị lệch đi một dòng.
  - Hậu quả:
    - "Hộp gấm" (task 20) ở 1002 không bao giờ hiện. Chuỗi Tô Hộ → Thủ Khố → Triệu Điền, Triệu Lôi tắc ở bước 1.
    - "Thu thập" (task 26 / 16 / 36) không hiện đúng lúc ở cả 3 thành.
    - "Sử dụng Thủ khố" hiện sai điều kiện.
- **Không phải lỗi hồi quy hôm nay:** `sim_main newbie:N` luôn kết thúc bằng `ITER_LIMIT progress=0`.
  - Chế độ `newbie` dùng biến tiến độ giả `9999` và chỉ chạy 120 vòng để quét hết nhiệm vụ tân thủ. Bản chạy ngày 29/09 cũng kết thúc như vậy.
  - Dấu hiệu lỗi thật nằm ở giá trị task cao nhất đạt được:
    - Trước khi sửa: task 20 chỉ lên 1 (đúng phải là 19). Task 26, 16, 36 không được nhận.
    - Sau khi sửa: task 20 = 19, task 26 = 10, task 16 = 9, task 36 = 8, giống bản chạy ngày 29/09.
- **`PTSD_JudgeRelation` là nil:** đây là lỗi của bộ mô phỏng, không phải lỗi engine.
  - `sim_main.lua` thay `Include` bằng một hàm rỗng, nên dòng Include thư viện `sudo_dongdi_lib.lua` ở cuối file bị bỏ qua.
  - Trong engine, `Include` (`PhongThanLuaInclude.inl`) nạp file vào đúng script state đó. Đường dẫn `\script\phongthan\ext\sudo_dongdi_lib.lua` là file loose dạng ASCII và có tồn tại.
  - Thư viện tự định nghĩa `PTSD_JudgeRelation`. Hàm này chỉ dùng API engine (`GetTeamSize`, `IsCaptain`, `GetTeamMember`, `IsMasterPRRelation`), không cần biến toàn cục của ext state.
  - Đã sửa `sim_main.lua`: chỉ bỏ qua `vng_tasknote` (đã nạp sẵn), các Include khác được nạp như engine. Sau khi sửa không còn cảnh báo nào.
- **Phần "server tắt / lỗi cũ" trong báo lỗi:**
  - Lần chạy cuối của server là 14:26–14:42.
  - Lúc đó Quân Sư (newbie2) gặp lỗi `stack overflow` khi Include `vng_tasknote_data.lua` (`admin_bridge\newbie2_error.log` lúc 14:34). Lỗi này đã được nb2fix sửa lúc 15:20.
  - Lỗi Thủ Khố có từ 02/10 và vẫn còn cho đến bản sửa này.

## Phần 2: Chi tiết

### 2.1 Sửa Thủ Khố (sửa ở mức byte, chuỗi TCVN3 giữ nguyên)
| File | Chỉ số đã dời (+1) trong `main()` |
|---|---|
| `Server\script\phongthan\npc_fix\1002_thu_kho.lua` | 7 chỗ: Sử dụng Thủ khố → `tasks[3]`, Thu thập → `tasks[2]`, Hộp gấm → `tasks[4]`, Long Phụng phù (đang comment) → `tasks[6]` |
| `Server\script\phongthan\npc_fix\1003_thu_kho.lua` | 5 chỗ: Sử dụng → `tasks[3]`, Thu thập → `tasks[2]`, Long Phụng (comment) → `tasks[5]` |
| `Server\script\phongthan\npc_fix\1004_thu_kho.lua` | 5 chỗ: giống 1003 |

- Mỗi file có thêm một dòng chú thích `-- npc_fix 2026-10-03 newbiefix: ...`. Dòng "Mở rương chứa đồ" vẫn giữ nguyên.
- Công cụ sửa: `scratchpad\newbiefix\fix_thukho.py`. Script nhận ra file đã sửa và không sửa lại lần nữa.
- Bản sao lưu: `_backup\20261003-newbiefix\script\phongthan\npc_fix\100{2,3,4}_thu_kho.lua`.
- Không động vào file nào agent daily3 vừa sửa (npc_restore, npc_quests\normal.lua, vng_tasknote*.lua, item).

### 2.2 Phân đoạn tìm nguyên nhân (bisect)
- So sánh `out_newbie_N` hiện tại với bản ngày 29/09 (`scratchpad\nb2fix\prev_out`). Chỉ có các bước Thủ Khố và chuỗi Hộp gấm bị mất. Các khác biệt còn lại là chữ ghi chú F11 mới (nb2fix, daily3), không ảnh hưởng tiến độ.
- Các file npc_fix sửa sau 29/09:
  - `dai_phu` / `tho_dong`: ngày 29/09.
  - `thu_kho` ×3 và `bao_thuong`: 02/10 17:01.
  - 3 NPC thử luyện của sudo_dongdi: 03/10 14:33.
  - `1020_thai_tue`, `1021_hoang_phi_ho`: 03/10 chiều.
- Chỉ `thu_kho` nằm trên đường đi của chuỗi bị tắc. Sửa chỉ số xong thì chuỗi chạy lại đầy đủ.
- Các thay đổi hôm nay không gây lỗi này: questfix2 (npc_restore), nb2fix (`vng_tasknote_data`), daily3 (dòng Include thêm vào cuối file, `PTNewTaskNote`), pt_compat, newbie2 tick, starter_gear.

### 2.3 Thực tế trong game ở 1002/1003/1004 (theo log của lần chạy 14:26)
- **NPC bản đồ:** theo `server_npc_load_diag.log`, cả 3 map nạp đủ NPC, không có NPC lỗi hay thiếu script hội thoại.
  - 1002: khai báo 772, nạp 772, lỗi 0, thiếu script 0.
  - 1003: khai báo 566, nạp 566, lỗi 0, thiếu script 0.
  - 1004: khai báo 561, nạp 561, lỗi 0, thiếu script 0.
- **Gắn script:** `PTADM_NPC_FIX` gắn lại mỗi phút 11 NPC tân thủ ở 1002, 7 ở 1003, 9 ở 1004, cùng Thủ Khố, Tạp Hóa, Đại Phu, Thợ Đồng, cổng dịch chuyển.
- **Quân Sư (newbie2):** `PTNB2_NPCS` tạo NPC ở 1002 (1632,3200), 1003 (1688,3120), 1004 (1560,3216).
  - Lúc 14:39, tick chạy qua bước gắn quái ("bound 7453 monsters"), tức là bước tạo NPC đã chạy.
  - Hội thoại lúc đó lỗi do stack overflow; nb2fix đã sửa.
- **Võ sư:** là bản PAK, được ptfix của sudo_dongdi vá. `sim_sudo_dongdi` đạt.
- **`script_registry_diag` "failed=69":** đã dựng lại offline (`scratchpad\newbiefix\regcheck.ps1`).
  - Cách làm: mỗi file loose được nạp trong một state `lua_open(100)`, đúng như `KSortScript.cpp` lúc khởi động.
  - Kết quả ứng với 69 file lỗi của engine:
    - 56 file `phongthan\spawn\spawn_10xx.lua`: file dữ liệu, cần biến `PT_SPAWN_DATA` của file gọi nó; đăng ký riêng lẻ thì lỗi nhưng không hại gì.
    - `spawn\monster_display_names.txt`: không phải Lua.
    - 9 file `skill\zhuansheng\*.lua` tên Unicode: `_findfirst` dạng ANSI không mở được.
    - 1 file trong `item\变身符\`, tên có ký tự hỏng.
    - Vài file VNG thiếu `require` hoặc header.
  - **Không có** file nào thuộc npc_fix, npc_restore, newbie, newbie2, ext hay lib bị lỗi đăng ký.
  - Lưu ý: bản kiểm tra offline báo thêm khoảng 200 file item GBK dùng `require`/`module` (`Able_Pet`, `COMMON`). Lỗi này do stub `require` của bộ kiểm tra, engine có `require` thật nên không bị.

### 2.4 Kiểm thử
| Bộ mô phỏng | Kết quả |
|---|---|
| `sim_main main:0/1/2` | DONE progress=81, cấp 85, **0 FLAG** (trước đó có 3 FLAG `PTSD_JudgeRelation`) |
| `sim_main newbie:0/1/2` | Kết thúc ITER_LIMIT như thiết kế. Task 20 = 19, 26 = 10, 16 = 9, 36 = 8, 0 FLAG |
| `sim_nbfemu newbie:0/1/2` (mới) | Như trên, nhưng mỗi lần vào hàm NPC (khoảng 34.300 lần) chỉ còn ≤47 khung stack như engine. Không có stack overflow; headroom nhỏ nhất 45 |
| `sim_nbf_tn` (mới) | Lần TaskNote đầu tiên nạp lười `vng_tasknote_data.lua` sâu trong hội thoại, headroom 47 / 39 / 30: đủ 394/394 bản ghi, không lỗi |
| `sim_questfix2`, `sim_newbie2`, `sim_nb2emu 47,40`, `sim_sudo_dongdi`, `sim_questaudit`, `sim_tta`, `sim_tutuong_b` | Giống hệt từng dòng so với trước khi sửa (FAILS = 0) |
| `t_st` | Giống, chỉ khác địa chỉ con trỏ trong log |

## Phần 3: Hành động

- [ ] Người dùng tự khởi động lại GameServer. Agent không khởi động hay tắt tiến trình nào.
  - Thủ Khố là script loose, được nạp lại khi server khởi động.
  - Nếu server đang chạy: gọi `ReLoadScript("\\script\\phongthan\\npc_fix\\100X_thu_kho.lua")` cho X = 2, 3, 4 qua bridge.
- [ ] Ở Sùng Thành doanh, thử bằng nhân vật mới:
  - Gặp Tô Hộ, nhận "Hộp gấm".
  - Gặp Thủ Khố: menu phải có dòng **"Hộp gấm"**.
  - Đi tiếp Triệu Điền, Triệu Lôi, quay về Thủ Khố, rồi về Tô Hộ.
- [ ] Ở cả 3 thành, nhân vật cấp ≥ 6 gặp Thủ Khố: menu phải có **"Thu thập"**, chọn được Đoản Kiếm hoặc Mảnh Giáp (1003: Ngọc Cốt, 1004: Hỏa Vũ…).
- [ ] Ở cả 3 thành, nhân vật mới (task 23/13/33 = 0) gặp Thủ Khố: phải có "Sử dụng Thủ khố" để nhận nhiệm vụ 5 mảnh vật liệu.
- [ ] Nói chuyện với Quân Sư ở 1002 (204,200), 1003 (211,195), 1004 (195,201). Kiểm tra `admin_bridge\newbie2_error.log` không còn dòng "stack overflow".

## Phần 4: Tài liệu tham khảo

- `bao-thuong-can-khon-tu-tuong-thu-kho-phong-than-20261002.md`: thay đổi gốc thêm dòng `mo_ruong`.
- `tan-thu-moi-phong-than-20261003.md`: newbie2 và mục nb2fix.
- `su-do-dong-di-phong-than-20261003.md`: `sudo_dongdi_lib.lua`.
- `kiem-thu-nhiem-vu-mo-phong-phong-than-20260929.md`: bộ mô phỏng chuỗi nhiệm vụ.
- Công cụ: `scratchpad\qtest\sim_main.lua` (đã sửa Include), `sim_nbfemu.lua`, `sim_nbf_tn.lua`, `scratchpad\newbiefix\fix_thukho.py`, `regcheck.ps1`, `regcat.py`.
