-- Phong Than npc_fix 2026-09-28: Sung Hac Ho (Chong Heihu); original script.pak \script\[GBK chongchengdaying]\[GBK chongheihu].lua; changes: exit row on SayTask, no authored wrapper menu, yes() task 3 phase 10->11 gives EventItem 45 via QuestExchange; yes_wxz: unregistered DelHandItem calls disabled (bag cleanup loop kept), first-entry branch now requires DelNormalItem(3,62,0,0) to succeed before entering Van Tien tran.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description:³çºÚ»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11

function main()
	tasks =
	{
		{"TrÇm H­¬ng","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"V¹n Tiªn trËn","renwu3";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}

		UTask_Knight = GetTask(3);
		UTask_11 = GetTask(21);
		if(GetPlayerType()==0)and (GetLevel() >= 35)  and  (UTask_Knight==10) then  --¼×Ê¿15¼¶?Îñ
			tasks[1].show=1;
		end;
		if (UTask_11 == 6)  then
				tasks[2].show=1;
		end;
	SayTask(10238,tasks)
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
		if(QuestExchange(3,10,11,{},{{4,45,0,0,0,0,1}})~=1)then
			Msg2Player("Hanh trang khong du cho trong.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10241)
		Msg2Player("NhËn lÖnh Sïng H¾c Hæ ®em 10 xe TrÇm H­¬ng Méc ®Õn TriÒu Ca cho Hoµng Phi Hæ.")
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

		if(DelNormalItem(3,62,0,0)~=1)then		-- npc_fix: entry token must really be taken from the bag
			Msg2Player("Can Tho Linh Phu trong hanh trang.")
			CloseDialog()
			return
		end;
		-- npc_fix: DelHandItem is not registered in this GameServer (would abort the script); disabled below.
		--DelHandItem(3,66,0,0)
		--DelHandItem(3,67,0,0)
		--DelHandItem(3,68,0,0)
		--DelHandItem(3,69,0,0)
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
		--DelHandItem(3,66,0,0)
		--DelHandItem(3,67,0,0)
		--DelHandItem(3,68,0,0)
		--DelHandItem(3,69,0,0)
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
		--DelHandItem(3,66,0,0)
		--DelHandItem(3,67,0,0)
		--DelHandItem(3,68,0,0)
		--DelHandItem(3,69,0,0)
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
