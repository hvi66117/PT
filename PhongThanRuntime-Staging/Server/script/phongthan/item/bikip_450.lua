-- Phong Than 2026-10-02 (agent bikip): Bi kip Luc Si Te, magicscript 6/1/62450.
-- Right click: learn skill 450 (profession 2, level 5). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 450)
end
