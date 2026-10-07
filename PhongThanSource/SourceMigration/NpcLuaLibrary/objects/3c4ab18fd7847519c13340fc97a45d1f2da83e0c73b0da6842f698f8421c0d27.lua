--description: 任务-孟津
--author: yangfeng
--date: 2005/6/14


function main()
	if(GetTask(363)==1)then
		MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(363,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(363)
	if (count < 3) then
		SetGlobalValue(363,count+1)
	else
		SetGlobalValue(363,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1617,y=3276},
			{x=1569,y=2998},
			{x=1391,y=3017},
			{x=1388,y=3556},
			{x=1793,y=3516}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-孟津.lua")
		SetGlobalValue(27,pos[sel].x)
		SetGlobalValue(28,pos[sel].y)
	end;
	CloseDialog()
end;
