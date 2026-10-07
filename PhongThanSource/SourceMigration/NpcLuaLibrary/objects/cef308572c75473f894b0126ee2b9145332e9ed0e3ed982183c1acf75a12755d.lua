--description: 任务-矿场
--author: yangfeng
--date: 2005/6/14


function main()
	if(GetTask(357)==1)then
		MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(357,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(357)
	if (count < 3) then
		SetGlobalValue(357,count+1)
	else
		SetGlobalValue(357,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1599,y=2959},
			{x=1475,y=2968},
			{x=1428,y=3164},
			{x=1444,y=3287},
			{x=1641,y=3373}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-矿场.lua")
		SetGlobalValue(37,pos[sel].x)
		SetGlobalValue(38,pos[sel].y)
	end;
	CloseDialog()
end;
