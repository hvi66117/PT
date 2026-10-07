-- Phong Than 2026-10-02 (agent bikip): Bi kip Thap Phuong Liet Hoa, magicscript 6/1/62018.
-- Right click: learn skill 18 (profession 1, level 58). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 18)
end
