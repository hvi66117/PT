-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61379 "Linh Thu Don" (pet food). Right click: the active pet gets
-- PTLT_FOOD_EXP exp; consumed only when the pet really gained exp (not at the stage cap).
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function main(nItemIdx)
	local r = PTLT_Feed()
	if r < 0 then
		Say("Ng\173\172i ch\173a c\227 linh th\243. G\198p Linh Th\243 S\248 \235 T\169y K\250 ho\198c Tri\210u Ca.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	if r == 0 then
		Say("Linh th\243 \174\183 \174\185t gi\237i h\185n c\202p c\241a giai \174o\185n n\181y, h\183y t\215m Linh Th\243 S\248 \174\211 ti\213n h\227a.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	RemoveItem(nItemIdx, 1, 0)
	Msg2Player("Linh th\243 nh\203n " .. r .. " \174i\211m kinh nghi\214m. " .. PTLT_Label(GetTask(PTLT_T_ACT)) .. ".")
	return 0
end
