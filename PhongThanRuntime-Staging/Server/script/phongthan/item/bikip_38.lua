-- Phong Than 2026-10-02 (agent bikip): Bi kip Lien Hoan Tram, magicscript 6/1/62038.
-- Right click: learn skill 38 (profession 0, level 66). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 38)
end
