-- Phong Than npc_fix 2026-09-28: Nam Cuc Tien Ong (1003); original script.pak \script\YuXuGong\NanJiXianWeng.lua (GBK names); changes:
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--   SayTask exit row "Ket thuc doi thoai" -> no(); task 11 phase 4->5 consumes
--   EventItem 20 via QuestExchange(11,4,5), Earn(600)+AddOwnExp(500) only after
--   success; task 11 phase 2->3 consumes 10x(3,13,0,0) via QuestExchange(11,2,3)
--   (was HaveNormalItem any-room + DelNormalItem bag-only loop); yes_2
--   re-checks task 11 phase 0. Task 10 (Bach Ly) unchanged.
--description: ÄÏ¼«ÏÉÎÌ
--author: yichuan
--date: 2004/4/9

function main(sel)
	tasks =
	{
		{"B¸ch Lý","renwu1";show=0},
		{"Ngò ThÊt","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		UTask_00=GetTask(10);
		if (UTask_00 == 1) or (UTask_00 == 3)or (UTask_00 == 9) or (UTask_00 == 11)then	
			tasks[1].show=1;
		end;
		UTask_01=GetTask(11);
		if(UTask_01==4)and(HaveEventItem(20)>=1)then
					tasks[2].show=1;
		end;
		if(UTask_01==2)and(HaveNormalItem(3,13,0,0)>=10)then
					tasks[2].show=1;
		end;
		if(UTask_01==0)and(GetLevel()>=3)then
					tasks[2].show=1;
		end;

	SayTask(10532,tasks)
end;

function  renwu1()
		UTask_00=GetTask(10);
		if (UTask_00 == 1)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,2)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 3)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,4)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 9)then
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,5)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
		if(UTask_00 == 11)then				
			Talk(1,"no",10533)
			SetTask(10,UTask_00+4)
			TaskNote(1,7)
			Msg2Player("Nam Cùc Tiªn ¤ng ®· chän ra ®Ö tö m×nh yªu thÝch.")
		end;
end;

function  renwu2()
	UTask_01=GetTask(11);
	if(UTask_01==4)and(HaveEventItem(20)>=1)then
			if (QuestExchange(11,4,5,{{4,20,0,0,0,0,1}},{})~=1) then
				Msg2Player("Chua the giao Hoa Thach: can Hoa Thach trong hanh trang.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10534)
			Earn(600)
			AddOwnExp(500)
			TaskNote(2,4)
			Msg2Player("LÊy ®­îc lo¹i löa thÝch hîp, nhËn phÇn th­ëng 600 l­îng + 500 ®iÓm kinh nghiÖm cña Nam Cùc Tiªn ¤ng.")
	end;
	if(UTask_01==2)and(HaveNormalItem(3,13,0,0)>=10)then
			if (QuestExchange(11,2,3,{{3,13,0,0,0,0,10}},{})~=1) then
				Msg2Player("Chua the giao Bang co: can 10 Bang co trong hanh trang.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10535)
			TaskNote(2,2)
			Msg2Player("§Õn gÆp Nhiªn §¨ng ®¹o nhËn löa ®em vÒ cho Nam Cùc Tiªn ¤ng.")
	end;
	if(UTask_01==0)and(GetLevel()>=3)then
			MsgBox(10536,"yes_2","no")
	end;

end;

function yes_2()
		if (GetTask(11)~=0) then
			CloseDialog()
			return
		end;
		Talk(1,"no",10537)
		SetTask(11,1)
		TaskNote(2,0)
		Msg2Player("§Õn gÆp Hoµng Long ch©n nh©n lÊy 10 B¨ng c¬ cho Nam Cùc Tiªn ¤ng.")
end;

function   no()
		CloseDialog()
end;
