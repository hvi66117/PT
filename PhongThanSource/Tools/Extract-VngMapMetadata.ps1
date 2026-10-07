$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$output=Join-Path $root 'Output\MapMetadataCertifiedVng'
if(Test-Path -LiteralPath $output){throw 'Metadata extraction output already exists'}
New-Item -ItemType Directory -Path $output | Out-Null
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$latin=[Text.Encoding]::GetEncoding(28591);$gbk=[Text.Encoding]::GetEncoding(936)
$names=@(Get-ChildItem -LiteralPath 'D:\Lam game phong than\PhongThanRuntime-Staging\Client\maps' -File -Filter '*.wor' | ForEach-Object {$gbk.GetString($latin.GetBytes($_.BaseName))} | Sort-Object -Unique)
$rows=@('logical_path')+@($names | ForEach-Object {'maps\'+$_+'.wor';'maps\'+$_+'24.jpg'})
$inventory=Get-Content -LiteralPath (Join-Path $root 'Output\MapMetadataActiveVng\run\manifests\extraction-manifest.json') -Raw | ConvertFrom-Json
$unavailable=@($inventory.failures | ForEach-Object logical_path)
$rows=@($rows | Where-Object {$_ -notin $unavailable})
$requests=Join-Path $output 'requests.tsv'
[IO.File]::WriteAllLines($requests,$rows,[Text.UTF8Encoding]::new($false))
& 'D:\Lam game phong than\SourceMigration\tools\phongthan-unpack2\Invoke-PhongThanUnpack2.ps1' `
    -OfficialPackageIni 'D:\Lam game phong than\PhongThanRuntime-Staging\Client\package.ini' `
    -RequestsPath $requests -UclDirectory 'D:\Lam game phong than\PhongThanRuntime-Staging\Client' `
    -PackageProfile RuntimePriority -RunRoot (Join-Path $output 'run')
