-- Phong Than 2026-10-02 (agent bikip): VNG genre-7 skill book (settings\item\001\skillbook.txt).
-- Not reachable yet: KItemList::ExecuteScript returns early for genre 7. Kept for a C++ hook that runs
-- this file for item_skillbook; until then old books are converted at Vo su Tay Ky / Trieu Ca.
Include("\\script\\phongthan\\lib\\pt_bikip.lua")

function main(nItemIdx)
	return PTBK_UseSkillBook7(nItemIdx)
end
