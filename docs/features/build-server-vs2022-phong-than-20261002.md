# Build lại server bằng Visual Studio 2022 (không cần VC6)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã triển khai lúc 16:17** (người dùng đồng ý). Backup VC6 ở `_backup\server-vc6-20261002-161718`. Đang chờ thử trong game.

## Phần 1: Tổng quan
- **Cài đặt:**
  - Máy công ty chặn Windows tự tải chứng chỉ (`DisableRootAutoUpdate = 1`), nên trình cài VS báo `Certificate is invalid` (0x80096004).
  - Cách xử lý: thêm 2 chứng chỉ trung gian của Microsoft (**Code Signing PCA 2024**, **Windows Code Signing PCA 2024**), rồi cài VS 2022 Build Tools 17.14.41 (MSVC 14.44, SDK 10.0.26100) và ATL (bản Spectre).
- **Kết quả:** đã build đủ bộ tiến trình GameServer: GameServer.exe, CoreServer.dll, Engine.dll, LuaLibDll.dll (32-bit, cần VC++ 2015–2022 x86, máy đã có).
- **5 bản sửa C++** có trong bản build:
  - vòng sáng set đồ;
  - tay không vẫn có sát thương;
  - chính xác âm vẫn có 40% trúng;
  - đệ tử tự đánh kẻ địch gần nhất;
  - `RepairAllEquip` (Lệnh Bài Hủy Đồ sửa toàn bộ đồ một lần).
- **Bản vá byte được chuyển vào mã nguồn:** `KItemList::Fit` (pháp bảo ở 2 ô Talisman) và `KPlayer::AddSelfExp` (kinh nghiệm khi đánh quái thấp cấp hơn). Bản vá byte cũ chỉ áp cho DLL VC6 (kiểm tra theo timestamp 0x6aaa5d9f), nên DLL mới sẽ tự được bỏ qua.

## Phần 2: Chi tiết
- **`Build\Build-Modern.ps1`:**
  - không dừng khi cl in cảnh báo ra stderr (PS 5.1);
  - bọc ngoặc kép đúng cho đường dẫn có dấu cách;
  - link các `.lib` khai báo như file nguồn trong `.dsp`, ưu tiên `.lib` vừa build thay bản VC6;
  - thêm `/NODEFAULTLIB:libc.lib`, `/D_WINSOCKAPI_`, `/Zc:sizedDealloc-`;
  - tự thêm đường dẫn ATL bản Spectre.
- **Sửa mã nguồn** (giữ tương thích VC6, backup `_backup\20261002-modernbuild\`):
  - thiếu kiểu `int` (Kime.cpp, ScriptFuns.cpp);
  - tham số mặc định ở phần định nghĩa hàm khởi tạo (KLuaScript, KStepLuaScript);
  - đường dẫn include (EDOneTimePad, KWeather);
  - `const_cast` cho phần tử `std::set` (DataSource);
  - `#include <string>` (KPlayerChat.h), `winsock2.h` khi build bằng VS2022 (inoutmac.h);
  - ép kiểu `strstr` (KGMCommand);
  - `KNpc::UpdateNpcStateInfo` chuyển sang public. Mã vòng sáng viết ngày 29/09 gọi hàm này và chưa từng được biên dịch.
- **Triển khai:** `_backup\20261002-modernbuild\Deploy-ModernServer.ps1`:
  - backup 4 file VC6 (runtime và Output) cùng `NATIVE_DEPLOYMENT.json`;
  - chép bản mới kèm `.pdb`;
  - cập nhật mã băm.
- **Khôi phục:** `Rollback-ModernServer.ps1`.
- **Rủi ro cần thử:** đây là lần đầu chạy server build bằng trình biên dịch khác. Cần kiểm tra đăng nhập, lưu và nạp nhân vật (CharacterStore), đánh quái, cửa hàng, Lua script. Client vẫn giữ bản VC6. Bishop, Goddess, Relay, AccountServer giữ bản cũ (tiến trình riêng, không bị ảnh hưởng).

## Phần 3: Hành động
- [ ] Tắt hẳn GameServer (Task Manager → GameServer.exe → End task).
- [ ] Đồng ý để Claude chạy `Deploy-ModernServer.ps1`.
- [ ] Mở server, đăng nhập và thử: đánh quái (số sát thương, kinh nghiệm), đệ tử Dị Nhân tự đánh, mặc đủ set đồ lục xem vòng sáng, Lệnh Bài Hủy Đồ → "Sửa toàn bộ đồ đang mặc", 3 ô pháp bảo.
- [ ] Nếu lỗi: chạy `Rollback-ModernServer.ps1`.

## Phần 4: Tài liệu tham khảo
- `vong-sang-set-do-luc-phong-than-20260929.md`, `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `sat-thuong-tay-khong-phong-than-20261002.md`, `lenh-bai-huy-do-phong-than-20260930.md`, `o-phap-bao-phap-khi-an-phong-than-20260930.md`, `kinh-nghiem-danh-quai-phong-than-20260930.md`.
