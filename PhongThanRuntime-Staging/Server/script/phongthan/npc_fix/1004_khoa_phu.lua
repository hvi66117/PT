-- Phong Than npc_fix 2026-09-28: Khoa Phu (kua fu totem, map 1004); original \script\ChiYouMu\KuaFuTuTeng.lua (pinyin of GBK PAK path, 977 bytes); changes: explicit exit row in SayTask (engine SayTask adds none), no() -> CloseDialog kept; task 30 phase logic (+4 at 1/3/9/11) unchanged.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ¿ä¸¸Í¼ÌÚ
--author: yichaun
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"Khai Trİ","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_20 = GetTask(30);
	if (UTask_20==1)  or  (UTask_20==3)or(UTask_20==9)or(UTask_20==11) then
			tasks[1].show=1
	end;
	SayTask(10160,tasks)
end;

function   renwu1()
	UTask_20 = GetTask(30);
	if(UTask_20==1)then
		Talk(1,"no",10161)
		Msg2Player("NhËn ®­îc sù chØ dÉn cña Khoa Phô.")
		TaskNote(13,3)
		SetTask(30,UTask_20+4)
	end;
	if(UTask_20==3)then
		Talk(1,"no",10161)
		Msg2Player("NhËn ®­îc sù chØ dÉn cña Khoa Phô.")
		TaskNote(13,5)
		SetTask(30,UTask_20+4)
	end;
	if(UTask_20==9)then
		Talk(1,"no",10161)
		Msg2Player("NhËn ®­îc sù chØ dÉn cña Khoa Phô.")
		TaskNote(13,4)
		SetTask(30,UTask_20+4)
	end;
	if(UTask_20==11) then
		Talk(1,"no",10161)
		Msg2Player("NhËn ®­îc sù chØ dÉn cña Khoa Phô.")
		TaskNote(13,7)
		SetTask(30,UTask_20+4)
	end;
end;

function no()
		CloseDialog()
end;
