--description: ¹íÐ°ÑýÈË
--author: liuzhiqiang
--date: 2009/05/04

---------------------ÐÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ÐÇ¹Ù´¦½ÓÐÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìýµ½ËµÃ÷ 3£ºÓë¹íÐ°ÑýÈËµÚÒ»´Î¶Ô»° 4: ÐÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑýÂ¯
--6: »Ùµô¹íÐ°ÑýÈËµÄÁé»ê 7: ÐÇ¹â÷öµ­ÈÎÎñÍê³É 8:ÐÇ¹Ù´¦½Ó³ý¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ð¾ 10: ÐÇ¹Ù´¦¸æÖª¹íÐ°ÑýÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ð¾Ê¹¹íÐ°ÑýÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íÐ°ÑýÈËµÄÔªÉñ 13: Íê³É³ý¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊý
-- 3byte: 1£ºÊÕ¼¯µ½º£ÐÄ²ÝµÄÖÖ×Ó 2: ÖÖÖ²º£ÐÄ²Ý 3£ºµÃµ½Ë®Ð¾

Task_collect = 1418 -- 1byte: 1:ÊÕ¼¯µ½Ë®£» 2byte: 1:ÊÕ¼¯µ½»ð£» 3byte: 1:ÊÕ¼¯µ½·ç£» 4byte:1£ºÊÕ¼¯µ½ÍÁ£»
---------------------ÐÇ¹â÷öµ­-----------------

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

    --ÐÇ¹â÷öµ­
    startLevel = 37
    if (GetLevel() >= startLevel) then
        local collect1 = GetTaskByte(Task_collect, 1)
        local collect2 = GetTaskByte(Task_collect, 2)
        local collect3 = GetTaskByte(Task_collect, 3)
        local collect4 = GetTaskByte(Task_collect, 4)
        local ShahunNum = GetTaskByte(Task_star, 2)
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
                --ÐÇ¹â÷öµ­ÓÅ»¯  Add by  qiufan	2009\11\2     
                state = 3
                subState = 0

            elseif (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and GetLevel() >= 37) then
                state = 2
                subState = 0
            end
        else
            if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
                --ÐÇ¹â÷öµ­ÓÅ»¯  Add by  qiufan	2009\11\2     
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and GetLevel() >= 37) then
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

    if ((GetTaskByte(Task_star, 1) == 2 or GetTaskByte(Task_star, 1) == 1) and GetLevel() >= 37) then
        --ÐÇ¹â÷öµ­ÓÅ»¯  Add by  qiufan	2009\11\2     
        Talk(2, "no", "QuØ tµ yªu nh©n:To gan, ng­¬i d¸m ®Õn ng¨n c¶n l·o phu ®é kiÕp, nÕu kh«ng ph¶i ®ang lµ thêi kh¾c quan träng, ta sÏ biÕn ng­¬i thµnh m©y khãi.", GetName() .. ":Ph¸p lùc cña ta ®ang c¹n kiÖt, ta sÏ ®i t×m Tinh Quan xin Ph¸p b¶o ®Õn ®èi phã ng­¬i, ®îi quay vÒ sÏ ®Êu víi ng­¬i 300 hiÖp.")
        SetTaskByte(Task_star, 1, 3)
        TaskNote(1059, 2)
        refreshNpcTaskState()
        return
    end

    local collect1 = GetTaskByte(Task_collect, 1)
    local collect2 = GetTaskByte(Task_collect, 2)
    local collect3 = GetTaskByte(Task_collect, 3)
    local collect4 = GetTaskByte(Task_collect, 4)
    local ShahunNum = GetTaskByte(Task_star, 2)
    if (GetTaskByte(Task_star, 1) == 5 and collect1 == 1 and collect2 == 1 and collect3 == 1 and collect4 == 1 and ShahunNum >= 1 and GetLevel() >= 37) then
        PlayerCastSkill(1, 223, 1)
        Talk(2, "no", "TiÓu bèi to gan d¸m ph¸ ho¹i ®¹i sù cña ta, l·o phu sÏ phanh th©y ng­¬i thµnh tr¨m m¶nh…………..", GetName() .. ":§¸ng tiÕc, ®· ®Ó cho nguyªn thÇn cña h¾n ch¹y tho¸t, chØ cßn l¹i nhôc thÓ. Mau b¸o tin cho Tinh Quan.")
        SetTaskByte(Task_star, 1, 6)
        ClearItem(6, 1, 511, 0) --É¾³ýÁ¶Ñýºø
        TaskNote(1059, 8)
        refreshNpcTaskState()
        return
    end

    if (GetTaskByte(Task_star, 1) >= 3 and GetTaskByte(Task_star, 1) <= 5 and (collect1 ~= 1 or collect2 ~= 1 or collect3 ~= 1 or collect4 ~= 1 or ShahunNum < 1) and GetLevel() >= 37) then
        Talk(1, "no", "QuØ tµ yªu nh©n:To gan, ng­¬i d¸m ®Õn ng¨n c¶n l·o phu ®é kiÕp, nÕu kh«ng ph¶i ®ang lµ thêi kh¾c quan träng, ta sÏ biÕn ng­¬i thµnh m©y khãi.")
        return
    end

end

function no()
    CloseDialog()
end;
