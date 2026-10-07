-- Phong Than 2026-10-03 (daily3): script of the field monsters of Ma De (souls) and Luc Lam (convoy cart + guards),
-- bound by d3_core.lua PTD3_AddMob (SetNpcScript + SetNpcTimer). Same scheme as daily2\d2_mob.lua:
-- params 5 = PTD3_MAGIC, 6 = pack key, 7 = owner PlayerIndex, 8 = code * 1000 + tag.
-- * LastDamage (run as the killer): credited to the OWNER while his pack key matches (team mates may help);
--   the monster is deleted in DeathSelf (DelNpc inside the death handler is deferred).
-- * OnTimer (every PTD3_LIFE seconds): re-armed while the owner keeps this pack and stands on its map, else deleted.
Include("\\script\\phongthan\\daily3\\d3_lib.lua")

if PTD3_DELS == nil then PTD3_DELS = {} end

function PTD3_MobErr(m)
end

function PTD3_OwnerOk(npc)
	local nm = GetName()
	if nm == nil or nm == "" then return nil end
	if GetTask(PTD3_T_FK_KEY) ~= GetNpcParam(npc, 6) then return nil end
	return 1
end

function PTD3_OnKill(code, tag, npc)
	if code == PTD3_CODE_MD then
		if GetTask(PTD3_T_MD_STATE) ~= 1 then return end
		local sp = PTD2_SD_SPOTS[GetTask(PTD3_T_MD_INFO)]
		if not sp then return end
		local c = GetTask(PTD3_T_MD_CNT)
		local ca, cb = floor(c / 100), mod(c, 100)
		if tag == 1 and ca < PTD3_MD_NEED then ca = ca + 1 elseif tag == 2 and cb < PTD3_MD_NEED then cb = cb + 1 else return end
		SetTask(PTD3_T_MD_CNT, ca * 100 + cb)
		local na, nb = PTD2_MobName(sp[2]), PTD2_MobName(sp[6])
		if ca >= PTD3_MD_NEED and cb >= PTD3_MD_NEED then
			SetTask(PTD3_T_MD_STATE, 2)
			PTD3_DropPack()
			TaskNote(81, 2)
			Msg2Player(PTD2_ColG .. "M· §Õ: ®· siªu ®é ®ñ linh hån." .. PTD2_ColE .. " VÒ Phong ThÇn §µi gÆp ¢n Hång giao linh khÝ.")
		else
			TaskNote(81, 1, na, ca, nb, cb)
			Msg2Player("M· §Õ: " .. na .. " " .. ca .. "/" .. PTD3_MD_NEED .. ", " .. nb .. " " .. cb .. "/" .. PTD3_MD_NEED .. ".")
		end
		return
	end
	if code == PTD3_CODE_LL then
		if tag ~= 2 or GetTask(PTD3_T_LL_JOB) ~= 1 then return end
		local kind = GetTask(PTD3_T_LL_KIND)
		PTD3_LL_ClearJob()
		PTD3_LL_GrantFlag(kind)
	end
end

function PTD3_MobDeath(npc)
	if GetNpcParam(npc, 5) ~= PTD3_MAGIC then return end
	PTD3_DELS[npc] = 1
	local tag = GetNpcParam(npc, 8)
	local owner = GetNpcParam(npc, 7)
	if owner == nil or owner <= 0 then return end
	local old = PlayerIndex
	PlayerIndex = owner
	if PTD3_OwnerOk(npc) then
		local a = GetTask(PTD3_T_FK_ALIVE) - 1
		if a < 0 then a = 0 end
		SetTask(PTD3_T_FK_ALIVE, a)
		call(PTD3_OnKill, { floor(tag / 1000), mod(tag, 1000), npc }, "x", PTD3_MobErr)
	end
	PlayerIndex = old
end

function LastDamage(npc)
	call(PTD3_MobDeath, { npc }, "x", PTD3_MobErr)
end

function DeathSelf(npc)
	if PTD3_DELS[npc] then
		PTD3_DELS[npc] = nil
		DelNpc(npc)
	end
end

function Revive(npc)
end

function PTD3_MobTimer(npc)
	if GetNpcParam(npc, 5) ~= PTD3_MAGIC then return end
	local owner = GetNpcParam(npc, 7)
	local keep = nil
	local old = PlayerIndex
	if owner and owner > 0 then
		PlayerIndex = owner
		if PTD3_OwnerOk(npc) then
			local w = GetNpcWorldPos(npc)
			local m = PTD2_MyPos()
			if PTD2_MapId(w) == m then
				keep = 1
				SetTask(PTD3_T_FK_TIME, SystemTime())
			elseif mod(GetNpcParam(npc, 8), 1000) ~= 9 then
				local a = GetTask(PTD3_T_FK_ALIVE) - 1
				if a < 0 then a = 0 end
				SetTask(PTD3_T_FK_ALIVE, a)
			end
		end
	end
	PlayerIndex = old
	if keep then
		SetNpcTimer(npc, PTD3_MOB_SCRIPT, PTD3_LIFE)
	else
		DelNpc(npc)
	end
end

function OnTimer(npc)
	call(PTD3_MobTimer, { npc }, "x", PTD3_MobErr)
end
