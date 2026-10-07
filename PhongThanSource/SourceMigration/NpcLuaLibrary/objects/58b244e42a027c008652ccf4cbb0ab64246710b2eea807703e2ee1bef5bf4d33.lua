--description: 任务-朝歌
--author: yangfeng
--date: 2005/6/14


function main()
	if(GetTask(353)==1)then
		MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(353,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(353)
	if (count < 3) then
		SetGlobalValue(353,count+1)
	else
		SetGlobalValue(353,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1563,y=3209},
			{x=1562,y=2962},
			{x=1906,y=2888},
			{x=1784,y=2860},
			{x=1874,y=3187}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-朝歌.lua")
		SetGlobalValue(33,pos[sel].x)
		SetGlobalValue(34,pos[sel].y)
	end;
	CloseDialog()
end;