-- ct_vequan.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "Ve quan" in Trieu Ca (1021): step 0 of taskinfo 79 "Diep bao" (solo: any hour, no curfew check).
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")

function main()
	if GetTask(PTCT_T_79) == 1 then
		SetTask(PTCT_T_79, 2)
		TaskNote(79, 4)
		Talk(1, "PTCT_No", "Su\254t... Ng\173\172i l\181 ng\173\234i c\241a H\253 vi\214n? Kho l\173\172ng l\183nh \174\222a \174\232i \174\222ch d\249a v\181o <color=green>X\221ch \167\229ng Th\182o<color> \235 r\215a t\169y nam T\169y K\250. Ph\184 ho\185i n\227 \174i!")
		return
	end
	Talk(1, "PTCT_No", "V\214 qu\169n Tri\210u Ca: Gi\234 gi\237i nghi\170m, k\206 l\185 kh\171ng \174\173\238c l\182ng v\182ng!")
end
