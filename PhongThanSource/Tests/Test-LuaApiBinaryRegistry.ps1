[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$DllPath,
    [string]$MapPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DllPath) { $DllPath = Join-Path $ProjectRoot 'Output\Server\CoreServer.dll' }
$DllPath = [IO.Path]::GetFullPath($DllPath)
if (-not $MapPath) { $MapPath = [IO.Path]::ChangeExtension($DllPath, '.map') }
$MapPath = [IO.Path]::GetFullPath($MapPath)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Read-U16([byte[]]$Bytes, [int]$Offset) {
    return [BitConverter]::ToUInt16($Bytes, $Offset)
}

function Read-U32([byte[]]$Bytes, [int]$Offset) {
    return [BitConverter]::ToUInt32($Bytes, $Offset)
}

function Read-AsciiZ([byte[]]$Bytes, [int]$Offset) {
    Assert-True ($Offset -ge 0 -and $Offset -lt $Bytes.Length) "PE string offset ngoai file: $Offset."
    $end = $Offset
    while ($end -lt $Bytes.Length -and $Bytes[$end] -ne 0) { $end++ }
    Assert-True ($end -lt $Bytes.Length) "PE string khong co terminator tai offset $Offset."
    return [Text.Encoding]::ASCII.GetString($Bytes, $Offset, $end - $Offset)
}

Assert-True (Test-Path -LiteralPath $DllPath -PathType Leaf) "Thieu CoreServer binary: $DllPath"
$bytes = [IO.File]::ReadAllBytes($DllPath)
Assert-True ($bytes.Length -ge 512) 'CoreServer binary qua ngan.'
Assert-True ($bytes[0] -eq 0x4d -and $bytes[1] -eq 0x5a) 'CoreServer khong co DOS MZ header.'
$peOffset = [int](Read-U32 $bytes 0x3c)
Assert-True ($peOffset -gt 0 -and $peOffset + 24 -lt $bytes.Length) 'PE header offset khong hop le.'
Assert-True ((Read-U32 $bytes $peOffset) -eq 0x00004550) 'CoreServer khong co PE signature.'
$sectionCount = [int](Read-U16 $bytes ($peOffset + 6))
$peTimestamp = [uint32](Read-U32 $bytes ($peOffset + 8))
$optionalSize = [int](Read-U16 $bytes ($peOffset + 20))
$optionalOffset = $peOffset + 24
Assert-True ((Read-U16 $bytes $optionalOffset) -eq 0x10b) 'CoreServer khong phai PE32/x86.'
$imageBase = [uint32](Read-U32 $bytes ($optionalOffset + 28))
$sizeOfHeaders = [uint32](Read-U32 $bytes ($optionalOffset + 60))
$exportRva = [uint32](Read-U32 $bytes ($optionalOffset + 96))
$exportSize = [uint32](Read-U32 $bytes ($optionalOffset + 100))
Assert-True ($sectionCount -gt 0 -and $sectionCount -lt 128) "PE section count bat thuong: $sectionCount."
Assert-True ($exportRva -gt 0 -and $exportSize -gt 0) 'CoreServer khong co export directory.'

$sections = New-Object System.Collections.Generic.List[object]
$sectionOffset = $optionalOffset + $optionalSize
for ($index = 0; $index -lt $sectionCount; $index++) {
    $offset = $sectionOffset + (40 * $index)
    Assert-True ($offset + 40 -le $bytes.Length) 'PE section table bi cat ngan.'
    $rawName = [Text.Encoding]::ASCII.GetString($bytes, $offset, 8)
    $name = $rawName.TrimEnd([char]0)
    $sections.Add([pscustomobject]@{
        Name = $name
        VirtualSize = [uint32](Read-U32 $bytes ($offset + 8))
        VirtualAddress = [uint32](Read-U32 $bytes ($offset + 12))
        RawSize = [uint32](Read-U32 $bytes ($offset + 16))
        RawOffset = [uint32](Read-U32 $bytes ($offset + 20))
        Characteristics = [uint32](Read-U32 $bytes ($offset + 36))
    })
}

function Convert-RvaToOffset([uint32]$Rva) {
    if ($Rva -lt $script:sizeOfHeaders) { return [int]$Rva }
    foreach ($section in $script:sections) {
        $span = [Math]::Max([uint32]$section.VirtualSize, [uint32]$section.RawSize)
        if ($Rva -ge $section.VirtualAddress -and $Rva -lt $section.VirtualAddress + $span) {
            $delta = [uint32]($Rva - $section.VirtualAddress)
            Assert-True ($delta -lt $section.RawSize) "RVA 0x$($Rva.ToString('X8')) chi nam trong virtual tail."
            $fileOffset = [uint64]$section.RawOffset + $delta
            Assert-True ($fileOffset -lt $script:bytes.Length) "RVA 0x$($Rva.ToString('X8')) vuot file."
            return [int]$fileOffset
        }
    }
    throw "Khong anh xa duoc RVA 0x$($Rva.ToString('X8'))."
}

function Convert-VaToRva([uint32]$Va) {
    Assert-True ($Va -ge $script:imageBase) "VA 0x$($Va.ToString('X8')) nho hon ImageBase."
    return [uint32]($Va - $script:imageBase)
}

function Get-SectionForRva([uint32]$Rva) {
    foreach ($section in $script:sections) {
        $span = [Math]::Max([uint32]$section.VirtualSize, [uint32]$section.RawSize)
        if ($Rva -ge $section.VirtualAddress -and $Rva -lt $section.VirtualAddress + $span) {
            return $section
        }
    }
    return $null
}

$exportOffset = Convert-RvaToOffset $exportRva
$ordinalBase = [uint32](Read-U32 $bytes ($exportOffset + 16))
$functionCount = [uint32](Read-U32 $bytes ($exportOffset + 20))
$nameCount = [uint32](Read-U32 $bytes ($exportOffset + 24))
$functionsRva = [uint32](Read-U32 $bytes ($exportOffset + 28))
$namesRva = [uint32](Read-U32 $bytes ($exportOffset + 32))
$ordinalsRva = [uint32](Read-U32 $bytes ($exportOffset + 36))
Assert-True ($functionCount -gt 0 -and $nameCount -gt 0) 'Export directory rong.'
$functionsOffset = Convert-RvaToOffset $functionsRva
$namesOffset = Convert-RvaToOffset $namesRva
$ordinalsOffset = Convert-RvaToOffset $ordinalsRva
$exports = @{}
for ([uint32]$index = 0; $index -lt $nameCount; $index++) {
    $nameRva = [uint32](Read-U32 $bytes ($namesOffset + [int](4 * $index)))
    $name = Read-AsciiZ $bytes (Convert-RvaToOffset $nameRva)
    $ordinalIndex = [uint32](Read-U16 $bytes ($ordinalsOffset + [int](2 * $index)))
    Assert-True ($ordinalIndex -lt $functionCount) "Export ordinal index vuot bang: $name."
    $targetRva = [uint32](Read-U32 $bytes ($functionsOffset + [int](4 * $ordinalIndex)))
    $exports[$name] = [pscustomobject]@{
        Name = $name
        Ordinal = [uint32]($ordinalBase + $ordinalIndex)
        Rva = $targetRva
    }
}

Assert-True (Test-Path -LiteralPath $MapPath -PathType Leaf) "Thieu linker map cung build: $MapPath"
$mapText = [IO.File]::ReadAllText($MapPath, [Text.Encoding]::ASCII)
$mapTimestampMatch = [regex]::Match($mapText, '(?im)^\s*Timestamp\s+is\s+(?<value>[0-9a-f]{8})\b')
Assert-True $mapTimestampMatch.Success 'Linker map thieu PE timestamp.'
$mapTimestamp = [Convert]::ToUInt32($mapTimestampMatch.Groups['value'].Value, 16)
Assert-True ($mapTimestamp -eq $peTimestamp) "Linker map khong cung binary: map=0x$($mapTimestamp.ToString('X8')), PE=0x$($peTimestamp.ToString('X8'))."

function Find-MapSymbol([string]$EncodedName) {
    $pattern = '(?im)^\s*[0-9a-f]+:[0-9a-f]+\s+' + [regex]::Escape($EncodedName) + '\s+(?<va>[0-9a-f]{8})\b'
    $found = @([regex]::Matches($script:mapText, $pattern))
    Assert-True ($found.Count -eq 1) "Linker map can dung mot symbol $EncodedName, tim thay $($found.Count)."
    $va = [Convert]::ToUInt32($found[0].Groups['va'].Value, 16)
    Assert-True ($va -ge $script:imageBase) "Symbol $EncodedName co VA duoi ImageBase."
    return [pscustomobject]@{
        Name = $EncodedName
        Va = $va
        Rva = [uint32]($va - $script:imageBase)
    }
}

$gameTableExport = Find-MapSymbol '?GameScriptFuns@@3PAUTLua_Funcs@@A'
$worldTableExport = Find-MapSymbol '?WorldScriptFuns@@3PAUTLua_Funcs@@A'
$countExport = Find-MapSymbol '?g_GetGameScriptFunNum@@YAHXZ'
$tableOrderMessage = 'GameScriptFuns/WorldScriptFuns khong theo thu tu du kien: game={0}@0x{1:X8}, world={2}@0x{3:X8}.' -f `
    $gameTableExport.Name, [uint32]$gameTableExport.Rva, $worldTableExport.Name, [uint32]$worldTableExport.Rva
Assert-True ([uint32]$worldTableExport.Rva -gt [uint32]$gameTableExport.Rva) $tableOrderMessage
$tableBytes = [uint32]($worldTableExport.Rva - $gameTableExport.Rva)
Assert-True (($tableBytes % 8) -eq 0) "Kich thuoc GameScriptFuns khong chia het cho TLua_Funcs x86: $tableBytes."
$registeredCount = [int]($tableBytes / 8)
Assert-True ($registeredCount -gt 182 -and $registeredCount -lt 4096) "So entry GameScriptFuns bat thuong: $registeredCount."

$tableOffset = Convert-RvaToOffset ([uint32]$gameTableExport.Rva)
$registrations = New-Object System.Collections.Generic.List[object]
for ($index = 0; $index -lt $registeredCount; $index++) {
    $entryOffset = $tableOffset + (8 * $index)
    $nameVa = [uint32](Read-U32 $bytes $entryOffset)
    $functionVa = [uint32](Read-U32 $bytes ($entryOffset + 4))
    Assert-True ($nameVa -ne 0 -and $functionVa -ne 0) "GameScriptFuns entry $index co null pointer."
    $nameRva = Convert-VaToRva $nameVa
    $functionRva = Convert-VaToRva $functionVa
    $name = Read-AsciiZ $bytes (Convert-RvaToOffset $nameRva)
    $functionSection = Get-SectionForRva $functionRva
    Assert-True ($null -ne $functionSection) "API $name co function RVA ngoai image."
    Assert-True (($functionSection.Characteristics -band 0x20000000) -ne 0) "API $name khong tro vao executable section."
    $registrations.Add([pscustomobject]@{
        Index = $index
        Name = $name
        FunctionRva = ('0x{0:X8}' -f $functionRva)
        Section = $functionSection.Name
    })
}

$catalog = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$catalogApis = @($catalog.apis)
Assert-True ($catalogApis.Count -eq 182) "Catalog API count=$($catalogApis.Count)."
$campaign = New-Object System.Collections.Generic.List[object]
$campaignPointers = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
foreach ($api in $catalogApis) {
    $matches = @($registrations | Where-Object Name -ceq ([string]$api.name))
    Assert-True ($matches.Count -eq 1) "Binary registration cua $($api.name) co $($matches.Count) entry, yeu cau 1."
    Assert-True ($campaignPointers.Add([string]$matches[0].FunctionRva)) "Hai campaign API chung function RVA: $($matches[0].FunctionRva)."
    $campaign.Add($matches[0])
}

$dllHash = (Get-FileHash -LiteralPath $DllPath -Algorithm SHA256).Hash
[pscustomobject]@{
    Status = 'PASS'
    Binary = $DllPath
    LinkerMap = $MapPath
    BinarySha256 = $dllHash
    Architecture = 'PE32/x86'
    LinkedFunctionCountAccessor = $countExport.Name
    PeTimestamp = ('0x{0:X8}' -f $peTimestamp)
    ExportDirectoryNames = $exports.Count
    RegisteredGameFunctions = $registeredCount
    CampaignApiCount = $campaign.Count
    UniqueCampaignFunctionPointers = $campaignPointers.Count
    ExecutableSectionPointers = $campaign.Count
    CampaignRegistrations = @($campaign | ForEach-Object { $_ })
}
