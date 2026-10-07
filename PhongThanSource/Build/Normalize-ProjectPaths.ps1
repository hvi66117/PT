[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$sourcesRoot = Join-Path $ProjectRoot 'Sources'
$encoding = [Text.Encoding]::GetEncoding(28591)
$legacyBinRegex = [regex]'(?i)(?:\.\.[\\/])+bin[\\/](client|server|multiserver)'
$legacySdkRegex = [regex]'(?i)[a-z]:[\\/](?:mssdk|dx81sdk)[\\/]include'
$changed = New-Object System.Collections.Generic.List[string]

function Get-RelativeRoot([string]$Directory, [string]$Root) {
    $from = [Uri]([IO.Path]::GetFullPath($Directory).TrimEnd('\') + '\')
    $to = [Uri]([IO.Path]::GetFullPath($Root).TrimEnd('\') + '\')
    return $from.MakeRelativeUri($to).ToString().Replace('/', '\').TrimEnd('\')
}

Get-ChildItem -LiteralPath $sourcesRoot -Recurse -File |
    Where-Object { $_.Extension -in '.dsp', '.dsw', '.vcproj', '.sln', '.mak' } |
    ForEach-Object {
        $file = $_
        $bytes = [IO.File]::ReadAllBytes($file.FullName)
        $text = $encoding.GetString($bytes)
        $updated = $text.Replace('$/SwordOnline', '$/PhongThanSource')
        $relativeRoot = Get-RelativeRoot $file.DirectoryName $ProjectRoot
        $outputRoot = if ($relativeRoot) { "$relativeRoot\Output" } else { '.\Output' }
        $thirdPartyInclude = if ($relativeRoot) {
            "$relativeRoot\ThirdParty\dx9csdk\Include"
        } else {
            '.\ThirdParty\dx9csdk\Include'
        }

        $updated = $legacyBinRegex.Replace($updated, {
            param($match)
            $role = if ($match.Groups[1].Value -ieq 'client') { 'Client' } else { 'Server' }
            return "$outputRoot\$role"
        })
        $updated = $legacySdkRegex.Replace($updated, $thirdPartyInclude)
        if ($file.Extension -eq '.dsp') {
            $updated = [regex]::Replace(
                $updated,
                '(?m)^# PROP Scc_[^\r\n]*(?:\r?\n)?',
                ''
            )
        }

        if ($file.Extension -eq '.vcproj') {
            $updated = [regex]::Replace($updated, '(?m)^[ \t]*Scc(?:ProjectName|AuxPath|LocalPath|Provider)="[^"]*"(?<Close>>)?[ \t]*(?<Cr>\r?)$', {
                param($match)
                if ($match.Groups['Close'].Success) {
                    return '>' + $match.Groups['Cr'].Value
                }
                return $match.Groups['Cr'].Value
            })
        }

        if ($updated -ne $text) {
            if ($PSCmdlet.ShouldProcess($file.FullName, 'Normalize legacy source and output paths')) {
                [IO.File]::WriteAllBytes($file.FullName, $encoding.GetBytes($updated))
            }
            $changed.Add($file.FullName.Substring($ProjectRoot.Length + 1))
        }
    }

[pscustomobject]@{
    ProjectRoot = $ProjectRoot
    ChangedCount = $changed.Count
    ChangedFiles = $changed
}
