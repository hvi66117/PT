# Phong Than full-rebuild contract

Ngay chot: 2026-09-05.

Day la hop dong kien truc co muc uu tien cao nhat cua repository. Cac tai lieu
cu ve migration, compatibility, append-only protocol hoac packet freeze chi con
gia tri lich su neu mau thuan voi tai lieu nay.

## Nguon chan ly

1. Bang settings, Lua, map, SPR va PAK Phong Than VNG la nguon du lieu chuan.
2. Hanh vi quan sat duoc cua client Phong Than VNG la nguon chuan ve UI va gameplay.
3. Source Vo Lam/SwordOnline chi duoc dung de tham khao thuat toan tong quat; khong
   duoc dung lam schema nghiep vu cua Phong Than.

## Khong giu tuong thich cu

1. Khong giu ABI, ordinal DLL, kich thuoc struct hoac kich thuoc packet cu.
2. Khong giu protocol, database, save game, tai khoan, nhan vat hoac vat pham cu.
3. Khong giu adapter, alias, fallback, bang du lieu hoac Lua compatibility chi de
   runtime Vo Lam/SwordOnline tiep tuc chay.
4. Cho phep doi ten, tach, hop nhat hoac xoa binary va subsystem neu kien truc
   Phong Than moi yeu cau.
5. Cho phep reset toan bo du lieu runtime khi cutover.

## Nguyen tac trien khai

1. Moi subsystem phai co model Phong Than ro rang truoc khi noi server, protocol,
   client va persistence.
2. Server va client cung sinh/nap schema tu mot dinh nghia chuan; khong sao chep
   hai bo struct roi can bang kich thuoc bang tay.
3. Khong tao file du lieu gia de lap cho trong. Du lieu chua co tu VNG phai duoc
   danh dau thieu va fail-closed tai bien phu hop.
4. Mot ten hoac co che trung voi Vo Lam khong tu dong bi xoa neu VNG cung co tinh
   nang do. Vi du, Phong Than co Phi Phong trong `item\001\pendant.txt`; can viet
   model Phi Phong VNG, khong xoa tinh nang va cung khong giu `Mantle` chắp vá.
5. Khong cutover runtime va khong chot baseline moi cho den khi build, gate va
   kiem thu end-to-end cua subsystem da dat.

## Thu tu rebuild

1. Item/template-row va trang bi Phong Than.
2. Ngoai hinh nhan vat: giap, mu, vu khi, Phi Phong va thu cuoi.
3. Protocol nhan vat, NPC, quai, item va skill.
4. Database tai khoan/nhan vat moi.
5. Lua API native va gameplay scripts VNG.
6. UI dang nhap, F3, F4, HUD va tooltip.
7. Map, Region_S/Region_C, NPC, quai va diem chuyen tiep.
8. Runtime sach, kiem thu end-to-end va cutover.

## Dieu kien hoan thanh

- Khong con runtime asset, schema nghiep vu, adapter hoac fallback Vo Lam.
- Client/server build tu duy nhat repository nay va dung duy nhat content VNG da
  duoc xac minh.
- Dang nhap, tao/chon nhan vat, vao map, di chuyen, NPC/quai, trang bi, skill,
  Lua, F3/F4 va chuyen map hoat dong tren protocol/database moi.
