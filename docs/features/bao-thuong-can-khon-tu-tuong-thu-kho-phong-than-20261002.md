# Bào Thương, Càn Khôn Luân, Tứ Tượng, Rương Thủ Khố

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: Bào Thương và Thủ Khố **đã sửa** (có hiệu lực khi mở server). Càn Khôn Luân và Tứ Tượng **chờ người dùng chọn hướng**.

## Phần 1: Tổng quan
| Tính năng | Nguyên nhân | Trạng thái |
|---|---|---|
| Bào Thương | Script so `GetMorphType() ~= 0`, nhưng engine trả **-1** khi không biến thân, nên mọi người chơi cấp ≥ 20 bị báo "đang Vận Tiêu hoặc biến thân" | Đã sửa |
| Rương Thủ Khố | Các map 1002/1003/1004 không có vật thể rương. Thủ khố chỉ có nhiệm vụ 5 Mảnh Giáp, không có mục mở rương | Đã thêm "Mở rương chứa đồ" |
| Càn Khôn Luân | Phía server chạy đúng, thưởng trao ngay. Client VC6 **không có cửa sổ vòng quay** | Chờ chọn hướng hiển thị |
| Tứ Tượng | Chỉ nhiệm vụ Tứ Tượng ở Thủ khố chạy được. Túi/rương Tứ Tượng lỗi, script Tứ Linh, trưởng lão, Thử Thách Huyền Vũ đã mất | Chờ chọn (xem Phần 3) |

## Phần 2: Chi tiết
- **Bào Thương:**
  - đổi điều kiện thành `local mt = GetMorphType() if mt ~= -1 and mt ~= 0 then`;
  - tệp: `Server\script\phongthan\npc_fix\bao_thuong.lua`, generator `scratchpad\baothuong\gen.py`, mock `qtest\sim.lua`;
  - mô phỏng đã chạy trọn: thuê xe → mua 25 hàng → giao ở thành khác → +65.000 lượng, +100.000 EXP.
- **Thủ Khố:**
  - ở cả 3 file `npc_fix\100x_thu_kho.lua`, mục đầu tiên là "Mở rương chứa đồ";
  - hàm `mo_ruong()` gọi `SetFightState(0)` rồi `OpenBox(2)`, giống script rương VNG;
  - không cần làm nhiệm vụ 5 Mảnh Giáp trước;
  - sửa ở mức byte để giữ mã TCVN3.
- **Càn Khôn Luân, 2 hướng:**
  - **B1 (C++ server):** `Roulette(k)` hiện chuỗi tên ô chạy chậm dần trên đầu màn hình rồi mới trao thưởng. Không có hình vòng quay.
  - **B2 (thanh tiến trình của client):** cần thêm `UiProgressBarLoading.ini`; khi thanh chạy xong mới trao thưởng. Vòng quay giống VNG thật thì phải sửa C++ ở client.
- **Tứ Tượng:** báo cáo nghiên cứu đầy đủ ở `scratchpad\tutuong\tutuong_report.md`. Đề xuất 4 giai đoạn:
  1. sửa túi/rương lỗi và an toàn thưởng Thủ khố;
  2. Tứ Linh;
  3. trưởng lão → Tinh Thạch → Hỗn Nguyên Châu;
  4. Thử Thách Huyền Vũ trên map 1086.

## Phần 3: Hành động
- [ ] Mở server (sau khi triển khai bản C++ mới) → thử Bào Thương ở Thương nhân, chọn "Mở rương chứa đồ" ở Thủ khố.
- [ ] Người dùng chọn: hướng Càn Khôn Luân (B1/B2); nội dung Túi Tứ Tượng; nguồn Tinh Phách.

## Phần 4: Tài liệu tham khảo
- `bao-thuong-chay-buon-phong-than-20260929.md`, `can-khon-luan-duoc-diem-tho-dong-phong-than-20260930.md`.
- Báo cáo chẩn đoán: `scratchpad\features3\features3_report.md`.
