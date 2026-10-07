[CmdletBinding()]
param([Parameter(Mandatory=$true)][string]$RoleRoot,[string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference='Stop'
if((Split-Path -Leaf $RoleRoot) -ine 'Server'){return}
$RoleRoot=[IO.Path]::GetFullPath($RoleRoot).TrimEnd('\')
$sourceRoot=Join-Path $ProjectRoot 'Deploy\ProjectContent\NpcQuests'
$manifest=Get-Content -LiteralPath (Join-Path $sourceRoot 'normal_provenance.json') -Raw | ConvertFrom-Json
$relative='script\phongthan\npc_quests\normal.lua'
if($manifest.logical -ne ('\'+$relative)){throw 'Unexpected quest script destination'}
$source=Join-Path $sourceRoot ('compiled\'+$relative)
if((Get-FileHash -LiteralPath $source).Hash -ine $manifest.sha256){throw 'NPC quest source hash mismatch'}
$target=Join-Path $RoleRoot $relative
New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
Copy-Item -LiteralPath $source -Destination $target -Force
if((Get-FileHash -LiteralPath $target).Hash -ine $manifest.sha256){throw 'NPC quest deployment hash mismatch'}
[pscustomobject]@{RoleRoot=$RoleRoot;QuestScript=$relative;Sha256=$manifest.sha256;OriginalPakModified=$false}
& (Join-Path $PSScriptRoot 'Publish-XichTungTuContent.ps1') -RoleRoot $RoleRoot -ProjectRoot $ProjectRoot
