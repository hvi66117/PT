[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RoleRoot
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(936)
$RoleRoot = [IO.Path]::GetFullPath($RoleRoot).TrimEnd('\')
$playerRoot = Join-Path $RoleRoot 'settings\npc\player'
if (-not (Test-Path -LiteralPath $playerRoot -PathType Container)) {
    throw "Missing player settings directory: $playerRoot"
}

$skillsByProfile = @{
    0 = @(1, 2) + @(27..42)
    1 = @(1, 2) + @(27..42)
    2 = @(1, 2) + @(3..26)
    3 = @(1, 2) + @(3..26)
    4 = @(1, 2) + @(43..51)
    5 = @(1, 2) + @(43..51)
}

$records = New-Object Collections.Generic.List[object]
for ($profile = 0; $profile -lt 6; ++$profile) {
    $path = Join-Path $playerRoot ('newplayerini{0:D2}.ini' -f $profile)
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing VNG player profile: $path"
    }
    $skills = @($skillsByProfile[$profile])
    $lines = New-Object Collections.Generic.List[string]
    $lines.Add('[FSKILLS]')
    $lines.Add("COUNT=$($skills.Count)")
    for ($index = 0; $index -lt $skills.Count; ++$index) {
        $slot = $index + 1
        $lines.Add("S$slot=$($skills[$index])")
        $lines.Add("L$slot=1")
    }
    $replacement = ($lines -join "`r`n") + "`r`n`r`n"
    $text = [IO.File]::ReadAllText($path, $cp936)
    $pattern = '(?ms)^\[FSKILLS\]\r?\n.*?(?=^\[LSKILLS\])'
    if (-not [regex]::IsMatch($text, $pattern)) {
        throw "Invalid FSKILLS section: $path"
    }
    $updated = [regex]::Replace($text, $pattern, $replacement)
    [IO.File]::WriteAllText($path, $updated, $cp936)
    $records.Add([pscustomobject]@{
        Profile = $profile
        Profession = [int]($profile / 2)
        SkillCount = $skills.Count
        Path = $path
        Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    })
}

[pscustomobject]@{
    Result = 'PASS'
    RoleRoot = $RoleRoot
    Profiles = $records.Count
    Records = @($records | ForEach-Object { $_ })
}
