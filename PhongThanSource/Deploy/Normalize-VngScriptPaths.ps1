[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$badBytes = [byte[]](0x97, 0x83, 0xE8, 0xBB)
$replacementBytes = [Text.Encoding]::ASCII.GetBytes('taowu')
$badUnicodeName = ([string][char]0x0097) + ([string][char]0x0083) +
    ([string][char]0x00E8) + ([string][char]0x00BB) + '.lua'
$correctedUnicodeName = '梼杌.lua'
$runtimeName = 'taowu.lua'

function Replace-ByteSequence {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][byte[]]$Needle,
        [Parameter(Mandatory = $true)][byte[]]$Replacement
    )
    $bytes = [IO.File]::ReadAllBytes($Path)
    $output = New-Object Collections.Generic.List[byte]
    $replacements = 0
    for ($index = 0; $index -lt $bytes.Length;) {
        $matches = $index + $Needle.Length -le $bytes.Length
        if ($matches) {
            for ($needleIndex = 0; $needleIndex -lt $Needle.Length; $needleIndex++) {
                if ($bytes[$index + $needleIndex] -ne $Needle[$needleIndex]) {
                    $matches = $false
                    break
                }
            }
        }
        if ($matches) {
            $output.AddRange($Replacement)
            $index += $Needle.Length
            $replacements++
        }
        else {
            $output.Add($bytes[$index])
            $index++
        }
    }
    if ($replacements) {
        [IO.File]::WriteAllBytes($Path, $output.ToArray())
    }
    return $replacements
}

$records = New-Object Collections.Generic.List[object]
foreach ($role in 'Client', 'Server') {
    $roleRoot = Join-Path $RuntimeRoot $role
    if (-not (Test-Path -LiteralPath $roleRoot -PathType Container)) {
        throw "Thieu runtime role: $roleRoot"
    }
    foreach ($relativeDirectory in 'script\bossË¢ÐÂ', 'script\item\±äÉí·û') {
        $directory = Join-Path $roleRoot $relativeDirectory
        if (-not (Test-Path -LiteralPath $directory -PathType Container)) {
            throw "Thieu VNG script directory: $directory"
        }
        $target = Join-Path $directory $runtimeName
        $sources = @(@(
            (Join-Path $directory $badUnicodeName),
            (Join-Path $directory $correctedUnicodeName)
        ) | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf })
        if ($sources.Count -gt 1 -or ($sources.Count -eq 1 -and (Test-Path -LiteralPath $target))) {
            throw "Xung dot Taowu runtime path in $directory"
        }
        if ($sources.Count -eq 1) {
            Move-Item -LiteralPath $sources[0] -Destination $target
        }
        if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
            throw "Thieu normalized Taowu script: $target"
        }
        $records.Add([pscustomobject]@{
            Role = $role
            Script = $target.Substring($roleRoot.Length + 1)
            Sha256 = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
        })
    }

    $settingExpectations = @(
        [pscustomobject]@{ Relative = 'settings\systemtimetask.txt'; OriginalCount = 2 },
        [pscustomobject]@{ Relative = 'settings\item\001\magicscript.txt'; OriginalCount = 1 }
    )
    foreach ($expectation in $settingExpectations) {
        $path = Join-Path $roleRoot $expectation.Relative
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            throw "Thieu VNG setting: $path"
        }
        $count = Replace-ByteSequence -Path $path -Needle $badBytes -Replacement $replacementBytes
        if ($count -notin 0, $expectation.OriginalCount) {
            throw "So replacement bat thuong in $path`: $count"
        }
        $records.Add([pscustomobject]@{
            Role = $role
            Setting = $expectation.Relative
            Replacements = $count
            Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        })
    }
}

[pscustomobject]@{
    Status = 'PASS'
    RuntimeRoot = $RuntimeRoot
    Alias = '9783E8BB -> taowu'
    Records = @($records | ForEach-Object { $_ })
}
