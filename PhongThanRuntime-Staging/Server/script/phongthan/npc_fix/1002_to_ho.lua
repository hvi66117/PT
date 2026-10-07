-- Phong Than npc_fix 2026-09-28: To Ho (Su Hu); original script.pak \script\[GBK chongchengdaying]\[GBK suhu].lua; changes: exit row on SayTask, no authored wrapper menu, renwu1 task 20 phase 18->19 via QuestExchange (takes EventItem 26, gives 3x(1,0,1,1,0,0)+3x(1,3,1,1,0,0)), yes_1 task 20 phase 0->1 via QuestExchange compare-and-set.
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
--description: ËÕ»¤
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks =
	{
		{"Hép gÊm","renwu1";show=0},
		{"KÕt thóc ®èi tho¹i","no";show=1}
	}
			UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			tasks[1].show=1;
		end;
		if(UTask_10==0) then
			tasks[1].show=1;
		end;
		SayTask(10271,tasks)
end;

-- npc_fix: logic from the reviewed npc_restore QuestExchange appendix (1002_00.lua).
function renwu1()
    local phase = GetTask(20)
    if phase == 0 then
        MsgBox(10273, "yes_1", "no")
        return
    end
    if phase ~= 18 then
        CloseDialog()
        return
    end
    if QuestExchange(20, 18, 19,
        {{4, 26, 0, 0, 0, 0, 1}},
        {{1, 0, 1, 1, 0, 0, 3}, {1, 3, 1, 1, 0, 0, 3}}) ~= 1 then
        Msg2Player("Chua the nhan thuong: can Hop Gam va cho trong hanh trang.")
        CloseDialog()
        return
    end
    Talk(1, "no", 10272)
    Msg2Player("Giao Hop Gam cho To Ho: nhan 3 Tieu Hong don va 3 Tieu Hoan don.")
    TaskNote(7, 10)
end

function yes_1()
    if QuestExchange(20, 0, 1, {}, {}) ~= 1 then
        CloseDialog()
        return
    end
    Talk(1, "no", 10274)
    Msg2Player("Den Thu Kho lay Hop Gam ve cho To Ho.")
    TaskNote(7, 0)
end

function no()
		CloseDialog()
end;
