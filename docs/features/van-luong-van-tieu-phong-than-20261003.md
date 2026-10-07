---
title: Vận Lương và Vận Tiêu 2004 – dựng lại cho Phong Thần local
date: 2026-10-03
agent: vantieu (kiêm vanluong)
scope: Lua (loose + ptfix) và C++ CoreServer (SendCarriage, GetTGuardNum, GetTGuardTimeScale, AddTongAttr, AiMode 12)
tasks: 2121–2133 (bỏ 2120, 2123 vì script thú cưng rời đang ghi)
status: đã build CoreServer 0 lỗi, sim 47/47 OK; CHƯA triển khai (chờ người dùng cho phép thay DLL và build ptfix)
---

# Vận Lương và Vận Tiêu 2004 – dựng lại cho Phong Thần local

## Phần 1: Tổng quan

- **Vận Lương** (taskinfo 64 "Vận lương" của VNG: chở lương cho Tổng binh Trương Quế Phương, 6 chuyến/ngày, thưởng theo cấp) mất gần hết script: NPC `镖师` ở Đồng Quan (1014) trỏ tới `\script\运镖\潼关镖师.lua` không tồn tại, 16 script xe lương cũng mất. Tính năng được **viết lại hoàn toàn bằng Lua** và chơi được một mình: nhận xe ở Tiêu Sư Đồng Quan, xe đi theo người áp vận, có tuỳ chọn đường tắt với 2 đợt thổ phỉ phục kích (người chơi, đồng đội và bot đều đánh được), giao ở Lương Thảo Quan để nhận thưởng.
- **Vận Tiêu 2004** (Tuyệt Long Lĩnh) có đủ script VNG nhưng engine thiếu 4 hàm Lua và không ai chạy lịch mở tiêu. Đã **bổ sung 4 hàm trong C++** (`PhongThanLuaCarriage.h`), thêm **AiMode 12** cho xe đi theo chủ, và chạy lịch mở/đóng tiêu từ ext tick. Script VNG được vá nhẹ qua ptfix (hẹn giờ, phục kích, kiểm tra xe ở gần khi giao, bỏ đổi phe vĩnh viễn).
- Hai tính năng **dùng chung một bộ máy** (`vl_lib.lua`): xe = NPC có tham số, bộ hẹn giờ 1–2 giây lo hết thời gian, chủ bỏ xe, xe bị phá, phục kích. Không dùng biến Lua toàn cục chia sẻ giữa các script, nên nạp lại script giữa chừng không làm hỏng chuyến đang chạy.
- **Chạy được ngay cả khi chưa thay DLL**: Vận Lương tự chuyển sang chế độ dự phòng (xe được Lua dời từng bước theo chủ). Vận Tiêu cần DLL mới; trước đó Tiêu Đầu Thần Bí chỉ báo "Tiêu cục tạm nghỉ".

## Phần 2: Chi tiết

### 2.1 Luồng Vận Lương (map 1014 Đồng Quan)

| Bước | Ở đâu | Diễn biến |
|---|---|---|
| Nhận | Tiêu Sư Đồng Quan (1454/3150, NPC đặt sẵn của VNG, ext tick gắn lại script) | Cấp ≥ 20, tối đa 6 chuyến/ngày (tính lúc nhận). Chọn **đường lớn** (an toàn) hoặc **đường tắt** (2 đợt thổ phỉ, thưởng cao hơn) |
| Sinh xe | Cạnh người chơi | Mẫu 556 "粮饷车" (xe lương VNG), tên "Xe Lương". Có DLL mới: `NewSiegeWeapon` + `SendCarriage` (xe thành NPC loại 0, cùng phe chủ, AiMode 12 đi theo). Không có DLL: `AddNpc` + `SetNpcKind(0)`, Lua dời xe mỗi giây |
| Đi theo | Đồng Quan | Xe theo chủ; kẹt 6 giây khi chủ cách > 12 ô thì tự kéo lại. Tiêu Sư có nút "Kéo xe lương về bên cạnh ta" |
| Phục kích (đường tắt) | Khi quãng đường còn 70% và 40% | Mỗi đợt 3 "Thổ Phỉ Cướp Lương" (mẫu 979 悍匪), 4 nếu có tổ đội; cấp = cấp chủ − 2, máu 800 + cấp² |
| Giao | Lương Thảo Quan (1498/3500, ext tick sinh) | Xe trong vòng 15 ô. Thưởng: đường lớn cấp×2000 kinh nghiệm + cấp×300 lượng; đường tắt ×1,5 kinh nghiệm + cấp×150 mỗi tên cướp bị hạ, cấp×500 lượng |
| Thất bại | — | Xe bị phá (mã 2), quá 15 phút (3), tự huỷ (4), chủ khác bản đồ/offline/xa > 60 ô quá 120 giây (5). Thổ phỉ tự rút khi xe mất |

Ví dụ cấp 50: đường lớn 100.000 kinh nghiệm + 15.000 lượng; đường tắt hạ 5 tên được 187.500 kinh nghiệm + 25.000 lượng.

### 2.2 Luồng Vận Tiêu 2004 (map 1019 Tuyệt Long Lĩnh)

| Bước | Script | Diễn biến |
|---|---|---|
| Mở tiêu | ext tick (thay `开启.lua`) | Khung giờ 12:00, 19:00, 21:00, mỗi khung 30 phút (VNG gốc: 19:00–19:10). Sinh "Tiêu Đầu Thần Bí" ở 1 trong 5 điểm VNG, đặt global 422=1, 423=0, 424=0, báo toàn server. Hết khung: 422=0, xoá Tiêu Đầu |
| Nhận tiêu | `神秘镖头.lua` (VNG, vá) | Điều kiện VNG: không tổ đội, đã vào phe, không chạy thương, cấp ≥ 30, danh vọng ≥ 10. Mỗi khung chỉ 1 xe (423). `SendCarriage(xe, tên, 1, 1800)` rồi gắn hẹn giờ Lua. Người chơi đổi **phe tạm** (SetCurCamp 2/8), **không còn** đổi phe vĩnh viễn |
| Hộ tống | `vl_lib.lua` | Xe theo chủ, 2 đợt "Sơn Tặc Cướp Tiêu" (4–5 tên mỗi đợt), hạn 30 phút |
| Giao tiêu | Tổng Tiêu Đầu (1609/2954, ext tick sinh), `总镖头.lua` (vá) | Xe phải trong 20 ô. Thưởng VNG: 500.000 lượng (tiền thưởng của xe), 10 danh vọng, 1 Ngọc tỷ (3,83); thêm cấp×300 kinh nghiệm mỗi sơn tặc bị hạ; trả lại phe cũ |
| Xe bị phá | `镖车.lua` (vá) → `vl_lib` | Luật VNG: 3 lần đầu để lại "Bảo Rương Tiêu Xa" ở chỗ xe đổ, lần 4–6 xác suất 1/2; người mở rương nhận xe mới (`宝箱.lua`, hạn 10 phút) |
| Đổi Ngọc tỷ | Tiêu Sư (Xi Vưu, 1004, ext tick sinh), `镖师.lua` | Hưng thịnh (AddTongAttr, chỉ thành viên bang, không thì giữ lại Ngọc tỷ) hoặc Sách chư hầu |

### 2.3 C++ (CoreServer)

| File | Thay đổi |
|---|---|
| `Core\Src\PhongThanLuaCarriage.h` (mới) | `SendCarriage(xe, tên, cấp, giây)`: xe thành `kind_normal` (dòng VNG mang Kind 8, nằm ngoài bảng quan hệ), phe = phe chủ, gắn chủ, AiMode 12, bỏ death script mẫu (để DeathSelf/Revive về ActionScript), hồi sinh sau 18 khung; ghi bản ghi xe (tiền thưởng 500.000 × cấp, giờ bắt đầu, thời hạn) và gắn người áp tiêu. `GetTGuardNum()`: số xe đang chạy. `GetTGuardTimeScale()`: % thời gian còn lại. `AddTongAttr(loại, giá trị)`: lưu bền theo bang (GameData, ô 100+loại) |
| `PhongThanLuaWave8.h` | Khai báo trước `PhongThanCarriageBounty`; `PhongThanAttachPlayerToSiege` lấy tiền thưởng từ bản ghi xe (vào/ra xe không mất tiền thưởng) |
| `ScriptFuns.cpp` (sửa ở mức byte) | `#include "PhongThanLuaCarriage.h"` sau Wave9; đăng ký 4 hàm |
| `KNpcAI.cpp` (GBK, sửa ở mức byte) | `PhongThanCarriageFollow` + `case 12`: đi theo chủ (đi bộ khi > 96, chạy khi > 480, đứng yên khi > 1600 hoặc chủ khác map/chết/offline), không bao giờ tấn công |

Vì sao không dùng thẳng AiMode 11 như `AddTotemNpc`: AiMode 11 là AI thú cưng, tự đánh quái và **tự xoá NPC** khi chủ đổi bản đồ hay chết, lại bỏ qua hồi sinh. AiMode 12 dùng cùng cách nhận chủ (`m_nOwnerIdx` + tên `Owner`) nhưng chỉ đi theo, để Lua quyết định thất bại.

Build: `Build-Modern.ps1 -Targets CoreServer` → **0 lỗi** (chỉ cảnh báo cũ C5208/C4005), DLL ở `PhongThanSource\OutputModern\Server\CoreServer.dll` (10.020.864 byte, có chuỗi 4 hàm mới). **Chưa triển khai.**

### 2.4 Lua và dữ liệu

| File | Vai trò |
|---|---|
| `Server\script\phongthan\vanluong\vl_lib.lua` | Bộ máy chung: hằng số, sinh xe, gắn xe Vận Tiêu, hẹn giờ xe, đi theo dự phòng, phục kích, thất bại, rương tiêu, thưởng diệt cướp |
| `Server\script\phongthan\vanluong\vl_core.lua` | Một script cho mọi NPC Vận Lương (Tiêu Sư, Lương Thảo Quan, xe, thổ phỉ) và là script hẹn giờ của xe Vận Tiêu |
| `Server\script\phongthan\ext\vanluong.lua` | `PTEXT_vanluong_Tick()` (mỗi phút): ReLoadScript 7 script, gắn lại NPC 1014, giữ 3 NPC cố định, lịch Vận Tiêu; `PTEXTVL_ForceOpen()` mở tiêu ngay 30 phút để thử |
| `scratchpad\ptfix\extra_vanluong.py` | Thêm `\script\运镖\潼关镖师.lua` (bọc vl_core); vá `神秘镖头`, `宝箱`, `镖车`, `总镖头`, `镖师`, `开启` (AddNpc đủ 6 tham số, map 1019) |
| Nguồn UTF-8 + bộ sinh | `scratchpad\vantieu\src\*.lua`, `gen.py` (chuyển tiếng Việt sang TCVN3, đường dẫn GBK sang escape) |

Tham số NPC xe: 0 mã nhận diện, 1 chỉ số người chơi, 2 uuid, 3 hạn chót, 4 số đợt phục kích, 5 quãng đường², 6 giây vắng chủ, 7/8 ô cuối, 9 loại (1 lương, 2 tiêu), 10 chế độ, 11 chỉ số xe C++, 12 đã báo tới nơi, 13/14 ô đích, 15 đếm kẹt.

Task: 2121 trạng thái, 2122 chỉ số xe, 2124 mã xe, 2125 hạn chót, 2126 ngày, 2127 số chuyến, 2128 cướp bị hạ, 2129 chế độ, 2130/2131 xe Vận Tiêu, 2132 sơn tặc bị hạ, 2133 kết quả gần nhất. Đã quét toàn bộ PAK và script rời: dải 2121–2139 trống (2120, 2123 bị `鸡年黄金灵宠图谱.lua` ghi nên bỏ qua; 2134–2139 chỉ là số hiệu vật phẩm trong script khác).

### 2.5 An toàn engine (vì sao thiết kế như vậy)

- NPC chết nằm trong danh sách "none region"; `DelNpc` lúc đó không gỡ nút khỏi danh sách (hỏng bộ nhớ). Vì vậy xe/thổ phỉ chết chỉ bị **đánh dấu**, hồi sinh sau 1 giây (`SetNpcRevTime(18)`), rồi **tự xoá trong OnTimer của chính nó** (vòng duyệt region đã lưu nút kế tiếp nên xoá chính mình là an toàn).
- `SetNpcScript` trên NPC loại 0 gọi ngay `Revive`: script đặt tham số **sau** `SetNpcScript`, nên lần gọi đó không làm gì.
- Không có biến toàn cục dùng chung: trạng thái nằm ở task của chủ và tham số NPC, chịu được ReLoadScript.

## Phần 3: Hành động

### Checklist cho người dùng (sau khi tự khởi động lại server)

- [ ] Coordinator build ptfix có `extra_vanluong.py` và triển khai (khi được đồng ý).
- [ ] Người dùng đồng ý thay `CoreServer.dll` bằng `PhongThanSource\OutputModern\Server\CoreServer.dll` (Vận Tiêu cần; Vận Lương chạy được cả khi chưa thay).
- [ ] Vào Đồng Quan (1014), gặp **Tiêu Sư Đồng Quan** (1454/3150): thấy 4 lựa chọn.
- [ ] Nhận **đường lớn**: xe lương xuất hiện cạnh nhân vật và đi theo; đi về phía nam tới **Lương Thảo Quan** (1498/3500), báo giao xe, nhận kinh nghiệm + lượng.
- [ ] Nhận **đường tắt**: giữa đường gặp 2 đợt thổ phỉ; hạ thổ phỉ (thử cả khi có bot/đồng đội); giao xe, thấy dòng "thổ phỉ bị hạ: N".
- [ ] Để thổ phỉ phá xe: nhận thông báo thất bại, xe biến mất sau ~1 giây, thổ phỉ rút trong vài giây.
- [ ] Bỏ xe chạy sang bản đồ khác hơn 2 phút: thất bại; chờ quá 15 phút: thất bại.
- [ ] Nhận đủ 6 chuyến trong ngày: chuyến thứ 7 bị từ chối.
- [ ] Vận Tiêu: lúc 12:00/19:00/21:00 (hoặc gọi `PTEXTVL_ForceOpen()` qua bridge) có thông báo, **Tiêu Đầu Thần Bí** ở Tuyệt Long Lĩnh; nhận tiêu (cấp ≥ 30, danh vọng ≥ 10, không tổ đội, đã vào phe).
- [ ] Hộ tống tới **Tổng Tiêu Đầu** (1609/2954), giao khi xe ở gần: 500.000 lượng, Ngọc tỷ, phe trở lại như cũ.
- [ ] Để xe tiêu bị phá: xuất hiện **Bảo Rương Tiêu Xa**; nhân vật khác mở rương nhận xe mới.
- [ ] Ở Xi Vưu (1004) gặp **Tiêu Sư** đổi Ngọc tỷ: người không có bang được giữ lại Ngọc tỷ.

### Kết quả mô phỏng (`scratchpad\qtest\sim_vanluong.lua`)

47/47 OK, không cờ lỗi: ext tick (nạp 7 script, gắn lại NPC, sinh NPC không trùng), VL engine (nhận, theo, giao; 2 đợt phục kích, bot hạ cướp vẫn tính cho chủ; xe bị phá; quá giờ; bỏ xe; huỷ; giới hạn ngày; cấp thấp), VL dự phòng (theo bằng SetNpcPos, giao; xe chết với death script mẫu), VT (lịch mở/đóng, nhận, xe ở xa không cho giao, 8 sơn tặc, giao đủ thưởng, xe bị phá → rương → người nhặt nhận xe → quá giờ, Tiêu Sư 1004). Hồi quy: sim_questfix, sim_questaudit, sim_tta, sim_tutuong_b, t_st đều 0 lỗi.

## Phần 4: Tài liệu tham khảo

- Kiểm toán: `scratchpad\questaudit\quest_audit.md` mục 2.11.
- Script VNG gốc đã giải: `scratchpad\vantieu\vng\` (`神秘镖头` ac557a46, `总镖头` 162b1f5b, `镖车` a10ada3d, `宝箱` 23d75a51, `镖师` c871181c, `开启` f4a59849, `关闭` c7b1814c); lịch VNG `systemtimetask`: 19:00 mở, 19:10 đóng.
- Công cụ: `scratchpad\vantieu\route.py` (BFS chọn điểm đích), `cellchk.py` (ô đi được), `taskscan.py` (quét task), `extract.py` (lấy bản vá ra cho sim).
- Liên quan: `docs\features\kiem-toan-nhiem-vu-phong-than-20261002.md`.
- Việc có thể làm tiếp: gắn thêm lựa chọn "Vận lương" vào Phong Lâm (Mạnh Tân, của coordinator); phần "Lục lâm hảo hán" (Tam Sơn, phía cướp) vẫn cần IB buff 302/1306 nên chưa nối.
