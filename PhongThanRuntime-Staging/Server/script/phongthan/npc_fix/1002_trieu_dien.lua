-- Phong Than npc_fix 2026-09-28: Trieu Dien (Chao Tian); original script.pak \script\[GBK chongchengdaying]\[GBK chaotian].lua; changes: exit row on SayTask, no authored wrapper menu, renwu2 task 25 phase 3->4 takes EventItem 24 and gives equip (0,4,n,1,0,0) n=0..5 via one QuestExchange, AddCredit(10) only after success.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÍÀÃÔ
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks =
	{
		{"HÈp g m","renwu1";show=0},
		{"DÚng ßao","renwu2";show=0},
		{"K’t thÛc ÆËi thoπi","no";show=1}
	}
	UTask_10 = GetTask(20);
	UTask_15=GetTask(25);

	if (UTask_10 == 10) or(UTask_10==11)or (UTask_10==12)or(UTask_10==13) then	
				tasks[1].show=1;
	end;

	if(HaveEventItem(24)>=1)and(UTask_15==3)then
				tasks[2].show=1;
	end;
	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==1)then
				tasks[2].show=1;
	end;
	if(UTask_15 ==0)and  (GetPlayerType()==0)and(GetLevel()>=7)then
				tasks[2].show=1;
	end;
	SayTask(10231,tasks)
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if (UTask_10 == 10)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,4)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==11)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,7)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==12)then
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,6)
			SetTask(20,UTask_10+4)
	end;
	if(UTask_10==13) then				
			Talk(1,"no",10232)
			Msg2Player("ß∑ th´ng b∏o cho Tri“u ßi“n.")
			TaskNote(7,8)
			SetTask(20,UTask_10+4)
	end;
end;

function    renwu2()
	UTask_15=GetTask(25);
	if(HaveEventItem(24)>=1)and(UTask_15==3)then
			local n=random(0,5);
			if(QuestExchange(25,3,4,{{4,24,0,0,0,0,1}},{{0,4,n,1,0,0,1}})~=1)then
					Msg2Player("Can Dung Dao trong hanh trang va cho trong.")
					CloseDialog()
					return
			end;
			Talk(1,"no",10233)
			AddCredit(10)
			Msg2Player("NhÀn Æ≠Óc ph∏p b∂o c p 10")
			TaskNote(11,10)
	end;
	if(HaveEventItem(21)>=1)and(HaveEventItem(22)>=1)and(HaveEventItem(23)>=1)and(UTask_15==1)then
			Talk(1,"no",10234)
			Msg2Player("NhÍ ¢u Thi™n H„a giÛp tu s˜a b∂o Æao.")
			TaskNote(11,8)
			SetTask(25,2)
	end;
	if(UTask_15 ==0)and  (GetPlayerType()==0)and(GetLevel()>=7)then
			MsgBox(10235,"yes_2","no")
	end;
end;

function yes_2()
		Talk(1,"no",10236)
		Msg2Player("ßi Y’n S¨n gi’t H∂i c»u v≠¨ng, l y m∂nh b∂o Æao.")
		TaskNote(11,0)
		SetTask(25,1)
end;

function no()
		CloseDialog()
end;
