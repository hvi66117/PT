-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61380 "Hat Giong Ky Son" (Le Quan, Tam Nguyet Ky Son, taskinfo
-- 1029 / 1617). Right click on Ky Son (1017): a sapling (template 1808) grows where the player stands; npc param
-- 0 = 2370200, 1 = owner player id, 2 = ripe flag, 3 = planted (SystemTime). lq_tree.lua: OnTimer after 5 min
-- (ripe), main = harvest, Timeout = removed after 30 min. Consumed on success.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

function main(nItemIdx)
	local w = GetWorldPos()
	if w ~= PTLQ_TREE_MAP then
		Say("M\199m c\169y th\199n b\221 ch\216 h\238p \174\202t <color=yellow>K\250 S\172n<color>. H\183y \174\213n K\250 S\172n r\229i tr\229ng.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	local sw = SubWorldID2Idx(w)
	if sw == nil or sw < 0 then return 0 end
	local pn = GetPlayerNpcIdx()
	local pw, x, y = GetNpcPos(pn)
	local t = AddNpc(PTLQ_TREE_TPL, 1, sw, x * 32 + 16, y * 32 + 16, 0)
	if t == nil or t <= 0 then
		Say("Kh\171ng tr\229ng \174\173\238c \235 ch\231 n\181y, h\183y th\246 ch\231 kh\184c.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	SetNpcName(t, "C\169y Th\199n (" .. GetName() .. ")")
	SetNpcScript(t, PTSH_S_TREE)
	SetNpcParam(t, 0, PTSH_MG_TREE)
	SetNpcParam(t, 1, PTSH_Me())
	SetNpcParam(t, 2, 0)
	SetNpcParam(t, 3, PTSH_Now())
	SetNpcTimer(t, PTSH_S_TREE, PTLQ_TREE_RIPE)
	SetNpcTimeout(t, PTLQ_TREE_LIFE * 18)
	RemoveItem(nItemIdx, 1, 0)
	Msg2Player("\167\183 tr\229ng C\169y Th\199n. Kho\182ng 5 ph\243t n\247a c\169y s\207 ch\221n, h\183y quay l\185i h\184i qu\182 (c\169y t\249 bi\213n m\202t sau 30 ph\243t).")
	return 0
end
