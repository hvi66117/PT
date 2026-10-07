---
title: Kiểm toán và sửa nhiệm vụ Phong Thần (Tứ Linh, Tứ Tượng, Huyền Vũ, nhiệm vụ thế giới)
date: 2026-10-02
agent: questfix
tóm tắt: Tóm tắt báo cáo kiểm toán 22 nhóm nhiệm vụ VNG so với server local. Sửa 3 lỗi của tính năng làm hôm nay (đường vào Tứ Linh, Thủ khố Tây Kỳ/Triều Ca cho Tứ Tượng, map Thử Thách Huyền Vũ 1086 → 1084). Đặt thêm 14 NPC, 6 Phong ấn tháp và 13 quái nhiệm vụ để chạy trọn Phi Tiên, Minh Châu, Vi Lao và bước đầu Quy Tinh trong mô phỏng. Phần nằm trong PAK đi qua plug-in ptfix `extra_questfix.py`, cần build và deploy ptfix rồi khởi động lại server.
---

# Kiểm toán và sửa nhiệm vụ Phong Thần

## Phần 1: Tổng quan

### Insight chính
- **Chưa xong hết.** Trong 394 nhiệm vụ của sổ nhiệm vụ (taskinfo), 247 nhiệm vụ (63%) không có script nào gọi `TaskNote`. Bảng tên script VNG có 4.536 file, thiếu 2.521 file (56%).
- **Ba tính năng ghi "đã xong" hôm nay đều hỏng ở đường vào.** Cả ba đã sửa trong đợt này:
  - **Tứ Linh:** menu được vá vào script PAK, nhưng Thầy tướng số trên map lại chạy bản sao 2004 (`npc_restore`), nên không thấy dòng "Tứ Linh".
  - **Tứ Tượng:** Tây Kỳ và Triều Ca không có Thủ khố nào, nên không nhận được nhiệm vụ.
  - **Thử Thách Huyền Vũ:** script đưa người chơi sang map 1086 (Tử Huyền Động Thiên). Huyền Vũ Thần Vực là 1084.
- **Thiếu NPC còn nặng hơn thiếu script.** Nhiều script VNG có sẵn trong PAK nhưng không ai đứng trên map. Đặt NPC đúng chỗ và gắn script PAK là cách sửa rẻ nhất, không phải viết script mới.
- **Phát hiện thêm trong lúc sửa:**
  - Script quái VNG (`\script\怪物\*.lua`) chỉ có `OnDeath`. Khi gắn bằng `SetNpcScript`, engine chỉ gọi `LastDamage`, nên quái nhiệm vụ không rơi vật phẩm.
  - Võ Cát dùng `GetItemCount(41)`. Engine hiểu số 41 là genre, nên luôn ra 0 và Vi Lao kẹt ở bước 6.
  - Thầy Bói (`彩票\卦.lua`) so `GetWorldPos()` với 20/21. Runtime trả về 1020/1021, nên hộp thoại rỗng.

### Bảng tóm tắt kiểm toán, trạng thái sau đợt sửa
| # | Hệ thống | Cấp | Trạng thái trước | Sau đợt questfix |
|---|---|---|---|---|
| 1 | Tân thủ đời 2004 | 1–35 | Chạy (mô phỏng) | Không đổi |
| 2 | Tân thủ đời mới (Mao Lư, mật tịch…) | 1–20 | Thiếu script | Không đổi |
| 3 | Chính tuyến 3 phái 0→81 | 25–85 | Chạy (mô phỏng) | Không đổi |
| 4 | Tiên Ma giới (86–119) | 90+ | Thiếu cả thư mục script | Không đổi |
| 5 | Nhiệm vụ thế giới 2004 (20–26) | 13–59 | 1/7 chạy trọn | **6/7 chạy trọn trong mô phỏng**: Yên Phúc, Tứ Tượng, Phi Tiên, Minh Châu, Vi Lao; Quy Tinh bước 1/36. Phu thê vẫn cần thử bước biến thân |
| 6 | Sư đồ: Trừ yêu + 4 Thí luyện | 20–50 | Hỏng (thiếu Võ sư, Na Tra, Đại phu mê cung) | Không đổi |
| 7 | Nhiệm vụ thành thị khác (32, 33, 52, 60) | 30–70 | Một phần | Tân Miễn (32) và Tì Bà (Thiên thụ) đã có NPC |
| 8 | Tứ Linh (54) | — | Không có đường vào | **Sửa**: dòng "Tứ Linh" hiện ở Thầy tướng số Tây Kỳ và Triều Ca |
| 9 | Thử Thách Huyền Vũ | 70+ | Sai map 1086 | **Sửa**: map 1084, tọa độ theo bản đồ nhỏ VNG |
| 10 | Nhiệm vụ ngày đời mới (Thiên Cống, Thiên Cương Hồn…) | 30–90 | Thiếu | Không đổi |
| 11 | Vận Tiêu 2004 | 30+ | Hỏng, cần C++ | Không đổi |
| 12 | Vận Lương đời mới | 30+ | Thiếu script | Không đổi |
| 13 | Bào Thương | 20+ | Chạy | Không đổi |
| 14 | Lãnh địa / Lính đánh thuê / Sát thủ | 20+ | Bị chặn (cần công thành) | Không đổi |
| 15 | Thầy Bói (62, 63, 75, 76) | 45+ | Không có NPC | **Có NPC** ở Tây Kỳ, hộp thoại mở được. Chưa thử từng nhánh |
| 16 | Đông Di / Đông Nguy | 45+ | Hỏng giữa chuỗi | Bá Giám đã có NPC. NPC 偃* trên 1073 vẫn thiếu |
| 17 | Vạn Tiên trận, Boss thế giới, Trưởng lão Tứ Tượng | 30+ | Chạy (dựng mới) | Không đổi |
| 18 | Viễn Cổ chiến trường | 60+ | Hỏng | Không đổi |
| 19 | Giang Sơn Y Cựu | 60+ | Thiếu 201 script | Không đổi |
| 20 | Sự kiện Lễ Quan | mọi cấp | Thiếu | Không đổi |
| 21 | Sinh hoạt, Thị tộc, Hôn lễ… | 30+ | Thiếu | Không đổi |
| 22 | Linh thú trưởng thành | — | Một phần | Không đổi |

## Phần 2: Chi tiết

### 2.1 Phần A: ba lỗi của tính năng làm hôm nay
| Lỗi | Cách sửa | File |
|---|---|---|
| Tứ Linh không có đường vào | Thêm 2 dòng `PTADM_NPC_FIX`: Thầy tướng số 1020/1021 (tên GBK 算命先生) gắn thẳng vào script PAK `\script\西岐\算命先生.lua` và `\script\朝歌\算命先生.lua`. Hai script này đã được `extra_tutuong_b.py` vá dòng Tứ Linh, và đã có trong ptfix đang chạy. Nội dung gốc giống hệt bản `npc_restore`, nên Yên Phúc và Phi Tiên giữ nguyên. Chỉ mất menu phụ "Vai trò / NPC liên quan" | `servertimer.lua` |
| Không có Thủ khố ở Tây Kỳ/Triều Ca | Thêm 2 dòng `PTADM_NPC_SPAWN`: tpl 151 (giống Thủ khố 1003/1004) tại tọa độ VNG trong taskinfo 24 (`mappos1=$(20,1469,3063)`, `mappos2=$(21,1715,3036)`), tên hiển thị "Thủ Khố" (TCVN3). Thêm 2 dòng `PTADM_NPC_FIX` gắn script PAK 1cbd6c1b / 517a52ae, mà `extra_tutuong_a.py` đã vá an toàn | `servertimer.lua` |
| Huyền Vũ sai map | `PTHV_MAP = 1084`, chỗ vào `{1226, 2906}`, Thí Luyện Thần Sứ trong Thần Vực ở `{1084, 1211, 2880}`. Có trong `WorldSet.ini` (`1084=xuan_wu_shen_yu`), và `core_map_load_diag.log` ghi map đã nạp (slot 77, 238 vùng) | `tutuong\hv_lib.lua`, `tt_tick.lua`, `hv_npc.lua` (chỉ sửa chú thích) |

Cách chọn tọa độ Huyền Vũ Thần Vực:
- Bản đồ nhỏ VNG `maps\xuan_wu_shen_yu24.jpg` (544×448 điểm ảnh, rect vùng 72,87–88,100) có ghi chữ "Thí Luyện Thần Sứ" ở góc trên trái.
- Quy đổi: 1 điểm ảnh = 16 điểm hiển thị. Ô x = 1152 + px/2, ô y = 2784 + py. Ra khoảng (1211, 2880).
- Chỗ vào lệch sang khoảng sàn trống bên phải: 4 Vật Tổ ở ±8/±16 ô, hồn ở +6/+12.
- Các vùng (75..77, 89..91) không có file Region_S. Theo `KRegion::LoadObject`, vùng như vậy không có vật cản trên server.

### 2.2 Phần B: đặt NPC cho nhiệm vụ thế giới (mục 4 và 6 của kiểm toán)
**Tọa độ** lấy từ taskinfo (`mappos`, `HyperLinkWorldPos`: ô = hiển thị x×8, y×16), hoặc từ chữ ghi trên bản đồ nhỏ VNG. Đã kiểm tra lưới vật cản bằng `questfix\validate_st.py` (0 lỗi).

| NPC / quái | Map, ô | Template | Script gắn | Nhiệm vụ mở được |
|---|---|---|---|---|
| Người Hái Thuốc | 1020 (1428,3084) | 776 采药人 | `西岐\采药老人` | Vi Lao (50) bước 1 |
| Người Tây Vực (NPC vùng sẵn có) | 1020 | — | `西岐\西域神秘人` (thay placeholder 1020_03) | Phi Tiên (51), Trùng Mộc, Tân Thủ tầm bảo |
| Thầy Bói | 1020 (1420,3151) | 202 | `彩票\卦` | Thất Quải, Long Châu, Tìm bảo |
| Tân Miễn | 1020 (1524,3046) | 158 | `西岐\辛免` | Thu thập vật phẩm (32) |
| Tì Bà | 1021 (1792,2874) | 165 | `朝歌\琵琶` | Thiên thụ (đổi mầm) |
| Bá Giám | 1001 (1652,3120) | 202 | `封神台\柏鉴` | Thiên thụ (nhận quả, cho Liễu Mộc 39 của Vi Lao), Quỷ Nguyệt |
| Đồ Thư Quán | 1001 (1468,3256) | 158 | `封神台\图书馆` | Minh Châu (41) bước 2 |
| Cù Lưu Tôn | **1003** (1654,3166) | 202 | `玉虚宫\惧留孙` | Minh Châu bước 3/11/27. Bản placeholder ở Triều Ca giữ nguyên |
| Phong Ấn Tháp ×6 | 1006, 1007, 1012, 1013, 1010, 1009 | 1002 镇魂塔 | `item\天罡星\封印之塔1..6` | Quy Tinh (53) |
| Dược Lâu Tử ×3 | 1010 | 104 lv55 | `怪物\药篓子` | Vi Lao: Huyên thảo (38) |
| Hoa Trư ×4 | 1022 | 108 lv30 | `怪物\花之荒猪` | Phi Tiên: mảnh Lưu tinh (37) |
| Chúc / Thố / Thể Ngư ×2 | 1037 | 110/111/112 lv45 | `怪物\水煮鱼`, `糖醋鱼`, `酸菜鱼` | Minh Châu: 3 loại máu cá (34–36) |

**Plug-in `S\ptfix\extra_questfix.py`** (chỉ sửa trong PAK, idempotent):
1. Thêm `LastDamage → OnDeath` vào 5 script quái VNG và 36 script Thiên Cương Tinh. `DelNpc` trong `OnDeath` được hoãn sang `DeathSelf`, để không xóa NPC ngay trong lúc engine đang xử lý cái chết.
2. Sửa 6 script Phong ấn tháp:
   - `AddNpc` thêm tham số thứ 6 (engine trả 0 nếu chỉ có 5);
   - `ReLoadScript` script Thiên Cương Tinh một lần;
   - không lấy Bách Linh phướn nếu gọi Cương Tinh thất bại.
3. Thêm hàm dự phòng `HaveItem2` (Người Tây Vực) và `LoadIni*/SaveIni*` (Thầy Bói). Các hàm này chưa đăng ký trong `ScriptFuns.cpp`.
4. Thầy Bói nhận cả map 1020/1021 bên cạnh 20/21.

**File dự án sửa trực tiếp:** `npc_restore\1020_05.lua` (Võ Cát, TCVN3, sửa ở mức byte): `GetItemCount(41)>=2` → `HaveEventItemCount(41)>=2`, 2 chỗ.

### 2.3 Kiểm thử mô phỏng (`S\qtest\sim_questfix.lua` → `out_questfix.txt`): **0 FAIL**
- **servertimer:**
  - nạp được file, mỗi tick một lần đặt NPC + gắn script, không spawn trùng;
  - 58 dòng spawn có FIX đều nhận đúng script;
  - 32 dòng `PTADM_MOB_SPAWN` có đủ tên và script chết.
- **Tứ Linh:** dòng Tứ Linh hiện ở cả 2 thành, kể cả khi không có nhiệm vụ nào. Yên Phúc chạy tới task 91 = 4.
- **Tứ Tượng:** cả 2 Thủ khố nhận nhiệm vụ từ cấp 31, lấy 10 nguyên liệu, trả 1.200 lượng.
- **Phi Tiên:** đi đủ Người Tây Vực → Thầy tướng số Tây Kỳ → Cao Minh → Hoa Trư → Người Tây Vực, task 51 = 5.
- **Minh Châu:** đi đủ Con bạc → Cầm đồ → Đồ Thư Quán → Cù Lưu Tôn → 3 cá → Cù Lưu Tôn, task 41 = 10, nhận thưởng.
- **Vi Lao:** đi đủ Tiểu Bảo → Người Hái Thuốc → Dược Lâu Tử → Võ Cát → Xích Tinh Tử → Võ Cát → Xích Tinh Tử, task 50 = 8.
- **Quy Tinh, tháp 1:** tháp gọi Cương Tinh (tpl 123), giết Cương Tinh nhận chân khí, Dương Tiễn ghi bước 1/36.
- **Hộp thoại mới:** Thầy Bói, Tân Miễn, Tì Bà, Bá Giám đều mở được.
- **Không hồi quy:**
  - `sim_tutuong_b.lua`: chỉ khác số map và tọa độ;
  - `sim_tta.lua`: TOTAL FAILS = 0, giống bản trước;
  - `sim_questaudit.lua`: giống bản trước;
  - `t_st.lua`: servertimer nạp được.
- **Build thử ptfix** với cả 6 plug-in ra `S\questfix\ptfix_test.pak`: 448 mục, log ghi `questfix: 5/5, 36/36, 6/6, shim 1/1`.

## Phần 3: Hành động

### Việc cần làm trước khi thử (coordinator / người dùng)
- [ ] Build ptfix với plug-in mới rồi deploy qua web admin (`build_ptfix.py Server …` → `AdminWeb\pending`). Thiếu bước này thì phần A vẫn chạy (ptfix hiện tại đã có các bản vá của tutuong_a/b). Riêng quái nhiệm vụ, Phong ấn tháp và Thầy Bói của phần B sẽ chưa hoạt động.
- [ ] Khởi động lại GameServer. `servertimer.lua`, `tt_tick.lua` và `hv_lib.lua` chỉ được nạp lúc khởi động.

### Checklist thử trong game
- [ ] Thầy tướng số Tây Kỳ (174/188) và Triều Ca (214/195) có dòng **Tứ Linh**. Bấm vào thì mở menu Linh Tê.
- [ ] Có **Thủ Khố** ở Tây Kỳ (183/191) và Triều Ca (214/189). Từ cấp 31 nhận được Tứ Tượng, nộp 10 nguyên liệu nhận 1.200 lượng.
- [ ] Thí Luyện Thần Sứ (Triều Ca) → "Vào thử thách ngay": minimap phải ghi **Huyền Vũ Thần Vực**. 4 Vật Tổ xuất hiện quanh chỗ đứng.
- [ ] Phi Tiên (cấp 39): Người Tây Vực → Thầy tướng số Tây Kỳ (1.000 lượng) → Cao Minh (Xi Vưu Mộ) → Hoa Trư ở Hoang mạc (187/186) → Người Tây Vực.
- [ ] Minh Châu (cấp 43): Con bạc → Chủ cầm đồ → Đồ Thư Quán (Phong Thần Đài 183/203) → Cù Lưu Tôn (**Ngọc Hư** 206/197) → cá ở Đông Hải Thủy Vực (225/207, 222/179, 204/177) → Cù Lưu Tôn.
- [ ] Vi Lao (cấp 57): Tiểu Bảo → Người Hái Thuốc (Tây Kỳ 178/192) → Dược Lâu Tử (Thủ Dương sơn) → Võ Cát → Xích Tinh Tử. Ba báu vật: Liễu Mộc lấy từ quả Thiên thụ ở Bá Giám; Côn Lôn kính ở Bích Du tầng 2; 2 Đèn thần mua ở Cao Giác.
- [ ] Quy Tinh (cấp 59): Dương Tiễn → Phong Ấn Tháp ở Bắc Hải (217/197) → giết Thiên Cương Tinh → Dương Tiễn.
- [ ] Thầy Bói (Tây Kỳ 177/196), Tân Miễn (190/190), Tì Bà (Triều Ca, cạnh Đắc Kỷ), Bá Giám (Phong Thần Đài 206/195) mở được hộp thoại.
- [ ] Tên hiển thị các NPC mới (TCVN3) có đọc được không. Nếu client hiện lỗi font, báo lại để đổi tên.

### Còn lại, theo thứ tự ưu tiên
1. Quy Tinh mới thử tháp 1. Năm tháp còn lại dùng cùng mẫu, nhưng chưa ai đi đủ 36 bước. Bắc Hải và Cự Lộc có cùng tọa độ hiển thị (217,197) trong taskinfo.
2. Lỗi E còn tồn: các NPC `npc_restore` (Con bạc, Chủ cầm đồ, Tiểu Bảo, Võ Cát, Tống Dị Nhân) ra hộp thoại không có dòng thoát khi không có nhiệm vụ.
3. Sư đồ: Võ sư ×3, Na Tra Tây Kỳ (taskinfo [20,167,185]), Đại phu dã ngoại trong mê cung (kiểm toán mục 5).
4. Đông Di: NPC 偃* trên map 1073, sửa tên placeholder 1073–1075.
5. Tài liệu `tu-linh-thu-thach-huyen-vu-phong-than-20261002.md` vẫn ghi map 1086. Bản này là nguồn đúng.
6. Vận Lương / Vận Tiêu, nhiệm vụ ngày đời mới, Tân thủ đời mới, Tiên Ma giới: cần viết script mới hoặc sửa C++.

## Phần 4: Tài liệu tham khảo
- **Báo cáo kiểm toán:** `S\questaudit\quest_audit.md`, kèm dữ liệu trong `S\questaudit\`.
- **Công cụ của đợt này** (`S\questfix\`):
  - đọc dữ liệu: `pk.py` (đọc PAK), `dumpu.py` (xuất script, TCVN3 → Unicode), `grep_pak.py` (tìm trong toàn bộ script VNG), `regnpc.py` (NPC theo vùng), `ti_dump.py` / `links.py` (tọa độ taskinfo);
  - kiểm tra: `chk.py` (lưới vật cản), `apicheck.py` (hàm chưa đăng ký), `validate_st.py`;
  - sửa file: `st_rows.py` + `st_edit.py` (ghi dòng servertimer), `deploy_hv.py`, `fix_vocat.py`.
- **Plug-in:** `S\ptfix\extra_questfix.py`. Build thử: `S\questfix\ptfix_test.pak`.
- **Mô phỏng:** `S\qtest\sim_questfix.lua`.
- **Nguồn engine:**
  - `ScriptFuns.cpp`: `LuaAddNpc` cần 6 tham số; `LuaEnterNewWorld` cộng 1000 cho map 1..118, `GetWorldPos` không đổi ngược; `LuaGetItemCount` hiểu tham số đầu là genre;
  - `KNpc.cpp:1718`: ActionScript chỉ được gọi `LastDamage`;
  - `KRegion.cpp`: vùng không có Region_S thì không có vật cản.
- **Tài liệu liên quan:** `tu-linh-thu-thach-huyen-vu-phong-than-20261002.md`, `tu-tuong-vat-pham-truong-lao-phong-than-20261002.md`, `roi-vat-pham-nhiem-vu-phong-than-20260929.md`.
