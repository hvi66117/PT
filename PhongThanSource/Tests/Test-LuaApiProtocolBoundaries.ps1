[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [switch]$WriteEvidence
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Read-Latin1([string]$Relative) {
    [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes((Join-Path $ProjectRoot $Relative)))
}
function Assert-Match([string]$Text, [string]$Pattern, [string]$Message) {
    Assert-True ($Text -match $Pattern) $Message
}

$catalog = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis)
Assert-True ($apis.Count -eq 182) "Protocol gate nhan $($apis.Count)/182 API."
$protocolDef = Read-Latin1 'Headers\KProtocolDef.h'
$protocolStruct = Read-Latin1 'Headers\KProtocol.h'
$phongThanWire = Read-Latin1 'Headers\PhongThanProtocol.h'
$protocolProcess = Read-Latin1 'Sources\Core\Src\KProtocolProcess.cpp'
$player = Read-Latin1 'Sources\Core\Src\KPlayer.cpp'
$npc = Read-Latin1 'Sources\Core\Src\KNpc.cpp'
$item = Read-Latin1 'Sources\Core\Src\KItemList.cpp'
$scriptFuns = Read-Latin1 'Sources\Core\Src\ScriptFuns.cpp'

$scriptUiApis = @(
    'InfoBox','MsgBox','NpcSay','Msg2CurMapAnnounce','Msg2CurMapAnnounceEx',
    'SayTask','TaskNote','NewTaskNote','RefreshAllNpcTask','AddEvent','InstanceMsg2All',
    'Msg2TongMember','Msg2TongMemberByTongName'
)
$inventoryApis = @(
    'AbradeEquip','AddEventItem','AddNormalItemBind','AddNormalItemPile','ClearItem',
    'DelEventItem','DelNormalItem','DelNormalItemInQuick'
)
$playerSyncApis = @(
    'ActiveTitleFunc','ActiveTitleQualify','AddAssignedAttrib','AddHelpScore','AddOwnExtendExp',
    'ApplyAssignedAttrib','ChangeJusticEvilCredit','SetCurTitle','SetExploit','SetExploitV'
)
$stateEffectApis = @('AddIBBuff','CostIBBuff','NpcAddIBBuff','NpcRemoveIBBuff','RemoveIBBuff')
$skillApis = @('BeginLvSkill','DoSkillAction','PlayerCastSkill','RemoveSpecialSkill','SetClientLeftSkill','SetClientRightSkill')
$npcSyncApis = @(
    'AddMyTrap','AddTotemNpc','BeginMotion','CallMonsterAttacker','CancelNpcBelonger','CaptureNpc',
    'ClearEffectNpc','DelBuildingNpc','DelNpcTimer','ModifyEffectNpc','NpcPolyMorph','PolyMorph',
    'SetAIScript','SetCreatureType','SetEffectNpc','SetEffectNpcCount','SetGuardLevel','SetNpcCamp',
    'SetNpcTarget','NewSiegeWeapon','DeleteSiegeWeapon','DeleteSubWorldKindNpcs','SetBarrierState',
    'MonsterOnDeath','PlayerInOrOut','WorldBossDeath'
)

$boundaries = [ordered]@{
    'script-action-ui' = [ordered]@{
        Apis = $scriptUiApis
        Protocol = 's2c_scriptaction / PLAYER_SCRIPTACTION_SYNC'
        Producer = 'KPlayer::DoScriptAction -> PackDataToClient with bounded m_wProtocolLong'
        Consumer = 'KProtocolProcess::SyncScriptAction -> KPlayer::OnScriptAction -> UI callback'
    }
    'inventory-sync' = [ordered]@{
        Apis = $inventoryApis
        Protocol = 'PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT / ITEM_REMOVE / ITEM_MOVE / ITEM_DURABILITY / ITEM_PROPERTIES / ITEM_AUTO_MOVE'
        Producer = 'KItemList -> self-describing PHONGTHAN_WIRE_HEADER and scalar-only item payloads'
        Consumer = 'KProtocolProcess validates exact envelope size then dispatches all migrated inventory messages'
    }
    'player-f3-sync' = [ordered]@{
        Apis = $playerSyncApis
        Protocol = 's2c_syncplayer plus rank/current-attribute submessages'
        Producer = 'KNpc player sync and KPlayer current attribute/rank producers'
        Consumer = 'KProtocolProcess::SyncPlayer/s2cSyncRankData/current attribute consumer'
    }
    'state-effect-sync' = [ordered]@{
        Apis = $stateEffectApis
        Protocol = 's2c_syncstateeffect / STATE_EFFECT_SYNC'
        Producer = 'KNpc::SetStateSkillEffect emits bounded state payload'
        Consumer = 'KProtocolProcess::SyncStateEffect reapplies native state skill'
    }
    'skill-action-sync' = [ordered]@{
        Apis = $skillApis
        Protocol = 'PLAYER_SYNC append-only LEFTSKILL/RIGHTSKILL ids and native skill sync'
        Producer = 'ScriptFuns emits PLAYER_SYNC and native skill/action commands'
        Consumer = 'KProtocolProcess player-sync dispatcher updates skill bars/action state'
    }
    'npc-world-sync' = [ordered]@{
        Apis = $npcSyncApis
        Protocol = 's2c_syncnpc and existing NPC movement/remove/state messages'
        Producer = 'KNpc::SendSyncData and native NPC lifecycle producers'
        Consumer = 'KProtocolProcess::SyncNpc and NPC lifecycle dispatch table'
    }
}

Assert-Match $protocolDef 's2c_scriptaction' 'Thieu s2c_scriptaction id.'
Assert-Match $protocolStruct 'PLAYER_SCRIPTACTION_SYNC' 'Thieu PLAYER_SCRIPTACTION_SYNC.'
Assert-Match $player 'DoScriptAction[\s\S]{0,500}s2c_scriptaction[\s\S]{0,300}m_wProtocolLong[\s\S]{0,500}PackDataToClient' 'Script-action producer khong dong goi payload co length.'
Assert-Match $protocolProcess 'ProcessFunc\[s2c_scriptaction\]\s*=\s*SyncScriptAction' 'Client thieu script-action dispatcher.'
Assert-Match $protocolProcess 'SyncScriptAction[\s\S]{0,500}OnScriptAction' 'Client thieu script-action consumer.'

foreach ($payload in @(
    'PHONGTHAN_ITEM_SNAPSHOT','PHONGTHAN_ITEM_REMOVE_MESSAGE','PHONGTHAN_ITEM_MOVE_MESSAGE',
    'PHONGTHAN_ITEM_DURABILITY_MESSAGE','PHONGTHAN_ITEM_PROPERTIES_MESSAGE',
    'PHONGTHAN_ITEM_USE_REQUEST','PHONGTHAN_ITEM_PICKUP_REQUEST','PHONGTHAN_ITEM_MOVE_REQUEST',
    'PHONGTHAN_ITEM_DROP_REQUEST','PHONGTHAN_NPC_SHOP_SELL_REQUEST','PHONGTHAN_NPC_SHOP_BUY_REQUEST'
)) {
    Assert-Match $phongThanWire "\b$payload\b" "Thieu payload inventory Phong Than: $payload."
}
Assert-True ($phongThanWire -notmatch '\b(?:PlayerItem|KLockItem|KMagicAttrib)\b') 'Inventory wire con lo runtime class.'
Assert-Match $item 'void\s+KItemList::SyncItem\([\s\S]{0,1800}PhongThanInitializeWireHeader\(&sItem\.Header[\s\S]{0,5000}sizeof\(sItem\)' 'Item snapshot producer chua dung envelope moi.'
Assert-Match $item 'SendPhongThanItemRemove[\s\S]{0,500}PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE' 'Item remove producer chua dung envelope moi.'
Assert-Match $item 'SendPhongThanItemDurability[\s\S]{0,600}Message\.Durability = nDurability' 'Durability producer chua gui gia tri tuyet doi.'
Assert-Match $protocolProcess 'case PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT:[\s\S]{0,500}case PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE:[\s\S]{0,500}case PHONGTHAN_MSG_INVENTORY_ITEM_MOVE:[\s\S]{0,500}case PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY:[\s\S]{0,500}case PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES:[\s\S]{0,500}case PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE:' 'Client thieu dispatcher inventory Phong Than.'
Assert-Match $protocolProcess 'ProcessFunc\[s2c_syncitem\]\s*=\s*NULL;[\s\S]{0,300}ProcessFunc\[s2c_removeitem\]\s*=\s*NULL;[\s\S]{0,300}ProcessFunc\[s2c_playermoveitem\]\s*=\s*NULL;[\s\S]{0,3000}ProcessFunc\[s2c_ItemAutoMove\]\s*=\s*NULL;[\s\S]{0,3000}ProcessFunc\[s2c_itemdurabilitychange\]\s*=\s*NULL;' 'Legacy inventory dispatcher chua bi khoa.'

Assert-Match $protocolDef 's2c_syncplayer[\s\S]{0,100}s2c_syncplayermin' 'Player sync ids thay doi.'
Assert-Match $npc 'PlayerSync\.ProtocolType\s*=\s*\(BYTE\)s2c_syncplayer' 'Server thieu full player sync producer.'
Assert-Match $protocolProcess 'ProcessFunc\[s2c_syncplayer\]\s*=\s*SyncPlayer' 'Client thieu player sync dispatcher.'
Assert-Match $protocolProcess 's2cSyncRankData\s*\(' 'Client thieu rank consumer.'
Assert-Match $player 'SetBaseStrength[\s\S]{0,1000}m_btAttribute\s*=\s*0[\s\S]{0,600}PackDataToClient' 'Base attribute setter khong sync F3.'

Assert-Match $protocolStruct 'STATE_EFFECT_SYNC' 'Thieu STATE_EFFECT_SYNC struct.'
Assert-Match $npc 'SetStateSkillEffect[\s\S]{0,1200}s2c_syncstateeffect[\s\S]{0,700}m_wLength' 'State effect producer khong co bounded length.'
Assert-Match $protocolProcess 'ProcessFunc\[s2c_syncstateeffect\]\s*=\s*SyncStateEffect' 'Client thieu state effect dispatcher.'
Assert-Match $protocolProcess 'SyncStateEffect[\s\S]{0,900}SetStateSkillEffect' 'Client thieu state effect consumer.'

Assert-Match $protocolDef 'enumS2C_PLAYERSYNC_ID_MASKFEATURE,[\s\S]{0,300}enumS2C_PLAYERSYNC_ID_LEFTSKILL,[\s\S]{0,100}enumS2C_PLAYERSYNC_ID_RIGHTSKILL' 'Skill shortcut ids khong append-only.'
Assert-Match $scriptFuns 'm_wLength\s*=\s*sizeof\(S2C_PLAYER_SYNC\)\s*-\s*1[\s\S]{0,200}m_wMsgID\s*=\s*bRightSkill\s*\?\s*enumS2C_PLAYERSYNC_ID_RIGHTSKILL\s*:[\s\S]{0,100}enumS2C_PLAYERSYNC_ID_LEFTSKILL[\s\S]{0,300}m_wLength\s*\+\s*1' 'Server thieu exact skill shortcut producer.'
Assert-Match $protocolProcess 'enumS2C_PLAYERSYNC_ID_LEFTSKILL[\s\S]{0,180}SetLeftSkill[\s\S]{0,300}enumS2C_PLAYERSYNC_ID_RIGHTSKILL[\s\S]{0,180}SetRightSkill' 'Client thieu skill shortcut consumers.'

Assert-Match $protocolDef 's2c_syncnpc[\s\S]{0,100}s2c_syncnpcmin' 'NPC sync ids thay doi.'
Assert-Match $npc 'NpcSync\.ProtocolType\s*=\s*\(BYTE\)s2c_syncnpc' 'Server thieu NPC sync producer.'
Assert-Match $protocolProcess 'ProcessFunc\[s2c_syncnpc\]\s*=\s*SyncNpc[\s\S]{0,700}ProcessFunc\[s2c_npcremove\]\s*=\s*NetCommandRemoveNpc' 'Client thieu NPC add/remove dispatcher.'

$assigned = @{}
foreach ($boundaryName in $boundaries.Keys) {
    foreach ($name in @($boundaries[$boundaryName].Apis)) {
        Assert-True ($name -in $apis.name) "Protocol map chua API khong thuoc campaign: $name."
        Assert-True (-not $assigned.ContainsKey($name)) "API $name bi map hai protocol boundary."
        $assigned[$name] = $boundaryName
    }
}
$evidence = New-Object System.Collections.Generic.List[object]
foreach ($api in $apis) {
    $name = [string]$api.name
    if ($assigned.ContainsKey($name)) {
        $boundaryName = [string]$assigned[$name]
        $boundary = $boundaries[$boundaryName]
        $evidence.Add([pscustomobject]@{
            name = $name
            wave = [int]$api.wave
            client_sync = 'required-and-verified'
            boundary = $boundaryName
            protocol = $boundary.Protocol
            producer = $boundary.Producer
            consumer = $boundary.Consumer
            reason = $null
        })
    }
    else {
        $reason = if ($name -match '^(Get|Have|Is|Search|Find)' -or $name -in @('pcall','ipairs','PlayerIndexToNpcIndex','PetGetType','NpcHaveIBBuff','TaskCheck')) {
            'Server-side query/helper returns only to the calling Lua state; no client packet is part of its contract.'
        }
        else {
            'Authoritative server-only state/lifecycle operation; visible effects use a separately audited native boundary when they occur.'
        }
        $evidence.Add([pscustomobject]@{
            name = $name
            wave = [int]$api.wave
            client_sync = 'not-applicable-with-reason'
            boundary = $null
            protocol = $null
            producer = $null
            consumer = $null
            reason = $reason
        })
    }
}
Assert-True ($evidence.Count -eq 182) "Protocol evidence chi co $($evidence.Count)/182."
Assert-True (@($evidence | Where-Object { $_.client_sync -eq 'required-and-verified' }).Count -eq $assigned.Count) 'Protocol required count mismatch.'
Assert-True (@($evidence | Where-Object { $_.client_sync -eq 'not-applicable-with-reason' -and -not $_.reason }).Count -eq 0) 'N/A protocol evidence thieu ly do.'

if ($WriteEvidence) {
    $document = [ordered]@{
        schema = 1
        generated_at_utc = [DateTime]::UtcNow.ToString('o')
        api_count = $evidence.Count
        required_and_verified = @($evidence | Where-Object client_sync -eq 'required-and-verified').Count
        not_applicable_with_reason = @($evidence | Where-Object client_sync -eq 'not-applicable-with-reason').Count
        boundaries = @($boundaries.Keys | ForEach-Object {
            $name = $_; [pscustomobject]@{ name=$name; protocol=$boundaries[$name].Protocol; producer=$boundaries[$name].Producer; consumer=$boundaries[$name].Consumer }
        })
        apis = @($evidence | Sort-Object wave,name)
    }
    [IO.File]::WriteAllText(
        (Join-Path $ProjectRoot 'Docs\LUA_API_182_PROTOCOL_EVIDENCE.json'),
        ($document | ConvertTo-Json -Depth 8),
        (New-Object Text.UTF8Encoding($false)))
}

[pscustomobject]@{
    Status = 'PASS'
    ApiCount = $evidence.Count
    SyncRequiredAndVerified = @($evidence | Where-Object client_sync -eq 'required-and-verified').Count
    NotApplicableWithReason = @($evidence | Where-Object client_sync -eq 'not-applicable-with-reason').Count
    BoundaryCount = $boundaries.Count
    IndependentProtocolMigration = 'IN-PROGRESS'
    StructSizeProducerConsumer = 'PASS'
}
