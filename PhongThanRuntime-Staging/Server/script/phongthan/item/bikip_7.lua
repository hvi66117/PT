-- Phong Than 2026-10-02 (agent bikip): Bi kip Tinh Thong Loi He, magicscript 6/1/62007.
-- Right click: learn skill 7 (profession 1, level 14). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 7)
end
