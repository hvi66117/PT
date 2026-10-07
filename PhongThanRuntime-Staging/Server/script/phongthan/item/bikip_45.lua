-- Phong Than 2026-10-02 (agent bikip): Bi kip Bo Tam Chu, magicscript 6/1/62045.
-- Right click: learn skill 45 (profession 2, level 30). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 45)
end
