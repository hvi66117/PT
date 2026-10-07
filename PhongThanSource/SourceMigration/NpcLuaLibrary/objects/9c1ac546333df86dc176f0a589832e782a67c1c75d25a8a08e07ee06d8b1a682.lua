--description: ?务-西岐
--author: yangfeng
--date: 2005/6/14

function main()
	if(GetTask(354)==1)then
			MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(354,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(354)
	if (count < 3) then
		SetGlobalValue(354,count+1)
	else
		SetGlobalValue(354,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1324,y=3216},
			{x=1572,y=3140},
			{x=1560,y=3022},
			{x=1285,y=3033},
			{x=1467,y=2975}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-西岐.lua")
		SetGlobalValue(31,pos[sel].x)
		SetGlobalValue(32,pos[sel].y)
	end;
	CloseDialog()
end;

