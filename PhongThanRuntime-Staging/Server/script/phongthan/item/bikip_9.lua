-- Phong Than 2026-10-02 (agent bikip): Bi kip Bang Co Tuyet Cot, magicscript 6/1/62009.
-- Right click: learn skill 9 (profession 1, level 22). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 9)
end
