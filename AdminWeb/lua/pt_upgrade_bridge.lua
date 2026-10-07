-- Phong Than 2026-10-05 (natives): web admin "Cuong hoa" (equipment upgrade +0..+12).
-- PhongThan-Admin.ps1 sends this whole file plus one call (PTUP_List / PTUP_Set) through
-- admin_bridge\pending.lua; servertimer.lua runs it in its own Lua state (PTADM_DIR, PTAdm_Log,
-- PTAdm_FindPlayer come from there). Needs the CoreServer natives GetItemListEntry, GetItemUpgrade,
-- SetItemUpgrade (PhongThanLuaItemNatives.h). Lua 4, ASCII only. Global names start with PTUP_.

PTUP_ERR = {}
PTUP_ERR[0] = "item not found for this player"
PTUP_ERR[-1] = "not an equipment item"
PTUP_ERR[-2] = "player is locked or trading"
PTUP_ERR[-3] = "no upgrade rule for this equipment (no Xich Tung Tu recipe)"
PTUP_ERR[-4] = "level outside 0..12 or rejected by the upgrade tables"
PTUP_ERR[-5] = "item could not be put back (restored unchanged)"

function PTUP_HasNatives()
	if GetItemListEntry and GetItemUpgrade and SetItemUpgrade and GetItemGen then return 1 end
	return nil
end

-- places shown in the web list: 2 = worn, 3 = bag, 4 = extra bag
function PTUP_Shown(place)
	if place == 2 or place == 3 or place == 4 then return 1 end
	return nil
end

-- itemId (persistent id) -> current item index of the selected player, 0 when gone
function PTUP_FindById(iid)
	local k = 1
	while k <= 600 do
		local idx, place, x, y, cur = GetItemListEntry(k)
		if not idx or idx <= 0 then return 0 end
		if cur == iid then return idx end
		k = k + 1
	end
	return 0
end

-- writes admin_bridge\upgrade_items.txt:
--   line 1: time, player name, online|offline|nonative
--   then one line per equipment item: itemIdx, itemId, place, x, y, level, rule, name (TCVN3)
function PTUP_List(id, name)
	local tmp = PTADM_DIR .. "upgrade_items.tmp"
	local h = openfile(tmp, "w")
	if not h then
		PTAdm_Log(id, "FAIL", "cannot write upgrade_items.tmp")
		return
	end
	local pi = PTAdm_FindPlayer(name)
	local state = "offline"
	if pi then
		state = "online"
		if not PTUP_HasNatives() then state = "nonative" end
	end
	write(h, date("%Y-%m-%d %H:%M:%S") .. "\t" .. name .. "\t" .. state .. "\n")
	local n = 0
	if state == "online" then
		local k = 1
		while k <= 600 do
			local idx, place, x, y, iid = GetItemListEntry(k)
			if not idx or idx <= 0 then break end
			if PTUP_Shown(place) and GetItemGen(idx) == 0 then
				local lv, rule = GetItemUpgrade(idx)
				write(h, idx .. "\t" .. iid .. "\t" .. place .. "\t" .. x .. "\t" .. y .. "\t" .. (lv or 0) .. "\t" .. (rule or 0) .. "\t" .. (GetNameItem(idx) or "") .. "\n")
				n = n + 1
			end
			k = k + 1
		end
	end
	closefile(h)
	remove(PTADM_DIR .. "upgrade_items.txt")
	rename(tmp, PTADM_DIR .. "upgrade_items.txt")
	if state == "offline" then
		PTAdm_Log(id, "FAIL", "offline " .. name .. ": nhan vat phai dang online")
	elseif state == "nonative" then
		PTAdm_Log(id, "FAIL", "CoreServer chua co native SetItemUpgrade/GetItemListEntry - can trien khai ban build 2026-10-05")
	else
		PTAdm_Log(id, "OK", name .. ": " .. n .. " mon trang bi (mac + tui)")
	end
end

-- sets the upgrade level of one item (persistent itemId) of an online player; msg = TCVN3 text for the player
function PTUP_Set(id, name, iid, level, msg)
	local pi = PTAdm_FindPlayer(name)
	if not pi then
		PTAdm_Log(id, "FAIL", "offline " .. name .. ": nhan vat phai dang online moi cuong hoa duoc")
		return
	end
	if not PTUP_HasNatives() then
		PTAdm_Log(id, "FAIL", "CoreServer chua co native SetItemUpgrade - can trien khai ban build 2026-10-05")
		return
	end
	local idx = PTUP_FindById(iid)
	if idx <= 0 then
		PTAdm_Log(id, "FAIL", name .. ": khong con mon id=" .. iid .. " (da ban/bo?) - bam Liet ke lai")
		return
	end
	local before = GetItemUpgrade(idx)
	local r = SetItemUpgrade(idx, level)
	if r == 1 then
		local after = GetItemUpgrade(idx)
		if msg then Msg2Player(msg .. level) end
		PTAdm_Log(id, "OK", name .. " id=" .. iid .. " +" .. (before or 0) .. " -> +" .. (after or 0))
	else
		PTAdm_Log(id, "FAIL", name .. " id=" .. iid .. " SetItemUpgrade=" .. r .. " (" .. (PTUP_ERR[r] or "?") .. ")")
	end
end
