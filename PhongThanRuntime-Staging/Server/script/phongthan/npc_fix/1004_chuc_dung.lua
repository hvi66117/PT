-- Phong Than npc_fix 2026-09-28: Chuc Dung (zhu rong totem, map 1004); original \script\ChiYouMu\ZhuRongTuTeng.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 35 7->8 consumes event 27 and grants equip (0,4,random 0-5,1,0,0) via QuestExchange, AddCredit(10) only after success; yes_1 guarded to phase 0; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ×£ÈÚÍ¼ÌÚ-½ÌÁ·-ò¿ÓÈÄ¹10¼¶ÈÎÎñ
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"Khai TrÝ","renwu1";show=0},
		{"ThÇn KhÝ","renwu2";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}

	UTask_20 = GetTask(30);
	UTask_25 = GetTask(35);
	if (UTask_20==1) or (UTask_20==3)or (UTask_20==5)or(UTask_20==7)then
			tasks[1].show=1;
	end;

	if (UTask_25==7) and (HaveEventItem(27)>=1) then
				tasks[2].show=1;
	end;

	if (UTask_25==0) and(GetPlayerType()==2)and(GetLevel()>=7) then
				tasks[2].show=1;
	end;

	SayTask(10218,tasks)
end;

function   renwu1()
	UTask_20 = GetTask(30);
	if(UTask_20==1)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,2)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==3)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,6)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==5)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,4)
			SetTask(30,UTask_20+8)
	end;
	if(UTask_20==7)then
			Talk(1,"no",10219)
			Msg2Player("§èi tho¹i víi Chóc Dung, nhËn ®­îc nh÷ng chØ dÉn quý gi¸!")
			TaskNote(13,7)
			SetTask(30,UTask_20+8)
	end;
end;

function   renwu2()
	UTask_25 = GetTask(35);
	if (UTask_25==7) and (HaveEventItem(27)>=1) then
			local n=random(0,5);
			-- npc_fix: event 27 (Than Khi) -> equip (0,4,n,1,0,0) + task 35 7->8 in one transaction
			if (QuestExchange(35,7,8,{{4,27,0,0,0,0,1}},{{0,4,n,1,0,0,1}})~=1) then
				Msg2Player("Chua the nhan thuong: can Than Khi va cho trong hanh trang.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10220)
			AddCredit(10)
			Msg2Player("NhËn ®­îc mét ph¸p b¶o cÊp 10.")
			TaskNote(17,7)
	elseif (UTask_25==0) and(GetPlayerType()==2)and(GetLevel()>=7) then
			MsgBox(10221,"yes_1","no")
	end;
end;

function yes_1()
	if (GetTask(35)~=0) then	-- npc_fix: never reset an accepted quest
		CloseDialog()
		return
	end;
	Talk(1,"no",10222)
	SetTask(35,1)
	Msg2Player("§i t×m Céng C«ng hái tin tøc cña  ThÇn KhÝ.")
	TaskNote(17,0)
end;

function no()
		CloseDialog()
end;
