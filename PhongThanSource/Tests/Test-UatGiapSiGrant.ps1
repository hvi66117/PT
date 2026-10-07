[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$sourcePath = Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.cpp'
if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
    throw "Thieu source KPlayer: $sourcePath"
}
$source = [IO.File]::ReadAllText($sourcePath, [Text.Encoding]::GetEncoding(28591))
$checks = [ordered]@{
    ScopedToTestAccount = $source -match '_stricmp\(AccountName, "123456"\) == 0[\s\S]{0,400}nLevelBefore'
    SetsMaximumPlayerLevel = $source -match 'if \(nLevelBefore != MAX_LEVEL\)[\s\S]{0,80}SetLevel\(MAX_LEVEL\)'
    UsesSexSpecificWeapon = $source -match 'equip_meleeweapon, Npc\[m_nIndex\]\.m_nSex == 0 \? 0 : 1'
    UsesCompleteVngSet = ([regex]::Matches($source, '\{ equip_(?:armor|helm|belt|boots|pendant), 3 \}')).Count -eq 5
    UsesVngHorse = $source -match '\{ equip_horse, 12 \}'
    UsesMaximumEquipmentLevel = $source -match 'const int nEquipmentLevel = 10'
    BypassesLegacyMagicRoll = $source -notmatch 'nMagicLevel\[nMagic\] = 10' -and
                              $source -match 'Equipment\[nSpec\]\.nParticular, NULL'
    UsesGiapSiSeries = $source -match 'item_equip, series_metal, nEquipmentLevel'
    UsesRevisionMarker = $source -match 'const int nEquipmentRevision = 0x50544705' -and
                         $source -match 'SetParam\(nEquipmentRevision\)'
    RemovesLegacyEquipment = $source -match 'm_ItemList\.Remove\(nOldItem\)' -and
                             $source -match 'ItemSet\.Remove\(nOldItem\)'
    ChecksF4AndEquipped = $source -match 'pOwned->nPlace == pos_equiproomex' -and
                          $source -match 'pOwned->nPlace == pos_equip'
    RemovesAllOldEquipment = $source -match 'nOldEquipment\[MAX_PLAYER_ITEM\]' -and
                             $source -match 'Item\[nOldItem\]\.GetGenre\(\) == item_equip' -and
                             $source -match 'm_ItemList\.Remove\(nOldEquipment\[nDeleteOld\]\)'
    GrantsIntoF4 = $source -match 'pOwned->nPlace == pos_equiproom' -and
                   $source -match 'm_ItemList\.Add\(nGrantedItem, ItemSize, false\)'
    IsIdempotent = $source -match 'GetParam\(\) == nEquipmentRevision' -and
                   $source -match 'if \(nExistingItem > 0\)[\s\S]{0,150}\+\+nExistingCount'
    UsesActiveVngRegistry = $source -match 'GetActiveItemTableVersion\(\)'
}

$failed = @($checks.GetEnumerator() | Where-Object { -not $_.Value } | ForEach-Object Key)
if ($failed.Count) { throw "UAT Giap Si grant gate FAIL: $($failed -join ', ')" }

[pscustomobject]@{
    Result = 'PASS'
    Checks = $checks.Count
    Account = '123456'
    PlayerLevel = 200
    EquipmentLevel = 10
    EquipmentCount = 7
}
