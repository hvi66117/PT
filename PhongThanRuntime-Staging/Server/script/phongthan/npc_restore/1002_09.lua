-- Original VNG source payload; provenance in deployment report.
--description:³çºÚ»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11

function main()
	tasks = 
	{
		{"TrÇm H­¬ng","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"V¹n Tiªn trËn","renwu3";show=0}
	}

		UTask_Knight = GetTask(3);
		UTask_11 = GetTask(21);
		if(GetPlayerType()==0)and (GetLevel() >= 35)  and  (UTask_Knight==10) then  --¼×Ê¿15¼¶?Îñ
			tasks[1].show=1;
		end;
		if (UTask_11 == 6)  then
				tasks[2].show=1;
		end;
	PTQ2_SayTask(10238,tasks)
end;

function  renwu1()
				MsgBox(10239,"yes","no")
end;

function   renwu2()
				Talk(1,"no",10240)
				Msg2Player("Quay l¹i gÆp ¢u Thiªn Hãa!")
				TaskNote(8,6)
				SetTask(21,7)
end;

function yes()
		Talk(1,"no",10241)
		Msg2Player("NhËn lÖnh Sïng H¾c Hæ ®em 10 xe TrÇm H­¬ng Méc ®Õn TriÒu Ca cho Hoµng Phi Hæ.")
		AddEventItem(45)
		SetTask(3,11)
		TaskNote(27,3)
end;

function no()
		CloseDialog()
end;
--------------------------
function   renwu3()
	idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
				Talk(1,"no","Lóc nµy ng­¬i kh«ng thÓ vµo V¹n Tiªn trËn.")
		elseif(GetLevel()<=29)or(GetLevel()>=51)then
				Talk(1,"no","§¼ng cÊp cña ng­¬i kh«ng thÓ vµo V¹n Tiªn trËn (Thæ), h·y qua trËn kh¸c nhÐ.")
		elseif(HaveNormalItem(3,62,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox("Ng­¬i muèn vµo V¹n Tiªn trËn (Thæ) ®Ó th¸ch ®Êu víi Th«ng Thiªn Gi¸o Chñ ­?","yes_wxz","no")
		else
				Talk(1,"no","ChØ cÇn cã Thæ Linh Phï, ta sÏ cho ng­¬i vµo V¹n Tiªn khiªu chiÕn Th«ng Thiªn Gi¸o chñ.")
		end;
end;

function  yes_wxz()
		idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
		if (idx == -1) then 
			return
		end;
		SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
	if(GetGlobalValue(1)==1)and(GetMSPlayerCount(1,1)<50)and(GetTask(421)~=GetMissionV(1))then

		DelNormalItem(3,62,0,0)
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
		AddMSPlayer(1,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(67,1325,3280)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(1)==1)and(GetMSPlayerCount(1,1)<55)and(GetTask(421)==GetMissionV(1))then
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
		AddMSPlayer(1,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(67,1325,3280)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(1)==2)and(GetMSPlayerCount(1,1)<55)and(GetTask(421)==GetMissionV(1))then
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
		AddMSPlayer(1,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		NewWorld(67,1325,3280)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
	elseif(GetGlobalValue(1)==2)then
	    Talk(1,"no","§· qu¸ giê b¸o danh, xin h·y quay l¹i sau!")
	elseif(GetMSPlayerCount(1,1)>=50)then
	    Talk(1,"no","§· ®ñ 50 ng­êi, xin h·y ®îi trËn sau!")
	else
		Talk(1,"no","V¹n Tiªn trËn (thæ) ®· ®ãng, xin h·y quay l¹i sau!")
	end;
end;

pt_original_main = main
-- Authored restoration menu begins here.
-- AUTHORED NPC 1002_09; not a claim of original appearance.
function pt_guard()
    local w = GetWorldPos()
    if w ~= 1002 then CloseDialog(); return 0 end
    return 1
end
function main()
    if pt_guard() == 0 then return end
    Say("Sung Hac Ho - Sung Thanh doanh (213/200)", 5, "Vai tro va huong dan/pt_about", "NPC lien quan/pt_routes", "Trang thai chuc nang/pt_status", "Chuc nang VNG goc/pt_original", "Dong/pt_close")
end
function pt_about()
    if pt_guard() == 0 then return end
    Say("Tuong Sung Thanh trong chuoi Tan Thuc. Tim Lo Hung de theo dung thu tu nhiem vu.", 2, "Quay lai/main", "Dong/pt_close")
end
function pt_routes()
    if pt_guard() == 0 then return end
    Say("Sung Ung Loan (212/198); Sung Ung Buu (211/198); Ho Tro Tan Thu (210/200); Pham Nghia (210/200); Trieu Loi (216/197)", 2, "Quay lai/main", "Dong/pt_close")
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
