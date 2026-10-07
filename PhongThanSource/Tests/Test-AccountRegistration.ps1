[CmdletBinding()]
param(
    [string]$ProjectRoot,
    [string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging',
    [switch]$Database
)
$ErrorActionPreference='Stop'
if (-not $ProjectRoot) { $ProjectRoot=Split-Path -Parent $PSScriptRoot }
. (Join-Path $ProjectRoot 'Deploy\AccountRegistration.ps1')
function Assert-Registration($condition,[string]$message) {
    if (-not $condition) { throw $message }
}
function Assert-Rejected([scriptblock]$action,[string]$message) {
    $rejected=$false
    try { & $action | Out-Null } catch { $rejected=$true }
    Assert-Registration $rejected $message
}
Assert-PhongThanAccountName 'testaccount200'
foreach($name in @('','abc','abc_def','acc test',('a'*17),"abc'def")) {
    Assert-Rejected { Assert-PhongThanAccountName $name } 'Invalid account accepted.'
}
$password=ConvertTo-SecureString '123456' -AsPlainText -Force
$different=ConvertTo-SecureString '654321' -AsPlainText -Force
try {
    $proof=Get-PhongThanPasswordProof $password
    Assert-Registration ($proof -ceq 'E10ADC3949BA59ABBE56E057F20F883E') 'Hash differs from KSG_StringToMD5String.'
    Assert-Rejected { New-PhongThanAccount -RuntimeRoot $RuntimeRoot -AccountName 'testaccount200' -Password $password -ConfirmPassword $different } 'Mismatched confirmation accepted.'
    foreach($value in @('abcde','with space',('x'*17))) {
        $invalid=ConvertTo-SecureString $value -AsPlainText -Force
        try { Assert-Rejected { Get-PhongThanPasswordProof $invalid } 'Invalid password accepted.' }
        finally { $invalid.Dispose() }
    }
    'PASS: input validation, confirmation, uppercase client-compatible password proof.'
    if ($Database) {
        $connection=[Data.SqlClient.SqlConnection]::new((Get-PhongThanAccountConnectionString $RuntimeRoot))
        $transaction=$null
        $testName='qat'+[Guid]::NewGuid().ToString('N').Substring(0,13)
        try {
            $connection.Open()
            $transaction=$connection.BeginTransaction([Data.IsolationLevel]::Serializable)
            Add-PhongThanAccountRows $connection $transaction $testName $proof
            $command=$connection.CreateCommand()
            try {
                $command.Transaction=$transaction
                $command.CommandTimeout=8
                $command.Parameters.Add('@name',[Data.SqlDbType]::NVarChar,16).Value=$testName
                $command.Parameters.Add('@proof',[Data.SqlDbType]::NVarChar,32).Value=$proof
                # Same CS_AS comparison and deposit view read by S3PAccount::Login.
                $command.CommandText=@'
SELECT COUNT(*) FROM dbo.Account_Info a
JOIN dbo.View_AccountMoney v ON v.cAccName=a.cAccName
WHERE a.cAccName=@name AND a.cPassWord COLLATE Chinese_PRC_CS_AS=@proof
  AND a.cSecPassword COLLATE Chinese_PRC_CS_AS=@proof
  AND a.iClientID=0 AND a.iLock=0 AND a.nMac=0
  AND v.nExtPoint=0 AND v.iLeftSecond>1800 AND v.dEndDate>GETDATE();
'@
                Assert-Registration ($command.ExecuteScalar() -eq 1) 'Account does not satisfy server login prerequisites.'
                Assert-Rejected { Add-PhongThanAccountRows $connection $transaction $testName $proof } 'Duplicate account accepted.'
                Assert-Registration ($command.ExecuteScalar() -eq 1) 'Duplicate attempt altered the first account.'
                $command.CommandText='SELECT COUNT(*) FROM dbo.Account_Habitus WHERE cAccName=@name'
                Assert-Registration ($command.ExecuteScalar() -eq 1) 'Duplicate deposit record.'
            } finally { $command.Dispose() }
        } finally {
            if ($transaction -and $transaction.Connection) { $transaction.Rollback() }
            if ($transaction) { $transaction.Dispose() }
            $connection.Dispose()
        }
        $connection=[Data.SqlClient.SqlConnection]::new((Get-PhongThanAccountConnectionString $RuntimeRoot))
        try {
            $connection.Open()
            $command=$connection.CreateCommand()
            try {
                $command.CommandText='SELECT (SELECT COUNT(*) FROM dbo.Account_Info WHERE cAccName=@name)+(SELECT COUNT(*) FROM dbo.Account_Habitus WHERE cAccName=@name)'
                $command.Parameters.Add('@name',[Data.SqlDbType]::NVarChar,16).Value=$testName
                Assert-Registration ($command.ExecuteScalar() -eq 0) 'Test rows remain after rollback.'
            } finally { $command.Dispose() }
        } finally { $connection.Dispose() }
        'PASS: two-table insert, server password/deposit query, duplicate refusal, rollback cleanup. No account retained.'
    }
} finally { $password.Dispose(); $different.Dispose() }
