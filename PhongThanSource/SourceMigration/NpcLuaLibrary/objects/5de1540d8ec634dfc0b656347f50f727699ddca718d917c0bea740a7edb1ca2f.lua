--description: »ÆÁú­â?-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/6/11

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

    --Ì¤ÉÏÕ÷³Ì
    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 0) then
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
        { "Chinh §å", "renwu1"; show = 0 },
        --		{"Îå»ðÆßÇÝ","renwu2";show=0}
    }
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (GetLevel() >= 25) and (UTask_Wizard == 0) then
        tasks[1].show = 1;
    end ;
    --	UTask_01=GetTask(11);
    --	if (UTask_01==1)then
    --			tasks[2].show=1;
    --	end;

    SayTask(10555, tasks)
end;

function fangchenmi()
    --if  it return 0, the 5-hour limit rules executed
    local state
    local mark
    --	if  you don't want this function executed then	you can set state equal to zero
    --		state=0
    --	else
    state = GetWeakState()    --state=0, not in limited time; state=1, in 3 hours-limit; state=2, in 5 hours limit
    --	end
    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu1()
    local mark = fangchenmi()
    if (mark == 1) then
        MsgBox(10556, "yes", "no")                --µÀÊ¿5¼¶?Îñ
    else
        Talk(1, "no", 11718)
    end


end;

function renwu2()
    Talk(1, "no", 10557)
    TaskNote(2, 1)
    Msg2Player("§­îc sù chØ dÉn cña Hoµng Long ch©n nh©n ®i ch©n nói C«n L«n thu thËp B¨ng c¬.")
    SetTask(11, 2)
end;

function yes()
    Talk(1, "no", 10558)
    AddEventItem(0)
    Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bÞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
    SetTask(1, 1)
    TaskNote(28, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;
