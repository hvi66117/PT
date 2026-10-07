-- Phong Than npc_fix 2026-09-28: Dac Ky tuong lai (da ji, future, map 1063 Trieu Ca 10 nam sau); original script.pak \script\WeiLai\DaJi.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; renwu1 71->72 guarded on the player's own class task (level>=80).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

function main()
	tasks = 
	{
		{"Cæ Kim","renwu1";show=0},
		{"§Õn Diªu Tr×","renwu2";show=1},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	UTask_Knight = GetTask(3);
	UTask_Druid = GetTask(2);
	if  (GetLevel()>=80) then

			if(UTask_Wizard==71)or(UTask_Druid==71)or(UTask_Knight==71)then
							tasks[1].show=1
			end;
	end;

	SayTask(10375,tasks)
end;

function   renwu1()
					local pt_t=3	-- npc_fix: phase guard on the player's own class task (must be 71)
					if (GetPlayerType()==1) then pt_t=1 elseif (GetPlayerType()==2) then pt_t=2 end;
					if (GetLevel()<80) or (GetTask(pt_t)~=71) then
						CloseDialog()
						return
					end;
					Talk(1,"no",10376)
					Msg2Player("§Õn Ngäc H­ Cung 10 n¨m tr­íc ®Ó t×m Nguyªn Thñy Thiªn T«n")
					if  (GetPlayerType()==2)  then
							SetTask(2,72)
							TaskNote(29,27)
					end;
					if  (GetPlayerType()==1)  then
							SetTask(1,72)
							TaskNote(28,32)
					end;
					if  (GetPlayerType()==0)  then
							SetTask(3,72)
							TaskNote(27,28)
					end;
end;

function   no()
		CloseDialog()
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
