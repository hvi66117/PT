$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$source=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KItemList.cpp'),[Text.Encoding]::GetEncoding(28591))
if($source -notmatch 'PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT,\s*sizeof\(sItem\),\s*PHONGTHAN_WIRE_FLAG_RESPONSE'){
 throw 'Actual item snapshot sender does not match response-only receiver'
}
$receiver=[IO.File]::ReadAllText((Join-Path $root 'Headers/PhongThanProtocol.h'))
if($receiver -notmatch 'item->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE'){throw 'Receiver contract changed'}
'PASS: production SyncItem sender and snapshot validator use matching RESPONSE flags.'
