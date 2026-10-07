-- Phong Than 2026-10-03 (newbie2): mat tich / lenh items 6/1/303-309 and 6/1/350-356 (taskinfo 914-925, 1009, 1010).
-- magicscript.txt points them at GBK paths (\script\item\huangou juanzhou.lua ...) that cannot be read as loose files;
-- ptfix (extra_newbie2.py) puts a stub at each GBK path: Include this file + main(idx) -> PTNB2_ScrollUse(idx, part).
-- Accepting consumes the item and starts counting (nb2_mob.lua); turn in at Tap hoa Thuong or Quan Su (Tan thu).
Include("\\script\\phongthan\\newbie2\\nb2_lib.lua")

function PTNB2_ScrollUse(idx, part)
	local i = PTNB2_ScrollIndex(part)
	if i == nil then return 0 end
	PTNB2_SC_IDX = idx
	PTNB2_SC_I = i
	local sc = PTNB2_SCROLL[i]
	if PTNB2_ScGet(i) > 0 then
		Talk(1, "no", PTNB2_TXT.sc_busy)
		return 0
	end
	Say(PTNB2_TXT.sc_ask .. PTNB2_Title(sc[2]) .. PTNB2_TXT.sc_ask2, 2, PTNB2_TXT.sc_yes .. "/PTNB2_ScrollYes", PTNB2_TXT.sc_no .. "/no")
	return 0
end

function PTNB2_ScrollYes()
	local i = PTNB2_SC_I
	if i == nil then return end
	local sc = PTNB2_SCROLL[i]
	local p = PTNB2_Prof()
	if p == nil then return end
	if PTNB2_ScGet(i) > 0 then
		Talk(1, "no", PTNB2_TXT.sc_busy)
		return
	end
	local before = HaveNormalItem(6, 1, sc[1], 1)
	if before < 1 then
		Talk(1, "no", PTNB2_TXT.sc_noitem)
		return
	end
	-- consume exactly this scroll: by item index when it is still this item, else by type (VNG way)
	if PTNB2_SC_IDX and PTNB2_SC_IDX > 0 and GetItemPartByID(PTNB2_SC_IDX) == sc[1] then
		RemoveItem(PTNB2_SC_IDX, 1, 0)
	end
	if HaveNormalItem(6, 1, sc[1], 1) >= before then DelNormalItem(6, 1, sc[1], 1) end
	if HaveNormalItem(6, 1, sc[1], 1) >= before then
		Talk(1, "no", PTNB2_TXT.sc_noitem)
		return
	end
	PTNB2_SC_IDX = nil
	PTNB2_ScSet(i, 1)
	local n = 0
	if sc[3] < 0 then n = PTNB2_C917[p][1] end
	PTNB2_Note(sc[2], n)
	Msg2Player(PTNB2_TXT.sc_got .. PTNB2_Title(sc[2]))
	Talk(1, "no", PTNB2_TXT.sc_got .. PTNB2_Title(sc[2]) .. ". " .. PTNB2_StepText(sc[2], n, {}))
end

function no()
	CloseDialog()
end
