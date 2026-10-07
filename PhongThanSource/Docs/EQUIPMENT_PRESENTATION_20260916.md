# Hiển thị trang bị — 16/09/2026

## Đã triển khai vào Staging/Client

- `Sources/Core/Src/PhongThanEquipmentArt.inl`: F4 dùng biến thể `_big_male.spr`/`_big_female.spr`, theo cờ `m_nHasSpecialImage` và `m_nSpecialSex` của template. Đọc PAK qua Engine, không thay ảnh trong bảng và không phóng lớn icon 32×32. Nếu thiếu biến thể, giữ icon gốc; không ghép ảnh thay thế. Hành trang tiếp tục dùng icon nhỏ riêng. Hình quá lớn được cắt trong ô, không kéo giãn.
- `KItem.cpp`: trọng lượng từ trường `负重` đã có trong template; hướng dẫn Ctrl+chuột trái theo mã chữ TCVN3. Không sửa chức năng chat vốn đã có trong WndObjContainer.
- Dòng thăng cấp màu cyan, giữa thuộc tính hiện và thuộc tính ẩn của bộ. Với vật phẩm không có bộ, dòng này nằm sau toàn bộ thuộc tính hiện. Nhãn từ ID quy tắc đã lưu, cột tên của 18 bảng nâng cấp; không đoán chế độ từ tên vật phẩm. STCB/hỏa sát được nhận diện bằng loại thuộc tính của quy tắc; băng/lôi/thổ và trang bị khác giữ nhãn gốc.
- `TextPic.cpp` + `PhongThanEquipmentStars.inl`: 1–12 sao ngay dưới tên; +12 có khung SPR nguyên bản động. Dải 15 sao gốc được cắt theo số sao, không thu/phóng hoặc tạo hình mới. ID inline 481–492 dành cho hiển thị này.
- Vầng sáng +12 trong ô đang mặc dùng tài nguyên gốc `tou.spr`, `shen.spr`, `yao.spr`, `fabao.spr`. Loại bỏ lớp viền chạy cũ riêng ở các ô đang mặc. Không áp hiệu ứng lên đồ còn nằm trong túi.
- Công lực đối với nguồn số nguyên: điểm gốc + điểm thuộc tính bổ sung đã nạp + tổng điểm thăng theo bảng PAK. Dòng vẫn có khi +0. **Chưa xác minh đầy đủ điểm công lực cho mọi loại đồ**, xem giới hạn dưới.

## Bằng chứng tài nguyên PAK trực tiếp

| Tài nguyên | PAK | Entry | Kích thước/frame |
|---|---|---:|---|
| `\spr\item\equip\衣服11.spr` | spr.pak | 695 | 32×32, 1 |
| `\spr\item\equip\衣服11_big_male.spr` | spr.pak | 4133 | 64×96, 1 |
| `\spr\item\weapen\斩将刀_big_male.spr` | spr.pak | 3190 | 66×98, 1 |
| `\spr\ui4\tips\星星黄色.spr` | update0_171-171.pak | 5073 | 208×11, 1 |
| `\spr\ui4\tips\边框12.spr` | update0_171-171.pak | 2245 | 172×17, 89 |
| `\spr\ui4\道具栏\tou.spr` | update0_122-163.pak | 4461 | 68×68, 20 |
| `\spr\ui4\道具栏\shen.spr` | update0_122-163.pak | 9120 | 66×98, 20 |
| `\spr\ui4\道具栏\yao.spr` | update0_122-163.pak | 4478 | 66×45, 20 |
| `\spr\ui4\道具栏\fabao.spr` | update0_122-163.pak | 1621 | 34×34, 20 |

`Tools/audit_equipment_presentation.py` kiểm tra entry/bytes trực tiếp. Tùy chọn `--preview` chỉ giải mã ảnh kiểm tra vào Output, không đưa ảnh tạo lại vào runtime. Tên có trong danh mục không tự chứng minh payload; các dòng trên đã kiểm tra payload thực tế và native Engine.

## Giới hạn chưa hoàn tất

1. Các ô công lực dạng `*a,b*` vẫn chưa có công thức đánh giá được chứng minh. Không thay bằng random, trung bình, tổng hai số, hoặc coi là 0. Khi không có điểm số đã đánh giá hợp lệ, hiển thị `Công lực: chưa xác định`. Tham khảo điều tra trước ở `Tests/EquipmentSchemaFindings.md`, `Tests/UpgradePowerEvidence.md`. Vì vậy không tuyên bố tổng công lực mọi trang bị đã chuẩn VNG.
2. Đồ thử được cấp sao từ trước nhưng chỉ lưu level, không lưu upgrade-rule, không thể xác nhận đã dùng Trầm Điện hay loại sát thương nào. Dòng hiển thị báo chưa rõ loại; không sửa lại đồ/save để ép một quy tắc.
3. Chưa nghiệm thu ảnh trong client đang chơi. Computer Use lỗi `failed to write kernel assets ... os error 3` ngay lúc khởi tạo; không thực hiện đăng nhập hay tác động đồ của người chơi. Các ảnh PAK đã giải mã được xem trực tiếp, không phải ảnh nghiệm thu UI đang chạy.
4. Chưa thay đổi hiệu ứng ngoại hình ngoài bản đồ; vầng sáng trong yêu cầu/ảnh được xử lý ở ô F4.

Luật giữ cấp khi thăng tinh lực được đối chiếu [hướng dẫn VNG](https://phongthan.vinagame.com.vn/su-kien/thang-cap-trang-bi-va-vu-khi/thang-cap-trang-bi.html); quy tắc/nhãn cụ thể lấy từ PAK đang dùng, không chép số liệu của một vật phẩm mẫu lên mọi vật phẩm.

## Kiểm tra và bản phát hành

- `Build/Test-EquipmentPresentation.ps1`: PASS — helper production, đọc/giải mã SPR bằng Engine thật, giới hạn sao, STCB/hỏa/lôi/tinh lực, điểm số +0, overflow và chặn pair chưa rõ.
- `python Tests/test_equipment_presentation_wiring.py`: 3 PASS — tách túi/ô mặc; thứ tự sao/thăng/ẩn/trọng lượng/hướng dẫn; ảnh lớn/cờ template/+12.
- `Build/Build-PhongThan.ps1 -Targets CoreClient,GameClient -NoRebuild`: 0 lỗi biên dịch; kiểm tra này không thay nghiệm thu UI.
- `Deploy/Publish-NativeClient.ps1`: đã cập nhật Game.exe/CoreClient.dll, manifest và gate native 22 artifact. Không thay CoreServer, giao thức, PAK, Lua hoặc save nhân vật. File định nghĩa túi tân thủ do publisher chép lại không đổi hash.
- CoreClient.dll: `D2719F16244A999EB8F8D38DAFFC9DB05ACA14A1B7CCD1C7F767BA21E16BEB12`.
- Game.exe: `5AEC94B8AE51EC930F7DD831A88E6641D1B2441E66F9961ED845C8EF8D0A9A71`.
- Server PID 22024 giữ nguyên, marker `WORLD_READY bishop_pid=26400 service=1001 maps=102`.

Bước nghiệm thu: mở đúng `PhongThanRuntime-Staging/Client/Game.exe`; so sánh cùng món khi trong túi/đang mặc, xem đồ +0 và đồ thăng mới +1/+12; kiểm tra sao, màu dòng và vầng sáng. Không cần restart server cho thay đổi hiển thị này. Công việc tiếp theo còn bắt buộc: hoàn thiện công thức công lực pair bằng bằng chứng VNG.
