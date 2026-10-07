-- Phong Than 2026-10-03 (sinhhoat): Cay Than of Tam Nguyet Ky Son (planted by lq_hatgiong.lua).
-- OnTimer (SetNpcTimer, 5 min): ripe. main: the owner harvests (also when the timer did not run because nobody
-- was near: the planted time in param 3 is checked). Timeout (30 min): removed.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function PTLQ_TreeRipe(npc)
	if GetNpcParam(npc, 2) == 1 then return 1 end
	local p = GetNpcParam(npc, 3)
	local now = PTSH_Now()
	if now - p >= PTLQ_TREE_RIPE and now >= p then return 1 end
	return 0
end

function OnTimer(npc)
	if npc == nil or npc <= 0 or GetNpcParam(npc, 0) ~= PTSH_MG_TREE then return end
	SetNpcParam(npc, 2, 1)
	SetNpcName(npc, "C\169y Th\199n (\174\183 ch\221n)")
end

function Timeout(npc)
	if npc and npc > 0 then DelNpc(npc) end
end

function main(npc)
	if npc == nil or npc <= 0 or GetNpcParam(npc, 0) ~= PTSH_MG_TREE then return end
	if GetNpcParam(npc, 1) ~= PTSH_Me() then
		Say("\167\169y l\181 C\169y Th\199n do ng\173\234i kh\184c tr\229ng.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTLQ_TreeRipe(npc) == 0 then
		local left = PTLQ_TREE_RIPE - (PTSH_Now() - GetNpcParam(npc, 3))
		if left < 0 then left = 0 end
		Say("C\169y Th\199n ch\173a ch\221n, c\223n kho\182ng " .. (floor(left / 60) + 1) .. " ph\243t.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 4 then
		Say("C\199n 4 \171 tr\232ng trong h\181nh trang \174\211 h\184i qu\182.", 1, "\167\227ng/PTSH_No")
		return
	end
	SetNpcParam(npc, 0, 0)
	DelNpc(npc)
	local lv = GetLevel()
	local e = lv * lv * 20 + 5000
	AddOwnExp(e)
	local tmax = floor(lv / 15) + 1
	if tmax > 10 then tmax = 10 end
	local i = 1
	while i <= 3 do
		local t = PTSH_Rand(1, tmax)
		PTSH_Give(3, PTSH_Pick(PTSH_MAT[1][t]), 0, 1)
		i = i + 1
	end
	local id = PTLQ_TaskId(1029, 1617)
	PTSH_Note(id, "Tam Nguy\214t K\250 S\172n", "Ho\181n th\181nh", 2)
	Msg2Player("H\184i \174\173\238c qu\182 C\169y Th\199n: " .. e .. " kinh nghi\214m v\181 3 th\182o d\173\238c.")
	PTLQ_EggChance(10)
end
