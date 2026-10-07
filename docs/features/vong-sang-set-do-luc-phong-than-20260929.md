# Vòng sáng kích hoạt khi mặc đủ set đồ lục

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-29 · Trạng thái: **Đã chẩn đoán. Cần build lại C++ để làm đúng**; có phương án tạm bằng Lua, đang chờ chủ server chọn.

## Phần 1: Tổng quan
- **Chỉ số set vẫn được cộng.**
  - `KItemList::GetGoldEquipEnhance` (KItemList.cpp:1514-1553) đếm các món cùng set id (cột 69). Từ 3 món trở lên set mới có hiệu lực.
  - `ReCalcEquip` mở thêm các dòng thuộc tính set.
  - Đồ lục phát từ web admin cùng một set id, nên đủ điều kiện.
- **Vòng sáng không hiện vì phần này chưa được viết trong mã nguồn dựng lại:**
  - Hàm `IsEnoughToActive()` (KItemList.cpp:4665) không được gọi ở đâu.
  - Không có đoạn mã nào gắn hiệu ứng trạng thái khi đủ set.
- **Tài nguyên hình đã có sẵn ở client:** `\settings\npcres\状态图形对照表.txt` có state 26–28 `circle-perfect1..3` (hiệu ứng set) và state 35–38 `equipeffect3/5` (hiệu ứng set 3 món / 5 món, nam/nữ).

## Phần 2: Các phương án
| Phương án | Cách làm | Ưu | Nhược |
|---|---|---|---|
| A. Build lại C++ (chuẩn) | Cuối `KPlayer::ReCalcEquip`: đếm set, thêm hoặc xóa `KStateNode` tạm (state 26–28 hoặc 35–38), rồi gọi `UpdateNpcStateInfo()` | Đúng như VNG: bật hoặc tắt ngay khi mặc hoặc tháo | Cần cài Visual C++ 6 |
| B. Tạm bằng Lua | Mỗi phút, cầu nối kiểm tra người chơi online có mặc đủ 5 món cùng set không (`IsEquipItem` theo danh sách món mỗi set, dựng từ bảng đồ). Nếu đủ thì `SetRankEx(tên, màu, 26, thời hạn)` | Không cần build lại | Trễ tối đa 1 phút; **đè lên danh hiệu**; tháo đồ phải chờ lần kiểm tra sau mới tắt |

- Việc chọn state nào cho cấp set nào là suy luận, vì không có dữ liệu gốc VNG để đối chiếu.

## Phần 2b: Đã chọn phương án A (2026-09-29): mã nguồn đã viết, chờ build
- **`Core\Src\KPlayer.cpp`:** thêm `PhongThanUpdateSetAura()` (chỉ phía server, `#ifdef _SERVER`), gọi ở cuối `KPlayer::ReCalcEquip()`.
  - Đếm số món nhiều nhất của cùng một set đang mặc (cùng Group + SetID).
  - 3–4 món → state graphics **26**; từ 5 món trở lên → **27**.
  - Thêm hoặc cập nhật một `KStateNode` tạm (không thuộc tính, `m_LeftTime = -1`), xóa node khi tháo đồ, rồi gọi `UpdateNpcStateInfo()`. Client tự vẽ theo `状态图形对照表.txt`.
- **Cùng lượt build còn có:**
  - `KItemList.cpp`: `UseItem` và `NowEatItem` nhận chỉ số người chơi 0 ở client. Đây là sửa gốc của bản vá byte dùng thuốc.
  - `UiTrade.cpp`: kiểm tra NULL trước khi đọc tên đối phương (tránh crash khi giao dịch).
- **Bản sao lưu mã nguồn trước khi sửa:** `_backup\20260929-cpp-src\`. Mã mới là ASCII, đã so byte: không đụng chuỗi GBK/TCVN3 có sẵn.
- **Chưa build được:** máy này không có Visual C++ 6. `Build\Build-PhongThan.ps1` tìm `MSDEV.COM` ở `D:\VisualStudio6\...` hoặc `C:\Program Files (x86)\Microsoft Visual Studio\Common\MSDev98\Bin\`; thư mục `D:\VisualStudio6` không tồn tại.

## Phần 3: Hành động
- [ ] **Chủ server cài Visual C++ 6** (bản đã dùng để build dự án này), hoặc đặt biến môi trường `PHONGTHAN_MSDEV` trỏ tới `MSDEV.COM`.
- [ ] Tắt server và client, rồi chạy:
```bash
powershell -ExecutionPolicy Bypass -File "E:\VL\Phong than\PT\PhongThanSource\Build\Build-PhongThan.ps1" -Targets CoreServer,CoreClient,GameClient
```
- [ ] Mở `PhongThan-BangDieuKhien.cmd`, bấm **Publish** để chép bản build vào runtime, sau đó chạy `PhongThan-ChayTatCa.cmd game`.
- [ ] Mặc đủ 5 món đồ lục cùng bộ: phải thấy vòng sáng; tháo 1 món vẫn còn vòng sáng mức 3–4 món; tháo tiếp xuống dưới 3 món thì mất.
- [ ] Bản vá byte dùng thuốc sẽ tự bỏ qua khi DLL mới có timestamp khác. Khi đó sửa gốc trong mã nguồn đã có hiệu lực.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KItemList.cpp` (1514-1553, 4665), `KPlayer.cpp` (3146-3176), `KNpc.cpp` (8345-8388, 10018-10054), `ScriptFuns.cpp` (SetRankEx 7359-7380)
- `do-luc-he-phai-phong-than-20260928.md`
