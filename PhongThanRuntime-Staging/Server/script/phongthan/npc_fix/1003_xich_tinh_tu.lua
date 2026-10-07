-- Phong Than npc_fix 2026-09-28: Xich Tinh Tu (1003); original script.pak \script\YuXuGong\ChiJingZi.lua (GBK names); changes:
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--   SayTask exit row "Ket thuc doi thoai" -> no(); GetItemCount(41) (engine
--   reads arg1 as genre) -> HaveEventItemCount(41) in main and renwu2;
--   task 50 phase 7->8 grants 3/4/5 x (3,28,0,0,0,0) Hong thuy tinh via
--   QuestExchange(50,7,8), AddOwnExp(5000)/SetTask(52,0)/messages only after
--   success; yes_3 re-checks task 50 phase 4. Task 10 (Bach Ly) unchanged.
--description: ³à¾«×Ó
--author: yichuan
--date: 2004/6/27

function main()
	tasks =
	{
		{"B¸ch Lı","renwu1";show=0},
		{"Vi Lao","renwu2";show=0},
		{"Chuy\211n sinh","PTLW_CS";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
		UTask_00=GetTask(10);
		if (UTask_00==1)or(UTask_00 == 3) or(UTask_00 == 5)or (UTask_00 == 7) then	
			tasks[1].show=1;
		end;
		UTask_xq_0=GetTask(50);
		if(UTask_xq_0==7)then
			tasks[2].show=1;
		end;		
		if(UTask_xq_0==5)and(HaveEventItem(39)==1)and(HaveEventItem(40)==1)and(HaveEventItemCount(41)>=2)then
			tasks[2].show=1;
		end;		
		if(UTask_xq_0==4)then
			tasks[2].show=1;
		end;		

	if (GetLevel() >= 100) or (GetTranslife and GetTranslife() > 0) then tasks[3].show=1 end -- luawave
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
				local c=3
				if(i<=5)then
					c=3
				elseif(5<i)and(i<=9)then
					c=4
				elseif(i==10)then
					c=5
				end;
				if (QuestExchange(50,7,8,{},{{3,28,0,0,0,0,c}})~=1) then
					Msg2Player("Chua the nhan thuong: hanh trang khong du cho trong.")
					CloseDialog()
					return
				end;
				if(c==3)then
					--µÀ¾ßÖÖ¯C0£¬¾ß·¥¯C±ğ2£¬ÏêÏ¸¯C±ğp£¬µÈ¼¶3
					Talk(1,"no",11396)
					TopMessage("B¹n nhËn ®­îc <color=green>3 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
				elseif(c==4)then
					Talk(1,"no",11397)
					TopMessage("B¹n nhËn ®­îc <color=green>4 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
                		else
					Talk(1,"no",11398)
					TopMessage("B¹n nhËn ®­îc <color=green>5 Hång thñy tinh<color> vµ <color=green>5000 ®iÓm kinh nghiÖm<color>")
				end;					                                  
				TaskNote(21,-1)
				Msg2Player("Cøu ®­îc Vâ C¸t, nhËn ®­îc Hång thñy tinh vµ 5000 ®iÓm kinh nghiÖm")
				AddOwnExp(5000)
				SetTask(52,0)
		end;

		if(UTask_xq_0==5)and(HaveEventItem(39)==1)and(HaveEventItem(40)==1)and(HaveEventItemCount(41)>=2)then
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
		if (GetTask(50)~=4) then
			CloseDialog()
			return
		end;
		TaskNote(21,4)
		Msg2Player("Thu thËp liÔu méc, C«n L«n kİnh, §Ìn thÇn cøu Vâ C¸t, cã lÏ biÕn th©n phï sÏ gióp İch cho b¹n.")
		SetTask(52,1)--52ºÅ±äÁ¿ÉèÂ÷Îª1£¬ÕâÖÖ×´Ì¬ÏÂ¿ÉÒÔ´òµ½ÜäÂØ¾µ
		SetTask(50,5)
		CloseDialog()
end;

function no()
		CloseDialog()
end;

-- luawave 2026-10-05: Chuyen sinh (script\phongthan\luawave\cs_lib.lua, loaded at call time)
function PTLW_CS()
	if not PTCS_Main then dofile("script\\phongthan\\luawave\\cs_lib.lua") end
	if PTCS_Main then PTCS_Main(1) end
end
