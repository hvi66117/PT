--description: ¸ßÃ÷-Ç§ÀïÑÛ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"ThÇn KhÝ","renwu1";show=0},
		{"T©n Thøc","renwu2";show=0},
		{"Phi Tiªn","renwu3";show=0}
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
	SayTask(10146,tasks)
end;

function  renwu1()

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
		Talk(1,"no",10149)
		AddEventItem(29)
		Msg2Player("Tr­íc tiªn gióp Cao Minh chuyÓn th­ cho H×nh Thiªn.")
		TaskNote(14,2)
		SetTask(31,3)
	end;
end;

function   renwu3()

		Talk(1,"no",10150)
		Msg2Player("ChuÈn bÞ ®Õn sa m¹c t×m Tr­ Tinh ®Ó lÊy m¶nh L­u tinh")
		TaskNote(22,2)
		SetTask(51,3)
end;

function no()
		CloseDialog()
end;
