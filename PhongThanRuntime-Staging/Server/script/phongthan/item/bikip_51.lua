-- Phong Than 2026-10-02 (agent bikip): Bi kip Van Cot Toan Kho, magicscript 6/1/62051.
-- Right click: learn skill 51 (profession 2, level 90). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 51)
end
