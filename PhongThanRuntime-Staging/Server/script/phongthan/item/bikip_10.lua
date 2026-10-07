-- Phong Than 2026-10-02 (agent bikip): Bi kip Phong Lam Hoa Son, magicscript 6/1/62010.
-- Right click: learn skill 10 (profession 1, level 26). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 10)
end
