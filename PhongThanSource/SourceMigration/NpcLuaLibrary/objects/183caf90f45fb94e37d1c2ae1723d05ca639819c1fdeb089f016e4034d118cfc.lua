--description
--author: yichuan
--date:2004/7/7

function  main()
	tasks = 
	{
		{"Vi Lao","renwu1";show=0}
	}
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==0)and(GetLevel()>=57)then
			tasks[1].show=1;
	end;


			SayTask(10461,tasks)
end;

function   renwu1()
				Talk(1,"next",10462)
end;

function  next()
		Talk(3,"next1",10463,10464,10465)
end;

function  next1()
		Talk(1,"no",10466)
		Msg2Player("§Õn gÆp Ng­êi h¸i thuèc hái th¨m vÒ Huyªn th¶o.")
		TaskNote(21,0)
		SetTask(50,1)
end;

function  no()
		CloseDialog()
end;

