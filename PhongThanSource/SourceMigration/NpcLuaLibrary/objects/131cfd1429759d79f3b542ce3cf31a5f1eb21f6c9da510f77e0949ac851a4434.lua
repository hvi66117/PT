--description: À×Õð×Ó-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27

function main()
	tasks = 
	{
		{"ThÕ Së","renwu1";show=0}
	}
	UTask_Wizard = GetTask(1);
	if(UTask_Wizard == 17)then
			tasks[1].show=1;
	end;
	if(GetPlayerType()==1)and(GetLevel()>=35)  and  (UTask_Wizard == 2)then
			tasks[1].show=1;
	end;
		SayTask(10418,tasks)
end;

function  renwu1()
	UTask_Wizard = GetTask(1);
	if(UTask_Wizard == 17)then
			Talk(3,"no",10419,10420,10421)
			AddNormalItem(7,59,128,1,0,0)
			Msg2Player("Hoµn thµnh nhiÖm vô chiªu hµng, nhËn ®­îc MËt tÞch Ban M«n Léng Phñ")
			SetTask(1,20)
			TaskNote(28,10)
	end;
	if(GetPlayerType()==1)and(GetLevel()>=35)  and  (UTask_Wizard == 2)then
			MsgBox(10422,"yes","no")
	end;
end;

function yes()	
		Talk(1,"no",10423)
		Msg2Player("NhËn lÖnh Kh­¬ng Tö Nha, khuyªn 3 t­íng lÜnh nhµ Th­¬ng ®Çu Chu.")
		SetTask(1,10)
		TaskNote(28,2)
end;

function no()	
		CloseDialog()
end;
