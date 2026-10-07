# Sửa lỗi: giao diện túi đồ vẽ vật phẩm tràn ra ngoài khung

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã sửa; có hiệu lực sau khi mở lại client**

## Phần 1: Tổng quan
- **Triệu chứng (ảnh người chơi gửi):**
  - Món ở cột thứ 6 bị vẽ đè lên viền phải.
  - Một món đè lên dòng "lượng".
  - Hai món rơi ra ngoài cửa sổ, ngay dưới nút "Bày bán".
- **Nguyên nhân:**
  - Túi đồ trên server rộng **6 cột × 10 hàng** (`EQUIPMENT_ROOM_WIDTH/HEIGHT`, GameDataDef.h:425-426).
  - File giao diện `Client\Ui\ui3\UiItem.ini` khai báo `[ItemBox]` chỉ **5 × 7**.
  - `KWndObjectMatrix` vẽ mọi món mà không cắt theo khung, nên món ở cột 6 và hàng 8–10 bị vẽ ra ngoài.

## Phần 2: Chi tiết
| Khóa | Cũ | Mới |
|---|---|---|
| HUnits × VUnits | 5 × 7 | **6 × 10** |
| Width × Height | 220 × 310 | 216 × 310 (ô 36 × 31) |
| UnitBorder | 4 | 1 |

- Vị trí khung giữ nguyên (Left 284, Top 56), nên cả 60 ô nằm gọn trong vùng túi.
- Lưới ô vẽ sẵn trên hình nền vẫn là 5 × 7. Vì vậy vạch lưới nền không trùng khít với ô mới; đây là giới hạn của hình nền.
- Bản sao lưu: `_backup\20260929-uiitem\UiItem.ini`.

## Phần 3: Hành động
- [ ] Thoát client, mở lại, rồi mở túi đồ (F3/F4): mọi món phải nằm trong khung.
- [ ] Nếu ô quá nhỏ hoặc lệch, báo lại để chỉnh Width, Height, Left, Top.

## Phần 4: Tài liệu tham khảo
- `PhongThanSource\Sources\GameClient\Ui\Elem\WndObjContainer.cpp` (`KWndObjectMatrix::Init`, `PaintWindow`)
