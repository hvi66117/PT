-- Phong Than npc_fix 2026-09-28: Xi Vuu (chi you, map 1064 Vien Co); original script.pak \script\YuanGu\ChiYou.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; yes_3 phase guard (task 2 ==50, Di Nhan, level>=70); yes_4 task 2 52->60 grants the level-7 class weapon via QuestExchange (event 4 kept, as in the original).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ò¿ÓÈ-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/7/29

function main()
	tasks = 
	{
		{"ThÇn Dô KÝnh","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		UTask_Druid = GetTask(2);
		if(GetTask(905)~=3)and(GetTask(905)~=4)and(GetTask(905)~=8)and(GetTask(905)~=9)and(HaveIBBuff(217)~=0)then
				shengxian()
		else
			if  (GetPlayerType()==2)  and(GetLevel()>=70)  and  (UTask_Druid == 52) and  (HaveEventItem(4)>=1)then
					tasks[1].show=1;
			end;
			if  (GetPlayerType()==2)  and  (GetLevel()>=70)  and  (UTask_Druid == 50)then
					tasks[1].show=1;
			end;
			SayTask(10584,tasks)
		end
end;

function shengxian()
	SetTask(905,GetTask(905)+2)
	TaskNote(47,GetTask(905)-1)
	TopMessage("§­îc <color=green>Xi V­u<color> chØ dÉn")
	Talk(2,"no",10584,10587)
end

function  renwu1()
	UTask_Druid = GetTask(2);
	if  (GetPlayerType()==2)  and(GetLevel()>=70)  and  (UTask_Druid == 52) and  (HaveEventItem(4)>=1)then
			Talk(2,"yes_4",10585,10586)
	end;
	if  (GetPlayerType()==2)  and  (GetLevel()>=70)  and  (UTask_Druid == 50)then
			Talk(2,"yes_1",10587,10588)
	end;
end;

function yes_1()	
		Talk(1,"yes_2",10589)
end;

function yes_2()
		MsgBox(10590,"yes_3","no")
end;

function yes_3()
		if (GetPlayerType()~=2) or (GetLevel()<70) or (GetTask(2)~=50) then	-- npc_fix: phase guard
			CloseDialog()
			return
		end;
		Talk(1,"no",10591)
		SetTask(2,51)
		TaskNote(29,19)
		Msg2Player("§Ó b¶o vÖ téc Xi V­u ®ång ý khiªu chiÕn Tr¹nh Nanh thÇn thó ë Khæn Tiªn Cung.")
end;

function yes_4()
		-- npc_fix: class weapon + task 2 52->60 in one transaction (event 4 kept)
		local i=random(1,2)
		local w={0,0,34,7,1,0,1}
		if(GetPlayerType()==0)then
			w={0,0,30+i,7,1,0,1}
		elseif (GetPlayerType()==1)then
			w={0,0,33,7,1,0,1}
		end
		if (GetLevel()<70) or (HaveEventItem(4)<1) or (QuestExchange(2,52,60,{},{w})~=1) then
			Msg2Player("Chua the nhan thuong: can Than Du Kinh va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10592)
		if(GetPlayerType()==0)then
			-- npc_fix: granted by QuestExchange above -- AddNormalItem(0,0,30+i,7,1,0)
			if (i==1)then
				Msg2Player("NhËn ®­îc §¶ ThÇn Tiªn.")
			else
				Msg2Player("NhËn ®­îc §iÓm T­íng KÝch.")
		        end
		elseif (GetPlayerType()==1)then
			-- npc_fix: granted by QuestExchange above -- AddNormalItem(0,0,33,7,1,0)
			Msg2Player("NhËn ®­îc Cù KhuyÕt kiÕm.")
		else
			-- npc_fix: granted by QuestExchange above -- AddNormalItem(0,0,34,7,1,0)
			Msg2Player("NhËn ®­îc Tô Tiªn phñ.")
		end
		TaskNote(29,21)
end;

function  no()
		CloseDialog()
end;
