--description: ³ç¾üÍ­½³
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0},
		{"Kiªm ¸i","renwu2";show=0},
		{"Dòng §ao","renwu3";show=0}
	}
	UTask_11 = GetTask(21);
	UTask_14= GetTask(24);
	UTask_15=GetTask(25);
	if (UTask_11 == 7)  then		
			tasks[1].show=1;
	end;
	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
			tasks[1].show=1;
	end;
	if(UTask_11 == 1)  then
			tasks[1].show=1;
	end;

	if(UTask_14 ==1)then		
			tasks[2].show=1;
	end;

	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==2)then
			tasks[3].show=1;
	end;

	SayTask(10276,tasks)
end;

function   renwu1()
	UTask_11 = GetTask(21);
	if (UTask_11 == 7)  then		
				Talk(1,"no",10277)
				Msg2Player("VÒ gÆp Lç Hïng phôc mÖnh.")
				TaskNote(8,7)
				SetTask(21,8)
	end;
	if(UTask_11 == 3) and(HaveNormalItem(3,10,0,0)>=10)then
				Talk(1,"no",10278)
				for i=1,10 do 
						DelNormalItem(3,10,0,0)
				end;
				Msg2Player("T×m Sïng HÇu Hæ ®æi nguyªn liÖu.")
				TaskNote(8,3)
				SetTask(21,4)
	end;
	if(UTask_11 == 1)  then
				Talk(1,"no",10279)
				Msg2Player("§ t×m Sïng øng B­u.")
				TaskNote(8,1)
				SetTask(21,2)	
	end;
end;

function   renwu2()
				Talk(1,"no",10280)
				Msg2Player("GiÕt H¶i cÈu tinh sÏ nhËn ®­îc cuèc.")
				TaskNote(10,1)
				SetTask(24,2)
end;

function   renwu3()

				Talk(1,"no",10281)
				DelEventItem(21)
				DelEventItem(22)
				DelEventItem(23)
				AddEventItem(24)
				Msg2Player("Dòng §ao t¸i xuÊt giang hå!")
				TaskNote(11,9)
				SetTask(25,3)
end;

function no()
		CloseDialog()
end;
