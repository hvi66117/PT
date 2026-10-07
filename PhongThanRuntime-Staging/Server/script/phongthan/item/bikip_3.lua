-- Phong Than 2026-10-02 (agent bikip): Bi kip Chuong Tam Loi, magicscript 6/1/62003.
-- Right click: learn skill 3 (profession 1, level 4). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 3)
end
