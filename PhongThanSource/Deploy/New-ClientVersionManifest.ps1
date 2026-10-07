[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ClientRoot
)

$ErrorActionPreference = 'Stop'
$ClientRoot = [IO.Path]::GetFullPath($ClientRoot).TrimEnd('\')
if (-not (Test-Path -LiteralPath $ClientRoot -PathType Container)) {
    throw "Client root khong ton tai: $ClientRoot"
}

$files = [Collections.Generic.List[IO.FileInfo]]::new()
foreach ($file in Get-ChildItem -LiteralPath $ClientRoot -File -Force) {
    if ($file.Name -ieq 'version.xml' -or $file.Name -match '(?i)\.log(?:\..*)?$') { continue }
    $files.Add($file)
}
$dataRoot = Join-Path $ClientRoot 'data'
if (Test-Path -LiteralPath $dataRoot -PathType Container) {
    foreach ($file in Get-ChildItem -LiteralPath $dataRoot -File -Filter '*.pak' -Force) {
        $files.Add($file)
    }
}

$legacyTokens = @(
    'volam',
    'vltk',
    ('sword' + 'online'),
    'script\\skill\\(cuiyan|emei|gaibang|huashan|kunlun|shaolin|tangmen|tianren|tianwang|wudang|wudu)\.lua'
)
$legacyPattern = '(?i)' + ($legacyTokens -join '|')

$records = @($files | ForEach-Object {
    $relative = $_.FullName.Substring($ClientRoot.Length + 1).Replace('/', '\')
    if ($relative -match $legacyPattern) {
        throw "Tu choi dua du lieu Vo Lam vao version.xml: $relative"
    }
    [pscustomobject]@{
        Path = $relative
        Link = $relative.Replace('\', '/')
        Hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm MD5).Hash
        Size = $_.Length
    }
} | Sort-Object Path)
if (-not $records.Count) { throw 'Khong co file nao de tao version.xml.' }

$target = Join-Path $ClientRoot 'version.xml'
$settings = [Xml.XmlWriterSettings]::new()
$settings.Encoding = [Text.UTF8Encoding]::new($false)
$settings.Indent = $true
$settings.IndentChars = '  '
$settings.NewLineChars = "`r`n"
$settings.NewLineHandling = [Xml.NewLineHandling]::Replace
$writer = [Xml.XmlWriter]::Create($target, $settings)
try {
    $writer.WriteStartDocument()
    $writer.WriteStartElement('Autoupdate')
    $writer.WriteAttributeString('xmlns', 'xsi', $null, 'http://www.w3.org/2001/XMLSchema-instance')
    $writer.WriteAttributeString('xmlns', 'xsd', $null, 'http://www.w3.org/2001/XMLSchema')
    foreach ($record in $records) {
        $writer.WriteStartElement('Item')
        $writer.WriteElementString('Path', [string]$record.Path)
        $writer.WriteElementString('Link', [string]$record.Link)
        $writer.WriteElementString('Hash', [string]$record.Hash)
        $writer.WriteElementString('Size', [string]$record.Size)
        $writer.WriteEndElement()
    }
    $writer.WriteEndElement()
    $writer.WriteEndDocument()
}
finally {
    $writer.Dispose()
}

[pscustomobject]@{
    Result = 'PASS'
    VersionManifest = $target
    Entries = $records.Count
}
