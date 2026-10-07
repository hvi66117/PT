# Xích Tùng Tử — triển khai 16/09/2026

## Phạm vi đã phát hành

- NPC gốc ở Diêu Trì 1052: template 206, world (49965,100773); map/reference không đổi.
- PAK script `\script\瑶池\赤松子.lua`, entry 987, ID D02B148D; giữ nguyên byte gốc và ghép appendix có nguồn. KNpcSet chỉ chuyển đúng bộ ba world/template/script sang `\script\phongthan\npc_services\xich_tung_tu.lua`. Không nhận diện chỉ bằng template hình ảnh.
- Giữ menu 3 nhánh, bảo điển 6 nhóm/16 callback. Đổi 10 danh vọng lấy vật liệu 82 qua giao dịch an toàn; không trừ điểm nếu túi đầy hoặc tạo đồ lỗi.
- Hợp thành vật liệu 100%: 40 công thức giải mã được; 28 có đủ phí, 12 bị chặn vì ô phí PAK trống. Hỗ trợ sản phẩm nhiều chiếc. Không suy diễn ô trống là miễn phí.
- Thăng thường/thăng tinh chế có Trầm Điện qua công thức loại 1, nhóm 1; hoàn nguyên qua loại 7. Điều kiện `(3,4,5)` được hiểu là số lần đã thăng, không bỏ qua.
- Đọc thuộc tính từ 18 bảng nâng cấp (3 hệ, 6 nhóm trang bị), theo attribute-rule ID trong công thức. Không tra theo SetID, không viết công thức riêng từng món.
- Phí từ `zhuang_bei_he_cheng_jin_qian_xu_qiu.txt`, theo ID công thức và lần thăng. Chance=0 đọc bảng tỷ lệ theo loại trang bị/lần; chance khác 0 dùng đúng phần trăm của dòng PAK.
- Giữ cùng item ID, seed, template, thuộc tính gốc và thuộc tính bộ; không tạo lại trang bị để roll chỉ số. Chỉ cộng/trừ lớp delta của quy tắc nâng cấp.
- Ghi cả rule và level trong biểu diễn có tag của trường UpgradeLevel, không đổi độ dài packet/record. Source/client/server cùng giải mã. Dữ liệu cũ chỉ có level được giữ nguyên; phải hoàn nguyên trước khi thăng tiếp để tránh đoán rule cũ.
- Hoàn nguyên xóa riêng delta thăng cấp, giữ chỉ số gốc; xóa các slot chỉ do nâng cấp tạo ra. Không để lại dòng thuộc tính 0 giả.
- Lỗi kỹ thuật/túi đầy/thanh toán lỗi khôi phục nguyên liệu về đúng slot, không thu tiền. Thất bại theo xác suất là nghiệp vụ riêng: lần 4–6 về +3; lần 7–9 mất cả trang bị; lần 10–12 về +0. Không hoàn lại nguyên liệu/chi phí của một lần thăng đã thực hiện.
- Client mở panel bằng native event độc lập, sửa tọa độ slot nguồn/đích và mở lại nút sau timeout. Có cảnh báo có thể mất đồ, kết quả thăng/hoàn nguyên riêng và dòng số lần thăng trong tooltip.

## Nguồn

PAK được đọc qua package.ini, không sửa PAK:

| Nội dung | PAK | Entry / SHA256 |
|---|---|---|
| Công thức | vng00.pak | 4400 / 5cd4ddc5fb99b15d5f183873deafef1135ac21b73d0e8ef79be86a3dc6cafb87 |
| Phí | vng00.pak | 2042 / aac64fc86b90a0d0ede8b2dccbe257eb509f3cfde48448b571042fa4b213a376 |
| Tỷ lệ cơ bản | vng00.pak | 1436 / 58704d5f1afeb3b4214552f221b4f9bae1ef128cc7ec4ebb11284bc06366ea5c |
| IBItem: Trầm Điện 8/191/2, Quy Chân Thạch 8/201/5 | vng00.pak | 1553 / 36cd0111705985d49ef23a7be2978abe2d483cad3735404f6d5c5a795a20c7b7 |

Luật hậu quả thất bại đối chiếu [VNG — Thăng cấp trang bị 120](https://phongthan.zing.vn/su-kien/phien-ban-moi-luong-cuc-tam-gioi/thang-cap-trang-bi-120.html) và bảo điển Lua gốc. Bài web và PAK khác một số tỷ lệ 6/10/16 so với mô tả 10%; runtime dùng số PAK, không pha phiên bản web. Pháp bảo có luồng riêng theo [VNG — Hệ thống Pháp Bảo](https://phongthan.zing.vn/tin-tuc/can-biet/he-thong-phap-bao-phong-phu.html), chưa gộp nó vào quy tắc vũ khí/giáp.

## Kiểm thử đã chạy

`Build/Test-XichTungTu.ps1`:

- Lua 4 thật: tái hiện lỗi trừ điểm nhưng không nhận Tha Sơn Thạch, xác nhận bản sửa; menu, 16 trang hướng dẫn, định danh NPC, khoảng cách, khóa, túi đầy, lỗi tạo vật phẩm.
- Bảng PAK thật: parser, đủ tuple và điều kiện level; 28 công thức vật liệu đủ phí.
- Giao dịch vật liệu: nhiều output, lỗi tạo/đặt đồ giữa chừng, thiếu tiền, bấm lại và request cũ.
- Phương thức KItem thật với bảng PAK: weapon rule1 +30/+30 ở +3, +45/+45 ở +4; armor rule41 phòng ngự +42 ở +4; áp dụng lặp không cộng trùng; hoàn nguyên không mất thuộc tính bộ.
- Giao dịch trang bị: rule1/201 thường/tinh chế, hoàn nguyên 1101, giáp vàng rule3006/công thức9144 và hoàn nguyên10502; giữ ID, thất bại về+3/mất đồ/về+0; tỷ lệ 6% với roll5/6; sai mode, legacy rule thiếu, túi đầy, thanh toán lỗi, lỗi tháo nguyên liệu.
- CharacterStore create/load thật trong thư mục test riêng: giữ nguyên byte trạng thái có tag, chuyển sang packet client hợp lệ. Không sửa nhân vật thật.
- CoreServer/CoreClient/GameClient build thành công; còn cảnh báo kích thước image CoreServer lớn đã có trước, không phải build 0 cảnh báo.

Các bài trên dùng inventory/RNG test double; chưa nghiệm thu qua client đăng nhập thật. Không tuyên bố toàn bộ NPC hoàn tất.

## Chưa mở

- Thăng 13–15 (hậu quả thất bại khác phiên bản cần xác minh).
- Công thức có qualifier `[...]`, yêu cầu recipe riêng, các phép biến đổi loại 2/6/11, luyện/ghép pháp bảo và thú cưỡi.
- Dòng thiếu phí, thiếu rule, sai/mơ hồ dữ liệu bị từ chối trước khi trừ đồ.

## Runtime đã cập nhật

- Staging Server/CoreServer.dll: 71331949B24879D98E4D67FC0E022E27A2658C23855B4860BDAB6588033DAB12
- Staging Client/CoreClient.dll: CF3E678364A5FF0336B30AC1CE5DED3461DE46AA087AD3C7D26DBCE9AA7F428C
- Staging Client/Game.exe: CD036CC84588BFC08C5579ECE62FF71ABAE373D0B68792FA47ADF0AB217DFEF5
- Lua Xích Tùng Tử trong Content/Server và Staging/Server: 094ba522d53f5b1dc740ddc971f65ba50e6777bbb4d6c8a92f6b6a4ae7d4c4d9

Không restart dịch vụ trong lượt này; không sửa save nhân vật/map/PAK.
Sau khi khởi động server/client mới, chọn Xích Tùng Tử → Hợp thành vật phẩm.
Đặt đúng tuple/nguyên liệu và số lượng công thức PAK trong 9 ô. Hoàn nguyên dùng trang bị đã thăng + Quy Chân Thạch (8/201/5).
Nhật ký giao dịch khi chạy thật: `Server/xich_tung_tu_diag.log`.
