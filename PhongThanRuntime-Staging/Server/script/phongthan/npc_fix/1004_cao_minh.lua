-- Phong Than npc_fix 2026-09-28: Cao Minh (gao ming, map 1004); original \script\ChiYouMu\GaoMing.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 31 2->3 grants event 29 via QuestExchange (no advance without the letter); phase guards on renwu1 (task 35 ==2) and renwu3 (task 51 ==2); wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ¸ßÃ÷-Ç§ÀïÑÛ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"ThÇn KhÝ","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"Phi Tiªn","renwu3";show=0},
		{"Chuy\211n sinh","PTLW_CS";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_25 = GetTask(35);
	UTask_21 = GetTask(31);
	UTask_xq_1 = GetTask(51);
	if (UTask_25==2) then
			tasks[1].show=1;
	end;
	if (UTask_21==4) then
			tasks[2].show=1;
	end;
	if (UTask_21==2) then
			tasks[2].show=1;
	end;
	if(UTask_xq_1==2)then
			tasks[3].show=1;
	end;
	if (GetLevel() >= 100) or (GetTranslife and GetTranslife() > 0) then tasks[4].show=1 end -- luawave
	SayTask(10146,tasks)
end;

function  renwu1()
		if (GetTask(35)~=2) then	-- npc_fix: phase guard (original advanced unconditionally)
			CloseDialog()
			return
		end;
		Talk(1,"no",10147)
		Msg2Player("§Õn Miªu C­¬ng diÖt trõ Th¶o Tiªn bµ bµ, ®o¹t l¹i m¶nh ThÇn KhÝ. ")
		TaskNote(17,2)
		SetTask(35,3)
end;

function   renwu2()
	UTask_21 = GetTask(31);
	if (UTask_21==4) then
		Talk(1,"no",10148)
		Msg2Player("BiÕt ®­îc nguyªn liÖu cÇn t×m lµ MÆt Quû. T×m 10 MÆt Quû sau ®ã ®Õn HËu Thæ phôc mÖnh.")
		TaskNote(14,4)
		SetTask(31,5)
	end;
	if (UTask_21==2) then
		-- npc_fix: event 29 (thu cho Hinh Thien) + task 31 2->3 in one transaction
		if (QuestExchange(31,2,3,{},{{4,29,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the nhan thu: hanh trang da day.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10149)
		Msg2Player("Tr­íc tiªn gióp Cao Minh chuyÓn th­ cho H×nh Thiªn.")
		TaskNote(14,2)
	end;
end;

function   renwu3()
		if (GetTask(51)~=2) then	-- npc_fix: phase guard (original advanced unconditionally)
			CloseDialog()
			return
		end;
		Talk(1,"no",10150)
		Msg2Player("ChuÈn bÞ ®Õn sa m¹c t×m Tr­ Tinh ®Ó lÊy m¶nh L­u tinh")
		TaskNote(22,2)
		SetTask(51,3)
end;

function no()
		CloseDialog()
end;

-- luawave 2026-10-05: Chuyen sinh (script\phongthan\luawave\cs_lib.lua, loaded at call time)
function PTLW_CS()
	if not PTCS_Main then dofile("script\\phongthan\\luawave\\cs_lib.lua") end
	if PTCS_Main then PTCS_Main(2) end
end
