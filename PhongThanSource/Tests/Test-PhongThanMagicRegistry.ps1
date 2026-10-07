[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) {
    $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
}
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-MagicDescKeys([string]$Path) {
    Assert-True (Test-Path -LiteralPath $Path -PathType Leaf) "Thieu MagicDesc.ini: $Path"
    $keys = New-Object System.Collections.Generic.List[string]
    $inside = $false
    foreach ($line in [IO.File]::ReadAllLines($Path, [Text.Encoding]::GetEncoding(936))) {
        if ($line -match '^\s*\[Descript\]\s*$') {
            $inside = $true
            continue
        }
        if ($inside -and $line -match '^\s*\[') { break }
        if ($inside -and $line -match '^\s*([^/;\s][^=]*?)\s*=') {
            $keys.Add($matches[1].Trim())
        }
    }
    return @($keys)
}

$serverDesc = Join-Path $RuntimeRoot 'Server\settings\MagicDesc.ini'
$clientDesc = Join-Path $RuntimeRoot 'Client\settings\MagicDesc.ini'
$serverKeys = @(Get-MagicDescKeys $serverDesc)
$clientKeys = @(Get-MagicDescKeys $clientDesc)
Assert-True ($serverKeys.Count -eq 358) "MagicDesc VNG phai co 358 dong, thuc te $($serverKeys.Count)."
Assert-True (($serverKeys -join [char]0) -ceq ($clientKeys -join [char]0)) 'Thu tu MagicDesc client/server khong dong bo.'
Assert-True (((Get-FileHash -LiteralPath $serverDesc -Algorithm SHA256).Hash -eq
    (Get-FileHash -LiteralPath $clientDesc -Algorithm SHA256).Hash)) 'MagicDesc client/server khong cung byte.'

$uniqueServerKeys = New-Object System.Collections.Generic.List[string]
$seenServerKeys = @{}
foreach ($key in $serverKeys) {
    if ($seenServerKeys.ContainsKey($key)) { continue }
    $seenServerKeys[$key] = $uniqueServerKeys.Count
    $uniqueServerKeys.Add($key)
}
Assert-True ($uniqueServerKeys.Count -eq 357) "MagicDesc VNG phai co 357 ID duy nhat, thuc te $($uniqueServerKeys.Count)."

$registryPath = Join-Path $ProjectRoot 'Sources\Core\Src\KMagicAttribRegistry.inc'
$rows = New-Object System.Collections.Generic.List[object]
foreach ($line in Get-Content -LiteralPath $registryPath) {
    $match = [regex]::Match($line,
        '^MAGIC_ATTRIB_ENTRY\((\d+),\s*(magic_[A-Za-z0-9_]+),\s*"([A-Za-z0-9_]+)"\)$')
    Assert-True $match.Success "Registry sai cu phap: $line"
    $rows.Add([pscustomobject]@{
        Id = [int]$match.Groups[1].Value
        Symbol = $match.Groups[2].Value
        Key = $match.Groups[3].Value
    })
}
Assert-True ($rows.Count -eq 357) "Registry source phai co 357 ID duy nhat, thuc te $($rows.Count)."
for ($id = 0; $id -lt $rows.Count; ++$id) {
    Assert-True ($rows[$id].Id -eq $id) "Registry thieu hoac sai thu tu ID $id."
    Assert-True ($rows[$id].Key -ceq $uniqueServerKeys[$id]) "Registry ID $id khong khop MagicDesc: $($rows[$id].Key) != $($uniqueServerKeys[$id])."
}

Assert-True ($rows[45].Key -ceq 'exdefense_v') 'ID 45 phai la exdefense_v.'
Assert-True ($rows[179].Key -ceq 'addexdefense_v') 'ID 179 phai la addexdefense_v (Phong ngu).'
Assert-True ($rows[320].Key -ceq 'magic_summon_damage_reduce_v') 'ID 320 phai la magic_summon_damage_reduce_v.'
Assert-True ($rows[356].Key -ceq 'reduce_skill_life_potion_v') 'ID 356 phai la reduce_skill_life_potion_v.'
Assert-True (@($serverKeys | Where-Object { $_ -ceq 'knockback_p' }).Count -eq 2) 'MagicDesc VNG phai giu du 2 dong knockback_p.'
Assert-True (@($rows | Where-Object Key -CEQ 'knockback_p').Count -eq 1) 'Registry numeric chi duoc co 1 ID knockback_p.'

$latin1 = [Text.Encoding]::GetEncoding(28591)
$header = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\Core\Src\KMagicAttrib.h'), $latin1)
$descSource = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\Core\Src\KMagicDesc.cpp'), $latin1)
$modifySource = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Sources\Core\Src\KNpcAttribModify.cpp'), $latin1)
Assert-True ($header -match 'magic_normal_end\s*=\s*357') 'magic_normal_end khong phai exclusive bound 357.'
Assert-True ($descSource -match '#include "KMagicAttribRegistry\.inc"') 'KMagicDesc.cpp khong dung registry VNG.'
Assert-True ($descSource -match 'm_aryTemplate\[pAttrib->nAttribType\]') 'KMagicDesc khong doc mo ta theo ID.'
Assert-True ($descSource -match 'nTemplateId = nExisting') 'KMagicDesc chua gom khoa MagicDesc trung vao cung numeric ID.'
Assert-True ($descSource -match 'm_nTemplateCount != magic_normal_end') 'KMagicDesc khong khoa du 357 ID VNG.'
Assert-True ($descSource -notmatch 'm_IniFile\.GetKeyByIndex') 'KMagicDesc van dung loader lam mat khoa trung VNG.'
Assert-True ($descSource -notmatch '"dec_percasttime"\s*,') 'KMagicDesc.cpp van chua bang chuoi Vo Lam.'
Assert-True ($modifySource -match
    'ProcessFunc\[magic_exdefense_v\]\s*=\s*&KNpcAttribModify::TuChanAttrib') 'ID exdefense_v chua co effect handler.'
Assert-True ($modifySource -match
    'case\s+magic_exdefense_v:\s*case\s+magic_addexdefense_v:') 'TuChanAttrib chua xu ly ca exdefense_v va addexdefense_v.'

$legacyBlock = [regex]::Match($header,
    'magic_legacy_begin\s*=\s*1000,(?<body>.*?)magic_legacy_storage_end',
    [Text.RegularExpressions.RegexOptions]::Singleline)
Assert-True $legacyBlock.Success 'Khong tim thay khoi cach ly ID Vo Lam.'
$legacySymbols = @([regex]::Matches($legacyBlock.Groups['body'].Value,
    '\bmagic_[A-Za-z0-9_]+\b') | ForEach-Object Value | Sort-Object -Unique)
$registeredSymbols = @([regex]::Matches($modifySource,
    'ProcessFunc\[(magic_[A-Za-z0-9_]+)\]') |
    ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)
$unsafe = @($registeredSymbols | Where-Object { $_ -in $legacySymbols })
Assert-True (-not $unsafe.Count) "Handler dang ky nham ID Vo Lam da cach ly: $($unsafe -join ', ')."

[pscustomobject]@{
    Result = 'PASS'
    RegistryEntries = $rows.Count
    SourceKnockbackRows = @($serverKeys | Where-Object { $_ -ceq 'knockback_p' }).Count
    RegistryKnockbackIds = @($rows | Where-Object Key -CEQ 'knockback_p').Count
    ClientServerSha256 = (Get-FileHash -LiteralPath $serverDesc -Algorithm SHA256).Hash
    CriticalIds = '45,179,320,356'
}
