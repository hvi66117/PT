--description:³çºî»¢-¼×Ê¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/11

function main()
	tasks = 
	{
		{"Trung Thµnh","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"Phôc håi nhiÖm vô","taskid";show=0}
	}
	UTask_Knight = GetTask(3);
	UTask_11 = GetTask(21);

				if(UTask_Knight==2)  and  (HaveEventItem(11)==1)then
						tasks[1].show=1;
				end;
				if(GetPlayerType()==0)and(GetLevel() >= 25)  and  (UTask_Knight==0) then
						tasks[1].show=1;
				end;
				if(UTask_11==4) then
							tasks[2].show=1;
				end;
	SayTask(10242,tasks)
end;

function   taskid()
			Talk(1,"no",11175)
end;


function   renwu1()
	UTask_Knight = GetTask(3);
	if(UTask_Knight==2)  and  (HaveEventItem(11)==1)then
							Talk(3,"no",10243,10244,10245)
							DelEventItem(11)
							AddOwnExp(300)
							Earn(30000)
							Msg2Player("NhËn ®­îc 300 ®iÓm kinh nghiÖm vµ 3w l­îng.")
							SetTask(3,10)
							TaskNote(27,2)
	end;
	if(GetPlayerType()==0)and(GetLevel() >= 25)  and  (UTask_Knight==0) then
							MsgBox(10246,"yes","no")
	end;
end;

function   renwu2()
			Talk(1,"no",10247)
			Msg2Player("Sïng HÇu Hæ kh«ng chÞu ®æi nguyªn liÖu, ®i t×m Lç Hïng nghÜ c¸ch.")
			TaskNote(8,4)
			SetTask(21,5)
end;

function yes()
		Talk(1,"no",10248)
		Msg2Player("§i gÆp TrÞnh Lu©n dä xÐt.")
		SetTask(3,1)
		TaskNote(27,0)
end;

function no()
		CloseDialog()
end;
