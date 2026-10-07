--description: ¹²¹¤Í¼ÌÚ-ÎäÆ÷ÏúÊÛÉÌ
--author: yichuan
--date: 2004/5/15

function main(sel)
	tasks = 
	{
		{"ThÇn Khİ","renwu1";show=0},
		{"B¸o danh","renwu";show=0}
	}
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (GetItemCount(28)>=3) then
				tasks[1].show=1;
	end;
	if (UTask_25==1) then
				tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then	
		 tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®ang chiªu mé anh tµi, chuÈn bŞ ph¹t Th­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10151,tasks)
	end;
end;

function   renwu1()
	UTask_25 = GetTask(35);
	if  (UTask_25==6) and (GetItemCount(28)>=3) then
		Talk(1,"no",10152)
		DelEventItem(28)
		DelEventItem(28)
		DelEventItem(28)
		AddEventItem(27)
		SetTask(35,7)
		Msg2Player("NhËn ®­îc ThÇn Khİ, ®em ®Õn ®­a cho Chóc Dung.")
		TaskNote(17,6)
	end;
	if (UTask_25==1) then
		Talk(1,"no",10153)
		Msg2Player("T×m Cao Minh hái tin tøc m¶nh ThÇn Khİ.")
		TaskNote(17,1)
		SetTask(35,2)
	end;
end;

function no()
		CloseDialog()
end;

function  renwu()
		if(GetTask(330)==0)then
			for a=1,3 do
				AddNormalItem(1,0,0,0,1,0)
				AddNormalItem(1,3,0,0,1,0)
			end;
			SetTask(330,1)
				Talk(1,"no","Hy väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bŞ.")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh tßng qu©n råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bŞ.")
		end;
end;
