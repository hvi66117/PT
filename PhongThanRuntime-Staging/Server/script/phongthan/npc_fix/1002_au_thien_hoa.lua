-- Phong Than npc_fix 2026-09-28: Au Thien Hoa (Wu Wenhua); original script.pak \script\[GBK chongchengdaying]\[GBK wuwenhua].lua; changes: exit row on SayTask, no authored wrapper menu, renwu1 task 21 phase 3->4 consumes 10x(3,10,0,0) via QuestExchange, renwu3 task 25 phase 2->3 takes EventItems 21+22+23 and gives EventItem 24 via one QuestExchange.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ³ç¾üÍ­½³
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks =
	{
		{"T©n Thøc","renwu1";show=0},
		{"Kiªm ¸i","renwu2";show=0},
		{"Dòng §ao","renwu3";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
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
				if(QuestExchange(21,3,4,{{3,10,0,0,0,0,10}},{})~=1)then
						Msg2Player("Can du 10 Doan Kiem trong hanh trang.")
						CloseDialog()
						return
				end;
				Talk(1,"no",10278)
				Msg2Player("T×m Sïng HÇu Hæ ®æi nguyªn liÖu.")
				TaskNote(8,3)
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
				if(QuestExchange(25,2,3,{{4,21,0,0,0,0,1},{4,22,0,0,0,0,1},{4,23,0,0,0,0,1}},{{4,24,0,0,0,0,1}})~=1)then
						Msg2Player("Can du 3 manh bao dao trong hanh trang va cho trong.")
						CloseDialog()
						return
				end;
				Talk(1,"no",10281)
				Msg2Player("Dòng §ao t¸i xuÊt giang hå!")
				TaskNote(11,9)
end;

function no()
		CloseDialog()
end;
