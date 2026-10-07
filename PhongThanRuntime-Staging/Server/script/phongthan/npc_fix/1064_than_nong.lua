-- Phong Than npc_fix 2026-09-28: Than Nong (shen nong, map 1064 Vien Co); original script.pak \script\YuanGu\ShenNong.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; yes_3 phase guard (task 3 ==50, Giap Si, level>=55); yes_4 task 3 52->60 grants gem (3,41,0,1,0,0) + treasure (0,4,10..13,1) via QuestExchange (event 4 kept, as in the original: Vo Vuong 62->63 consumes it).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÉñÅ©-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/7/29

function main()
	tasks = 
	{
		{"ThÇn Dô KÝnh","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		if(GetTask(905)~=2)and(GetTask(905)~=4)and(GetTask(905)~=7)and(GetTask(905)~=9)and(HaveIBBuff(217)~=0)then
				shengxian()
		else
			UTask_knight = GetTask(3);
			if  (GetPlayerType()==0)  and  (GetLevel()>=55)  and  (UTask_knight == 52) and  (HaveEventItem(4)>=1)then
					tasks[1].show=1;
			end;	
			if  (GetPlayerType()==0) and (GetLevel()>=55)  and  (UTask_knight == 50)then
					tasks[1].show=1;
			end;
			SayTask(10601,tasks)
		end
end;

function shengxian()
	SetTask(905,GetTask(905)+1)
	TaskNote(47,GetTask(905)-1)
	TopMessage("§­îc <color=green>ThÇn N«ng<color> chØ dÉn")
	Talk(2,"no",10601,10602)
end

function  renwu1()
		UTask_knight = GetTask(3);
		if  (GetPlayerType()==0)  and  (GetLevel()>=55)  and  (UTask_knight == 52) and  (HaveEventItem(4)>=1)then
				Talk(2,"yes_4",10602,10603)
		end;
		if  (GetPlayerType()==0) and (GetLevel()>=55)  and  (UTask_knight == 50)then
				Talk(2,"yes_1",10604,10605)
		end;
end;

function yes_1()	
		Talk(1,"yes_2",10606)
end;

function yes_2()
		MsgBox(10607,"yes_3","no")
end;

function yes_3()
		if (GetPlayerType()~=0) or (GetLevel()<55) or (GetTask(3)~=50) then	-- npc_fix: phase guard
			CloseDialog()
			return
		end;
		Talk(1,"no",10608)
		SetTask(3,51)
		Msg2Player("§Ó b¶o vÖ téc ThÇn N«ng ®ång ý khiªu chiÕn Tr¹nh Nanh thÇn thó ë Khæn Tiªn Cung.")
		TaskNote(27,20)
end;

function yes_4()
		-- npc_fix: gem + treasure and task 3 52->60 in one transaction (event 4 kept)
		local n=random(10,13)
		if (GetPlayerType()~=0) or (GetLevel()<55) or (HaveEventItem(4)<1) or (QuestExchange(3,52,60,{},{{3,41,0,1,0,0,1},{0,4,n,1,0,0,1}})~=1) then
			Msg2Player("Chua the nhan thuong: can Than Du Kinh va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10609)
		Msg2Player("Gióp Hiªn Viªn b¶o qu¶n ThÇn Dô KÝnh. NhËn phÇn th­ëng mét viªn b¶o th¹ch vµ mét ph¸p b¶o cÊp 50.")
		TaskNote(27,22)
end;

function  no()
		CloseDialog()
end;
