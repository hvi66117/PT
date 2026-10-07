--description:?´ó¸ç
--author: yichuan
--date: 2004/7/19

function main(sel)
	tasks = 
	{
		{"Phu Thª","renwu1";show=0}
	}
	UTask_world_2=GetTask(92);
	if(GetMorphType()==50)then
				if(UTask_world_2==2)or(UTask_world_2==4)then
						tasks[1].show=1;
				end;
	end;
	if(GetMorphType()==34)then
				if(UTask_world_2==2)or(UTask_world_2==3)then
						tasks[1].show=1;
				end;
	end;
	SayTask(10433,tasks)
end;

function  renwu1()
	UTask_world_2=GetTask(92);
	if(GetMorphType()==50)then
				if(UTask_world_2==2)or(UTask_world_2==4)then
						Talk(1,"no",10434)
						Msg2Player("NhËm ®¹i ca ®· thÊy ®­îc Phi Thè. ")
						SetTask(92,UTask_world_2+1)
				end;
	end;
	if(GetMorphType()==34)then
				if(UTask_world_2==2)or(UTask_world_2==3)then
						Talk(1,"no",10435)
						Msg2Player("NhËm ®¹i ca ®· thÊy ®­îc Ngäc n÷. ")
						SetTask(92,UTask_world_2+2)
				end;
	end;
end;


function no()	
		CloseDialog()
end;
