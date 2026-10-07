[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ServerRoot,
    [string]$RunnerPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $ServerRoot) { $ServerRoot = Join-Path $ProjectRoot 'Output\Server' }
if (-not $RunnerPath) { $RunnerPath = Join-Path $ProjectRoot 'Output\Tools\LuaApiBinarySmoke.exe' }
$ServerRoot = [IO.Path]::GetFullPath($ServerRoot).TrimEnd('\')
$RunnerPath = [IO.Path]::GetFullPath($RunnerPath)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

$requiredDlls = @('CoreServer.dll', 'LuaLibDll.dll', 'Engine.dll')
foreach ($name in $requiredDlls) {
    Assert-True (Test-Path -LiteralPath (Join-Path $ServerRoot $name) -PathType Leaf) "Smoke server root thieu $name."
}
if (-not (Test-Path -LiteralPath $RunnerPath -PathType Leaf)) {
    & (Join-Path $ProjectRoot 'Build\Build-LuaApiBinarySmoke.ps1') -ProjectRoot $ProjectRoot -OutputPath $RunnerPath | Out-Null
}

$binary = & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinaryRegistry.ps1') `
    -ProjectRoot $ProjectRoot -DllPath (Join-Path $ServerRoot 'CoreServer.dll') `
    -MapPath (Join-Path $ProjectRoot 'Output\Server\CoreServer.map')
$catalog = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$registrationByName = @{}
foreach ($entry in @($binary.CampaignRegistrations)) { $registrationByName[[string]$entry.Name] = $entry }

$runId = [guid]::NewGuid().ToString('N')
$fixturePath = Join-Path ([IO.Path]::GetTempPath()) ("phongthan-lua-api-smoke-{0}.tsv" -f $runId)
$isolatedRunnerPath = Join-Path $ServerRoot ("LuaApiBinarySmoke-{0}.exe" -f $runId)
try {
    # Windows resolves dependent DLLs from the executable directory first.
    # Run beside the target Core/Engine pair so a stale Output\Tools\Engine.dll
    # cannot invalidate the smoke result.
    Copy-Item -LiteralPath $RunnerPath -Destination $isolatedRunnerPath -Force
    $lines = New-Object System.Collections.Generic.List[string]
    foreach ($api in @($catalog.apis | Sort-Object wave, name)) {
        $forms = @($api.call_forms | Sort-Object @{Expression={ [int]($_.form.Split(':')[0]) }}, form)
        Assert-True ($forms.Count -gt 0) "API $($api.name) khong co call form."
        $form = [string]$forms[0].form
        $firstColon = $form.IndexOf(':')
        $lastColon = $form.LastIndexOf(':')
        $kinds = if ($lastColon -gt $firstColon) { $form.Substring($firstColon + 1, $lastColon - $firstColon - 1) } else { '' }
        if ($api.name -eq 'pcall') { $kinds = 'function' }
        elseif ($api.name -eq 'ipairs') { $kinds = 'table' }
        else {
            $normalized = foreach ($kind in @($kinds.Split(',') | Where-Object { $_ })) {
                if ($kind -in @('string', 'table', 'nil', 'function')) { $kind } else { 'number' }
            }
            $kinds = $normalized -join ','
        }
        $entry = $registrationByName[[string]$api.name]
        Assert-True ($null -ne $entry) "Khong co binary registration cho $($api.name)."
        $lines.Add("$($api.name)`t$($entry.FunctionRva)`t$kinds")
    }
    [IO.File]::WriteAllLines($fixturePath, $lines, (New-Object Text.UTF8Encoding($false)))
    $output = @(& $isolatedRunnerPath $ServerRoot $fixturePath 2>&1)
    $exitCode = $LASTEXITCODE
    $failures = @($output | Where-Object { $_ -like 'FAIL*' -or $_ -like 'ERROR*' })
    $passes = @($output | Where-Object { $_ -like 'PASS*' })
    $summary = @($output | Where-Object { $_ -like 'SUMMARY*' })
    Assert-True ($exitCode -eq 0) "Native Lua API smoke that bai ($exitCode): $($failures -join '; ')"
    Assert-True ($failures.Count -eq 0) "Native Lua API smoke co failure: $($failures -join '; ')"
    Assert-True ($passes.Count -eq 182) "Native Lua API smoke chi PASS $($passes.Count)/182."
    Assert-True ($summary.Count -eq 1 -and $summary[0] -match '^SUMMARY\s+182\s+182\s+0$') "Native smoke summary sai: $($summary -join '; ')"
}
finally {
    Remove-Item -LiteralPath $fixturePath -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $isolatedRunnerPath -Force -ErrorAction SilentlyContinue
}

[pscustomobject]@{
    Status = 'PASS'
    DynamicAbiCalls = $passes.Count
    SehFailures = 0
    CoreServerSha256 = $binary.BinarySha256
    RunnerSha256 = (Get-FileHash -LiteralPath $RunnerPath -Algorithm SHA256).Hash
    FixturePolicy = 'minimum audited call form; fail-closed zero/empty values; pcall=function; ipairs=table'
}
