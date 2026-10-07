--description: æ§¼º-Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/8

function main()
	tasks = 
	{
		{"Thiªn Duyªn","renwu1";show=0},
		{"§Õn Diªu Tr×","renwu2";show=1}
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
	if  (GetLevel()>=85) and (HaveEventItem(9)==1)then
			if(UTask_Wizard==80)or(UTask_Druid==80)or(UTask_Knight==80)then
					Talk(1,"no",10380)
					DelEventItem(9)
					if  (GetPlayerType()==2)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							SetTask(2,81)
							TaskNote(29,31)
					elseif  (GetPlayerType()==1)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							SetTask(1,81)
							TaskNote(28,36)
					elseif  (GetPlayerType()==0)  then
							Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
							SetTask(3,81)
							TaskNote(27,32)
					end;
			end;
	end;
end;
