---
name: admin-van-hanh-phong-than
date: 2026-10-04
agent: adminops
summary: Web admin thêm 4 thẻ vận hành — Sức khỏe server (A1), Sao lưu & khôi phục gồm quay về bản DLL/ptfix trước (A2) và sao lưu nhân vật hằng ngày (A3), Quản lý nhân vật (xóa mềm / khôi phục), Tổ đội bot (C4: số bot, tỉ lệ phái, cấp, bật/tắt theo nhân vật).
status: Web admin đã sửa (cần mở lại web admin). party.lua mới nằm trong src, CHƯA chép vào runtime (chờ agent botheal xong để triển khai một lần).
---

# Web admin vận hành: sức khỏe server, quay về bản trước, sao lưu và quản lý nhân vật, tổ đội bot

## Phần 1: Tổng quan

- **Không cần nhờ Claude đọc log nữa**: thẻ *Sức khỏe server* cho thấy số NPC so với giới hạn engine và trần mật độ (đọc từ `matdo.txt`; 48.000 / 44.000 với CoreServer cũ, 96.000 / 92.000 với bản engine2), lỗi tick mới, nhân vật online, thời gian chạy, nhịp cầu nối, phiên bản ptfix.pak và DLL, xem 200 dòng cuối 4 file log. Tự làm mới 30 giây.
- **Bản build lỗi khôi phục trong 1 phút**: thẻ *Sao lưu & khôi phục* liệt kê mọi `server-deploy-*`, `client-deploy-*`, `ptfix-*`. Chỉ khôi phục khi GameServer, Bishop và Game đều tắt. Có 2 bước xác nhận. Bản đang dùng được sao lưu trước.
- **Nhân vật được sao lưu tự động** khi mở web admin và sau mỗi 24 giờ vào `_backup\characters\YYYYMMDD\`, giữ 7 ngày.
- **Xóa nhân vật luôn là xóa mềm**: file nhân vật chuyển vào thùng rác `_backup\characters\deleted\` và khôi phục được. Server chỉ lưu nhân vật ở `CharacterStore\role_<hex>.pthc`. Danh sách nhân vật của tài khoản được dựng lại bằng cách quét các file này, nên xóa nhất quán ở mọi nơi.
- **Tổ đội bot chỉnh được từ web**: số bot, tỉ lệ Giáp Sĩ / Đạo Sĩ / Dị Nhân, cấp bot (cấp người chơi ± n), bật/tắt và số bot riêng cho từng nhân vật. Cấu hình giữ qua khởi động lại server.

## Phần 2: Chi tiết

### A1. Sức khỏe server (thẻ "Sức khỏe server")

| Mục | Nguồn |
|---|---|
| GameServer chạy từ lúc nào, thời gian chạy | Tiến trình `GameServer.exe` (giờ tạo tiến trình), cùng danh sách Bishop / Goddess / Game |
| Nhịp cầu nối | `admin_bridge\heartbeat.txt`: nội dung và số giây từ lần ghi cuối; quá 150 giây thì báo "Chậm" |
| Nhân vật online | `admin_bridge\online.txt` |
| Số NPC, giới hạn engine, trần mật độ | `admin_bridge\matdo.txt`, dòng `total`: cột 1 = số NPC, cột 3 = trần mật độ. Ext matdo tính giới hạn engine = `GetNpcCount() + GetFreeNpcCount() + 1` và trần = giới hạn − 4.000, nên web lấy giới hạn = trần + 4.000. Nếu sau này matdo ghi thêm cột 11 (≥ 48.000) thì dùng thẳng cột đó. Chưa có file thì hiện 48.000 và ghi "mặc định". Thanh đổi màu ở 85 % và 95 % của giới hạn engine. Báo khi file cũ hơn 2 phút |
| Lỗi tick | `admin_bridge\tick_error.log`: số dòng từ khi GameServer khởi động, trong 1 giờ qua, tổng, dòng cuối |
| ptfix.pak | `Server\data` và `Client\data`, cùng `AdminWeb\pending\ptfix.pak` (nếu có bản chờ cài): kích thước, ngày, MD5 8 ký tự, mã băm khớp `NATIVE_DEPLOYMENT.json` |
| DLL / exe | Server: GameServer, CoreServer, Engine, LuaLibDll, Bishop, Goddess. Client: Game, CoreClient, Engine, LuaLibDll, Represent2. Hiển thị ngày build (dấu thời gian PE), ngày file, khớp receipt |
| Nhật ký | Nút xem 200 dòng cuối của `result.log`, `tick_error.log`, `newbie2_error.log`, `petai.log`. Đọc tối đa 256 KB cuối file, chữ TCVN3 hiển thị thành Unicode |

- Mã băm được nhớ theo kích thước và ngày file: lần đầu khoảng 0,7 giây, các lần sau khoảng 0,2 giây.
- API: `GET /api/health`, `GET /api/logtail?name=result|tick_error|newbie2_error|petai&n=200`.

### A2. Quay về bản trước (thẻ "Sao lưu & khôi phục")

| Loại | Nội dung bản sao lưu | Khôi phục vào |
|---|---|---|
| `server-deploy-*` (Deploy-ModernServer) | File **trước** lần triển khai: `PhongThanRuntime-Staging\*` và `Output\*`. Bản `*-core` dạng phẳng `PhongThanRuntime-Staging-CoreServer.dll`, `Output-CoreServer.dll` | `PhongThanRuntime-Staging\Server` và `PhongThanSource\Output\Server` |
| `client-deploy-*` (Deploy-ModernClient) | Như trên, phía Client, gồm cả .pdb / .map | `...\Client` và `Output\Client` |
| `ptfix-*` (PhongThan-ClientPatch) | `Server-ptfix.pak` và `Client-ptfix.pak` là bản **trước** lần cài. `installed-ptfix.pak` là bản được cài lúc đó, không dùng để khôi phục. Bản thiếu một phía thì dùng file còn lại cho cả hai | `Server\data\ptfix.pak` và `Client\data\ptfix.pak` |

- **Bước 1** (`POST /api/rollback/prepare`):
  - Từ chối nếu GameServer, Bishop hoặc Game đang chạy.
  - Trả về danh sách file sẽ ghi đè và mã 4 số (hiệu lực 5 phút, dùng 1 lần).
- **Bước 2** (`POST /api/rollback/run`):
  - Hộp thoại liệt kê file, người dùng gõ lại mã.
  - Kiểm tra lại tiến trình và các file đích có đang bị khóa không. Có vấn đề thì dừng trước khi chép.
  - Sao lưu bản đang dùng thành `_backup\<loại>-<giờ>-rollback\`, cùng cấu trúc, kèm `NATIVE_DEPLOYMENT.json`. Bản này cũng hiện trong danh sách và khôi phục lại được.
  - Chép file và so mã băm sau khi chép.
- **Cập nhật `NATIVE_DEPLOYMENT.json`** (trình khởi động yêu cầu runtime trùng receipt):
  - Server/Client: tính lại mã băm các artifact vừa khôi phục, các mục khác giữ nguyên.
  - ptfix: cập nhật mục `ptfix.pak` trong PakChain (Length, Sha256, TotalBytes), giống cách PhongThan-ClientPatch làm.
- Danh sách đánh dấu "giống bản đang dùng" khi mọi file trùng kích thước và ngày với file hiện tại.
- Nhật ký: `AdminWeb\data\adminops.log`, hiển thị ở cuối thẻ.

### A3. Sao lưu nhân vật hằng ngày

- **Nội dung sao lưu:**
  - Mọi file trong `Server\CharacterStore`. Mỗi file `.pthc` được kiểm tra header và checksum FNV. Đọc lỗi thì thử lại 5 lần, file vẫn lỗi được ghi rõ trong `manifest.json`.
  - Database **account** (tài khoản, xu): dùng `BACKUP DATABASE [account] ... WITH COPY_ONLY`, cách sao lưu trực tuyến an toàn khi server đang chạy và không làm đứt chuỗi log. **Chỉ chạy khi instance MSSQLLocalDB đang chạy**: web admin không tự khởi động LocalDB. LocalDB tắt thì chỉ sao lưu file nhân vật, cột "Database" ghi "Bỏ qua (LocalDB đang tắt)".
- **Nơi lưu:** `_backup\characters\YYYYMMDD\`, mỗi ngày một thư mục. Sao lưu lại trong ngày thì thay thư mục của ngày đó, ghi qua thư mục tạm rồi đổi tên. Giữ 7 thư mục ngày mới nhất, thư mục cũ hơn bị xóa.
- **Lịch chạy:** lần đầu khi mở web admin (ở vòng chờ đầu tiên), sau đó mỗi 24 giờ, qua `Invoke-AdminOpsTick` gọi từ `Invoke-Scheduler`. Không tạo Scheduled Task. Có nút "Sao lưu ngay". Lỗi thì thử lại sau 1 giờ và ghi nhật ký.
- **Khôi phục (thủ công):**
  - Chọn ngày, rồi chọn "Tất cả nhân vật" hoặc một nhân vật.
  - Bắt buộc GameServer, Goddess, Bishop đều tắt.
  - 2 bước: hộp thoại xác nhận, rồi gõ mã 4 số.
  - File hiện tại được sao lưu vào `_backup\characters\truoc-khoi-phuc-<giờ>\` trước khi ghi đè. File sao lưu sai checksum thì từ chối khôi phục.
- **Khôi phục database account không làm từ web** (cần quyền dùng riêng database). Cách làm thủ công:
  1. Tắt toàn bộ server.
  2. Sao lưu tay bản account hiện tại: thẻ Cài đặt server → "Sao lưu account hiện tại".
  3. Chạy `RESTORE DATABASE [account] FROM DISK = N'<_backup\characters\YYYYMMDD\account.bak>' WITH REPLACE` bằng sqlcmd / SSMS trên `(localdb)\MSSQLLocalDB`.

### Quản lý nhân vật (thẻ "Quản lý nhân vật")

- **Server lưu nhân vật ở đâu** (đã kiểm tra mã nguồn `MultiServer\Goddess\PhongThanCharacterStore.cpp`):
  - Mỗi nhân vật là một file `CharacterStore\role_<hex tên TCVN3, chữ ASCII viết thường>.pthc`.
  - `List(account)` quét `CharacterStore\*.pthc`, lấy file có `AccountName` trùng và checksum đúng.
  - Lệnh xóa của chính engine là `DeleteFileA` file đó.
  - Database `account` không có bảng nhân vật (chỉ có `Account_Info`, `Account_Habitus`).
  - Vì vậy, chuyển file ra khỏi `CharacterStore` là gỡ nhân vật khỏi mọi nơi: tài khoản không còn trỏ tới nhân vật không tồn tại.
- **Danh sách:** tên, tài khoản, cấp, phái đọc từ header file (RoleName ở byte 32, AccountName ở byte 64, Profession ở byte 97, FightLevel ở byte 224), cùng ngày ghi file và cờ online. Nhân vật có file sai checksum vẫn hiện nhưng không có nút Xóa.
- **Xóa (mềm):**
  - Điều kiện:
    - Nhân vật không có trong `online.txt`.
    - Nếu GameServer đang chạy, `online.txt` phải mới hơn 150 giây; nếu không thì từ chối vì không biết ai đang online.
    - Engine không cần tắt server để xóa: Goddess đọc file mỗi lần đăng nhập và lập danh sách.
  - Bước 1: hộp thoại thông tin. Bước 2: gõ lại **đúng tên** nhân vật, phân biệt hoa thường. Kèm mã ẩn của bước 1 (5 phút, dùng 1 lần).
  - File được **chuyển** (đổi tên trên cùng ổ) vào `_backup\characters\deleted\YYYYMMDD-HHMMSS-<tên không dấu>\`. Thư mục này kèm `info.json` (tên, tài khoản, cấp, phái, SHA-256, giờ xóa). Không bao giờ xóa vĩnh viễn.
- **Dữ liệu phụ thuộc:**
  - `admin_bridge\lbdaosi_pending.txt` (bộ chiêu Lệnh Bài chờ áp khi đăng nhập): các dòng của nhân vật được cất vào thư mục thùng rác. Chúng chỉ bị gỡ khỏi file khi GameServer tắt, vì server đang chạy giữ file này trong bộ nhớ và tự ghi lại. Khi server đang chạy các dòng này còn nằm lại; chúng vô hại vì nhân vật đã xóa không đăng nhập được, nhưng sẽ áp nếu sau này tạo nhân vật trùng tên.
  - Các mục chỉ ghi chú, không tự dọn: dòng nhân vật trong thẻ Tổ đội bot (`botparty_config.lua`, vô hại); `AdminWeb\data\chest_backup` và các bản sao lưu ngày (giữ để khôi phục được); lệnh cầu nối đang chờ có tên nhân vật (báo "offline" khi chạy).
  - Chưa có cấu hình nhặt đồ theo nhân vật nào trên server lúc viết tài liệu này.
- **Khôi phục từ thùng rác:**
  - Từ chối nếu đã có nhân vật trùng tên (trùng file), hoặc tài khoản đã đủ 3 nhân vật (`PHONGTHAN_CHARACTER_LIMIT`), hoặc file trong thùng rác sai checksum.
  - 2 bước, có gõ mã.
  - Chép file về `CharacterStore` qua file tạm (`.admin.tmp`, không bị Goddess quét), giữ bản trong thùng rác và ghi `restored` vào `info.json`.
- API: `GET /api/chars`, `POST /api/chars/delete/prepare` → `/api/chars/delete` (file, code, name), `POST /api/chars/undelete/prepare` → `/api/chars/undelete` (folder, code).

### C4. Tổ đội bot (thẻ "Tổ đội bot")

- **Cấu hình:** `admin_bridge\botparty_config.lua`, ASCII. Bản web lưu ở `AdminWeb\data\botparty.json`.

```lua
PTBPC_CFG = { count = 0, gs = 2, ds = 1, dn = 1, lvoff = 0, lvspread = 2, chars = {
	{ name = "lichnt", mode = 1, count = 3 },
} }
```

- **Quy tắc trong `party.lua`** (hàm `PTBPC_*`, file đọc lại mỗi phút trong `PTBP_Tick`):

| Thiết lập | Ý nghĩa | Ưu tiên |
|---|---|---|
| Số bot | Dòng nhân vật > số bot chung của thẻ này (`count`) > lựa chọn ở NPC "Hỗ Trợ Tổ Đội" (task 2071) > số mặc định ở thẻ Bot | Cao → thấp |
| Bật/tắt | Dòng nhân vật `mode` 1 = luôn bật, 2 = luôn tắt; 0 = theo NPC trong game (task 2070) | Công tắc "Tự động tổ đội bot" ở thẻ Bot vẫn là công tắc tổng |
| Tỉ lệ phái | Trọng số 0–10 cho Giáp Sĩ (mẫu 2703–2708), Đạo Sĩ (2709–2714), Dị Nhân (2715–2720). Ô thứ j của tổ đội lấy phái theo vòng chọn có trọng số (smooth weighted round robin), nên mọi số bot đều giữ đúng tỉ lệ và bot gọi lại ở ô cũ giữ phái cũ. Cả ba bằng 0 = trộn theo danh sách tên như trước | — |
| Cấp bot | Cấp người chơi + `lvoff` (−20…+20) ± `lvspread` (0–5), trong khoảng 1–200. Mặc định ±2 như trước | — |

- **Tên nhân vật:** so khớp sau khi viết thường chữ ASCII, giống cách Goddess đặt tên file. Chữ TCVN3 có dấu giữ nguyên byte.
- **Bấm Áp dụng:** lệnh cầu nối gọi `PTBPC_Load()`, rồi `PTBPC_Rebuild()` gỡ bot tổ đội của mọi người đang online, rồi `PTBOT_AdminApply()` gọi lại bot theo phái và cấp mới. Nếu server còn chạy `party.lua` cũ (chưa có `PTBPC_Load`), lệnh tự nạp lại file; nếu vẫn chưa có thì báo FAIL "party.lua trên server chưa có bản adminops". Cấu hình vẫn được lưu và có hiệu lực khi cài `party.lua` mới.
- **Không có file cấu hình** thì hành vi giống hệt trước: sim hồi quy cho kết quả từng dòng trùng bản cũ.
- **File đã sửa:** `scratchpad\botparty\src\party.lua` (4 dòng móc trong `PTBP_Want`, `PTBP_Spawn`, `PTBP_Tick`, cùng khối hàm `PTBPC_*` ở cuối file). Agent botheal sửa cùng file sau đó, và src hiện có cả hai phần.

## Phần 3: Hành động

| # | Việc | Ai | Khi nào |
|---|---|---|---|
| 1 | Đóng cửa sổ web admin rồi mở lại (`PhongThan-Admin.cmd`), sau đó bấm F5 | Người dùng | Ngay |
| 2 | Kiểm tra thẻ Sức khỏe server, xem `tick_error.log` | Người dùng | Sau bước 1 |
| 3 | Xem lần sao lưu nhân vật đầu tiên ở thẻ Sao lưu & khôi phục | Người dùng | Sau bước 1 |
| 4 | Triển khai `party.lua`: chạy `scratchpad\botparty\gen.py` → `out\`, kiểm tra runtime trùng `out\` cũ (hash `3DD612FA…`), chép `out\party.lua` + `out\party_npc.lua` vào `Server\script\phongthan\bots\`. Gộp chung với lần cài của botheal | Điều phối / botheal | Khi botheal xong |
| 5 | Thử thẻ Tổ đội bot: đặt tỉ lệ 2:1:1, bấm Áp dụng, xem bot trong game | Người dùng | Sau bước 4 |

- Không cần khởi động lại GameServer cho các thẻ web. `party.lua` nạp nóng qua lệnh cầu nối của thẻ Tổ đội bot.

## Phần 4: Tài liệu tham khảo

- Mã: `AdminWeb\PhongThan-Admin.ps1`, khối "admin ops (2026-10-04 adminops)": các route `/api/health`, `/api/logtail`, `/api/rollback*`, `/api/charbackup*`, `/api/chars*`, `/api/botparty`, và một dòng trong `Invoke-Scheduler`. `AdminWeb\index.html`: 4 thẻ mới.
- Nguồn engine: `MultiServer\Goddess\PhongThanCharacterStore.cpp`, `Headers\PhongThanCharacter.h`, `Headers\PhongThanProtocol.h` (giới hạn 3 nhân vật).
- Kiểm thử:
  - `scratchpad\adminops\test_ps1.ps1 [-FromFile]`: 83 đạt / 0 lỗi, chạy trên bản sao trong `scratchpad\adminops\t`. LocalDB và tiến trình được giả lập.
  - `qtest\sim_adminops.lua`: 29/0 với `-Stack 100` và EMU; headroom `PTBOT_Tick` 37 khung, bằng trước.
  - `qtest\sim_bp_regress.lua`: kết quả trùng từng dòng bản cũ.
  - `qtest\sim_adminops_cfg.lua`: 5/0.
- Sao lưu trước khi sửa: `_backup\20261004-adminops\`.
- Liên quan: `to-doi-bot-phong-than-20261003.md`, `mo-ruong-2-5-phong-than-20261003.md`, `de-xuat-tinh-nang-phong-than-20261004.md` (A1–A3, C4).
