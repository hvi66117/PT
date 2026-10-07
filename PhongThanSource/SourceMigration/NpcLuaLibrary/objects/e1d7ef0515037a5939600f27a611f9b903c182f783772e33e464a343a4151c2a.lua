Task_star = 1417

Task_collect = 1418

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

    startLevel = 37
    if (GetLevel() >= startLevel) then
        local collect1 = GetTaskByte(Task_collect, 1)
        local collect2 = GetTaskByte(Task_collect, 2)
        local collect3 = GetTaskByte(Task_collect, 3)
        local collect4 = GetTaskByte(Task_collect, 4)
        local ShahunNum = GetTaskByte(Task_star, 2)
        if (GetLevel() - startLevel <= 5) then
            if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
                state = 3
                subState = 0

            elseif (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and GetLevel() >= 37) then
                state = 2
                subState = 0
            end
        else
            if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and GetLevel() >= 37) then
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

    if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
        Talk(2, "no", "QuØ tµ yªu nh©n:To gan, ng­¬i d¸m ®Õn ng¨n c¶n l·o phu ®é kiÕp, nÕu kh«ng ph¶i ®ang lµ thêi kh¾c quan träng, ta sÏ biÕn ng­¬i thµnh m©y khãi.", GetName() .. ":Ph¸p lùc cña ta ®ang c¹n kiÖt, ta sÏ ®i t×m Tinh Quan xin Ph¸p b¶o ®Õn ®èi phã ng­¬i, ®îi quay vÒ sÏ ®Êu víi ng­¬i 300 hiÖp.")
        SetTaskByte(Task_star, 1, 3)
        TaskNote(1059, 2)
        refreshNpcTaskState()
        return
    end

    local collect1 = GetTaskByte(Task_collect, 1)
    local collect2 = GetTaskByte(Task_collect, 2)
    local collect3 = GetTaskByte(Task_collect, 3)
    local collect4 = GetTaskByte(Task_collect, 4)
    local ShahunNum = GetTaskByte(Task_star, 2)
    if (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
        PlayerCastSkill(1, 223, 1)
        Talk(2, "no", "TiÓu bèi to gan d¸m ph¸ ho¹i ®¹i sù cña ta, l·o phu sÏ phanh th©y ng­¬i thµnh tr¨m m¶nh…………..", GetName() .. ":§¸ng tiÕc, ®· ®Ó cho nguyªn thÇn cña h¾n ch¹y tho¸t, chØ cßn l¹i nhôc thÓ. Mau b¸o tin cho Tinh Quan.")
        SetTaskByte(Task_star, 1, 6)
        ClearItem(6, 1, 511, 0)
        TaskNote(1059, 8)
        refreshNpcTaskState()
        return
    end

    if (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and (collect1 ~= 1 or collect2 ~= 1 or collect3 ~= 1 or collect4 ~= 1 or ShahunNum < 1) and GetLevel() >= 37) then
        Talk(1, "no", "QuØ tµ yªu nh©n:To gan, ng­¬i d¸m ®Õn ng¨n c¶n l·o phu ®é kiÕp, nÕu kh«ng ph¶i ®ang lµ thêi kh¾c quan träng, ta sÏ biÕn ng­¬i thµnh m©y khãi.")
        return
    end

end

function no()
    CloseDialog()
end;
