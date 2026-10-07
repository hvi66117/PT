# Đánh quái không có kinh nghiệm

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái: **Có bản vá byte `CoreServer.dll`**. Tự áp dụng khi tắt server rồi chạy `PhongThan-ChayTatCa.cmd game`. Người dùng chọn "Nới luật chênh cấp".

## Phần 1: Tổng quan
- **Triệu chứng:** nhân vật EmLaAi (cấp 120) đánh quái mà không lên kinh nghiệm. Lúc 12:29 kinh nghiệm là 94 / 245.351.400, nhân vật đang ở bản đồ 1027, quái xung quanh là mẫu 20 cấp 38.
- **Nguyên nhân gốc (kiểm chứng trong `KPlayer::AddSelfExp`):**

| Điều kiện | Kinh nghiệm nhận được |
|---|---|
| Người chơi ≥ quái **và quái cấp ≥ 100** | gốc − gốc × chênh cấp / 200 |
| Chênh ≤ 5 cấp | 100% |
| Chênh 6–15 cấp | (295 − 19 × chênh) / 200 |
| **Chênh > 15 cấp** | **1 điểm** |

- Quái hiện được đặt cao nhất chỉ tới cấp 102 (bản đồ 1078, cấp 95–102). Nhân vật cấp 120 chỉ có kinh nghiệm thật khi đánh quái cấp 100–102.
- Hệ số `ExpRate` trong cấu hình server không giúp được, vì nó nhân trước bước phạt và trường hợp chênh trên 15 cấp luôn trả về 1 điểm.

## Phần 2: Chi tiết
### 2.1 Bản vá (`AdminWeb\PhongThan-ClientPatch.ps1`)
- **Vị trí:** `CoreServer.dll` (timestamp 6aaa5d9f), hàm `AddSelfExp` (map 0001:00025910), file offset 0x26971.
  - Trước: `7c1f 83ff64 7c1a` (`jl` nếu người chơi thấp hơn quái; `cmp edi,100`; `jl` nếu quái dưới cấp 100).
  - Sau: `7c1f 83ff64 9090`: bỏ lệnh nhảy thứ hai.
- **Kết quả:** mọi quái **thấp cấp hơn hoặc bằng** người chơi cho kinh nghiệm = gốc × (1 − chênh cấp / 200):

| Chênh cấp | Nhận được |
|---|---|
| 0 | 100% |
| 10 | 95% |
| 20 | 90% |
| 82 (cấp 120 đánh quái 38) | 59% |
| 119 (cấp 120 đánh quái 1) | 40,5% |

- Quái **cao cấp hơn** người chơi giữ luật cũ: chênh ≤ 5 cấp nhận đủ, 6–15 cấp giảm dần, trên 15 cấp còn 1 điểm.
- Kinh nghiệm gốc của quái tăng theo cấp quái, nên đánh quái thấp vẫn cho ít hơn nhiều so với quái cùng cấp.
- Buff kinh nghiệm (Thiên Hương, Lâm Tiên Lộ…) và `ExpRate` vẫn nhân như cũ.
- **Cách áp dụng an toàn:** script chỉ vá khi cả bản runtime lẫn bản Output đều ghi được, rồi cập nhật `NATIVE_DEPLOYMENT.json`. Đã thử vá lên một bản sao trong scratchpad, 3 bản vá server ghi được đúng vị trí.

### 2.2 Sửa gốc cho lần build C++
- `KPlayer.cpp`, hàm `KPlayer::AddSelfExp`: đổi điều kiện `(m_Level >= nTarLevel) && (nTarLevel >= 100)` thành `m_Level >= nTarLevel`.

## Phần 3: Hành động
- [ ] Tắt server và thoát game, chạy `PhongThan-ChayTatCa.cmd game`. Cửa sổ lệnh phải báo "Da va KPlayer::AddSelfExp…".
- [ ] Đánh một con quái ở bản đồ 1027: kinh nghiệm phải tăng khoảng 59% kinh nghiệm gốc của con quái.
- [ ] Mật độ, mẫu và cấp quái so với VNG đang được nghiên cứu riêng (yêu cầu "Quái của các map đang ít và không giống như VNG").

## Phần 4: Tài liệu tham khảo
- `Core\Src\KPlayer.cpp` (`AddSelfExp` 2770, `AddExp` 2595), `KNpcDeathCalcExp.cpp` (`CalcExp`: sát thương × kinh nghiệm / máu tối đa), `KNpc.cpp` 1693–1720, `KCore.cpp` 722 (`ExpRate`).
- `Server\script\phongthan\spawn\spawn_*.lua`: cấp quái do bộ sinh `gen_spawn.py` đặt.
