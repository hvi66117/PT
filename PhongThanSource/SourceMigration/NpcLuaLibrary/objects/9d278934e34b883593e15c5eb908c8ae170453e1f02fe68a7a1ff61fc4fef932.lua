--description: 酒店老晃-异?主线?务
--author: yichuan
--date:2004/5/13

function  main()
			tasks = 
			{
				 {"B蕋 T髖 ","renwu1";show=0}
			}
			UTask_Druid = GetTask(2);
			if(GetLevel()>=35)  and  (UTask_Druid==12)  and  (HaveEventItem(16)==0)then
				 tasks[1].show=1;
			end;
			SayTask(11123,tasks)
end;

function  renwu1()

				Talk(1,"no",11124)
				AddEventItem(16)
				SetTask(2,13)
				TaskNote(29,5)
				Msg2Player("Nh薾 頲 1 ch衝 canh t豱h ru.")
end;

function   no()
		CloseDialog()
end;
