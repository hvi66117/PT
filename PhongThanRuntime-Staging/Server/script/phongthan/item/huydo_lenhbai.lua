-- Phong Than "Lenh Bai Huy Do" (magicscript 61002, 2026-09-30/10-01): permanent, unlimited uses
-- (KItemList::ExecuteScript only calls main; this script never removes the item).
--  * buy/sell/repair are all refused in fight mode (KBuySell::CanBuy/Sell, KPlayer::RepairItem),
--    so both shop entries switch fight mode off first.
--  * sell: KBuySell::OpenSale records the player's own map/position and the sell handler only checks
--    that the player has not moved, so Sale(1) works anywhere ("Ban" button, click bag items).
--  * repair: KPlayer::RepairItem has no shop-position check but refuses while m_FightMode is on, and
--    there is no Lua API to repair: the token turns the fight state off (task 1940 = 1 remembers it),
--    opens the shop; the player uses "Sua" and clicks each equipped item in F3 (paid like an NPC).
--    "Bat lai chien dau" restores the fight state only if the token switched it off.
-- No top-level dofile: loose scripts are registered with cwd = their own folder.
PTHD_TASK = 1940

-- Diagnostics (2026-10-01): one line per step in admin_bridge\\token.log (cwd = Server).
function PTHD_Log(tag)
	if openfile == nil or date == nil then return end
	local h = openfile("admin_bridge\\token.log", "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S") .. "\thuydo\t" .. tag .. " fight=" .. GetFightState() .. " task=" .. GetTask(PTHD_TASK) .. "\n")
		closefile(h)
	end
end

function main(nItemIdx)
	PTHD_Log("menu")
	Say("<color=yellow>L\214nh B\181i H\241y \167\229<color>: ch\228n ch\248c n\168ng.", 5, "B\184n \174\229 trong t\243i/PTHD_Sell", "H\241y \174\229 (b\225 v\181o h\233p r\229i x\184c nh\203n)/PTHD_Destroy", "S\246a to\181n b\233 \174\229 \174ang m\198c/PTHD_Repair", "B\203t l\185i chi\213n \174\202u/PTHD_Fight", "K\213t th\243c \174\232i tho\185i/PTHD_No")
	return 0
end

function PTHD_Sell()
	PTHD_Log("PTHD_Sell")
	if GetFightState() == 1 then
		SetTask(PTHD_TASK, 1)
		SetFightState(0)
	end
	Msg2Player("\167\183 t\185m t\190t chi\213n \174\202u v\181 m\235 c\246a h\181ng: b\202m n\243t B\184n r\229i click v\181o \174\229 trong t\243i (ho\198c gi\247 Shift + chu\233t ph\182i) \174\211 b\184n. Xong ch\228n m\244c B\203t l\185i chi\213n \174\202u tr\170n l\214nh b\181i.")
	Sale(1)
	PTHD_Log("after Sale fight=" .. GetFightState())
end

function PTHD_Repair()
	PTHD_Log("PTHD_Repair")
	-- RepairAllEquip (C++, ScriptFuns.cpp 2026-10-01) repairs every equipped item for free in one go;
	-- until that engine build is installed, fall back to the shop "Sua" mode (items with price 0 get a
	-- repair cost of 0 and KPlayer::RepairItem silently refuses them).
	if RepairAllEquip ~= nil then
		local n = RepairAllEquip()
		Msg2Player("\167\183 s\246a \174\199y \174\233 b\210n " .. (n or 0) .. " m\227n \174\229 \174ang m\198c (\174\229 \174\183 h\225ng, \174\233 b\210n 0, kh\171ng s\246a \174\173\238c).")
		return
	end
	if GetFightState() == 1 then
		SetTask(PTHD_TASK, 1)
		SetFightState(0)
	end
	Msg2Player("\167\183 t\185m t\190t chi\213n \174\202u v\181 m\235 c\246a h\181ng: b\202m n\243t S\246a, m\235 F3 r\229i click t\245ng m\227n \174\229 \174ang m\198c (tr\182 l\173\238ng nh\173 s\246a \235 NPC). Xong ch\228n m\244c B\203t l\185i chi\213n \174\202u tr\170n l\214nh b\181i.")
	Sale(1)
	PTHD_Log("after Sale fight=" .. GetFightState())
end

function PTHD_Fight()
	PTHD_Log("PTHD_Fight")
	if GetTask(PTHD_TASK) == 1 then
		SetTask(PTHD_TASK, 0)
		SetFightState(1)
		Msg2Player("\167\183 b\203t l\185i tr\185ng th\184i chi\213n \174\202u.")
	else
		Msg2Player("L\214nh b\181i ch\173a t\190t chi\213n \174\202u, kh\171ng c\199n b\203t l\185i.")
	end
end

function PTHD_Destroy()
	PTHD_Log("PTHD_Destroy")
	GiveItemUI("H\241y \174\229", "K\208o c\184c m\227n mu\232n h\241y v\181o h\233p r\229i b\202m X\184c nh\203n. To\181n b\233 \174\229 trong h\233p s\207 bi\213n m\202t v\220nh vi\212n, kh\171ng l\202y l\185i \174\173\238c.", "PTHD_DestroyOK")
end

-- Confirm in the give box: KProtocolProcess (enumC2S_PLAYERCOMMAND_ID_GIVE) runs this callback in
-- the token script (ExecuteScript set m_ActionScriptID), then BackLocal() returns whatever is still
-- in room_give (12) to the bag. RemoveRoom(12) deletes every item put in the box first.
function PTHD_DestroyOK()
	PTHD_Log("PTHD_DestroyOK")
	local n = GetItemCountRoom(14)
	if n == nil or n <= 0 then
		Msg2Player("H\233p tr\232ng, kh\171ng c\227 m\227n n\181o b\222 h\241y.")
		return
	end
	RemoveRoom(12)
	Msg2Player("\167\183 h\241y v\220nh vi\212n " .. n .. " m\227n \174\229.")
end

function PTHD_No()
end
