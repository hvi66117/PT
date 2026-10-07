-- Phong Than 2026-10-02 (agent bikip): Bi kip Ban Mon Long Phu, magicscript 6/1/62128.
-- Right click: learn skill 128 (profession -1, level 1). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 128)
end
