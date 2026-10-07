--description: È¼µÆµÀÈË
--author: yichuan
--date: 2004/6/27

function main(sel)
	tasks = 
	{
		{"Ngò ThÊt","renwu1";show=0},
		{"Linh lùc","renwu2";show=0}
	}
	UTask_01=GetTask(11);
	UTask_04=GetTask(14);
	if(UTask_01==3)then
			tasks[1].show=1;
	end;
	if (UTask_04 == 1) and (HaveNormalItem(3,9,0,0)>=10) then
			tasks[2].show=1;
	end;
	if (UTask_04 == 0) and  (GetPlayerType()==1)and(GetLevel()>=12) then
			tasks[2].show=1;
	end;
		if (UTask_04 == 2)and (GetCamp()==0)then
						SetCamp(7)
						Talk(1,"no","Ng­¬i ®· nhËn kü n¨ng MËt tÞch, h·y cè g¾ng luyÖn tËp!")
						Msg2Player("B¹n ®· nhËn s¸ch kü n¨ng, tõ giê ®· kh«ng cßn lµ T©n Thñ n÷a!")
		end;
	SayTask(10526,tasks)
end;

function  renwu1()

		Talk(1,"no",10527)
		AddEventItem(20)
		SetTask(11,4)
		TaskNote(2,3)
		Msg2Player("NhËn ®­îc Háa Th¹ch")

end;

function  renwu2()
	UTask_04 = GetTask(14);
	if (UTask_04 == 1) and (HaveNormalItem(3,9,0,0)>=10) then
				Talk(1,"no",10528)
				for  i=1,10 do
					DelNormalItem(3,9,0,0)
				end;
				AddNormalItem(7,58,62,1,0,0) 
				SetTask(14,2)
				Msg2Player("nhËn ®­îc s¸ch kü n¨ng khai kho¸ng Bµn Cæ Khai Thiªn, tõ giê ®· kh«ng cßn lµ T©n Thñ!")
				SetCamp(7)
				TaskNote(4,1)
	end;
	if (UTask_04 == 0) and  (GetPlayerType()==1)and(GetLevel()>=12) then
				Talk(2,"yuanyi",10529,10530)
	end;
end;

function yuanyi()
		MsgBox(10531,"yes_1","no")
end;


function yes_1()
		CloseDialog()
		SetTask(14,1)
		Msg2Player("Gióp Nhiªn §¨ng ®¹o nh©n t×m 10 Ngäc cèt.")
		TaskNote(4,0)
end;

function no()
		CloseDialog()
end;
