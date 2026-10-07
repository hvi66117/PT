# Tính năng 4: Phát đồ lục theo hệ phái và cấp

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai** trên web admin (tab "Đồ lục")

## Phần 1: Tổng quan

- **Đồ lục là trang bị theo bộ**: trong bảng dữ liệu gốc, mỗi món có mã bộ (cột 69 `套装id`). Mỗi bộ gồm **5 món**: Giáp, Mũ, Giày, Thắt lưng, Bội.
- **Mỗi phái có một chuỗi bộ đồ riêng theo cấp**: bộ cấp 20 → 40 → 60 → 80 → 100, cùng 2 bộ không yêu cầu cấp (bộ #6, #7).
- **Giới hạn phái** nằm ở cặp cột "yêu cầu" (cột 44–55): loại **37** = phái (0 Giáp Sĩ, 1 Đạo Sĩ, 2 Dị Nhân), loại **36** = cấp nhân vật.
- **Giày và Thắt lưng không giới hạn phái.** Web ghép chúng vào đúng bộ của từng phái theo mã particular. Mã particular thống nhất giữa các món: 3/6/9 là Giáp Sĩ, 4/7/10 là Đạo Sĩ, 5/8/11 là Dị Nhân.
- **Nguồn dữ liệu là bảng trong PAK**, không phải file trên đĩa, vì GameServer đọc PAK trước (`KCore.cpp: g_SetPakFileMode(1)`). Bảng trên đĩa bị thiếu dòng: armor/helm/boot/belt/pendant chỉ có 2.611 dòng, trong khi PAK có 3.271.

## Phần 2: Chi tiết

### 2.1 Bảng bộ đồ theo phái (không tính đồ nhiệm vụ)

| Cấp bộ | Giáp Sĩ | Đạo Sĩ | Dị Nhân | Cấp trang bị |
|---|---|---|---|---|
| 20 (bộ #1) | Cự Đấu | Vân Trung | Khuyển Văn | 1–2 |
| 40 (bộ #2) | Vũ Khúc | Xích Tùng | Báo Thần | 3–4 |
| 60 (bộ #3) | Tinh Cang | Thái Ất | Giác Thú | 5–6 |
| 80 (bộ #4) | Khai Thiên | Thông Thiên | Lam Điêu | 7–8 |
| 100 (bộ #5) | Hoàng Kim Chấn Đán | Hồng Quân | Kháng Long | 9–10 |
| Không yêu cầu (bộ #6) | Thần Phục Huyền Khung | Minh Quang | Thiên Lộc | 1–10 |
| Không yêu cầu (bộ #7) | Thiên Cương Thánh Diệu | Hư Nghi | Loan Vũ | 1–10 |

Bộ #8 và các bộ #30, #36 là **trang bị nhiệm vụ**. Mặc định web ẩn chúng; tích "Hiện cả đồ nhiệm vụ" để xem.

### 2.2 Cấp yêu cầu từng món trong một bộ (ví dụ bộ cấp 40)

| Món | Giáp | Mũ | Giày | Thắt lưng | Bội |
|---|---|---|---|---|---|
| Cấp yêu cầu | 40 | 32 | 36 | 34 | 38 |

Quy luật chung: Giáp = cấp bộ, Mũ = cấp bộ − 8, Giày = −4, Thắt lưng = −6, Bội = −2.

### 2.3 Cách hoạt động
1. Khi khởi động, web trích 15 bảng vật phẩm từ PAK vào `AdminWeb\data\pak_item_tables\`.
2. Web đọc 5 bảng armor/helm/boot/belt/pendant, lấy các dòng có mã bộ, rồi xác định phái và kiểu theo mã particular của bảng giáp.
3. API `GET /api/gearsets?prof=<0|1|2>` trả về danh sách bộ, kiểu, cấp trang bị và 5 món (mỗi món có mã tra cứu dạng `Nhóm|STT`).
4. Bấm "Phát cả bộ" sẽ gọi `POST /api/giveset`. Mỗi món thành một lệnh `PTAdm_Give` trong hàng đợi cầu nối. Server thực thi ở giây 00 kế tiếp và dùng `AddItem` + `AddItemID` để đưa đồ vào hành trang.
5. Server sinh trang bị bằng cách khớp **particular + cấp trang bị**. Hệ ngũ hành (1/6/11) nằm ngoài khoảng 0–4 nên được bỏ qua, và món tạo ra đúng dòng dữ liệu đã chọn.

### 2.4 Tệp liên quan

| Tệp | Vai trò |
|---|---|
| `AdminWeb\PhongThan-Admin.ps1` | Trích bảng từ PAK, dựng `$GearPieces`, API `/api/gearsets`, `/api/giveset` |
| `AdminWeb\index.html` | Tab "Đồ lục": chọn nhân vật, tự chọn phái và cấp bộ phù hợp |
| `PhongThanRuntime-Staging\Server\script\servertimer.lua` | `PTAdm_Give`: phát đồ cho nhân vật đang online |

## Phần 3: Hành động

### Hướng dẫn sử dụng
- [ ] Mở `PhongThan-Admin.cmd` → tab **Đồ lục**
- [ ] Chọn **nhân vật đang online**. Web tự chọn phái và cấp bộ cao nhất mà nhân vật dùng được.
- [ ] Chọn bộ muốn phát → **Phát cả bộ (5 món)** → xác nhận
- [ ] Hành trang cần **tối thiểu 5 ô trống**. Lệnh chạy trong vòng 1 phút, xem kết quả ở tab **Lịch sử lệnh**.

### Kiểm thử cần làm trong game (chưa thực hiện)

| Hạng mục | Cách kiểm | Người thực hiện |
|---|---|---|
| Đúng món, đúng phái | Phát bộ cấp 20 cho EmLaAi (Giáp Sĩ), kiểm tra tên 5 món trong F4 | Chủ server |
| Hiệu ứng bộ | Mặc đủ 3 món trở lên, xem thuộc tính bộ trong tooltip | Chủ server |
| Hành trang đầy | Phát khi F4 còn dưới 5 ô, xem món nào báo lỗi | Chủ server |

### Giới hạn đã biết
- Một số tổ hợp của Dị Nhân bộ #5 kiểu 4 chỉ có 2 món trong dữ liệu gốc. Web hiển thị đúng số món có sẵn.
- Vũ khí không có mã bộ trong dữ liệu, nên không nằm trong tính năng này. Vũ khí phát riêng ở tab **Phát đồ**.

## Phần 4: Tài liệu tham khảo
- Dữ liệu gốc: `\settings\item\001\{armor,helm,boot,belt,pendant}.txt` trong `settings.pak` (các cột 3, 11, 44–55, 69)
- Sinh trang bị: `PhongThanSource\Sources\Core\Src\KItemGenerator.CPP` (khớp particular + level, bỏ qua series ngoài 0–4)
- Phái: `PhongThanSource\Sources\Core\Src\KPhongThanProfessionSkills.h`
- Nhật ký thay đổi: `PT\CHANGELOG.md` (mục 2026-09-28)
- Tính năng liên quan: tab **Thú cưỡi** (lọc phái bằng yêu cầu loại 37), tab **Bí kíp / Kỹ năng**
