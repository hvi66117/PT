-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61381 "Chien Thu Khieu Chien" (Le Quan, Khieu chien cuc han,
-- taskinfo 204 / 1615). Right click outside town: 7 challenge boars appear around the player (owned through npc
-- param 1 = player id, param 2 = start time); kills are counted in lq_mob.lua (LastDamage). Consumed on success.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function main(nItemIdx)
	if PTLQ_ChalRunning() > 0 then
		Say("Ng\173\172i \174ang trong m\233t cu\233c khi\170u chi\213n, h\183y h\185 h\213t heo th\246 th\184ch tr\173\237c.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	if PTSH_InCity() == 1 then
		Say("Trong th\181nh kh\171ng th\211 khi\170u chi\213n. H\183y ra ngo\181i th\181nh r\229i d\239ng Chi\213n Th\173.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	local n = PTLQ_SpawnChallenge()
	if n > 0 then RemoveItem(nItemIdx, 1, 0) end
	return 0
end

function PTLQ_SpawnChallenge()
	local w = GetWorldPos()
	local sw = SubWorldID2Idx(w)
	if sw == nil or sw < 0 then return 0 end
	local pn = GetPlayerNpcIdx()
	local pw, x, y = GetNpcPos(pn)
	local now = PTSH_Now()
	local me = PTSH_Me()
	local lv = GetLevel()
	local last = getn(PTLQ_MOB_OFF)
	local n = 0
	local i = 1
	while i <= last do
		local o = PTLQ_MOB_OFF[i]
		local tpl = PTLQ_MOB_TPL
		local name = "Heo R\245ng Th\246 Th\184ch"
		if i == last then
			tpl = PTLQ_BOSS_TPL
			name = "Tr\173 V\173\172ng Th\246 Th\184ch"
		end
		local m = AddNpc(tpl, lv, sw, (x + o[1]) * 32, (y + o[2]) * 32, 0)
		if m and m > 0 then
			SetNpcName(m, name)
			SetNpcScript(m, PTSH_S_MOB)
			SetNpcParam(m, 0, PTSH_MG_MOB)
			SetNpcParam(m, 1, me)
			SetNpcParam(m, 2, now)
			SetNpcTimeout(m, PTLQ_CHAL_SEC * 18)
			n = n + 1
		end
		i = i + 1
	end
	if n == 0 then
		Say("Kh\171ng th\182 \174\173\238c heo th\246 th\184ch \235 \174\169y.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	SetTask(PTLQ_T_CHAL, now)
	SetTask(PTLQ_T_KILL, PTLQ_CHAL_KILLS - n)
	Msg2Player("Khi\170u chi\213n c\249c h\185n b\190t \174\199u: h\185 " .. n .. " heo th\246 th\184ch trong 10 ph\243t!")
	return n
end
