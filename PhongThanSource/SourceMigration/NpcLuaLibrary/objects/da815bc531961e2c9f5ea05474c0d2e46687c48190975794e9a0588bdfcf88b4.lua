--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ýº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ý4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ý6ÕÒ·ç²®Í¼ÌÚ£©

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
    local startLevel = 10

    --Â÷Ìì¹ýº£
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 2) and (HaveEventItem(235) > 0) and (HaveEventItem(236) > 0) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 2) and (HaveEventItem(235) > 0) and (HaveEventItem(236) > 0) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(314) == 11 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 11 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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

function main(sel)
    if (GetTask(304) == 11) then
        Talk(1, "no", 11441)
        SetTask(304, 100)
        TaskNote(31, 0)
    elseif (GetTask(314) == 11) then
        Talk(1, "no", 11567)
        SetTask(314, 100)
        TaskNote(33, 0)
        refreshNpcTaskState()
    elseif (GetTaskByte(Task_newer13, 1) == 2) then
        if (HaveEventItem(235) > 0) and (HaveEventItem(236) > 0) then
            MsgBox(" LuyÖn chÕ ®¬n d­îc ph¶i sö dông Tam Muéi Ch©n Háa, tiÓu anh hïng cÈn thËn coi chõng bÞ löa ®èt", "yes_fire", "no")
        else
            Talk(1, "no", "N­íc m¾t vµ má cña ng­¬i ®©u, h·y thu thËp ®ñ ®õng ®Ó bÞ mÊt n÷a!")
            SetTaskByte(Task_newer13, 1, 1)
            Msg2Player("Ng­¬i ph¶i ®em má Cuång §iÓu vµ n­íc m¾t Lôc Qu¸i cho ¶i Du Hån §¹i phu míi cã thÓ luyÖn chÕ b¶o ®¬n.")
            TaskNote(205, 0)
        end
    else
        MsgBox(10322, "yes", "no")
    end ;
end;

function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;

function yes_fire()
    CloseDialog()
    PlayerCastSkill(1, 225, 1)
    DelEventItem(235)
    DelEventItem(236)
    AddEventItem(237)
    SetTaskByte(Task_newer13, 1, 3)
    TaskNote(205, 2)
    Msg2Player("NhËn ®­îc Thiªn Niªn B¶o T©n §an, ®em b¶o ®an cho Tr­¬ng Thiªn Qu©n.")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
