-- Phong Than npc_fix 2026-09-28: Loi Chan Tu (lei zhenzi, map 1020); original script.pak \script\XiQi\LeiZhenZi.lua (pinyin of GBK PAK path, bound directly before this fix); changes: exit row in SayTask; renwu1 task 1 17->20 grants skill book (7,59,128) via QuestExchange; yes() phase guard (task 1 ==2, Dao Si, level>=35).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: À×Õð×Ó-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27

function main()
	tasks = 
	{
		{"ThÕ Së","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Wizard = GetTask(1);
	if(UTask_Wizard == 17)then
			tasks[1].show=1;
	end;
	if(GetPlayerType()==1)and(GetLevel()>=35)  and  (UTask_Wizard == 2)then
			tasks[1].show=1;
	end;
		SayTask(10418,tasks)
end;

function  renwu1()
	UTask_Wizard = GetTask(1);
	if(UTask_Wizard == 17)then
			-- npc_fix: skill book + task 1 17->20 in one transaction
			if (QuestExchange(1,17,20,{},{{7,59,128,1,0,0,1}})~=1) then
				Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
			Talk(3,"no",10419,10420,10421)
			Msg2Player("Hoµn thµnh nhiÖm vô chiªu hµng, nhËn ®­îc MËt tÞch Ban M«n Léng Phñ")
			TaskNote(28,10)
	end;
	if(GetPlayerType()==1)and(GetLevel()>=35)  and  (UTask_Wizard == 2)then
			MsgBox(10422,"yes","no")
	end;
end;

function yes()
		if (GetPlayerType()~=1) or (GetLevel()<35) or (GetTask(1)~=2) then	-- npc_fix: phase guard
			CloseDialog()
			return
		end;
		Talk(1,"no",10423)
		Msg2Player("NhËn lÖnh Kh­¬ng Tö Nha, khuyªn 3 t­íng lÜnh nhµ Th­¬ng ®Çu Chu.")
		SetTask(1,10)
		TaskNote(28,2)
end;

function no()	
		CloseDialog()
end;
