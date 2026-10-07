-- Phong Than 2026-10-02 (agent bikip): Bi kip Thien Quan Tram, magicscript 6/1/62041.
-- Right click: learn skill 41 (profession 0, level 84). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 41)
end
