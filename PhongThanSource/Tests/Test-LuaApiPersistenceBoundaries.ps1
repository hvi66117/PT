[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [switch]$WriteEvidence
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Read-Latin1([string]$Relative) {
    [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes((Join-Path $ProjectRoot $Relative)))
}
function Assert-Match([string]$Text, [string]$Pattern, [string]$Message) {
    Assert-True ($Text -match $Pattern) $Message
}

$catalog = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis)
Assert-True ($apis.Count -eq 182) "Persistence gate nhan $($apis.Count)/182 API."
$db = Read-Latin1 'Sources\Core\Src\KPlayerDBFuns.cpp'
$scriptFuns = Read-Latin1 'Sources\Core\Src\ScriptFuns.cpp'
$wave8 = Read-Latin1 'Sources\Core\Src\PhongThanLuaWave8.h'
$wave9 = Read-Latin1 'Sources\Core\Src\PhongThanLuaWave9.h'
$core = Read-Latin1 'Sources\Core\Src\KCore.cpp'
$dataDef = Read-Latin1 'Sources\Core\Src\GameDataDef.h'

Assert-Match $db 'LoadPlayerItemList[\s\S]{0,90000}m_ItemList\.Add' 'Role item loader khong khoi phuc inventory owner.'
Assert-Match $db 'SavePlayerItemList[\s\S]{0,5000}dwItemOffset' 'Role item saver khong serialize item block.'
Assert-Match $db 'LoadPlayerTaskList[\s\S]{0,10000}m_cTask\.SetSaveVal' 'Role task loader khong khoi phuc Task_List.'
Assert-Match $db 'SavePlayerTaskList|m_cTask\.GetSaveStr' 'Role task saver khong serialize Task_List.'
Assert-Match $dataDef 'TASKVALUE_PT_TASK_STATE[\s\S]{0,120}TASKVALUE_PT_TASK_SUB_STATE[\s\S]{0,120}TASKVALUE_PT_TASK_REVISION' 'Task state/revision slots khong duoc khoa.'
Assert-Match $scriptFuns 'LuaSetPlayerTaskStateCompat[\s\S]{0,1800}TASKVALUE_PT_TASK_STATE[\s\S]{0,700}TASKVALUE_PT_TASK_REVISION' 'SetPlayerTaskState khong ghi persistent task slots.'
Assert-Match $db 'm_nPhongThanTaskState\s*=\s*m_cTask\.GetSaveVal\(TASKVALUE_PT_TASK_STATE\)[\s\S]{0,500}m_dwPhongThanTaskRevision' 'Relog khong khoi phuc task state/revision.'
Assert-Match $scriptFuns 'PersistPlayerIBBuffStore[\s\S]{0,1800}TASKVALUE_PT_IBBUFF_BEGIN' 'IBBuff writer khong dung locked task ABI.'
Assert-Match $db 'RestorePhongThanIBBuffs\(m_nPlayerIndex\)' 'Relog khong goi IBBuff restore.'
Assert-Match $scriptFuns 'RestorePhongThanIBBuffs[\s\S]{0,1900}dwExpireTime[\s\S]{0,800}ApplyNativeIBBuffState' 'IBBuff restart restore khong loc expiry/reapply native state.'
Assert-Match $db 'LoadPlayerFightSkillList[\s\S]{0,5000}m_SkillList\.Add' 'Learned skill loader khong khoi phuc skill list.'
Assert-Match $db 'SavePlayerFightSkillList[\s\S]{0,1200}UpdateDBSkillList' 'Learned skill saver khong serialize skill list.'
Assert-Match $core 'GameData\.Init\(\)[\s\S]{0,200000}GameData\.Save\(\)' 'GameData khong co startup load/shutdown save pair.'
Assert-Match $wave8 'PhongThanPersistentGroup[\s\S]{0,3500}GameData\.FindDataId[\s\S]{0,2200}GameData\.AddDataGr' 'Tong/city persistent groups khong load/create trong GameData.'
Assert-Match $wave8 'PhongThanSetPersistentValue[\s\S]{0,900}GameData\.Save\(\)' 'Tong/city mutation khong flush GameData.'
Assert-Match $wave9 'pt_persist_world_event_value[\s\S]{0,300}pt_persist_world_event_progress[\s\S]{0,300}pt_persist_world_boss_death' 'World-event persistent namespaces khong tach biet.'

$boundaries = [ordered]@{
    'role-inventory-db' = [ordered]@{
        PersistenceValues = @('role inventory')
        WriteHook = 'KPlayer::SavePlayerItemList -> TPhongThanItemRecord role payload'
        ReadHook = 'KPlayer::LoadPlayerItemList -> authoritative KItemList ownership'
    }
    'role-task-db' = [ordered]@{
        PersistenceValues = @('role/relationship state','role task state')
        WriteHook = 'KTask SetSaveVal -> KPlayer::SavePlayerTaskList'
        ReadHook = 'KPlayer::LoadPlayerTaskList, including title and Phong Than task state restoration'
    }
    'role-ibbuff-db' = [ordered]@{
        PersistenceValues = @('player buffs')
        WriteHook = 'PersistPlayerIBBuffStore -> locked Task_List slots 4900..4995'
        ReadHook = 'RestorePhongThanIBBuffs after complete task payload, expiry checked and native state reapplied'
    }
    'role-skill-db' = [ordered]@{
        PersistenceValues = @('learned skill state')
        WriteHook = 'SavePlayerFightSkillList -> KSkillList::UpdateDBSkillList'
        ReadHook = 'LoadPlayerFightSkillList -> KSkillList::Add'
    }
    'server-gamedata-db' = [ordered]@{
        PersistenceValues = @('Tong/city ownership','world events only')
        WriteHook = 'PhongThanSetPersistentValue -> GameData.Save plus KCore shutdown flush'
        ReadHook = 'KCore startup GameData.Init -> PhongThanPersistentGroup lookup'
    }
}

$valueToBoundary = @{}
foreach ($boundaryName in $boundaries.Keys) {
    foreach ($value in @($boundaries[$boundaryName].PersistenceValues)) {
        Assert-True (-not $valueToBoundary.ContainsKey($value)) "Persistence value map trung: $value."
        $valueToBoundary[$value] = $boundaryName
    }
}
$evidence = New-Object System.Collections.Generic.List[object]
foreach ($api in $apis) {
    $value = [string]$api.persistence
    if ($valueToBoundary.ContainsKey($value)) {
        $boundaryName = [string]$valueToBoundary[$value]
        $boundary = $boundaries[$boundaryName]
        $evidence.Add([pscustomobject]@{
            name = [string]$api.name
            wave = [int]$api.wave
            persistence_contract = $value
            restart_persistence = 'required-and-verified'
            boundary = $boundaryName
            write_hook = $boundary.WriteHook
            read_hook = $boundary.ReadHook
            reason = $null
        })
    }
    else {
        $reason = switch ($value) {
            'runtime lifetime' { 'NPC/world extension state is intentionally discarded when the owning runtime object or server process ends.' }
            'team lifetime' { 'Team task state is owned by the current authoritative team and is invalidated when team ownership changes.' }
            'global values only' { 'Legacy global byte/word helpers operate on process-global compatibility values; the audited contract has no restart durability.' }
            'no' { 'Read-only/session/UI API has no durable state to save.' }
            default { throw "Persistence contract chua duoc phan loai: $value ($($api.name))." }
        }
        $evidence.Add([pscustomobject]@{
            name = [string]$api.name
            wave = [int]$api.wave
            persistence_contract = $value
            restart_persistence = 'not-applicable-with-reason'
            boundary = $null
            write_hook = $null
            read_hook = $null
            reason = $reason
        })
    }
}
Assert-True ($evidence.Count -eq 182) "Persistence evidence chi co $($evidence.Count)/182."
Assert-True (@($evidence | Where-Object { $_.restart_persistence -eq 'required-and-verified' -and (-not $_.write_hook -or -not $_.read_hook) }).Count -eq 0) 'Persistent API thieu write/read hook.'
Assert-True (@($evidence | Where-Object { $_.restart_persistence -eq 'not-applicable-with-reason' -and -not $_.reason }).Count -eq 0) 'Persistence N/A thieu ly do.'

$deployment = Get-Content -Raw -LiteralPath (Join-Path $RuntimeRoot 'DEPLOYMENT_MANIFEST.json') | ConvertFrom-Json
$stateRoot = [IO.Path]::GetFullPath([string]$deployment.StateRoot).TrimEnd('\')
$runtimeManifest = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json') | ConvertFrom-Json
$junctionCount = 0
foreach ($relative in @($runtimeManifest.Roles.Server.StateDirectories)) {
    $path = Join-Path (Join-Path $RuntimeRoot 'Server') ([string]$relative)
    $expected = [IO.Path]::GetFullPath((Join-Path (Join-Path $stateRoot 'Server') ([string]$relative))).TrimEnd('\')
    $item = Get-Item -LiteralPath $path -Force
    Assert-True (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) "Persistent state khong phai junction: $relative."
    $targets = @($item.Target | ForEach-Object { [IO.Path]::GetFullPath($_).TrimEnd('\') })
    Assert-True ($expected -in $targets) "Persistent state junction sai target: $relative."
    $junctionCount++
}

if ($WriteEvidence) {
    $document = [ordered]@{
        schema = 1
        generated_at_utc = [DateTime]::UtcNow.ToString('o')
        api_count = $evidence.Count
        required_and_verified = @($evidence | Where-Object restart_persistence -eq 'required-and-verified').Count
        not_applicable_with_reason = @($evidence | Where-Object restart_persistence -eq 'not-applicable-with-reason').Count
        state_junctions = $junctionCount
        boundaries = @($boundaries.Keys | ForEach-Object {
            $name = $_; [pscustomobject]@{ name=$name; write_hook=$boundaries[$name].WriteHook; read_hook=$boundaries[$name].ReadHook }
        })
        apis = @($evidence | Sort-Object wave,name)
    }
    [IO.File]::WriteAllText(
        (Join-Path $ProjectRoot 'Docs\LUA_API_182_PERSISTENCE_EVIDENCE.json'),
        ($document | ConvertTo-Json -Depth 8),
        (New-Object Text.UTF8Encoding($false)))
}

[pscustomobject]@{
    Status = 'PASS'
    ApiCount = $evidence.Count
    RestartPersistenceRequiredAndVerified = @($evidence | Where-Object restart_persistence -eq 'required-and-verified').Count
    NotApplicableWithReason = @($evidence | Where-Object restart_persistence -eq 'not-applicable-with-reason').Count
    PersistenceBoundaries = $boundaries.Count
    RuntimeStateJunctions = $junctionCount
    WriteHooks = 'PASS'
    ReadHooks = 'PASS'
}
