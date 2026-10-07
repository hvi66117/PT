# Bộ 8 ini giao diện client cơ bản (đợt #7 uiini)

Ngày: 2026-10-05 · Phạm vi: client (`PhongThanRuntime-Staging\Client\Ui\ui3`) · Không sửa C++, không cần ptfix

## Phần 1: Tổng quan

- Tám cửa sổ đã có lớp C++ trong client nhưng thiếu file `UiXxx.ini`. Vì vậy `LoadScheme` bỏ qua mọi `Init`, cửa sổ có kích thước 0 và không hiện.
- Ba cửa sổ còn nguy hiểm hơn. Chúng gọi `Wnd_SetExclusive` khi mở nên cửa sổ vô hình **chiếm hết bàn phím, chuột**:
  - `UiInformation`: mọi `UIMessageBox` của server và client.
  - `UiESCDlg`: phím Esc khi không còn cửa sổ nào để đóng.
  - `UiBreakItem`: Shift + click vật phẩm xếp chồng.
- `UiNewsSysMsg` (TopMessage, 319 script server dùng, cộng thông báo tìm đường/tự đánh) và `UiNewsMessage` (ScrollMessage):
  - Khi thiếu ini, màu chữ, khoảng thời gian hiển thị và độ rộng vùng chữ là giá trị rác, chưa khởi tạo.
- Đã dựng đủ 8 ini từ layout VNG trong PAK. Kèm 2 file dữ liệu cho bảng Trợ giúp (F1).
- Tất cả là **file rời** tên tiếng Anh, không có trong PAK nên client đọc trực tiếp, giống `UiShop.ini` đã cài.
- Smoke test offline với các `.obj` UI thật của bản build hiện đại: **0 lỗi**.

| Cửa sổ (lớp) | Ini VNG nguồn → file đích | Mở từ đâu | Trạng thái |
|---|---|---|---|
| `KUiInformation` | `\ui\ui3\提示.ini` (8df7bf5a) → `UiInformation.ini` | `UIMessageBox`, MessageBox server | Chép nguyên 4 mục, căn giữa 1024x768 |
| `KUiESCDlg` | `\ui\ui3\esc打开的界面.ini` (e6641da3) → `UiESCDlg.ini` | Phím Esc (`Open([[system]])`), nút Hệ thống | 3 nút: Tiếp tục / Chức năng / Rời khỏi và lưu game. Không có Ủy thác, Trợ giúp |
| `KUiProgressBarLoading` | `\ui\ui3\打造物品.ini` (1b62b004) → `UiProgressBarLoading.ini` | Lua `OpenProgressBar(n)` → `s2c_openprogressbar` | Xong. Hiện chưa script nào gọi |
| `KUiNewsSysMsg` | `\ui\ui4\系统公告.ini` là dữ liệu, không phải layout → viết mới `UiNewsSysMsg.ini` | `TopMessage()`, `GDCNI_TOP_MESSAGE` | Xong, chữ vàng giữa màn hình, y = 150 |
| `KUiNewsMessage` | `\ui\ui3\新闻消息来了.ini` (0523859a) → `UiNewsMessage.ini` | `ScrollMessage()` / `AddGlobalNews`; tự mở khi vào game | Chép nguyên, căn giữa 1024 |
| `KUiBreakItem` | `\ui\ui3\分割物品界面.ini` (55e54c8d) → `UiBreakItem.ini` | Shift + chuột trái vào chồng vật phẩm trong túi (F4) | Đổi tên mục, nút +/− đặt lên mũi tên vẽ sẵn |
| `KUiSelPlayerNearby` | `\ui\ui3\选择附近玩家.ini` (97a36ce4) → `UiSelPlayerNearby.ini` | Nút Giao tiếp trên thanh công cụ, nút Tìm trong bảng bạn bè | 7 hành động, đổi mã VNG sang `ACTION_*` của PT |
| `KUiHelper2` | `\ui\ui3\详细帮助界面.ini` (bf7b4312) → `UiHelper2.ini` + `DetailHelper.ini` + `DetailHelperData.ini` | F1 (`Open([[help]])`), nút Trợ giúp, nút Trợ giúp trong Esc (đã ẩn) | 46 mục trợ giúp tiếng Việt từ VNG, 1.071 dòng |

## Phần 2: Chi tiết

### 2.1 Quy tắc chung

- **Mã hóa:** GBK + CRLF. Đường dẫn sprite là tiếng Trung GBK, chép từ VNG.
- **Chữ tiếng Việt:** byte TCVN3 chép từ ini VNG, bỏ tiền tố `$` vì client PT không xử lý ký tự này. Không gõ tay chuỗi nào.
- **Tọa độ:** ini VNG dùng hệ 800x600, client PT chạy 1024x768 (`config.ini`) và **không đọc** `CalculateWay`. Các hộp thoại giữa màn hình được tính lại để căn giữa 1024x768.
- **Thanh cuộn:** `KWndScrollBar` của PT gồm ảnh thanh và mục `<tên>_Btn`.
  - VNG tách thành `X_Bar`, `X_Bar_Btn`, `X_BtnUp`, `X_BtnDown`.
  - Đã gộp `X` + `X_Bar` thành một mục. Nút mũi tên lên/xuống không có thành phần tương ứng ở PT nên bỏ.
- **Sprite:** đã kiểm 17 sprite, tất cả có trong PAK client (đọc header SPR). Smoke test cũng báo 0 sprite thiếu.

### 2.2 Từng cửa sổ

**UiInformation.ini** (`KWndShowAnimate` + `KWndText256` + 2 `KWndPureTextBtn`)
- Giữ nguyên các mục `Main`, `Info`, `FirstBtn`, `SecondBtn` (tên khóa trùng 100%).
- `Main` 295,264, kích thước 434x110.
- Bỏ `ThirdBtn` vì PT không có.

**UiESCDlg.ini**
- Khung `游戏选项外框.spr` 360x186 đặt ở 332,291.
- Ba nút 240x27 căn giữa:
  - `ContiumeGame` (继续游戏): đóng menu.
  - `Options` (功能选项): mở `KUiOptions`.
  - `ExitGame` (退出并保存游戏): gửi `GOI_EXIT_GAME`, về màn hình đầu.
- Lớp C++ còn đọc `OffLine` (Ủy thác, gọi `\script\system\uythac.lua` phía server; file loose này không tồn tại) và `GameHelp`. VNG không có sprite cho hai nút này nên **cố ý bỏ** để thành cửa sổ 0x0 vô hình, không bấm được.
- F1 vẫn mở trợ giúp.
- Nút `GameToSelPlayer` của VNG không có xử lý trong PT.

**UiProgressBarLoading.ini**
- Ảnh PT là `合成栏.spr` bản mới (update0_169, 219x395, bảng "ghép" có 8 ô bát quái). Tọa độ ngọc của ini VNG cũ không khớp ảnh này nên đã đặt lại 7 ô ngọc + ô vật phẩm lên các ô vẽ sẵn, kèm `HaveBgColor=0`. Class không bao giờ điền vật phẩm vào các ô này.
- Hiệu ứng `合成特效.spr` (27 khung) đặt chồng lên thái cực.
- Thêm `LoadingProgress` ("Đang tiến trình...") và phần trăm vào ô chữ dưới cùng.
- Bỏ `Assemble`/`Close` vì bấm không làm gì.
- **Lưu ý C++:**
  - Phần trăm tính bằng `khung*100/130` (cố định cho hiệu ứng 130 khung). Với 27 khung, số hiện tối đa khoảng 20% rồi cửa sổ tự đóng.
  - Không có script server nào gọi `OpenProgressBar`.

**UiNewsSysMsg.ini**
- Viết mới theo các khóa `KUiNewsSysMsg::LoadScheme` đọc: `Font=16`, `TextColor=255,253,122`, `ShowInterval=6000`, `Top=150`.
- Class căn chữ theo `RESOLUTION_WIDTH=800` nên dùng `IndentH=112` để dời về giữa màn 1024.
- Tối đa 3 dòng, cách nhau 32 px, cho chuột bấm xuyên qua.

**UiNewsMessage.ini**
- Chép nguyên `新闻消息来了.ini`, chỉ đổi `Left=319` để căn giữa 1024.
- Thông số giữ của VNG: thanh 386x16 ở y = 50, `IndentH=11`, chữ cuộn mỗi 125 ms, bóng đen alpha 80.

**UiBreakItem.ini**
- Đổi tên mục: `BtnConfirm`→`OkBtn`, `BtnCancel`→`CancelBtn`, `EditQuantity`→`StringInput` (`Type=0` chỉ nhận số, `MaxLen=4`).
- Thanh trượt và 2 ô vật phẩm của VNG không có thành phần tương ứng ở PT. `Decrease`/`Increase` là vùng bấm trong suốt đặt đúng lên mũi tên ◀ ▶ vẽ sẵn trên ảnh, đo theo pixel (64..66 và 116..118, y 34..38).
- `ItemName` nằm ở dải trên của ảnh. `Title` ("Nhập số lượng", do code đặt) nằm ngay phía trên khung.
- Bỏ `CheckButton`/`Button` (tách hết): `BreakAll` luôn tắt.
- **Lỗi có sẵn trong C++:** code `Init` hai lần vào `m_CheckButton` (`CheckButton` rồi `Button`).

**UiSelPlayerNearby.ini**
- Nút hành động của PT là `KWndPureTextBtn`, chỉ có chữ, không vẽ ảnh nút. Đã đổi khóa màu VNG `Up*`/`Down*` → `Color`/`SelColor`.
- Đặt `Width/Height` 63x17 theo ảnh nút VNG. Nếu thiếu, kích thước 0 và không bấm được.
- Mã hành động VNG thuộc enum khác nên đã ánh xạ sang PT:

| VNG id | Nhãn (byte VNG) | PT `ACTION_*` |
|---|---|---|
| 26 | Thêm hảo hữu | 1 MAKEFRIEND |
| 6 | Giao dịch | 2 TRADE |
| 24 | Nhập đội | 3 JOINTEAM |
| 23 | Tổ đội | 4 INVITETEAM |
| 9 | Theo sau | 5 FOLLOW |
| 12 | Tin tức | 0 CHAT (mật đàm) |
| 29 | Sổ đen | 7 BLACKLIST |

- Bỏ hai mục:
  - "Chiêu nạp đệ tử": PT không có hành động này.
  - "Xem trang bị": cần `UiParadeItem.ini`, hiện cũng thiếu.
- Ô "giải trí" để trống vì PT không có thành phần tương ứng.

**UiHelper2.ini + DetailHelper.ini + DetailHelperData.ini**
- PT chỉ có 1 danh sách mục + 1 khung nội dung. VNG có 2 cấp (danh mục → chủ đề) nên đã làm phẳng:
  - Danh mục có trang giới thiệu sinh tự động `PTHelpCat_*`.
  - Chủ đề lùi 2 dấu cách.
  - Tổng 46 mục.
- `DetailHelperData.ini` là bản chép `详细帮助项目.ini` ui3 (6dd9f660):
  - Gộp các mục trùng tên.
  - Bỏ `$` và `##`.
  - Đổi thẻ màu VNG `<c=r>`/`<c=yel>`/`<c=g>`/`<c>` sang `<color=Red/Yellow/Green>`/`<color>`. Bộ mã hóa chữ PT chỉ hiểu `color/bclr/pic/enter`.
- Danh sách nằm ở ô dưới bên trái (font 12, tên dài tự cắt ".."). Ô trên bên trái để trống.
- **Cố ý bỏ** `BtnPic/BtnKeyboard/BtnWuxing`:
  - Ba nút này mở `KUiHelper`, mà `UiHelper.ini` đang thiếu.
  - `KUiHelper::Show()` còn tắt phím tắt, đặt lại vị trí thanh công cụ và đổi chế độ bản đồ nhỏ, nên cửa sổ vô hình sẽ thành bẫy.
- Mọi dòng trong `DetailHelper.ini` đều có `_Ini`, nên `KUiHelper` không bao giờ được mở.

### 2.3 Kết quả smoke test

- Thư mục: `scratchpad\uiini\w7\smoke\`, gồm `ui7_test.cpp`, `bui.cmd`, `ui_out.txt`.
- Link 8 `.obj` UiCase + 15 `.obj` Elem thật từ `GameClient\Modern\Win32Release` với renderer ghi lại thao tác vẽ (kích thước sprite đọc từ PAK, `sprites.h`) và `iCoreShell` giả.
- Kết quả: **SMOKE PASSED (0 failures)**, 74 kiểm tra:

| Cửa sổ | Đã kiểm |
|---|---|
| Information | Hiện + chiếm quyền nhập. Hai nút ở 40,85. Một nút thì căn giữa. Enter đóng hộp một nút. Bấm nút 2 thì đóng và trả quyền nhập |
| ESC | Khung căn giữa, 3 nút 240x27. OffLine/Help/BackGround có kích thước 0x0. Vẽ 4 ảnh. Tiếp tục và phím Esc đều đóng menu |
| ProgressBar | Vị trí khung, hiệu ứng, ô ngọc. Chữ "Đang tiến trình..." và "0%". Hiệu ứng chạy hết 27 khung thì tự đóng (38 nhịp) |
| TopMsg | Font 16, giữ tối đa 3 dòng, căn giữa 1024, màu vàng, y từ 150 |
| News | Thanh 386x16 ở y = 50. Chữ cuộn sang trái trong vùng |
| Break | Kích thước 182x113. Tối đa = chồng − 1. Title/ItemName đúng chỗ. Vùng bấm nằm đúng mũi tên. + + → 3, chặn ở 9, − → 8. OK gửi `BreakItem(8)` rồi đóng. Esc hủy, không gửi gì |
| Nearby | 413x372 tại 0,116. 7 hành động, mã PT đúng. Nhãn TCVN3 không còn `$`. Danh sách 3 người. Bấm tên thì điền vào ô nhập. Làm mới và Đóng đều chạy |
| Help | 474x326 căn giữa, 46 mục. Mục nào cũng có chữ (1.071 dòng). Không còn `$` hay `<c=` thô. Không có dòng `_Ini` rỗng |

- Ảnh bố cục: `scratchpad\uiini\w7\png\mock_*.png`.

## Phần 3: Hành động

### Triển khai (coordinator chép trong đợt cài)

- [ ] Sao lưu `PhongThanRuntime-Staging\Client\Ui\ui3\`. Cả 10 tên file đều **chưa có** trong runtime nên không ghi đè gì.
- [ ] Chép 10 file từ `scratchpad\uiini\deploy\Client\Ui\ui3\` vào `PhongThanRuntime-Staging\Client\Ui\ui3\`:
  - `UiInformation.ini`, `UiESCDlg.ini`, `UiProgressBarLoading.ini`, `UiNewsSysMsg.ini`, `UiNewsMessage.ini`, `UiBreakItem.ini`, `UiSelPlayerNearby.ini`, `UiHelper2.ini`
  - `DetailHelper.ini`, `DetailHelperData.ini`
- [ ] Mở lại Game.exe. Không cần build, không cần ptfix, không cần khởi động lại server.
- [ ] Thử trong game:
  - Esc (menu 3 nút).
  - Shift + click chồng thuốc trong túi (tách).
  - Nút Giao tiếp (chọn người chơi gần).
  - F1 (trợ giúp, bấm vài mục).
  - Script `TopMessage`/`ScrollMessage` (ví dụ dùng `itemid46.lua`, hoặc lệnh tìm đường Alt+F để thấy thông báo đỉnh).
  - Một hộp xác nhận bất kỳ của server.

### Việc còn mở (chưa làm, cần quyết định)

1. **Ủy thác trong menu Esc:** cần sprite nút "Ủy thác" riêng và script `\script\system\uythac.lua` phía server. Hiện cả hai đều không có.
2. **Phần trăm tiến trình:** sửa C++ `UpdatePercent` dùng `GetMaxFrame()` thay số 130. Chỉ đáng làm khi có script gọi `OpenProgressBar`.
3. Các ini còn thiếu có liên quan: `UiHelper.ini` (ảnh trợ giúp/phím tắt), `UiParadeItem.ini` (xem trang bị), `UiTongManager.ini`.
4. **Ngoài phạm vi, phát hiện khi kiểm tra:**
   - 319 script server gửi thẻ màu `<c=yel>`/`<c>` trong `TopMessage`, nhưng bộ mã hóa chữ PT không hiểu nên in nguyên văn.
   - Nhãn menu chuột phải lên người chơi (`g_ActionName` trong `UiGame.cpp`) đã bị hỏng thành byte `EF BF BD`.

## Phần 4: Tài liệu tham khảo

- Báo cáo nguồn: `de-xuat-khoang-trong-vng-phong-than-20261004.md` (mục #7). Dữ liệu `scratchpad\gaps\ui\client_classes_missing_ini.tsv`.
- Công cụ: `scratchpad\uiini\w7\`:
  - `gen7.py`: sinh 10 file, kiểm sprite, xuất `sprites.h`.
  - `mock7.py`: ảnh bố cục.
  - `spr.py`, `findbtn.py`, `findframes.py`: tra sprite.
  - `smoke\`: smoke test.
- Mã C++ liên quan: `GameClient\Ui\UiCase\` (`UiInformation.cpp`, `UiESCDlg.cpp`, `UiProgressBarLoading.cpp`, `UiNewsSysMsg.cpp`, `UiNewsMessage.cpp`, `UiBreakItem.cpp`, `UiSelPlayerNearby.cpp`, `UiHelper2.cpp`) và `ShortcutKey.cpp` (Esc/F1), `UiShell.cpp` (`Player_Communication`), `UiItem.cpp` (`OnBreakItem`).
- Sao lưu: `_backup\20261005-uiini\` (CHANGELOG.md, README.md trước khi sửa).
