--description: ËÕ»¤
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"Hép gÊm","renwu1";show=0}
	}
			UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			tasks[1].show=1;
		end;
		if(UTask_10==0) then
			tasks[1].show=1;
		end;
		SayTask(10271,tasks)
end;

function   renwu1()	
		UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			Talk(1,"no",10272)
			DelEventItem(26)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			Msg2Player("Gióp T« Hé lÊy hép gÊm, nhËn phÇn th­ëng 3 TiÓu Hång ®¬n vµ 3 TiÓu Hoµn ®¬n.")
			TaskNote(7,10)
			SetTask(20,19)
		end;
		if(UTask_10==0) then
			MsgBox(10273,"yes_1","no")
		end;	
end;

function yes_1()
		Talk(1,"no",10274)
		Msg2Player("§Õn Thñ khè lÊy hép gÊm vÒ cho T« Hé.")
		TaskNote(7,0)
		SetTask(20,1)
end;

function no()
		CloseDialog()
end;
