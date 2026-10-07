--description:Àî¾¸-¼×Ê¿Ö÷ÏßÈÎÎñ
--author: yichuan
--date:2004/5/11

sel = 0

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

    --Æú°µÍ¶Ã÷
    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 21) or (taskProcess == 23) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 21) or (taskProcess == 23) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´óÊÆËùÇ÷
    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) or (taskProcess == 11) or (taskProcess == 14) or (taskProcess == 15) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 10) or (taskProcess == 11) or (taskProcess == 14) or (taskProcess == 15) then
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
    strings = {
        "<color=green>" .. GetName() .. "<color>: Kh¶i bÈm ®¹i nh©n, Cöu C«ng lÖnh cho t¹i h¹ ®Õn BÊt Chu Thiªn quan dä th¸m t×nh h×nh. §©y lµ <color=yellow>Th«ng quan lÖnh bµi<color>",
        "Lý TÞnh: MÊy h«m tr­íc x¶y ra ®Þa chÊn, con ®­êng dÉn ®Õn <c=yel>BÊt Chu Thiªn quan<c> ®· bÞ bÞ kÝn, hiÖn giê ch­a thÓ ®i ®­îc!",
        "<color=green>" .. GetName() .. "<color>VËy sao ®©y? T¹i h¹ ®ang cã qu©n t×nh khÈn cÊp cÇn ®Õn BÊt Chu Thiªn quan",
        "H·y ®Õn Phong ThÇn ®µi t×m <c=g>B¸ Gi¸m<c>, phÐp <c=g>Kh«ng Minh ChuyÓn<c> cña «ng ta cã thÓ gióp ®­îc ng­¬i.",
        "<color=green>" .. GetName() .. "<c>:§¹ t¹! T¹i h¹ lËp tøc ®i ngay."
    }
    if (GetTask(597) == 5) and (HaveEventItem(107) >= 1) then
        local sel = GetTask(596) + 1
        tasks = {
            { "Trang kÕ", "main"; show = 0 },
            { "Th«ng hµnh lÖnh", "zusai"; show = 0 }
        }
        if (sel <= 4) then
            tasks[1].show = 1;
        elseif (sel == 5) then
            tasks[2].show = 1;
        end ;
        SayTask(strings[sel], tasks)
        if (sel <= 4) then
            SetTask(596, sel)
        end ;
    else
        main1()
    end ;
end;

function zusai()
    if (GetTask(597) == 5) and (HaveEventItem(107) >= 1) then
        SetTask(597, 6)
        TaskNote(35, 6)
        DelEventItem(107)
        AddCredit(10)--ÉùÍû½±Àø
        AddOwnExp(4000) --¾­Ñé½±Àø
        Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 10 ®iÓm danh väng!")
        TopMessage(13051)
        Msg2Player("§i Phong ThÇn ®µi t×m B¸ Gi¸m.")
        SetTask(596, 0)
    end ;
    CloseDialog()
end;

function main1()
    tasks = {
        { "Khuyªn hµng", "renwu1"; show = 0 },
        { "ThÕ Së", "renwu2"; show = 0 }
    }
    UTask_Knight = GetTask(3);
    UTask_Wizard = GetTask(1);
    if (UTask_Knight == 21) or (UTask_Knight == 23) then
        tasks[1].show = 1;
    end ;
    if (UTask_Wizard == 10) or (UTask_Wizard == 11) or (UTask_Wizard == 14) or (UTask_Wizard == 15) then
        tasks[2].show = 1;
    end ;
    SayTask(10125, tasks)

end;

function renwu1()
    UTask_Knight = GetTask(3);
    if (UTask_Knight == 21) then
        Talk(3, "no", 10126, 10127, 10128)
        Msg2Player("KÞp thêi th«ng b¸o tin tøc cho Lý TÞnh.")
        SetTask(3, UTask_Knight + 1)
        TaskNote(27, 6)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Knight == 23) then
        Talk(3, "no", 10126, 10127, 10128)
        Msg2Player("KÞp thêi th«ng b¸o tin tøc cho Lý TÞnh.")
        SetTask(3, UTask_Knight + 1)
        TaskNote(27, 8)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function renwu2()
    UTask_Wizard = GetTask(1);
    if (UTask_Wizard == 10) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 3)
    elseif (UTask_Wizard == 11) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 6)
    elseif (UTask_Wizard == 14) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 7)
    elseif (UTask_Wizard == 15) then
        Talk(3, "no", 10129, 10130, 10131)
        SetTask(1, UTask_Wizard + 2)
        Msg2Player("Khuyªn Lý TÞnh ®Çu hµng thµnh c«ng")
        TaskNote(28, 9)
    end
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    SetTask(596, 0)
    CloseDialog()
end;

