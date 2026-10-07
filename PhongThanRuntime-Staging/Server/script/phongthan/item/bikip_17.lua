-- Phong Than 2026-10-02 (agent bikip): Bi kip Tinh Thong Bang He, magicscript 6/1/62017.
-- Right click: learn skill 17 (profession 1, level 54). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 17)
end
