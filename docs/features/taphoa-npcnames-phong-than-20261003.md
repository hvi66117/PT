# Tạp Hóa Thương, Thợ Đồng, Thủ Khố mất bước nhiệm vụ tân thủ sau khi đổi tên NPC

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Agent: taphoa · Trạng thái: **Đã sửa gốc và áp nóng lúc 19:58.** Không cần khởi động lại server.

## Phần 1: Tổng quan

- **Báo lỗi:** người chơi báo "tạp hóa thương cũng mất nhiệm vụ", ngay sau lời báo tương tự về "thợ đồng". Cả hai ở chuỗi tân thủ mới (newbie2) tại Xi Vưu Mộ (1004) và Ngọc Hư Cung (1003).
- **Cơ chế của newbie2:** bước "đi gặp NPC X" không dùng hội thoại. Bước hoàn thành khi người chơi đứng cạnh NPC.
  - `PTNB2_ScanNpcs` quét bảng NPC và so `GetNpcName` với **tên GBK** trong `nb2_data.lua`, ví dụ 杂货商 (Tạp hóa Thương), 仓库管理员 (Thủ Khố), 铜匠 (Thợ Đồng).
  - Tên tiếng Việt (TCVN3) được đổi ngược về tên GBK qua bảng `PTNN_ALIAS` trong `lib\pt_npcalias.lua`.
- **Nguyên nhân gốc:**
  - Chiều 03/10, `mk_spawnnames.py` đổi 29 dòng `PTADM_NPC_SPAWN` sang tên TCVN3, gồm Thủ Khố, Thợ Đồng, Đại Phu, Tạp Hóa và Bào Thương.
  - `gen_npcnames.py` chỉ sinh alias cho các dòng mà chính nó đổi tên. Nó bỏ qua tên GBK có trong file của tính năng khác (danh sách `others`) và tên spawn.
  - Vì vậy Thủ Khố, Thợ Đồng và Đại Phu ở 1003/1004 mang tên TCVN3 nhưng **không có alias**. newbie2 không còn thấy hai NPC này.
- **Hậu quả trong game (đã tái hiện bằng mô phỏng):**
  - Xi Vưu, nhiệm vụ 1000 (Mao Lư): đứng cạnh Tạp hóa Thương thì F11 báo "qua gặp Thủ khố", rồi kẹt ở bước Thủ Khố (`STUCK at 1000:3`). Người chơi thấy như Tạp hóa Thương mất nhiệm vụ.
  - Xi Vưu, nhiệm vụ 1001: kẹt ở bước "tìm Thợ Đồng trả nhiệm vụ". Đây là lỗi "thợ đồng".
  - Ngọc Hư, nhiệm vụ 897: bước đôi "Tạp hóa Thương + Thủ Khố" kẹt (`STUCK at 897:2`). Nhiệm vụ 896 (Thợ Đồng) cũng không trả được.
  - Sùng Thành (1002) không bị: Tạp Hóa và Thủ Khố ở đây là NPC gốc của bản đồ, vẫn mang tên GBK.
- **Lỗi phụ:** đợt đổi tên lúc 19:13–19:15 để lại 14 NPC spawn bị trùng, đứng chồng lên nhau ở cùng một ô.
  - Danh sách: Tạp Hóa ×4, Bào Thương ×5, Khoa Phụ, Đa Bảo Đạo Nhân, Thần Nông, Nguyên Thủy Thiên Tôn, Đắc Kỷ lúc nhỏ.
  - Thứ tự xảy ra: tick `npcnames` đổi tên NPC spawn trước khi bảng spawn trong bộ nhớ được cập nhật. `PTAdm_EnsureNpcs` tưởng NPC đã mất nên đặt thêm bản mới.
- **Không phải nguyên nhân:**
  - Script của Tạp Hóa (`npc_fix\100x_tap_hoa.lua`) không so sánh tên NPC.
  - `PTAdm_FixNpcScripts` vẫn gắn đúng script nhờ nhãn f[3] TCVN3.
  - Các ext khác (tienma, congthanh, sudo_dongdi, vienco, daily2/3, vanluong…) chỉ chứa các tên GBK này bên trong đường dẫn script, không dùng để so tên.
  - Mã C++ không chứa tên này.

## Phần 2: Chi tiết

### 2.1 Chẩn đoán lúc chạy (admin bridge, 19:48)
- `taphoa_d1`: liệt kê NPC template 149/151/157/158 ở 1002/1003/1004/1020/1021.
  - Tạp Hóa ở 1003/1004/1020/1021 có hai bản ở cùng ô: 5375–5384 và 31615–31619.
  - Thủ Khố và Thợ Đồng ở 1003/1004 mang tên TCVN3.
- `taphoa_d2`, trong state servertimer:
  - Alias có Tạp Hóa nhưng **không có** Thủ Khố, Thợ Đồng và Đại Phu.
  - `PTNB2_POS[1003]` và `PTNB2_POS[1004]` thiếu 仓库管理员 và 铜匠.
- `taphoa_d3`: nhân vật KyUc1Thoi có task 2180 = 0, tức là chưa nhận chuỗi newbie2.

### 2.2 File đã sửa
| File | Thay đổi | Sao lưu |
|---|---|---|
| `scratchpad\npcnames\gen_npcnames.py` | Alias gồm các dòng do chính nó đổi tên, cộng **mọi nhãn TCVN3 của `PTADM_NPC_FIX`**. Bỏ dòng trùng; tên trùng mà GBK khác thì in cảnh báo. | `_backup\20261003-taphoa\scratchpad\npcnames\` |
| `scratchpad\npcnames\mk_spawnnames.py` | Chạy lại `gen_npcnames.py` ngay sau khi đổi tên spawn, để alias không bị thiếu lần nữa | như trên |
| `Server\script\phongthan\lib\pt_npcalias.lua` | Sinh lại: 61 tên, không trùng (trước là 67 dòng, nhiều dòng lặp, thiếu 6 tên). Thêm Thủ Khố, Thợ Đồng, Đại Phu, Hiên Viên, Xi Vưu (Đồ Đằng), Đắc Kỷ. | `_backup\20261003-taphoa\PhongThanRuntime-Staging\Server\script\phongthan\lib\` |
| `Server\script\phongthan\newbie2\nb2_lib.lua` | Sau `Include` alias, xóa cache vị trí NPC (`PTNB2_POS`, `PTNB2_POS_TM`, `PTNB2_SCAN_I`, `PTNB2_SCAN_T`). Mỗi lần nạp lại state, lần quét kế tiếp dùng alias mới, không giữ cache cũ 10 phút. Sửa ở mức byte, chỉ chèn ASCII. | `_backup\20261003-taphoa\PhongThanRuntime-Staging\Server\script\phongthan\newbie2\` |
| `Server\script\phongthan\ext\npcnames.lua` | Sinh lại, **giống hệt từng byte** với bản đang chạy | như trên (`ext\`) |

- Không sửa `servertimer.lua`.

### 2.3 Áp nóng (pending.lua lúc 19:58, `scratchpad\taphoa\hot_taphoa.lua`)
1. `dofile` lại `pt_npcalias.lua` vào state servertimer.
2. Xóa các NPC trùng. Điều kiện xóa:
   - cùng tên, template và bản đồ với một dòng `PTADM_NPC_SPAWN`;
   - cách vị trí spawn không quá 2 ô;
   - không phải chỉ số đang được theo dõi trong `PTADM_SPAWNED`.
3. `ReLoadScript("\\script\\phongthan\\newbie2\\quan_su.lua")` để state của Quân Sư (vòng quét 3 giây) nạp lại alias và xóa cache.
4. Xóa cache newbie2 trong state servertimer, quét lại toàn bộ và ghi log tên NPC tìm thấy ở 1003/1004.

Kết quả trong `admin_bridge\result.log`:
```
2026-10-03 19:58:01  taphoa_fix   OK  alias=61 thukho=y thodong=y daiphu=y reload_quan_su=nil dup_removed=14
2026-10-03 19:58:01  taphoa_dup   OK  5358(1002:1388) 5360(1003:1388) 5362(1004:1388) 5364(1020:1388) 5366(1021:1388) 5375(1020:158) 5379(1021:158) 5380(1004:175) 5382(1003:158) 5384(1004:158) 5385(1044:202) 5386(1064:1474) 5390(1062:206) 5391(1061:164)
2026-10-03 19:58:01  taphoa_scan  OK  1003: 医生 仓库管理员 云中子 生活技能老师（玉虚） 南极仙翁 铜匠 杂货商 燃灯道人 赤精子 慈航道人 | 1004: 生活技能老师（蚩尤墓） 仓库管理员 祝融图腾 少昊图腾 铜匠 风伯图腾 杂货商 医生 共工图腾
```
- Log ghi tên dạng `\ddd`. Khối trên đã đổi sang chữ Hán cho dễ đọc; mỗi tên đếm được 1 NPC.
- `reload_quan_su=nil` là bình thường: `ReLoadScript` không trả giá trị. `newbie2_error.log` và `tick_error.log` không có dòng mới.

### 2.4 Kiểm thử offline (`scratchpad\qtest`, 32-bit, LuaLibDll của server)
| Bộ | Kết quả |
|---|---|
| `sim_taphoa.lua oldalias`: `sim_newbie2` chạy với tên NPC hiện tại trong game và alias cũ | **FAILS=12**, kẹt ở `897:2` (Ngọc Hư) và `1000:3` (Xi Vưu). Tái hiện đúng lỗi. |
| `sim_taphoa.lua`: cùng kịch bản, alias mới | **FAILS=0**. Cả 3 phái chạy hết chuỗi, gồm 1000 → 1001 → 999… |
| `sim_newbie2.lua` (tên GBK gốc) | FAILS=0, giống từng dòng với bản trước khi sửa |
| `sim_nb2emu.lua 47,40` (giới hạn stack như engine) | FAILS=0, giống từng dòng với bản trước, không tràn stack |
| `sim_taphoa_hot.lua` (khối pending) | 7/7 ok: chỉ xóa bản trùng, giữ NPC đang theo dõi, giữ Tạp Thương của daily2 và NPC cùng tên ở xa |

## Phần 3: Hành động

- [x] Sửa generator, sinh lại alias, vá `nb2_lib.lua`, áp nóng, xóa 14 NPC trùng.
- [ ] Người chơi thử với nhân vật đang làm chuỗi newbie2 (task 2180 > 0):
  - Xi Vưu: đứng cạnh Tạp Hóa, rồi cạnh Thủ Khố (1576/3219). F11 phải chuyển sang "Tìm Thiếu Hạo trả nhiệm vụ".
  - Giết 8 Hỏa Diện, rồi đứng cạnh Thợ Đồng (1631/3246): nhiệm vụ 1001 hoàn thành.
  - Ngọc Hư: Tạp Hóa (1729/3221) và Thủ Khố (1739/3202) → 897; Thợ Đồng (1737/3237) → 896.
- [ ] Nếu bước vẫn chỉ hoàn thành khi đứng chờ khoảng 1 phút, thì vòng quét 3 giây của Quân Sư chưa nạp lại alias. Khi đó khởi động lại GameServer; các script loose sẽ được nạp lại khi khởi động. Agent không tự khởi động lại server.
- [ ] Lần sau đổi tên NPC spawn: chạy `mk_spawnnames.py`. Script nay tự chạy `gen_npcnames.py`. Sau đó áp nóng bằng `hot_spawnnames.lua`; file này đã `dofile` cả alias.
- Lưu ý ngoài phạm vi:
  - Tạp Hóa và Thủ Khố ở Sùng Thành (1002) vẫn là NPC gốc mang tên GBK, client hiển thị chữ lỗi. Newbie2 vẫn tìm thấy hai NPC này.
  - Muốn đổi tên hai NPC này thì phải thêm dòng `PTADM_NPC_FIX` (việc của coordinator).

## Phần 4: Tài liệu tham khảo

- `tan-thu-moi-phong-than-20261003.md`: newbie2 (`nb2_lib.lua`, `nb2_data.lua`, Quân Sư).
- `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`: các NPC Tạp Hóa, Thợ Đồng và Đại Phu được spawn (template 158/157/149).
- CHANGELOG 2026-10-03 19:20: đổi tên NPC (`gen_npcnames.py`, `mk_spawnnames.py`).
- Công cụ: `scratchpad\taphoa\` gồm `audit.py` (đối chiếu tên đã đổi với mọi chỗ dùng tên GBK), `mk_diag1.py`, `hot_taphoa.lua`, `queue_hot.py`, `gen_simtaphoa.py`. Mô phỏng: `scratchpad\qtest\sim_taphoa.lua`, `sim_taphoa_live.lua`, `sim_taphoa_hot.lua`.
