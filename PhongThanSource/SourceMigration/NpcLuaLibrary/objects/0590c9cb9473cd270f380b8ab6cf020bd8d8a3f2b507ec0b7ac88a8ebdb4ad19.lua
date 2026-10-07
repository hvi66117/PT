--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

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

    --Ç§ÄêÖ®Áµ
    startLevel = 85
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 80) or (taskWizard == 80) or (taskDruid == 80)) and (HaveEventItem(9) == 1) then
                state = 1
                subState = 0
            elseif ((taskKnight == 81) or (taskKnight == 82) or (taskWizard == 81) or (taskWizard == 82) or (taskDruid == 81) or (taskDruid == 82)) and (HaveEventItem(175) == 1) then
                state = 3
                subState = 0
            elseif ((taskKnight == 81) or (taskKnight == 82) or (taskWizard == 81) or (taskWizard == 82) or (taskDruid == 81) or (taskDruid == 82)) then
                state = 2
                subState = 0
            end
        else
            if ((taskKnight == 80) or (taskWizard == 80) or (taskDruid == 80)) and (HaveEventItem(9) == 1) then
                state = 1
                subState = 1
            elseif ((taskKnight == 81) or (taskKnight == 82) or (taskWizard == 81) or (taskWizard == 82) or (taskDruid == 81) or (taskDruid == 82)) and (HaveEventItem(175) == 1) then
                state = 3
                subState = 1
            elseif ((taskKnight == 81) or (taskKnight == 82) or (taskWizard == 81) or (taskWizard == 82) or (taskDruid == 81) or (taskDruid == 82)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --·å»ØÂ·×ª
    startLevel = 100
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 93) or (taskWizard == 93) or (taskDruid == 93) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 93) or (taskWizard == 93) or (taskDruid == 93) then
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
        { "Thiªn Duyªn", "renwu1"; show = 0 },
        { "Phong Håi Lé ChuyÓn", "renwu100"; show = 0 },
        { "§Õn Diªu Tr×", "renwu2"; show = 1 },
    }
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (GetLevel() >= 85) and (HaveEventItem(9) == 1) then

        if (GetPlayerType() == 0) and (UTask_Knight == 80) then

            tasks[1].show = 1

        elseif (GetPlayerType() == 1) and (UTask_Wizard == 80) then

            tasks[1].show = 1

        elseif (GetPlayerType() == 2) and (UTask_Druid == 80) then

            tasks[1].show = 1

        end ;
    end
    if ((UTask_Knight == 81) or (UTask_Wizard == 81) or (UTask_Druid == 81) or (UTask_Knight == 82) or (UTask_Wizard == 82) or (UTask_Druid == 82)) and (HaveEventItem(175) == 1) then

        tasks[1].show = 1

    end ;

    if (UTask_Knight == 93) or (UTask_Wizard == 93) or (UTask_Druid == 93) then
        tasks[2].show = 1
    end
    SayTask(10377, tasks)
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
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (mark == 1) then
        if (UTask_Knight == 80) or (UTask_Wizard == 80) or (UTask_Druid == 80) and (HaveEventItem(9) == 1) then
            Talk(2, "renwu3", 10378, 10379)
        end
        if ((UTask_Knight == 81) or (UTask_Wizard == 81) or (UTask_Druid == 81) or (UTask_Knight == 82) or (UTask_Wizard == 82) or (UTask_Druid == 82)) and (HaveEventItem(175) == 1) then

            renwu5()

        end
    else
        Talk(1, "no", 11718)
    end
end;

function renwu2()
    local i = random(1, 3)
    if (i == 1) then
        NewWorld(52, 1541, 3190)
    end ;
    if (i == 2) then
        NewWorld(52, 1556, 3202)
    end ;
    if (i == 3) then
        NewWorld(52, 1540, 3205)
    end ;
    SetFightState(0)
    CloseDialog()
end;

function no()
    CloseDialog()
end;

function renwu3()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)
    if (GetLevel() >= 85) and (HaveEventItem(9) == 1) then
        if (UTask_Wizard == 80) or (UTask_Druid == 80) or (UTask_Knight == 80) then

            Talk(2, "renwu4", 13817, "Tuy n¨ng lùc cã h¹n, nh­ng ta sÏ cè g¾ng gióp tû!")

        end
    end
end

function renwu4()

    Talk(2, "no", 13818, "ChuyÖn  nhá th«i! Ta sÏ sím mang nã vÒ!")
    Msg2Player("Giao Phong ThÇn b¶ng thËt cho §¾t Kû")
    DelEventItem(9)
    if (GetPlayerType() == 2) then
        Msg2Player("§i t×m Bµn Cæ ThÇn KhÝ")
        SetTask(2, 81)
        TaskNote(29, 31)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (GetPlayerType() == 1) then
        Msg2Player("§i t×m Bµn Cæ ThÇn KhÝ")
        SetTask(1, 81)
        TaskNote(28, 36)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (GetPlayerType() == 0) then
        Msg2Player("§i t×m Bµn Cæ ThÇn KhÝ")
        SetTask(3, 81)
        TaskNote(27, 32)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;
function renwu5()
    Say(13819, 3, { "Giµy/sel", "Yªu ®¸i/sel", "M·o/sel" })


end

function sel(j)

    if (GetPlayerType() == 0) then
        AddNormalItem2(0, 5 + j, 6, 8, 1, 0)

    elseif (GetPlayerType() == 1) then
        AddNormalItem2(0, 5 + j, 7, 8, 1, 0)

    elseif (GetPlayerType() == 2) then
        AddNormalItem2(0, 5 + j, 8, 8, 1, 0)
    end ;
    DelEventItem(175)
    AddOwnExp(6500000)
    Msg2Player("NhËn ®­îc trang bÞ cÊp 80 vµ 650 v¹n ®iÓm kinh nghiÖm.")
    TopMessage(13820)
    if (GetPlayerType() == 2) then

        SetTask(2, 83)
        TaskNote(29, 32)

    elseif (GetPlayerType() == 1) then

        SetTask(1, 83)
        TaskNote(28, 37)
    elseif (GetPlayerType() == 0) then

        SetTask(3, 83)
        TaskNote(27, 33)

    end ;
    CloseDialog()
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function renwu100()
    CloseDialog()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (UTask_Knight == 93) or (UTask_Wizard == 93) or (UTask_Druid == 93) then
        Talk(2, "no", "Rèt cuéc Th­îng ca còng ®· ®Õn ®©y t×m ta. Ng­¬i còng ®· nghe vÒ sù t×nh cña Phong ThÇn b¶ng?...giê ta ph¶i lµm g× ®©y?...", "LÇn nµy ®· ®Õn Tiªn Ma giíi t×m Phong ThÇn b¶ng, hy väng Th­îng ca sÏ kh«ng hiÓu lÇm ta!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 94)
            TaskNote(27, 38)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        elseif (pt == 1) then
            SetTask(1, 94)
            TaskNote(28, 42)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728

        else
            SetTask(2, 94)
            TaskNote(29, 37)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728

        end ;
    end
end