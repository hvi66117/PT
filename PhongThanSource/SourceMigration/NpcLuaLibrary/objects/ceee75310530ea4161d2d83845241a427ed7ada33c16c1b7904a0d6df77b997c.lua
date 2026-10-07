--description: µ±ÆÌÀÏ°å-Ã÷Öé°µÍ¶ÈÎÎñ
--author: chensong
--date: 2004/7/13

function main(sel)
			tasks = 
			{
				 {"Minh Ch©u","renwu1";show=0}
			}

			UTask_cg_1 = GetTask(41);
			if(UTask_cg_1==1) then
					tasks[1].show=1;
			end;
			if(UTask_cg_1==10) then
					tasks[1].show=1;
			end;
			SayTask(10029,tasks)
end;

function   renwu1()

	if(UTask_cg_1==10)  then
		Talk(3,"no",10030,10031,10032)
		AddEventItem(33)
		Msg2Player("Mang B¶o ch©u ®Õn Ngäc H­ Cung nhê Cï L­u T«n gi¸m ®Þnh.")
		TaskNote(20,2)
		SetTask(41,11)
	end;
	if (UTask_cg_1==1) then
		Talk(3,"no",10033,10034,10035)
		AddEventItem(33)
		SetTask(41,2)
		Msg2Player("§Õn §å Th­ Qu¸n ë Phong ThÇn ®µi t×m tung tÝch §Þnh H¶i B¶o Ch©u.")
		TaskNote(20,1)
	end;
end;

function   no()
		CloseDialog()
end;		
