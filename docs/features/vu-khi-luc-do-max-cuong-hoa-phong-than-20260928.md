# Tính năng 5: Vũ khí lục, đồ max option, cường hóa +12, pháp bảo, pháp khí, ngọc bội, ấn, thú cưỡi

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai phần làm được trên web admin** (tab "Vũ khí lục", tab "Đồ max & Pháp bảo"). Phần cần build lại C++ được ghi rõ ở Phần 3.

## Phần 1: Tổng quan

| Yêu cầu | Trạng thái | Cách làm / lý do |
|---|---|---|
| Vũ khí lục theo phái và cấp | **Đã làm** | Tab "Vũ khí lục". Dòng lục có cột hệ = 1000 (có ô thuộc tính xanh), mốc cấp 10–100 |
| Đồ max option | **Làm được một phần** | Chỉ các mẫu có chỉ số cố định bằng mức tối đa (Tinh Quân Cấp 10, thú cưỡi Nghịch / Tinh Quân cấp 10, pháp bảo cấp 120). Đồ có khoảng ngẫu nhiên thì không ép được max |
| Cường hóa +12 | **Không làm được thật** | Không có hàm Lua nào đặt cấp cường hóa. Thay thế: bản "Tinh Quân (+12)" đã có sẵn chỉ số cường hóa trong mẫu, nhưng **không hiện sao** |
| Pháp bảo | **Đã làm** | Dữ liệu pháp bảo VNG nằm ở bảng amulet, **mặc vào ô Ngọc bội** |
| Ngọc bội | Dùng chung ô với pháp bảo | Ô Ngọc bội nhận bảng amulet (tức pháp bảo VNG) |
| Pháp khí | **Không làm được** | Bảng `Shipin.txt` không được server nạp (`KBasPropTbl.CPP`) |
| Ấn | **Không làm được** | Bảng `Signet.txt` không được server nạp |
| Thú cưỡi max | **Đã làm** | Mẫu cố định cấp 10 (Nghịch Lân/Long/Lôi, Tinh Quân cấp 10). Thú cưỡi **không có hệ thống cường hóa** |
| Đồ lục (bộ 5 món) max | Không ép được max | Chỉ số bộ quay ngẫu nhiên trong khoảng min–max của dòng dữ liệu |

## Phần 2: Chi tiết

### 2.1 Vì sao không ép được "max option"
- Bản rebuild lấy **loại thuộc tính cố định theo dòng dữ liệu VNG**. Server chỉ **quay ngẫu nhiên giá trị** trong khoảng min–max: `KItem::SetAttrib_CBR` → `GetRandomNumber` (`KItem.cpp:175-255`).
- Các tham số magic level (thứ 7 trở đi của `AddItem`) và tham số may mắn **không được dùng** để sinh thuộc tính (`KItemGenerator.CPP` `Gen_Equipment`).
- `SetMagicAttrib` có sẵn trong Lua nhưng chỉ sửa trong bộ nhớ: sau khi đăng nhập lại, thuộc tính được dựng lại từ mẫu + seed nên bị mất. Không dùng.
- Kết luận: "max" chỉ đảm bảo được với các mẫu có **min = max**.

### 2.2 Vì sao không có +12 thật
- Cấp cường hóa lưu ở `UpgradeLevel` (tối đa 12; `PhongThanEquipmentCompose.inl`). Nó chỉ được đặt khi load dữ liệu nhân vật, đồng bộ client, và khi cường hóa ở NPC Xích Tùng Tử (gói tin compose từ client).
- **Không có hàm Lua nào** gọi `ApplyUpgradeState`. Đã rà toàn bộ bảng đăng ký `ScriptFuns.cpp` dòng 14000–14820.
- Tham số `level` của `AddItem` chỉ chọn 1 trong 10 dòng của cùng particular (cấp trang bị), **không phải** cấp cường hóa.
- Thú cưỡi, pháp bảo, ấn không có bảng tỉ lệ cường hóa được nạp.

### 2.3 Vũ khí lục (tab "Vũ khí lục")
| Phái | Mốc 20 | Mốc 40 | Mốc 60 | Mốc 80 | Mốc 100 |
|---|---|---|---|---|---|
| Giáp Sĩ (đao) | Hóa Huyết đao | Xích Đồng đao | Giao Hải đao | Đoạt Cung đao | Viêm Đế kiếm |
| Giáp Sĩ (kích/phủ) | Tấn Thiết mâu | Tiếu Thiên đao | Ngân Tiêm kích | Tuyên Hoa phủ | Trạm Kim phủ |
| Đạo Sĩ | Diệt Diệm kiếm | Tử Dương kiếm | Độn Long kiếm | Ngô Câu kiếm | Thái Cực kiếm |
| Dị Nhân | Trường Sinh phủ | Phục Thế phủ | Thất bảo phủ | Tuyệt Tiên phủ | Diệt Thần phủ |

Ngoài 5 mốc trên, danh sách còn có mốc 10, 30, 50, 70, 90, và các vũ khí cấp 75+ (Vạn Kiếp, Nhân Gian, Nguyệt Ảnh, Tuyệt Thế Thần Binh…). Mỗi món có nhiều cấp trang bị (tb) để chọn.

### 2.4 Đồ max (tab "Đồ max & Pháp bảo")
| Nhóm | Giáp Sĩ | Đạo Sĩ | Dị Nhân | Ghi chú |
|---|---|---|---|---|
| Vũ khí Tinh Quân Cấp 10 | Trạm Kim Phủ, Viêm Đế Kiếm | Thái Cực Kiếm | Diệt Thần Phủ | Chỉ số cố định = max, cấp 100 |
| Vũ khí Tinh Quân (+12) | như trên (+12) | như trên (+12) | như trên (+12) | Có sẵn chỉ số cường hóa trong mẫu, **không có sao** |
| Thú cưỡi Tinh Quân Cấp 10 | Xích Diệm Hổ | Thực Hỏa Điểu | Phi Xuyên Hồ Điệp | Cấp 120 |
| Thú cưỡi Nghịch cấp 10 | Nghịch Lân | Nghịch Long | Nghịch Lôi | Cấp 90 |
| Thú cưỡi Bạch Kim Nghịch Thiên, Phi Tuyết | có | có | có | |
| Pháp bảo cấp 120 (ô Ngọc bội) | Huyền Thiên Kính / Linh Bảo / Bảo Đỉnh… | chung | chung | Cố định |
| Pháp bảo Thất Bảo Kim Liên | theo phái | theo phái | theo phái | Cấp 120 |

Cột "Pháp bảo" bên phải tab liệt kê **101 pháp bảo** (cấp trang bị 10), lọc được theo phái.

### 2.5 Tệp liên quan
| Tệp | Nội dung |
|---|---|
| `AdminWeb\PhongThan-Admin.ps1` | `$Weapons` (cờ `green` = cột hệ 1000), `$Presets`, `$Talismans`; API `/api/weapons`, `/api/presets` |
| `AdminWeb\index.html` | Tab "Vũ khí lục", "Đồ max & Pháp bảo" |
| `AdminWeb\data\pak_item_tables\` | Bảng trích từ PAK khi web khởi động |

## Phần 3: Hành động

### Người chơi / chủ server
- [ ] Mở lại client (bắt buộc để thấy tiền đồng và F11)
- [ ] Web → **Vũ khí lục** → chọn nhân vật → chọn mốc cấp → **Phát**
- [ ] Web → **Đồ max & Pháp bảo** → chọn nhân vật → phát vũ khí Tinh Quân / thú cưỡi / pháp bảo
- [ ] Pháp bảo: kéo vào **ô Ngọc bội** ở F3

### Cần build lại C++ (khi có Visual C++ 6)
| Việc | Tệp cần sửa |
|---|---|
| Hàm Lua đặt cấp cường hóa (+1..+12 thật, có sao) | Đăng ký hàm mới gọi `KItem::ApplyUpgradeState` + đồng bộ client (`ScriptFuns.cpp`) |
| Tùy chọn "quay max" khi tạo đồ | `KItem::SetAttrib_CBR` nhận cờ lấy `nMax` thay vì random |
| Pháp khí, ấn | Nạp `Shipin.txt`, `Signet.txt` trong `KLibOfBPT::Init` (`KBasPropTbl.CPP`) và thêm dữ liệu |
| Pháp bảo đúng ô Pháp bảo | Sửa ánh xạ ô UI ↔ detail (`CoreShell.cpp`, `UiItem.cpp`) |

## Phần 4: Tài liệu tham khảo
- Khảo sát: `KItemGenerator.CPP` (Gen_Equipment), `KItem.cpp` (SetAttrib_CBR), `PhongThanEquipmentCompose.inl`, `PhongThanUpgradeState.h`, `KBasPropTbl.CPP`, `GameDataDef.h` (enum equip_/itempart_)
- Tính năng liên quan: `do-luc-he-phai-phong-than-20260928.md` (đồ lục theo bộ), tab "Thú cưỡi"
