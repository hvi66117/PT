# Microsoft Windows SDK - GDI+

Nguon: NuGet chinh thuc, owner Microsoft/WindowsSDK.

- `Microsoft.Windows.SDK.CPP` 10.0.22000.194
- `Microsoft.Windows.SDK.CPP.x86` 10.0.22000.194
- Trang goi: https://www.nuget.org/packages/Microsoft.Windows.SDK.CPP/10.0.22000.194
- Trang x86: https://www.nuget.org/packages/Microsoft.Windows.SDK.CPP.x86/10.0.22000.194

SHA-256:

- common: `77AF7CF5E7BA2D5EA56B48BC8154EFCE635AC85C4ACAE4F91C101242DBB5DB9E`
- x86: `17778D703AC6FC9FE9D289CC870C6323F675604157AB50636BF1762F065A4A46`

Chi cac header `gdiplus*.h`, hai header phan vung API ma chung phu thuoc va import
library x86 `gdiplus.lib` duoc vendor de VC6 co the build Represent2/Represent3.
DLL runtime van la thanh phan Windows.

`GdiPlusVc6Compat.h` chi vo hieu hoa cac SAL annotation phuc vu static analysis
ma compiler VC6 khong biet; no khong thay doi ABI hay khai bao ham GDI+.

`GdiPlus.WinSdk.lib` la import library x86 chinh thuc lay tu goi SDK tren. Tool
`New-Vc6GdiPlusImportLib.ps1` xac nhan tung import object co symbol stdcall cho
linker VC6 (vi du `_GdipCloneImage@8`) va `Name type: undecorate` de Windows nap
export that `GdipCloneImage`. Sau khi xac nhan, tool chep nguyen ven thu vien nay
thanh `GdiPlus.lib` cho project build; khong dung DEF va khong tai tao import lib.

`GdiPlus.import.json` ghi hash, kien truc va ket qua xac nhan ABI. Sau moi build,
`Test-GdiPlusAbi.ps1` kiem tra `Represent2.dll`/`Represent3.dll` va dung build neu
import table con bat ky ten sai dang `Gdip...@N`.
