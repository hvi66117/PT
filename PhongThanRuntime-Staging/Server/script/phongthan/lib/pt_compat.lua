-- pt_compat.lua  (Lua 4, Phong Than GameServer)
-- Included as the first line of every VNG script that ptfix.pak overrides
-- (scripts that call TaskNote or SayTask). It:
--   1. installs TaskNote = PTTaskNote (readable F11 quest-log text, see vng_tasknote.lua);
--   2. wraps SayTask so every menu gets a "Ket thuc doi thoai" row when the script
--      did not provide a way out (the rebuilt SayTask never adds one).
-- File stays ASCII; Vietnamese text is written as TCVN3 byte escapes.

Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

-- "Ket thuc doi thoai" (TCVN3)
PT_COMPAT_EXIT = "K\213t th\243c \174\232i tho\185i"

if PT_SayTask_C == nil and SayTask ~= nil and SayTask ~= PTCompat_SayTask then
	PT_SayTask_C = SayTask
end

function PTCompat_Close()
	CloseDialog()
end

function PTCompat_IsExit(label, fn)
	if fn == nil or fn == "" then
		return 1
	end
	local f = strlower(fn)
	if f == "no" or f == "cancel" or f == "oncancel" or f == "exit" or f == "ptcompat_close" then
		return 1
	end
	if strsub(f, 1, 3) == "no_" or strsub(f, 1, 4) == "exit" or strsub(f, 1, 3) == "end" or strsub(f, 1, 5) == "close" then
		return 1
	end
	if label ~= nil and strfind(label, PT_COMPAT_EXIT, 1, 1) then
		return 1
	end
	return 0
end

function PTCompat_SayTask(id, tasks, ...)
	if type(tasks) == "table" then
		local n = getn(tasks)
		local hasExit = 0
		local i = 1
		while i <= n do
			local t = tasks[i]
			if type(t) == "table" and (t.show == nil or t.show ~= 0) and PTCompat_IsExit(t[1], t[2]) == 1 then
				hasExit = 1
			end
			i = i + 1
		end
		if hasExit == 0 then
			-- copy: scripts sometimes keep the menu table in a global and reuse it
			local c = {}
			i = 1
			while i <= n do
				c[i] = tasks[i]
				i = i + 1
			end
			c[n + 1] = { PT_COMPAT_EXIT, "PTCompat_Close"; show = 1 }
			tasks = c
		end
	end
	return PT_SayTask_C(id, tasks)
end

if PT_SayTask_C ~= nil then
	SayTask = PTCompat_SayTask
end

-- Say(text, n, "label/func", ...): same exit-row rule for plain string menus.
if PT_Say_C == nil and Say ~= nil and Say ~= PTCompat_Say then
	PT_Say_C = Say
end

function PTCompat_Say(text, n, ...)
	local cnt = tonumber(n)
	if cnt ~= nil and cnt > 0 and cnt == arg.n then
		local hasExit = 0
		local i = 1
		while i <= arg.n do
			local s = arg[i]
			if type(s) ~= "string" then
				hasExit = 1
			else
				local p = strfind(s, "/", 1, 1)
				local fn = ""
				local lab = s
				if p then
					lab = strsub(s, 1, p - 1)
					fn = strsub(s, p + 1)
				end
				if PTCompat_IsExit(lab, fn) == 1 then
					hasExit = 1
				end
			end
			i = i + 1
		end
		if hasExit == 0 then
			arg[arg.n + 1] = PT_COMPAT_EXIT .. "/PTCompat_Close"
			arg.n = arg.n + 1
			cnt = cnt + 1
		end
	end
	local t = { text, cnt or n }
	local i = 1
	while i <= arg.n do
		t[i + 2] = arg[i]
		i = i + 1
	end
	t.n = arg.n + 2
	return call(PT_Say_C, t)
end

if PT_Say_C ~= nil then
	Say = PTCompat_Say
end

-- Multi-use IB items (Di ngoai phu 10 uses, Lam Tien Lo 5, ...): VNG counted uses per item, the
-- rebuilt engine only has the stack count (1 per item), so CostIBItem removed the whole item on the
-- first use. Count used charges in the item param (saved to the database) and remove the item
-- only when the last charge is used.
Include("\\script\\phongthan\\lib\\pt_ibuses.lua")
-- "Con lai %d lan su dung" (TCVN3)
PT_COMPAT_USES1 = "C\223n l\185i "
PT_COMPAT_USES2 = " l\199n s\246 d\244ng."

if PT_CostIBItem_C == nil and CostIBItem ~= nil and CostIBItem ~= PTCompat_CostIBItem then
	PT_CostIBItem_C = CostIBItem
end

-- returns 1 when a charge was taken; the item disappears with its last charge
function PTCompat_UseCharge(idx)
	if idx == nil or idx <= 0 then return 0 end
	local name = GetNameItem(idx)
	local max = nil
	if name and PTCOMPAT_IBUSES then max = PTCOMPAT_IBUSES[name] end
	if max and max > 1 and (GetStackItem(idx) or 1) <= 1 then
		local used = (GetParamItem(idx) or 0) + 1
		if used < max then
			SetParamItem(idx, used)
			Msg2Player(PT_COMPAT_USES1 .. (max - used) .. PT_COMPAT_USES2)
			return 1
		end
	end
	if PT_CostIBItem_C then return PT_CostIBItem_C(idx) end
	return RemoveItem(idx, 1, 0)
end

function PTCompat_CostIBItem(idx)
	return PTCompat_UseCharge(idx)
end

if PT_CostIBItem_C ~= nil then
	CostIBItem = PTCompat_CostIBItem
end

-- Engine functions VNG scripts call but this server build never registered.
-- Without them the whole NPC dialog aborts ("attempt to call global"); these
-- fallbacks answer "not available" so the NPC still opens and can be closed.
function PTCompat_Zero() return 0 end
function PTCompat_Nop() end
PTCOMPAT_MISSING_ZERO = { "GetNewPills", "IsHaveTongRight", "IsTongMaster", "IsMaster", "IsDrawing",
	"HaveItem2", "HaveHandItem", "GetNativeWeightMax", "GetCoin", "IsRegMember", "BuildingOperator",
	"GetMasterPRValue", "CanMasterPR", "CanChangeMasterPRValue", "IsMasterPRRelation", "GetPillsState",
	"GetBuildingState", "GetTaskNoteCount", "GetPillsCount" }
PTCOMPAT_MISSING_NOP = { "AddTongContri", "AddMasterPRValue", "DecMasterPRValue", "ChangeMasterPRValue",
	"DoMasterPR", "UnMasterPREx", "DelHandItem", "RepairTaskValue", "AddTongDialog", "StartMakePills" }
do
	local i = 1
	while PTCOMPAT_MISSING_ZERO[i] do
		if getglobal(PTCOMPAT_MISSING_ZERO[i]) == nil then setglobal(PTCOMPAT_MISSING_ZERO[i], PTCompat_Zero) end
		i = i + 1
	end
	i = 1
	while PTCOMPAT_MISSING_NOP[i] do
		if getglobal(PTCOMPAT_MISSING_NOP[i]) == nil then setglobal(PTCOMPAT_MISSING_NOP[i], PTCompat_Nop) end
		i = i + 1
	end
	if GetExactWorldPos == nil then GetExactWorldPos = GetWorldPos end
end

-- 2026-10-02 (tutuong_a) Lua 5 compatibility for newer VNG item scripts. Lua 4 has no math/table/
-- string libraries as tables and no require; the engine also never registered some newer item API.
-- Every name is only defined when it is still nil, so scripts that set their own keep them.
function PTCompat_mrandom(a, b)
	if a == nil then return random() end
	if b == nil then return random(1, a) end
	return random(a, b)
end
function PTCompat_pow(a, b) return a ^ b end
function PTCompat_tconcat(t, sep, i, j)
	sep = sep or ""
	i = i or 1
	j = j or getn(t)
	local s = ""
	local k = i
	while k <= j do
		s = s .. t[k]
		if k < j then s = s .. sep end
		k = k + 1
	end
	return s
end
if math == nil then
	math = { random = PTCompat_mrandom, floor = floor, ceil = ceil, min = min, max = max, abs = abs,
		mod = mod, fmod = mod, sqrt = sqrt, pow = PTCompat_pow, pi = 3.14159265358979, huge = 2147483647 }
end
if table == nil then
	table = { getn = getn, insert = tinsert, remove = tremove, sort = sort, concat = PTCompat_tconcat }
end
if string == nil then
	string = { len = strlen, sub = strsub, find = strfind, lower = strlower, upper = strupper, rep = strrep,
		format = format, gsub = gsub, byte = strbyte, char = strchar }
end
-- require("common.luax") etc.: the VNG helper modules do not exist here; loading nothing is safe
function PTCompat_require(name) return 1 end
if require == nil then require = PTCompat_require end

-- item API by item index (the engine passes the index as the first argument of main)
function PTCompat_DelItemByID(idx, n)
	if idx == nil or idx <= 0 then return 0 end
	if RemoveItem(idx, n or 1, 0) == 1 then return 1 end
	return 0
end
function PTCompat_FindAValidItemID(idx)
	if idx == nil or idx <= 0 then return 0 end
	local p = GetItemPartByID(idx)
	if p and p > 0 then return idx end
	return 0
end
-- bound = LOCK_STATE_FOREVER (-2) or LOCK_STATE_CHARACTER (-3)
function PTCompat_IsItemBind(idx)
	if idx == nil or idx <= 0 then return 0 end
	local st = GetLockItem(idx)
	if st == -2 or st == -3 then return 1 end
	return 0
end
function PTCompat_Minus1() return -1 end
if DelItemByID == nil then DelItemByID = PTCompat_DelItemByID end
if FindAValidItemID == nil then FindAValidItemID = PTCompat_FindAValidItemID end
if IsItemBind == nil then IsItemBind = PTCompat_IsItemBind end
-- no genre/detail getter by index: -1 never matches a VNG item table, so such scripts give nothing
if GetItemGen == nil then GetItemGen = PTCompat_Minus1 end
if GetItemDetail == nil then GetItemDetail = PTCompat_Minus1 end
-- no bound-coin currency and no VIP (privilege) system in this build
if AddBindCoin == nil then AddBindCoin = PTCompat_Zero end
if GetPlayerVipLevel == nil then GetPlayerVipLevel = PTCompat_Zero end
if SetPlayerVipLevel == nil then SetPlayerVipLevel = PTCompat_Zero end
