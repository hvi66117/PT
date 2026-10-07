--description: ¶ÄÍ½-Ã÷Öé°µÍ¶ÈÎÎñ
--author: chensong
--date: 2004/7/13

function main(sel)
			tasks = 
			{
			 {"Minh Ch©u","renwu1";show=0}
			}

	UTask_cg_1 = GetTask(41);
	if (UTask_cg_1==0)  and  (GetLevel()>=43) then
				 tasks[1].show=1;
	end;
	SayTask(10036,tasks)
end;

function   renwu1()
		Talk(2,"bujie",10037,10038)

end;

function bujie()
	Talk(2,"no",10039,10040)
	Msg2Player("T×m chñ tiÖm cÇm ®å dß la tin tøc §Þnh H¶i B¶o Ch©u.")
	TaskNote(20,0)
	SetTask(41,1)
end;

function no()
		CloseDialog()
end;
