-- Phong Than exit NPC 2026-09-28: map 1004 -> 1013 (julu). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from VNG script.pak \\script\\trap\\[GBK chiyoumu]to[GBK julu].lua.
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>Cù Léc<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi Cù Léc/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn Cù Léc")
	NewWorld(13,1584,3212)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
