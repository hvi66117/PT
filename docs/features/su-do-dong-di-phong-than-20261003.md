---
title: Sư đồ (Trừ yêu, 4 Thí luyện) chơi một mình và chuỗi Đông Di / Đông Nguy chạy trọn
date: 2026-10-03
agent: sudo_dongdi
tóm tắt: Mở lại nhiệm vụ sư đồ 42–46 và cho làm một mình (không tổ đội). Đặt 3 Võ sư tân thủ, Na Tra Tây Kỳ, 20 Đại phu trong 4 mê cung. Đếm quái Trừ yêu cho 8 loại quái mục tiêu, vì 7/8 script chết VNG bị thiếu. Chuỗi Đông Nguy (35, 37–41) chạy trọn từ 0 đến 32 trong mô phỏng: mở lại điểm bắt đầu và menu Bá Giám mà VNG đã tắt, đặt 14 NPC Đông Di trong túi tây nam của map 1073, thêm 2 Thuyền phu Khai Minh đảo, nguồn rơi cho vật phẩm không có nguồn, sửa map id và hàm đếm sai. Phần trong PAK đi qua plug-in `extra_sudo_dongdi.py`, cần build và deploy ptfix rồi khởi động lại server.
---

# Sư đồ chơi một mình và chuỗi Đông Di / Đông Nguy

## Phần 1: Tổng quan

### Insight chính
- **Sư đồ hỏng ở 3 tầng, không chỉ thiếu NPC.**
  - Thiếu NPC: Võ sư 3 map tân thủ, Na Tra Tây Kỳ, Đại phu trong mê cung.
  - Ba NPC thí luyện npc_fix (Thổ Hành Tôn, Hoàng Thiên Hóa, Dương Tiễn) đã **tắt hẳn** thí luyện bằng `pt_fix_mpr` vì `AddMasterPRValue` chưa đăng ký.
  - Trừ yêu không bao giờ đếm được quái: 7/8 loại quái mục tiêu (红煞, 鬼驭, 天吴, 沙魂, 火离小妖, 冰灵, 英招神) có DeathScript trỏ tới file VNG **không tồn tại**. Kể cả có đủ cặp sư đồ thật cũng kẹt.
- **Chơi một mình:** chọn cách thay đổi nhỏ nhất. Người chơi **không ở trong tổ đội** được coi như một cặp sư đồ hợp lệ. Tổ đội đúng 2 người có quan hệ sư đồ vẫn đi đường VNG gốc. Tổ đội khác thì bị từ chối như cũ.
- **Đông Nguy bị chính VNG tắt:** dòng mở chuỗi ở Tôn Tử Vũ và các dòng Đông Di ở Bá Giám đều bị comment trong script VNG. Ngoài ra:
  - nhiều vật phẩm nhiệm vụ không có nguồn trên server: Ngọc Hư Phù, Hồng bảo thạch, Quả nhân sâm, Mai/Lan/Trúc/Cúc, Địa tâm/Phong lệ/Thủy hồn/Hỏa linh ×100;
  - script đếm quái của Thiết Cốt và Chúc Thần bị thiếu;
  - script mảnh pháp khí so map với `76`, trong khi runtime là `1076`;
  - Yển Bá Ích dùng `GetItemCount(114)`, luôn ra 0;
  - Khai Minh đảo không có Thuyền phu nào để đi và về.
- **Phân vùng với Tiên Ma (theo coordinator):**
  - map 1073–1075 dùng số map VNG cuối (Bất Chu Thiên Quan, Bất Chu Sơn, Ngục Pháp Sơn), và các placeholder trên đó là NPC Tiên Ma đúng chỗ. **Không đổi tên, không gắn lại** placeholder nào;
  - NPC Đông Di (`\script\东夷\*`, bản 2005) chỉ đặt trong **túi tây nam kín của 1073**, nơi Bá Giám đưa tới (1615/3888, 2.465 ô đi được, không nối với vùng Tiên Ma).

### Trạng thái sau đợt này
| Nhiệm vụ | Trước | Sau (mô phỏng) |
|---|---|---|
| 42 Sư môn Trừ yêu | Không có Võ sư, không đếm được quái | Nhận được một mình ở 3 Võ sư, đếm quái, trả thưởng |
| 43 Hoang mạc thí luyện (Thổ Hành Tôn) | Bị tắt, thiếu Đại phu | Chạy trọn 0→7 một mình |
| 44 Đông Hải thí luyện (Na Tra) | Không có Na Tra, thiếu Đại phu | Chạy trọn 0→7 |
| 45 Hiên Viên thí luyện (Hoàng Thiên Hóa) | Bị tắt, thiếu Đại phu | Chạy trọn 0→7 |
| 46 Băng Xuyên thí luyện (Dương Tiễn) | Bị tắt, thiếu Đại phu | Chạy trọn 0→7; xong 4 thí luyện thì nhận thú cưỡi cấp 50 |
| 35 Đông Nguy + 37–41 | Không bắt đầu được | Chạy trọn 597 = 0→32, nhận thưởng Khương Tử Nha |

## Phần 2: Chi tiết

### 2.1 NPC đặt mới (ext `script\phongthan\ext\sudo_dongdi.lua`)
Tọa độ chọn bằng `S\sudo_dongdi\findpos.py`. Ô được chọn phải đi được trên lưới server, cả 8 ô quanh cũng đi được, không nằm trên trap, và cùng vùng với điểm vào map.

| NPC | Map, ô | Template | Script gắn |
|---|---|---|---|
| Võ Sư ×3 | 1002 (1674,3214), 1003 (1668,3136), 1004 (1548,3216) | 154 (Võ sư VNG Diêu Trì) | `崇城大营\教师`, `玉虚宫\教师`, `蚩尤墓\教师` |
| Na Tra | 1020 (1336,2960), taskinfo [20,167,185] | 225 (Na Tra VNG) | `西岐\哪吒` |
| Đại Phu ×20 | 1022–1041, cách điểm vào mỗi tầng khoảng 5 ô | 149 | xem bảng 2.3 |
| Tôn Tử Vũ | 1002 (1708,3112), cạnh Sùng Hầu Hổ | 190 | `崇城大营\孙子羽` |
| Thuyền Phu | 1065 (1550,3322), cạnh Lý Tịnh | 156 | `陈塘关\船夫` (đi Khai Minh đảo) |
| Thuyền Phu | 1072 (1600,3236), điểm cập bến | 156 | `红名岛\船夫` (về Phong Thần Đài) |
| Ma Lễ Thọ, Ma Lễ Hải, Ma Lễ Hồng, Ma Lễ Thanh | 1073 (1606,3880) (1602,3888) (1602,3896) (1608,3900) | 773, 211 | `东夷\魔礼寿/海/红/青` |
| Vệ Binh Thành Môn | 1073 (1622,3870) | 211 | `东夷\城门卫兵1` (ra vùng ngoài ải) |
| Thiếu Nữ Di Tộc, Bạch Di | 1073 (1628,3864) (1636,3858) | 165, 164 | `东夷\夷族女子`, `东夷\白夷` |
| Yển Bá Ích, Yển Thúc Di | 1073 (1648,3850) (1655,3850) | 1008, 1009 | `东夷\偃伯益`, `东夷\偃叔夷` |
| Liễu Nhân, Yển Phong | 1073 (1642,3842) (1658,3860) | 165, 1010 | `东夷\柳茵`, `东夷\偃风` |
| Yển Long, Yển Hổ, Yển Lang | 1073 (1640,3870) (1648,3870) (1656,3870) | 1011, 1012, 156 | `东夷\偃龙/虎/狼` |

- Mỗi phút: NPC nào mất (tên hoặc map không khớp) thì đặt lại. Phút đầu tiên `ReLoadScript` mọi script PAK đang dùng, vì script chỉ có trong PAK không được nạp lúc khởi động.
- Tên hiển thị là TCVN3. Không trùng tên với dòng nào của `PTADM_NPC_FIX`. Mô phỏng xác nhận `PTAdm_FixNpcScripts` không gắn đè.
- **Ma Lễ Thọ (tpl 773) đặt tại 1073 ô (1606,3880), trong túi tây nam.** Nếu Tiên Ma sau này cần Ma Lễ Thọ riêng, cần tránh trùng.

### 2.2 Sư đồ chơi một mình
- **Thư viện chung** `ext\sudo_dongdi_lib.lua`:
  - `PTSD_JudgeRelation()` trả 1 khi là cặp sư đồ VNG, hoặc khi người chơi không ở trong tổ đội;
  - `AddMasterPRValue` có hàm dự phòng không làm gì, để phần thưởng "sư phụ" không gây lỗi.
- **3 Võ sư tân thủ** (plug-in): thay `judge_relation`; `judge_times` chỉ xét bản thân khi làm một mình; `mission_PR_confirm` có nhánh một mình:
  - vẫn chọn quái theo cấp như VNG, vẫn bật vòng sáng Nhân giả (buff 215), vẫn giới hạn 4 lần/tuần;
  - **số quái = một nửa công thức VNG** `100+(floor(2×cấp/10)−5)×40`, tối thiểu 30 (cấp 20: 30 con, cấp 30: 70, cấp 40: 110, cấp 50: 150).
  - Không đụng Võ sư Tây Kỳ/Triều Ca (`西岐\教师`, `朝歌\教师` của `extra_bikip.py`). Đây là 3 mục PAK khác nhau.
- **Đếm quái Trừ yêu** (plug-in):
  - tạo mới `\script\npcdeath\红煞|鬼驭|天吴|沙魂|火离小妖|冰灵|英招神.lua`;
  - bọc `\script\npcdeath\武士龟.lua` (file VNG có sẵn, vẫn chạy thân cũ).
  - Mỗi con chết: người giết và đồng đội cùng map được trừ 1 nếu mục tiêu khớp `GetTask(897)`, còn `898` và còn buff 215.
- **Thí luyện:**
  - Na Tra (plug-in): đổi `judge_relation`. Nút "Đổi sức lực" trả lời "chưa mở", thay vì trừ danh vọng rồi lỗi ở `AddWeightMax` (hàm này chưa đăng ký).
  - Thổ Hành Tôn, Hoàng Thiên Hóa, Dương Tiễn (npc_fix, thêm vào cuối file ở mức byte): `pt_fix_mpr` trả 1, `judge_relation` theo thư viện.

### 2.3 Đại phu trong mê cung (plug-in: thêm nhánh một mình; sửa map id cho 2 script)
| Thí luyện (task) | Tầng 1 | Tầng 2 | Tầng 3 | Tầng 4 | Tầng 5 |
|---|---|---|---|---|---|
| 43 Hoang mạc (899) | 1022 `-荒漠` | 1023 `野外医生` | 1024 `-沙漠风滩` | 1025 `-死亡沙漠` | 1026 `野外医生` |
| 44 Đông Hải (900) | 1037 `-东海水域` | 1038 `-东海海底` | 1039 `-东海海沟` | 1040 `-东海龙域` | 1041 `-东海龙渊` |
| 45 Hiên Viên (901) | 1027 `-轩辕洞一层` | 1028 `-轩辕洞二层` | 1029 `野外医生` | 1030 `野外医生` | 1031 `-轩辕洞五层` |
| 46 Băng Xuyên (902) | 1032 `-玉泉冰川` | 1033 `-冰川雪谷` | 1034 `-大风冰川` | 1035 `-大泽冰川` | 1036 `-冰川之极` |

- `野外医生.lua` (bản chung) và `野外医生-死亡沙漠.lua` so `GetWorldPos()` với số map VNG 23/25/26/29/30. Runtime trả về 1023…, nên thêm dòng đổi `mapid − 1000` khi mapid nằm trong 1001..1118.

### 2.4 Chuỗi Đông Nguy (task 597) và cách mở từng chỗ kẹt
| Bước | NPC / việc | Chỗ kẹt cũ | Cách sửa |
|---|---|---|---|
| 0→1 | Tôn Tử Vũ (Sùng Thành), cấp ≥ 70 | VNG comment dòng nhận; không có NPC | Plug-in mở lại, lời thoại tiếng Việt; đặt NPC |
| 1→4 | Đặng Cửu Công (đố 4 câu) → Đặng Thiền Ngọc → 20 Lam Cốt | Lam Cốt chỉ có ở Bích Du 3/4, Khổn Tiên 1 | Giữ nguyên; thêm gợi ý chỗ đánh |
| 4→6 | Hoàng Phi Hổ → Lý Tịnh | — | Sẵn có (npc_fix) |
| 6→9 | Bá Giám: Ngọc Hư Phù + Hồng bảo thạch + 1 vạn → Hộ thân phù → sang Giai Mộng | VNG comment menu; 2 vật phẩm không có nguồn | Plug-in mở lại menu. Lam Cốt rơi mỗi thứ 1 cái (25%/con) khi đang ở bước 7 |
| 9→14 | Ma Lễ Thọ + 3 huynh đệ → Đặng Cửu Công → 10 Phi Thố ở Khai Minh đảo | Không có NPC; không có Thuyền phu | Đặt NPC trong túi 1073; Thuyền phu ở Trần Đường (5 vạn) và trên đảo. Đếm Phi Thố bằng `npcdeath\red1-3.lua` có sẵn |
| 14→16 | Vệ binh (ra ngoài ải), Thiếu nữ Di tộc (Quả nhân sâm), Bạch Di | Quả nhân sâm không có nguồn | Phi Thố rơi Quả nhân sâm (30%) khi ở bước 300 |
| 16→22 | Yển Bá Ích → Yển Thúc Di → Liễu Nhân (Mai, Lan, Trúc, Cúc), Yển Phong (3 Đại Hồng đơn + 3 Đại Hoàn đơn mua ở tiệm thuốc), tứ linh ×100 | Hoa và tứ linh không có nguồn | Phi Thố rơi 1 hoa còn thiếu (30%/con), và mỗi con cho 1 cái mỗi loại tứ linh còn thiếu (tối đa 100) |
| 22→23 | Yển Long, Yển Hổ, Yển Lang: mỗi người 20 Thiết Cốt / Huyết Yêu / Thiết Tinh | Thiết Cốt (tpl 750/751) không có script chết | Tạo `仙·风兽山珲.lua`, `魔·风兽山珲.lua` (chép `风兽山晖.lua` của VNG) |
| 23→29 | Yển Bá Ích → Đặng Cửu Công → Trụ Vương ("Chức năng VNG gốc") + Võ Vương → Đặng Cửu Công → Võ Vương → Khương Tử Nha | — | Sẵn có |
| 29→31 | Yển Bá Ích → 7 mảnh pháp khí ở Bản Tuyền Thánh Địa (1076) | So map 76; Chúc Thần (tpl 934) không có script chết; `GetItemCount(114)` luôn ra 0 | Chấp nhận 1076 trong `乘黄/烛阴神/苟芒神.lua`; tạo `烛阴神阪泉.lua`; đổi sang `HaveEventItemCount(114)` |
| 31→32 | Khương Tử Nha: 1.500.000 kinh nghiệm, 35 danh vọng | — | Sẵn có (npc_fix đã sửa `GetItemCount`) |

- **Script rơi đồ** `ext\sudo_dongdi_drop.lua` (ActionScript, `LastDamage`) gắn vào Lam Cốt (tpl 44) trên 1044/1045/1047 và Phi Thố (tpl 421–423) trên 1072. Các template này chưa có ActionScript nào của dự án.
  - Chỉ rơi cho người giết, đúng bước, không vượt số cần.
  - Gắn sau khi bãi quái sinh xong (`PT_SPAWN_DONE`), quét lại mỗi 10 phút.
  - Tỉ lệ đổi ở đầu `sudo_dongdi_lib.lua` (`PTSD_RATE_*`).
- **Gợi ý nguồn vật phẩm** (`Msg2Player`): thêm ở Đặng Thiền Ngọc, Bá Giám, Thiếu nữ Di tộc, Yển Thúc Di, Liễu Nhân, Yển Long/Hổ/Lang, Yển Bá Ích.

### 2.5 Mô phỏng `S\qtest\sim_sudo_dongdi.lua` → `out_sudo_dongdi.txt`: **TOTAL FAILS = 0**
- **Ext:**
  - nạp được, chưa gắn đồ rơi khi bãi quái chưa sinh xong;
  - lần 3 không đặt thêm NPC; 41 dòng NPC có đủ tên, script và đã `ReLoadScript`; 16 script chết đã đăng ký;
  - đồ rơi gắn đúng Lam Cốt 1044 và Phi Thố 1072, không đụng quái Tiên Ma 1073;
  - NPC mất thì đặt lại một lần; mọi NPC Đông Di nằm trong túi 1073;
  - `PTAdm_FixNpcScripts` không gắn đè.
- **Trừ yêu:**
  - cấp 20 làm một mình: Ngưu Sát 30 con, giết khác loại không tính, đủ 30 thì F11 bước 8, trả thưởng;
  - mất buff thì không tính; bản bọc Võ sĩ quy (tpl 19) chạy cả thân VNG;
  - tổ đội 3 người bị từ chối; cặp sư đồ thật vẫn ra số VNG (260).
- **4 thí luyện một mình:** mỗi thí luyện đi đủ NPC → 5 Đại phu → NPC, task lên 7, có kinh nghiệm. Xong cả 4 nhận thú cưỡi cấp 50. Mất buff 216 thì Đại phu không cho qua. "Đổi sức lực" của Na Tra không lỗi.
- **Đông Nguy:** đi đủ 0→32 như bảng 2.4, F11 35 bước 39.
- **Không hồi quy:**
  - `sim_questfix` 0 FAIL; `sim_tta` giống hệt bản gốc; `t_st` nạp được servertimer;
  - `sim_questaudit` và `sim_tutuong_b` chỉ khác bản gốc ở dòng thoát `PTQ2_Close` (questfix2) và map Huyền Vũ (questfix), không do đợt này.
- **Build thử ptfix** với cả 10 plug-in ra `S\sudo_dongdi\ptfix_test.pak`: 477 mục, log ghi `sudo_dongdi: teachers 3/3, na tra 1, doctors 17/17, tru yeu 8/8, dong di death 6, hints 7/7, yen ba ich 1, ba giam 1, ton tu vu 1`.

## Phần 3: Hành động

### Việc cần làm trước khi thử (coordinator / người dùng)
- [ ] Build ptfix có `extra_sudo_dongdi.py` rồi deploy qua web admin. Chưa có bước này thì NPC vẫn được đặt, nhưng script PAK là bản gốc: chỉ cặp sư đồ làm được, Trừ yêu không đếm, Đông Nguy không mở.
- [ ] Khởi động lại GameServer. Ext chỉ được nạp lần đầu sau khi server chạy.

### Checklist thử trong game
- [ ] Tân thủ (1002/1003/1004) có **Võ Sư**. Cấp 20–50, không tổ đội: "Trừ Yêu" nhận được và báo số quái. Giết quái mục tiêu: dòng chat đếm ngược. Đủ thì "Hoàn thành" nhận kinh nghiệm.
- [ ] **Na Tra** ở Tây Kỳ (167/185). Cấp 31–40: "Đông Hải Thí Luyện" → 5 Đại phu Đông Hải (vào từ Trần Đường) → Na Tra.
- [ ] Thổ Hành Tôn (cấp 26–35, Hoang mạc), Hoàng Thiên Hóa (36–45, Hiên Viên), Dương Tiễn (41–50, Băng Xuyên): mỗi tầng có **Đại Phu** gần chỗ vào.
- [ ] Đông Nguy (cấp ≥ 70): Tôn Tử Vũ ở Sùng Thành → … → Bá Giám (Phong Thần Đài) → túi Giai Mộng (1073) có anh em Ma Lễ, Vệ binh và trại Di tộc.
- [ ] Thuyền phu Trần Đường đưa ra Khai Minh đảo; Thuyền phu trên đảo đưa về Phong Thần Đài.
- [ ] Rời túi Giai Mộng về thành bằng Thổ địa phù, hoặc ra vùng ngoài ải qua Vệ binh.
- [ ] Tên NPC mới (TCVN3) đọc được.

### Còn lại / rủi ro
1. Thiết Cốt, Huyết Yêu (vùng ngoài ải 1073) và Thiết Tinh, Chúc Thần (1076) là quái của bãi sinh chung (cấp 70–80). Đây là vùng của Tiên Ma. Nếu Tiên Ma đổi bãi quái hoặc script chết các template 747/750/751/930/934, cần giữ phần đếm 589/590/591 và mảnh pháp khí. Plug-in `extra_tienma.py` chạy sau `extra_sudo_dongdi.py` (theo tên); nó bỏ qua mục đã có ("exists") chứ không ghi đè.
2. Đi Bản Tuyền phải qua vùng ngoài ải 1073 → 1074 → 1075 → 1076. Trap 1074→1075 của VNG chỉ mở khi 597 nằm trong 15..299.
3. Hoàng Phi Hổ (Đạo lý / Xuất sư) và việc đổi sức lực vẫn tắt (cần API sư đồ trong C++).

## Phần 4: Tài liệu tham khảo
- **Kiểm toán:** `S\questaudit\quest_audit.md` mục 2.6 và 2.12; `kiem-toan-nhiem-vu-phong-than-20261002.md`.
- **File của đợt này:**
  - ext: `Server\script\phongthan\ext\sudo_dongdi.lua`, `sudo_dongdi_lib.lua`, `sudo_dongdi_drop.lua` (sinh bằng `S\sudo_dongdi\gen_lua.py`);
  - plug-in: `S\ptfix\extra_sudo_dongdi.py`;
  - npc_fix thêm cuối file: `1021_tho_hanh_ton.lua`, `1021_hoang_thien_hoa.lua`, `1020_duong_tien.lua`.
- **Công cụ** (`S\sudo_dongdi\`): `dump.py` / `dump_test.py` (xuất script PAK), `ti.py` (taskinfo), `findpos.py`, `pocket.py`, `pocketpos.py` (chọn ô), `traps.py` (điểm vào map), `npcfind.py` (template).
- **Nguồn engine:**
  - `KNpcTemplate.cpp`: DeathScript `npcdeath\normal.lua` được đổi sang `phongthan\npc_quests\normal.lua`;
  - `KNpc.cpp` DoDeath: ActionScript `LastDamage` và DeathScript `OnDeath` chạy riêng;
  - `ScriptFuns.cpp`: `LuaGetTeamId` trả nil khi không tổ đội, `RemoveVngItems` xóa từng cái, `AddNormalItemPile` để gộp chồng.
- **Liên quan:** `tien-ma-*-20261003.md` (agent tienma), `bi-kip-he-phai-phong-than-20261002.md` (Võ sư Tây Kỳ/Triều Ca).
