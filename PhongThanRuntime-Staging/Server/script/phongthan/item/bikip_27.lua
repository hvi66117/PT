-- Phong Than 2026-10-02 (agent bikip): Bi kip Te Huyet Tram, magicscript 6/1/62027.
-- Right click: learn skill 27 (profession 0, level 6). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 27)
end
