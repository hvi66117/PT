-- Phong Than exit NPC 2026-09-28: map 1002 -> 1007 (yanshan). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from VNG script.pak \\script\\trap\\[GBK chongchengdaying]to[GBK yanshan].lua.
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>Yªn S¬n<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi Yªn S¬n/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn Yªn S¬n")
	NewWorld(7,1609,3204)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
