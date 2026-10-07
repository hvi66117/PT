-- Phong Than 2026-10-02 (agent bikip): Bi kip Thien Bang Dia Liet, magicscript 6/1/62020.
-- Right click: learn skill 20 (profession 1, level 66). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 20)
end
