Task_baichuan = 1364

Tower_Camp = {
    { desc = "Canh Th­¬ng" },
    { desc = "Quú Vò" },
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

    startLevel = 46
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_baichuan, 1) == 3) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_baichuan, 1) == 3) then
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

require("common.luax")
function main()

    if (GetTaskByte(2253, 1) == 1) then
        if (COMMON.sendMsg_npc("Thiªn Nh¹c ngôc tèt") == 1) then
            return 0
        end
    end

    local tasks = {
        { "ChuyÓn tiÕp", "send"; show = 1 }
    }

    SayTask("Thiªn Nh¹c Ngôc Tèt: C¸c vÞ tr­ëng l·o Thiªn Nh¹c Ngò ¢m Täa ®ang vËn hµnh trËn ph¸p, kh«ng thÓ gÆp mÆt, nÕu nh­ ng­¬i muèn gÆp ng­êi cña Thiªn Nh¹c ta cã thÓ chuyÓn ng­¬i lªn trªn.", tasks)
end;

function send()
    CloseDialog()

    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    NewWorld(74, 1930, 3734)
    if (GetPlayerExtLevel() >= 46 and GetTaskByte(Task_baichuan, 1) == 3) then
        TaskNote(1037, 3, Tower_Camp[gdCamp].desc)

        refreshNpcTaskState()

    end
end

function no()
    CloseDialog()
end;

