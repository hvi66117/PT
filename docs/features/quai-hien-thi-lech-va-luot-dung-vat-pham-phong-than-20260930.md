# Quái hiển thị lệch, bấm không trúng; vật phẩm nhiều lượt dùng chỉ dùng được 1 lần; buff "tán"

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30 · Trạng thái: **Đã có bản vá**. Tự áp dụng khi bật server hoặc mở game bằng `PhongThan-ChayTatCa.cmd` / `PhongThan-MoGame.cmd`, lúc client đang tắt. Mô phỏng đạt; chưa kiểm thử trong game.

## Phần 1: Tổng quan
| Lỗi | Nguyên nhân gốc (đã kiểm chứng) | Cách sửa |
|---|---|---|
| Thanh tên/máu quái lệch lên trên bên trái; di chuột/bấm vào thân quái không chọn được | `Represent2.dll` (bộ vẽ đang dùng, `Represent=2`) chỉ đặt tâm đúng kiểu VNG (255,293) cho hình 510×510 nằm trong `npcres\passerby\`. Hình quái (`npcres\animal\...`) bị gán tâm kiểu Võ Lâm (160,192), nên **thân quái bị vẽ lệch +95 px ngang, +101 px dọc**. Thanh tên và vùng bấm thì đúng vị trí thật | **Vá 1 byte** trong `Represent2.dll` (offset 0xB0C3: `70` → `00`): chuỗi `npcres\passerby\` thành `npcres\`, nên mọi hình 510×510 trong `npcres\` dùng tâm VNG. Thân quái về đúng vị trí, khớp thanh tên và vùng bấm |
| Di Ngoại Phù (10 lượt), Như ý Di Ngoại Phù (30), Siêu Cấp (50)… dùng 1 lần là mất | Bản dựng lại không có bộ đếm lượt dùng. `CostIBItem` trừ 1 vào số lượng, mà số lượng mỗi món là 1 | `pt_compat.lua` thay `CostIBItem`: đếm lượt đã dùng trong tham số của vật phẩm (được lưu vào database), báo "Còn lại X lần sử dụng", hết lượt mới xóa món đồ |
| Dao/Ngọc … tán và các buff chỉ số khác không có tác dụng | Cột script là `NONE`, engine không tự áp thuộc tính | Hệ thống buff tổng quát: 429 loại, 6 ô chạy song song |

## Phần 2: Chi tiết
### 2.1 Bản vá `Represent2.dll`
- Kiểm chứng:
  - Timestamp DLL `6aa134b5` khớp với `Represent2.map`.
  - Hàm `IsPhongThanHumanComposite` ở RVA 0x4420; chuỗi này chỉ được tham chiếu một chỗ (file 0x4459).
  - Log `client_npc_name_overlay_diag.log`: thanh tên tính đúng theo tâm quái (−133, 370).
- An toàn:
  - Điều kiện ảnh 510×510 vẫn giữ nguyên, nên hình Võ Lâm cũ (320×384…) không bị ảnh hưởng.
  - Hình có sẵn tâm trong header vẫn dùng tâm đó.
- `AdminWeb\PhongThan-ClientPatch.ps1` vá cả bản runtime lẫn bản Output, và cập nhật `NATIVE_DEPLOYMENT.json`. Bản gốc lưu ở `_backup\client-patch\`.
- **Sửa gốc cho lần build C++:** `PhongThanSpriteAnchor.h`, hàm `PhongThanUsesActorCanvas` nhận `npcres\` cho canvas 510×510.

### 2.2 Vật phẩm nhiều lượt dùng (95 loại, bảng `script\phongthan\lib\pt_ibuses.lua`)
| Nhóm | Số dòng | Trạng thái |
|---|---|---|
| Script gốc dùng `CostIBItem`: Di Ngoại Phù, Như ý Di Ngoại Phù, Di Ngoại Phù Siêu Cấp, Chỉ Nam Châu… | 14 | **Đã sửa:** đếm lượt |
| Buff NONE có chỉ số (Dao … tán, Lâm Tiên Lộ…) | 16 | **Đã sửa:** buff tổng quát / buff kinh nghiệm, có đếm lượt |
| NONE thuộc hệ thống khác (Thái Cực Đơn, Lam Dương Đơn, Quy Chân Đơn: ủy thác rời mạng; Chỉ nhân, Mộc nhân, Đồng nhân: Càn Khôn Luân; biến hình liên server; Buff Binh Giải; Tri Thường Tán, Khứ Khổ Đơn; Cam Lộ) | 14 | Chưa làm (cần dựng từng hệ thống) |
| **Script gốc không còn trong dữ liệu** (hồi thành phù, thẻ nhiệm vụ, bảo nang, túi ngoại trang, Triệu Tập Lệnh, Thiên Lý Truyền Âm…) | 71 | Món đồ **dùng không có tác dụng**; cần viết lại từng script |

### 2.3 Buff tổng quát
- Nhận các ibitem buff có thời hạn mà **mọi thuộc tính đều là chỉ số cộng thẳng**: máu/nội lực tối đa và hồi phục, 4 chỉ số cơ bản, kháng, tốc độ chạy/đánh/ra chiêu, sát thương, phòng ngự, chính xác, toàn thuộc tính.
- Bỏ qua các thuộc tính đặc biệt (khóa di chuyển, độc, biến hình, giấy phép bày bán…).
- Có 6 ô chạy song song. Dùng lại cùng món thì cộng dồn thời gian; ô đầy thì thay ô sắp hết hạn nhất. Engine tính lại chỉ số (mặc/tháo đồ, đăng nhập lại) thì tự áp lại trong vòng 1 phút.
- Biến nhiệm vụ: 1921–1932 (mã buff và hạn của 6 ô), 1933–1938 (phần đang áp).

## Phần 3: Hành động
- [ ] Thoát game, mở lại bằng `PhongThan-MoGame.cmd`: cửa sổ lệnh báo "Da va Represent2 ...". Quái phải đứng ngay dưới tên của nó, di chuột lên thân quái thì hiện biểu tượng đánh.
- [ ] Để cài `ptfix.pak` mới (buff "tán", đếm lượt): dừng server rồi bật lại bằng `PhongThan-ChayTatCa.cmd game`.
- [ ] Dùng Di Ngoại Phù: phải báo "Còn lại 9 lần sử dụng" và món đồ vẫn còn.

## Phần 4: Tài liệu tham khảo
- `Represent\Represent2\KRepresentShell2.cpp` (333–356, 1203, 1227), `PhongThanSpriteAnchor.h`, `Core\Src\KNpcSet.cpp:1094`, `KScenePlaceC.cpp:51-62`
- `ScriptFuns.cpp` (CostIBItem 3175, FindAValidIBItem 3142, SetParamItem), `KPlayerDBFuns.cpp:456/758` (ScriptParam được lưu)
- `vat-pham-ibitem-lo-buff-phong-than-20260929.md`, `dung-thuoc-mau-mana-phong-than-20260929.md`
