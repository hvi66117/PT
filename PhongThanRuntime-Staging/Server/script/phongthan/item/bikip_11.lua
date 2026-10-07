-- Phong Than 2026-10-02 (agent bikip): Bi kip Han Dia Loi, magicscript 6/1/62011.
-- Right click: learn skill 11 (profession 1, level 30). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 11)
end
