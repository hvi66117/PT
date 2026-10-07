# Kỹ năng của quái và NPC: đổi tên kỹ năng sang mã số

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã sửa dữ liệu.** Có hiệu lực khi khởi động lại server.

## Phần 1: Tổng quan
- **Triệu chứng:** đệ tử Dị Nhân không ra đòn. Kiểm tra thì thấy đa số quái cũng không có kỹ năng.
- **Nguyên nhân:**
  - `KNpcTemplate` đọc cột `Skill1..4` của `settings\phongthan\Npcs.txt` bằng `GetInteger`, tức `atoi`.
  - Dữ liệu VNG lại ghi **tên** kỹ năng: `#npc tấn công vật lý`, `#arrow hỏa 2`...
  - Kết quả là mã kỹ năng bằng 0, `KSkillList::SetNpcSkill` bỏ qua, và NPC không có kỹ năng nào.
  - Một số ô còn có cấp `0|1`, `atoi` ra 0, cũng bị bỏ qua.
- **Quy mô:** 1.478 trên 2.722 mẫu NPC bị ảnh hưởng.

## Phần 2: Chi tiết
| Hạng mục | Số lượng |
|---|---|
| Mẫu NPC được sửa | 1.442 |
| Ô kỹ năng đổi tên → mã số theo `skills.txt` (cột SkillName → SkillId) | 5.667 |
| Ô cấp kỹ năng < 1 nâng lên ≥ 1 (lấy số lớn nhất trong `a\|b`) | 326 |
| Ô có tên không tồn tại trong `skills.txt` → gán đòn thường 63 | 167 |

- **Tệp:**
  - `PhongThanRuntime-Staging\Server\settings\phongthan\Npcs.txt`
  - `PhongThanRuntime-Staging\Client\settings\phongthan\Npcs.txt`
  - Hai file vẫn giống nhau.
- **Backup:** `_backup\20261002-npcskills\` (trước khi đổi hàng loạt) và `_backup\20261002-petskill\` (trước khi sửa 12 mẫu đệ tử).
- **Ảnh hưởng:**
  - Quái tung đúng chiêu như bản VNG, nên đánh trả mạnh hơn trước.
  - Game khó hơn, nhất là ở các bản đồ cấp cao và với boss.

## Phần 3: Hành động
- [ ] Khởi động lại server.
- [ ] Đánh quái ở bãi luyện công: quái tung chiêu và gây sát thương.
- [ ] Gọi đệ tử Dị Nhân: đệ tử ra đòn.
- [ ] Nếu quá khó: báo để giảm cấp kỹ năng quái, hoặc khôi phục từ `_backup\20261002-npcskills\` (chỉ khôi phục khi được đồng ý).

## Phần 4: Tài liệu tham khảo
- `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`
- Mã nguồn: `Core\Src\KNpcTemplate.cpp` (dòng 124–145), `Core\Src\KSkillList.cpp` (`SetNpcSkill`)
