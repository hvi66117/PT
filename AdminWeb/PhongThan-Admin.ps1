# Phong Than local admin web (PowerShell 5.1, built-in only).
# Serves http://localhost:<Port>/ for this machine only. Game actions are queued
# as Lua calls into Server\admin_bridge\pending.lua; script\servertimer.lua runs
# the queue once per minute (see its header). Accounts use the LocalDB directly.
[CmdletBinding()]
param([int]$Port = 8765, [switch]$NoBrowser)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Runtime = Join-Path $Root 'PhongThanRuntime-Staging'
$ServerRoot = Join-Path $Runtime 'Server'
$Bridge = Join-Path $ServerRoot 'admin_bridge'
$DataDir = Join-Path $PSScriptRoot 'data'
# GameServer reads package files before loose files (KCore.cpp g_SetPakFileMode(1)),
# so item codes must come from the PAK copies of the tables, extracted at startup.
$ItemDir = Join-Path $DataDir 'pak_item_tables'
$Enc1252 = [Text.Encoding]::GetEncoding(1252)
$EncGbk = [Text.Encoding]::GetEncoding(936)
$Utf8 = New-Object Text.UTF8Encoding($false)
$Token = [guid]::NewGuid().ToString('N')
New-Item -ItemType Directory -Force $Bridge, $DataDir | Out-Null

# ---------------------------------------------------------------- TCVN3 text
$tcvnFrom = @(0xB5,0xB8,0xB6,0xB7,0xB9,0xA8,0xBB,0xBE,0xBC,0xBD,0xC6,0xA9,0xC7,0xCA,0xC8,0xC9,0xCB,0xAE,0xCC,0xD0,0xCE,0xCF,0xD1,0xAA,0xD2,0xD5,0xD3,0xD4,0xD6,0xD7,0xDD,0xD8,0xDC,0xDE,0xDF,0xE3,0xE1,0xE2,0xE4,0xAB,0xE5,0xE8,0xE6,0xE7,0xE9,0xAC,0xEA,0xED,0xEB,0xEC,0xEE,0xEF,0xF3,0xF1,0xF2,0xF4,0xAD,0xF5,0xF8,0xF6,0xF7,0xF9,0xFA,0xFD,0xFB,0xFC,0xFE,0xA1,0xA2,0xA7,0xA3,0xA4,0xA5,0xA6)
$tcvnTo = @(0xE0,0xE1,0x1EA3,0xE3,0x1EA1,0x103,0x1EB1,0x1EAF,0x1EB3,0x1EB5,0x1EB7,0xE2,0x1EA7,0x1EA5,0x1EA9,0x1EAB,0x1EAD,0x111,0xE8,0xE9,0x1EBB,0x1EBD,0x1EB9,0xEA,0x1EC1,0x1EBF,0x1EC3,0x1EC5,0x1EC7,0xEC,0xED,0x1EC9,0x129,0x1ECB,0xF2,0xF3,0x1ECF,0xF5,0x1ECD,0xF4,0x1ED3,0x1ED1,0x1ED5,0x1ED7,0x1ED9,0x1A1,0x1EDD,0x1EDB,0x1EDF,0x1EE1,0x1EE3,0xF9,0xFA,0x1EE7,0x169,0x1EE5,0x1B0,0x1EEB,0x1EE9,0x1EED,0x1EEF,0x1EF1,0x1EF3,0xFD,0x1EF7,0x1EF9,0x1EF5,0x102,0xC2,0x110,0xCA,0xD4,0x1A0,0x1AF)
$TcvnToUni = @{}; $UniToTcvn = @{}
for ($i = 0; $i -lt $tcvnFrom.Count; $i++) { $TcvnToUni[[int]$tcvnFrom[$i]] = [char]$tcvnTo[$i]; $UniToTcvn[[int]$tcvnTo[$i]] = [byte]$tcvnFrom[$i] }

function ConvertFrom-Tcvn([byte[]]$Bytes) {
    $sb = New-Object Text.StringBuilder
    foreach ($b in $Bytes) { if ($TcvnToUni.ContainsKey([int]$b)) { [void]$sb.Append($TcvnToUni[[int]$b]) } else { [void]$sb.Append([char]$b) } }
    $sb.ToString()
}
function ConvertTo-Tcvn([string]$Text) {
    $out = New-Object Collections.Generic.List[byte]
    foreach ($ch in $Text.ToCharArray()) {
        $c = [int]$ch
        if ($c -lt 128) { $out.Add([byte]$c); continue }
        if ($UniToTcvn.ContainsKey($c)) { $out.Add($UniToTcvn[$c]); continue }
        $lower = [int][char]::ToLowerInvariant($ch)
        if ($UniToTcvn.ContainsKey($lower)) { $out.Add($UniToTcvn[$lower]); continue }
        $base = ([string]$ch).Normalize([Text.NormalizationForm]::FormD)[0]
        if ([int]$base -lt 128) { $out.Add([byte][int]$base) } else { $out.Add([byte][int][char]'?') }
    }
    , $out.ToArray()
}
# Lua 4 string literal of TCVN3 bytes; only printable ASCII is emitted raw.
function ConvertTo-LuaString([string]$Text) {
    $sb = New-Object Text.StringBuilder('"')
    foreach ($b in (ConvertTo-Tcvn $Text)) {
        if ($b -ge 32 -and $b -le 126 -and $b -ne 34 -and $b -ne 92) { [void]$sb.Append([char]$b) } else { [void]$sb.Append('\' + ([int]$b).ToString('000')) }
    }
    [void]$sb.Append('"'); $sb.ToString()
}
function Get-Plain([string]$Text) {
    $d = $Text.ToLowerInvariant().Replace([string][char]0x111, 'd').Normalize([Text.NormalizationForm]::FormD)
    [regex]::Replace($d, '\p{Mn}', '')
}

# ---------------------------------------------------------------- catalogs
Write-Host 'Dang trich bang vat pham tu PAK...'
New-Item -ItemType Directory -Force $ItemDir | Out-Null
$pakTool = Join-Path $Root 'PhongThanSource\Output\Tools\PakEntryExtract.exe'
$pathFile = Join-Path $ItemDir '_path.txt'
Push-Location $ServerRoot
try {
    foreach ($t in 'meleeweapon', 'rangeweapon', 'armor', 'ring', 'amulet', 'boot', 'belt', 'helm', 'cuff', 'pendant', 'horse', 'ibitem', 'magicscript', 'material', 'questkey') {
        [IO.File]::WriteAllBytes($pathFile, $Enc1252.GetBytes("\settings\item\001\$t.txt"))
        & $pakTool (Join-Path $ServerRoot 'package.ini') "@$pathFile" (Join-Path $ItemDir "$t.txt") | Out-Null
        if (-not (Test-Path -LiteralPath (Join-Path $ItemDir "$t.txt"))) { Copy-Item -LiteralPath (Join-Path $ServerRoot "settings\item\001\$t.txt") (Join-Path $ItemDir "$t.txt") }
    }
} finally { Pop-Location }
Write-Host 'Dang nap danh muc vat pham...'
$Items = New-Object Collections.Generic.List[object]
$lookup = Join-Path $Root 'Tra-cuu-vat-pham.txt'
if (Test-Path -LiteralPath $lookup) {
    foreach ($line in [IO.File]::ReadAllLines($lookup, [Text.Encoding]::UTF8)) {
        $c = $line -split "`t"
        if ($c.Count -lt 6 -or $c[1] -notmatch '^\d+$') { continue }
        $Items.Add([pscustomobject]@{ key = "$($c[0])|$($c[1])"; group = $c[0]; code = [int]$c[1]; name = $c[3]; table = $c[4]; line = [int]$c[5]; plain = (Get-Plain $c[3]) })
    }
}
$ItemByKey = @{}; foreach ($it in $Items) { $ItemByKey[$it.key] = $it }

# Set gear (do luc): armor/helm/boot/belt/pendant rows with set id (col 69).
# Armor rows fix particular -> (profession, variant); boot/belt have no profession
# requirement and reuse the same particular numbering. Tier = armor level req (type 36).
$GearTables = [ordered]@{ armor = 'Giap'; helm = 'Mu'; boot = 'Giay'; belt = 'That lung'; pendant = 'Boi' }
$GearPieces = New-Object Collections.Generic.List[object]
$gearRows = @{}
foreach ($t in $GearTables.Keys) {
    $lines = [IO.File]::ReadAllLines((Join-Path $ItemDir "$t.txt"), $Enc1252)
    $rows = New-Object Collections.Generic.List[object]
    for ($r = 1; $r -lt $lines.Count; $r++) {
        $c = $lines[$r] -split "`t"
        if ($c.Count -lt 70 -or $c[69] -notmatch '^[1-9]\d*$') { continue }
        $prof = -1; $req = 0
        for ($k = 44; $k -le 54; $k += 2) {
            if ($c[$k] -eq '37' -and $c[$k + 1] -match '^\d+$') { $prof = [int]$c[$k + 1] }
            if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] }
        }
        $rows.Add([pscustomobject]@{ set = [int]$c[69]; part = [int]("0$($c[3])" -replace '\D', ''); ilv = [int]("0$($c[11])" -replace '\D', ''); prof = $prof; req = $req; line = $r + 1; name = (ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#') })
    }
    $gearRows[$t] = $rows
}
$partMap = @{}; $setTier = @{}; $setName = @{}
foreach ($g in ($gearRows['armor'] | Group-Object set)) {
    foreach ($pg in ($g.Group | Where-Object { $_.prof -ge 0 } | Group-Object prof)) {
        $parts = @($pg.Group | ForEach-Object part | Sort-Object -Unique)
        for ($i = 0; $i -lt $parts.Count; $i++) { $partMap["$($g.Name)|$($parts[$i])"] = @([int]$pg.Name, ($i + 1)) }
    }
    $setTier[[int]$g.Name] = ($g.Group | Measure-Object req -Maximum).Maximum
}
foreach ($t in $GearTables.Keys) {
    foreach ($row in $gearRows[$t]) {
        $pm = $partMap["$($row.set)|$($row.part)"]
        if (-not $pm) { continue }
        if ($row.prof -ge 0 -and $row.prof -ne $pm[0]) { continue }
        $key = "$($GearTables[$t])|$($row.line - 1)"
        if (-not $ItemByKey.ContainsKey($key)) { continue }
        $GearPieces.Add([pscustomobject]@{ set = $row.set; tier = $setTier[$row.set]; prof = $pm[0]; variant = $pm[1]; piece = $GearTables[$t]; ilv = $row.ilv; req = $row.req; key = $key; name = $row.name })
        if ($t -eq 'armor' -and -not $setName["$($row.set)|$($pm[0])|$($pm[1])"]) { $setName["$($row.set)|$($pm[0])|$($pm[1])"] = $row.name }
    }
}

# Tier weapons (vu khi luc): melee/range rows with profession requirement (type 37)
# and a level requirement (type 36) >= 10; quest copies "(N.v)"/"nhiem vu" skipped.
$Weapons = New-Object Collections.Generic.List[object]
foreach ($wt in @(@('meleeweapon', 'Vu khi gan'), @('rangeweapon', 'Vu khi xa'))) {
    $lines = [IO.File]::ReadAllLines((Join-Path $ItemDir "$($wt[0]).txt"), $Enc1252)
    $seenW = @{}
    for ($r = 1; $r -lt $lines.Count; $r++) {
        $c = $lines[$r] -split "`t"
        if ($c.Count -lt 56) { continue }
        $prof = -1; $req = 0
        for ($k = 44; $k -le 54; $k += 2) {
            if ($c[$k] -eq '37' -and $c[$k + 1] -match '^\d+$') { $prof = [int]$c[$k + 1] }
            if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] }
        }
        if ($prof -lt 0 -or $req -lt 10) { continue }
        $name = ((ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#') -replace '<[^>]*>', '').Trim()
        if ((Get-Plain $name) -match 'nhiem vu|\(n\.v\)') { continue }
        $key = "$($wt[1])|$r"
        if (-not $ItemByKey.ContainsKey($key)) { continue }
        $sig = "$name|$req|$($c[11])|$($c[9])"; if ($seenW[$sig]) { continue }; $seenW[$sig] = $true
        # Series column 1000 marks the green (luc) rows that carry magic slots 6..10.
        $Weapons.Add([pscustomobject]@{ key = $key; name = $name; prof = $prof; req = $req; ilv = [int]("0$($c[11])" -replace '\D', ''); green = ($c[9] -eq '1000'); kind = $(if ($wt[0] -eq 'rangeweapon') { 'Tam xa' } else { 'Can chien' }) })
    }
}

# Max presets: rows whose attributes are fixed (min = max) in the VNG tables, the
# only reliable "max option" the unmodified engine can produce. (+12) rows carry
# the upgrade stat bonus in the template but no upgrade stars (nUpgradeLvl = 0).
$GroupByTable = @{ meleeweapon = 'Vu khi gan'; amulet = 'Day chuyen'; horse = 'Thu cuoi'; pendant = 'Boi' }
$tableCache2 = @{}
function Find-PresetRow([string]$Table, [int]$Part, [int]$Level) {
    if (-not $tableCache2.ContainsKey($Table)) { $tableCache2[$Table] = [IO.File]::ReadAllLines((Join-Path $ItemDir "$Table.txt"), $Enc1252) }
    $lines = $tableCache2[$Table]
    for ($r = 1; $r -lt $lines.Count; $r++) {
        $c = $lines[$r] -split "`t"
        if ($c[3] -eq "$Part" -and $c[11] -eq "$Level") {
            $prof = -1; $req = 0
            for ($k = 44; $k -le 54; $k += 2) {
                if ($c[$k] -eq '37' -and $c[$k + 1] -match '^\d+$') { $prof = [int]$c[$k + 1] }
                if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] }
            }
            $key = "$($GroupByTable[$Table])|$r"
            if (-not $ItemByKey.ContainsKey($key)) { return $null }
            return [pscustomobject]@{ key = $key; name = ((ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#') -replace '<[^>]*>', '').Trim(); prof = $prof; req = $req; part = $Part; level = $Level }
        }
    }
    $null
}
$Presets = New-Object Collections.Generic.List[object]
$presetDefs = @(
    @('Vu khi max - Tinh Quan Cap 10', 'meleeweapon', @(244, 245, 246, 247), 10),
    @('Vu khi Tinh Quan (+12) - chi so cuong hoa co san, khong co sao', 'meleeweapon', @(132, 133, 134, 135), 10),
    @('Thu cuoi max - Tinh Quan Cap 10', 'horse', @(60, 61, 62), 10),
    @('Thu cuoi max - Nghich (cap 10)', 'horse', @(24, 25, 26), 10),
    @('Thu cuoi - Bach Kim Nghich Thien', 'horse', @(27, 28, 29), 10),
    @('Thu cuoi - Phi Tuyet', 'horse', @(42, 43, 44), 10),
    @('Phap bao max cap 120 (o Ngoc boi)', 'amulet', @(89, 90, 91, 92, 143), 10),
    @('Phap bao That Bao Kim Lien (o Ngoc boi)', 'amulet', @(72, 73, 74), 10)
)
foreach ($pd in $presetDefs) {
    foreach ($pp in $pd[2]) {
        $row = Find-PresetRow $pd[1] $pp $pd[3]
        if ($row) { $Presets.Add([pscustomobject]@{ group = $pd[0]; key = $row.key; name = $row.name; prof = $row.prof; req = $row.req }) }
    }
}
# Phap bao list (amulet, worn in the JadePendant slot), one row per particular at level 10.
$Talismans = New-Object Collections.Generic.List[object]
$amuletLines = [IO.File]::ReadAllLines((Join-Path $ItemDir 'amulet.txt'), $Enc1252)
$seenA = @{}
for ($r = 1; $r -lt $amuletLines.Count; $r++) {
    $c = $amuletLines[$r] -split "`t"
    if ($c.Count -lt 56 -or $c[11] -ne '10') { continue }
    $key = "Day chuyen|$r"; if (-not $ItemByKey.ContainsKey($key)) { continue }
    $prof = -1; $req = 0
    for ($k = 44; $k -le 54; $k += 2) {
        if ($c[$k] -eq '37' -and $c[$k + 1] -match '^\d+$') { $prof = [int]$c[$k + 1] }
        if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] }
    }
    $name = ((ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#') -replace '<[^>]*>', '').Trim()
    if ($seenA["$name|$prof"]) { continue }; $seenA["$name|$prof"] = $true
    $Talismans.Add([pscustomobject]@{ key = $key; name = $name; prof = $prof; req = $req; part = $c[3] })
}
# Phap khi (VNG instrument.txt 0/11) and An (signet.txt 0/13): the engine cannot load those
# tables, so ptfix.pak appends them to amulet.txt as phap bao (particular 200+ / 250+), worn in
# the Ngoc + 2 Talisman slots. Rows are not in Tra-cuu-vat-pham.txt: register them here.
$Instruments = New-Object Collections.Generic.List[object]
$Signets = New-Object Collections.Generic.List[object]
$seenIS = @{}
for ($r = 1; $r -lt $amuletLines.Count; $r++) {
    $c = $amuletLines[$r] -split "`t"
    if ($c.Count -lt 56 -or $c[3] -notmatch '^\d+$' -or [int]$c[3] -lt 200) { continue }
    $name = ((ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#') -replace '<[^>]*>', '').Trim()
    $ilv = [int]("0$($c[11])" -replace '\D', '')
    if ($seenIS["$($c[3])|$ilv"]) { continue }; $seenIS["$($c[3])|$ilv"] = $true
    $key = "Day chuyen|$r"
    if (-not $ItemByKey.ContainsKey($key)) {
        $it = [pscustomobject]@{ key = $key; group = 'Day chuyen'; code = $r; name = $name; table = 'amulet.txt'; line = $r + 1; plain = (Get-Plain $name) }
        $Items.Add($it); $ItemByKey[$key] = $it
    }
    $req = 0
    for ($k = 44; $k -le 54; $k += 2) { if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] } }
    $o = [pscustomobject]@{ key = $key; name = $name; req = $req; ilv = $ilv; part = [int]$c[3] }
    if ([int]$c[3] -ge 250) { $Signets.Add($o) } else { $Instruments.Add($o) }
}

# Mounts: horse.txt requirement pairs (cols 44..55); type 37 = profession (0 Giap Si,
# 1 Dao Si, 2 Di Nhan), type 36 = character level. No type 37 = usable by everyone.
$Mounts = New-Object Collections.Generic.List[object]
$horseLines = [IO.File]::ReadAllLines((Join-Path $ItemDir 'horse.txt'), $Enc1252)
foreach ($it in $Items) {
    if ($it.group -ne 'Thu cuoi' -or $it.line -gt $horseLines.Count) { continue }
    $c = $horseLines[$it.line - 1] -split "`t"
    $prof = -1; $req = 0
    for ($k = 44; $k -le 54; $k += 2) {
        if ($c[$k] -eq '37' -and $c[$k + 1] -match '^\d+$') { $prof = [int]$c[$k + 1] }
        if ($c[$k] -eq '36' -and $c[$k + 1] -match '^\d+$') { $req = [int]$c[$k + 1] }
    }
    $Mounts.Add([pscustomobject]@{ key = $it.key; name = $it.name; prof = $prof; req = $req; plain = $it.plain })
}
# Bi kip he phai (2026-10-03, agent bikip2): ptfix extra_bikip.py magicscript rows 62000 + skill, right click = learn
# (script\phongthan\item\bikip_<skill>.lua). Skills per profession; 62 / 128 are life books for every profession.
$BiKipByProf = @{ 0 = @(27..42) + @(62, 128); 1 = @(3..26) + @(62, 128); 2 = @(43..51) + @(450..458) + @(62, 128) }
# "Dong sach (ep bi kip)" materials at every city Vo su (pt_bikip.lua PTBK_RECIPE): Khong Thu = ibitem 8/139..142/2,
# Manh Hong Thuy Tinh 3/77, Hong Thuy Tinh 3/28, Hong Bao Thach 3/79. One press of a tier = its largest VNG recipe.
$BiKipMats = [ordered]@{
    p139 = @(8, 139, 2, 'Bach Khong Thu'); p140 = @(8, 140, 2, 'Lam Khong Thu'); p141 = @(8, 141, 2, 'Hong Khong Thu'); p142 = @(8, 142, 2, 'Hoang Khong Thu')
    m77 = @(3, 77, 0, 'Manh Hong Thuy Tinh'); m28 = @(3, 28, 0, 'Hong Thuy Tinh'); m79 = @(3, 79, 0, 'Hong Bao Thach')
}
$BiKipTier = @{ 139 = @{ p139 = 2; m77 = 1 }; 140 = @{ p140 = 2; m28 = 1 }; 141 = @{ p141 = 2; m79 = 1 }; 142 = @{ p142 = 1; m79 = 3 } }
# Than Ky (2026-10-05, agent thanky; ptfix extra_thanky.py, script\phongthan\thanky\tk_lib.lua): VNG skills 1986-2000.
# skill = @(profession, Manh Than Ky key (stack 250, 30 -> 1 book), book keys cap 1..5). Book right click = learn / raise
# to its cap (cap 5: +1 level per book up to 10). Vien Thuoc Tinh 6855..6866 (Suc Manh, Ngo Tinh, The Chat, Than Phap x
# So / Trung / Cao = +2 / +5 / +10, max 100 per stat, tasks 2690..2693), Tui Thuoc Tinh 6854 / (Trung) 6982.
$ThanKy = @{
    1986 = @(0, 8352, @(8375, 8381, 8387, 8393, 8399)); 1996 = @(2, 8353, @(8376, 8382, 8388, 8394, 8400))
    1990 = @(1, 8354, @(8377, 8383, 8389, 8395, 8401)); 1991 = @(1, 8355, @(8378, 8384, 8390, 8396, 8402))
    1993 = @(1, 8356, @(8379, 8385, 8391, 8397, 8403)); 1994 = @(1, 8357, @(8380, 8386, 8392, 8398, 8404))
}
$ThanKyStones = @(6854, 6982) + @(6855..6866)
$TableCache = @{}
function Get-ItemCode([string]$Key) {
    # Project starter bag (Sources\Core\Src\PhongThanStarterBag.h): reusable item picker.
    if ($Key -eq 'StarterBag') { return @{ g = 6; d = 61000; p = 0; lv = 1; se = 0; name = 'Tui tan thu' } }
    # World-boss token (ptfix.pak magicscript row 61001, script\phongthan\item\boss_lenhbai.lua).
    if ($Key -eq 'BossToken') { return @{ g = 6; d = 61001; p = 0; lv = 1; se = 0; name = 'Lenh Bai Boss The Gioi' } }
    # Remote sell token (ptfix.pak magicscript row 61002, script\phongthan\item\huydo_lenhbai.lua).
    if ($Key -eq 'SellToken') { return @{ g = 6; d = 61002; p = 0; lv = 1; se = 0; name = 'Lenh Bai Huy Do' } }
    # Di Nhan summon token (ptfix.pak magicscript row 61003, script\phongthan\item\trieuhoi_lenhbai.lua).
    if ($Key -eq 'SummonToken') { return @{ g = 6; d = 61003; p = 0; lv = 1; se = 0; name = 'Lenh Bai Trieu Hoi' } }
    # Leveling-spot token (2026-10-03, agent luyencong; ptfix extra_luyencong.py magicscript row 61420, luyencong_lenhbai.lua).
    if ($Key -eq 'LuyenCongToken') { return @{ g = 6; d = 61420; p = 0; lv = 1; se = 0; name = 'Lenh Bai Luyen Cong' } }
    # Quest-NPC teleport token + quest-item supply token (2026-10-04, agent lenhbainv; ptfix extra_lenhbainv.py
    # magicscript rows 61430 / 61431, nhiemvu_lenhbai.lua / tiepte_lenhbai.lua).
    if ($Key -eq 'NhiemVuToken') { return @{ g = 6; d = 61430; p = 0; lv = 1; se = 0; name = 'Lenh Bai Nhiem Vu' } }
    if ($Key -eq 'TiepTeToken') { return @{ g = 6; d = 61431; p = 0; lv = 1; se = 0; name = 'Lenh Bai Tiep Te Nhiem Vu' } }
    # Tham Quan token (2026-10-04, agent lenhbainv5; extra_lenhbainv.py magicscript row 61432, thamquan_lenhbai.lua).
    if ($Key -eq 'ThamQuanToken') { return @{ g = 6; d = 61432; p = 0; lv = 1; se = 0; name = 'Lenh Bai Tham Quan' } }
    # Van Tien tran / Thuong Chu battlefield tokens (2026-10-04, agent vtcc; ptfix extra_vtcc.py magicscript rows
    # 61470 / 61471, vantien_lenhbai.lua / thuongchu_lenhbai.lua, 1-hour cooldown in tasks 2670 / 2671).
    if ($Key -eq 'VanTienToken') { return @{ g = 6; d = 61470; p = 0; lv = 1; se = 0; name = 'Lenh Bai Van Tien Tran' } }
    if ($Key -eq 'ThuongChuToken') { return @{ g = 6; d = 61471; p = 0; lv = 1; se = 0; name = 'Lenh Bai Chien Truong Thuong Chu' } }
    # Auto-fight skill set tokens (2026-10-04, agent lbdaosi; ptfix extra_lbdaosi.py magicscript rows 61480 / 61481,
    # lbdaosi_lenhbai.lua / lbdinhan_lenhbai.lua, sets in tasks 2613 / 2614, action 'lbskills').
    if ($Key -eq 'DaoSiToken') { return @{ g = 6; d = 61480; p = 0; lv = 1; se = 0; name = 'Lenh Bai Dao Si' } }
    if ($Key -eq 'DiNhanToken') { return @{ g = 6; d = 61481; p = 0; lv = 1; se = 0; name = 'Lenh Bai Di Nhan' } }
    # lbdaosi r3: Lenh Bai Giap Si (magicscript 61482, lbgiapsi_lenhbai.lua, set in task 2619).
    if ($Key -eq 'GiapSiToken') { return @{ g = 6; d = 61482; p = 0; lv = 1; se = 0; name = 'Lenh Bai Giap Si' } }
    # Lenh Bai Hanh Trang (2026-10-04, agent items; ptfix extra_hanhtrang.py magicscript row 61500, hanhtrang_lenhbai.lua):
    # box anywhere, clean bag, pickup filter (task 2640) / clean-bag filter (2641 / 2642), action 'hanhtrang'.
    if ($Key -eq 'HanhTrangToken') { return @{ g = 6; d = 61500; p = 0; lv = 1; se = 0; name = 'Lenh Bai Hanh Trang' } }
    # Permanent full-heal bottles (2026-10-04, agent kytrancac; ptfix extra_kytrancac.py magicscript rows 61520 / 61521,
    # vinhcuu_sinhluc.lua / vinhcuu_noiluc.lua): never consumed, quick bar (1-0), 2 s cooldown. Also sold in Ky Tran Cac.
    if ($Key -eq 'BinhSinhLucVC') { return @{ g = 6; d = 61520; p = 0; lv = 1; se = 0; name = 'Binh Sinh Luc Vinh Cuu' } }
    if ($Key -eq 'BinhNoiLucVC') { return @{ g = 6; d = 61521; p = 0; lv = 1; se = 0; name = 'Binh Noi Luc Vinh Cuu' } }
    # Pet food (2026-10-05, agent nuoithu; script\phongthan\item\nuoithu_lib.lua): Linh Thu Don 61379 (extra_sinhhoat.py,
    # +30 linh thu exp), Linh Thu Dai Don 61551 (+300) and De Tu Linh Don 61550 (+1000 Di Nhan pet exp) of
    # extra_nuoithu.py. Stack 100. Actions 'nuoithugive' (count 1..1000) and 'nuoithu' (feed full / max level).
    if ($Key -eq 'NuoiThuLTDon') { return @{ g = 6; d = 61379; p = 0; lv = 1; se = 0; name = 'Linh Thu Don' } }
    if ($Key -eq 'NuoiThuLTDai') { return @{ g = 6; d = 61551; p = 0; lv = 1; se = 0; name = 'Linh Thu Dai Don' } }
    if ($Key -eq 'NuoiThuDTDon') { return @{ g = 6; d = 61550; p = 0; lv = 1; se = 0; name = 'De Tu Linh Don' } }
    # Rebirth skill books (ptfix.pak magicscript rows 61011..61019 = skill 1481..1489, sach_kn_<id>.lua).
    if ($Key -match '^SkillBook(\d{4})$') {
        $sid = [int]$Matches[1]
        if ($sid -lt 1481 -or $sid -gt 1489) { throw "Sach ky nang $sid khong ton tai" }
        return @{ g = 6; d = 61011 + $sid - 1481; p = 0; lv = 1; se = 0; name = "Sach Ky Nang $sid" }
    }
    # Bi kip he phai (magicscript 62000 + skill), e.g. BiKip32 = Hoanh Khong Tram.
    if ($Key -match '^BiKip(\d+)$') {
        $sid = [int]$Matches[1]
        if (-not (@($BiKipByProf.Values | ForEach-Object { $_ }) -contains $sid)) { throw "Bi kip $sid khong ton tai" }
        return @{ g = 6; d = 62000 + $sid; p = 0; lv = 1; se = 0; name = "Bi Kip $sid" }
    }
    $it = $ItemByKey[$Key]; if (-not $it) { throw "Khong tim thay vat pham $Key" }
    switch ($it.group) {
        'MagicScript' { return @{ g = 6; d = $it.code; p = 0; lv = 1; se = 0; name = $it.name } }
        'Nguyen lieu' { return @{ g = 3; d = $it.code; p = 0; lv = 1; se = 0; name = $it.name } }
        'Nhiem vu'    { return @{ g = 4; d = $it.code; p = 0; lv = 1; se = 0; name = $it.name } }
    }
    if (-not $TableCache.ContainsKey($it.table)) { $TableCache[$it.table] = [IO.File]::ReadAllLines((Join-Path $ItemDir $it.table), $Enc1252) }
    $row = $TableCache[$it.table][$it.line - 1] -split "`t"
    $num = { param($v, $def) if ("$v" -match '^-?\d+$') { [int]$v } else { $def } }
    if ($it.group -eq 'Ky tran cac') { return @{ g = (& $num $row[1] 8); d = (& $num $row[2] 0); p = (& $num $row[3] 0); lv = 1; se = 0; name = $it.name } }
    @{ g = (& $num $row[1] 0); d = (& $num $row[2] 0); p = (& $num $row[3] 0); lv = (& $num $row[11] 1); se = (& $num $row[9] 0); name = $it.name }
}

Write-Host 'Dang nap danh sach NPC va ban do...'
$Npcs = New-Object Collections.Generic.List[object]
$npcLines = [IO.File]::ReadAllLines((Join-Path $ServerRoot 'settings\phongthan\Npcs.txt'), $Enc1252)
for ($i = 1; $i -lt $npcLines.Count; $i++) {
    $c = $npcLines[$i] -split "`t", 3
    if (-not $c[0]) { continue }
    $raw = $Enc1252.GetBytes($c[0])
    $name = if (($raw | Where-Object { $_ -ge 128 }).Count) { $EncGbk.GetString($raw) } else { $c[0] }
    $name = $name -replace '<[^>]*>', ''
    $Npcs.Add([pscustomobject]@{ id = $i - 1; name = $name; kind = [int]("0$($c[1])" -replace '\D', ''); plain = (Get-Plain $name) })
}
# Profession skills (Sources\Core\Src\KPhongThanProfessionSkills.h):
# 0 Giap Si 27-42, 1 Dao Si 3-26, 2 Di Nhan 43-51. Skills.txt: 0 name, 2 id, 4 style, 49 max level.
$ProfRanges = @{ 0 = @(27, 42); 1 = @(3, 26); 2 = @(43, 51) }
$Skills = New-Object Collections.Generic.List[object]
$seenSkill = @{}
foreach ($line in [IO.File]::ReadAllLines((Join-Path $ServerRoot 'settings\Skills.txt'), $Enc1252)) {
    $c = $line -split "`t"
    if ($c.Count -lt 50 -or $c[2] -notmatch '^\d+$') { continue }
    $id = [int]$c[2]
    if ($seenSkill[$id]) { continue }
    foreach ($p in $ProfRanges.Keys) {
        if ($id -ge $ProfRanges[$p][0] -and $id -le $ProfRanges[$p][1]) {
            $seenSkill[$id] = $true
            $max = if ($c[49] -match '^\d+$') { [Math]::Min(10, [int]$c[49]) } else { 10 }
            $Skills.Add([pscustomobject]@{ id = $id; prof = $p; name = (ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])).TrimStart('#'); style = [int]("0$($c[4])" -replace '\D', ''); max = $max; tier = 0 })
        }
    }
}
# VNG rebirth skills Lv.60/120/180 (2026-10-01, level scripts + skills.txt rows in ptfix.pak v9).
# Outside the 3-51 profession ranges, so they are listed and allowed separately.
$RebirthSkills = @(
    @(1481, 0, 60, 3, 'Huy\u1ebft Chi\u1ebfn Sa Tr\u01b0\u1eddng'), @(1482, 0, 120, 3, 'D\u0129 Chi\u1ebfn D\u01b0\u1ee1ng Chi\u1ebfn'), @(1483, 0, 180, 3, 'B\u00e1ch Chi\u1ebfn D\u01b0 Sinh'),
    @(1484, 1, 60, 3, 'Nghi\u1ec7p H\u1ecfa Ph\u1ea7n T\u00e2m'), @(1485, 1, 120, 3, 'H\u1ea1o Nhi\u00ean Ch\u00ednh Kh\u00ed'), @(1486, 1, 180, 3, 'D\u1eabn H\u1ecfa Thi\u00eau Th\u00e2n'),
    @(1487, 2, 60, 3, '\u0110\u1ed9c H\u00e0nh Thi\u00ean H\u1ea1'), @(1488, 2, 120, 2, 'C\u1ed5 Ho\u1eb7c Ch\u00fang Sinh'), @(1489, 2, 180, 2, 'V\u1ea1n \u0110\u1ed9c H\u1ed9 Th\u00e2n'))
$RebirthByProf = @{ 0 = @(); 1 = @(); 2 = @() }
foreach ($r in $RebirthSkills) {
    $Skills.Add([pscustomobject]@{ id = $r[0]; prof = $r[1]; name = [regex]::Unescape($r[4]); style = $r[3]; max = 10; tier = $r[2] })
    $RebirthByProf[$r[1]] += $r[0]
}
# Di Nhan summon skills "Ky nang de tu (trieu hoi)" (2026-10-02, ptfix plug-in extra_petskill.py:
# skills.txt rows 450-461, SkillStyle 4). id, required level, name. Allowed for prof 2 via $RebirthByProf.
$PetSkills = @(
    @(450, 5, 'L\u1ef1c S\u0129 t\u1ebf'), @(451, 15, 'Tr\u01b0\u1eddng Cung t\u1ebf'), @(452, 25, 'Thi\u00ean V\u0169 t\u1ebf'), @(453, 35, 'Li\u00ean N\u1ed7 t\u1ebf'),
    @(454, 45, 'H\u1ecfa L\u00f4i t\u1ebf'), @(455, 55, 'To\u00e1i C\u1ed1t t\u1ebf'), @(456, 65, 'L\u01b0u Tinh t\u1ebf'), @(457, 75, 'Truy H\u1ed3n t\u1ebf'),
    @(458, 85, 'Phong Quy\u1ec3n T\u00e0n V\u00e2n'), @(459, 95, 'Cu\u1ed3ng \u0110\u00e0o t\u1ebf'), @(460, 105, 'Ng\u1ef1 S\u1eadu B\u1ea1o Phong'), @(461, 120, 'Huy\u1ec1n \u1ea2nh T\u00e1n Hoa'))
foreach ($r in $PetSkills) {
    $Skills.Add([pscustomobject]@{ id = $r[0]; prof = 2; name = [regex]::Unescape($r[2]); style = 4; max = 10; tier = 0; pet = 1; req = $r[1] })
    $RebirthByProf[2] += $r[0]
}
$Maps = New-Object Collections.Generic.List[object]
$mapNames = @{}
foreach ($line in [IO.File]::ReadAllLines((Join-Path $ServerRoot 'settings\MapList.ini'), $Enc1252)) {
    if ($line -match '^(\d+)_name=\$?(.*)$') { $mapNames[1000 + [int]$Matches[1]] = ConvertFrom-Tcvn ($Enc1252.GetBytes($Matches[2].Trim())) }
}
foreach ($line in [IO.File]::ReadAllLines((Join-Path $ServerRoot 'maps\WorldSet.ini'))) {
    if ($line -match '^World\d+=(\d+)') { $id = [int]$Matches[1]; $Maps.Add([pscustomobject]@{ id = $id; name = $(if ($mapNames[$id]) { $mapNames[$id] } else { "Ban do $id" }) }) }
}

# ---------------------------------------------------------------- state
$HistoryPath = Join-Path $DataDir 'history.json'
$EventsPath = Join-Path $DataDir 'events.json'
function Read-JsonList([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return , (New-Object Collections.ArrayList) }
    $list = New-Object Collections.ArrayList
    $data = [IO.File]::ReadAllText($Path, $Utf8) | ConvertFrom-Json
    foreach ($x in @($data)) { if ($x) { [void]$list.Add($x) } }
    , $list
}
function Save-Json([string]$Path, $Value) { [IO.File]::WriteAllText($Path, (ConvertTo-Json -InputObject ([object[]]$Value.ToArray()) -Depth 8), $Utf8) }
$History = Read-JsonList $HistoryPath
$Events = Read-JsonList $EventsPath
$script:ResultOffset = 0L
$script:Seq = 0

# ---------------------------------------------------------------- bridge
function Add-BridgeCommand([string]$Type, [string]$Description, [string]$LuaTemplate) {
    $script:Seq++
    $id = 'c' + (Get-Date -Format 'MMddHHmmss') + $script:Seq
    $lua = $LuaTemplate.Replace('{ID}', "`"$id`"") + "`n"
    $bytes = $Enc1252.GetBytes($lua)
    $pending = Join-Path $Bridge 'pending.lua'
    $tmp = Join-Path $Bridge ('write_' + $id + '.tmp')
    for ($try = 0; $try -lt 5; $try++) {
        try {
            if (Test-Path -LiteralPath $pending) {
                $old = [IO.File]::ReadAllBytes($pending)
                [IO.File]::WriteAllBytes($tmp, [byte[]]($old + $bytes))
                try { [IO.File]::Replace($tmp, $pending, [NullString]::Value); break }
                catch [IO.FileNotFoundException] { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue }
            }
            [IO.File]::WriteAllBytes($tmp, $bytes)
            [IO.File]::Move($tmp, $pending); break
        } catch { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue; Start-Sleep -Milliseconds 100; if ($try -eq 4) { throw } }
    }
    $entry = [pscustomobject]@{ id = $id; time = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); type = $Type; desc = $Description; status = 'PENDING'; detail = 'Cho server xu ly (toi da ~60 giay)' }
    [void]$History.Insert(0, $entry)
    while ($History.Count -gt 300) { $History.RemoveAt($History.Count - 1) }
    Save-Json $HistoryPath $History
    $entry
}
function Update-Results {
    $log = Join-Path $Bridge 'result.log'
    if (-not (Test-Path -LiteralPath $log)) { return }
    $fs = [IO.File]::Open($log, 'Open', 'Read', 'ReadWrite')
    try {
        if ($fs.Length -lt $script:ResultOffset) { $script:ResultOffset = 0 }
        [void]$fs.Seek($script:ResultOffset, 'Begin')
        $buf = New-Object byte[] ($fs.Length - $script:ResultOffset)
        $n = $fs.Read($buf, 0, $buf.Length); $script:ResultOffset += $n
    } finally { $fs.Dispose() }
    if (-not $n) { return }
    $changed = $false
    foreach ($line in ($Enc1252.GetString($buf, 0, $n) -split "`r?`n")) {
        $c = $line -split "`t"; if ($c.Count -lt 3) { continue }
        foreach ($h in $History) { if ($h.id -eq $c[1]) { $h.status = $c[2]; $h.detail = "$($c[0]) $($c[3])"; $changed = $true } }
    }
    if ($changed) { Save-Json $HistoryPath $History }
}
function Get-Online {
    $path = Join-Path $Bridge 'online.txt'
    $list = @(); $stamp = $null
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) {
            $c = $l -split "`t"; if ($c.Count -lt 6) { continue }
            $map = [int]$c[3]
            $list += [pscustomobject]@{ name = (ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])); account = $c[1]; level = $c[2]; map = $map; mapName = $(if ($mapNames[$map]) { $mapNames[$map] } else { "$map" }); x = $c[4]; y = $c[5]; prof = $(if ($c.Count -ge 7 -and $c[6] -match '^-?\d+$') { [int]$c[6] } else { -1 }) }
        }
    }
    [pscustomobject]@{ stamp = $stamp; players = $list }
}
function Get-Status {
    $hb = Join-Path $Bridge 'heartbeat.txt'
    $procs = @(Get-CimInstance Win32_Process | Where-Object { $_.ExecutablePath -and $_.ExecutablePath.StartsWith($ServerRoot + '\', [StringComparison]::OrdinalIgnoreCase) } | ForEach-Object { $_.Name })
    [pscustomobject]@{
        heartbeat = $(if (Test-Path -LiteralPath $hb) { [IO.File]::ReadAllText($hb) } else { $null })
        heartbeatAgeSec = $(if (Test-Path -LiteralPath $hb) { [int]((Get-Date) - (Get-Item -LiteralPath $hb).LastWriteTime).TotalSeconds } else { -1 })
        pendingQueued = (Test-Path -LiteralPath (Join-Path $Bridge 'pending.lua'))
        services = $procs
        now = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
    }
}
# World bosses (VNG \script\boss<refresh>\*.lua): static table data\worldboss.json + live state
# written every minute by script\phongthan\boss\wb_lib.lua into admin_bridge\worldboss.txt
# (key, state 1 alive / -1 killed / 0 not spawned, spawn hhmm, death hhmm, next hhmm, killer).
$WorldBossPath = Join-Path $DataDir 'worldboss.json'
$WorldBoss = if (Test-Path -LiteralPath $WorldBossPath) { @([IO.File]::ReadAllText($WorldBossPath, $Utf8) | ConvertFrom-Json) } else { @() }
function Format-HHMM([string]$v) { if ($v -notmatch '^\d+$' -or [int]$v -le 0) { return '' }; $n = [int]$v; '{0:00}:{1:00}' -f [Math]::Floor($n / 100), ($n % 100) }
function Get-WorldBoss {
    $path = Join-Path $Bridge 'worldboss.txt'
    $live = @{}; $stamp = $null
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) { $c = $l -split "`t"; if ($c.Count -ge 5) { $live[$c[0]] = $c } }
    }
    $list = foreach ($b in $WorldBoss) {
        $c = $live[$b.key]
        $st = if ($c) { [int]$c[1] } else { 0 }
        $death = if ($c) { Format-HHMM $c[3] } else { '' }
        [pscustomobject]@{
            key = $b.key; name = $b.name; map = $b.map; mapName = $b.mapName; level = $b.level; dx = $b.dx; dy = $b.dy; schedule = $b.schedule
            state = $(if ($st -eq 1) { 'alive' } elseif ($st -eq -1 -and $death) { 'killed' } else { 'waiting' })
            spawn = $(if ($c) { Format-HHMM $c[2] } else { '' }); death = $death
            next = $(if ($c) { Format-HHMM $c[4] } else { '' })
            killer = $(if ($c -and $c.Count -ge 6 -and $c[5]) { ConvertFrom-Tcvn $Enc1252.GetBytes($c[5]) } else { '' })
        }
    }
    [pscustomobject]@{ stamp = $stamp; bosses = @($list) }
}
# Van Tien tran (2026-10-02): live state written every minute (and after an admin open) by
# script\phongthan\vantien\vt_timer.lua PTVT_WriteStatus into admin_bridge\vantien.txt:
# line 1 time, then n, state (0 closed / 1 preparation / 2 fighting / 3 cleared), kill mask, players inside, seconds left, key.
function Get-VanTien {
    $path = Join-Path $Bridge 'vantien.txt'
    $live = @{}; $stamp = $null
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) { $c = $l -split "`t"; if ($c.Count -ge 5 -and $c[0] -match '^\d$') { $live[[int]$c[0]] = $c } }
    }
    $names = @('', 'Tho', 'Thuy', 'Hoa', 'Phong'); $minLv = @(0, 30, 51, 71, 91); $maps = @(0, 1079, 1080, 1081, 1082)
    $list = foreach ($n in 1..4) {
        $c = $live[$n]
        $st = if ($c) { [int]$c[1] } else { 0 }
        $mask = if ($c) { [int]$c[2] } else { 0 }
        $tien = 0; foreach ($b in 1, 2, 4, 8) { if ($mask -band $b) { $tien++ } }
        [pscustomobject]@{
            tran = $n; name = $names[$n]; minLevel = $minLv[$n]; map = $maps[$n]; state = $st
            tien = $(if ($st -gt 0) { $tien } else { 0 }); thongThien = [bool]($st -gt 0 -and ($mask -band 16))
            inside = $(if ($c) { [int]$c[3] } else { 0 }); restSec = $(if ($c) { [int]$c[4] } else { 0 })
        }
    }
    [pscustomobject]@{ stamp = $stamp; trans = @($list) }
}
# Bot gia nguoi choi (2026-10-02): config -> admin_bridge\bots_config.lua (re-read every minute by
# script\phongthan\bots\bots.lua; action 'bots' also queues PTBOT_AdminApply() to apply it at once),
# web copy in data\bots.json. Status admin_bridge\bots.txt (PTBot_WriteStatus): line 1 time, then
# cfg/enabled/follow/followCount/source/max, total/alive/target, follow/alive/target/players,
# spot/i/map/x/y/target/alive/level/loaded (x, y in cells).
$BotsJsonPath = Join-Path $DataDir 'bots.json'
function Get-BotsConfig {
    if (Test-Path -LiteralPath $BotsJsonPath) { try { return ([IO.File]::ReadAllText($BotsJsonPath, $Utf8) | ConvertFrom-Json) } catch { } }
    [pscustomobject]@{ enabled = $true; follow = $true; followCount = 40; spots = @(); party = $true; partyCount = 4; partyBonus = 15 }
}
function Get-Bots {
    $path = Join-Path $Bridge 'bots.txt'
    $st = [ordered]@{ stamp = $null; enabled = $null; source = ''; alive = 0; target = 0; followAlive = 0; followTarget = 0; players = 0; spots = @()
        party = $null; partyCount = 0; partyBonus = 0; partyPlayers = 0; partyAlive = 0; partyExp = $false }
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $st.stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) {
            $c = $l -split "`t"
            if ($c[0] -eq 'cfg' -and $c.Count -ge 5) { $st.enabled = ($c[1] -eq '1'); $st.source = $c[4] }
            elseif ($c[0] -eq 'total' -and $c.Count -ge 3) { $st.alive = [int]$c[1]; $st.target = [int]$c[2] }
            elseif ($c[0] -eq 'follow' -and $c.Count -ge 4) { $st.followAlive = [int]$c[1]; $st.followTarget = [int]$c[2]; $st.players = [int]$c[3] }
            # 2026-10-03 botparty: party/on/count/bonus%/players with a party/party bots alive/EXP bonus in CoreServer
            elseif ($c[0] -eq 'party' -and $c.Count -ge 7) { $st.party = ($c[1] -eq '1'); $st.partyCount = [int]$c[2]; $st.partyBonus = [int]$c[3]; $st.partyPlayers = [int]$c[4]; $st.partyAlive = [int]$c[5]; $st.partyExp = ($c[6] -eq '1') }
            elseif ($c[0] -eq 'spot' -and $c.Count -ge 9) {
                $m = [int]$c[2]
                $st.spots += [pscustomobject]@{ index = [int]$c[1]; map = $m; mapName = $(if ($mapNames[$m]) { $mapNames[$m] } else { "$m" }); x = [int]$c[3]; y = [int]$c[4]; target = [int]$c[5]; alive = [int]$c[6]; level = [int]$c[7]; loaded = ($c[8] -eq '1') }
            }
        }
    }
    [pscustomobject]@{ config = (Get-BotsConfig); status = [pscustomobject]$st; maxTotal = 100 }
}
function Set-Bots($a) {
    $mapIds = @{}; foreach ($m in $Maps) { $mapIds[[int]$m.id] = 1 }
    $en = [bool]$a.enabled; $fo = [bool]$a.follow; $fc = Clamp $a.followCount 0 100
    # 2026-10-03 botparty: to doi bot (missing fields from an old page keep the defaults: on, 4 bots, 15%)
    $pa = if ($null -eq $a.party) { $true } else { [bool]$a.party }
    $pc = if ($null -eq $a.partyCount) { 4 } else { Clamp $a.partyCount 0 7 }
    $pb = if ($null -eq $a.partyBonus) { 15 } else { Clamp $a.partyBonus 0 50 }
    $spots = @()
    foreach ($s in @($a.spots)) {
        if ($null -eq $s) { continue }
        $m = [int]$s.map
        if (-not $mapIds.ContainsKey($m)) { throw "Ban do $m khong co trong danh sach ban do cua server." }
        $spots += [pscustomobject]@{ map = $m; x = (Clamp $s.x 0 65535); y = (Clamp $s.y 0 65535); count = (Clamp $s.count 0 100); level = (Clamp $s.level 0 200) }
    }
    if ($spots.Count -gt 20) { throw 'Toi da 20 dia diem dat bot.' }
    $sum = 0; foreach ($s in $spots) { $sum += $s.count }
    $total = if ($en) { [Math]::Min(100, $fc + $sum) } else { 0 }
    $text = "-- Written by AdminWeb (tab Bot gia nguoi choi) $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); read by script\phongthan\bots\bots.lua`n"
    $text += "PTBOT_CFG = { enabled = $([int]$en), follow = $([int]$fo), followCount = $fc, party = $([int]$pa), partyCount = $pc, partyBonus = $pb, spots = {`n"
    foreach ($s in $spots) { $text += "`t{ map = $($s.map), x = $($s.x), y = $($s.y), count = $($s.count), level = $($s.level) },`n" }
    $text += "} }`n"
    $dst = Join-Path $Bridge 'bots_config.lua'; $tmp = Join-Path $Bridge 'bots_config.tmp'
    [IO.File]::WriteAllBytes($tmp, $Enc1252.GetBytes($text))
    if (Test-Path -LiteralPath $dst) { [IO.File]::Replace($tmp, $dst, [NullString]::Value) } else { [IO.File]::Move($tmp, $dst) }
    [IO.File]::WriteAllText($BotsJsonPath, (ConvertTo-Json -InputObject ([pscustomobject]@{ enabled = $en; follow = $fo; followCount = $fc; spots = @($spots); party = $pa; partyCount = $pc; partyBonus = $pb }) -Depth 5), $Utf8)
    $desc = if (-not $en) { 'Tat het bot' } else { "Bot: tu do $fc ($(if ($fo) { 'theo nguoi choi' } else { 'di dao' })), $($spots.Count) dia diem, tong $total" + $(if ($fc + $sum -gt 100) { ' (cat con 100)' } else { '' }) + $(if ($pa) { "; to doi bot $pc x $pb%" } else { '; tat to doi bot' }) }
    # 'not PTBP_Tick': a server started before the botparty update loads the new bots.lua here (hot reload)
    Add-BridgeCommand 'Bot gia nguoi choi' $desc ("if not PTBP_Tick then dofile(`"script\\phongthan\\bots\\bots.lua`") end local n = PTBOT_AdminApply() PTAdm_Log({ID}, `"OK`", `"bot dang song: `" .. n .. `" / $total`")")
}
# Mat do & hoi quai (2026-10-04, quaimatdo): config -> admin_bridge\matdo_config.lua (read every minute by
# script\phongthan\ext\matdo.lua; action 'matdo' also queues PTEXT_matdo_Apply() to apply it at once), web copy in
# data\matdo.json. Status admin_bridge\matdo.txt (PTMD_WriteStatus): line 1 time, then cfg/density x10/revive s/all/
# source, total/npc count/extras/cap/seeds/state/added/removed/revive pass/revive set/players,
# map/id/seeds/extras/allocation/wanted/hot/in scope/revive s.
$MatDoJsonPath = Join-Path $DataDir 'matdo.json'
$MatDoMaps = @(1014, 1016, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1015, 1017, 1018, 1019, 1065, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1053, 1054, 1055, 1056, 1072, 1077, 1078, 1073, 1074, 1075, 1076)
function Get-MatDoConfig {
    if (Test-Path -LiteralPath $MatDoJsonPath) { try { return ([IO.File]::ReadAllText($MatDoJsonPath, $Utf8) | ConvertFrom-Json) } catch { } }
    [pscustomobject]@{ density = 20; revive = 10; all = $true; maps = @() }
}
function Get-MatDo {
    $path = Join-Path $Bridge 'matdo.txt'
    $st = [ordered]@{ stamp = $null; density = 10; revive = 0; all = $true; source = ''; npc = 0; extras = 0; cap = 0; seeds = 0; state = ''; added = 0; removed = 0; revivePass = ''; reviveSet = 0; players = 0 }
    $live = @{}
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $st.stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) {
            $c = $l -split "`t"
            if ($c[0] -eq 'cfg' -and $c.Count -ge 5) { $st.density = [int]$c[1]; $st.revive = [int]$c[2]; $st.all = ($c[3] -eq '1'); $st.source = $c[4] }
            elseif ($c[0] -eq 'total' -and $c.Count -ge 11) { $st.npc = [int]$c[1]; $st.extras = [int]$c[2]; $st.cap = [int]$c[3]; $st.seeds = [int]$c[4]; $st.state = $c[5]; $st.added = [int]$c[6]; $st.removed = [int]$c[7]; $st.revivePass = $c[8]; $st.reviveSet = [int]$c[9]; $st.players = [int]$c[10] }
            elseif ($c[0] -eq 'map' -and $c.Count -ge 9) { $live[[int]$c[1]] = $c }
        }
    }
    $maps = foreach ($m in $MatDoMaps) {
        $c = $live[$m]
        [pscustomobject]@{ id = $m; name = $(if ($mapNames[$m]) { $mapNames[$m] } else { "$m" })
            seeds = $(if ($c) { [int]$c[2] } else { 0 }); extras = $(if ($c) { [int]$c[3] } else { 0 }); alloc = $(if ($c) { [int]$c[4] } else { 0 })
            want = $(if ($c) { [int]$c[5] } else { 0 }); hot = [bool]($c -and $c[6] -eq '1'); scope = [bool]($c -and $c[7] -eq '1'); revive = $(if ($c) { [int]$c[8] } else { 0 }) }
    }
    [pscustomobject]@{ config = (Get-MatDoConfig); status = [pscustomobject]$st; maps = @($maps) }
}
function Set-MatDo($a) {
    $d = [int]$a.density
    if (@(10, 15, 20, 30) -notcontains $d) { throw 'He so mat do chi nhan x1, x1.5, x2, x3.' }
    $r = Clamp $a.revive 0 600
    if ($r -gt 0 -and $r -lt 3) { $r = 3 }
    $all = [bool]$a.all
    $ids = @()
    foreach ($m in @($a.maps)) {
        if ($null -eq $m) { continue }
        $n = [int]$m
        if ($MatDoMaps -notcontains $n) { throw "Ban do $n khong nam trong danh sach ban do co quai." }
        if ($ids -notcontains $n) { $ids += $n }
    }
    if (-not $all -and $ids.Count -eq 0) { throw 'Hay danh dau it nhat mot ban do, hoac chon Moi ban do.' }
    $text = "-- Written by AdminWeb (tab Mat do & hoi quai) $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); read by script\phongthan\ext\matdo.lua`n"
    $text += "PTMD_CFG = { density = $d, revive = $r, all = $([int]$all), maps = { $($ids -join ', ') } }`n"
    $dst = Join-Path $Bridge 'matdo_config.lua'; $tmp = Join-Path $Bridge 'matdo_config.tmp'
    [IO.File]::WriteAllBytes($tmp, $Enc1252.GetBytes($text))
    if (Test-Path -LiteralPath $dst) { [IO.File]::Replace($tmp, $dst, [NullString]::Value) } else { [IO.File]::Move($tmp, $dst) }
    [IO.File]::WriteAllText($MatDoJsonPath, (ConvertTo-Json -InputObject ([pscustomobject]@{ density = $d; revive = $r; all = $all; maps = @($ids) }) -Depth 4), $Utf8)
    $desc = "Mat do x$($d / 10), hoi " + $(if ($r) { "$r giay" } else { 'theo Npcs.txt' }) + ', ' + $(if ($all) { 'moi ban do co quai' } else { "$($ids.Count) ban do: " + ($ids -join ', ') })
    # 'not PTEXT_matdo_Tick': a server started before this feature loads the ext and registers it here (hot)
    Add-BridgeCommand 'Mat do & hoi quai' $desc 'if not PTEXT_matdo_Tick then dofile("script\\phongthan\\ext\\matdo.lua") end local f = 0 local k = 1 while PTADM_EXT_NAMES[k] do if PTADM_EXT_NAMES[k] == "matdo" then f = 1 end k = k + 1 end if f == 0 then tinsert(PTADM_EXT_NAMES, "matdo") end PTEXT_matdo_Apply({ID})'
}
# Client resolution (PhongThanClient.cpp KMyApp::GameInit reads \config.ini [Client] FullScreen,
# ScreenWidth, ScreenHeight once at startup; the in-game VNG resolution combo has no code behind it).
$ClientCfgPath = Join-Path $Root 'PhongThanRuntime-Staging\Client\config.ini'
function Get-ClientCfg {
    $w = 1024; $h = 768; $f = 0
    if (Test-Path -LiteralPath $ClientCfgPath) {
        foreach ($l in [IO.File]::ReadAllLines($ClientCfgPath, $Enc1252)) {
            if ($l -match '^\s*ScreenWidth\s*=\s*(\d+)') { $w = [int]$Matches[1] }
            elseif ($l -match '^\s*ScreenHeight\s*=\s*(\d+)') { $h = [int]$Matches[1] }
            elseif ($l -match '^\s*FullScreen\s*=\s*(\d+)') { $f = [int]$Matches[1] }
        }
    }
    [pscustomobject]@{ width = $w; height = $h; fullScreen = ($f -ne 0); gameRunning = [bool](Get-Process Game -ErrorAction SilentlyContinue) }
}
function Set-ClientCfg($a) {
    $w = [int]$a.width; $h = [int]$a.height; $f = if ([int]$a.fullScreen) { 1 } else { 0 }
    if (-not (($w -eq 800 -and $h -eq 600) -or ($w -eq 1024 -and $h -eq 768))) { throw 'Chi ho tro 800x600 hoac 1024x768.' }
    if (-not (Test-Path -LiteralPath $ClientCfgPath)) { throw 'Khong tim thay Client\config.ini.' }
    $bak = Join-Path $Root ('_backup\client-config\config.ini.' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $bak) | Out-Null
    Copy-Item -LiteralPath $ClientCfgPath -Destination $bak
    $lines = [Collections.Generic.List[string]]([IO.File]::ReadAllLines($ClientCfgPath, $Enc1252))
    $sec = ''; $seen = @{}; $clientEnd = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $l = $lines[$i]
        if ($l -match '^\s*\[(.+)\]') { if ($sec -eq 'Client') { $clientEnd = $i }; $sec = $Matches[1]; continue }
        if ($sec -ne 'Client') { continue }
        if ($l -match '^\s*ScreenWidth\s*=') { $lines[$i] = "ScreenWidth=$w"; $seen.w = 1 }
        elseif ($l -match '^\s*ScreenHeight\s*=') { $lines[$i] = "ScreenHeight=$h"; $seen.h = 1 }
        elseif ($l -match '^\s*FullScreen\s*=') { $lines[$i] = "FullScreen=$f"; $seen.f = 1 }
    }
    if ($clientEnd -lt 0) { $clientEnd = $lines.Count }
    if (-not $seen.f) { $lines.Insert($clientEnd, "FullScreen=$f") }
    if (-not $seen.h) { $lines.Insert($clientEnd, "ScreenHeight=$h") }
    if (-not $seen.w) { $lines.Insert($clientEnd, "ScreenWidth=$w") }
    [IO.File]::WriteAllLines($ClientCfgPath, $lines.ToArray(), $Enc1252)
    $run = if (Get-Process Game -ErrorAction SilentlyContinue) { ' Game dang mo: thoat game va mo lai de ap dung.' } else { ' Ap dung o lan mo game tiep theo.' }
    "Da luu ${w}x${h}, " + $(if ($f) { 'toan man hinh' } else { 'cua so' }) + '.' + $run
}
# Client sound volume (2026-10-02, agent sound): KUiOptions keeps music/effect volume (0..100, <=3 = mute)
# in Client\UserData\UiCommon.ini [Options] MusicValue / SoundValue and applies them at startup
# (UiInit.cpp:56 -> KUiOptions::LoadSetting -> KOption::SetMusicVolume / SetSndVolume). config.ini has no
# sound keys. The running game rewrites UiCommon.ini from memory, so saving is refused while Game.exe runs.
$ClientUiCommonPath = Join-Path $Root 'PhongThanRuntime-Staging\Client\UserData\UiCommon.ini'
function Get-ClientSound {
    $m = 100; $s = 100
    if (Test-Path -LiteralPath $ClientUiCommonPath) {
        $sec = ''
        foreach ($l in [IO.File]::ReadAllLines($ClientUiCommonPath, $Enc1252)) {
            if ($l -match '^\s*\[(.+)\]') { $sec = $Matches[1]; continue }
            if ($sec -ne 'Options') { continue }
            if ($l -match '^\s*MusicValue\s*=\s*(-?\d+)') { $m = [int]$Matches[1] }
            elseif ($l -match '^\s*SoundValue\s*=\s*(-?\d+)') { $s = [int]$Matches[1] }
        }
    }
    $m = [Math]::Max(0, [Math]::Min(100, $m)); $s = [Math]::Max(0, [Math]::Min(100, $s))
    [pscustomobject]@{ music = $m; sound = $s; gameRunning = [bool](Get-Process Game -ErrorAction SilentlyContinue) }
}
function Set-ClientSound($a) {
    $m = [int]$a.music; $s = [int]$a.sound
    if ($m -lt 0 -or $m -gt 100 -or $s -lt 0 -or $s -gt 100) { throw 'Am luong phai tu 0 den 100.' }
    if (Get-Process Game -ErrorAction SilentlyContinue) { throw 'Game dang mo: thoat game truoc (game ghi de UiCommon.ini khi thoat), roi luu lai.' }
    $lines = New-Object Collections.Generic.List[string]
    if (Test-Path -LiteralPath $ClientUiCommonPath) {
        $bak = Join-Path $Root ('_backup\client-config\UiCommon.ini.' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $bak) | Out-Null
        Copy-Item -LiteralPath $ClientUiCommonPath -Destination $bak
        foreach ($l in [IO.File]::ReadAllLines($ClientUiCommonPath, $Enc1252)) { $lines.Add($l) }
    } else {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ClientUiCommonPath) | Out-Null
    }
    $sec = ''; $seen = @{}; $optStart = -1; $optEnd = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $l = $lines[$i]
        if ($l -match '^\s*\[(.+)\]') { if ($sec -eq 'Options' -and $optEnd -lt 0) { $optEnd = $i }; $sec = $Matches[1]; if ($sec -eq 'Options') { $optStart = $i }; continue }
        if ($sec -ne 'Options') { continue }
        if ($l -match '^\s*MusicValue\s*=') { $lines[$i] = "MusicValue=$m"; $seen.m = 1 }
        elseif ($l -match '^\s*SoundValue\s*=') { $lines[$i] = "SoundValue=$s"; $seen.s = 1 }
    }
    if ($optStart -lt 0) {
        if ($lines.Count -gt 0 -and $lines[$lines.Count - 1].Trim() -ne '') { $lines.Add('') }
        $lines.Add('[Options]'); $optEnd = $lines.Count
    } elseif ($optEnd -lt 0) { $optEnd = $lines.Count }
    while ($optEnd -gt $optStart + 1 -and $optStart -ge 0 -and $lines[$optEnd - 1].Trim() -eq '') { $optEnd-- }
    if (-not $seen.s) { $lines.Insert($optEnd, "SoundValue=$s") }
    if (-not $seen.m) { $lines.Insert($optEnd, "MusicValue=$m") }
    [IO.File]::WriteAllLines($ClientUiCommonPath, $lines.ToArray(), $Enc1252)
    "Da luu am luong: nhac nen $m, hieu ung $s" + $(if ($m -le 3 -and $s -le 3) { ' (tat tieng)' } else { '' }) + '. Ap dung o lan mo game tiep theo.'
}
function Get-Characters {
    $dir = Join-Path $ServerRoot 'CharacterStore'
    @(Get-ChildItem -LiteralPath $dir -Filter 'role_*.pthc' -ErrorAction SilentlyContinue | ForEach-Object {
        $hex = $_.BaseName.Substring(5)
        if ($hex -match '^([0-9A-Fa-f]{2})+$') {
            $bytes = [byte[]]@(for ($i = 0; $i -lt $hex.Length; $i += 2) { [Convert]::ToByte($hex.Substring($i, 2), 16) })
            [pscustomobject]@{ name = (ConvertFrom-Tcvn $bytes); saved = $_.LastWriteTime.ToString('yyyy-MM-dd HH:mm') }
        }
    })
}

# ---------------------------------------------------------------- expanded storage (ruong 2026-10-03)
# Ruong k (2..6) = KPlayer::m_btRepositoryNum k-1 = engine pages pos_repositoryroom1..5 (GetExpandBox/SetExpandBox).
# Saved as byte ExtraBox (state offset 90) of PHONGTHAN_CHARACTER_STATE_HEADER. Offline file CharacterStore\role_<hex>.pthc =
# 16-byte header (magic 'PHTC' 0x43544850, version 1, header size 16, state size, FNV-1a of the state) + state,
# see PhongThanSource\Sources\MultiServer\Goddess\PhongThanCharacterStore.cpp. Goddess reads the file at every login.
function Get-ChestPath([string]$Name) {
    $bytes = ConvertTo-Tcvn $Name
    $hex = -join @(foreach ($b in $bytes) { $c = [int]$b; if ($c -ge 65 -and $c -le 90) { $c += 32 }; $c.ToString('x2') })
    Join-Path (Join-Path $ServerRoot 'CharacterStore') "role_$hex.pthc"
}
function Get-ChestFnv([byte[]]$Data) {
    [long]$h = 2166136261
    for ($i = 16; $i -lt $Data.Length; $i++) { $h = (($h -bxor $Data[$i]) * 16777619) -band [long]4294967295 }
    $h
}
function Read-ChestFile([string]$Name) {
    $path = Get-ChestPath $Name
    if (-not (Test-Path -LiteralPath $path)) { return $null }
    $d = [IO.File]::ReadAllBytes($path)
    if ($d.Length -lt 424 -or [BitConverter]::ToUInt32($d, 0) -ne 0x43544850 -or [BitConverter]::ToUInt16($d, 4) -ne 1 -or
        [BitConverter]::ToUInt16($d, 6) -ne 16 -or [BitConverter]::ToUInt32($d, 8) -ne ($d.Length - 16)) { throw 'File nhan vat sai dinh dang.' }
    if ([long][BitConverter]::ToUInt32($d, 12) -ne (Get-ChestFnv $d)) { throw 'File nhan vat sai checksum.' }
    $role = $Enc1252.GetString($d, 32, 32).Split([char]0)[0]
    if ($role -ne $Enc1252.GetString((ConvertTo-Tcvn $Name))) { throw 'Ten trong file nhan vat khong khop.' }
    [pscustomobject]@{ path = $path; data = $d; box = [int]$d[106] }
}
# Raise the opened count in the file (never lowers). Returns @{ ok; text } (ASCII text for the history/bridge log).
function Set-ChestFile([string]$Name, [int]$Box) {
    $f = $null
    try { $f = Read-ChestFile $Name } catch { return @{ ok = $false; text = "file loi: $($_.Exception.Message)" } }
    if (-not $f) { return @{ ok = $false; text = 'khong co file nhan vat' } }
    if ($f.box -ge $Box) { return @{ ok = $true; text = "file da mo den ruong $($f.box + 1)" } }
    $d = $f.data; $d[106] = [byte]$Box
    [Array]::Copy([BitConverter]::GetBytes([uint32](Get-ChestFnv $d)), 0, $d, 12, 4)
    $bakDir = Join-Path $DataDir 'chest_backup'; New-Item -ItemType Directory -Force $bakDir | Out-Null
    $bak = Join-Path $bakDir ((Split-Path $f.path -Leaf) + '.' + (Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
    $tmp = $f.path + '.admin.tmp'
    [IO.File]::WriteAllBytes($tmp, $d)
    try { [IO.File]::Replace($tmp, $f.path, $bak) } catch { Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue; return @{ ok = $false; text = "khong ghi duoc file: $($_.Exception.Message)" } }
    @{ ok = $true; text = "file ruong $($f.box + 1) -> $($Box + 1)" }
}

# ---------------------------------------------------------------- admin ops (2026-10-04 adminops)
# A1 server health, A2 roll back a deploy backup, A3 daily character backup + character soft delete, C4 bot party panel.
# Doc: docs\features\admin-van-hanh-phong-than-20261004.md. Names: AdminOps* / CharBackup* / BotParty*.
$AdminOpsBackupRoot = Join-Path $Root '_backup'
$AdminOpsOutputRoot = Join-Path $Root 'PhongThanSource\Output'
$AdminOpsReceipt = Join-Path $Runtime 'NATIVE_DEPLOYMENT.json'
$AdminOpsLogPath = Join-Path $DataDir 'adminops.log'
$AdminOpsLogs = [ordered]@{ result = 'result.log'; tick_error = 'tick_error.log'; newbie2_error = 'newbie2_error.log'; petai = 'petai.log' }
$AdminOpsServerBins = @('GameServer.exe', 'CoreServer.dll', 'Engine.dll', 'LuaLibDll.dll', 'Bishop.exe', 'Goddess.exe')
$AdminOpsClientBins = @('Game.exe', 'CoreClient.dll', 'Engine.dll', 'LuaLibDll.dll', 'Represent2.dll')
$AdminOpsNpcLimit = 48000
$script:AdminOpsHash = @{}
$script:AdminOpsCodes = @{}
$script:AdminOpsTcvn = New-Object char[] 256
for ($i = 0; $i -lt 256; $i++) { $script:AdminOpsTcvn[$i] = $(if ($TcvnToUni.ContainsKey($i)) { $TcvnToUni[$i] } else { [char]$i }) }
function Write-AdminOpsLog([string]$Action, [string]$Text) {
    $line = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "`t" + $Action + "`t" + ($Text -replace "[`r`n`t]", ' ')
    [IO.File]::AppendAllText($AdminOpsLogPath, $line + "`r`n", $Utf8)
}
function Get-AdminOpsLog([int]$Count = 30) {
    if (-not (Test-Path -LiteralPath $AdminOpsLogPath)) { return @() }
    @([IO.File]::ReadAllLines($AdminOpsLogPath, $Utf8) | Where-Object { $_ } | Select-Object -Last $Count | ForEach-Object {
        $c = $_ -split "`t", 3
        [pscustomobject]@{ time = $c[0]; action = $(if ($c.Count -gt 1) { $c[1] } else { '' }); text = $(if ($c.Count -gt 2) { $c[2] } else { '' }) }
    })
}
function Get-AdminOpsRunning([string[]]$Names) { @(Get-Process -Name $Names -ErrorAction SilentlyContinue | ForEach-Object { $_.ProcessName } | Select-Object -Unique) }
function ConvertFrom-AdminOpsBytes([byte[]]$Bytes, [int]$Start, [int]$Length) {
    $arr = New-Object char[] $Length; $m = $script:AdminOpsTcvn
    for ($k = 0; $k -lt $Length; $k++) { $arr[$k] = $m[$Bytes[$Start + $k]] }
    New-Object string (, $arr)
}
function Get-AdminOpsHash([string]$Path, [string]$Algo) {
    try {
        $fi = Get-Item -LiteralPath $Path
        $key = "$Algo|$Path"; $stamp = "$($fi.Length)|$($fi.LastWriteTimeUtc.Ticks)"
        $c = $script:AdminOpsHash[$key]
        if ($c -and $c.stamp -eq $stamp) { return $c.hash }
        $h = (Get-FileHash -LiteralPath $Path -Algorithm $Algo).Hash
        $script:AdminOpsHash[$key] = @{ stamp = $stamp; hash = $h }
        $h
    } catch { '' }
}
# PE link time (build date) of an exe/dll, '' when not a PE file
function Get-AdminOpsPeTime([string]$Path) {
    try {
        $fs = [IO.File]::Open($Path, 'Open', 'Read', 'ReadWrite')
        try { $b = New-Object byte[] 1024; $n = $fs.Read($b, 0, 1024) } finally { $fs.Dispose() }
        $pe = [BitConverter]::ToInt32($b, 0x3c)
        if ($pe -lt 0 -or $pe + 12 -gt $n -or [BitConverter]::ToUInt32($b, $pe) -ne 0x4550) { return '' }
        ([DateTimeOffset]::FromUnixTimeSeconds([BitConverter]::ToUInt32($b, $pe + 8))).LocalDateTime.ToString('yyyy-MM-dd HH:mm')
    } catch { '' }
}
function Read-AdminOpsReceipt { if (Test-Path -LiteralPath $AdminOpsReceipt) { try { return (Get-Content -LiteralPath $AdminOpsReceipt -Raw | ConvertFrom-Json) } catch { } }; $null }
function Get-AdminOpsBin([string]$Path, [string]$Role, $Receipt) {
    $name = Split-Path -Leaf $Path
    if (-not (Test-Path -LiteralPath $Path)) { return [pscustomobject]@{ name = $name; exists = $false } }
    $fi = Get-Item -LiteralPath $Path
    $want = $null
    if ($Receipt) { $want = @($Receipt.Artifacts | Where-Object { $_.Role -eq $Role -and $_.Name -eq $name } | ForEach-Object { $_.Sha256 })[0] }
    $ok = $null; if ($want) { $ok = ((Get-AdminOpsHash $Path 'SHA256') -eq $want) }
    [pscustomobject]@{ name = $name; exists = $true; size = $fi.Length; date = $fi.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); build = (Get-AdminOpsPeTime $Path); receiptOk = $ok }
}
function Get-AdminOpsPak([string]$Label, [string]$Path, $Receipt) {
    if (-not (Test-Path -LiteralPath $Path)) { return [pscustomobject]@{ label = $Label; exists = $false } }
    $fi = Get-Item -LiteralPath $Path
    $want = $null
    if ($Receipt -and $Receipt.PakChain) { $want = @($Receipt.PakChain.Entries | Where-Object { $_.Name -eq 'ptfix.pak' } | ForEach-Object { $_.Sha256 })[0] }
    $md5 = Get-AdminOpsHash $Path 'MD5'
    $ok = $null; if ($want) { $ok = ((Get-AdminOpsHash $Path 'SHA256') -eq $want) }
    [pscustomobject]@{ label = $Label; exists = $true; size = $fi.Length; date = $fi.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); md5 = $(if ($md5) { $md5.Substring(0, 8) } else { '' }); receiptOk = $ok }
}
# tick_error.log: lines "yyyy-MM-dd HH:mm:ss message" (servertimer PTAdm_TickErr); counts since $Start and in the last hour
function Get-AdminOpsTickErr($Start) {
    $p = Join-Path $Bridge 'tick_error.log'
    $r = [ordered]@{ exists = $false; size = 0; lines = 0; sinceStart = 0; lastHour = 0; lastTime = ''; last = ''; date = '' }
    if (-not (Test-Path -LiteralPath $p)) { return [pscustomobject]$r }
    $fi = Get-Item -LiteralPath $p
    $r.exists = $true; $r.size = $fi.Length; $r.date = $fi.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss')
    $hour = (Get-Date).AddHours(-1); $last = $null
    $fs = [IO.File]::Open($p, 'Open', 'Read', 'ReadWrite')
    try { $sr = New-Object IO.StreamReader($fs, $Enc1252); $text = $sr.ReadToEnd() } finally { $fs.Dispose() }
    foreach ($l in ($text -split "`r?`n")) {
        if (-not $l) { continue }
        $r.lines++; $last = $l
        if ($l -match '^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)') {
            $t = [datetime]::ParseExact($Matches[1], 'yyyy-MM-dd HH:mm:ss', $null)
            $r.lastTime = $Matches[1]
            if ($Start -and $t -ge $Start) { $r.sinceStart++ }
            if ($t -ge $hour) { $r.lastHour++ }
        }
    }
    if ($last) { $b = $Enc1252.GetBytes($last); $r.last = ConvertFrom-AdminOpsBytes $b 0 ([Math]::Min($b.Length, 400)) }
    [pscustomobject]$r
}
function Get-AdminHealth {
    $now = Get-Date
    $procs = @()
    try { $procs = @(Get-CimInstance Win32_Process -Filter "Name='GameServer.exe' OR Name='Bishop.exe' OR Name='Goddess.exe' OR Name='Game.exe'" -ErrorAction Stop) } catch { }
    $gs = @($procs | Where-Object { $_.Name -eq 'GameServer.exe' } | Sort-Object CreationDate)[0]
    $start = $null; if ($gs) { $start = $gs.CreationDate }
    $hb = Join-Path $Bridge 'heartbeat.txt'
    $hbText = $null; $hbAge = -1
    if (Test-Path -LiteralPath $hb) { $hbText = [IO.File]::ReadAllText($hb).Trim(); $hbAge = [int]($now - (Get-Item -LiteralPath $hb).LastWriteTime).TotalSeconds }
    $on = Get-Online
    $npc = [ordered]@{ count = $null; cap = 0; limit = $AdminOpsNpcLimit; limitSrc = 'default'; stamp = ''; ageSec = -1 }
    $md = Join-Path $Bridge 'matdo.txt'
    if (Test-Path -LiteralPath $md) {
        $lines = [IO.File]::ReadAllLines($md, $Enc1252)
        if ($lines.Count) { $npc.stamp = $lines[0]; $npc.ageSec = [int]($now - (Get-Item -LiteralPath $md).LastWriteTime).TotalSeconds }
        # engine2: matdo writes the density cap (column 3) = engine limit - 4000, engine limit = GetNpcCount() + GetFreeNpcCount() + 1
        # (48000 / cap 44000 on the old CoreServer, 96000 / 92000 with engine2); a column 11 >= 48000, if ever written, is the limit itself
        foreach ($l in $lines) {
            $c = $l -split "`t"
            if ($c[0] -eq 'total' -and $c.Count -ge 4) {
                $npc.count = [int]$c[1]; $npc.cap = [int]$c[3]
                if ($c.Count -ge 12 -and $c[11] -match '^\d+$' -and [int]$c[11] -ge 48000) { $npc.limit = [int]$c[11]; $npc.limitSrc = 'matdo' }
                elseif ($npc.cap -gt 0) { $npc.limit = [Math]::Max($AdminOpsNpcLimit, $npc.cap + 4000); $npc.limitSrc = 'matdo' }
            }
        }
    }
    $logs = foreach ($k in $AdminOpsLogs.Keys) {
        $p = Join-Path $Bridge $AdminOpsLogs[$k]
        if (Test-Path -LiteralPath $p) { $fi = Get-Item -LiteralPath $p; [pscustomobject]@{ key = $k; file = $AdminOpsLogs[$k]; exists = $true; size = $fi.Length; date = $fi.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') } }
        else { [pscustomobject]@{ key = $k; file = $AdminOpsLogs[$k]; exists = $false; size = 0; date = '' } }
    }
    $rc = Read-AdminOpsReceipt
    $paks = @(
        (Get-AdminOpsPak 'Server\data\ptfix.pak' (Join-Path $ServerRoot 'data\ptfix.pak') $rc),
        (Get-AdminOpsPak 'Client\data\ptfix.pak' (Join-Path $Runtime 'Client\data\ptfix.pak') $rc)
    )
    $pend = Join-Path (Split-Path -Parent $DataDir) 'pending\ptfix.pak'
    if (Test-Path -LiteralPath $pend) { $paks += (Get-AdminOpsPak 'AdminWeb\pending\ptfix.pak (cho cai)' $pend $null) }
    [pscustomobject]@{
        now = $now.ToString('yyyy-MM-dd HH:mm:ss')
        processes = @($procs | ForEach-Object { [pscustomobject]@{ name = $_.Name; pid = $_.ProcessId; start = $(if ($_.CreationDate) { $_.CreationDate.ToString('yyyy-MM-dd HH:mm:ss') } else { '' }) } })
        gameServer = [bool]$gs; startTime = $(if ($start) { $start.ToString('yyyy-MM-dd HH:mm:ss') } else { '' }); uptimeSec = $(if ($start) { [int]($now - $start).TotalSeconds } else { -1 })
        heartbeat = $hbText; heartbeatAgeSec = $hbAge
        online = @($on.players).Count; onlineStamp = $on.stamp; players = @($on.players | ForEach-Object { $_.name })
        npc = [pscustomobject]$npc
        tickError = (Get-AdminOpsTickErr $start)
        logs = @($logs)
        paks = $paks
        serverBins = @(foreach ($n in $AdminOpsServerBins) { Get-AdminOpsBin (Join-Path $ServerRoot $n) 'Server' $rc })
        clientBins = @(foreach ($n in $AdminOpsClientBins) { Get-AdminOpsBin (Join-Path $Runtime "Client\$n") 'Client' $rc })
        receipt = [bool]$rc
    }
}
# last $Count lines of an admin_bridge log (reads at most the last 256 KB; TCVN3 shown as Unicode)
function Get-AdminOpsLogTail([string]$Key, [int]$Count = 200) {
    $file = $AdminOpsLogs[$Key]; if (-not $file) { throw 'Nhat ky khong hop le.' }
    if ($Count -lt 1) { $Count = 200 }; if ($Count -gt 1000) { $Count = 1000 }
    $p = Join-Path $Bridge $file
    if (-not (Test-Path -LiteralPath $p)) { return [pscustomobject]@{ key = $Key; file = $file; exists = $false; size = 0; lines = @() } }
    $fs = [IO.File]::Open($p, 'Open', 'Read', 'ReadWrite')
    try {
        $len = $fs.Length; $take = [int][Math]::Min($len, 262144)
        [void]$fs.Seek($len - $take, 'Begin')
        $buf = New-Object byte[] $take; $n = 0
        while ($n -lt $take) { $k = $fs.Read($buf, $n, $take - $n); if ($k -le 0) { break }; $n += $k }
    } finally { $fs.Dispose() }
    $end = $n; while ($end -gt 0 -and ($buf[$end - 1] -eq 10 -or $buf[$end - 1] -eq 13)) { $end-- }
    $from = 0; $seen = 0; $i = $end - 1
    while ($i -ge 0) {
        $i = [Array]::LastIndexOf($buf, [byte]10, $i)
        if ($i -lt 0) { break }
        $seen++; if ($seen -ge $Count) { $from = $i + 1; break }
        $i--
    }
    # a cut first line (file larger than the window) is dropped
    if ($seen -lt $Count -and $take -lt $len) { $j = [Array]::IndexOf($buf, [byte]10, 0); if ($j -ge 0 -and $j -lt $end) { $from = $j + 1 } }
    $text = if ($end -gt $from) { ConvertFrom-AdminOpsBytes $buf $from ($end - $from) } else { '' }
    [pscustomobject]@{ key = $Key; file = $file; exists = $true; size = $len; date = (Get-Item -LiteralPath $p).LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'); lines = @($text -split "`r?`n") }
}

# ---- A2 roll back: _backup\server-deploy-* / client-deploy-* (Deploy-ModernServer/Client: files before that deploy,
# PhongThanRuntime-Staging\ + Output\ or flat "<tag>-<file>"), ptfix-* (PhongThan-ClientPatch: Server-/Client-ptfix.pak
# = the pak before that install; installed-ptfix.pak is the one installed then and is not restored).
function Get-AdminOpsKind([string]$Name) {
    if ($Name -match '^(server-deploy|client-deploy|ptfix)-(\d{8})-(\d{6})(-[A-Za-z0-9-]+)?$') {
        return [pscustomobject]@{ kind = $Matches[1]; time = [datetime]::ParseExact($Matches[2] + $Matches[3], 'yyyyMMddHHmmss', $null); tag = "$($Matches[4])".TrimStart('-') }
    }
    $null
}
function Get-AdminOpsRestoreMap([string]$Dir, [string]$Kind) {
    $list = New-Object Collections.ArrayList
    if ($Kind -eq 'ptfix') {
        $sv = Join-Path $Dir 'Server-ptfix.pak'; $cl = Join-Path $Dir 'Client-ptfix.pak'
        $hasS = Test-Path -LiteralPath $sv; $hasC = Test-Path -LiteralPath $cl
        $s1 = if ($hasS) { $sv } elseif ($hasC) { $cl } else { $null }
        $c1 = if ($hasC) { $cl } elseif ($hasS) { $sv } else { $null }
        if ($s1) { [void]$list.Add([pscustomobject]@{ src = $s1; dst = (Join-Path $ServerRoot 'data\ptfix.pak'); rel = 'Server-ptfix.pak'; label = 'Server\data\ptfix.pak' }) }
        if ($c1) { [void]$list.Add([pscustomobject]@{ src = $c1; dst = (Join-Path $Runtime 'Client\data\ptfix.pak'); rel = 'Client-ptfix.pak'; label = 'Client\data\ptfix.pak' }) }
        return , $list
    }
    $side = if ($Kind -eq 'server-deploy') { 'Server' } else { 'Client' }
    $targets = @{ 'PhongThanRuntime-Staging' = (Join-Path $Runtime $side); 'Output' = (Join-Path $AdminOpsOutputRoot $side) }
    $labels = @{ 'PhongThanRuntime-Staging' = "$side (runtime)"; 'Output' = "$side (Output)" }
    foreach ($tag in 'PhongThanRuntime-Staging', 'Output') {
        $d = Join-Path $Dir $tag
        if (Test-Path -LiteralPath $d -PathType Container) {
            foreach ($f in @(Get-ChildItem -LiteralPath $d -File)) { [void]$list.Add([pscustomobject]@{ src = $f.FullName; dst = (Join-Path $targets[$tag] $f.Name); rel = "$tag\$($f.Name)"; label = "$($labels[$tag]) $($f.Name)" }) }
        }
        foreach ($f in @(Get-ChildItem -LiteralPath $Dir -File -Filter "$tag-*")) {
            $n = $f.Name.Substring($tag.Length + 1)
            [void]$list.Add([pscustomobject]@{ src = $f.FullName; dst = (Join-Path $targets[$tag] $n); rel = $f.Name; label = "$($labels[$tag]) $n" })
        }
    }
    , $list
}
function Get-AdminOpsBackups {
    $out = New-Object Collections.ArrayList
    if (-not (Test-Path -LiteralPath $AdminOpsBackupRoot)) { return , $out }
    foreach ($d in @(Get-ChildItem -LiteralPath $AdminOpsBackupRoot -Directory)) {
        $k = Get-AdminOpsKind $d.Name; if (-not $k) { continue }
        $map = Get-AdminOpsRestoreMap $d.FullName $k.kind
        $same = $map.Count -gt 0; $bytes = 0L
        $files = foreach ($m in $map) {
            $s = Get-Item -LiteralPath $m.src; $bytes += $s.Length
            $eq = $false
            if (Test-Path -LiteralPath $m.dst) { $t = Get-Item -LiteralPath $m.dst; $eq = ($t.Length -eq $s.Length -and $t.LastWriteTimeUtc -eq $s.LastWriteTimeUtc) }
            if (-not $eq) { $same = $false }
            [pscustomobject]@{ label = $m.label; size = $s.Length; date = $s.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); same = $eq; build = $(if ($m.src -match '\.(exe|dll)$') { Get-AdminOpsPeTime $m.src } else { '' }) }
        }
        [void]$out.Add([pscustomobject]@{ name = $d.Name; kind = $k.kind; time = $k.time.ToString('yyyy-MM-dd HH:mm:ss'); tag = $k.tag; files = @($files); same = $same; bytes = $bytes })
    }
    $sorted = @($out | Sort-Object { $_.time } -Descending)
    , $sorted
}
function Get-AdminOpsBackupDir([string]$Name) {
    $k = Get-AdminOpsKind $Name
    if (-not $k) { throw 'Ten ban sao luu khong hop le.' }
    $dir = Join-Path $AdminOpsBackupRoot $Name
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { throw "Khong thay ban sao luu $Name." }
    [pscustomobject]@{ dir = $dir; kind = $k.kind; time = $k.time }
}
function Assert-AdminOpsStopped([string[]]$Names, [string]$What) {
    $run = @(Get-AdminOpsRunning $Names)
    if ($run.Count) { throw ('Dang chay: ' + ($run -join ', ') + ". Tat $What truoc roi bam lai.") }
}
function New-AdminOpsCode([string]$Kind, [string]$Key) {
    $code = [string](Get-Random -Minimum 1000 -Maximum 10000)
    $script:AdminOpsCodes[$Kind] = @{ code = $code; key = $Key; until = (Get-Date).AddMinutes(5) }
    $code
}
function Confirm-AdminOpsCode([string]$Kind, [string]$Key, [string]$Code) {
    $c = $script:AdminOpsCodes[$Kind]
    [void]$script:AdminOpsCodes.Remove($Kind)
    if (-not $c -or $c.key -ne $Key -or $c.code -ne "$Code".Trim() -or (Get-Date) -gt $c.until) { throw 'Ma xac nhan sai hoac het han (5 phut). Bam Khoi phuc lai tu dau.' }
}
function Get-AdminOpsRollbackPlan([string]$Name) {
    $b = Get-AdminOpsBackupDir $Name
    Assert-AdminOpsStopped @('GameServer', 'Bishop', 'Game') 'GameServer, Bishop va game'
    $map = Get-AdminOpsRestoreMap $b.dir $b.kind
    if (-not $map.Count) { throw 'Ban sao luu khong co file nao de khoi phuc.' }
    [pscustomobject]@{ name = $Name; kind = $b.kind; code = (New-AdminOpsCode 'rollback' $Name); files = @($map | ForEach-Object { $_.label }) }
}
function Invoke-AdminOpsRollback([string]$Name, [string]$Code) {
    Confirm-AdminOpsCode 'rollback' $Name $Code
    $b = Get-AdminOpsBackupDir $Name
    Assert-AdminOpsStopped @('GameServer', 'Bishop', 'Game') 'GameServer, Bishop va game'
    $map = Get-AdminOpsRestoreMap $b.dir $b.kind
    if (-not $map.Count) { throw 'Ban sao luu khong co file nao de khoi phuc.' }
    foreach ($m in $map) {
        if (-not (Test-Path -LiteralPath (Split-Path -Parent $m.dst) -PathType Container)) { throw "Khong thay thu muc dich $(Split-Path -Parent $m.dst)" }
        if (Test-Path -LiteralPath $m.dst) { try { $fs = [IO.File]::Open($m.dst, 'Open', 'ReadWrite', 'None'); $fs.Close() } catch { throw "File dang bi khoa: $($m.dst)" } }
    }
    # current files first, same layout as the backup (so this copy can itself be restored)
    $ts = Get-Date -Format 'yyyyMMdd-HHmmss'
    $safe = Join-Path $AdminOpsBackupRoot "$($b.kind)-$ts-rollback"
    $n = 2; while (Test-Path -LiteralPath $safe) { $safe = Join-Path $AdminOpsBackupRoot "$($b.kind)-$ts-rollback$n"; $n++ }
    New-Item -ItemType Directory -Force -Path $safe | Out-Null
    if (Test-Path -LiteralPath $AdminOpsReceipt) { Copy-Item -LiteralPath $AdminOpsReceipt -Destination $safe }
    foreach ($m in $map) {
        if (-not (Test-Path -LiteralPath $m.dst)) { continue }
        $t = Join-Path $safe $m.rel
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $t) | Out-Null
        Copy-Item -LiteralPath $m.dst -Destination $t
    }
    Write-AdminOpsLog 'rollback' "bat dau $Name; ban hien tai luu o $(Split-Path -Leaf $safe)"
    $bad = @()
    foreach ($m in $map) {
        Copy-Item -LiteralPath $m.src -Destination $m.dst -Force
        if ((Get-FileHash -LiteralPath $m.src).Hash -ne (Get-FileHash -LiteralPath $m.dst).Hash) { $bad += $m.label }
    }
    $rc = Update-AdminOpsReceipt $b.kind $map
    $msg = "Da khoi phuc $($map.Count) file tu $Name (ban hien tai luu o _backup\$(Split-Path -Leaf $safe)). $rc"
    if ($bad.Count) { $msg += ' LOI: file khong khop sau khi chep: ' + ($bad -join ', ') }
    Write-AdminOpsLog 'rollback' $msg
    if ($bad.Count) { throw $msg }
    $msg
}
# NATIVE_DEPLOYMENT.json: the launcher needs runtime == receipt. Server/Client: hashes of the restored artifacts;
# ptfix: the PakChain entry (as PhongThan-ClientPatch.ps1 does when it installs a pak).
function Update-AdminOpsReceipt([string]$Kind, $Map) {
    if (-not (Test-Path -LiteralPath $AdminOpsReceipt)) { return 'Khong co NATIVE_DEPLOYMENT.json.' }
    $r = Get-Content -LiteralPath $AdminOpsReceipt -Raw | ConvertFrom-Json
    $n = 0
    if ($Kind -eq 'ptfix') {
        $pak = Join-Path $ServerRoot 'data\ptfix.pak'
        $len = (Get-Item -LiteralPath $pak).Length; $hash = (Get-FileHash -LiteralPath $pak).Hash
        foreach ($e in $r.PakChain.Entries) { if ($e.Name -eq 'ptfix.pak') { $r.PakChain.TotalBytes = [long]$r.PakChain.TotalBytes - [long]$e.Length + $len; $e.Length = $len; $e.Sha256 = $hash; $n++ } }
    } else {
        $side = if ($Kind -eq 'server-deploy') { 'Server' } else { 'Client' }
        $rtDir = Join-Path $Runtime $side
        $names = @($Map | Where-Object { $_.dst.StartsWith($rtDir + '\', [StringComparison]::OrdinalIgnoreCase) } | ForEach-Object { Split-Path -Leaf $_.dst })
        foreach ($a in $r.Artifacts) {
            if ($a.Role -eq $side -and ($names -contains $a.Name)) { $a.Sha256 = (Get-FileHash -LiteralPath (Join-Path $rtDir $a.Name)).Hash; $n++ }
        }
    }
    ($r | ConvertTo-Json -Depth 10) | Set-Content -LiteralPath $AdminOpsReceipt -Encoding UTF8
    "Da cap nhat NATIVE_DEPLOYMENT.json ($n muc)."
}

# ---- A3 character backup: CharacterStore\role_<hex>.pthc (+ LocalDB account by BACKUP ... COPY_ONLY, online-safe,
# only when the MSSQLLocalDB instance is already running: the web admin never starts LocalDB for this) into
# _backup\characters\yyyyMMdd\ (one folder per day, a later run the same day replaces it), newest 7 days kept.
# Runs when the web admin opens and every 24 hours (Invoke-AdminOpsTick from Invoke-Scheduler).
$CharBackupRoot = Join-Path $AdminOpsBackupRoot 'characters'
$CharBackupKeep = 7
$CharStoreDir = Join-Path $ServerRoot 'CharacterStore'
$script:CharBackupLast = $null
$script:CharBackupNext = $null
function Get-AdminOpsFnv([byte[]]$Data) {
    [long]$h = 2166136261
    for ($i = 16; $i -lt $Data.Length; $i++) { $h = (($h -bxor $Data[$i]) * 16777619) -band [long]4294967295 }
    $h
}
function Test-AdminOpsPthc([byte[]]$d) {
    $d.Length -ge 16 -and [BitConverter]::ToUInt32($d, 0) -eq 0x43544850 -and [BitConverter]::ToUInt32($d, 8) -eq ($d.Length - 16) -and [long][BitConverter]::ToUInt32($d, 12) -eq (Get-AdminOpsFnv $d)
}
function Get-AdminOpsCharName([string]$File) {
    if ($File -match '^role_(([0-9A-Fa-f]{2})+)\.pthc$') {
        $hex = $Matches[1]
        return (ConvertFrom-Tcvn ([byte[]]@(for ($i = 0; $i -lt $hex.Length; $i += 2) { [Convert]::ToByte($hex.Substring($i, 2), 16) })))
    }
    $File
}
function Find-AdminOpsLocalDbExe {
    $c = Get-Command SqlLocalDB.exe -ErrorAction SilentlyContinue
    if ($c) { return $c.Source }
    $f = @(Get-ChildItem -Path (Join-Path $env:ProgramFiles 'Microsoft SQL Server\*\Tools\Binn\SqlLocalDB.exe') -ErrorAction SilentlyContinue | Sort-Object FullName -Descending)[0]
    if ($f) { return $f.FullName }
    $null
}
function Test-AdminOpsLocalDb {
    $exe = Find-AdminOpsLocalDbExe
    if (-not $exe) { return $false }
    $ErrorActionPreference = 'Continue'   # native stderr must not stop the backup (PowerShell 5.1)
    ((& $exe info MSSQLLocalDB 2>$null) -join "`n") -match 'State:\s+Running'
}
function Invoke-AdminOpsDbBackup([string]$Path) { [void](Invoke-Sql 'BACKUP DATABASE [account] TO DISK = @p WITH INIT, FORMAT, COPY_ONLY' @{ '@p' = $Path }) }
function Invoke-CharBackup([string]$Reason) {
    New-Item -ItemType Directory -Force -Path $CharBackupRoot | Out-Null
    $day = Join-Path $CharBackupRoot (Get-Date -Format 'yyyyMMdd')
    $tmp = "$day.tmp"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Recurse -Force }
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    $files = New-Object Collections.ArrayList; $bad = 0
    foreach ($f in @(Get-ChildItem -LiteralPath $CharStoreDir -File -ErrorAction SilentlyContinue)) {
        $isRole = $f.Name -like 'role_*.pthc'
        $data = $null; $ok = -not $isRole
        for ($try = 0; $try -lt 5; $try++) {
            try { $data = [IO.File]::ReadAllBytes($f.FullName) } catch { $data = $null }
            if ($data -and (-not $isRole -or (Test-AdminOpsPthc $data))) { $ok = $true; break }
            Start-Sleep -Milliseconds 300
        }
        if ($null -eq $data) { $bad++; [void]$files.Add([pscustomobject]@{ file = $f.Name; name = (Get-AdminOpsCharName $f.Name); size = 0; saved = $f.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); ok = $false }); continue }
        if (-not $ok) { $bad++ }
        $t = Join-Path $tmp $f.Name
        [IO.File]::WriteAllBytes($t, $data); (Get-Item -LiteralPath $t).LastWriteTime = $f.LastWriteTime
        [void]$files.Add([pscustomobject]@{ file = $f.Name; name = (Get-AdminOpsCharName $f.Name); size = $data.Length; saved = $f.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); ok = $ok })
    }
    $db = ''
    try {
        if (Test-AdminOpsLocalDb) { Invoke-AdminOpsDbBackup (Join-Path $tmp 'account.bak'); $db = 'ok' }
        else { $db = 'bo qua: LocalDB dang tat (chi sao luu file nhan vat)' }
    } catch { $db = "loi: $($_.Exception.Message)" }
    $man = [pscustomobject]@{ time = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); reason = $Reason; files = @($files); db = $db }
    [IO.File]::WriteAllText((Join-Path $tmp 'manifest.json'), (ConvertTo-Json -InputObject $man -Depth 4), $Utf8)
    $old = "$day.old"
    if (Test-Path -LiteralPath $old) { Remove-Item -LiteralPath $old -Recurse -Force }
    if (Test-Path -LiteralPath $day) { Move-Item -LiteralPath $day -Destination $old }
    Move-Item -LiteralPath $tmp -Destination $day
    if (Test-Path -LiteralPath $old) { Remove-Item -LiteralPath $old -Recurse -Force }
    $drop = @(Get-ChildItem -LiteralPath $CharBackupRoot -Directory | Where-Object { $_.Name -match '^\d{8}$' } | Sort-Object Name -Descending | Select-Object -Skip $CharBackupKeep)
    foreach ($d in $drop) { Remove-Item -LiteralPath $d.FullName -Recurse -Force }
    $script:CharBackupLast = Get-Date; $script:CharBackupNext = $script:CharBackupLast.AddHours(24)
    $msg = "Sao luu $($files.Count) file nhan vat vao _backup\characters\$(Split-Path -Leaf $day)" + $(if ($bad) { " ($bad file loi checksum/khong doc duoc)" } else { '' }) + "; database account: $db" + $(if ($drop.Count) { "; xoa $($drop.Count) ban cu hon $CharBackupKeep ngay" } else { '' }) + '.'
    Write-AdminOpsLog "charbackup ($Reason)" $msg
    $msg
}
function Get-CharBackups {
    $list = @()
    if (Test-Path -LiteralPath $CharBackupRoot) {
        foreach ($d in @(Get-ChildItem -LiteralPath $CharBackupRoot -Directory | Where-Object { $_.Name -match '^\d{8}$' } | Sort-Object Name -Descending)) {
            $man = $null; $mp = Join-Path $d.FullName 'manifest.json'
            if (Test-Path -LiteralPath $mp) { try { $man = [IO.File]::ReadAllText($mp, $Utf8) | ConvertFrom-Json } catch { } }
            $fs = @(Get-ChildItem -LiteralPath $d.FullName -File -Filter 'role_*.pthc')
            $bytes = 0L; foreach ($x in @(Get-ChildItem -LiteralPath $d.FullName -File)) { $bytes += $x.Length }
            $list += [pscustomobject]@{ date = $d.Name; time = $(if ($man) { $man.time } else { $d.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') }); reason = $(if ($man) { $man.reason } else { '' })
                db = $(if ($man) { $man.db } else { '' }); hasDb = (Test-Path -LiteralPath (Join-Path $d.FullName 'account.bak')); bytes = $bytes
                chars = @($fs | ForEach-Object { [pscustomobject]@{ file = $_.Name; name = (Get-AdminOpsCharName $_.Name); size = $_.Length; saved = $_.LastWriteTime.ToString('yyyy-MM-dd HH:mm') } }) }
        }
    }
    [pscustomobject]@{ backups = @($list); keep = $CharBackupKeep; last = $(if ($script:CharBackupLast) { $script:CharBackupLast.ToString('yyyy-MM-dd HH:mm:ss') } else { '' })
        next = $(if ($script:CharBackupNext) { $script:CharBackupNext.ToString('yyyy-MM-dd HH:mm:ss') } else { '' }) }
}
function Get-CharRestoreFiles([string]$Date, [string]$File) {
    if ($Date -notmatch '^\d{8}$') { throw 'Ngay sao luu khong hop le.' }
    $dir = Join-Path $CharBackupRoot $Date
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { throw "Khong thay ban sao luu nhan vat $Date." }
    if ($File -eq '*') { $fs = @(Get-ChildItem -LiteralPath $dir -File -Filter 'role_*.pthc') }
    elseif ($File -match '^role_[0-9A-Fa-f]+\.pthc$' -and (Test-Path -LiteralPath (Join-Path $dir $File))) { $fs = @(Get-Item -LiteralPath (Join-Path $dir $File)) }
    else { throw 'Nhan vat khong co trong ban sao luu nay.' }
    if (-not $fs.Count) { throw 'Ban sao luu khong co file nhan vat.' }
    foreach ($f in $fs) { if (-not (Test-AdminOpsPthc ([IO.File]::ReadAllBytes($f.FullName)))) { throw "File sao luu $($f.Name) sai checksum, khong khoi phuc." } }
    , $fs
}
function Get-CharRestorePlan([string]$Date, [string]$File) {
    $fs = Get-CharRestoreFiles $Date $File
    Assert-AdminOpsStopped @('GameServer', 'Goddess', 'Bishop') 'toan bo server (GameServer, Goddess, Bishop)'
    [pscustomobject]@{ date = $Date; file = $File; code = (New-AdminOpsCode 'charrestore' "$Date|$File"); files = @($fs | ForEach-Object { "$(Get-AdminOpsCharName $_.Name) ($($_.Name), luu $($_.LastWriteTime.ToString('yyyy-MM-dd HH:mm')))" }) }
}
function Invoke-CharRestore([string]$Date, [string]$File, [string]$Code) {
    Confirm-AdminOpsCode 'charrestore' "$Date|$File" $Code
    $fs = Get-CharRestoreFiles $Date $File
    Assert-AdminOpsStopped @('GameServer', 'Goddess', 'Bishop') 'toan bo server (GameServer, Goddess, Bishop)'
    $safe = Join-Path $CharBackupRoot ('truoc-khoi-phuc-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
    New-Item -ItemType Directory -Force -Path $safe | Out-Null
    foreach ($f in $fs) { $cur = Join-Path $CharStoreDir $f.Name; if (Test-Path -LiteralPath $cur) { Copy-Item -LiteralPath $cur -Destination $safe } }
    foreach ($f in $fs) { Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $CharStoreDir $f.Name) -Force }
    $msg = "Da khoi phuc $($fs.Count) nhan vat tu ban $Date (" + (($fs | ForEach-Object { Get-AdminOpsCharName $_.Name }) -join ', ') + "); file hien tai luu o _backup\characters\$(Split-Path -Leaf $safe)."
    Write-AdminOpsLog 'charrestore' $msg
    $msg
}
# called from Invoke-Scheduler (every ~2 s while the web admin is idle): first backup at start, then every 24 h
function Invoke-AdminOpsTick {
    if ($script:CharBackupNext -and (Get-Date) -lt $script:CharBackupNext) { return }
    $reason = if ($script:CharBackupLast) { 'tu dong 24 gio' } else { 'mo web admin' }
    try { Write-Host (Invoke-CharBackup $reason) }
    catch {
        $script:CharBackupNext = (Get-Date).AddHours(1)
        Write-AdminOpsLog "charbackup ($reason)" "LOI: $($_.Exception.Message) (thu lai sau 1 gio)"
    }
}

# ---- character management (soft delete). Goddess (PhongThanCharacterStore.cpp) keeps every character only as
# CharacterStore\role_<hex of the ASCII-lowercased TCVN3 name>.pthc; the character list of an account is built at
# each request by scanning CharacterStore\*.pthc for that AccountName (no role table in LocalDB: database account
# only has Account_Info / Account_Habitus). The engine's own delete is DeleteFileA of that file, so moving the file
# out of CharacterStore removes the character everywhere. Deleted files go to _backup\characters\deleted\
# yyyyMMdd-HHmmss-<name>\ (file + info.json, never removed here) and can be copied back (max 3 per account).
$CharTrashRoot = Join-Path $CharBackupRoot 'deleted'
$CharAccountLimit = 3   # PHONGTHAN_CHARACTER_LIMIT (Headers\PhongThanProtocol.h)
function Read-AdminOpsRole([string]$Path) {
    $d = [IO.File]::ReadAllBytes($Path)
    $ok = Test-AdminOpsPthc $d
    if ($d.Length -lt 16 + 408) { return [pscustomobject]@{ ok = $false; role = ''; roleRaw = ''; account = ''; gender = -1; prof = -1; level = 0; size = $d.Length; data = $d } }
    $raw = $Enc1252.GetString($d, 32, 32).Split([char]0)[0]
    [pscustomobject]@{ ok = $ok; role = (ConvertFrom-Tcvn $Enc1252.GetBytes($raw)); roleRaw = $raw; account = $Enc1252.GetString($d, 64, 32).Split([char]0)[0]
        gender = [int]$d[96]; prof = [int]$d[97]; level = [BitConverter]::ToInt32($d, 224); size = $d.Length; data = $d }
}
function Get-AdminOpsOnlineState {
    $on = Get-Online
    $p = Join-Path $Bridge 'online.txt'
    $age = if (Test-Path -LiteralPath $p) { [int]((Get-Date) - (Get-Item -LiteralPath $p).LastWriteTime).TotalSeconds } else { -1 }
    [pscustomobject]@{ names = @($on.players | ForEach-Object { "$($_.name)".ToLowerInvariant() }); ageSec = $age; server = (@(Get-AdminOpsRunning @('GameServer')).Count -gt 0) }
}
function Get-AdminOpsCharList {
    $st = Get-AdminOpsOnlineState
    $list = foreach ($f in @(Get-ChildItem -LiteralPath $CharStoreDir -File -Filter 'role_*.pthc' -ErrorAction SilentlyContinue)) {
        $r = Read-AdminOpsRole $f.FullName
        $name = if ($r.role) { $r.role } else { Get-AdminOpsCharName $f.Name }
        [pscustomobject]@{ file = $f.Name; name = $name; account = $r.account; level = $r.level; prof = $r.prof; gender = $r.gender; ok = $r.ok
            saved = $f.LastWriteTime.ToString('yyyy-MM-dd HH:mm'); size = $f.Length; online = ($st.names -contains $name.ToLowerInvariant()) }
    }
    [pscustomobject]@{ characters = @($list | Sort-Object account, name); server = $st.server; onlineAgeSec = $st.ageSec; trash = @(Get-AdminOpsCharTrash) }
}
function Get-AdminOpsCharTrash {
    if (-not (Test-Path -LiteralPath $CharTrashRoot)) { return @() }
    @(foreach ($d in @(Get-ChildItem -LiteralPath $CharTrashRoot -Directory | Sort-Object Name -Descending)) {
        $ip = Join-Path $d.FullName 'info.json'; if (-not (Test-Path -LiteralPath $ip)) { continue }
        $i = [IO.File]::ReadAllText($ip, $Utf8) | ConvertFrom-Json
        [pscustomobject]@{ folder = $d.Name; name = $i.name; account = $i.account; level = $i.level; prof = $i.prof; file = $i.file; deleted = $i.deleted
            restored = "$($i.restored)"; exists = (Test-Path -LiteralPath (Join-Path $CharStoreDir $i.file)) }
    })
}
function Get-AdminOpsCharFile([string]$File) {
    if ($File -notmatch '^role_([0-9a-f]{2})+\.pthc$') { throw 'File nhan vat khong hop le.' }
    $p = Join-Path $CharStoreDir $File
    if (-not (Test-Path -LiteralPath $p)) { throw 'Khong thay nhan vat nay (co the da bi xoa).' }
    $r = Read-AdminOpsRole $p
    if (-not $r.ok) { throw 'File nhan vat sai checksum: khong xoa tu web, hay kiem tra bang tay.' }
    $r | Add-Member -NotePropertyName path -NotePropertyValue $p -PassThru
}
# offline check: never while the character is in online.txt; with GameServer running online.txt must be fresh (< 150 s)
function Assert-AdminOpsCharOffline([string]$Name) {
    $st = Get-AdminOpsOnlineState
    if ($st.names -contains $Name.ToLowerInvariant()) { throw "Nhan vat $Name dang online. Thoat nhan vat ra roi xoa." }
    if ($st.server -and ($st.ageSec -lt 0 -or $st.ageSec -gt 150)) { throw 'GameServer dang chay nhung online.txt cu hon 2 phut (cau noi chua chay): khong biet ai dang online. Doi cau noi hoac tat server roi xoa.' }
}
function Get-CharDeletePlan([string]$File) {
    $r = Get-AdminOpsCharFile $File
    Assert-AdminOpsCharOffline $r.role
    [pscustomobject]@{ file = $File; name = $r.role; account = $r.account; level = $r.level; prof = $r.prof; code = (New-AdminOpsCode 'chardelete' $File) }
}
function Invoke-CharDelete([string]$File, [string]$Code, [string]$TypedName) {
    Confirm-AdminOpsCode 'chardelete' $File $Code
    $r = Get-AdminOpsCharFile $File
    if ("$TypedName".Trim() -cne $r.role) { throw "Ten go lai khong dung (can go dung: $($r.role)). Chua xoa gi." }
    Assert-AdminOpsCharOffline $r.role
    $plain = ([regex]::Replace($r.role.Replace([string][char]0x111, 'd').Replace([string][char]0x110, 'D').Normalize([Text.NormalizationForm]::FormD), '[^A-Za-z0-9_-]', ''))
    if (-not $plain) { $plain = 'nv' }
    $dir = Join-Path $CharTrashRoot ((Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + $plain)
    $n = 2; $base = $dir; while (Test-Path -LiteralPath $dir) { $dir = "$base-$n"; $n++ }
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $hash = (Get-FileHash -LiteralPath $r.path).Hash
    # pending Lenh Bai Dao Si / Di Nhan sets of this name (admin_bridge\lbdaosi_pending.txt): saved here; removed from the
    # file only while GameServer is off (the running server keeps that file in memory and rewrites it)
    $notes = @()
    $lp = Join-Path $Bridge 'lbdaosi_pending.txt'
    if (Test-Path -LiteralPath $lp) {
        $all = [IO.File]::ReadAllLines($lp, $Enc1252)
        $mine = @($all | Where-Object { ($_ -split "`t", 3).Count -eq 3 -and ($_ -split "`t", 3)[2] -eq $r.roleRaw })
        if ($mine.Count) {
            [IO.File]::WriteAllLines((Join-Path $dir 'lbdaosi_pending.txt'), $mine, $Enc1252)
            if (@(Get-AdminOpsRunning @('GameServer')).Count) { $notes += "lbdaosi_pending.txt con $($mine.Count) dong cua nhan vat (GameServer dang chay, khong sua)" }
            else { [IO.File]::WriteAllLines($lp, @($all | Where-Object { $mine -notcontains $_ }), $Enc1252); $notes += "da go $($mine.Count) dong lbdaosi_pending.txt" }
        }
    }
    Move-Item -LiteralPath $r.path -Destination (Join-Path $dir $File)
    $info = [pscustomobject]@{ name = $r.role; account = $r.account; level = $r.level; prof = $r.prof; gender = $r.gender; file = $File; sha256 = $hash
        deleted = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); from = $r.path; notes = @($notes); restored = '' }
    [IO.File]::WriteAllText((Join-Path $dir 'info.json'), (ConvertTo-Json -InputObject $info -Depth 3), $Utf8)
    $msg = "Da xoa (mem) nhan vat $($r.role) (tai khoan $($r.account), cap $($r.level)); file luu o _backup\characters\deleted\$(Split-Path -Leaf $dir)" + $(if ($notes.Count) { '; ' + ($notes -join '; ') } else { '' }) + '.'
    Write-AdminOpsLog 'chardelete' $msg
    $msg
}
function Get-AdminOpsTrashEntry([string]$Folder) {
    if ($Folder -notmatch '^\d{8}-\d{6}-[A-Za-z0-9_-]+$') { throw 'Muc thung rac khong hop le.' }
    $dir = Join-Path $CharTrashRoot $Folder
    $ip = Join-Path $dir 'info.json'
    if (-not (Test-Path -LiteralPath $ip)) { throw 'Khong thay muc nay trong thung rac.' }
    $i = [IO.File]::ReadAllText($ip, $Utf8) | ConvertFrom-Json
    $src = Join-Path $dir $i.file
    if ("$($i.file)" -notmatch '^role_([0-9a-f]{2})+\.pthc$' -or -not (Test-Path -LiteralPath $src)) { throw 'Muc thung rac thieu file nhan vat.' }
    $r = Read-AdminOpsRole $src
    if (-not $r.ok) { throw 'File trong thung rac sai checksum, khong khoi phuc.' }
    if (Test-Path -LiteralPath (Join-Path $CharStoreDir $i.file)) { throw "Da co nhan vat ten $($r.role) trong game (trung ten): khong khoi phuc de tranh ghi de." }
    $same = 0   # broken files are skipped by Goddess too
    foreach ($f in @(Get-ChildItem -LiteralPath $CharStoreDir -File -Filter 'role_*.pthc' -ErrorAction SilentlyContinue)) { $o = Read-AdminOpsRole $f.FullName; if ($o.ok -and $o.account -ieq $r.account) { $same++ } }
    if ($same -ge $CharAccountLimit) { throw "Tai khoan $($r.account) da du $CharAccountLimit nhan vat: xoa bot mot nhan vat roi khoi phuc." }
    [pscustomobject]@{ dir = $dir; info = $i; infoPath = $ip; src = $src; role = $r; count = $same }
}
function Get-CharUndeletePlan([string]$Folder) {
    $e = Get-AdminOpsTrashEntry $Folder
    [pscustomobject]@{ folder = $Folder; name = $e.role.role; account = $e.role.account; level = $e.role.level; count = $e.count; code = (New-AdminOpsCode 'charundelete' $Folder) }
}
function Invoke-CharUndelete([string]$Folder, [string]$Code) {
    Confirm-AdminOpsCode 'charundelete' $Folder $Code
    $e = Get-AdminOpsTrashEntry $Folder
    $dst = Join-Path $CharStoreDir $e.info.file
    $tmp = "$dst.admin.tmp"
    Copy-Item -LiteralPath $e.src -Destination $tmp -Force
    [IO.File]::Move($tmp, $dst)
    $e.info.restored = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
    [IO.File]::WriteAllText($e.infoPath, (ConvertTo-Json -InputObject $e.info -Depth 3), $Utf8)
    $msg = "Da khoi phuc nhan vat $($e.role.role) (tai khoan $($e.role.account)) tu thung rac $Folder (ban trong thung rac van giu)."
    if (Test-Path -LiteralPath (Join-Path $e.dir 'lbdaosi_pending.txt')) { $msg += ' Bo chieu Lenh Bai cho cu luu trong thu muc thung rac, khong tu ap lai.' }
    Write-AdminOpsLog 'charundelete' $msg
    $msg
}

# ---- C4 bot party panel: admin_bridge\botparty_config.lua, read every minute by script\phongthan\bots\party.lua
# (PTBPC_Load); web copy data\botparty.json. count 0 = player menu (task 2071) / tab Bot; gs/ds/dn = class weights
# (all 0 = roster mix); lvoff / lvspread = bot level = player level + lvoff +- lvspread; chars = per character
# mode (0 game setting, 1 always on, 2 always off) and count (0 = general). Names are matched ASCII-lowercased.
$BotPartyJsonPath = Join-Path $DataDir 'botparty.json'
function Get-BotPartyConfig {
    if (Test-Path -LiteralPath $BotPartyJsonPath) { try { return ([IO.File]::ReadAllText($BotPartyJsonPath, $Utf8) | ConvertFrom-Json) } catch { } }
    [pscustomobject]@{ count = 0; gs = 0; ds = 0; dn = 0; lvoff = 0; lvspread = 2; chars = @() }
}
function Get-BotParty {
    $b = Get-Bots
    [pscustomobject]@{ config = (Get-BotPartyConfig); status = $b.status; party = $b.config.party; partyCount = $b.config.partyCount
        fileExists = (Test-Path -LiteralPath (Join-Path $Bridge 'botparty_config.lua'))
        online = @((Get-Online).players | ForEach-Object { [pscustomobject]@{ name = $_.name; level = $_.level; prof = $_.prof; mapName = $_.mapName } })
        characters = @(Get-Characters | ForEach-Object { $_.name }) }
}
function ConvertTo-BotPartyKey([string]$Name) {
    $sb = New-Object Text.StringBuilder('"')
    foreach ($b in (ConvertTo-Tcvn $Name)) {
        $c = [int]$b; if ($c -ge 65 -and $c -le 90) { $c += 32 }
        if ($c -ge 32 -and $c -le 126 -and $c -ne 34 -and $c -ne 92) { [void]$sb.Append([char]$c) } else { [void]$sb.Append('\' + $c.ToString('000')) }
    }
    [void]$sb.Append('"'); $sb.ToString()
}
function Set-BotParty($a) {
    $count = Clamp $a.count 0 7; $gs = Clamp $a.gs 0 10; $ds = Clamp $a.ds 0 10; $dn = Clamp $a.dn 0 10
    $lvoff = Clamp $a.lvoff -20 20; $sp = if ($null -eq $a.lvspread) { 2 } else { Clamp $a.lvspread 0 5 }
    $chars = @(); $keys = @{}
    foreach ($c in @($a.chars)) {
        if ($null -eq $c -or -not "$($c.name)".Trim()) { continue }
        $name = Assert-Name "$($c.name)".Trim()
        $mode = Clamp $c.mode 0 2; $cnt = Clamp $c.count 0 7
        if ($mode -eq 0 -and $cnt -eq 0) { continue }
        $key = ConvertTo-BotPartyKey $name
        if ($keys.ContainsKey($key)) { throw "Nhan vat $name bi lap trong danh sach." }
        $keys[$key] = 1
        $chars += [pscustomobject]@{ name = $name; mode = $mode; count = $cnt; key = $key }
    }
    if ($chars.Count -gt 50) { throw 'Toi da 50 nhan vat.' }
    $text = "-- Written by AdminWeb (tab To doi bot) $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); read by script\phongthan\bots\party.lua (PTBPC_Load)`n"
    $text += "PTBPC_CFG = { count = $count, gs = $gs, ds = $ds, dn = $dn, lvoff = $lvoff, lvspread = $sp, chars = {`n"
    foreach ($c in $chars) { $text += "`t{ name = $($c.key), mode = $($c.mode), count = $($c.count) },`n" }
    $text += "} }`n"
    $dst = Join-Path $Bridge 'botparty_config.lua'; $tmp = Join-Path $Bridge 'botparty_config.tmp'
    [IO.File]::WriteAllBytes($tmp, $Enc1252.GetBytes($text))
    if (Test-Path -LiteralPath $dst) { [IO.File]::Replace($tmp, $dst, [NullString]::Value) } else { [IO.File]::Move($tmp, $dst) }
    [IO.File]::WriteAllText($BotPartyJsonPath, (ConvertTo-Json -InputObject ([pscustomobject]@{ count = $count; gs = $gs; ds = $ds; dn = $dn; lvoff = $lvoff; lvspread = $sp
        chars = @($chars | ForEach-Object { [pscustomobject]@{ name = $_.name; mode = $_.mode; count = $_.count } }) }) -Depth 4), $Utf8)
    $desc = 'To doi bot: so bot ' + $(if ($count) { $count } else { 'theo NPC/tab Bot' }) + ', ti le GS:DS:DN ' + $(if ($gs + $ds + $dn) { "${gs}:${ds}:${dn}" } else { 'tron nhu cu' }) +
        ', cap nguoi choi ' + $(if ($lvoff -ge 0) { "+$lvoff" } else { "$lvoff" }) + " +-$sp, $($chars.Count) nhan vat rieng"
    # 'not PTBPC_Load': a server started before this update loads the new party.lua here (hot); PTBPC_Rebuild removes the
    # party bots of everyone online so PTBOT_AdminApply spawns them again with the new classes / levels at once
    Add-BridgeCommand 'To doi bot' $desc 'if not PTBPC_Load then dofile("script\\phongthan\\bots\\party.lua") end if PTBPC_Load then PTBPC_Load() local d = PTBPC_Rebuild() local n = 0 if PTBOT_AdminApply then n = PTBOT_AdminApply() end PTAdm_Log({ID}, "OK", "doi lai " .. d .. " bot to doi; bot dang song: " .. n) else PTAdm_Log({ID}, "FAIL", "party.lua tren server chua co ban adminops: da luu cau hinh, ap dung sau khi cai party.lua moi") end'
}

# ---------------------------------------------------------------- content 2026-10-04 (E1 lich su kien, E2 qua dang nhap, E4 thanh tich)
# E1: admin_bridge\eventsched_config.lua (re-read every minute by script\phongthan\content\ev_lib.lua, ext 'eventsched';
#     survives restarts), web copy data\eventsched.json, status admin_bridge\eventsched.txt (cfg / exp / row id, day, result).
#     The game runs the schedule itself (no need to keep the web admin open, unlike the older tab 'Su kien').
# E2: admin_bridge\dailygift_config.lua (read every minute by content\dg_lib.lua, ext 'dailygift'), web copy data\dailygift.json.
#     Rows are VNG tuples for AddNormalItemPile (g, d, p, lv, se), n units, st = max stack (cells = ceil(n / st)).
# E4: admin_bridge\thanhtich.txt written by content\ac_lib.lua (ext 'thanhtich'): one line per character.
# Doc: docs\features\noi-dung-moi-phong-than-20261004.md.
$EvJsonPath = Join-Path $DataDir 'eventsched.json'
$EvKinds = @('vantien', 'thuongchu', 'boss', 'exp')
$EvVngVt = @('02:00', '10:00', '13:00', '18:00', '21:00', '23:00')
function Get-EvConfig {
    if (Test-Path -LiteralPath $EvJsonPath) { try { return ([IO.File]::ReadAllText($EvJsonPath, $Utf8) | ConvertFrom-Json) } catch { } }
    # default = what scratchpad\content\gen_cfg.py wrote the first time (x2 exp Saturday + Sunday 20:00-22:00 on, templates off)
    [pscustomobject]@{ enabled = $true; pre = 5; rows = @(
        [pscustomobject]@{ id = 1; on = $true; days = '60'; hh = 20; mm = 0; kind = 'exp'; arg = 0; key = ''; dur = 120; title = '' },
        [pscustomobject]@{ id = 2; on = $false; days = '6'; hh = 20; mm = 30; kind = 'vantien'; arg = 1; key = ''; dur = 0; title = '' },
        [pscustomobject]@{ id = 3; on = $false; days = '0'; hh = 20; mm = 50; kind = 'thuongchu'; arg = 0; key = ''; dur = 0; title = '' },
        [pscustomobject]@{ id = 4; on = $false; days = '0123456'; hh = 21; mm = 30; kind = 'boss'; arg = 0; key = 'ly_long'; dur = 0; title = '' }) }
}
# next start of a row after $now (start minute counts until start + 2, like the Lua firing window)
function Get-EvNext($r, [datetime]$now) {
    $days = "$($r.days)"
    for ($d = 0; $d -le 7; $d++) {
        $day = $now.Date.AddDays($d)
        if ($days -ne '' -and -not $days.Contains([string][int]$day.DayOfWeek)) { continue }
        $at = $day.AddHours([int]$r.hh).AddMinutes([int]$r.mm)
        if ($at.AddMinutes(3) -gt $now) { return $at }
    }
    $null
}
function Get-EvWarn($r) {
    $w = @()
    $t = [int]$r.hh * 60 + [int]$r.mm
    if ($r.kind -eq 'vantien') {
        $first = 1; $last = 4; if ([int]$r.arg -ge 1) { $first = [int]$r.arg; $last = [int]$r.arg }
        foreach ($s in $EvVngVt) { $p = $s.Split(':'); foreach ($n in $first..$last) { $st = [int]$p[0] * 60 + [int]$p[1] + ($n - 1) * 5; if ($t -ge $st - 5 -and $t -lt $st + 35) { $w += "vtvng:$s" } } }
    }
    if ($r.kind -eq 'thuongchu' -and [int]$r.mm -lt 45) { $w += 'tcvng' }
    @($w | Select-Object -Unique)
}
function Get-EventSched {
    $cfg = Get-EvConfig
    $path = Join-Path $Bridge 'eventsched.txt'
    $st = [ordered]@{ stamp = $null; enabled = $null; source = ''; expEnd = 0; expLeft = 0; rows = @{} }
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $st.stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) {
            $c = $l -split "`t"
            if ($c[0] -eq 'cfg' -and $c.Count -ge 4) { $st.enabled = ($c[1] -eq '1'); $st.source = $c[3] }
            elseif ($c[0] -eq 'exp' -and $c.Count -ge 3) { $st.expEnd = [long]$c[1]; $st.expLeft = [int]$c[2] }
            elseif ($c[0] -eq 'row' -and $c.Count -ge 3) { $st.rows["$($c[1])"] = [pscustomobject]@{ day = $c[2]; result = $(if ($c.Count -ge 4) { $c[3] } else { '' }) } }
        }
    }
    $now = Get-Date
    $rows = foreach ($r in @($cfg.rows)) {
        if ($null -eq $r) { continue }
        $nx = if ($r.on -and $cfg.enabled) { Get-EvNext $r $now } else { $null }
        $live = $st.rows["$($r.id)"]
        [pscustomobject]@{ id = $r.id; on = [bool]$r.on; days = "$($r.days)"; hh = [int]$r.hh; mm = [int]$r.mm; kind = $r.kind; arg = [int]$r.arg; key = "$($r.key)"; dur = [int]$r.dur; title = "$($r.title)"
            next = $(if ($nx) { $nx.ToString('yyyy-MM-dd HH:mm') } else { '' }); lastDay = $(if ($live) { $live.day } else { '' }); result = $(if ($live) { $live.result } else { '' }); warn = @(Get-EvWarn $r) }
    }
    $bosses = @($WorldBoss | ForEach-Object { [pscustomobject]@{ key = $_.key; name = $_.name } })
    [pscustomobject]@{ enabled = [bool]$cfg.enabled; pre = [int]$cfg.pre; rows = @($rows); status = [pscustomobject]$st; bosses = $bosses; vngVt = $EvVngVt; now = $now.ToString('yyyy-MM-dd HH:mm (ddd)') }
}
function Set-EventSched($a) {
    $pre = Clamp $(if ($null -eq $a.pre) { 5 } else { $a.pre }) 1 30
    $en = [bool]$a.enabled
    $bossKeys = @($WorldBoss | ForEach-Object { "$($_.key)" })
    $rows = @(); $ids = @{}
    foreach ($r in @($a.rows)) {
        if ($null -eq $r) { continue }
        $id = Clamp $r.id 1 999
        if ($ids.ContainsKey($id)) { throw "Trung so dong $id." }; $ids[$id] = 1
        $kind = "$($r.kind)"; if ($EvKinds -notcontains $kind) { throw "Loai su kien khong hop le: $kind" }
        $days = -join @("$($r.days)".ToCharArray() | Where-Object { $_ -match '[0-6]' } | Select-Object -Unique)
        if ($days -eq '') { throw "Dong ${id}: chon it nhat mot ngay trong tuan." }
        $hh = Clamp $r.hh 0 23; $mm = Clamp $r.mm 0 59
        $arg = 0; $key = ''; $dur = 0
        if ($kind -eq 'vantien') { $arg = Clamp $r.arg 0 4 }
        if ($kind -eq 'boss') { $key = "$($r.key)"; if ($bossKeys -notcontains $key) { throw "Dong ${id}: boss '$key' khong co trong danh sach boss the gioi." } }
        if ($kind -eq 'exp') { $dur = Clamp $r.dur 1 1440 }
        $title = "$($r.title)".Trim(); if ($title.Length -gt 60) { throw "Dong ${id}: tieu de toi da 60 ky tu." }
        $rows += [pscustomobject]@{ id = $id; on = [bool]$r.on; days = $days; hh = $hh; mm = $mm; kind = $kind; arg = $arg; key = $key; dur = $dur; title = $title }
    }
    if ($rows.Count -gt 40) { throw 'Toi da 40 dong lich.' }
    $text = "-- Written by AdminWeb (tab Lich su kien) $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); read every minute by script\phongthan\content\ev_lib.lua`n"
    $text += "PTEV_CFG = { enabled = $([int]$en), pre = $pre, rows = {`n"
    foreach ($r in $rows) { $text += "`t{ id = $($r.id), on = $([int]$r.on), days = `"$($r.days)`", hh = $($r.hh), mm = $($r.mm), kind = `"$($r.kind)`", arg = $($r.arg), key = `"$($r.key)`", dur = $($r.dur), title = $(ConvertTo-LuaString $r.title) },`n" }
    $text += "} }`n"
    $dst = Join-Path $Bridge 'eventsched_config.lua'; $tmp = Join-Path $Bridge 'eventsched_config.tmp'
    [IO.File]::WriteAllBytes($tmp, $Enc1252.GetBytes($text))
    if (Test-Path -LiteralPath $dst) { [IO.File]::Replace($tmp, $dst, [NullString]::Value) } else { [IO.File]::Move($tmp, $dst) }
    [IO.File]::WriteAllText($EvJsonPath, (ConvertTo-Json -InputObject ([pscustomobject]@{ enabled = $en; pre = $pre; rows = @($rows) }) -Depth 5), $Utf8)
    "Da luu lich su kien: $($rows.Count) dong ($(@($rows | Where-Object on).Count) dang bat)" + $(if ($en) { '' } else { ', lich dang TAT' }) + '. Server doc lai trong vong 1 phut.'
}
$DgJsonPath = Join-Path $DataDir 'dailygift.json'
function New-DgRow($g, $d, $p, $lv, $se, $n, $st, $name) { [pscustomobject]@{ g = $g; d = $d; p = $p; lv = $lv; se = $se; n = $n; st = $st; name = $name } }
function Get-DgConfig {
    if (Test-Path -LiteralPath $DgJsonPath) { try { return ([IO.File]::ReadAllText($DgJsonPath, $Utf8) | ConvertFrom-Json) } catch { } }
    # default = PTDG_DEFAULT of content\dg_lib.lua (scratchpad\content\gen_e2.py)
    [pscustomobject]@{ enabled = $true; moneyDaily = 20000; moneyBig = 200000
        daily = @((New-DgRow 1 2 0 1 0 10 100 ([regex]::Unescape('\u0110\u1ea1i H\u1ed3ng \u0111\u01a1n'))), (New-DgRow 1 5 0 1 0 10 100 ([regex]::Unescape('\u0110\u1ea1i Ho\u00e0n \u0111\u01a1n'))), (New-DgRow 3 28 0 0 0 1 100 ([regex]::Unescape('H\u1ed3ng Th\u1ee7y Tinh'))))
        big = @((New-DgRow 8 1380 0 0 0 1 1 ([regex]::Unescape('Buff x2 kinh nghi\u1ec7m (24 gi\u1edd)'))), (New-DgRow 8 139 2 0 0 5 100 ([regex]::Unescape('Kh\u00f4ng Th\u01b0 (B\u1ea1ch)'))), (New-DgRow 3 28 0 0 0 5 100 ([regex]::Unescape('H\u1ed3ng Th\u1ee7y Tinh'))), (New-DgRow 1 2 0 1 0 30 100 ([regex]::Unescape('\u0110\u1ea1i H\u1ed3ng \u0111\u01a1n')))) }
}
# runtime item code (Get-ItemCode, AddItem tuple) -> VNG tuple of AddNormalItemPile + default max stack
function ConvertTo-DgRow([string]$Key, [int]$Count) {
    $c = Get-ItemCode $Key
    $g = [int]$c.g; $d = [int]$c.d; $p = [int]$c.p; $lv = [int]$c.lv; $se = [int]$c.se
    if ($g -eq 6) { $p = $d; $d = 1; $lv = 1; $se = 0 }           # magicscript runtime (6, ID, 0) -> VNG (6, 1, ID)
    elseif ($g -eq 3 -or $g -eq 4 -or $g -eq 8) { $lv = 0; $se = 0 }
    elseif ($g -eq 1 -and $lv -lt 1) { $lv = 1 }                    # medicine needs level >= 1
    $st = 1
    if ($g -eq 1 -or $g -eq 3) { $st = 100 }
    if ($g -eq 8 -and $d -ge 139 -and $d -le 142) { $st = 100 }
    New-DgRow $g $d $p $lv $se (Clamp $Count 1 100) $st "$($c.name)"
}
function Get-DailyGift {
    $path = Join-Path $Bridge 'thanhtich.txt'
    $stamp = $null; $chars = @()
    if (Test-Path -LiteralPath $path) {
        $lines = [IO.File]::ReadAllLines($path, $Enc1252)
        if ($lines.Count) { $stamp = $lines[0] }
        foreach ($l in ($lines | Select-Object -Skip 1)) {
            $c = $l -split "`t"; if ($c.Count -lt 15) { continue }
            $chars += [pscustomobject]@{ name = (ConvertFrom-Tcvn $Enc1252.GetBytes($c[0])); level = [int]$c[1]; boss = [int]$c[2]; chain = [int]$c[3]; pet = [int]$c[4]; vt = [int]$c[5]; tc = [int]$c[6]; kill = [long]$c[7]
                claim = "$($c[8])"; streak = [int]$c[9]; total = [int]$c[10]; day = "$($c[11])"; pendDaily = [int]$c[12]; pendBig = [int]$c[13]; seen = $c[14] }
        }
    }
    [pscustomobject]@{ config = (Get-DgConfig); stamp = $stamp; chars = @($chars | Sort-Object seen -Descending) }
}
function Set-DailyGift($a) {
    $lists = @{}
    foreach ($which in 'daily', 'big') {
        $out = @()
        foreach ($r in @($a.$which)) {
            if ($null -eq $r) { continue }
            if ($r.key) { $out += (ConvertTo-DgRow "$($r.key)" ([int]$r.n)); continue }
            $g = [int]$r.g; if (@(1, 3, 4, 6, 8) -notcontains $g) { throw "Nhom vat pham $g khong ho tro (chi thuoc, nguyen lieu, vat pham nhiem vu, magicscript, ky tran cac)." }
            $name = "$($r.name)".Trim(); if (-not $name -or $name.Length -gt 40) { throw 'Ten vat pham 1-40 ky tu.' }
            $out += (New-DgRow $g (Clamp $r.d 0 65535) (Clamp $r.p 0 65535) (Clamp $r.lv 0 10) (Clamp $r.se 0 4) (Clamp $r.n 1 100) (Clamp $r.st 1 1000) $name)
        }
        if ($out.Count -gt 10) { throw 'Toi da 10 dong qua moi loai.' }
        $lists[$which] = $out
    }
    $en = [bool]$a.enabled; $md = Clamp $a.moneyDaily 0 10000000; $mb = Clamp $a.moneyBig 0 10000000
    $row = { param($r) "`t`t{ g = $($r.g), d = $($r.d), p = $($r.p), lv = $($r.lv), se = $($r.se), n = $($r.n), st = $($r.st), name = $(ConvertTo-LuaString $r.name) },`n" }
    $text = "-- Written by AdminWeb (tab Qua & thanh tich) $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); read every minute by script\phongthan\content\dg_lib.lua`n"
    $text += "PTDG_CFG = { enabled = $([int]$en), moneyDaily = $md, moneyBig = $mb, daily = {`n"
    foreach ($r in $lists['daily']) { $text += (& $row $r) }
    $text += "`t}, big = {`n"
    foreach ($r in $lists['big']) { $text += (& $row $r) }
    $text += "`t} }`n"
    $dst = Join-Path $Bridge 'dailygift_config.lua'; $tmp = Join-Path $Bridge 'dailygift_config.tmp'
    [IO.File]::WriteAllBytes($tmp, $Enc1252.GetBytes($text))
    if (Test-Path -LiteralPath $dst) { [IO.File]::Replace($tmp, $dst, [NullString]::Value) } else { [IO.File]::Move($tmp, $dst) }
    [IO.File]::WriteAllText($DgJsonPath, (ConvertTo-Json -InputObject ([pscustomobject]@{ enabled = $en; moneyDaily = $md; moneyBig = $mb; daily = @($lists['daily']); big = @($lists['big']) }) -Depth 5), $Utf8)
    "Da luu qua dang nhap: $($lists['daily'].Count) dong qua ngay, $($lists['big'].Count) dong qua 7 ngay" + $(if ($en) { '' } else { ' (dang TAT)' }) + '. Server doc lai trong vong 1 phut.'
}
# ---------------------------------------------------------------- actions
function Assert-Name([string]$Name) { if (-not $Name -or $Name.Length -gt 32) { throw 'Ten nhan vat khong hop le.' }; $Name }
function Clamp([object]$v, [int]$min, [int]$max) { $n = [int]$v; if ($n -lt $min) { $min } elseif ($n -gt $max) { $max } else { $n } }
# 2026-10-04 (agent items) last lines of admin_bridge\hanhtrang_sell.log ("Don tui" of the Lenh Bai Hanh Trang):
# time, character, tay (button) / tu dong (auto clean), item, money. Reads at most the last 256 KB; TCVN3 -> Unicode.
function Get-HanhTrangLog([int]$Count = 200) {
    $p = Join-Path $Bridge 'hanhtrang_sell.log'
    if (-not (Test-Path -LiteralPath $p)) { return [pscustomobject]@{ exists = $false; total = 0; rows = @() } }
    $fs = [IO.File]::Open($p, 'Open', 'Read', 'ReadWrite')
    try {
        $len = $fs.Length; $take = [int][Math]::Min($len, 262144)
        [void]$fs.Seek($len - $take, 'Begin')
        $buf = New-Object byte[] $take; $n = 0
        while ($n -lt $take) { $k = $fs.Read($buf, $n, $take - $n); if ($k -le 0) { break }; $n += $k }
    } finally { $fs.Dispose() }
    $lines = @((ConvertFrom-Tcvn $buf) -split "`r?`n" | Where-Object { $_ -ne '' })
    if ($take -lt $len -and $lines.Count) { $lines = @($lines | Select-Object -Skip 1) }
    $rows = @($lines | Select-Object -Last $Count | ForEach-Object { $c = $_ -split "`t"; [pscustomobject]@{ time = $c[0]; player = $c[1]; why = $c[2]; item = $c[3]; money = $c[4] } })
    [pscustomobject]@{ exists = $true; total = $lines.Count; rows = $rows }
}
# 2026-10-05 natives: equipment upgrade +0..+12 (CoreServer natives GetItemListEntry/GetItemUpgrade/SetItemUpgrade).
# The Lua helpers live in AdminWeb\lua\pt_upgrade_bridge.lua and travel with each bridge command;
# PTUP_List writes admin_bridge\upgrade_items.txt (time, player, state, then idx/id/place/x/y/level/rule/name).
function Get-UpgradeLua { [IO.File]::ReadAllText((Join-Path $PSScriptRoot 'lua\pt_upgrade_bridge.lua'), $Enc1252) }
function Get-UpgradeItems {
    $path = Join-Path $Bridge 'upgrade_items.txt'
    $res = [ordered]@{ stamp = $null; player = ''; state = ''; items = @() }
    if (-not (Test-Path -LiteralPath $path)) { return [pscustomobject]$res }
    $lines = [IO.File]::ReadAllLines($path, $Enc1252)
    if ($lines.Count) {
        $h = $lines[0] -split "`t"; $res.stamp = $h[0]
        if ($h.Count -ge 3) { $res.player = (ConvertFrom-Tcvn $Enc1252.GetBytes($h[1])); $res.state = $h[2] }
    }
    $list = New-Object Collections.Generic.List[object]
    foreach ($l in ($lines | Select-Object -Skip 1)) {
        $c = $l -split "`t"; if ($c.Count -lt 8 -or $c[0] -notmatch '^\d+$' -or $c[1] -notmatch '^\d+$') { continue }
        $list.Add([pscustomobject]@{ idx = [int]$c[0]; id = [double]$c[1]; place = [int]$c[2]; x = [int]$c[3]; y = [int]$c[4]; level = [int]$c[5]; rule = [int]$c[6]; name = (ConvertFrom-Tcvn $Enc1252.GetBytes($c[7])) })
    }
    $res.items = $list.ToArray()
    [pscustomobject]$res
}
function Invoke-Action($a) {
    switch ($a.type) {
        'give' {
            $code = Get-ItemCode $a.itemKey; $n = Clamp $a.count 1 50; $name = Assert-Name $a.player
            Add-BridgeCommand 'Phat do' "$name <- $($code.name) x$n" ("PTAdm_Give({ID}, $(ConvertTo-LuaString $name), $($code.g), $($code.d), $($code.p), $($code.lv), $($code.se), $n, $(ConvertTo-LuaString $code.name))")
        }
        'giveall' {
            $code = Get-ItemCode $a.itemKey; $n = Clamp $a.count 1 50
            Add-BridgeCommand 'Phat do toan server' "Tat ca <- $($code.name) x$n" ("PTAdm_GiveAll({ID}, $($code.g), $($code.d), $($code.p), $($code.lv), $($code.se), $n, $(ConvertTo-LuaString $code.name))")
        }
        'money' { $name = Assert-Name $a.player; $v = Clamp $a.amount 1 2000000000; Add-BridgeCommand 'Tang tien' "$name +$v luong" "PTAdm_Money({ID}, $(ConvertTo-LuaString $name), $v)" }
        'coin' {
            # Tien dong = account ExtPoint (Ky Tran Cac currency). Inline Lua so the
            # running servertimer.lua needs no reload; AddExtPoint marks it changed.
            $name = Assert-Name $a.player; $v = Clamp $a.amount 1 1000000; $ln = ConvertTo-LuaString $name
            Add-BridgeCommand 'Tang tien dong' "$name +$v tien dong" ("local pi = PTAdm_FindPlayer($ln) if pi then AddExtPoint($v) Msg2Player(" + (ConvertTo-LuaString ("Admin t" + [char]0x1EB7 + "ng $v ti" + [char]0x1EC1 + "n " + [char]0x111 + [char]0x1ED3 + "ng")) + ") PTAdm_Log({ID}, `"OK`", $ln .. `" coin+$v now=`" .. GetExtPoint()) else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end")
        }
        'skills' {
            $name = Assert-Name $a.player; $prof = [int]$a.prof
            if (-not $ProfRanges.ContainsKey($prof)) { throw 'Phai khong hop le.' }
            $lv = Clamp $a.level 1 10
            $ids = @($a.skills | ForEach-Object { [int]$_ } | Where-Object { ($_ -ge $ProfRanges[$prof][0] -and $_ -le $ProfRanges[$prof][1]) -or ($RebirthByProf[$prof] -contains $_) } | Select-Object -Unique)
            if (-not $ids.Count) { throw 'Chua chon ky nang nao cua phai nay.' }
            $check = if ($a.checkProf -eq $false) { -1 } else { $prof }
            $profName = @('Giap Si', 'Dao Si', 'Di Nhan')[$prof]
            Add-BridgeCommand 'Bi kip / ky nang' "$name <- $($ids.Count) ky nang $profName cap $lv" ("PTAdm_SetSkills({ID}, $(ConvertTo-LuaString $name), $check, $lv, {" + ($ids -join ', ') + "})")
        }
        'level' {
            # KPlayer::SetLevel rolls every skill back to 0 (refunding points) and
            # refunds attribute points; skills 1..60, the summon skills 450..461, the rebirth skills 1478..1489 and the
            # Than Ky skills 1986..2000 (2026-10-05, agent thanky) are captured and restored.
            $name = Assert-Name $a.player; $v = Clamp $a.level 1 200; $ln = ConvertTo-LuaString $name
            $msg = ConvertTo-LuaString ("Admin: level " + $v)
            Add-BridgeCommand 'Tang level' "$name -> level $v" ("local pi = PTAdm_FindPlayer($ln) if pi then local sk = {} local s = 1 while s <= 2000 do if s <= 60 or (s >= 1478 and s <= 1489) or s >= 1986 or (s >= 450 and s <= 461) then local l = GetMagicLevel(s) if l and l > 0 then sk[s] = l end end s = s + 1 end SetLevel($v) s = 1 while s <= 2000 do if sk[s] then SetSkillLevel(s, sk[s]) AddMagic(s, sk[s]) end s = s + 1 end Msg2Player($msg) PTAdm_Log({ID}, `"OK`", $ln .. `" level=`" .. GetLevel()) else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end")
        }
        'attr' {
            # Attribute points (2026-10-02). AddStrg/AddDex/AddVit/AddEng add to the base value and subtract
            # the same amount from the free points (ScriptFuns.cpp LuaSetPlayer*), so AddProp(total) first
            # keeps the player's own free points. ResetProp refunds every spent point.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name
            $show = "`" str=`" .. GetStrg(1) .. `" dex=`" .. GetDex(1) .. `" vit=`" .. GetVit(1) .. `" eng=`" .. GetEng(1) .. `" free=`" .. GetProp() .. `" AR=`" .. (GetDex(1) * 4 - 28)"
            if ($a.info) {
                Add-BridgeCommand 'Diem thuoc tinh' "$name xem chi so" ("local pi = PTAdm_FindPlayer($ln) if pi then PTAdm_Log({ID}, `"OK`", $ln .. $show) else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end")
            } elseif ($a.reset) {
                Add-BridgeCommand 'Diem thuoc tinh' "$name tay diem" ("local pi = PTAdm_FindPlayer($ln) if pi then ResetProp() Msg2Player(`"Admin: da tay diem thuoc tinh, hay cong lai o F3`") PTAdm_Log({ID}, `"OK`", $ln .. `" reset`" .. $show) else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end")
            } else {
                $s = Clamp $a.str 0 5000; $dx = Clamp $a.dex 0 5000; $v = Clamp $a.vit 0 5000; $e = Clamp $a.eng 0 5000; $p = Clamp $a.prop 0 10000
                $tot = $s + $dx + $v + $e
                if (($tot + $p) -le 0) { throw 'Hay nhap so diem can cong.' }
                $lua = "local pi = PTAdm_FindPlayer($ln) if pi then "
                if ($tot -gt 0) { $lua += "AddProp($tot) " }
                if ($s -gt 0) { $lua += "AddStrg($s) " }; if ($dx -gt 0) { $lua += "AddDex($dx) " }
                if ($v -gt 0) { $lua += "AddVit($v) " }; if ($e -gt 0) { $lua += "AddEng($e) " }
                if ($p -gt 0) { $lua += "AddProp($p) " }
                $lua += "Msg2Player(`"Admin: cong diem thuoc tinh`") PTAdm_Log({ID}, `"OK`", $ln .. $show) else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end"
                Add-BridgeCommand 'Diem thuoc tinh' "$name +suc manh $s, than phap $dx, sinh khi $v, noi cong $e, tiem nang $p" $lua
            }
        }
        'upgradelist' {
            # 2026-10-05 natives: list worn + bag equipment of an online player (see Get-UpgradeItems)
            $name = Assert-Name $a.player
            try { Remove-Item -LiteralPath (Join-Path $Bridge 'upgrade_items.txt') -Force -ErrorAction Stop } catch {}
            Add-BridgeCommand 'Cuong hoa' "$name liet ke trang bi" ((Get-UpgradeLua) + "`nPTUP_List({ID}, $(ConvertTo-LuaString $name))")
        }
        'upgradeset' {
            # 2026-10-05 natives: SetItemUpgrade(item, +0..+12) on an online player; offline -> FAIL (nothing queued for login)
            $name = Assert-Name $a.player; $lv = Clamp $a.level 0 12; $id = [double]"0$($a.itemId)"
            if ($id -lt 1 -or $id -gt 4294967295) { throw 'Chua chon mon trang bi.' }
            $ids = '{0:F0}' -f $id
            $msg = ConvertTo-LuaString ("Admin: trang b" + [char]0x1ECB + " " + [char]0x111 + [char]0x1B0 + [char]0x1EE3 + "c " + [char]0x111 + [char]0x1EB7 + "t c" + [char]0x1B0 + [char]0x1EDD + "ng h" + [char]0xF3 + "a +")
            Add-BridgeCommand 'Cuong hoa' "$name mon id $ids -> +$lv" ((Get-UpgradeLua) + "`nPTUP_Set({ID}, $(ConvertTo-LuaString $name), $ids, $lv, $msg)")
        }
        'exp' { $name = Assert-Name $a.player; $v = Clamp $a.amount 1 2000000000; Add-BridgeCommand 'Tang kinh nghiem' "$name +$v exp" "PTAdm_Exp({ID}, $(ConvertTo-LuaString $name), $v)" }
        'news' { $t = "$($a.text)".Trim(); if (-not $t -or $t.Length -gt 250) { throw 'Noi dung thong bao 1-250 ky tu.' }; Add-BridgeCommand 'Thong bao' $t "PTAdm_News({ID}, $(ConvertTo-LuaString $t))" }
        'spawn' {
            $npc = Clamp $a.npc 0 ($Npcs.Count - 1); $lv = Clamp $a.level 1 200; $n = Clamp $a.count 1 30
            $label = "$($Npcs[$npc].name) (#$npc) lv$lv x$n"
            if ($a.mode -eq 'player') { $name = Assert-Name $a.player; Add-BridgeCommand 'Tao boss/NPC' "$label canh $name" "PTAdm_SpawnNear({ID}, $npc, $lv, $(ConvertTo-LuaString $name), $n)" }
            else { $m = [int]$a.map; $x = Clamp $a.x 0 100000; $y = Clamp $a.y 0 100000; Add-BridgeCommand 'Tao boss/NPC' "$label tai $m ($x,$y)" "PTAdm_SpawnAt({ID}, $npc, $lv, $m, $x, $y, $n)" }
        }
        'clear' { Add-BridgeCommand 'Xoa boss/NPC' 'Xoa tat ca NPC tao tu web' 'PTAdm_ClearSpawned({ID})' }
        'wbspawn' {
            $b = @($WorldBoss | Where-Object { $_.key -eq "$($a.key)" })[0]; if (-not $b) { throw 'Khong tim thay boss the gioi.' }
            Add-BridgeCommand 'Boss the gioi' "Goi $($b.key) ngay" ("if not PTWB_SpawnKey then dofile(`"script\\phongthan\\boss\\wb_lib.lua`") end local r = PTWB_SpawnKey(`"$($b.key)`") if r > 0 then PTAdm_Log({ID}, `"OK`", `"npc=`" .. r) elseif r == 0 then PTAdm_Log({ID}, `"OK`", `"dang song`") else PTAdm_Log({ID}, `"FAIL`", `"ket qua `" .. r) end")
        }
        'vtopen' {
            # 2026-10-02 Van Tien tran: open tran n (1 Tho, 2 Thuy, 3 Hoa, 4 Phong) now, 5 min preparation.
            # PTVT_AdminOpen (script\phongthan\vantien\vt_timer.lua): 1 opened, 2 already open, 0 map not loaded.
            $n = [int]$a.tran; if ($n -lt 1 -or $n -gt 4) { throw 'Tran Van Tien phai la 1..4.' }
            $tn = @('', 'Tho', 'Thuy', 'Hoa', 'Phong')[$n]
            Add-BridgeCommand 'Van Tien tran' "Mo Van Tien tran $n ($tn)" ("if not PTVT_AdminOpen then dofile(`"script\\phongthan\\vantien\\vt_timer.lua`") end local r = PTVT_AdminOpen($n) if r == 1 then PTAdm_Log({ID}, `"OK`", `"da mo tran $n ($tn), 5 phut chuan bi`") elseif r == 2 then PTAdm_Log({ID}, `"OK`", `"tran $n ($tn) dang mo san`") else PTAdm_Log({ID}, `"FAIL`", `"khong mo duoc tran $n, ket qua `" .. tostring(r)) end")
        }
        'bikipmats' {
            # 2026-10-03 (agent bikip2) materials of "Dong sach (ep bi kip)": counts per material (mats.p139 ...), or
            # bundle = n presses of each chosen tier (tiers 139..142, default all). One bridge command, flat statements.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name
            $cnt = [ordered]@{}; foreach ($k in $BiKipMats.Keys) { $cnt[$k] = 0 }
            $bv = 0; if ($a.bundle) { $bv = $a.bundle }; $bundle = Clamp $bv 0 10
            if ($bundle -gt 0) {
                $tiers = @($a.tiers | ForEach-Object { [int]$_ } | Where-Object { $BiKipTier.ContainsKey($_) } | Select-Object -Unique)
                if (-not $tiers.Count) { $tiers = @(139, 140, 141, 142) }
                foreach ($t in $tiers) { foreach ($k in $BiKipTier[$t].Keys) { $cnt[$k] += $BiKipTier[$t][$k] * $bundle } }
            } else {
                foreach ($k in $BiKipMats.Keys) { if ($a.mats -and $a.mats.$k) { $cnt[$k] = Clamp $a.mats.$k 0 50 } }
            }
            $total = 0; $desc = @(); $lua = "local pi = PTAdm_FindPlayer($ln) if pi then local ok = 0 "
            foreach ($k in $BiKipMats.Keys) {
                $n = [int]$cnt[$k]; if ($n -le 0) { continue }
                $m = $BiKipMats[$k]; $total += $n; $desc += "$($m[3]) x$n"
                $lua += "ok = ok + PTAdm_GiveTo(pi, $($m[0]), $($m[1]), $($m[2]), 1, 0, $n) "
            }
            if (-not $total) { throw 'Chua nhap so luong nguyen lieu nao.' }
            if ($total -gt 200) { throw 'Toi da 200 mon moi lan (hanh trang co han).' }
            $msg = ConvertTo-LuaString ([regex]::Unescape('Admin t\u1eb7ng nguy\u00ean li\u1ec7u \u00e9p s\u00e1ch: '))
            $lua += "PlayerIndex = pi Msg2Player($msg .. ok .. `"/$total`") if ok == $total then PTAdm_Log({ID}, `"OK`", $ln .. `" +`" .. ok) else PTAdm_Log({ID}, `"FAIL`", $ln .. `" created `" .. ok .. `"/$total (hanh trang day?)`") end else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end"
            Add-BridgeCommand 'Nguyen lieu ep sach' ("$name <- " + $(if ($bundle -gt 0) { "bo $bundle lan ep: " } else { '' }) + ($desc -join ', ')) $lua
        }
        'bikip' {
            # 2026-10-03 (agent bikip2) bi kip items 6/1/(62000 + skill) of one profession: chosen skills or all of them.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name; $prof = [int]$a.prof
            if (-not $BiKipByProf.ContainsKey($prof)) { throw 'Phai khong hop le.' }
            $cv = 1; if ($a.count) { $cv = $a.count }; $n = Clamp $cv 1 10
            $ids = @(if ($a.all) { $BiKipByProf[$prof] } else { $a.skills | ForEach-Object { [int]$_ } | Where-Object { $BiKipByProf[$prof] -contains $_ } | Select-Object -Unique })
            if (-not $ids.Count) { throw 'Chua chon bi kip nao cua phai nay.' }
            $total = $ids.Count * $n
            if ($total -gt 200) { throw 'Toi da 200 cuon moi lan (hanh trang co han).' }
            $lua = "local pi = PTAdm_FindPlayer($ln) if pi then local ok = 0 "
            foreach ($id in $ids) { $lua += "ok = ok + PTAdm_GiveTo(pi, 6, $(62000 + $id), 0, 1, 0, $n) " }
            $msg = ConvertTo-LuaString ([regex]::Unescape('Admin t\u1eb7ng b\u00ed k\u00edp h\u1ec7 ph\u00e1i: '))
            $lua += "PlayerIndex = pi Msg2Player($msg .. ok .. `"/$total`") if ok == $total then PTAdm_Log({ID}, `"OK`", $ln .. `" +`" .. ok) else PTAdm_Log({ID}, `"FAIL`", $ln .. `" created `" .. ok .. `"/$total (hanh trang day?)`") end else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end"
            $profName = @('Giap Si', 'Dao Si', 'Di Nhan')[$prof]
            Add-BridgeCommand 'Bi kip he phai' ("$name <- " + $(if ($a.all) { "tat ca $($ids.Count) bi kip $profName" } else { "bi kip " + ($ids -join ', ') }) + " x$n") $lua
        }
        'thanky' {
            # 2026-10-05 (agent thanky) Than Ky + Vien Thuoc Tinh. mode: book (skills, cap 1..5, 1..10 each), manh (skills,
            # 1..250 pieces each), stone (keys of $ThanKyStones, 1..20 each), teach (skills -> level 1..10 now, SetSkillLevel +
            # AddMagic like 'level'), info (skill levels + stone counters). One bridge command, flat statements.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name; $mode = "$($a.mode)"
            $sks = @($a.skills | ForEach-Object { [int]$_ } | Where-Object { $ThanKy.ContainsKey($_) } | Select-Object -Unique)
            $lua = "local pi = PTAdm_FindPlayer($ln) if pi then local ok = 0 "
            $tail = " else PTAdm_Log({ID}, `"FAIL`", `"offline `" .. $ln) end"
            if ($mode -eq 'info') {
                $lua += "PTAdm_Log({ID}, `"OK`", $ln .. `" than ky:"
                foreach ($s in @($ThanKy.Keys | Sort-Object)) { $lua += " $s=`" .. (GetMagicLevel($s) or 0) .. `"" }
                $lua += " | vien: suc manh `" .. GetTask(2690) .. `", ngo tinh `" .. GetTask(2691) .. `", the chat `" .. GetTask(2692) .. `", than phap `" .. GetTask(2693) .. `" (max 100 moi chi so) | goc str=`" .. GetStrg(1) .. `" eng=`" .. GetEng(1) .. `" vit=`" .. GetVit(1) .. `" dex=`" .. GetDex(1))"
                Add-BridgeCommand 'Than Ky' "$name xem Than Ky / Vien Thuoc Tinh" ($lua + $tail)
                return
            }
            if ($mode -eq 'stone') {
                $keys = @($a.stones | ForEach-Object { [int]$_ } | Where-Object { $ThanKyStones -contains $_ } | Select-Object -Unique)
                if (-not $keys.Count) { throw 'Chua chon vien / tui nao.' }
                $cv = 1; if ($a.count) { $cv = $a.count }; $n = Clamp $cv 1 20; $total = $keys.Count * $n
                if ($total -gt 200) { throw 'Toi da 200 mon moi lan (hanh trang co han).' }
                foreach ($k in $keys) { $lua += "ok = ok + PTAdm_GiveTo(pi, 6, $k, 0, 1, 0, $n) " }
                $what = "vien/tui " + ($keys -join ', ') + " x$n"
                $msg = ConvertTo-LuaString ([regex]::Unescape('Admin t\u1eb7ng Vi\u00ean / T\u00fai Thu\u1ed9c T\u00ednh: '))
            } else {
                if (-not $sks.Count) { throw 'Chua chon Than Ky nao.' }
                if ($mode -eq 'teach') {
                    $lv = Clamp $a.level 1 10; $total = $sks.Count
                    foreach ($s in $sks) { $lua += "SetSkillLevel($s, $lv) AddMagic($s, $lv) if GetMagicLevel($s) == $lv then ok = ok + 1 end " }
                    $what = "day Than Ky " + ($sks -join ', ') + " cap $lv"
                    $msg = ConvertTo-LuaString ([regex]::Unescape("Admin: \u0111\u00e3 \u0111\u1eb7t Th\u1ea7n K\u1ef9 c\u1ea5p $lv, s\u1ed1 k\u1ef9 n\u0103ng: "))
                } elseif ($mode -eq 'manh') {
                    $cv = 30; if ($a.count) { $cv = $a.count }; $n = Clamp $cv 1 250; $total = $sks.Count * $n
                    if ($total -gt 600) { throw 'Toi da 600 manh moi lan.' }
                    foreach ($s in $sks) { $lua += "ok = ok + PTAdm_GiveTo(pi, 6, $($ThanKy[$s][1]), 0, 1, 0, $n) " }
                    $what = "manh Than Ky " + ($sks -join ', ') + " x$n"
                    $msg = ConvertTo-LuaString ([regex]::Unescape('Admin t\u1eb7ng M\u1ea3nh Th\u1ea7n K\u1ef9: '))
                } else {
                    $cap = Clamp $a.cap 1 5; $cv = 1; if ($a.count) { $cv = $a.count }; $n = Clamp $cv 1 10; $total = $sks.Count * $n
                    foreach ($s in $sks) { $lua += "ok = ok + PTAdm_GiveTo(pi, 6, $($ThanKy[$s][2][$cap - 1]), 0, 1, 0, $n) " }
                    $what = "sach Than Ky " + ($sks -join ', ') + " cap $cap x$n"
                    $msg = ConvertTo-LuaString ([regex]::Unescape('Admin t\u1eb7ng s\u00e1ch Th\u1ea7n K\u1ef9: '))
                }
            }
            $lua += "PlayerIndex = pi Msg2Player($msg .. ok .. `"/$total`") if ok == $total then PTAdm_Log({ID}, `"OK`", $ln .. `" +`" .. ok) else PTAdm_Log({ID}, `"FAIL`", $ln .. `" `" .. ok .. `"/$total (hanh trang day / sai phai?)`") end"
            Add-BridgeCommand 'Than Ky' "$name <- $what" ($lua + $tail)
        }
        'chest' {
            # 2026-10-03 (ruong) Ruong chua do mo rong: to = 2..6 (Ruong k = SetExpandBox(k-1)); info = only report. See Get-ChestPath.
            # Online (online.txt): SetExpandBox through the bridge. Offline: patch the character file now (backup data\chest_backup);
            # the bridge command still runs and applies SetExpandBox if the character is in game after all. Never lowers the count.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name
            $online = @(Get-Online | Where-Object { $_.name -eq $name }).Count -gt 0
            if ($a.info) {
                $f = $null; $ft = 'khong co file nhan vat'
                try { $f = Read-ChestFile $name; if ($f) { $ft = "file: da mo den ruong $($f.box + 1)" } } catch { $ft = "file loi: $($_.Exception.Message)" }
                $ft = ($ft -replace '[^\x20-\x7E]', '?') -replace '["\\]', '/'
                Add-BridgeCommand 'Ruong mo rong' "$name xem so ruong ($ft)" ("local pi = PTAdm_FindPlayer($ln) if pi then local o = GetExpandBox() or 0 PTAdm_Log({ID}, `"OK`", $ln .. `" online: da mo den ruong `" .. (o + 1)) else PTAdm_Log({ID}, `"OK`", `"offline `" .. $ln .. `" - $ft`") end")
            } else {
                $to = Clamp $a.to 2 6; $n = $to - 1
                $ft = 'online, ap qua server'; $offStatus = 'FAIL'
                if (-not $online) { $r = Set-ChestFile $name $n; $ft = $r.text; if ($r.ok) { $offStatus = 'OK' } }
                else { $ft = 'luc xep lenh dang online nhung khi chay da thoat: bam lai de sua file' }
                $ft = ($ft -replace '[^\x20-\x7E]', '?') -replace '["\\]', '/'
                $msg = ConvertTo-LuaString ([regex]::Unescape("Admin: \u0111\u00e3 m\u1edf \u0111\u1ebfn R\u01b0\u01a1ng $to. M\u1edf r\u01b0\u01a1ng \u1edf Th\u1ee7 Kh\u1ed1, b\u1ea5m m\u0169i t\u00ean ph\u1ea3i trong khung r\u01b0\u01a1ng \u0111\u1ec3 sang R\u01b0\u01a1ng 2 - $to."))
                $lua = "local pi = PTAdm_FindPlayer($ln) if pi then local o = GetExpandBox() or 0 if o < $n then SetExpandBox($n) end local m = GetExpandBox() or 0 "
                $lua += "if m >= $n then Msg2Player($msg) PTAdm_Log({ID}, `"OK`", $ln .. `" online: ruong mo rong `" .. o .. `" -> `" .. m .. `" (mo den ruong `" .. (m + 1) .. `")`") "
                $lua += "else PTAdm_Log({ID}, `"FAIL`", $ln .. `" SetExpandBox khong co tac dung`") end "
                $lua += "else PTAdm_Log({ID}, `"$offStatus`", `"offline `" .. $ln .. `" - $ft`") end"
                Add-BridgeCommand 'Ruong mo rong' ("$name mo den ruong $to (" + $(if ($online) { 'online' } else { "offline, $($r.text)" }) + ")") $lua
            }
        }
        'lbskills' {
            # 2026-10-04 (agent lbdaosi) skill set of the Lenh Bai Dao Si (which 1: task 2613, skills 3..26) or the
            # Lenh Bai Di Nhan (which 2: task 2614, skills 43..51) for the client auto fight. mask = sum 2^(id - base),
            # off = 0 (Dao Si: skills on the keys; Di Nhan: no support skills). Online: applied and synced now; offline:
            # kept in admin_bridge\lbdaosi_pending.txt and applied at the next login (script\phongthan\item\lbdaosi_lib.lua).
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name; $which = [int]$a.which
            # lbdaosi r3: which 3 = Lenh Bai Giap Si (task 2619, skills 27..42).
            if ($which -lt 1 -or $which -gt 3) { throw 'Loai lenh bai khong hop le (1 Dao Si, 2 Di Nhan, 3 Giap Si).' }
            $base = @(0, 3, 43, 27)[$which]; $last = @(0, 26, 51, 42)[$which]
            $ids = @(if (-not $a.off) { $a.skills | ForEach-Object { [int]$_ } | Where-Object { $_ -ge $base -and $_ -le $last } | Select-Object -Unique | Sort-Object })
            if (-not $a.off -and -not $ids.Count) { throw 'Chua chon chieu nao (hoac bam nut tat).' }
            [long]$mask = 0; foreach ($id in $ids) { $mask += [long]1 -shl ($id - $base) }
            $label = @('', 'Dao Si', 'Di Nhan', 'Giap Si')[$which]
            $desc = if ($mask -eq 0) { $(if ($which -eq 2) { 'tat' } else { 'theo phim dang gan' }) } else { 'chieu ' + ($ids -join ', ') }
            Add-BridgeCommand 'Lenh bai luan phien' "$name <- $label $desc" ("if not PTLB_AdminSet then dofile(`"script\\phongthan\\item\\lbdaosi_lib.lua`") end PTLB_AdminSet({ID}, $ln, $which, $mask)")
        }
        'lbmax' {
            # 2026-10-04 (agent lbdaosi r3) raise profession skills to their max level (skills.txt MaxLevel, as the token's
            # "Nang cap ky nang"): skill 0 = every skill of the profession (rebirth skills only once their level is reached),
            # else one skill. prof 0 Giap Si, 1 Dao Si, 2 Di Nhan (checked on the character). Skill points neither spent nor
            # refunded. Online now; offline kept in admin_bridge\lbdaosi_pending.txt (kind 4) until the next login.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name; $prof = [int]$a.prof
            if (-not $ProfRanges.ContainsKey($prof)) { throw 'Phai khong hop le.' }
            $sk = 0; if ($a.skill) { $sk = [int]$a.skill }
            if ($sk -ne 0 -and -not (($sk -ge $ProfRanges[$prof][0] -and $sk -le $ProfRanges[$prof][1]) -or (@(1481, 1484, 1487)[$prof] -le $sk -and $sk -le @(1483, 1486, 1489)[$prof]))) { throw "Ky nang $sk khong thuoc phai nay." }
            $profName = @('Giap Si', 'Dao Si', 'Di Nhan')[$prof]
            $desc = if ($sk -eq 0) { "toan bo ky nang $profName" } else { "ky nang $sk" }
            Add-BridgeCommand 'Nang max ky nang' "$name <- $desc len cap toi da" ("if not PTLB_AdminMax then dofile(`"script\\phongthan\\item\\lbdaosi_lib.lua`") end PTLB_AdminMax({ID}, $ln, $prof, $sk)")
        }
        'hanhtrang' {
            # 2026-10-04 (agent items) Lenh Bai Hanh Trang settings (script\phongthan\item\hanhtrang_lib.lua PTHT_AdminSet):
            # pick[] = pickup filter bits 0..10 (task 2640, client auto pickup), sell[] = clean-bag bits 0..3 (task 2641),
            # blv = magic equipment sold below this item level (task 2642, 2..11); default = the default filters.
            # Online: applied and synced now; offline: admin_bridge\hanhtrang_pending.txt, applied at the next login.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name
            if ($a.default) { $pick = 1789; $sell = 3; $blv = 5 }
            else {
                $pick = 0; foreach ($v in @($a.pick | Where-Object { $null -ne $_ })) { $k = [int]$v; if ($k -ge 0 -and $k -le 10) { $pick = $pick -bor (1 -shl $k) } }
                $sell = 0; foreach ($v in @($a.sell | Where-Object { $null -ne $_ })) { $k = [int]$v; if ($k -ge 0 -and $k -le 3) { $sell = $sell -bor (1 -shl $k) } }
                $blv = Clamp $a.blv 2 11
            }
            Add-BridgeCommand 'Lenh Bai Hanh Trang' "$name <- nhat do $pick, don tui $sell, do xanh duoi cap $blv" ("if not PTHT_AdminSet then dofile(`"script\\phongthan\\item\\hanhtrang_lib.lua`") end PTHT_AdminSet({ID}, $ln, $pick, $sell, $blv)")
        }
        'nuoithugive' {
            # 2026-10-05 (agent nuoithu) pet food by count: itemKey NuoiThuLTDon / NuoiThuLTDai / NuoiThuDTDon (Get-ItemCode),
            # 1..1000 units through PTAdm_Give (AddItem + AddItemIDStack: joins stacks of 100). Character must be online.
            $key = "$($a.itemKey)"
            if (-not (@('NuoiThuLTDon', 'NuoiThuLTDai', 'NuoiThuDTDon') -contains $key)) { throw 'Loai do nuoi thu khong hop le.' }
            $code = Get-ItemCode $key; $n = Clamp $a.count 1 1000; $name = Assert-Name $a.player
            Add-BridgeCommand 'Do nuoi thu' "$name <- $($code.name) x$n" ("PTAdm_Give({ID}, $(ConvertTo-LuaString $name), $($code.g), $($code.d), $($code.p), $($code.lv), $($code.se), $n, $(ConvertTo-LuaString $code.name))")
        }
        'nuoithu' {
            # 2026-10-05 (agent nuoithu) script\phongthan\item\nuoithu_lib.lua PTNT_AdminFeed (servertimer state, no main()):
            # mode 1 = "cho thu an day": every owned linh thu to the cap of its stage, Di Nhan pet +1 level;
            # mode 2 = "tang cap thu toi da": every owned linh thu to stage 4 level 40, Di Nhan pet level 10.
            # Online only (offline: FAIL in result.log). A summoned linh thu is renamed / re-summoned with its new stage.
            $name = Assert-Name $a.player; $ln = ConvertTo-LuaString $name; $mode = [int]$a.mode
            if ($mode -ne 1 -and $mode -ne 2) { throw 'Che do khong hop le (1 = cho an day, 2 = tang cap toi da).' }
            $desc = if ($mode -eq 2) { 'tang cap thu toi da (linh thu giai doan 4 cap 40, de tu cap 10)' } else { 'cho thu an day (linh thu day cap giai doan, de tu +1 cap)' }
            Add-BridgeCommand 'Nuoi thu' "$name <- $desc" ("if not PTNT_AdminFeed then dofile(`"script\\phongthan\\item\\nuoithu_lib.lua`") end PTNT_AdminFeed({ID}, $ln, $mode)")
        }
        'bots' { Set-Bots $a }   # 2026-10-02 Bot gia nguoi choi (enabled, follow, followCount, spots[])
        'matdo' { Set-MatDo $a }   # 2026-10-04 Mat do & hoi quai (density, revive, all, maps[])
        'evrun' {
            # content 2026-10-04 E1: run one row of the saved schedule now (ignores day / time, keeps the daily key)
            $id = Clamp $a.id 1 999
            Add-BridgeCommand 'Lich su kien' "Chay ngay dong $id" ("if not PTEV_AdminRun then dofile(`"script\\phongthan\\content\\ev_lib.lua`") end PTEV_AdminRun({ID}, $id)")
        }
        'evstopexp' { Add-BridgeCommand 'Lich su kien' 'Tat su kien x2 kinh nghiem' ("if not PTEV_AdminStopExp then dofile(`"script\\phongthan\\content\\ev_lib.lua`") end PTEV_AdminStopExp({ID})") }   # content 2026-10-04 E1
        default { throw "Hanh dong khong ho tro: $($a.type)" }
    }
}

# ---------------------------------------------------------------- accounts
. (Join-Path $Root 'PhongThanSource\Deploy\AccountRegistration.ps1')
function Invoke-Sql([string]$Sql, [hashtable]$Params, [switch]$Query) {
    $cn = New-Object Data.SqlClient.SqlConnection 'Server=(localdb)\MSSQLLocalDB;Integrated Security=true;Database=account;Connect Timeout=10'
    $cn.Open()
    try {
        $cmd = $cn.CreateCommand(); $cmd.CommandText = $Sql
        if ($Params) { foreach ($k in $Params.Keys) { [void]$cmd.Parameters.AddWithValue($k, $Params[$k]) } }
        if (-not $Query) { return $cmd.ExecuteNonQuery() }
        $r = $cmd.ExecuteReader(); $rows = @()
        while ($r.Read()) { $o = [ordered]@{}; for ($i = 0; $i -lt $r.FieldCount; $i++) { $o[$r.GetName($i)] = $(if ($r.IsDBNull($i)) { $null } else { "$($r.GetValue($i))" }) }; $rows += [pscustomobject]$o }
        $r.Close(); , $rows
    } finally { $cn.Close() }
}
function Get-Md5Upper([string]$Plain) {
    if ($Plain -cnotmatch '\A[\x21-\x7E]{6,16}\z') { throw 'Mat khau 6-16 ky tu ASCII, khong dau, khong khoang trang.' }
    $md5 = [Security.Cryptography.MD5]::Create()
    try { [BitConverter]::ToString($md5.ComputeHash([Text.Encoding]::ASCII.GetBytes($Plain))).Replace('-', '') } finally { $md5.Dispose() }
}
function Invoke-AccountAction($b) {
    switch ($b.op) {
        'create' {
            $pw = ConvertTo-SecureString $b.password -AsPlainText -Force; $pw2 = ConvertTo-SecureString $b.password -AsPlainText -Force
            New-PhongThanAccount -RuntimeRoot $Runtime -AccountName $b.account -Password $pw -ConfirmPassword $pw2 | Out-Null
            "Da tao tai khoan $($b.account)."
        }
        'password' {
            Assert-PhongThanAccountName $b.account
            $h = Get-Md5Upper $b.password
            $sql = if ($b.alsoSecond) { 'UPDATE Account_Info SET cPassWord=@p, cSecPassword=@p WHERE cAccName=@a' } else { 'UPDATE Account_Info SET cPassWord=@p WHERE cAccName=@a' }
            if ((Invoke-Sql $sql @{ '@p' = $h; '@a' = $b.account }) -ne 1) { throw 'Khong tim thay tai khoan.' }
            "Da doi mat khau $($b.account)."
        }
        'extpoint' {
            Assert-PhongThanAccountName $b.account
            $v = Clamp $b.value 0 2000000000
            if ((Invoke-Sql 'UPDATE Account_Habitus SET nExtPoint=@v WHERE cAccName=@a' @{ '@v' = $v; '@a' = $b.account }) -ne 1) { throw 'Khong tim thay tai khoan.' }
            "Da dat xu = $v cho $($b.account) (co hieu luc khi dang nhap lai)."
        }
        default { throw 'Thao tac tai khoan khong hop le.' }
    }
}

# ---------------------------------------------------------------- scheduler
function Invoke-Event($ev, [string]$Reason) {
    $ids = @()
    foreach ($a in @($ev.actions)) { try { $ids += (Invoke-Action $a).id } catch { Write-Host "Su kien $($ev.name): $($_.Exception.Message)" } }
    $ev.lastRun = (Get-Date -Format 'yyyy-MM-dd HH:mm')
    Save-Json $EventsPath $Events
    "Su kien '$($ev.name)' ($Reason): da xep $($ids.Count) lenh."
}
function Invoke-Scheduler {
    try { Invoke-AdminOpsTick } catch { }   # 2026-10-04 adminops: character backup at start + every 24 h
    $now = Get-Date; $today = $now.ToString('yyyy-MM-dd'); $dow = [int]$now.DayOfWeek
    foreach ($ev in $Events) {
        if (-not $ev.enabled -or "$($ev.time)" -notmatch '^(\d{1,2}):(\d{2})$') { continue }
        $at = $now.Date.AddHours([int]$Matches[1]).AddMinutes([int]$Matches[2])
        $days = @($ev.days | Where-Object { "$_" -ne '' })
        if ($days.Count -and ($days -notcontains $dow) -and ($days -notcontains "$dow")) { continue }
        if ($now -ge $at -and $now -lt $at.AddMinutes(10) -and "$($ev.lastRun)" -notlike "$today*") { Write-Host (Invoke-Event $ev 'theo lich') }
    }
}

# ---------------------------------------------------------------- http
function Send-Json($ctx, $obj, [int]$Code = 200) {
    $bytes = $Utf8.GetBytes((ConvertTo-Json -InputObject $obj -Depth 8 -Compress))
    $ctx.Response.StatusCode = $Code; $ctx.Response.ContentType = 'application/json; charset=utf-8'
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length); $ctx.Response.Close()
}
function Read-Body($ctx) { $sr = New-Object IO.StreamReader($ctx.Request.InputStream, $Utf8); try { $t = $sr.ReadToEnd() } finally { $sr.Dispose() }; if ($t) { $t | ConvertFrom-Json } else { $null } }
function Find-Items([string]$q, [string]$group) {
    $p = Get-Plain $q; $res = @()
    foreach ($it in $Items) {
        if ($group -and $it.group -ne $group) { continue }
        if ($p -and -not ($it.plain.Contains($p) -or "$($it.code)" -eq $q)) { continue }
        $res += [pscustomobject]@{ key = $it.key; group = $it.group; code = $it.code; name = $it.name }
        if ($res.Count -ge 80) { break }
    }
    , $res
}
function Find-Npcs([string]$q, [string]$kind) {
    $p = Get-Plain $q; $res = @()
    foreach ($n in $Npcs) {
        if ($kind -ne '' -and "$($n.kind)" -ne $kind) { continue }
        if ($p -and -not ($n.plain.Contains($p) -or "$($n.id)" -eq $q)) { continue }
        $res += [pscustomobject]@{ id = $n.id; name = $n.name; kind = $n.kind }
        if ($res.Count -ge 100) { break }
    }
    , $res
}
function Invoke-Route($ctx) {
    $req = $ctx.Request; $path = $req.Url.AbsolutePath; $qs = $req.QueryString
    if ($path -eq '/' -or $path -eq '/index.html') {
        $html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot 'index.html'), $Utf8).Replace('__PT_TOKEN__', $Token)
        $bytes = $Utf8.GetBytes($html); $ctx.Response.ContentType = 'text/html; charset=utf-8'
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length); $ctx.Response.Close(); return
    }
    if (-not $path.StartsWith('/api/')) { Send-Json $ctx @{ error = 'Not found' } 404; return }
    # Custom header blocks cross-site requests from other pages in the browser.
    if ($req.Headers['X-PT-Token'] -ne $Token) { Send-Json $ctx @{ error = 'Sai token. Tai lai trang.' } 403; return }
    Update-Results
    switch ("$($req.HttpMethod) $path") {
        'GET /api/status' { Send-Json $ctx @{ status = (Get-Status); online = (Get-Online) } }
        'GET /api/items' { Send-Json $ctx @{ items = (Find-Items $qs['q'] $qs['group']) } }
        'GET /api/groups' { Send-Json $ctx @{ groups = @($Items | ForEach-Object group | Select-Object -Unique) } }
        'GET /api/npcs' { Send-Json $ctx @{ npcs = (Find-Npcs $qs['q'] "$($qs['kind'])") } }
        'GET /api/presets' { Send-Json $ctx @{ presets = $Presets.ToArray(); talismans = @($Talismans | Sort-Object req, name); instruments = @($Instruments | Sort-Object part, ilv); signets = @($Signets | Sort-Object part, ilv) } }
        'GET /api/weapons' {
            $prof = "$($qs['prof'])"; $tier = "$($qs['tier'])"; $greenOnly = "$($qs['green'])" -ne '0'
            $res = @($Weapons | Where-Object { ($prof -eq '' -or "$($_.prof)" -eq $prof) -and ($tier -eq '' -or "$($_.req)" -eq $tier) -and (-not $greenOnly -or $_.green) } | Sort-Object req, name, ilv | Select-Object -First 300)
            $tiers = @($Weapons | Where-Object { $prof -eq '' -or "$($_.prof)" -eq $prof } | ForEach-Object req | Sort-Object -Unique)
            Send-Json $ctx @{ weapons = $res; tiers = $tiers }
        }
        'GET /api/gearsets' {
            $prof = [int]"0$($qs['prof'])"; $out = New-Object Collections.Generic.List[object]
            foreach ($g in ($GearPieces | Where-Object prof -eq $prof | Group-Object set, variant, ilv | Sort-Object { $_.Group[0].tier }, { $_.Group[0].set }, { $_.Group[0].variant }, { $_.Group[0].ilv })) {
                $f = $g.Group[0]
                $pieces = @($g.Group | Group-Object piece | ForEach-Object { $_.Group[0] } | ForEach-Object { [pscustomobject]@{ piece = $_.piece; key = $_.key; name = $_.name; req = $_.req } })
                $out.Add([pscustomobject]@{ set = $f.set; tier = $f.tier; variant = $f.variant; ilv = $f.ilv; title = $setName["$($f.set)|$prof|$($f.variant)"]; pieces = $pieces })
            }
            Send-Json $ctx @{ sets = $out.ToArray() }
        }
        'POST /api/giveset' {
            $b = Read-Body $ctx; $name = Assert-Name $b.player; $n = 0
            foreach ($k in @($b.keys)) { if ($GearPieces | Where-Object key -eq "$k") { [void](Invoke-Action ([pscustomobject]@{ type = 'give'; itemKey = "$k"; player = $name; count = 1 })); $n++ } }
            if (-not $n) { throw 'Khong co mon hop le trong bo.' }
            Send-Json $ctx @{ ok = $true; message = "Da xep lenh phat $n mon do luc cho $name." }
        }
        'GET /api/mounts' {
            $prof = "$($qs['prof'])"; $p = Get-Plain "$($qs['q'])"; $res = New-Object Collections.Generic.List[object]; $seen = @{}
            foreach ($m in $Mounts) {
                if ($prof -ne '' -and $m.prof -ne -1 -and "$($m.prof)" -ne $prof) { continue }
                if ($p -and -not $m.plain.Contains($p)) { continue }
                $sig = "$($m.name)|$($m.prof)|$($m.req)"; if ($seen[$sig]) { continue }; $seen[$sig] = $true
                $res.Add([pscustomobject]@{ key = $m.key; name = $m.name; prof = $m.prof; req = $m.req })
                if ($res.Count -ge 150) { break }
            }
            Send-Json $ctx @{ mounts = $res.ToArray(); total = $Mounts.Count }
        }
        'GET /api/skills' { Send-Json $ctx @{ skills = $Skills.ToArray() } }
        'GET /api/maps' { Send-Json $ctx @{ maps = $Maps.ToArray() } }
        'GET /api/worldboss' { Send-Json $ctx (Get-WorldBoss) }
        'GET /api/vantien' { Send-Json $ctx (Get-VanTien) }
        'GET /api/bots' { Send-Json $ctx (Get-Bots) }
        'GET /api/matdo' { Send-Json $ctx (Get-MatDo) }
        'GET /api/clientcfg' { Send-Json $ctx (Get-ClientCfg) }
        'POST /api/clientcfg' { Send-Json $ctx @{ ok = $true; message = (Set-ClientCfg (Read-Body $ctx)) } }
        'GET /api/clientsound' { Send-Json $ctx (Get-ClientSound) }
        'POST /api/clientsound' { Send-Json $ctx @{ ok = $true; message = (Set-ClientSound (Read-Body $ctx)) } }
        'GET /api/characters' { Send-Json $ctx @{ characters = (Get-Characters) } }
        'GET /api/hanhtranglog' { Send-Json $ctx (Get-HanhTrangLog 200) }   # 2026-10-04 (agent items)
        'GET /api/upgrade/items' { Send-Json $ctx (Get-UpgradeItems) }   # 2026-10-05 natives: cuong hoa
        'GET /api/history' { Send-Json $ctx @{ history = $History.ToArray() } }
        'POST /api/action' { $r = Invoke-Action (Read-Body $ctx); Send-Json $ctx @{ ok = $true; message = "Da xep lenh $($r.id): $($r.desc)"; entry = $r } }
        'GET /api/accounts' { Send-Json $ctx @{ accounts = (Invoke-Sql 'SELECT i.cAccName AS account, CONVERT(varchar(16), i.dRegDate, 120) AS registered, CONVERT(varchar(16), i.dLoginDate, 120) AS lastLogin, h.nExtPoint AS extPoint FROM Account_Info i LEFT JOIN Account_Habitus h ON h.cAccName = i.cAccName ORDER BY i.cAccName' -Query) } }
        'POST /api/account' { Send-Json $ctx @{ ok = $true; message = (Invoke-AccountAction (Read-Body $ctx)) } }
        'GET /api/events' { Send-Json $ctx @{ events = $Events.ToArray() } }
        'POST /api/events' {
            $b = Read-Body $ctx
            if (-not $b.name -or "$($b.time)" -notmatch '^\d{1,2}:\d{2}$') { throw 'Can ten su kien va gio dang HH:mm.' }
            $existing = $null; foreach ($e in $Events) { if ($e.id -eq $b.id) { $existing = $e } }
            if ($existing) { [void]$Events.Remove($existing) }
            $ev = [pscustomobject]@{ id = $(if ($b.id) { $b.id } else { 'e' + (Get-Date -Format 'yyyyMMddHHmmss') }); name = "$($b.name)"; enabled = [bool]$b.enabled; time = "$($b.time)"; days = @($b.days); lastRun = $(if ($existing) { $existing.lastRun } else { '' }); actions = @($b.actions) }
            [void]$Events.Add($ev); Save-Json $EventsPath $Events
            Send-Json $ctx @{ ok = $true; message = "Da luu su kien '$($ev.name)'." }
        }
        'POST /api/events/delete' { $b = Read-Body $ctx; $del = @($Events | Where-Object { $_.id -eq $b.id }); foreach ($d in $del) { [void]$Events.Remove($d) }; Save-Json $EventsPath $Events; Send-Json $ctx @{ ok = $true; message = 'Da xoa su kien.' } }
        'POST /api/events/run' { $b = Read-Body $ctx; $ev = @($Events | Where-Object { $_.id -eq $b.id })[0]; if (-not $ev) { throw 'Khong tim thay su kien.' }; Send-Json $ctx @{ ok = $true; message = (Invoke-Event $ev 'chay ngay') } }
        # 2026-10-04 adminops: A1 health, A2 roll back, A3 character backup, C4 bot party (functions in the admin ops block)
        'GET /api/health' { Send-Json $ctx (Get-AdminHealth) }
        'GET /api/logtail' { Send-Json $ctx (Get-AdminOpsLogTail "$($qs['name'])" ([int]"0$($qs['n'])")) }
        'GET /api/rollback' { Send-Json $ctx @{ backups = (Get-AdminOpsBackups); running = @(Get-AdminOpsRunning @('GameServer', 'Bishop', 'Game')); log = @(Get-AdminOpsLog 40) } }
        'POST /api/rollback/prepare' { $b = Read-Body $ctx; Send-Json $ctx (Get-AdminOpsRollbackPlan "$($b.name)") }
        'POST /api/rollback/run' { $b = Read-Body $ctx; Send-Json $ctx @{ ok = $true; message = (Invoke-AdminOpsRollback "$($b.name)" "$($b.code)") } }
        'GET /api/charbackup' { Send-Json $ctx (Get-CharBackups) }
        'POST /api/charbackup/run' { Send-Json $ctx @{ ok = $true; message = (Invoke-CharBackup 'bam Sao luu ngay') } }
        'POST /api/charbackup/prepare' { $b = Read-Body $ctx; Send-Json $ctx (Get-CharRestorePlan "$($b.date)" "$($b.file)") }
        'POST /api/charbackup/restore' { $b = Read-Body $ctx; Send-Json $ctx @{ ok = $true; message = (Invoke-CharRestore "$($b.date)" "$($b.file)" "$($b.code)") } }
        'GET /api/botparty' { Send-Json $ctx (Get-BotParty) }
        'POST /api/botparty' { $r = Set-BotParty (Read-Body $ctx); Send-Json $ctx @{ ok = $true; message = "Da xep lenh $($r.id): $($r.desc)"; entry = $r } }
        'GET /api/chars' { Send-Json $ctx (Get-AdminOpsCharList) }
        'POST /api/chars/delete/prepare' { $b = Read-Body $ctx; Send-Json $ctx (Get-CharDeletePlan "$($b.file)") }
        'POST /api/chars/delete' { $b = Read-Body $ctx; Send-Json $ctx @{ ok = $true; message = (Invoke-CharDelete "$($b.file)" "$($b.code)" "$($b.name)") } }
        'POST /api/chars/undelete/prepare' { $b = Read-Body $ctx; Send-Json $ctx (Get-CharUndeletePlan "$($b.folder)") }
        'POST /api/chars/undelete' { $b = Read-Body $ctx; Send-Json $ctx @{ ok = $true; message = (Invoke-CharUndelete "$($b.folder)" "$($b.code)") } }
        'GET /api/eventsched' { Send-Json $ctx (Get-EventSched) }   # content 2026-10-04 E1 lich su kien
        'POST /api/eventsched' { Send-Json $ctx @{ ok = $true; message = (Set-EventSched (Read-Body $ctx)) } }
        'GET /api/dailygift' { Send-Json $ctx (Get-DailyGift) }   # content 2026-10-04 E2 qua dang nhap + E4 thanh tich
        'POST /api/dailygift' { Send-Json $ctx @{ ok = $true; message = (Set-DailyGift (Read-Body $ctx)) } }
        'GET /api/dailygift/item' { Send-Json $ctx @{ row = (ConvertTo-DgRow "$($qs['key'])" ([int]"0$($qs['n'])")) } }
        'GET /api/setup/status' { Send-Json $ctx (Get-SetupState) }
        'POST /api/setup/run' {
            $b = Read-Body $ctx; $step = "$($b.step)"
            if (@('all', 'localdb', 'database', 'backup') -notcontains $step) { throw 'Buoc cai dat khong hop le.' }
            if ($script:SetupProc -and -not $script:SetupProc.HasExited) { throw 'Dang co mot buoc cai dat chay, hay doi.' }
            $script:SetupLog = Join-Path $DataDir 'setup.log'
            Set-Content -LiteralPath $script:SetupLog -Value "== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') buoc: $step" -Encoding UTF8
            $script:SetupProc = Start-Process -FilePath 'powershell.exe' -PassThru -WindowStyle Hidden -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$SetupScript`"", '-Step', $step, '-LogPath', "`"$($script:SetupLog)`"")
            Send-Json $ctx @{ ok = $true; message = "Da bat dau buoc '$step'. Xem nhat ky ben duoi." }
        }
        default { Send-Json $ctx @{ error = 'Not found' } 404 }
    }
}

# ---------------------------------------------------------------- server setup (LocalDB + account DB)
$SetupScript = Join-Path $PSScriptRoot 'PhongThan-Setup.ps1'
$script:SetupProc = $null
$script:SetupLog = Join-Path $DataDir 'setup.log'
function Get-SetupState {
    $running = [bool]($script:SetupProc -and -not $script:SetupProc.HasExited)
    $st = $null
    if (-not $running) {
        $raw = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $SetupScript -Step check -Json 2>$null
        $line = @($raw | Where-Object { "$_".StartsWith('{') })[-1]
        if ($line) { $st = $line | ConvertFrom-Json }
    }
    $log = @()
    if (Test-Path -LiteralPath $script:SetupLog) { $log = @(Get-Content -LiteralPath $script:SetupLog -Encoding UTF8 -Tail 40) }
    $exit = $null
    if ($script:SetupProc -and $script:SetupProc.HasExited) { $exit = $script:SetupProc.ExitCode }
    @{ running = $running; status = $st; log = $log; exitCode = $exit }
}

$listener = New-Object Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
$url = "http://localhost:$Port/"
Write-Host "Phong Than Admin dang chay: $url  (dong cua so nay de tat)"
Write-Host "Vat pham: $($Items.Count) | NPC: $($Npcs.Count) | Ban do: $($Maps.Count)"
if (-not $NoBrowser) { Start-Process $url }
try {
    while ($listener.IsListening) {
        $task = $listener.GetContextAsync()
        while (-not $task.Wait(2000)) { try { Invoke-Scheduler } catch { Write-Host "Scheduler: $($_.Exception.Message)" } }
        $ctx = $task.Result
        try { Invoke-Route $ctx }
        catch { try { Send-Json $ctx @{ error = $_.Exception.Message } 400 } catch {} }
    }
} finally { $listener.Stop(); $listener.Close() }
