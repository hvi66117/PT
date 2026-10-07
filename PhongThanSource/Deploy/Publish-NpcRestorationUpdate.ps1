[CmdletBinding()]
param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),
      [string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging',
      [string]$ContentRoot='D:\Lam game phong than\PhongThanRuntime-Content',
      [switch]$RequireComplete)
$ErrorActionPreference='Stop'
$ProjectRoot=[IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$parent=Split-Path -Parent $ProjectRoot
if($RequireComplete){
    $npcReport=Get-Content -LiteralPath (Join-Path $ProjectRoot 'Docs\NPC_RESTORATION_DEPLOYMENT.json') -Raw | ConvertFrom-Json
    if($npcReport.pending -ne 0 -or -not $npcReport.complete){throw "INCOMPLETE_BATCH: $($npcReport.pending) unresolved NPCs; runtime was not modified"}
}
if([IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\') -ine (Join-Path $parent 'PhongThanRuntime-Staging')){throw 'Wrong staging root'}
if([IO.Path]::GetFullPath($ContentRoot).TrimEnd('\') -ine (Join-Path $parent 'PhongThanRuntime-Content')){throw 'Wrong content root'}
$running=@(Get-CimInstance Win32_Process | Where-Object {$_.ExecutablePath -and $_.ExecutablePath.StartsWith($RuntimeRoot+'\Server\',[StringComparison]::OrdinalIgnoreCase)})
if($running){throw 'Save and stop server before publishing NPC update'}
$binary=Join-Path $ProjectRoot 'Output\Server\CoreServer.dll'
$receiptPath=Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json'
$receipt=Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
$entry=@($receipt.Artifacts | Where-Object {$_.Role -eq 'Server' -and $_.Name -eq 'CoreServer.dll'})
if($entry.Count -ne 1){throw 'Missing unique CoreServer deployment identity'}
$hash=(Get-FileHash -LiteralPath $binary).Hash
foreach($root in $ContentRoot,$RuntimeRoot){
    foreach($role in 'Server','Client'){
        & (Join-Path $PSScriptRoot 'Publish-NpcRestoration.ps1') -ProjectRoot $ProjectRoot -RoleRoot (Join-Path $root $role)
    }
}
$target=Join-Path $RuntimeRoot 'Server\CoreServer.dll'
Copy-Item -LiteralPath $binary -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ne $hash){throw 'CoreServer hash mismatch'}
$entry[0].Sha256=$hash
$receipt.CreatedAtUtc=[DateTime]::UtcNow.ToString('o')
[IO.File]::WriteAllText($receiptPath,($receipt | ConvertTo-Json -Depth 12),[Text.UTF8Encoding]::new($false))
"Published CoreServer.dll SHA256=$hash; PAKs, character data and other binaries unchanged."
