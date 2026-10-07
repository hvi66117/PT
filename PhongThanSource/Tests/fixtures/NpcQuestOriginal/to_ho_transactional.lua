--description: À’ª§
--author: yichuan
--date: 2004/5/14

function main(sel)
	tasks = 
	{
		{"HÈp g m","renwu1";show=0}
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

function   renwu1()	
		UTask_10 = GetTask(20);
		if(UTask_10==18) and (HaveEventItem(26)>=1) then
			Talk(1,"no",10272)
			DelEventItem(26)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,0,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			AddNormalItem(1,3,1,1,0,0)
			Msg2Player("GiÛp T´ HÈ l y hÈp g m, nhÀn ph«n th≠Îng 3 Ti”u HÂng Æ¨n vµ 3 Ti”u Hoµn Æ¨n.")
			TaskNote(7,10)
			SetTask(20,19)
		end;
		if(UTask_10==0) then
			MsgBox(10273,"yes_1","no")
		end;	
end;

function yes_1()
		Talk(1,"no",10274)
		Msg2Player("ß’n ThÒ khË l y hÈp g m v“ cho T´ HÈ.")
		TaskNote(7,0)
		SetTask(20,1)
end;

function no()
		CloseDialog()
end;

-- Project compatibility appendix; append AFTER the unchanged VNG Su Ho Lua.
-- Source: script.pak /script/Â¥áÂüéÂ§ßËê•/ËãèÊä§.lua
-- Original SHA256: c44b9f6b28692d77a4a4c6f51d35ebb6a509241e0be102d7b7c78eb4b026460c
-- Keeps task 20, EventItem 26, message IDs and all original reward tuples.
-- QuestExchange is a server API: reserve rewards, consume requirements and
-- advance the expected task phase together. A failed exchange changes nothing.
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
