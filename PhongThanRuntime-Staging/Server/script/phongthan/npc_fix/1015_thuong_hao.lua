-- Phong Than npc_fix 2026-09-28: Thuong Hao (chang hao, map 1015); original script.pak \script\MengJin\ChangHao.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 2 22->30 grants event 17 + axe (0,0,34,4,1,0) in one QuestExchange; one step per click; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ³£ê»-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"Cæ §ao ","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
			UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
					tasks[1].show=1;
		end;

		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
					tasks[1].show=1;
		end;
		SayTask(10343,tasks)
end;

function  renwu1()
		UTask_Druid = GetTask(2);
		if(GetLevel()>=45)  and  (UTask_Druid==22) and(GetPlayerType()==2) then
						-- npc_fix: event 17 + axe and task 2 22->30 in one transaction
						if (QuestExchange(2,22,30,{},{{4,17,0,0,0,0,1},{0,0,34,4,1,0,1}})~=1) then
							Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
							CloseDialog()
							return
						end;
						Talk(1,"no",10344)
						TaskNote(29,9)
						Msg2Player("Cøu ®­îc dÞ nh©n, nhËn ®­îc Phôc ThÕ phñ!")
						return	-- npc_fix: one step per click
		end;
		if(GetPlayerType()==2)and(GetLevel()>=45)  and (UTask_Druid==20)then
						Talk(3,"no",10345,10346,10347)
						SetTask(2,21)
						TaskNote(29,7)
						Msg2Player("Cøu ®­îc DÞ nh©n.")
		end;
end;

function   no()
	CloseDialog()
end;
