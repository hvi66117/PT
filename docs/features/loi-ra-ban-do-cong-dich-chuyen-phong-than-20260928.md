# Sửa lỗi: lối ra bản đồ và cổng dịch chuyển (khu tân thủ và toàn thế giới)

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai 20:53** (nạp nóng: `traps 122`, 13 cổng NPC đã đặt). Chưa kiểm thử trong game.

## Phần 1: Tổng quan

- **Triệu chứng:** đi ra mép bản đồ ở khu tân thủ (Sùng Thành doanh 1002, Ngọc Hư Cung 1003, Xi Vưu Mộ 1004) không có gì xảy ra, và không thấy cổng dịch chuyển.
- **Nguyên nhân gốc (đã kiểm chứng trong mã nguồn):**
  - **Dữ liệu trap vẫn đầy đủ.** Các ô lối ra nằm trong file `*_region_s.dat` và khớp với dữ liệu phía client.
  - Mỗi ô trap lưu mã script dạng `g_FileName2Id("\script\trap\<A>to<B>.lua")`.
  - Các script trap **chỉ nằm trong `script.pak`**. Còn `g_IniScriptEngine` (`KSortScript.cpp`) chỉ đăng ký file rời lúc khởi động. Vì vậy khi `KNpc::CheckTrap` gọi `ExecuteScript(id)` thì không tìm thấy script nào.
- **Phạm vi:** lỗi ảnh hưởng **toàn bộ 102 bản đồ**, với 189 mã trap. Đã khôi phục tên cho 122 mã. 65 mã chưa khôi phục được tên, chủ yếu là trap sự kiện, phó bản và trap "SuperTrap" dịch chuyển về thành.
- Engine **không vẽ trap**. "Cổng" trong game là hình vẽ con đường ở mép bản đồ, không có sprite cổng nào để khôi phục.

## Phần 2: Chi tiết

### 2.1 Lối ra khu tân thủ (trap gốc VNG)
| Bản đồ | Lối ra (tọa độ hiển thị) | Tới |
|---|---|---|
| 1002 Sùng Thành doanh | 192/204 · 192/194 · 212/205 | Sùng Thành dã ngoại 1005 · Bắc Hải 1006 · Yến Sơn 1007 |
| 1003 Ngọc Hư Cung | 221/205 · 222/193 · 203/204 · 199/192 | Chân núi Côn Lôn 1008 · Tây Côn Lôn 1009 · Thủ Dương sơn 1010 · Khoáng trường 1057 |
| 1004 Xi Vưu Mộ | 178/195 · 215/209 · 216/203 | Du Hồn quan 1011 · Miêu Cương 1012 · Cự Lộc 1013 |

### 2.2 Cách sửa
1. **Nạp script trap gốc:** `script\phongthan\npc_fix\exit_trap_register.lua` chứa 122 đường dẫn GBK, đã đối chiếu với chỉ mục PAK. `servertimer.lua` gọi `PTAdm_RegisterExits()` một lần mỗi lần server khởi động, dùng `ReLoadScript(path)` để nạp bản trong PAK dưới đúng mã trap.
2. **Trap Ngọc Hư Cung → Khoáng trường** (không có trong PAK): tạo file rời `Server\script\trap\玉虚宫to矿场.lua` với `NewWorld(57,1608,3094)`.
3. **13 NPC cổng nhìn thấy được** (mẫu 1686 `传送法阵`), đặt cách điểm lối ra 3–6 ô:
   - 10 **"Cổng đi …"**: mỗi cổng dẫn tới một bản đồ lân cận.
   - 3 **"Truyền Tống Trận"**: dựng lại menu dịch chuyển về thành của SuperTrap, gồm 10 điểm đến, phí theo cấp từ 200 đến 5000, và các điều kiện Viễn Cổ, Trư Lung.
   - Các cổng được `PTAdm_EnsureNpcs` tự đặt lại nếu biến mất.

### 2.3 Tệp liên quan
| Tệp | Vai trò |
|---|---|
| `Server\script\servertimer.lua` | `PTAdm_RegisterExits`, 13 dòng `PTADM_NPC_SPAWN` và 13 dòng `PTADM_NPC_FIX` |
| `Server\script\phongthan\npc_fix\exit_*.lua` | Script trap và script cổng (tất cả biên dịch OK) |
| `Server\script\trap\玉虚宫to矿场.lua` | Trap còn thiếu |
| `settings\phongthan\NpcDisplayNames.txt` (Server, Client) | Tên hiển thị các cổng |

## Phần 3: Hành động

### Kiểm thử (người chơi)
- [ ] Ở 1002, đi tới mép tây gần 192/204: phải sang Sùng Thành dã ngoại (1005)
- [ ] Nói chuyện với **Cổng đi Sùng Thành** hoặc **Truyền Tống Trận**: menu có "Đi tới …" và "Kết thúc đối thoại"
- [ ] Thử lối ra ở 1003 và 1004

### Việc còn lại
| Việc | Cách làm |
|---|---|
| 65 mã trap chưa có tên (phó bản, sự kiện, SuperTrap) | Cần sửa C++ để trap chạy được script trong PAK theo mã, không cần biết tên. Hoặc tiếp tục dò tên |
| Tọa độ cổng NPC | Có thể dời theo ý chủ server trong `PTADM_NPC_SPAWN` |

## Phần 4: Tài liệu tham khảo
- `PhongThanSource\Sources\Core\Src\KRegion.cpp` (LoadServerTrap), `KNpc.cpp` (CheckTrap, khoảng dòng 9080), `KSortScript.cpp` (g_IniScriptEngine), `Engine\Src\KFilePath.cpp` (g_FileName2Id)
- Dữ liệu dò tìm: `%TEMP%\ptexits\` (`alltraps_maps.txt`, `unnamed.txt`, `dump\`)
- Backup: `_backup\20260928-exits\`
