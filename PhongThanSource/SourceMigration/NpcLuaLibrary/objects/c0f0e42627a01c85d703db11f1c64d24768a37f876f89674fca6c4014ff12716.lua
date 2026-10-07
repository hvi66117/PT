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

    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(408) == 10) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(408) == 10) then
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

function main(sel)
    if (GetTask(408) == 10) then
        SetTask(408, 100000)

        refreshNpcTaskState()

        MsgBox("L¹i thªm mét tªn hå ®å, <c=g>" .. GetName() .. "<c>. VÒ b¸o víi <c=g>Thiªn Hïng<c>:Sai ng­¬i ®Õn ®©y lµ quyÕt ®Þnh sai lÇm. Ta sÏ ë l¹i ®Ó chØ dÉn cho nh÷ng ng­êi l¹c lèi, ng­¬i ®õng lo l¾ng cho ta.", "no")
    else
        MsgBox(11209, "yes", "no")
    end
end;

function yes()
    CloseDialog()
    Sale(1);
end;

function no()
    CloseDialog()
end;
