-- Phong Than 2026-10-02 (agent bikip): Bi kip Bang Tuyet Dan, magicscript 6/1/62005.
-- Right click: learn skill 5 (profession 1, level 8). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 5)
end
