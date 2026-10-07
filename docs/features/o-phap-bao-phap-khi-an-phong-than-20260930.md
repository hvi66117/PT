# Ô Pháp bảo (3 ô), Pháp khí, Thần Ấn

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-30
> Trạng thái:
> - **3 ô Pháp bảo:** đã có bản vá byte, tự áp dụng khi tắt server và game rồi chạy `PhongThan-ChayTatCa.cmd game`.
> - **Pháp khí, Thần Ấn:** đã làm phương án tạm (người dùng đồng ý lúc 12:50). Chuyển thành pháp bảo, đeo ở 3 ô Pháp bảo/Ngọc, phát từ web admin. Nằm trong `ptfix.pak` v6, đang chờ cài. Muốn đeo vào đúng ô Pháp khí/Thần Ấn vẫn cần C++.

## Phần 1: Tổng quan
| Ô trên giao diện | Ô trong engine | Nhận loại | Trạng thái |
|---|---|---|---|
| Ngọc (JadePendant) | `itempart_amulet` (6) | Pháp bảo 0/4 | Chạy từ trước |
| Pháp bảo 1, Pháp bảo 2 (Talisman1/2) | `itempart_ring1/ring2` (7/8) | Trước: chỉ nhẫn 0/3 (VNG chỉ có 10 dòng nhẫn). **Sau vá: nhận thêm pháp bảo 0/4** | Có bản vá |
| Pháp khí (Instrument) | `itempart_shipin` (12) | Engine chờ loại 12 từ `Shipin.txt`; dữ liệu VNG là `instrument.txt`, loại **0/11** | Cần C++ |
| Thần Ấn (Signet) | `itempart_signet` (11) | Engine chờ loại 11 từ `Signet.txt`; dữ liệu VNG là `signet.txt`, loại **0/13** | Cần C++ |

## Phần 2: Chi tiết
### 2.1 Bản vá 3 ô Pháp bảo (`AdminWeb\PhongThan-ClientPatch.ps1`)
- Vá hàm `KItemList::Fit(int,int)` và `Fit(KItem*,int)`, nhánh `equip_amulet`, ở 4 vị trí:
  - `CoreServer.dll` (timestamp 6aaa5d9f): 0x4DB06, 0x4DC2D;
  - `CoreClient.dll` (timestamp 6aaa74c1): 0x4F389, 0x4F4AD.
- **Nội dung vá (15 byte):**
  - Trước: `cmp [esp+8],6 / jne ret0 / mov eax,1 / ret 8`.
  - Sau: `mov ecx,[esp+8] / sub ecx,6 / cmp ecx,2 / jbe ret1 / jmp ret0 / nop`. Pháp bảo vào được ô 6, 7, 8. Các nhánh khác và bảng nhảy giữ nguyên.
- **Chỉ số là thật:** `KPlayer::ReCalcEquip` duyệt mọi ô trang bị và gọi `ApplyMagicAttribToNPC`, nên pháp bảo ở ô Talisman cũng được cộng chỉ số.
- **Cách áp dụng an toàn:**
  - `Test-NativeRuntime` yêu cầu bản runtime và bản Output khớp hash trong receipt, nên script **chỉ vá khi cả hai file đều ghi được** (server và game đã tắt), rồi cập nhật `NATIVE_DEPLOYMENT.json`.
  - Game đang mở thì bỏ qua phần client; server đang chạy thì bỏ qua phần server và vá ở lần chạy sau.
  - Bản gốc lưu ở `_backup\client-patch\`.
- **Cách đeo:**
  - Bấm chuột phải lên pháp bảo thì luôn vào ô Ngọc (engine `GetEquipPlace`).
  - Muốn đeo vào 2 ô Pháp bảo còn lại thì **kéo thả** vào ô đó.

### 2.2 Vì sao Pháp khí và Thần Ấn cần C++
- `KLibOfBPT::Init` (`KBasPropTbl.CPP`) chỉ nạp 11 bảng trang bị, từ MeleeWeapon đến Horse. `m_BPTSignet` và `m_BPTShipin` được khai báo nhưng không bao giờ nạp.
- Loại vật phẩm VNG khác engine: pháp khí VNG là 11 (engine hiểu 11 là ấn), ấn VNG là 13 (vượt `equip_detailnum = 13`). Không có dữ liệu VNG nào dùng loại 12.
- **Hệ quả:** `AddItem(0,11,…)` / `AddItem(0,13,…)` không tạo được vật phẩm. Nút phát đồ trên web admin sẽ không có tác dụng, nên **chưa thêm vào web admin** để tránh gây hiểu nhầm.
- **Việc cần làm khi có trình biên dịch:**
  1. Nạp `instrument.txt` làm bảng loại 11 và `signet.txt` làm bảng loại 13; thêm loại 13 vào enum và mọi `switch` theo loại (`KItemGenerator`, `Fit`, `GetEquipPlace`, `PhongThanEquipmentArt.inl`).
  2. `Fit`: loại 11 vào `itempart_shipin` (ô Pháp khí), loại 13 vào `itempart_signet` (ô Thần Ấn).
  3. Web admin: thêm 2 danh sách phát đồ như tab pháp bảo, đọc từ `instrument.txt` (38 loại, cấp 1–10) và `signet.txt` (10 loại, cấp 1–10).
### 2.3 Phương án tạm đã làm: pháp khí và ấn thành pháp bảo
- **`build_ptfix.py`** (bản sao lưu `build_ptfix.py.v5`) ghép thêm **480 dòng** vào cuối `\settings\item\001\amulet.txt`. Nối vào cuối nên chỉ số dòng của các pháp bảo cũ không đổi, đồ đã lưu trong DB vẫn đúng.
  - **Pháp khí**: 380 dòng từ `instrument.txt`, particular **200–237** (38 loại, cấp 1–10).
    - Cột 1–44 giữ nguyên.
    - 3 thuộc tính ẩn gộp vào các ô thuộc tính cơ bản còn trống.
    - Cột yêu cầu và các cờ dời về đúng vị trí của bảng pháp bảo.
    - Điền thêm mã trang bị 7 và cột công lực 15/15.
  - **Ấn**: 100 dòng từ `signet.txt`, particular **250–259** (10 loại).
    - Cột 1–69 giữ nguyên.
    - Bỏ cột "trọng chú", giữ cột bộ trang bị.
    - Mỗi loại ấn VNG có 10 dòng giống hệt nhau, nên chỉ có một mức chỉ số.
  - **Bỏ thời gian tồn tại** (ấn VNG có 180, tức sẽ hết hạn): bản phát từ web admin dùng vĩnh viễn.
  - **Yêu cầu:** pháp khí cần cấp 110 (loại 36) và loại 218 (engine không biết loại này nên bỏ qua); ấn không có yêu cầu.
- **Kiểm tra `ptfix_v6.pak`:**
  - Có 362 mục: 359 script, buysell, ibitem 1.677 dòng, amulet 1.920 dòng.
  - 480 dòng mới đều đủ 70 cột (đúng số cột tối thiểu của bảng amulet).
  - Web admin sẽ hiện 344 mục pháp khí (tổ hợp particular và cấp không trùng) và 10 mục ấn.
- **Web admin**, tab "Đồ max & Pháp bảo": thêm 2 ô "Pháp khí" và "Ấn", mỗi ô có bộ chọn cấp.
  - Các dòng mới được tự đăng ký vào danh mục (chúng không có trong `Tra-cuu-vat-pham.txt`).
  - API `/api/presets` trả thêm hai trường `instruments` và `signets`.
- **Cài đặt:** `AdminWeb\pending\ptfix.pak` (v6, sha256 E233FDD2…). Tắt server và thoát game, chạy `PhongThan-ChayTatCa.cmd game`, rồi **mở lại web admin** để nạp danh sách mới.

### 2.4 Kiểm tra sau khi cài (13:20)
- API `/api/presets` trả 344 pháp khí và 10 ấn. Phát thử "Bạch Liên Pháp khí" cho EmLaAi thành công.
- Túi EmLaAi có 0/4/200 (pháp khí) và 0/4/259 (Phục Hy Bát Quái Ấn). Một pháp khí đang đeo ở ô số 7 (Talisman1): bản vá 3 ô pháp bảo hoạt động.
- Ô "Ấn" trên web hiện đủ 10 loại, không lọc theo cấp, vì mỗi loại ấn chỉ có một cấp. Mỗi món có kèm mã particular để phân biệt các pháp khí trùng tên.

## Phần 3: Hành động
- [ ] Tắt server (bảng điều khiển) và thoát game, rồi chạy `PhongThan-ChayTatCa.cmd game`. Cửa sổ lệnh phải báo "Da va KItemList::Fit…" 4 lần.
- [ ] Kéo 2 pháp bảo vào 2 ô Pháp bảo, mở F3 (trạng thái) kiểm tra chỉ số tăng.
- [ ] Sau khi cài v6: web admin → "Đồ max & Pháp bảo" → chọn nhân vật → ô "Pháp khí"/"Ấn" → chọn cấp → bấm tên để phát. Kéo món vừa nhận vào ô Pháp bảo, kiểm tra chỉ số ở F3.

## Phần 4: Tài liệu tham khảo
- `Core\Src\KItemList.cpp` (`Fit` 1395/1454, `Equip` 1162, `GetEquipPlace` 1356), `KPlayer.cpp` (`ReCalcEquip` 3222).
- `Core\Src\KBasPropTbl.CPP` (danh sách bảng 129–143, `Init` 204–239), `GameDataDef.h` (`itempart_*` 217, `EQUIPDETAILTYPE` 312).
- `GameClient\Ui\UiCase\UiItem.cpp` (55–59: Talisman1/2, Instrument, Signet, JadePendant).
- Dữ liệu VNG: `vng00.pak` → `\settings\item\001\instrument.txt`, `\settings\item\001\signet.txt`.
- Tài liệu cũ: `vu-khi-luc-do-max-cuong-hoa-phong-than-20260928.md`.
