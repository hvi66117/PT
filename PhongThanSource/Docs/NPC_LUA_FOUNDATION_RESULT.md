# Khôi phục Lua NPC — kết quả triển khai nền

Ngày 15/09/2026. Phạm vi: tận dụng mã có nguồn, sửa loader/API/schema hỗ trợ;
không tiếp tục sửa các lỗi đăng nhập/máy chủ theo yêu cầu người dùng.

## Đã làm

- Gom 1.762 nội dung Lua khác nhau theo SHA256, giữ nguyên byte, trong
  `SourceMigration/NpcLuaLibrary/objects`. `Docs/NPC_LUA_LIBRARY.json` liên kết
  đường dẫn logic, PAK, hash index, entry, hash nội dung và phụ thuộc.
- Xác minh lại 366 tham chiếu được lưu đầy đủ trong kiểm kê cũ. Con số 496 trước
  đây là tổng ứng viên trong bộ nhớ của lần quét, không phải 496 file đã lưu:
  báo cáo cũ chỉ ghi các ứng viên khớp từng NPC. Đã lấy thêm ứng viên từ chính
  các PAK/đường dẫn đã biết và tham chiếu template, không quét lại toàn bộ ổ đĩa.
- Kho bao gồm NPC đối thoại, script quái và tài nguyên liên quan, nhiều phiên
  bản. Không được dùng 1.762 để tính số NPC hay tỷ lệ chức năng hoàn thành.
- Các phụ thuộc Include/require tĩnh đã phát hiện đều có nội dung cùng PAK;
  không có cạnh thiếu trong tập này. Đây không phải kiểm chứng mọi API, nhánh
  chạy động hay toàn bộ Lua VNG. Mã ứng viên không được tự động đưa vào runtime.
- PAK `autoupdate/data/vng00.pak` có index khác lần kiểm kê trước nên bị loại
  khỏi nguồn đã xác minh, không âm thầm đổi nguồn.
- Lập danh sách 143 mục NPC đã nghiên cứu: 82 mục có ứng viên, 61 mục chưa có
  ứng viên trong kho này. Đây là danh sách tọa độ hiện có, không đại diện toàn bộ
  2.703 template NPC/quái của Npcs.txt.

## Source đã sửa và đã cập nhật runtime

### Include PAK-first

`Sources/Core/Src/PhongThanLuaInclude.inl`, gọi từ `ScriptFuns.cpp`:

- Include đọc qua KPakFile: đúng thứ tự package.ini, file rời chỉ fallback.
- Chạy thư viện trong chính Lua state của NPC, giữ callback và biến dùng chung.
- Chặn đường dẫn thoát thư mục, vòng lặp Include, quá sâu/quá lớn; báo lỗi thật
  khi thiếu thư viện. Giữ nguyên byte đường dẫn CP936.
- Kiểm thử Engine/Lua 4 thật: PAK thắng file rời cùng tên; fallback; callback
  cùng state; file thiếu/vòng lặp/đường dẫn lỗi không làm hỏng lần gọi tiếp.

### Schema và phí hợp thành

`PhongThanComposeRecipe.h` và `PhongThanComposeServer.inl`:

- Sửa hiểu sai cột 2: ID thuộc tính hợp thành, KHÔNG phải tiền.
- Sửa hiểu sai cột 15: nhóm công thức, KHÔNG phải số lượng thành phẩm.
- Số lượng lấy từ trường thứ tư của tuple `genre.detail.particular.quantity`.
- Tiền lấy bằng ID công thức từ
  `settings/item/001/zhuang_bei_he_cheng_jin_qian_xu_qiu.txt`.
- Giữ phạm vi đã chứng minh: 30 công thức vật liệu, nhóm 1, loại 6, xác suất
  100%, không cần thuộc tính/recipe phụ. Chưa tự mở các nhóm công thức khác.
- Công thức 83: 2 vật liệu 29 -> 1 vật liệu 30, phí 400 lượng, theo PAK VNG.
- Client hiển thị lỗi thiếu tiền và bỏ thông báo sai rằng hợp thành miễn phí.

Kiểm thử dùng chính implementation giao dịch và bảng PAK thật, với inventory
giả lập: thành công/phí; thiếu tiền; túi đầy; request cũ; bấm lại không cấp thêm.
Chưa thử giao dịch này trên nhân vật thật, không chỉnh tiền/đồ/tọa độ nhân vật.

Đã build CoreServer, CoreClient, GameClient và publish đúng ba binary vào
`PhongThanRuntime-Staging`; không sửa PAK/map, không khởi động dịch vụ.

| Binary | SHA256 |
|---|---|
| Server/CoreServer.dll | 479D79DAC88BA91CA0D3513E4B04EAC1A8C91FE0FCED649F1BF7D1D79F5C0CE1 |
| Client/CoreClient.dll | 168E9BFE8516600EED613DE5C4E6F5ADDD8BFEE38B92A62CD0E509DD1EB9682F |
| Client/Game.exe | C93C3C8C7F8A22DFB236BF653A8BA80EE7C4502E65880561276D805B5468F15E |

## Chưa hoàn thành — không tính menu hướng dẫn là nghiệp vụ

84 Lua hướng dẫn vẫn chưa thành các nhiệm vụ/giao dịch hoàn chỉnh. 42 nhánh gốc
cần kiểm chứng ID/API/điều kiện và lưu trạng thái. Không đánh dấu chúng xong chỉ
vì Include hoặc compile đã qua.

Việc tiếp theo theo thứ tự:

1. Xích Tùng Tử: đối chiếu tất cả nhóm trong bảng hợp thành, bảng chi phí,
   bảng tỷ lệ và bảng thuộc tính sau nâng cấp; triển khai kiểu giao dịch có giữ
   hoặc mất trang bị đúng từng nhóm dữ liệu, không đặt công thức riêng từng món.
2. Thái Thượng Lão Quân: phục dựng chuỗi Tinh Quân Giáng Thế -> Thu Thập Chiến
   Hồn -> chế tạo/nâng cấp; xác minh task ID, boss kết thúc, vật phẩm, giới hạn
   ngày và phần thưởng trước khi bật giao dịch.
3. 82 mục có ứng viên: chọn đúng phiên bản, đọc hết thư viện và kiểm chứng
   tham số API. Giữ nguyên nguồn tham khảo; không trộn bytecode/ID của server khác.
4. Các mục còn thiếu: dùng luật VNG và script tương tự đã kiểm chứng để viết bù;
   nội dung không công bố rõ được ghi thành điểm thiếu, không tự đặt tỷ lệ.

Nguồn luật đối chiếu:

- [Tinh Quân: nhiệm vụ, nguyên liệu và chế tạo](https://phongthan.zing.vn/su-kien/trang-bi-va-vu-khi-tinh-quan/trang-bi-tinh-quan-cap-1.html).
- [Nâng cấp Tinh Quân nhiệm vụ](https://phongthan.zing.vn/tin-tuc/tin-tuc/thang-cap-trang-bi-tinh-quan-nhiem-vu.html).
- [Thăng cấp trang bị 120 và kết quả khi thất bại](https://phongthan.zing.vn/su-kien/phien-ban-moi-luong-cuc-tam-gioi/thang-cap-trang-bi-120.html).

Lưu ý phiên bản: bài trang bị 120 và bảng VNG hiện có không được mặc định áp
dụng cho mọi trang bị đời khác. Nội dung web cũng có tên nguyên liệu không nhất
quán giữa một số hàng; cần dùng bảng/ID cùng phiên bản để giải quyết.

## Chạy lại có phạm vi

- `Tools/prepare_npc_lua_library.py --write`: kho ứng viên, không deploy.
- `Tools/build_npc_lua_worklist.py`: danh sách NPC và nguồn ứng viên.
- `Build/Test-NpcLuaFoundation.ps1`: kiểm thử loader/schema/giao dịch.
- `Deploy/Publish-NpcLuaRuntime.ps1`: chỉ ba binary; từ chối nếu Game hoặc
  GameServer đang dùng chúng. Không khởi động hay sửa các dịch vụ tài khoản.
