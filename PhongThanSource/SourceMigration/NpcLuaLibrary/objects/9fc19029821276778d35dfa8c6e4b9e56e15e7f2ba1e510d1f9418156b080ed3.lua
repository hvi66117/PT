--description: ÎâÁú-Òì?Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/13

-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --¾Æ²»×íÈË
    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 11) then
                state = 3
                subState = 0
            elseif (taskProcess == 13) and (HaveEventItem(16) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 13) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 11) then
                state = 3
                subState = 1
            elseif (taskProcess == 13) and (HaveEventItem(16) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 13) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    tasks = {
        { "BÊt Tóy", "renwu1"; show = 0 }
    }
    UTask_Druid = GetTask(2);
    if (GetPlayerType() == 2) and (UTask_Druid == 11) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 35) and (UTask_Druid == 13) and (HaveEventItem(16) >= 1) then
        tasks[1].show = 1;
    end ;
    SayTask(10354, tasks)
end;

function renwu1()
    UTask_Druid = GetTask(2);
    if (GetPlayerType() == 2) and (UTask_Druid == 11) then
        Talk(4, "no", 10355, 10356, 10357, 10358)
        SetTask(2, 12)
        Msg2Player("Mau ®Õn töu ®iÕm trong TriÒu Ca ®Ó mua canh tØnh r­îu!")
        TaskNote(29, 4)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    local xingjiu = HaveEventItem(16)
    if (GetLevel() >= 35) and (UTask_Druid == 13) and (xingjiu >= 1) then
        Talk(3, "no", 10359, 10360, 10361)
        for i = 1, xingjiu do
            DelEventItem(16)
        end

        AddNormalItem(7, 59, 128, 1, 0, 0)
        AddOwnExp(80000)
        Msg2Player("Cøu ®­îc Ng« Long, nhËn s¸ch Ban M«n Léng Phñ vµ 80000 kinh nghiÖm")
        TopMessage(11939)
        SetTask(2, 20)
        TaskNote(29, 6)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function no()
    CloseDialog()
end;
