-- Original VNG source payload; provenance in deployment report.
--description: ÉÙê»Í¼ÌÚ-Ò©Æ·ÏúÊÛÕß
--author:  chensong
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"V¹n Tiªn trËn","renwu2";show=0}
	}
	UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
	if (UTask_20==15)then
			tasks[1].show=1;
	end;
	if(UTask_20==0)  then
			tasks[1].show=1;
	end;
	PTQ2_SayTask(10162,tasks)
end;

function   renwu1()
	UTask_20 = GetTask(30);--¼ÇÂ¼¸ÃÈÎÎñµÄ±àºÅ
	if (UTask_20==15)then
		Talk(1,"no",10163)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,0,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		AddNormalItem(1,3,1,1,0,0)
		Msg2Player("NhËn ®­îc phÇn th­ëng cña ThiÕu H¹o gåm 3 TiÓu Hång ®¬n vµ 3 TiÓu Hoµn ®¬n.")
		TaskNote(13,8)
		SetTask(30,16)
	end;
	if(UTask_20==0)  then
		Talk(3,"no",10164,10165,10166)
		SetTask(30,1)
		TaskNote(13,0)
		Msg2Player("§­îc sù chØ dÉn cña ThiÕu H¹o. §Õn t×m Khoa Phô, Chóc Dung, Phong B¸ nhê gióp ®ì.")
	end;
end;


function no()
		CloseDialog()
end;
---------------------------
function   renwu2()
	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
				Talk(1,"no","Tr¹ng th¸i hiÖn t¹i cña ng­¬i kh«ng thÓ vµo V¹n Tiªn trËn.")
		elseif(GetLevel()<=50)or(GetLevel()>=71)then
				Talk(1,"no","§¼ng cÊp cña ng­¬i ch­a thÓ vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ, thö qua trËn kh¸c xem sao!")
		elseif(HaveNormalItem(3,63,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox("Ng­¬i muèn vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ ph¶i kh«ng?","yes_wxz","no")
		else
				Talk(1,"no","NÕu ng­¬i ®­a ta mét tÊm Thñy Linh phï th× ta sÏ gióp ng­¬i vµo V¹n Tiªn trËn (thñy) giao ®Êu víi Th«ng Thiªn gi¸o chñ.")
		end;
end;

function  yes_wxz()
	idx = SubWorldID2Idx(68); -- È·±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ÈÎÎñ¿ªÆô±ØÐèµÄ±äÁ¿
	if(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<50)and(GetTask(421)~=GetMissionV(1))then
	
		DelNormalItem(3,63,0,0)
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
		for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)	
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
		end;
		SetFightState(0)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==1)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(1))then
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;

		SetFightState(0)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==2)and(GetMSPlayerCount(2,1)<55)and(GetTask(421)==GetMissionV(1))then
		DelHandItem(3,66,0,0)
		DelHandItem(3,67,0,0)
		DelHandItem(3,68,0,0)
		DelHandItem(3,69,0,0)
			for i=1,60 do
				if(HaveNormalItem(3,66,0,0)>=1)then
							DelNormalItem(3,66,0,0)
				elseif(HaveNormalItem(3,67,0,0)>=1)then
							DelNormalItem(3,67,0,0)
				elseif(HaveNormalItem(3,68,0,0)>=1)then
							DelNormalItem(3,68,0,0)
				elseif(HaveNormalItem(3,69,0,0)>=1)then
							DelNormalItem(3,69,0,0)
				else
							break;
				end;
			end;
		SetFightState(1)
		AddMSPlayer(2,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(68,1752,3567)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(2)==2)then
	    Talk(1,"no","TrËn ®Êu ®ang diÔn ra, xin ®îi gi©y l¸t!")
	elseif(GetMSPlayerCount(2,1)>=50)then
	    Talk(1,"no","§· ®ñ 50 ng­êi, lÇn sau quay l¹i nhÐ!")
	else
		Talk(1,"no","V¹n Tiªn trËn (thñy) ®· ®ãng, lÇn sau quay l¹i nhÐ!")
	end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1004_00; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1004 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Thieu Hao - Xi Vuu Mo (198/204)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Dau moi Khai Tri cua Di Nhan. Nghe loi chi dan cua cac totem tai Xi Vuu Mo roi quay lai phuc menh.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Chuyen Sinh Lao Lao (196/202); Lao Rua (200/202); Phong Ba (195/204); Hau Tho (202/204); Ho Tro Tan Thu (194/205)", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_status()
    if pt_guard() == 0 then return end
    Say("Co nhanh Lua VNG goc trong PAK. Cac dieu kien va giao dich do nhanh goc kiem tra; chua nghiem thu toan bo nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_close()
    CloseDialog()
end
function pt_original()
    if pt_guard() == 0 then return end
    pt_original_main()
end

-- questfix2 2026-10-03: the VNG menus above only list quest rows (show=0 until a quest is due), so a
-- player with no quest got a dialog without any row. PTQ2_SayTask adds a "Ket thuc doi thoai" row;
-- with no visible row it shows PTQ2_FLAV (when set) or the VNG greeting with that row only.
-- Quest rows, conditions and callbacks are unchanged.
PTQ2_EXIT = "K\213t th\243c \174\232i tho\185i"
PTQ2_IDLE = "Hi\214n ta kh\171ng c\227 vi\214c g\215 c\199n nh\234 \174\213n ng\173\172i."
PTQ2_FLAV = nil
function PTQ2_Close()
	CloseDialog()
end
function PTQ2_SayTask(id, tasks)
	local n = getn(tasks)
	local vis = 0
	local ex = 0
	local c = {}
	local i = 1
	while i <= n do
		local t = tasks[i]
		c[i] = t
		if type(t) == "table" and (t.show == nil or t.show ~= 0) then
			vis = vis + 1
			local f = t[2]
			if type(f) ~= "string" then f = "" end
			f = strlower(f)
			if f == "no" or f == "cancel" or f == "oncancel" or f == "ptq2_close" or strsub(f, 1, 3) == "no_" or strsub(f, 1, 4) == "exit" or strsub(f, 1, 3) == "end" or strsub(f, 1, 5) == "close" then ex = 1 end
			if type(t[1]) == "string" and strfind(t[1], PTQ2_EXIT, 1, 1) then ex = 1 end
		end
		i = i + 1
	end
	if (vis == 0 and PTQ2_FLAV) or id == nil then
		local s = PTQ2_FLAV
		if s == nil then s = PTQ2_IDLE end
		Say(s, 1, PTQ2_EXIT .. "/PTQ2_Close")
		return
	end
	if ex == 0 then c[n + 1] = { PTQ2_EXIT, "PTQ2_Close"; show = 1 } end
	SayTask(id, c)
end

-- 2026-10-03 daily3 (F11): quest-log records from the taskinfo texts (vng_tasknote.lua) instead of the C++
-- "Task N - step S" placeholder; appended so the original script body above stays byte-identical.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
