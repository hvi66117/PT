--description: 任务-游魂关
--author: yangfeng
--date: 2005/6/14


function main()
	if(GetTask(360)==1)then
			MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(360,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(360)
	if (count < 3) then
		SetGlobalValue(360,count+1)
	else
		SetGlobalValue(360,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1838,y=3587},
			{x=1819,y=3084},
			{x=1611,y=3054},
			{x=1595,y=3292},
			{x=1701,y=3372}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-游魂关.lua")
		SetGlobalValue(23,pos[sel].x)
		SetGlobalValue(24,pos[sel].y)
	end;
	CloseDialog()
end;
