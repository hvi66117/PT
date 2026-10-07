-- Phong Than 2026-10-02 (agent bikip): Bi kip Bang Phong Van Ly, magicscript 6/1/62025.
-- Right click: learn skill 25 (profession 1, level 86). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 25)
end
