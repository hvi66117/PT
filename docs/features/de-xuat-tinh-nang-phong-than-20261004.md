# Đề xuất tính năng tiếp theo cho server Phong Thần (2026-10-04)

## Phần 1: Tổng quan

- Sau đợt cài 19:29, server đã có khá đủ hệ thống chơi một mình: đệ tử, bot tổ đội, 7 lệnh bài, Vạn Tiên, Thương Chu, mật độ quái và web admin quản trị.
- Điểm yếu lớn nhất bây giờ không phải thiếu tính năng mà là ba việc:
  - **Kiểm chứng:** rất nhiều phần mới chỉ chạy qua mô phỏng, chưa thử trong game.
  - **Túi đồ:** túi đầy là nguyên nhân mất đồ lặp lại nhiều lần (Thông Thiên, Tiếp Tế, Càn Khôn).
  - **Giới hạn engine:** tối đa 48.000 NPC.
- Đề xuất xếp theo thứ tự: ổn định trước, sau đó tiện ích chơi hằng ngày, cuối cùng là nội dung mới.

## Phần 2: Chi tiết

### Nhóm A: Ổn định và vận hành (ưu tiên cao)

| # | Tính năng | Lý do | Công sức |
|---|---|---|---|
| A1 | **Bảng sức khỏe server trên web admin**: số NPC so với giới hạn, lỗi tick, nhân vật online, phiên bản ptfix/DLL, nút xem `result.log` / `tick_error.log` | Hiện phải nhờ Claude đọc log mới biết server có lỗi | Thấp |
| A2 | **Nút "Quay về bản trước" trên web admin** cho DLL/ptfix: chọn một bản sao lưu `server-deploy-*` / `ptfix-*` và khôi phục khi server tắt | Một bản build lỗi có thể khôi phục trong một phút, không cần Claude | Trung bình |
| A3 | **Sao lưu nhân vật tự động hằng ngày** (`CharacterStore`, LocalDB), giữ 7 ngày | Nhiều thay đổi đụng tới đồ và task của nhân vật | Thấp |
| A4 | **Tăng giới hạn NPC** từ 48.000 lên khoảng 96.000 trong C++ | Để mật độ x2–x3 chạy cho mọi bản đồ, chừa chỗ cho bot, đệ, Vạn Tiên | Trung bình (cần kiểm tra bộ nhớ) |
| A5 | **Gỡ bộ ghi nhật ký AI đệ tử** sau khi xác nhận đệ đánh ổn | Bộ ghi tạm, tốn ghi file | Rất thấp |

### Nhóm B: Tiện ích chơi hằng ngày

| # | Tính năng | Lý do | Công sức |
|---|---|---|---|
| B1 | **Tự nhặt đồ + lọc đồ** (bật/tắt, chọn loại: bí kíp, pháp bảo, đồ lục, nguyên liệu; bỏ đồ trắng) | Đánh mật độ x2 rơi rất nhiều đồ | Trung bình (client + server) |
| B2 | **Tự bán đồ rác / phân giải** khi túi đầy, hoặc nút "Dọn túi" trên lệnh bài | Hết cảnh mất đồ vì túi đầy | Trung bình |
| B3 | **Rương phụ di động**: lệnh bài mở Rương 2–5 ở mọi nơi | Đã có Rương 2–5, chỉ thiếu chỗ mở | Thấp |
| B4 | **Tự động làm nhiệm vụ**: Lệnh Bài Nhiệm Vụ + tự dịch chuyển + tự đánh, hoàn thành chuỗi tân thủ / hằng ngày | Ghép 3 tính năng đã có | Cao |
| B5 | **Thanh biểu tượng buff** cho buff kinh nghiệm / hồi máu (Càn Khôn Luân, IB item) | Hiện chỉ thấy bằng dòng chữ | Trung bình (client) |

### Nhóm C: Bot và đệ tử thông minh hơn

| # | Tính năng | Lý do | Công sức |
|---|---|---|---|
| C1 | **Bot Dị Nhân hồi máu cho người chơi** (Bổ Tâm Chú lên chủ và đồng đội khi máu dưới 50%) | Đúng vai hỗ trợ của Dị Nhân VNG | Trung bình |
| C2 | **Bổ Tâm Chú của người chơi hồi cả đồng đội và bot** | Hiện chỉ hồi bản thân | Trung bình |
| C3 | **Bot tự hồi sinh / thay bot chết ngay** thay vì chờ tick 1 phút | Đánh boss mất bot sẽ hụt sức | Thấp |
| C4 | **Bảng điều khiển tổ đội bot trên web admin**: chọn phái, số lượng, cấp, bật/tắt từng bot | Hiện chỉ có số lượng chung | Thấp |
| C5 | **Đệ kỹ năng 450–461 có chỉ số riêng như đệ lệnh bài** (native trả `m_nPetIdx` cho Lua) | Còn ghi chú "chưa áp dụng" | Thấp |

### Nhóm D: Sửa nốt khoảng trống engine đã phát hiện

| # | Việc | Nguồn phát hiện |
|---|---|---|
| D1 | `AddIBBuff` dùng hiệu quả vật phẩm IB thay vì trạng thái kỹ năng (sửa luôn túi quà Võ Lâm Đại Hội) | cankhon3 |
| D2 | `AddCredit` dùng chung giá trị với Danh vọng (F3) | cankhon3 |
| D3 | `enhance_fatallystrike_p` và cột `DeadlyStrikeResist` | vancot |
| D4 | Giữ chuột phải để tung chiêu lặp | daosi |
| D5 | Nhị Lang Thần ở Diêu Trì (đổi Liễu Mộc lấy Hạt thần bí, Thiên Thụ) | questfix3 |
| D6 | Đổi tên Tạp Hóa / Thủ Khố ở Sùng Thành còn hiện chữ lỗi | taphoa |

### Nhóm E: Nội dung mới

| # | Tính năng | Ghi chú |
|---|---|---|
| E1 | **Lịch sự kiện tự động** trên web admin: hẹn giờ mở Vạn Tiên, Thương Chu, boss thế giới, nhân đôi kinh nghiệm cuối tuần | Server chơi một mình nhưng vẫn có nhịp chơi |
| E2 | **Quà đăng nhập hằng ngày / tích lũy 7 ngày** | Dễ làm bằng tick |
| E3 | **Phó bản một người theo cấp** (dùng lại cơ chế mission Vạn Tiên) | Công sức cao |
| E4 | **Bảng thành tích**: giết boss, hoàn thành chuỗi, cấp đệ | Tạo mục tiêu dài hạn |

## Phần 3: Hành động

Đề xuất làm theo thứ tự:

1. **Ngay sau khi bạn thử bản 19:29:** sửa các lỗi phát hiện khi thử + A5.
2. **Đợt 1 (ổn định):** A1, A3, A4.
3. **Đợt 2 (tiện ích):** B1, B2, B3, C1, C3.
4. **Đợt 3 (sửa nốt):** D1–D6.
5. **Đợt 4 (nội dung):** E1, E2, rồi B4, E3 nếu muốn.

Mỗi đợt gom một lần cài như các đợt trước.

## Phần 4: Tài liệu tham khảo

- `docs\features\README.md`: danh sách tính năng đã làm.
- `CHANGELOG.md`: lịch sử thay đổi.
- Các báo cáo phát hiện: `can-khon-luan-quay-cpp-phong-than-20261002.md` (cankhon3), `van-cot-toan-kho-phong-than-20261004.md`, `dao-si-nhieu-chieu-phong-than-20261004.md`, `questfix3-phong-than-20261004.md`, `mat-do-hoi-quai-phong-than-20261004.md`.
