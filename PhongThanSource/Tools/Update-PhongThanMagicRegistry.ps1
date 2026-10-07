[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$MagicDescPath,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $MagicDescPath) {
    $MagicDescPath = Join-Path (Split-Path -Parent $ProjectRoot) `
        'PhongThanRuntime-Staging\Server\settings\MagicDesc.ini'
}
if (-not $OutputPath) {
    $OutputPath = Join-Path $ProjectRoot 'Sources\Core\Src\KMagicAttribRegistry.inc'
}

if (-not (Test-Path -LiteralPath $MagicDescPath -PathType Leaf)) {
    throw "Thieu MagicDesc.ini VNG: $MagicDescPath"
}

$rawKeys = New-Object System.Collections.Generic.List[string]
$insideDescript = $false
foreach ($line in [IO.File]::ReadAllLines($MagicDescPath, [Text.Encoding]::GetEncoding(936))) {
    if ($line -match '^\s*\[Descript\]\s*$') {
        $insideDescript = $true
        continue
    }
    if ($insideDescript -and $line -match '^\s*\[') { break }
    if (-not $insideDescript) { continue }

    $match = [regex]::Match($line, '^\s*([^/;\s][^=]*?)\s*=')
    if (-not $match.Success) { continue }
    $key = $match.Groups[1].Value.Trim()
    if ($key -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') {
        throw "Ten thuoc tinh khong hop le trong MagicDesc.ini: $key"
    }
    $rawKeys.Add($key)
}

if ($rawKeys.Count -ne 358) {
    throw "MagicDesc.ini VNG phai co 358 dong du lieu, thuc te co $($rawKeys.Count)."
}

$keys = New-Object System.Collections.Generic.List[string]
$seenKeys = @{}
foreach ($key in $rawKeys) {
    if ($seenKeys.ContainsKey($key)) { continue }
    $seenKeys[$key] = $keys.Count
    $keys.Add($key)
}
if ($keys.Count -ne 357 -or @($rawKeys | Where-Object { $_ -ceq 'knockback_p' }).Count -ne 2) {
    throw "MagicDesc.ini VNG phai cho 357 ID duy nhat va dung 2 dong knockback_p."
}

$rows = New-Object System.Collections.Generic.List[string]
for ($id = 0; $id -lt $keys.Count; ++$id) {
    $key = $keys[$id]
    $symbol = if ($key.StartsWith('magic_', [StringComparison]::Ordinal)) {
        $key
    }
    else {
        "magic_$key"
    }
    $rows.Add(('MAGIC_ATTRIB_ENTRY({0}, {1}, "{2}")' -f $id, $symbol, $key))
}

$utf8NoBom = New-Object Text.UTF8Encoding($false)
[IO.File]::WriteAllLines($OutputPath, $rows, $utf8NoBom)

[pscustomobject]@{
    Result = 'PASS'
    Entries = $keys.Count
    SourceRows = $rawKeys.Count
    DuplicateRows = $rawKeys.Count - $keys.Count
    OutputPath = [IO.Path]::GetFullPath($OutputPath)
    Sha256 = (Get-FileHash -LiteralPath $OutputPath -Algorithm SHA256).Hash
}
