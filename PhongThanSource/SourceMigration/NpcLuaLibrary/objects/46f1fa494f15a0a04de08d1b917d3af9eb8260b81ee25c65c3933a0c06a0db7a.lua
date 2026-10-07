WashPointNeed = {
    { IBItem = 503, IBCostIdx = 88 },
    { IBItem = 504, IBCostIdx = 89 },
    { IBItem = 505, IBCostIdx = 90 },
}
LockTaskIndex = 1307

TaskYouChong = 1288;

gIn_TaskYangShou = 1308
gIn_YangShouScriptItem = 436
gIn_YangShouCatchCount = 20
gIn_YangShouBounsExp = 30000

TASK_REBORN = 1691

Reborn_Table = {
    [1] = { lowLevel = 40, topLevel = 50, number = 5, property = 2, money = 1000000, },
    [2] = { lowLevel = 51, topLevel = 60, number = 10, property = 3, money = 5000000, },
    [3] = { lowLevel = 61, topLevel = 70, number = 20, property = 3, money = 20000000, },
    [4] = { lowLevel = 71, topLevel = 80, number = 40, property = 4, money = 50000000, },
}

Task_Reborn2 = 1709
Reborn_Table2 = {
    [1] = { lowLevel = 40, topLevel = 45, number = 7, property = 2, money = 1000000, },
    [2] = { lowLevel = 46, topLevel = 50, number = 8, property = 2, money = 1000000, },
    [3] = { lowLevel = 51, topLevel = 60, number = 15, property = 3, money = 5000000, },
    [4] = { lowLevel = 61, topLevel = 70, number = 30, property = 3, money = 20000000, },
    [5] = { lowLevel = 71, topLevel = 80, number = 60, property = 4, money = 50000000, },
}

Reborn_Items = {
    [1] = { name = "BÊt Chu HuyÒn ThiÕt", property = { 3, 361, 0, 0 }, camp = "Tiªn giíi" },
    [2] = { name = "BÊt Chu Tinh Cang", property = { 3, 362, 0, 0 }, camp = "Ma giíi" },
}

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

    startLevel = 120
    if (GetPlayerExtLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if ((taskKnight == 121) or (taskWizard == 121) or (taskDruid == 121)) or ((taskKnight == 123) or (taskWizard == 123) or (taskDruid == 123)) then
                state = 1
                subState = 0
            end
        else
            if ((taskKnight == 121) or (taskWizard == 121) or (taskDruid == 121)) or ((taskKnight == 123) or (taskWizard == 123) or (taskDruid == 123)) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 6
    if (GetPlayerExtLevel() >= startLevel) then
        local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
        local lYouCNum = GetByte(GetTask(TaskYouChong), 3)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (lTaskCtrl == 0) then
                state = 1
                subState = 0

            elseif (lTaskCtrl == 2 and lYouCNum == 0) then
                state = 3
                subState = 0
            elseif (lTaskCtrl <= 2) then
                state = 2
                subState = 0
            end
        else
            if (lTaskCtrl == 0) then
                state = 1
                subState = 1

            elseif (lTaskCtrl == 2 and lYouCNum == 0) then
                state = 3
                subState = 1
            elseif (lTaskCtrl <= 2) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 9
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskBit(gIn_TaskYangShou, 1) == 0 and GetTaskBit(gIn_TaskYangShou, 2) == 0) then
                state = 1
                subState = 0

            elseif ((GetTaskByte(gIn_TaskYangShou, 2) >= gIn_YangShouCatchCount) and ((HaveNormalItem(6, 1, gIn_YangShouScriptItem, 0) > 0) or (HaveNormalItemInQuick(6, 1, gIn_YangShouScriptItem, 0) > 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(gIn_TaskYangShou, 2) == 1 and GetTaskBit(gIn_TaskYangShou, 1) == 0) then
                state = 2
                subState = 0
            end
        else
            if (GetTaskBit(gIn_TaskYangShou, 1) == 0 and GetTaskBit(gIn_TaskYangShou, 2) == 0) then
                state = 1
                subState = 1

            elseif ((GetTaskByte(gIn_TaskYangShou, 2) >= gIn_YangShouCatchCount) and ((HaveNormalItem(6, 1, gIn_YangShouScriptItem, 0) > 0) or (HaveNormalItemInQuick(6, 1, gIn_YangShouScriptItem, 0) > 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(gIn_TaskYangShou, 2) == 1 and GetTaskBit(gIn_TaskYangShou, 1) == 0) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 40
    if (GetPlayerExtLevel() >= startLevel) then
        local taskInfo = {}
        local item = {}

        if (GetTaskByte(TASK_REBORN, 3) == 0) then
            state = 1
            subState = 0
        elseif (GetTaskByte(TASK_REBORN, 3) == 1) then

            local nSelf = GetTaskByte(Task_Reborn2, 1)
            if (nSelf == 0) then
                for i = 1, table.getn(Reborn_Table) do
                    if (GetPlayerExtLevel() >= Reborn_Table[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table[i].topLevel) then
                        taskInfo = Reborn_Table[i]
                        break
                    end
                end
            elseif (nSelf == 1) then
                for i = 1, table.getn(Reborn_Table2) do
                    if (GetPlayerExtLevel() >= Reborn_Table2[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table2[i].topLevel) then
                        taskInfo = Reborn_Table2[i]
                        break
                    end
                end
            end

            if (GetTaskByte(TASK_REBORN, 4) == 1) then
                item = Reborn_Items[2]
            elseif (GetTaskByte(TASK_REBORN, 4) == 2) then
                item = Reborn_Items[1]
            end

            if (HaveNormalItem(item.property[1], item.property[2], item.property[3], item.property[4]) >= taskInfo.number) then
                state = 3
                subState = 0
            else
                state = 2
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

function main()

    local tasks = {
        { "Th¨ng Tiªn NhËp Ma", "renwu120"; show = 0 },
        { "Ph©n phèi TiÒm n¨ng", "WashSelect"; show = 1 },
        { "¦u Trïng Phô ThÓ", "youchong"; show = 0 },
        { "Hñy bá ¦u Trïng Phô ThÓ", "cancelyouchong"; show = 0 },
        { "Phi Thè Cèt", "On_SelYanshou"; show = 1 },

        { "Thay g©n ®æi cèt", "Reborn"; show = 0 },

    }

    if ((GetTaskBit(gIn_TaskYangShou, 1) == 1) or (GetPlayerExtLevel() <= 8)) then
        tasks[5].show = 0
    end

    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (GetLevel() >= 120) then
        if (UTask_Knight == 121) or (UTask_Wizard == 121) or (UTask_Druid == 121) then
            tasks[1].show = 1
        elseif (UTask_Knight == 123) or (UTask_Wizard == 123) or (UTask_Druid == 123) then
            tasks[1].show = 1
        end

    end

    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lLevel = GetPlayerExtLevel()
    local lYouCNum = GetByte(GetTask(TaskYouChong), 3)

    if (lTaskCtrl == 0 and lLevel >= 6) then
        tasks[3].show = 1
    end

    if (lTaskCtrl == 2 and lYouCNum == 0) then
        tasks[3].show = 1
    end

    if (lTaskCtrl == 1 or (lTaskCtrl == 2 and lYouCNum ~= 0)) then
        tasks[4].show = 1
    end

    if (GetPlayerExtLevel() >= 40) then
        tasks[6].show = 1
    end

    SayTask(" Thiªn th­îng nh©n gian hµ xø khø, cùu hoan t©n méng gi¸c lai thêi", tasks)
end;

function Reborn()
    CloseDialog()

    if (GetTaskByte(TASK_REBORN, 3) == 1) then
        Finish_Reborn()
        return 0
    end

    local nTaskTimes = GetTaskByte(TASK_REBORN, 2)
    if (GetPlayerExtLevel() > nTaskTimes + 39) then

        local item = {}
        if (GetJusticEvilCredit() > 0) then
            item = Reborn_Items[1]
        elseif (GetJusticEvilCredit() < 0) then
            item = Reborn_Items[2]
        end

        local tasks = {
            { "Giao BÊt Chu HuyÒn ThiÕt", "Collect_XuanTie"; show = 1 },
            { "Giao BÊt Chu Tinh Cang", "Collect_JingGang"; show = 1 },
        }
        SayTask("Ng­¬i ®ang t¹i <c=yel>" .. item.camp .. "<c>, nÕu muèn nép <c=g>" .. item.name .. "<c>, cÇn nép nhiÒu h¬n mét nöa.", tasks)

    else
        Talk(1, "no", "Sau khi ®¹o h÷u ®¹t cÊp 40, mçi lÇn t¨ng cÊp cã thÓ ®Õn gÆp ta ®Ó thay g©n ®æi cèt, hÊp thô Thiªn §Þa linh khÝ t¨ng cao c¸c thuéc tÝnh. T¨ng thªm mét cÊp n÷a h·y quay l¹i nhÐ!")
    end
end

function Collect_XuanTie()
    CloseDialog()
    if (GetJusticEvilCredit() > 0) then
        SetTaskByte(Task_Reborn2, 1, 1)
    elseif (GetJusticEvilCredit() < 0) then
        SetTaskByte(Task_Reborn2, 1, 0)
    end
    SetTaskByte(TASK_REBORN, 4, 2)
    Pay_ForReborn()
end

function Collect_JingGang()
    CloseDialog()
    if (GetJusticEvilCredit() > 0) then
        SetTaskByte(Task_Reborn2, 1, 0)
    elseif (GetJusticEvilCredit() < 0) then
        SetTaskByte(Task_Reborn2, 1, 1)
    end
    SetTaskByte(TASK_REBORN, 4, 1)
    Pay_ForReborn()
end

function Pay_ForReborn()
    local taskInfo = {}

    local nSelf = GetTaskByte(Task_Reborn2, 1)
    if (nSelf == 0) then
        for i = 1, table.getn(Reborn_Table) do
            if (GetPlayerExtLevel() >= Reborn_Table[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table[i].topLevel) then
                taskInfo = Reborn_Table[i]
                break
            end
        end
    elseif (nSelf == 1) then
        for i = 1, table.getn(Reborn_Table2) do
            if (GetPlayerExtLevel() >= Reborn_Table2[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table2[i].topLevel) then
                taskInfo = Reborn_Table2[i]
                break
            end
        end
    end

    local item = {}
    if (GetTaskByte(TASK_REBORN, 4) == 1) then
        item = Reborn_Items[2]
    elseif (GetTaskByte(TASK_REBORN, 4) == 2) then
        item = Reborn_Items[1]
    end

    MsgBox("Muèn thay g©n ®æi cèt, ngoµi cÇn <c=g>" .. taskInfo.number .. "<c> <c=yel>" .. item.name .. "<c>, cßn cÇn <c=g>" .. taskInfo.money .. "<c> b¹c! Thö chø?", "Do_Reborn", "no")
end

function Do_Reborn()
    CloseDialog()
    local taskInfo = {}

    local nSelf = GetTaskByte(Task_Reborn2, 1)
    if (nSelf == 0) then
        for i = 1, table.getn(Reborn_Table) do
            if (GetPlayerExtLevel() >= Reborn_Table[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table[i].topLevel) then
                taskInfo = Reborn_Table[i]
                break
            end
        end
    elseif (nSelf == 1) then
        for i = 1, table.getn(Reborn_Table2) do
            if (GetPlayerExtLevel() >= Reborn_Table2[i].lowLevel and GetPlayerExtLevel() <= Reborn_Table2[i].topLevel) then
                taskInfo = Reborn_Table2[i]
                break
            end
        end
    end

    local item = {}
    if (GetTaskByte(TASK_REBORN, 4) == 1) then
        item = Reborn_Items[2]
    elseif (GetTaskByte(TASK_REBORN, 4) == 2) then
        item = Reborn_Items[1]
    end

    if (GetCash() < taskInfo.money) then
        Msg2Player("B¹n kh«ng mang ®ñ b¹c!")
        Talk(1, "no", "Thay g©n ®æi cèt cÇn b¹c <c=g>" .. taskInfo.money .. "<c>, ng­¬i kh«ng mang ®ñ b¹c!")
        return 0
    end

    Pay(taskInfo.money, 1)
    Msg2Player("B¹n tæn thÊt " .. taskInfo.money .. "TiÒn")
    SetTaskByte(TASK_REBORN, 1, GetPlayerExtLevel())
    SetTaskByte(TASK_REBORN, 3, 1)

    local nMaterialNum = HaveNormalItem(item.property[1], item.property[2], item.property[3], item.property[4])
    if (nMaterialNum >= taskInfo.number) then
        Finish_Reborn()
        return 0
    end

    TaskNote(1603, 0, taskInfo.number, item.name)

    Talk(1, "no", "Thay g©n ®æi cèt kh«ng hÒ ®¬n gi¶n, cßn cÇn <c=g>" .. taskInfo.number .. "<c> <c=g>" .. item.name .. "<c>, h·y nhanh chãng t×m ®ñ ®i!")
    refreshNpcTaskState()

end

function Finish_Reborn()
    local taskInfo = {}
    local item = {}

    local nLevel = GetTaskByte(TASK_REBORN, 1)

    local nSelf = GetTaskByte(Task_Reborn2, 1)
    if (nSelf == 0) then
        for i = 1, table.getn(Reborn_Table) do
            if (nLevel >= Reborn_Table[i].lowLevel and nLevel <= Reborn_Table[i].topLevel) then
                taskInfo = Reborn_Table[i]
                break
            end
        end
    elseif (nSelf == 1) then
        for i = 1, table.getn(Reborn_Table2) do
            if (nLevel >= Reborn_Table2[i].lowLevel and nLevel <= Reborn_Table2[i].topLevel) then
                taskInfo = Reborn_Table2[i]
                break
            end
        end
    end

    if (GetTaskByte(TASK_REBORN, 4) == 1) then
        item = Reborn_Items[2]
    elseif (GetTaskByte(TASK_REBORN, 4) == 2) then
        item = Reborn_Items[1]
    end

    local nTaskTimes = GetTaskByte(TASK_REBORN, 2)
    if (GetPlayerExtLevel() <= nTaskTimes + 39) then
        return 0
    end

    local nMaterialNum = HaveNormalItem(item.property[1], item.property[2], item.property[3], item.property[4])
    if (nMaterialNum >= taskInfo.number) then
        for i = 1, taskInfo.number do
            DelNormalItem(item.property[1], item.property[2], item.property[3], item.property[4])
        end

        SetTaskByte(TASK_REBORN, 3, 0)
        SetTaskByte(TASK_REBORN, 2, GetTaskByte(TASK_REBORN, 2) + 1)
        TaskNote(1603, -1)

        local shuxing = {
            { kind = "Søc m¹nh", key = 0 },
            { kind = "Th©n ph¸p", key = 0 },
            { kind = "ThÓ chÊt", key = 0 },
            { kind = "Linh ho¹t", key = 0 },
        }

        local KeepPoint = { 0, 0, 0, 0 }
        for i = 1, 4 do
            KeepPoint[i] = GetAssignedAttrib(i - 1)
            ClearAssignedAttrib(i - 1)
        end

        local totalPoint = taskInfo.property
        for i = 1, totalPoint do
            local attrIdx = math.random(1, 4)
            shuxing[attrIdx].key = shuxing[attrIdx].key + 1
        end

        local str = ""
        for j = 1, 4 do
            AddAssignedAttrib(j - 1, shuxing[j].key + KeepPoint[j])
            if (shuxing[j].key > 0) then
                str = str .. shuxing[j].key .. " ®iÓm" .. shuxing[j].kind
            end
        end
        ApplyAssignedAttrib()
        Talk(1, "no", "§· thay g©n ®æi cèt, nhËn ®­îc <c=g>" .. str .. "<c> xanh nµo!")
        local shuxingstr = ""
        for i = 1, 4 do
            shuxingstr = shuxingstr .. shuxing[i].kind .. GetAssignedAttrib(i - 1)
        end
        WriteLog("[ÍÑÌ¥»»¹Ç][NhËn ®­îc: " .. str .. "][ÊôÐÔ: " .. shuxingstr)
    else
        Talk(1, "no", "Nguyªn liÖu vÉn ch­a ®ñ! H·y tiÕp tôc nç lùc!")
    end
    refreshNpcTaskState()
end

function On_SelYanshou()
    if (GetPlayerExtLevel() < 9) then
        MsgBox(" §¼ng cÊp cña ng­¬i ch­a ®¹t yªu cÇu!", "no")
        return
    end

    if (GetTaskBit(gIn_TaskYangShou, 1) == 1) then
        MsgBox("Cã tin vui ®©y! D­îc ph­¬ng kh¾c chÕ Trïng hån ta ®· ®iÒu chÕ xong. N¹n Phi Thè cã hy väng ®­îc gi¶i trõ!", "no")
        return
    end

    if (GetTaskBit(gIn_TaskYangShou, 2) == 1) then
        if (HaveItemInAllRoom(6, 1, gIn_YangShouScriptItem, 0, 0, 0, 0) == 0) then
            MsgBox(" Hå L« dÔ lµm, ®õng lo! Ta t¨ng cho ng­¬i c¸i kh¸c ®©y!", "no")
            AddNormalItem(6, 1, gIn_YangShouScriptItem, 0, 0, 0)
            return
        end

        if (GetTaskByte(gIn_TaskYangShou, 2) >= gIn_YangShouCatchCount) then
            if (HaveNormalItem(6, 1, gIn_YangShouScriptItem, 0) > 0) or (HaveNormalItemInQuick(6, 1, gIn_YangShouScriptItem, 0) > 0) then

                MsgBox(" Lo¹i ¦u Trïng nµy kh«ng biÕt lai lÞch tõ ®©u, dï sao còng ®· trõ råi! Xin nhËn chót phÇn th­ëng nµy!", "no")

                DelNormalItem(6, 1, gIn_YangShouScriptItem, 0)
                DelNormalItemInQuick(6, 1, gIn_YangShouScriptItem, 0)

                local nFactExp = AddOwnExtendExp(gIn_YangShouBounsExp)
                Msg2Player("Hoµn thµnh nhiÖm vô Phi Thè Cèt, nhËn ®­îc " .. math.floor(nFactExp) .. " ®iÓm tu luyÖn")

                SetTaskBit(gIn_TaskYangShou, 2, 0)
                SetTaskBit(gIn_TaskYangShou, 1, 1)
                SetTaskByte(gIn_TaskYangShou, 2, 0)
                TopMessage("NhËn ®­îc " .. math.floor(nFactExp) .. " ®iÓm tu luyÖn")
                SetSubTask(1025, -1, 1)
                TaskNote(1025, -1)

                refreshNpcTaskState()

                if (GetPlayerType() == 0) then
                    AddNormalItem(0, 6, 12, 1, 0, 1, 1)
                elseif (GetPlayerType() == 1) then
                    AddNormalItem(0, 6, 13, 1, 0, 1, 1)
                elseif (GetPlayerType() == 2) then
                    AddNormalItem(0, 6, 14, 1, 0, 1, 1)
                end

            else
                MsgBox(" NÕu ®· b¾t hÕt ®­îc Phi Thè, xin tr¶ l¹i Hå L« cho ta!", "no")
            end
        else
            MsgBox(" Ng­¬i ch­a b¾t ®ñ dÞ thó!", "no")
        end

        return
    end

    MsgBox(" Phi Thè mÆc dï hung ¸c, nh­ng vÉn cã thÓ trÞ. Do chóng bÞ ¦u Trïng Phô ThÓ khèng chÕ, giê ph¶i b¾t vµi con vÒ nghiªn cøu ra ph­¬ng thøc ®Ó trõ chóng!", "lishou_yes", "no")
end

function lishou_yes()
    if (GetTaskBit(gIn_TaskYangShou, 1) == 1) then
        return
    end

    if (GetTaskBit(gIn_TaskYangShou, 2) == 1) then
        return
    end

    if (GetTaskByte(gIn_TaskYangShou, 2) >= gIn_YangShouCatchCount) then
        return
    end

    CloseDialog()
    SetTaskBit(gIn_TaskYangShou, 2, 1)
    SetTaskByte(gIn_TaskYangShou, 2, 0)
    SetSubTask(1025, 1, 1)
    AddNormalItem(6, 1, gIn_YangShouScriptItem, 0, 0, 0)

    refreshNpcTaskState()

    TaskNote(1025, 0)

    Talk(1, "no", " Ta cho ng­¬i m­în <c=g>Hå L«<c> nµy, h·y ®i b¾t" .. gIn_YangShouCatchCount .. " Phi Thè vÒ ®©y ®Ó nghiªn cøu c¸ch trõ chóng! Cã ®Ó ®Æt <c=g>Hå L«<c> trªn thanh phÝm t¾t.")
end

function cold()

    if (HaveNormalItem(3, 224, 0, 0) >= 1) then
        Talk(1, "no", 14595)
        DelNormalItem(3, 224, 0, 0)
        AddOwnExp(10000)
        Earn(500)
        TopMessage(14447)
        Msg2Player("B¹n nhËn ®­îc 10000 kinh nghiÖm, 500 l­îng")
        SetTask(Task_cold, SetBit(GetTask(Task_cold), 2, 1))
        TaskNote(74, -1)

        refreshNpcTaskState()

    end

end;

function youchong()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lYouCNum = GetByte(GetTask(TaskYouChong), 3)
    if (lTaskCtrl == 0) then
        accepteyouchongtask()
    elseif (lTaskCtrl == 2 and lYouCNum == 0) then
        finishyouchongtask()
    end
end

function accepteyouchongtask()
    CloseDialog()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    if (lTaskCtrl == 0) then
        Talk(1, "no", "Phi Thè th­êng quÇn tô ë BÊt Chu Thiªn quan, tr­íc giê ®Òu sèng yªn b×nh víi nh©n gian. Kh«ng hiÓu v× sao gÇn ®©y chóng l¹i léng hµnh, ph¸ ho¹i c©y cèi mïa mµng! Ng­¬i b¶n lÜnh còng kh«ng ph¶i tÇm th­êng, cã d¸m ®i tiªu diÖt chóng kh«ng?")
        SetTask(TaskYouChong, SetByte(GetTask(TaskYouChong), 3, 20))
        SetTaskWord(TaskYouChong, 1, 1)
        SetSubTask(1024, 1, 1)

        refreshNpcTaskState()

    else
        Talk(1, "no", "Hµng phôc Phi Thè cÇn ph¶i hiÓu ®­îc nh÷ng nh­îc ®iÓm cña nã, nh­ng biÕt råi còng ch­a ch¾c dÔ dµng ®èi phã! Anh hïng ph¶i hÕt søc cÈn thËn nhÐ!")
    end
    TaskNote(1024, 0)
end

function finishyouchongtask()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lTaskNum = GetByte(GetTask(TaskYouChong), 3)
    if (lTaskCtrl == 2 and lTaskNum == 0) then
        local nFactExp = AddOwnExtendExp(10000)
        SetTaskWord(TaskYouChong, 1, 3)
        Talk(1, "no", " Th× ra Phi Thè t¸c lo¹n, nguyªn do lµ bÞ ¦u Trïng khèng chÕ! Ta ®· cã chót manh mèi råi! Anh hïng h·y t¹m nghØ ng¬i ®i!")
        Msg2Player("Hoµn thµnh nhiÖm vô ¦u Trïng Phô ThÓ, nhËn ®­îc " .. math.floor(nFactExp) .. " ®iÓm tu luyÖn!")
        TopMessage("NhËn ®­îc " .. math.floor(nFactExp) .. " tu luyÖn")
        SetSubTask(1024, -1, 1)
        TaskNote(1024, -1)

        refreshNpcTaskState()

    end
end

function cancelyouchong()
    CloseDialog()
    local lTaskCtrl = GetTaskWord(TaskYouChong, 1)
    local lLevel = GetPlayerExtLevel()
    local lYouCNum = GetByte(GetTask(TaskYouChong), 3)

    if (lTaskCtrl == 1 or (lTaskCtrl == 2 and lYouCNum ~= 0)) then
        SetTask(TaskYouChong, 0)
        TaskNote(1024, -1)

        refreshNpcTaskState()

    end
end

function renwu120()
    CloseDialog()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (UTask_Knight == 121) or (UTask_Wizard == 121) or (UTask_Druid == 121) then
        Talk(4, "no", " B¹n trÎ lµ do Cao Minh tiÕn cö ®Õn t×m ta?", "Kh«ng sai! Xin ®¹i s­ chØ gi¸o!", " BÊt Chu Thiªn quan nµy lµ n¬i tiÕp gi¸p gi÷a nh©n giíi vµ thiªn th­îng, còng chÝnh lµ n¬i ph¸t sinh cuéc chiÕn Tiªn Ma l­ìng giíi. Giê h·y ®i thØnh gi¸o Tu Hµnh S­, ng­¬i sÏ biÕt ®­îc nhiÒu ®iÒu bæ Ých!", "§a t¹ ®¹i s­ chØ ®iÓm!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 122)
            TaskNote(27, 51)
        elseif (pt == 1) then
            SetTask(1, 122)
            TaskNote(28, 55)
        else
            SetTask(2, 122)
            TaskNote(29, 50)
        end ;

        refreshNpcTaskState()


    elseif (UTask_Knight == 123) or (UTask_Wizard == 123) or (UTask_Druid == 123) then
        Talk(4, "no", "Cã ph¶i lµ do XÝch Tinh Tö giíi thiÖu ®¹o h÷u ®Õn ®©y?", "Kh«ng sai! Xin ®¹i s­ chØ gi¸o!", " BÊt Chu Thiªn quan nµy lµ n¬i tiÕp gi¸p gi÷a nh©n giíi vµ thiªn th­îng, còng chÝnh lµ n¬i ph¸t sinh cuéc chiÕn Tiªn Ma l­ìng giíi. Giê h·y ®i thØnh gi¸o Tu Hµnh S­, ng­¬i sÏ biÕt ®­îc nhiÒu ®iÒu bæ Ých!", "§a t¹ ®¹i s­ chØ ®iÓm!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 124)
            TaskNote(27, 50)
        elseif (pt == 1) then
            SetTask(1, 124)
            TaskNote(28, 54)
        else
            SetTask(2, 124)
            TaskNote(29, 49)
        end ;

        refreshNpcTaskState()

    end
end

function ClearLock()
    SetTask(LockTaskIndex, 0)
end

function GetLockFlag(AttribIndex)
    return GetTaskBit(LockTaskIndex, AttribIndex)
end

function GetLockAttribString()
    local sLock = ""
    local sUnLock = ""
    if (GetLockFlag(1) == 1) then
        sLock = sLock .. "[Søc lùc]"
    else
        sUnLock = sUnLock .. "[Søc lùc]"
    end

    if (GetLockFlag(2) == 1) then
        sLock = sLock .. "[Th©n ph¸p]"
    else
        sUnLock = sUnLock .. "[Th©n ph¸p]"
    end

    if (GetLockFlag(3) == 1) then
        sLock = sLock .. "[ThÓ chÊt]"
    else
        sUnLock = sUnLock .. "[ThÓ chÊt]"
    end

    if (GetLockFlag(4) == 1) then
        sLock = sLock .. "[Ngé tÝnh]"
    else
        sUnLock = sUnLock .. "[Ngé tÝnh]"
    end

    return sLock, sUnLock
end

function SetLockFlag(AttribIndex, Flag)
    SetTaskBit(LockTaskIndex, AttribIndex, Flag)
end

function CheckIB(WashType)
    local ItemID = FindAValidIBItem(8, WashPointNeed[WashType].IBItem, 2, 0)
    if (ItemID > 0) then
        return 1
    else
        costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[WashType].IBCostIdx)
        if (GetCoin() >= costIBNum) then
            return 1
        end
    end

    return 0
end

function CostIB(WashType)
    local ItemID = FindAValidIBItem(8, WashPointNeed[WashType].IBItem, 2, 0)
    if (ItemID > 0) then
        CostIBItem(ItemID)
    else
        CostCoinByIdx(WashPointNeed[WashType].IBCostIdx)
    end
end

function WashSelect()
    CloseDialog()
    local AllPoint = 0
    for i = 0, 3 do
        AllPoint = AllPoint + GetAssignedAttrib(i)
    end
    if (AllPoint <= 0) then
        MsgBox(" Ng­¬i hiÖn t¹i kh«ng cã ®ñ ®iÓm tiÒm n¨ng ®Ó ph©n phèi. Trïng sinh hoÆc tiÕn hµnh ®é kiÕp sÏ gióp ng­¬i cã ®iÓm TiÒm n¨ng!", "no")
        return
    end

    local tasks = {
        { "Ph©n phèi toµn bé", "StartWashAll"; show = 1 },
        { "Ph©n phèi 3 môc", "StartWashThree"; show = 1 },
        { "Ph©n phèi 2 môc", "StartWashTwo"; show = 1 },
    }
    local string = "<enter>B¹n ®· ph©n phèi ®iÓm TiÒm n¨ng nh­ sau <enter>Søc lùc: <c=yel>" .. GetAssignedAttrib(0) .. "<c>Th©n ph¸p: <c=yel>" .. GetAssignedAttrib(1) .. "<c><enter>ThÓ chÊt: <c=yel>" .. GetAssignedAttrib(2) .. "<c>Ngé tÝnh: <c=yel>" .. GetAssignedAttrib(3) .. "<c>"
    SayTask(" Tho¸t thay ®æi cèt vèn lµ chuyÖn nghÞch l¹i ý trêi, mét khi thÊt b¹i, hËu qu¶ sÏ khã l­êng. Ng­îc l¹i nÕu thµnh c«ng, n¨ng lùc sÏ kh«ng thua g× thiªn binh thÇn t­íng!" .. string, tasks)
end

function StartWashAll()
    CloseDialog()

    ClearLock()

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[1].IBCostIdx)
    MsgBox(" Tho¸t thay ®æi cèt vèn lµ chuyÖn nghÞch l¹i ý trêi, nh­ng nÕu ng­¬i thµnh t©m bá ra <c=g>" .. costDisNum .. "<c> Th«ng B¶o, ta sÏ chÊp nhËn bÞ th­îng thiªn tr¸ch ph¹t, gióp ng­¬i th©y g©n ®æi cèt!", "DoWashAll", "WashSelect")
end

function DoWashAll()
    CloseDialog()
    if (CheckIB(1) == 0) then
        MsgBox(" Th«ng B¶o cña ng­¬i kh«ng ®ñ!", "no")
        return
    end

    WashPoint()

    CostIB(1)

    MsgBox("LÇn nµy ®· ph©n phèi l¹i ®iÓm tiÒm n¨ng nh­ sau:<enter>Søc lùc:" .. GetAssignedAttrib(0) .. "<enter>Th©n ph¸p:" .. GetAssignedAttrib(1) .. "<enter>ThÓ chÊt:" .. GetAssignedAttrib(2) .. "<enter>Ngé tÝnh:" .. GetAssignedAttrib(3) .. "<enter>Ng­¬i x¸c ®Þnh muèn tÈy ®iÓm tiÒm n¨ng?", "DoWashAll", "WashSelect")
end

function StartWashThree()
    CloseDialog()

    ClearLock()

    local tasks = {
        { "Khãa Søc lùc", "WashThreeLockStr"; show = 1 },
        { "Khãa Th©n ph¸p", "WashThreeLockDex"; show = 1 },
        { "Khãa ThÓ chÊt", "WashThreeLockCon"; show = 1 },
        { "Khãa Ngé tÝnh", "WashThreeLockInt"; show = 1 },
    }
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    SayTask(" Tho¸t thay ®æi cèt vèn lµ chuyÖn nghÞch l¹i ý trêi, nh­ng nÕu ng­¬i thµnh t©m bá ra <c=g>" .. costDisNum .. "<c> Th«ng B¶o, ta sÏ chÊp nhËn bÞ th­îng thiªn tr¸ch ph¹t, gióp ng­¬i th©y g©n ®æi cèt!", tasks)
end

function WashThreeLockStr()
    SetLockFlag(1, 1)

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("HuyÒn §é §¹i Ph¸p S­: HiÖn t¹i ®ang khãa søc m¹nh, ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶ÔÉí·¨, ÌåÖÊ, ÎòÐÔ½øÐÐÖØÐÂ·ÖÅä sao?", "DoWashThree", "WashSelect")

end

function WashThreeLockDex()
    SetLockFlag(2, 1)

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("HuyÒn §é §¹i Ph¸p S­: HiÖn t¹i ®ang khãa th©n ph¸p, ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶ÔÁ¦Á¿, ÌåÖÊ, ÎòÐÔ½øÐÐÖØÐÂ·ÖÅä sao?", "DoWashThree", "WashSelect")

end

function WashThreeLockCon()
    SetLockFlag(3, 1)

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("HuyÒn §é §¹i Ph¸p S­: HiÖn t¹i ®ang khãa thÓ chÊt, ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶ÔÁ¦Á¿, Éí·¨, ÎòÐÔ½øÐÐÖØÐÂ·ÖÅä sao?", "DoWashThree", "WashSelect")

end

function WashThreeLockInt()
    SetLockFlag(4, 1)

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("HuyÒn §é §¹i Ph¸p S­: HiÖn t¹i ®ang khãa ngé tÝnh, ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶ÔÁ¦Á¿, Éí·¨, ÌåÖÊ½øÐÐÖØÐÂ·ÖÅä sao?", "DoWashThree", "WashSelect")

end

function DoWashThree()
    CloseDialog()
    if (CheckIB(2) == 0) then
        MsgBox(" Th«ng B¶o cña ng­¬i kh«ng ®ñ!", "no")
        return
    end

    WashPoint()

    CostIB(2)

    MsgBox("LÇn nµy ®· ph©n phèi l¹i ®iÓm tiÒm n¨ng nh­ sau:<enter>Søc lùc:" .. GetAssignedAttrib(0) .. "<enter>Th©n ph¸p:" .. GetAssignedAttrib(1) .. "<enter>ThÓ chÊt:" .. GetAssignedAttrib(2) .. "<enter>Ngé tÝnh:" .. GetAssignedAttrib(3) .. "<enter>Ng­¬i x¸c ®Þnh muèn tÈy ®iÓm tiÒm n¨ng?", "DoWashThree", "WashSelect")
end

function StartWashTwo()
    CloseDialog()

    ClearLock()
    local tasks = {
        { "Khãa Søc lùc", "WashTwoLockStr1"; show = 1 },
        { "Khãa Th©n ph¸p", "WashTwoLockDex1"; show = 1 },
        { "Khãa ThÓ chÊt", "WashTwoLockCon1"; show = 1 },
        { "Khãa Ngé tÝnh", "WashTwoLockInt1"; show = 1 },
    }
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[3].IBCostIdx)
    SayTask(" Tho¸t thay ®æi cèt vèn lµ chuyÖn nghÞch l¹i ý trêi, nh­ng nÕu ng­¬i thµnh t©m bá ra <c=g>" .. costDisNum .. "<c> Th«ng B¶o, ta sÏ chÊp nhËn bÞ th­îng thiªn tr¸ch ph¹t, gióp ng­¬i th©y g©n ®æi cèt!", tasks)
end

function WashTwoLockStr1()
    SetLockFlag(1, 1)
    local tasks = {
        { "Khãa Th©n ph¸p", "WashTwoLockDex2"; show = 1 },
        { "Khãa ThÓ chÊt", "WashTwoLockCon2"; show = 1 },
        { "Khãa Ngé tÝnh", "WashTwoLockInt2"; show = 1 },
    }
    SayTask("Ng­¬i ®· khãa Søc lùc, xin chän thuéc tÝnh thø hai muèn khãa!", tasks)
end

function WashTwoLockDex1()
    SetLockFlag(2, 1)
    local tasks = {
        { "Khãa Søc lùc", "WashTwoLockStr2"; show = 1 },
        { "Khãa ThÓ chÊt", "WashTwoLockCon2"; show = 1 },
        { "Khãa Ngé tÝnh", "WashTwoLockInt2"; show = 1 },
    }
    SayTask("Ng­¬i ®· khãa Th©n ph¸p, xin chän thuéc tÝnh thø hai muèn khãa!", tasks)
end

function WashTwoLockCon1()
    SetLockFlag(3, 1)
    local tasks = {
        { "Khãa Søc lùc", "WashTwoLockStr2"; show = 1 },
        { "Khãa Th©n ph¸p", "WashTwoLockDex2"; show = 1 },
        { "Khãa Ngé tÝnh", "WashTwoLockInt2"; show = 1 },
    }
    SayTask("Ng­¬i ®· khãa ThÓ chÊt, xin chän thuéc tÝnh thø hai muèn khãa!", tasks)
end

function WashTwoLockInt1()
    SetLockFlag(4, 1)
    local tasks = {
        { "Khãa Søc lùc", "WashTwoLockStr2"; show = 1 },
        { "Khãa Th©n ph¸p", "WashTwoLockDex2"; show = 1 },
        { "Khãa ThÓ chÊt", "WashTwoLockCon2"; show = 1 },
    }
    SayTask("Ng­¬i ®· khãa Ngé tÝnh, xin chän thuéc tÝnh thø hai muèn khãa!", tasks)
end

function WashTwoLockStr2()
    SetLockFlag(1, 1)
    local sLock, sUnLock = GetLockAttribString()

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[3].IBCostIdx)
    MsgBox("Ng­¬i hiÖn t¹i ®· khãa" .. sLock .. ", ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶Ô" .. sUnLock .. "ph©n bæ l¹ kh«ng? ", "DoWashTwo", "WashSelect")

end

function WashTwoLockDex2()
    SetLockFlag(2, 1)
    local sLock, sUnLock = GetLockAttribString()

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("Ng­¬i hiÖn t¹i ®· khãa" .. sLock .. ", ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶Ô" .. sUnLock .. "ph©n bæ l¹ kh«ng? ", "DoWashTwo", "WashSelect")

end

function WashTwoLockCon2()
    SetLockFlag(3, 1)
    local sLock, sUnLock = GetLockAttribString()

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("Ng­¬i hiÖn t¹i ®· khãa" .. sLock .. ", ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶Ô" .. sUnLock .. "ph©n bæ l¹ kh«ng? ", "DoWashTwo", "WashSelect")

end

function WashTwoLockInt2()
    SetLockFlag(4, 1)
    local sLock, sUnLock = GetLockAttribString()

    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(WashPointNeed[2].IBCostIdx)
    MsgBox("Ng­¬i hiÖn t¹i ®· khãa" .. sLock .. ", ®ång ý tiªu phÝ <c=g>" .. costDisNum .. "<c> Th«ng B¶o¶Ô" .. sUnLock .. "ph©n bæ l¹ kh«ng? ", "DoWashTwo", "WashSelect")

end

function DoWashTwo()
    CloseDialog()
    if (CheckIB(3) == 0) then
        MsgBox(" Th«ng B¶o cña ng­¬i kh«ng ®ñ!", "no")
        return
    end

    WashPoint()

    CostIB(3)

    MsgBox("LÇn nµy ®· ph©n phèi l¹i ®iÓm tiÒm n¨ng nh­ sau:<enter>Søc lùc:" .. GetAssignedAttrib(0) .. "<enter>Th©n ph¸p:" .. GetAssignedAttrib(1) .. "<enter>ThÓ chÊt:" .. GetAssignedAttrib(2) .. "<enter>Ngé tÝnh:" .. GetAssignedAttrib(3) .. "<enter>Ng­¬i x¸c ®Þnh muèn tÈy ®iÓm tiÒm n¨ng?", "DoWashTwo", "WashSelect")
end

function no()
    CloseDialog()
end

function WashPoint()
    local AllPoint = 0
    local i = 0
    local AttribCount = 0

    for i = 1, 4 do
        if (GetLockFlag(i) == 0) then
            AllPoint = AllPoint + GetAssignedAttrib(i - 1)
            AttribCount = AttribCount + 1
        end
    end

    if (AllPoint == 0) then

        return
    end

    local KeepPoint = { 0, 0, 0, 0 }
    for i = 1, 4 do
        KeepPoint[i] = GetAssignedAttrib(i - 1)
        ClearAssignedAttrib(i - 1)
    end

    for j = 1, AllPoint do

        local AllocAttrIdx = math.random(1, AttribCount)
        local CurAttrIdx = 1

        for i = 1, 4 do
            if (GetLockFlag(i) == 0) then
                if (CurAttrIdx == AllocAttrIdx) then
                    AddAssignedAttrib(i - 1, 1)
                    break
                end
                CurAttrIdx = CurAttrIdx + 1
            end
        end
    end

    for i = 1, 4 do
        if (GetLockFlag(i) == 1) then
            AddAssignedAttrib(i - 1, KeepPoint[i])
        end
    end

    ApplyAssignedAttrib()
    local shuxing = { "Søc m¹nh", "Th©n ph¸p", "ThÓ chÊt", "Linh ho¹t", }
    local shuxingstr = ""
    for i = 1, 4 do
        shuxingstr = shuxingstr .. shuxing[i] .. GetAssignedAttrib(i - 1)
    end
    WriteLog("[ÖØÖÃÇ±ÄÜ]" .. shuxingstr)
end
