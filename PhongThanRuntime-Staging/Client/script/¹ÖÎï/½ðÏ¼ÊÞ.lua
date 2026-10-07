--description: ½ðÏ¼ÊÞ
--author: yichuan
--date:2004/8/2

function OnDeath()
	UTask_Druid = GetTask(2);
	if  (GetPlayerType()==2)  and  (GetLevel()>=35)  and  (UTask_Druid == 31)  then
			AddEventItem(18)
			Msg2Player("T×m ®­îc Kim Hµ qu¸n cña Háa Linh Th¸nh MÉu lµm mÊt, cã thÓ ®em nã ®Õn BÝch Du cung.")
			SetTask(2,32)
			TaskNote(29,11)
	end;
end;
