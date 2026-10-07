# Hướng dẫn cài đặt và chạy game Phong Thần (bản local)

> Thư mục gốc: `E:\VL\Phong than\PT` · Kiểm tra máy ngày 2026-09-28 · Windows 11 Enterprise

## Phần 1: Tổng quan

### Kết quả kiểm tra máy hiện tại

| Hạng mục | Trạng thái | Ghi chú |
|---|---|---|
| Bộ runtime (`PhongThanRuntime-Staging`) | ✅ Đạt | `Test-NativeRuntime` PASS: 22 file build khớp hash, 102 bản đồ |
| ODBC driver `SQL Server` 32-bit | ✅ Có sẵn | Server dùng driver này để đọc database tài khoản |
| PowerShell 32-bit | ✅ Có sẵn | Dùng để kiểm tra kết nối database |
| **SQL Server Express LocalDB** | ❌ **Chưa cài** | **Bắt buộc** — lưu tài khoản đăng nhập |
| **Database `account`** | ❌ **Chưa có** | Có file sao lưu `Server\database\account.bak` (45 MB) để khôi phục |
| Visual C++ 6 (`DUMPBIN.EXE`) | ⚠️ Không có | Nút "Mở client" trên bảng điều khiển sẽ báo lỗi → dùng cách mở client trực tiếp (Bước 5) |

### Nhận định chính

- **Không cần build lại mã nguồn.** Bản runtime đã build sẵn và toàn vẹn — chỉ cần dựng database là chạy được.
- Lỗi cuối cùng trong `ControlLogs` là `Cannot open database "account"` → xác nhận đúng nguyên nhân: database chưa được khôi phục.
- Toàn bộ server chạy trên `127.0.0.1` (loopback), không mở ra Internet.

### Kiến trúc chạy game

```
Game.exe (client) ──5622──► Bishop.exe (gateway) ──5632──► GameServer.exe (6666, 102 bản đồ)
                                 │
                                 ├──5002──► PhongThanAccountServer.exe ──► LocalDB: database "account"
                                 └──5001──► Goddess.exe (nhân vật, Berkeley DB trong Server\database)
                  PhongThanRelay.exe (5003) — kênh liên lạc giữa các service
```

---

## Phần 2: Các bước cài đặt chi tiết

### Bước 1 — Cài SQL Server Express LocalDB (một lần duy nhất)

1. Tải **SQL Server 2022 Express** từ trang chính thức Microsoft: <https://www.microsoft.com/sql-server/sql-server-downloads> → mục **Express** → *Download now*.
2. Chạy file tải về → chọn **Download Media** → chọn gói **LocalDB** (khoảng 50–60 MB) → tải về `SqlLocalDB.msi`.
3. Chạy `SqlLocalDB.msi` → Next → chấp nhận điều khoản → Install.
4. Mở **PowerShell mới** và kiểm tra:

```bash
& "C:\Program Files\Microsoft SQL Server\160\Tools\Binn\SqlLocalDB.exe" info
```

Kết quả phải có dòng `MSSQLLocalDB`. (Nếu thư mục khác `160`, tìm `SqlLocalDB.exe` trong `C:\Program Files\Microsoft SQL Server\`.)

> Chọn bản 2022 để chắc chắn khôi phục được `account.bak` — LocalDB đời mới đọc được bản sao lưu đời cũ, ngược lại thì không.

### Bước 2 — Khôi phục database `account` từ file sao lưu

Mở PowerShell (không cần quyền Admin), dán nguyên khối lệnh sau:

```powershell
$sqlLocalDb = Get-ChildItem "C:\Program Files\Microsoft SQL Server" -Filter SqlLocalDB.exe -Recurse | Select-Object -First 1 -ExpandProperty FullName
& $sqlLocalDb create MSSQLLocalDB -s 2>$null; & $sqlLocalDb start MSSQLLocalDB

$bak     = "E:\VL\Phong than\PT\PhongThanRuntime-Staging\Server\database\account.bak"
$dataDir = "E:\VL\Phong than\PT\PhongThanRuntime-State\sql"
New-Item -ItemType Directory -Force $dataDir | Out-Null

$cn = New-Object System.Data.SqlClient.SqlConnection "Server=(localdb)\MSSQLLocalDB;Integrated Security=true;Database=master"
$cn.Open(); $cmd = $cn.CreateCommand(); $cmd.CommandTimeout = 600
$cmd.CommandText = "RESTORE FILELISTONLY FROM DISK = N'$bak'"
$rd = $cmd.ExecuteReader(); $moves = @()
while ($rd.Read()) {
  $ln = $rd['LogicalName']; $ext = if ($rd['Type'] -eq 'L') { 'ldf' } else { 'mdf' }
  $moves += "MOVE N'$ln' TO N'$dataDir\account_$ln.$ext'"
}
$rd.Close()
$cmd.CommandText = "RESTORE DATABASE [account] FROM DISK = N'$bak' WITH " + ($moves -join ', ') + ", RECOVERY"
$cmd.ExecuteNonQuery() | Out-Null
$cmd.CommandText = "SELECT COUNT(*) FROM account.dbo.Account_Info"
"Khôi phục xong. Số tài khoản hiện có: " + $cmd.ExecuteScalar()
$cn.Close()
```

- Dữ liệu SQL được đặt ở `PT\PhongThanRuntime-State\sql` — tách khỏi thư mục Staging nên khi build lại runtime **không mất tài khoản**.
- Lệnh không dùng `REPLACE` nên nếu database `account` đã tồn tại, nó sẽ báo lỗi thay vì ghi đè — an toàn cho dữ liệu cũ.

### Bước 3 — Mở bảng điều khiển và bật server

Tạo lối tắt riêng (file `PhongThan-Control.cmd` có sẵn trong `Server\` đang trỏ tới ổ `F:\` của máy cũ nên **không dùng được**):

```bash
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File "E:\VL\Phong than\PT\PhongThanSource\Deploy\PhongThan-Control.ps1"
```

Trên cửa sổ **"Phong Than - Server / Client / Tai khoan"**:

1. Bấm **Bat server**. Script sẽ tự: khởi động LocalDB → cập nhật pipe vào `Server\DataBase.ini` → kiểm tra kết nối database → bật lần lượt Goddess → AccountServer → Relay → Bishop → GameServer.
2. Chờ tới khi log hiện `Status = READY_FOR_LOGIN` và `MapCount = 102` (thường 30–60 giây).
3. Nếu Windows Firewall hỏi quyền cho `Bishop.exe`, `GameServer.exe`… → chọn **Allow** (chỉ mạng Private là đủ).

### Bước 4 — Tạo tài khoản chơi

Trên bảng điều khiển bấm **Tao tai khoan**:

| Trường | Quy tắc |
|---|---|
| Tên tài khoản | 6–16 ký tự, chỉ chữ và số không dấu |
| Mật khẩu | 6–16 ký tự ASCII, không có khoảng trắng |

- Tài khoản mới chưa có nhân vật — tạo nhân vật trong game.
- Mật khẩu cấp 2 / mật khẩu xóa nhân vật mặc định **trùng mật khẩu đăng nhập**.

### Bước 5 — Mở client và vào game

Nút **Mo client** trên bảng điều khiển sẽ báo lỗi `Thieu: D:\VisualStudio6\...\DUMPBIN.EXE` vì script kiểm tra renderer cần bộ công cụ Visual C++ 6 của máy build gốc. Bỏ qua bước kiểm tra đó bằng cách mở client trực tiếp (renderer đã được xác minh qua hash ở `Test-NativeRuntime`):

```powershell
$env:__COMPAT_LAYER = 'HIGHDPIAWARE'; Start-Process "E:\VL\Phong than\PT\PhongThanRuntime-Staging\Client\Game.exe" -WorkingDirectory "E:\VL\Phong than\PT\PhongThanRuntime-Staging\Client"
```

Trong game:

1. Chọn cụm **Phong Than Online (DEV AG v1)** → máy chủ **Trieu Ca (127.0.0.1)**.
2. Đăng nhập bằng tài khoản vừa tạo ở Bước 4.
3. Tạo nhân vật → vào game. Túi tân thủ (starter bag) được phát tự động.

> Client chạy chế độ cửa sổ 1024×768 (`Client\config.ini`: `FullScreen=0`). Muốn toàn màn hình → đổi `FullScreen=1`.

### Bước 6 — Tắt game đúng cách (tránh mất dữ liệu nhân vật)

1. Thoát nhân vật trong game, đóng client.
2. Trên bảng điều khiển bấm **Dung server** — GameServer sẽ lưu toàn bộ nhân vật rồi mới thoát (tối đa 180 giây).
3. **Không** tắt bằng Task Manager hay `Stop-StagingRuntime.ps1` khi đang có người chơi — script đó ép tắt tiến trình, có thể mất tiến độ nhân vật.

---

## Phần 3: Checklist và xử lý sự cố

### Checklist lần đầu

- [ ] Cài `SqlLocalDB.msi` (SQL Server 2022 Express LocalDB)
- [ ] Chạy khối lệnh khôi phục `account.bak` → thấy "Khôi phục xong"
- [ ] Tạo lối tắt bảng điều khiển trên Desktop
- [ ] Bat server → `READY_FOR_LOGIN`, 102 maps
- [ ] Tạo tài khoản
- [ ] Mở client trực tiếp → đăng nhập → tạo nhân vật

### Checklist mỗi lần chơi

1. Mở bảng điều khiển → **Bat server** → chờ `READY_FOR_LOGIN`
2. Mở client (lệnh ở Bước 5)
3. Chơi xong: thoát game → **Dung server**

### Bảng xử lý lỗi thường gặp

| Thông báo lỗi | Nguyên nhân | Cách xử lý |
|---|---|---|
| `Khong tim thay SqlLocalDB.exe` | Chưa cài LocalDB | Làm Bước 1 |
| `Cannot open database "account"` | Chưa khôi phục database | Làm Bước 2 |
| `Thieu: D:\VisualStudio6\...\DUMPBIN.EXE` | Nút "Mo client" cần VC6 | Mở client trực tiếp (Bước 5) |
| `Server da chay` / `Server already running` | Còn tiến trình cũ | Bấm **Trang thai** xem tiến trình → **Dung server** |
| `... missing ports: 5001` (hoặc 5622, 6666…) | Cổng bị phần mềm khác chiếm | Chạy `Get-NetTCPConnection -LocalPort 5622 -State Listen` để tìm tiến trình chiếm cổng |
| `Bishop has not confirmed all 102 maps` | GameServer nạp bản đồ chậm | Chờ thêm, xem `Server\native_world_ready.log` và `Server\core_map_load_diag.log` |
| Client mở rồi tự tắt | Thiếu DirectPlay / DirectX cũ | Windows sẽ hỏi cài **DirectPlay** → đồng ý; hoặc bật trong *Turn Windows features on or off → Legacy Components → DirectPlay* |
| Chữ/hình bị mờ trên màn hình 4K | Scaling DPI | Đã có `HIGHDPIAWARE` trong lệnh mở; nếu vẫn mờ → chuột phải `Game.exe` → Properties → Compatibility → Change high DPI settings |

### File log cần xem khi lỗi

| Vị trí | Nội dung |
|---|---|
| `PhongThanRuntime-Staging\ControlLogs\*.log` | Kết quả từng thao tác trên bảng điều khiển |
| `Server\gameserver_login_diag.log` | Đăng nhập, lưu nhân vật |
| `Server\bishop_login_diag.log` | Gateway, xác thực tài khoản |
| `Client\login_connect_diag.log` | Client kết nối server |

---

## Phần 4: Tài liệu tham khảo

- Tài liệu gốc của dự án: `PhongThanSource\README.md`, `PhongThanSource\Deploy\PhongThan-Control.README.md`
- Script khởi động server: `PhongThanSource\Deploy\Start-NativeServer.ps1`
- Cấu hình cổng/địa chỉ: `Server\ServerCfg.ini`, `Server\Bishop.cfg`, `Client\serverlist.ini`
- **Chỉ cần khi muốn sửa mã nguồn và build lại**: Visual C++ 6 đặt tại `D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\`, sau đó làm theo 16 bước trong `PhongThanSource\README.md`

### Bước tiếp theo đề xuất

1. Sửa `Server\PhongThan-Control.cmd` trỏ về đường dẫn `E:\` mới.
2. Thêm tham số để nút **Mo client** bỏ qua kiểm tra `DUMPBIN` khi máy không có VC6.
3. Cho phép chơi qua mạng LAN: đổi `127.0.0.1` trong `ServerCfg.ini`, `Bishop.cfg`, `serverlist.ini` sang IP LAN của máy chủ.
