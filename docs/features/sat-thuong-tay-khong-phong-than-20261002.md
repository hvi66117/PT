# Đánh quái trúng nhưng không mất máu (nhân vật không cầm vũ khí)

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-02
> Trạng thái: **Đã tìm ra nguyên nhân.**
> - Cách dùng ngay: trang bị vũ khí cho nhân vật.
> - Bản sửa C++ đã viết, chờ build VC6.

## Phần 1: Tổng quan
- **Triệu chứng:** Đạo Sĩ và Dị Nhân đánh quái (cả đánh thường lẫn kỹ năng) chỉ thấy hiệu ứng, không hiện số sát thương, quái không mất máu.
- **Kiểm chứng trên server** (EmLaAi2, Đạo Sĩ cấp 20, bản đồ 1008):
  - Tuyết quái NPC 2796 còn **60/60** máu cả trước lẫn sau 1 phút bị đánh.
  - Trạng thái chiến đấu bật; phe 0 với phe 5 là địch.
  - Quái cấp 3, kháng 0–40%.
  - Nhân vật **không mặc món trang bị nào**.
- **Nguyên nhân (mã nguồn):**
  - `KPlayer::SetNpcPhysicsDamage` (KPlayer.cpp ~2517): sát thương vật lý = sát thương vũ khí + sức mạnh/hệ số (vũ khí cận chiến) hoặc + thân pháp/hệ số (vũ khí tầm xa). Nhánh **không có vũ khí** chỉ lấy sát thương vũ khí, tức 0 + 0.
  - `KNpc::CalcDamage` (KNpc.cpp 3301) trả về ngay khi `nMin + nMax <= 0`, nên không trừ máu và không gửi số sát thương.
  - Kỹ năng Đạo Sĩ/Dị Nhân dựa trên sát thương gốc này nên cũng ra 0.
  - Giáp Sĩ EmLaAi có vũ khí nên không bị.

## Phần 2: Chi tiết
- **Sửa C++** (`KPlayer.cpp`): nhánh tay không cộng `m_nCurStrength / STRENGTH_SET_DAMAGE_VALUE` như vũ khí cận chiến, và sát thương tối đa tối thiểu là 1. Backup ở `_backup\20261001-repairall\KPlayer.cpp.orig`. Bản này build cùng đợt VC6 với `RepairAllEquip` và đệ tử tự đánh.
- **Phát hiện phụ:** vòng sửa đồ kẹt tay chuyển món "Xu" (questkey 4/47) mỗi phút. Món này nằm trong túi nhưng `FindItem` báo vị trí 1. Vô hại, sẽ sửa riêng.

### 2.1 Cầm vũ khí rồi vẫn không mất máu: nguyên nhân chính là chính xác âm (08:22)
- Kiểm tra lại: EmLaAi2 đã mặc "Diệt Diệm kiếm" và bộ "Hư Nghi" (7 món), nhưng **thân pháp 3, sức mạnh 5, còn 95 điểm tiềm năng chưa cộng**.
- `KPlayer::SetNpcAttackRating`: chính xác = thân pháp × 4 − 28 = **−16**.
- `KNpc::CheckHitTarget` (KNpc.cpp 7607): `if (nAR < 0) return FALSE;`, tức chính xác âm thì **trượt 100%**. Đòn trượt chỉ có hiệu ứng, không có số sát thương. Khi chính xác ≥ 0, engine bảo đảm tỉ lệ trúng tối thiểu 40%.
- **Dùng ngay:** F3 → cộng **thân pháp lên từ 8 trở lên** (chính xác ≥ 4), phần còn lại cộng sức mạnh/nội công theo phái.
- **Sửa C++:** chính xác âm tính là 0 (sàn 40% trúng). Backup ở `_backup\20261001-repairall\KNpc.cpp.orig`. Chờ build VC6.

### 2.2 Đã vá byte, không cần trình biên dịch (09:40)
- Máy không cài được trình biên dịch C++: trình cài VS Build Tools lỗi `0x80096004 Certificate is invalid`, có thể do mạng công ty can thiệp HTTPS.
- **Bản vá byte** `CoreServer.dll` (ts 6aaa5d9f), `KNpc::CheckHitTarget` (map 0001:00015bd0), file offset 0x16BFB:
  - trước: `8b442408 85c0 7d06 33c0 5e c20c00` (nAR < 0 thì return FALSE);
  - sau: `8b442408 85c0 7d02 33c0 90909090` (nAR < 0 thì gán 0 rồi chạy tiếp công thức, sàn 40% trúng).
- Đã thêm vào `AdminWeb\PhongThan-ClientPatch.ps1` và áp cho cả bản runtime lẫn Output lúc 09:40 (server đang tắt). `NATIVE_DEPLOYMENT.json` đã cập nhật.
- Tay không ra 0 sát thương: không vá, vì nhân vật mới đã được phát vũ khí tân thủ (`do-tan-thu-vu-khi-thu-cuoi-phong-than-20261002.md`).

## Phần 3: Hành động
- [ ] Web admin → "Phát đồ" → vũ khí phái Đạo Sĩ/Dị Nhân → phát cho nhân vật → mặc vào → đánh thử.
- [ ] Khi có VC6: build CoreServer với 3 bản sửa C++ đang chờ.

## Phần 4: Tài liệu tham khảo
- `KPlayer.cpp` (`SetNpcPhysicsDamage`), `KNpc.cpp` (`CalcDamage` 3296), `KNpcSet.cpp` (`GenOneRelation` 158).
- `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `lenh-bai-huy-do-phong-than-20260930.md`.
