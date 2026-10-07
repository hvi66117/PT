-- Phong Than npc_fix 2026-09-28: Nguyen Thuy Thien Ton (yuanshi tianzun, map 1062 Ngoc Hu 10 nam sau); original script.pak \script\WeiLai\YuanShiTianZun.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; renwu1 74->80 swaps event 10 for gem (3,41,0,0,1,0) + Khu Lai phu (6,1,34,1) via QuestExchange on the player's own class task (also fixes the original and/or precedence); yes() 72->73 guarded on the own class task.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÔªÊ¼Ìì×ð-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

function main()
	tasks = 
	{
		{"Cæ Kim","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if  (GetLevel()>=80) then
			if(UTask_Wizard==74)or(UTask_Druid==74)or(UTask_Knight==74)then
							if(HaveEventItem(10)>=1)then
									tasks[1].show=1
							end;
			end;

			if(UTask_Wizard==72)or(UTask_Druid==72)or(UTask_Knight==72)then
							tasks[1].show=1
			end;
	end;

	SayTask(10387,tasks)
end;

function   renwu1()
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if  (GetLevel()>=80) then
			if(UTask_Wizard==74)or(UTask_Druid==74)or(UTask_Knight==74)and (HaveEventItem(10)>=1)then
					-- npc_fix: event 10 -> gem + Khu Lai phu and class task 74->80 in one transaction
					local pt_t=3
					if (GetPlayerType()==1) then pt_t=1 elseif (GetPlayerType()==2) then pt_t=2 end;
					if (QuestExchange(pt_t,74,80,{{4,10,0,0,0,0,1}},{{3,41,0,0,1,0,1},{6,1,34,1,0,0,1}})~=1) then
						Msg2Player("Chua the hoan thanh: can Truc gian va cho trong hanh trang.")
						CloseDialog()
						return
					end;
					Talk(1,"no",10388)
					Msg2Player(" Nguyªn Thñy Thiªn T«n ®· gióp b¹n kh«i phôc Khø Lai phï. NhËn ®­îc viªn Lam b¶o th¹ch.")
					if  (GetPlayerType()==2)  then
							TaskNote(29,30)
					end;
					if  (GetPlayerType()==1)  then
							TaskNote(28,35)
					end;
					if  (GetPlayerType()==0)  then
							TaskNote(27,31)
					end;
					return	-- npc_fix: one step per click
			end;

			if(UTask_Wizard==72)or(UTask_Druid==72)or(UTask_Knight==72)then
					MsgBox(10389,"yes","no")
			end;
	end;
end;

function   yes()
			local pt_t=3	-- npc_fix: phase guard on the player's own class task (must be 72)
			if (GetPlayerType()==1) then pt_t=1 elseif (GetPlayerType()==2) then pt_t=2 end;
			if (GetLevel()<80) or (GetTask(pt_t)~=72) then
				CloseDialog()
				return
			end;
			Talk(1,"no",10390)
			if  (GetPlayerType()==2)  then
					Msg2Player("T×m Tróc gi¶n")
					SetTask(2,73)
					TaskNote(29,28)
			elseif  (GetPlayerType()==1)  then
					Msg2Player("T×m Tróc gi¶n")
					SetTask(1,73)
					TaskNote(28,33)
			elseif  (GetPlayerType()==0)  then
					Msg2Player("T×m Tróc gi¶n")
					SetTask(3,73)
					TaskNote(27,29)
			end;
end;

function   no()
		CloseDialog()
end;
