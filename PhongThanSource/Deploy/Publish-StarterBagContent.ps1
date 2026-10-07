[CmdletBinding()]
param([string]$ProjectRoot,[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
if(-not $ProjectRoot){$ProjectRoot=Split-Path -Parent $PSScriptRoot}
$source=Join-Path $ProjectRoot 'Deploy\ProjectContent\settings\item\PhongThanStarterBag.ini'
foreach($role in 'Server','Client'){
    $target=Join-Path $RuntimeRoot "$role\settings\item\PhongThanStarterBag.ini"
    if(-not(Test-Path -LiteralPath (Split-Path -Parent $target))){throw 'Runtime item directory missing'}
    Copy-Item -LiteralPath $source -Destination $target -Force
    if((Get-FileHash -LiteralPath $source).Hash -ne (Get-FileHash -LiteralPath $target).Hash){throw 'Starter bag config mismatch'}
}
'Starter bag project definition synchronized; VNG tables unchanged.'
