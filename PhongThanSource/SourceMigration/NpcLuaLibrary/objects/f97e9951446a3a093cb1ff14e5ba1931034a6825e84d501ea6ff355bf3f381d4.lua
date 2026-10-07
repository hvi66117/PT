--description: 任务-三山关
--author: yangfeng
--date: 2005/6/14

function main()
	if(GetTask(361)==1)then
		MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(361,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(361)
	if (count < 3) then
		SetGlobalValue(361,count+1)
	else
		SetGlobalValue(361,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1390,y=3497},
			{x=1364,y=3205},
			{x=1492,y=3104},
			{x=1700,y=3278},
			{x=1569,y=3469}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-三山关.lua")
		SetGlobalValue(29,pos[sel].x)
		SetGlobalValue(30,pos[sel].y)
	end;
	CloseDialog()
end;
