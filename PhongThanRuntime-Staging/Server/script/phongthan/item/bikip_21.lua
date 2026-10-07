-- Phong Than 2026-10-02 (agent bikip): Bi kip Bang Phong Bao, magicscript 6/1/62021.
-- Right click: learn skill 21 (profession 1, level 70). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 21)
end
