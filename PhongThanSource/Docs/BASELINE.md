# Baseline Phong Than - full rebuild

Ngay chot: 2026-09-05.

Du an nay la mot ban xay lai Phong Than doc lap. `Docs\REBUILD_CONTRACT.md`
la hop dong kien truc bat buoc; cac quyet dinh migration/compatibility truoc do
da het hieu luc.

## Quyet dinh bat buoc

1. Khong giu ABI, ordinal DLL, kich thuoc packet, protocol hoac struct cu.
2. Khong giu database, save game, tai khoan, nhan vat hay vat pham cu.
3. Khong giu adapter, fallback, alias, bang du lieu hay Lua API chi de tuong
   thich SwordOnline/Vo Lam.
4. Settings, Lua, map, SPR va PAK VNG la nguon du lieu chuan.
5. Runtime chi duoc cutover sau khi client/server cung build tu baseline moi va
   kiem thu end-to-end dat.

## Cau truc doc lap

- Source: `D:\Lam game phong than\PhongThanSource`
- Content bat bien: `D:\Lam game phong than\PhongThanRuntime-Content`
- Du lieu runtime thay doi: `D:\Lam game phong than\PhongThanRuntime-State`
- Staging kiem thu: `D:\Lam game phong than\PhongThanRuntime-Staging`

Source/build khong duoc doc hay ghi vao cay `DEV AG v1\SwordOnline`.

## Baseline dang xay

### Item va trang bi

- Moi item trang bi duoc dinh danh bang `TemplateRow` trong bang VNG do
  `settings\item\itemversion.ini` chon.
- Server, client, view item, giao dich va persistence cung truyen `TemplateRow`;
  khong suy dien row bang cong thuc `Particular * 10 + Level - 1`.
- Lenh mac trang bi ghi that vao `m_EquipItem`.
- Phi Phong la mot lop VNG duy nhat, lay `EquipId` tu `item\001\pendant.txt`;
  khong con `PenD/Mantle`, `CloakRes.txt` hay Lua Mantle chap va.
- Gate: `Tests\Test-PhongThanItemBaseline.ps1`.
- Subsystem ngoai hinh la `KPhongThanAppearance`; `KItemChangeRes`, cac bang
  `ChangeRes` va state ngoai hinh tach roi cua SwordOnline da bi xoa.
- Checkpoint 2026-09-05: `CoreServer`, `CoreClient`, `GameClient` Release build
  thanh cong; gate item dat 16/16 va gate ngoai hinh dat 31/31.

### Data registry

- Item chi nap tu version VNG dang active va fail-closed khi sai schema.
- Server doc `Region_S.dat`; client doc `Region_C.dat`; hai vai tro khong duoc
  danh trao hoac suy dien tu nhau.
- Registry hien tai bat buoc du 102 map active tren 91 bo map vat ly, voi
  34.048 `Region_C` va 34.048 `Region_S`; thieu mot entry thi gate fail-closed.

### Protocol session Phong Than

- Client va Bishop dung wire header tu mo ta cho dang nhap, danh sach nhan vat,
  tao, xoa, chon nhan vat va vao world.
- Response dang nhap khong gui nguoc mat khau; ket qua auth dung enum Phong Than.
- Danh sach nhan vat duoc Bishop chuyen thanh danh sach scalar co gioi han, khong
  forward `TProcessData` hoac `RoleBaseInfo` xuong client.
- Tao/xoa nhan vat khong con dung `TProcessData`, `tagDBDelPlayer` hay
  `tagNewDelRoleResponse` tren bien client.
- Client vao GameServer bang ticket opaque 16 byte; khong truyen `GUID` nhu mot
  hop dong wire.
- Cac entry legacy `c2s_login`, `s2c_login`, `c2s_newplayer`,
  `s2c_rolenewdelresponse`, `c2s_logicLogin` va `c2s_dbplayerselect` da bi khoa.
- Bishop va AccountServer dung packet Phong Than cho hello, xac thuc va release
  tai khoan; khong con payload login account cua SwordOnline tren bien nay.
- Bishop va Goddess dung packet Phong Than cho list/create/delete/load nhan vat.
- Bishop va GameServer truyen state nhan vat chuan bang
  `PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER`, khong truyen `tagGuidableInfo` hay
  `TRoleData` tren bien vao world.
- GameServer va Goddess dung packet save Phong Than; khong con `TProcessData`,
  CRC chen cuoi blob hay `TRoleData` tren duong truyen save.
- Gate: `Tests\Test-PhongThanProtocolBaseline.ps1` dat 49/49 o checkpoint
  2026-09-05.
- Control-plane GameServer-Bishop va Bishop-AccountServer dung packet native cho
  world hello, map registry, session enter/leave/transfer, account enter-world va
  heartbeat. Socket smoke: `Tests\Test-PhongThanServiceControlPlane.ps1`.

### Character state va persistence Phong Than

- Schema chuan duy nhat nam trong `Headers\PhongThanCharacter.h`, gom header va
  cac vung fight skill, state skill, task, item co count va kich thuoc ro rang.
- Bishop tao nhan vat truc tiep bang schema nay; khong con sinh `TRoleData` trong
  `PlayerCreator`.
- Goddess create/list/load/save/delete qua `CPhongThanCharacterStore`; moi nhan
  vat la mot file `.pthc` co magic, format version, state size va checksum.
- Ghi save dung tep tam, flush va thay the nguyen tu; state sai version, size,
  count, account hoac checksum bi tu choi.
- Kho Berkeley/blob va API `S3DBI_*` cu khong con tren luong nghiep vu nhan vat.
- CoreServer nap/luu base, skill, task va item truc tiep bang schema canonical.
- Adapter `PhongThanLegacyCharacterAdapter.h` da bi xoa; luong attach/save khong
  con chuyen doi qua `TRoleData` hay `TDBSkillData`.
- Core khong con include `PhongThanDB.h`; hai DB thread cu da bi xoa.
- Chuyen nhan vat giua GameServer dung canonical state, khong con blob
  `TRoleData + CRC`; gateway tu choi payload phan manh legacy.
- Goddess chi build `CPhongThanCharacterStore`; Berkeley DB, DB backup,
  game-stat/GM blob va `libdb41s` da bi loai khoi executable.
- Khoa nhan vat GameServer-Goddess dung packet Phong Than rieng `0x1106`.

### Relay Phong Than native

- `Headers\PhongThanRelayProtocol.h` la hop dong relay moi, khong bao ton ABI,
  packet size hoac routing union cua `KRelayProtocol.h`.
- Hợp dong moi co message rieng cho dang ky dich vu, heartbeat, session/map
  index, route theo account/role/map, chuyen nhan vat, chat, clan va friend.
- Moi payload bien deu co kich thuoc tu mo ta va bi gioi han truoc khi route;
  khong duoc dua runtime class, `TProcessData`, `RELAY_DATA` hay
  `EXTEND_HEADER` len wire.
- Gate hop dong: `Tests\Test-PhongThanRelayProtocol.ps1`.
- Coordinator TCP native `PhongThanRelay.exe` da build Release; smoke test mo
  socket that, dang ky hai game service, bind session/map va route payload theo
  role da dat.
- GameServer da build cung transport `CPhongThanRelayClient`, gom framing,
  register, heartbeat, session/map bind. Producer/consumer gameplay dang duoc
  chuyen sang transport nay truoc khi cutover runtime.
- Trang thai: chua cutover hai executable relay cu cho den khi tat ca
  producer/consumer moi cung build va test end-to-end dat.

## Thu tu tiep tuc

1. Thay hai relay con lai bang dich vu Phong Than native; xoa Berkeley/ADO,
   giao thuc `KRelayProtocol` va S3Relay cu.
2. Viet Lua API native theo hop dong VNG, xoa compatibility layer.
3. Xay UI dang nhap, F3, F4, HUD va tooltip theo tai nguyen VNG.
4. Hoan tat map, NPC, quai, skill, tuong tac va chuyen tiep.
5. Xoa binary/content/runtime Vo Lam con lai, chay test end-to-end va cutover.

## Dieu kien chot commit baseline moi

- Tat ca target can thiet build Release thanh cong.
- Gate source, content, protocol, database va runtime sach deu PASS.
- Dang nhap, tao/chon nhan vat, vao map, di chuyen, NPC/quai, trang bi, skill,
  Lua, F3/F4 va chuyen map chay tren protocol/database moi.
- Khong con schema nghiep vu, fallback hay runtime asset Vo Lam.
