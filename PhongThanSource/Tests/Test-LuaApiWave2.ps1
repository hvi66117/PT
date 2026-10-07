[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot), [string]$AuditRoot)
$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
if (-not $AuditRoot) { $AuditRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'SourceMigration\staging\p0.3-validated-entry-sets\audit' }
function Assert-True([bool]$Condition,[string]$Message){if(-not $Condition){throw $Message}}
function Read-Latin1([string]$Path){[Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($Path))}
function Assert-Contains([string]$Text,[string]$Pattern,[string]$Message){if($Text -notmatch $Pattern){throw $Message}}
$source=Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
$itemList=Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KItemList.cpp')
$basic=Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KBasPropTbl.CPP')
$catalog=Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json')|ConvertFrom-Json
$apis=@($catalog.apis|Where-Object wave -eq 2|ForEach-Object name)
Assert-True ($apis.Count -eq 16) "Wave 2 count mismatch: $($apis.Count)"
foreach($api in $apis){Assert-Contains $source ('\{"'+[regex]::Escape($api)+'"\s*,') "Wave 2 API is not registered: $api"}
Assert-Contains $source 'GetVngNormalTuple[\s\S]{0,500}MapVngNormalItemTuple' 'Normal item APIs bypass the VNG tuple mapper.'
Assert-Contains $source 'CountVngOwnedItems[\s\S]{0,700}GetFirstItem[\s\S]{0,500}GetStackNum' 'Owned item count does not include authoritative stacks.'
Assert-Contains $source 'AddVngNormalItemToInventory[\s\S]{0,1000}CreateVngNormalItem[\s\S]{0,800}ItemSet\.Remove' 'Inventory insertion has no rollback.'
Assert-Contains $itemList 'FindSameItemToStack[\s\S]{0,500}ItemSet\.Remove\(nIdx\)' 'Fully merged stacks leak the temporary item slot.'
Assert-Contains $source 'LuaAddEventItemCompat[\s\S]{0,700}questkey\.txt[\s\S]{0,300}item_task,\s*nDetail' 'EventItem is not resolved from the VNG sparse QuestKey registry.'
Assert-Contains $basic 'GetQuestRecord[\s\S]{0,240}m_BPTQuest\.FindRecord' 'QuestKey lookup is not sparse-key safe.'
Assert-Contains $source 'RemoveVngItems[\s\S]{0,1600}m_ItemList\.Remove[\s\S]{0,200}ItemSet\.Remove' 'Item deletion does not update inventory and item ownership together.'
Assert-Contains $source 'LuaDelNormalItemInQuickCompat[\s\S]{0,500}pos_immediacy' 'Quick-slot deletion is not room-scoped.'
Assert-Contains $source 'LuaHaveItemInAllRoomCompat[\s\S]{0,500}CountVngOwnedItems[\s\S]{0,100}-1' 'All-room query is not inventory-wide.'
Assert-Contains $source 'GetInventoryFreeCells[\s\S]{0,250}CalcFreeItemCellCount\(1,\s*1,\s*room_equipment\)' 'Treasure space does not use the inventory geometry.'
Assert-Contains $source 'LuaIsHaveSpaceForTreasureCompat[\s\S]{0,500}GetInventoryFreeCells' 'Treasure space does not consult the inventory geometry helper.'
Assert-Contains $source 'LuaIsEquipItemCompat[\s\S]{0,1000}GetEquipment\(i\)' 'Equipped item query does not inspect equipment slots.'
Assert-Contains $source 'LuaAbradeEquipCompat[\s\S]{0,1100}m_ItemList\.Abrade\(nType\)[\s\S]{0,500}GetDurability\(\)\s*==\s*0' 'Equipment abrasion does not report actual broken items.'
Assert-Contains $source 'LuaGetNormalItemNameCompat[\s\S]{0,850}CreateVngNormalItem[\s\S]{0,500}ItemSet\.Remove' 'Normal item name is not resolved through the actual VNG item generator.'
$missing=@(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis|Where-Object{$_ -in $missing.name}).Count -eq 0) 'Audit still reports one or more Wave 2 APIs.'
$summary=Get-Content -Raw (Join-Path $AuditRoot 'summary.json')|ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 140) "Wave 2 gap regressed above 140: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'
[pscustomobject]@{Status='PASS';Wave=2;ImplementedApiCount=$apis.Count;RemainingApiNames=$summary.lua.missing_api_name_count}
