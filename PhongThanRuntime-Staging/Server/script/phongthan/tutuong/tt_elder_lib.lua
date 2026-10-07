-- Phong Than 2026-10-02 (tutuong_a): dialog of the 4 T\248 T\173\238ng elders. Included by tt_elder_1..4.lua,
-- which set PTTE_EL (1 Th\230, 2 H\225a, 3 Phong, 4 Th\241y). Chain (item descriptions in material.txt):
--   Tinh Ph\184ch 3/200..203 --(elder of the same element, 1:1)--> Ng\173ng Ph\184ch 3/204..207
--   1 Th\230 + 1 H\225a + 1 Phong + 1 Th\241y Ng\173ng Ph\184ch --(any elder)--> 1 T\248 T\173\238ng Tinh Th\185ch 3/208
--   4 Tinh Th\185ch + 8 T\173\237ng Qu\169n L\214nh 3/100 + 10 Dung Tinh L\233 3/209 -> H\231n Nguy\170n Ch\169u (compose #385).
-- Per set the output is given first (full bag: stop, nothing taken), then the inputs are taken; if
-- one is missing (HaveNormalItem also counts the storage box) the set is undone. Outputs are unbound
-- (the Tinh Ph\184ch from the world bosses are unbound).
PTTE_EL_NAME = { "Th\230", "H\225a", "Phong", "Th\241y" }
PTTE_MAX = 100

function PTTE_Count(d)
	return HaveNormalItem(3, d, 0, -1) or 0
end

function PTTE_PutBack(list, upto)
	local k = 1
	while k <= upto do
		AddNormalItemPile(3, list[k], 0, 0, 0, 0)
		k = k + 1
	end
end

-- one set = 1 of every detail in `inputs` -> 1 `out`; repeats up to n times; returns sets made
function PTTE_Craft(inputs, out, n)
	if IsHaveSpaceForTreasure(2) == 0 then
		Talk(1, "PTTE_No", "H\181nh trang c\199n \221t nh\202t 2 \171 tr\232ng, h\183y s\190p x\213p l\185i.")
		return -1
	end
	local made = 0
	local i = 1
	while i <= n do
		-- give first: a full bag stops here with nothing taken
		local r = AddNormalItemPile(3, out, 0, 0, 0, 0)
		if not r or r <= 0 then break end
		local taken = 0
		local j = 1
		while inputs[j] do
			if DelNormalItem(3, inputs[j], 0, -1) > 0 then taken = taken + 1 else break end
			j = j + 1
		end
		if taken < getn(inputs) then
			-- an input is missing (or only in the storage box): undo this set
			PTTE_PutBack(inputs, taken)
			DelNormalItem(3, out, 0, -1)
			break
		end
		made = made + 1
		i = i + 1
	end
	return made
end

function PTTE_Status()
	return "H\181nh trang: " .. PTTE_EL_NAME[PTTE_EL] .. " Tinh Ph\184ch " .. PTTE_Count(199 + PTTE_EL) ..
		"; Ng\173ng Ph\184ch Th\230 " .. PTTE_Count(204) .. ", H\225a " .. PTTE_Count(205) .. ", Phong " .. PTTE_Count(206) ..
		", Th\241y " .. PTTE_Count(207) .. "; T\248 T\173\238ng Tinh Th\185ch " .. PTTE_Count(208) .. "."
end

function main()
	local nm = PTTE_EL_NAME[PTTE_EL]
	Say("<color=yellow>" .. nm .. " Tr\173\235ng L\183o<color>: Ma v\173\172ng giam c\199m ta \235 \174\169y \174\183 l\169u. Mang <color=green>" .. nm ..
		" Tinh Ph\184ch<color> \174\213n, ta luy\214n th\181nh <color=green>" .. nm .. " Ng\173ng Ph\184ch<color>. \167\241 4 lo\185i Ng\173ng Ph\184ch (Th\230, H\225a, Phong, Th\241y) th\215 ta h\238p th\181nh <color=green>T\248 T\173\238ng Tinh Th\185ch<color>. " ..
		PTTE_Status(), 6,
		"Luy\214n 1 " .. nm .. " Tinh Ph\184ch th\181nh Ng\173ng Ph\184ch/PTTE_One",
		"Luy\214n to\181n b\233 " .. nm .. " Tinh Ph\184ch/PTTE_All",
		"H\238p 1 T\248 T\173\238ng Tinh Th\185ch/PTTE_Stone",
		"H\238p t\232i \174a T\248 T\173\238ng Tinh Th\185ch/PTTE_StoneAll",
		"T\215m hi\211u T\248 T\173\238ng Tinh Th\185ch/PTTE_Info",
		"K\213t th\243c \174\232i tho\185i/PTTE_No")
end

function PTTE_Refine(n)
	local nm = PTTE_EL_NAME[PTTE_EL]
	if PTTE_Count(199 + PTTE_EL) <= 0 then
		Talk(1, "PTTE_No", "Ng\173\172i ch\173a c\227 " .. nm .. " Tinh Ph\184ch. Tinh Ph\184ch r\172i khi h\185 ma v\173\172ng: Th\230 - Thi\213t B\232, H\225a - C\171n B\232i, Phong - Lam B\184, Th\241y - Kim Tr\185i.")
		return
	end
	local made = PTTE_Craft({ 199 + PTTE_EL }, 203 + PTTE_EL, n)
	if made > 0 then
		Msg2Player("Luy\214n th\181nh c\171ng " .. made .. " " .. nm .. " Ng\173ng Ph\184ch.")
		Talk(1, "main", "Ta \174\183 luy\214n " .. made .. " " .. nm .. " Tinh Ph\184ch th\181nh Ng\173ng Ph\184ch. " .. PTTE_Status())
	elseif made == 0 then
		Talk(1, "PTTE_No", "Tinh Ph\184ch ph\182i n\187m trong h\181nh trang (kh\171ng t\221nh r\173\172ng ch\248a \174\229).")
	end
end

function PTTE_StoneMake(n)
	local made = PTTE_Craft({ 204, 205, 206, 207 }, 208, n)
	if made > 0 then
		Msg2Player("H\238p th\181nh c\171ng " .. made .. " T\248 T\173\238ng Tinh Th\185ch.")
		Talk(1, "main", "Ta \174\183 h\238p " .. made .. " T\248 T\173\238ng Tinh Th\185ch. " .. PTTE_Status())
	elseif made == 0 then
		Talk(1, "PTTE_No", "C\199n \174\241 1 Ng\173ng Ph\184ch m\231i lo\185i Th\230, H\225a, Phong, Th\241y trong h\181nh trang. " .. PTTE_Status())
	end
end

function PTTE_One() PTTE_Refine(1) end
function PTTE_All() PTTE_Refine(PTTE_MAX) end
function PTTE_Stone() PTTE_StoneMake(1) end
function PTTE_StoneAll() PTTE_StoneMake(PTTE_MAX) end

function PTTE_Info()
	Talk(1, "main", "4 T\248 T\173\238ng Tinh Th\185ch + 8 T\173\237ng Qu\169n L\214nh + 10 Dung Tinh L\233 gh\208p th\181nh H\231n Nguy\170n Ch\169u (giao di\214n gh\208p \174\229, X\221ch T\239ng T\246 - Di\170u Tr\215). Dung Tinh L\233 luy\214n t\245 ph\184p b\182o. Tr\173\235ng l\183o xu\202t hi\214n l\243c 00:00 v\181 12:00 (Th\230), 00:15 v\181 12:15 (Th\241y), 00:30 v\181 12:30 (H\225a), 00:45 v\181 12:45 (Phong), \235 l\185i 60 ph\243t c\185nh ma v\173\172ng.")
end

function PTTE_No()
end
