# Tính năng: Cài đặt server tự động (SQL LocalDB + database account) để chia sẻ source

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã triển khai**. Tab "Cài đặt server" trên web admin, file `PhongThan-CaiDat.cmd`. Đã kiểm thử phần kiểm tra trạng thái, phần gắn lại database và phần khôi phục từ `account.bak` (khôi phục vào database tạm, 10 tài khoản, sau đó xóa).

## Phần 1: Tổng quan

- **Mục tiêu:** chép nguyên thư mục `PT` sang máy khác, bấm một nút là server có database và chạy được.
- **Bối cảnh sự cố ngày 2026-09-29:**
  - LocalDB khởi động lại lúc 08:27 và mất đăng ký database `account`. File dữ liệu vẫn còn nguyên.
  - Hậu quả là lỗi *"Cannot open database account"*. Đã sửa: bảng điều khiển (`Start-StagingServer.ps1`) giờ tự gắn lại database này trước khi kiểm tra kết nối.
- **Nguyên tắc an toàn khi xử lý database `account`:**

| Tình huống | Hành động |
|---|---|
| Database đang gắn | Không làm gì |
| Có file dữ liệu trong `PhongThanRuntime-State\sql` | **Gắn lại**, giữ nguyên tài khoản hiện có |
| Chưa có gì (máy mới) | Khôi phục từ `Server\database\account.bak` |

## Phần 2: Chi tiết

### 2.1 Thành phần
| Tệp | Vai trò |
|---|---|
| `AdminWeb\PhongThan-Setup.ps1` | Script cài đặt. Các bước: `check`, `all`, `localdb`, `database`, `backup` |
| `AdminWeb\PhongThan-Admin.ps1` | API `GET /api/setup/status` và `POST /api/setup/run` (chạy nền, ghi nhật ký vào `AdminWeb\data\setup.log`) |
| `AdminWeb\index.html` | Tab **Cài đặt server** |
| `PhongThan-CaiDat.cmd` | Chạy cài đặt không cần web |
| `Setup\SqlLocalDB.msi` (65 MB) | Bộ cài SQL Server 2025 LocalDB, đi kèm source |
| `Setup\SQL2022-SSEI-Expr.exe` | Dự phòng: tải LocalDB từ Microsoft nếu thiếu file msi |
| `PhongThanSource\Deploy\Start-StagingServer.ps1` | Tự gắn lại database `account` mỗi lần khởi động server |

### 2.2 Các bước
1. **Cài SQL LocalDB:**
   - Bỏ qua nếu đã có `SqlLocalDB.exe`.
   - Nếu chưa có: chạy `msiexec /i SqlLocalDB.msi /qn IACCEPTSQLLOCALDBLICENSETERMS=YES`. Windows hiện hộp thoại UAC xin quyền quản trị.
2. **Khởi động instance `MSSQLLocalDB`:** tạo instance nếu chưa có.
3. **Database `account`:** gắn lại hoặc khôi phục. Khi khôi phục, script đọc `RESTORE FILELISTONLY` để lấy tên logic, rồi `MOVE` vào `account_account_Data.mdf` và `account_account_Log.ldf`.
4. **Cập nhật `DataBase.ini`:** ghi pipe mới. Bảng điều khiển cũng tự ghi lại pipe mỗi lần khởi động.
5. **Sao lưu (`backup`):**
   - `BACKUP DATABASE ... COPY_ONLY` ra `Server\database\account.bak`.
   - Bản cũ được giữ ở `_backup\account-bak-<thời gian>`.

### 2.3 Lưu ý
- LocalDB **tự tắt khi không có kết nối**, và pipe đổi sau mỗi lần bật. Vì vậy trạng thái "Đang tắt" là bình thường; server sẽ tự bật lại khi khởi động.
- Không chạy cài đặt từ hai tài khoản Windows khác nhau. Instance LocalDB gắn với từng người dùng.
- `account.bak` chứa toàn bộ tài khoản và mật khẩu đã mã hóa. Chỉ chia sẻ cho người tin cậy.

## Phần 3: Hành động

### Máy hiện tại, trước khi chia sẻ
- [ ] Web admin → **Cài đặt server** → **Sao lưu account hiện tại → account.bak**. Hiện live có 11 tài khoản, còn `account.bak` cũ chỉ có 10.
- [ ] Nén cả thư mục `PT`. Có thể bỏ `_backup\` để giảm dung lượng.

### Máy mới
- [ ] Giải nén, chạy `PhongThan-CaiDat.cmd` (hoặc mở web admin → **Cài đặt tự động**). Bấm **Yes** ở hộp thoại UAC.
- [ ] Khi nhật ký báo "HOAN TAT", chạy `PhongThan-BangDieuKhien.cmd` để khởi động server, rồi `PhongThan-MoGame.cmd` để vào game.

## Phần 4: Tài liệu tham khảo
- Hướng dẫn cài đặt gốc: `huong-dan-cai-dat-phong-than-20260928.md`
- Log cài LocalDB: `%TEMP%\pt_localdb_install.log`
- Backup ngày 2026-09-29: `_backup\20260929-accountdb\`, `_backup\20260929-admin-web-v8\`
