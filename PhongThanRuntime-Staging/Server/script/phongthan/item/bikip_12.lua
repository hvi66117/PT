-- Phong Than 2026-10-02 (agent bikip): Bi kip Tinh Thong Tho He, magicscript 6/1/62012.
-- Right click: learn skill 12 (profession 1, level 34). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 12)
end
