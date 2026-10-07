--description: 任务-崇城大营
--author: yangfeng
--date: 2005/6/14

function main()
	if(GetTask(351)==1)then
			MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(351,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(351)
	if (count < 3) then
		SetGlobalValue(351,count+1)
	else
		SetGlobalValue(351,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1543,y=3258},
			{x=1656,y=3078},
			{x=1697,y=3097},
			{x=1735,y=3139},
			{x=1701,y=3279}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-崇城大营.lua")
		SetGlobalValue(13,pos[sel].x)
		SetGlobalValue(14,pos[sel].y)
	end;
	CloseDialog()
end;
