-- Phong Than 2026-10-02 (agent bikip): Bi kip Tram Tam Chu, magicscript 6/1/62049.
-- Right click: learn skill 49 (profession 2, level 70). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 49)
end
