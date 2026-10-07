[CmdletBinding()]
param(
    [string[]]$Targets = @(
        'Engine', 'LuaLibDll', 'Common', 'ExpandPackageStaticLib',
        'FilterTextStatic', 'CoreServer', 'CoreClient', 'ExpandPackage',
        'FilterText', 'Heaven', 'Rainbow', 'Represent2', 'Represent3',
        'GameClient', 'AccountServer', 'PhongThanRelay', 'Bishop', 'Goddess',
        'GameServer'
    ),
    [int]$Jobs = 0,
    [switch]$Clean,
    [switch]$KeepGoing
)
# Builds the VC6 projects (.dsp) with the Visual Studio 2022 Build Tools (MSVC v143, x86).
# ASCII only. Reads each project's "Release" configuration from the .dsp (compiler/linker
# flags, sources, per-file exclusions and defines), translates VC6 flags, and writes every
# object and binary under Sources\<project>\Modern\<config> and PhongThanSource\OutputModern.
# The VC6 artifacts in Output\ and Sources\*\Release are never touched.
$ErrorActionPreference = 'Stop'
$root = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot))
$outRoot = Join-Path $root 'OutputModern'
$outLib = Join-Path $outRoot 'lib'
$logRoot = Join-Path $root 'Build\LogsModern'
New-Item -ItemType Directory -Force -Path (Join-Path $outRoot 'Client'), (Join-Path $outRoot 'Server'), $outLib, $logRoot | Out-Null
if ($Jobs -le 0) { $Jobs = [Environment]::ProcessorCount }

# ------------------------------------------------------------------ toolchain
function Import-VsEnvironment {
    $vswhere = Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio\Installer\vswhere.exe'
    if (-not (Test-Path -LiteralPath $vswhere)) { throw 'Chua cai Visual Studio Build Tools (thieu vswhere.exe).' }
    $vs = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
    if (-not $vs) { throw 'Khong tim thay MSVC x86/x64 trong Visual Studio Build Tools.' }
    $bat = Join-Path $vs 'VC\Auxiliary\Build\vcvarsall.bat'
    # vcvarsall calls vswhere.exe by name; without it on PATH it prints to stderr, which
    # Windows PowerShell 5.1 turns into a terminating error under 'Stop'.
    $env:PATH = (Split-Path -Parent $vswhere) + ';' + $env:PATH
    $lines = & cmd.exe /c "`"$bat`" x86 >nul && set"
    foreach ($l in $lines) {
        $i = $l.IndexOf('=')
        if ($i -gt 0) { [Environment]::SetEnvironmentVariable($l.Substring(0, $i), $l.Substring($i + 1), 'Process') }
    }
    if (-not (Get-Command cl.exe -ErrorAction SilentlyContinue)) { throw 'vcvarsall khong dat duoc cl.exe vao PATH.' }
}
Import-VsEnvironment
$gdiInclude = Join-Path $root 'ThirdParty\WindowsSDK\GDIPlus\Include'
$gdiLib = Join-Path $root 'ThirdParty\WindowsSDK\GDIPlus\Lib\x86'
$dxInclude = Join-Path $root 'ThirdParty\dx9csdk\Include'
$dxLib = Join-Path $root 'ThirdParty\dx9csdk\Lib'
# Project headers first; the old DX9 SDK after the Windows SDK so d3d9.h/dsound.h match the libs.
$env:INCLUDE = "$gdiInclude;$($env:INCLUDE);$dxInclude"
$env:LIB = "$outLib;$gdiLib;$($env:LIB);$dxLib"
# Only the Spectre-mitigated ATL may be installed (atlmfc\lib\spectre\x86); use it when lib\x86 is absent.
if ($env:VCToolsInstallDir) {
    $atlLib = Join-Path $env:VCToolsInstallDir 'atlmfc\lib\x86'
    $atlSpectre = Join-Path $env:VCToolsInstallDir 'atlmfc\lib\spectre\x86'
    if (-not (Test-Path -LiteralPath (Join-Path $atlLib 'atls.lib')) -and (Test-Path -LiteralPath (Join-Path $atlSpectre 'atls.lib'))) { $env:LIB = "$env:LIB;$atlSpectre" }
    $atlInc = Join-Path $env:VCToolsInstallDir 'atlmfc\include'
    if ((Test-Path -LiteralPath $atlInc) -and ($env:INCLUDE -notlike "*$atlInc*")) { $env:INCLUDE = "$env:INCLUDE;$atlInc" }
}

# ------------------------------------------------------------------ projects
$projects = [ordered]@{
    Engine = @{ Dsp = 'Sources\Engine\Engine.dsp'; Cfg = 'Engine - Win32 Release'; Roles = 'Client', 'Server' }
    LuaLibDll = @{ Dsp = 'Sources\Library\LuaLib\LuaLibDll.dsp'; Cfg = 'LuaLibDll - Win32 Release'; Roles = 'Client', 'Server' }
    Common = @{ Dsp = 'Sources\MultiServer\Common\Common.dsp'; Cfg = 'Common - Win32 Release'; Roles = @() }
    ExpandPackageStaticLib = @{ Dsp = 'Sources\ExpandPackageStaticLib\ExpandPackageStaticLib.dsp'; Cfg = 'ExpandPackageStaticLib - Win32 Release'; Roles = @() }
    FilterTextStatic = @{ Dsp = 'Sources\FilterText\FilterText_StaticLib.dsp'; Cfg = 'FilterText_StaticLib - Win32 Release'; Roles = @() }
    CoreServer = @{ Dsp = 'Sources\Core\Core.dsp'; Cfg = 'Core - Win32 Server Release'; Roles = 'Server' }
    CoreClient = @{ Dsp = 'Sources\Core\Core.dsp'; Cfg = 'Core - Win32 Client Release'; Roles = 'Client' }
    ExpandPackage = @{ Dsp = 'Sources\ExpandPackage2.0\ExpandPackage.dsp'; Cfg = 'ExpandPackage - Win32 Release'; Roles = 'Client', 'Server' }
    FilterText = @{ Dsp = 'Sources\FilterText\FilterText.dsp'; Cfg = 'FilterText - Win32 Release'; Roles = 'Client', 'Server' }
    Heaven = @{ Dsp = 'Sources\MultiServer\Heaven\Heaven.dsp'; Cfg = 'Heaven - Win32 Release'; Roles = 'Client', 'Server' }
    Rainbow = @{ Dsp = 'Sources\MultiServer\Rainbow\Rainbow.dsp'; Cfg = 'Rainbow - Win32 Release'; Roles = 'Client', 'Server' }
    Represent2 = @{ Dsp = 'Sources\Represent\Represent2\Represent2.dsp'; Cfg = 'Represent2 - Win32 Release'; Roles = 'Client' }
    Represent3 = @{ Dsp = 'Sources\Represent\Represent3\Represent3.dsp'; Cfg = 'Represent3 - Win32 Release'; Roles = 'Client' }
    GameClient = @{ Dsp = 'Sources\GameClient\PhongThanClient.dsp'; Cfg = 'PhongThanClient - Win32 Release'; Roles = 'Client' }
    AccountServer = @{ Dsp = 'Sources\AccountServices\AccountServer\PhongThanAccountServer.dsp'; Cfg = 'PhongThanAccountServer - Win32 Release'; Roles = 'Server' }
    PhongThanRelay = @{ Dsp = 'Sources\MultiServer\PhongThanRelay\PhongThanRelay.dsp'; Cfg = 'PhongThanRelay - Win32 Release'; Roles = 'Server' }
    Bishop = @{ Dsp = 'Sources\MultiServer\Bishop\Bishop.dsp'; Cfg = 'Bishop - Win32 Release'; Roles = 'Server' }
    Goddess = @{ Dsp = 'Sources\MultiServer\Goddess\Goddess.dsp'; Cfg = 'Goddess - Win32 Release'; Roles = 'Server' }
    GameServer = @{ Dsp = 'Sources\MultiServer\GameServer\GameServer.dsp'; Cfg = 'GameServer - Win32 Release'; Roles = 'Server' }
}

# ------------------------------------------------------------------ .dsp parsing
function Split-Args([string]$s) {
    $r = New-Object Collections.Generic.List[string]
    $cur = ''; $q = $false; $has = $false
    foreach ($ch in $s.ToCharArray()) {
        if ($ch -eq '"') { $q = -not $q; $has = $true; continue }
        if (-not $q -and [char]::IsWhiteSpace($ch)) { if ($has) { $r.Add($cur); $cur = ''; $has = $false }; continue }
        $cur += $ch; $has = $true
    }
    if ($has) { $r.Add($cur) }
    return , $r.ToArray()
}

# Text of the !IF/!ELSEIF branch for $cfg inside $text (empty if none).
function Get-CfgBranch([string]$text, [string]$cfg) {
    $marker = '"$(CFG)" == "' + $cfg + '"'
    $i = $text.IndexOf($marker)
    if ($i -lt 0) { return $null }
    $i = $text.IndexOf("`n", $i) + 1
    $m = [regex]::Match($text.Substring($i), '(?m)^!(ELSEIF|ENDIF)')
    if ($m.Success) { return $text.Substring($i, $m.Index) }
    return $text.Substring($i)
}

function Read-Dsp([string]$path, [string]$cfg) {
    $text = [IO.File]::ReadAllText($path, [Text.Encoding]::GetEncoding(28591)).Replace("`r`n", "`n")
    $p = @{ Dir = Split-Path -Parent $path; Kind = 'exe'; Cpp = ''; Link = ''; Lib = ''; Rsc = ''; Files = New-Object Collections.Generic.List[object] }
    if ($text -match 'TARGTYPE "Win32 \(x86\) Dynamic-Link Library"') { $p.Kind = 'dll' }
    elseif ($text -match 'TARGTYPE "Win32 \(x86\) Static Library"') { $p.Kind = 'lib' }
    $head = $text.Substring(0, [Math]::Max(0, $text.IndexOf('# Begin Target')))
    $b = Get-CfgBranch $head $cfg
    if ($null -eq $b) { throw "Khong thay cau hinh '$cfg' trong $path" }
    foreach ($l in $b -split "`n") {
        if ($l -match '^# ADD CPP (.*)$') { $p.Cpp = $Matches[1] }
        elseif ($l -match '^# ADD LINK32 (.*)$') { $p.Link = $Matches[1] }
        elseif ($l -match '^# ADD LIB32 (.*)$') { $p.Lib = $Matches[1] }
        elseif ($l -match '^# ADD RSC (.*)$') { $p.Rsc = $Matches[1] }
    }
    foreach ($m in [regex]::Matches($text, '(?s)# Begin Source File\n(.*?)# End Source File')) {
        $body = $m.Groups[1].Value
        if ($body -notmatch '(?m)^SOURCE=(.+)$') { continue }
        $src = $Matches[1].Trim().Trim('"')
        $fb = Get-CfgBranch $body $cfg
        $excluded = $false; $extra = ''
        if ($null -ne $fb) {
            if ($fb -match '(?m)^# PROP Exclude_From_Build 1') { $excluded = $true }
            if ($fb -match '(?m)^# ADD CPP (.*)$') { $extra = $Matches[1] }
        } elseif ($body -match '(?m)^# PROP Exclude_From_Build 1' -and $body -notmatch '!IF') { $excluded = $true }
        if ($excluded) { continue }
        $p.Files.Add([pscustomobject]@{ Src = $src; Extra = $extra })
    }
    return $p
}

# ------------------------------------------------------------------ flag translation
$common = @('/nologo', '/c', '/EHsc', '/Zc:forScope-', '/Zc:wchar_t-', '/Zc:strictStrings-', '/Zc:threadSafeInit-',
    '/permissive', '/W1', '/wd4996', '/wd4700', '/Zi', '/Oy-', '/GS-', '/FS',
    '/D_CRT_SECURE_NO_WARNINGS', '/D_CRT_NONSTDC_NO_DEPRECATE', '/D_WINSOCK_DEPRECATED_NO_WARNINGS',
    '/D_USE_32BIT_TIME_T', '/D_CRT_NO_VA_START_VALIDATION', '/DPHONGTHAN_MODERN_BUILD=1',
    # windows.h would pull the old winsock.h before the sources' winsock2.h (sockaddr/fd_set redefinitions)
    '/D_WINSOCKAPI_',
    # VC6-era classes declare operator delete(void*, size_t) next to placement new (error C2956)
    '/Zc:sizedDealloc-')

function Convert-Cpp([string[]]$tokens, [string]$projDir) {
    $out = New-Object Collections.Generic.List[string]
    for ($i = 0; $i -lt $tokens.Count; $i++) {
        $t = $tokens[$i]
        switch -regex ($t) {
            '^/(I|D|U)$' { $out.Add($t + $tokens[$i + 1]); $i++; continue }
            '^/I(.+)$' { $out.Add($t); continue }
            '^/(D|U).+$' { $out.Add($t); continue }
            '^/M(T|D)d?$' { $out.Add($t); continue }
            '^/O[12xsdtgiby]+$' { $out.Add($t); continue }
            '^/Zp\d*$' { $out.Add($t); continue }
            '^/J$' { $out.Add($t); continue }
            '^/(nologo|c|GX|GR|W\d|WX|YX|FD|FR|Fr|ZI|Zi|Z7|Gm|GZ|G[3-7B]|Gy|Gf|GF|Oy)$' { continue }
            '^/(Y[cuX]|Fp|Fo|Fd|Fa|FR|Fr).*$' { continue }
            default { if ($t.StartsWith('/')) { Write-Verbose "cl bo co: $t" } }
        }
    }
    return , $out.ToArray()
}

# ------------------------------------------------------------------ build one project
function Invoke-Tool([string]$exe, [string[]]$argv, [string]$log, [string]$cwd) {
    $rsp = [IO.Path]::GetTempFileName()
    # Quote arguments with spaces; double trailing backslashes so "/Fo<dir>\" keeps its closing quote
    # (the project path contains spaces, e.g. "Phong than").
    [IO.File]::WriteAllText($rsp, (($argv | ForEach-Object { if ($_ -match '\s') { '"' + ($_ -replace '(\\+)$', '$1$1') + '"' } else { $_ } }) -join "`r`n"), [Text.Encoding]::ASCII)
    Push-Location $cwd
    # Windows PowerShell 5.1 turns native stderr lines (cl warnings) into terminating errors under
    # $ErrorActionPreference = 'Stop'; only the exit code decides success here.
    $oldEap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
    # rc.exe has no response-file support; pass its (short) argument list directly.
    try { if ($exe -eq 'rc.exe') { $o = & $exe @argv 2>&1 | ForEach-Object { "$_" } } else { $o = & $exe "@$rsp" 2>&1 | ForEach-Object { "$_" } }; $code = $LASTEXITCODE } finally { $ErrorActionPreference = $oldEap; Pop-Location; Remove-Item -LiteralPath $rsp -Force }
    Add-Content -LiteralPath $log -Value ("> $exe " + ($argv -join ' ')) -Encoding UTF8
    Add-Content -LiteralPath $log -Value ($o | ForEach-Object { "$_" }) -Encoding UTF8
    return @{ Code = $code; Out = $o }
}

function Build-Project([string]$name) {
    $def = $projects[$name]
    $dsp = Join-Path $root $def.Dsp
    $p = Read-Dsp $dsp $def.Cfg
    $cfgTag = ($def.Cfg -split ' - ')[1] -replace '[^A-Za-z0-9]', ''
    $work = Join-Path $p.Dir "Modern\$cfgTag"
    if ($Clean -and (Test-Path -LiteralPath $work)) { Remove-Item -LiteralPath $work -Recurse -Force }
    New-Item -ItemType Directory -Force -Path $work | Out-Null
    $log = Join-Path $logRoot "$name.log"
    Set-Content -LiteralPath $log -Value "== $name $(Get-Date -Format s)" -Encoding UTF8

    $baseFlags = Convert-Cpp (Split-Args $p.Cpp) $p.Dir
    # Bishop's headers already declare HMONITOR, so the DX9 ddraw.h must not redeclare it (C2011).
    # Core keeps _WIN32_WINNT 0x0400 (no HMONITOR in windef.h) and needs ddraw.h's own declaration.
    if ($name -eq 'Bishop') { $baseFlags = @($baseFlags) + '/DHMONITOR_DECLARED' }
    $objs = New-Object Collections.Generic.List[string]
    $seen = @{}
    $groups = @{}
    $res = New-Object Collections.Generic.List[string]
    $srcLibs = New-Object Collections.Generic.List[string]
    $defFile = $null
    foreach ($f in $p.Files) {
        $src = [IO.Path]::GetFullPath((Join-Path $p.Dir $f.Src))
        $ext = [IO.Path]::GetExtension($src).ToLowerInvariant()
        if ($ext -eq '.rc') { $res.Add($src); continue }
        if ($ext -eq '.def') { $defFile = $src; continue }
        # VC6 links every .lib listed as a project source file (e.g. Engine.dsp lists LuaLibDll.lib);
        # prefer the import library rebuilt by this script when one with the same name exists.
        if ($ext -eq '.lib') {
            $modernLib = Join-Path $outLib ([IO.Path]::GetFileName($src))
            $srcLibs.Add($(if (Test-Path -LiteralPath $modernLib) { $modernLib } else { $src }))
            continue
        }
        if ($ext -notin '.c', '.cpp', '.cxx', '.cc') { continue }
        if (-not (Test-Path -LiteralPath $src)) { Add-Content $log "THIEU FILE: $src"; continue }
        $base = [IO.Path]::GetFileNameWithoutExtension($src).ToLowerInvariant()
        $n = 0; $objName = $base
        while ($seen.ContainsKey($objName)) { $n++; $objName = "$base`_$n" }
        $seen[$objName] = 1
        $obj = Join-Path $work "$objName.obj"
        $objs.Add($obj)
        $extra = Convert-Cpp (Split-Args $f.Extra) $p.Dir
        $key = ($extra -join ' ') + '|' + ($(if ($objName -ne $base) { $objName } else { '' }))
        if (-not $groups.ContainsKey($key)) { $groups[$key] = @{ Extra = $extra; Files = New-Object Collections.Generic.List[object] } }
        $groups[$key].Files.Add(@{ Src = $src; Obj = $obj; Unique = ($objName -ne $base) })
    }
    $failed = $false
    foreach ($g in $groups.Values) {
        $single = @($g.Files | Where-Object { $_.Unique })
        $multi = @($g.Files | Where-Object { -not $_.Unique })
        if ($multi.Count) {
            $argv = @($common) + $baseFlags + $g.Extra + @("/MP$Jobs", "/Fo$work\", "/Fd$work\vc143.pdb") + ($multi | ForEach-Object { $_.Src })
            $r = Invoke-Tool 'cl.exe' $argv $log $p.Dir
            if ($r.Code -ne 0) { $failed = $true }
        }
        foreach ($s in $single) {
            $argv = @($common) + $baseFlags + $g.Extra + @("/Fo$($s.Obj)", "/Fd$work\vc143.pdb", $s.Src)
            $r = Invoke-Tool 'cl.exe' $argv $log $p.Dir
            if ($r.Code -ne 0) { $failed = $true }
        }
    }
    foreach ($rc in $res) {
        $resOut = Join-Path $work ([IO.Path]::GetFileNameWithoutExtension($rc) + '.res')
        # VC6 wizard .rc files include MFC's afxres.h; MFC is not installed, the SDK's winres.h has the same defines.
        # Latin1 keeps the GBK bytes of the resource script unchanged.
        $latin1 = [Text.Encoding]::GetEncoding(28591)
        $rcText = [IO.File]::ReadAllText($rc, $latin1)
        $rcSrc = $rc
        if ($rcText -match 'afxres\.h') {
            $rcSrc = Join-Path $work ([IO.Path]::GetFileName($rc))
            [IO.File]::WriteAllText($rcSrc, ($rcText -replace 'afxres\.h', 'winres.h'), $latin1)
        }
        $r = Invoke-Tool 'rc.exe' @('/nologo', '/i', (Split-Path -Parent $rc), '/fo', $resOut, '/d', 'NDEBUG', '/l', '0x804', $rcSrc) $log (Split-Path -Parent $rc)
        if ($r.Code -ne 0) { $failed = $true } else { $objs.Add($resOut) }
    }
    if ($failed) { return @{ Ok = $false; Log = $log; Errors = @(Get-Content $log | Select-String ': (fatal )?error ' | Select-Object -First 40 | ForEach-Object { $_.Line }) } }

    # link / lib
    $outName = $null
    if ($p.Kind -eq 'lib') {
        $tok = Split-Args $p.Lib
        foreach ($t in $tok) { if ($t -match '^/out:(.+)$') { $outName = [IO.Path]::GetFileName($Matches[1]) } }
        if (-not $outName) { $outName = [IO.Path]::GetFileNameWithoutExtension($dsp) + '.lib' }
        $target = Join-Path $work $outName
        $r = Invoke-Tool 'lib.exe' (@('/nologo', "/OUT:$target") + $objs) $log $p.Dir
        if ($r.Code -ne 0) { return @{ Ok = $false; Log = $log; Errors = @($r.Out | Select-Object -Last 20) } }
        Copy-Item -LiteralPath $target -Destination $outLib -Force
        return @{ Ok = $true; Log = $log; Output = $target }
    }
    $largv = New-Object Collections.Generic.List[string]
    $largv.AddRange([string[]]@('/nologo', '/MACHINE:X86', '/SAFESEH:NO', '/DEBUG', '/INCREMENTAL:NO', '/DYNAMICBASE:NO'))
    # The shipped VC6 GameServer.exe was patched large-address-aware: ~5000 per-script Lua states need >2 GB
    # while loading scripts; without it the modern build ran out of memory (AV in LuaLibDll!setnodevector).
    # The VC6 client Game.exe never was (it stays far below 2 GB), so keep its address space unchanged.
    # It also ran without DEP (no NX_COMPAT) next to old third-party client DLLs; keep that too.
    if ($name -ne 'GameClient') { $largv.Add('/LARGEADDRESSAWARE') } else { $largv.AddRange([string[]]@('/LARGEADDRESSAWARE:NO', '/NXCOMPAT:NO')) }
    # VC6 static libraries still name the removed single-threaded CRT (LIBC/LIBCD) as a default library.
    $largv.AddRange([string[]]@('/NODEFAULTLIB:libc.lib', '/NODEFAULTLIB:libcd.lib'))
    # 2026-10-03: ScriptFuns.cpp builds ~23 temporary KMission lookup keys on the stack (~729 KB each);
    # with the 1 MB default the server overflowed in AddMSNpc when Van Tien opened at 18:00.
    if ($name -eq 'GameServer') { $largv.Add('/STACK:16777216') }
    if ($p.Kind -eq 'dll') { $largv.Add('/DLL') }
    foreach ($t in (Split-Args $p.Link)) {
        switch -regex ($t) {
            '^/out:(.+)$' { $outName = [IO.Path]::GetFileName($Matches[1]); continue }
            '^/(nologo|dll|debug|map|incremental:.*|pdbtype:.*|pdb:.*|machine:.*|profile|pdb)$' { continue }
            '^/libpath:(.+)$' { $largv.Add('/LIBPATH:' + [IO.Path]::GetFullPath((Join-Path $p.Dir $Matches[1]))); continue }
            '^/def:(.+)$' { $defFile = [IO.Path]::GetFullPath((Join-Path $p.Dir $Matches[1])); continue }
            '^/(subsystem|base|nodefaultlib|stack|heap|entry|opt|force|delayload|export|section|align|fixed|release|version)(:.*)?$' { $largv.Add($t); continue }
            '\.lib$' {
                # A project library rebuilt by this script (Common.lib, Engine.lib, ...) replaces the VC6 copy
                # named in the .dsp link line; VC6 objects need the old STL (std::_Xlen ...).
                $modernLib = Join-Path $outLib ([IO.Path]::GetFileName($t))
                if (Test-Path -LiteralPath $modernLib) { $srcLibs.Add($modernLib) } else { $largv.Add($t) }
                continue
            }
            default { if ($t.StartsWith('/')) { Add-Content $log "link bo co: $t" } }
        }
    }
    if (-not $outName) { $outName = [IO.Path]::GetFileNameWithoutExtension($dsp) + $(if ($p.Kind -eq 'dll') { '.dll' } else { '.exe' }) }
    $target = Join-Path $work $outName
    $largv.Add("/OUT:$target"); $largv.Add("/MAP:$([IO.Path]::ChangeExtension($target, '.map'))"); $largv.Add("/PDB:$([IO.Path]::ChangeExtension($target, '.pdb'))")
    $largv.Add("/IMPLIB:$([IO.Path]::ChangeExtension($target, '.lib'))")
    if ($defFile) { $largv.Add("/DEF:$defFile") }
    $largv.AddRange([string[]]@('legacy_stdio_definitions.lib', 'legacy_stdio_wide_specifiers.lib'))
    $seenLib = @{}
    foreach ($sl in $srcLibs) { $k = [IO.Path]::GetFileName($sl).ToLowerInvariant(); if (-not $seenLib[$k]) { $seenLib[$k] = 1; $largv.Add($sl) } }
    $largv.AddRange([string[]]$objs)
    $r = Invoke-Tool 'link.exe' $largv.ToArray() $log $p.Dir
    if ($r.Code -ne 0) { return @{ Ok = $false; Log = $log; Errors = @($r.Out | Where-Object { "$_" -match 'error' } | Select-Object -First 40) } }
    $implib = [IO.Path]::ChangeExtension($target, '.lib')
    if (Test-Path -LiteralPath $implib) { Copy-Item -LiteralPath $implib -Destination $outLib -Force }
    foreach ($role in $def.Roles) {
        foreach ($ext in '', '.map', '.pdb') {
            $srcFile = if ($ext) { [IO.Path]::ChangeExtension($target, $ext) } else { $target }
            if (Test-Path -LiteralPath $srcFile) { Copy-Item -LiteralPath $srcFile -Destination (Join-Path $outRoot $role) -Force }
        }
    }
    return @{ Ok = $true; Log = $log; Output = $target }
}

# ------------------------------------------------------------------ main
$summary = New-Object Collections.Generic.List[object]
foreach ($t in $Targets) {
    if (-not $projects.Contains($t)) { throw "Target khong hop le: $t" }
    Write-Host "== $t" -ForegroundColor Cyan
    $sw = [Diagnostics.Stopwatch]::StartNew()
    $r = Build-Project $t
    $summary.Add([pscustomobject]@{ Target = $t; Ok = $r.Ok; Seconds = [int]$sw.Elapsed.TotalSeconds; Log = $r.Log })
    if (-not $r.Ok) {
        Write-Host "LOI $t (xem $($r.Log))" -ForegroundColor Red
        $r.Errors | ForEach-Object { Write-Host "  $_" }
        if (-not $KeepGoing) { break }
    } else { Write-Host "OK  $t -> $($r.Output)" -ForegroundColor Green }
}
$summary | Format-Table -AutoSize | Out-String | Write-Host
if (@($summary | Where-Object { -not $_.Ok }).Count) { exit 1 }
exit 0
