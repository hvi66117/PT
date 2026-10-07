--description: ³à¾«×Ó
--author: yichuan
--date: 2004/6/27

function main()
	tasks = 
	{
		{"B¸ch Lı","renwu1";show=0},
		{"Vi Lao","renwu2";show=0}
	}
		UTask_00=GetTask(10);
		if (UTask_00==1)or(UTask_00 == 3) or(UTask_00 == 5)or (UTask_00 == 7) then	
			tasks[1].show=1;
		end;
		UTask_xq_0=GetTask(50);
		if(UTask_xq_0==7)then
			tasks[2].show=1;
		end;		
		if(UTask_xq_0==5)and(HaveEventItem(39)==1)and(HaveEventItem(40)==1)and(GetItemCount(41)>=2)then
			tasks[2].show=1;
		end;		
		if(UTask_xq_0==4)then
			tasks[2].show=1;
		end;		

	SayTask(10570,tasks)
end;

function  renwu1()
		UTask_00=GetTask(10);
		if (UTask_00==1)then
			Talk(3,"no",10571,10572,10573)
			TaskNote(1,1)
			Msg2Player("Xİch Tinh Tö ®· chän ra ®Ö tö m×nh yªu thİch.")
			SetTask(10,UTask_00+8)
		end;
		if(UTask_00 == 3)then
			Talk(3,"no",10571,10572,10573)
			TaskNote(1,6)
			Msg2Player("Xİch Tinh Tö ®· chän ra ®Ö tö m×nh yªu thİch.")
			SetTask(10,UTask_00+8)
		end;
		if(UTask_00 == 5)then
			Talk(3,"no",10571,10572,10573)
			TaskNote(1,5)
			Msg2Player("Xİch Tinh Tö ®· chän ra ®Ö tö m×nh yªu thİch.")
			SetTask(10,UTask_00+8)
		end;
		if(UTask_00 == 7) then	
			Talk(3,"no",10571,10572,10573)
			TaskNote(1,7)
			Msg2Player("Xİch Tinh Tö ®· chän ra ®Ö tö m×nh yªu thİch.")
			SetTask(10,UTask_00+8)
		end;
end;

function  renwu2()
		UTask_xq_0=GetTask(50);
		if(UTask_xq_0==7)then
		 
				local i=random(1,10);
				if(i<=5)then
					AddNormalItem2(3,28,0,0,0,0)--µÀ¾ßÖÖ¯C0£¬¾ß·¥¯C±ğ2£¬ÏêÏ¸¯C±ğp£¬µÈ¼¶3
					AddNormalItem2(3,28,0,0,0,0)
					AddNormalItem2(3,28,0,0,0,0)
					Talk(1,"no",11396)
					TopMessage("B¹n nhËn ®­îc <color=green>3 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
				elseif(5<i)and(i<=9)then
					AddNormalItem2(3,28,0,0,0,0)
                       			AddNormalItem2(3,28,0,0,0,0)
					AddNormalItem2(3,28,0,0,0,0)
					AddNormalItem2(3,28,0,0,0,0)
					Talk(1,"no",11397)
					TopMessage("B¹n nhËn ®­îc <color=green>4 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
                		elseif(i==10) then 
					AddNormalItem2(3,28,0,0,0,0) 
					AddNormalItem2(3,28,0,0,0,0) 
					AddNormalItem2(3,28,0,0,0,0)
					AddNormalItem2(3,28,0,0,0,0)
					AddNormalItem2(3,28,0,0,0,0)
					Talk(1,"no",11398)
					TopMessage("B¹n nhËn ®­îc <color=green>5 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
				end;					                                  
				TaskNote(21,-1)
				Msg2Player("Cøu ®­îc Vâ C¸t, nhËn ®­îc Hång thñy tinh vµ 5000 ®iÓm kinh nghiÖm")
				AddOwnExp(5000)
				SetTask(50,8)
				SetTask(52,0)
		end;

		if(UTask_xq_0==5)and(HaveEventItem(39)==1)and(HaveEventItem(40)==1)and(GetItemCount(41)>=2)then
				Talk(1,"no",10629)
				TaskNote(21,5)
				Msg2Player("Thu thËp ®ñ b¶o bèi, ®Õn T©y Kú cøu Vâ C¸t.")
				SetTask(50,6)
		end;

		if(UTask_xq_0==4)then 
				Talk(4,"yes_4",10575,10576,10577,10578)
		end;
end;

function yes_4()
		Talk(1,"yes_2",10579)
end;


function yes_2()
		MsgBox(10580,"yes_3","no")
end;

function yes_3()
		TaskNote(21,4)
		Msg2Player("Thu thËp liÔu méc, C«n L«n kİnh, §Ìn thÇn cøu Vâ C¸t, cã lÏ biÕn th©n phï sÏ gióp İch cho b¹n.")
		SetTask(52,1)--52ºÅ±äÁ¿ÉèÂ÷Îª1£¬ÕâÖÖ×´Ì¬ÏÂ¿ÉÒÔ´òµ½ÜäÂØ¾µ
		SetTask(50,5)
		CloseDialog()
end;

function no()
		CloseDialog()
end;
