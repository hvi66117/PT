[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$RoleRoot,
    [string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference='Stop'
if((Split-Path -Leaf $RoleRoot) -ine 'Server'){return}
$RoleRoot=[IO.Path]::GetFullPath($RoleRoot).TrimEnd('\')
$sourceRoot=Join-Path $ProjectRoot 'Deploy\ProjectContent\NpcQuests'
$manifest=Get-Content -LiteralPath (Join-Path $sourceRoot 'xich_tung_tu_provenance.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$relative='script\phongthan\npc_services\xich_tung_tu.lua'
if($manifest.logical -ne ('\'+$relative) -or $manifest.npc.world -ne 1052 -or $manifest.npc.template -ne 206){throw 'Unexpected Xich Tung Tu identity'}
$source=Join-Path $sourceRoot ('compiled\'+$relative)
if((Get-FileHash -LiteralPath $source).Hash -ine $manifest.sha256){throw 'Xich Tung Tu source hash mismatch'}
$target=Join-Path $RoleRoot $relative
New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
Copy-Item -LiteralPath $source -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ine $manifest.sha256){throw 'Xich Tung Tu runtime hash mismatch'}
[pscustomobject]@{RoleRoot=$RoleRoot;Script=$relative;Sha256=$manifest.sha256;OriginalPakModified=$false}
