[CmdletBinding()]
param(
    [string]$DataRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json'),
    [string]$AuditTool,
    [string]$OutputDirectory
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(936)
$latin1 = [Text.Encoding]::GetEncoding(28591)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
if (-not $AuditTool) { $AuditTool = Join-Path $ProjectRoot 'Output\Tools\PakEntryAudit.exe' }
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $ProjectRoot 'Output\SkillResourcePolicy' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$skillPolicy = $manifest.DataRegistries.Gameplay.Skill
$missilePolicy = $manifest.DataRegistries.Gameplay.Missile
$clientRoot = Join-Path $DataRoot 'Client'
$serverRoot = Join-Path $DataRoot 'Server'

function ConvertTo-DiskRelativePath([string]$Path) {
    $normalized = $Path.Trim().Trim([char]'"').Replace('/', '\').TrimStart('\')
    $segments = foreach ($segment in $normalized.Split([char]'\')) {
        if ($segment -match '[^\x00-\x7f]') { $script:latin1.GetString($script:cp936.GetBytes($segment)) }
        else { $segment }
    }
    return $segments -join '\'
}

function Get-References([string]$Path, [string[]]$Columns, [string]$ExtensionPattern) {
    $lines = [IO.File]::ReadAllLines($Path, $script:cp936)
    $header = $lines[0].Split([char]9)
    $indexes = foreach ($name in $Columns) {
        $index = [Array]::IndexOf($header, $name)
        if ($index -lt 0) { throw "Bang $Path thieu cot runtime $name." }
        $index
    }
    $set = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    for ($row = 1; $row -lt $lines.Count; $row++) {
        $cells = $lines[$row].Split([char]9)
        foreach ($index in $indexes) {
            if ($index -ge $cells.Count) { continue }
            $value = $cells[$index].Trim().Replace('/', '\')
            if (-not $value -or $value -notmatch $ExtensionPattern) { continue }
            if (-not $value.StartsWith('\')) { $value = '\' + $value }
            [void]$set.Add($value.ToLowerInvariant())
        }
    }
    return @($set | Sort-Object)
}

function Invoke-PakAudit([string[]]$References, [string]$Name) {
    $catalog = Join-Path $script:OutputDirectory "$Name.paths.txt"
    $missing = Join-Path $script:OutputDirectory "$Name.missing.txt"
    [IO.File]::WriteAllLines($catalog, $References, $script:cp936)
    Push-Location $script:clientRoot
    try {
        $output = @(& $script:AuditTool (Join-Path $script:clientRoot 'package.ini') $catalog $missing 2>$null)
        if ($LASTEXITCODE -notin @(0, 1)) { throw "PakEntryAudit $Name loi $LASTEXITCODE." }
    }
    finally { Pop-Location }
    $values = @{}
    foreach ($line in $output) {
        if ($line -match '^([A-Z_]+)=(\d+)$') { $values[$matches[1]] = [int]$matches[2] }
    }
    return [pscustomobject]@{
        References = $References.Count
        Pak = $values.ENTRY_PAK
        Loose = $values.ENTRY_LOOSE
        Missing = $values.ENTRY_FAILURES
        MissingCatalog = $missing
    }
}

foreach ($required in @(
    (Join-Path $clientRoot ([string]$skillPolicy.Table)),
    (Join-Path $clientRoot ([string]$missilePolicy.Table)),
    (Join-Path $clientRoot 'package.ini')
)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Thieu skill gate dependency: $required" }
}
if (-not (Test-Path -LiteralPath $AuditTool -PathType Leaf)) {
    & (Join-Path $ProjectRoot 'Build\Build-PakEntryAudit.ps1') -ProjectRoot $ProjectRoot | Out-Null
}
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null

$skillVisual = @(Get-References (Join-Path $clientRoot ([string]$skillPolicy.Table)) @($skillPolicy.RuntimeClientResourceColumns) '(?i)\.(spr|wav|mp3)$')
$skillLua = @(Get-References (Join-Path $clientRoot ([string]$skillPolicy.Table)) @($skillPolicy.RuntimeLevelScriptColumns) '(?i)\.lua$')
$missileVisual = @(Get-References (Join-Path $clientRoot ([string]$missilePolicy.Table)) @($missilePolicy.RuntimeClientResourceColumns) '(?i)\.(spr|wav|mp3)$')
if ($skillVisual.Count -ne [int]$skillPolicy.ExpectedVisualAudioReferences -or
    $skillLua.Count -ne [int]$skillPolicy.ExpectedLevelLuaReferences -or
    $missileVisual.Count -ne [int]$missilePolicy.ExpectedVisualAudioReferences) {
    throw "So tham chieu skill/missile thay doi: visual=$($skillVisual.Count), lua=$($skillLua.Count), missile=$($missileVisual.Count)."
}

$skillVisualAudit = Invoke-PakAudit $skillVisual 'skill-visual-audio'
$skillLuaAudit = Invoke-PakAudit $skillLua 'skill-level-lua'
$missileVisualAudit = Invoke-PakAudit $missileVisual 'missile-visual-audio'
if ($skillVisualAudit.Missing -ne [int]$skillPolicy.ExpectedMissingVisualAudio -or
    $skillLuaAudit.Missing -ne [int]$skillPolicy.ExpectedMissingLevelLua -or
    $missileVisualAudit.Missing -ne [int]$missilePolicy.ExpectedMissingVisualAudio) {
    throw "Backlog PAK skill thay doi: skillVisual=$($skillVisualAudit.Missing), skillLua=$($skillLuaAudit.Missing), missile=$($missileVisualAudit.Missing)."
}

$resolvedBoth = 0
$missingBoth = New-Object System.Collections.Generic.List[string]
foreach ($reference in $skillLua) {
    $relative = ConvertTo-DiskRelativePath $reference
    $clientFile = Join-Path $clientRoot $relative
    $serverFile = Join-Path $serverRoot $relative
    if ((Test-Path -LiteralPath $clientFile -PathType Leaf) -and
        (Test-Path -LiteralPath $serverFile -PathType Leaf)) {
        if ((Get-FileHash -LiteralPath $clientFile -Algorithm SHA256).Hash -ne
            (Get-FileHash -LiteralPath $serverFile -Algorithm SHA256).Hash) {
            throw "Skill Lua client/server khac hash: $reference"
        }
        $resolvedBoth++
    }
    else { $missingBoth.Add($reference) }
}
if ($resolvedBoth -ne [int]$skillPolicy.ExpectedResolvedLevelLua -or
    $missingBoth.Count -ne [int]$skillPolicy.ExpectedMissingLevelLua) {
    throw "Skill Lua dong bo sai: resolved=$resolvedBoth, missing=$($missingBoth.Count)."
}
[IO.File]::WriteAllLines((Join-Path $OutputDirectory 'skill-level-lua.server-backlog.txt'), $missingBoth, $cp936)

$skillsSource = [IO.File]::ReadAllText((Join-Path $ProjectRoot 'Sources\Core\Src\KSkills.cpp'))
$missileSource = [IO.File]::ReadAllText((Join-Path $ProjectRoot 'Sources\Core\Src\KMissle.cpp'))
if ($skillsSource -notmatch '"LvlSetScript"' -or $skillsSource -match '"CastScript"') {
    throw 'Skill gate khong khop cac cot ma loader thuc su doc.'
}
if ($missileSource -match '"ProcessScript"') {
    throw 'Missile loader bat ngo bat dau doc ProcessScript; can cap nhat policy.'
}

$report = [ordered]@{
    Result = 'PASS'
    Policy = 'VNG_ORIGINAL_RESOURCES_NO_SYNTHETIC_SKILL_ASSETS'
    SkillVisualAudio = $skillVisualAudit
    SkillLevelLua = [ordered]@{
        References = $skillLua.Count
        ClientPakOrLoose = $skillLua.Count - $skillLuaAudit.Missing
        SynchronizedClientServer = $resolvedBoth
        MissingBacklog = $missingBoth.Count
    }
    MissileVisualAudio = $missileVisualAudit
    DeclaredButUnused = [ordered]@{
        Skills = @($skillPolicy.DeclaredButUnusedColumns)
        Missiles = @($missilePolicy.DeclaredButUnusedColumns)
    }
}
[IO.File]::WriteAllText((Join-Path $OutputDirectory 'report.json'), ($report | ConvertTo-Json -Depth 8), [Text.Encoding]::UTF8)
[pscustomobject]$report
