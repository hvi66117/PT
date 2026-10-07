-- Phong Than exit NPC 2026-09-28: map 1002 -> 1005 (chongchengyewai). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from VNG script.pak \\script\\trap\\[GBK chongchengdaying]to[GBK chongchengyewai].lua.
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>Sïng thµnh<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi Sïng thµnh/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn Sïng thµnh")
	NewWorld(5,1808,2943)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
