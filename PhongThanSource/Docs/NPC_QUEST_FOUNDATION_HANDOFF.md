# Chốt nền nhiệm vụ NPC trước khi xử lý Xích Tùng Tử

Ngày chốt: 2026-09-16

## Đã hoàn tất

- Lua nhiệm vụ lấy người chơi hiện tại mà không làm bẩn Lua stack; đội có ID 0, thành viên rời mạng, sai bản đồ và thành viên trùng được xử lý đúng.
- Tiến độ diệt quái chạy trong ngữ cảnh người gây sát thương đã chụp tại thời điểm chết; không còn ghi nhầm nhiệm vụ cho người chơi khác khi slot được tái sử dụng.
- `QuestExchange` thực hiện giao/nhận vật phẩm theo một giao dịch: kiểm tra giai đoạn, kiểm tra đủ vật phẩm và chỗ trống, tạo đủ phần thưởng rồi mới xóa vật phẩm nhiệm vụ; lỗi giữa chừng khôi phục túi và không tiến nhiệm vụ.
- Luồng vật phẩm nhiệm vụ giữ đủ `Genre/Detail/Particular/Level/Series/Luck`; không còn bỏ `ParticularType` khi kiểm tra hoặc xóa vật phẩm.
- Nạp đúng 29 thuốc và 104 sách kỹ năng từ `settings/item/001`; sách kỹ năng dùng genre 7, được tạo và khôi phục qua dữ liệu nhân vật bằng đúng `DetailType + skill ID`.
- Nhiệm vụ Hộp Gấm của Tô Hộ đã chuyển phần nhận thưởng sang `QuestExchange`; lỗi túi đầy làm mất Hộp Gấm nhưng vẫn hoàn thành nhiệm vụ đã được loại bỏ.
- Script chết quái giữ nguyên luật VNG, chỉ bổ sung bảo vệ solo/đội, giới hạn tiến độ, cập nhật byte nguyên tử và phục hồi Lua globals.
- Không sửa PAK gốc. Mọi phần bổ sung nằm dưới namespace `script/phongthan`.

## Xác nhận

- Build `CoreServer`, `CoreClient`, `GameClient`: thành công, 0 lỗi.
- Lua 4 thật: 5 chuỗi nhiệm vụ, 24 tình huống, 1.112 assertion: đạt.
- Tiến độ diệt quái: 68 assertion: đạt.
- Giao dịch nhiệm vụ: túi đầy, tạo thưởng lỗi giữa chừng, sai vật phẩm, sai giai đoạn, stack một phần và bấm lặp: đạt.
- Cả runtime Client và Server nạp đủ 18/18 bảng vật phẩm, gồm 29 thuốc và 104 sách kỹ năng: đạt.
- Bộ kiểm thử lặp lại: `Build/Test-NpcQuests.ps1`.

## Đã phát hành vào runtime

- `CoreServer.dll`: `E3C7A4815111309FA574BFD1CE84177C7063DA5EEFD69EE2F01018819D0565D8`
- `CoreClient.dll`: `8784E22C913A6A7AE66D12AD5597DC8AEED753CAEB2A97B0CAD3048ACEF19DEB`
- `Game.exe`: `1FA2E653F59DDCFDED428A69DDBB7F4F54BB870F9A174B91F5F0F342F3C9301C`
- Tô Hộ `1002_00.lua`: `CC2F81D9A7D8B40F1DBEB2C412552B268DAE48968C5D69925C5EE7CE8D24CE23`
- Script chết quái: `6B29FF733F2C777B67EA0EFC22EE6C5763C1627951433491B2CACDD4B08C7186`

Các hash nguồn và runtime Staging/Content đã đối chiếu trùng nhau.

## Ranh giới còn lại

- Genre 7 đã có đường tạo và lưu/đọc trong source, đồng thời đã xác nhận bảng dữ liệu và build; tương tác thực tế trên UI và hành vi bấm phải để học sách chưa được tuyên bố hoàn tất khi chưa đối chiếu luật VNG.
- Kết quả trên chứng minh nền engine và 5 chuỗi gốc đã kiểm thử, không phải tuyên bố mọi nhánh nhiệm vụ của toàn bộ NPC đã hoàn thiện.
- Bước tiếp theo chỉ tập trung NPC Xích Tùng Tử: xác minh Lua gốc/ứng viên, menu, điều kiện nhiệm vụ, vật phẩm vào-ra, hội thoại, chức năng Hợp vật phẩm và kiểm thử từng nhánh trên nền đã chốt này.
