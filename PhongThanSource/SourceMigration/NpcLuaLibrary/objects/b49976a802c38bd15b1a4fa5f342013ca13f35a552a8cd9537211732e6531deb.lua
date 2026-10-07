Task_hetu = 1387

Hetu_playerID = 1388
Global_longmashui = 185
Global_longmahuo = 186
Global_longmamu = 187
Global_longmajin = 188

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

    startLevel = 28
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
                state = 3
                subState = 0
            end
        else
            if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
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
        if (COMMON.sendMsg_npc("Ng­êi Huynh §Ö h¸i thuèc") == 1) then
            return 0
        end
    end

    local tasks = {
        { "Hµ §å HuyÒn C¶nh", "hetu"; show = 0 },
    }

    if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
        tasks[1].show = 1
    end

    SayTask(GetName() .. " …… h¾n 1 lêi còng kh«ng nãi.", tasks)
end

function hetu()

    CloseDialog()

    if (GetPlayerExtLevel() >= 28 and GetTaskByte(Task_hetu, 1) == 5) then
        Talk(1, "no", "Lµ ng­êi anh em cña ta nhê ng­¬i ®Õn cøu ta? Ta t­ëng r»ng sÏ ph¶i chÕt tr«ng ®Êy råi, nay ®· ®­îc cøu thËt kh«ng biÕt c¶m t¹ thÕ nµo.")
        local addexp = AddOwnExtendExp(500000)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addexp .. "<c> tu luyÖn")
        Msg2Player("Hoµn thµnh Hµ §å Hoang C¶nh, nhËn ®­îc " .. addexp .. " ®iÓm tu luyÖn!")

        ClearItem(6, 1, 484, 0)
        ClearItem(6, 1, 485, 0)
        TaskNote(1043, -1)
        SetTaskByte(Task_hetu, 1, 6)
        SetSubTask(1043, -1, 1)

        refreshNpcTaskState()

    end
end

function no()
    CloseDialog()
end;
