# Tự động đánh (bật/tắt) phía client — Phong Thần

> Ngày: 2026-10-03 · Agent: autofight · Phạm vi: client C++ (`CoreClient.dll`, `PhongThanClient.exe`). Server, Lua, PAK: không đổi.

## Phần 1: Tổng quan

- **Vấn đề:** client chưa có chức năng tự đánh và dừng tự đánh như auto của VNG. File phím tắt gốc của VNG `\Ui\autoexec.lua` đã gán sẵn ba phím: `Alt+A Switch([[leftautoai]])`, `Alt+S Switch([[rightautoai]])`, `Alt+D Switch([[rightlocalautoai]])`. Tuy vậy, hàm `Switch()` của client (`LuaSwitchStatus` trong `ShortcutKey.cpp`) không biết ba trạng thái này: `FindStatus()` trả về -1, nên bấm phím không có tác dụng gì.
- **Giải pháp:** viết một bộ tự động đánh gọn, chạy hoàn toàn ở client, và nối nó vào đúng ba phím VNG. Không cần sửa PAK, không cần sửa server.
- **Vì sao an toàn với server:** mọi hành động đi qua đúng các lệnh mà một cú click chuột tạo ra (`SendClientCmdSkill`, `SendClientCmdRun/Walk`, `ApplyUseItem`). Trước khi gửi, bộ auto kiểm tra `CanCast` (hồi chiêu) và `Cost` (nội lực) giống hệt `KPlayer::ProcessMouse`. Server vẫn kiểm tra như với người chơi click tay, không có gói tin mới.
- **Code TamLTM cũ:** trong mã nguồn đã có một bộ auto cũ (`KPlayerAI`, cửa sổ `KUiAutoPlay`). Bộ này phụ thuộc cửa sổ cấu hình `UiAutoPlay.ini`, nhưng file ini đó không có trong PAK, còn nút `[AutoPlay]` trong `UiPlayerBar.ini` có kích thước 0. Vì vậy không dùng lại bộ cũ. Khi bật auto mới, cờ `m_bIsActive` của bộ cũ bị tắt để không có hai "người lái" cùng lúc.

| Phím | Chế độ | Chiêu dùng | Di chuyển |
|---|---|---|---|
| **Alt+A** | Tự đánh bằng chiêu tay trái | Chiêu chuột trái (đánh thường) | Đuổi quái trong bán kính, không rời điểm bật quá 960 |
| **Alt+S** | Tự đánh bằng chiêu tay phải | Chiêu chuột phải. Nếu chiêu phải không dùng được (hồi chiêu, thiếu nội lực, là chiêu buff hoặc hào quang) thì dùng chiêu trái | Như Alt+A |
| **Alt+D** | Đứng tại chỗ | Như Alt+S | Không đuổi. Chỉ đánh quái trong tầm chiêu quanh điểm bật, rồi tự quay về điểm bật |

- Bấm lại **cùng phím** thì tắt. Bấm phím auto khác thì đổi chế độ. Mỗi lần bật/tắt, màn hình hiện dòng chữ TCVN3 ở giữa phía trên và trong khung tin hệ thống, ví dụ "Tự động đánh: BẬT (chiêu tay phải)" hoặc "Tự động đánh: TẮT - đã đổi bản đồ".

## Phần 2: Chi tiết

### 2.1 Vòng lặp (mỗi khung hình client, quyết định tối đa 10 lần/giây)

1. **Điều kiện dừng hẳn**, auto tắt và báo lý do:
   - đổi bản đồ (`SubWorld[0].m_SubWorldID` khác lúc bật): "đã đổi bản đồ";
   - nhân vật chết hoặc đang hồi sinh: "nhân vật bị trọng thương";
   - vào thành hoặc khu an toàn (`m_FightMode == 0`, tức trạng thái phi chiến đấu do server đặt): "đang ở khu vực an toàn";
   - server mở một hội thoại mới (`m_UiDialogToken` đổi sang giá trị khác 0): "đang mở hội thoại";
   - đang giao dịch: "đang giao dịch".
2. **Tạm dừng:** click hoặc kéo chuột trong thế giới game (`KPlayer::ProcessMouse`) làm auto tạm dừng 4 giây và hiện thông báo một lần. Sau đó auto chạy tiếp và lấy **vị trí mới** làm điểm bật. Như vậy người chơi có thể tự di chuyển sang bãi khác mà không bị kéo về chỗ cũ. Click trên giao diện (túi đồ, cửa sổ) không làm tạm dừng.
3. **Bình thuốc** (chỉ lấy từ thanh phím nhanh, ô `pos_immediacy`): máu dưới 50% thì dùng bình máu hoặc bình "cả hai", mana dưới 20% thì dùng bình mana hoặc "cả hai". Mỗi loại cách nhau ít nhất 2,5 giây. Người chơi tự quyết định bằng cách để hay không để bình ở thanh phím nhanh.
4. **Chỉ ra lệnh khi hành động trước đã xong:** nhân vật phải nhận lệnh được (`IsCanInput`) và đang đứng, đi, chạy hoặc ngồi, không ở giữa động tác đánh hay trúng đòn.
5. **Chọn mục tiêu:** quái gần nhân vật nhất trong bán kính 640 và cách điểm bật không quá 960 (Alt+D: tầm chiêu + 32). Quái hợp lệ phải đủ các điều kiện:
   - `m_Kind == kind_normal`, tức không phải người chơi, không phải NPC hội thoại;
   - đang sống, không tàng hình, `m_CurrentLifeMax > 0`;
   - quan hệ `relation_enemy` với nhân vật;
   - không phải bot giả (template 2703–2720), không phải pet có chủ (`m_nOwnerIdx > 0`), không phải NPC chỉ có ở client.
6. **Tấn công:**
   - Trong tầm chiêu: gửi `do_skill` + `SendClientCmdSkill`, giống click chuột phải lên quái. Chiêu đánh vào điểm thì gửi theo tọa độ của quái. Hai lệnh chiêu cách nhau ít nhất 200 ms.
   - Ngoài tầm: chạy hoặc đi tới quái. Lệnh di chuyển cách nhau ít nhất 400 ms, đồng thời phải qua giới hạn `defMAX_PLAYER_SEND_MOVE_FRAME` của client. Không gửi lại lệnh nếu nhân vật đang trên đường tới cùng điểm đó.
7. **Quái chết** thì chọn con kế tiếp. **Hết quái** thì quay về điểm bật.
8. **Chống kẹt:** đuổi một con quá 6 giây mà chưa tới tầm (vướng tường, quái chạy), hoặc máu quái không đổi trong 15 giây (đánh không trúng, quái miễn nhiễm), thì bỏ qua con đó 20 giây và tìm con khác.

### 2.2 Tệp và điểm móc

| Hunk | Tệp | Nội dung |
|---|---|---|
| H0 | `Core\Src\PhongThanAutoFight.inl` (mới, ASCII) | Toàn bộ logic, chỉ build cho client |
| H1 | `Core\Src\KPlayerAI.cpp`, đầu `KPlayerAI::Active()` | `PTAutoFight_Tick()` (được `KPlayer::Active()` gọi mỗi khung hình client) |
| H5 | `Core\Src\KPlayerAI.cpp`, cuối tệp | `#include "PhongThanAutoFight.inl"`, không phải thêm tệp vào `Core.dsp` |
| H2 | `Core\Src\KPlayer.cpp`, đầu `ProcessMouse()` | `PTAutoFight_OnManualInput()` để tạm dừng khi click tay |
| H3 | `Core\Src\CoreShell.cpp`, đầu `PAIOperation()` | Mã riêng `0x50544146` ('PTAF') gọi `PTAutoFight_Operation(chế độ)`, không đổi `CoreShell.h` |
| H4 | `GameClient\Ui\ShortcutKey.cpp`, trong `LuaSwitchStatus()` | `leftautoai`=1, `rightautoai`=2, `rightlocalautoai`=3 |

- Bản vá chính xác: `scratchpad\autofight\cpp_patch.md`. Applier: `scratchpad\autofight\apply_patch.py`:
  - sửa ở mức byte, an toàn với GBK/TCVN3;
  - kiểm tra toàn bộ neo trước khi ghi, ghi tất cả hoặc không ghi gì;
  - idempotent, chạy lại không áp trùng;
  - có `--dry-run` và `--status`;
  - backup vào `_backup\<YYYYMMDD>-autofight\`.
- Không trùng vùng sửa của questtrack. Questtrack sửa trong `ShortcutKey.cpp` các phần include, `HandleKeyInput` (Alt+N), bảng cửa sổ id 22 `tasktrace` và switch `Open()`. H4 chỉ chèn trước `switch (FindStatus(strStatus))` của `LuaSwitchStatus`. Phím Alt+A/S/D không trùng Alt+N.

### 2.3 Kết quả build trên bản sao

| Lần | Cây nguồn | CoreClient | GameClient |
|---|---|---|---|
| 1 | Bản sao lúc 17:43 + bản vá | OK, 0 lỗi | OK, 0 lỗi |
| 2 | Bản sao + 9 tệp questtrack hiện tại + bản vá (H4 áp lên bản của questtrack) | OK, 0 lỗi | OK, 0 lỗi (build lại toàn bộ, có `UiTaskTrace.cpp`) |

- Lệnh build: bản sao của `Build-Modern.ps1 -Targets 'CoreClient','GameClient'`, chạy trên `scratchpad\autofight\tree`.
- Cây thật chưa bị sửa. `--dry-run` trên cây thật hiện tại: mọi hunk ở trạng thái "apply", không có lỗi neo.

### 2.4 Rủi ro và giới hạn

| Rủi ro | Mức | Ghi chú |
|---|---|---|
| Đây là "bot" chạy ở client | Trung bình | Đúng chủ đích (auto như VNG). Server không phân biệt được với click tay. Nếu muốn cấm ở map nào, đặt map đó là khu phi chiến đấu (auto tự tắt) |
| Kẹt địa hình | Thấp | Không có tìm đường. Bỏ qua quái sau 6 giây đuổi không tới |
| Xe tiêu, NPC nhiệm vụ phe địch | Thấp | Nếu server cho quan hệ `enemy` với một NPC `kind_normal` (ví dụ xe tiêu của người khác khi bật PK) thì auto có thể đánh. Bot giả 2703–2720 đã được loại trừ |
| Chiêu cần cưỡi ngựa hoặc xuống ngựa | Thấp | Không tự lên/xuống ngựa. Server từ chối thì chỉ mất một nhịp, auto thử lại sau 200 ms |
| Hội thoại client-only (không qua server) | Thấp | Không làm auto dừng. Click chuột vào NPC đã làm auto tạm dừng 4 giây |
| Bình thuốc | Thấp | Chỉ dùng bình ở thanh phím nhanh, ngưỡng cố định 50%/20%, chưa có giao diện chỉnh |
| Chưa có nút bấm trên giao diện | — | Nút `[AutoPlay]` có sẵn trong `UiPlayerBar.ini` nhưng kích thước 0 và chưa có sprite. Hiện chỉ dùng phím tắt |

## Phần 3: Hành động

### 3.1 Áp dụng (coordinator)

- [ ] `python scratchpad\autofight\apply_patch.py --dry-run`: kiểm tra mọi hunk báo "apply" hoặc "present", không có "ANCHOR ERROR".
- [ ] `python scratchpad\autofight\apply_patch.py`: áp bản vá, tự động backup vào `_backup\<ngày>-autofight\`.
- [ ] Build: `powershell -Command "& 'E:\VL\Phong than\PT\PhongThanSource\Build\Build-Modern.ps1' -Targets 'CoreClient','GameClient'"`.
- [ ] Chép `CoreClient.dll` và `Game.exe` mới sang client theo quy trình triển khai thường lệ. Không cần khởi động lại server.

### 3.2 Kiểm thử trong game (người chơi)

- [ ] Ra bãi quái (ví dụ ngoại thành), bấm **Alt+S**: hiện "Tự động đánh: BẬT (chiêu tay phải)". Nhân vật tự chạy tới con gần nhất và đánh bằng chiêu phải.
- [ ] Quái chết thì nhân vật tự chuyển sang con kế tiếp. Hết quái thì nhân vật quay về chỗ vừa bật.
- [ ] Bấm **Alt+S** lần nữa: hiện "Tự động đánh: TẮT", nhân vật dừng.
- [ ] **Alt+A**: đánh bằng chiêu trái. **Alt+D**: đứng yên, chỉ đánh quái lại gần.
- [ ] Đặt chiêu phải là chiêu buff: Alt+S vẫn đánh bằng chiêu trái.
- [ ] Hết nội lực: chuyển sang chiêu trái. Có bình mana ở thanh phím nhanh thì tự uống khi mana dưới 20%.
- [ ] Để bình máu ở thanh phím nhanh, để quái đánh tới dưới 50% máu: nhân vật tự uống, mỗi 2,5 giây tối đa một bình.
- [ ] Click chuột xuống đất khi auto đang chạy: hiện "tạm dừng". Nhân vật đi theo click, khoảng 4 giây sau tiếp tục đánh tại chỗ mới.
- [ ] Click vào NPC hội thoại: auto dừng, báo "đang mở hội thoại".
- [ ] Chạy vào thành: auto tắt, báo "đang ở khu vực an toàn". Bấm Alt+S trong thành: báo "Không thể tự động đánh trong khu vực an toàn."
- [ ] Đi qua cổng sang bản đồ khác: auto tắt, báo "đã đổi bản đồ". Nếu lúc chuyển bản đồ client tạm không có nhân vật thì chỉ báo "Tự động đánh: TẮT". Dùng thổ địa phù về thành: auto cũng tắt.
- [ ] Để nhân vật chết khi đang auto: auto tắt, báo "nhân vật bị trọng thương".
- [ ] Bật auto ở chỗ không có quái: không lỗi, nhân vật đứng yên tại chỗ.
- [ ] Đứng cạnh bot giả (người chơi ảo): auto không đánh bot.
- [ ] Alt+N (bảng theo dõi nhiệm vụ của questtrack) vẫn hoạt động bình thường.

## Phần 4: Tài liệu tham khảo

- Bản vá: `scratchpad\autofight\cpp_patch.md`. Applier: `scratchpad\autofight\apply_patch.py`. Mã nguồn tệp mới: `scratchpad\autofight\payload\PhongThanAutoFight.inl`.
- Cây build thử: `scratchpad\autofight\tree\PhongThanSource`, log ở `Build\LogsModern\CoreClient.log` và `GameClient.log`.
- Phím tắt VNG: `\Ui\autoexec.lua` (`vng00.pak`, giống hệt `PhongThanRuntime-Staging\Client\Ui\autoexec.lua`).
- Liên quan:
  - `docs\features\bot-gia-nguoi-choi-phong-than-20261002.md` (template bot 2703–2720);
  - `docs\features\khung-theo-doi-nhiem-vu-phong-than-20261003.md` (questtrack, Alt+N).
- Bước tiếp theo (tùy chọn):
  - nút bật/tắt trên thanh công cụ (cần sprite và ô `[AutoPlay]` trong `UiPlayerBar.ini`);
  - cửa sổ chỉnh bán kính và ngưỡng bình thuốc;
  - tự nhặt đồ.
