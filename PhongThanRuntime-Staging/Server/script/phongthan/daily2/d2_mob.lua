-- Phong Than 2026-10-03 (daily2): script of the field monsters of Thien Cuong Hon, Sieu Do and Hap Hon
-- (SetNpcScript + SetNpcTimer by d2_core.lua PTD2_AddMob). No edit of script\npcdeath\normal.lua.
-- NPC params: 5 = PTD2_MAGIC, 6 = pack key, 7 = owner PlayerIndex, 8 = quest code * 1000 + tag.
-- * LastDamage (KNpc::DoDeath, run as the killer): the kill is credited to the OWNER when his current
--   pack key still matches (team mates may help); the monster is deleted in DeathSelf (a DelNpc inside
--   the death handler is deferred, same pattern as ptfix extra_questfix.py).
-- * OnTimer (every PTD2_LIFE seconds): re-armed while the owner keeps this pack and stands on its map,
--   otherwise the monster is deleted (owner offline, round finished or cancelled, newer pack).
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

if PTD2_DELS == nil then PTD2_DELS = {} end

function PTD2_MobErr(m)
end

-- runs with PlayerIndex = owner; 1 when the owner still owns this pack
function PTD2_OwnerOk(npc)
	local nm = GetName()
	if nm == nil or nm == "" then return nil end
	if GetTask(PTD2_T_PK_KEY) ~= GetNpcParam(npc, 6) then return nil end
	return 1
end

function PTD2_OnKill(code, tag, npc)
	if code == PTD2_CODE_TCH then
		local st = GetTask(PTD2_T_TCH_STATE)
		local map, sname = mod(GetTask(PTD2_T_TCH_INFO), 10000), (PTD2_STARS[floor(GetTask(PTD2_T_TCH_INFO) / 10000)] or "Thiªn C­¬ng") .. " Tinh"
		if tag == 1 and st == 1 then
			local k = GetTask(PTD2_T_TCH_KILL) + 1
			SetTask(PTD2_T_TCH_KILL, k)
			if k >= PTD2_TCH_SHADOWS then
				SetTask(PTD2_T_TCH_STATE, 2)
				local w, x, y = GetNpcWorldPos(npc)
				PTD2_TchSpawn(x, y)
				TaskNote(53, 2)
				Msg2Player(PTD2_ColR .. sname .. " ®· hiÖn th©n!" .. PTD2_ColE .. " H·y ®Ých th©n hµng phôc nã.")
			else
				TaskNote(53, 3, k)
				Msg2Player("§· diÖt ¶nh Tö thø " .. k .. "/" .. PTD2_TCH_SHADOWS .. " cña " .. sname .. ".")
			end
		elseif tag == 2 and st == 2 then
			SetTask(PTD2_T_TCH_STATE, 3)
			PTD2_DropPack()
			TaskNote(53, 8)
			Msg2Player(PTD2_ColG .. "Hµng phôc " .. sname .. " thµnh c«ng, nhËn ®­îc 1 Hån." .. PTD2_ColE .. " VÒ Phong ThÇn §µi gÆp ¢n Giao.")
		end
		return
	end
	if code == PTD2_CODE_SD then
		if GetTask(PTD2_T_SD_STATE) ~= 1 then return end
		local sp = PTD2_SD_SPOTS[GetTask(PTD2_T_SD_INFO)]
		if not sp then return end
		local c = GetTask(PTD2_T_SD_CNT)
		local ca, cb = floor(c / 100), mod(c, 100)
		if tag == 1 and ca < PTD2_SD_NEED then ca = ca + 1 elseif tag == 2 and cb < PTD2_SD_NEED then cb = cb + 1 else return end
		SetTask(PTD2_T_SD_CNT, ca * 100 + cb)
		local na, nb = PTD2_MobName(sp[2]), PTD2_MobName(sp[6])
		if ca >= PTD2_SD_NEED and cb >= PTD2_SD_NEED then
			SetTask(PTD2_T_SD_STATE, 2)
			PTD2_DropPack()
			TaskNote(48, 2)
			Msg2Player(PTD2_ColG .. "§· siªu ®é ®ñ linh hån." .. PTD2_ColE .. " VÒ Phong ThÇn §µi gÆp ¢n Hång tr¶ nhiÖm vô.")
		else
			TaskNote(48, 1, na, ca, nb, cb)
			Msg2Player("Siªu ®é: " .. na .. " " .. ca .. "/" .. PTD2_SD_NEED .. ", " .. nb .. " " .. cb .. "/" .. PTD2_SD_NEED .. ".")
		end
		return
	end
	if code == PTD2_CODE_HH then
		if GetTask(PTD2_T_HH_STATE) ~= 1 or tag ~= 1 then return end
		local t = PTD2_HH_TARGETS[floor(GetTask(PTD2_T_HH_INFO) / 10)]
		if not t then return end
		local k = GetTask(PTD2_T_HH_CNT) + 1
		SetTask(PTD2_T_HH_CNT, k)
		TaskNote(70, 1, k, t[2])
		if k >= PTD2_HH_NEED then
			SetTask(PTD2_T_HH_STATE, 2)
			PTD2_DropPack()
			Msg2Player(PTD2_ColG .. "§· ®o¹t ®ñ " .. PTD2_HH_NEED .. " hån ph¸ch cña " .. t[2] .. "." .. PTD2_ColE .. " VÒ gÆp ThuyÒn phu nhËn th­ëng.")
		else
			Msg2Player("§· ®o¹t " .. k .. "/" .. PTD2_HH_NEED .. " hån ph¸ch cña " .. t[2] .. ".")
		end
	end
end

function PTD2_MobDeath(npc)
	if GetNpcParam(npc, 5) ~= PTD2_MAGIC then return end
	PTD2_DELS[npc] = 1
	local tag = GetNpcParam(npc, 8)
	local owner = GetNpcParam(npc, 7)
	if owner == nil or owner <= 0 then return end
	local old = PlayerIndex
	PlayerIndex = owner
	if PTD2_OwnerOk(npc) then
		local a = GetTask(PTD2_T_PK_ALIVE) - 1
		if a < 0 then a = 0 end
		SetTask(PTD2_T_PK_ALIVE, a)
		call(PTD2_OnKill, { floor(tag / 1000), mod(tag, 1000), npc }, "x", PTD2_MobErr)
	end
	PlayerIndex = old
end

function LastDamage(npc)
	call(PTD2_MobDeath, { npc }, "x", PTD2_MobErr)
end

function DeathSelf(npc)
	if PTD2_DELS[npc] then
		PTD2_DELS[npc] = nil
		DelNpc(npc)
	end
end

function Revive(npc)
end

function PTD2_MobTimer(npc)
	if GetNpcParam(npc, 5) ~= PTD2_MAGIC then return end
	local owner = GetNpcParam(npc, 7)
	local keep = nil
	local old = PlayerIndex
	if owner and owner > 0 then
		PlayerIndex = owner
		if PTD2_OwnerOk(npc) then
			local w = GetNpcWorldPos(npc)
			local m = PTD2_MyPos()
			if PTD2_MapId(w) == m then
				keep = 1
				SetTask(PTD2_T_PK_TIME, SystemTime())
			elseif mod(GetNpcParam(npc, 8), 1000) ~= 9 then
				local a = GetTask(PTD2_T_PK_ALIVE) - 1
				if a < 0 then a = 0 end
				SetTask(PTD2_T_PK_ALIVE, a)
			end
		end
	end
	PlayerIndex = old
	if keep then
		SetNpcTimer(npc, PTD2_MOB_SCRIPT, PTD2_LIFE)
	else
		DelNpc(npc)
	end
end

function OnTimer(npc)
	call(PTD2_MobTimer, { npc }, "x", PTD2_MobErr)
end
