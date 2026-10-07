param([string]$Dump)
$b=[IO.File]::ReadAllBytes($Dump)
function U32($o){[BitConverter]::ToUInt32($b,[int]$o)}
function U64($o){[BitConverter]::ToUInt64($b,[int]$o)}
$dirs=@{};$n=U32 8;$off=U32 12
for($i=0;$i -lt $n;$i++){$d=$off+12*$i;$dirs[(U32 $d)]=(U32 ($d+8))}
$mods=@();$o=$dirs[[uint32]4];$count=U32 $o
for($i=0;$i -lt $count;$i++){$m=$o+4+108*$i;$name=U32 ($m+20);$len=U32 $name;$mods += [pscustomobject]@{Base=(U64 $m);Size=(U32 ($m+8));Name=[Text.Encoding]::Unicode.GetString($b,$name+4,$len)}}
$exc=$dirs[[uint32]6];$ctx=U32 ($exc+164);$esp=U32 ($ctx+196);$eip=U32 ($ctx+184);$ebp=U32 ($ctx+180)
'Thread={0} Exception=0x{1:X} EIP=0x{2:X} ESP=0x{3:X} EBP=0x{4:X}' -f (U32 $exc),(U32 ($exc+8)),$eip,$esp,$ebp
$o=$dirs[[uint32]9];$count=U64 $o;$file=U64 ($o+8);$ranges=@()
for($i=0;$i -lt $count;$i++){$d=$o+16+16*$i;$va=U64 $d;$size=U64 ($d+8);$ranges += [pscustomobject]@{Base=$va;Size=$size;File=$file};$file+=$size}
function At($va){foreach($r in $ranges){if($va -ge $r.Base -and $va -lt $r.Base+$r.Size){return [long]($r.File+$va-$r.Base)}};return -1}
for($i=0;$i -lt 180;$i++){$address=[long]$esp+4*$i;$f=At $address;if($f -lt 0){break};$v=U32 $f;foreach($m in $mods){if($v -ge $m.Base -and $v -lt $m.Base+$m.Size){'{0:X8}: {1:X8} {2}+0x{3:X}' -f $address,$v,([IO.Path]::GetFileName($m.Name)),($v-$m.Base)}}}
