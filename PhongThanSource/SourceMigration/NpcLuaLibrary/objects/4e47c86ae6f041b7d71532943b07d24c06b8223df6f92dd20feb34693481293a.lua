function  OnDeath(npcidx)
		SetGlobalValue(107,-1)
		DelNpc(npcidx)
		local  i=GetName()
		AddGlobalCountNews("<color=green>"..i.."<color> m彋 家o k掐 li啐 <color=green>完i 告沿<color>, B徯h Du cung l隘 悌蟃 h卿ng thanh b莋h.",20)
	local w,x,y=GetWorldPos()
	local lvl = GetNpcLevel(npcindex)
	if(GetTeam()~=0)then
		-- 有隊伍(包括只有自己一個人的)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- 遍歷隊中隊員
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			city_shouji(w)
		end
		PlayerIndex=oldPlayer
	else
		-- 無隊伍
			city_shouji(w)
	end;
end;

function city_shouji()
	local w,x,y=GetWorldPos()
	if(w == world) then
		local task_id = 866
		local item_id = 170
		local type_id = 15
		local item_name = "序u 完i 告沿"
		local task_val = GetTask(task_id)
		local type1 = GetByte(task_val,1)
		local count1=	GetByte(task_val,2)
		local type2 = GetByte(task_val,3)
		local count2= GetByte(task_val,4)
	
		local item_count =IsExistItem(4,item_id,1,1)
		if (type1 == type_id)then
			if(item_count < count1) then
				AddNormalItem(4,item_id,0,0,0,0)
				item_count = item_count + 1
			end
			if(item_count < count1) then
				Msg2Player("C羧 ph進 thu th疕 "..item_name..(count1-item_count)..". ")
			else
				Msg2Player("Thu th疕 氧 "..item_name.." ")
			end
		end
		if (type2 == type_id)then
			if(item_count < count2) then
				AddNormalItem(4,item_id,0,0,0,0)
				item_count = item_count + 1
			end
			if(item_count < count2) then
				Msg2Player("C羧 ph進 thu th疕 "..item_name..(count2-item_count)..". ")
			else
				Msg2Player("Thu th疕 氧 "..item_name.." ")
			end
		end
	end
end