-- Phong Than npc_fix 2026-09-28: Dac Ky luc nho (young da ji, map 1061 Ngoc Hu 10 nam truoc); original script.pak \script\WeiLai\NianShaoDaJi.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; love() 80->81 consumes event 9 via QuestExchange on the player's own class task (level>=85), task values re-read instead of relying on the globals from main.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: æ§¼º-Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/8

function main()
	tasks = 
	{
		{"Thiªn Duyªn","renwu1";show=0},
		{"§Õn Diªu Tr×","renwu2";show=1},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if  (GetLevel()>=85) and (HaveEventItem(9)==1)then
			if(UTask_Wizard==80)or(UTask_Druid==80)or(UTask_Knight==80)then
						tasks[1].show=1
			end;
	end;

	SayTask(10377,tasks)
end;

function   renwu1()

			Talk(2,"love",10378,10379)

end;

function  renwu2()
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
				CloseDialog()
end;

function   no()
		CloseDialog()
end;

function   love()
	UTask_Wizard = GetTask(1);	-- npc_fix: re-read (original relied on the globals from main)
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if  (GetLevel()>=85) and (HaveEventItem(9)==1)then
			if(UTask_Wizard==80)or(UTask_Druid==80)or(UTask_Knight==80)then
					-- npc_fix: event 9 consumed + class task 80->81 in one transaction
					local pt_t=3
					if (GetPlayerType()==1) then pt_t=1 elseif (GetPlayerType()==2) then pt_t=2 end;
					if (QuestExchange(pt_t,80,81,{{4,9,0,0,0,0,1}},{})~=1) then
						Msg2Player("Chua the hoan thanh: can Phong Than bang trong hanh trang.")
						CloseDialog()
						return
					end;
					Talk(1,"no",10380)
					if  (GetPlayerType()==2)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							TaskNote(29,31)
					elseif  (GetPlayerType()==1)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							TaskNote(28,36)
					elseif  (GetPlayerType()==0)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							TaskNote(27,32)
					end;
			end;
	end;
end;
