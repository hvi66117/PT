--description: ÔÆÖÐ×Ó
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"Th¨m Dß","renwu1";show=0}
	}
	UTask_05 = GetTask(15);
	if (GetPlayerType() == 1) and  (UTask_05 == 6)  then
			tasks[1].show=1;
	end;
	if (GetPlayerType() == 1) and  (UTask_05 == 2) then
			tasks[1].show=1;
	end;
	if (UTask_05 == 0)   and (GetPlayerType() == 1) and(GetLevel()>=7)then
			tasks[1].show=1;
	end;


	SayTask(10519,tasks)
end;


function  renwu1()
	UTask_05 = GetTask(15);
	if (GetPlayerType() == 1) and  (UTask_05 == 6)  then
		Talk(1,"no",10520)
		local n=random(0,5);				
		AddNormalItem(0,4,n,1,0,0)
		AddCredit(10)
		SetTask(15,7)
		Msg2Player("Hoµn thµnh kh¶o nghiÖm cña V©n Trung Tö, nhËn ®­îc ph¸p b¶o cÊp 10.")
		TaskNote(5,4)
	end;
	if (GetPlayerType() == 1) and  (UTask_05 == 2) then
		Talk(1,"no",10521)
		SetTask(15,5)
		Msg2Player("TiÕp nhËn thö th¸ch cña V©n Trung Tö, ®i giÕt TuyÕt Nguyªn Cù Thó ë Thñ D­¬ng S¬n.")
		TaskNote(5,2)
	end;
	if (UTask_05 == 0)   and (GetPlayerType() == 1) and(GetLevel()>=7)then
		MsgBox(10522,"yes_1","no")
	end;
end;

function yes_1()
		Talk(1,"no",10523)
		SetTask(15,1)
		Msg2Player("TiÕp nhËn thö th¸ch cña V©n Trung Tö t×m Linh B¶o ®¹i ph¸p s­ tr¶ lêi vÊn ®¸p.")
		TaskNote(5,0)
end;

function  no()
		CloseDialog()
end;
