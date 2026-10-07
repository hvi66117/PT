-- Phong Than 2026-10-02 (agent bikip): Bi kip Hoanh Khong Tram, magicscript 6/1/62032.
-- Right click: learn skill 32 (profession 0, level 36). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 32)
end
