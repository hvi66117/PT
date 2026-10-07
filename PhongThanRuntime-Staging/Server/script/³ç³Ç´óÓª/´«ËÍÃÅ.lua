--description: ÍòÏÉÕó[ÍÁ]
--author: yujin
--date: 2005/4/14

function main()
	tasks = 
	{
		{"V¹n Tiªn trËn","renwu3";show=1}
	}
	if(GetGlobalValue(1)==0)then
		SayTask(11176,tasks)			
	elseif(GetGlobalValue(1)==1)then
		SayTask(11177,tasks)			
	elseif(GetGlobalValue(1)==2)then
		SayTask(11178,tasks)			
	end;
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
				Talk(1,"no",11179)
		elseif(GetLevel()<=29)or(GetLevel()>=51)then
				Talk(1,"no",11180)
		elseif(7~=GetCamp())or(87<GetPK())then
				Talk(1,"no","ChØ cho phÐp nh©n vËt phe xanh  vµo.")
		elseif(HaveNormalItem(3,62,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox(11181,"yes_wxz","no")
		else
				Talk(1,"no",11182)
		end;
end;

function do_enter()
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
	
	local mission_step = GetGlobalValue(1)
	if (mission_step == 1) then
		SetFightState(0)
	else
		SetFightState(1)
	end
		AddMSPlayer(1,1)
		SetLogoutRV(1)
		SetTask(421,GetMissionV(1))
		LockCamp(1)--Ëø¶¨ÕóÓª
		NewWorld(67,1325,3280)
		StopUsePills()
		Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
		CloseDialog()
end

function  yes_ib()
	idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(1)
	local noneib_player_count = GetGlobalValue(61)
	local ib_player_count = GetGlobalValue(65)
	local player_count = noneib_player_count+ib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)

	if (mission_step == 1) then
		if(player_count <200) then
			if(player_key ~= mission_key) then
				if(FindAValidIBItem(8,144,2,0)>=1)then
					DelNormalItem(3,62,0,0)
					CostIBItem(FindAValidIBItem(8,144,2,0))
					SetGlobalValue(65,GetGlobalValue(65)+1)
					do_enter()
				else
					Talk(1,"no","Xin lçi! Ng­¬i kh«ng cã Thæ Linh Th¹ch.")
				end
			else
				do_enter()
			end	
		else
			Talk(1,"no","Sè ng­êi trong trËn ®· ®Çy, Linh Th¹ch còng kh«ng thÓ gióp ng­¬i vµo trong.")
		end
	elseif(mission_step == 2) then
		if(player_count < 200 and player_key==mission_key) then
			do_enter()
		else
			Talk(1,"no","Ng­¬i ®Õn trÔ ma qu¸i trong trËn ®· hãa phÐp ng¨n chÆn cöa vµo!")
		end
	else
		Talk(1,"no",11183)
	end

end


function  yes_wxz()
	idx = SubWorldID2Idx(67); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(1)
	local noneib_player_count = GetGlobalValue(61)
	local ib_player_count = GetGlobalValue(65)
	local player_count = noneib_player_count+ib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)
	
	if (player_key == mission_key) then
		if (mission_step == 1 or mission_step == 2) then
			do_enter()
		else
			Talk(1,"no",11183)
		end
	else
		if (mission_step == 1) then
			if(player_count < 200 )then
				if(noneib_player_count < 50) then
					DelNormalItem(3,62,0,0)
					SetGlobalValue(61,noneib_player_count+1)
					do_enter()
				else
					MsgBox("V¹n Tiªn trËn ®· ®ñ ng­êi, trõ khi ng­¬i cã <color=green>Thæ Linh Th¹ch<color> ta cã thÓ ph¸ lÖ cho ng­¬i vµo!","yes_ib","no")
				end
			else
				Talk(1,"no","Ng­¬i ®Õn trÔ ma qu¸i trong trËn ®· hãa phÐp ng¨n chÆn cöa vµo!")
			end
		else
			Talk(1,"no",11183)
		end
	end
end;