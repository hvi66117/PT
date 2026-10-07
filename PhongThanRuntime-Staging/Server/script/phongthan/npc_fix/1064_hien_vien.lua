-- Phong Than npc_fix 2026-09-28: Hien Vien (xuan yuan, map 1064 Vien Co); original script.pak \script\YuanGu\XuanYuan.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; yes_3 phase guard (task 1 ==50, Dao Si, level>=55); yes_4 task 1 52->60 grants gem (3,41,0,1,0,0) + treasure (0,4,10..13,1) via QuestExchange (event 4 kept, as in the original).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÐùÔ¯-ÒìÈËÖ÷ÏßÈÎÎñ
--author: yichuan
--date:2004/7/29

function main()
	tasks = 
	{
		{"ThÇn Dô KÝnh","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	if(GetTask(905)~=6)and(GetTask(905)~=7)and(GetTask(905)~=8)and(GetTask(905)~=9)and(HaveIBBuff(217)~=0)then
				shengxian()
	else
		if  (GetPlayerType()==1)  and(GetLevel()>=55)  and  (UTask_Wizard == 52) and  (HaveEventItem(4)>=1)then
				tasks[1].show=1;
		end;
		if  (GetPlayerType()==1)  and  (GetLevel()>=55)  and  (UTask_Wizard == 50)then
				tasks[1].show=1;
		end;
		SayTask(10611,tasks)
	end
end;

function shengxian()
	SetTask(905,GetTask(905)+5)
	TaskNote(47,GetTask(905)-1)
	TopMessage("§­îc <color=green>Hiªn Viªn<color> chØ dÉn")
	Talk(1,"no",10611)
end

function  renwu1()
	UTask_Wizard = GetTask(1);
	if  (GetPlayerType()==1)  and(GetLevel()>=55)  and  (UTask_Wizard == 52) and  (HaveEventItem(4)>=1)then
			Talk(2,"yes_4",10612,10613)
	end;
	if  (GetPlayerType()==1)  and  (GetLevel()>=55)  and  (UTask_Wizard == 50)then
			Talk(2,"yes_1",10614,10615)
	end;
end;

function yes_1()	
		Talk(1,"yes_2",10616)
end;

function yes_2()
		MsgBox(10617,"yes_3","no")
end;

function yes_3()
		if (GetPlayerType()~=1) or (GetLevel()<55) or (GetTask(1)~=50) then	-- npc_fix: phase guard
			CloseDialog()
			return
		end;
		Talk(1,"no",10618)
		SetTask(1,51)
		Msg2Player("§Õn Khæn Tiªn Cung t×m diÖt Tr¹nh Nanh thÇn thó.")
		TaskNote(28,24)
end;

function yes_4()
		-- npc_fix: gem + treasure and task 1 52->60 in one transaction (event 4 kept)
		local n=random(10,13)
		if (GetPlayerType()~=1) or (GetLevel()<55) or (HaveEventItem(4)<1) or (QuestExchange(1,52,60,{},{{3,41,0,1,0,0,1},{0,4,n,1,0,0,1}})~=1) then
			Msg2Player("Chua the nhan thuong: can Than Du Kinh va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10619)
		Msg2Player("Gióp Hiªn Viªn b¶o qu¶n ThÇn Dô KÝnh. NhËn phÇn th­ëng mét viªn b¶o th¹ch vµ mét ph¸p b¶o cÊp 50.")
		TaskNote(28,26)
end;

function  no()
		CloseDialog()
end;
