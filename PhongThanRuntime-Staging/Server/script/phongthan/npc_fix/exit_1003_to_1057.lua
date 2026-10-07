-- Phong Than exit NPC 2026-09-28: map 1003 -> 1057 (kuangchang). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from authored: VNG trap script \\script\\trap\\[GBK yuxugong]to[GBK kuangchang].lua is absent from every PAK; target from VNG SuperTrap (NewWorld(57,1608,3094)).
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>Kho¸ng tr­êng<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi Kho¸ng tr­êng/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn Kho¸ng tr­êng")
	NewWorld(57,1608,3094)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
