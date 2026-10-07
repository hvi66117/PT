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
			-- stackgem 2026-10-03: stackable items join an existing stack (AddItemID never stacks)
			local mx = GetMaxStackItem(idx)
			if mx and mx > 1 then AddItemIDStack(idx, 0) else AddItemID(idx, 0) end
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
	{ 1004, "\191\228\184\184\205\188\204\218", "Khoa Ph\244 (\167\229 \167\187ng)", "\\script\\phongthan\\npc_fix\\1004_khoa_phu.lua" },
	{ 1021, "\187\198\183\201\187\162", "Hoang Phi Ho", "\\script\\phongthan\\npc_fix\\1021_hoang_phi_ho.lua" },
	{ 1021, "\186\250\207\178\195\196", "Ho Hy Mi", "\\script\\phongthan\\npc_fix\\1021_ho_hy_mi.lua" },
	{ 1021, "\230\167\188\186", "Dac Ky", "\\script\\phongthan\\npc_fix\\1021_dac_ky.lua" },
	{ 1021, "\187\198\204\236\187\175", "Hoang Thien Hoa", "\\script\\phongthan\\npc_fix\\1021_hoang_thien_hoa.lua" },
	{ 1021, "\205\193\208\208\203\239", "Tho Hanh Ton", "\\script\\phongthan\\npc_fix\\1021_tho_hanh_ton.lua" },
	{ 1021, "\190\198\181\234\192\207\176\229", "Chu Tuu Diem", "\\script\\phongthan\\npc_fix\\1021_chu_tuu_diem.lua" },
	{ 1020, "\209\238\234\175", "Duong Tien", "\\script\\phongthan\\npc_fix\\1020_duong_tien.lua" },
	{ 1020, "\206\228\205\245", "Vo Vuong", "\\script\\phongthan\\npc_fix\\1020_vo_vuong.lua" },
	{ 1020, "\189\170\215\211\209\192", "Khuong Tu Nha", "\\script\\phongthan\\npc_fix\\1020_khuong_tu_nha.lua" },
	{ 1020, "\192\215\213\240\215\211", "Loi Chan Tu", "\\script\\phongthan\\npc_fix\\1020_loi_chan_tu.lua" },
	{ 1065, "\192\238\190\184", "Ly Tinh", "\\script\\phongthan\\npc_fix\\1065_ly_tinh.lua" },
	{ 1015, "\183\231\193\214", "Phong Lam", "\\script\\phongthan\\npc_fix\\1015_phong_lam.lua" },
	{ 1015, "\206\226\193\250", "Ngo Long", "\\script\\phongthan\\npc_fix\\1015_ngo_long.lua" },
	{ 1015, "\179\163\234\187", "Thuong Hao", "\\script\\phongthan\\npc_fix\\1015_thuong_hao.lua" },
	{ 1016, "\181\203\190\197\185\171", "Dang Cuu Cong", "\\script\\phongthan\\npc_fix\\1016_dang_cuu_cong.lua" },
	{ 1014, "\206\197\204\171\202\166", "Van Thai Su", "\\script\\phongthan\\npc_fix\\1014_van_thai_su.lua" },
	{ 1052, "\206\247\205\245\196\184", "Tay Vuong Mau", "\\script\\phongthan\\npc_fix\\1052_tay_vuong_mau.lua" },
	{ 1044, "\182\224\177\166\181\192\200\203", "\167a B\182o \167\185o Nh\169n", "\\script\\phongthan\\npc_fix\\1044_da_bao.lua" },
	{ 1064, "\201\241\197\169", "Th\199n N\171ng (\167\229 \167\187ng)", "\\script\\phongthan\\npc_fix\\1064_than_nong.lua" },
	{ 1064, "\208\249\212\175", "Hi\170n Vi\170n", "\\script\\phongthan\\npc_fix\\1064_hien_vien.lua" },
	{ 1064, "\242\191\211\200", "Xi V\173u (\167\229 \167\187ng)", "\\script\\phongthan\\npc_fix\\1064_xi_vuu.lua" },
	{ 1063, "\230\167\188\186", "\167\190c K\251", "\\script\\phongthan\\npc_fix\\1063_dac_ky.lua" },
	{ 1062, "\212\170\202\188\204\236\215\240", "Nguy\170n Th\241y Thi\170n T\171n", "\\script\\phongthan\\npc_fix\\1062_nguyen_thuy.lua" },
	{ 1061, "\196\234\201\217\230\167\188\186", "\167\190c K\251 l\243c nh\225", "\\script\\phongthan\\npc_fix\\1061_dac_ky_luc_nho.lua" },
	{ 1003, "\178\214\191\226\185\220\192\237\212\177", "Th\241 Kh\232", "\\script\\phongthan\\npc_fix\\1003_thu_kho.lua" },
	{ 1003, "\212\211\187\245\201\204", "T\185p H\227a", "\\script\\phongthan\\npc_fix\\1003_tap_hoa.lua" },
	{ 1004, "\178\214\191\226\185\220\192\237\212\177", "Th\241 Kh\232", "\\script\\phongthan\\npc_fix\\1004_thu_kho.lua" },
	{ 1004, "\212\211\187\245\201\204", "T\185p H\227a", "\\script\\phongthan\\npc_fix\\1004_tap_hoa.lua" },
	{ 1002, "\197\220\201\204", "B\181o Th\173\172ng", "\\script\\phongthan\\npc_fix\\bao_thuong.lua" },
	{ 1003, "\197\220\201\204", "B\181o Th\173\172ng", "\\script\\phongthan\\npc_fix\\bao_thuong.lua" },
	{ 1004, "\197\220\201\204", "B\181o Th\173\172ng", "\\script\\phongthan\\npc_fix\\bao_thuong.lua" },
	{ 1020, "\197\220\201\204", "B\181o Th\173\172ng", "\\script\\phongthan\\npc_fix\\bao_thuong.lua" },
	{ 1021, "\197\220\201\204", "B\181o Th\173\172ng", "\\script\\phongthan\\npc_fix\\bao_thuong.lua" },
	{ 1002, "\210\189\201\250", "\167\185i Phu", "\\script\\phongthan\\npc_fix\\1002_dai_phu.lua" },
	{ 1002, "\205\173\189\179", "Th\238 \167\229ng", "\\script\\phongthan\\npc_fix\\1002_tho_dong.lua" },
	{ 1003, "\210\189\201\250", "\167\185i Phu", "\\script\\phongthan\\npc_fix\\1003_dai_phu.lua" },
	{ 1003, "\205\173\189\179", "Th\238 \167\229ng", "\\script\\phongthan\\npc_fix\\1003_tho_dong.lua" },
	{ 1004, "\210\189\201\250", "\167\185i Phu", "\\script\\phongthan\\npc_fix\\1004_dai_phu.lua" },
	{ 1004, "\205\173\189\179", "Th\238 \167\229ng", "\\script\\phongthan\\npc_fix\\1004_tho_dong.lua" },
	{ 1020, "\210\189\201\250", "\167\185i Phu", "\\script\\phongthan\\npc_fix\\1020_dai_phu.lua" },
	{ 1020, "\212\211\187\245\201\204", "T\185p H\227a", "\\script\\phongthan\\npc_fix\\1020_tap_hoa.lua" },
	{ 1020, "\205\173\189\179", "Th\238 \167\229ng", "\\script\\phongthan\\npc_fix\\1020_tho_dong.lua" },
	{ 1021, "\210\189\201\250", "\167\185i Phu", "\\script\\phongthan\\npc_fix\\1021_dai_phu.lua" },
	{ 1021, "\205\173\189\179", "Th\238 \167\229ng", "\\script\\phongthan\\npc_fix\\1021_tho_dong.lua" },
	{ 1020, "\204\171\203\234\202\166", "Thai Tue Su", "\\script\\phongthan\\npc_fix\\1020_thai_tue.lua" },
	{ 1021, "\212\211\187\245\201\204", "T\185p H\227a", "\\script\\phongthan\\npc_fix\\1021_tap_hoa.lua" },
	{ 1002, "Cong Dich Chuyen 1", "Cong di Sung Thanh", "\\script\\phongthan\\npc_fix\\exit_1002_to_1005.lua" },
	{ 1002, "Cong Dich Chuyen 2", "Cong di Bac Hai", "\\script\\phongthan\\npc_fix\\exit_1002_to_1006.lua" },
	{ 1002, "Cong Dich Chuyen 3", "Cong di Yen Son", "\\script\\phongthan\\npc_fix\\exit_1002_to_1007.lua" },
	{ 1003, "Cong Dich Chuyen 4", "Cong di Chan nui Con Lon", "\\script\\phongthan\\npc_fix\\exit_1003_to_1008.lua" },
	{ 1003, "Cong Dich Chuyen 5", "Cong di Tay Con Lon", "\\script\\phongthan\\npc_fix\\exit_1003_to_1009.lua" },
	{ 1003, "Cong Dich Chuyen 6", "Cong di Thu Duong son", "\\script\\phongthan\\npc_fix\\exit_1003_to_1010.lua" },
	{ 1003, "Cong Dich Chuyen 7", "Cong di Khoang truong", "\\script\\phongthan\\npc_fix\\exit_1003_to_1057.lua" },
	{ 1004, "Cong Dich Chuyen 8", "Cong di Du Hon", "\\script\\phongthan\\npc_fix\\exit_1004_to_1011.lua" },
	{ 1004, "Cong Dich Chuyen 9", "Cong di Mieu Cuong", "\\script\\phongthan\\npc_fix\\exit_1004_to_1012.lua" },
	{ 1004, "Cong Dich Chuyen 10", "Cong di Cu Loc", "\\script\\phongthan\\npc_fix\\exit_1004_to_1013.lua" },
	{ 1002, "Truyen Tong Tran 1", "Truyen Tong Tran", "\\script\\phongthan\\npc_fix\\exit_truyen_tong.lua" },
	{ 1003, "Truyen Tong Tran 2", "Truyen Tong Tran", "\\script\\phongthan\\npc_fix\\exit_truyen_tong.lua" },
	{ 1004, "Truyen Tong Tran 3", "Truyen Tong Tran", "\\script\\phongthan\\npc_fix\\exit_truyen_tong.lua" },
	-- 2026-10-02 questfix: Thay tuong so -> PAK (Tu Linh row); Thu kho Tay Ky/Trieu Ca -> PAK keeper (Tu Tuong); -- qf
	-- world-quest NPCs (taskinfo / minimap positions) -> their VNG PAK scripts (ptfix extra_questfix.py) -- qf
	{ 1020, "\203\227\195\252\207\200\201\250", "Thay Tuong So", "\\script\\\206\247\225\170\\\203\227\195\252\207\200\201\250.lua" }, -- qf
	{ 1021, "\203\227\195\252\207\200\201\250", "Thay Tuong So", "\\script\\\179\175\184\232\\\203\227\195\252\207\200\201\250.lua" }, -- qf
	{ 1020, "\178\214\191\226\185\220\192\237\212\177", "Th\241 Kh\232", "\\script\\\206\247\225\170\\\178\214\191\226\185\220\192\237\212\177.lua" }, -- qf
	{ 1021, "\178\214\191\226\185\220\192\237\212\177", "Th\241 Kh\232", "\\script\\\179\175\184\232\\\178\214\191\226\185\220\192\237\212\177.lua" }, -- qf
	{ 1020, "Nguoi Tay Vuc", "Nguoi Tay Vuc", "\\script\\\206\247\225\170\\\206\247\211\242\201\241\195\216\200\203.lua" }, -- qf Phi Tien (task 51) instead of placeholder 1020_03
	{ 1020, "\178\201\210\169\192\207\200\203", "Ng\173\234i H\184i Thu\232c", "\\script\\\206\247\225\170\\\178\201\210\169\192\207\200\203.lua" }, -- qf Vi Lao (task 50)
	{ 1020, "\216\212\202\166", "Th\199y B\227i", "\\script\\\178\202\198\177\\\216\212.lua" }, -- qf That Quai / Long Chau
	{ 1020, "\208\193\195\226", "T\169n Mi\212n", "\\script\\\206\247\225\170\\\208\193\195\226.lua" }, -- qf Thu thap vat pham (task 32)
	{ 1021, "\197\253\197\195", "T\215 B\181", "\\script\\\179\175\184\232\\\197\253\197\195.lua" }, -- qf Thien thu
	{ 1001, "\176\216\188\248", "B\184 Gi\184m", "\\script\\\183\226\201\241\204\168\\\176\216\188\248.lua" }, -- qf Thien thu reward
	{ 1001, "\205\188\202\233\185\221", "\167\229 Th\173 Qu\184n", "\\script\\\183\226\201\241\204\168\\\205\188\202\233\185\221.lua" }, -- qf Minh Chau (task 41) step 2
	{ 1003, "\190\229\193\244\203\239", "C\239 L\173u T\171n", "\\script\\\211\241\208\233\185\172\\\190\229\193\244\203\239.lua" }, -- qf Minh Chau steps 3/11/27
	{ 1006, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2541.lua" }, -- qf Quy Tinh (task 53) Bac Hai
	{ 1007, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2542.lua" }, -- qf Quy Tinh Yen Son
	{ 1012, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2543.lua" }, -- qf Quy Tinh Mieu Cuong
	{ 1013, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2544.lua" }, -- qf Quy Tinh Cu Loc
	{ 1010, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2545.lua" }, -- qf Quy Tinh Thu Duong son
	{ 1009, "\183\226\211\161\214\174\203\254", "Phong \202n Th\184p", "\\script\\item\\\204\236\238\184\208\199\\\183\226\211\161\214\174\203\2546.lua" }, -- qf Quy Tinh Tay Con Lon
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
	-- 2026-09-29 Bao Thuong merchants (tid 1388) + camel (tid 366) in 5 cities
	{ 1002, 1388, 1, 53904, 102160, "B\181o Th\173\172ng" },
	{ 1002, 366, 1, 54032, 102160, "\194\230\205\213" },
	{ 1003, 1388, 1, 56112, 103600, "B\181o Th\173\172ng" },
	{ 1003, 366, 1, 56240, 103600, "\194\230\205\213" },
	{ 1004, 1388, 1, 51696, 103888, "B\181o Th\173\172ng" },
	{ 1004, 366, 1, 51824, 103888, "\194\230\205\213" },
	{ 1020, 1388, 1, 50576, 96784, "B\181o Th\173\172ng" },
	{ 1020, 366, 1, 50704, 96784, "\194\230\205\213" },
	{ 1021, 1388, 1, 52880, 101136, "B\181o Th\173\172ng" },
	{ 1021, 366, 1, 53008, 101136, "\194\230\205\213" },
	-- 2026-09-29 shops (medicine / weapon / equipment), placed next to the existing store NPCs
	{ 1002, 149, 1, 52624, 101648, "\167\185i Phu" },
	{ 1002, 157, 1, 53392, 102160, "Th\238 \167\229ng" },
	{ 1003, 149, 1, 54832, 103088, "\167\185i Phu" },
	{ 1003, 157, 1, 55600, 103600, "Th\238 \167\229ng" },
	{ 1004, 149, 1, 51696, 102864, "\167\185i Phu" },
	{ 1004, 157, 1, 52208, 103888, "Th\238 \167\229ng" },
	{ 1020, 149, 1, 49296, 96528, "\167\185i Phu" },
	{ 1020, 158, 1, 49808, 96528, "T\185p H\227a" },
	{ 1020, 157, 1, 50320, 96528, "Th\238 \167\229ng" },
	{ 1021, 149, 1, 52112, 94480, "\167\185i Phu" },
	{ 1021, 157, 1, 53392, 101136, "Th\238 \167\229ng" },
	-- 2026-10-03 cankhon2: old unreachable Thai Tue statue (tpl 1116) removed; ext\cankhon2.lua spawns tpl 1130 in 1020/1021
	{ 1021, 158, 1, 54608, 101616, "T\185p H\227a" },
	{ 1004, 175, 1, 48768, 104704, "Khoa Ph\244 (\167\229 \167\187ng)" },
	{ 1003, 151, 1, 55648, 102464, "Th\241 Kh\232" },
	{ 1003, 158, 1, 55328, 103072, "T\185p H\227a" },
	{ 1004, 151, 1, 50448, 103024, "Th\241 Kh\232" },
	{ 1004, 158, 1, 51936, 103360, "T\185p H\227a" },
	{ 1044, 202, 1, 61568, 98560, "\167a B\182o \167\185o Nh\169n" },
	{ 1064, 1474, 1, 50048, 103168, "Th\199n N\171ng (\167\229 \167\187ng)" },
	{ 1064, 1380, 1, 50560, 102656, "Hi\170n Vi\170n" },
	{ 1064, 176, 1, 51072, 103168, "Xi V\173u (\167\229 \167\187ng)" },
	{ 1063, 164, 1, 48720, 105168, "\167\190c K\251" },
	{ 1062, 206, 1, 51584, 105728, "Nguy\170n Th\241y Thi\170n T\171n" },
	{ 1061, 164, 1, 51584, 106240, "\167\190c K\251 l\243c nh\225" },
	{ 1002, 1686, 1, 49472, 104448, "Cong Dich Chuyen 1" },
	{ 1002, 1686, 1, 49568, 99936, "Cong Dich Chuyen 2" },
	{ 1002, 1686, 1, 54144, 104928, "Cong Dich Chuyen 3" },
	{ 1003, 1686, 1, 56704, 104128, "Cong Dich Chuyen 4" },
	{ 1003, 1686, 1, 56576, 99264, "Cong Dich Chuyen 5" },
	{ 1003, 1686, 1, 52704, 103488, "Cong Dich Chuyen 6" },
	{ 1003, 1686, 1, 51168, 98400, "Cong Dich Chuyen 7" },
	{ 1004, 1686, 1, 45856, 100704, "Cong Dich Chuyen 8" },
	{ 1004, 1686, 1, 54752, 106848, "Cong Dich Chuyen 9" },
	{ 1004, 1686, 1, 55232, 104096, "Cong Dich Chuyen 10" },
	{ 1002, 1686, 1, 52160, 102528, "Truyen Tong Tran 1" },
	{ 1003, 1686, 1, 53408, 98944, "Truyen Tong Tran 2" },
	{ 1004, 1686, 1, 50496, 105152, "Truyen Tong Tran 3" },
	-- 2026-10-02 questfix: Thu kho Tay Ky / Trieu Ca (Tu Tuong) + world-quest NPCs missing from the region data -- qf
	{ 1020, 151, 1, 47008, 98016, "Th\241 Kh\232" }, -- qf Thu kho Tay Ky (taskinfo 24 mappos1)
	{ 1021, 151, 1, 54880, 97152, "Th\241 Kh\232" }, -- qf Thu kho Trieu Ca (taskinfo 24 mappos2)
	{ 1020, 776, 1, 45696, 98688, "Ng\173\234i H\184i Thu\232c" }, -- qf taskinfo 21 [20,178,192]
	{ 1020, 202, 1, 45440, 100832, "Th\199y B\227i" }, -- qf taskinfo 62 mappos (20,1420,3151)
	{ 1020, 158, 1, 48768, 97472, "T\169n Mi\212n" }, -- qf taskinfo 32 mappos (20,1524,3046)
	{ 1021, 165, 1, 57344, 91968, "T\215 B\181" }, -- qf VNG minimap Trieu Ca, beside Dac Ky (Loc Dai)
	{ 1001, 202, 1, 52864, 99840, "B\184 Gi\184m" }, -- qf taskinfo [1,206,195]
	{ 1001, 158, 1, 46976, 104192, "\167\229 Th\173 Qu\184n" }, -- qf taskinfo 20 [1,183,203]
	{ 1003, 202, 1, 52928, 101312, "C\239 L\173u T\171n" }, -- qf taskinfo 20 [3,206,197]
	{ 1006, 1002, 1, 55552, 100864, "Phong \202n Th\184p" }, -- qf Bac Hai (217,197)
	{ 1007, 1002, 1, 51456, 107008, "Phong \202n Th\184p" }, -- qf Yen Son (201,209)
	{ 1012, 1002, 1, 50176, 101376, "Phong \202n Th\184p" }, -- qf Mieu Cuong (196,198)
	{ 1013, 1002, 1, 55552, 100864, "Phong \202n Th\184p" }, -- qf Cu Loc (217,197)
	{ 1010, 1002, 1, 34816, 101376, "Phong \202n Th\184p" }, -- qf Thu Duong son (136,198)
	{ 1009, 1002, 1, 52992, 103936, "Phong \202n Th\184p" }, -- qf Tay Con Lon (207,203)
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
-- Main-quest monsters with no map placement (11 chain mobs + Kim Ha thu fix):
-- { mapId, template, level, mpsX, mpsY, server name, death-handling script }.
-- The script is attached as ActionScript (LastDamage runs for the killer);
-- the engine revives the mob in place and keeps name + script.
PTADM_MOB_SPAWN = {
	{ 1018, 122, 45, 48000, 97024, "\213\242\181\238\189\171\190\252", "\\script\\phongthan\\npc_fix\\mob_tran_dien_tuong_quan.lua" },
	{ 1038, 113, 55, 52864, 89856, "\182\171\186\163\201\241\193\250", "\\script\\phongthan\\npc_fix\\mob_dong_hai_than_long.lua" },
	{ 1006, 100, 45, 54656, 104704, "\177\177\186\163\201\241\221\186", "\\script\\phongthan\\npc_fix\\mob_bac_hai_than_oanh.lua" },
	{ 1006, 100, 45, 53632, 102656, "\177\177\186\163\201\241\221\186", "\\script\\phongthan\\npc_fix\\mob_bac_hai_than_oanh.lua" },
	{ 1006, 100, 45, 58496, 104192, "\177\177\186\163\201\241\221\186", "\\script\\phongthan\\npc_fix\\mob_bac_hai_than_oanh.lua" },
	{ 1024, 109, 55, 54400, 92928, "\178\187\203\192\201\241\196\190", "\\script\\phongthan\\npc_fix\\mob_bat_tu_than_moc.lua" },
	{ 1015, 116, 45, 54656, 101120, "\201\204\190\252\208\163\206\190", "\\script\\phongthan\\npc_fix\\mob_thuong_quan_hieu_uy.lua" },
	{ 1045, 121, 65, 46464, 102144, "\176\178\190\211\202\222", "\\script\\phongthan\\npc_fix\\mob_an_cu_thu.lua" },
	{ 1045, 121, 65, 50304, 104704, "\176\178\190\211\202\222", "\\script\\phongthan\\npc_fix\\mob_an_cu_thu.lua" },
	{ 1045, 121, 65, 47488, 111360, "\176\178\190\211\202\222", "\\script\\phongthan\\npc_fix\\mob_an_cu_thu.lua" },
	{ 1047, 461, 70, 50560, 108800, "\213\248\196\252", "\\script\\phongthan\\npc_fix\\mob_tranh_nanh.lua" },
	{ 1048, 119, 75, 50304, 97024, "\177\226\200\181\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_bien_thuoc_tien_the.lua" },
	{ 1048, 119, 75, 49536, 108288, "\177\226\200\181\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_bien_thuoc_tien_the.lua" },
	{ 1049, 118, 75, 52864, 104704, "\184\201\189\171\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_can_tuong_tien_the.lua" },
	{ 1049, 118, 75, 53888, 96512, "\184\201\189\171\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_can_tuong_tien_the.lua" },
	{ 1050, 117, 75, 49024, 107776, "\203\239\206\228\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_ton_vu_tien_the.lua" },
	{ 1050, 117, 75, 45952, 101120, "\203\239\206\228\199\176\202\192", "\\script\\phongthan\\npc_fix\\mob_ton_vu_tien_the.lua" },
	{ 1062, 120, 80, 52864, 104704, "\203\209\203\247\182\211\179\164", "\\script\\phongthan\\npc_fix\\mob_doi_truong_luc_soat.lua" },
	{ 1016, 107, 50, 46194, 108305, "<color=green>\189\240\207\188\202\222<color>", "\\script\\phongthan\\npc_fix\\mob_kim_ha_thu.lua" },
	-- 2026-10-02 questfix: VNG quest monsters with their \script\[guaiwu] death script (LastDamage wrapper in ptfix) -- qf
	{ 1010, 104, 55, 39296, 89856, "D\173\238c L\169u T\246", "\\script\\\185\214\206\239\\\210\169\194\168\215\211.lua" }, -- qf Vi Lao: Huyen thao (event 38)
	{ 1010, 104, 55, 34944, 94976, "D\173\238c L\169u T\246", "\\script\\\185\214\206\239\\\210\169\194\168\215\211.lua" }, -- qf Vi Lao
	{ 1010, 104, 55, 34880, 104768, "D\173\238c L\169u T\246", "\\script\\\185\214\206\239\\\210\169\194\168\215\211.lua" }, -- qf Vi Lao
	{ 1022, 108, 30, 47872, 95232, "Hoa Tr\173", "\\script\\\185\214\206\239\\\187\168\214\174\187\196\214\237.lua" }, -- qf Phi Tien: manh Luu tinh (event 37) [187,186]
	{ 1022, 108, 30, 46816, 98336, "Hoa Tr\173", "\\script\\\185\214\206\239\\\187\168\214\174\187\196\214\237.lua" }, -- qf Phi Tien [183,192]
	{ 1022, 108, 30, 46848, 96256, "Hoa Tr\173", "\\script\\\185\214\206\239\\\187\168\214\174\187\196\214\237.lua" }, -- qf Phi Tien [183,188]
	{ 1022, 108, 30, 47872, 96768, "Hoa Tr\173", "\\script\\\185\214\206\239\\\187\168\214\174\187\196\214\237.lua" }, -- qf Phi Tien [187,189]
	{ 1037, 110, 45, 57600, 105984, "Ch\243c Ng\173", "\\script\\\185\214\206\239\\\203\174\214\243\211\227.lua" }, -- qf Minh Chau: Chuc Ngu huyet (event 34) [225,207]
	{ 1037, 110, 45, 57408, 105792, "Ch\243c Ng\173", "\\script\\\185\214\206\239\\\203\174\214\243\211\227.lua" }, -- qf Minh Chau
	{ 1037, 111, 45, 56832, 91648, "Th\232 Ng\173", "\\script\\\185\214\206\239\\\204\199\180\215\211\227.lua" }, -- qf Minh Chau: Tho Ngu huyet (event 35) [222,179]
	{ 1037, 111, 45, 57024, 91840, "Th\232 Ng\173", "\\script\\\185\214\206\239\\\204\199\180\215\211\227.lua" }, -- qf Minh Chau
	{ 1037, 112, 45, 52224, 90624, "Th\211 Ng\173", "\\script\\\185\214\206\239\\\203\225\178\203\211\227.lua" }, -- qf Minh Chau: The Ngu huyet (event 36) [204,177]
	{ 1037, 112, 45, 52416, 90816, "Th\211 Ng\173", "\\script\\\185\214\206\239\\\203\225\178\203\211\227.lua" }, -- qf Minh Chau
}
PTADM_MOBS = {}
PTADM_MOB_INIT = nil

function PTAdm_EnsureMobs()
	local k = 1
	if not PTADM_MOB_INIT then
		-- first run: remove region-placed copies (Kim Ha thu) and stale spawns, load scripts
		while PTADM_MOB_SPAWN[k] do
			local m = PTADM_MOB_SPAWN[k]
			ClearMapNpcWithName(m[1], m[6])
			ReLoadScript(m[7])
			k = k + 1
		end
		PTADM_MOB_INIT = 1
		k = 1
	end
	while PTADM_MOB_SPAWN[k] do
		local m = PTADM_MOB_SPAWN[k]
		local ni = PTADM_MOBS[k]
		if not (ni and ni > 0 and GetNpcName(ni) == m[6]) then
			local sw = SubWorldID2Idx(m[1])
			if sw and sw >= 0 then
				ni = AddNpc(m[2], m[3], sw, m[4], m[5], 1)
				if not ni or ni <= 0 then ni = AddNpc(m[2], m[3], sw, m[4] + 512, m[5], 1) end
				if not ni or ni <= 0 then ni = AddNpc(m[2], m[3], sw, m[4], m[5] + 512, 1) end
				if not ni or ni <= 0 then ni = AddNpc(m[2], m[3], sw, m[4], m[5], 0) end
				if ni and ni > 0 then
					SetNpcName(ni, m[6])
					SetNpcScript(ni, m[7])
					PTADM_MOBS[k] = ni
				end
			end
		end
		k = k + 1
	end
end
-- Map-exit trap scripts live only in script.pak and the startup scan never registers them;
-- load them once per server start (exit_trap_register.lua) plus the loose Ngoc Hu -> Khoang truong trap.
function PTAdm_RegisterExits()
	if PTEXIT_REG then return end
	dofile("script\\phongthan\\npc_fix\\exit_trap_register.lua")
	PTEXIT_TRAPS = PTExit_RegisterTraps()
	ReLoadScript("\\script\\trap\\\211\241\208\233\185\172to\191\243\179\161.lua")
	PTEXIT_REG = 1
end

-- Generated monster population for the 51 empty maps (+4 optional, +17 quest targets);
-- data and loader in script\phongthan\spawn\ (evidence per map in each file header).
-- Runs in budgets of 2500 AddNpc per tick until done; once per server start.
function PTAdm_Spawn()
	if not PT_SPAWN_MAIN_VERSION then
		dofile("script\\phongthan\\spawn\\spawn_main.lua")
		PT_SPAWN_USE_OPTIONAL = 1
		PT_SPAWN_WITH_SPECIAL = 1
	end
	if not PT_SPAWN_DONE then PTSpawn_Run(4000) end
end

-- 2026-09-30 ibitem experience buffs (Thien Huong, Lam Tien Lo...): re-apply after the engine
-- recomputes stats, remove when expired. Logic in script\phongthan\ibitem\pt_ibitem_lib.lua.
function PTAdm_IbTick()
	if not PTIB_Refresh then dofile("script\\phongthan\\ibitem\\pt_ibitem_lib.lua") end
	if not PTIB_Tick then return end
	local i = 1
	while i <= PTADM_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then PTIB_Tick() end
		i = i + 1
	end
	PlayerIndex = nil
end

-- 2026-09-30 item stuck "in hand" on the server: saved with Container=pos_hand at logout and
-- reloaded into m_Hand at login (or left there by a desynced swap). The client does not show it,
-- and KItemList::ExchangeItem drops every bag->equip move while m_Hand is set, so nothing can be
-- equipped. Move it back to the bag: clone it into a free cell (AddItemIdx + AddItemID) and only
-- remove the hand copy once the clone is in the player's item list (a full bag keeps it as is).
PTADM_HAND_SCAN = 30000
function PTAdm_HandFixPlayer()
	local k = 1
	while k <= PTADM_HAND_SCAN do
		if FindItem(k) == 1 then
			-- 2026-10-03 weaponequip: a full bag made AddItemID drop the hand item on the ground and put the
			-- clone in hand, so every minute added a copy (Xu). Only clone when there is room, and only
			-- remove the hand copy once the clone sits in the bag (place 3/4).
			if CheckRoom(k, 0) ~= 1 then return 0, 0 end
			local n = AddItemIdx(k, 0)
			if not n or n <= 0 then return k, -2 end
			AddItemID(n, 3, 0)
			local pn = FindItem(n)
			if pn == 3 or pn == 4 then
				RemoveItem(k, 0, 0)
				return k, n
			end
			return k, -3
		end
		k = k + 1
	end
	return 0, 0
end

function PTAdm_HandTick()
	local i = 1
	while i <= PTADM_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local k, n = PTAdm_HandFixPlayer()
			if k > 0 then PTAdm_Log("handfix", "OK", nm .. " hand item " .. k .. " -> bag " .. n) end
		end
		i = i + 1
	end
	PlayerIndex = nil
end

-- 2026-09-30 world bosses (12 VNG bosses on the systemtimetask schedule, alive/killed state,
-- admin_bridge\worldboss.txt for the web admin). Logic in script\phongthan\boss\wb_lib.lua.
function PTAdm_WbTick()
	if not PTWB_Tick then dofile("script\\phongthan\\boss\\wb_lib.lua") end
	if PTWB_Tick then PTWB_Tick() end
end

-- 2026-10-02 starter gear for new characters (weapon + horse, level 1, max attributes).
-- Logic in script\phongthan\newbie\starter_gear.lua (task 1950).
function PTAdm_NbTick()
	if not PTNB_Tick then dofile("script\\phongthan\\newbie\\starter_gear.lua") end
	if PTNB_Tick then PTNB_Tick() end
end

-- 2026-10-02: feature ticks run protected, so an error in one feature cannot stop the admin bridge.
function PTAdm_TickErr(m)
	local h = openfile(PTADM_DIR .. "tick_error.log", "a")
	if h then write(h, date("%Y-%m-%d %H:%M:%S ") .. tostring(m) .. "\n") closefile(h) end
end

function PTAdm_Safe(fn)
	if fn then call(fn, {}, "x", PTAdm_TickErr) end
end

-- bot gia nguoi choi: script\phongthan\bots\bots.lua (template 2703-2720 in settings\phongthan\Npcs.txt)
function PTAdm_BotTick()
	if not PTBOT_Tick then dofile("script\\phongthan\\bots\\bots.lua") end
	if PTBOT_Tick then PTBOT_Tick() end
end

-- Tu Tuong elders (Tinh Phach -> Ngung Phach -> Tinh Thach): script\phongthan\tutuong\tt_elder.lua
function PTAdm_TeTick()
	if not PTTE_Tick then dofile("script\\phongthan\\tutuong\\tt_elder.lua") end
	if PTTE_Tick then PTTE_Tick() end
end

-- Tu Linh + Thu Thach Huyen Vu: script\phongthan\tutuong\tt_tick.lua
function PTAdm_TtTick()
	if not PTTT_Tick then dofile("script\\phongthan\\tutuong\\tt_tick.lua") end
	if PTTT_Tick then PTTT_Tick() end
end

-- Van Tien tran (maps 1079-1082, Thien Hung in Tay Ky): script\phongthan\vantien\vt_timer.lua
function PTAdm_VtTick()
	if not PTVT_Tick then dofile("script\\phongthan\\vantien\\vt_timer.lua") end
	if PTVT_Tick then PTVT_Tick() end
end

-- 2026-10-03: per-feature extension ticks. Each feature owns script\phongthan\ext\<name>.lua defining
-- PTEXT_<name>_Tick(); missing files are skipped. Run protected like PTAdm_FeatTick.
PTADM_EXT_NAMES = { "questfix2", "sudo_dongdi", "vanluong", "daily2", "newbie2", "tienma", "tienma45", "daily3", "vienco", "sinhhoat", "cankhon2", "congthanh", "npcnames", "questfix3", "matdo", "lbdaosi", "eventsched", "dailygift", "thanhtich", "noidung", "luawave", "hanhtrang" }
function PTAdm_ExtOne(nm)
	local fn = getglobal("PTEXT_" .. nm .. "_Tick")
	if not fn then
		local p = "script\\phongthan\\ext\\" .. nm .. ".lua"
		local h = openfile(p, "r")
		if not h then return end
		closefile(h)
		dofile(p)
		fn = getglobal("PTEXT_" .. nm .. "_Tick")
	end
	if fn then fn() end
end

function PTAdm_ExtTick()
	local k = 1
	while PTADM_EXT_NAMES[k] do
		local nm = PTADM_EXT_NAMES[k]
		call(PTAdm_ExtOne, { nm }, "x", PTAdm_TickErr)
		k = k + 1
	end
end

function PTAdm_FeatTick()
	PTAdm_Safe(PTAdm_BotTick)
	PTAdm_Safe(PTAdm_TeTick)
	PTAdm_Safe(PTAdm_TtTick)
	PTAdm_Safe(PTAdm_VtTick)
	PTAdm_ExtTick()
end

function PTAdm_Tick()
	PTAdm_RegisterExits()
	PTAdm_Spawn()
	PTAdm_EnsureNpcs()
	PTAdm_EnsureMobs()
	PTAdm_IbTick()
	PTAdm_HandTick()
	PTAdm_WbTick()
	PTAdm_NbTick()
	PTAdm_FeatTick()
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
