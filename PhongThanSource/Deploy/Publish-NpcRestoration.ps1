[CmdletBinding()]
param(
    [string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),
    [Parameter(Mandatory=$true)][string]$RoleRoot
)
$ErrorActionPreference='Stop'
$RoleRoot=[IO.Path]::GetFullPath($RoleRoot).TrimEnd('\')
if((Split-Path -Leaf $RoleRoot) -notin 'Client','Server'){throw 'Expected Client or Server role root'}
$reportPath=Join-Path $ProjectRoot 'Docs\NPC_RESTORATION_DEPLOYMENT.json'
if(-not(Test-Path -LiteralPath $reportPath)){return}
$report=Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json
$sourceRoot=Join-Path $ProjectRoot 'Deploy\ProjectContent\NpcRestoration\compiled'
$files=[Collections.Generic.List[object]]::new()
if((Split-Path -Leaf $RoleRoot) -eq 'Server') {
    foreach($entry in $report.overrides){
        if($entry.relative -notmatch '^settings/phongthan/npc_regions/\d+/v_\d{3}/\d{3}_(region|npc)_s\.dat$'){throw 'Invalid NPC override path'}
        $source=Join-Path $sourceRoot $entry.relative
        if((Get-FileHash -LiteralPath $source).Hash -ine $entry.sha256){throw "Authored NPC hash mismatch: $source"}
        $files.Add([pscustomobject]@{Source=$source;Relative=$entry.relative})
    }
    foreach($entry in $report.scripts){
        if($entry.relative -notmatch '^script/phongthan/npc_restore/\d+_\d{2}\.lua$'){throw 'Invalid authored NPC Lua path'}
        $source=Join-Path $sourceRoot $entry.relative
        if((Get-FileHash -LiteralPath $source).Hash -ine $entry.sha256){throw "NPC Lua hash mismatch: $source"}
        $files.Add([pscustomobject]@{Source=$source;Relative=$entry.relative})
    }
}
$files.Add([pscustomobject]@{Source=(Join-Path $sourceRoot 'settings\phongthan\NpcDisplayNames.txt');Relative='settings\phongthan\NpcDisplayNames.txt'})
foreach($file in $files){
    $target=[IO.Path]::GetFullPath((Join-Path $RoleRoot $file.Relative))
    if(-not $target.StartsWith($RoleRoot+'\settings\phongthan\',[StringComparison]::OrdinalIgnoreCase) -and
       -not $target.StartsWith($RoleRoot+'\script\phongthan\npc_restore\',[StringComparison]::OrdinalIgnoreCase)){throw 'NPC destination escaped namespace'}
    New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
    Copy-Item -LiteralPath $file.Source -Destination $target -Force
    if((Get-FileHash -LiteralPath $file.Source).Hash -ne (Get-FileHash -LiteralPath $target).Hash){throw "NPC publish mismatch: $target"}
}
& (Join-Path $PSScriptRoot 'Publish-NpcQuestContent.ps1') -ProjectRoot $ProjectRoot -RoleRoot $RoleRoot | Out-Null
[pscustomobject]@{RoleRoot=$RoleRoot;Published=$files.Count;Ready=$report.ready;Pending=$report.pending;OriginalMapsModified=$false}
