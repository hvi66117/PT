--description: ³£ê»-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"Cæ §ao ","renwu1";show=0}
	}
			UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
					tasks[1].show=1;
		end;

		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
					tasks[1].show=1;
		end;
		SayTask(10343,tasks)
end;

function  renwu1()
		UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
						Talk(1,"no",10344)
						AddEventItem(17)			
						AddNormalItem(0,0,34,4,1,0)
						SetTask(2,30)
						TaskNote(29,9)
						Msg2Player("Cøu ®­îc dÞ nh©n, nhËn ®­îc Phôc ThÕ phñ!")
		end;
		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
						Talk(3,"no",10345,10346,10347)
						SetTask(2,21)
						TaskNote(29,7)
						Msg2Player("Cøu ®­îc DÞ nh©n.")
		end;
end;

function   no()
	CloseDialog()
end;
