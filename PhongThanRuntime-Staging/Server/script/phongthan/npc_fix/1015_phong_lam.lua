-- Phong Than npc_fix 2026-09-28: Phong Lam (feng lin, map 1015); original script.pak \script\MengJin\FengLin.lua (pinyin of GBK PAK path); changes: exit row in SayTask; yes() phase guard (task 2 ==10, Di Nhan, level>=35) so the confirm box cannot reset a later phase; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ·çÁÖ-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function main()
	tasks = 
	{
		{"BÊt Tóy ","renwu1";show=0},
		{"Vµo s¬n cèc ","come";show=1},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Druid = GetTask(2);
	if(GetPlayerType()==2)and(GetLevel()>=35)  and  (UTask_Druid ==10 )then
			tasks[1].show=1
	end;


	SayTask(10348,tasks)
end;

function   renwu1()
			Talk(3,"func_leave",10349,10350,10351)
end;

function  func_leave()
	MsgBox(10352,"yes","no")
end;

function  yes()
	CloseDialog()
	if (GetPlayerType()~=2) or (GetLevel()<35) or (GetTask(2)~=10) then	-- npc_fix: phase guard
		return
	end;
	NewWorld(15,1687,3106)--´«ËÍ½ø?É½¹È
	SetTask(2,11)
	TaskNote(29,3)
	Msg2Player("Vµo s¬n cèc, cøu bän DÞ nh©n say r­îu.")
end;

function  no()
		CloseDialog()
end;

function  come()
		NewWorld(15,1687,3106)--´«ËÍ½ø?É½¹È
		CloseDialog()
end;
