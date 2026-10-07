-- Phong Than npc_fix 2026-09-28: Dac Ky (da ji, map 1021); original script.pak \script\ChaoGe\DaJi.lua (pinyin of GBK PAK path); changes: exit row in SayTask; renwu1 40->41 level>=65 re-check; func_leave2 60->61 swaps the class item (event 2 / 13 / 19) for Phong Than bang (event 9) via QuestExchange on the player's own task (1 / 3 / 2); renwu2 re-reads the task values; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/9

function  main()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);

	tasks = 
	{
	 {"B×nh An","renwu1";show=0},
	 {"Tam s¸ch","renwu2";show=0},
	 {"Nghe","listen";show=1},
	 {"§Õn Diªu Tr×","go";show=0},
	 {"KÕt thóc ®èi tho¹i","no";show=1}
	}

	if (UTask_Knight ==40)  or  (UTask_Druid ==40) or  (UTask_Wizard ==40) then
			 if(GetLevel()>=65)then
				tasks[1].show=1;
			 end;
	end;
	if (UTask_Knight >40)  or  (UTask_Druid >40) or  (UTask_Wizard >40) then
			 tasks[4].show=1;
	end;
	if(UTask_Knight ==60)or (UTask_Druid ==60) or  (UTask_Wizard ==60)then
			 if(GetLevel()>=75)then
					tasks[2].show=1;			
			 end;
	end;
	SayTask(10013,tasks)
end;

function  renwu1()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
				if (GetLevel()<65) then	-- npc_fix: menu condition re-checked
					CloseDialog()
					return
				end;
				Talk(4,"func_leave1",10014,10015,10016,10017)
				if(UTask_Wizard ==40)then
					SetTask(1,41)
					TaskNote(28,20)
				end;
				if(UTask_Knight ==40)then
					SetTask(3,41)
					TaskNote(27,16)
				end;
				if(UTask_Druid ==40)then
					SetTask(2,41)
					TaskNote(29,15)
				end;
end;

function   renwu2()
	UTask_Wizard = GetTask(1);	-- npc_fix: re-read (original relied on the globals from main)
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if(GetPlayerType()==0)and (UTask_Knight ==60) and (GetLevel()>=75)then
		if(HaveEventItem(13)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i t×m gióp ta t×m r©u cña ThÇn Long.")
		end;
	elseif(GetPlayerType()==1)and (UTask_Wizard ==60)and (GetLevel()>=75)then
		if(HaveEventItem(2)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i gióp ta t×m ThÇn Méc.")
		end;
	elseif(GetPlayerType()==2)and (UTask_Druid ==60)and (GetLevel()>=75)then
		if (HaveEventItem(19)>=1)then
			Talk(1,"func_leave2",10018)
		else
			Talk(1,"no","PhiÒn ng­¬i t×m gióp ta Ma HuyÕt")
		end;
	end;
end;
		

function  listen()
		Talk(1,"func_leave3",10019)
end;

function  go()
		if ( GetMorphType()==364)or(IsPlayerInsideWeapon(PlayerIndex)>0)then          --Éæ¼°?Îñ£¬ÓÐµÄ±äÉí×´Ì¬Ö»ÄÜ¿¿?Îñ½â³ý£¬¹ý³ÌÖÐ²»¿ÉÊ¹ÓÃ´«ËÍ
				Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
		else
				local i=random(1,3)
				if ( i==1)then
						NewWorld(52,1541,3190)
				end;
				if(i==2)then
						NewWorld(52,1556,3202)
				end;
				if(i==3)then
						NewWorld(52,1540,3205)
				end;
				SetFightState(0)
		end;
		CloseDialog()
end;

function  func_leave1()
		Talk(1,"main",10020)
end;

function  func_leave2()
		UTask_Wizard = GetTask(1);
		UTask_Knight = GetTask(3);
		UTask_Druid = GetTask(2);
		-- npc_fix: class item -> event 9 and task 60->61 in one transaction
		if(UTask_Wizard ==60)and(HaveEventItem(2)>=1)and(GetPlayerType()==1)and (GetLevel()>=75)then
			if (QuestExchange(1,60,61,{{4,2,0,0,0,0,1}},{{4,9,0,0,0,0,1}})~=1) then
				Msg2Player("Chua the nhan Phong Than bang: hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
			Talk(2,"no",10021,10022)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao ThÇn Méc cho §¾c Kû.")
			TaskNote(28,27)
		elseif(UTask_Knight ==60)and(HaveEventItem(13)>=1)and (GetPlayerType()==0) and (GetLevel()>=75)then
			if (QuestExchange(3,60,61,{{4,13,0,0,0,0,1}},{{4,9,0,0,0,0,1}})~=1) then
				Msg2Player("Chua the nhan Phong Than bang: hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
			Talk(2,"no",10021,10022)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao r©u ThÇn Long cho §¾c Kû.")
			TaskNote(27,23)
		elseif(UTask_Druid ==60)and(HaveEventItem(19)>=1)and(GetPlayerType()==2)and (GetLevel()>=75)then
			if (QuestExchange(2,60,61,{{4,19,0,0,0,0,1}},{{4,9,0,0,0,0,1}})~=1) then
				Msg2Player("Chua the nhan Phong Than bang: hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
			Talk(2,"no",10021,10022)
			TaskNote(29,22)
			Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao Ma HuyÕt cho §¾c Kû.")
		end;			
end;

function  func_leave3()
		Talk(1,"func_leave4",10023)
end;

function  func_leave4()
		Talk(2,"func_leave5",10024,10025)
end;

function  func_leave5()
		Talk(1,"func_leave6",10026)
end;

function  func_leave6()
		Talk(1,"func_leave7",10027)
end;

function  func_leave7()
		Talk(1,"no",10028)

end;

function  no()
		CloseDialog()
end;
