-- pt_ibitem.lua (Lua 4, ASCII). Item script for ibitem pools and experience buffs; ptfix.pak points the
-- NONE script column of those \settings\item\001\ibitem.txt rows here. The engine passes the item index.
Include("\\script\\phongthan\\ibitem\\pt_ibitem_lib.lua")
Include("\\script\\phongthan\\lib\\pt_compat.lua")

-- same effect again: add the time; otherwise start from now
function PTIB_Extend(tEnd, secs, now)
	local e = GetTask(tEnd)
	if e < now then e = now end
	SetTask(tEnd, e + secs)
	return e + secs - now
end

function PTIB_UsePool(idx, p)
	local now = SystemTime()
	local left
	if p[1] == 3 then
		left = PTIB_Extend(PTIB_T_LIFE_END, p[4], now)
		if p[2] > GetTask(PTIB_T_LIFE_RATE) then SetTask(PTIB_T_LIFE_RATE, p[2]) end
	else
		left = PTIB_Extend(PTIB_T_MANA_END, p[4], now)
		if p[2] > GetTask(PTIB_T_MANA_RATE) then SetTask(PTIB_T_MANA_RATE, p[2]) end
	end
	RemoveItem(idx, 1, 0)
	PTIB_Refresh()
	if p[1] == 3 then
		Msg2Player("K\221ch ho\185t h\229i ph\244c sinh l\249c +" .. GetTask(PTIB_T_LIFE_RATE) .. " m\231i nh\222p" .. ", th\234i h\185n c\223n " .. PTIB_TimeText(left))
	else
		Msg2Player("K\221ch ho\185t h\229i ph\244c n\233i l\249c +" .. GetTask(PTIB_T_MANA_RATE) .. " m\231i nh\222p" .. ", th\234i h\185n c\223n " .. PTIB_TimeText(left))
	end
end

function PTIB_UseBuff(idx, b)
	local now = SystemTime()
	local left
	if GetTask(PTIB_T_EXP_END) > now and GetTask(PTIB_T_EXP_PCT) == b[2] and GetTask(PTIB_T_EXP_SKILL) == b[3] then
		left = PTIB_Extend(PTIB_T_EXP_END, b[1], now)
	else
		SetTask(PTIB_T_EXP_END, now + b[1])
		left = b[1]
	end
	SetTask(PTIB_T_EXP_PCT, b[2])
	SetTask(PTIB_T_EXP_SKILL, b[3])
	PTCompat_UseCharge(idx)
	PTIB_Refresh()
	local msg = "Nh\203n hi\214u qu\182: kinh nghi\214m +" .. b[2]
	if b[3] == 1 then msg = msg .. "%, kinh nghi\214m k\252 n\168ng x2" else msg = msg .. "%" end
	Msg2Player(msg .. ", th\234i h\185n c\223n " .. PTIB_TimeText(left))
end

-- generic stat buff: the same buff extends its slot, a new one takes a free slot or the slot
-- that ends first (slot logic in pt_ibitem_lib.lua PTIB_GrantGen since 2026-10-02, also used by scripts)
function PTIB_UseGen(idx, gid)
	local left = PTIB_GrantGen(gid)
	PTCompat_UseCharge(idx)
	Msg2Player("Nh\203n hi\214u qu\182 v\203t ph\200m, th\234i h\185n c\223n " .. PTIB_TimeText(left))
end

function main(idx)
	if idx == nil or idx <= 0 then return end
	local name = GetNameItem(idx)
	if name then
		local p = PTIB_POOL[name]
		if p then PTIB_UsePool(idx, p) return end
		local b = PTIB_BUFF[name]
		if b then PTIB_UseBuff(idx, b) return end
		local gid = PTIB_GENID[name]
		if gid then PTIB_UseGen(idx, gid) return end
	end
	Msg2Player("V\203t ph\200m n\181y ch\173a \174\173\238c h\231 tr\238.")
end
