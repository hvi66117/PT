# Mở rương chứa đồ 2, 3, 4, 5 cho nhân vật (Thủ Khố + web admin)

## Phần 1: Tổng quan

- **Yêu cầu (2026-10-03):** "Thêm cả mở rương 2,3,4,5 của nhân vật + webadmin."
- **Hiện trạng:** engine đã có đủ rương mở rộng; chỉ thiếu chỗ để mở.
  - Rương 1 = "Rương chứa đồ" (`pos_repositoryroom`).
  - Rương 2–5 = các trang "Rương mở rộng 1–4" (`pos_repositoryroom1..4`). Engine còn trang thứ 5 (`pos_repositoryroom5`), tài liệu này gọi là Rương 6.
- **Nguyên nhân chưa dùng được:** số trang đã mở (`KPlayer::m_btRepositoryNum`, trường `ExtraBox` trong file nhân vật) của mọi nhân vật thật đều là 0.
  - Có native `GetExpandBox` / `SetExpandBox` nhưng không script nào gọi.
  - Trang chưa mở bị tô mờ; server từ chối cất đồ vào trang đó.
- **Đã làm:**
  - Thủ Khố (3 thành) có dòng mới **"Mở rộng rương (Rương 2-5)"**.
  - Web admin có mục **"Rương chứa đồ mở rộng"**: online thì áp qua admin bridge, offline thì sửa thẳng file nhân vật.
  - Không cần sửa C++, không cần ptfix.
- **Cách VNG làm:** VNG cho thuê Rương 2–5 bằng Tiền Đồng, có thời hạn 7 hoặc 30 ngày (script `RentStoreBox`, `GetCoin`, task 770, nút "Thuê" trong khung rương).
  - Engine này không có `RentStoreBox` / `GetCoin` và file nhân vật không lưu hạn dùng.
  - Vì vậy áp dụng phương án dự phòng: **mở thẳng, vĩnh viễn, miễn phí**.

## Phần 2: Chi tiết

### 2.1 Kiểm tra engine (đọc mã)

| Thành phần | Vị trí | Tình trạng |
|---|---|---|
| Vị trí vật phẩm | `GameDataDef.h` `pos_repositoryroom`, `pos_repositoryroom1..5`; `room_repository1..5` 6x10 | Có |
| Đặt / lấy / đổi chỗ đồ | `KItemList.cpp` `Add`, `Remove`, `ExchangeItem` (case `pos_repositoryroom1..5`) | Có. Chặn đặt đồ khi `m_btRepositoryNum <= REPOSITORY_n`; lấy ra thì vẫn được. Chặn khi đang chiến đấu. |
| Native Lua | `ScriptFuns.cpp` `GetExpandBox`, `SetExpandBox` → `KPlayer::SetExpandBoxNum` | Có. Gửi `PHONGTHAN_PLAYER_BANK_PAGES` xuống client. |
| Đồng bộ khi đăng nhập | `KPlayer.cpp` `sSync.BankPages` | Có |
| Lưu và nạp | `KPlayerDBFuns.cpp`: nạp `m_btRepositoryNum = pState->ExtraBox`; lưu `pState->ExtraBox = m_btRepositoryNum`; vật phẩm lưu `Container = nPlace` (6..10) và nạp lại bằng `m_ItemList.Add(..., Container, x, y)` | Có |
| File nhân vật | `CharacterStore\role_<hex>.pthc`: header 16 byte (magic `PHTC`, version 1, kích thước, checksum FNV-1a), sau đó là `PHONGTHAN_CHARACTER_STATE_HEADER`. `ExtraBox` ở byte 90 của state. Goddess đọc lại file mỗi lần đăng nhập, không cache. | Có |
| Client | `UiStoreBox.cpp`: 6 trang (Rương chứa đồ, Rương mở rộng 1–5); nút trái/phải (`UiStoreBox.ini` LeftBtn/RightBtn); trang `>= GDI_EXBOX_NUM` bị tô mờ | Có, đã có trong `Game.exe` đang dùng |
| Chỗ mở rương | Không script nào gọi `SetExpandBox`; Thủ Khố chỉ có "Mở rương chứa đồ" (`OpenBox(2)`) | **Thiếu → đã thêm** |

Dữ liệu thật (đọc file nhân vật, không sửa):

- `ExtraBox = 0` ở mọi nhân vật chơi thật: EmLaAi, EmlaAi1, EmLaAi2, KyUc1Thoi, 1111111111…
- Chỉ 3 nhân vật test có `ExtraBox = 5`, do công cụ cũ `Tests\Native\UnlockTestStorage.cpp` đặt.
- Chưa nhân vật nào có đồ trong container 6..10.

### 2.2 Thủ Khố

| Bước | Hiển thị |
|---|---|
| Nói chuyện Thủ Khố (Triều Ca 1002, Ngọc Hư 1003, Xi Vưu 1004) | Menu cũ, thêm dòng **"Mở rộng rương (Rương 2-5)"** ngay trước "Kết thúc đối thoại" |
| Chọn dòng đó | Câu hiện trạng: "đã mở đến Rương N"; các nút: **Mở Rương N+1**, **Mở hết Rương 2 - 5** (khi còn từ 2 rương), **Xem rương chứa đồ**, Kết thúc |
| Mở | `SetExpandBox(n+1)` (hoặc 4). Kiểm tra lại bằng `GetExpandBox`, báo tin, rồi mở khung rương (`SetFightState(0)` + `OpenBox(2)`). |
| Trong khung rương | Bấm mũi tên phải để sang "Rương mở rộng 1" (= Rương 2), "Rương mở rộng 2" (= Rương 3)… |

Quy tắc:

- Dòng mới nằm **trước** dòng kết thúc, nên `tasks[2]`, `tasks[3]`, `tasks[4]` (nhiệm vụ Thủ Khố) giữ nguyên chỉ số. Mô phỏng đã so khớp với bản trước khi sửa.
- Trong game chỉ mở đến Rương 5 (`PTRUONG_MAX = 4`), giống 5 tab của VNG. Rương 6 chỉ mở bằng web admin.
- Không bao giờ giảm số rương đã mở. Nếu admin đã mở Rương 6 thì Thủ Khố giữ nguyên.

File:

- `Server\script\phongthan\npc_fix\ruong_mo_rong.lua` (mới, TCVN3). Toàn bộ tên toàn cục có tiền tố `PTRUONG_`.
  - Sinh bằng `scratchpad\ruong\mk_ruong.py`.
- `npc_fix\1002_thu_kho.lua`, `1003_thu_kho.lua`, `1004_thu_kho.lua`. Sửa ở mức byte bằng `scratchpad\ruong\patch_thukho.py`:
  - thêm `Include` ở đầu file;
  - thêm 1 dòng menu;
  - thêm hàm `mo_rong_ruong()` ở cuối file.

### 2.3 Web admin

Tab **Phát đồ** → khung "2. Phát cho người chơi" → mục **"Rương chứa đồ mở rộng (Rương 2–5)"**:

- Nhập tên nhân vật ở ô "Tên nhân vật" phía trên.
- Chọn **Mở đến rương**: 2, 3, 4, 5 (mặc định, mở hết) hoặc 6 (trang thêm của engine).
- **Mở rương cho nhân vật trên**:
  - **Online** (có trong `admin_bridge\online.txt`): xếp lệnh bridge `SetExpandBox(k-1)` nếu số hiện tại nhỏ hơn. Server chạy trong tối đa 1 phút và nhắn cho người chơi.
  - **Offline**: sửa ngay byte `ExtraBox` trong `CharacterStore\role_<hex>.pthc`, tính lại checksum, ghi qua file tạm + `File.Replace`.
    - Bản cũ được lưu vào `AdminWeb\data\chest_backup\role_<hex>.pthc.<thời gian>`.
    - Kiểm tra magic, version, kích thước, checksum và tên trước khi ghi.
    - Lệnh bridge vẫn được xếp: nếu thực ra nhân vật đang trong game thì vẫn áp vào bộ nhớ.
  - Kết quả hiện ở tab Lịch sử: OK hoặc FAIL kèm lý do. Ví dụ FAIL "khong co file nhan vat"; "luc xep lenh dang online nhung khi chay da thoat: bam lai de sua file".
- **Xem số rương đã mở**: đọc file và hỏi server (nếu online).
- Không bao giờ giảm số rương đã mở.

Mã:

- `PhongThan-Admin.ps1`:
  - các hàm `Get-ChestPath`, `Get-ChestFnv`, `Read-ChestFile`, `Set-ChestFile`;
  - action `chest` (tham số `player`, `to` 2..6, `info`). File vẫn chỉ có ký tự ASCII.
- `index.html`: khối HTML và 2 nút `btnChest`, `btnChestInfo`.

### 2.4 Lưu khi đăng xuất / đăng nhập (đọc mã + mô phỏng)

- **Số rương:** `SetExpandBox` ghi `m_btRepositoryNum` → lần lưu kế tiếp (định kỳ hoặc khi thoát) ghi `ExtraBox` → đăng nhập nạp lại → gửi `BankPages` xuống client.
- **Đồ trong Rương 2–6:** mỗi món lưu `Container = 6..10` cùng toạ độ. Khi nạp, `KItemList::Add` có case cho `pos_repositoryroom1..5`, đặt món đồ vào đúng `room_repository1..5`.
- Chưa kiểm thử trong game: đến giờ chưa nhân vật nào có đồ trong container 6..10. Xem checklist ở Phần 3.
- Mô phỏng ghi file offline trên bản sao: chỉ byte 106 (ExtraBox) và 4 byte checksum đổi; Python kiểm lại checksum FNV-1a khớp.

### 2.5 Kết quả kiểm thử

| Kiểm thử | Kết quả |
|---|---|
| `qtest\sim_ruong.lua`, `run.ps1 -Stack 100` | 57 ok, FAILS=0 |
| `sim_ruong.lua` chế độ EMU (`-Stack 0 -Args1 EMU`, đệm 47 frame như NPC thật) | 57 ok, FAILS=0, headroom tối thiểu 44 frame |
| Menu chính 3 Thủ Khố × 3 trạng thái nhiệm vụ: các dòng cũ khớp bản gốc, dòng mới đứng trước dòng kết thúc | ok |
| `ruong\test_chest.ps1`: hàm sửa file trên bản sao EmLaAi/TestDaoSy (đặt, không giảm, khác hoa thường, thiếu file, checksum hỏng, backup, không để file tạm) | FAILS=0 |
| `ruong\test_admin_chest.ps1`: chạy **đúng** action `chest` trích từ `PhongThan-Admin.ps1` (online/offline/info/clamp) | FAILS=0 |
| `qtest\sim_ruong_bridge.lua`: biên dịch và chạy 6 lệnh bridge do admin sinh ra (online, offline, đã thoát, không đổi, engine từ chối) | FAILS=0 |
| Bridge chẩn đoán chỉ đọc trên server đang chạy (KyUc1Thoi) | `GetExpandBox=0`, native có đủ (mục 2.6) |
| Parser PowerShell trên `PhongThan-Admin.ps1` sau khi sửa | 0 lỗi |

### 2.6 Chẩn đoán trên server đang chạy

Lệnh chỉ đọc `ruongdiag1` (ghi vào `admin_bridge\pending.lua` khi file chưa tồn tại): đọc `GetExpandBox()` của KyUc1Thoi và kiểm tra `SetExpandBox` / `OpenBox` có tồn tại.

Kết quả trong `admin_bridge\result.log`:

```
2026-10-03 20:35:00	ruongdiag1	OK	KyUc1Thoi GetExpandBox=0 SetExpandBox=function OpenBox=function
```

Kết luận: server đang chạy có đủ native. Nhân vật thật hiện mở 0 trang mở rộng. Lệnh này không thay đổi gì.

## Phần 3: Hành động

### Triển khai

- [ ] **Script Thủ Khố:** cần nạp lại 3 file Thủ Khố, chọn một trong hai cách:
  - Khởi động lại server.
  - Hoặc nạp nóng qua admin bridge (coordinator):
    ```lua
    ReLoadScript("\\script\\phongthan\\npc_fix\\1002_thu_kho.lua")
    ReLoadScript("\\script\\phongthan\\npc_fix\\1003_thu_kho.lua")
    ReLoadScript("\\script\\phongthan\\npc_fix\\1004_thu_kho.lua")
    PTAdm_Log("ruongreload", "OK", "thu kho reloaded")
    ```
    `ruong_mo_rong.lua` được Include nên không cần đăng ký riêng.
- [ ] **Web admin:** đóng cửa sổ web admin, mở lại bằng launcher thường dùng (Claude không tự khởi động lại), rồi F5 trình duyệt.
- [ ] **C++, client, ptfix:** không cần. Không đổi DLL, EXE hay PAK.

### Checklist kiểm thử trong game

- [ ] Thủ Khố → "Mở rộng rương (Rương 2-5)" → "Mở Rương 2" → khung rương mở. Bấm mũi tên phải: trang "Rương mở rộng 1" không còn tô mờ.
- [ ] Kéo vài món vào "Rương mở rộng 1" (Rương 2). Chuyển trang qua lại, đồ vẫn còn.
- [ ] Thoát game hẳn, đăng nhập lại → Thủ Khố → "Mở rương chứa đồ" → mũi tên phải: đồ vẫn ở Rương 2. Thủ Khố báo "đã mở đến Rương 2".
- [ ] "Mở hết Rương 2 - 5" → 4 trang mở rộng đầu đều dùng được; trang 5 (Rương 6) vẫn tô mờ.
- [ ] Web admin, nhân vật online: chọn Rương 6 → Lịch sử OK sau ≤ 1 phút; trang "Rương mở rộng 5" dùng được (chuyển trang để làm mới).
- [ ] Web admin, nhân vật offline: chọn Rương 5 → Lịch sử báo "file ruong 1 -> 5"; đăng nhập kiểm tra.
- [ ] Các dòng cũ của Thủ Khố (Thu thập, Sử dụng Thủ khố, Hộp gấm, Nguyên liệu) vẫn hiện đúng như trước.

### Tuỳ chọn (chưa làm)

- Đổi chữ trên khung rương thành "Rương 1 … Rương 6" cho khớp tên gọi. Cần sửa `UiStoreBox.cpp`, build GameClient và triển khai client. Hiện lời thoại giải thích "Rương 2 = Rương mở rộng 1".
- Thuê rương có thời hạn kiểu VNG. Cần thêm trường hạn dùng vào file nhân vật (C++). Không cần cho bản chơi một mình.

## Phần 4: Tài liệu tham khảo

- Mã engine:
  - `PhongThanSource\Sources\Core\Src\KItemList.cpp`, `KPlayer.cpp` (`SetExpandBoxNum`), `KPlayerDBFuns.cpp` (`ExtraBox`), `ScriptFuns.cpp` (`LuaGetExpandBox` / `LuaSetExpandBox` / `LuaOpenBox`);
  - `GameClient\Ui\UiCase\UiStoreBox.cpp`;
  - `Headers\PhongThanCharacter.h`, `MultiServer\Goddess\PhongThanCharacterStore.cpp`.
- Script VNG thuê rương (tham khảo, không chạy được ở engine này): PAK `7d8aefec.lua` (`RentStoreBox`). Giao diện VNG `\ui\ui3\储物箱.ini` (BtnPage_0..4, BtnRent).
- Sao lưu: `_backup\20261003-ruong\` (3 file Thủ Khố, `PhongThan-Admin.ps1`, `index.html`, `CHANGELOG.md`, `README.md`).
- Công cụ: `scratchpad\ruong\` (`mk_ruong.py`, `patch_thukho.py`, `patch_admin.py`, `chest_block.ps1`, `chest_action.ps1`, `test_chest.ps1`, `test_admin_chest.ps1`); `scratchpad\qtest\sim_ruong.lua`, `sim_ruong_bridge.lua`.
- Liên quan: `web-admin-quan-tri-phong-than-20260928.md`, `taphoa-npcnames-phong-than-20261003.md` (lỗi lệch `tasks[N]` khi chèn dòng lên đầu).
