# Bào Thương (chạy buôn bằng lạc đà) — dựng mới

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã triển khai và nạp nóng lúc 14:00** (10 NPC, 5 lượt gắn script). Mô phỏng trọn một chuyến buôn đạt. Chưa kiểm thử trong game.

## Phần 1: Tổng quan
- **Yêu cầu:** dựng mới Bào Thương, **phần thưởng tùy theo hàng đã mua**.
- **Dữ liệu VNG còn lại:**
  - Lời thoại StringResource 10710–10775: cấp 20 trở lên, thuê lạc đà, mua hàng, giao hàng, trả lạc đà.
  - Vật phẩm phụ trợ: Bào thương lệnh, Phi Mao phù, Bào thương hồi thành phù.
  - Phần thưởng Ngôi Sao May Mắn (3,5482).
- **Dữ liệu VNG đã mất:** script thương nhân. Vì vậy luật giá và thưởng dưới đây là **tự thiết kế**.

## Phần 2: Chi tiết

### 2.1 Vòng chơi
1. Nói chuyện với **Bào Thương** (cấp 20 trở lên, không đang biến thân) → **Thuê lạc đà**:

| Lạc đà | Phí thuê | Chở tối đa |
|---|---|---|
| Nhỏ | 1.000 lượng | 10 kiện |
| Lớn | 5.000 lượng | 25 kiện |

2. **Mua hàng** đặc sản của thành đang đứng: 5, 10 hoặc đầy lạc đà.
3. Mang tới **Bào Thương ở thành khác** → **Giao hàng**:
   - Nhận lượng theo giá bán.
   - Nhận kinh nghiệm = số kiện × giá mua × 2.
   - Nếu chở từ 10 kiện trở lên, nhận thêm 1 **Ngôi Sao May Mắn**.
4. **Trả lạc đà** khi không chạy buôn nữa. Nếu còn hàng thì hàng bị thu hồi.

### 2.2 Hàng hóa và giá (thưởng tăng theo hàng mua và quãng đường)
| Thành | Map | Đặc sản | Giá mua / kiện |
|---|---|---|---|
| Sùng Thành doanh | 1002 | Da thú Sùng Thành | 1.500 |
| Ngọc Hư Cung | 1003 | Linh dược Ngọc Hư | 2.500 |
| Xi Vưu Mộ | 1004 | Khoáng thạch Xi Vưu | 1.800 |
| Tây Kỳ | 1020 | Trà Tây Kỳ | 2.000 |
| Triều Ca | 1021 | Lụa Triều Ca | 3.000 |

- **Giá bán** = giá mua × (1,2 + 0,1 × khoảng cách). Khoảng cách đếm theo thứ tự Sùng Thành, Ngọc Hư, Xi Vưu, Tây Kỳ, Triều Ca. Kết quả là lời từ 30% (thành kế bên) đến 60% (xa nhất).
- **Ví dụ (đã mô phỏng):** 25 kiện Trà Tây Kỳ chở sang Triều Ca. Vốn 50.000, thu 65.000 lượng (lời 15.000), nhận 100.000 kinh nghiệm và 1 Ngôi Sao May Mắn.
- **Lời nhất:** 25 kiện Lụa Triều Ca chở sang Sùng Thành. Vốn 75.000, thu 120.000 (lời 45.000), nhận 150.000 kinh nghiệm.

### 2.3 Kỹ thuật
| Thành phần | Chi tiết |
|---|---|
| Script | `npc_fix\bao_thuong.lua`, một file dùng cho cả 5 thành (nhận biết thành qua `GetWorldPos`). Sinh từ `scratchpad\baothuong\gen.py` để chuỗi TCVN3 chính xác |
| NPC | Thương nhân template 1388 (族裔商人, tên server `跑商` → hiển thị "Bao Thuong") và lạc đà trang trí 366 (城市骆驼 → "Lac Da"), đặt cạnh các tiệm; vị trí đã kiểm tra là ô đi được |
| Biến nhiệm vụ | 1900 lạc đà (0/1/2), 1901 loại hàng, 1902 số kiện, 1903 map mua, 1904 giá mua, 1905 số chuyến đã xong. VNG không dùng các biến này |
| Đăng ký | `servertimer.lua` có 10 dòng `PTADM_NPC_SPAWN` và 5 dòng `PTADM_NPC_FIX`; `NpcDisplayNames` thêm `跑商`, `骆驼` |

### 2.4 Chưa có (có thể làm tiếp)
- Giới hạn thời gian mỗi chuyến, và mất hàng khi chết. VNG dùng task 60 ở 87 chỗ, nên chưa gắn vào để tránh xung đột.
- Bào thương hồi thành phù và Phi Mao phù là ibitem có script `NONE`, chưa dùng được (giống Thanh Lộ).

## Phần 3: Hành động
- [ ] Tới Tây Kỳ hoặc Triều Ca, tìm NPC **Bao Thuong** đứng cạnh con lạc đà gần các tiệm.
- [ ] Thuê lạc đà, mua hàng, chạy sang thành khác giao hàng. Kiểm tra lượng, kinh nghiệm và Ngôi Sao May Mắn.
- [ ] Muốn đổi giá hoặc tỉ lệ lời: sửa `BT_GOODS`, `BT_SellPrice`, `BT_EXP_PER_LUONG` trong `gen.py` rồi chạy lại.

## Phần 4: Tài liệu tham khảo
- StringResource 10710–10775, ibitem 136/148/160/258, material 5482
- `tiem-thuoc-vu-khi-tap-hoa-phong-than-20260929.md`
- Bản sao lưu: `_backup\20260929-shops\servertimer.before-baothuong.lua`
