--description:?´óÁr
--author: yichuan
--date: 2004/7/19

function main(sel)
	tasks = 
	{
		{"Phu Thª","renwu1";show=0}
	}
	UTask_world_2=GetTask(92);
	if (UTask_world_2==5)and(GetMorphType()==249)then
			tasks[1].show=1;
	end;
	if(UTask_world_2==0)and(GetLevel()>=27)then
			tasks[1].show=1;
	end;

		SayTask(10436,tasks)
end;

function  renwu1()
	UTask_world_2=GetTask(92);
	if (UTask_world_2==5)then
				if(GetMorphType()==249)then
						Talk(1,"no",10437)
						AddWeightMax(20)
						AddOwnExp(5000)
						Msg2Player("Hoµn thµnh nhiÖm vô. NhËn ®­îc 5000 ®iÓm kinh nghiÖm vµ 20 ®iÓm søc lùc")
						TopMessage("NhËn ®­îc <color=green>5000<color> ®iÓm kinh nghiÖm vµ <color=green>20<color> ®iÓm søc lùc")
						TaskNote(26,5)
						SetTask(92,6)
				end;
	end;
	if(UTask_world_2==0)and(GetLevel()>=17)then
				Talk(3,"func_check",10438,10439,10440)		
	end;
end;

function func_check()
		Talk(2,"func_check1",10441,10442)
end;


function func_check1()
		MsgBox(10443,"yes_1","no")
end;

function  yes_1()
		Talk(1,"no",10444)
		Msg2Player("§Õn t×m D­¬ng TiÔn nghÜ c¸ch t×m Ngäc N÷ vµ Phi Thè")
		TaskNote(26,0)
		SetTask(92,1)
end;

function  no()
		CloseDialog()
end;
