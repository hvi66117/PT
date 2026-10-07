function  OnDeath(npcidx)
	SetGlobalValue(104,-1)
	DelNpc(npcidx)
	local  i=GetName()
	local  j=GetLevel()
	if (j<=90) then
		AddGlobalCountNews("Dòng sÜ <color=green>"..i.."<color> 1 kiÕm h¹ gôc <color=green>C«n Bèi<color>, nh©n gian l¹i ®­îc h­ëng sù thanh b×nh.",20)
	else
	end;
	local w,x,y=GetWorldPos()
	local lvl = GetNpcLevel(npcindex)
	if(GetTeam()~=0)then
		-- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		-- ¹M¾ú¶¤¤¤¶¤­û
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			city_shouji(w)
		end
		PlayerIndex=oldPlayer
	else
		-- µL¶¤¥î
			city_shouji(w)
	end;
end;

function city_shouji(world)
	local w,x,y=GetWorldPos()
	if (w == world) then
		local task_id = 864
		local item_id = 169
		local type_id = 14
		local item_name = "§Çu C«n Bèi"
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
				Msg2Player("Cßn ph¶i thu thËp "..item_name..(count1-item_count)..". ")
			else
				Msg2Player("Thu thËp ®ñ "..item_name.." ")
			end
		end
		if (type2 == type_id)then
			if(item_count < count2) then
				AddNormalItem(4,item_id,0,0,0,0)
				item_count = item_count + 1
			end
			if(item_count < count2) then
				Msg2Player("Cßn ph¶i thu thËp "..item_name..(count2-item_count)..". ")
			else
				Msg2Player("Thu thËp ®ñ "..item_name.." ")
			end
		end
	end
end