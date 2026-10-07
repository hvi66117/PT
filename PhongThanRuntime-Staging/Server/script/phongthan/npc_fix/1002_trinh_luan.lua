-- Phong Than npc_fix 2026-09-28: Trinh Luan (Zheng Lun); original script.pak \script\[GBK chongchengdaying]\[GBK zhenglun].lua; changes: exit row on SayTask, no authored wrapper menu, renwu1 task 3 phase 1->2 gives EventItem 11 via QuestExchange (also guards against repeat grants).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description:Ö£Â×-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/11

function main()
	tasks =
	{
		{"Trung Thµnh","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
	UTask_Knight = GetTask(3);
	if (GetPlayerType()==0) and (UTask_Knight==1) then        --¼×Ê¿5¼¶ÈÎÎñ
			tasks[1].show=1
	end;
		SayTask(10284,tasks)
end;

function   renwu1()
			if(QuestExchange(3,1,2,{},{{4,11,0,0,0,0,1}})~=1)then
				Msg2Player("Hanh trang khong du cho trong.")
				CloseDialog()
				return
			end;
			Talk(1,"no",10285)
			Msg2Player("Mang huyÕt th­ cña TrÞnh Lu©n vÒ cho Sïng HÇu Hæ.")
			TaskNote(27,1)
end;

function no()
		CloseDialog()
end;
