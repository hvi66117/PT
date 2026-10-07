-- Phong Than 2026-10-02 (agent bikip): Bi kip Thiet Ma Bang Qua, magicscript 6/1/62013.
-- Right click: learn skill 13 (profession 1, level 38). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 13)
end
