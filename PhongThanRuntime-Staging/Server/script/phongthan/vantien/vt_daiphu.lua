-- Phong Than 2026-10-02: Dai phu inside Van Tien tran (VNG yisheng, template 766). One at the entry and
-- one in each isolated Than Bi Tran Diem area, so nobody gets stuck after a trap: status, medicine,
-- teleport to Thong Thien, back to the entry, next tran (after the clear), leave to Tay Ky.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function dp_tran()
	local w = GetWorldPos()
	return PTVT_MapToN(w)
end

function main()
	local n = dp_tran()
	if not n then
		CloseDialog()
		return
	end
	local opts = {}
	tinsert(opts, "T\215nh h\215nh tr\203n/dp_status")
	local st = 0
	if PTVT_IsOpen(n) == 1 then st = PTVT_GV(n, 0) end
	local mask = PTVT_GV(n, 1)
	local qs = GetTask(PTVT_T_QSTATE)
	if qs == 1 then
		tinsert(opts, "H\225i v\210 L\244c H\229n Phi\170n (nhi\214m v\244 Thi\170n H\239ng)/dp_quest")
	elseif qs == 10 then
		tinsert(opts, "H\225i v\210 l\214nh b\181i \174\198c bi\214t (nhi\214m v\244 Thi\170n H\239ng)/dp_quest")
	end
	if st == 2 and PTVT_Bit(mask, 16) == 0 and (PTVT_CountTien(mask) == 4 or GetTask(PTVT_T_QPASS) == 1) then
		tinsert(opts, "\167\173a ta \174\213n Th\199n B\221 Tr\203n \167i\211m (Th\171ng Thi\170n)/dp_boss")
	end
	if st == 3 and n < 4 then
		tinsert(opts, "Ti\213n v\181o V\185n Ti\170n tr\203n (" .. PTVT_NAME[n + 1] .. ")/dp_next")
	end
	tinsert(opts, "Mua thu\232c/dp_sale")
	tinsert(opts, "V\210 \174i\211m v\181o tr\203n/dp_entry")
	tinsert(opts, "R\234i tr\203n, v\210 T\169y K\250/dp_leave")
	tinsert(opts, "K\213t th\243c \174\232i tho\185i/no")
	local t = { "<color=green>\167\185i phu<color>: V\185n Ti\170n tr\203n nguy hi\211m, c\200n th\203n gi\247 m\185ng. Ng\173\172i c\199n g\215?", getn(opts) }
	local i = 1
	while opts[i] do
		t[i + 2] = opts[i]
		i = i + 1
	end
	call(Say, t)
end

function dp_status()
	local n = dp_tran()
	if not n then return end
	local st = 0
	if PTVT_IsOpen(n) == 1 then st = PTVT_GV(n, 0) end
	local mask = PTVT_GV(n, 1)
	local txt = "V\185n Ti\170n tr\203n (" .. PTVT_NAME[n] .. "): " .. PTVT_StateText(n) .. ". \167\183 h\185 " .. PTVT_CountTien(mask) .. "/4 ti\170n"
	if PTVT_Bit(mask, 16) == 1 then txt = txt .. ", Th\171ng Thi\170n Gi\184o Ch\241 \174\183 b\222 h\185" end
	local s = PTVT_RestSeconds(n)
	if s > 0 then txt = txt .. ". C\223n " .. floor(s / 60) .. " ph\243t " .. mod(s, 60) .. " gi\169y" end
	Say(txt .. ".", 2, "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
end

function dp_boss()
	local n = dp_tran()
	if not n then return end
	local mask = PTVT_GV(n, 1)
	if PTVT_IsOpen(n) ~= 1 or PTVT_GV(n, 0) ~= 2 or (PTVT_CountTien(mask) < 4 and GetTask(PTVT_T_QPASS) ~= 1) then
		Msg2Player("Ch\173a h\185 \174\241 4 ti\170n, Th\199n B\221 Tr\203n \167i\211m ch\173a m\235.")
		return
	end
	CloseDialog()
	-- the second Dai phu stands on a checked free cell inside the Thong Thien area
	SetPos(PTVT_D[n].doctors[2][1], PTVT_D[n].doctors[2][2])
	SetFightState(1)
	Msg2Player("\167\183 \174\213n Th\199n B\221 Tr\203n \167i\211m.")
end

-- Thien Hung quest: intro (Luc Hon Phien) and the level 8 special token quest are answered here
function dp_quest()
	local st = GetTask(PTVT_T_QSTATE)
	if PTVT_QDoctor() == 1 then
		if st == 1 then
			Say("<color=green>\167\185i phu<color>: L\244c H\229n Phi\170n \173? Ta \235 trong tr\203n \174\183 l\169u, ch\173a t\245ng th\202y l\184 c\234 \202y. C\227 l\207 n\227 kh\171ng n\187m trong V\185n Ti\170n tr\203n. Ng\173\172i h\183y v\210 b\184o cho <color=green>Thi\170n H\239ng<color> \235 T\169y K\250.", 2, "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
		else
			Say("<color=green>\167\185i phu<color>: K\206 bi\213n m\202t b\170n v\203t t\230 \174\183 b\222 \174\173a t\237i <color=yellow>Th\199n B\221 Tr\203n \167i\211m<color>, n\172i Th\171ng Thi\170n Gi\184o Ch\241 \200n th\169n. T\245 nay khi tr\203n \174ang chi\213n \174\202u, ta c\227 th\211 \174\173a ng\173\172i v\181o \174\227 m\181 kh\171ng c\199n l\214nh b\181i. H\183y v\210 b\184o cho <color=green>Thi\170n H\239ng<color>.", 2, "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
		end
		return
	end
	CloseDialog()
end

function dp_next()
	local n = dp_tran()
	if not n or n >= 4 then return end
	if PTVT_IsOpen(n) ~= 1 or PTVT_GV(n, 0) ~= 3 then
		Msg2Player("Ph\182i ph\184 tr\203n n\181y tr\173\237c.")
		return
	end
	CloseDialog()
	PTVT_EnterRequest(n + 1)
end

function dp_sale()
	CloseDialog()
	Sale(1)
end

function dp_entry()
	local n = dp_tran()
	if not n then return end
	CloseDialog()
	SetPos(PTVT_D[n].entry[1], PTVT_D[n].entry[2])
end

function dp_leave()
	CloseDialog()
	PTVT_ToTown()
end

function no()
	CloseDialog()
end
