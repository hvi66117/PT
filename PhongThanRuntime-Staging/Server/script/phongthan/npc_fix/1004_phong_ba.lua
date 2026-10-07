-- Phong Than npc_fix 2026-09-28: Phong Ba (feng bo totem, map 1004); original \script\ChiYouMu\FengBoTuTeng.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 34 6->7 skill book (7,58,62,1,0,0) granted via QuestExchange, SetCamp(7)/TaskNote only after success; yes_1 guarded to phase 0; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ·ç²®Í¼ÌÚ-ò¿ÓÈÄ¹
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"Cøu TÕ","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		UTask_20 = GetTask(30);
		UTask_24 = GetTask(34);
		if (UTask_20==1)   or (UTask_20==5) or(UTask_20==9)or(UTask_20==13)then
					tasks[1].show=1;
		end;		
		if (UTask_24 == 6)  then
					tasks[2].show=1;
		end;				
		if (UTask_24 == 0) and (GetPlayerType()==2) and(GetLevel()>=12)then
					tasks[2].show=1;
		end;	
		if (UTask_24 == 7)and (GetCamp()==0)then
						SetCamp(7)
						Talk(1,"no","Ng­¬i ®· nhËn s¸ch kü n¨ng sèng, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
						Msg2Player("B¹n ®· nhËn s¸ch kü n¨ng, tõ giê ®· kh«ng cßn lµ T©n Thñ n÷a!")
		end;
		SayTask(10138,tasks)
end;

function  renwu1()
	UTask_20 = GetTask(30);
	if (UTask_20==1) then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,1)
			SetTask(30,UTask_20+2)
	end;
	if (UTask_20==5) then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,5)
			SetTask(30,UTask_20+2)
	end;
	if(UTask_20==9)then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,6)
			SetTask(30,UTask_20+2)
	end;
	if(UTask_20==13)then
			Talk(1,"no",10138)
			Msg2Player("NhËn ®­îc sù h­íng dÉn quý gi¸ tõ Phong B¸")
			TaskNote(13,7)
			SetTask(30,UTask_20+2)
	end;
end;

function  renwu2()
	UTask_24 = GetTask(34);
	if (UTask_24 == 6)  then
			-- npc_fix: skill book (7,58,62,1,0,0) + task 34 6->7 in one transaction
			if (QuestExchange(34,6,7,{},{{7,58,62,1,0,0,1}})~=1) then
				Msg2Player("Chua the nhan thuong: hanh trang da day.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10139)
				Msg2Player("nhËn ®­îc s¸ch kü n¨ng khai kho¸ng Bµn Cæ Khai Thiªn, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
				SetCamp(7)
			TaskNote(16,6)
	end;
	if (UTask_24 == 0) and (GetPlayerType()==2) and(GetLevel()>=12)then
			MsgBox(10140,"yes_1","no")

	end;
end;

function yes_1()
		if (GetTask(34)~=0) then	-- npc_fix: never reset an accepted quest
			CloseDialog()
			return
		end;
		Talk(1,"no",10141)
		SetTask(34,1)
		Msg2Player("Muèn häc b¶n lÜnh ®Æc biÖt nªn t×m H×nh Thiªn.")
		TaskNote(16,0)
end;

function no()
		CloseDialog()
end;
