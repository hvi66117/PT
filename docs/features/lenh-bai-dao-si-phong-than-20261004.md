---
tinh-nang: Lệnh Bài phái — Đạo Sĩ (luân phiên chiêu theo hệ), Dị Nhân (luân phiên chiêu hỗ trợ), Giáp Sĩ (luân phiên chiêu đao) — bắt đầu/dừng tự đánh, nâng cấp kỹ năng tối đa
ngay: 2026-10-04
agent: lbdaosi
trang-thai: Đợt 2 (20:50) — Lua r3 đã chép runtime và áp nóng qua bridge; C++ CoreClient build 20:48 và ptfix build thử (61480/61481/61482) đạt; CHƯA triển khai CoreClient.dll và ptfix mới (xem Phần 5)
tom-tat: Hai lệnh bài dùng mãi (magicscript 61480 / 61481). Đạo Sĩ chọn bộ chiêu Thổ + Hỏa + Băng (mặc định), Hỏa + Băng + Lôi, tất cả, một hệ hoặc từng chiêu; tự đánh luân phiên đúng các chiêu đó, không phụ thuộc phím. Dị Nhân chọn hào quang, Bổ Tâm Chú, chú nguyền; tự đánh tự duy trì luân phiên. Lựa chọn lưu ở task 2613 / 2614, gửi xuống client bằng gói VNG s2c_synctaskvalue có sẵn (không đổi giao thức, không sửa server C++). Web admin phát lệnh bài và đặt bộ chiêu cho nhân vật online hoặc offline.
---

# Lệnh Bài Đạo Sĩ và Lệnh Bài Dị Nhân (2026-10-04)

## Phần 1: Tổng quan

- **Yêu cầu 1 (Đạo Sĩ):** "Thêm lệnh bài Đạo Sĩ cho lựa chọn đánh luân phiên các chiêu của hệ Thổ + Hỏa + Băng; cho lựa chọn đánh luân phiên ở web admin."
- **Yêu cầu 2 (Dị Nhân, bổ sung cùng đợt):** "Thêm lệnh bài của Dị Nhân cho phép dùng nhiều chiêu buff luân phiên, phát ở webadmin."
- **Insight chính:**
  - Tự đánh chạy ở client (`PhongThanAutoFight.inl`), còn lệnh bài là script server. Engine **đã có sẵn kênh** đẩy giá trị task xuống client: Lua `SyncTaskValue(id)` → `KPlayerTask::SyncTaskValue` → gói VNG `s2c_synctaskvalue` → `KProtocolProcess::s2cSyncTaskValue` → `Player.m_cTask` ở client. Kênh này đang được dùng thật (danh vọng, phúc duyên hiển thị ở client).
  - Vì vậy **không thêm wire message, không sửa CoreServer, không sửa Game.exe**. Chỉ sửa `PhongThanAutoFight.inl` (CoreClient.dll) để đọc task.
  - `KPlayer::SyncCurPlayer` xóa `m_cTask` của client mỗi lần vào bản đồ. Client giữ giá trị đã nhận gần nhất của **cùng nhân vật** cho tới lần đồng bộ sau; server gửi lại mỗi phút.
- **Cách dùng (người chơi):**
  1. Nhân vật Đạo Sĩ / Dị Nhân tự nhận lệnh bài của phái (1 lần, trong vòng 1 phút sau khi online), hoặc admin phát.
  2. Nhấp phải lệnh bài, chọn bộ chiêu.
  3. Bật tự đánh Alt+A / Alt+S / Alt+D. Thông báo bật ghi rõ "luân phiên N chiêu theo Lệnh Bài + duy trì M chiêu hỗ trợ".
  4. Alt+R vẫn tắt/bật luân phiên như bản daosi (tắt: quay về 1 chiêu như cũ).
- **Quay về hành vi cũ:** Đạo Sĩ chọn "Theo phím đang gán (bỏ bộ chiêu)"; Dị Nhân chọn "Tắt". Task = 0 thì tự đánh chạy đúng như bản daosi.

## Phần 2: Chi tiết

### 2.1 Mã số

| Thành phần | Giá trị |
|---|---|
| Lệnh Bài Đạo Sĩ | magicscript genre 6, detail 1, particular **61480**; script `\script\phongthan\item\lbdaosi_lenhbai.lua` |
| Lệnh Bài Dị Nhân | magicscript 6/1/**61481**; script `\script\phongthan\item\lbdinhan_lenhbai.lua` |
| Task bộ chiêu Đạo Sĩ | **2613**: 0 = theo phím; khác 0 = 2^30 + Σ 2^(id − 3), id 3..26 |
| Task bộ chiêu Dị Nhân | **2614**: 0 = tắt; khác 0 = 2^30 + Σ 2^(id − 43), id 43..51 |
| Cờ đã phát lệnh bài | **2615** (Đạo Sĩ), **2616** (Dị Nhân): 1 = đã phát hoặc đã có sẵn |
| Kênh server → client | `SyncTaskValue(2613/2614)` (VNG `s2c_synctaskvalue`), không đổi giao thức |
| Thư viện server | `\script\phongthan\item\lbdaosi_lib.lua` (không có `main`, dofile vào state servertimer) |
| Tick phút | `\script\phongthan\ext\lbdaosi.lua` → `PTEXT_lbdaosi_Tick` (cần thêm `"lbdaosi"` vào `PTADM_EXT_NAMES`) |
| Admin offline | `admin_bridge\lbdaosi_pending.txt` (`loại<TAB>giá trị<TAB>tên`), áp khi nhân vật đăng nhập |
| Biến toàn cục Lua | tiền tố `PTLB_`, `PTLBDS_`, `PTLBDN_` (đã kiểm tra không trùng) |
| Khóa web admin | `DaoSiToken` → 6/61480, `DiNhanToken` → 6/61481; hành động `lbskills` |

**Quét trùng (ngay trước khi chốt):** `scratchpad\lbdaosi\scan_ids2.py` quét mọi mục văn bản của mọi PAK (Server + Client), script rời, settings, admin_bridge, AdminWeb, docs và toàn bộ scratchpad (kể cả mọi `extra_*.py`). Task 2613–2629 và magicscript 61480–61499: **không ai dùng** (chỉ trùng số tọa độ 61488 trong `spawn_*.lua` và một chuỗi hex).

### 2.2 Chiêu Đạo Sĩ theo hệ (`skills.txt`, cột 65 SkillType: 1 Băng, 2 Hỏa, 3 Lôi, 4 Thổ)

| Hệ | Chiêu đánh (id, tên) | Buff hệ (giữ hiệu lực) |
|---|---|---|
| **Thổ** | 4 Lưu Tinh Thạch, 8 Thiên Phong Địa Nhận, 16 Ngũ Nhạc Triều Tông, 20 Thiên Băng Địa Liệt, 24 Huyền Nữ Bổ Thiên | (12 Tinh Thông Thổ Hệ là bị động) |
| **Hỏa** | 6 Tích Lịch Hỏa, 10 Phong Lâm Hỏa Sơn, 18 Thập Phương Liệt Hỏa, 26 Tam Muội Chân Hỏa | 22 Chúc Dung Chân Khí |
| **Băng** | 5 Băng Tuyết Đạn, 13 Thiết Mã Băng Qua, 21 Băng Phong Bạo, 25 Băng Phong Vạn Lý | 9 Băng Cơ Tuyết Cốt |
| **Lôi** | 3 Chưởng Tâm Lôi, 11 Hạn Địa Lôi, 15 Phong Vân Lôi Động, 23 Lôi Động Cửu Thiên | 19 Lôi Phong Giáp |

- Bị động 7 / 12 / 14 / 17 (Tinh Thông các hệ) không đưa vào.
- Buff 9 / 19 / 22: hiệu lực 1500 + 150 × cấp khung (cấp 1 ≈ 92 giây, cấp 10 ≈ 167 giây; script cấp VNG `\script\skill\daoshi\*.lua`), thời gian chờ 500 khung (≈ 28 giây).
- **Bộ có sẵn:** Thổ + Hỏa + Băng (13 chiêu, mặc định), Hỏa + Băng + Lôi (12), Tất cả các hệ (17), Chỉ một hệ. Chọn bộ chỉ thay phần chiêu đánh, buff đã bật được giữ.

### 2.3 Chiêu Dị Nhân hỗ trợ

| Id | Tên | Loại | Hiệu lực (script cấp VNG `\script\skill\yiren\*.lua`) | Tự đánh làm gì |
|---|---|---|---|---|
| 43 | Kim Cang Chú | hào quang | phòng thủ ngoài +(7 + 3 × cấp), khi hào quang bật | Bật hào quang |
| 46 | Cường Công Chú | hào quang | sát thương vật lý +(7 + 3 × cấp) % | Bật hào quang |
| 48 | Bồ Đề Chú | hào quang | giảm thời gian đóng băng / hồi phục khi trúng đòn (7 + 3 × cấp) % | Bật hào quang |
| 50 | Tật Phong Chú | hào quang | tốc độ đánh và tốc độ xuất chiêu +(10 + cấp) | Bật hào quang |
| 45 | Bổ Tâm Chú | hồi máu | hồi 20 + 20 × cấp sinh lực | Tung lên mình khi sinh lực < 60 % (cách nhau ≥ 1,5 giây) |
| 47 | Phá Giáp Chú | chú nguyền | phòng thủ ngoài −(30 + 2 × cấp), kháng −(15 + cấp) %; 72 + 18 × cấp khung (cấp 1 = 5 s, cấp 10 = 14 s) | Tung lên mục tiêu, làm mới 1 giây trước khi hết |
| 49 | Trảm Tâm Chú | chú nguyền | sát thương vật lý của mục tiêu −(20 + 5 × cấp); 72 + 18 × cấp khung | Như trên |

- Hào quang: engine chỉ cho **một** hào quang hoạt động (`m_ActiveAuraID`). Chọn nhiều thì tự đánh **đổi lần lượt mỗi 15 giây**. Người chơi đổi chiêu tay phải làm tắt hào quang (`KPlayer::SetRightSkill`) thì tự đánh bật lại ở lần nghĩ sau.
- 44 Thôi Thân Chú, 51 Vạn Cốt Toàn Khô là đòn đánh chính: vẫn lấy theo phím/luân phiên như bản daosi. Chú nguyền đã chọn bằng lệnh bài **không** bị đưa vào vòng đánh thường nữa (chỉ tung theo chu kỳ của nó).
- Đệ tử 450–458 không nằm trong lệnh bài này (đã có Lệnh Bài Triệu Hồi).
- **Bộ có sẵn:** Tất cả buff (43, 46, 48, 50, 45), Buff + chú nguyền (cả 7), Chỉ hồi máu (45), Bật/tắt từng chiêu, Tắt.

### 2.4 Menu lệnh bài (≤ 7 dòng mỗi trang, chỉ hiện chiêu đã học)

- **Lệnh Bài Đạo Sĩ:** Thổ + Hỏa + Băng (mặc định) · Hỏa + Băng + Lôi · Tất cả các hệ · Chỉ một hệ... (Thổ / Hỏa / Băng / Lôi / Quay lại / Đóng) · Bật, tắt từng chiêu (cả buff)... · Theo phím đang gán (bỏ bộ chiêu) · Đóng.
- **Lệnh Bài Dị Nhân:** Tất cả buff · Buff + chú nguyền · Chỉ hồi máu · Bật, tắt từng chiêu... · Tắt · Đóng.
- **Trang bật/tắt:** 4 chiêu đã học mỗi trang, dạng `[x] Tam Muội Chân Hỏa - Hỏa`, kèm Trang sau / Quay lại / Đóng. Bấm một chiêu là đổi trạng thái rồi hiện lại đúng trang đó. Tắt hết chiêu đã học thì task về 0.
- Tiêu đề luôn ghi bộ hiện tại, ví dụ "Hiện tại: Thổ 3, Hỏa 3, Băng 2 + buff 1".
- Dòng menu không chứa "/" (engine tách tên hàm ở dấu "/" **đầu tiên**, `LuaSelectUI`) và dài < 100 byte (engine cắt ở 100).
- Sai phái: thông báo "chỉ dành cho phái …", không lưu gì.

### 2.5 Tự đánh phía client (`Core\Src\PhongThanAutoFight.inl`, dấu `lbdaosi`)

- `PTAF_TaskValue(k)`: đọc chuỗi task 2613 / 2614 của `Player.m_cTask`. Chuỗi rỗng (vừa bị `SyncCurPlayer` xóa) thì dùng giá trị đã nhận gần nhất của **cùng tên nhân vật**; nhân vật khác trong cùng Game.exe không bị dính bộ cũ.
- `PTAF_SelKind`: chiêu đã học trong bộ được phân loại theo thuộc tính thật của kỹ năng: hào quang (`IsAura`), chú nguyền (47 / 49), hồi máu (`TargetAlly` không `TargetEnemy`), buff bản thân (style `InitiativeNpcState` + `TargetSelf`), chiêu đánh (`PTAF_IsAttackSkill`).
- **Chiêu đánh (luân phiên bật):** bộ của lệnh bài **thay** danh sách phím. Luân phiên công bằng: chiêu nào gửi lâu nhất thì tới lượt, chiêu đang hồi thì bỏ qua, nên chiêu không thời gian chờ của hệ Thổ cũng tới lượt (khác với danh sách phím, nơi chiêu lớn có thời gian chờ được ưu tiên). Vẫn ưu tiên chiêu với tới mục tiêu.
- **Hỗ trợ (`PTAF_Support`, chạy trước phần tìm mục tiêu mỗi lần nghĩ):** hồi máu khi < 60 % → hào quang → buff có trạng thái còn < 3 giây (54 khung) hoặc không có trạng thái (gửi lại sau ≥ 4 giây). Mỗi lần tối đa 1 chiêu, cách nhau ≥ 1,2 giây, nên đòn đánh không bị ngắt nhiều.
- **Chú nguyền (`PTAF_Curse`, đầu `PTAF_Engage`):** mục tiêu trong tầm chiêu và chú nguyền của mục tiêu này sắp hết (theo cấp chiêu) thì tung.
- Mọi lần tung đi qua đúng kiểm tra như cú bấm chuột: `CanCast` (thời gian chờ), `Cost` (nội lực), tầm. Buff và hồi máu tung tại chính vị trí mình (như `CoreShell::UseSkill` và `KNpcAI`). Server kiểm tra lại như lệnh chuột.
- Thông báo bật tự đánh: "… - luân phiên N chiêu theo Lệnh Bài (Alt+R bật/tắt) + duy trì M chiêu hỗ trợ".

### 2.6 Server (Lua)

- `lbdaosi_lib.lua` → `PTLB_Tick()` mỗi phút cho từng người chơi online:
  1. Áp bộ chiêu admin đặt khi vắng mặt (từ `lbdaosi_pending.txt`, giữ qua khởi động lại server).
  2. Phát lệnh bài của phái nếu chưa có (`HaveNormalItem` trước; chỉ đặt task 2615 / 2616 khi `AddNormalItem` thành công, nên túi đầy hoặc chưa có ptfix thì phút sau thử lại).
  3. Gửi lại task 2613 / 2614 (`SetTask(t, GetTask(t))` biến task chưa đặt thành "0" thật rồi `SyncTaskValue`).
- `PTLB_AdminSet(id, tên, loại, mask)` (bridge): online thì đặt và gửi ngay, báo người chơi; offline thì lưu file, log "ap khi dang nhap".

### 2.7 Web admin

- **Phát đồ:** thêm nút "Phát Lệnh Bài Đạo Sĩ", "Phát Lệnh Bài Dị Nhân" cạnh các lệnh bài khác.
- **Bí kíp / Kỹ năng → thẻ 4 "Lệnh Bài Đạo Sĩ / Dị Nhân (tự đánh luân phiên)":**
  - Ô tên nhân vật (gợi ý danh sách online; tên không online thì báo sẽ lưu và áp khi đăng nhập).
  - 2 nút phát lệnh bài.
  - "Luân phiên chiêu Đạo Sĩ": nút bộ có sẵn (Thổ + Hỏa + Băng, Hỏa + Băng + Lôi, Tất cả các hệ), danh sách tích 20 chiêu (17 chiêu đánh + 3 buff), nút "Áp dụng bộ chiêu Đạo Sĩ" và "Theo phím đang gán".
  - "Luân phiên buff Dị Nhân": nút bộ có sẵn, danh sách tích 7 chiêu, "Áp dụng buff Dị Nhân", "Tắt buff Dị Nhân".
- Backend `PhongThan-Admin.ps1`: hành động `lbskills` (`which` 1/2, `skills[]` hoặc `off`), lọc id theo phái, tính mask, xếp lệnh bridge `PTLB_AdminSet`. File .ps1 vẫn toàn ASCII.

## Phần 3: Hành động

### 3.1 File đã sửa / thêm

| File | Loại | Nội dung |
|---|---|---|
| `PhongThanSource\Sources\Core\Src\PhongThanAutoFight.inl` | sửa (vá byte, ASCII, dấu `lbdaosi`) | Đọc task, phân loại chiêu, bộ chiêu thay phím, luân phiên công bằng, hỗ trợ/hào quang/hồi máu/chú nguyền, thông báo |
| `PhongThanRuntime-Staging\Server\script\phongthan\item\lbdaosi_lenhbai.lua` | mới | Lệnh Bài Đạo Sĩ |
| `…\item\lbdinhan_lenhbai.lua` | mới | Lệnh Bài Dị Nhân |
| `…\item\lbdaosi_lib.lua` | mới | Tick, admin, file chờ, phát lệnh bài |
| `…\ext\lbdaosi.lua` | mới | `PTEXT_lbdaosi_Tick` |
| `scratchpad\ptfix\extra_lbdaosi.py` | mới | 2 dòng magicscript 61480 / 61481 (Server + Client) |
| `AdminWeb\PhongThan-Admin.ps1` | sửa | `DaoSiToken`, `DiNhanToken`, hành động `lbskills` |
| `AdminWeb\index.html` | sửa | 2 nút ở Phát đồ, thẻ 4 ở Bí kíp / Kỹ năng |
| `CHANGELOG.md`, `docs\features\README.md` | sửa | Mục mới |

Không sửa: server C++ (`KNpc.cpp`, `KSkills.cpp`, `KNpcAI.cpp` của agent khác), `Headers`, Game.exe, `servertimer.lua`, `starter_gear.lua`.

Sao lưu: `_backup\20261004-lbdaosi\` (`PhongThanAutoFight.inl`, `PhongThan-Admin.ps1`, `index.html`, `CHANGELOG.md`, `README.md`, `starter_gear.lua` dù không sửa).

### 3.2 Kiểm thử

| Kiểm thử | Kết quả |
|---|---|
| `qtest\sim_lbdaosi.lua -Stack 100` | FAILS=0 (100 kiểm tra) |
| `sim_lbdaosi.lua` chế độ EMU (lối vào 47 khung, tick 40) | FAILS=0, headroom tối thiểu 39 khung |
| `sim_lbdaosi.lua` với file đã chép vào runtime (`live`, `emulive`) | FAILS=0 |
| `qtest\test_admin_lbdaosi.ps1` (AST của .ps1, không chạy web) | 10 đạt / 0 lỗi; lệnh bridge sinh ra được chạy trong sim phần 4 |
| Smoke C++ `scratchpad\lbdaosi\smoke\` (biên dịch nguyên `PhongThanAutoFight.inl` thật) | 60 đạt / 0 lỗi |
| Smoke daosi (`scratchpad\lbdaosi\smoke_daosi\`, bản sao test của agent daosi, mock bổ sung) | 45 đạt / 0 lỗi (Q1/Q2/luân phiên daosi không đổi) |
| ptfix build thử `scratchpad\lbdaosi\ptfix_test_client.pak` (42 mục) / `ptfix_test.pak` (617 mục) | `magicscript.txt` 5784 dòng, 61480 / 61481 đủ 34 cột, hình `书信3/4.spr` (Kỹ Năng Quyển VNG 5625/5626) |
| `Build-Modern.ps1 -Targets CoreServer,CoreClient,GameClient` | Cả 3 OK lúc 18:08 |

Sim kiểm tra: menu ≤ 7 dòng, một dấu "/", < 100 byte, mọi callback tồn tại; 3 bộ có sẵn và từng hệ đúng bit; bộ giữ buff đã bật; trang chỉ liệt kê chiêu đã học; bật/tắt hiện lại đúng trang; tắt hết → 0; sai phái bị từ chối; tick phát lệnh bài đúng phái, không phát trùng, túi đầy/chưa có ptfix thì thử lại; gửi lại 2 task mỗi phút; admin online/offline, file chờ qua khởi động lại server, áp khi đăng nhập rồi xóa; lỗi trong tick bị bắt.

### 3.3 Cần làm (coordinator)

- [ ] Thêm `"lbdaosi"` vào `PTADM_EXT_NAMES` trong `Server\script\servertimer.lua` (chỉ coordinator sửa file này). Hoặc kích hoạt nóng bằng `scratchpad\lbdaosi\bridge_activate.lua` (ReLoadScript 2 script lệnh bài + thêm tên vào danh sách) sau khi đã cài ptfix.
- [ ] Build ptfix chính thức (Client trước, Server sau); plug-in `extra_lbdaosi.py` tự được nạp. Triển khai cho **cả Server và Client**.
- [ ] Triển khai **CoreClient.dll** (client). CoreServer.dll và Game.exe build lại không có thay đổi của đợt này (gồm thay đổi của các agent khác).
- [ ] Người dùng khởi động lại GameServer (script lệnh bài rời được đăng ký lúc khởi động) hoặc dùng kích hoạt nóng ở trên.
- [ ] Người dùng đóng và mở lại web admin, rồi F5.

### 3.4 Kiểm thử trong game

1. Đạo Sĩ đã học vài chiêu mỗi hệ: chờ ≤ 1 phút, nhận "Lệnh Bài Đạo Sĩ". Nhấp phải: menu 7 dòng, tiêu đề "theo phím đang gán".
2. Chọn "Thổ + Hỏa + Băng": tiêu đề ghi số chiêu từng hệ. Alt+S: thông báo "luân phiên N chiêu theo Lệnh Bài". Quan sát chiêu Thổ, Hỏa, Băng ra lần lượt, kể cả khi phím Q…C đang gán chiêu Lôi.
3. "Bật, tắt từng chiêu": bật Băng Cơ Tuyết Cốt → khi tự đánh, buff được làm mới gần lúc hết.
4. Đổi bản đồ, đăng nhập lại: lựa chọn vẫn giữ (sau đăng nhập có thể mất ≤ 1 phút nếu là Game.exe mới mở).
5. "Theo phím đang gán": tự đánh trở lại như bản daosi.
6. Dị Nhân: "Buff + chú nguyền", Alt+S: hào quang bật (đổi mỗi 15 giây nếu chọn nhiều), Bổ Tâm Chú khi máu < 60 %, Phá Giáp / Trảm Tâm lên quái rồi Thôi Thân Chú.
7. Web admin: đặt bộ cho nhân vật online (nhận trong ≤ 1 phút) và offline (áp khi đăng nhập), xem "Lịch sử lệnh".

### 3.5 Giới hạn

- Thời gian hiệu lực chú nguyền ở client tính theo công thức VNG (72 + 18 × cấp khung); client không thấy trạng thái trên quái. Nếu dữ liệu chiêu đổi thì sửa `PTAF_CurseMs`.
- Bổ Tâm Chú chỉ hồi cho bản thân, chưa hồi đồng đội.
- Sau khi mở Game.exe mới và đăng nhập, bộ chiêu có hiệu lực ở lần tick đầu (≤ 1 phút), vì server chỉ gửi theo tick (không có hook đăng nhập an toàn: `playerlogin.lua` VNG nằm trong PAK, không sửa).
- Rollback: chép lại `PhongThanAutoFight.inl`, `PhongThan-Admin.ps1`, `index.html` từ `_backup\20261004-lbdaosi\`, build lại CoreClient; xóa 4 file Lua mới và `extra_lbdaosi.py`, build lại ptfix; bỏ `"lbdaosi"` khỏi `PTADM_EXT_NAMES`. Task 2613–2616 vô hại nếu để lại.

## Phần 4: Tài liệu tham khảo

- `dao-si-nhieu-chieu-phong-than-20261004.md`: luân phiên chiêu daosi, Alt+R, danh sách phím nhanh.
- `tu-dong-danh-phong-than-20261003.md`: tự đánh gốc Alt+A/S/D.
- `lenh-bai-luyen-cong-phong-than-20261003.md`: mẫu lệnh bài + tự phát + web admin.
- `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`: Lệnh Bài Triệu Hồi (đệ tử Dị Nhân).
- Công cụ: `scratchpad\lbdaosi\` (`gen.py`, `patch_autofight*.py`, `scan_ids2.py`, `verify_pak.py`, `dump_lvl3.py`, `smoke\`, `smoke_daosi\`, `bridge_activate.lua`), `scratchpad\qtest\sim_lbdaosi.lua`, `test_admin_lbdaosi.ps1`.

## Phần 5: Đợt 2 (2026-10-04 tối) — lỗi "không tự đánh", bắt đầu/dừng từ lệnh bài, Lệnh Bài Giáp Sĩ, nâng cấp kỹ năng

### 5.1 Báo lỗi và nguyên nhân

- **Người dùng báo (sau khi triển khai 19:29):** "Chọn lệnh bài Đạo Sĩ và chọn kỹ năng vẫn không tự động đánh; trong lệnh bài chưa cho chọn kỹ năng đánh cụ thể." Dữ liệu thật: `DaoSi1` cấp 4, task 2613 = 1088857262 (= bộ Thổ + Hỏa + Băng: 4 5 6 8 10 13 16 18 20 21 24 25 26), server và tick chạy đúng.
- **Nguyên nhân chính — lệnh bài không bật tự đánh:** bản 1 chỉ lưu bộ chiêu, còn tự đánh vẫn phải bấm Alt+A. Tệ hơn, nếu đã bật Alt+A rồi mới mở lệnh bài thì tự đánh **tự tắt** ("đang mở hội thoại", vì mọi hộp thoại server mới đều dừng tự đánh). Người chơi chọn bộ xong thấy nhân vật đứng yên.
- **"Chưa chọn được từng chiêu":** trang bật/tắt có tồn tại nhưng nằm sâu ("Bật, tắt từng chiêu..." ở dòng 5), mỗi trang trộn 4 chiêu của nhiều hệ, trạng thái chỉ là `[x]`. Đợt 2 chuyển sang chọn theo nhóm (hệ / loại đao / hào quang), trạng thái `[BẬT]` / `[tắt]` rõ ràng. Mô phỏng còn bắt được lỗi ẩn: số đếm dạng "3/3" trong dòng menu làm engine cắt tên hàm ở dấu "/" đầu tiên — đã đổi thành "3 trong 3".
- **Kênh đồng bộ:** đã kiểm lại toàn tuyến `SyncTaskValue` → `s2c_synctaskvalue` (bảng kích thước `g_nProtocolSize` khớp enum, index 96) → `s2cSyncTaskValue` → `m_cTask`; không thấy lỗi. Từ đợt này client ghi `lbdaosi_diag.log` (thư mục Client, tối đa 400 dòng mỗi lần chạy) để lần sau đọc được: giá trị task nhận, lệnh bắt đầu/dừng, danh sách bộ chiêu lúc bật (cấp, loại, nội lực), thiếu nội lực, dự phòng.
- **Nội lực cấp thấp:** chiêu Đạo Sĩ cấp 1 tốn 2,5–33 nội lực (4/5/6 rẻ nhất, 23/26 đắt nhất); trước đây chiêu không đủ nội lực bị bỏ qua im lặng, và nếu cả bộ đều không dùng được thì đứng yên.

### 5.2 Cách sửa (C++ `PhongThanAutoFight.inl`, dấu `lbdaosi r2` / `lbdaosi r3`; giữ nguyên các đoạn daosi, botheal `af-*`, hanhtrang)

| Sửa | Chi tiết |
|---|---|
| Bắt đầu / dừng từ server | Task **2617** = số thứ tự × 4 + lệnh (1 bắt đầu như Alt+A, 2 dừng). Client so với giá trị đã thấy của cùng nhân vật; giá trị đầu tiên chỉ ghi nhận (không tự bật sau khi đăng nhập). Lệnh bài gửi giá trị hiện tại ngay khi mở menu, tick gửi lại mỗi phút. Đang tự đánh mà nhận "bắt đầu" thì chỉ thông báo lại số chiêu. Ở khu vực an toàn: server không gửi lệnh, báo ra ngoài bãi rồi bấm. |
| Thiếu nội lực | Mỗi chiêu của bộ thiếu nội lực báo **một lần** mỗi lần bật: "Thiếu nội lực cho chiêu X: tự đánh tạm bỏ qua chiêu này." |
| Dự phòng | Không chiêu nào của bộ dùng được (nội lực, hồi chiêu) → đánh bằng chiêu tay trái, tay phải hoặc đòn đánh thường của vũ khí; báo một lần. |
| Giáp Sĩ (r3) | Bộ thứ ba, task **2619** (bit id − 27). Chiêu được kiểm tra **vũ khí đang cầm** như `KSkill::CanCastSkill` (`EqtLimit` của `skills.txt`: 0 đoản đao, 1 trường đao, −2 mọi vũ khí; tay không → không dùng). Áp cho cả danh sách phím, nên Giáp Sĩ không còn bị lặp "không dùng được với vũ khí này". |
| Nhật ký | `lbdaosi_diag.log` như 5.1. |

### 5.3 Menu lệnh bài mới (cả 3 lệnh bài, ≤ 7 dòng mỗi trang)

1. Bắt đầu tự động đánh
2. Dừng tự động đánh
3. Bộ mặc định — Đạo Sĩ: Thổ + Hỏa + Băng; Dị Nhân: tất cả buff (hào quang + Bổ Tâm Chú); Giáp Sĩ: tất cả chiêu đánh
4. Bộ thứ hai — Đạo Sĩ: Hỏa + Băng + Lôi; Dị Nhân: buff + chú nguyền; Giáp Sĩ: đoản đao
5. Chọn từng chiêu (bật, tắt)... → nhóm (Đạo Sĩ: Hệ Thổ / Hỏa / Băng / Lôi / Buff hệ; Dị Nhân: Hào quang / Hồi máu và chú nguyền; Giáp Sĩ: Chiêu đoản đao / trường đao / Hào quang), mỗi nhóm ghi "(a trong b đang bật)" → trang nhóm: `[BẬT] tên` / `[tắt] tên`, "Xong, bắt đầu tự động đánh" (khi nhóm ≤ 5 chiêu), Quay lại.
6. Bộ khác, tùy chọn, nâng cấp kỹ năng... → bộ còn lại (Đạo Sĩ: tất cả các hệ, chỉ một hệ; Dị Nhân: chỉ hồi máu; Giáp Sĩ: trường đao), Theo phím đang gán / Tắt chiêu hỗ trợ, **Nâng cấp kỹ năng (tối đa)...**, "Tự bật tự đánh khi chọn bộ: ĐANG BẬT/TẮT" (task **2618**, mặc định bật).
7. Đóng

Chọn một bộ có sẵn → lưu, đóng menu và **tự bật tự đánh** (nếu tùy chọn bật). Bật/tắt từng chiêu không tự bật (chọn "Xong" hoặc "Bắt đầu"). Alt+A / Alt+S / Alt+D vẫn như cũ.

### 5.4 Lệnh Bài Giáp Sĩ (magicscript **61482**, task bộ chiêu **2619**, cờ đã phát **2620**)

| Nhóm | Chiêu (id) |
|---|---|
| Đoản đao (`EqtLimit` 0) | 27 Tế Huyết Trảm, 30 Hồi Phong Trảm, 32 Hoành Không Trảm, 36 Huyền Băng Trảm, 38 Liên Hoàn Trảm, 41 Thiên Quân Trảm |
| Trường đao (`EqtLimit` 1) | 29 Khai Sơn Trảm, 31 Điện Quang Trảm, 35 Tam Đầu Lục Thủ, 37 Hỏa Quang Trảm, 39 Lạc Địa Trảm, 42 Khuynh Thành Nhất Kích |
| Hào quang (duy trì như Dị Nhân) | 28 Lăng Ba Vi Bộ, 40 Thuần Dương Hộ Thể |
| Bị động (không dùng trong tự đánh) | 33 Tinh Thông Đoản Đao, 34 Tinh Thông Trường Đao |

Tự phát cho mọi nhân vật Giáp Sĩ như hai lệnh bài kia; hình Kỹ Năng Quyển VNG 5624.

### 5.5 Nâng cấp kỹ năng (cả 3 lệnh bài + web admin)

- **Nâng tối đa toàn bộ kỹ năng của phái** (có xác nhận): mọi kỹ năng phái trong `skills.txt` (Đạo Sĩ 3–26, Giáp Sĩ 27–42, Dị Nhân 43–51, kể cả bị động/buff) lên `MaxLevel` thật (cột 49 = 10), học luôn chiêu chưa có; thêm kỹ năng chuyển sinh của phái (1481–1489) **chỉ khi đủ cấp nhân vật** 60 / 120 / 180. Không đụng kỹ năng phái khác, kỹ năng đệ tử 450–461 (có điều kiện cấp riêng, dùng Lệnh Bài Triệu Hồi).
- **Nâng tối đa một kỹ năng:** danh sách 5 chiêu mỗi trang, dòng ghi "(cấp 3 trong 10)", "(chưa học, tối đa 10)" hoặc "(đã tối đa 10)" → xác nhận → nâng → hiện lại đúng trang.
- Cách nâng như web admin "Bí kíp / Kỹ năng": `SetSkillLevel` + `AddMagic` (AddMagic gửi gói kỹ năng xuống client nên thanh kỹ năng đổi ngay). **Không tốn và không hoàn điểm kỹ năng.**
- **Web admin** (thẻ "4. Lệnh Bài phái"): chọn phái + kỹ năng, nút "Nâng max toàn bộ kỹ năng" (có hỏi lại) và "Nâng max kỹ năng chỉ định" → hành động `lbmax` → bridge `PTLB_AdminMax`. Online áp ngay (kiểm tra đúng phái); offline lưu loại 4 trong `admin_bridge\lbdaosi_pending.txt` (phái × 10000 + kỹ năng) và áp khi đăng nhập.
- Web admin thêm "Phát Lệnh Bài Giáp Sĩ" và khung "Luân phiên chiêu Giáp Sĩ" (bộ có sẵn + tích từng chiêu, `lbskills` `which` = 3).

### 5.6 Kiểm thử đợt 2

| Kiểm thử | Kết quả |
|---|---|
| `qtest\sim_lbdaosi.lua` (`-Stack 100`, EMU headroom 39, `live`, `emulive` trên file runtime) | FAILS=0 (186 kiểm tra; thêm menu mới cả 3 lệnh bài, lệnh 2617, khu vực an toàn, tùy chọn tự bật, nhóm 6 chiêu, nâng cấp kỹ năng, Giáp Sĩ, admin max online/offline) |
| `qtest\test_admin_lbdaosi.ps1` | 15 / 0 |
| Smoke C++ `scratchpad\lbdaosi\smoke\` (nền là bản `items\smoke\lbdaosi_regress.cpp` có mock hanhtrang/botheal) | 85 / 0 (thêm: lệnh bắt đầu/dừng, giá trị đầu chỉ ghi nhận, khu vực an toàn, thiếu nội lực báo 1 lần, dự phòng tay trái/đánh thường, Giáp Sĩ đoản/trường đao/tay không, hào quang 40) |
| `scratchpad\botheal\patch_cpp.py --check` | af-def / af-func / af-call còn nguyên |
| ptfix build thử `scratchpad\lbdaosi\ptfix_test*.pak` | magicscript 5786 dòng, 61480 / 61481 / 61482 đủ 34 cột |
| Build-Modern CoreServer / CoreClient / GameClient | OK 20:48 |
| Áp nóng Lua qua bridge (20:50) | `result.log`: "r3 hot activation: 3 token scripts reloaded, lib r3 loaded" |

### 5.7 Cần triển khai

- [ ] **CoreClient.dll** (bản 20:48) cho client: bắt buộc để lệnh bài bật/dừng được tự đánh, có báo thiếu nội lực, dự phòng, lọc vũ khí Giáp Sĩ, nhật ký. Client cũ vẫn dùng được bộ chiêu nhưng không nhận lệnh bắt đầu/dừng.
- [ ] **ptfix** chính thức có `extra_lbdaosi.py` mới (thêm dòng 61482, mô tả mới cho 61480/61481), cài cho Server và Client. Trước khi có, Lệnh Bài Giáp Sĩ chưa phát được (tick thử lại mỗi phút).
- [ ] Người dùng đóng và mở lại web admin (sửa `.ps1`), F5.
- Lua đã áp nóng; không cần khởi động lại GameServer cho phần Lua (khởi động lại vẫn đúng vì file đã nằm trong runtime).