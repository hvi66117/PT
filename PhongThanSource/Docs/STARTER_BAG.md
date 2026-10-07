# Túi tân thủ — nhận theo ID/STT

## Sử dụng

Click phải **Tui tan thu** trong F4 → chọn nhóm → nhập mã → kiểm tra tên →
xác nhận nhận **1 món**. Có nút nhận thêm, nhập mã khác, đổi nhóm và đóng.
Túi không bị tiêu hao; thao tác nhận không thực thi Lua của món được nhận.

- MagicScript: ID ở cột ngay trước đường dẫn SPR (thường là cột 4), không phải
  số dòng. ID không liên tục và có một khóa trùng nên dùng loader để tra.
- Trang bị / thú cưỡi / IBItem: STT bắt đầu từ 1, bỏ dòng tiêu đề.
  Ví dụ dòng 61 của meleeweapon.txt = STT 60, Trạm Kim phủ.
- Nguyên liệu / nhiệm vụ: ID trong bảng tương ứng.
- Tra cứu: `D:\Lam game phong than\Tra-cuu-vat-pham.txt`; Ctrl+F tìm tên,
  dùng cột Nhom + MaNhap. File được xuất từ các bảng đã qua loader hiện tại,
  không phải bảng tự chế. 48.554 mục; 5.690 khóa MagicScript duy nhất.
- Nhận thuộc tính gốc theo generator hiện có, không tự nâng cấp +12 hay sửa
  chỉ số của bảng. Chưa bảo đảm mọi vật phẩm được nhận có đủ Lua chức năng.

## Triển khai

- Item dự án riêng `genre=6, detail=61000`; không thêm/ghi đè MagicScript VNG.
  Kiểm tra khóa không trùng lúc chạy test; dùng sprite gốc của Túi Càn Khôn
  MagicScript ID 272 (đã xác nhận đọc được trong PAK).
- `Deploy/ProjectContent/settings/item/PhongThanStarterBag.ini` là định nghĩa
  đồng bộ server/client. `[Grant] Accounts` hiện gồm 123456, 1234567, 12345678,
  testdaosy, testdinhan. Chỉ các tài khoản này được tự cấp lúc nạp nhân vật;
  không cấp trùng nếu đã có túi, không rơi đồ khi F4 đầy.
- Luồng lựa chọn do server quản lý trong `PhongThanStarterBag.inl`. Dùng
  `KItemList::Add` để đặt vào F4, đồng bộ snapshot và đánh dấu cần lưu.
- `PhongThanItemPickerCatalog.h` dùng chung cho cấp đồ và kiểm tra/danh mục.
- Nhập số dùng view native 211, request 0x5103 (map/token/value); token được
  tiêu thụ trước callback. Dữ liệu sai phạm vi, token cũ, sai map hoặc mất
  túi đều bị từ chối. Cửa sổ lấy PAK entry 0x5F7D8300, không tạo hình mới.
- Callback cấp đồ nằm phía server; client không được chỉ định callback Lua.
- Không cấp đặc quyền GM, không đổi cấp/chỉ số nhân vật, không xóa đồ cũ.

## Kiểm tra đã thực hiện

```powershell
& .\Build\Build-PhongThan.ps1 -Targets CoreServer,CoreClient,GameClient -NoRebuild
& .\Tests\Test-StarterBagCatalog.ps1
& .\Tools\Export-StarterBagLookup.ps1
```

- Build thành công; runtime đã nhận CoreServer/CoreClient/Game và định nghĩa.
- PAK icon/khung nhập số; giới hạn gói + encode/decode; tra toàn bộ danh mục:
  đạt. Không kiểm thử sử dụng Lua của toàn bộ 48.554 mục.
- Probe login thật `12345678/test1234`: menu 15 nhóm, nhập 272, xem trước,
  nhận vào F4; mở túi lại, nhận melee STT60 đúng TemplateRow59; khóa 999999
  bị từ chối; phản hồi xác nhận cũ không cấp lại. Đạt ở mức packet server.
- Chưa xác nhận bằng thao tác chuột/ảnh giao diện mới và chưa có thử F4 đầy
  trực tiếp. Nhánh F4 đầy dùng API Add sẵn có và giải phóng item nếu thất bại.
- Túi đã được lưu ít nhất một lần trong role test1234; lần nghiệm thu có
  hai món cấp mới chưa được xác nhận lưu thành công sau shutdown.

## Trở ngại runtime phát hiện trong nghiệm thu

GameServer shutdown có lỗi riêng: dump `GameServer.exe.19480.dmp` cho thấy
SavePlayerData ghi NULL tại 0x00406704 (unchecked `new BYTE[]`). Đã thay buffer
packet lưu tối đa 64 KiB bằng buffer stack giới hạn và build GameServer.
Lần tiếp theo không crash tại điểm đó nhưng còn chờ shutdown/save quá lâu.
Giữ các dịch vụ DB/relay để điều tra, không khẳng định lưu thành công. Bộ nhớ
GameServer khi gặp vấn đề: virtual ~3,8 GB / working set ~3,2 GB.
Không dùng kết quả kiểm tra cấp đồ để suy ra luồng shutdown đã đạt.

Hai chỉnh sửa cuối reset UiDialogView sau nhập số đã build ở Output, cần
publish sau khi GameServer đang chờ dừng đã thoát an toàn.
