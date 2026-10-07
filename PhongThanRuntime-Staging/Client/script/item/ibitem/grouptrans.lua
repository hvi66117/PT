--description: 队长召集令
--author: liuying	
--date: 2006/1/18

function main(itemID)
	SetExeState(0)
	if(IsCaptain()==1)then
		if(GetTeamSize()>0)then
			check()
		else
			Talk(1,"no"," ")
		end;
	else
		Talk(1,"no"," ")
	end
end;

function check()
	local i=FindAValidIBItem(8,35,2,0)
	local mapid,x,y=GetWorldPos()
	if(i~=0)then
		if(mapid~=66)and(mapid~=72)and(mapid~=61)and(mapid~=62)and(mapid~=63)then
			trans()
			CostIBItem(i)
		else
			Talk(1,"no"," ")
		end
	else
		Talk(1,"no"," ")
	end
end

function trans()
	local mark=0
	local mapid,x,y=GetExactWorldPos()
	if(mapid~=1)and(mapid~=71)and(mapid~=2)and(mapid~=3)and(mapid~=4)and(mapid~=21)and(mapid~=20)and(mapid~=52)and(mapid<99)and(mapid~=57)and(mapid~=64)then
		mark=1
	end;
	local oldPlayer=PlayerIndex
	local membercount=GetTeamSize()
	-- 遍历队中队员
	for i=1,membercount do
		PlayerIndex=GetTeamMember(i)
		ExactNewWorld(mapid,x,y)
		SetFightState(mark)
	end	
	PlayerIndex=oldPlayer	
end



