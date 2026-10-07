-- Phong Than npc_fix 2026-09-28: Trieu Loi (Chao Lei); original script.pak \script\[GBK chongchengdaying]\[GBK chaolei].lua; changes: exit row on SayTask, no authored wrapper menu, renwu (2005 registration event, still time-gated/hidden) grants 3x(1,0,0,0,1,0)+3x(1,3,0,0,1,0) and task 330 0->1 in one QuestExchange.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ³ç¾ü¾üÒ½
--author:  yichuan
--date: 2004/6/27

function main(sel)
	tasks =
	{
	 {"Hép gÊm","renwu1";show=0},
	 {"B¸o danh","renwu";show=0},
	 {"KÕt thóc ®èi tho¹i","no";show=1}
	}
 	UTask_10 = GetTask(20);
	if (UTask_10 == 10) or  (UTask_10==11)or(UTask_10==14) or(UTask_10==15)then	
		 tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then		
		 tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®ang chiªu mé anh tµi, chuÈn bÞ ph¹t Th­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10229,tasks)
	end;
end;

function   renwu1()
	UTask_10 = GetTask(20);
	if(UTask_10 == 10)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,3)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==11)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,5)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==14)then
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,6)
				SetTask(20,UTask_10+2)
	end;
	if(UTask_10==15)then				
				Talk(1,"no",10230)
				Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
				TaskNote(7,8)
				SetTask(20,UTask_10+2)
	end;
end;

function no()
		CloseDialog()
end;

function  renwu()
		if(GetTask(330)==0)then
			if(QuestExchange(330,0,1,{},{{1,0,0,0,1,0,3},{1,3,0,0,1,0,3}})~=1)then
				Msg2Player("Hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
				Talk(1,"no","Hy väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ. ")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")
		end;
end;
