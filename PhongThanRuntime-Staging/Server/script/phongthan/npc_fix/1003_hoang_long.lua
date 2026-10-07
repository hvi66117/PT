-- Phong Than npc_fix 2026-09-28: Hoang Long Chan Nhan (1003); original script.pak \script\YuXuGong\HuangLongZhenRen.lua (GBK names); changes:
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--   SayTask exit row "Ket thuc doi thoai" -> no(); task 1 phase 0->1 grants
--   EventItem 0 (thu tien cu) atomically via QuestExchange(1,0,1) and re-checks
--   PlayerType/level; renwu2 re-checks task 11 phase 1 before SetTask(11,2).
--description: »ÆÁú­â?-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/6/11

function main()
	tasks = 
	{
		{"Chinh §å","renwu1";show=0},
		{"Ngò ThÊt","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);	
	if (GetPlayerType()==1)and(GetLevel() >= 25)  and  (UTask_Wizard==0) then
			tasks[1].show=1;
	end;
	UTask_01=GetTask(11);
	if (UTask_01==1)then
			tasks[2].show=1;
	end;

	SayTask(10555,tasks)
end;

function  renwu1()
			MsgBox(10556,"yes","no")				--µÀÊ¿5¼¶?Îñ

end;

function  renwu2()
			if (GetTask(11)~=1) then
				CloseDialog()
				return
			end;
			Talk(1,"no",10557)
			TaskNote(2,1)
			Msg2Player("§­îc sù chØ dÉn cña Hoµng Long ch©n nh©n ®i ch©n nói C«n L«n thu thËp B¨ng c¬.")
			SetTask(11,2)
end;

function yes()
		if (GetPlayerType()~=1)or(GetLevel()<25) then
			CloseDialog()
			return
		end;
		if (QuestExchange(1,0,1,{},{{4,0,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the nhan thu tien cu: hanh trang day hoac nhiem vu da nhan.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10558)
		Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bÞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
		TaskNote(28,0)
end;

function no()
		CloseDialog()
end;
