[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$AuditRoot,
    [string]$OutputJson,
    [string]$OutputTsv
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
if (-not $AuditRoot) {
    $AuditRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'SourceMigration\staging\p0.3-validated-entry-sets\audit'
}
$AuditRoot = [IO.Path]::GetFullPath($AuditRoot)
if (-not $OutputJson) { $OutputJson = Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json' }
if (-not $OutputTsv) { $OutputTsv = Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.tsv' }

[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)

function Read-AuditedLua([object]$Entry) {
    $encoding = switch ($Entry.encoding) {
        'cp1258' { [Text.Encoding]::GetEncoding(1258) }
        'gb18030' { [Text.Encoding]::GetEncoding(54936) }
        'latin-1' { [Text.Encoding]::GetEncoding(28591) }
        'utf-8-sig' { [Text.UTF8Encoding]::new($true, $true) }
        default { throw "Unsupported audited Lua encoding: $($Entry.encoding)" }
    }
    $encoding.GetString([IO.File]::ReadAllBytes($Entry.output))
}

function Test-IdentifierChar([char]$Char) {
    [char]::IsLetterOrDigit($Char) -or $Char -eq '_'
}

function Split-LuaArguments([string]$Text) {
    if ([string]::IsNullOrWhiteSpace($Text)) { return @() }
    $parts = [Collections.Generic.List[string]]::new()
    $start = 0
    $paren = 0
    $brace = 0
    $bracket = 0
    $quote = [char]0
    $escape = $false
    for ($i = 0; $i -lt $Text.Length; $i++) {
        $ch = $Text[$i]
        if ($quote -ne [char]0) {
            if ($escape) { $escape = $false; continue }
            if ($ch -eq '\') { $escape = $true; continue }
            if ($ch -eq $quote) { $quote = [char]0 }
            continue
        }
        if ($ch -eq "'" -or $ch -eq '"') { $quote = $ch; continue }
        switch ($ch) {
            '(' { $paren++ }
            ')' { if ($paren -gt 0) { $paren-- } }
            '{' { $brace++ }
            '}' { if ($brace -gt 0) { $brace-- } }
            '[' { $bracket++ }
            ']' { if ($bracket -gt 0) { $bracket-- } }
            ',' {
                if ($paren -eq 0 -and $brace -eq 0 -and $bracket -eq 0) {
                    $parts.Add($Text.Substring($start, $i - $start).Trim())
                    $start = $i + 1
                }
            }
        }
    }
    $parts.Add($Text.Substring($start).Trim())
    @($parts)
}

function Get-ArgumentKind([string]$Argument) {
    $value = $Argument.Trim()
    if ($value -match '^[+-]?(?:\d+(?:\.\d*)?|\.\d+)$') { return 'number' }
    if ($value -match '^["'']') { return 'string' }
    if ($value -match '^(?:nil|true|false)$') { return 'literal' }
    if ($value -match '^\{') { return 'table' }
    if ($value -match '^[A-Za-z_][A-Za-z0-9_]*$') { return 'identifier' }
    'expression'
}

function Get-ReturnUse([string]$Text, [int]$Position) {
    $lineStart = $Text.LastIndexOf("`n", [Math]::Max(0, $Position - 1))
    if ($lineStart -lt 0) { $lineStart = 0 } else { $lineStart++ }
    $prefix = $Text.Substring($lineStart, $Position - $lineStart)
    if ($prefix -match '\b(?:if|elseif|while)\s*$') { return 'condition' }
    if ($prefix -match '\breturn\s*$') { return 'return' }
    if ($prefix -match '(?<![=<>~])=(?!=)[^=]*$') { return 'assignment' }
    if ($prefix -match '[,(]\s*$') { return 'expression' }
    'statement'
}

function Find-LuaCalls([string]$Text, [string]$Name) {
    $result = [Collections.Generic.List[object]]::new()
    $searchFrom = 0
    while ($searchFrom -lt $Text.Length) {
        $pos = $Text.IndexOf($Name, $searchFrom, [StringComparison]::Ordinal)
        if ($pos -lt 0) { break }
        $searchFrom = $pos + $Name.Length
        if ($pos -gt 0 -and (Test-IdentifierChar $Text[$pos - 1])) { continue }
        if ($searchFrom -lt $Text.Length -and (Test-IdentifierChar $Text[$searchFrom])) { continue }
        $open = $searchFrom
        while ($open -lt $Text.Length -and [char]::IsWhiteSpace($Text[$open])) { $open++ }
        if ($open -ge $Text.Length -or $Text[$open] -ne '(') { continue }

        $depth = 1
        $quote = [char]0
        $escape = $false
        $close = -1
        for ($i = $open + 1; $i -lt $Text.Length; $i++) {
            $ch = $Text[$i]
            if ($quote -ne [char]0) {
                if ($escape) { $escape = $false; continue }
                if ($ch -eq '\') { $escape = $true; continue }
                if ($ch -eq $quote) { $quote = [char]0 }
                continue
            }
            if ($ch -eq "'" -or $ch -eq '"') { $quote = $ch; continue }
            if ($ch -eq '(') { $depth++; continue }
            if ($ch -eq ')') {
                $depth--
                if ($depth -eq 0) { $close = $i; break }
            }
        }
        if ($close -lt 0) { continue }
        $argumentText = $Text.Substring($open + 1, $close - $open - 1)
        $arguments = @(Split-LuaArguments $argumentText)
        $line = 1
        if ($pos -gt 0) { $line += ([regex]::Matches($Text.Substring(0, $pos), "`n")).Count }
        $result.Add([pscustomobject]@{
            line = $line
            argument_count = $arguments.Count
            argument_kinds = @($arguments | ForEach-Object { Get-ArgumentKind $_ })
            return_use = Get-ReturnUse $Text $pos
            text = $argumentText.Trim()
        })
        $searchFrom = $close + 1
    }
    @($result)
}

$groups = [ordered]@{
    'runtime-time-global-helper' = 'GetYMD,GetHMS,pcall,GetGameServerName,GetGlobalValueByte,SetGlobalValueByte,GetWeekDay,ipairs,IsWarServer,SetGlobalValueWord,GetGlobalValueWord,GetIPValue'.Split(',')
    'message-dialog-ui' = 'Msg2CurMapAnnounceEx,MsgBox,Msg2CurMapAnnounce,NpcSay,InfoBox,GetDialogNpcName'.Split(',')
    'item-inventory-equipment' = 'HaveNormalItem,AddNormalItemPile,IsHaveSpaceForTreasure,AddEventItem,ClearItem,HaveEventItem,DelNormalItem,AddNormalItemBind,HaveItemInAllRoom,GetBoxSize,HaveEventItemCount,IsEquipItem,AbradeEquip,DelEventItem,GetNormalItemName,DelNormalItemInQuick'.Split(',')
    'ibbuff-player-npc' = 'HaveIBBuff,AddIBBuff,RemoveIBBuff,GetIBBuffTimes,GetIBBuffLeftTimes,GetIBBuffCount,NpcRemoveIBBuff,NpcHaveIBBuff,GetIBBuffLevel,NpcAddIBBuff,CostIBBuff'.Split(',')
    'task-quest-note' = 'TaskNote,FinishNpcCollection,SayTask,SetPlayerTaskState,SetMateTask,SetSubTask,RefreshAllNpcTask,IsNewBirthComplete,IsJEMainTaskComplete,JEMainTaskComplete,NewTaskNote,TaskCheck'.Split(',')
    'player-progression-relation-title' = 'GetPlayerExtLevel,GetJusticEvilCredit,GetPlayerType,IsMantlePrentice,IsPlayerInsideWeapon,IsMasterPRRelation,IsMantleMaster,GetMantleMasterName,IsPlayerInDeath,AddHelpScore,AddOwnExtendExp,ActiveTitleQualify,SetCurTitle,GetMasterPlayerIndex,ChangeJusticEvilCredit,GetExploitLevel,GetPosterityType,IsMarried,GetExploit,SetExploitV,SetExploit,GetExploitV,GetPlayerTarget,ApplyAssignedAttrib,AddAssignedAttrib,GetAssignedAttrib,HaveQualify,ActiveTitleFunc,PetGetType'.Split(',')
    'player-lookup-session' = 'SearchPlayerById,GetSubWorldPlayerIdxByNum,GetSubWorldPlayerCount,GetPlayerIndexByName,GetFirstPlayerInAll,GetNextPlayerInAll,GetSessionNextPlayer,PlayerIndexToNpcIndex'.Split(',')
    'team' = 'TeamAction,GetTeamTask,SetTeamTask'.Split(',')
    'tong-city-siege' = 'IsTongMember,Msg2TongMember,Msg2TongMemberByTongName,IsOwnerCity,GetCityInfo,NewSiegeWeapon,GetSiegeWeaponNpcIndex,GetSiegeWeaponPlayerCount,GetTongIDByName,GetCityInfoByID,GetNpcMapCityID,GetCityTaskByID,DeleteSiegeWeapon,GetTGuardIndexByCarriageIndex,GetSiegeWeaponIndexByNpcIndex,GetTGuardIndexByPlayerName,GetTGuardInfo,ModifyUnionTongWarPowerByName,GetTongTaskByID,GetUnionTongNameByPosterityType,SetCityTaskByID,GetUnionTongIDByPosterityType,GetHeavenCityUnion,GetCityGateNpcIdxByNpc,IsInMonsterAttackDay,GetCityTotemNpcIdxByNpc,SetTongTask,AddTongRes,GetTongTask,GetCityName'.Split(',')
    'instance-world-event-map' = 'WorldBossDeath,SetInstanceTempValue,InstanceMsg2All,MonsterOnDeath,PlayerInOrOut,GetInstanceActiveInfo,GetInstanceBaseInfo,GetInstanceTempValue,AddEvent,SetMissionV,GetWorldEventValue,SetWorldEventValue,SetWorldEventProgress,GetWorldEventProgress,SetBarrierState,DeleteSubWorldKindNpcs'.Split(',')
    'npc-ai-creature-trap-totem' = 'GetHardNpcAttrib,NpcPolyMorph,SetAIScript,SetNpcCamp,SetGuardLevel,AddTotemNpc,AddMyTrap,GetMorphType,SetNpcTarget,PolyMorph,GetCreatureInfo,SetCreatureType,DelNpcTimer,CancelNpcBelonger,BeginMotion,GetNpcPolyMorph,SetEffectNpc,SetEffectNpcCount,GetFreeNpcCount,HaveEffectNpc,ClearEffectNpc,ModifyEffectNpc,CaptureNpc,CallMonsterAttacker,GetNpcBelonger,DelBuildingNpc,GetNpcEnmityItem,GetNpcEnmityCount,GetGuardLevel,GetNpcOwer,GetBossTargetPlayer'.Split(',')
    'skill-combat-action' = 'GetLiveSkillLevel,BeginLvSkill,DoSkillAction,Getskill_eventskilllevel,SetClientRightSkill,RemoveSpecialSkill,SetClientLeftSkill,PlayerCastSkill'.Split(',')
}

$waves = @{
    'runtime-time-global-helper' = 1; 'message-dialog-ui' = 1; 'player-lookup-session' = 1
    'item-inventory-equipment' = 2
    'player-progression-relation-title' = 3; 'team' = 3
    'ibbuff-player-npc' = 4
    'task-quest-note' = 5
    'skill-combat-action' = 6
    'npc-ai-creature-trap-totem' = 7
    'tong-city-siege' = 8
    'instance-world-event-map' = 9
}

$contracts = @{
    'runtime-time-global-helper' = @{ data = 'Lua 4.0 runtime and bounded global-value registry'; owner = 'runtime/server'; persistence = 'global values only'; client = 'none' }
    'message-dialog-ui' = @{ data = 'message channel and dialog contract'; owner = 'server'; persistence = 'no'; client = 'message/dialog UI protocol' }
    'item-inventory-equipment' = @{ data = 'settings/item/001 plus verified EventItem/Treasure registries'; owner = 'server inventory'; persistence = 'role inventory'; client = 'inventory/equipment sync' }
    'ibbuff-player-npc' = @{ data = 'VNG IBBuff registry, stacking and duration rules'; owner = 'server buff manager'; persistence = 'player buffs'; client = 'buff state/icon/timer sync' }
    'task-quest-note' = @{ data = 'VNG task-note templates and task state schema'; owner = 'server task manager'; persistence = 'role task state'; client = 'task journal and NPC marker sync' }
    'player-progression-relation-title' = @{ data = 'VNG player progression/relation/title schema'; owner = 'server player'; persistence = 'role/relationship state'; client = 'F3/title/attribute sync' }
    'player-lookup-session' = @{ data = 'bounded player/session/subworld index contract'; owner = 'server world'; persistence = 'no'; client = 'none' }
    'team' = @{ data = 'team membership and team-task schema'; owner = 'server team'; persistence = 'team lifetime'; client = 'team state sync' }
    'tong-city-siege' = @{ data = 'VNG Tong/city/siege registries'; owner = 'server Tong/city'; persistence = 'Tong/city ownership'; client = 'Tong/city/siege sync' }
    'instance-world-event-map' = @{ data = 'instance/world-event/mission registry'; owner = 'server instance/world'; persistence = 'world events only'; client = 'instance/world event sync' }
    'npc-ai-creature-trap-totem' = @{ data = 'VNG HardNpc/AI/trap/totem/creature contracts'; owner = 'server NPC/world'; persistence = 'runtime lifetime'; client = 'NPC/morph/effect sync' }
    'skill-combat-action' = @{ data = 'VNG skill and event-skill registries'; owner = 'server skill/combat'; persistence = 'learned skill state'; client = 'skill bar/action sync' }
}

$recoveredDataContracts = @(
    'TaskNote','NewTaskNote','AddEventItem','HaveEventItem','HaveEventItemCount',
    'DelEventItem','GetHardNpcAttrib','AddTotemNpc','SetAIScript','Getskill_eventskilllevel','AddMyTrap',
    'HaveIBBuff','AddIBBuff','RemoveIBBuff','GetIBBuffTimes','GetIBBuffLeftTimes',
    'GetIBBuffCount','NpcRemoveIBBuff','NpcHaveIBBuff','GetIBBuffLevel','NpcAddIBBuff','CostIBBuff'
)
$projectGlobals = @('HaveNormalItem','DelNormalItem','AddNormalItemBind','Getskill_eventskilllevel')
$runtimeHelpers = @('pcall','ipairs')

$missingPath = Join-Path $AuditRoot 'lua-missing-api.tsv'
$detailsPath = Join-Path $AuditRoot 'lua-semantic-details.json'
$summaryPath = Join-Path $AuditRoot 'summary.json'
$missing = @(Import-Csv -Delimiter "`t" -LiteralPath $missingPath)
$details = @(Get-Content -Raw -LiteralPath $detailsPath | ConvertFrom-Json)
$summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json
$groupByName = @{}
foreach ($group in $groups.Keys) {
    foreach ($name in $groups[$group]) {
        if ($groupByName.ContainsKey($name)) { throw "Duplicate API catalog assignment: $name" }
        $groupByName[$name] = $group
    }
}

# Once the campaign reaches zero missing names the semantic audit no longer
# contains the original unresolved call sites. Preserve that Wave 0 inventory
# and only advance its completion metadata; otherwise a legitimate final audit
# would regenerate an empty catalog.
if ($missing.Count -eq 0) {
    if ($summary.lua.missing_api_name_count -ne 0) {
        throw 'Missing API TSV is empty but summary.json is not at zero gap.'
    }
    if (-not (Test-Path -LiteralPath $OutputJson -PathType Leaf)) {
        throw 'Zero-gap regeneration requires the committed Wave 0 catalog.'
    }
    $existing = Get-Content -Raw -LiteralPath $OutputJson | ConvertFrom-Json
    $catalog = @($existing.apis)
    if ($catalog.Count -ne 182 -or @($catalog.name | Sort-Object -Unique).Count -ne 182) {
        throw "Committed Wave 0 catalog is invalid: $($catalog.Count) entries."
    }
    foreach ($entry in $catalog) {
        if (-not $groupByName.ContainsKey([string]$entry.name)) {
            throw "Committed catalog contains an unknown API: $($entry.name)"
        }
        $entry.contract_status = if ($entry.name -in $recoveredDataContracts) {
            'data-contract-recovered'
        }
        else { 'call-contract-inventoried' }
    }
    $existing.audit_manifest_sha256 = $summary.manifest_sha256
    $existing.generated_utc = [DateTime]::UtcNow.ToString('o')
    $json = $existing | ConvertTo-Json -Depth 12
    [IO.File]::WriteAllText($OutputJson, $json + "`r`n", [Text.UTF8Encoding]::new($false))
    $tsvRows = @($catalog | Select-Object name,subsystem,wave,audited_file_references,extracted_call_count,official_file_references,community_file_references,audit_status,implementation_kind,contract_status,data_contract,state_owner,persistence,client_sync)
    $tsv = $tsvRows | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation
    [IO.File]::WriteAllLines($OutputTsv, $tsv, [Text.UTF8Encoding]::new($false))
    [pscustomobject]@{
        Status = 'PASS'
        ApiCount = $catalog.Count
        AuditedFileReferences = ($catalog | Measure-Object audited_file_references -Sum).Sum
        ExtractedCalls = ($catalog | Measure-Object extracted_call_count -Sum).Sum
        OfficialFileReferences = ($catalog | Measure-Object official_file_references -Sum).Sum
        DataContractRecovered = @($catalog | Where-Object contract_status -eq 'data-contract-recovered').Count
        OutputJson = $OutputJson
        OutputTsv = $OutputTsv
    }
    return
}

$textCache = @{}
$catalog = foreach ($row in $missing) {
    $name = $row.name
    if (-not $groupByName.ContainsKey($name)) { throw "Unclassified API: $name" }
    $group = $groupByName[$name]
    $hits = @($details | Where-Object { $_.unresolved_calls -contains $name })
    $calls = [Collections.Generic.List[object]]::new()
    foreach ($hit in $hits) {
        if (-not $textCache.ContainsKey($hit.output)) { $textCache[$hit.output] = Read-AuditedLua $hit }
        foreach ($call in @(Find-LuaCalls $textCache[$hit.output] $name)) {
            $calls.Add([pscustomobject]@{
                logical_path = $hit.logical_path
                source_tier = $hit.source_tier
                bucket = $hit.bucket
                line = $call.line
                argument_count = $call.argument_count
                argument_kinds = $call.argument_kinds
                return_use = $call.return_use
                text = $call.text
            })
        }
    }
    $forms = @($calls | Group-Object { "$($_.argument_count):$(($_.argument_kinds) -join ','):$($_.return_use)" } | ForEach-Object {
        [pscustomobject]@{
            form = $_.Name
            count = $_.Count
            example_path = $_.Group[0].logical_path
            example_line = $_.Group[0].line
            example_arguments = $_.Group[0].text
        }
    } | Sort-Object form)
    [pscustomobject]@{
        name = $name
        subsystem = $group
        wave = $waves[$group]
        audited_file_references = [int]$row.entry_count
        extracted_call_count = $calls.Count
        official_file_references = @($hits | Where-Object bucket -eq 'vng-official-baseline').Count
        community_file_references = @($hits | Where-Object bucket -eq 'community-quarantine').Count
        source_tiers = @($hits.source_tier | Sort-Object -Unique)
        audit_status = $row.status
        implementation_kind = if ($name -in $runtimeHelpers) { 'lua4-runtime-helper' } elseif ($name -in $projectGlobals) { 'project-global-or-native-contract' } else { 'native-gameplay-api' }
        contract_status = if ($name -in $recoveredDataContracts) { 'data-contract-recovered' } else { 'call-contract-inventoried' }
        data_contract = $contracts[$group].data
        state_owner = $contracts[$group].owner
        persistence = $contracts[$group].persistence
        client_sync = $contracts[$group].client
        call_forms = $forms
        call_sites = @($calls)
    }
}

if ($catalog.Count -ne 182 -or $groupByName.Count -ne 182) {
    throw "Catalog coverage mismatch: catalog=$($catalog.Count), assigned=$($groupByName.Count)"
}

$document = [ordered]@{
    schema = 1
    baseline_commit = '40ebc31'
    audit_manifest_sha256 = $summary.manifest_sha256
    generated_utc = [DateTime]::UtcNow.ToString('o')
    api_count = $catalog.Count
    audited_file_reference_count = ($catalog | Measure-Object audited_file_references -Sum).Sum
    extracted_call_count = ($catalog | Measure-Object extracted_call_count -Sum).Sum
    wave_counts = @($catalog | Group-Object wave | Sort-Object Name | ForEach-Object { [pscustomobject]@{ wave = [int]$_.Name; api_count = $_.Count; file_references = ($_.Group | Measure-Object audited_file_references -Sum).Sum } })
    apis = @($catalog)
}

$json = $document | ConvertTo-Json -Depth 12
[IO.File]::WriteAllText($OutputJson, $json + "`r`n", [Text.UTF8Encoding]::new($false))
$tsvRows = @($catalog | Select-Object name,subsystem,wave,audited_file_references,extracted_call_count,official_file_references,community_file_references,audit_status,implementation_kind,contract_status,data_contract,state_owner,persistence,client_sync)
$tsv = $tsvRows | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation
[IO.File]::WriteAllLines($OutputTsv, $tsv, [Text.UTF8Encoding]::new($false))

[pscustomobject]@{
    Status = 'PASS'
    ApiCount = $catalog.Count
    AuditedFileReferences = $document.audited_file_reference_count
    ExtractedCalls = $document.extracted_call_count
    OfficialFileReferences = ($catalog | Measure-Object official_file_references -Sum).Sum
    DataContractRecovered = @($catalog | Where-Object contract_status -eq 'data-contract-recovered').Count
    OutputJson = $OutputJson
    OutputTsv = $OutputTsv
}
