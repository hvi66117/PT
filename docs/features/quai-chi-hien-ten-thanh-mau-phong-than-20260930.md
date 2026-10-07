# Quái chỉ hiện tên và thanh máu, bấm không đánh được; chữ "# Khôi Giáp Sĩ" trên đất

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30 · Trạng thái: **Phần dữ liệu đã sửa** (có hiệu lực khi khởi động lại server + client). **Phần C++ đã viết vào mã nguồn, chờ build bằng VC6.**

## Phần 1: Tổng quan
- **Đã kiểm chứng:**
  - Mã template quái, dữ liệu thả quái và hình đứng đều đúng.
  - Log hiển thị client ghi Giang Quy còn sống ở trạng thái `body=1 doing=1 action=1`, tức là vẽ bình thường.
  - Con "chỉ có tên + thanh máu" là **quái đã chết, đang chờ hồi sinh** (ReviveFrame 540 ≈ 30 giây):
    - Hình động chết `aniXXX_die.spr` không có trong PAK nào (với mọi loại quái), nên xác quái vô hình.
    - Quái đã chết thì không chọn làm mục tiêu được (`GetRelation` trả `relation_none` khi `!IsAlive()`).
    - Nhưng `KNpc::DrawBlood` vẫn vẽ tên và thanh máu đầy, nên trông như quái còn sống.
- **Chữ "# Khôi Giáp Sĩ" trên đất:**
  - Khi quái chết, client tạo vật thể xác theo cột `CorpseIdx` trong `Npcs.txt`. Tất cả quái có giá trị 14 (hoặc 65), vốn lấy từ dữ liệu Võ Lâm.
  - `ObjData.txt` của VNG không có dòng xác quái. DataID 14 là "Khôi Giáp Sĩ" (hình cái mũ).

## Phần 2: Chi tiết
| Sửa | Nội dung | Hiệu lực |
|---|---|---|
| Dữ liệu | `settings\phongthan\Npcs.txt` (Client và Server, 2 bản giống hệt nhau): `CorpseIdx` 14/65 → **0** cho 2.703 dòng. `KObjSet::ClientAdd` từ chối mã ≤ 0, nên không tạo vật thể xác | Khởi động lại server và client |
| C++ (client) | `KNpc::DrawBlood`: không vẽ tên và thanh máu khi `m_Doing` là `do_death` hoặc `do_revive` | Sau khi build bằng VC6 |
| C++ (nếu cần) | Nếu quái bị kẹt mãi ở trạng thái chết: trong `SyncNpc`/`SyncNpcMin`, khi nhận trạng thái sống thì ép NPC về đứng (`m_ProcessAI = 1`, `DoStand()`) | Chỉ làm nếu kiểm thử cho thấy bị kẹt |

- **Bản sao lưu:** `_backup\20260930-corpse\` (`Npcs.txt`), `_backup\20260929-cpp-src\KNpc.cpp`.
- Mã sửa là ASCII. Đã so byte: số byte không phải ASCII không đổi.

## Phần 3: Hành động
- [ ] Khởi động lại server và client: sau khi giết quái, không còn chữ "# Khôi Giáp Sĩ".
- [ ] Đứng cạnh một con quái vừa chết khoảng 1 phút: nó phải hiện hình lại và đánh được. Nếu không, báo lại để làm phần C++ thứ hai.
- [ ] Sau khi build bằng VC6: quái đã chết không còn hiện tên và thanh máu.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KNpc.cpp` (DoDeath 1665, OnDeath 1817, OnRevive 2360, DrawBlood 8554), `KNpcSet.cpp` (SearchNpcAt 1094, GetRelation 1271), `KObjSet.cpp:465`
- Bảng: `\settings\obj\ObjData.txt` (serverlist.pak), `\settings\npcres\普通npc资源.txt`
