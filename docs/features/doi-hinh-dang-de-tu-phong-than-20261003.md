# Đổi hình dạng đệ tử (Triệu Hồi Thú biến thân kiểu VNG) trong Lệnh Bài Triệu Hồi

> Dự án: Phong Thần (bản local) · Ngày: 2026-10-03 · Người làm: agent petmorph
> Trạng thái: **Đã làm bằng Lua, đã triển khai script.** Không cần sửa C++, không cần ptfix mới. Script cần được nạp lại (ReLoadScript hoặc khởi động lại server) mới có hiệu lực.

## Phần 1: Tổng quan
- **Yêu cầu:** thêm mục đổi hình dạng đệ tử vào Lệnh Bài Triệu Hồi, giống VNG.
- **Hệ thống của VNG (đã kiểm chứng trong dữ liệu):**
  - 6 vật phẩm magicscript 6/1/1982–1987 "Triệu Hồi Thú … Biến Thân". Mỗi vật phẩm chạy `\script\item\summonbeastmorph_*.lua`.
  - Script gọi `SetSummonBeastMorph(mẫu)`, ghi **task 254** = mẫu NPC, rồi xóa vật phẩm (dùng một lần).
  - 6 mẫu NPC 2651–2656 trong `Npcs.txt` (tên gốc "…（召唤兽变身）"). Sprite có đủ trong `spr\npcres\animal`.
  - Engine đã có sẵn chỗ đọc task 254: `KSkills.cpp` 523–531 gán hình này cho đệ tử mỗi lần dùng kỹ năng triệu hồi.
- **Cách làm:** thêm mục "Đổi hình dạng đệ tử" vào lệnh bài. Chọn hình thì ghi task 254, gọi lại đệ tử lệnh bài với hình mới, và cập nhật đệ tử kỹ năng.
- **Insight chính:**
  - Đổi hình "tại chỗ" một NPC đang đứng thì client **không vẽ lại** sprite (chỉ ghi số mẫu, không nạp lại hình).
  - Vì vậy script **gọi lại** đệ tử: NPC mới nhận hình ngay trong cùng lượt script, trước gói đồng bộ đầu tiên, nên client thấy hình mới ngay.
  - Chỉ số và kỹ năng vẫn lấy từ mẫu đệ tử gốc (Lực Sĩ tế… Huyền Ảnh Tán Hoa). Chỉ ngoại hình thay đổi, đúng như VNG.

## Phần 2: Chi tiết

### 2.1 Danh sách hình dạng
| Lựa chọn | Mẫu NPC | Vật phẩm VNG tương ứng | Sprite |
|---|---|---|---|
| Thỏ Vàng | 2651 | 6/1/1985 | 金兔 |
| Câu Trần Vàng | 2652 | 6/1/1987 | 勾陈灵兽金色 |
| Chúc Thần Vàng | 2653 | 6/1/1986 | 金色烛神 |
| Tất Phương | 2654 | 6/1/1982 | 毕方 |
| Hạn Bạt | 2655 | 6/1/1983 | 旱魃 |
| Hóa Xà | 2656 | 6/1/1984 | 化蛇 |
| Hình dạng mặc định | 0 | — | theo mẫu đệ tử |

- **Chi phí:** VNG bắt dùng 1 vật phẩm cho mỗi lần đổi. Trong dữ liệu không tìm thấy cửa hàng hay nguồn bán các vật phẩm này. Lệnh bài cho đổi **miễn phí**, không giới hạn số lần.
- **Task 254:** chỉ VNG dùng (6 script `summonbeastmorph_*.lua`). Không có script loose hay PAK nào khác ghi task này. Vật phẩm VNG và lệnh bài dùng chung một giá trị.

### 2.2 Menu trong game
- **Menu chính** có thêm dòng "Đổi hình dạng đệ tử". Tổng cộng 17 lựa chọn, dưới giới hạn 20 của `Say`.
- **Menu đổi hình:**
  - tiêu đề ghi hình đang dùng;
  - 6 hình, hình đang dùng có chữ "(đang dùng)";
  - dòng "Trở về hình dạng mặc định" (task 254 = 0);
  - "Đóng".
- **Sau khi chọn:**
  - Đệ tử lệnh bài đang đứng: bị xóa và gọi lại cùng loại đệ tử, mang hình mới.
  - Đệ tử gọi bằng kỹ năng (450–461): mang hình mới từ lần dùng kỹ năng triệu hồi tiếp theo. Nếu đang có con đứng, script gọi `SetSummonBeastMorph` để đổi phía server.
  - Gọi đệ tử mới bằng lệnh bài: luôn mang hình đã chọn.

### 2.3 Engine (đã đọc mã nguồn)
| Thành phần | Vị trí | Vai trò |
|---|---|---|
| `NpcPolyMorph(npc, mẫu)` | `PhongThanLuaWave7.h` 215, đăng ký `ScriptFuns.cpp` 14238 | đổi `m_NpcSettingIdx` của một NPC bất kỳ và gửi đồng bộ; có trong `CoreServer.dll` đang chạy |
| `SetSummonBeastMorph(mẫu)` | `ScriptFuns.cpp` 3919 | chỉ đổi đệ tử kỹ năng (`m_nPetIdx`), chỉ nhận 2651–2656 |
| Đệ tử kỹ năng | `KSkills.cpp` 523–531 | đọc task 254 mỗi lần thi triển |
| `AddTotemNpc` | `PhongThanLuaWave7.h` 294 | đệ tử lệnh bài **không** gán `m_nPetIdx`, nên `SetSummonBeastMorph` không tới được nó |
| Client `SyncNpc` | `KProtocolProcess.cpp` 1507 | NPC đã có thì chỉ ghi số mẫu, không nạp lại sprite |

- Server không đọc lại chỉ số theo `m_NpcSettingIdx` sau khi tạo NPC (`GetNpcCopyFromTemplate` chỉ chạy lúc `Load`, ngoài ra chỉ dùng cho mặt nạ người chơi). Vì vậy đổi mẫu không làm thay đổi sinh lực, sát thương hay kỹ năng.
- `PTTH_Owned` trước đây so số mẫu NPC với task 1942. Nay chấp nhận thêm mẫu 2651–2656, vẫn bắt buộc chủ nhân đúng tên người chơi. Nhờ vậy "Gọi về" và "Thu hồi" vẫn chạy với đệ tử đã đổi hình, và không xóa nhầm NPC của người khác.
- Task 1942 vẫn lưu mẫu đệ tử gốc, dùng để gọi lại đúng loại đệ tử.

### 2.4 Tệp
| Tệp | Thay đổi | Backup |
|---|---|---|
| `scratchpad\skill180\mktrieuhoi.py` | thêm `MORPHS`, menu đổi hình, `PTTH_SetMorph`, sửa `PTTH_Owned`, `PTTH_Summon` | `_backup\20261003-petmorph\mktrieuhoi.py` |
| `Server\script\phongthan\item\trieuhoi_lenhbai.lua` | sinh lại (12025 byte, SHA256 666D40FF…) | `_backup\20261003-petmorph\trieuhoi_lenhbai.lua` |
| `scratchpad\qtest\sim_petmorph.lua` | mô phỏng mới | — |
| `scratchpad\qtest\sim_petskill_pm.lua` | chạy lại `sim_petskill.lua` với script mới | — |
| `scratchpad\petmorph\cpp_patch.md` | bản vá client **tùy chọn** | — |

- Không có plug-in ptfix: script có đường dẫn ASCII, nằm ngoài PAK.

### 2.5 Kiểm tra
- **`sim_petmorph.lua`, chạy `-Stack 100`:** 22/22 đạt, FAILS=0.
  - gọi Lực Sĩ tế, chọn Thỏ Vàng: xóa 501, gọi lại 502 mẫu 359, `NpcPolyMorph 502 2651`, task 1942 = 359;
  - gọi về khi đã đổi hình: vẫn nhận là đệ tử của mình;
  - gọi Toái Cốt tế khi đã chọn hình: tự mang hình 2651;
  - chọn Hóa Xà rồi trở về mặc định: gọi lại không đổi hình, không gọi `SetSummonBeastMorph`;
  - chọn hình khi chưa có đệ tử: chỉ ghi task;
  - NPC của người khác (mẫu 2653) nằm ở chỉ số cũ: không bị xóa;
  - sai phái: không đổi gì;
  - thiếu cấp để gọi lại: vẫn ghi task, không gọi lại.
- **Mô phỏng đúng stack engine** (`-Stack 0 -Args1 emu`, mỗi lối vào được đệm còn 47 khung như item thật): 22/22 đạt, không tràn stack.
- **`sim_petskill.lua`:** `out_petskill.txt` giống hệt bản trước. Bản chạy với script mới (`out_petskill_pm.txt`) chỉ khác ở dòng menu mới (17 lựa chọn).

### 2.6 Giới hạn
- Đệ tử kỹ năng đang đứng không đổi hình ngay trên màn hình, vì client không vẽ lại. Cần dùng lại kỹ năng triệu hồi. Đây cũng là hành vi của vật phẩm VNG ("Triệu hồi lại thú nếu hình chưa đổi ngay").
- Bản vá client tùy chọn trong `scratchpad\petmorph\cpp_patch.md` (sửa `KProtocolProcess::SyncNpc`) cho phép đổi hình tại chỗ hiện ngay. Bản vá này chờ agent coreclient build xong.
- Tên đệ tử vẫn là tên loại đệ tử (ví dụ "Lực Sĩ tế"), không đổi theo hình.

### 2.7 Áp dụng C++ (agent cppbatch, 2026-10-03)
- Bản vá client tùy chọn ở trên đã được rà soát và gộp vào bản vá chung `scratchpad\cppbatch\cpp_patch.md`, hunk **H7, H8** (`KProtocolProcess.cpp`, chỉ **CoreClient**). Áp dụng bằng `scratchpad\cppbatch\apply_patch.py`.
- Hai lỗi của bản gốc đã được sửa:
  - Sau `Npc[nIdx].Load(...)`, Kind của mẫu (linh thú VNG là 10) ghi đè Kind thật. Bản mới khôi phục Kind từ gói đồng bộ, có chặn `< kind_num`.
  - `Load` nạp lại cờ `ClientOnly` của mẫu, làm NPC không gửi được hội thoại lên server. Bản mới đặt lại `FALSE`.
- An toàn:
  - Không bao giờ nạp lại người chơi (kiểm Kind và mẫu −1/−2).
  - Chỉ nạp khi mẫu thật sự đổi, với mẫu nằm trong 0…4095.
  - Vị trí, vùng, chủ (`m_nOwnerIdx`) và hành động không đổi. Sinh lực, phe, tên, menu được ghi lại ngay từ gói tin.
- Đã biên dịch (Client Release, cờ của `Build-Modern.ps1`) và build thật `CoreClient.dll` trên bản sao nguồn: OK.
- Trạng thái: **chờ coordinator áp dụng và build CoreClient**. Trước khi build, tính năng vẫn chạy như mục 2.6 (gọi lại đệ tử để thấy hình mới).

## Phần 3: Hành động
- [ ] Nạp lại script `\script\phongthan\item\trieuhoi_lenhbai.lua`: dùng `ReLoadScript` qua bridge, hoặc khởi động lại server (người dùng tự làm).
- [ ] Dị Nhân click phải Lệnh Bài Triệu Hồi: thấy dòng "Đổi hình dạng đệ tử".
- [ ] Gọi một đệ tử bằng lệnh bài → "Đổi hình dạng đệ tử" → "Thỏ Vàng": đệ tử biến mất và hiện lại thành Thỏ Vàng, tên vẫn là tên đệ tử cũ.
- [ ] Cho đệ tử đánh quái: sát thương giống trước khi đổi hình.
- [ ] "Gọi đệ tử về bên cạnh" và "Thu hồi đệ tử" vẫn chạy với đệ tử đã đổi hình.
- [ ] Chọn "Trở về hình dạng mặc định": đệ tử hiện lại với hình gốc.
- [ ] Đã học kỹ năng triệu hồi: chọn một hình, rồi dùng kỹ năng triệu hồi → đệ tử `[cấp]tên` mang hình đã chọn.
- [ ] (Tùy chọn) Coordinator áp bản vá chung `scratchpad\cppbatch\cpp_patch.md` (hunk H7, H8) rồi build CoreClient. Sau đó kiểm tra: đổi hình đệ tử kỹ năng hiện ngay, tên, máu, vị trí giữ nguyên, vẫn đối thoại được với NPC khác.

## Phần 4: Tài liệu tham khảo
- **Script VNG:** `Server\script\item\summonbeastmorph_{tuzi,gouchen,zhushen,bifang,hanba,huashe}.lua`; vật phẩm trong `settings\item\001\magicscript.txt` (1982–1987).
- **Mã nguồn:** `KSkills.cpp` 483–575, `ScriptFuns.cpp` 3919 và 14238, `PhongThanLuaWave7.h` 215 và 294, `KProtocolProcess.cpp` 1454–1562, `KNpc.cpp` 5381 (`Load`).
- **Tài liệu liên quan:** `de-tu-trieu-hoi-di-nhan-phong-than-20261001.md`, `ky-nang-de-tu-di-nhan-phong-than-20261002.md`.
