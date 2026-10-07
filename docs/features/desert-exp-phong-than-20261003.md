# Đánh quái ở sa mạc không lên kinh nghiệm

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03
> Trạng thái: **Đã vá C++ và build `CoreServer.dll`, chờ triển khai khi tắt server.** Không cần sửa script hay dữ liệu.

## Phần 1: Tổng quan
- **Triệu chứng:** KyUc1Thoi (cấp 10) giết quái ở bản đồ sa mạc 1023 (Thổ Thành) mà kinh nghiệm không tăng. Người dùng báo thêm lúc 19:51: "quái chết nhưng kinh nghiệm không tăng".
- **Nguyên nhân chính:** luật chênh cấp trong `KPlayer::AddSelfExp` (`Core\Src\KPlayer.cpp`, dòng 2977–2984 trước khi sửa). Quái cao hơn người chơi **trên 15 cấp** thì mỗi con chỉ cho **1 điểm** kinh nghiệm.
  - Quái sa mạc: 1022 cấp 30, 1023 cấp 32/36, 1024 cấp 36/38, 1025 cấp 38/43, 1026 cấp 45/50 (`script\phongthan\spawn\spawn_10xx.lua`).
  - Nhân vật cấp 6–20 vào đây luôn chênh trên 15 cấp.
  - `ExpRate=5` không giúp được, vì hệ số nhân trước bước phạt chênh cấp.
- **Nguyên nhân phụ:** luật khoảng cách khi chơi một mình trong `KNpcDeathCalcExp::CalcExp` (`Core\Src\KNpcDeathCalcExp.cpp`, dòng 189–191 trước khi sửa). Người chơi phải đứng trong bán kính 768 quanh quái chết thì mới có kinh nghiệm.
  - Đệ tử Dị Nhân và bot tổ đội (AiMode 11) đánh mục tiêu cách chủ tới 1000 (`PhongThanPetTargetOk`). Đệ tử chỉ bị kéo về khi cách chủ quá 900.
  - Vì vậy quái do đệ tử hoặc bot hạ ở khoảng cách 768–1000 không cho chủ kinh nghiệm nào.

## Phần 2: Chi tiết

### 2.1 Kiểm chứng lúc chạy (admin bridge, 19:47 và 19:50)
- 19:47: KyUc1Thoi cấp 10, không ở tổ đội (`GetTeam` = -1), không có buff kinh nghiệm, thưởng bot tổ đội = 0.
- 19:50: gọi `AddExp(20, cấp, 0)` hai lần, đi thẳng vào `AddSelfExp`:

| Cấp quái giả lập | Kinh nghiệm nhận |
|---|---|
| Bằng cấp người chơi (10) | **+100** (20 × ExpRate 5) |
| Cao hơn 22 cấp (32, như Sa Hồn ở 1023) | **+1** |

- Phép thử chỉ cộng tổng cộng 101 điểm kinh nghiệm cho nhân vật.

### 2.2 Các nghi phạm đã loại trừ

| Nghi phạm | Kết luận |
|---|---|
| `Npcs.txt` (ExpParam) | Mẫu quái sa mạc 14/17/20/24/25/28/30/33 có ExpParam `100,0,2,50`, giống mẫu 8 ở bản đồ 1009, nơi người chơi vẫn lên kinh nghiệm. File này không nằm trong PAK, bản rời được dùng. |
| Thưởng bot tổ đội (P1/P2) | Chỉ cộng thêm khi kinh nghiệm > 0. Bot không chiếm phần. Người chơi không ở tổ đội thật. |
| Quái do đệ tử/bot hạ đòn cuối | `KNpc::CalcDamage` (KNpc.cpp 3822–3828) ghi sát thương của NPC AiMode 11 có chủ vào chủ, và `DoDeath` nhận chủ làm người giết. Chỉ vướng luật khoảng cách 768 (nguyên nhân phụ). |
| Death script `npc_quests\normal.lua` | Không đụng vào kinh nghiệm, và chạy sau `CalcExp`. Không có `tick_error.log`. |
| Tự đánh, trạng thái chiến đấu | Kinh nghiệm tính hoàn toàn ở server, không phụ thuộc phía client. |

### 2.3 Bản vá

**`KPlayer.cpp`, `KPlayer::AddSelfExp`, nhánh quái cao cấp hơn:**

| Chênh cấp (quái cao hơn) | Trước | Sau |
|---|---|---|
| ≤ 5 | 100% | 100% |
| 6 | 90,5% | 95% |
| 10 | 52,5% | 75% |
| 15 | 5% | 50% |
| > 15 | **1 điểm** | **50%** |

- Công thức mới: `100 − 5 × (chênh − 5)`, thấp nhất 50%.
- Nhánh quái thấp cấp hơn giữ nguyên bản vá 2026-09-30: gốc × (1 − chênh / 200).
- Kinh nghiệm gốc của quái chỉ tăng tuyến tính theo cấp: 2 × cấp, theo `ExpParam 100,0,2` và `GetNpcKeyData`. Vì vậy mức 50% không tạo đường cày tắt:
  - nhân vật cấp 10 đánh Sa Hồn cấp 32 nhận 32 × 5 = 160 mỗi con;
  - quái cấp 10 cho 100 mỗi con;
  - đổi lại, Sa Hồn có LifeParam 900 so với 200 của quái thường, tức máu dày gấp nhiều lần.

**`KNpcDeathCalcExp.cpp`, `CalcExp`, nhánh chơi một mình:**
- Bán kính nhận kinh nghiệm tăng từ 768 lên 1600 (`PHONGTHAN_SOLO_EXP_DISTANCE`).
- Mức này phủ vùng đánh của đệ tử và bot: mục tiêu cách chủ ≤ 1000, đệ tử bị kéo về ở 900.
- Tổ đội thật vẫn dùng luật chia của engine như cũ.

### 2.4 Build
- `Build-Modern.ps1 -Targets CoreServer` chạy OK lúc 19:52 và tạo `Sources\Core\Modern\Win32ServerRelease\CoreServer.dll`.
- Bản build này gồm cả các bản vá C++ đang chờ của agent khác: `KNpcAI.cpp` (PhongThanPetTargetOk) và `KItemList.cpp` (weaponequip).

## Phần 3: Hành động
- [ ] Coordinator: tắt GameServer và Bishop, rồi triển khai `CoreServer.dll` mới bằng `_backup\20261002-modernbuild\Deploy-ModernServer.ps1`.
- [ ] Người dùng: vào bản đồ 1023, giết một con Sa Hồn (cấp 32) khi nhân vật cấp 10. Kinh nghiệm phải tăng khoảng 160 mỗi con (64 × 5 × 50%), tính theo phần sát thương của mình, không còn +1.
- [ ] Người dùng: để đệ tử hoặc bot hạ quái cách mình khoảng nửa màn hình. Chủ vẫn phải nhận kinh nghiệm.
- [ ] Nếu muốn mức khác (ví dụ không phạt quái cao cấp, hoặc sàn 25%), chỉ cần đổi hai hằng số `5` và `50` trong `AddSelfExp`.

## Phần 4: Tài liệu tham khảo
- Mã nguồn: `Core\Src\KPlayer.cpp` (`AddSelfExp`), `Core\Src\KNpcDeathCalcExp.cpp` (`CalcExp`), `Core\Src\KNpc.cpp` 3822–3830 (ghi sát thương của đệ tử cho chủ), `Core\Src\KNpcAI.cpp` (`PhongThanPetTargetOk`, `ProcessAIType11`).
- Tài liệu liên quan: `kinh-nghiem-danh-quai-phong-than-20260930.md` (nới luật cho quái thấp cấp), `he-so-kinh-nghiem-phong-than-20261002.md` (ExpRate=5).
- Backup: `_backup\20261003-desertexp\`.
