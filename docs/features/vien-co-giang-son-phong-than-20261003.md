# Viễn Cổ chiến trường (bản PvE) và Giang Sơn Y Cựu

> Ngày: 2026-10-03 · Agent `vienco` · Ext tick `PTEXT_vienco_Tick()` (đã có sẵn trong `PTADM_EXT_NAMES` của servertimer)
> Biến nhiệm vụ: 2340–2369 (đã kiểm tra: không script rời hay script PAK nào dùng). GlobalValue: 2340–2369.

## Phần 1: Tổng quan

### Insight chính
1. **"Viễn Cổ chiến trường" của VNG là chiến trường PvP Thương – Chu**, không phải sự kiện PvE.
   - Script nằm ở `\script\新古战场\远古战场*.lua` (Mission 5), bản đồ 71 = runtime **1071** (商周战场, "Chiến trường").
   - Mở thứ Bảy và Chủ nhật: 15 phút báo danh, 60 phút giao chiến, rồi phát thưởng.
   - Báo danh tại bia đá Phong Thần Đài (`封神台\神碑2.lua`): cấp 50 trở lên, phí 5 vạn lượng, chọn phe Thương (camp 1) hoặc Chu (camp 2).
   - Trong trận: hạ người chơi phe địch, phá vật tổ, đoạt soái kỳ. Chủ tướng là Văn Trọng (闻仲) và Khương Thượng (姜尚); họ giao nhiệm vụ "Vị Quốc Lập Công" (taskinfo 85).
   - Thưởng nhận ở Võ Vương (Tây Kỳ) hoặc Trụ Vương (Triều Ca), có thêm "đẳng cấp chiến trường" 0–10.
   - Trên server local, lịch không bao giờ chạy (engine không đọc `systemtimetask.txt`). Map 1071 chỉ có 5 NPC placeholder.
   - Lưu ý: map 64 "2000年前古战场" (nơi có Hiên Viên, Thần Nông, Xi Vưu của nhiệm vụ 47) là một bản đồ nhiệm vụ khác, không phải chiến trường này.
2. **Đã dựng bản PvE chơi một mình được** trên chính map 1071, giữ luật VNG:
   - Hai đạo quân đều là NPC: Thương binh (camp 1) và Chu binh (camp 2).
   - Người chơi vào phe nào thì quân phe đó là đồng minh, quân phe kia là kẻ địch. Engine tính quan hệ theo camp (`KNpcSet::GenOneRelation`: cùng camp là đồng minh, khác camp là địch).
   - Không phụ thuộc bot giả lập người chơi. Có thể đặt thêm bot lên map 1071 qua trang cấu hình bots trên web admin cho đông vui, nhưng không bắt buộc.
3. **Giang Sơn Y Cựu (taskinfo 1053–1058, 1081) mất gần hết dữ liệu VNG.**
   - Thiếu toàn bộ 201 script `\script\instance\` và 74 script `motion`.
   - Sách 江山卷 gọi `OpenNpcCollectionDlg`, hàm này engine chưa đăng ký.
   - Đã dựng lại thành **một chuỗi 19 bước tại Dư Khánh (Triều Ca)**. Chuỗi bám theo chữ taskinfo và các tọa độ bảo đồ còn sót trong script vật phẩm `江山依旧地图*.lua`.
4. **Không cần sửa C++** để hai tính năng chạy. Phần 2.6 có đề xuất C++ nhỏ, không bắt buộc.

### Nhận định
- Đã mô phỏng end-to-end, 63/63 kiểm tra đạt, với cả hai chế độ stack:
  - giả lập stack của engine (đệm 47/40 khung);
  - `-Stack 100` thường.
- Chưa thử trong game, cần người dùng khởi động lại server.

## Phần 2: Chi tiết

### 2.1 Viễn Cổ chiến trường – luồng chơi
| Bước | Nơi | Nội dung |
|---|---|---|
| Lịch | Ext tick | Mỗi giờ có 1 trận, phút 00–44 giao chiến, phút 45 tổng kết. Danh sách giờ là `PTVC_HOURS` (mặc định cả 24 giờ), độ dài là `PTVC_LEN = 45`. Admin mở ngay một trận bằng `PTVC_ForceOpen()` qua bridge |
| Báo danh | **Viễn Cổ Chiến Sứ**, Phong Thần Đài (1001) 1514/3284, tọa độ hiển thị (189/205) | Cấp 50 trở lên, PK dưới 88, còn ít nhất 5 phút. Phí 5 vạn (đẳng cấp chiến trường 10 được miễn). Chọn **Quân Thương** hoặc **Quân Chu**. Rời map giữa trận thì được vào lại miễn phí, cùng phe |
| Doanh trại | Thương: 1430/3393 (phía tây). Chu: 2349/3053 (phía đông) | Điểm hồi sinh tạm của phe (`SetTempRevPos`). Không phạt PK. Camp hiện tại được đặt bằng `SetCurCamp(1/2)` |
| Chủ tướng | **Văn Trọng** 1426/3413 (tpl 1520), **Khương Thượng** 2339/3050 (tpl 301 Khương Tử Nha) | Gồm: Vị Quốc Lập Công, Chiến trạng, Công trạng, **Xuất trận** (ra tiền tuyến, bật chiến đấu), Về thành. Giao soái kỳ ở đây |
| Quân y | 1438/3406 và 2349/3031 (tpl 766) | Gắn script VNG `新古战场\医生.lua` (cửa hàng 21) |
| Bẫy (trap) VNG | 商营out / 周营out trong doanh trại; 商营in / 周营in ở tiền tuyến | Bẫy "out" của VNG vẫn đưa người chơi ra tiền tuyến. Bẫy "in" được vá trong ptfix để đọc phe ở task 2341 thay cho task 423 |
| Placeholder 1071 | 5 NPC "Nguyen Soai / Tuong Linh / Tiep Dan" | Được đổi tên và gắn lại script `vienco\vc_info.lua`: xem chiến cục, về doanh trại, về Phong Thần Đài. File `npc_restore\1071_0x.lua` vẫn giữ trên đĩa |

**Quân NPC** (38 con mỗi trận; hết trận thì xóa, chết thì engine cho hồi sinh tại chỗ):

| Loại | Thương (camp 1) | Chu (camp 2) | Số lượng / phe | Công trạng | Điểm phe |
|---|---|---|---|---|---|
| Binh | tpl 116 商军校尉, cấp 55, "Thương Binh" | tpl 1952 守卫士兵, cấp 55, "Chu Binh" | 12 | +1 | +1 |
| Thám quân | tpl 116, cấp 65 | tpl 1952, cấp 65 | 4 | +3 | +1 |
| Soái kỳ | tpl 419 商旗, cấp 55 | tpl 420 周旗, cấp 55 | 2 | +10 khi mang về giao chủ tướng | +5 |
| Vật tổ | tpl 417 商朝图腾, cấp 65 | tpl 418 周朝图腾, cấp 65 | 1 | +5 | +3 |

- Mỗi phút, mỗi phe được cộng thêm 1–3 điểm "tự động", tượng trưng cho quân NPC tự giao chiến.
  - Người chơi đứng yên vẫn có thể thua.
  - Phe nào có người chơi tích cực thì gần như chắc thắng.
- Vị trí đã kiểm tra trên lưới Region_S của 商周战场: mọi ô đều đi được và cùng vùng liên thông với tiền tuyến.

**Vị Quốc Lập Công** (VNG `姜尚.lua accmission`, bảng xác suất `RootProb` theo đẳng cấp):
- Mã nhiệm vụ: `1000+n` hạ n quân địch, `2000+n` đoạt n soái kỳ, `3000+n` phá vật tổ n lần, `4000+n` hạ n thám quân, `5001` giúp phe thắng.
- Mỗi trận nhận 1 nhiệm vụ, tối đa 3 nhiệm vụ mỗi ngày.
- Hoàn thành nhiệm vụ (trạng thái 1) rồi ở lại đến khi tổng kết thì chuyển sang trạng thái 2, nhận thưởng ở Viễn Cổ Chiến Sứ.
- Nhiệm vụ "thắng" chỉ tính khi phe mình thắng.
- Rời trận trước khi xong thì nhiệm vụ đang làm bị hủy (như VNG).

**Tổng kết (phút 45):**
- Phe nhiều điểm hơn thắng.
- Mỗi người tham gia nhận kinh nghiệm `cấp × công trạng × 30`; công trạng tính tối đa 300; phe thắng nhân 1,5.
- Người chơi được đưa về Phong Thần Đài (1510/3289) và trả lại camp gốc.
- Có tin toàn server: tỉ số, phe thắng, dũng sĩ đệ nhất.
- Người chơi offline lúc tổng kết được xử lý lần sau khi nói chuyện với Chiến Sứ (`PTVC_Lazy`).

**Phần thưởng Vị Quốc Lập Công** (VNG `武王.lua reward_normal / reward_add`, chỉ dùng vật phẩm có sẵn):
- Kinh nghiệm `cấp × (đẳng cấp × 100 + 2000) × 2`, ví dụ cấp 60, đẳng cấp 0 nhận 240.000.
- 3 vạn lượng.
- Tỉ lệ 1/3 nhận **Lam bảo thạch** (3/41).
- Cứ 2 lần nhận thưởng thì tăng 1 đẳng cấp chiến trường (tối đa 10).
- Lên đẳng cấp 4: giáp **Tinh Cang / Thái Ất / Giác Thú** (0/2/6–8, cấp 5). Lên đẳng cấp 10: **Khai Thiên / Thông Thiên / Lam Điêu** (cấp 7), theo hệ nhân vật.

### 2.2 Biến và trạng thái
| Biến | Ý nghĩa |
|---|---|
| Task 2340 | Mã trận đã tham gia (mmddHHMM) |
| Task 2341 | Phe: 1 Thương, 2 Chu, 0 không trong trận |
| Task 2342 / 2343 | Công trạng trận này / tổng công trạng |
| Task 2344 | Vị Quốc Lập Công (mã ở 2.1) |
| Task 2345 / 2346 | Đẳng cấp chiến trường / số lần thưởng tích lũy |
| Task 2347 / 2348 | Ngày nhận nhiệm vụ / số nhiệm vụ đã nhận trong ngày |
| Task 2349 | Đang cầm soái kỳ (mã trận) |
| Task 2355–2360 | Giang Sơn Y Cựu: bước, trạng thái, giai đoạn, số đã diệt, thời điểm triệu hồi, đã xong toàn bộ |
| GV 2340 / 2341 | Trạng thái trận (2 = đang đánh) / mã trận |
| GV 2342 / 2343 | Điểm phe Thương / phe Chu |
| GV 2344 / 2345 | Mã trận vừa tổng kết / phe thắng |
| GV 2346 | Phút kết thúc trận (giờ × 60 + phút) |
| GV 2350–2369 | 20 ô người tham gia (PlayerIndex; kiểm tra bằng `GetPlayerID` và task 2340) |

### 2.3 Giang Sơn Y Cựu – chuỗi 19 bước tại Dư Khánh (Triều Ca 1560/3200, tọa độ hiển thị 195/200 theo taskinfo)
- Mỗi bước: nhận ở Dư Khánh, mục tiêu riêng của người chơi xuất hiện ngay trên bản đồ của bước (không cần có mặt), diệt xong thì về phục mệnh.
- Mục tiêu tồn tại 30 phút. "Triệu hồi lại" được sau 10 phút. Có thể hủy bước.
- Kill đếm qua `LastDamage` (`gs_mob.lua`). Người chơi trong tổ đội diệt hộ vẫn tính nếu đang ở cùng bước.

| # | Taskinfo | Bước | Bản đồ | Mục tiêu (template) | Cấp |
|---|---|---|---|---|---|
| 1 | 1053 Hoang Mạc biên | Sa Hồn | 1022 Hoang Mạc | 3 × Sa Hồn (17) | 30 |
| 2 | 1053 | Đao Cầm Xanh | 1022 | 1 × Sa Hồn Thủ Lĩnh (1253), đặt tên "Đao Cầm Xanh" | 30 |
| 3 | 1053 | Hoa Trư | 1022 | 4 × Hoa Trư (108) | 30 |
| 4 | 1054 Đông Hải biên | Lục Quy | 1037 Đông Hải Thủy Vực | 3 × Võ Sĩ Quy (19), đặt tên "Lục Quy" | 32 |
| 5 | 1054 | Hỏa Ngư | 1037 | 3 × Hỏa Ngư (21) | 32 |
| 6 | 1054 | Thiết Ngư Vương | 1037 | 1 × Hỏa Ngư Thủ Lĩnh (1257) | 35 |
| 7 | 1055 Ảo cảnh biên | Thiết Bố | 1026 Sa Mạc Chết (bảo đồ 185/196) | Cự Thạch Thần (30), rồi Hạ Canh Thi Vương (33), rồi Thiết Bố (980 混沌幻象) | 60 |
| 8 | 1055 | Kim Trại | 1041 Long Uyên (bảo đồ 201/212) | Mỹ Nữ Bạng (34), rồi Khai Minh Thần (38), rồi Kim Trại (981 穷奇幻象) | 70 |
| 9 | 1081 Quyển 2 | Hàng biểu | 1026 | 1 × Hạ Canh Thi Vương Thủ Lĩnh (1266) | 60 |
| 10 | 1056 Hiên Viên thiên | Phi Giáp | 1033 | 5 × Phi Giáp (32) | 60 |
| 11 | 1056 | Hỏa Tà | 1029 | 5 × Hỏa Tà (35) | 60 |
| 12 | 1056 | Lôi Trạch Thần | 1031 | 5 × Lôi Trạch Thần (41) | 60 |
| 13 | 1055 | Côn Bối | 1031 | 3 × Đầu Lĩnh Lôi Trạch Thần (985), rồi Côn Bối (982 饕餮幻象) | 70 |
| 14 | 1057 Băng Xuyên thiên | Băng Linh | 1032 | 5 × Băng Linh (27) | 60 |
| 15 | 1057 | Dã Mao Thần | 1036 | 5 × Dã Mao Thần (42) | 60 |
| 16 | 1055 | Lam Bá | 1036 (bảo đồ 162/212) | 3 × Hoàng Kim Võ La Thần (986), rồi Lam Bá (983 梼杌幻象) | 80 |
| 17 | 1058 Khổn Tiên thiên | Huyễn Linh | 1047 | 5 × Huyễn Linh (47) | 80 |
| 18 | 1058 | Lục Ngô Thần | 1051 | 3 × Lục Ngô Đại Thần (49) | 80 |
| 19 | 1058 | Đại Điêu | 1051 (gần bảo đồ Khổn Tiên) | Đại Điêu (10 蛊雕) | 80 |

- **Thưởng mỗi bước:**
  - Kinh nghiệm `cấp yêu cầu² × 40`, gấp đôi với bước có boss nhiều giai đoạn.
  - Bạc `cấp yêu cầu × 300` lượng.
- **Vật phẩm khi xong mốc:**
  - Bước 6: 1 Lam bảo thạch.
  - Bước 8: 1 Quả nhân sâm (3/81).
  - Bước 13: 1 Lam bảo thạch.
  - Bước 16: 1 Lam bảo thạch + 1 Quả nhân sâm.
  - Bước 19: 2 Lam bảo thạch + 1 Quả nhân sâm.
- Hoàn tất cả chuỗi có tin toàn server.
- **Chỗ phải thay thế vì dữ liệu VNG mất** (bám sát chữ taskinfo nhất có thể):
  - Các quái "xanh" (tinh anh) dùng template Thủ Lĩnh hoặc quái thường, đặt lại tên.
  - Bỏ các vật phẩm "Lưu Ly Trản" và "Nga Mao bút".
  - Bỏ trạng thái "giải cứu".
  - Bỏ hội thoại Bàn Cổ. Đại Điêu xuất hiện ở Khổn Tiên tầng 5 thay vì Bích Du.
  - Lam Bá không bỏ chạy khi hộ vệ chết; ở đây diệt hộ vệ trước thì Lam Bá mới hiện thân.
- Tọa độ mục tiêu lấy từ quần thể quái sinh ra (`spawn_10xx.lua`) hoặc từ tọa độ bảo đồ VNG. Mọi tọa độ đã kiểm tra đi được trên lưới Region_S.

### 2.4 File
| File | Loại |
|---|---|
| `Server\script\phongthan\ext\vienco.lua` | Ext tick: đăng ký script, NPC cố định, nhận placeholder, lịch trận, quân NPC, tổng kết |
| `Server\script\phongthan\vienco\vc_lib.lua` | Thư viện chiến trường: hằng số, điểm, nhiệm vụ, thưởng |
| `vc_chiensu.lua`, `vc_general.lua`, `vc_vantrong.lua`, `vc_khuongthuong.lua`, `vc_info.lua`, `vc_mob.lua` | NPC báo danh, chủ tướng, placeholder, action script của quân (LastDamage) |
| `gs_data.lua`, `gs_lib.lua`, `gs_dukhanh.lua`, `gs_mob.lua` | Giang Sơn Y Cựu: dữ liệu (mỗi bản ghi một câu lệnh), logic, NPC Dư Khánh, action script mục tiêu |
| `scratchpad\ptfix\extra_vienco.py` | Plug-in ptfix (chỉ Server): thay `新古战场\姜尚.lua` / `闻仲.lua` bằng stub gọi `vc_general.lua` (phe 2 / 1); vá bẫy `周营in` / `商营in` dùng task 2341 |
| `scratchpad\vienco\mk_vienco.py`, `positions.py`, `positions.json` | Bộ sinh mã (mọi chữ hiển thị ở TCVN3, file Lua giữ ASCII) và bộ tính tọa độ đi được |
| `scratchpad\qtest\sim_vienco.lua` | Mô phỏng (giả lập stack engine; tham số `noemu` chạy `-Stack 100` thường; tham số `runtime` đọc bản đã triển khai) |

Toàn bộ là file mới, không sửa file dự án có sẵn, nên không cần sao lưu.

### 2.5 Kiểm thử đã chạy
- `sim_vienco.lua`:
  - Ở cả 3 chế độ: giả lập stack (`-Stack 0` + đệm 47/40), `-Stack 100` thường, và đọc bản runtime.
  - Kết quả **FAILS=0, 63 OK**.
  - Độ dư stack thấp nhất: 44 khung ở NPC (engine 47), 37 khung ở ext tick (engine 40). Không tràn stack.
- Hồi quy: `sim_questfix` (TOTAL FAILS = 0), `sim_tta` (TOTAL FAILS = 0, trùng file mẫu), `sim_questaudit`, `sim_tutuong_b` (không có FLAG lỗi mới), `t_st` (nạp servertimer OK).
- Build ptfix nháp: Client rồi Server, `scratchpad\vienco\ptfix_test_client.pak` (40 mục) và `scratchpad\vienco\ptfix_test.pak` (501 mục). Plug-in vienco thay 4 mục.

### 2.6 Đề xuất C++ (không bắt buộc)
Các sách `\script\item\江山卷1..3.lua` (file rời) gọi `OpenNpcCollectionDlg(n)`, hàm chưa đăng ký nên bấm sách sẽ lỗi Lua. Chuỗi Giang Sơn mới không dùng sách. Nếu muốn sách không báo lỗi, agent sở hữu C++ có thể thêm stub sau vào `PhongThanSource\Sources\Core\Src\ScriptFuns.cpp`:
```cpp
// cạnh LuaSearchPlayerByIdCompat
int LuaOpenNpcCollectionDlgCompat(Lua_State *L)
{
    return 0;   // VNG UI "NPC collection" (Giang Son Y Cuu books) does not exist in this client
}
// bảng đăng ký, cạnh {"SearchPlayerById", LuaSearchPlayerByIdCompat},
    {"OpenNpcCollectionDlg", LuaOpenNpcCollectionDlgCompat},
```

### 2.7 Áp dụng C++ (agent cppbatch, 2026-10-03)
- Stub ở mục 2.6 đã có trong bản vá chung `scratchpad\cppbatch\cpp_patch.md`:
  - hàm `LuaOpenNpcCollectionDlgCompat` nằm trong header mới `PhongThanLuaCppBatch.h`, được include trong khối `_SERVER` của `ScriptFuns.cpp` (hunk **H1**);
  - đăng ký `{"OpenNpcCollectionDlg", ...}` ngay sau `{"AddTotemNpc", ...}` (hunk **H2**).
- Chỉ cần build lại **CoreServer**. Sách 江山卷1..3 sẽ đóng hội thoại mà không báo lỗi Lua. Phần trả lại vật phẩm 6/1/502, 6/1/503 trong sách vẫn chạy như cũ. Chuỗi Giang Sơn tại Dư Khánh không thay đổi.
- Đã biên dịch Server Release và build thật `CoreServer.dll` trên bản sao nguồn: OK. DLL có chuỗi `OpenNpcCollectionDlg`.
- Trạng thái: **chờ coordinator chạy `apply_patch.py` và build CoreServer**.

## Phần 3: Hành động

### Checklist người dùng thử trong game (sau khi tự khởi động lại server, triển khai ptfix nếu muốn có stub 姜尚/闻仲 và bẫy)
- [ ] Phong Thần Đài, khoảng (189/205): có NPC **Viễn Cổ Chiến Sứ**. Hội thoại hiện chiến cục và số phút còn lại.
- [ ] Phút 00–44 của bất kỳ giờ nào, nhân vật cấp 50 trở lên chọn Vào chiến trường → Quân Chu: mất 5 vạn, vào doanh trại phía đông map Chiến trường.
- [ ] Nói chuyện với **Khương Thượng**: nhận Vị Quốc Lập Công, xem F11 có dòng "'Vị Quốc Lập Công': …".
- [ ] Chọn **Xuất trận**: Chu Binh không đánh mình; Thương Binh, Thám Quân, Soái Kỳ, Vật Tổ là kẻ địch. Đánh được và công trạng tăng.
- [ ] Diệt Soái Kỳ Thương, quay về Khương Thượng: báo +10 công trạng.
- [ ] Đến phút 45: tự về Phong Thần Đài, có tin toàn server. Nếu đã hoàn thành nhiệm vụ thì nhận thưởng ở Chiến Sứ.
- [ ] 5 NPC placeholder trên map Chiến trường hiển thị tên mới (Nguyên Soái Chiến Trường, Tướng Lĩnh, Tiếp Dẫn) và menu "Về Phong Thần Đài".
- [ ] Triều Ca, khoảng (195/200): có **Dư Khánh** → Giúp Dư Khánh → Nhận nhiệm vụ → 3 Sa Hồn (Giang Sơn) xuất hiện ở Hoang Mạc (189/221). Diệt xong về phục mệnh.
- [ ] Báo lại nếu quân NPC (soái kỳ, vật tổ) tự đi lại hoặc đứng sai chỗ: chỉnh template hoặc cấp trong `mk_vienco.py` (`army_tpl`).

### Việc cho coordinator
| Việc | Ai | Khi nào |
|---|---|---|
| Không cần thêm hook servertimer: `vienco` đã có trong `PTADM_EXT_NAMES` | — | — |
| Đưa `extra_vienco.py` vào lần build ptfix chính thức (độc lập thứ tự với plug-in khác) | coordinator | lần build tới |
| Dán dòng CHANGELOG và thêm dòng README | coordinator | ngay |
| (Tùy chọn) Stub `OpenNpcCollectionDlg` (2.6): đã có trong `scratchpad\cppbatch\cpp_patch.md` (H1, H2), áp dụng bằng `apply_patch.py` rồi build CoreServer (mục 2.7) | coordinator | khi C++ được nhả |

## Phần 4: Tài liệu tham khảo
- **Script VNG đã đọc:**
  - `新古战场\远古战场.lua`, `远古战场on/start/bonustime/off.lua`, `姜尚.lua`, `闻仲.lua`;
  - `周营in/out`, `商营in/out`, `周旗/商旗`, `周朝图腾/商朝图腾`, `医生`, `储物箱`;
  - `封神台\神碑2.lua`, `西岐\武王.lua`;
  - `item\江山依旧地图{沙漠,东海,轩辕,冰川,捆仙}.lua`, `item\江山卷1..3.lua`.
- **Dữ liệu:**
  - taskinfo 47, 85, 1053–1058, 1081 (`questaudit\steps.py`);
  - `Npcs.txt` (template 10, 17, 19, 21, 27, 30–49, 108, 116, 301, 417–420, 766, 980–986, 1253–1266, 1520, 1952);
  - `MapList.ini`, lưới Region_S (`vantien\impl\mapgrid.py`).
- **Engine:** `KNpc.cpp:1718` (LastDamage), `KNpcSet.cpp GenOneRelation` (quan hệ camp), `ScriptFuns.cpp` (SetCurCamp, SetNpcCurCamp, SearchPlayerById, GetPlayerID).
- **Tài liệu liên quan:** `kiem-toan-nhiem-vu-phong-than-20261002.md` (mục 18, 19), `tien-ma-gioi-*`, `van-tien-tran-phong-than-20261002.md`.
- **Bước tiếp theo đề xuất:**
  - Đưa thưởng Vị Quốc Lập Công vào luôn Võ Vương / Trụ Vương (file của agent khác).
  - Thêm trận PvP thật khi có nhiều người chơi; giữ PvE làm mặc định.
