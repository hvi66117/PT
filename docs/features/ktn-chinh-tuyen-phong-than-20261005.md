---
tinh-nang: Khương Tử Nha không có lựa chọn chính tuyến (Đạo Sĩ cấp 25) + tên NPC chính tuyến
ngay: 2026-10-05
agent: ktnfix
trang-thai: Đã áp nóng 20:58 qua admin bridge; không cần ptfix, C++ hay khởi động lại
tom-tat: Khương Tử Nha đúng script VNG. Nhân vật DaoSi1 chưa nhận chính tuyến (task 1 = 0) nên VNG chỉ hiện câu chào. Chính tuyến Đạo Sĩ bắt đầu ở Hoàng Long Chân Nhân (Ngọc Hư cung). Đã thêm dòng "Chính tuyến - hướng dẫn" ở Khương Tử Nha cho cả 3 phái. Đổi tên Dương Tiễn và Đắc Kỷ sang tiếng Việt.
---

# Khương Tử Nha không có lựa chọn chính tuyến – nguyên nhân và cách xử lý

## Phần 1: Tổng quan

- **Lỗi người dùng báo:** "Chính tuyến cấp 25 Đạo Sĩ: đến gặp Khương Tử Nha ở Tây Kỳ nhưng không thấy." Ảnh chụp sau đó cho thấy NPC có hình. Lần đầu không thấy chỉ vì nhân vật đứng đè lên NPC. Khi bấm vào, hộp thoại chỉ có câu chào "Hãy tiêu diệt Ma tộc giành lấy vận mệnh của mình!" và "Kết thúc đối thoại".
- **Kết luận chính:** script và NPC đều không hỏng.
  - Khương Tử Nha (idx 1258, template 301, Tây Kỳ 1020 [158,189]) có hình và đang chạy `npc_fix\1020_khuong_tu_nha.lua`, tức bản sửa của script VNG `\script\XiQi\JiangZiYa.lua`. Câu chào là chuỗi 10395 của chính script này.
  - Theo VNG, Khương Tử Nha chỉ hiện "Chinh Đồ" khi đủ 3 điều kiện: phái Đạo Sĩ, task 1 = 1 và có **Thư tiến cử** (event 0) trong túi.
  - Bridge đọc lúc 20:46: DaoSi1 có `GetPlayerType` = 1, cấp 31, **task 1 = 0**, không có Thư tiến cử. Vậy nhân vật **chưa nhận chính tuyến**.
  - Lần trước kiểm tra nhầm biến. Chính tuyến dùng task **3** (Giáp Sĩ), **1** (Đạo Sĩ) và **2** (Dị Nhân). Còn 27/28/29 là mã ghi chú F11 (TaskNote), không phải biến tiến độ.
- **Chính tuyến Đạo Sĩ bắt đầu ở đâu:**
  1. Từ cấp 25, về **Ngọc Hư cung (1003)** gặp **Hoàng Long Chân Nhân** [204,195]. Chọn "Chinh Đồ" rồi đồng ý. Nhân vật nhận Thư tiến cử, task 1 chuyển 0 → 1.
  2. Mang thư tới **Tây Kỳ** gặp Khương Tử Nha, chọn "Chinh Đồ". Task 1 chuyển 1 → 2, nhận 300 kinh nghiệm và 30.000 lượng.
  3. Từ cấp 35, gặp **Lôi Chấn Tử** ở Tây Kỳ (task 1 = 2).
- **Đã sửa:**
  - Khương Tử Nha có thêm dòng **"Chính tuyến - hướng dẫn"**. Dòng này chỉ hiện khi không có dòng nhiệm vụ VNG nào dùng được, nên người chơi không còn gặp hộp thoại trống.
  - Tên **Dương Tiễn** (Tây Kỳ) và **Đắc Kỷ** (Triều Ca) trước đây hiện chữ Trung lỗi font ("Ñîê¯", "æ§¼º"). Nay đã đổi sang tiếng Việt.

## Phần 2: Chi tiết

### 2.1 Kiểm tra trên server (admin bridge, chỉ đọc)

| Mục | Kết quả |
|---|---|
| Khương Tử Nha | idx 1258, template 301, 1020 (1268, 3032), tên TCVN3. Không có NPC thứ hai trùng chỗ. Võ Vương (idx 1259) đứng cạnh, cách 8 ô |
| Script gắn | `ext\npcnames.lua` đổi tên từ tên GBK và gắn `npc_fix\1020_khuong_tu_nha.lua`. Câu chào trong ảnh là chuỗi 10395 của script này, nên script đã chạy |
| DaoSi1 | Loại phái 1, profession 1, cấp 31, task 1 = 2 = 3 = 0, task 11 = 0, không có event 0 |
| NPC đầu chuỗi | Hoàng Long Chân Nhân (idx 26, t846, 1003 [204,195]), Sùng Hầu Hổ (idx 2, 1002 [212,193]), Hình Thiên (idx 44, 1004 [194,200]). Cả ba có tên TCVN3 và đã gắn `npc_fix` |
| NPC chính tuyến khác | Lôi Chấn Tử, Võ Vương, Hoàng Phi Hổ, Hoàng Thiên Hóa, Thổ Hành Tôn, Hồ Hỷ Mị, Lý Tĩnh, Đặng Cửu Công, Văn Thái Sư, Phong Lâm, Ngô Long, Thương Hạo, Đa Bảo, Tây Vương Mẫu, Nguyên Thủy, Đắc Kỷ lúc nhỏ, Đắc Kỷ 1063, Hiên Viên, Thần Nông, Xi Vưu: đều có, tên tiếng Việt. Riêng **Dương Tiễn 1020** và **Đắc Kỷ 1021** còn tên GBK (script vẫn gắn đúng qua `PTAdm_FixNpcScripts`) |

### 2.2 Điều kiện từng NPC (script VNG, giữ nguyên)

| Phái | Biến | Bước 0 → 1 | Bước kế tiếp |
|---|---|---|---|
| Đạo Sĩ | task 1 | Hoàng Long Chân Nhân, "Chinh Đồ", cấp ≥ 25: phát Thư tiến cử (event 0) | Khương Tử Nha "Chinh Đồ" (1 → 2, nhận thư), Lôi Chấn Tử từ cấp 35 |
| Giáp Sĩ | task 3 | Sùng Hầu Hổ, "Trung Thành", cấp ≥ 25 | Trịnh Luân (1 → 2, Huyết thư event 11), Sùng Hầu Hổ (2 → 10) |
| Dị Nhân | task 2 | Hình Thiên, "Mao Lư", cấp ≥ 25 | Hồ Hỷ Mị (1 → 2, Thiệp mời event 15), Hình Thiên (2 → 10) |

Khương Tử Nha chỉ tham gia các bước sau:
- Đạo Sĩ 1 và 20 (cấp 45);
- Giáp Sĩ 27;
- bước 61 của cả ba phái;
- Đông Di 597 = 28/31;
- Tấn Cấp 330 (sự kiện cũ, đã hết hạn).

### 2.3 Dòng "Chính tuyến - hướng dẫn" ở Khương Tử Nha (không có trong VNG)

Dòng này chỉ hiện khi người chơi từ cấp 25 trở lên và đang ở một trong các trạng thái sau (`PTKTN_Hint`):

| Mã | Trạng thái | Nội dung |
|---|---|---|
| 1 | Đạo Sĩ, task 1 = 0 | Về Ngọc Hư cung gặp Hoàng Long Chân Nhân [204,195], chọn "Chinh Đồ" để nhận Thư tiến cử, rồi mang thư tới Tây Kỳ |
| 2 | Đạo Sĩ, task 1 = 1, không có Thư tiến cử | Dùng Lệnh Bài Tiếp Tế Nhiệm Vụ để nhận lại thư. Hoàng Long không phát lại, vì VNG chỉ phát khi task 1 = 0 |
| 3 | Đạo Sĩ, task 1 = 20, cấp < 45 | Đạt cấp 45 quay lại nhận "Thần Oanh" |
| 4 | Giáp Sĩ, task 3 = 0 | Về Sùng Thành doanh gặp Sùng Hầu Hổ [212,193], chọn "Trung Thành" |
| 5 | Dị Nhân, task 2 = 0 | Về Xi Vưu mộ gặp Hình Thiên [194,200], chọn "Mao Lư" |

- Ở mọi trạng thái khác, menu giữ nguyên như VNG. Dòng hướng dẫn chỉ hiện chữ (`Talk`), không đổi biến và không phát vật phẩm.
- Chữ TCVN3 được ghi thành mã `\ddd`, nên file vẫn là ASCII. Hàm `ktn_hint` tính lại trạng thái lúc người chơi bấm, không lưu biến toàn cục giữa các người chơi.

### 2.4 Lệnh Bài Nhiệm Vụ: không sai, không phải sửa

Đã chạy mô phỏng `sim_ktnfix_lb.lua` (19/0) trên file runtime:
- Với task = 0, ở cấp 25 và 31, "Nhiệm vụ đang làm" chỉ đúng NPC đầu chuỗi của từng phái: Sùng Hầu Hổ 1002, Hoàng Long Chân Nhân 1003, Hình Thiên 1004. Ở cấp 24 chuỗi chưa hiện.
- "Chính tuyến" từng bước: dấu `[>]` nằm ở bước 1, nút dịch chuyển của bước 1 đưa tới đúng NPC đầu chuỗi.
- Đạo Sĩ task 1 = 1: bước kế tiếp là Khương Tử Nha, cần Thư tiến cử. Lệnh Bài Tiếp Tế liệt kê đúng món còn thiếu.
- Người chơi có thể bấm dịch chuyển tới bước 2 (Khương Tử Nha) khi chưa làm bước 1. Lệnh bài cho phép xem và dịch chuyển tới mọi bước, bước chưa tới ghi "(chưa tới)". Đây nhiều khả năng là lý do người chơi tới thẳng Khương Tử Nha. Nay dòng hướng dẫn chỉ đường về NPC đầu chuỗi.

### 2.5 Tên Dương Tiễn và Đắc Kỷ

- Trình sinh `npcnames` bỏ qua hai NPC này vì tên GBK của chúng xuất hiện ở file khác. Đã kiểm tra: hai tên chỉ nằm trong **đường dẫn script** (`boss\wb_lib.lua` danh sách npcdeath, `ext\tienma.lua` `PTTM_P`), không có chỗ nào so sánh tên.
- Đã thêm 2 dòng vào `ext\npcnames.lua`:
  - `{1020, GBK 杨戬, "Dương Tiễn", 1020_duong_tien.lua}`
  - `{1021, GBK 妲己, "Đắc Kỷ", 1021_dac_ky.lua}`
- Đã thêm alias `Dương Tiễn → GBK` vào `lib\pt_npcalias.lua`.
- Đã thêm 2 cặp này vào `FORCE` của `scratchpad\npcnames\gen_npcnames.py`.
- Chỉ đổi Đắc Kỷ ở bản đồ 1021. Đắc Kỷ 1063 (tên đã là tiếng Việt) và Đắc Kỷ lúc nhỏ 1061 không đổi.
- **Lưu ý về trình sinh:** chạy thử `gen_npcnames.py` (dry run) ra kết quả khác file runtime từ trước khi sửa. Ví dụ, trình sinh hiện bỏ qua Hình Thiên, Ngô Long và Thương Hạo, trong khi file runtime có các dòng này. Vì vậy lần này không sinh lại mà sửa thẳng file runtime ở mức byte. Không nên chạy lại trình sinh ghi đè lên runtime khi chưa so sánh.

## Phần 3: Hành động

- [x] Sao lưu `_backup\20261005-ktnfix\` gồm `1020_khuong_tu_nha.lua`, `npcnames.lua`, `pt_npcalias.lua`, `gen_npcnames.py`, `sim_lenhbainv.lua`.
- [x] Sửa ở mức byte bằng `scratchpad\ktnfix\patch_ktn.py`. Bản chạy thử ở `ktnfix\dry1` giống hệt bản runtime.
  - So với bản sao lưu: KTN chỉ đổi dòng chú thích đầu và thêm 45 dòng; npcnames thêm 2 dòng; alias thêm 1 dòng.
- [x] Mô phỏng `sim_ktnfix.lua`: 53/0 ở chế độ thường và EMU (khoảng trống stack tối thiểu 41).
  - Đi trọn đầu chuỗi của cả 3 phái: Hoàng Long → Khương Tử Nha → Lôi Chấn Tử; Sùng Hầu Hổ → Trịnh Luân → Sùng Hầu Hổ; Hình Thiên → Hồ Hỷ Mị → Hình Thiên.
  - Kiểm tra 5 trạng thái hướng dẫn, các trường hợp không được hiện hướng dẫn, và dòng npcnames.
- [x] Mô phỏng `sim_ktnfix_lb.lua` (Lệnh Bài Nhiệm Vụ, file runtime): 19/0 ở chế độ thường và EMU.
- [x] Áp nóng lúc 20:58 bằng `ktnfix\hot_ktn.lua`:
  - `ReLoadScript` Khương Tử Nha, Dương Tiễn và Đắc Kỷ;
  - nạp lại `npcnames.lua` (74 dòng) và `pt_npcalias.lua`;
  - chạy tick ngay;
  - giữ nguyên `main` của servertimer.
  - Kết quả trên server: 1256 "Dương Tiễn", 1258 "Khương Tử Nha", 1272 "Đắc Kỷ".
- [ ] **Người chơi DaoSi1:** về Ngọc Hư cung gặp Hoàng Long Chân Nhân để nhận "Chinh Đồ", rồi quay lại Khương Tử Nha. Có thể dùng Lệnh Bài Nhiệm Vụ → Chính tuyến → bước 1 để dịch chuyển tới. Client đang mở có thể cần ra xa rồi quay lại để thấy tên mới của Dương Tiễn và Đắc Kỷ.

## Phần 4: Tài liệu tham khảo

- `docs\features\lenh-bai-nhiem-vu-phong-than-20261004.md`: dữ liệu chính tuyến của lệnh bài (chuỗi 20, task 3/1/2).
- `scratchpad\ktnfix\`: `diag_ktn1.lua` (bridge, chỉ đọc), `patch_ktn.py`, `hot_ktn.lua`, `mainnames.py`, `bdiff.py`, `mk_sim_lb.py`.
- `scratchpad\qtest\sim_ktnfix.lua`, `sim_ktnfix_lb.lua`. Kết quả ở `out_ktnfix*.txt`, `out_ktnfix_lb*.txt`.
- Script VNG: `\script\XiQi\JiangZiYa.lua` (Khương Tử Nha), `\script\YuXuGong\HuangLongZhenRen.lua` (Hoàng Long Chân Nhân).
