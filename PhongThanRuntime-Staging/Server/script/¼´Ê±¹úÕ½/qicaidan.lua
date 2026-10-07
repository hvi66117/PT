TASK_1 = 1076

eggs = {
    [1] = { info = 1080, index = 1081, id = 1082, tim = 1083 },
    [2] = { info = 1407, index = 1408, id = 1409, tim = 1410 },
    [3] = { info = 1411, index = 1412, id = 1413, tim = 1414 }
}

City_Pullulate = {
    [1] = { [1] = 4, [2] = 7, [3] = 9, },
    [2] = { [1] = 6, [2] = 9, [3] = 12, [4] = 14 },
    [3] = { [1] = 8, [2] = 11, [3] = 14, [4] = 17, [5] = 19 },
    [4] = { [1] = 10, [2] = 13, [3] = 16, [4] = 19, [5] = 22, [6] = 24, [7] = 28, },
}

CITY_build = 42
CITY_growth_day = 44
CITY_NOWAR_CARD = 59

function IsGetAnother()
    local taskNum = 0
    for i = 1, 3, 1 do
        if (GetTask(eggs[i].index) == -1) then
            taskNum = i
            break
        end
    end
    return taskNum
end

function IsGetFree()
    local taskNum = 0
    for i = 1, 3, 1 do
        if (GetTask(eggs[i].index) == 0) then
            taskNum = i
            break
        end
    end
    return taskNum
end

function IsOneDis()
    local taskNum = 0
    for i = 1, 3, 1 do
        local npcindex = GetTask(eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 587) or (GetTask(eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(eggs[i].info, 4) == 0) then
                taskNum = i
                break
            end

        end
    end
    return taskNum
end

function IsAttackEggDis()
    local taskNum = 0

    for i = 1, 3, 1 do
        local npcindex = GetTask(eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 587) or (GetTask(eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(eggs[i].info, 4) > 0) then
                taskNum = i
                break
            end

        end
    end
    return taskNum
end

function IsAttackEggOverTime()
    local taskNum = 0
    local H, M, S = GetHMS()

    for i = 1, 3, 1 do
        local npcindex = GetTask(eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 587) or (GetTask(eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(eggs[i].info, 4) > 0) and (IsOverTime() > 0) then
                taskNum = i
                break
            end

        end
    end

    return taskNum
end

function IsOverTime()
    local flag = 0
    local H, M, S = GetHMS()
    if (IsInMonsterAttackDay() == 1) then
        if (H ~= 20) or (H == 20 and M > 39) then
            flag = 1
        end
    elseif (isCounterAttack() > 0) then
        if (H ~= 20) or (H == 20 and M > 29) then
            flag = 1
        end
    end

    return flag
end

function ifExchangeTong()
    if (GetTaskByte(eggs[2].info, 3) ~= (GetOwnCityLevel() + 1)) then
        local oldLevel = GetTaskByte(eggs[2].info, 3)
        local newLevel = GetOwnCityLevel() + 1
        if (oldLevel < newLevel) then
            SetTaskByte(eggs[2].info, 3, newLevel)
            for i = 1, 3, 1 do
                local remainTimes = GetTaskByte(eggs[i].info, 1)
                SetTaskByte(eggs[i].info, 1, (remainTimes + newLevel - oldLevel))
            end
        elseif (oldLevel > newLevel) then
            SetTaskByte(eggs[2].info, 3, newLevel)
            for i = 1, 3, 1 do
                local nEat = oldLevel + 2 - GetTaskByte(eggs[i].info, 1)
                if ((nEat < newLevel + 1) and nEat >= 0) then
                    SetTaskByte(eggs[i].info, 1, newLevel + 2 - nEat)
                elseif (nEat >= 0) then
                    SetTaskByte(eggs[i].info, 1, 1)


                end
            end
        end
    end
end

function main()
    local today = math.floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(TASK_1)) then
        Talk(1, "no", "Ngµy míi b¾t ®Çu! Th¹ch cÇu cña b¹n ®· bÞ bÈn. Xin ®Õn S©n luyÖn thó ®Ó röa, míi cã thÓ tiÕp tôc nu«i!")
        return 0
    end

    if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", "Trong xe kh«ng thÓ Êp trøng!")
        return 0
    end

    if (GetFightState() == 1) and (IsOwnerCity() == 1) then
        if (GetFreeNpcCount() >= 200) then
            if (GetTaskByte(eggs[1].info, 3) >= 5) then
                Talk(1, "no", 13949)
                return
            end

            if (IsGetAnother() > 0) then
                MsgBox(13948, "SetEgg1", "no")
            elseif (IsGetFree() > 0) then
                MsgBox(13948, "SetEgg", "no")
            elseif (IsOneDis() > 0) then
                Talk(1, "no", "Ng­¬i ®· nu«i d­ìng 3 qu¶ ThÊt Th¹ch CÇu, cÇn ph¶i Êp chóng në ra míi cã thÓ gi¶i phãng qu¸i vËt míi. NÕu nh­ ThÊt Th¹ch CÇu cña ng­¬i biÕn mÊt cã thÓ ®Õn khu s¨n luyÖn thó nhËn l¹i.")
            else
                Talk(1, "no", "Ng­¬i chØ cã thÓ nu«i d­ìng 3 qu¶ ThÊt Th¹ch CÇu 1 lóc.")
            end
        else
            Talk(1, "no", 13951)
        end

    elseif (GetMorphType() == -1) and (GetFightState() == 1) and (IsInCity() == 1) and (GetCamp() ~= 7) then


        local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
        if (lvl ~= nil) then


            local H, M, S = GetHMS()
            if (IsInMonsterAttackDay() == 1 and H == 20 and M <= 39) or (isCounterAttack() == 1 and H == 20 and M <= 29) then
                if (GetByte(GetCityTask(CITY_NOWAR_CARD), 2) == 1) then
                    Talk(1, "no", "´Ë¹úÒÑ¾­¹ÒÆðÃâÕ½ÅÆ, ¹¥³Çµ°½«ÎÞ·¨ÔÚ´Ë³ÇÊÐÄÚ°²·Å.")
                else
                    local key = GetByte(GetCityTask(CITY_build), 2)
                    if (key ~= 2) and (IsTongHaveRelation(CityTongName, 0) == 0) then
                        if (GetFreeNpcCount() >= 200) then
                            if ((IsGetAnother() > 0) or (IsGetFree() > 0)) then
                                MsgBox("B¹n x¸c ®Þnh muèn gäi qu¸i vËt c«ng thµnh ra?", "SetAttackEgg", "no")
                            else
                                Talk(1, "no", "Ng­¬i ®· nu«i d­ìng 3 qu¶ ThÊt Th¹ch CÇu, cÇn ph¶i Êp chóng në ra míi cã thÓ gi¶i phãng qu¸i vËt míi. NÕu nh­ ThÊt Th¹ch CÇu cña ng­¬i biÕn mÊt cã thÓ ®Õn khu s¨n luyÖn thó nhËn l¹i.")
                            end
                        else
                            Talk(1, "no", 13951)
                        end
                    else
                        Talk(1, "no", "Trong tr¹ng th¸i §ång minh hoÆc VËt tæ bÞ ph¸ háng kh«ng thÓ nu«i C«ng Thµnh cÇu")
                    end
                end
            else
                Talk(1, "no", "Trong thêi gian Qu¸i vËt kh«ng c«ng thµnh hoÆc kh«ng ph¶n kÝch chiÕn kh«ng thÓ nu«i C«ng Thµnh cÇu")
            end
        else
            Talk(1, "no", 13952)
        end
    else
        Talk(1, "no", "Trong tr¹ng th¸i hßa b×nh kh«ng thÓ nu«i ThÊt s¾c Th¹ch CÇu, tr¹ng th¸i biÕn th©n hoÆc phe hßa b×nh kh«ng thÓ nu«i C«ng Thµnh cÇu")
    end
end;

function no()
    CloseDialog()
end;

function SetEgg()
    ifExchangeTong()
    local taskNum = IsGetFree()
    if (taskNum <= 0) then
        Talk(1, "no", 13954)
        return
    end

    local w, x, y = GetWorldPos()
    local npcEggIdx = AddNpc(587, 1, SubWorld, x * 32, y * 32)
    if (npcEggIdx > 0 and GetTask(eggs[taskNum].index) == 0) then
        if (HaveNormalItem(6, 1, 300, 0) > 0) then
            SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\caidan.lua")
            SetNpcTask(npcEggIdx, 2, GetTaskByte(eggs[2].info, 3))
            SetNpcTask(npcEggIdx, 3, 1)

            local nTimes = GetTaskByte(eggs[1].info, 3)
            SetTaskByte(eggs[1].info, 3, nTimes + 1)
            SetTaskByte(eggs[taskNum].info, 2, 0)
            SetTaskByte(eggs[taskNum].info, 4, 0)

            SetTask(eggs[taskNum].index, npcEggIdx)
            SetTask(eggs[taskNum].id, GetNpcID(npcEggIdx))

            DelNormalItem(6, 1, 300, 0)
            Talk(1, "no", 13953)

            local H, M, S = GetHMS()
            local today = math.floor(LocalSystemTime() / 86400)
            local sTongName = GetTongName()
            local _, _, sTime, nState = GetShortBattleToInfo(sTongName)

            if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40 and (GetByte(GetCityTask(CITY_build), 2) ~= 2)) then
                SetNpcTask(npcEggIdx, 4, 1)
            elseif (math.floor(sTime / 86400) == today - 1) and (nState == 2) and (H == 20 and M < 30) then


                SetNpcTask(npcEggIdx, 4, 1)
            end


        else
            DelNpc(npcEggIdx)
            Talk(1, "no", 13953)
        end
    else
        Talk(1, "no", 13954)
    end
end

function SetEgg1()
    ifExchangeTong()
    local taskNum = IsGetAnother()
    if (taskNum <= 0) then
        Talk(1, "no", 13954)
    end

    local w, x, y = GetWorldPos()
    local npcEggIdx = AddNpc(587, 1, SubWorld, x * 32, y * 32)
    if (npcEggIdx > 0 and GetTask(eggs[taskNum].index) == -1) then
        if (HaveNormalItem(6, 1, 300, 0) > 0) then
            SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\caidan.lua")
            SetNpcTask(npcEggIdx, 1, GetTaskByte(eggs[taskNum].info, 2))
            SetNpcTask(npcEggIdx, 2, GetTaskByte(eggs[2].info, 3))
            SetNpcTask(npcEggIdx, 3, 1)

            local nTimes = GetTaskByte(eggs[1].info, 3)
            SetTaskByte(eggs[1].info, 3, nTimes + 1)
            SetTaskByte(eggs[taskNum].info, 4, 0)

            SetTask(eggs[taskNum].index, npcEggIdx)
            SetTask(eggs[taskNum].id, GetNpcID(npcEggIdx))

            DelNormalItem(6, 1, 300, 0)
            Talk(1, "no", 13953)

            local H, M, S = GetHMS()
            local today = math.floor(LocalSystemTime() / 86400)
            local sTongName = GetTongName()
            local _, _, sTime, nState = GetShortBattleToInfo(sTongName)

            if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40 and (GetByte(GetCityTask(CITY_build), 2) ~= 2)) then
                SetNpcTask(npcEggIdx, 4, 1)
            elseif (math.floor(sTime / 86400) == today - 1) and (nState == 2) and (H == 20 and M < 30) then


                SetNpcTask(npcEggIdx, 4, 1)
            end

        else
            DelNpc(npcEggIdx)
            Talk(1, "no", 13953)
        end
    else
        Talk(1, "no", 13954)
    end
end

function SetEgg2()
    ifExchangeTong()
    local taskNum = IsAttackEggOverTime()
    if (taskNum <= 0) then
        Talk(1, "no", 13954)
    end

    Msg2Player("C«ng Thµnh cÇu qu¸ giê ®· biÕn mÊt.....")

    local w, x, y = GetWorldPos()
    local npcEggIdx = AddNpc(587, 1, SubWorld, x * 32, y * 32)
    if (npcEggIdx > 0) then
        if (HaveNormalItem(6, 1, 300, 0) > 0) then
            SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\caidan.lua")
            SetNpcTask(npcEggIdx, 2, GetTaskByte(eggs[2].info, 3))
            SetNpcTask(npcEggIdx, 3, 1)

            local nLevel = GetOwnCityLevel()
            SetTaskByte(eggs[taskNum].info, 1, nLevel + 3)
            local nTimes = GetTaskByte(eggs[1].info, 3)
            SetTaskByte(eggs[1].info, 3, nTimes + 1)
            SetTaskByte(eggs[taskNum].info, 2, 0)
            SetTaskByte(eggs[taskNum].info, 4, 0)

            SetTask(eggs[taskNum].index, npcEggIdx)
            SetTask(eggs[taskNum].id, GetNpcID(npcEggIdx))
            SetTask(eggs[taskNum].tim, 0)

            DelNormalItem(6, 1, 300, 0)
            Talk(1, "no", 13953)

            local H, M, S = GetHMS()
            local today = math.floor(LocalSystemTime() / 86400)
            local sTongName = GetTongName()
            local _, _, sTime, nState = GetShortBattleToInfo(sTongName)

            if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40 and (GetByte(GetCityTask(CITY_build), 2) ~= 2)) then
                SetNpcTask(npcEggIdx, 4, 1)
            elseif (math.floor(sTime / 86400) == today - 1) and (nState == 2) and (H == 20 and M < 30) then


                SetNpcTask(npcEggIdx, 4, 1)
            end


        else
            DelNpc(npcEggIdx)
            Talk(1, "no", 13953)
        end
    else
        Talk(1, "no", 13954)
    end
end

function SetAttackEgg()
    ifExchangeTong()
    local taskNum = IsGetAnother()
    if (taskNum > 0 and GetTask(eggs[taskNum].index) == -1) then
        Talk(1, "no", "Trøng tr¶ l¹i chØ cã thÓ Êp trong l·nh ®Þa cña m×nh.")
        return


    elseif (IsGetFree() > 0) then
        local taskNum = IsGetFree()
        local w, x, y = GetWorldPos()
        local npcEggIdx = AddNpc(587, 1, SubWorld, x * 32, y * 32)
        if (npcEggIdx > 0 and GetTask(eggs[taskNum].index) == 0) then
            if (HaveNormalItem(6, 1, 300, 0) > 0) then
                SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\¹¥³Çµ°.lua")
                local lvl = GetTaskByte(eggs[taskNum].info, 1) - 2
                SetTaskByte(eggs[taskNum].info, 4, lvl)
                SetTaskByte(eggs[taskNum].info, 2, 0)

                SetNpcTask(npcEggIdx, 2, lvl)
                SetNpcTask(npcEggIdx, 3, 2)

                SetTask(eggs[taskNum].index, npcEggIdx)
                SetTask(eggs[taskNum].id, GetNpcID(npcEggIdx))

                DelNormalItem(6, 1, 300, 0)
                Talk(1, "no", 13953)

                local H, M, S = GetHMS()
                if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40) then
                    SetNpcTask(npcEggIdx, 4, 1)
                end


            else
                DelNpc(npcEggIdx)
                Talk(1, "no", 13953)
            end
        else
            Talk(1, "no", 13954)
        end
    else
        Talk(1, "no", 13954)
    end
end

function isCounterAttack()
    local _, _, _, _, lvl, typeIdx, CityTongName = GetCityInfo()
    if (IsTongHaveRelation(CityTongName, 0) == 1) then
        return 0
    end

    local sTongName = GetTongName()
    if (sTongName == CityTongName) then
        return 0
    end

    local sTong, _, sTime, nState = GetShortBattleByInfo(sTongName)
    local today = math.floor(LocalSystemTime() / 86400)
    local day_key = GetCityTask(CITY_growth_day)
    if (today ~= day_key) or (math.floor(sTime / 86400) + 1 ~= today) or (nState ~= 1) then
        return 0
    end

    if (sTong == CityTongName) then
        return 1
    end
    return 0
end

