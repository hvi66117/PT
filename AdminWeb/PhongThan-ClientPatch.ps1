param([switch]$Quiet)
# Byte patches for client binaries that cannot be rebuilt here (no VC6). ASCII only.
# Each patch checks the exact original bytes first; already-patched files are skipped.
# The runtime copy, the PhongThanSource\Output copy and the NATIVE_DEPLOYMENT.json hash
# are updated together so Test-NativeRuntime keeps passing.
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Runtime = Join-Path $Root 'PhongThanRuntime-Staging'
$Output = Join-Path $Root 'PhongThanSource\Output'
$Receipt = Join-Path $Runtime 'NATIVE_DEPLOYMENT.json'

$Patches = @(
    @{
        # KItemList::UseItem (CoreClient.map 0001:0004e7e0, file offset 0x4f7e0):
        #   cmp dword ptr [ebx],0 / jg ok   -> the local player index is 0 on the client,
        #   so every right-click on a potion returned 0 before a request was sent.
        #   jg (7F) -> jge (7D)
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x4f7e7; Context = 0x4f7e0
        Before = '538bd956833b007f07'; After = '538bd956833b007d07'
        Desc = 'KItemList::UseItem accepts local player index 0 (potions usable)'
    },
    @{
        # KItemList::NowEatItem (CoreClient.map 0001:0004e660): same guard,
        #   mov ecx,[ebx] / test ecx,ecx / jg -> UseItem called it for medicine and got FALSE.
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x4f66a; Context = 0x4f660
        Before = '538bd955568b0b5785c97f09'; After = '538bd955568b0b5785c97d09'
        Desc = 'KItemList::NowEatItem accepts local player index 0'
    },
    @{
        # Represent2 IsPhongThanHumanComposite (Represent2.map 0x4420) only gave the VNG 510x510
        # actor-canvas anchor (255,293) to paths containing "npcres\passerby\"; monster sprites
        # (npcres\animal\...) fell back to the SwordOnline spot (160,192), drawing bodies ~95/101 px
        # right/down of their real ground point while names and mouse picking stay on it.
        # Shorten the string at .data 0xB0BC to "npcres\" (only reference: file 0x4459).
        Role = 'Client'; Name = 'Represent2.dll'; TimeStamp = 0x6aa134b5
        Offset = 0xB0C3; Context = 0xB0BC
        Before = '6e70637265735c70617373657262795c00'; After = '6e70637265735c00617373657262795c00'
        Desc = 'Represent2 uses the VNG actor anchor for every 510x510 npcres sprite (monsters on their ground point)'
    },
    # KItemList::Fit(int,int) / Fit(KItem*,int), case equip_amulet (VNG phap bao, detail 4):
    #   cmp [esp+8],6 / jne ret0 / mov eax,1 / ret 8   (only the JadePendant slot)
    # ->mov ecx,[esp+8] / sub ecx,6 / cmp ecx,2 / jbe ret1 / jmp ret0 / nop
    #   so phap bao also fit itempart_ring1/ring2 (UI "Talisman1/2", the two "Phap bao" boxes).
    #   ReCalcEquip applies the magic attributes of every equipped slot, so the stats are real.
    #   ret1/ret0 are the shared "mov eax,1 / ret 8" and "ret 8" (eax=0) tails of each function.
    @{
        Role = 'Server'; Name = 'CoreServer.dll'; TimeStamp = 0x6aaa5d9f
        Offset = 0x4db06; Context = 0x4db06
        Before = '837c2408067551b801000000c20800'; After = '8b4c240883e90683f9027647eb4a90'
        Desc = 'KItemList::Fit(int,int): phap bao fit the 2 Talisman (ring) slots (server)'
    },
    @{
        Role = 'Server'; Name = 'CoreServer.dll'; TimeStamp = 0x6aaa5d9f
        Offset = 0x4dc2d; Context = 0x4dc2d
        Before = '837c2408067551b801000000c20800'; After = '8b4c240883e90683f9027647eb4a90'
        Desc = 'KItemList::Fit(KItem*,int): phap bao fit the 2 Talisman (ring) slots (server)'
    },
    @{
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x4f389; Context = 0x4f389
        Before = '837c2408067551b801000000c20800'; After = '8b4c240883e90683f9027647eb4a90'
        Desc = 'KItemList::Fit(int,int): phap bao fit the 2 Talisman (ring) slots (client)'
    },
    @{
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x4f4ad; Context = 0x4f4ad
        Before = '837c2408067551b801000000c20800'; After = '8b4c240883e90683f9027647eb4a90'
        Desc = 'KItemList::Fit(KItem*,int): phap bao fit the 2 Talisman (ring) slots (client)'
    },
    @{
        # KPlayer::AddSelfExp (Coreserver.map 0001:00025910): a player more than 15 levels above
        # the monster got a flat 1 exp, so a level 120 character earned nothing anywhere (spawned
        # monsters top out at level 102). The "player >= target && target >= 100" branch already
        # gives exp - exp*diff/200; drop the "target >= 100" test (cmp edi,64h / jl -> nop nop)
        # so every lower-level monster uses it (diff 20 -> 90%, diff 82 -> 59%). Monsters above
        # the player keep the original rule.
        Role = 'Server'; Name = 'CoreServer.dll'; TimeStamp = 0x6aaa5d9f
        Offset = 0x26976; Context = 0x26971
        Before = '7c1f83ff647c1a'; After = '7c1f83ff649090'
        Desc = 'KPlayer::AddSelfExp: lower-level monsters give exp - exp*diff/200 instead of 1'
    },
    @{
        # PaintPhongThanLifeBarOverlay (KScenePlaceC.cpp, CoreClient.map 0001:00079400): a killed
        # monster waiting to revive has no body sprite but its empty barback.spr frame was still
        # drawn (life 0%), leaving floating empty bars. Percent clamp
        #   test ebx,ebx / jge +4 / xor ebx,ebx / jmp +0a
        # ->test ebx,ebx / jle 0x1007a60b (function epilogue: pop edi,esi,ebp,ebx / add esp / ret)
        # so a 0% bar is not drawn; the >100 clamp that follows is unchanged.
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x7a44b; Context = 0x7a44b
        Before = '85db7d0433dbeb0a'; After = '85db0f8eb8010000'
        Desc = 'Life bar overlay: no empty bar for dead monsters (life 0%)'
    },
    @{
        # 2026-10-03: crash on game exit (WER "unknown ...a350", seen since 2026-09-28). The atexit
        # destructor of g_SoundCache (registered at 0x10056210) runs in CoreClient's DllMain DETACH,
        # after GameExit already released DirectSound, so KWavSound::Free calls Release through a
        # freed vtable. mov ecx,g_SoundCache -> ret: skip that destructor (the process is exiting).
        Role = 'Client'; Name = 'CoreClient.dll'; TimeStamp = 0x6aaa74c1
        Offset = 0x56220; Context = 0x56220
        Before = 'b908630011ff2590700810'; After = 'c308630011ff2590700810'
        Desc = 'atexit g_SoundCache: no DirectSound Release on exit (exit crash ...a350)'
    },
    @{
        # KNpc::CheckHitTarget (CoreServer.map 0001:00015bd0, 2026-10-02): attack rating is
        # dexterity * 4 - 28, negative for new Dao Si / Di Nhan (dexterity 3), and
        #   mov eax,[esp+8] / test eax,eax / jge +6 / xor eax,eax / pop esi / ret 0Ch
        # returned FALSE (every hit missed, no damage number). Now a negative AR becomes 0:
        #   jge +2 / xor eax,eax / nop x4  -> falls through to the normal formula (40% floor).
        Role = 'Server'; Name = 'CoreServer.dll'; TimeStamp = 0x6aaa5d9f
        Offset = 0x16c01; Context = 0x16bfb
        Before = '8b44240885c07d0633c05ec20c00'; After = '8b44240885c07d0233c090909090'
        Desc = 'KNpc::CheckHitTarget: negative attack rating counts as 0 (40% hit floor) instead of always missing'
    }
)

function Log([string]$m) { if (-not $Quiet) { Write-Host $m } }
function Hex([byte[]]$b, [int]$o, [int]$n) { -join ($b[$o..($o + $n - 1)] | ForEach-Object { $_.ToString('x2') }) }

$running = @(Get-Process Game -ErrorAction SilentlyContinue)
if ($running.Count) { Log 'Client dang mo: bo qua cac ban va client (dong game roi chay lai).' }

# Pending ptfix.pak (built while server/client held the old one open): install it in both
# data folders and refresh the NATIVE_DEPLOYMENT.json PakChain entry.
$pendingPak = Join-Path $PSScriptRoot 'pending\ptfix.pak'
if (Test-Path -LiteralPath $pendingPak) {
    # any GameServer (the process path is not always readable) or a locked pak means "running"
    $srvRun = @(Get-Process GameServer -ErrorAction SilentlyContinue)
    $locked = $false
    foreach ($side in 'Server', 'Client') {
        $dst = Join-Path $Runtime "$side\data\ptfix.pak"
        if (Test-Path -LiteralPath $dst) {
            try { $fs = [IO.File]::Open($dst, 'Open', 'ReadWrite', 'None'); $fs.Close() } catch { $locked = $true }
        }
    }
    if ($srvRun.Count -or $locked) {
        Log 'GameServer/client dang chay: chua cai ptfix.pak moi (dung server va thoat game roi chay lai).'
    } else {
        $bakDir = Join-Path $Root ('_backup\ptfix-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
        New-Item -ItemType Directory -Force -Path $bakDir | Out-Null
        foreach ($side in 'Server', 'Client') {
            $dst = Join-Path $Runtime "$side\data\ptfix.pak"
            if (Test-Path -LiteralPath $dst) { Copy-Item -LiteralPath $dst -Destination (Join-Path $bakDir "$side-ptfix.pak") }
            Copy-Item -LiteralPath $pendingPak -Destination $dst -Force
        }
        if (Test-Path -LiteralPath $Receipt) {
            $r = Get-Content -LiteralPath $Receipt -Raw | ConvertFrom-Json
            $len = (Get-Item -LiteralPath $pendingPak).Length
            $hash = (Get-FileHash -LiteralPath $pendingPak).Hash
            foreach ($e in $r.PakChain.Entries) {
                if ($e.Name -eq 'ptfix.pak') { $r.PakChain.TotalBytes = [long]$r.PakChain.TotalBytes - [long]$e.Length + $len; $e.Length = $len; $e.Sha256 = $hash }
            }
            ($r | ConvertTo-Json -Depth 10) | Set-Content -LiteralPath $Receipt -Encoding UTF8
        }
        Move-Item -LiteralPath $pendingPak -Destination (Join-Path $bakDir 'installed-ptfix.pak') -Force
        Log "Da cai ptfix.pak moi (ban cu luu o $bakDir)"
    }
}

foreach ($p in $Patches) {
    $changed = $false
    if ($p.Role -eq 'Client' -and $running.Count) { continue }
    $files = @((Join-Path $Runtime "$($p.Role)\$($p.Name)"), (Join-Path $Output "$($p.Role)\$($p.Name)"))
    # Test-NativeRuntime needs runtime and Output to match the receipt: patch both or neither.
    $lockedFile = $null
    foreach ($f in $files) {
        if (-not (Test-Path -LiteralPath $f)) { continue }
        try { $fs = [IO.File]::Open($f, 'Open', 'ReadWrite', 'None'); $fs.Close() } catch { $lockedFile = $f }
    }
    if ($lockedFile) { Log "File dang bi khoa (server/game dang chay), se va lan sau: $lockedFile"; continue }
    foreach ($f in $files) {
        if (-not (Test-Path -LiteralPath $f)) { continue }
        $b = [IO.File]::ReadAllBytes($f)
        $pe = [BitConverter]::ToInt32($b, 0x3c)
        if ([BitConverter]::ToUInt32($b, $pe + 8) -ne [uint32]$p.TimeStamp) { Log "Bo qua (khac phien ban): $f"; continue }
        $len = $p.Before.Length / 2
        $cur = Hex $b $p.Context $len
        if ($cur -eq $p.After) { Log "Da va: $f"; continue }
        if ($cur -ne $p.Before) { Log "Bo qua (byte khong khop $cur): $f"; continue }
        $bak = Join-Path $Root ('_backup\client-patch\' + (Split-Path -Leaf (Split-Path -Parent $f)) + '_' + $p.Name + '.orig')
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $bak) | Out-Null
        if (-not (Test-Path -LiteralPath $bak)) { Copy-Item -LiteralPath $f -Destination $bak }
        $afterBytes = [byte[]]::new($len)
        for ($i = 0; $i -lt $len; $i++) { $afterBytes[$i] = [Convert]::ToByte($p.After.Substring($i * 2, 2), 16) }
        [Array]::Copy($afterBytes, 0, $b, $p.Context, $len)
        [IO.File]::WriteAllBytes($f, $b)
        Log "Da va $($p.Desc): $f"
        $changed = $true
    }
    if ($changed -and (Test-Path -LiteralPath $Receipt)) {
        $r = Get-Content -LiteralPath $Receipt -Raw | ConvertFrom-Json
        $hash = (Get-FileHash -LiteralPath $files[0]).Hash
        foreach ($a in $r.Artifacts) { if ($a.Role -eq $p.Role -and $a.Name -eq $p.Name) { $a.Sha256 = $hash } }
        ($r | ConvertTo-Json -Depth 10) | Set-Content -LiteralPath $Receipt -Encoding UTF8
        Log 'Da cap nhat NATIVE_DEPLOYMENT.json'
    }
}
exit 0
