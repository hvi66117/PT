# Tính năng: Chạy tất cả bằng một file (database → server → web admin)

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã triển khai**. Kiểm tra cú pháp đạt. Chưa chạy thử trọn vòng vì server đang chạy cho người chơi.

## Phần 1: Tổng quan
- `PhongThan-ChayTatCa.cmd` làm lần lượt:
  1. Kiểm tra và cài SQL LocalDB, gắn lại hoặc khôi phục database `account` (`PhongThan-Setup.ps1 -Step all`).
  2. Bật server bằng đúng script của bảng điều khiển (`Start-NativeServer.ps1`). Nếu server đang chạy thì bỏ qua.
  3. Mở web admin ở cửa sổ riêng (`http://localhost:8765/`). Nếu web đang chạy thì chỉ mở trình duyệt.
- `PhongThan-ChayTatCa.cmd game`: làm như trên rồi mở luôn client game.

## Phần 2: Chi tiết
| Tệp | Vai trò |
|---|---|
| `PhongThan-ChayTatCa.cmd` | File chạy chính |
| `AdminWeb\PhongThan-RunAll.ps1` | Logic 3 bước. Mỗi bước in `== x/3`; khi có lỗi in `LOI:` |
| `PhongThanSource\Deploy\Start-NativeServer.ps1` | Đã thêm bước tự gắn database (sửa lỗi "Cannot open database account" sáng 2026-09-29) |

- Các file chạy khác vẫn dùng như cũ:

| File | Dùng khi |
|---|---|
| `PhongThan-BangDieuKhien.cmd` | Dừng server |
| `PhongThan-MoGame.cmd` | Mở client |
| `PhongThan-Admin.cmd` | Chỉ mở web |
| `PhongThan-CaiDat.cmd` | Chỉ cài đặt |

## Phần 3: Hành động
- [ ] Lần tới khi khởi động lại (để nạp ptfix.pak): Dừng server trong bảng điều khiển, thoát client, rồi chạy `PhongThan-ChayTatCa.cmd game`.

## Phần 4: Tài liệu tham khảo
- `cai-dat-server-localdb-phong-than-20260929.md`, `goi-va-ptfix-pak-phong-than-20260929.md`
