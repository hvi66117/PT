-- Phong Than npc_fix 2026-09-28: Cong Cong (gong gong totem, map 1004); original \script\ChiYouMu\GongGongTuTeng.lua (pinyin of GBK PAK path); changes: exit row in SayTask; GetItemCount(28) -> HaveEventItemCount(28) (menu + renwu1); task 35 6->7 = QuestExchange 3 x event 28 -> 1 x event 27; dead 2005 register branch (task 330) made transactional; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ¹²¹¤Í¼ÌÚ-ÎäÆ÷ÏúÊÛÉÌ
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"ThÇn Khİ","renwu1";show=0},
		{"B¸o danh","renwu";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (HaveEventItemCount(28)>=3) then	-- npc_fix: was GetItemCount(28) (genre-only query)
				tasks[1].show=1;
	end;
	if (UTask_25==1) then
				tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then	
		 tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®ang chiªu mé anh tµi, chuÈn bŞ ph¹t Th­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10151,tasks)
	end;
end;

function   renwu1()
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (HaveEventItemCount(28)>=3) then
		-- npc_fix: 3 x event 28 -> 1 x event 27 + task 35 6->7 in one transaction
		if (QuestExchange(35,6,7,{{4,28,0,0,0,0,3}},{{4,27,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the doi: can 3 Manh Than Khi va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10152)
		Msg2Player("NhËn ®­îc ThÇn Khİ, ®em ®Õn ®­a cho Chóc Dung.")
		TaskNote(17,6)
	end;
	if (UTask_25==1) then
		Talk(1,"no",10153)
		Msg2Player("T×m Cao Minh hái tin tøc m¶nh ThÇn Khİ.")
		TaskNote(17,1)
		SetTask(35,2)
	end;
end;

function no()
		CloseDialog()
end;

function  renwu()
		if(GetTask(330)==0)then
			-- npc_fix: 3+3 potions + task 330 0->1 in one transaction (branch is time-gated to 2005, unreachable)
			if (QuestExchange(330,0,1,{},{{1,0,0,0,1,0,3},{1,3,0,0,1,0,3}})~=1) then
				Msg2Player("Chua the nhan thuong: hanh trang da day.")
				CloseDialog()
				return
			end;
				Talk(1,"no","Hy väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bŞ.")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh tßng qu©n råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bŞ.")
		end;
end;
