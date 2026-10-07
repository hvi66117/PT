# Cửa sổ Tùy chọn: độ phân giải và âm thanh không hoạt động

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-01, cập nhật phần âm thanh 2026-10-02
> Trạng thái:
> - **Độ phân giải:** đã có chỗ chỉnh trên web admin, có hiệu lực khi mở lại game. Ô chọn trong game cần C++.
> - **Âm thanh:** đã tìm ra nguyên nhân (thiếu file giao diện `UiOptions.ini`). Đã có bản vá ptfix (`extra_sound.py`) và chỗ chỉnh âm lượng trên web admin. Chờ cài ptfix.pak mới và kiểm tra trong game.

## Phần 1: Tổng quan
- **Cửa sổ** ESC → Tùy chọn là `KUiOptions`.
  - Game.exe nạp giao diện từ `<thư mục giao diện>\UiOptions.ini`, tức `\ui\ui3\UiOptions.ini`.
  - Chuỗi `UiOptions.ini` có trong Game.exe; `UiOptions.cpp` dòng 24 và 148.
- **Nguyên nhân mất thanh âm thanh (đã kiểm chứng): thiếu file giao diện.**
  - `\ui\ui3\UiOptions.ini` (mã `476417ed`) **không có** trong PAK client nào, cũng không có file rời trong `Client\ui\ui3\`.
  - Vì vậy `Ini.Load` thất bại và `KUiOptions::LoadScheme` không chạy. Cửa sổ không có nền, không có thanh trượt Music/Sound, không có nút bật/tắt.
  - Mã C++ **có tạo** đủ các điều khiển: `m_BGMValue` ("Music"), `m_SoundValue` ("Sound"), 4 nút bật/tắt, `ShortcutSet`, `CloseBtn`. Nó chỉ thiếu file ini để định vị và gắn hình.
  - VNG phát hành đúng bố cục này dưới tên tiếng Trung `\ui\ui3\选项.ini` (mã `6bf7bc29`, vng00.pak). Tên các mục trong file khớp với mã: `Main`, `CloseBtn`, `Music`/`Music_Btn`, `Sound`/`Sound_Btn`, `ShortcutSet`, `ToggleStatus`, `ToggleBtn`, `ToggleOptionsName`.
  - Đây là trường hợp **(a)**: sửa bằng file giao diện, không cần dựng lại client.
- **Lưu âm lượng:** **không** nằm trong `config.ini`.
  - Game lưu trong `Client\UserData\UiCommon.ini`, mục `[Options]`, hai khóa `MusicValue` và `SoundValue` (thang 0–100).
  - Game đọc hai khóa này **khi khởi động** (`UiInit.cpp` dòng 56 → `KUiOptions::LoadSetting(…, true)`) và mỗi lần cửa sổ game được kích hoạt lại (`UiShell.cpp` dòng 393).
  - Hiện file `UiCommon.ini` chưa có mục `[Options]`, nên game dùng mặc định 100/100.
- **Độ phân giải (kiểm chứng):** `KUiOptions` không có mã cho `Resolution`, `CmbAniQuality` hay `MaxPlayerCount`. Các mục này chỉ là hình vẽ trên nền.
  - Client đọc độ phân giải **một lần lúc khởi động** từ `Client\config.ini` mục `[Client]`: `ScreenWidth`, `ScreenHeight` (800–1920), `FullScreen` (`PhongThanClient.cpp`, `KMyApp::GameInit` dòng 214–216).

## Phần 2: Chi tiết
### 2.1 Web admin: "Cài đặt client: độ phân giải" (tab Cài đặt server)
- Chọn 800×600 hoặc 1024×768 (giao diện VNG chỉ thiết kế cho hai mức này), cùng chế độ Cửa sổ / Toàn màn hình. Bấm "Lưu cài đặt client".
- API: `GET /api/clientcfg`, `POST /api/clientcfg`; hàm `Get-ClientCfg` / `Set-ClientCfg` trong `PhongThan-Admin.ps1`.
  - Chỉ sửa 3 khóa trong `[Client]`, giữ nguyên các dòng khác.
  - Mỗi lần lưu sao lưu `config.ini` vào `_backup\client-config\`.
  - Từ chối các độ phân giải khác.
- Có hiệu lực khi **thoát game rồi mở lại** (`PhongThan-MoGame.cmd`).
- **Kiểm thử trên bản sao** `config.ini`: đọc ra 1024×768 cửa sổ; ghi 800×600 toàn màn hình đúng; 1920×1080 bị từ chối. `PhongThan-Admin.ps1` không lỗi cú pháp.

### 2.2 Bản vá ptfix: khôi phục cửa sổ Tùy chọn (`extra_sound.py`)
- **File:** `S\ptfix\extra_sound.py` (plug-in của `build_ptfix.py`).
  - Đọc `选项.ini` từ PAK **client** theo thứ tự `Client\package.ini`.
  - Ghi thành mục `\ui\ui3\uioptions.ini` (mã `476417ed`) trong ptfix.pak.
  - Chạy với mọi `SIDE`: ptfix.pak dựng một lần với `SIDE=Server` rồi chép sang cả hai phía.
- **Giữ nguyên của VNG:**
  - nền `\Spr\Ui4\系统选项\选项.spr` (246×275);
  - thanh **Âm thanh** (`Music`, y=36) và **Hiệu ứng âm thanh** (`Sound`, y=56), 0–100, nút kéo `通用拖动条-竖.spr`;
  - nút đóng `npc对话条\确定.spr`.
  - Mọi sprite đã kiểm tra có trong PAK client.
- **Chỉnh cho khớp mã dựng lại** (sửa ở mức byte, giữ GBK/CRLF, thêm một dòng chú thích ASCII ở đầu):
  - Mã luôn hiện **4** nút bật/tắt, trong khi nền VNG chỉ có 3 ô. Các nút được xếp cách nhau 19 px từ y=153 để cả 4 nằm trong vùng khung.
  - Tên 4 nút (TCVN3), đúng thứ tự trong mã:
    1. Hiệu ứng ánh sáng;
    2. Thời tiết;
    3. Phối cảnh 3D;
    4. Chất lượng cao.
  - Dấu tích dời sang phải nhãn (x=178). Sprite tích chỉ có 2 khung nên `DisableFrame=0`.
  - Nhãn `ShortcutSet` (phương án phím tắt) dời vào ô "Chọn giao diện" (x=100, y=95).
- **Dựng thử:** `python S\ptfix\build_ptfix.py Server S\sound\ptfix_test.pak` chạy thành công.
  - Log: `"sound": "uioptions.ini 476417ed from vng00.pak (3330 bytes)"`, tổng 398 mục.
  - Các plug-in khác (tutuong_a, tutuong_b) vẫn chạy bình thường.
  - Nội dung trích lại từ PAK thử đúng: CRLF và các mục Music/Sound đầy đủ.
- **Giới hạn còn lại:**
  - Ô "Chất lượng hình động" và "Số người hiển thị trên màn hình" vẫn chỉ là hình nền vì mã không có điều khiển cho chúng.
  - Tên phương án phím tắt lấy từ `\ui\setting.ini` là chữ Trung (`默认配置`), có thể hiện ký tự lạ.
  - "Hiệu ứng ánh sáng" và "Phối cảnh 3D" chỉ bấm được khi chạy Represent3. "Thời tiết" bị mã ép tắt mỗi lần nạp.

### 2.3 Web admin: "Cài đặt client: âm thanh" (tab Cài đặt server)
- **Giao diện:** hai thanh trượt "Nhạc nền" và "Hiệu ứng âm thanh" (0–100, bước 5), nút "Lưu âm lượng" và "Tắt hết tiếng".
- **API:** `GET /api/clientsound`, `POST /api/clientsound` (`{music, sound}`); hàm `Get-ClientSound` / `Set-ClientSound` trong `PhongThan-Admin.ps1`.
  - Chỉ sửa `MusicValue` / `SoundValue` trong `[Options]` của `Client\UserData\UiCommon.ini`. Nếu chưa có mục `[Options]` thì thêm mới; các dòng khác (Login, AccountList…) giữ nguyên.
  - Mỗi lần lưu sao lưu file vào `_backup\client-config\UiCommon.ini.<thời điểm>`.
  - **Từ chối lưu khi Game.exe đang chạy**, vì game ghi đè `UiCommon.ini` từ bộ nhớ khi thoát hoặc khi đóng cửa sổ Tùy chọn.
- **Thang âm lượng:** giá trị ≤ 3 là tắt tiếng (`KOption::SetMusicVolume` / `SetSndVolume`); 100 là lớn nhất.
- **Kiểm thử trên bản sao** (không đụng file thật):
  - file thật chưa có `[Options]` → đọc ra 100/100; ghi 60/30 thì thêm `[Options]` ở cuối;
  - `[Options]` nằm giữa file và có `MusicValue=-1` → đọc ra 0, ghi thay đúng chỗ, giữ `Brightness` và mục `[Login]` phía sau;
  - file chưa tồn tại → tạo mới;
  - giá trị 101 bị từ chối;
  - `PhongThan-Admin.ps1` không lỗi cú pháp.

### 2.4 Sửa gốc khi có trình biên dịch C++
- `KUiOptions`: thêm ô chọn `Resolution` (ghi `config.ini`, báo cần mở lại game), `CmbAniQuality` và `MaxPlayerCount`, theo các mục có sẵn trong `选项.ini`.
- Sửa chuỗi tên file `UiOptions.ini` hoặc thêm cơ chế đọc tên dự phòng `选项.ini`.

## Phần 3: Hành động
- [ ] Coordinator dựng lại ptfix.pak (đã có `extra_sound.py`) rồi cài vào **Client\data** (và Server\data như thường lệ).
- [ ] Mở lại web admin (để nạp API mới) → tab "Cài đặt server":
  - "Cài đặt client: độ phân giải" → chọn → Lưu;
  - "Cài đặt client: âm thanh" → **thoát game trước** → kéo thanh → "Lưu âm lượng".
- [ ] Mở game bằng `PhongThan-MoGame.cmd` → ESC → Tùy chọn. Kiểm tra:
  - có nền "LỰA CHỌN", hai thanh "Âm thanh" và "Hiệu ứng âm thanh" có nút kéo;
  - kéo thanh thì nhạc nền / tiếng hiệu ứng to nhỏ ngay;
  - 4 nút bật/tắt hiện trong khung, nút đóng (Xác định) đóng được cửa sổ;
  - đóng cửa sổ → thoát game → mở lại: âm lượng giữ nguyên (đã ghi vào `UiCommon.ini`).
- [ ] Nếu bố cục 4 nút bật/tắt bị lệch khung hoặc chữ đè nhau: chụp màn hình gửi lại để chỉnh tọa độ trong `extra_sound.py`.

## Phần 4: Tài liệu tham khảo
- `GameClient\Ui\UiCase\UiOptions.cpp`:
  - tên file ini dòng 24;
  - `LoadScheme` 145–215;
  - `OnScrollBarPosChanged` 389;
  - `LoadSetting` 450, `StoreSetting` 534.
- `GameClient\Ui\Elem\WndScrollBar.cpp` 51–88: các khóa `Type/Min/Max/PageSize/SlideBegin/SlideEnd` và mục `<tên>_Btn`.
- `GameClient\Ui\UiBase.cpp` 63 (`\UserData\UiCommon.ini`), 434–463 (thư mục giao diện `ui3` lấy từ `\ui\setting.ini` mục `[Theme]`).
- `Core\Src\KOption.cpp` 17–53 (thang âm lượng), `CoreShell.cpp` 3070.
- `GameClient\PhongThanClient.cpp` 171–226, `GameClient\Ui\ShortcutKey.cpp` 1447–1457 (lệnh đổi toàn màn hình ghi `config.ini`).
- `S\ptfix\extra_sound.py`, `S\sound\ptfix_test.pak`, ảnh kiểm tra bố cục `S\sound\opt_layout.png`.
