-- Phong Than 2026-10-03 (ruong): mo rong ruong chua do (Ruong 2..5) tai Thu Kho.
-- Engine: KPlayer::m_btRepositoryNum (GetExpandBox/SetExpandBox) = so trang "Ruong mo rong" da mo (0..5),
-- luu trong file nhan vat (PHONGTHAN_CHARACTER_STATE_HEADER.ExtraBox). Ruong k (2..6) = trang mo rong k-1
-- (pos_repositoryroom1..5). Trang chua mo bi to mo va server tu choi cat do vao (KItemList::ExchangeItem).
-- VNG cho thue ruong 2..5 bang Tien Dong co thoi han (RentStoreBox/GetCoin, task 770). Engine nay khong co
-- hai ham do va khong luu han dung, nen mo thang, vinh vien, mien phi. Khong bao gio giam so ruong da mo.
-- Duoc Include tu npc_fix\100x_thu_kho.lua (dong menu mo_rong_ruong). Ten toan cuc rieng: PTRUONG_*.
PTRUONG_MAX = 4

function PTRUONG_Count()
	local n = GetExpandBox()
	if not n or n < 0 then n = 0 end
	return n
end

function PTRUONG_Menu()
	local n = PTRUONG_Count()
	local s = ''
	if n <= 0 then
		s = "HiÖn ng­¬i chØ cã R­¬ng 1 (R­¬ng chøa ®å). R­¬ng 2, 3, 4, 5 lµ c¸c trang R­¬ng më réng 1, 2, 3, 4: më ë ®©y, råi trong khung r­¬ng bÊm mòi tªn ph¶i ®Ó chuyÓn trang."
	elseif n < PTRUONG_MAX then
		s = "Ng­¬i ®· më ®Õn R­¬ng " .. (n + 1) .. ". Muèn më thªm R­¬ng " .. (n + 2) .. " kh«ng? Më miÔn phÝ, dïng vÜnh viÔn."
	else
		s = "Ng­¬i ®· më ®ñ R­¬ng 2, 3, 4, 5. Trong khung r­¬ng bÊm mòi tªn ph¶i ®Ó chuyÓn trang."
	end
	local t = {}
	if n < PTRUONG_MAX then
		tinsert(t, {"Më R­¬ng " .. (n + 2), "PTRUONG_OpenNext"})
		if n + 1 < PTRUONG_MAX then
			tinsert(t, {"Më hÕt R­¬ng 2 - 5", "PTRUONG_OpenAll"})
		end
	end
	tinsert(t, {"Xem r­¬ng chøa ®å", "PTRUONG_Show"})
	tinsert(t, {"KÕt thóc ®èi tho¹i", "PTRUONG_No"})
	SayTask(s, t)
end

-- k = so trang mo rong muon co (1..PTRUONG_MAX), tuc mo den Ruong k+1
function PTRUONG_Set(k)
	local n = PTRUONG_Count()
	if k > PTRUONG_MAX then k = PTRUONG_MAX end
	if n >= k then
		Talk(1, "PTRUONG_Menu", "R­¬ng " .. (k + 1) .. " ®· më råi.")
		return
	end
	SetExpandBox(k)
	local m = PTRUONG_Count()
	if m < k then
		Msg2Player("Kh«ng më ®­îc r­¬ng, h·y b¸o admin.")
		return
	end
	Msg2Player("§· më ®Õn R­¬ng " .. (m + 1) .. ". Trong khung r­¬ng bÊm mòi tªn ph¶i ®Ó sang R­¬ng 2 (R­¬ng më réng 1) vµ c¸c r­¬ng sau.")
	PTRUONG_Show()
end

function PTRUONG_OpenNext()
	PTRUONG_Set(PTRUONG_Count() + 1)
end

function PTRUONG_OpenAll()
	PTRUONG_Set(PTRUONG_MAX)
end

-- same as the keeper's mo_ruong(): no chest object on the city maps, open the storage box directly
function PTRUONG_Show()
	SetFightState(0)
	OpenBox(2)
end

function PTRUONG_No()
	CloseDialog()
end
