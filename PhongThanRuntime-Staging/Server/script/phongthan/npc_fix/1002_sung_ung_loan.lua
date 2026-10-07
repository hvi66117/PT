-- Phong Than npc_fix 2026-09-28: Sung Ung Loan (Chong Yingluan); original script.pak \script\[GBK chongchengdaying]\[GBK chongyingluan].lua; changes: exit row on SayTask, no authored wrapper menu, renwu2 task 24 phase 3->4 takes EventItem 25 and gives skill book (7,58,62,1,0,0) via one QuestExchange, SetCamp(7) only after success.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ³çÓ¦ð½
--author: yichuan
--date: 2004/6/28

function main(sel)
	tasks =
	{
		{"Hép gÊm","renwu1";show=0},
		{"Kiªm ¸i","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_10 = GetTask(20);
	UTask_14= GetTask(24);
	if (UTask_10 == 10) or(UTask_10==12)or(UTask_10==14)or(UTask_10==16)then				
			tasks[1].show=1;
	end;
	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
			tasks[2].show=1;
	end;	
	if(UTask_14 ==0)  and (GetPlayerType()==0)and(GetLevel()>=12) then	
			tasks[2].show=1;
	end;	
	if (UTask_14 == 4)and (GetCamp()==0)then
						SetCamp(7)
						Talk(1,"no",11167)
						Msg2Player("B¹n ®· nhËn s¸ch kü n¨ng, tõ giê ®· kh«ng cßn lµ T©n Thñ n÷a!")
		end;

	SayTask(10251,tasks)
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if (UTask_10 == 10)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,2)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==12)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,5)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==14)then
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,7)
					SetTask(20,UTask_10+1)
	end;
	if(UTask_10==16)then				
					Talk(1,"no",10252)
					Msg2Player("Th«ng b¸o cho Sïng øng Loan.")
					TaskNote(7,8)
					SetTask(20,UTask_10+1)
	end;
end;

function    renwu2()
	UTask_14= GetTask(24);

	if(UTask_14 ==3)and  (HaveEventItem(25)>=1)then
					if(QuestExchange(24,3,4,{{4,25,0,0,0,0,1}},{{7,58,62,1,0,0,1}})~=1)then      --Éú»î¼¼ÄÜÊé
							Msg2Player("Can vat pham nhiem vu trong hanh trang va cho trong.")
							CloseDialog()
							return
					end;
					Talk(1,"no",10253)
				Msg2Player("nhËn ®­îc s¸ch kü n¨ng khai kho¸ng Bµn Cæ Khai Thiªn, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
				SetCamp(7)
					TaskNote(10,3)
	end;
	if(UTask_14 ==0)  and (GetPlayerType()==0)and(GetLevel()>=12) then		
					Talk(3,"no",10254,10255,10256)
					Msg2Player("§Õn gÆp ¢u Thiªn Hãa m­în cuèc chim häc kü n¨ng khai kho¸ng.")
					TaskNote(10,0)
					SetTask(24,1)		
	end;
end;

function no()
		CloseDialog()
end;
