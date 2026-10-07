-- Phong Than 2026-10-02 (agent bikip): Bi kip Ngu Nhac Trieu Tong, magicscript 6/1/62016.
-- Right click: learn skill 16 (profession 1, level 50). Logic in pt_bikip.lua.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseBook(nItemIdx, 16)
end
