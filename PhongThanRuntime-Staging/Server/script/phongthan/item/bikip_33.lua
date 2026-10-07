-- Phong Than 2026-10-02 (agent bikip): Bi kip Tinh Thong Doan Dao, magicscript 6/1/62033.
-- Right click: learn skill 33 (profession 0, level 42). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 33)
end
