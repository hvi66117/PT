Task_id = 1358;

Buff_id = 626;
Idx_danfang = 1360;
ID_danfang = 1361;

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

    startLevel = 42
    if (GetPlayerExtLevel() >= startLevel) then
        local status = GetTaskByte(Task_id, 1)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (status == 0) then
                state = 1
                subState = 0
            elseif (status == 5) then
                state = 3
                subState = 0
            elseif ((status >= 1) and (status <= 3)) then
                state = 2
                subState = 0
            end
        else
            if (status == 0) then
                state = 1
                subState = 1
            elseif (status == 5) then
                state = 3
                subState = 1
            elseif ((status >= 1) and (status <= 3)) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 43
    if (GetPlayerExtLevel() >= startLevel) then
        local status = GetTaskByte(Task_id, 1)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (status == 5) then
                state = 1
                subState = 0

            end
        else
            if (status == 0) then
                state = 1
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
        { "Thiªn Hµnh ThuËn NghÞch", "lingqutx"; show = 0 },
        { "Hñy bá Thiªn Hµnh ThuËn NghÞch.", "quxiaotx"; show = 0 },
    }
    local status = GetTaskByte(Task_id, 1)

    if ((GetPlayerExtLevel() >= 42) and (status < 12)) then

        if (status <= 5) then
            tasks[1].show = 1
        end

        if (GetPlayerExtLevel() >= 43) then
            if ((status >= 6) and (status <= 11)) then
                tasks[2].show = 1
            end
        end

        SayTask("Ta ®· ®¾c ®¹o thµnh tiªn, duy tr× thiªn trô chu toµn t¹i ®©y, tiÕc r»ng Céng C«ng thÇn lùc v« song, BÊt Chu S¬n bÞ h¾n ph¸ ®ç, thiªn ®Õ gi¸ng téi ta ®µnh ph¶i l­u l¹i t¹i ®©y tu phôc!", tasks)

    else
        Talk(1, "no", "Ta ®· ®¾c ®¹o thµnh tiªn, duy tr× thiªn trô chu toµn t¹i ®©y, tiÕc r»ng Céng C«ng thÇn lùc v« song, BÊt Chu S¬n bÞ h¾n ph¸ ®ç, thiªn ®Õ gi¸ng téi ta ®µnh ph¶i l­u l¹i t¹i ®©y tu phôc!")
    end
end;

function lingqutx()
    CloseDialog()
    local status = GetTaskByte(Task_id, 1)
    if (status == 0) then
        MsgBox("Néi luyÖn tr­êng sinh cöu thÕ chi ®¹o, nghÞch c¶i thiªn mÖnh, ®Ó cÇu tån, ngo¹i tu hµnh tÝch thiÖn chi ®¹o, thuËn thiªn ý, thùc chÊt cÇu ch©n. Ng­¬i cã muèn häc ®¬n ®¹o nµy?", "tianxing", "no")
    elseif ((status >= 1) and (status <= 3)) then
        Talk(1, "no", "LuyÖn ®¬n lµ viÖc nhÊt thiÕt ®èi víi ng­êi tu ®¹o, ng­¬i luyÖn ®¬n xong h·y vÒ t×m ta.")
    elseif (status == 4) then
        Talk(1, "no", "Ng­¬i ®· hoµn thµnh ngo¹i c«ng, nªn néi luyÖn, lß ®¬n nµy thµnh råi nh­ng vÉn kh«ng ®ñ, c«ng hiÖu lín nhÊt cña VÞ TÕ L­ chÝnh lµ luyÖn <c=g>Hoµng Lé ®¬n<c>.")
        status = status + 1
        SetTaskByte(Task_id, 1, status)

        refreshNpcTaskState()

        lingqutx()
        return
    elseif (status == 5) then
        ClearItem(6, 1, 471, 1)

        if (GetPlayerExtLevel() < 43) then
            Talk(1, "no", "Tu hµnh cña ng­¬i ch­a ®ñ, ®¼ng cÊp tiªn ma ®¹t <c=g>43<c> h·y ®Õn t×m ta.")
            TaskNote(1036, 5)
        else
            MsgBox("Ng­¬i ngo¹i luyÖn ®· hoµn thµnh, cã ý muèn häc Néi LuyÖn Chi §¹o.", "tianxing", "no")
        end

    end
end

function tianxing()
    CloseDialog()
    local status = GetTaskByte(Task_id, 1)

    if (status == 0) then

        if (IsHaveSpaceForTreasure(1) == 0) then
            Talk(1, "no", "Nh»m tr¸nh thÊt tho¸t <c=yel>VÞ TÕ L­<c>, <c=r>h·y ®Ó trèng 1 « trong hµnh trang!")
            return
        end

        SetTaskByte(Task_id, 1, status + 1)
        SetSubTask(1036, 1, 1)
        TaskNote(1036, 0)

        refreshNpcTaskState()

    elseif (status == 5) then

        if (IsHaveSpaceForTreasure(2) == 0) then
            Talk(1, "no", "§Ó tr¸nh thÊt tho¸t <c=yel>Hoµng Lé ®¬n<c> vµ <c=yel>VÞ TÕ L­<c>, <c=r>h·y ®Ó trèng 2 « trong hµnh trang!")
            return
        end

        local idx = GetTask(Idx_danfang)
        if (idx ~= 0) and (GetNpcID(idx) == GetTask(ID_danfang)) then
            DelNpc(idx)
        end

        SetTaskByte(Task_id, 1, status + 1)
        SetTask(Idx_danfang, 0)
        AddNormalItem(6, 1, 472, 1, 0, 1)
        RemoveIBBuff(Buff_id)
        TaskNote(1036, 6)

        refreshNpcTaskState()

    end

    AddNormalItem(6, 1, 471, 1, 0, 1)

    if (status == 0) then
        Talk(1, "no", "Mang <c=g>VÞ TÕ L­<c> nµy ®Õn <c=g>BÊt Chu S¬n<c> sö dông lµ cã thÓ triÖu gäi ra lß luyÖn ®¬n, lóc ®ãn lß luyÖn ®¬n sÏ b¸o ng­¬i ngo¹i luyÖn nh­ thÕ nµo.")
    elseif (status == 5) then
        Talk(1, "no", "Néi luyÖn chÝnh lµ cè b¶n båi nguyªn, nÕu nh­ ng­¬i cã thÓ dïng <c=g>VÞ TÕ L­<c> luyÖn ra <c=g>Hoµng Lé ®¬n<c>, tu hµnh sÏ ®¹t ®Õn 1 tÇng cao míi. Ta trao chóng cho ng­¬i, ra d· ngo¹i sö dông <c=g>VÞ TÕ L­<c>, tù sÏ biÕt sö dông nh­ thÕ nµo.")
    end
end;

function quxiaotx()
    MsgBox("Chí cã gÊp, nÕu nh­ muèn sau nµy luyÖn n÷a, th× kh«ng cÇn thiÕt ph¶i véi vµng nh­ vËy.", "quxiao", "no")
end

function quxiao()
    CloseDialog()
    SetTaskByte(Task_id, 1, 5)
    RemoveIBBuff(Buff_id)
    ClearItem(6, 1, 471, 1)
    ClearItem(6, 1, 472, 1)
    Msg2Player("Hñy bá nhiÖm vô Thiªn Hµnh ThuËn NghÞch, cã thÓ nhËn l¹i tõ S¬n ThÇn H«ng B¸c.")

    refreshNpcTaskState()

end

function no()
    CloseDialog()
end;
