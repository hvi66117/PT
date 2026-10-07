# Lễ Quan, Sinh hoạt (kỹ năng sống) và Linh thú

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Người làm: agent `sinhhoat`
> Trạng thái: **Đã làm bằng Lua và dữ liệu, chờ cài ptfix.**
> - Script Lua đã nằm trong `Server\script\phongthan\sinhhoat\` và `ext\sinhhoat.lua`. Servertimer đã có sẵn tên `sinhhoat` nên tick chạy ngay khi server chạy.
> - Vật phẩm mới và các script tên tiếng Trung nằm trong plug-in `extra_sinhhoat.py`. Bản build thử Client và Server đều đạt. Cần build ptfix chính thức, cài, rồi khởi động lại server và game.
> - Không sửa C++. Phần cần C++ để linh thú hoàn chỉnh như VNG có đề xuất chi tiết ở mục 2.6.

## Phần 1: Tổng quan

### Insight chính
1. **Lễ Quan ở mọi thành chỉ là stub 189 byte.** Bốn script VNG `\script\{封神台, 崇城大营, 朝歌, 瑶池}\礼官.lua` chỉ có một câu "Ta phụ trách công bố các sự kiện mới nhất".
   - 195/239 script `活动脚本` (sự kiện) bị mất. Engine cũng không đọc `systemtimetask.txt`, nên không lịch sự kiện nào tự chạy.
   - Tây Kỳ, Triều Ca và 3 thôn tân thủ không có NPC Lễ Quan nào. Chỉ Diêu Trì có, nhưng gắn file GBK rời, engine không mở được.
2. **Sinh hoạt (kỹ năng sống) mất toàn bộ phần NPC.**
   - Vẫn còn đủ dữ liệu: 46 nguyên liệu sống trong `material.txt` (thảo dược 910–925, khoáng thạch 928–937, cá 944–955, tinh hoa 956–971, thịt 972–983, Thủy Tinh Nguyên Thạch 1001–1004) và taskinfo 1200–1202, 1509–1513.
   - Nhưng không có Sinh Hoạt Sư (`生活技能老师` thiếu ở 5 thành) và không có điểm thu thập. Các hàm VNG `GetLiveSkillLevel`, `AddLvSkillFormula`… cũng không có hệ thống thật phía sau.
3. **Linh thú VNG cần C++, nhưng phần nhìn thấy được vẫn còn.**
   - `common\属性灵宠.luax` (201 KB) dùng `require`, `module`, `table.*`, `PetSetType`, `PetModifyProtect` và bảng NPC kiểu "pet" (Kind 10). Engine dựng lại không có các API này.
   - Npcs.txt (Server và Client) **còn đủ 32 mẫu NPC của 8 linh thú × 4 giai đoạn** (2486–2536), kèm tài nguyên hình ở client (`胡喜媚幼体`…). Vì vậy linh thú hiện hình được.
   - Mẫu Kind 10 nằm ngoài bảng quan hệ kind × camp của engine (`kind_num = 6`). Đặt thẳng ra map có nguy cơ đọc tràn mảng. Cách xử lý: đổi sang Kind 0 trước lần đồng bộ đầu tiên.

### Cách làm (một câu)
Viết lại ba hệ thống bằng Lua theo đúng taskinfo và dữ liệu VNG còn sót, đặt NPC bằng ext tick, thêm 12 vật phẩm qua ptfix, và dùng `AddTotemNpc` (AI 11) để linh thú đi theo chủ.

## Phần 2: Chi tiết

### 2.1 Sự kiện Lễ Quan (`sinhhoat\lq_*.lua`)
- **NPC:** 5 Lễ Quan (mẫu 154) đặt theo tọa độ taskinfo:
  - Tây Kỳ 1472/3052, Triều Ca 1757/3066;
  - Sùng Thành 1599/3159, Ngọc Hư 1767/3160, Xi Vưu Mộ 1606/3322.
  - Bốn script GBK `礼官.lua` (gồm Diêu Trì) được ptfix chuyển tiếp về `lq_npc.lua`, nên NPC VNG nào gắn đường dẫn cũ cũng chạy đúng.
- **Giờ lễ hội:** 12:00–13:59 và 19:00–22:59 (giờ máy chủ). Ext tick thông báo toàn server lúc 12:00/19:00 (mở) và 13:55/22:55 (sắp đóng).

| Hoạt động | taskinfo | Luật | Phần thưởng |
|---|---|---|---|
| Lễ vật hằng ngày | — | Mỗi ngày 1 lần, giờ nào cũng được | cấp² × 10 + 2.000 kinh nghiệm, 2 Linh Thú Đơn, 1 thảo dược |
| Tam Nguyệt Kỳ Sơn | 1029 (tối), 1617 (trưa) | Trong giờ lễ hội: nhận Hạt Giống Kỳ Sơn (tối đa 3/ngày). Đến **Kỳ Sơn (1017)** nhấp phải để trồng. Cây (mẫu 1808) chín sau 5 phút; chỉ người trồng hái được; cây tự biến mất sau 30 phút | cấp² × 20 + 5.000 kinh nghiệm, 3 thảo dược, 10% Trứng Linh Thú |
| Khiêu chiến cực hạn | 204 (tối), 1615 (trưa) | Trong giờ lễ hội: nhận Chiến Thư (tối đa 2/ngày). Ra ngoài thành nhấp phải: 6 Heo Rừng + 1 Trư Vương (mẫu 1369/1370, cấp = cấp người chơi) xuất hiện. Hạ hết trong 10 phút | cấp² × 40 + 10.000 kinh nghiệm, cấp × 300 lượng, 2 Linh Thú Đơn, 8% Trứng Linh Thú |

- **Đếm quái:** không sửa `npcdeath\normal.lua`. Mỗi con heo gắn `lq_mob.lua`. Engine gọi `LastDamage` với `PlayerIndex` là người hạ (KNpc.cpp, `DoDeath`).
  - Chủ được nhận diện qua param NPC (mã người chơi rút gọn và giờ bắt đầu). Người khác hạ thì không tính.
  - Mẫu 1369/1370 không có DeathScript nên không hồi sinh. Mỗi con còn có hạn sống 10 phút (`Timeout`).
- **Sổ nhiệm vụ (F11):** ghi bằng `AddNote` với chữ tiếng Việt khớp luật mới (không nạp bảng taskinfo 280 KB).

### 2.2 Sinh hoạt: thu thập (`sh_node.lua`)
- **30 điểm thu thập** do ext tick đặt; ô đứng đã kiểm trên lưới Region_S bằng `scratchpad\sinhhoat\pos.py`:
  - Bụi Thảo Dược (mẫu 1870): Sùng Thành dã ngoại, Chân núi Côn Lôn, Miêu Cương, Kỳ Sơn, mỗi nơi 3 điểm.
  - Mạch Khoáng (mẫu 1738): Yến Sơn, Cự Lộc, Thủ Dương sơn.
  - Điểm Câu Cá (mẫu 1456): Bắc Hải, Mạnh Tân, Đông Hải Thủy Vực.
- **Luật:**
  - Mỗi lần bấm thu được 1 nguyên liệu, cách nhau tối thiểu 3 giây.
  - Mỗi điểm dùng được 5 lần rồi biến mất, 3 phút sau ext tick đặt lại.
  - Cấp nguyên liệu ngẫu nhiên trong khoảng [cấp kỹ năng − 2, cấp kỹ năng].
  - Khai khoáng: 20% ra 2 viên. Từ cấp 4 có 5% ra Thủy Tinh Nguyên Thạch.
- **Sách kỹ năng sống 62/128** (theo `bi-kip-he-phai-phong-than-20261002.md`):
  - **Bàn Cổ Khai Thiên (62)** là điều kiện để khai khoáng.
  - **Ban Môn Lộng Phủ (128)** là điều kiện để luyện đơn, hỏa trù.
  - Học bằng bí kíp ở Võ sư, hoặc nhờ Sinh Hoạt Sư dạy với giá 2.000 lượng.
- **Cấp kỹ năng:** mốc điểm 0/20/60/120/220/360/560/820/1150/1600 cho cấp 1→10. Cấp 10 chỉ mở sau khi lên Tôn Sư.

### 2.3 Sinh hoạt: Sinh Hoạt Sư (`sh_master.lua`)
- **NPC:** 5 Sinh Hoạt Sư (mẫu 167) ở Tây Kỳ, Triều Ca, Sùng Thành, Ngọc Hư, Xi Vưu Mộ, cạnh Tạp Thương.
  - Hai đường dẫn VNG đã mất `生活技能老师（大营/朝歌）.lua` được thêm vào ptfix, chuyển tiếp về `sh_master.lua`.
- **Nhiệm vụ nhập môn:**

| taskinfo | Nhiệm vụ | Giao | Thưởng |
|---|---|---|---|
| 1200 | Lần Đầu Hái Thuốc | 1 Bạch Trà | 3.000 kinh nghiệm, 1.000 lượng, +10 điểm kỹ năng |
| 1201 | Lần Đầu Khai Khoáng | 1 Hoàng đồng | như trên |
| 1202 | Lần Đầu Câu Cá | 1 Tôm xanh | như trên |

- **Chế tác** (nguyên liệu phải để trong hành trang; thiếu thì trả lại, không mất gì):

| Công thức | Kỹ năng/cấp | Nguyên liệu | Sản phẩm |
|---|---|---|---|
| Tinh luyện | Luyện đơn ≥ cấp nguyên liệu | 2 thảo dược cùng loại | 1 tinh hoa tương ứng |
| Sơ chế | Hỏa trù ≥ cấp nguyên liệu | 2 cá cùng loại | 1 thịt tương ứng |
| Tiểu Hồng/Tiểu Hoàn Đơn ×5 | Luyện đơn 1 | 1 tinh hoa cấp 1–3 | 5 bình (1/0/0, 1/3/0) |
| Trung Hồng/Trung Hoàn Đơn ×5 | Luyện đơn 4 | 1 tinh hoa cấp 4–6 | 5 bình (1/1/0, 1/4/0) |
| Đại Hồng/Đại Hoàn Đơn ×5 | Luyện đơn 7 | 1 tinh hoa cấp 7+ | 5 bình (1/2/0, 1/5/0) |
| Linh Thú Đơn | Luyện đơn 2 | 1 tinh hoa + 1 thịt | 1 Linh Thú Đơn |
| Canh dưỡng linh thú | Hỏa trù 3 | 2 thịt | 2 Linh Thú Đơn |
| Mâm cỗ | Hỏa trù 1 | 5 thịt | cấp × 200 × cấp Hỏa trù kinh nghiệm |
| Chế luyện thủy tinh | Khai khoáng 4 | 1 Thủy Tinh Nguyên Thạch | 1 mảnh Hồng/Lục/Lam/Hoàng thủy tinh |

  - Mảnh Hồng thủy tinh dùng tiếp cho "Đóng sách" bí kíp ở Võ sư.
- **Đơn đặt hàng hằng ngày** (3 đơn/ngày): lần lượt 10 thảo dược, 10 khoáng thạch, 10 cá (loại nào cũng được).
  - Thưởng: cấp² × 12 + 5.000 kinh nghiệm, cấp × 200 lượng, +5 điểm kỹ năng.
  - 30% tặng thêm Linh Thú Đơn.
- **Tôn Sư** (taskinfo 1509 Khai Khoáng, 1510 Thu Thập, 1511 Điếu Ngư, 1512 Luyện Đơn, 1513 Hỏa Trù):
  - Điều kiện: kỹ năng đạt cấp 9, nộp 10 nguyên liệu cấp 8+ của kỹ năng đó và 500.000 lượng.
  - Kết quả: mở cấp 10 và thưởng cấp² × 50 kinh nghiệm.

### 2.4 Linh thú (`lt_*.lua`)
| # | Linh thú | Mẫu NPC 4 giai đoạn | taskinfo | Tên giai đoạn |
|---|---|---|---|---|
| 1 | Hồ Hỷ Mị | 2486–2489 | 2035–2038 | Tu Vi, Trúc Cơ, Hóa Hình, Đại Thành |
| 2 | Na Tra | 2490–2493 | 2039–2042 | Cố Bản, Hóa Nhân, Tán Tiên, Kim Tiên |
| 3 | Lôi Chấn Tử | 2510–2513 | 2047–2050 | Ước Nguyện Tuổi Thơ … Lôi Công Chân Thân |
| 4 | Thạch Cơ | 2515–2518 | 2051–2054 | Thiên Giáng Kỳ Thạch … Thạch Cơ Nương Nương |
| 5 | Thái Ất | 2520–2523 | 2055–2058 | Luân Hồi Tiểu Đạo … Thái Ất Chân Nhân |
| 6 | Đắc Kỷ | 2525–2528 | 2059–2062 | Hồ Yêu Xuất Sơn … Khoác Xiêm Y Rực Rỡ |
| 7 | Thân Công Báo | 2529–2532 | 2063–2066 | Đạo Đồng … Báo Săn |
| 8 | Hoàng Phi Hổ | 2533–2536 | 2067–2070 | Binh Sĩ … Khai Quốc Võ Thành Vương |

- **Nhận linh thú:**
  - Linh Thú Sứ (mẫu 181, Tây Kỳ 1478/3060, Triều Ca 1763/3074) tặng **con đầu tiên miễn phí** (chọn 1 trong 8) và Linh Thú Lệnh.
  - Trứng các con khác: đổi 20 Linh Thú Đơn + 100.000 lượng, hoặc nhận ngẫu nhiên từ hoạt động Lễ Quan.
  - Trứng giao dịch được. Trứng của con đã có thì được giữ lại.
- **Dùng (Linh Thú Lệnh, vĩnh viễn):** triệu hồi/thu hồi, gọi về bên cạnh, đổi linh thú, cho ăn Linh Thú Đơn (1 hoặc 10 viên), xem trạng thái.
- **Cách hiện hình:**
  - `AddTotemNpc(mẫu giai đoạn, cấp chủ, …)` đặt chủ và bật AI 11 (đi theo chủ).
  - `SetNpcKind(npc, 0)` đổi Kind 10 thành Kind 0 trước lần đồng bộ đầu tiên. Client cũng lấy Kind từ gói đồng bộ (`KProtocolProcess::SyncNpc`), nên không đọc tràn bảng quan hệ.
  - `SetNpcOwner` chép máu tối đa của chủ. Linh thú không có kỹ năng chiến đấu, giống linh sủng thuộc tính của VNG: nó đi theo chủ, không gây sát thương.
- **Lên cấp:**
  - Mỗi phút ext tick xét người đang có linh thú ngoài map. Nếu chủ đang ở trạng thái chiến đấu: linh thú +1 điểm, chủ +cấp × 10 × giai đoạn kinh nghiệm.
  - Từ giai đoạn 2, cứ 10 phút chiến đấu linh thú "tha về" 1 nguyên liệu.
  - Linh Thú Đơn: +30 điểm mỗi viên.
  - Điểm cần để lên cấp L: 10 + 2L. Giai đoạn s giới hạn cấp s × 10; quá giới hạn thì đồ ăn được trả lại.
- **Tiến hóa** (Linh Thú Sứ; đủ cấp giới hạn, nguyên liệu để trong hành trang):

| Từ → đến | Điều kiện |
|---|---|
| 1 → 2 | cấp 10, 10 tinh hoa cấp 1–3, 10 thịt cấp 1–3, 50.000 lượng |
| 2 → 3 | cấp 20, 10 tinh hoa cấp 4–6, 10 thịt cấp 4–6, 1 Mảnh Hoàng thủy tinh, 200.000 lượng |
| 3 → 4 | cấp 30, 10 tinh hoa cấp 7+, 10 thịt cấp 7+, 1 Hoàng thủy tinh, 500.000 lượng |

  - Tiến hóa xong, linh thú đang ngoài map được gọi lại bằng mẫu NPC mới.
- **Đổi map, tử vong:** AI 11 của engine tự xóa linh thú. Tick phút sau gọi lại (task 2390 = −1 nghĩa là "muốn cho ra"). Thu hồi bằng lệnh bài thì tick không gọi lại.
- **Không đụng Dị Nhân:** đệ tử Dị Nhân dùng task 1941/1942 và `m_nPetIdx` (kỹ năng 450–461). `AddTotemNpc` không dùng `m_nPetIdx`, nên hai hệ thống chạy song song. Mô phỏng kiểm tra 1941/1942 không bị ghi.

### 2.5 Dữ liệu, task, tệp
- **Biến task 2370–2399** (đã quét toàn bộ script rời và mọi PAK: không ai dùng):
  - 2370: NPC vừa nói chuyện.
  - 2371–2375: điểm 5 kỹ năng.
  - 2376–2378: nhiệm vụ 1200–1202.
  - 2379: Tôn Sư (chữ số thứ k).
  - 2380: giờ thu thập lần trước.
  - 2381–2382: đơn hàng trong ngày.
  - 2383–2387: Lễ Quan (lễ vật, hạt giống, khiêu chiến).
  - 2388: linh thú sở hữu (chữ số k = giai đoạn).
  - 2389: linh thú hiện tại.
  - 2390–2391: NPC và mẫu NPC đang triệu hồi.
  - 2392–2399: điểm của 8 linh thú.
  - **Lưu ý cho coordinator:** hệ VNG `属性灵宠` dùng 2071–2125, 2188, 2191 (trùng dải của các agent khác, nhưng script đó không chạy được trên engine này). `common_beast` dùng 2224–2244. tienma đang dùng 2222/2223. Dải 2370–2399 không chạm các dải này.
- **Vật phẩm mới** (magicscript 6/1/…, cả Server lẫn Client, giống hệt nhau):
  - 61370 Linh Thú Lệnh;
  - 61371–61378 Trứng Linh Thú (8 con);
  - 61379 Linh Thú Đơn (chồng 100);
  - 61380 Hạt Giống Kỳ Sơn (chồng 10);
  - 61381 Chiến Thư Khiêu Chiến.
- **Tệp mới** (ASCII; chữ Việt là mã thoát TCVN3 do `scratchpad\sinhhoat\gen.py` sinh từ `src\*.lua`):
  - `Server\script\phongthan\sinhhoat\`: `sh_lib.lua`, `sh_master.lua`, `sh_node.lua`, `lq_npc.lua`, `lq_tree.lua`, `lq_mob.lua`, `lq_hatgiong.lua`, `lq_chienthu.lua`, `lt_npc.lua`, `lt_lenh.lua`, `lt_don.lua`, `lt_trung_1..8.lua`;
  - `Server\script\phongthan\ext\sinhhoat.lua`;
  - `scratchpad\ptfix\extra_sinhhoat.py`.
- Không sửa file dự án nào có sẵn, nên không cần backup.

### 2.6 Đề xuất C++ (chưa làm; vòng 4 agent `coreclient` giữ mã nguồn)
1. **Chặn Kind ngoài bảng** (an toàn cho mọi mẫu VNG Kind 8/10), `Core\Src\KNpcTemplate.cpp`, ngay sau dòng 57 `g_NpcSetting.GetInteger(nNpcTempRow, "Kind", 0, (int *)&m_Kind);`:
   ```cpp
   	// Phong Than: VNG rows carry Kind 8 (carriage) and 10 (pet), outside m_RelationTable[kind_num]...
   	if ((int)m_Kind < kind_normal || (int)m_Kind >= kind_num)
   		m_Kind = kind_normal;
   ```
   Có bản vá này rồi thì Lua bỏ được `SetNpcKind(idx, 0)`, nhưng giữ lại cũng vô hại.
2. **AI 13 "bạn đồng hành"** (chỉ đi theo, không đuổi đánh quái; AI 11 hiện chạy tới quái dù không có kỹ năng).
   - `KNpcAI.cpp`, trong `switch (Npc[m_nIndex].m_AiMode)` (dòng 114–119), thêm `case 13: PhongThanCompanionFollow(m_nIndex); break;`. Thêm cả vào switch thứ hai ở dòng 250–256 nếu switch đó lọc chế độ AI.
   - Hàm mới:
   ```cpp
   static void PhongThanCompanionFollow(int nIdx)
   {
   	int nOwner = Npc[nIdx].m_nOwnerIdx;
   	if (nOwner <= 0 || !Npc[nOwner].IsAlive() || Npc[nOwner].m_SubWorldIndex != Npc[nIdx].m_SubWorldIndex)
   	{
   		SubWorld[Npc[nIdx].m_SubWorldIndex].m_Region[Npc[nIdx].m_RegionIndex].RemoveNpc(nIdx);
   		SubWorld[Npc[nIdx].m_SubWorldIndex].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
   		NpcSet.Remove(nIdx);
   		return;
   	}
   	int x, y, ox, oy;
   	Npc[nIdx].GetMpsPos(&x, &y);
   	Npc[nOwner].GetMpsPos(&ox, &oy);
   	int d = g_GetDistance(ox, oy, x, y);
   	if (d > 900)      Npc[nIdx].SendCommand(do_run, ox + 48, oy + 48);
   	else if (d > 160) Npc[nIdx].SendCommand(do_walk, ox + 48, oy + 48);
   }
   ```
   - Lua cần một hàm đặt AI. Thêm vào `PhongThanLuaWave7.h`:
   ```cpp
   int LuaSetNpcAiModeCompat(Lua_State *L)
   {
   	int nNpc = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
   	int nMode = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : -1;
   	int nOk = 0;
   	if (PhongThanIsLiveNpc(nNpc) && (nMode == 11 || nMode == 13)) { Npc[nNpc].m_AiMode = nMode; nOk = 1; }
   	Lua_PushNumber(L, nOk);
   	return 1;
   }
   ```
     Đăng ký trong `ScriptFuns.cpp`: `{"SetNpcAiMode", LuaSetNpcAiModeCompat},`.
   - Khi đã có hàm, `PTLT_Summon` trong `sh_lib.lua` chỉ cần thêm `if SetNpcAiMode then SetNpcAiMode(idx, 13) end`.
3. **Thuộc tính linh sủng (bonus chỉ số như VNG):** VNG cộng chỉ số qua IBBuff 1784–1793… (`TaskTable[...].buffid`). Kho IBBuff của engine (Wave 4) chỉ áp thuộc tính khi trùng id với một kỹ năng trạng thái. Đề xuất một trong hai cách:
   - (a) thêm vào `skills.txt` các dòng trạng thái 1784–1817 (sức mạnh/thân pháp/sinh lực theo giai đoạn), rồi Lua gọi `AddIBBuff(id, giây, cấp)` khi triệu hồi;
   - (b) hàm mới `PetSetType(type)`: ghi `TASKVALUE_PT_PET_TYPE` và cộng một bảng thuộc tính cố định vào `KNpcAttribModify` của chủ.
4. **Bảng linh thú ở client** (UI pet của VNG) và các hàm `PetModifyProtect`, `GetDropPlayer`: cần sửa client UI. Bản Lua dùng Linh Thú Lệnh thay cho bảng này.

### 2.7 Áp dụng C++ (agent cppbatch, 2026-10-03)

**Phần C++** nằm trong bản vá chung `scratchpad\cppbatch\cpp_patch.md`, áp dụng bằng `apply_patch.py`; build lại CoreServer và CoreClient.

| Đề xuất 2.6 | Hunk | Kết quả |
|---|---|---|
| 1. Chặn Kind ngoài bảng | H6 (`KNpcTemplate.cpp`), H7 (client) | Kind ≥ 6 (VNG 7–15) → `kind_normal`, không bao giờ đọc tràn `m_RelationTable`. Lua vẫn gọi `SetNpcKind(idx, 0)` (vô hại) |
| 2. AI 13 bạn đồng hành | H3, H4 (`KNpcAI.cpp`) | Đi bộ khi xa hơn 120, chạy khi xa hơn 360, **không bao giờ đánh**. Chủ đổi map, chết, ẩn thân, thoát game → linh thú bị xóa như AI 11, tick phút gọi lại |
| `SetNpcAiMode(npc, mode)` | H1, H2 + `PhongThanLuaCppBatch.h` | Chỉ nhận 11/13 và chỉ cho NPC có chủ là người chơi đang sống, nên không thể biến NPC bản đồ hay quái thành AI 13 |
| (thêm) Lỗi AI 11 | H5 | AI 11 xóa linh thú rồi vẫn ra lệnh cho ô NPC đã giải phóng; nay `return` ngay |
| 3. Cộng chỉ số linh thú | — | **Không làm.** `PetSetType` trùng tên API thẻ Dị Nhân VNG (`摄印伏魔铃\*.lua`). Cộng thẳng vào thuộc tính chủ cần sổ sách gỡ/áp lại, dễ cộng vĩnh viễn vào nhân vật. Phương án dòng trạng thái `skills.txt` là việc PAK và kỹ năng trạng thái từng gây sập server. Xem 2.5 của `cpp_patch.md` |

**Phần Lua** (đã triển khai, có cổng tự nhận biết nên chạy cả với binary cũ):
- **Chế độ linh thú** lưu ở chữ số thứ 9 của task 2388; các chữ số 1–8 vẫn là giai đoạn của 8 linh thú. Không dùng thêm task nào.
  - **Bạn đồng hành** (mặc định):
    - binary mới: `SetNpcAiMode(idx, 13)`, linh thú chỉ đi theo;
    - binary cũ (không có `SetNpcAiMode`): giữ AI 11 không kỹ năng như trước, linh thú chạy theo quái nhưng không gây sát thương. Menu có dòng cảnh báo màu đỏ.
  - **Chiến đấu:** AI 11 (`AddTotemNpc`) + `SetNpcSkill(idx, 63, 1, 1..4)`, đòn cận chiến như mẫu Dị Nhân 359. Sức mạnh và máu chép từ chủ qua `SetNpcOwner`. Chạy được ngay cả **trước khi** build C++.
  - VNG không cho linh thú thuộc tính đánh quái (mẫu 2486–2536 không có kỹ năng). Chế độ Chiến đấu là tùy chọn riêng của Phong Thần, theo yêu cầu "linh thú đánh được".
- **Linh Thú Lệnh** có thêm dòng "Chế độ: …". Đổi chế độ khi linh thú đang ở ngoài thì gọi lại ngay; khi đang thu hồi thì chỉ lưu. Tick phút gọi lại linh thú đúng chế độ đã chọn.
- **Tệp đã sửa:**
  - `scratchpad\sinhhoat\src\sh_lib.lua`: `PTLT_Mode`, `PTLT_SetMode`, `PTLT_HasCompanionAI`, `PTLT_ApplyMode`, gọi trong `PTLT_Summon`;
  - `scratchpad\sinhhoat\src\lt_lenh.lua`: menu `PTLT_ModeMenu`, `PTLT_Mode0/1`;
  - sinh lại bằng `gen.py` (không phải sửa `gen.py`) → `Server\script\phongthan\sinhhoat\sh_lib.lua` (21749 byte), `lt_lenh.lua` (5965 byte). Các tệp khác sinh lại giống hệt từng byte.
  - Backup: `E:\VL\Phong than\PT\_backup\20261003-cppbatch\` (runtime, `src`, `gen.py`, tài liệu).
- **Mô phỏng** `qtest\sim_cppbatch.lua` chạy lại toàn bộ `sim_sinhhoat.lua`, rồi thêm 19 kiểm tra chế độ (binary cũ và mới, gọi lại sau đổi map, đổi chế độ khi đã thu hồi, chỉ ghi task 2370–2399):
  - `-Stack 0` (giả lập stack engine): **FAILS=0**, headroom thấp nhất 37 khung;
  - `-Stack 100`: **FAILS=0**.

## Phần 3: Hành động

### Checklist cho coordinator
- [ ] Build ptfix chính thức cho **Client và Server**, có `extra_sinhhoat.py` (chạy sau `extra_questfix2`, trước `extra_sound`; không phụ thuộc thứ tự), cài vào cả hai bên.
- [ ] Dán dòng CHANGELOG (phần 4). Servertimer **không cần sửa**: `PTADM_EXT_NAMES` đã có `sinhhoat`.
- [ ] Người dùng khởi động lại server và game (để nạp magicscript mới và script PAK của Lễ Quan).

### Kiểm thử trong game (người dùng)
- [ ] Tây Kỳ: có **Lễ Quan** (1472/3052), **Sinh Hoạt Sư** (1571/3032), **Linh Thú Sứ** (1478/3060). Triều Ca và 3 thôn tân thủ cũng có Lễ Quan và Sinh Hoạt Sư.
- [ ] Lễ Quan → "Nhận lễ vật hằng ngày": được kinh nghiệm và 2 Linh Thú Đơn. Bấm lần 2 thì báo đã nhận.
- [ ] 12:00–13:59 hoặc 19:00–22:59: Lễ Quan → Tam Nguyệt Kỳ Sơn → nhận Hạt Giống. Đến Kỳ Sơn nhấp phải: mọc Cây Thần. 5 phút sau hái quả.
- [ ] Lễ Quan → Khiêu chiến cực hạn → nhận Chiến Thư. Ra ngoài thành nhấp phải: 7 heo xuất hiện. Hạ hết trong 10 phút thì nhận thưởng.
- [ ] Sinh Hoạt Sư → Nhiệm vụ → "Lần Đầu Hái Thuốc". Ra Sùng Thành dã ngoại bấm **Bụi Thảo Dược** lấy Bạch Trà rồi giao. F11 hiện nhiệm vụ.
- [ ] Học Bàn Cổ Khai Thiên (2.000 lượng) → đào **Mạch Khoáng** ở Yến Sơn. Câu cá ở **Điểm Câu Cá** Bắc Hải.
- [ ] Học Ban Môn Lộng Phủ → Tinh luyện 2 Bạch Trà → luyện Tiểu Hồng Đơn ×5 → dùng được.
- [ ] Linh Thú Sứ → nhận linh thú đầu tiên → nhấp phải Linh Thú Lệnh → Triệu hồi: linh thú hiện hình và đi theo. **Báo lại nếu client lỗi hoặc không thấy hình.**
- [ ] Đánh quái vài phút → Linh Thú Lệnh → Xem trạng thái: điểm tăng. Đổi map: một phút sau linh thú tự quay lại.
- [ ] Dị Nhân: dùng Lệnh Bài Triệu Hồi gọi đệ tử cùng lúc với linh thú: cả hai cùng đi theo, không con nào bị xóa nhầm.
- [ ] Linh Thú Lệnh → "Chế độ" → **Chiến đấu**: linh thú đánh quái cùng chủ (dùng được ngay, chưa cần build C++). Báo lại nếu linh thú không có hình tấn công.
- [ ] Sau khi coordinator build CoreServer (cppbatch): chọn **Bạn đồng hành** → linh thú chỉ đi theo, không chạy tới quái. Dòng cảnh báo đỏ trong menu chế độ phải biến mất.

### Giới hạn đã biết
- Linh thú không cộng chỉ số (mục 2.7: không làm, có lý do). Linh thú đánh được ở chế độ Chiến đấu (mục 2.7). Lợi ích hiện có: kinh nghiệm thêm cho chủ, nguyên liệu tha về, hình dáng theo 4 giai đoạn.
- Ở chế độ Bạn đồng hành, khi binary chưa có bản vá cppbatch, AI 11 vẫn cho linh thú chạy tới quái mà chủ đánh (không gây sát thương). Bản vá cppbatch (AI 13) sửa việc này.
- Trước khi cài ptfix mới, các NPC đã xuất hiện (ext tick chạy ngay), nhưng vật phẩm 61370–61381 chưa tạo được: phần thưởng vật phẩm sẽ không vào túi.
- Thức ăn VNG (Tôm xào…, magicscript 634–662) không có script tác dụng, nên Hỏa trù không nấu các món này.

## Phần 4: Tài liệu tham khảo

### Dòng CHANGELOG đề xuất
```
### [COMPLETED] - 2026-10-03 HH:mm
- **Thêm**: Sự kiện Lễ Quan (5 NPC; lễ vật hằng ngày; Tam Nguyệt Kỳ Sơn trồng cây ở Kỳ Sơn; Khiêu chiến cực hạn 7 heo thử thách; giờ 12:00–13:59, 19:00–22:59 có thông báo), 4 script GBK 礼官 chuyển về script\phongthan\sinhhoat\lq_npc.lua.
- **Thêm**: Sinh hoạt: 5 Sinh Hoạt Sư, 30 điểm thu thập (thảo dược/khoáng/câu cá), 5 kỹ năng sống cấp 1–10, nhiệm vụ 1200–1202, chế tác (tinh luyện, sơ chế, thuốc Hồng/Hoàn, Linh Thú Đơn, chế luyện thủy tinh), đơn hàng ngày, Tôn Sư 1509–1513; sách 62/128 là điều kiện khai khoáng/chế tác.
- **Thêm**: Linh thú: 8 linh thú × 4 giai đoạn (mẫu NPC VNG 2486–2536, taskinfo 2035–2070), Linh Thú Sứ (Tây Kỳ/Triều Ca), Linh Thú Lệnh, trứng, Linh Thú Đơn; đi theo chủ bằng AddTotemNpc (AI 11, Kind 10 → 0), lên cấp khi chiến đấu, tiến hóa; không đụng đệ tử Dị Nhân.
- **Thêm**: ptfix extra_sinhhoat.py: magicscript 61370–61381 (Server + Client), forwarder 生活技能老师. Task 2370–2399. Ext tick script\phongthan\ext\sinhhoat.lua.
```

### Mã nguồn và dữ liệu đã đọc
- **Mã nguồn C++:**
  - `KNpcTemplate.cpp` 41–57 (Kind, DeathScript);
  - `KNpcSet.cpp` 1221 (`GetRelation`, `m_RelationTable[kind_num]`);
  - `KProtocolProcess.cpp` 1490 (client lấy Kind từ gói đồng bộ);
  - `PhongThanLuaWave7.h` 294 (`AddTotemNpc`);
  - `KNpcAI.cpp` 1671 (AI 11);
  - `KNpc.cpp` 853 (`OnTimer`), 1710 (`LastDamage`);
  - `KPlayer.cpp` 7528 (`main(npcIndex)`);
  - `ScriptFuns.cpp` (`SetNpcKind`, `SetNpcParam`, `SetNpcTimer`, `GetItemCount`).
- **Dữ liệu VNG:**
  - taskinfo (`questaudit\taskinfo_list.txt`): 203–211, 1020–1105, 1200–1202, 1509–1513, 1600–1631, 2035–2070;
  - `settings\phongthan\Npcs.txt`;
  - `material.txt`, `potion.txt`, `magicscript.txt` (vng00/ptfix);
  - `common\属性灵宠.luax`, `common\common_beast.luax`.
- **Liên quan:** `kiem-toan-nhiem-vu-phong-than-20261002.md` (mục 20–22), `bi-kip-he-phai-phong-than-20261002.md`, `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `nhiem-vu-ngay-moi-phong-than-20261003.md`.

### Công cụ và kiểm thử
- **Scratchpad `sinhhoat\`:**
  - `gen.py` (sinh Lua);
  - `pos.py` (chọn ô đứng);
  - `verify_pak.py` (kiểm build);
  - `pakread.py`, `taskscan.py` (quét task 2370–2399);
  - `src\*.lua` (mã nguồn UTF-8).
- **Mô phỏng `qtest\sim_sinhhoat.lua`:**
  - `run.ps1 -Stack 0` (giả lập stack engine: 47 khung cho NPC/vật phẩm, 40 cho ext) → `out_sinhhoat.txt`: **FAILS=0**, headroom thấp nhất 37 khung;
  - `run.ps1 -Stack 100` → `out_sinhhoat_s100.txt`: **FAILS=0**, không tràn stack.
- **Build thử:** `scratchpad\sinhhoat\ptfix_test_client.pak` (Client, 41 mục) và `ptfix_test.pak` (Server, 615 mục). `verify_pak.py`: 12 dòng magicscript giống hệt giữa hai bên, 6 forwarder GBK đúng, mọi script vật phẩm tồn tại → OK.
