-- Phong Than 2026-10-02 (agent bikip): Bi kip Khuynh Thanh Nhat Kich, magicscript 6/1/62042.
-- Right click: learn skill 42 (profession 0, level 90). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 42)
end
