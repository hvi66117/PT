--description: ÍòÏÉÕó[·ç]
--author: yujin
--date: 2005/4/14

function main(sel)
	tasks = 
	{
		{"V¹n Tiªn trËn","renwu1";show=1}
	}
	if(GetGlobalValue(4)==0)then
		SayTask(11194,tasks)			
	elseif(GetGlobalValue(4)==1)then
		SayTask(11195,tasks)			
	elseif(GetGlobalValue(4)==2)then
		SayTask(11196,tasks)			
	end;
end;

function no()
		CloseDialog()
end;
-----------------
function   renwu1()
	idx = SubWorldID2Idx(70); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then
				Talk(1,"no",11197)
		elseif(GetLevel()<=90)then
				Talk(1,"no",11198)
		elseif(7~=GetCamp())or(87<GetPK())then
				Talk(1,"no","ChØ cho phÐp nh©n vËt phe xanh  vµo.")
		elseif(HaveNormalItem(3,65,0,0)>=1)or(GetTask(421)==GetMissionV(1))then
				MsgBox(11199,"yes_wxz","no")
		else
				Talk(1,"no",11200)
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

	local mission_step = GetGlobalValue(4)
	if (mission_step == 1) then
		SetFightState(0)
	else
		SetFightState(1)
	end

	AddMSPlayer(4,1)
	SetLogoutRV(1)
	SetTask(421,GetMissionV(1))
	local pos = 
	{
		{x=1671,y=3035},
		{x=1525,y=3144},
		{x=1592,y=3387},
		{x=1786,y=3269}
	}
	local sel=random(1,getn(pos))
	LockCamp(1)--Ëø¶¨ÕóÓª
	NewWorld(70,pos[sel].x,pos[sel].y)
	StopUsePills()
	Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
	CloseDialog()
end

function  yes_ib()
	idx = SubWorldID2Idx(70); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(4)
	local noneib_player_count = GetGlobalValue(64)
	local ib_player_count = GetGlobalValue(68)
	local player_count = noneib_player_count+ib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)

	if (mission_step == 1) then
		if(player_count <200) then
			if(player_key ~= mission_key) then
				if(FindAValidIBItem(8,147,2,0)>=1)then
					DelNormalItem(3,65,0,0)
					CostIBItem(FindAValidIBItem(8,147,2,0))
					SetGlobalValue(68,GetGlobalValue(68)+1)
					do_enter()
				else
					Talk(1,"no","B¹n kh«ng cã Phong Linh th¹ch")
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
		Talk(1,"no",11201)
	end

end


function  yes_wxz()
	idx = SubWorldID2Idx(70); -- ?±£µØÍ¼ÔÚÕâÌ¨·þÎñÆ÷
	if (idx == -1) then 
		return
	end;
	SubWorld = idx; -- ?Îñ¿ªÆô±ØÐèµÄ±äÁ¿

	local mission_step = GetGlobalValue(4)
	local noneib_player_count = GetGlobalValue(64)
	local ib_player_count = GetGlobalValue(68)
	local player_count = noneib_player_count+ib_player_count
	local player_key = GetTask(421)
	local mission_key = GetMissionV(1)

	if (player_key == mission_key) then
		if (mission_step == 1 or mission_step == 2) then
			do_enter()
		else
			Talk(1,"no",11201)
		end
	else
		if (mission_step == 1) then
			if(player_count < 200 )then
				if(noneib_player_count < 50) then
					DelNormalItem(3,65,0,0)
					SetGlobalValue(64,noneib_player_count+1)
					do_enter()
				else
					MsgBox("Sè ng­êi trong V¹n Tiªn trËn ®· ®Çy, trõ khi ng­¬i cã <color=green>Phong Linh th¹ch<color> ta míi cã thÓ gióp","yes_ib","no")
				end
			else
				Talk(1,"no","Ng­¬i ®Õn trÔ ma qu¸i trong trËn ®· hãa phÐp ng¨n chÆn cöa vµo!")
			end
		else
			Talk(1,"no",11201)
		end
	end;
end;
