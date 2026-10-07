[CmdletBinding()]
param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp=[Text.Encoding]::GetEncoding(936);$latin=[Text.Encoding]::GetEncoding(28591)
$npc=Get-Content -LiteralPath (Join-Path $ProjectRoot 'Docs\VNG_NPC_REGION_IMPORT.json') -Raw | ConvertFrom-Json
if($npc.RegionCount -ne 535 -or $npc.NpcCount -ne 1221){throw 'Unexpected original NPC coverage'}
foreach($region in $npc.Regions){
    $path=Join-Path $RuntimeRoot ('Server\'+$region.RelativePath)
    if((Get-FileHash -LiteralPath $path).Hash -ne $region.Sha256){throw "Original NPC region lost: $path"}
}
$minimap=Get-Content -LiteralPath (Join-Path $ProjectRoot 'Docs\VNG_MINIMAP_PAK_PROVENANCE.json') -Raw | ConvertFrom-Json
if($minimap.failures.Count){throw 'Minimap extraction had failures'}
$metadata=0;$images=0
foreach($file in $minimap.files){
    $name=$latin.GetString($cp.GetBytes([IO.Path]::GetFileName($file.logical_path)))
    $sub=if($name.EndsWith('.wor')){++$metadata;'settings\phongthan\minimap'}else{++$images;'maps'}
    foreach($role in @('Client','Server')){
        $path=Join-Path $RuntimeRoot ($role+'\'+$sub+'\'+$name)
        if((Get-FileHash -LiteralPath $path).Hash -ne $file.output_sha256){throw "Minimap provenance mismatch: $path"}
    }
}
if($metadata -ne 91 -or $images -ne 87){throw 'Incomplete verified minimap publication'}
$missing=@($npc.Npcs | Where-Object { $_.Kind -eq 3 -and $_.Script -and -not(Test-Path -LiteralPath (Join-Path $RuntimeRoot ('Server\'+$_.Script.TrimStart('\')))) } | Select-Object -ExpandProperty Script -Unique)
[pscustomobject]@{Result='PASS_VERIFIED_CONTENT';NpcRecords=1221;NpcRegions=535;MapsWithOriginalNpcs=($npc.MapIds -join ',');MinimapMetadata=$metadata;VerifiedMinimapImages=$images;MissingDialogScripts=$missing;FullMapNpcCoverage=$false;VisualAcceptance=$false}
