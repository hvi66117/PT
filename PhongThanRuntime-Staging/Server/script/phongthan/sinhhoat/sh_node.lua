-- Phong Than 2026-10-03 (sinhhoat): gather node (herb bush / ore vein / fishing spot). Spawned and respawned by
-- script\phongthan\ext\sinhhoat.lua; npc param 0 = 2370100 + type (1 herb, 2 ore, 3 fish), param 1 = uses left.
-- One click = one gather (cooldown PTSH_COOLDOWN seconds); the node disappears after PTSH_NODE_USES gathers and
-- the ext tick puts it back a few minutes later.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTSH_NODE_TITLE = { "B\244i th\182o d\173\238c", "M\185ch kho\184ng", "\167i\211m c\169u c\184" }
PTSH_NODE_VERB = { "h\184i", "\174\181o", "c\169u" }

function main(npc)
	if npc == nil or npc <= 0 then return end
	local typ = GetNpcParam(npc, 0) - PTSH_MG_NODE
	if typ < 1 or typ > 3 then return end
	SetTask(PTSH_T_DLG, npc)
	PTSH_Gather(npc, typ)
end

function PTSH_Gather(npc, typ)
	local k = typ          -- skill index = node type (1 herb, 2 ore, 3 fish)
	if typ == 2 and PTSH_HasBook(PTSH_BOOK_GATHER) == 0 then
		Say("<color=green>" .. PTSH_NODE_TITLE[typ] .. "<color>: mu\232n khai kho\184ng ph\182i l\220nh h\233i k\252 n\168ng s\232ng <color=yellow>B\181n C\230 Khai Thi\170n<color> (Sinh Ho\185t S\173 d\185y, ho\198c d\239ng b\221 k\221p).", 1, "\167\227ng/PTSH_No")
		return
	end
	local now = PTSH_Now()
	local last = GetTask(PTSH_T_GTIME)
	if now - last < PTSH_COOLDOWN and now >= last then
		Msg2Player("\167ang " .. PTSH_NODE_VERB[typ] .. ", h\183y ch\234 m\233t ch\243t r\229i b\202m l\185i.")
		return
	end
	if PTSH_Free() < 1 then
		Say("H\181nh trang \174\183 \174\199y, kh\171ng c\223n ch\231 ch\248a.", 1, "\167\227ng/PTSH_No")
		return
	end
	local left = GetNpcParam(npc, 1)
	if left <= 0 then
		Msg2Player("N\172i n\181y \174\183 c\185n, h\183y t\215m ch\231 kh\184c.")
		return
	end
	SetTask(PTSH_T_GTIME, now)
	local lv = PTSH_SkillLevel(k)
	local t = PTSH_Rand(lv - 2, lv)
	if t < 1 then t = 1 end
	local id = PTSH_Pick(PTSH_MAT[typ][t])
	local n = 1
	if typ == 2 and PTSH_Rand(1, 100) <= 20 then n = 2 end
	local got = PTSH_Give(3, id, 0, n)
	if got <= 0 then
		Msg2Player("Kh\171ng nh\203n \174\173\238c v\203t ph\200m (h\181nh trang \174\199y?).")
		return
	end
	Msg2Player("\167\183 " .. PTSH_NODE_VERB[typ] .. " \174\173\238c " .. got .. " nguy\170n li\214u c\202p " .. t .. ".")
	if typ == 2 and lv >= 4 and PTSH_Rand(1, 100) <= 5 then
		local c = PTSH_Pick(PTSH_CRYSTAL)
		if PTSH_Give(3, c[1], 0, 1) > 0 then Msg2Player("May m\190n! \167\181o \174\173\238c m\233t vi\170n Th\241y Tinh Nguy\170n Th\185ch.") end
	end
	PTSH_AddSkillExp(k, 2 + floor(t / 3))
	left = left - 1
	SetNpcParam(npc, 1, left)
	if left <= 0 then
		DelNpc(npc)
	end
end

function Timeout(npc)
	if npc and npc > 0 then DelNpc(npc) end
end
