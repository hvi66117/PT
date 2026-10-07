-- Phong Than 2026-10-03 (agent bikip2): bi kip menu for EVERY city Vo su.
-- Tay Ky / Trieu Ca already have it (tail of extra_bikip.py). S\ptfix\extra_bikip2.py appends a small tail to the
-- other Vo su PAK scripts (Phong Than Dai, Dao Tri, Sung Thanh doanh, Ngoc Hu cung, Xi Vuu mo):
--     Include("\\script\\phongthan\\lib\\pt_bikip2.lua")
--     PTBK_SHOP_SALE = { [0] = 66, [1] = 67, [2] = 68 }
--     PTBK2_ORIG_MAIN = main
--     function main(sel) PTBK2_Main(sel) end
-- PTBK2_Main runs the VNG main unchanged, but while it runs the first SayTask menu gets 3 more rows ("Mua bi kip he
-- phai", "Dong sach (ep bi kip)", "Doi sach ky nang cu thanh bi kip"); a VNG main that only shows
-- MsgBox(text, "yes_2", "no") (Dao Tri) becomes a menu "Mua sach ky nang" + the 3 rows. Quest dialogs of the VNG main
-- (songxin, Tru Yeu ...) and the VNG book shops (Sale 8/9/10/19 via yes_2 / renwu2 / jineng) are untouched.
-- The row functions live in pt_bikip.lua (agent bikip). Lua 4: no local function, no true/false; ASCII + TCVN3 escapes.

Include("\\script\\phongthan\\lib\\pt_bikip.lua")

PTBK2_ROW_SHOP = "Mua b\221 k\221p h\214 ph\184i"
PTBK2_ROW_CRAFT = "\167\227ng s\184ch (\208p b\221 k\221p)"
PTBK2_ROW_CONVERT = "\167\230i s\184ch k\252 n\168ng c\242 th\181nh b\221 k\221p"
PTBK2_ROW_SACH = "Mua s\184ch k\252 n\168ng"

-- 1 when the row is an exit row (same rule as pt_compat.lua PTCompat_IsExit, which may not be loaded)
function PTBK2_IsExit(t)
	if PTCompat_IsExit then return PTCompat_IsExit(t[1], t[2]) end
	local f = t[2]
	if f == nil or f == "" or f == "no" then return 1 end
	return 0
end

-- copy of the VNG task table with the 3 bi kip rows inserted before the first visible exit row (or at the end)
function PTBK2_AddRows(tasks)
	local n = getn(tasks)
	local at = n + 1
	local i = 1
	while i <= n do
		local t = tasks[i]
		if type(t) == "table" and (t.show == nil or t.show ~= 0) and PTBK2_IsExit(t) == 1 then
			at = i
			break
		end
		i = i + 1
	end
	local c = {}
	local k = 1
	i = 1
	while i < at do
		c[k] = tasks[i]
		k = k + 1
		i = i + 1
	end
	c[k] = { PTBK2_ROW_SHOP, "PTBK_ShopMenu"; show = 1 }
	c[k + 1] = { PTBK2_ROW_CRAFT, "PTBK_CraftMenu"; show = 1 }
	c[k + 2] = { PTBK2_ROW_CONVERT, "PTBK_ConvertOld"; show = 1 }
	k = k + 3
	while i <= n do
		c[k] = tasks[i]
		k = k + 1
		i = i + 1
	end
	return c
end

function PTBK2_SayTaskHook(id, tasks)
	PTBK2_Unhook()
	if type(tasks) == "table" then tasks = PTBK2_AddRows(tasks) end
	return SayTask(id, tasks)
end

function PTBK2_MsgBoxHook(id, yes, no)
	PTBK2_Unhook()
	if yes == nil or yes == "" then return MsgBox(id, yes, no) end
	local tasks = { { PTBK2_ROW_SACH, yes; show = 1 } }
	tasks = PTBK2_AddRows(tasks)
	if no ~= nil and no ~= "" then
		tasks[getn(tasks) + 1] = { PT_COMPAT_EXIT or "Th\171i", no; show = 1 }
	end
	return SayTask(id, tasks)
end

function PTBK2_Unhook()
	if PTBK2_SAYTASK then SayTask = PTBK2_SAYTASK end
	if PTBK2_MSGBOX then MsgBox = PTBK2_MSGBOX end
end

function PTBK2_Main(sel)
	if PTBK2_ORIG_MAIN == nil then return end
	-- a hook left behind by a Lua error inside the VNG main is never taken as the original
	if SayTask ~= PTBK2_SayTaskHook then PTBK2_SAYTASK = SayTask end
	if MsgBox ~= PTBK2_MsgBoxHook then PTBK2_MSGBOX = MsgBox end
	if PTBK2_SAYTASK then SayTask = PTBK2_SayTaskHook end
	if PTBK2_MSGBOX then MsgBox = PTBK2_MsgBoxHook end
	PTBK2_ORIG_MAIN(sel)
	PTBK2_Unhook()
end
