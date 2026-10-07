--description: ËãÃüÏÈÉú
--author: yichuan
--date: 2004/7/13

function main()
	tasks = 
	{
		{"Phi Tiªn","renwu1";show=0}
	}
		UTask_xq_1=GetTask(51);
		if(UTask_xq_1==1)then
					tasks[1].show=1;
		end;
		SayTask(10467,tasks)
end;

function   renwu1()
		MsgBox(10468,"yes_1","no")
end;




function yes_1()
	if(GetCash()>=1000)then
		Talk(5,"no",10469,10470,10471,10472,10473)
		Msg2Player("T×m Cao Minh hái th¨m vÞ trÝ cô thÓ cña m¶nh L­u Tinh, nhËn ®­îc B¸ L¹c Nh·n.")
		AddNormalItem(3,29,0,0,0,0)
		Pay(1000)
		TaskNote(22,1)
		SetTask(51,2)
	else
		Talk(1,"no",10474)
	end;
end;

function no()
		CloseDialog()
end;
