--description:¾åÁôËï-Ã÷Öé°µÍ¶?Îñ
--author: chensong
--date: 2004/7/13
--edit:yichuan

function main()
	tasks = 
	{
		{"Minh Ch©u","renwu1";show=0},
		{"B¸o danh","renwu";show=0}
	}
UTask_cg_1 = GetTask(41);
	if (UTask_cg_1==27) and (HaveEventItem(33)>=1) and (HaveEventItem(34)>=1) and (HaveEventItem(35)>=1)  and (HaveEventItem(36)>=1) then
			tasks[1].show=1;
	end;
	if(UTask_cg_1==11)and(HaveEventItem(33)>=1)then
			tasks[1].show=1;
	end;
	if (UTask_cg_1==3) and (HaveEventItem(33)>=1) then
			tasks[1].show=1;
	end;
	if(GetLevel()<20)and(SystemTime()>1111140000)and(SystemTime()<1111226400)then		
			tasks[2].show=1;
		SayTask("Kh­¬ng Th¸i c«ng ®­îc sù ñy th¸c cña Vâ v­¬ng, triÖu tËp binh lÝnh chuÈn bÞ tiÕn ®¸nh Trô V­¬ng. NÕu muèn tham gia ta sÏ gióp ng­¬i b¸o danh. Ngµy mai xuÊt ph¸t th× kh«ng cßn c¬ héi n÷a! ",tasks)
	else 
		SayTask(10546,tasks)
	end;
end;

function  renwu1()
	UTask_cg_1 = GetTask(41);
	if (UTask_cg_1==27) and (HaveEventItem(33)>=1) and (HaveEventItem(34)>=1) and (HaveEventItem(35)>=1)  and (HaveEventItem(36)>=1) then
		Talk(1,"no",10547)
		DelEventItem(33)
		DelEventItem(34)
		DelEventItem(35)
		DelEventItem(36)
		AddOwnExp(3000)
		AddNormalItem(3,78,0,0,0,0)
		local  i=random(0,3)
		if(i==0)then
				AddNormalItem(3,80,0,0,0,0)
				TopMessage("B¹n nhËn ®­îc <color=green>1 Lam thñy tinh<color>")
		end;
		SetTask(41,10)
		Msg2Player("NhËn ®­îc 3000 ®iÓm kinh nghiÖm vµ 1 m¶nh Lam thñy tinh")
		TaskNote(20,-1)
	end;

	if(UTask_cg_1==11)and(HaveEventItem(33)>=1)then
		lingli();
	end;

	if (UTask_cg_1==3) and (HaveEventItem(33)>=1) then
		Talk(3,"lingli",10548,10549,10550)
	end;
end;

function lingli()
	MsgBox(10551,"yes_1","no")
end;

function yes_1()
	Talk(1,"no",10552)
	SetTask(41,20)
	Msg2Player("§i §«ng H¶i t×m Chóc Ng­ huyÕt, Thè Ng­ huyÕt, ThÓ Ng­ huyÕt.")
	TaskNote(20,3)
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
				Talk(1,"no","Hi väng ng­¬i nhanh chãng tr­ëng thµnh. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")			
		else
				Talk(1,"no","Ng­¬i ®· b¸o danh tßng qu©n råi. Sè t©n binh sau khi ®¹t cÊp 20 cã thÓ ®Õn T©y Kú t×m <color=red>Kh­¬ng Tö Nha<color> nhËn trang bÞ.")
		end;
end;
