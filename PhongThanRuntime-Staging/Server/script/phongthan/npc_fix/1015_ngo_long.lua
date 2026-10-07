-- Phong Than npc_fix 2026-09-28: Ngo Long (wu long, map 1015); original script.pak \script\MengJin\WuLong.lua (pinyin of GBK PAK path); changes: exit row in SayTask; task 2 13->20 swaps event 16 for skill book (7,59,128) via QuestExchange; one step per click; wrapper menu removed.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÎâÁú-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"BÊt Tóy ","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
			UTask_Druid = GetTask(2);
		if(GetPlayerType()==2)and (UTask_Druid==11)then
					tasks[1].show=1;
		end;
		if(GetLevel()>=35)  and  (UTask_Druid==13)  and  (HaveEventItem(16)>=1)then
					tasks[1].show=1;
		end;
		SayTask(10354,tasks)
end;

function   renwu1()
		UTask_Druid = GetTask(2);
		if(GetPlayerType()==2)and (UTask_Druid==11)then
						Talk(4,"no",10355,10356,10357,10358)
						SetTask(2,12)
						Msg2Player("Mau ®Õn töu ®iÕm trong TriÒu Ca ®Ó mua canh tØnh r­îu!")
						TaskNote(29,4)
						return	-- npc_fix: one step per click
		end;
		if(GetLevel()>=35)  and  (UTask_Druid==13)  and  (HaveEventItem(16)>=1)then
						-- npc_fix: event 16 -> skill book (7,59,128) and task 2 13->20 in one transaction
						if (QuestExchange(2,13,20,{{4,16,0,0,0,0,1}},{{7,59,128,1,0,0,1}})~=1) then
							Msg2Player("Chua the hoan thanh: can Canh tinh ruou va cho trong hanh trang.")
							CloseDialog()
							return
						end;
						Talk(3,"no",10359,10360,10361)
						Msg2Player("Cøu ®­îc Ng« Long, nhËn ®­îc s¸ch kü n¨ng Ban M«n Léng Phñ. TiÕp tôc ®i cøu nh÷ng ng­êi kh¸c.")
						TaskNote(29,6)
		end;
end;

function   no()
		CloseDialog()
end;
