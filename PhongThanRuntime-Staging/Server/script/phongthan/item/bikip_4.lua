-- Phong Than 2026-10-02 (agent bikip): Bi kip Luu Tinh Thach, magicscript 6/1/62004.
-- Right click: learn skill 4 (profession 1, level 6). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 4)
end
