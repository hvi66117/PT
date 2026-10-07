[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [switch]$WriteEvidence
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Get-Sha256Text([string]$Text) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($Text)))).Replace('-', '') }
    finally { $sha.Dispose() }
}
function Get-FunctionBody([string]$FunctionName, [hashtable]$SourceTexts) {
    $pattern = '(?m)\b(?:static\s+)?int\s+' + [regex]::Escape($FunctionName) + '\s*\(\s*Lua_State\s*\*\s*\w+\s*\)\s*\{'
    foreach ($path in $SourceTexts.Keys) {
        $text = $SourceTexts[$path]
        $match = [regex]::Match($text, $pattern)
        if (-not $match.Success) { continue }
        $open = $match.Index + $match.Length - 1
        $depth = 0; $state = 'code'
        for ($index = $open; $index -lt $text.Length; $index++) {
            $character = $text[$index]
            $next = if ($index + 1 -lt $text.Length) { $text[$index + 1] } else { [char]0 }
            if ($state -eq 'line') { if ($character -eq "`n") { $state = 'code' }; continue }
            if ($state -eq 'block') { if ($character -eq '*' -and $next -eq '/') { $index++; $state = 'code' }; continue }
            if ($state -eq 'string') { if ($character -eq '\') { $index++; continue }; if ($character -eq '"') { $state = 'code' }; continue }
            if ($state -eq 'char') { if ($character -eq '\') { $index++; continue }; if ($character -eq "'") { $state = 'code' }; continue }
            if ($character -eq '/' -and $next -eq '/') { $index++; $state = 'line'; continue }
            if ($character -eq '/' -and $next -eq '*') { $index++; $state = 'block'; continue }
            if ($character -eq '"') { $state = 'string'; continue }
            if ($character -eq "'") { $state = 'char'; continue }
            if ($character -eq '{') { $depth++ }
            elseif ($character -eq '}') {
                $depth--
                if ($depth -eq 0) {
                    return [pscustomobject]@{ Path=$path; Body=$text.Substring($open + 1, $index - $open - 1) }
                }
            }
        }
        throw "Khong tim thay cuoi implementation $FunctionName."
    }
    return $null
}

$catalog = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis)
Assert-True ($apis.Count -eq 182) "Completion evidence nhan $($apis.Count)/182 API."
$binary = & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinaryRegistry.ps1') -ProjectRoot $ProjectRoot
$smoke = & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinarySmoke.ps1') -ProjectRoot $ProjectRoot `
    -ServerRoot (Join-Path $RuntimeRoot 'Server')
& (Join-Path $ProjectRoot 'Tests\Test-LuaApiProtocolBoundaries.ps1') -ProjectRoot $ProjectRoot -WriteEvidence | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-LuaApiPersistenceBoundaries.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot -WriteEvidence | Out-Null
$protocol = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_PROTOCOL_EVIDENCE.json') | ConvertFrom-Json
$persistence = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_PERSISTENCE_EVIDENCE.json') | ConvertFrom-Json
$protocolByName = @{}; foreach ($entry in @($protocol.apis)) { $protocolByName[[string]$entry.name] = $entry }
$persistenceByName = @{}; foreach ($entry in @($persistence.apis)) { $persistenceByName[[string]$entry.name] = $entry }
$binaryByName = @{}; foreach ($entry in @($binary.CampaignRegistrations)) { $binaryByName[[string]$entry.Name] = $entry }

$latin1 = [Text.Encoding]::GetEncoding(28591)
$sourceFiles = @((Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')) + @(
    Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src') -Filter 'PhongThanLuaWave*.h' -File |
        Sort-Object Name | ForEach-Object FullName)
$sourceTexts = @{}
foreach ($path in $sourceFiles) { $sourceTexts[$path] = $latin1.GetString([IO.File]::ReadAllBytes($path)) }
$registrationSource = $sourceTexts[(Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')]
$evidence = New-Object System.Collections.Generic.List[object]
foreach ($api in $apis) {
    $name = [string]$api.name
    Assert-True (@($api.call_forms).Count -gt 0 -and [int]$api.extracted_call_count -gt 0) "$name thieu signature/call-form evidence."
    Assert-True ([string]$api.contract_status -ne 'data-contract-recovery-required') "$name con data contract blocker."
    Assert-True (-not [string]::IsNullOrWhiteSpace([string]$api.data_contract)) "$name thieu data contract."
    Assert-True (-not [string]::IsNullOrWhiteSpace([string]$api.state_owner)) "$name thieu authoritative state owner."
    $registration = [regex]::Matches($registrationSource, '\{"' + [regex]::Escape($name) + '"\s*,\s*(?<function>\w+)\s*\}')
    Assert-True ($registration.Count -eq 1) "$name co $($registration.Count) source registration."
    $functionName = $registration[0].Groups['function'].Value
    $definition = Get-FunctionBody $functionName $sourceTexts
    Assert-True ($null -ne $definition) "$name thieu implementation $functionName."
    $normalizedBody = [regex]::Replace([regex]::Replace($definition.Body, '(?s)/\*.*?\*/|//[^\r\n]*', ''), '\s+', '')
    Assert-True ($normalizedBody.Length -ge 20) "$name co implementation qua ngan."
    $binaryEntry = $binaryByName[$name]
    $protocolEntry = $protocolByName[$name]
    $persistenceEntry = $persistenceByName[$name]
    Assert-True ($null -ne $binaryEntry -and $null -ne $protocolEntry -and $null -ne $persistenceEntry) "$name thieu binary/protocol/persistence evidence."
    $callFormLines = @($api.call_forms | ForEach-Object { [string]$_.form } | Sort-Object)
    $evidence.Add([pscustomobject]@{
        name = $name
        wave = [int]$api.wave
        subsystem = [string]$api.subsystem
        signature = [pscustomobject]@{
            extracted_calls = [int]$api.extracted_call_count
            call_form_count = $callFormLines.Count
            call_forms_sha256 = Get-Sha256Text ($callFormLines -join "`n")
        }
        data = [pscustomobject]@{
            contract_status = [string]$api.contract_status
            contract = [string]$api.data_contract
            source_tiers = @($api.source_tiers)
        }
        state = [pscustomobject]@{ authoritative_owner = [string]$api.state_owner }
        implementation = [pscustomobject]@{
            native_symbol = $functionName
            source = $definition.Path.Substring($ProjectRoot.Length + 1)
            body_sha256 = Get-Sha256Text $normalizedBody
            binary_rva = [string]$binaryEntry.FunctionRva
            binary_section = [string]$binaryEntry.Section
            binary_sha256 = [string]$binary.BinarySha256
        }
        persistence = $persistenceEntry
        protocol_ui = $protocolEntry
        tests = [pscustomobject]@{
            contract_regression = "Tests\\Test-LuaApiWave$($api.wave).ps1"
            binary_registry = 'Tests\\Test-LuaApiBinaryRegistry.ps1'
            dynamic_abi = 'Tests\\Test-LuaApiBinarySmoke.ps1'
            dynamic_result = 'PASS: one audited fail-closed call through the real x86 Lua ABI'
        }
    })
}
Assert-True ($evidence.Count -eq 182) "Completion evidence chi co $($evidence.Count)/182."
Assert-True (@($evidence.name | Sort-Object -Unique).Count -eq 182) 'Completion evidence trung API.'
Assert-True ($smoke.DynamicAbiCalls -eq 182 -and $smoke.SehFailures -eq 0) 'Dynamic ABI evidence khong du 182/182.'

$document = [ordered]@{
    schema = 1
    generated_at_utc = [DateTime]::UtcNow.ToString('o')
    api_count = $evidence.Count
    binary_sha256 = $binary.BinarySha256
    dynamic_abi_calls = $smoke.DynamicAbiCalls
    dynamic_seh_failures = $smoke.SehFailures
    completion_dimensions = @('signature','data','authoritative-state','persistence','protocol-ui','functional-contract','binary-registration','dynamic-abi')
    apis = @($evidence | Sort-Object wave,name)
}
if ($WriteEvidence) {
    [IO.File]::WriteAllText(
        (Join-Path $ProjectRoot 'Docs\LUA_API_182_COMPLETION_EVIDENCE.json'),
        ($document | ConvertTo-Json -Depth 12),
        (New-Object Text.UTF8Encoding($false)))
}

[pscustomobject]@{
    Status = 'PASS'
    ApiCount = $evidence.Count
    CompletionDimensions = $document.completion_dimensions.Count
    BinaryRegistrations = $binary.CampaignApiCount
    DynamicAbiCalls = $smoke.DynamicAbiCalls
    DynamicSehFailures = $smoke.SehFailures
    ProtocolEvidence = $protocol.api_count
    PersistenceEvidence = $persistence.api_count
}
