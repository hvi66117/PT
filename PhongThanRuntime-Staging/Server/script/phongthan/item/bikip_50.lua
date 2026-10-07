-- Phong Than 2026-10-02 (agent bikip): Bi kip Tat Phong Chu, magicscript 6/1/62050.
-- Right click: learn skill 50 (profession 2, level 80). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 50)
end
