-- questfix3 (2026-10-04): ext tick for two VNG quest steps no script was moving, called once per minute by
-- servertimer.lua (PTAdm_ExtTick -> PTEXT_questfix3_Tick, protected). ASCII only: TCVN3 / GBK as byte escapes.
--  1. Cuu Te (Di Nhan, task 34) 2 -> 3 and 4 -> 5: VNG NPC "Thu linh toc nhan bi mat tich" (taskinfo 16:
--     Cu Loc [239,192]) with the VNG script \script\chi_you_mu\shi_zong_de_zu_ren.lua (GBK path, script.pak +
--     ptfix copy with pt_compat). No placement data survives, so it is spawned here: template 1097 (VNG name
--     "shi zong de zu ren", male Di Nhan look, kind 3), cell 1916/3080 = display [239,192] (client + server grid
--     walkable, 3x3 free, large connected area; the Doc Luc quai of spawn_1013.lua specials stand 20-60 cells away).
--     PAK-only scripts are not registered at start: ReLoadScript once per state.
--  2. Khao nghiem (Dao Si, task 15) 5 -> 6: the Tuyet Nguyen Cu Thu (template 103) of spawn_1009.lua carries no
--     ActionScript; bind npc_fix\mob_drop.lua (PTDrop_Task15) to every template-103 NPC once the field
--     population is complete, then every 30 minutes (Yem Hoa, template 8, is bound by spawn_main.lua already).
-- Doc: docs\features\questfix3-phong-than-20261004.md. Lua 4: no true/false, no local function.

PTQ3_NPCS = {
	-- key, map, template, mpsX, mpsY, name (TCVN3 "Thu Linh Toc Nhan"), script
	{ "toclinh1013", 1013, 1097, 61312, 98560, "Th\241 L\220nh T\233c Nh\169n", "\\script\\\242\191\211\200\196\185\\\202\167\215\217\181\196\215\229\200\203.lua" },
}
PTQ3_DROP_TPL = { [103] = 1 }
PTQ3_DROP_SCRIPT = "\\script\\phongthan\\npc_fix\\mob_drop.lua"
if PTQ3_SPAWNED == nil then PTQ3_SPAWNED = {} end
if PTQ3_TICKS == nil then PTQ3_TICKS = 0 end
PTQ3_LAST = { spawned = 0, bound = 0 }

function PTQ3_MaxNpc()
	if PTADM_MAX_NPC then return PTADM_MAX_NPC end
	return 48000
end

function PTQ3_Nop() end

function PTQ3_Register()
	local k = 1
	while PTQ3_NPCS[k] do
		call(ReLoadScript, { PTQ3_NPCS[k][7] }, "x", PTQ3_Nop)
		k = k + 1
	end
end

function PTQ3_EnsureNpcs()
	local n = 0
	local k = 1
	while PTQ3_NPCS[k] do
		local s = PTQ3_NPCS[k]
		local ni = PTQ3_SPAWNED[k]
		local ok = nil
		if ni and ni > 0 and GetNpcName(ni) == s[6] then
			local w = GetNpcPos(ni)
			if w == s[2] then ok = 1 end
		end
		if not ok then
			PTQ3_SPAWNED[k] = nil
			local sw = SubWorldID2Idx(s[2])
			if sw and sw >= 0 then
				ni = AddNpc(s[3], 1, sw, s[4], s[5], 0)
				if ni and ni > 0 then
					SetNpcName(ni, s[6])
					SetNpcScript(ni, s[7])
					PTQ3_SPAWNED[k] = ni
					n = n + 1
				end
			end
		end
		k = k + 1
	end
	return n
end

function PTQ3_BindDrops()
	local n = 0
	local i = 1
	local mx = PTQ3_MaxNpc()
	while i < mx do
		local id = GetNpcID(i)
		if id and id ~= 0 and PTQ3_DROP_TPL[GetNpcTemplateID(i) or 0] then
			SetNpcScript(i, PTQ3_DROP_SCRIPT)
			n = n + 1
		end
		i = i + 1
	end
	return n
end

function PTEXT_questfix3_Tick()
	if not PTQ3_INIT then
		PTQ3_Register()
		PTQ3_INIT = 1
	end
	PTQ3_LAST.spawned = PTQ3_EnsureNpcs()
	if PT_SPAWN_DONE or PTQ3_TICKS >= 15 then
		if (not PTQ3_DROP_AT) or PTQ3_TICKS - PTQ3_DROP_AT >= 30 then
			PTQ3_LAST.bound = PTQ3_BindDrops()
			PTQ3_DROP_AT = PTQ3_TICKS
		end
	end
	PTQ3_TICKS = PTQ3_TICKS + 1
end
