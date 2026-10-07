-- Phong Than npc_fix 2026-09-28: Da Bao Dao Nhan (duobao daoren, map 1044 Bich Du cung tang 3); original script.pak \script\BiYouGong\DuoBaoDaoRen.lua (pinyin of GBK PAK path; NPC not placed before this fix); changes: exit row in SayTask; yes() task 2 32->33 swaps event 18 for event 19 via QuestExchange (Di Nhan re-checked).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ∂‡±¶µ¿»À
--author: yichuan
--date: 2004/6/10

function main()
		local tasks =
		{
			   {"Ma huy’t","renwu1";show=0},
			   {"K’t thÛc ÆËi thoπi","no";show=1}
		}
		UTask_Druid=GetTask(2);
		if(UTask_Druid==32)and(HaveEventItem(18)==1)  then
				tasks[1].show=1
		end;
		SayTask(10001,tasks)
end;

function  renwu1()
			Talk(2,"yes",10002,10003)
		
end;

function  yes()
		-- npc_fix: event 18 -> event 19 and task 2 32->33 in one transaction
		if (GetPlayerType()~=2) or (QuestExchange(2,32,33,{{4,18,0,0,0,0,1}},{{4,19,0,0,0,0,1}})~=1) then
			Msg2Player("Chua the hoan thanh: can Kim Ha quan va cho trong hanh trang.")
			CloseDialog()
			return
		end;
		Talk(1,"no",10004)
		TaskNote(29,12)
		Msg2Player("Mang Kim Hµ qu∏n v“ B›ch Du cung, nhÀn Æ≠Óc Ma Huy’t.")
end;

function   no()
		CloseDialog()
end;
