function  OnDeath(npcidx)
	SetGlobalValue(101,-1)
	DelNpc(npcidx)
	local w,x,y=GetWorldPos()
	if(GetTeam()~=0)then
		local oldPlayer=PlayerIndex
		local membercount=GetTeamSize()
		for i=1,membercount do
			PlayerIndex=GetTeamMember(i)
			liandan_open(w)
		end
		PlayerIndex=oldPlayer
	else
		liandan_open(w)
	end;
end;

function liandan_open(world)
	local task_id = 908
	local w,x,y = GetWorldPos()
	if (w == world) then
		if (GetTask(task_id)== 1)then
			Msg2Player("B¹n ®· h¹ s¸t thµnh c«ng Cöu Linh ")
			SetTask(task_id, 2)
			TaskNote(908, 2)
		end
	end
end