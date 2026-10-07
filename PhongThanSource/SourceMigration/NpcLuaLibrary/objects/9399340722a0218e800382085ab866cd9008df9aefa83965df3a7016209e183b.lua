--description:Îä¼ª
--author: yichuan
--date: 2004/7/8

function main()
	tasks = 
	{
		{"Vi Lao","renwu1";show=0}
	}
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==8)then
			tasks[1].show=1;
	end;
	if(UTask_xq_0==6)and(HaveEventItem(39)>=1)and(HaveEventItem(40)>=1)and(GetItemCount(41)>=2)then
			tasks[1].show=1;
	end;
	if(UTask_xq_0==3)and(HaveEventItem(38)>=1)then
			tasks[1].show=1;
	end;
	SayTask(10476,tasks)
end;

function   renwu1()
	UTask_xq_0=GetTask(50);
	if(UTask_xq_0==8)then
				MsgBox(10477,"yes","no")
	end;
	if(UTask_xq_0==6)and(HaveEventItem(39)>=1)and(HaveEventItem(40)>=1)and(GetItemCount(41)>=2)then
				Talk(1,"no",10478)
				DelEventItem(39)
				DelEventItem(40)
				DelEventItem(41)
				Msg2Player("Cøu Vâ C¸t, quay vÒ phôc mÖnh XÝch Tinh Tö.")
				TaskNote(21,6)
				SetTask(50,7)
	end;
	if(UTask_xq_0==3)and(HaveEventItem(38)>=1)then
				Talk(2,"yes_1",10479,10480)
				DelEventItem(38)
				Msg2Player("BiÕt Vâ C¸t ®ang muèn vÒ th¨m mÑ. §Õn Ngäc H­ Cung thØnh gi¸o XÝch Tinh Tö")
				TaskNote(21,3)
				SetTask(50,4)
	end;
end;

function  yes()
		Msg2Player("§i t×m XÝch Tinh Tö")
		TaskNote(21,7)
		SetTask(50,4)
		CloseDialog()
end;

function  yes_1()
		Talk(3,"no",10481,10482,10483)
end;

function no()	
		CloseDialog()
end;


