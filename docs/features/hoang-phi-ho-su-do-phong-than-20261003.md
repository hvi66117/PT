---
title: Hoàng Phi Hổ (Bái sư, Đổi điểm sư đồ, Xuất sư) và đổi sức lực ở Na Tra, kèm API sư đồ trong C++
date: 2026-10-03
agent: sudocpp
tóm tắt: Bổ sung 11 hàm sư đồ VNG mà GameServer chưa đăng ký (cộng 1 hàm kiểm tra), qua một patch C++ chuẩn bị sẵn kèm applier. Patch chưa áp dụng vì coreclient đang giữ C++. Phần Lua đã đặt sẵn và chỉ bật khi máy chủ có `MasterPRVersion`. Hoàng Phi Hổ mở lại Bái sư, Đổi điểm sư đồ, Quy Chân Kính, Xuất sư; người chơi một mình được xuất sư với Hoàng Phi Hổ làm "sư phụ ảo". Na Tra mở lại Đổi sức lực. Lưu trữ bằng task value của engine (4847, 4848 và các slot tên sư phụ có sẵn), không đổi DB.
---

# Hoàng Phi Hổ (Bái sư, Xuất sư) và đổi sức lực ở Na Tra

## Phần 1: Tổng quan

### Insight chính
- **Phần sư đồ còn tắt là do thiếu API, không phải do script.**
  - GameServer chưa đăng ký 11 hàm: `GetMasterPRValue`, `AddMasterPRValue`, `DecMasterPRValue`, `CanMasterPR`, `DoMasterPR`, `IsMaster`, `UnMasterPREx`, `CanChangeMasterPRValue`, `ChangeMasterPRValue`, `GetNativeWeightMax`, `AddWeightMax`.
  - npc_fix của Hoàng Phi Hổ chặn mọi nhánh cần các hàm này bằng `pt_fix_mpr`.
  - sudo_dongdi cho Na Tra trả lời "chưa mở" ở nút Đổi sức lực.
- **Engine đã có sẵn một nửa phần lưu trữ.**
  - Có slot tên sư phụ (`TASKVALUE_PT_MASTER_NAME_*`, 3 slot × 15 ký tự) và bộ đếm đệ tử. `IsMasterPRRelation`, `IsMantleMaster`… đã đọc chúng, nhưng **chưa hàm nào ghi**.
  - Patch chỉ cần thêm phần ghi (`DoMasterPR`, `UnMasterPREx`) và 2 task value mới: điểm sư đồ (4847) và sức lực (4848). Không đổi schema DB.
- **`pt_compat.lua` làm hỏng cách kiểm tra `if GetMasterPRValue then`.** File này giả lập nhiều tên VNG bằng hàm trả 0. Vì vậy Lua kiểm tra bằng một tên mới, `MasterPRVersion()`.
- **Chơi một mình ("sư phụ ảo"), cùng quy tắc với sudo_dongdi:** người chơi không ở trong tổ đội được coi là một cặp hợp lệ.
  - Hoàng Phi Hổ đóng vai sư phụ, nên phần điểm của sư phụ lúc xuất sư chuyển cho người chơi.
  - Mỗi nhân vật chỉ được xuất sư một mình một lần (task 2410).
- **Rủi ro cần quyết định:** engine **không có luật sức chứa hành trang**. "Sức lực" chỉ được lưu và hiển thị, không tác dụng gì thêm, vậy mà người chơi vẫn tốn danh vọng, tiền và điểm sư đồ.
  - Mặc định vẫn mở cho đúng VNG và đúng yêu cầu, nhưng có cờ tắt `PTSC_WEIGHT_EXCHANGE`.
  - Đề nghị người dùng quyết định.

### Trạng thái
| Hạng mục | Trước | Sau khi deploy C++ (đã mô phỏng) |
|---|---|---|
| Hoàng Phi Hổ: Bái sư | Ẩn | Hiện cho cặp hợp lệ (đệ tử cấp < 30, sư phụ cấp ≥ 50, tổ đội 2 người); ghi quan hệ thật |
| Hoàng Phi Hổ: Đổi điểm sư đồ | Ẩn | Hiện khi có ≥ 1 điểm: Lam/Hồng bảo thạch, mảnh Hoàng thủy tinh, tiền, kinh nghiệm |
| Hoàng Phi Hổ: Nhận điểm sư đồ | Ẩn | Vẫn ẩn (đổi ext point VNG, `CanChangeMasterPRValue` = 0) |
| Quy Chân Kính tăng cấp | "Chưa mở" | 70/70/100 điểm sư đồ như VNG |
| Xuất sư (Đạo lý, task 905) | "Chưa mở" | Cặp thật: đúng đường VNG. Một mình: Viễn Cổ → 1.000.000 kinh nghiệm, Lưỡng Nghi Quy Chân Kính, 15 điểm sư đồ |
| Xuất sư đơn giản (cấp > 50) | "Chưa mở" | Cặp thật như VNG. Một mình: 5 điểm sư đồ |
| Na Tra: Đổi sức lực | "Chưa mở" | Mở theo bảng giá VNG (zj1–zj9); sức lực hiện lên dòng chat |

## Phần 2: Chi tiết

### 2.1 API sư đồ: danh sách và trạng thái đăng ký
Danh sách lấy bằng cách grep 43 script loose và PAK có gọi API sư đồ. Trạng thái đăng ký kiểm tra trong `ScriptFuns.cpp` và các file `PhongThanLuaWave*.h` / `*.inl`.

| Hàm | Script gọi | Trước | Patch |
|---|---|---|---|
| `IsMasterPRRelation(n)` | Hoàng Phi Hổ, Na Tra, 4 thí luyện, 17 Đại phu, Võ sư | Có (Wave 3) | Giữ nguyên |
| `GetMateTask`, `SetMateTask` | Hoàng Phi Hổ (Bái sư) | Có (Diệu Trì) | Giữ nguyên |
| `GetMasterPRValue`, `DecMasterPRValue` | Hoàng Phi Hổ, Na Tra, gm đạo cụ | **Thiếu** | Thêm (task 4847) |
| `AddMasterPRValue` | 18 file (thí luyện, Võ sư, Hoàng Phi Hổ…) | **Thiếu** | Thêm |
| `CanMasterPR`, `DoMasterPR` | Hoàng Phi Hổ | **Thiếu** | Thêm (ghi slot tên sư phụ, bộ đếm đệ tử) |
| `UnMasterPREx(name)` | Hoàng Phi Hổ | **Thiếu** | Thêm (nil hoặc "" = tự rời sư phụ) |
| `IsMaster()` | Hoàng Phi Hổ, 3 Võ sư | **Thiếu** | Trỏ vào `LuaIsMantleMasterCompat` có sẵn |
| `CanChangeMasterPRValue`, `ChangeMasterPRValue` | Hoàng Phi Hổ | **Thiếu** | Thêm, luôn trả 0 |
| `GetNativeWeightMax`, `AddWeightMax` | Na Tra, Nhâm Đại Tẩu, 4 Giáp mã, gm đạo cụ | **Thiếu** | Thêm (task 4848, mặc định 300, khoảng 1–5000) |
| `MasterPRVersion()` | sudocpp | — | Thêm, trả 1 |

### 2.2 Patch C++ (chưa áp dụng)
- **Tài liệu và applier:**
  - `S\sudocpp\cpp_patch.md`: tài liệu đầy đủ, kèm toàn văn header.
  - `S\sudocpp\apply_patch.py`: applier mức byte, có kiểm tra điểm neo, chạy lại nhiều lần vẫn an toàn, có sao lưu.
- **4 thay đổi:**
  - file mới `Core\Src\PhongThanLuaMasterPR.h`;
  - `GameDataDef.h`: thêm 2 dòng enum trước `TASKVALUE_PT_ENGINE_END = 4899`;
  - `ScriptFuns.cpp`: thêm 1 include và 12 dòng bảng hàm, tất cả trong `#ifdef _SERVER`.
- **Đã kiểm tra:**
  - unit test C++ độc lập 39/39 ok;
  - biên dịch thử `ScriptFuns.cpp` đã patch bằng đúng cờ CoreServer: EXIT=0;
  - applier chạy trên bản sao: áp dụng, rồi chạy lại báo "already applied".

### 2.3 Lua (đã đặt, có kiểm tra khả năng)
| File | Vai trò |
|---|---|
| `Server\script\phongthan\sudocpp\sudocpp_lib.lua` | `PTSC_Ready()` (= có `MasterPRVersion`), `PTSC_IsSolo`, `PTSC_IsPair`, `PTSC_JudgeRelation`; hằng số: task 2410, điểm 15/5, cờ `PTSC_WEIGHT_EXCHANGE` |
| `Server\script\phongthan\sudocpp\sudocpp_hph.lua` | Được Include ở **cuối** `npc_fix\1021_hoang_phi_ho.lua` nên thay các hàm `main`, `pt_fix_mpr`, `judge_relation`, `chushi`. Thêm `PTSC_HPH_SoloEnd`, `PTSC_HPH_SoloSimpleEnd` |
| `Server\script\phongthan\sudocpp\sudocpp_natra.lua` | Được Include ở cuối PAK `\script\西岐\哪吒.lua`. Thay `panduan`: chỉ mở khi `PTSC_Ready()` = 1 và cờ bật; hiện sức lực rồi gọi `panduan` VNG |
| `S\ptfix\extra_sudocpp.py` | Plug-in: nối 1 dòng Include vào Na Tra, chạy sau `extra_sudo_dongdi.py` (theo tên: `sudo_` < `sudoc`) |
| `npc_fix\1021_hoang_phi_ho.lua` | Nối thêm ở mức byte 1 dòng `Include("\\script\\phongthan\\sudocpp\\sudocpp_hph.lua")`, đã sao lưu |
| `S\sudocpp\gen_lua.py` | Sinh 3 file Lua (ASCII, chuỗi TCVN3 viết dạng `\ddd`) |

- **Khi chưa deploy C++:** mọi hàm gọi bản gốc. Menu, lời "Hệ thống sư đồ hiện chưa mở" và lời "Chức năng đổi sức lực chưa mở" giữ nguyên như hiện tại.
- **Menu Hoàng Phi Hổ:** gọi `main` của npc_fix nhưng chặn `SayTask` để bật 3 dòng VNG đã bị comment, theo đúng điều kiện VNG:
  - Bái sư khi `CanMasterPR()==1` và task 333 = 0;
  - Nhận điểm khi `CanChangeMasterPRValue()==1`;
  - Đổi điểm khi có ≥ 1 điểm.
- **Xuất sư một mình** (`chushi` khi không ở trong tổ đội):
  - đã xuất sư một mình rồi (task 2410 ≠ 0): từ chối;
  - cấp ≥ 50, đủ 2 thí luyện:
    - Viễn Cổ (905 → 9, chuỗi Thần Nông / Xi Vưu / Hiên Viên ở map 1064, chơi một mình được);
    - `PTSC_HPH_SoloEnd`: 1.000.000 kinh nghiệm; Lưỡng Nghi Quy Chân Kính nếu 903 = 0; xóa 895–907; 903 = 1; gỡ buff 217; xóa task note 42–47; +15 điểm; tin toàn server;
  - cấp > 50, chưa phải sư phụ của ai: `PTSC_HPH_SoloSimpleEnd`, +5 điểm, xóa 895–907 trừ 903;
  - người đang làm sư phụ (`IsMaster()` = 1): từ chối;
  - nếu người chơi đang có sư phụ thật thì `UnMasterPREx("")` gỡ luôn quan hệ.
- **Tổ đội 2 người có quan hệ:** đi nguyên đường VNG (`PM_shengxian_end`, `PM_wuming_end`). Tổ đội khác bị từ chối như VNG.

### 2.4 Task var
| Task | Ý nghĩa |
|---|---|
| 2410 | Xuất sư một mình: 0 = chưa, 1 = Đạo lý, 2 = đơn giản. Dải 2411–2429 còn trống cho sudocpp |
| 4847, 4848 | (engine) điểm sư đồ, sức lực |
| 4815–4817, 4818 | (engine, có sẵn) tên sư phụ, số đệ tử |

- Đã grep script loose và script PAK: không script nào dùng 2410–2429 hay 4840–4899.
- Số 2410–2422 xuất hiện trong `common_beast.luax`, nhưng đó là template NPC, không phải task.

### 2.5 Mô phỏng `S\qtest\sim_sudocpp.lua`
Mô phỏng có nhiều người chơi, tổ đội 2 người, và stub API C++ cùng quy tắc với header.

| Chạy | Kết quả |
|---|---|
| `run.ps1 -Main sim_sudocpp.lua -Stack 0` (đệm stack về 47 frame như engine) | **FAILS=0**, headroom thấp nhất 46 frame (`out_sudocpp_emu.txt`) |
| `run.ps1 -Main sim_sudocpp.lua -Stack 100` (stack nhỏ, khắt khe hơn) | **FAILS=0**, chỉ còn 32 frame vẫn không tràn (`out_sudocpp_s100.txt`) |

- **A. Chưa có C++:**
  - menu không có dòng sư đồ; Xuất sư và Quy Chân Kính "chưa mở", không đổi gì;
  - Thông hành lệnh vẫn chạy;
  - Na Tra: Đổi sức lực đóng, danh vọng còn nguyên; menu đủ.
- **B. Một mình:**
  - Đạo lý: 905 = 1 → 9 → xuất sư (flag, kinh nghiệm, kính, 15 điểm, reset); lần 2 bị từ chối, không có thưởng thêm;
  - Đổi điểm (Hồng bảo thạch bị từ chối, Hoàng thủy tinh, kinh nghiệm);
  - Quy Chân Kính 1 → 2;
  - xuất sư đơn giản 5 điểm, chỉ một lần;
  - cấp 45 chỉ được giải thích; người đang làm sư phụ bị từ chối; tổ đội 3 người bị từ chối.
- **C. Cặp thật:**
  - Bái sư (đệ tử gửi yêu cầu → sư phụ `yes_PR` → `DoMasterPR`), `IsMasterPRRelation` = 1;
  - xuất sư VNG: gỡ quan hệ; đệ tử nhận 1.000.000 kinh nghiệm và kính; sư phụ nhận 15 điểm;
  - không dùng cờ một mình.
- **D. Na Tra:**
  - zj1 (−5 danh vọng, 300 → 301);
  - đầy theo cấp thì báo "đầy";
  - zj6 (−80 danh vọng, −1 điểm, −8.500 lượng);
  - 0 điểm thì từ chối;
  - cờ tắt thì đóng;
  - Đông Hải thí luyện một mình vẫn nhận được.
- **Không hồi quy:** `sim_sudo_dongdi` TOTAL FAILS = 0 (gồm Thông hành lệnh của Hoàng Phi Hổ), `sim_questfix` 0, `sim_questaudit` không có FAIL.
- **Build thử ptfix** với cả 20 plug-in ra `S\sudocpp\ptfix_test.pak`: thành công, log `"sudocpp": ["na tra: 1"]`.

## Phần 3: Hành động

### Coordinator
- [ ] Sau khi coreclient xong, chạy `python S\sudocpp\apply_patch.py --dry-run`, rồi `python S\sudocpp\apply_patch.py`.
- [ ] Build CoreServer (và CoreClient nếu cần, vì enum dùng chung), rồi deploy.
- [ ] Build ptfix có `extra_sudocpp.py` và deploy qua web admin.
- [ ] Người dùng tự khởi động lại GameServer để nạp `CoreServer.dll`, ptfix mới và npc_fix Hoàng Phi Hổ.
- [ ] Quyết định giữ `PTSC_WEIGHT_EXCHANGE = 1` (mặc định) hay đặt `nil` trong `sudocpp_lib.lua` (xem rủi ro ở Phần 1).

### Checklist thử trong game (sau khi deploy)
- [ ] Hoàng Phi Hổ (Triều Ca): nhân vật cấp > 50 không tổ đội → "Xuất sư" → xuất sư đơn giản → nhận 5 điểm sư đồ. Hỏi lại: "Ngươi đã xuất sư rồi".
- [ ] Nhân vật cấp ≥ 50 đã xong 2 thí luyện: Xuất sư → Viễn Cổ (Thần Nông, Xi Vưu, Hiên Viên) → quay lại → 1.000.000 kinh nghiệm, Lưỡng Nghi Quy Chân Kính, 15 điểm.
- [ ] Menu có "Đổi điểm sư đồ": đổi mảnh Hoàng thủy tinh (5 điểm) và kinh nghiệm.
- [ ] Hai nhân vật (cấp 60 và cấp < 30) lập tổ đội 2 người: đệ tử bấm "Bái sư" trước, sau đó sư phụ bấm "Bái sư" và đồng ý. Rời nhóm rồi vào lại: Võ sư Trừ yêu nhận ra cặp sư đồ.
- [ ] Quy Chân Kính cấp 1 + 70 điểm → tăng lên cấp 2.
- [ ] Na Tra (Tây Kỳ): "Đổi sức lực" → dòng chat báo sức lực hiện tại → đổi 1 điểm → danh vọng giảm, sức lực tăng 1 → relog vẫn còn.
- [ ] Trước khi deploy C++: mọi chỗ trên vẫn báo "chưa mở" như hiện tại, không có lỗi Lua.

### Còn lại / rủi ro
1. "Sức lực" không có tác dụng gameplay vì engine không có luật sức chứa (xem Phần 1).
2. Đệ tử rời một sư phụ đang offline thì bộ đếm đệ tử của sư phụ không giảm (record chưa nạp). `IsMantleMaster` có thể còn trả 1 cho đến khi sửa tay.
3. Ba thí luyện npc_fix còn lại (Thổ Hành Tôn, Hoàng Thiên Hóa, Dương Tiễn) và Na Tra vẫn bỏ phần điểm sư phụ khi làm một mình (theo sudo_dongdi). Người chơi một mình chỉ có điểm từ lúc xuất sư (15 hoặc 5).

## Phần 4: Tài liệu tham khảo
- **Patch C++:**
  - `S\sudocpp\cpp_patch.md`, `S\sudocpp\apply_patch.py`, `S\sudocpp\PhongThanLuaMasterPR.h`;
  - test: `S\sudocpp\cpptest\harness.cpp` (+ `out.txt`), biên dịch thử: `S\sudocpp\cctest\cc2.bat`.
- **Lua:** `Server\script\phongthan\sudocpp\*.lua` (sinh bằng `S\sudocpp\gen_lua.py`), `S\ptfix\extra_sudocpp.py`, `S\sudocpp\append_hph.py`.
- **Mô phỏng:** `S\qtest\sim_sudocpp.lua` → `out_sudocpp_emu.txt`, `out_sudocpp_s100.txt`.
- **Nguồn engine:**
  - `ScriptFuns.cpp`: `GetPersistentMasterName`, `LuaIsMasterPRRelationCompat`, `LuaIsMantleMasterCompat`;
  - `PhongThanDieuTriLua.inl`: `PhongThanDieuTriGetTeamMate`;
  - `GameDataDef.h`: vùng task 4800–4899 của engine.
- **Liên quan:** `su-do-dong-di-phong-than-20261003.md` (sudo_dongdi: sư đồ một mình, Na Tra, thí luyện).
