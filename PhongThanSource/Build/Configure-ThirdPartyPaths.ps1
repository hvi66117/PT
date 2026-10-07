[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$encoding = [Text.Encoding]::GetEncoding(28591)
$includeToken = '/I "../../../ThirdParty/WindowsSDK/GDIPlus/Include"'
$compatToken = '/FI"../../../ThirdParty/WindowsSDK/GDIPlus/Include/GdiPlusVc6Compat.h"'
$libToken = '/libpath:"../../../ThirdParty/WindowsSDK/GDIPlus/Lib/x86"'
$dxIncludeToken = '/I "../../../ThirdParty/dx9csdk/Include"'
$dxLibToken = '/libpath:"../../../ThirdParty/dx9csdk/Lib"'
$files = @(
    'Sources\Represent\Represent2\Represent2.dsp',
    'Sources\Represent\Represent3\Represent3.dsp',
    'Sources\Represent\Represent3\Represent3 1234.dsp'
)
$changed = New-Object System.Collections.Generic.List[string]

foreach ($relative in $files) {
    $path = Join-Path $ProjectRoot $relative
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $text = $encoding.GetString([IO.File]::ReadAllBytes($path))
    $isRepresent3 = $relative -like 'Sources\Represent\Represent3\*'
    $updated = [regex]::Replace($text, '(?m)^(# ADD CPP[^\r\n]*)(\r?)$', {
        param($match)
        $line = $match.Groups[1].Value
        if ($line -notlike "*$includeToken*") { $line = "$line $includeToken" }
        if ($line -notlike "*$compatToken*") { $line = "$line $compatToken" }
        if ($isRepresent3 -and $line -notlike "*$dxIncludeToken*") { $line = "$line $dxIncludeToken" }
        return "$line$($match.Groups[2].Value)"
    })
    $updated = [regex]::Replace($updated, '(?mi)^(# ADD LINK32[^\r\n]*GdiPlus\.lib[^\r\n]*)(\r?)$', {
        param($match)
        $line = $match.Groups[1].Value
        if ($line -notlike "*$libToken*") { $line = "$line $libToken" }
        if ($isRepresent3 -and $line -notlike "*$dxLibToken*") { $line = "$line $dxLibToken" }
        return "$line$($match.Groups[2].Value)"
    })
    if ($updated -ne $text) {
        if ($PSCmdlet.ShouldProcess($path, 'Add vendored third-party include and lib paths')) {
            [IO.File]::WriteAllBytes($path, $encoding.GetBytes($updated))
        }
        $changed.Add($relative)
    }
}

$utilityRelative = 'Sources\Represent\iRepresent\RepresentUtility.cpp'
$utilityPath = Join-Path $ProjectRoot $utilityRelative
$utilityText = $encoding.GetString([IO.File]::ReadAllBytes($utilityPath))
$guidMarker = 'PHONGTHAN_VC6_ENCODER_QUALITY'
if ($utilityText -notlike "*$guidMarker*") {
    $needle = "using namespace Gdiplus;`r`n"
    $definition = @"
using namespace Gdiplus;

// PHONGTHAN_VC6_ENCODER_QUALITY: the current SDK declares this GUID, while
// the VC6-compatible import library contains functions only.
namespace Gdiplus
{
extern "C" const GUID EncoderQuality =
    { 0x1d5be4b5, 0xfa4a, 0x452d, { 0x9c, 0xdd, 0x5d, 0xb3, 0x51, 0x05, 0xe7, 0xeb } };
}
"@ -replace "`n", "`r`n"
    if (-not $utilityText.Contains($needle)) { throw "Khong tim thay diem chen trong $utilityRelative" }
    $utilityText = $utilityText.Replace($needle, $definition + "`r`n")
    if ($PSCmdlet.ShouldProcess($utilityPath, 'Define EncoderQuality GUID for VC6')) {
        [IO.File]::WriteAllBytes($utilityPath, $encoding.GetBytes($utilityText))
    }
    $changed.Add($utilityRelative)
}

[pscustomobject]@{ ChangedCount=$changed.Count; ChangedFiles=$changed }
