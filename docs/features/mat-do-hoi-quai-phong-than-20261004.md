---
tinh-nang: Mật độ & hồi quái (chỉnh từ web admin)
ngay: 2026-10-04
agent: quaimatdo
trang-thai: Đã áp nóng lúc 16:49, đang chạy x2 + hồi 10 giây trên mọi bản đồ có quái. Tab web admin cần mở lại web admin.
file-chinh: script\phongthan\ext\matdo.lua, admin_bridge\matdo_config.lua, AdminWeb\PhongThan-Admin.ps1, AdminWeb\index.html
---

# Mật độ & hồi quái — Phong Thần

> **Cập nhật 2026-10-04 (engine2):** `matdo.lua` tự đọc giới hạn NPC từ engine (`GetNpcCount() + GetFreeNpcCount() + 1`), trần = giới hạn − 4.000. CoreServer hiện tại: 48.000 / 44.000 như dưới đây (đã nạp nóng 20:36). Sau khi triển khai CoreServer engine2: 96.000 / 92.000, quái thêm dùng vùng chỉ số cao 48.000–95.999 (`SetNpcAllocZone`), x2 đủ cho cả 57 bản đồ. Xem `engine-gaps-phong-than-20261004.md`.

## Phần 1: Tổng quan

- **Yêu cầu** (2026-10-04): "Tỉ lệ quái vẫn quá ít, thêm tính năng tăng tỉ lệ quái ở bản đồ và thời gian xuất hiện sau khi chết."
  - Hôm qua đã giảm một nửa `ReviveFrame` (quái thường hồi sau 15–30 giây) nhưng vẫn thấy ít quái.
- **Đã làm**: tab mới **"Mật độ & hồi quái"** trên web admin, gồm hai nút chỉnh:
  - **Hệ số mật độ** x1 / x1.5 / x2 / x3: server thêm quái cùng loại, cùng cấp, quanh các điểm sinh quái sẵn có.
  - **Thời gian hồi** của quái thường (5 / 10 / 15 / 30 giây hoặc nhập số), áp ngay cho quái đang sống, không cần khởi động lại.
  - Phạm vi: mọi bản đồ có quái (57 bản đồ) hoặc chỉ các bản đồ đánh dấu.
- **Đang chạy**: x2, hồi 10 giây, mọi bản đồ.
  - Bãi đang đứng (1026, bản đồ có người chơi) được đủ x2: **674 → 1.339 quái**.
  - Server có thêm **12.439 quái**. Tổng NPC 31.535 → 43.974, chạm giới hạn an toàn 44.000.
- **Giới hạn quan trọng**: engine chỉ chứa tối đa 48.000 NPC (`MAX_NPC`).
  - x2 cho cả 57 bản đồ cần khoảng 30.700 quái thêm, vượt sức chứa.
  - Vì vậy bản đồ đang có người chơi luôn được đủ hệ số trước. Các bản đồ khác chia phần còn lại theo tỉ lệ, hiện mỗi bản đồ khoảng 39% mục tiêu.
  - Người chơi sang bản đồ mới thì trong 1–2 phút bản đồ đó được đủ hệ số. Bản đồ cũ giữ quái thêm thêm 15 phút rồi mới trả lại phần ngân sách.

## Phần 2: Chi tiết

### 2.1 Tăng mật độ

| Mục | Cách làm |
|---|---|
| Điểm sinh gốc (seed) | Bản đồ do `spawn_main.lua` sinh: dùng các dòng `PT_SPAWN_DATA[map]` (vị trí, mẫu, cấp). Không dùng dòng quái nhiệm vụ `PT_SPAWN_SPECIAL`. Bản đồ 1014/1016 (quái Region_S gốc của VNG): quét NPC một lần, lấy quái thường (camp 5, AI 1–5, không tên màu, không bản sao nhiệm vụ). Loại quái trong `PTADM_MOB_SPAWN`/`PTADM_MOBS`/`PTADM_SPAWNED`, quái tạm newbie2 (param 0), boss. |
| Danh sách bản đồ | 57 bản đồ có quái của `PTBP_MAPS` (`bots\party.lua`): 51 bản đồ spawn_main, 1073–1076, 1014, 1016. Không gồm thành, Vạn Tiên trận (1079–1082), chiến trường 1071. |
| Tạo quái | `AddNpc(mẫu, cấp, sw, x, y, 1)` giống `spawn_main.lua`. Thử 8 hướng ở 4 ô, rồi 2 ô (ô đi được, có kiểm tra vật cản), cuối cùng đặt đúng điểm sinh gốc. |
| Hành vi giống quái gốc | `AddNpc` theo mẫu nên quái thêm có DeathScript `npc_quests\normal.lua` (kinh nghiệm, đồ rơi, nhiệm vụ đếm, kinh nghiệm đệ tử, Tứ Linh), AI, phe, ReviveFrame. Quái 1014/1016 giữ tên của quái gốc. |
| ActionScript | Engine không có hàm Lua đọc script đang gắn trên một NPC, nên `PTMD_Bind` gắn lại theo đúng bảng mẫu → script mà các tính năng khác gắn cho quái gốc, theo thứ tự ưu tiên: (1) `sudo_dongdi_drop.lua` (`PTSD_DROPMAPS`: Lam Cốt 44 ở 1044/1045/1047, Phi Thử 421–423 ở 1072); (2) `mob_drop.lua` của questfix3 (mẫu 103 Tuyết Nguyên Cự Thú, task 15); (3) `nb2_mob.lua` của newbie2 (`PTNB2_BIND_TID` 0–24, đã gồm `mob_drop.lua`, ví dụ Yểm Hỏa 8), ghi luôn vào `PTNB2_BOUND`; (4) `mob_drop.lua` của spawn_main (`PT_SPAWN_DROP_TIDS`: 0–4, 6, 8, 101, 102, 105, 106, 114). Quái nhiệm vụ chỉ có trong `PT_SPAWN_SPECIAL` (Độc Lục quái 106, 105, 102, 970, 971), quái `PTADM_MOB_SPAWN` (Kim Hà Thú…), quái Giang Sơn (vienco sinh riêng cho từng người) **không bao giờ được nhân bản**. |
| Chống trùng lặp | Theo dõi theo bảng `(map, ô e) → chỉ số NPC + GetNpcID`, không theo tên. Ô e luôn ứng với cùng một điểm sinh (ô lẻ trước, ô chẵn sau, nên quái thêm rải đều khắp bản đồ). Quái thêm mang param 12 = 7310417, 11 = ô e, 13 = map. Nếu state Lua bị tạo lại trong lúc server vẫn chạy, lượt quét đầu nhận lại quái thêm và xóa bản trùng. NPC bị người khác xóa, kể cả khi chỉ số đã được dùng lại cho NPC khác, thì chỉ xóa bản ghi rồi sinh lại ô đó, không bao giờ xóa NPC lạ. |
| Giới hạn | `GetNpcCount() ≤ 44.000` (chừa 4.000 trong 48.000 cho bot, boss, nhiệm vụ). Mỗi phút tối đa 4.000 lần gọi `AddNpc` và 2.500 lần `DelNpc`. Hạ hệ số thì xóa ô cao nhất trước. |
| Ưu tiên | Bản đồ có người chơi (giữ 15 phút sau khi rời) được đủ hệ số, người đến sau cùng được ưu tiên trước. Các bản đồ khác chia phần còn lại theo tỉ lệ mục tiêu. |

Mục tiêu mỗi bản đồ = điểm sinh × (hệ số − 1). Ví dụ 1026 có 665 điểm sinh: x1.5 = 332, x2 = 665, x3 = 1.330 quái thêm.

### 2.2 Thời gian hồi quái

- Dùng native `SetNpcRevTime(npc, giây × 18)` (`ScriptFuns.cpp` 4520 → `KNpc::SetReviveFrame`).
  - `KNpc::Revive` không nạp lại mẫu, nên giá trị giữ qua mọi lần hồi.
- **Áp cho**: quần thể spawn_main (`PT_SPAWN_NPCS`, trừ quái nhiệm vụ special), quái Region_S 1014/1016 và quái thêm.
- **Không áp cho**: boss, quái nhiệm vụ, NPC của các tính năng khác.
- Chạy ngay khi bấm Áp dụng: 12.000 quái mỗi phút, khoảng 4 phút cho 41.590 quái. Lặp lại mỗi 30 phút.
- **Duy trì sau khi khởi động lại server**: cấu hình nằm ở file, ext đặt lại từ đầu.
- Chọn "Mặc định" hoặc bản đồ ngoài phạm vi thì trả về giá trị `ReviveFrame` trong `Npcs.txt` (bảng `PTMD_RF`).
- Quái đang nằm chờ hồi giữ hẹn giờ cũ; từ lần chết sau mới theo số giây mới.
- **Không sửa `Npcs.txt`**: cách runtime áp được ngay mà không cần khởi động lại.

### 2.3 Web admin (tab "Mật độ & hồi quái")

- **Khung cấu hình**:
  - Hệ số (x1/x1.5/x2 đề xuất/x3).
  - Thời gian hồi (mặc định/5/10/15/30 giây/nhập số 3–600).
  - Phạm vi: mọi bản đồ hoặc chỉ bản đồ đánh dấu.
  - Nút **Áp dụng** và nút **Về mặc định** (x1, hồi theo Npcs.txt).
- **Khung trạng thái**: cấu hình đang chạy, số quái thêm và số bản đồ có quái thêm, tổng NPC / giới hạn, số điểm sinh gốc, số quái thêm và gỡ trong phút gần nhất, tiến độ đặt thời gian hồi, bản đồ có người chơi.
- **Bảng theo bản đồ** (57 dòng): ô đánh dấu, tên, số điểm sinh gốc, số quái đang thêm (kèm phần được chia khi chạm giới hạn), mục tiêu, thời gian hồi đang áp.
- **Luồng dữ liệu**:
  - `POST /api/action {type:'matdo'}` ghi `admin_bridge\matdo_config.lua` và `AdminWeb\data\matdo.json`, rồi xếp lệnh bridge `PTEXT_matdo_Apply`.
  - Lệnh bridge tự nạp ext và đăng ký vào `PTADM_EXT_NAMES` nếu server chạy từ trước bản này.
  - `GET /api/matdo` đọc `admin_bridge\matdo.txt` do server ghi mỗi phút.

### 2.4 Số quái trước / sau (đếm thực tế, chỉ đọc, bán kính 40 ô)

| Vị trí | Trước (16:39) | Sau (17:12) |
|---|---|---|
| 1026 chỗ người chơi đứng [1762, 2932] (đủ x2) | 23 | 22 + 14 = **36** |
| 1026 bãi đầu [1465, 3433] | 6 | 6 + 6 = **12** |
| 1014 Đông Quan [1437, 3090] | 11 | 11 + 6 = **17** |
| 1016 Tam Sơn [1430, 3140] | 15 | 15 + 7 = **22** |
| 1006 Bắc Hải [1910, 2785] | 12 | 12 + 5 = **17** |
| 1040 [1586, 3073] | 11 | 11 + 5 = **16** |
| Cả bản đồ 1026 | 676 | 674 + 665 = **1.339** |
| Cả bản đồ 1040 / 1006 / 1014 / 1016 | 702 / 686 / 752 / 448 | +275 / +265 / +291 / +172 |
| Tổng NPC server | 31.535 | 43.974 |

### 2.5 Kiểm thử mô phỏng

- **`S\qtest\sim_matdo.lua`**: mô hình engine gồm quần thể thật của `spawn_main.lua` (29.559 quái), quái Region_S, quái nhiệm vụ, boss, chỉ số NPC được dùng lại, giới hạn 48.000.
  - Chạy `-Stack 100`: `out_matdo.txt` FAILS=0.
  - Chạy EMU 40 khung: `out_matdo_emu.txt` FAILS=0, còn dư 39 khung.
  - Chạy với file runtime: `out_matdo_emu_live.txt` FAILS=0.
- **Các trường hợp đã kiểm**:
  - chờ spawn xong;
  - bản đồ có người chơi đủ x2 ngay phút đầu;
  - các bản đồ khác chia theo tỉ lệ;
  - không vượt 44.000;
  - không trùng sau nhiều tick, sau khi nạp lại file và sau khi state bị tạo lại (nhận lại 13.228 quái, xóa bản trùng);
  - NPC lạ dùng lại chỉ số không bị xóa;
  - người chơi đổi bản đồ;
  - x1.5 / x3 / x1 (gỡ hết, số NPC về đúng ban đầu);
  - phạm vi riêng;
  - hồi 10 giây / 5 giây / về Npcs.txt;
  - boss / quái nhiệm vụ / NPC thoại không bị đổi;
  - script gắn đúng theo mẫu (0, 8, 44, 101, 103, 114);
  - file cấu hình lỗi;
  - giá trị ngoài khoảng;
  - bản đồ chưa nạp;
  - lệnh Áp dụng của web admin.
- **`S\matdo\test_ps1.ps1`**: hàm `Get-MatDo` / `Set-MatDo` của web admin, kết quả ở `out_matdo_web.txt` FAILS=0. JS của trang qua `node --check`.

## Phần 3: Hành động

- [x] Sao lưu `_backup\20261004-quaimatdo\` gồm servertimer.lua, PhongThan-Admin.ps1, index.html, CHANGELOG.md, docs\features\README.md.
- [x] `script\phongthan\ext\matdo.lua` (mới, ASCII, sinh bởi `S\matdo\gen_matdo.py`).
- [x] `servertimer.lua`: chỉ thêm `"matdo"` vào `PTADM_EXT_NAMES`, sửa ở mức byte, thêm 9 byte.
- [x] `admin_bridge\matdo_config.lua` khởi tạo: x2, hồi 10 giây, mọi bản đồ.
- [x] Áp nóng qua bridge lúc 16:49 (`matdo_hot`): thêm 3.600 quái ngay; 17:11 đã đủ ngân sách 12.439 quái.
- [x] Web admin: `PhongThan-Admin.ps1` (route `GET /api/matdo`, action `matdo`) và `index.html` (tab mới).
- [ ] **Người dùng**: đóng cửa sổ web admin rồi mở lại bằng launcher, sau đó F5 trình duyệt để có tab mới. Không cần khởi động lại game server.
- [ ] Muốn nhiều quái hơn ở nơi khác nơi đang đứng: chọn "Chỉ các bản đồ đánh dấu" với vài bãi hay luyện. Ngân sách 12.000+ quái khi đó dồn cho các bản đồ đó, nên x3 cũng đủ.

## Phần 4: Tài liệu tham khảo

- Code: `ScriptFuns.cpp` (`LuaAddNpc` 4059, `LuaSetNpcRevTime` 4520, `LuaGetNpcID` 4904), `KNpc.cpp` (`DoRevive` 2343, `Revive` 8033, `LoadDataFromTemplate` 7807), `GameDataDef.h` (`MAX_NPC` 48000, `MAX_NPCPARAM` 16).
- Tính năng liên quan: `quai-mat-do-vng-phong-than-20260930.md` (spawn_main), entry respawn 2026-10-03 trong CHANGELOG, `tan-thu-moi-phong-than-20261003.md` (nb2_mob), `questfix3-phong-than-20261004.md`, `su-do-dong-di-phong-than-20261003.md`.
- Hướng mở rộng nếu cần x2 cho mọi bản đồ cùng lúc: tăng `MAX_NPC` trong C++ (cần build + triển khai, tốn bộ nhớ). Hiện chưa làm.
