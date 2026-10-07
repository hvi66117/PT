--description: ºóÍÁÍ¼ÌÚ-×°±¸ÏúÊÛÉÌ-ò¿ÓÈÄ¹1¼¶ÈÎÎñ
--author: yichuan
--date: 2004/6/29

function main(sel)
	tasks = 
	{
		{"T©n Thøc","renwu1";show=0}
	}
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
				tasks[1].show=1;
	end;		
	if (UTask_21 == 0)and(GetLevel()>=3)  then
				tasks[1].show=1;
	end;		
	SayTask(10154,tasks)
end;

function   renwu1()
	UTask_21 = GetTask(31);
	if (UTask_21 == 5)  and (HaveNormalItem(3,12,0,0)>=10) then
			Talk(1,"no",10155)
			for  i=1,10 do
				DelNormalItem(3,12,0,0)
			end;
			SetTask(31,6)
			Earn(600)
			AddOwnExp(500)
			Msg2Player("Gióp HËu Thæ t×m ®ñ nguyªn liÖu, nhËn ®­îc 600 l­îng + 500 ®iÓm kinh nghiÖm.")
			TaskNote(14,5)
	end;

	if (UTask_21 == 0)and(GetLevel()>=3)  then
			MsgBox(10156,"yes_1","no")		
	end;
end;

function yes_1()
		Talk(1,"no",10157)
		Msg2Player("T×m Cao Gi¸c hái vÒ nguyªn liÖu cã thÓ t¨ng tİnh n¨ng cña trang bŞ.")
		TaskNote(14,0)
		SetTask(31,1)
end;

function no()
		CloseDialog()
end;
