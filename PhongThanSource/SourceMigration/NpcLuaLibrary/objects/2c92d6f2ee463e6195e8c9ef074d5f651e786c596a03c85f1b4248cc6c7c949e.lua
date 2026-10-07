--description:Ö£Â×-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/11

function main()
	tasks = 
	{
		{"Trung Thµnh","renwu1";show=0}
	}
	UTask_Knight = GetTask(3);
	if (GetPlayerType()==0) and (UTask_Knight==1) then        --¼×Ê¿5¼¶ÈÎÎñ
			tasks[1].show=1
	end;
		SayTask(10284,tasks)
end;

function   renwu1()
			Talk(1,"no",10285)
			AddEventItem(11)
			SetTask(3,2)
			Msg2Player("Mang huyÕt th­ cña TrŞnh Lu©n vÒ cho Sïng HÇu Hæ.")
			TaskNote(27,1)
end;

function no()
		CloseDialog()
end;
