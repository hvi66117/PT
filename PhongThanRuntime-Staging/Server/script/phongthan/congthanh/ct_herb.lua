-- ct_herb.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "Xich Dong Thao" herb patch (3 NPCs on the south-west edge of Tay Ky): pick for taskinfo 78,
-- destroy for taskinfo 79 step 4 ("Pha hoai Xich Dong Thao cua lanh dia doi dich").
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")

function PTCT_H_Busy()
	local now = SystemTime()
	local last = GetTask(PTCT_T_ACT)
	if last > 0 and now >= last and now - last < PTCT_ACT_GAP then
		PTCT_Say1("T\245 t\245 th\171i, b\244i c\225 c\223n ch\173a k\222p m\228c l\185i.")
		return 1
	end
	SetTask(PTCT_T_ACT, now)
	return nil
end

function main()
	local rows = {}
	local n = 0
	local v = GetTask(PTCT_T_78)
	if v ~= 0 and GetByte(v, 2) < PTCT_78_Need() then
		n = n + 1 rows[n] = { "H\184i X\221ch \167\229ng Th\182o", "PTCT_H_Pick" }
	end
	if GetTask(PTCT_T_79) == 2 then
		n = n + 1 rows[n] = { "Ph\184 ho\185i X\221ch \167\229ng Th\182o (\167i\214p b\184o)", "PTCT_H_Ruin" }
	end
	n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	SayTask("<color=yellow>X\221ch \167\229ng Th\182o<color>: lo\185i c\225 \174\225 nh\173 \174\229ng, Ph\223ng chi\213n xa d\239ng \174\211 luy\214n gi\184p xe.", rows)
end

function PTCT_H_Pick()
	local v = GetTask(PTCT_T_78)
	if v == 0 then return end
	local got = GetByte(v, 2)
	if got >= PTCT_78_Need() then return end
	if PTCT_H_Busy() then return end
	got = got + 1
	SetTask(PTCT_T_78, SetByte(v, 2, got))
	if got >= PTCT_78_Need() then
		TaskNote(78, 1)
		Msg2Player("\167\183 h\184i \174\241 " .. PTCT_78_Need() .. " b\244i X\221ch \167\229ng Th\182o, mang v\210 Ph\223ng chi\213n xa.")
	else
		Msg2Player("H\184i \174\173\238c X\221ch \167\229ng Th\182o (" .. got .. "/" .. PTCT_78_Need() .. ")")
	end
end

function PTCT_H_Ruin()
	if GetTask(PTCT_T_79) ~= 2 then return end
	if PTCT_H_Busy() then return end
	SetTask(PTCT_T_79, 3)
	TaskNote(79, 5)
	Msg2Player("\167\183 ph\184 ho\185i X\221ch \167\229ng Th\182o. Mau v\210 H\253 vi\214n ph\244c m\214nh!")
end
