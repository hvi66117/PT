$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$enc = [Text.Encoding]::GetEncoding(28591)
function ReadSource($path) { [IO.File]::ReadAllText((Join-Path $root $path), $enc) }
$buy = ReadSource 'Sources/Core/Src/KBuySell.cpp'
if ($buy -notmatch '!IsPhongThanIBShop\(nBuy\) && Npc\[Player\[nPlayerIdx\].m_nIndex\].m_FightMode') { throw 'Global shop is blocked by fight mode' }
$player = ReadSource 'Sources/Core/Src/KPlayer.cpp'
if ($player -notmatch 'if \(bPhongThanGlobalShop \|\|') { throw 'Global shop is restricted to its opening position' }
$core = ReadSource 'Sources/Core/Src/CoreShell.cpp'
if ($core -notmatch 'PHONGTHAN_MSG_IBSHOP_OPEN_REQUEST') { throw 'Missing native shop request' }
$dispatch = ReadSource 'Sources/Core/Src/KProtocolProcess.cpp'
foreach ($token in 'case PHONGTHAN_MSG_IBSHOP_OPEN_RESPONSE:', 'nMsgSize != sizeof(PHONGTHAN_IBSHOP_OPEN_RESPONSE)', 'nMsgSize != sizeof(PHONGTHAN_WIRE_HEADER)', 'Player[nIndex].CheckTrading()') {
    if (!$dispatch.Contains($token)) { throw "Missing shop validation: $token" }
}
foreach ($token in 'GetEquipmentMoney() < nPrice', 'SearchPosition', 'CheckTrading()', 'PHONGTHAN_MSG_IBSHOP_OPEN_RESPONSE') {
    if (!$buy.Contains($token)) { throw "Missing purchase protection: $token" }
}
'PASS: global IBShop source wiring, fight-mode exception, and purchase safeguards (not an in-game test).'
