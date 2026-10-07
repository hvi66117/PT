# Phong Than Source

Day la cay ma nguon Phong Than doc lap duoc tao tu dung baseline dang chay.

- `Sources`: ma nguon Core, Engine, Client, Server va Represent.
- `Headers`: giao thuc va header dung chung.
- `Lib`: thu vien can thiet cho toolchain cu.
- `ThirdParty`: GDI+ va DirectX 9 SDK da dong goi, co provenance/hash.
- `Build`: chuan hoa project va build bang toolchain VC6.
- `Deploy`: tao kho noi dung allowlist va runtime staging sach tu `Output`.
- `Docs`: baseline, quy tac protocol va manifest hash.
- `Tests`: kiem tra source khong tham chieu lai cay `SwordOnline`.
- `Output`: san pham build; khong chay truc tiep tu thu muc source.

Runtime live cu khong duoc chinh sua boi cac script trong repository nay.

Thu tu su dung:

1. `Build\Normalize-ProjectPaths.ps1`
2. `Tools\Import-WindowsSdkGdiPlus.ps1`
3. `Tools\New-Vc6GdiPlusImportLib.ps1`
4. `Build\Configure-ThirdPartyPaths.ps1`
5. `Tests\Test-SourceIndependence.ps1`
6. `Tests\Test-NpcScriptRegistryLoader.ps1`
7. `Tests\Test-LuaApiCompatibility.ps1`
8. `Tests\Test-LuaUiTimeGlobalCompatibility.ps1`
9. `Deploy\Import-VngQuestKey.ps1`
10. `Tests\Test-LuaVngItemNpcCompatibility.ps1`
11. `Build\Build-PhongThan.ps1`
12. `Tests\Test-GdiPlusAbi.ps1`
13. `Deploy\New-RuntimeContentStore.ps1` (chi dung khi kho noi dung chua duoc tao hoac manifest thay doi)
14. `Deploy\New-StagingRuntime.ps1`
15. `Deploy\Start-StagingServer.ps1`
16. `Deploy\Start-StagingClient.ps1`

Lenh build mac dinh tao 20 target va ghi artifact runtime vao `Output`:
client, renderer, core, account server, relay server va cum game server. Script
staging xoa sach dich den, chi lay noi dung trong
`Deploy\RUNTIME_CONTENT_MANIFEST.json` va phu `.exe/.dll` tu `Output`.
File `.map/.pdb`, log, snapshot, backup, JxStudio/JxStartup va binary legacy
khong duoc dua vao runtime. Du lieu Berkeley DB song o
`PhongThanRuntime-State` va duoc gan vao runtime bang junction, vi vay viec tao
lai staging khong lam mat nhan vat.

Client staging phai duoc mo bang `Start-StagingClient.ps1`. Renderer tao cac
surface ve noi bo RGB565 va de DirectDraw chuyen sang dinh dang desktop 32-bit;
launcher khong con ep Windows vao che do mau 16-bit. Server staging tu khoi dong
`MSSQLLocalDB`, cap nhat pipe hien tai trong `DataBase.ini` va probe database
`account` bang ADO 32-bit truoc khi mo cac dich vu.
