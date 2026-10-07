-- Phong Than npc_fix 2026-09-28: Van Thai Su (wen taishi, map 1014); original script.pak \script\TongGuan\WenTaiShi.lua (pinyin of GBK PAK path, bound directly before this fix); changes: exit row in SayTask; yes() task 2 30->31 consumes event 17 via QuestExchange (Di Nhan, level>=55); one step per click in renwu1; event 19 is kept at 33->34 (Ho Hy Mi / Dac Ky need it).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ÎÅÌ«Ê¦-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

function  main()
	tasks = 
	{
		{"Ma huyÕt","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Druid = GetTask(2);
	if (UTask_Druid==33)  and  (HaveEventItem(19)>=1)then
				tasks[1].show=1;
	end;
	if(GetPlayerType()==2)and(GetLevel()>=55)  and (UTask_Druid==30)and (HaveEventItem(17)>=1)then
				tasks[1].show=1;
	end;

	SayTask(10369,tasks)
end;

function   renwu1()
		UTask_Druid = GetTask(2);
		if (UTask_Druid==33)  and  (HaveEventItem(19)>=1)then
				Talk(1,"no",10370)
				Msg2Player("Mang ma huyÕt ®i TriÒu Ca t×m Hå Hû MÞ.")
		        SetTask(2,34)
				TaskNote(29,13)
				return	-- npc_fix: one step per click
		end;

		if(GetPlayerType()==2)and(GetLevel()>=55)  and (UTask_Druid==30)and (HaveEventItem(17)>=1)then
				Talk(2,"func_leave",10371,10372)
	
		end;
end;

function  func_leave()
		Talk(1,"func_leave1",10373)
end;

function  func_leave1()
		MsgBox(10374,"yes","no")
end;

function  yes()
		CloseDialog()
		-- npc_fix: event 17 consumed + task 2 30->31 in one transaction
		if (GetPlayerType()~=2) or (GetLevel()<55) or (QuestExchange(2,30,31,{{4,17,0,0,0,0,1}},{})~=1) then
			return
		end;
		TaskNote(29,10)
		Msg2Player("NhËn lêi gióp V¨n th¸i s­ t×m Kim Qu¸n cña Háa Linh th¸nh mÉu ®­a cho Th«ng Thiªn gi¸o chñ ë BÝch Du Cung.")
end;

function no()
		CloseDialog()
end;
