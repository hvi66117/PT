---
tinh-nang: Đợt native C++ (#2 missile, #3 vật phẩm VNG, #13 cường hóa + web admin)
ngay: 2026-10-05
agent: natives
trang-thai: C++ đã build (CoreServer + CoreClient + Game.exe), smoke C++ 36/0, mô phỏng Lua 60/0, test web admin 12/0 + giao diện 11/0. Chưa triển khai. Web admin đã sửa, người dùng cần tự mở lại.
tom-tat: 33 native mới, sửa GetItemPartByID cho vật phẩm magic-script, script vật phẩm nhận main(idx, thời điểm, mục tiêu, idx) như VNG, tab web admin "Cường hóa" +0..+12. 209 script VNG hết thiếu native; 29 script vật phẩm/sự kiện chạy được ngay sau khi triển khai CoreServer, 169 script còn lại nằm trong file loose tên GBK nên phải đóng gói ptfix. Phát hiện: engine không chạy script trúng đích của missile (cột ProcessScript), nên #2 cần thêm một hook C++ mới có hiệu lực.
---

# Đợt native C++ — Phong Thần (bản local)

## Phần 1: Tổng quan

### Insight chính

1. **Native #2 đã có, nhưng hiệu ứng trúng đích của missile vẫn chưa chạy.** Lý do không nằm ở native:
   - `Missles.txt` có cột 56 `ProcessScript` (28 dòng trỏ tới script, 10 script `skill\missle\*`). `KMissle.cpp` không đọc cột này. Không chỗ nào trong C++ gọi `OnHitTarget`.
   - Muốn hiệu ứng chạy phải thêm hook: đọc `ProcessScript` khi nạp missile, gọi `OnHitTarget(npcIdx)` khi missile trúng.
   - Khi làm hook phải xử lý thêm ngữ nghĩa máu. `GetNpcLife` của engine trả **máu tối đa hiện tại** (`m_CurrentLifeMax`). `SetNpcLife` ghi **cả máu lẫn máu tối đa**. Script VNG lại hiểu là máu hiện tại.
   - Bật hook mà không sửa thì mỗi đòn sét sẽ trừ luôn máu tối đa của người chơi. Mô phỏng cho thấy TestB từ 3000/3000 còn 2850/2850.
   - Đề xuất: khi chạy `OnHitTarget`, bật cờ ngữ cảnh để hai hàm này dùng máu hiện tại. Ngoài ngữ cảnh đó, hai hàm giữ nguyên vì `party.lua`, `congthanh`, `vanluong`… đang dựa vào cách cũ.
2. **Hai thay đổi ngoài native quyết định việc script VNG có chạy hay không:**
   - **Cách gọi script vật phẩm.** Engine gọi `main(idx)`, còn 242 script VNG viết `main(nLevel, nTime, nTNpcIdx, itemID)` nên `itemID = nil`, `FindAValidItemID(nil)` luôn báo "không có vật phẩm".
     - Nay `KItemList::ExecuteScript` gọi `main(idx, thời điểm dùng, mục tiêu, idx)` bằng dạng `main(a,b,c,d)` mà `KPlayer::ExecuteScript` vốn đã hỗ trợ.
     - Script của dự án `main(idx)` không đổi gì.
     - 4 bộ Thái Vân Trang `夏装` trong PAK dùng `main(l, t)`, trước đây lỗi ở `t + 2592000`, nay chạy được.
   - **`GetItemPartByID`.** Vật phẩm magic-script lưu mã VNG ở DetailType và Particular = 0 (`KBasPropTbl.CPP`, `KItem::operator=`), nên native này luôn trả 0.
     - Nay hàm trả mã VNG cho đúng loại đó. Các genre khác giữ nguyên.
     - Sửa luôn được các script ptfix `玄武*` (PTTE), nhánh xóa theo chỉ số của `nb2_scroll.lua` và `PTCompat_FindAValidItemID`. Những chỗ này trước đây âm thầm rơi vào nhánh dự phòng.
3. **Số script mở lại** (phân tích tĩnh, `S\natives\block_result.tsv`, `full_unblocked.tsv`):

   | Hạng mục | Số file |
   |---|---|
   | Script VNG gọi ít nhất một native của đợt này | 439 |
   | Hết thiếu native | **209** |
   | — engine đọc được ngay (PAK, ptfix, loose tên ASCII) | 40, trong đó 10 là missile chờ hook, 1 cần `math.` (jinglantie) |
   | — **chạy ngay sau khi triển khai CoreServer** | **29** (6 ibitem trang phục, 8 file `夏装` (4 bộ + 4 gói), 3 vật phẩm tìm kho báu, 2 quà `huo_yue`, 2 `tianlingshibao`, 5 thông báo BOSS Hoàng Kim / Quỷ Môn Khai, `六道四象小礼包`, `jinzihongbao`, `xueqiu1`) |
   | — nằm ở file loose tên GBK, engine không đọc được, **phải đóng gói ptfix** | 169, trong đó 111 dùng `math.`/`table.`/`require` (khi đóng gói phải thêm `Include pt_compat.lua`) |
   | Vẫn bị chặn: hệ linh thú `PetIsAdd/PetSetType/PetIsSleep/PetGetTime` | 148 |
   | Vẫn bị chặn: `GetTitleFunc` / `AddNormalItem4` / bang hội / Xu | 34 / 33 / ~70 |

   Con số "≈ 350 script" của báo cáo khoảng trống là trần lý thuyết. Sau đợt này, mức thật là 209 script hết thiếu native. Phần lớn số đó cần đóng gói ptfix (đợt 3 #5) mới tới tay người chơi.
4. **#13 Cường hóa** chạy được trọn vòng:
   - `SetItemUpgrade` dùng đúng bảng thuộc tính Xích Tùng Tử.
   - Món được nhấc ra rồi đặt lại đúng chỗ, nên chỉ số được tính lại qua đường mặc đồ thường, client nhận snapshot mới có `UpgradeLevel` (hiện sao), DB lưu theo `GetUpgradeState`.
   - Web admin có tab "Cường hóa": liệt kê đồ đang mặc và trong túi, chọn +N, Áp dụng.
   - Nhân vật offline thì lệnh báo thất bại, **không lưu chờ** đăng nhập.

## Phần 2: Chi tiết

### 2.1 Bảng native đã thêm

Cột "Script": số file VNG gọi / hết thiếu native / đọc được ngay. Mức độ: **Chắc** = rút ra trực tiếp từ cách script VNG gọi; **Suy luận** = engine không có dữ liệu tương ứng nên phải chọn hành vi.

| Native | Chữ ký | Ngữ nghĩa | Script | Mức độ |
|---|---|---|---|---|
| `IsPlayer` | `(npcIdx) → 0/1` | 1 khi NPC là nhân vật người chơi | 16 / 15 / 10 | Chắc |
| `GetNpcLightResist` | `(npcIdx) → %` | Kháng lôi hiện tại, kẹp ±`m_CurrentLightResistMax` như code sát thương | 5 / 5 / 5 | Chắc (phần kẹp là suy luận nhẹ) |
| `GetNpcColdResist` | `(npcIdx) → %` | Kháng băng, như trên | 1 / 1 / 1 | Chắc. Script duy nhất (`万里冰雪`) còn lỗi `table.getn` |
| `GetNpcFireResist`, `GetNpcPoisonResist`, `GetNpcEarthResist`, `GetNpcPhysicsResist` | `(npcIdx) → %` | Cùng nhóm, thêm theo yêu cầu | 0 | Chắc |
| `GetNpcLifeMax` | `(npcIdx) → số` | `m_CurrentLifeMax`; `SetNpcLife(n, GetNpcLifeMax(n))` hồi đầy | 12 / 11 / 0 | Chữ ký chắc. Phép so `GetNpcLife/GetNpcLifeMax` luôn = 1 vì `GetNpcLife` của engine trả máu tối đa |
| `FindAValidItemID` | `(itemIdx) → itemIdx/0` | Trả chỉ số khi vật phẩm tồn tại và thuộc người gọi | 161 / 29 / 0 | Chắc (kiểm tra chủ là suy luận) |
| `GetItemGen` | `(itemIdx) → genre/-1` | Genre VNG (= genre runtime) | 129 / 2 / 0 | Chắc |
| `GetItemDetail` | `(itemIdx) → detail/-1` | Detail VNG: magic-script = 1, loại khác = DetailType | 129 / 2 / 0 | Chắc |
| `IsItemBind` | `(itemIdx) → 0/1` | 1 khi khóa vĩnh viễn hoặc khóa nhân vật | 10 / 9 / 1 | Chắc |
| `SetItemBind` | `(itemIdx, bind) → 1/0` | bind > 0: khóa vĩnh viễn + đồng bộ; bind 0: để nguyên | 33 / 1 / 0 | bind 1 chắc; bind 0 suy luận |
| `DelItemByID` | `(itemIdx[, n]) → 1/0` | Trừ n chiếc (mặc định, kể cả 0, là 1) của món thuộc người gọi | 81 / 65 / 5 | Số lượng là suy luận (giống `pt_compat`) |
| `HaveNormalItemInQuick` | `(g, d, p, lv[, se]) → số` | Đếm trong thanh phím nhanh, cùng quy tắc với `HaveNormalItem`/`DelNormalItemInQuick` | 58 / 19 / 4 | Chắc |
| `AddItemPileNum` | `(g, d, p, lv, n) → số đã phát` | Phát n chiếc, gộp chồng; nguyên liệu bị bảng từ chối cấp VNG thì thử lại cấp 0 | 14 / 7 / 1 | Thứ tự tham số chắc; thử lại cấp 0 là suy luận |
| `EarnBind` | `(tiền) → 1/0` | "Lượng khóa" VNG; engine chỉ có một túi tiền nên cộng tiền thường | 32 / 23 / 1 | Suy luận |
| `GetIBItemGenTime` | `(itemIdx) → thời điểm` | Engine không lưu thời điểm tạo vật phẩm, nên trả thời điểm dùng. Đồ "hạn 30 ngày" vì vậy tính từ lúc dùng và không bao giờ quá hạn | 6 / 6 / 6 | Suy luận |
| `Time2LocalYMD` | `(t) → Y, M, D, h, m, s` | Ngày giờ địa phương của giá trị `SystemTime()` | 37 / 36 / 14 | Chắc |
| `GetServerStartTime` | `() → số ngày` | Số ngày từ khi mở server: `[ServerConfig] ServerOpenDate=yyyymmdd` trong `\settings\GameSetting.ini`, mặc định 20260901 | 29 / 8 / 0 | Đơn vị ngày chắc (script so < 7, > 30, < 90); ngày mở là cấu hình |
| `GetCompeteFlag` | `() → 0` | Cờ thi đấu VNG; engine không có trạng thái này | 27 / 26 / 0 | Suy luận |
| `CanPolyMorph` | `() → 0` | Script VNG coi 1 là **bị chặn** biến thân (`f == 1 or CanPolyMorph() == 1` → từ chối); engine không chặn | 21 / 21 / 0 | Suy luận |
| `GetGlobalStoreValue`, `SetGlobalStoreValue` | `(id[, v]) → số/1` | Kho giá trị chung toàn server, 4096 ô, ghi `Server\pt_globalstore.txt` mỗi lần Set | 8 / 3 / 0, 0 | Ngữ nghĩa chắc; lưu file là thiết kế |
| `Get/SetGlobalStoreValueByte` | `(id, 1..4[, b, save])` | Byte 1 = 8 bit thấp, giống `GetByte/SetByte` của engine; cờ save nhận rồi bỏ qua | 16 / 11 / 0, 9 / 9 / 0 | Chắc |
| `Get/SetGlobalStoreValueWord` | `(id, 1..2[, w, save])` | Word 1 = 16 bit thấp | 5 / 5 / 0, 4 / 4 / 0 | Chắc |
| `SendGlobalMessage` | `(text)` | Alias của `Msg2SubWorld`: thông báo hệ thống tới mọi người chơi | 5 / 5 / 5 (BOSS Hoàng Kim Mạnh Tân, Quỷ Môn Khai) | Suy luận |
| `AddEmoteBalloon` | `(playerIdx, emote) → 1` | Bong bóng biểu cảm; client không hỗ trợ nên không làm gì | 13 / 11 / 0 | Suy luận |
| `SetItemUpgrade` | `(itemIdx, 0..12[, rule]) → 1/0/-1…-5` | Đặt cấp cường hóa cho trang bị đang mặc hoặc trong túi. Quy tắc lấy theo thứ tự: của món → tham số → công thức Xích Tùng Tử loại 1 có đầu vào là món đó (ưu tiên công thức đi từ +0) | web admin | Thiết kế |
| `GetItemUpgrade` | `(itemIdx) → cấp, quy tắc` | Đọc cấp cường hóa | web admin | Chắc |
| `GetItemListEntry` | `(n) → idx, chỗ, x, y, itemId` | Món thứ n của người gọi, dùng cho danh sách web | web admin | Thiết kế |

Mã trả của `SetItemUpgrade`:

| Mã | Ý nghĩa |
|---|---|
| 1 | Xong |
| 0 | Người này không có món đó |
| -1 | Không phải trang bị |
| -2 | Nhân vật đang khóa hoặc đang giao dịch |
| -3 | Món không có quy tắc cường hóa (ngựa, pháp bảo…) |
| -4 | Cấp ngoài 0..12 hoặc bảng nâng cấp từ chối |
| -5 | Không đặt lại được món (đã trả về nguyên trạng) |

Mỗi lần gọi ghi một dòng vào `Server\set_item_upgrade.log`.

### 2.2 Thay đổi hành vi không phải native mới

| Chỗ | Trước | Sau | Ảnh hưởng |
|---|---|---|---|
| `GetItemPartByID` (`ScriptFuns.cpp`) | Vật phẩm magic-script luôn trả 0 | Trả mã VNG (DetailType) khi genre 6 và Particular 0 | Các script so `GetItemPartByID(idx) == <mã VNG>` chạy đúng: ptfix PTTE (6 file), `nb2_scroll`, `pt_compat` FindAValidItemID, 2.063 ấn/ seal (khi được đóng gói). Ibitem, sách kỹ năng, trang bị không đổi |
| `KItemList::ExecuteScript` | `main(idx)` | `main(idx, time(NULL), mục tiêu, idx)` | Script `main(idx)` không đổi; script VNG 2–4 tham số nhận được chỉ số vật phẩm ở tham số 4 và thời điểm ở tham số 2 |

### 2.3 Web admin

- Tab mới **Cường hóa** (`index.html`):
  1. Chọn nhân vật online, bấm "Liệt kê đồ đang mặc + trong túi". Trang tự tải lại danh sách 5 giây/lần, tối đa 75 giây.
  2. Mỗi món có ô chọn +0..+12 và nút Áp dụng. Kết quả xem ở Lịch sử lệnh.
- `PhongThan-Admin.ps1` (ASCII):
  - Action `upgradelist` / `upgradeset`.
  - `GET /api/upgrade/items` đọc `admin_bridge\upgrade_items.txt`, giải mã tên TCVN3.
  - Lua cầu nối nằm ở `AdminWeb\lua\pt_upgrade_bridge.lua`, gửi kèm mỗi lệnh nên không cần sửa `servertimer.lua`.
- Server chưa có CoreServer mới: lệnh báo "CoreServer chưa có native SetItemUpgrade".
- Người chơi nhận tin TCVN3 "Admin: trang bị được đặt cường hóa +N".

### 2.4 File đã sửa / thêm

| File | Loại | Ghi chú |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\ScriptFuns.cpp` | Sửa (vá byte) | +1 include, +37 dòng đăng ký (33 native, `SendGlobalMessage` là alias; trong `#ifdef _SERVER`, sau `RouletteBusy`), sửa `LuaGetItemPartByID`. Marker `natives-20261005` |
| `PhongThanSource\Sources\Core\Src\KItemList.cpp` | Sửa (vá byte) | `ExecuteScript`: gọi `main(idx,time,target,idx)` |
| `PhongThanSource\Sources\Core\Src\PhongThanLuaItemNatives.h` | Mới | 33 native |
| `PhongThanSource\Sources\Core\Src\PhongThanLuaItemNativesCore.h` | Mới | Quy tắc thuần (định danh VNG, kẹp kháng, byte/word, kho chung, ngày, tìm quy tắc cường hóa) |
| `AdminWeb\PhongThan-Admin.ps1` | Sửa | `Get-UpgradeLua`, `Get-UpgradeItems`, 2 action, 1 route |
| `AdminWeb\index.html` | Sửa | Nút tab, section `upgrade`, khối JS |
| `AdminWeb\lua\pt_upgrade_bridge.lua` | Mới | `PTUP_List`, `PTUP_Set` |

- Sao lưu bản gốc: `_backup\20261005-natives\` (`Core_Src\`, `AdminWeb\`, `CHANGELOG.md`, `docs_features_README.md`); bản build `build\`; file mới `new_files\`.
- Đếm marker trước và sau khi vá giống hệt: engine2 47, skilllv 18, hanhtrang 18, botheal 15, timduong 16, lbdaosi 41, kytrancac 1, daosi: 40, bot9x 2, dinhanbot 7, vancot 12, skillself 3, pet10 6, onepet 2, petrange 1, petdebug 5, petfight 2, weaponequip 2, noexppenalty 1, desertexp 2, m_bCanStack 5, partypanel 13, autofight 7, questtrack 10.
- So byte với bản sao lưu: chỉ có phần chèn, đúng 1 dòng được thay (dòng gọi `ExecuteScript`).

### 2.5 Build và kiểm thử

| Kiểm thử | Kết quả | File |
|---|---|---|
| `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient` | OK, 0 lỗi (CoreServer 10 s, CoreClient 8 s, GameClient 10 s) | `Build\LogsModern\*.log` |
| Smoke C++: biên dịch `PhongThanLuaItemNativesCore.h` + `PhongThanComposeRecipe.h` thật (chép nguyên byte), đoạn phân tích tham số thật của `KPlayer::ExecuteScript` (trích tự động), KTabFile giả + bảng công thức giả | **36/0** | `S\natives\smoke\out_smoke.txt` |
| Mô phỏng Lua 4 (`-Stack 100`): 31 script VNG thật (PAK/loose/ptfix), mỗi native ≥ 2 script (trừ `GetNpcColdResist` chỉ có 1 nơi gọi) + chunk cầu nối do ps1 sinh. Native engine không mô phỏng được tự stub và đều có trong bảng native | **60/0** | `S\qtest\sim_natives.lua`, `out_natives.txt` |
| Test web admin (trích AST, không mở server) | **12/0** | `S\qtest\test_admin_upgrade.ps1`, `out_admin_upgrade.txt` |
| Test giao diện (node, DOM giả) + `node --check` | **11/0**, cú pháp OK | `S\natives\test_upgrade_ui.js` |

## Phần 3: Hành động

### Triển khai (coordinator / người dùng)
- [ ] Tắt GameServer + Bishop, triển khai **CoreServer.dll** mới bằng `_backup\20261002-modernbuild\Deploy-ModernServer.ps1`. Bản build gồm cả thay đổi chưa triển khai của các agent khác cùng cây nguồn. Bản build đợt này: `_backup\20261005-natives\build\`.
- [ ] Client: CoreClient.dll + Game.exe không có thay đổi chức năng của đợt này. Chỉ `GetItemPartByID` trong Lua client đổi. Triển khai cùng đợt client chung.
- [ ] Đóng web admin rồi mở lại (ps1 đã đổi; không khởi động từ shell của Claude), F5 trình duyệt.
- [ ] Tùy chọn: đặt ngày mở server thật bằng `[ServerConfig] ServerOpenDate=yyyymmdd` (PAK-first: nếu `GameSetting.ini` nằm trong PAK thì sửa qua ptfix).

### Thử trong game
- [ ] Web admin → Cường hóa: liệt kê, đặt +12 cho áo đang mặc → thấy sao, chỉ số tăng. Thoát vào lại vẫn +12. Đặt +0 để gỡ.
- [ ] Đặt cho món không có công thức (ngựa) → Lịch sử lệnh báo -3.
- [ ] Dùng một bộ Thái Vân Trang `夏装` (PAK) và ibitem Phụng Lôi/Hồn Khiên (ptfix) → hiện "dùng đến <ngày>", biến thân được.
- [ ] Túi `六道四象小礼包` và 6 món `玄武*` (ptfix) → chạy đúng nhờ sửa `GetItemPartByID`.
- [ ] Xem `Server\set_item_upgrade.log`, `pt_globalstore.txt`.

### Việc tiếp theo (đề xuất, chưa làm)
- [ ] **Hook `ProcessScript` cho missile**: đọc cột 56 trong `KMissle`, gọi `OnHitTarget(npcIdx)` khi trúng, kèm cờ ngữ cảnh máu hiện tại cho `GetNpcLife/SetNpcLife`. Mở 10 kỹ năng boss (sét, lốc, băng, lửa) và các viên đạn sự kiện (`雪球`, `捉鬼`, `阪泉圣地 物抗/魔抗`).
- [ ] Đóng gói ptfix 169 script VNG tên GBK đã hết thiếu native (danh sách `S\natives\full_unblocked.tsv`). Thêm `Include("\\script\\phongthan\\lib\\pt_compat.lua")` cho 111 file dùng `math./table./require`.
- [ ] Native tiếp theo theo số file bị chặn: hệ Pet VNG (148), `GetTitleFunc` (34), `AddNormalItem4` (33), `SetPlayerTarget` (8), `GetCoin/CostCoinByIdx` (14).
- [ ] Nếu cần thời hạn thật cho đồ VNG: lưu thời điểm tạo vật phẩm (đổi DB) thay cho "thời điểm dùng".

## Phần 4: Tài liệu tham khảo

- Báo cáo nguồn: `de-xuat-khoang-trong-vng-phong-than-20261004.md` (đợt 2 #1, #2, #4).
- Dữ liệu phân tích: `S\natives\calls_*.txt` (mọi lời gọi kèm ngữ cảnh), `block_result.tsv`, `full_unblocked.tsv`, `vng\manifest.txt`; công cụ `dumpcalls.py`, `block.py`, `lua5flag.py`, `extract_vng.py`, `patch_src.py`, `markers.py`.
- Mã liên quan: `PhongThanQuestItemTuple.h` (ánh xạ (6,1,P) → 6/P/0), `KBasPropTbl.CPP` (nạp magic-script), `PhongThanEquipmentCompose.inl` + `PhongThanItemUpgrade.inl` (cường hóa Xích Tùng Tử), `KItemList::SyncItem` (`UpgradeLevel`), `KMissle.cpp` (không có `ProcessScript`), `ScriptFuns.cpp` `LuaGetNpcLife/LuaSetNpcLife`.
- Tài liệu liên quan: `sua-loi-vat-pham-hoi-thoai-phong-than-20260928.md` (lần đầu thấy `GetItemPartByID` trả 0 và tham số 4), `tu-tuong-vat-pham-truong-lao-phong-than-20261002.md` (pt_compat), `mat-do-hoi-quai-phong-than-20261004.md`.
