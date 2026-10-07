--description: »ÆÁú­â?-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/6/11

function main()
	tasks = 
	{
		{"Chinh §å","renwu1";show=0},
		{"Ngò ThÊt","renwu2";show=0}
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
			Talk(1,"no",10557)
			TaskNote(2,1)
			Msg2Player("§­îc sù chØ dÉn cña Hoµng Long ch©n nh©n ®i ch©n nói C«n L«n thu thËp B¨ng c¬.")
			SetTask(11,2)
end;

function yes()
		Talk(1,"no",10558)
	    AddEventItem(0)
		Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bÞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
		SetTask(1,1)
		TaskNote(28,0)
end;

function no()
		CloseDialog()
end;
