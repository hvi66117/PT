param([ValidateSet('Panel','StartServer','StartClient','StopServer','Status','Publish','CreateAccount')][string]$Action='Panel')
$ErrorActionPreference='Stop'
$project=Split-Path -Parent $PSScriptRoot
$runtime=Join-Path (Split-Path -Parent $project) 'PhongThanRuntime-Staging'
$server=Join-Path $runtime 'Server'
function Processes([string]$dir) {
 @(Get-CimInstance Win32_Process | Where-Object {$_.ExecutablePath -and (Split-Path -Parent $_.ExecutablePath) -ieq $dir})
}
function StopServer {
 $game=@(Processes $server | Where-Object Name -ieq 'GameServer.exe')
 foreach($p in $game){
  $proc=Get-Process -Id $p.ProcessId
  # Acquire the process handle before signaling so its exit code remains readable.
  $null=$proc.Handle
  try{$ev=[Threading.EventWaitHandle]::OpenExisting("Local\PhongThan.Stop.$($p.ProcessId)")}catch{throw 'GameServer cu chua ho tro dung an toan. Khong ep tat. Can thoat phien cu va Cap nhat ban build.'}
  try{[void]$ev.Set()}finally{$ev.Dispose()}
  Write-Output 'Dang cho GameServer luu nhan vat va thoat (toi da 180 giay)...'
  if(!$proc.WaitForExit(180000)){throw 'Het thoi gian cho luu. Giu cac dich vu DB/relay; khong ep tat.'}
  if($proc.ExitCode -ne 0){throw "GameServer exit=$($proc.ExitCode): chua xac nhan luu day du. Giu DB/relay de dieu tra."}
 }
 # Character persistence belongs to Goddess; terminate supporting services only
 # after the world process has acknowledged all character saves and exited.
 foreach($name in 'Bishop.exe','PhongThanRelay.exe','PhongThanAccountServer.exe','Goddess.exe'){
  foreach($p in @(Processes $server | Where-Object Name -ieq $name)){Stop-Process -Id $p.ProcessId;Write-Output "Stopped $name"}
 }
 Write-Output 'Server da dung. LocalDB va client duoc giu nguyen.'
}
if($Action -ne 'Panel'){
 try{
  switch($Action){
   Status {Processes $server | Select-Object Name,ProcessId;Processes (Join-Path $runtime 'Client')|Select-Object Name,ProcessId}
   StartServer {if((Processes $server).Count){throw 'Server dang chay hoac chi chay mot phan. Xem trang thai truoc; khong tao trung.'}; & "$PSScriptRoot\Start-NativeServer.ps1" -ProjectRoot $project -RuntimeRoot $runtime}
   StartClient {if(@(Processes (Join-Path $runtime 'Client')|Where-Object Name -ieq 'Game.exe').Count){throw 'Client da mo.'}; & "$PSScriptRoot\Start-StagingClient.ps1" -StartupWaitSeconds 25}
   StopServer {StopServer}
   CreateAccount {. "$PSScriptRoot\PhongThan-AccountForm.ps1"; Show-PhongThanAccountForm -RuntimeRoot $runtime}
   Publish {if((Processes $server).Count -or (Processes (Join-Path $runtime 'Client')).Count){throw 'Can dong runtime truoc khi cap nhat build.'}; & "$PSScriptRoot\Publish-NativeRuntime.ps1"}
  };exit 0
 }catch{Write-Output "LOI: $($_.Exception.Message)";exit 1}
}
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form=[Windows.Forms.Form]::new();$form.Text='Phong Than - Server / Client / Tai khoan';$form.Size=[Drawing.Size]::new(760,550);$form.MinimumSize=$form.Size;$form.StartPosition='CenterScreen'
$box=[Windows.Forms.TextBox]::new();$box.Multiline=$true;$box.ReadOnly=$true;$box.ScrollBars='Both';$box.Location=[Drawing.Point]::new(15,110);$box.Size=[Drawing.Size]::new(715,370);$box.Anchor='Top,Bottom,Left,Right';$form.Controls.Add($box)
$script:worker=$null;$script:buttons=@();$logDir=Join-Path $runtime 'ControlLogs';New-Item -ItemType Directory -Force $logDir|Out-Null
$specs=@(@('Bat server','StartServer'),@('Mo client','StartClient'),@('Dung server','StopServer'),@('Trang thai','Status'),@('Cap nhat build','Publish'),@('Tao tai khoan','CreateAccount'))
$i=0
foreach($spec in $specs){$b=[Windows.Forms.Button]::new();$b.Text=$spec[0];$b.Tag=$spec[1];$b.Location=[Drawing.Point]::new((15+($i%5)*144),(20+([int][Math]::Floor($i/5))*44));$b.Size=[Drawing.Size]::new(135,34);$form.Controls.Add($b);$script:buttons+=$b;$i++
 $b.Add_Click({param($sender,$e)
  if($script:worker){return}
  if($sender.Tag -eq 'StopServer' -and [Windows.Forms.MessageBox]::Show('Ngat nguoi choi, luu nhan vat va dung server?','Xac nhan','YesNo') -ne 'Yes'){return}
  $script:log=Join-Path $logDir ((Get-Date -Format 'yyyyMMdd-HHmmss-fff')+'.log');$script:err=$script:log+'.err'
  $hostExe=(Get-Process -Id $PID).Path
  $args='-NoProfile -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File "'+$PSCommandPath+'" -Action '+$sender.Tag
  try{$script:worker=Start-Process $hostExe -ArgumentList $args -WindowStyle Hidden -RedirectStandardOutput $script:log -RedirectStandardError $script:err -PassThru;foreach($b in $script:buttons){$b.Enabled=$false}}catch{$box.Text=$_.Exception.Message}
 })
}
$timer=[Windows.Forms.Timer]::new();$timer.Interval=500;$timer.Add_Tick({if($script:worker){$box.Text=(Get-Content $script:log -Raw -ErrorAction SilentlyContinue)+(Get-Content $script:err -Raw -ErrorAction SilentlyContinue);$script:worker.Refresh();if($script:worker.HasExited){$box.AppendText("`r`nExit: $($script:worker.ExitCode)");$script:worker.Dispose();$script:worker=$null;foreach($b in $script:buttons){$b.Enabled=$true}}}});$timer.Start()
$form.Add_FormClosing({param($s,$e) if($script:worker){$e.Cancel=$true;[Windows.Forms.MessageBox]::Show('Dang xu ly. Hay cho hoan tat.')}})
$box.Text="Runtime: $runtime`r`nDung server se giu LocalDB va client. Khong tu dong ep tat GameServer."
$form.Add_Shown({Write-Output 'Control panel ready (CreateAccount enabled).'})
[void]$form.ShowDialog();$timer.Stop();$timer.Dispose();$form.Dispose()
