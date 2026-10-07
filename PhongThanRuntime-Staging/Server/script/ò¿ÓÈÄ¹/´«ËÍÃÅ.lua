--description: ÍòÏÉÕó[Ë®]
--author: yujin
--date: 2005/4/14

function main(sel)
	tasks = 
	{
		{"V¹n Tiªn trËn","renwu2";show=1}
	}
	if(GetGlobalValue(2)==0)then
		SayTask(11134,tasks)			
	elseif(GetGlobalValue(2)==1)then
		SayTask(11135,tasks)			
	elseif(GetGlobalValue(2)==2)then
		SayTask(11136,tasks)			
	end;
end;

function no()
		CloseDialog()
end;
---------------------------
function   renwu2()
	idx = SubWorldID2Idx(68); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
	if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
			Talk(1,"no",11137)
	elseif(GetLevel()<=50)or(GetLevel()>=71)then
			Talk(1,"no",11138)
	elseif(7~=GetCamp())or(87<GetPK())then
			Talk(1,"no","ChØ cho phÐp nh©n vËt phe xanh  vµo.")
	elseif(HaveNormalItem(3,63,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
			MsgBox(11139,"yes_wxz","no")
	else
			Talk(1,"no",11140)
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
	local mission_step = GetGlobalValue(2)
	if (mission_step == 1) then
		SetFightState(0)
	else
		SetFightState(1)
	end
	AddMSPlayer(2,1)
	SetLogoutRV(1)
	SetTask(421,GetMissionV(1))
	LockCamp(1)--Ëø¶¨ÕóÓª
	NewWorld(68,1752,3567)
	StopUsePills()
	Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
	CloseDialog()
end

function  yes_ib()
	idx = SubWorldID2Idx(68); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(2)
	local ibplayer_count =  GetGlobalValue(66)
	local noneib_player_count = GetGlobalValue(62)
	local player_count = ibplayer_count + noneib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)

	if (mission_step == 1) then
		if(player_count <200) then
			if(player_key ~= mission_key) then
				if(FindAValidIBItem(8,145,2,0)>=1)then
					DelNormalItem(3,63,0,0)
					CostIBItem(FindAValidIBItem(8,145,2,0))
					SetGlobalValue(66,GetGlobalValue(66)+1)
					do_enter()
				else
					Talk(1,"no","Xin lçi! Ng­¬i kh«ng cã Thñy Linh th¹ch!")
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
		Talk(1,"no",11143)
	end

end


function  yes_wxz()
	idx = SubWorldID2Idx(68); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(2)
	local ibplayer_count =  GetGlobalValue(66)
	local noneib_player_count = GetGlobalValue(62)
	local player_count = ibplayer_count + noneib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)
	
	if (player_key == mission_key) then
		if (mission_step == 1 or mission_step == 2) then
			do_enter()
		else
			Talk(1,"no",11143)
		end
	else
		if (mission_step == 1) then
			if(player_count < 200 )then
				if(noneib_player_count < 50) then
					DelNormalItem(3,63,0,0)
					SetGlobalValue(62,noneib_player_count+1)
					do_enter()
				else
					MsgBox("Sè ng­êi trong V¹n Tiªn trËn ®· ®Çy, nÕu ng­¬i cã <color=green>Thñy Linh th¹ch<color> ta sÏ gióp ng­êi vµo bªn trong.","yes_ib","no")
				end
			else
				Talk(1,"no","Ng­¬i ®Õn trÔ ma qu¸i trong trËn ®· hãa phÐp ng¨n chÆn cöa vµo!")
			end
		else
			Talk(1,"no",11143)
		end
	end
end;
