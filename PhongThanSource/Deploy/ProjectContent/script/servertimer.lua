-- Neutral Phong Than server heartbeat.
-- CoreServer calls main() once per minute; official scheduled gameplay is
-- provided by the Phong Than registries, not by inherited private-server data.
--
-- Local admin bridge (AdminWeb\PhongThan-Admin.ps1). The web tool writes Lua
-- calls to admin_bridge\pending.lua with an atomic replace; each minute the
-- queue is renamed to running.lua, executed once and deleted. Results go to
-- admin_bridge\result.log, online players to admin_bridge\online.txt.
-- Paths are relative to the GameServer working directory (runtime Server\).

PTADM_DIR = "admin_bridge\\"
PTADM_MAX_PLAYER = 1200
PTADM_NPCS = {}
PTADM_NPC_COUNT = 0

function PTAdm_Log(id, status, text)
	local h = openfile(PTADM_DIR .. "result.log", "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S") .. "\t" .. id .. "\t" .. status .. "\t" .. (text or "") .. "\n")
		closefile(h)
	end
end

function PTAdm_FindPlayer(name)
	local pi = GetPlayerIndexByName(name)
	if pi and pi > 0 then
		PlayerIndex = pi
		if GetName() then return pi end
	end
	return nil
end

function PTAdm_GiveTo(pi, g, d, p, lv, se, n)
	PlayerIndex = pi
	local ok = 0
	local k = 1
	while k <= n do
		local idx = AddItem(g, d, p, lv, se, 0)
		if idx and idx > 0 then
			AddItemID(idx, 0)
			ok = ok + 1
		end
		k = k + 1
	end
	return ok
end

-- Give n items (genre, detail, particular, level, series) to one online player.
function PTAdm_Give(id, name, g, d, p, lv, se, n, itemName)
	local pi = PTAdm_FindPlayer(name)
	if not pi then PTAdm_Log(id, "FAIL", "offline " .. name) return end
	local ok = PTAdm_GiveTo(pi, g, d, p, lv, se, n)
	if ok > 0 then Msg2Player("Admin t∆ng: " .. (itemName or "vÀt ph»m") .. " x" .. ok) end
	if ok == n then PTAdm_Log(id, "OK", name .. " +" .. ok) else PTAdm_Log(id, "FAIL", name .. " created " .. ok .. "/" .. n) end
end

-- Give items to every online player.
function PTAdm_GiveAll(id, g, d, p, lv, se, n, itemName)
	local i = 1
	local players = 0
	while i <= PTADM_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local ok = PTAdm_GiveTo(i, g, d, p, lv, se, n)
			if ok > 0 then
				PlayerIndex = i
				Msg2Player("Admin t∆ng: " .. (itemName or "vÀt ph»m") .. " x" .. ok)
				players = players + 1
			end
		end
		i = i + 1
	end
	PTAdm_Log(id, "OK", "players=" .. players)
end

function PTAdm_Money(id, name, amount)
	local pi = PTAdm_FindPlayer(name)
	if not pi then PTAdm_Log(id, "FAIL", "offline " .. name) return end
	Earn(amount)
	PTAdm_Log(id, "OK", name .. " money+" .. amount)
end

function PTAdm_Exp(id, name, amount)
	local pi = PTAdm_FindPlayer(name)
	if not pi then PTAdm_Log(id, "FAIL", "offline " .. name) return end
	AddOwnExp(amount)
	PTAdm_Log(id, "OK", name .. " exp+" .. amount)
end

function PTAdm_News(id, text)
	AddGlobalNews(text)
	PTAdm_Log(id, "OK", "news")
end

-- Spawn count NPCs of template row npc at map/x/y (GetWorldPos units: pixel/32).
function PTAdm_SpawnAt(id, npc, lv, mapId, x, y, count)
	local sw = SubWorldID2Idx(mapId)
	if not sw or sw < 0 then PTAdm_Log(id, "FAIL", "map " .. mapId .. " not loaded") return end
	local ok = 0
	local k = 1
	while k <= count do
		local dx = mod(k - 1, 5) * 2 - 4
		local dy = floor((k - 1) / 5) * 2
		if count == 1 then dx = 0 dy = 0 end
		local ni = AddNpc(npc, lv, sw, (x + dx) * 32, (y + dy) * 32, 0)
		if ni and ni > 0 then
			ok = ok + 1
			PTADM_NPC_COUNT = PTADM_NPC_COUNT + 1
			PTADM_NPCS[PTADM_NPC_COUNT] = ni
		end
		k = k + 1
	end
	if ok == count then PTAdm_Log(id, "OK", "spawned " .. ok) else PTAdm_Log(id, "FAIL", "spawned " .. ok .. "/" .. count) end
end

function PTAdm_SpawnNear(id, npc, lv, name, count)
	local pi = PTAdm_FindPlayer(name)
	if not pi then PTAdm_Log(id, "FAIL", "offline " .. name) return end
	local w, x, y = GetWorldPos()
	PTAdm_SpawnAt(id, npc, lv, w, x + 3, y + 3, count)
end

-- Remove every NPC spawned through the admin bridge since server start.
function PTAdm_ClearSpawned(id)
	local k = 1
	local n = 0
	while k <= PTADM_NPC_COUNT do
		if PTADM_NPCS[k] and PTADM_NPCS[k] > 0 then
			DelNpc(PTADM_NPCS[k])
			n = n + 1
		end
		PTADM_NPCS[k] = nil
		k = k + 1
	end
	PTADM_NPC_COUNT = 0
	PTAdm_Log(id, "OK", "removed " .. n)
end

-- Teach or set profession skills to level lv (1..10) for one online player.
-- prof: 0 Giap Si, 1 Dao Si, 2 Di Nhan; -1 skips the profession check.
-- SetSkillLevel allows lowering; AddMagic then adds/raises and syncs the client.
function PTAdm_SetSkills(id, name, prof, lv, skills)
	local pi = PTAdm_FindPlayer(name)
	if not pi then PTAdm_Log(id, "FAIL", "offline " .. name) return end
	local cur = GetProfession()
	if prof >= 0 and cur ~= prof then
		PTAdm_Log(id, "FAIL", name .. " profession " .. cur .. " ~= " .. prof)
		return
	end
	local ok = 0
	local k = 1
	while skills[k] do
		SetSkillLevel(skills[k], lv)
		local r = AddMagic(skills[k], lv)
		if r and r > 0 then ok = ok + 1 end
		k = k + 1
	end
	Msg2Player("Admin: cap nhat " .. ok .. " ky nang len cap " .. lv)
	if ok == k - 1 then PTAdm_Log(id, "OK", name .. " skills=" .. ok .. " lv=" .. lv) else PTAdm_Log(id, "FAIL", name .. " skills " .. ok .. "/" .. (k - 1)) end
end
function PTAdm_DumpOnline()
	local h = openfile(PTADM_DIR .. "online.tmp", "w")
	if not h then return end
	write(h, date("%Y-%m-%d %H:%M:%S") .. "\n")
	local i = 1
	while i <= PTADM_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local w, x, y = GetWorldPos()
			write(h, nm .. "\t" .. (GetAccount() or "") .. "\t" .. (GetLevel() or 0) .. "\t" .. (w or 0) .. "\t" .. (x or 0) .. "\t" .. (y or 0) .. "\t" .. (GetProfession() or -1) .. "\n")
		end
		i = i + 1
	end
	closefile(h)
	remove(PTADM_DIR .. "online.txt")
	rename(PTADM_DIR .. "online.tmp", PTADM_DIR .. "online.txt")
end

-- NPC script rebinding. GameServer reads script.pak before loose files, so a
-- fixed copy of a PAK script must live at a new (lowercase) path and be bound
-- to the NPC at runtime: { mapId, server name (GBK), display name, script }.
PTADM_NPC_FIX = {
	{ 1002, "\178\214\191\226\185\220\192\237\212\177", "Thu Kho", "\\script\\phongthan\\npc_fix\\1002_thu_kho.lua" },
	{ 1002, "\203\213\187\164", "To Ho", "\\script\\phongthan\\npc_fix\\1002_to_ho.lua" },
	{ 1002, "\194\179\208\219", "Lo Hung", "\\script\\phongthan\\npc_fix\\1002_lo_hung.lua" },
	{ 1002, "\218\249\206\196\187\175", "Au Thien Hoa", "\\script\\phongthan\\npc_fix\\1002_au_thien_hoa.lua" },
	{ 1002, "\179\231\211\166\177\235", "Sung Ung Buu", "\\script\\phongthan\\npc_fix\\1002_sung_ung_buu.lua" },
	{ 1002, "\179\231\211\166\240\189", "Sung Ung Loan", "\\script\\phongthan\\npc_fix\\1002_sung_ung_loan.lua" },
	{ 1002, "\234\203\204\239", "Trieu Dien", "\\script\\phongthan\\npc_fix\\1002_trieu_dien.lua" },
	{ 1002, "\234\203\192\215", "Trieu Loi", "\\script\\phongthan\\npc_fix\\1002_trieu_loi.lua" },
	{ 1002, "\179\231\186\238\187\162", "Sung Hau Ho", "\\script\\phongthan\\npc_fix\\1002_sung_hau_ho.lua" },
	{ 1002, "\179\231\186\218\187\162", "Sung Hac Ho", "\\script\\phongthan\\npc_fix\\1002_sung_hac_ho.lua" },
	{ 1002, "\214\163\194\215", "Trinh Luan", "\\script\\phongthan\\npc_fix\\1002_trinh_luan.lua" },
	{ 1003, "\180\200\186\189\181\192\200\203", "Tu Hang Dao Nhan", "\\script\\phongthan\\npc_fix\\1003_tu_hang.lua" },
	{ 1003, "\179\224\190\171\215\211", "Xich Tinh Tu", "\\script\\phongthan\\npc_fix\\1003_xich_tinh_tu.lua" },
	{ 1003, "\193\233\177\166\180\243\183\168\202\166", "Linh Bao Dai Phap Su", "\\script\\phongthan\\npc_fix\\1003_linh_bao.lua" },
	{ 1003, "\196\207\188\171\207\201\206\204", "Nam Cuc Tien Ong", "\\script\\phongthan\\npc_fix\\1003_nam_cuc.lua" },
	{ 1003, "\187\198\193\250\213\230\200\203", "Hoang Long Chan Nhan", "\\script\\phongthan\\npc_fix\\1003_hoang_long.lua" },
	{ 1003, "\200\188\181\198\181\192\200\203", "Nhien Dang Dao Nhan", "\\script\\phongthan\\npc_fix\\1003_nhien_dang.lua" },
	{ 1003, "\212\198\214\208\215\211", "Van Trung Tu", "\\script\\phongthan\\npc_fix\\1003_van_trung_tu.lua" },
	{ 1004, "\201\217\234\187\205\188\204\218", "Thieu Hao", "\\script\\phongthan\\npc_fix\\1004_thieu_hao.lua" },
	{ 1004, "\186\243\205\193\205\188\204\218", "Hau Tho", "\\script\\phongthan\\npc_fix\\1004_hau_tho.lua" },
	{ 1004, "\183\231\178\174\205\188\204\218", "Phong Ba", "\\script\\phongthan\\npc_fix\\1004_phong_ba.lua" },
	{ 1004, "\215\163\200\218\205\188\204\218", "Chuc Dung", "\\script\\phongthan\\npc_fix\\1004_chuc_dung.lua" },
	{ 1004, "\185\178\185\164\205\188\204\218", "Cong Cong", "\\script\\phongthan\\npc_fix\\1004_cong_cong.lua" },
	{ 1004, "\208\204\204\236", "Hinh Thien", "\\script\\phongthan\\npc_fix\\1004_hinh_thien.lua" },
	{ 1004, "\184\223\190\245", "Cao Giac", "\\script\\phongthan\\npc_fix\\1004_cao_giac.lua" },
	{ 1004, "\184\223\195\247", "Cao Minh", "\\script\\phongthan\\npc_fix\\1004_cao_minh.lua" },
	{ 1004, "\191\228\184\184\205\188\204\218", "Khoa Phu", "\\script\\phongthan\\npc_fix\\1004_khoa_phu.lua" },
}
PTADM_MAX_NPC = 48000
PTADM_FIX_LOADED = nil

function PTAdm_FixNpcScripts()
	local k = 1
	if not PTADM_FIX_LOADED then
		while PTADM_NPC_FIX[k] do
			ReLoadScript(PTADM_NPC_FIX[k][4])
			k = k + 1
		end
		PTADM_FIX_LOADED = 1
	end
	local n = 0
	local i = 1
	while i < PTADM_MAX_NPC do
		local nm = GetNpcName(i)
		if nm and nm ~= "" then
			k = 1
			while PTADM_NPC_FIX[k] do
				local f = PTADM_NPC_FIX[k]
				if nm == f[2] or nm == f[3] then
					local w = GetNpcPos(i)
					if w == f[1] then
						SetNpcScript(i, f[4])
						n = n + 1
					end
				end
				k = k + 1
			end
		end
		i = i + 1
	end
	return n
end
-- NPCs missing from the placement data, spawned by the bridge and re-spawned
-- if they disappear: { mapId, template row, level, mpsX, mpsY, server name }.
-- Khoa Phu (task 30) sits on the totem row of map 1004 at display 190/204;
-- template 175 (passerby027, Kind 3) is the gap in the 170-176 totem range.
PTADM_NPC_SPAWN = {
	{ 1004, 175, 1, 48768, 104704, "\191\228\184\184\205\188\204\218" },
}
PTADM_SPAWNED = {}

function PTAdm_EnsureNpcs()
	local k = 1
	while PTADM_NPC_SPAWN[k] do
		local s = PTADM_NPC_SPAWN[k]
		local ni = PTADM_SPAWNED[k]
		local ok = nil
		if ni and ni > 0 and GetNpcName(ni) == s[6] then ok = 1 end
		if not ok then
			local sw = SubWorldID2Idx(s[1])
			if sw and sw >= 0 then
				ni = AddNpc(s[2], s[3], sw, s[4], s[5], 0)
				if ni and ni > 0 then
					SetNpcName(ni, s[6])
					PTADM_SPAWNED[k] = ni
				end
			end
		end
		k = k + 1
	end
end
function PTAdm_Tick()
	PTAdm_EnsureNpcs()
	PTADM_NPC_FIXED = PTAdm_FixNpcScripts()
	if rename(PTADM_DIR .. "pending.lua", PTADM_DIR .. "running.lua") then
		dofile(PTADM_DIR .. "running.lua")
		remove(PTADM_DIR .. "running.lua")
	end
	PTAdm_DumpOnline()
	PlayerIndex = nil
	local h = openfile(PTADM_DIR .. "heartbeat.txt", "w")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S"))
		closefile(h)
	end
end

function main()
	PTAdm_Tick()
end
