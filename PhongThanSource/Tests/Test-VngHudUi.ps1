[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$DataRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$expected = [ordered]@{
    'UiHeaderControlBar.ini'     = 'DD1FD2E696DED0AF79E66B22E75AD08B688A79CA2D043882DFDC544E1CD6B64F'
    'UiMiniMapBig.ini'           = 'C0DC1AD12010AE2816484B75D529D39E9EED04E81A49001E1ABA9CE6CE86DBC4'
    'UiMiniMapSmall.ini'         = 'DDDC9D356924FD1AEA334AF20C636A1DFFD4735D03E8EF6802DBD8735282B796'
}

$projectUi = Join-Path $ProjectRoot 'Deploy\ProjectContent\Ui\ui3'
foreach ($entry in $expected.GetEnumerator()) {
    $path = Join-Path $projectUi $entry.Key
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Thieu VNG HUD payload: $path"
    }
    $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    if ($hash -ne $entry.Value) {
        throw "VNG HUD payload bi thay doi: $($entry.Key) ($hash)"
    }
}

$cp936 = [Text.Encoding]::GetEncoding(936)
$shellCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiShell.cpp'), $cp936)
$shellHeader = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiShell.h'), $cp936)
$toolsCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiCase\UiToolsControlBar.cpp'), $cp936)
$headerBarCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiCase\UiHeaderControlBar.cpp'), $cp936)
$superShopCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiCase\UiSuperShop.cpp'), $cp936)
$playerBarCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\UiCase\UiPlayerBar.cpp'), $cp936)
$protocolCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\Core\Src\KProtocolProcess.cpp'), $cp936)

foreach ($className in @(
    'Player_Name', 'Player_Friend', 'Player_FSBook', 'Player_Quest',
    'Player_System', 'Player_Lvskill', 'Player_DivineInfusion', 'Player_PKTimer',
    'Player_Help', 'Player_IBShop', 'Player_Topten', 'Player_HidePeople',
    'Player_Communication', 'Player_TextAnnounce')) {
    if ($shellHeader -notmatch [regex]::Escape("class $className")) {
        throw "Thieu khai bao VNG toolbar class: $className"
    }
    if ($shellCpp -notmatch [regex]::Escape("$className::RegisterSelfClass();")) {
        throw "VNG toolbar class chua duoc register: $className"
    }
}
if ($toolsCpp -notmatch 'PHONGTHAN_VNG_TOOLBAR_INI\s+"\\\\Ui\\\\Ui4\\\\gong_ju_kong_zhi_tiao\.ini"' -or
    $toolsCpp -notmatch 'Ini\.Load\(PHONGTHAN_VNG_TOOLBAR_INI\)') {
    throw 'Client chua bind truc tiep toolbar Phong Than Ui4 trong PAK.'
}
if ($headerBarCpp -notmatch 'PHONGTHAN_VNG_TOPBAR_INI_ID\s+1989332095UL' -or
    $headerBarCpp -notmatch 'LoadPakEntry\(PHONGTHAN_VNG_TOPBAR_INI_ID\)') {
    throw 'Client chua nap top bar Phong Than theo entry id VNG.'
}
$shortcutHeader = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\ShortcutKey.h'), $cp936)
$shortcutCpp = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\GameClient\Ui\ShortcutKey.cpp'), $cp936)
if ($shortcutHeader -notmatch 'SCK_SHORTCUT_IBSHOP\s+"Open\(\[\[ibshop\]\]\)"' -or
    $shortcutCpp -notmatch 'strcmpi\(szname,\s*"ibshop"\)') {
    throw 'Lenh ibshop VNG chua duoc noi vao cua so Ky Tran Cac.'
}
if ($shellCpp -notmatch '(?s)void Player_IBShop::OnButtonClick\(\).*?OperationRequest\(GOI_SUPERSHOP,\s*0,\s*0\)') {
    throw 'Nut Ky Tran Cac chua gui yeu cau native truc tiep.'
}
if ($protocolCpp -notmatch '(?s)enumC2S_PLAYERCOMMAND_ID_SUPERSHOP.*?BuySell\.OpenSale\(nIndex,\s*0,\s*moneyunit_money,.*?PHONGTHAN_IBSHOP_TAB_COUNT') {
    throw 'Server van phu thuoc Lua thay vi mo truc tiep 9 tab Ky Tran Cac.'
}
if ($superShopCpp -notmatch 'Ini\.Load\("\\\\Ui\\\\ui3\\\\ibshopcfg\.ini"\)') {
    throw 'Class Ky Tran Cac chua uu tien ibshopcfg.ini goc trong PAK VNG.'
}
if ($superShopCpp -notmatch 'LoadPageScheme\(const char \*pScheme, int nTab\)' -or
    $superShopCpp -notmatch 'm_PageBackground\.Init\(&Ini, szPage\)' -or
    $superShopCpp -notmatch 'Item_Theme_%d' -or
    $superShopCpp -notmatch 'SetPosition\(nPageLeft \+ nItemLeft,') {
    throw 'Class Ky Tran Cac chua anh xa day du kich thuoc/theme/toa do tung Page_n cua VNG.'
}
if ($superShopCpp -match 'm_NextPageBtn\.Init\(&Ini, "Page_1_BtnNext"\)' -or
    $superShopCpp -match 'm_WndSellItem\[i\]\.LoadScheme\(pScheme\);') {
    throw 'Class Ky Tran Cac van ep layout Page_1/Theme_Normal cua baseline cu.'
}
$startGame = [regex]::Match($shellCpp, '(?s)void UiStartGame\(\) \{.*?\n\}')
if (-not $startGame.Success) {
    throw 'Khong tim thay UiStartGame de kiem tra thu tu khoi tao HUD.'
}
if ($startGame.Value -match '(?m)^\s*MapSetMode\(MINIMAP_M_BRIEF_PIC\);') {
    throw 'Minimap dang duoc mo truoc khi dong bo player/map va co the lam hong UI heap.'
}
if ($startGame.Value -notmatch 'KUiPhongThanTopBar::OpenWindow\(\)') {
    throw 'UiStartGame chua khoi tao top bar Phong Than.'
}
if ($playerBarCpp -notmatch 'Wnd_AddWindow\(this,\s*WL_NORMAL\)' -or
    $startGame.Value -notmatch '(?s)KUiToolsControlBar::OpenWindow\(\).*?KUiPlayerBar::OpenWindow\(\)') {
    throw 'Thanh 4 o vat pham + 2 o skill dang nam sau toolbar VNG va bi che mat.'
}

if ($DataRoot) {
    $runtimeUi = Join-Path ([IO.Path]::GetFullPath($DataRoot).TrimEnd('\')) 'Client\Ui\ui3'
    $runtimeClient = Split-Path -Parent (Split-Path -Parent $runtimeUi)
    $confusableGame = @(Get-ChildItem -LiteralPath $runtimeClient -File -Force |
        Where-Object {
            $_.Name -cne 'Game.exe' -and
            $_.Name.TrimEnd([char]0x20, [char]0xA0) -ieq 'Game.exe'
        })
    if ($confusableGame) {
        throw "Runtime co Game.exe ten an: $($confusableGame.Name -join ', ')"
    }
    foreach ($entry in $expected.GetEnumerator()) {
        $path = Join-Path $runtimeUi $entry.Key
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            throw "Runtime thieu VNG HUD payload: $path"
        }
        $hash = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        if ($hash -ne $entry.Value) {
            throw "Runtime VNG HUD hash mismatch: $($entry.Key) ($hash)"
        }
    }
    if (Test-Path -LiteralPath (Join-Path $runtimeUi 'UiToolsControlBar.ini') -PathType Leaf) {
        throw 'Runtime van con toolbar Vo Lam UiToolsControlBar.ini.'
    }
    $playerBarIniPath = Join-Path $runtimeUi 'UiPlayerBar.ini'
    $playerBarIni = [IO.File]::ReadAllText($playerBarIniPath, $cp936)
    foreach ($section in @('Item_0','Item_1','Item_2','Item_3','ImediaLeftSkill','ImediaRightSkill')) {
        $block = [regex]::Match($playerBarIni, "(?ms)^\[$([regex]::Escape($section))\]\r?\n.*?(?=^\[|\z)")
        if (-not $block.Success -or
            $block.Value -notmatch '(?m)^Width=32\s*$' -or
            $block.Value -notmatch '(?m)^Height=32\s*$') {
            throw "Runtime thieu o VNG 32x32: $section"
        }
    }
}

[pscustomobject]@{
    Status = 'PASS'
    Payloads = $expected.Count
    RuntimeChecked = [bool]$DataRoot
    Scheme = 'Phong Than VNG Ui4 PAK-first'
}
