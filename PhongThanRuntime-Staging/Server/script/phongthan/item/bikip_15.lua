-- Phong Than 2026-10-02 (agent bikip): Bi kip Phong Van Loi Dong, magicscript 6/1/62015.
-- Right click: learn skill 15 (profession 1, level 46). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 15)
end
