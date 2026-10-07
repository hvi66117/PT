-- Phong Than 2026-10-02 (agent bikip): Bi kip Dien Quang Tram, magicscript 6/1/62031.
-- Right click: learn skill 31 (profession 0, level 30). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 31)
end
