# Xếp chồng mảnh thủy tinh, bảo thạch và Không Thư

> Ngày: 2026-10-03 · Agent: stackgem · Backup: `_backup\20261003-stackgem\`

## Phần 1: Tổng quan

**Lỗi người dùng báo:** mảnh thủy tinh, thủy tinh, hồng/lam bảo thạch không xếp chồng. Mỗi viên chiếm một ô túi. Bổ sung: 4 loại Không Thư (nguyên liệu ép sách) cũng không xếp chồng.

**Nguyên nhân:** có hai lỗi khác nhau.

| Nhóm | Dữ liệu | C++ | Nguyên nhân thật |
|---|---|---|---|
| Thủy tinh / bảo thạch, genre 3 (`material.txt`) | Cột MaxStack đúng VNG: 3/77, 3/28, 3/79 đều là 100; Lam Bảo Thạch 3/41 là 10 | Có hỗ trợ xếp chồng | **Lệnh phát đồ của web admin** (`PTAdm_GiveTo` trong `servertimer.lua`) gọi `AddItemID(idx, 0)`. Hàm này dẫn tới `InsertEquipment(idx, false)`, tức không tự gộp chồng, nên mỗi viên một ô. |
| Không Thư, genre 8, 8/139–142/2 (`ibitem.txt`) | Cột 11 `是否叠放` của VNG = 1 | `KItem::operator=(KBASICPROP_IBITEM)` đặt giới hạn chồng bằng `UseCount` (= 1) và bỏ qua cột 11 | Engine không có chỗ nào cho phép món genre 8 dùng một lần được xếp chồng. |

**Bằng chứng runtime** (đọc qua admin bridge lúc 20:14; chỉ đọc, không đổi đồ):
- Nhân vật KyUc1Thoi được web admin phát 130 Hồng Bảo Thạch, 70 Mảnh Hồng Thủy Tinh, 70 Hồng Thủy Tinh và 40 mỗi loại Không Thư.
- Trong túi chỉ còn: 41 Hồng Bảo Thạch, 69 Mảnh Hồng Thủy Tinh, 0 Hồng Thủy Tinh, 20 Bạch Không Thư.
- Túi đầy, phần thừa bị đẩy lên tay rồi rơi xuống đất. Món genre 3 có `max=100`, tức dữ liệu đúng. Không Thư có `max=1`.

## Phần 2: Chi tiết sửa

### 2.1 Phát đồ web admin xếp chồng (`servertimer.lua`)
Trong `PTAdm_GiveTo`, nếu `GetMaxStackItem(idx) > 1` thì gọi `AddItemIDStack(idx)` thay vì `AddItemID(idx, 0)`.
- `AddItemIDStack` dẫn tới `InsertEquipment(idx, true)`, rồi `KItemList::Add(..., bAutoStack=true)`. Món mới gộp vào chồng cùng loại còn chỗ trong túi; chồng đầy thì mở chồng mới.
- Món không xếp chồng (đồ, vũ khí...) vẫn đi đường cũ.
- Áp dụng cho mọi nút phát đồ của web admin: `PTAdm_Give`, `PTAdm_GiveAll`, bộ "Nguyên liệu ép sách", bí kíp. Không phải sửa `PhongThan-Admin.ps1`.

### 2.2 Không Thư xếp chồng 100 (C++ + ptfix)
- **C++** `Sources\Core\Src\KItem.cpp`, trong `operator=(const KBASICPROP_IBITEM&)`: thêm `if (sData.m_bCanStack > nMaxStack) nMaxStack = m_bCanStack;`.
  - Cột 11 của `ibitem.txt` đã được `KBPT_IBItem::LoadRecord` nạp sẵn vào `m_bCanStack`, nhưng trước đây không dùng.
  - Món mới vẫn bắt đầu bằng `UseCount`, nên món có nhiều lần dùng giữ nguyên cách hoạt động cũ.
  - Phải build cả CoreServer lẫn CoreClient. Nếu client không biết giới hạn mới thì không hiện số lượng và không gộp được.
- **ptfix** `scratchpad\ptfix\extra_stackgem.py` (Client và Server):
  - đặt cột 11 = **100** cho 8/139, 8/140, 8/141, 8/142 (particular 2), cùng mức với thủy tinh / bảo thạch dùng chung công thức;
  - **chuẩn hóa về 1** cho 1.302 dòng VNG khác đang có 100/200/250 (thuốc, Cây Đèn Thần, vật phẩm buff có script thay thế của Phong Thần...). Các dòng này xưa nay không xếp chồng trên server, và script của chúng chưa được kiểm tra với chồng. Nhờ vậy chỉ 4 Không Thư thay đổi hành vi. Muốn mở thêm món nào thì thêm vào `STACK` trong plug-in.
  - Không đụng `material.txt` (genre 3 vốn đúng).

### 2.3 Ép sách (`pt_bikip.lua`) an toàn với chồng
- Hàm đếm và trừ đã tính theo số lượng chồng, không theo số ô:
  - `HaveNormalItem` cộng `GetStackNum`;
  - `DelNormalItem` và `CostIBItem` (qua `RemoveItem(idx,1)`) trừ 1 khỏi chồng. Phần này không phải sửa.
- Sửa phần **trả lại nguyên liệu** khi thiếu Không Thư hoặc thiếu chỗ (`PTBK_RefundPages`, `PTBK_RefundMats`):
  - trước đây dùng `AddNormalItem`, không gộp chồng, mỗi món một ô. Lấy 3 viên từ một chồng không giải phóng ô nào, nên khi trả lại có thể cần thêm 3–4 ô, vượt 3 ô trống đã kiểm tra;
  - nay dùng `PTBK_AddPile`, tức `AddNormalItemPile` (tự gộp chồng). Nếu không có hàm này thì quay về `AddNormalItem`.
- Đã sửa cả template trong `scratchpad\bikip\gen_bikip.py`, để lần sinh lại sau vẫn giữ bản sửa.

### 2.4 Đồ đang có sẵn trong túi
- **Genre 3 (thủy tinh, bảo thạch):** đã xếp chồng được ngay. Các viên đang nằm riêng từng ô không tự gộp; người chơi kéo một viên thả lên viên cùng loại thì gộp (`KItemList::CanCombie`, tối đa 100). Món nhặt từ quái hoặc mua ở shop vốn tự gộp. Từ nay món phát từ web admin cũng tự gộp.
- **Không Thư:** sau khi triển khai C++ + ptfix và khởi động lại, các tờ cũ nạp từ DB có giới hạn 100 nhưng vẫn mỗi tờ một ô. Kéo thả để gộp; tờ mới tự gộp.
- **Không gộp tự động:** món bị khóa (`IsLock`), hoặc khác trạng thái khóa bán / giao dịch / rơi, khác hạn dùng, khác param.

## Phần 3: Hành động

| Việc | Ai | Cần |
|---|---|---|
| Build ptfix chính thức (có `extra_stackgem.py`) | Coordinator | Build Client trước, Server sau |
| Triển khai CoreServer.dll + CoreClient.dll + Game.exe (đã build 20:19) | Coordinator / người dùng | Tắt server và client. **Triển khai ptfix cùng lúc**: C++ mới mà thiếu ptfix thì 1.302 dòng VNG khác cũng thành xếp chồng |
| `servertimer.lua` | Có hiệu lực khi server nạp lại; hoặc áp nóng bằng `scratchpad\stackgem\hot_givestack.lua` (chép vào `admin_bridge\pending.lua`) | Không cần khởi động lại nếu áp nóng |
| `pt_bikip.lua` | Có hiệu lực khi các script Võ sư được nạp lại (khởi động lại hoặc ReLoadScript) | Thủy tinh đã xếp chồng ngay từ bây giờ, nên nên nạp sớm |
| Kiểm thử trong game | Người dùng | Phát 50 Hồng Bảo Thạch từ web admin, phải ra 1 ô x50. Sau khi triển khai, phát 20 Bạch Không Thư, phải ra 1 ô x20. Kéo thả gộp các viên cũ. Ép sách một lần |

## Phần 4: Kiểm thử đã chạy

- Build `CoreServer`, `CoreClient`, `GameClient`: OK (KItem.cpp đã được biên dịch lại).
- ptfix thử `scratchpad\stackgem\ptfix_test_client.pak` / `ptfix_test.pak`:
  - so với v25, chỉ `ibitem.txt` khác và chỉ khác ở cột 11;
  - sau sửa chỉ còn 4 dòng có giới hạn > 1 (8/139–142 = 100);
  - 41/42 (Client) và 616/617 (Server) mục còn lại giống hệt v25.
- `sim_bikip`, `sim_bikip2`: kết quả giống hệt trước khi sửa.
- `sim_stackgem.lua` (mới, mô hình túi có ô và chồng): FAILS=0.
  - **Phát đồ:** code cũ làm tràn túi, mất 110 món; code mới dùng 4 ô và không mất món nào.
  - **Ép sách:** trừ đúng số lượng trong chồng.
  - **Trả nguyên liệu:** trả lại đúng vào chồng cũ, không tốn thêm ô.
  - **So sánh:** code cũ tốn thêm 3 ô và làm đầy túi.

## Tài liệu tham khảo
- `Sources\Core\Src\KBasPropTbl.CPP`:
  - `KBPT_Material::LoadRecord` đọc MaxStack;
  - `KBPT_IBItem::LoadRecord` đọc cột 11.
- `Sources\Core\Src\KItemList.cpp`:
  - `Add(..., bAutoStack)`;
  - `CanCombie`;
  - `InsertEquipment`.
- `Sources\Core\Src\KInventory.cpp`: `FindSameItemToStack`.
- `Sources\Core\Src\ScriptFuns.cpp`:
  - `LuaAddItemID` (không chồng) và `LuaAddItemIDStack` (chồng);
  - `AddNormalItem` (không chồng) và `AddNormalItemPile` (chồng);
  - `RemoveVngItems`.
- Còn tồn tại (ngoài phạm vi):
  - `AddNormalItem` của C++ vẫn không tự gộp, nên phần thưởng nhiệm vụ VNG phát thủy tinh bằng hàm này sẽ ra từng ô (kéo thả để gộp);
  - đầu ra ghép nguyên liệu `PhongThanCommitMaterialCompose` cũng thêm không gộp.
