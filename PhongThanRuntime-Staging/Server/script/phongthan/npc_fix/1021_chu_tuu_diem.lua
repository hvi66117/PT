-- Phong Than npc_fix 2026-09-28: Chu Tuu Diem (jiudian laoban, map 1021); original script.pak \script\ChaoGe\JiuDianLaoBan.lua (pinyin of GBK PAK path); changes: exit row in SayTask; renwu1 task 2 12->13 grants event 16 via QuestExchange (level>=35 re-checked); wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: 酒店老晃-异?主线?务
--author: yichuan
--date:2004/5/13

function  main()
			tasks = 
			{
				 {"B蕋 T髖 ","renwu1";show=0},
				 {"K誸 th骳 i tho筰","no";show=1}
			}
			UTask_Druid = GetTask(2);
			if(GetLevel()>=35)  and  (UTask_Druid==12)  and  (HaveEventItem(16)==0)then
				 tasks[1].show=1;
			end;
			SayTask(11123,tasks)
end;

function  renwu1()
				if (GetLevel()<35) then	-- npc_fix: menu condition re-checked
					CloseDialog()
					return
				end;
				-- npc_fix: event 16 + task 2 12->13 in one transaction
				if (QuestExchange(2,12,13,{},{{4,16,0,0,0,0,1}})~=1) then
					Msg2Player("Chua the nhan: hanh trang khong du cho trong.")
					CloseDialog()
					return
				end;
				Talk(1,"no",11124)
				TaskNote(29,5)
				Msg2Player("Nh薾 頲 1 ch衝 canh t豱h ru.")
end;

function   no()
		CloseDialog()
end;
