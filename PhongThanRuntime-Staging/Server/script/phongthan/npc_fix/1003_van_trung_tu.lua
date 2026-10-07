-- Phong Than npc_fix 2026-09-28: Van Trung Tu (1003); original script.pak \script\YuXuGong\YunZhongZi.lua (GBK names); changes:
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--   SayTask exit row "Ket thuc doi thoai" -> no(); task 15 phase 6->7 grants
--   the random level-1 phap bao (0,4,n,1,0,0) via QuestExchange(15,6,7),
--   AddCredit(10) only after success; yes_1 re-checks task 15 phase 0.
--description: ÔÆÖÐ×Ó
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks =
	{
		{"Th¨m Dß","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_05 = GetTask(15);
	if (GetPlayerType() == 1) and  (UTask_05 == 6)  then
			tasks[1].show=1;
	end;
	if (GetPlayerType() == 1) and  (UTask_05 == 2) then
			tasks[1].show=1;
	end;
	if (UTask_05 == 0)   and (GetPlayerType() == 1) and(GetLevel()>=7)then
			tasks[1].show=1;
	end;


	SayTask(10519,tasks)
end;


function  renwu1()
	UTask_05 = GetTask(15);
	if (GetPlayerType() == 1) and  (UTask_05 == 6)  then
		local n=random(0,5);
		if (QuestExchange(15,6,7,{},{{0,4,n,1,0,0,1}})~=1) then
			Msg2Player("Chua the nhan phap bao: hanh trang khong du cho trong.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10520)
		AddCredit(10)
		Msg2Player("Hoµn thµnh kh¶o nghiÖm cña V©n Trung Tö, nhËn ®­îc ph¸p b¶o cÊp 10.")
		TaskNote(5,4)
	end;
	if (GetPlayerType() == 1) and  (UTask_05 == 2) then
		Talk(1,"no",10521)
		SetTask(15,5)
		Msg2Player("TiÕp nhËn thö th¸ch cña V©n Trung Tö, ®i giÕt TuyÕt Nguyªn Cù Thó ë Thñ D­¬ng S¬n.")
		TaskNote(5,2)
	end;
	if (UTask_05 == 0)   and (GetPlayerType() == 1) and(GetLevel()>=7)then
		MsgBox(10522,"yes_1","no")
	end;
end;

function yes_1()
		if (GetTask(15)~=0) then
			CloseDialog()
			return
		end;
		Talk(1,"no",10523)
		SetTask(15,1)
		Msg2Player("TiÕp nhËn thö th¸ch cña V©n Trung Tö t×m Linh B¶o ®¹i ph¸p s­ tr¶ lêi vÊn ®¸p.")
		TaskNote(5,0)
end;

function  no()
		CloseDialog()
end;
