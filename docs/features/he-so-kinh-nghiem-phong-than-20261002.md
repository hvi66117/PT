# Đánh quái gần như không có kinh nghiệm: hệ số EXP x5

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã đặt ExpRate=5** (người dùng chọn x5), có hiệu lực sau khi khởi động lại server.

## Phần 1: Tổng quan
- **Triệu chứng:** đánh quái chưa thấy kinh nghiệm, thanh kinh nghiệm trên client không nhích.
- **Phân tích** (`KPlayer::AddSelfExp`, KPlayer.cpp 2776):
  - kinh nghiệm nhận = kinh nghiệm quái × `g_ExpRate`, rồi điều chỉnh theo chênh cấp;
  - bản vá byte 0x26976 cho quái thấp cấp hơn: kinh nghiệm − kinh nghiệm × chênh cấp / 200.
- Quái ở bản đồ 1008 (Tuyết quái cấp 3, ExpParam 0/2/50) chỉ cho vài chục điểm, trong khi nhân vật cấp 20 cần hàng chục nghìn điểm để lên cấp. Mỗi con chỉ nhích dưới 1%, nhìn như không có.
- `\settings\GameSetting.ini` (serverlist.pak và bản rời) **không có** mục `[ServerConfig]`, nên `g_ExpRate` = 1 (KCore.cpp 722).

## Phần 2: Chi tiết
- Thêm `[ServerConfig]` với `ExpRate=5` vào hai chỗ, vì chưa chắc thời điểm nạp file này là trước hay sau khi engine chuyển sang chế độ PAK trước:
  - **ptfix v12** (`build_ptfix.py`, backup `.v11`): 391 mục, hash 512951B2…, đặt ở `AdminWeb\pending\ptfix.pak`.
  - **Bản rời** `Server\settings\GameSetting.ini`, sửa ở mức byte, backup ở `_backup\20261002-exprate\`.
- `MoneyRate`, `SkillRate`, `Skill120Rate` giữ mặc định như cũ (vẫn chưa khai báo).
- **Lời khuyên:** luyện ở bản đồ có quái gần cấp nhân vật (chênh ≤ 5 cấp thì nhận đủ kinh nghiệm).

## Phần 3: Hành động
- [ ] Tắt server, thoát game, đóng web admin, chạy `PhongThan-ChayTatCa.cmd game`. Trình cài sẽ cài ptfix v12.
- [ ] Đánh quái, xem thanh kinh nghiệm nhích nhanh hơn khoảng 5 lần.

## Phần 4: Tài liệu tham khảo
- `KCore.cpp` 112/722, `KPlayer.cpp` 2776, `kinh-nghiem-danh-quai-phong-than-20260930.md`.
