-- Phong Than 2026-10-01: Sach Ky Nang 1481 (VNG rebirth skill Lv.60). Right click: learn the
-- skill at level 1, every further book raises it by 1 (max 10). The book is consumed on success.
-- No top-level dofile: loose scripts are registered with cwd = their own folder.
PTSK_ID = 1481
PTSK_PROF = 0
PTSK_REQ = 60

-- Result is shown in a dialog too: Msg2Player chat lines are easy to miss (2026-10-01).
function PTSK_Show(msg)
	Msg2Player(msg)
	Say(msg, 1, "\167\227ng/PTSK_No")
end

function PTSK_No()
end

function PTSK_Log(tag)
	if openfile == nil or date == nil then return end
	local h = openfile("admin_bridge\\token.log", "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S") .. "\tbook" .. PTSK_ID .. "\t" .. tag .. "\n")
		closefile(h)
	end
end

function main(nItemIdx)
	PTSK_Log("use prof=" .. GetProfession() .. " lv=" .. GetLevel() .. " skill=" .. HaveMagic(PTSK_ID))
	if GetProfession() ~= PTSK_PROF then
		PTSK_Show("S\184ch n\181y ch\216 d\181nh cho ph\184i Gi\184p S\220.")
		return 0
	end
	if GetLevel() < PTSK_REQ then
		PTSK_Show("C\199n \174\185t c\202p 60 m\237i h\228c \174\173\238c Huy\213t Chi\213n Sa Tr\173\234ng.")
		return 0
	end
	local lv = HaveMagic(PTSK_ID)
	if lv ~= nil and lv >= 10 then
		PTSK_Show("Huy\213t Chi\213n Sa Tr\173\234ng \174\183 \174\185t c\202p t\232i \174a 10.")
		return 0
	end
	local nl = 1
	if lv ~= nil and lv > 0 then
		nl = lv + 1
		SetSkillLevel(PTSK_ID, nl)
	end
	AddMagic(PTSK_ID, nl)
	if GetMagicLevel(PTSK_ID) ~= nl then
		PTSK_Show("H\228c k\252 n\168ng th\202t b\185i, s\184ch v\201n c\223n.")
		return 0
	end
	RemoveItem(nItemIdx, 1, 0)
	PTSK_Show("\167\183 h\228c Huy\213t Chi\213n Sa Tr\173\234ng, c\202p hi\214n t\185i: " .. nl)
	return 0
end
