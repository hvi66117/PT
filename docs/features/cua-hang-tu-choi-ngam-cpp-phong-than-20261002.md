# Mua, bán, sửa đồ ở cửa hàng và Lệnh Bài Hủy Đồ: bỏ các điều kiện từ chối ngầm (C++)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã sửa trong CoreServer (VS2022) và đã triển khai lúc 16:25.** Có hiệu lực khi mở server.

## Phần 1: Tổng quan
- **Triệu chứng:** dùng Lệnh Bài Hủy Đồ (và đôi khi cửa hàng NPC) thì mua, bán, sửa đều "bấm không ăn". Client không hiện thông báo lỗi của server.
- **Nguyên nhân (mã nguồn):**

| Hàm | Điều kiện từ chối ngầm |
|---|---|
| `KPlayer::BuyItem`, `KPlayer::SellItem` | Vị trí hiện tại phải **đúng từng đơn vị** với vị trí lúc mở cửa hàng (`m_BuyInfo.m_nMpsX/Y`). Nhích nhẹ hoặc bị đánh đẩy lùi là hỏng |
| `KBuySell::CanBuy`, `KBuySell::Sell`, `KPlayer::RepairItem` | Đang ở trạng thái chiến đấu (`m_FightMode`) |
| `KPlayer::RepairItem` | Giá sửa = 0 thì thoát luôn |

## Phần 2: Chi tiết
- **Sửa:**
  - mua và bán chỉ cần **cùng bản đồ** (`m_SubWorldIndex == m_BuyInfo.m_SubWorldID`);
  - bỏ kiểm tra chiến đấu khi mua, bán, sửa;
  - giá sửa 0 thì sửa miễn phí (`Pay(0)` thành công).
- Các bản sửa trước vẫn giữ: giá trang bị 1 → 1000 trong ptfix, `RepairAllEquip()` cho mục "Sửa toàn bộ đồ đang mặc" của lệnh bài.
- **Tệp:** `Core\Src\KPlayer.cpp`, `Core\Src\KBuySell.cpp` (sửa ở mức byte, backup `_backup\20261002-shopfix\`).
- **Build và triển khai:** `Build-Modern.ps1 -Targets CoreServer` (0 lỗi), rồi `Deploy-ModernServer.ps1`. Mã băm runtime, Output và receipt khớp nhau.

## Phần 3: Hành động
- [ ] Mở server → dùng Lệnh Bài Hủy Đồ ở bãi quái:
  - "Bán đồ trong túi" → nút Bán → click đồ (có thể di chuyển, đang chiến đấu cũng được);
  - mua thử 1 bình thuốc;
  - "Sửa toàn bộ đồ đang mặc" → độ bền đầy ngay.
- [ ] Nếu vẫn lỗi: gửi nội dung `Server\admin_bridge\token.log`.

## Phần 4: Tài liệu tham khảo
- `lenh-bai-huy-do-phong-than-20260930.md`, `cua-hang-trang-thai-chien-dau-phong-than-20261001.md`, `build-server-vs2022-phong-than-20261002.md`.
