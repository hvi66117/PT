-- Phong Than 2026-10-02 (agent bikip): Bi kip Tinh Thong Hoa He, magicscript 6/1/62014.
-- Right click: learn skill 14 (profession 1, level 42). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 14)
end
