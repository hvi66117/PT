-- Phong Than 2026-10-01: Ky Nang Quyen (dao_si, magicscript 5625). VNG: "contains every secret
-- book of the profession". Teaches every profession skill 3..26 not learned yet at level 1;
-- the book is consumed only when it gave something. (Replaces the LUA-24xx BLOCKED_SPEC stub.)
PTKQ_PROF = 1
PTKQ_LO = 3
PTKQ_HI = 26

function PTKQ_No()
end

function main(nItemId)
	if GetProfession() ~= PTKQ_PROF then
		Say("Ch\216 Truy\210n Nh\169n ph\184i \167\185o S\220 m\237i d\239ng \174\173\238c K\252 N\168ng Quy\211n n\181y.", 1, "\167\227ng/PTKQ_No")
		return 0
	end
	local n = 0
	local id = PTKQ_LO
	while id <= PTKQ_HI do
		local lv = GetMagicLevel(id)
		if lv == nil or lv <= 0 then
			AddMagic(id, 1)
			lv = GetMagicLevel(id)
			if lv ~= nil and lv > 0 then n = n + 1 end
		end
		id = id + 1
	end
	local tok = 0
	if n == 0 and tok == 0 then
		Say("\167\183 h\228c \174\241 m\228i k\252 n\168ng c\241a ph\184i \167\185o S\220, K\252 N\168ng Quy\211n v\201n c\223n.", 1, "\167\227ng/PTKQ_No")
		return 0
	end
	RemoveItem(nItemId, 1, 0)
	local msg = "K\252 N\168ng Quy\211n: \174\183 h\228c th\170m " .. n .. " k\252 n\168ng c\241a ph\184i \167\185o S\220 (c\202p 1, d\239ng \174i\211m k\252 n\168ng \174\211 n\169ng)."
	Msg2Player(msg)
	Say(msg, 1, "\167\227ng/PTKQ_No")
	return 0
end
