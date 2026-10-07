-- Phong Than 2026-10-03 (botparty): dialog of the "Ho Tro To Doi" NPC (spawned by party.lua PTBP_EnsureNpcs in
-- the 3 newbie towns, script registered by PTBP_Register). Per-player switch of the bot party: task 2070 mode
-- (0 server setting, 1 on, 2 off), task 2071 count (0 server setting, 1..7). The bots themselves are managed by
-- the minute tick (bots.lua -> PTBP_Tick); here only the switch is stored, "off" also removes the bots at once.
-- Generated from scratchpad\botparty\src\party_npc.lua by gen.py (TCVN3 escapes, ASCII file).
Include("\\script\\phongthan\\bots\\party.lua")

function PTBPN_ModeText()
	if GetTask(PTBP_T_MODE) == 2 then return "<color=red>\174ang t\190t<color>" end
	return "<color=green>\174ang b\203t<color>"
end

function PTBPN_CountText()
	local n = GetTask(PTBP_T_COUNT)
	if not n or n <= 0 then return "theo m\184y ch\241 (m\198c \174\222nh " .. PTBP_DEF_COUNT .. ")" end
	return n .. " \174\229ng \174\233i"
end

function main()
	local s = "<color=yellow>H\231 Tr\238 T\230 \167\233i<color>: khi b\185n ra b\183i qu\184i (b\182n \174\229 c\227 qu\184i), \174\229ng \174\233i bot t\249 v\181o t\230 \174\233i, \174i theo, \174\184nh c\239ng m\244c ti\170u v\237i b\185n. Qu\184i do \174\229ng \174\233i h\185 \174\173\238c t\221nh nh\173 b\185n h\185, kinh nghi\214m c\233ng th\170m theo s\232 \174\229ng \174\233i \235 g\199n nh\173 t\230 \174\233i VNG. V\210 th\181nh ho\198c v\181o t\230 \174\233i th\203t th\215 \174\229ng \174\233i t\249 r\234i.\nT\230 \174\233i bot: " .. PTBPN_ModeText() .. ". S\232 \174\229ng \174\233i: " .. PTBPN_CountText() .. "."
	Say(s, 5, "B\203t t\230 \174\233i bot/PTBPN_On", "T\190t t\230 \174\233i bot/PTBPN_Off", "Ch\228n s\232 \174\229ng \174\233i/PTBPN_CountMenu", "C\184ch t\221nh kinh nghi\214m t\230 \174\233i/PTBPN_Info", "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_On()
	SetTask(PTBP_T_MODE, 1)
	Say("\167\183 b\203t t\230 \174\233i bot. Ra b\183i qu\184i, ch\203m nh\202t 1 ph\243t \174\229ng \174\233i s\207 t\237i.", 1, "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_Off()
	SetTask(PTBP_T_MODE, 2)
	local n = PTBP_DismissAll()
	Say("\167\183 t\190t t\230 \174\233i bot. \167\229ng \174\233i r\234i \174\233i: " .. n .. ".", 1, "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_CountMenu()
	Say("Ch\228n s\232 \174\229ng \174\233i bot (t\230 \174\233i VNG t\232i \174a 8 ng\173\234i k\211 c\182 b\185n):", 9, "1 \174\229ng \174\233i/PTBPN_C1", "2 \174\229ng \174\233i/PTBPN_C2", "3 \174\229ng \174\233i/PTBPN_C3", "4 \174\229ng \174\233i/PTBPN_C4", "5 \174\229ng \174\233i/PTBPN_C5", "6 \174\229ng \174\233i/PTBPN_C6", "7 \174\229ng \174\233i/PTBPN_C7", "Theo m\184y ch\241/PTBPN_C0", "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_SetCount(n)
	SetTask(PTBP_T_COUNT, n)
	Say("S\232 \174\229ng \174\233i bot: " .. PTBPN_CountText() .. ". \184p d\244ng trong v\223ng 1 ph\243t.", 1, "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_Info()
	local b = 0
	if GetPartyBotBonus then b = GetPartyBotBonus() end
	local s = "M\231i \174\229ng \174\233i bot \174\248ng g\199n b\185n (trong kho\182ng chia kinh nghi\214m c\241a t\230 \174\233i) c\233ng th\170m kinh nghi\214m khi \174\184nh qu\184i, m\198c \174\222nh +" .. PTBP_DEF_BONUS .. "% m\231i ng\173\234i (qu\182n tr\222 ch\216nh tr\170n web). Bot kh\171ng l\202y ph\199n kinh nghi\214m n\181o. Ch\216 \184p d\244ng khi b\185n ch\173a v\181o t\230 \174\233i th\203t."
	if GetPartyBotBonus then
		s = s .. " Hi\214n t\185i: +" .. b .. "%."
	else
		s = s .. " M\184y ch\241 ch\173a c\181i b\182n c\233ng th\170m kinh nghi\214m t\230 \174\233i: \174\229ng \174\233i v\201n \174\184nh gi\243p, qu\184i v\201n t\221nh cho b\185n."
	end
	Say(s, 1, "K\213t th\243c \174\232i tho\185i/no")
end

function PTBPN_C0() PTBPN_SetCount(0) end
function PTBPN_C1() PTBPN_SetCount(1) end
function PTBPN_C2() PTBPN_SetCount(2) end
function PTBPN_C3() PTBPN_SetCount(3) end
function PTBPN_C4() PTBPN_SetCount(4) end
function PTBPN_C5() PTBPN_SetCount(5) end
function PTBPN_C6() PTBPN_SetCount(6) end
function PTBPN_C7() PTBPN_SetCount(7) end

function no()
end

-- 2026-10-04 botheal (C3): replacement timer of a dead party bot. party.lua PTBP_WatchArm puts it on the player's own
-- NPC (SetNpcTimer, this script); no dialog NPC of this script has a timer, so OnTimer always gets a player NPC here.
function OnTimer(ni)
	PTBP_Watch(ni)
end
