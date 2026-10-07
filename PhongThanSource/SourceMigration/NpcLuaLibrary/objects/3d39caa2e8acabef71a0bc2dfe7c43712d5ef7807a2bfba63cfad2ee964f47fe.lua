--description: 任务-崇城野外
--author: yangfeng
--date: 2005/6/14

function main()
	if(GetTask(359)==1)then
			MsgBox(11205,"renwu")
	else
		MsgBox(11206,"no")
	end;
end;

function no()
	CloseDialog()
end;

function renwu()
	SetTask(359,2)
	SetTask(365,0)
	TaskNote(34,16)
	local count = GetGlobalValue(359)
	if (count < 3) then
		SetGlobalValue(359,count+1)
	else
		SetGlobalValue(359,0)
		DelNpc(DialogNpcIdx)

		local pos = 
		{
			{x=1560,y=3234},
			{x=1785,y=3194},
			{x=1838,y=2965},
			{x=1653,y=2785},
			{x=1565,y=2970}
		}
		local sel=random(1,5)
		local npcidx=AddNpc(255, 1, SubWorld, pos[sel].x * 32, pos[sel].y * 32)
		SetNpcScript(npcidx, "\\script\\神秘花卉任务\\任务-崇城野外.lua")
		SetGlobalValue(19,pos[sel].x)
		SetGlobalValue(20,pos[sel].y)
	end;
	CloseDialog()
end;
