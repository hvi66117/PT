-- Phong Than exit NPC 2026-09-28: map 1002 -> 1006 (beihai). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from VNG script.pak \\script\\trap\\[GBK chongchengdaying]to[GBK beihai].lua.
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>B¾c H¶i<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi B¾c H¶i/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn B¾c H¶i")
	NewWorld(6,1922,2798)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
