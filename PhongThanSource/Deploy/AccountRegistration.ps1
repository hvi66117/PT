# Local account administration; no gameplay state or existing account is changed.
function Assert-PhongThanAccountName([string]$AccountName) {
    # S3PAccount::Login rejects every character except ASCII letters/digits.
    if ($AccountName -cnotmatch '\A[A-Za-z0-9]{6,16}\z') {
        throw 'Ten tai khoan phai co 6-16 ky tu, chi gom chu khong dau va so.'
    }
}

function Get-PhongThanPasswordProof([Security.SecureString]$Password) {
    if (-not $Password) { throw 'Chua nhap mat khau.' }
    $pointer = [IntPtr]::Zero
    $bytes = $null
    $md5 = $null
    try {
        $pointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
        $plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($pointer)
        if ($plain -cnotmatch '\A[\x21-\x7E]{6,16}\z') {
            throw 'Mat khau phai co 6-16 ky tu ASCII, khong dau, khong khoang trang.'
        }
        # Engine/Src/KSG_MD5_String.cpp uses %02X. AccountServer compares CS_AS.
        # MD5 is required by this login protocol, not a general password policy.
        $bytes = [Text.Encoding]::ASCII.GetBytes($plain)
        $md5 = [Security.Cryptography.MD5]::Create()
        return [BitConverter]::ToString($md5.ComputeHash($bytes)).Replace('-', '')
    } finally {
        $plain = $null
        if ($bytes) { [Array]::Clear($bytes, 0, $bytes.Length) }
        if ($md5) { $md5.Dispose() }
        if ($pointer -ne [IntPtr]::Zero) {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($pointer)
        }
    }
}

function Get-PhongThanAccountConnectionString([string]$RuntimeRoot) {
    $path = Join-Path $RuntimeRoot 'Server\DataBase.ini'
    $values = @{}
    $section = ''
    foreach ($line in Get-Content -LiteralPath $path -ErrorAction Stop) {
        if ($line -match '^\s*\[([^]]+)\]') { $section = $Matches[1]; continue }
        if ($section -ieq 'account' -and $line -match '^\s*([^;#=]+?)\s*=(.*)$') {
            $values[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    if (-not $values.Server -or $values.DataBase -ine 'account') {
        throw 'DataBase.ini thieu [account]/Server hoac khong tro den database account.'
    }
    # Use the same endpoint/authentication as the running AccountServer.
    $builder = [Data.SqlClient.SqlConnectionStringBuilder]::new('Server=' + $values.Server)
    $builder['Initial Catalog'] = $values.DataBase
    $builder['Connect Timeout'] = 5
    $builder['Application Name'] = 'PhongThan Account Registration'
    if (-not $builder['Integrated Security']) {
        $builder['User ID'] = $values.User
        $builder['Password'] = $values.Password
    }
    return $builder.ConnectionString
}

function Add-PhongThanAccountRows {
    param(
        [Data.SqlClient.SqlConnection]$Connection,
        [Data.SqlClient.SqlTransaction]$Transaction,
        [string]$AccountName,
        [string]$PasswordProof
    )
    Assert-PhongThanAccountName $AccountName
    if ($PasswordProof -cnotmatch '\A[0-9A-F]{32}\z') { throw 'Ma mat khau khong dung dinh dang client.' }
    if (-not $Transaction -or $Transaction.Connection -ne $Connection) {
        throw 'Tao tai khoan bat buoc nam trong mot transaction.'
    }
    $command = $Connection.CreateCommand()
    try {
        $command.Transaction = $Transaction
        $command.CommandTimeout = 8
        $command.CommandText = @'
IF EXISTS (SELECT 1 FROM dbo.Account_Info WITH (UPDLOCK,HOLDLOCK) WHERE cAccName=@name)
   OR EXISTS (SELECT 1 FROM dbo.Account_Habitus WITH (UPDLOCK,HOLDLOCK) WHERE cAccName=@name)
BEGIN
    RAISERROR('PHONGTHAN_ACCOUNT_EXISTS',16,1);
    RETURN;
END;
INSERT INTO dbo.Account_Info
    (cAccName,cPassWord,cSecPassword,iClientID,iLock,nMac,dRegDate)
VALUES (@name,@proof,@proof,0,0,0,GETDATE());
INSERT INTO dbo.Account_Habitus
    (cAccName,iFlag,iLeftSecond,nExtPoint,dBeginDate,iLeftMonth,dEndDate)
VALUES (@name,1,31536000,0,GETDATE(),12,DATEADD(year,1,GETDATE()));
'@
        $command.Parameters.Add('@name', [Data.SqlDbType]::NVarChar, 16).Value = $AccountName
        $command.Parameters.Add('@proof', [Data.SqlDbType]::NVarChar, 32).Value = $PasswordProof
        try { [void]$command.ExecuteNonQuery() }
        catch {
            if ($_.Exception.ToString().Contains('PHONGTHAN_ACCOUNT_EXISTS')) {
                throw 'Tai khoan da ton tai. Khong ghi de hoac doi mat khau tai khoan cu.'
            }
            throw 'Khong ghi duoc du hai bang tai khoan. Kiem tra schema/quyen database.'
        }
    } finally { $command.Dispose() }
}

function New-PhongThanAccount {
    param(
        [Parameter(Mandatory=$true)][string]$RuntimeRoot,
        [Parameter(Mandatory=$true)][string]$AccountName,
        [Parameter(Mandatory=$true)][Security.SecureString]$Password,
        [Parameter(Mandatory=$true)][Security.SecureString]$ConfirmPassword
    )
    Assert-PhongThanAccountName $AccountName
    $proof = Get-PhongThanPasswordProof $Password
    $confirm = Get-PhongThanPasswordProof $ConfirmPassword
    if ($proof -cne $confirm) { throw 'Hai lan nhap mat khau khong khop.' }
    $connection = [Data.SqlClient.SqlConnection]::new((Get-PhongThanAccountConnectionString $RuntimeRoot))
    $transaction = $null
    try {
        try { $connection.Open() }
        catch { throw 'Khong ket noi duoc database account. Hay bat server de khoi dong/cap nhat LocalDB, roi thu lai.' }
        $transaction = $connection.BeginTransaction([Data.IsolationLevel]::Serializable)
        Add-PhongThanAccountRows $connection $transaction $AccountName $proof
        $transaction.Commit()
        [pscustomobject]@{AccountName=$AccountName; Status='Created'; Database='account'}
    } catch {
        if ($transaction -and $transaction.Connection) { $transaction.Rollback() }
        throw
    } finally {
        $proof = $null
        $confirm = $null
        if ($transaction) { $transaction.Dispose() }
        $connection.Dispose()
    }
}
