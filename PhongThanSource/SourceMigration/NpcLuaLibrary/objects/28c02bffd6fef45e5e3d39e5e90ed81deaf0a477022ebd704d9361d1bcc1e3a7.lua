Task_prepare = 1537

Task_anotherID = 1538
Task_item = 1539
Task_stage = 1540

GetBack_Info = {
    { itemInfo = { 3, 1134, 0, 0 }, itemName = "HuyÒn Hoang Th¸p", npcName = "D­ Kh¸nh", mapName = "Hoang m¹c" },
    { itemInfo = { 3, 1135, 0, 0 }, itemName = "H¶i ThÇn Ch©m", npcName = "Hoµng Minh", mapName = "§«ng H¶i" },
    { itemInfo = { 3, 1136, 0, 0 }, itemName = "V¹n Viªm Ch©u", npcName = "Tèng DÞ Nh©n", mapName = "Hiªn Viªn" },
    { itemInfo = { 3, 1137, 0, 0 }, itemName = "Tö Yªu LÖnh", npcName = "Hå Hû MÞ", mapName = "B¨ng Xuyªn" },
}
nNpcIndex = 3
Task_GetBackItem = 1727

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 23
    if (GetLevel() >= startLevel) then
        local taskProcess = GetTask(91)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 5) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) or (taskProcess == 5) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main(sel)
    tasks = {
        { "Yªn Phóc", "renwu1"; show = 0 },


    }

    UTask_world_1 = GetTask(91);
    if (UTask_world_1 == 2) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_1 == 0) and (GetLevel() >= 23) then
        tasks[1].show = 1;
    end ;

    SayTask(10065, tasks)
end;

function renwu1()
    UTask_world_1 = GetTask(91);
    if (UTask_world_1 == 2) then
        Talk(2, "func_dafu", 10066, 10067)
    end ;

    if (UTask_world_1 == 0) and (GetLevel() >= 13) then
        Talk(2, "func_ask", 10068, 10087)
    end ;
end;

function func_ask()
    MsgBox(10088, "yes_1", "no")
end;

function func_dafu()
    MsgBox(10076, "fault", "real")
end;

function real()
    Talk(2, "no", 10089, 10090)
    Earn(5000)
    SetTask(91, 5)
    Msg2Player("§em tin tèt lµnh ®Õn cho Tèng DÞ nh©n, nhËn ®­îc phÇn th­ëng.")
    TopMessage(14151)

    SetSubTask(25, -1, 1)

    TaskNote(25, -1)

    refreshNpcTaskState()

end;

function fault()
    if (GetCash() >= 500) then
        Talk(5, "no", 10091, 10092, 10093, 10094, 10095)
        Pay(500)
        AddNormalItem(6, 1, 12, 1, 0, 0)
        SetTask(91, 3)
        Msg2Player("G¹t ®­îc Tèng DÞ nh©n, lÊy ®­îc l¸ th¨m.")
        TaskNote(25, 2)

        refreshNpcTaskState()

    else
        Talk(5, "no", 10091, 10092, 10093, 10094, 10096)
    end ;
end;

function yes_1()
    CloseDialog()
    SetTask(91, 1)
    Msg2Player("T×m ThÇy t­íng sè, kÓ l¹i l¸ th¨m cña Tèng DÞ nh©n.")

    SetSubTask(25, 1, 1)

    TaskNote(25, 0)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function Get_BackItem()
    CloseDialog()
    local nStep = GetTaskByte(Task_GetBackItem, 3)
    local nYear, nMonth, nDay = GetYMD()
    local item = GetBack_Info[nNpcIndex].itemInfo

    if (nYear == 2011 and ((nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7)) and GetTaskByte(Task_GetBackItem, 2) == nNpcIndex) then
        if (nStep == 1) then
            TaskNote(1612, 1, GetBack_Info[nNpcIndex].itemName, "Tèng DÞ Nh©n")
            SetTaskByte(Task_GetBackItem, 3, 2)
            Talk(2, "no", "Nghe nãi " .. GetBack_Info[nNpcIndex].mapName .. " bÞ c­íp mÊt råi" .. GetBack_Info[nNpcIndex].itemName .. ", h·y gióp t«i ®o¹t l¹i b¶o khÝ tõ tay cña chóng!", "Nghe nãi ®· ®¸nh b¹i " .. GetBack_Info[nNpcIndex].mapName .. " cµng s©u trong ®éng th× x¸c suÊt nhËn ®­îc b¶o khÝ cµng lín, tuy nhiªn b¹n còng cã thÓ mua tõ ng­êi ch¬i kh¸c.")
        elseif (nStep == 2) then
            if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
                TaskNote(1612, -1)
                SetTaskByte(Task_GetBackItem, 3, 0)
                DelNormalItem(item[1], item[2], item[3], item[4])

                local lv = GetLevel()
                local nExp = 0
                if (lv >= 30 and lv <= 50) then
                    nExp = lv * 1000
                elseif (lv >= 51 and lv <= 90) then
                    nExp = lv * 2000
                elseif (lv >= 91 and lv <= 150) then
                    nExp = lv * 3000
                elseif (lv >= 151 and lv <= 200) then
                    nExp = lv * 4000
                end

                AddOwnExp(nExp)
                ScrollMessage("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
                Msg2Player("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
                WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô T×m b¶o khÝ")
                Talk(1, "no", "T×m ®­îc nhanh thÕ µ, c¶m ¬n ®¹i hiÖp, h·y nhËn lÊy phÇn th­ëng kinh nghiÖm!")
            else
                Talk(1, "no", "§¹i hiÖp vÉn ch­a gióp ta " .. GetBack_Info[nNpcIndex].itemName .. " tõ tay cña yªu ma, h·y ®i mau, thêi gian kh«ng cßn nhiÒu!")
            end
        end
    end
    refreshNpcTaskState()
end


