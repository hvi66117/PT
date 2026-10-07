--description: 任务-昆仑山麓
--author: yangfeng
--date: 2005/6/14


function main()
	if(GetTask(358)==1)then
			MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(358,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(358)
	if (count < 3) then
		SetGlobalValue(358,count+1)
	else
		SetGlobalValue(358,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1945,y=2851},
			{x=2029,y=3034},
			{x=1922,y=3185},
			{x=1869,y=3227},
			{x=1771,y=3397}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-昆仑山麓.lua")
		SetGlobalValue(21,pos[sel].x)
		SetGlobalValue(22,pos[sel].y)
	end;
	CloseDialog()
end;
