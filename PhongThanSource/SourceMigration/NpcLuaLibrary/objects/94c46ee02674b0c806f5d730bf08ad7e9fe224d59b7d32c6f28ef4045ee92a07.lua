Task_Divination = 1375

Task_Label_Type = 1376
Buff_Make_Drug = 636
Buff_Add_Life = 635
Buff_Polymorph = 404
Buff_Plutus = 228
Task_Num = 1039

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

    local startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(11)
            if (taskProcess == 1) or (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) or (taskProcess == 3) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(11)
            if (taskProcess == 1) or (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) or (taskProcess == 3) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 27
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Divination, 1)
        local labelType = GetTaskByte(Task_Label_Type, 1)
        if (GetLevel() - startLevel <= 5) then
            if (labelType == 2 and step == 7) then
                state = 3
                subState = 0
            elseif (labelType == 2 and step == 7 and HaveNormalItem(1, 0, 0, 1) >= 10) then
                state = 3
                substate = 0
            elseif (labelType == 2 and step == 7 and HaveNormalItem(1, 0, 0, 1) < 10) then
                state = 2
                substate = 0
            end
        else
            if (labelType == 2 and step == 7) then
                state = 3
                subState = 1
            elseif (labelType == 2 and step == 7 and HaveNormalItem(1, 0, 0, 1) >= 10) then
                state = 3
                substate = 1
            elseif (labelType == 2 and step == 7 and HaveNormalItem(1, 0, 0, 1) < 10) then
                state = 2
                substate = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 22
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 12) == 1 and GetTaskBit(Task_NotDieLamp, 13) == 0) then
                state = 3
                subState = 0
            end
        else
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 12) == 1 and GetTaskBit(Task_NotDieLamp, 13) == 0) then
                state = 3
                subState = 1
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
    tasks = {
        { "<c=yel>Ngò ThÊt<c>", "renwu1"; show = 0 },
        { "<c=yel>BÊt DiÖt §¨ng<c>", "getRenJianFire"; show = 0 },
        { "<c=yel>VÊn MÖnh Chi Thiªm<c>", "divination"; show = 0 }
    }

    if (isViewNotDieLamp() == 1) then
        tasks[2].show = 1
    end

    UTask_01 = GetTask(11);
    if (UTask_01 == 1 or UTask_01 == 2) then
        tasks[1].show = 1;
    end ;

    local step = GetTaskByte(Task_Divination, 1)
    local labelType = GetTaskByte(Task_Label_Type, 1)
    if (labelType == 2 and step == 7) then
        tasks[3].show = 1
    end
    SayTask(11401, tasks)
end;

function divination()
    CloseDialog()
    local step = GetTaskByte(Task_Divination, 1)
    local labelType = GetTaskByte(Task_Label_Type, 1)
    if (labelType == 2 and step == 7) then
        MsgBox("Ta bÞ Tiªn thó c¾n, ng­¬i cã thÓ ®em ®Õn cho ta 10 <c=r>TiÓu Hång ®¬n<c> kh«ng?", "yes_divination", "no")
    end
end

function yes_divination()
    CloseDialog()
    local step = GetTaskByte(Task_Divination, 1)
    local labelType = GetTaskByte(Task_Label_Type, 1)
    TaskNote(Task_Num, 8)
    if (labelType == 2 and step == 7) then
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "Tr¹ng th¸i hiÖn t¹i cña ng­¬i qu¸ nhiÒu, h·y gi¶i bá 1 vµi tr¹ng th¸i h·y quay l¹i tiÕp tôc nhiÖm vô ®i.")
            return
        end

        if (HaveNormalItem(1, 0, 0, 1) >= 10) then
            for i = 1, 10 do
                DelNormalItem(1, 0, 0, 1)
            end
            SetTaskByte(Task_Divination, 1, 8)
            refreshNpcTaskState()
            AddIBBuff(Buff_Add_Life)
            Talk(1, "no", "C¶m t¹ anh hïng ra tay t­¬ng trî, ®Ó c¶m t¹ ta tÆng ng­êi tr¹ng th¸i Hé T¸ trong 1 giê, h·y tËn dông nã.")
            TaskNote(Task_Num, -1)
        else
            Talk(1, "no", "Ng­¬i ®em kh«ng ®ñ sè <c=r>TiÓu Hång ®¬n<c>.")
            Msg2Player("Kh«ng ®ñ TiÓu Hång ®¬n")
        end
    end
end

Task_NotDieLamp = 1332

function isViewNotDieLamp()

    local nTaskState = GetByte(GetTask(Task_NotDieLamp), 1)
    local nSanMeiFire = GetTaskBit(Task_NotDieLamp, 12)
    local nRenJianFire = GetTaskBit(Task_NotDieLamp, 13)

    if (GetPlayerExtLevel() < 22) then
        return 0
    end
    if (nTaskState ~= 2) then
        return 0
    end

    if (nSanMeiFire == 0) then
        return 0
    end

    if (nRenJianFire == 1) then
        return 0
    end

    return 1
end

function getRenJianFire()
    if (HaveIBBuff(534) == 0) then
        Talk(1, "no", "Thêi gian ®· hÕt, Liªn täa ®· hÐo óa, ta còng bã tay th«i! Hay lµ ®i t×m <c=g>Liªn §¨ng Hé sø<c> hái xem cã c¸ch g× kh«ng?")

        refreshNpcTaskState()

        return
    end

    local nRenJianFire = GetTaskBit(Task_NotDieLamp, 13)
    if (nRenJianFire == 1) then
        Talk(1, "no", "Ng­¬i ®· cã ®­îc Nh©n Gian Háa, mau t×m <c=g>Liªn §¨ng Hé sø<c>.")
        return
    end

    if (isViewNotDieLamp() ~= 1) then
        Talk(1, "no", " LÏ ra ng­¬i kh«ng nªn ®Õn t×m ta!")
        return
    end

    AddNormalItem(3, 347, 0, 0, 0, 0)
    TopMessage("NhËn ®­îc <c=g>Nh©n Gian Háa<c>")
    Msg2Player("NhËn ®­îc Nh©n Gian Háa, cã thÓ vÒ gÆp Liªn §¨ng Hé sø.")
    SetTaskBit(Task_NotDieLamp, 13, 1)
    refreshNpcTaskState()
    Talk(1, "no", " <c=g>Nh©n Gian Háa<c> nµy thËt ra kh«ng ph¶i lµ quý hiÕm l¾m, ta tÆng cho ng­¬i ®©y. Giê h·y ®i gÆp <c=g>Liªn §¨ng Hé sø<c> ®i. Liªn ®¨ng s¾p hÐo óa råi!")
    TaskNote(96, 6)

    refreshNpcTaskState()

end

function renwu1()
    UTask_01 = GetTask(11);
    if (UTask_01 == 1) then
        SetTask(11, 3)
        refreshNpcTaskState()
        TaskNote(2, 2)
    elseif (UTask_01 == 2) then
        SetTask(11, 4)
        refreshNpcTaskState()
        TaskNote(2, 3)
    end
    AddOwnExp(50)
    AddEventItem(20)
    TopMessage(12149)
    Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm vµ Háa Th¹ch.")
    Talk(1, "no", 10527)

    refreshNpcTaskState()

end

function no()
    CloseDialog()
end;
