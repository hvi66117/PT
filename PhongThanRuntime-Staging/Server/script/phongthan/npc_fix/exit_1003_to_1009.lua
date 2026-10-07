-- Phong Than exit NPC 2026-09-28: map 1003 -> 1009 (xikunlun). Fallback/visible marker for the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- map-edge trap; destination copied from VNG script.pak \\script\\trap\\[GBK yuxugong]to[GBK xikunlun].lua.
-- NewWorld(id 1..118 -> 10xx, x, y in GetWorldPos units = mps/32).

function main()
	Say("Cæng dÞch chuyÓn nµy dÉn tíi <color=yellow>T©y C«n L«n<color>. B¹n cã muèn ®i kh«ng?", 2, "§i tíi T©y C«n L«n/go", "KÕt thóc ®èi tho¹i/no")
end;

function go()
	Msg2Player("§· ®Õn T©y C«n L«n")
	NewWorld(9,1843,3762)
	SetFightState(1)
	CloseDialog()
end;

function no()
	CloseDialog()
end;
