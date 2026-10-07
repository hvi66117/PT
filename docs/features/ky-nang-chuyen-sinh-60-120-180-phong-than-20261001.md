# Kỹ năng chuyển sinh 60 / 120 / 180 cho 3 phái

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-01
> Trạng thái: **Đã làm.** Sách kỹ năng và lệnh dạy qua web admin đã nạp nóng (09:13). Chỉ số kỹ năng nằm trong **ptfix v9**, có tác dụng sau khi khởi động lại server, game và web admin.
> Người dùng chọn: trọn bộ 60/120/180 · chỉ số tương đương bằng Lua · thêm Sách kỹ năng.

## Phần 1: Tổng quan
- **"Kỹ năng 180" của VNG** là bộ kỹ năng chuyển sinh, mỗi phái 3 bậc (nguồn: `vng00.pak` `\settings\skills.txt` dòng 1221–1229, `\settings\item\001\skillbook.txt` dòng 61–69):

| Phái | Lv.60 | Lv.120 | Lv.180 |
|---|---|---|---|
| Giáp Sĩ | 1481 Huyết Chiến Sa Trường | 1482 Dĩ Chiến Dưỡng Chiến | 1483 Bách Chiến Dư Sinh |
| Đạo Sĩ | 1484 Nghiệp Hỏa Phần Tâm | 1485 Hạo Nhiên Chính Khí | 1486 Dẫn Hỏa Thiêu Thân |
| Dị Nhân | 1487 Độc Hành Thiên Hạ | 1488 Cổ Hoặc Chúng Sinh (chủ động) | 1489 Vạn Độc Hộ Thân (chủ động) |

- **Vì sao trước đây không có:**
  - Server lẫn client đều thiếu script chỉ số `\script\skill\zhuansheng\*.lua`, nên kỹ năng nạp lên mà không có thuộc tính nào.
  - Nhiều thuộc tính gốc của VNG (`magic_modify_pkrate`, `ignorephysicsresist`, `magic_immunity_*`, `enhance_*`) chưa có handler trong engine.
  - Web admin chỉ cho dạy các mã kỹ năng phái 3–51.
- **Cách làm:**
  - Viết script chỉ số mới.
  - Đổi cột LvlSetting của 9 dòng sang thuộc tính tương đương mà engine đã xử lý.
  - Thêm 9 sách kỹ năng.
  - Mở web admin cho dạy và phát sách.

## Phần 2: Chi tiết

### 2.1 Chỉ số (cấp L = 1..10)
| Mã | Thuộc tính | Cấp 10 |
|---|---|---|
| 1481 | tốc đánh +2L, sát thương vật lý +3L%, sinh lực tối đa +L% | +20, +30%, +10% |
| 1482 | hút máu L%, tăng hiệu quả hút máu 2L%, hồi sinh lực 3L | 10%, 20%, 30 |
| 1483 | bỏ qua phòng thủ 2L%, tăng chí mạng 2L%, kháng tất cả +2L% | 20%, 20%, 20% |
| 1484 | tốc độ xuất chiêu +2L, sát thương phép +3L%, nội lực tối đa +L% | +20, +30%, +10% |
| 1485 | phản đòn cận chiến 2L%, sát thương chuyển thành nội lực 2L%, kháng tất cả +L% | 20%, 20%, 10% |
| 1486 | bỏ qua kháng hỏa/băng/lôi/thổ 2L%, sát thương phép +2L% | 20% mỗi hệ, +20% |
| 1487 | tốc đánh +2L, sát thương độc +3L%, sinh lực tối đa +L% | +20, +30%, +10% |
| 1488 | trạng thái 3 phút: tăng trí mạng 2L%, tốc chạy +2L%; tốn 50+10L nội lực | 20%, 20%; 150 |
| 1489 | trạng thái 3 phút: giảm thời gian trúng độc và choáng 5L%, kháng độc +3L%, kháng tất cả +2L%; tốn 80+10L nội lực | 50%, 30%, 20%; 180 |

- 1481–1487 là kỹ năng bị động, học xong có tác dụng ngay. 1488 và 1489 là kỹ năng hỗ trợ chủ động, gán vào phím chuột phải để dùng.
- Phát hiện thêm: `damagetomana_p` (thuộc tính gốc VNG của 1485) thật ra có handler, vì engine đặt alias `magic_damage2addmana_p = magic_damagetomana_p`.

### 2.2 Tệp và dữ liệu
- **`scratchpad\skill180\gen_skill180.py`** sinh:
  - 9 script chỉ số (hàm `GetSkillLevelData`, trả về `"giá trị,thời gian,0"`, thời gian −1 nghĩa là bị động);
  - 9 script sách `Server\script\phongthan\item\sach_kn_<mã>.lua`;
  - `skill180_ptfix.json`.
- **`build_ptfix.py`** (bản cũ lưu ở `.v8`):
  - nhét 9 script chỉ số vào PAK (tên file GBK, engine tìm theo hash);
  - sửa 9 dòng `skills.txt` của `vng00.pak`;
  - thêm 9 dòng magicscript 61011–61019 (sách, xếp chồng 1, vĩnh viễn).
  - Kết quả: ptfix v9 (384 mục). Bản đang chờ cài là **v10** (390 mục, hash 78C2BD6B…, có thêm bản sửa giá sửa đồ), đặt ở `AdminWeb\pending\ptfix.pak`.
- **Bản loose với tên GBK không dùng được:** trên Windows tiếng Việt, đường dẫn byte GBK không khớp tên file Unicode. Vì vậy chỉ số phải nằm trong ptfix. Các bản loose đã tạo trong `script\skill\zhuansheng\` vô hại, có thể xóa tay.
- **Sách kỹ năng** (`sach_kn_<mã>.lua`):
  - kiểm tra đúng phái, cấp ≥ 60/120/180, kỹ năng chưa đạt cấp 10;
  - chưa học thì học cấp 1, đã học thì nâng thêm 1 cấp;
  - đọc lại cấp kỹ năng để xác nhận, rồi mới `RemoveItem(nItemIdx, 1, 0)` để mất 1 cuốn.
- **Web admin:**
  - `PhongThan-Admin.ps1`:
    - danh sách `$RebirthSkills` gắn bậc (`tier`);
    - lệnh `skills` cho phép thêm các mã của phái;
    - mã vật phẩm `SkillBook1481..1489`;
    - lệnh "level" giữ lại kỹ năng 1478–1489 (trước đây chỉ giữ 1–60).
  - `index.html`: nhóm "Kỹ năng chuyển sinh 60 / 120 / 180" ở đầu danh sách, nút phát sách theo phái và ô chọn số cuốn.

### 2.3 Kiểm tra
- Mô phỏng Lua 4, sách 1489:
  - sai phái: từ chối;
  - cấp 100: từ chối;
  - cấp 180: học cấp 1, rồi nâng lên 2, mỗi lần mất 1 cuốn;
  - đã cấp 10: báo tối đa.
- Script chỉ số 1489: `poisonres_p` cấp 10 = `30,3240,0`, `skill_cost_v` cấp 3 = `110,0,0`.
- Build ptfix: `skill180 rows=9 scripts=9`, magicscript +61011..61019.
- `PhongThan-Admin.ps1`: 0 lỗi cú pháp. JavaScript của `index.html`: `node --check` đạt.

### 2.3b Báo lỗi "click sách không thấy gì" (13:10)
- Log `item_action_diag.log` cho thấy `sach_kn_1481`/`1483` đều chạy (`ExecuteScript_RESULT = 1`).
- Kết quả chỉ in bằng dòng chat `Msg2Player`, nên người chơi không thấy. EmLaAi là Giáp Sĩ cấp 120, đã có 1481–1483 cấp 10 (web admin lúc 13:09); sách 1483 cần cấp 180.
- Sửa: kết quả hiện bằng hộp thoại và ghi vào `admin_bridge\token.log`.

### 2.4 Giới hạn
- Cửa sổ kỹ năng của client viết cứng số ô: Giáp Sĩ và Đạo Sĩ đã kín ô, nên kỹ năng mới không hiện ở đó. Bị động vẫn có tác dụng. Muốn hiện ô thì phải sửa giao diện client.
- `RollBackSkills` (tẩy điểm kỹ năng) đưa các kỹ năng này về 0; khi đó dạy lại bằng web admin.
- Chỉ số đúng hệt VNG (sát thương PK, miễn khống chế) cần C++.

## Phần 3: Hành động
- [ ] Tắt server, thoát game, đóng web admin, chạy `PhongThan-ChayTatCa.cmd game` để cài ptfix v9.
- [ ] Web admin → "Bí kíp / Kỹ năng" → chọn phái → tích nhóm "Kỹ năng chuyển sinh" → dạy cấp 10. Hoặc phát sách rồi click phải trong game.
- [ ] Kiểm tra F3: tốc đánh, kháng tăng đúng bảng 2.1.

## Phần 4: Tài liệu tham khảo
- `KSkills.cpp` (`LoadSkillLevelData` 2333, `ParseString2MagicAttrib` 2653), `KNpcAttribModify.cpp`, `KMagicAttrib.h`, `ScriptFuns.cpp` (`LuaAddMagic` 3533).
- `scratchpad\skill180\skill180.json` (bảng nghiên cứu), `web-admin-quan-tri-phong-than-20260928.md`.
