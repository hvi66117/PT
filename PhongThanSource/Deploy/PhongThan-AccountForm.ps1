function Show-PhongThanAccountForm([string]$RuntimeRoot) {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    . (Join-Path $PSScriptRoot 'AccountRegistration.ps1')
    $dialog = [Windows.Forms.Form]::new()
    $dialog.Text = 'Phong Than - Tao tai khoan'
    $dialog.ClientSize = [Drawing.Size]::new(500,330)
    $dialog.Font = [Drawing.Font]::new('Segoe UI',10)
    $dialog.StartPosition = 'CenterScreen'
    $dialog.FormBorderStyle = 'FixedDialog'
    $dialog.MaximizeBox = $false
    $fields = @()
    $labels = @('Tai khoan (6-16 chu/so)', 'Mat khau (6-16 ky tu)', 'Nhap lai mat khau')
    for ($i=0; $i -lt 3; $i++) {
        $label = [Windows.Forms.Label]::new()
        $label.Text = $labels[$i]
        $label.Location = [Drawing.Point]::new(20,25+$i*45)
        $label.Size = [Drawing.Size]::new(190,28)
        $dialog.Controls.Add($label)
        $field = [Windows.Forms.TextBox]::new()
        $field.Location = [Drawing.Point]::new(215,22+$i*45)
        $field.Size = [Drawing.Size]::new(260,28)
        $field.MaxLength = 16
        $field.TabIndex = $i
        $field.UseSystemPasswordChar = ($i -gt 0)
        $dialog.Controls.Add($field)
        $fields += $field
    }
    $note = [Windows.Forms.Label]::new()
    $note.Text = "Tai khoan moi chua co nhan vat. Dang nhap de tao nhan vat.`r`nMat khau cap 2 ban dau giong mat khau dang nhap."
    $note.Location = [Drawing.Point]::new(20,158)
    $note.Size = [Drawing.Size]::new(460,48)
    $dialog.Controls.Add($note)
    $status = [Windows.Forms.Label]::new()
    $status.Location = [Drawing.Point]::new(20,211)
    $status.Size = [Drawing.Size]::new(460,65)
    $dialog.Controls.Add($status)
    $create = [Windows.Forms.Button]::new()
    $create.Text = 'Tao tai khoan'
    $create.Location = [Drawing.Point]::new(215,282)
    $create.Size = [Drawing.Size]::new(140,32)
    $create.TabIndex = 3
    $dialog.Controls.Add($create)
    $close = [Windows.Forms.Button]::new()
    $close.Text = 'Dong'
    $close.Location = [Drawing.Point]::new(365,282)
    $close.Size = [Drawing.Size]::new(110,32)
    $close.TabIndex = 4
    $dialog.Controls.Add($close)
    $dialog.AcceptButton = $create
    $dialog.CancelButton = $close
    $job = @{Runner=$null; Handle=$null; Password=$null; Confirm=$null}
    $create.Add_Click({
        if ($job.Runner) { return }
        $status.ForeColor = [Drawing.Color]::Firebrick
        try {
            Assert-PhongThanAccountName $fields[0].Text
            if (-not $fields[1].Text -or $fields[1].Text -cne $fields[2].Text) {
                throw 'Hai lan nhap mat khau khong khop hoac dang de trong.'
            }
            $job.Password = ConvertTo-SecureString $fields[1].Text -AsPlainText -Force
            $job.Confirm = ConvertTo-SecureString $fields[2].Text -AsPlainText -Force
            $null = Get-PhongThanPasswordProof $job.Password
            # Secrets stay in-process: never pass them on command lines or into logs.
            $job.Runner = [PowerShell]::Create()
            [void]$job.Runner.AddScript({
                param($library,$runtime,$name,$password,$confirmation)
                $ErrorActionPreference = 'Stop'
                . $library
                New-PhongThanAccount -RuntimeRoot $runtime -AccountName $name -Password $password -ConfirmPassword $confirmation
            }).AddArgument((Join-Path $PSScriptRoot 'AccountRegistration.ps1')).AddArgument($RuntimeRoot).AddArgument($fields[0].Text).AddArgument($job.Password).AddArgument($job.Confirm)
            $job.Handle = $job.Runner.BeginInvoke()
            $create.Enabled = $false
            $close.Enabled = $false
            foreach ($field in $fields) { $field.Enabled = $false }
            $status.ForeColor = [Drawing.Color]::Black
            $status.Text = 'Dang tao tai khoan...'
        } catch {
            $status.Text = $_.Exception.Message
            if ($job.Runner) { $job.Runner.Dispose(); $job.Runner=$null }
            if ($job.Password) { $job.Password.Dispose(); $job.Password=$null }
            if ($job.Confirm) { $job.Confirm.Dispose(); $job.Confirm=$null }
        } finally {
            $fields[1].Clear()
            $fields[2].Clear()
        }
    })
    $timer = [Windows.Forms.Timer]::new()
    $timer.Interval = 150
    $timer.Add_Tick({
        if (-not $job.Runner -or -not $job.Handle.IsCompleted) { return }
        try {
            $result = @($job.Runner.EndInvoke($job.Handle))
            if ($job.Runner.HadErrors) { throw $job.Runner.Streams.Error[0].Exception.Message }
            if ($result.Count -ne 1 -or $result[0].Status -ne 'Created') { throw 'Khong nhan duoc xac nhan tao tai khoan.' }
            $status.ForeColor = [Drawing.Color]::DarkGreen
            $status.Text = "Da tao tai khoan '$($result[0].AccountName)'.`r`nBan co the dang nhap va tao nhan vat ngay."
            Write-Output "Da tao tai khoan: $($result[0].AccountName)"
            $fields[0].Clear()
        } catch {
            $status.ForeColor = [Drawing.Color]::Firebrick
            $status.Text = $_.Exception.GetBaseException().Message
        } finally {
            $job.Runner.Dispose(); $job.Runner=$null; $job.Handle=$null
            $job.Password.Dispose(); $job.Password=$null
            $job.Confirm.Dispose(); $job.Confirm=$null
            $create.Enabled=$true; $close.Enabled=$true
            foreach ($field in $fields) { $field.Enabled=$true }
            [void]$fields[0].Focus()
        }
    })
    $close.Add_Click({ $dialog.Close() })
    $dialog.Add_Shown({ Write-Output 'Account form ready.' })
    $dialog.Add_FormClosing({ param($sender,$eventArgs) if ($job.Runner) { $eventArgs.Cancel=$true } })
    $timer.Start()
    try { [void]$dialog.ShowDialog() }
    finally { $timer.Stop(); $timer.Dispose(); $dialog.Dispose() }
}
