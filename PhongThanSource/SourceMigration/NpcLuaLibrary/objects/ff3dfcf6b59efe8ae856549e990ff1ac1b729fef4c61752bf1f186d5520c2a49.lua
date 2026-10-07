--description: ÎâÁú-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"BÊt Tóy ","renwu1";show=0}
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
		end;
		if(GetLevel()>=35)  and  (UTask_Druid==13)  and  (HaveEventItem(16)>=1)then
						Talk(3,"no",10359,10360,10361)
						DelEventItem(16)
						AddNormalItem(7,59,128,1,0,0)
						Msg2Player("Cøu ®­îc Ng« Long, nhËn ®­îc s¸ch kü n¨ng Ban M«n Léng Phñ. TiÕp tôc ®i cøu nh÷ng ng­êi kh¸c.")
						SetTask(2,20)
						TaskNote(29,6)
		end;
end;

function   no()
		CloseDialog()
end;
