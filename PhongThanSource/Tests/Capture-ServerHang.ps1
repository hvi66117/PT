param([Parameter(Mandatory=$true)][int]$ServerPid)
$ErrorActionPreference='Stop'
$process=Get-Process -Id $ServerPid
if($process.Path -ine 'D:\Lam game phong than\PhongThanRuntime-Staging\Server\GameServer.exe'){throw 'Not staging GameServer'}
Add-Type @'
using System;
using System.IO;
using System.Runtime.InteropServices;
public static class PhongThanDump {
 [DllImport("Dbghelp.dll",SetLastError=true)]
 public static extern bool MiniDumpWriteDump(IntPtr process,uint id,IntPtr file,uint type,IntPtr ex,IntPtr user,IntPtr cb);
 public static void Capture(IntPtr process,uint id,string path) {
  using(var f=new FileStream(path,FileMode.CreateNew,FileAccess.Write,FileShare.None)) {
   if(!MiniDumpWriteDump(process,id,f.SafeFileHandle.DangerousGetHandle(),0x1000,IntPtr.Zero,IntPtr.Zero,IntPtr.Zero))
    throw new System.ComponentModel.Win32Exception(Marshal.GetLastWin32Error());
  }
 }
}
'@
$path=Join-Path (Split-Path -Parent $PSScriptRoot) "Output\NpcRestorationTests\GameServer-hang-$ServerPid-$((Get-Date).ToString('HHmmss')).dmp"
[PhongThanDump]::Capture($process.Handle,[uint32]$ServerPid,$path)
$b=[IO.File]::ReadAllBytes($path)
function U32($o){[BitConverter]::ToUInt32($b,[int]$o)}
function U64($o){[BitConverter]::ToUInt64($b,[int]$o)}
$dirs=@{};$n=U32 8;$off=U32 12
for($i=0;$i -lt $n;$i++){$d=$off+12*$i;$dirs[(U32 $d)]=(U32 ($d+8))}
$mods=@();$o=$dirs[[uint32]4];$count=U32 $o
for($i=0;$i -lt $count;$i++){$m=$o+4+108*$i;$name=U32 ($m+20);$len=U32 $name;$mods += [pscustomobject]@{Base=(U64 $m);Size=(U32 ($m+8));Name=[Text.Encoding]::Unicode.GetString($b,$name+4,$len)}}
$o=$dirs[[uint32]3];$count=U32 $o
"Dump=$path threads=$count"
for($i=0;$i -lt $count;$i++){
 $t=$o+4+48*$i;$tid=U32 $t;$ctx=U32 ($t+44);$stack=U32 ($t+36);$size=U32 ($t+32)
 "THREAD $tid context_bytes=$(U32 ($t+40))"
 for($j=0;$j -lt [Math]::Min($size,512);$j+=4){
  $v=U32 ($stack+$j)
  foreach($m in $mods){if($v -ge $m.Base -and $v -lt $m.Base+$m.Size){'{0:X4} {1}+0x{2:X}' -f $j,([IO.Path]::GetFileName($m.Name)),($v-$m.Base)}}
 }
}
