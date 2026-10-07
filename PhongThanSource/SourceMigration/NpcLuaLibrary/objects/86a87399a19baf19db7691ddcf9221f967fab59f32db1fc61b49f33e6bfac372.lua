--description: Ò©µê-Ò©¢»ºØÊÛÉÌ
--author: yichuan
--date: 2004/6/10

Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚÐÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈýÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂÞÓã¶Ô»° 10Óë¾Þ¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ðÀëÐ¡Ñý£¬14µÃµ½»ê²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ðÀë¾«ÆÇ

--2byte: 1½Óµ½¹ý³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ýÈýÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ý»ðÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ý±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ðÀëÐ¡ÑýµÄÊýÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊýÄ¿

--AS GaoJingwei 2009/08/02
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

    --»ðÀë¾«ÆÇ
    startLevel = 41
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_Variety_Process, 2) == 3 and step == 13) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_Variety_Process, 2) == 3 and step == 13) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´ÌÌ½Çé±¨ luoyixuan
    startLevel = 30
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(314) == 27 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
                state = 3
                subState = 0
            end
        else
            if (GetTask(314) == 27 and GetTask(916) == 0 and GetTaskByte(317, 2) == 0) then
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

    tasks = {
        { "Hiªn Viªn ThÝ luyÖn", "shitu"; show = 0 }
    }
    if (GetTask(901) == 1) then
        tasks[1].show = 1;
        SayTask(11470, tasks)
    else
        if (GetTask(304) == 27) then
            Talk(1, "no", 11441)
            SetTask(304, 100)
            TaskNote(31, 0)
        elseif (GetTask(314) == 27) then
            Talk(1, "no", 11497)
            SetTask(314, 100)
            TaskNote(33, 0)
            refreshNpcTaskState()
        elseif (GetTaskByte(Task_Variety_Process, 1) == 13) then
            FireSoul()
        else
            MsgBox(10322, "yes", "no")
        end ;
    end


end;

function FireSoul()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "Kh«ng gian trªn hµnh trang cña ng­¬i kh«ng ®ñ, kh«ng thÓ nhËn vËt phÈm nhiÖm vô!")
        return
    end
    Talk(2, "no", GetName() .. " <c=g>Chóc Dung<c> nhê t¹i h¹ ®i t×m tung tÝch <c=yel>Háa Linh<c>, nh­ng c¸i bän L·o Hå l« quyÕt t©m kh«ng tiÕt lé bÝ mËt. Tiªn sinh cã ph­¬ng ph¸p g× kh«ng?", "§©y lµ <c=yel>Hån B¹ch<c>, ®Õn chç bän L·o Hå l« më ra, cã thÓ biÕt ®­îc manh mèi Háa Linh. Lóc sö dông cã thÓ ®Õn gÇn bän L·o Hå l«, nh­ng ph¶i coi chõng bÞ chóng ph¸t hiÖn")
    AddNormalItem(6, 1, 486, 1, 0, 0)
    Msg2Player("B¹n nhËn ®­îc Hån B¹ch")
    SetTaskByte(Task_Variety_Process, 1, 14)
    TaskNote(1046, 3)
    refreshNpcTaskState()
end

function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = 0
    if (GetTeam() ~= 0) then
        -- ÓÐ¶ÓÎé
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            mark = IsMasterPRRelation(n)

            if (mark == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = 0
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function shitu()
    local mark = judge_relation()
    if (mark == 1) then
        if (HaveIBBuff(216) ~= 0) then
            RestoreLife()
            RestoreMana()
            SetTask(901, 2)
            TaskNote(45, 0)
            MsgBox(11498, "no")
            refreshNpcTaskState()
        else
            MsgBox(11458, "no")
        end
    else
        MsgBox(11459, "no")
    end
end

function yes()
    CloseDialog()
    Sale(15);
end;

function no()
    CloseDialog()
end;
