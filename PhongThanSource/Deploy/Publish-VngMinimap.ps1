[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$RoleRoot,
    [string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot)
)
$ErrorActionPreference='Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp=[Text.Encoding]::GetEncoding(936);$latin=[Text.Encoding]::GetEncoding(28591)
$provenance=Get-Content -LiteralPath (Join-Path $ProjectRoot 'Docs\VNG_MINIMAP_PAK_PROVENANCE.json') -Raw | ConvertFrom-Json
if($provenance.failures.Count -or $provenance.files.Count -ne 178){throw 'Minimap PAK extraction was not accepted'}
foreach($file in $provenance.files) {
    if($file.validation_status -ne 'pass'){throw "Unverified minimap: $($file.logical_path)"}
    $name=$latin.GetString($cp.GetBytes([IO.Path]::GetFileName($file.logical_path)))
    $sub=if($name.EndsWith('.wor')){'settings\phongthan\minimap'}else{'maps'}
    $relative=$sub+'\'+$name
    $source=Join-Path $ProjectRoot ('Deploy\ProjectContent\'+$relative)
    if((Get-FileHash -LiteralPath $source).Hash -ne $file.output_sha256){throw "Project minimap provenance mismatch: $relative"}
    $destination=Join-Path $RoleRoot $relative
    New-Item -ItemType Directory -Path (Split-Path -Parent $destination) -Force | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination -Force
    if((Get-FileHash -LiteralPath $destination).Hash -ne $file.output_sha256){throw "Deployed minimap mismatch: $relative"}
}
# Refresh only the content groups touched by this import, not unrelated data.
$storePath=Join-Path (Split-Path -Parent $RoleRoot) 'CONTENT_STORE_MANIFEST.json'
if(Test-Path -LiteralPath $storePath){
    $store=Get-Content -LiteralPath $storePath -Raw | ConvertFrom-Json
    foreach($group in $store.Groups | Where-Object {$_.Role -eq (Split-Path -Leaf $RoleRoot) -and $_.Path -in @('maps','settings')}){
        $files=@(Get-ChildItem -LiteralPath (Join-Path $RoleRoot $group.Path) -Recurse -File -Force)
        $group.FileCount=$files.Count
        $group.Bytes=[long](($files | Measure-Object Length -Sum).Sum)
    }
    $store.SourceManifestSha256=(Get-FileHash -LiteralPath (Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json')).Hash
    $store.CreatedAtUtc=[DateTime]::UtcNow.ToString('o')
    [IO.File]::WriteAllText($storePath,($store|ConvertTo-Json -Depth 8),[Text.UTF8Encoding]::new($false))
}
[pscustomobject]@{RoleRoot=$RoleRoot;OriginalMetadata=91;OriginalImages=87;UnverifiedExistingImages=4}
