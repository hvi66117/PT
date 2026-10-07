-- Phong Than exit NPC 2026-09-28: town teleporter for maps 1002/1003/1004. Re-implements the
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- VNG "SuperTrap" (author yichuan 2004/6/29, script.pak id 0xCE741D0E, trap cells at
-- 1002 r103-104,100 / 1003 r103-104,96 / 1004 r98,102-103) whose logical path is unknown,
-- so the trap cannot be registered with ReLoadScript. Same destinations and level-based fee.

function gettranscost()
	local lv = GetLevel()
	if lv <= 30 then return 200 end
	if lv <= 50 then return 500 end
	if lv <= 70 then return 1000 end
	if lv <= 90 then return 2000 end
	return 5000
end;

function cantrans()
	if (GetMorphType()==364) or (IsPlayerInsideWeapon(PlayerIndex)>0) then
		return 0
	end
	return 1
end;

function main()
	if cantrans() ~= 1 then
		Talk(1,"no","ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp.")
		return
	end
	local cost = gettranscost()
	Say("TruyÒn tèng trËn: víi ®¼ng cÊp hiÖn t¹i, mçi lÇn chuyÓn ®i tèn <color=red>"..cost.." l­îng<color>. B¹n muèn ®i ®©u?", 11, "Sïng Thµnh ®¹i doanh/ccdy", "Ngäc H­ cung/yxg", "Xi V­u mé/cym", "TriÒu Ca/cg", "T©y Kú/xq", "Phong ThÇn ®µi/fst", "Diªu Tr×/yc", "ChiÕn tr­êng ViÔn Cæ/ygzc", "Thanh §ång s¬n/v58", "Tr­ Lung Thµnh tr¹i/v100", "KÕt thóc ®èi tho¹i/no")
end;

function PTExit_Go(w, x, y, fight)
	if cantrans() ~= 1 then
		Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp.")
		CloseDialog()
		return
	end
	local cost = gettranscost()
	if GetCash() < cost then
		Msg2Player("B¹n kh«ng ®ñ tiÒn!")
		CloseDialog()
		return
	end
	NewWorld(w, x, y)
	if fight then SetFightState(fight) end
	Pay(cost)
	CloseDialog()
end;

function ccdy()
	PTExit_Go(2,1608,3196,nil)
end;

function yxg()
	PTExit_Go(3,1692,3138,nil)
end;

function cym()
	PTExit_Go(4,1573,3229,nil)
end;

function cg()
	PTExit_Go(21,1723,3075,nil)
end;

function xq()
	PTExit_Go(20,1452,3086,nil)
end;

function fst()
	PTExit_Go(1,1536,3254,nil)
end;

function yc()
	PTExit_Go(52,1541,3190,nil)
end;

function ygzc()
	local cost = gettranscost()
	if cantrans() ~= 1 then
		Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp.")
	elseif GetPK() >= 88 then
		Msg2Player("Ng­êi ch¬i tªn ®á kh«ng thÓ chuyÓn ®Õn ViÔn Cæ.")
	elseif GetCamp() == 0 then
		Msg2Player("T©n thñ kh«ng thÓ vµo ViÔn Cæ.")
	elseif GetCash() >= cost then
		NewWorld(64,1600,3238)
		SetFightState(0)
		SetRevPos(64,216)
		Pay(cost)
	else
		Msg2Player("B¹n kh«ng ®ñ tiÒn!")
	end
	CloseDialog()
end;

function v58()
	PTExit_Go(57,1608,3094,nil)
end;

function v100()
	if GetLevel() < 30 then
		PTExit_Go(66,1545,3348,1)
	else
		Talk(1,"no","ChØ nh©n vËt d­íi cÊp 30 míi ®­îc vµo Tr­ Lung Thµnh tr¹i.")
	end
end;

function no()
	CloseDialog()
end;
