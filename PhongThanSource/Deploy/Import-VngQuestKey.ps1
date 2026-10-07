[CmdletBinding()]
param(
    [string]$SourcePath,
    [string[]]$RuntimeRoots
)

$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot)).TrimEnd('\')
$projectParent = Split-Path -Parent $projectRoot
if (-not $SourcePath) {
    $SourcePath = Join-Path $projectParent 'Tai nguyen VNG\vng00\block_3491_id2988111260.txt'
}
if (-not $RuntimeRoots -or $RuntimeRoots.Count -eq 0) {
    $RuntimeRoots = @(
        (Join-Path $projectParent 'PhongThanRuntime-Content'),
        (Join-Path $projectParent 'PhongThanRuntime-Staging')
    )
}

$expectedLength = 41292
$expectedSha256 = '2A6069B05472F817A0BC4948CFDE932D9B9BC4219C9BCCA1E8048261F3D3E26D'
$SourcePath = [IO.Path]::GetFullPath($SourcePath)
if (-not (Test-Path -LiteralPath $SourcePath -PathType Leaf)) {
    throw "Thieu payload QuestKey VNG goc: $SourcePath"
}
$source = Get-Item -LiteralPath $SourcePath
$sourceHash = (Get-FileHash -LiteralPath $SourcePath -Algorithm SHA256).Hash
if ($source.Length -ne $expectedLength -or $sourceHash -ne $expectedSha256) {
    throw "QuestKey VNG khong dung payload da xac thuc: length=$($source.Length), sha256=$sourceHash"
}

$bytes = [IO.File]::ReadAllBytes($SourcePath)
$lineEnd = [Array]::IndexOf($bytes, [byte]10)
$headerColumns = 1
for ($i = 0; $i -lt $lineEnd; $i++) {
    if ($bytes[$i] -eq 9) { $headerColumns++ }
}
if ($lineEnd -lt 0 -or $headerColumns -ne 19) {
    throw "QuestKey VNG sai schema: headerColumns=$headerColumns"
}

$written = New-Object System.Collections.Generic.List[object]
foreach ($runtimeRootValue in $RuntimeRoots) {
    $runtimeRoot = [IO.Path]::GetFullPath($runtimeRootValue).TrimEnd('\')
    $driveRoot = [IO.Path]::GetPathRoot($runtimeRoot).TrimEnd('\')
    if (-not $runtimeRoot -or $runtimeRoot -ieq $driveRoot) {
        throw "RuntimeRoot khong an toan: $runtimeRoot"
    }
    if (-not (Test-Path -LiteralPath $runtimeRoot -PathType Container)) {
        throw "RuntimeRoot khong ton tai: $runtimeRoot"
    }
    foreach ($role in 'Client', 'Server') {
        $roleRoot = [IO.Path]::GetFullPath((Join-Path $runtimeRoot $role)).TrimEnd('\')
        if (-not (Test-Path -LiteralPath $roleRoot -PathType Container)) {
            throw "Runtime thieu role $role`: $roleRoot"
        }
        $destination = [IO.Path]::GetFullPath(
            (Join-Path $roleRoot 'settings\item\001\questkey.txt'))
        if (-not $destination.StartsWith($roleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Tu choi ghi ngoai role root: $destination"
        }
        $parent = Split-Path -Parent $destination
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
        [IO.File]::WriteAllBytes($destination, $bytes)
        $actualHash = (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash
        if ($actualHash -ne $expectedSha256) {
            throw "QuestKey bi thay doi khi ghi: $destination"
        }
        $written.Add([pscustomobject]@{
            Runtime = $runtimeRoot
            Role = $role
            Path = $destination
            Length = $bytes.Length
            Sha256 = $actualHash
        })
    }
}

$written
