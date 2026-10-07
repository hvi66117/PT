-- Phong Than 2026-10-02 (agent bikip): Bi kip Tich Lich Hoa, magicscript 6/1/62006.
-- Right click: learn skill 6 (profession 1, level 10). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 6)
end
