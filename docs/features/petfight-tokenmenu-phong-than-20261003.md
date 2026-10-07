# Đệ tử Dị Nhân đánh cùng chủ và menu Lệnh Bài Triệu Hồi (2026-10-03)

## Phần 1: Tổng quan

Hai lỗi người chơi gặp:

- **Đệ tử không đánh cùng chủ.** Lực Sĩ Tế (template 359) chỉ đứng cạnh chủ, không đánh quái. Lỗi nằm ở AI 11 của server.
- **Menu Lệnh Bài Triệu Hồi thiếu "Đổi hình dạng đệ tử".** Menu dài 17 dòng nên client cắt mất các dòng cuối.

## Phần 2: Chi tiết

### 2.1 AI 11 chọn sai mục tiêu (`Sources\Core\Src\KNpcAI.cpp`)

Bản cũ lấy mục tiêu theo thứ tự `else if` từ các nguồn sau:

1. `m_nLastDamageIdx` của chủ;
2. `m_nLastPoisonDamageIdx` của chủ;
3. `m_nPeopleIdx` của chủ;
4. ba trường tương ứng của đệ;
5. mục tiêu chủ đang tung chiêu;
6. quái gần nhất.

Có hai chỗ hỏng:

| Tình huống | Hậu quả |
|---|---|
| Chủ vừa nói chuyện với NPC nhiệm vụ, nên `m_nPeopleIdx` của chủ là NPC đối thoại. `CheckNpc` trả về hợp lệ cho `kind_dialoger`. | Đệ `FollowAttack` NPC đối thoại, chạy tới rồi đứng im, không bao giờ đánh quái. |
| Quái từng đánh chủ vẫn còn sống nhưng đã cách chủ hơn 1000. | Mục tiêu bị đặt về 0 sau bước chọn quái gần nhất, nên đệ chạy về chủ và không đánh con nào. |

Bản sửa:

- Thêm hàm `PhongThanPetTargetOk(pet, owner, target, ownX, ownY)`. Mục tiêu hợp lệ khi:
  - còn sống, không tàng hình;
  - không phải NPC đối thoại;
  - cùng bản đồ;
  - `GetRelation(pet, target) == relation_enemy`;
  - cách chủ không quá 1000.
- Thứ tự thử ứng viên:
  1. mục tiêu chủ đang tung chiêu;
  2. quái đánh chủ;
  3. quái đánh độc chủ;
  4. mục tiêu chủ đang chọn;
  5. ba trường tương ứng của đệ;
  6. cuối cùng là quái gần nhất trong tầm nhìn của đệ.
- Không xóa các trường của chủ, nên thao tác của người chơi không bị ảnh hưởng.

Tiêu chí kiểm thử:

- Gọi Lực Sĩ Tế, nói chuyện với một NPC, rồi ra bãi quái đánh. Đệ phải lao vào đánh cùng.
- Bỏ chạy xa khỏi một con quái rồi đánh con khác. Đệ phải đổi sang con mới.

### 2.2 Menu Lệnh Bài

- Menu chính còn 7 dòng:
  - Gọi đệ tử (cấp 5-55)
  - Gọi đệ tử (cấp 65-120)
  - Học kỹ năng triệu hồi
  - **Đổi hình dạng đệ tử**
  - Gọi đệ tử về bên cạnh
  - Thu hồi đệ tử
  - Đóng
- Hai trang con, mỗi trang 6 đệ tử, có thêm "Quay lại" và "Đóng".
- Generator: `scratchpad\skill180\mktrieuhoi.py`, sinh ra `Server\script\phongthan\item\trieuhoi_lenhbai.lua`.

## Phần 3: Hành động

- [x] Sửa menu lệnh bài, nạp nóng lúc 19:32 (`tokenmenu OK reloaded`).
- [x] Vá `KNpcAI.cpp` và build `CoreServer.dll` (19:38).
- [ ] Tắt server, chạy `Deploy-ModernServer.ps1`, rồi người dùng tự khởi động lại server.
- [ ] Thử lại trong game theo tiêu chí ở mục 2.1.

## Phần 4: Tài liệu tham khảo

- Backup: `_backup\20261003-petfight\KNpcAI.cpp`, `_backup\20261003-tokenmenu\`
- Liên quan:
  - `trieuhoi-lenhbai-phong-than-20261001.md`
  - các bản vá AI 11 trước: leash 900 ngày 2026-10-02, petidx-clear ngày 2026-10-03.
