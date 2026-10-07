function GetPlayerTaskState()
    return 0, 0
end

function main(sel)
    tasks = {

        { "B¸o danh", "renwu"; show = 0 }
    }

    if (GetLevel() < 20) and (SystemTime() > 1111140000) and (SystemTime() < 1111226400) then
        tasks[1].show = 1;
        SayTask(12505, tasks)
    else
        SayTask(10229, tasks)
    end ;
end;

function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 10) then
        Talk(1, "no", 10230)
        Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
        TaskNote(7, 3)
        SetTask(20, UTask_10 + 2)
    end ;
    if (UTask_10 == 11) then
        Talk(1, "no", 10230)
        Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
        TaskNote(7, 5)
        SetTask(20, UTask_10 + 2)
    end ;
    if (UTask_10 == 14) then
        Talk(1, "no", 10230)
        Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
        TaskNote(7, 6)
        SetTask(20, UTask_10 + 2)
    end ;
    if (UTask_10 == 15) then
        Talk(1, "no", 10230)
        Msg2Player("§· th«ng b¸o cho TriÒu L«i.")
        TaskNote(7, 8)
        SetTask(20, UTask_10 + 2)
    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetTask(330) == 0) then
        for a = 1, 3 do
            AddNormalItem(1, 0, 0, 0, 1, 0)
            AddNormalItem(1, 3, 0, 0, 1, 0)
        end ;
        SetTask(330, 1)
        Talk(1, "no", 12506)
    else
        Talk(1, "no", 12507)
    end ;
end;
