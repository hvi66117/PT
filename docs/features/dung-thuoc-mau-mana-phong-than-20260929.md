# Sửa lỗi: không dùng được thuốc máu / mana trong túi đồ

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã có bản vá; tự áp dụng khi mở game bằng `PhongThan-MoGame.cmd` hoặc `PhongThan-ChayTatCa.cmd`** (lúc làm, client đang mở nên chưa vá được). Chưa kiểm thử trong game.

## Phần 1: Tổng quan
- **Triệu chứng:** click phải vào thuốc máu hoặc mana thì không có gì xảy ra.
- **Bằng chứng trong log:**
  - `Client\item_action_diag.log` ghi `ApplyUseItem_USE_RESULT ... value2=0`, nghĩa là `UseItem` ở client trả 0.
  - `Server\item_action_diag.log` không có yêu cầu nào tương ứng, tức là server **không nhận được gì**.
- **Nguyên nhân (mã nguồn):** `KItemList::UseItem` và `KItemList::NowEatItem` (KItemList.cpp:1557, 1605) bắt đầu bằng `if (m_PlayerIdx <= 0) return FALSE;`. Ở client, nhân vật của chính mình luôn có chỉ số **0** (`CLIENT_PLAYER_INDEX`), nên mọi lần dùng thuốc đều bị chặn.
  - Lỗi y hệt ở `ChangeItemInPlayer` (mặc trang bị) đã được sửa trong mã trước đây. Hai hàm này thì bị bỏ sót.
- **Cách sửa khi không có VC6:** vá trực tiếp 2 byte trong `CoreClient.dll`, đổi `jg` (> 0) thành `jge` (≥ 0).

## Phần 2: Chi tiết
| Hàm | Vị trí (CoreClient.map) | Offset trong file | Byte |
|---|---|---|---|
| `KItemList::NowEatItem` | 0001:0004e660 | 0x4f66a | `7F 09` → `7D 09` |
| `KItemList::UseItem` | 0001:0004e7e0 | 0x4f7e7 | `7F 07` → `7D 07` |

- **Script vá:** `AdminWeb\PhongThan-ClientPatch.ps1`.
  - Chỉ vá khi DLL đúng phiên bản (timestamp `6aaa74c1`) và đúng byte gốc. File đã vá thì bỏ qua. Client đang mở thì bỏ qua.
  - Vá cùng lúc bản runtime và bản `PhongThanSource\Output\Client`, rồi cập nhật Sha256 trong `NATIVE_DEPLOYMENT.json`, để Test-NativeRuntime vẫn PASS.
  - Bản gốc được lưu ở `_backup\client-patch\`.
- **Đã kiểm tra trên bản sao:** chỉ khác đúng 2 byte; chạy lần 2 báo "Da va".
- **Nối vào:** `PhongThan-MoGame.cmd` và `PhongThan-ChayTatCa.cmd` (chạy trước khi bật server hoặc mở client).
- **Khi build lại C++:** sửa 2 dòng trong mã nguồn thành `m_PlayerIdx < 0`, rồi bỏ bản vá này.

## Phần 3: Hành động
- [ ] Thoát game, mở lại bằng `PhongThan-MoGame.cmd`. Cửa sổ lệnh phải in "Da va ...".
- [ ] Click phải vào thuốc máu hoặc mana: máu và mana phải hồi, số lượng thuốc giảm.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KItemList.cpp` (1555-1632), `KPlayer.cpp:3620` (ApplyUseItem), `Output\Client\CoreClient.map`
