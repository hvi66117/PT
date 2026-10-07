# Bật quái cho các bản đồ Phong Thần

> Dự án: Phong Thần (bản local) · Ngày: 2026-09-28 · Trạng thái: **Đã triển khai 22:06** (nạp nóng, `added=7274 failed=0`). Chưa kiểm thử trong game.

## Phần 1: Tổng quan

- **Triệu chứng:** hầu hết bản đồ ngoài thành không có quái.
- **Nguyên nhân:** bộ dữ liệu gốc chỉ còn file đặt quái cho 3 bản đồ (1014, 1016, 1052). Đã quét 91.684 mục trong PAK và không tìm thấy dữ liệu đặt quái cho các bản đồ còn lại.
- **Cách xử lý:** sinh lại quần thể quái dựa trên bằng chứng trong dữ liệu VNG:
  - lời nhiệm vụ trong `taskinfo.ini` (quái nào ở map nào);
  - bảng tên quái `npc_name` / `mob_name`;
  - cấp quái lấy từ script boss và script sự kiện.
- **Lưu ý quan trọng:** vị trí và số lượng quái là **dữ liệu sinh lại, không phải bản gốc của VNG**. Loại quái và cấp quái bám theo dữ liệu gốc nhiều nhất có thể.

## Phần 2: Chi tiết

### 2.1 Số liệu
| Nhóm | Số bản đồ | Số quái |
|---|---|---|
| Bản đồ chính | 51 | 6.654 |
| Bản đồ 1073–1076 | 4 | 603 |
| Quái mục tiêu nhiệm vụ | — | 17 |
| **Tổng** | **55** | **7.274** (0 lỗi) |

### 2.2 Cách chạy
- `Server\script\servertimer.lua` → `PTAdm_Spawn()` chạy mỗi phút cùng `PTAdm_Tick()`:
  - lần đầu gọi `dofile("script\\phongthan\\spawn\\spawn_main.lua")`;
  - mỗi tick đặt tối đa 2.500 quái (`PTSpawn_Run(2500)`) để server không bị treo;
  - khi xong đặt `PT_SPAWN_DONE`, nên chỉ chạy **một lần mỗi lần khởi động server**.
- Quái do engine quản lý nên **tự hồi sinh** sau khi bị giết.

### 2.3 Tên hiển thị
- `monster_display_names.txt` có tên tiếng Việt đã kiểm chứng cho 51 loại quái. Tên đã được gộp vào `settings\phongthan\NpcDisplayNames.txt` (Server, Client, ProjectContent).
- **Cần mở lại client** để thấy tên tiếng Việt. Các quái chưa có tên kiểm chứng (đánh dấu `-`) vẫn hiện tên gốc.

### 2.4 Tệp liên quan
| Tệp | Vai trò |
|---|---|
| `Server\script\phongthan\spawn\spawn_main.lua` | Hàng đợi đặt quái: `PTSpawn_Run`, `PTSpawn_ClearAll`, `PTSpawn_Status` |
| `Server\script\phongthan\spawn\spawn_<map>.lua` | 55 file dữ liệu, mỗi bản đồ một file |
| `Server\script\phongthan\spawn\monster_display_names.txt` | Bảng tên quái (GBK) |
| `Server\script\servertimer.lua` | `PTAdm_Spawn()` |

## Phần 3: Hành động

### Kiểm thử (người chơi)
- [ ] Mở lại client, rời tân thủ thôn sang Sùng Thành dã ngoại (1005), Bắc Hải (1006), Chân núi Côn Lôn (1008): phải thấy quái
- [ ] Đánh thử: quái chết rồi hồi sinh
- [ ] Nếu map nào quá đông hoặc quá thưa, báo lại để chỉnh file `spawn_<map>.lua` tương ứng

### Giới hạn và việc tiếp theo
| Việc | Trạng thái |
|---|---|
| **Quái chưa rơi đồ** | Engine không đọc DropRateFile. Cần viết script rơi đồ (death script) |
| Tọa độ map 1044, 1061–1064 | Suy luận, có thể lệch vùng đi được |
| Xóa toàn bộ quái sinh thêm | Gửi `PTSpawn_ClearAll()` qua admin bridge |

## Phần 4: Tài liệu tham khảo
- Tính năng liên quan: `loi-ra-ban-do-cong-dich-chuyen-phong-than-20260928.md`, `nhiem-vu-chinh-tuyen-phong-than-20260928.md`
- Log: `Server\admin_bridge\result.log` (dòng `spawn-start`, `spawn-status`)
- Backup: `_backup\20260928-spawn\`
