--description: ÎÅÌ«Ê¦-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"Ma huyÕt","renwu1";show=0}
	}
	UTask_Druid = GetTask(2);
	if (UTask_Druid==33)  and  (HaveEventItem(19)>=1)then
				tasks[1].show=1;
	end;
	if(GetPlayerType()==2)and(GetLevel()>=55)  and (UTask_Druid==30)and (HaveEventItem(17)>=1)then
				tasks[1].show=1;
	end;

	SayTask(10369,tasks)
end;

function   renwu1()
		UTask_Druid = GetTask(2);
		if (UTask_Druid==33)  and  (HaveEventItem(19)>=1)then
				Talk(1,"no",10370)
				Msg2Player("Mang ma huyÕt ®i TriÒu Ca t×m Hå Hû MÞ.")
		        SetTask(2,34)
				TaskNote(29,13)
		end;

		if(GetPlayerType()==2)and(GetLevel()>=55)  and (UTask_Druid==30)and (HaveEventItem(17)>=1)then
				Talk(2,"func_leave",10371,10372)
	
		end;
end;

function  func_leave()
		Talk(1,"func_leave1",10373)
end;

function  func_leave1()
		MsgBox(10374,"yes","no")
end;

function  yes()
		CloseDialog()
		DelEventItem(17)
		SetTask(2,31)
		TaskNote(29,10)
		Msg2Player("NhËn lêi gióp V¨n th¸i s­ t×m Kim Qu¸n cña Háa Linh th¸nh mÉu ®­a cho Th«ng Thiªn gi¸o chñ ë BÝch Du Cung.")
end;

function no()
		CloseDialog()
end;
