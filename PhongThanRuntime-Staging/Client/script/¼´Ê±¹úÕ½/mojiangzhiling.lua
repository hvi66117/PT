NEW_TASK_1 = 1954

NEW_eggs = {
    [1] = { info = 1958, index = 1959, id = 1960, tim = 1961 },
    [2] = { info = 1962, index = 1963, id = 1964, tim = 1965 },
    [3] = { info = 1966, index = 1967, id = 1968, tim = 1969 }
}

CITY_build = 42
CITY_growth_day = 44

function IsGetAnother()
    local taskNum = 0
    for i = 1, 3, 1 do
        if (GetTask(NEW_eggs[i].index) == -1) then
            taskNum = i
            break
        end
    end
    return taskNum
end

function IsGetFree()
    local taskNum = 0
    for i = 1, 3, 1 do
        if (GetTask(NEW_eggs[i].index) == 0) then
            taskNum = i
            break
        end
    end
    return taskNum
end

function IsOneDis()
    local taskNum = 0
    for i = 1, 3, 1 do
        local npcindex = GetTask(NEW_eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 2185) or (GetTask(NEW_eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(NEW_eggs[i].info, 4) == 0) then
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
        local npcindex = GetTask(NEW_eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 2185) or (GetTask(NEW_eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(NEW_eggs[i].info, 4) > 0) then
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
        local npcindex = GetTask(NEW_eggs[i].index)
        if (npcindex > 0) and ((GetNpcTemplateID(npcindex) ~= 2185) or (GetTask(NEW_eggs[i].id) ~= GetNpcID(npcindex))) then

            if (GetTaskByte(NEW_eggs[i].info, 4) > 0) and (IsOverTime() > 0) then
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
    if (GetTaskByte(NEW_eggs[2].info, 3) ~= (GetOwnCityLevel() + 1)) then
        local oldLevel = GetTaskByte(NEW_eggs[2].info, 3)
        local newLevel = GetOwnCityLevel() + 1
        if (oldLevel < newLevel) then
            SetTaskByte(NEW_eggs[2].info, 3, newLevel)
            for i = 1, 3, 1 do
                local remainTimes = GetTaskByte(NEW_eggs[i].info, 1)
                SetTaskByte(NEW_eggs[i].info, 1, (remainTimes + newLevel - oldLevel))
            end
        elseif (oldLevel > newLevel) then
            SetTaskByte(NEW_eggs[2].info, 3, newLevel)
            for i = 1, 3, 1 do
                local nEat = oldLevel + 2 - GetTaskByte(NEW_eggs[i].info, 1)
                if ((nEat < newLevel + 1) and nEat >= 0) then
                    SetTaskByte(NEW_eggs[i].info, 1, newLevel + 2 - nEat)
                elseif (nEat >= 0) then
                    SetTaskByte(NEW_eggs[i].info, 1, 1)
                end
            end
        end
    end
end

function main()
    local today = math.floor(LocalSystemTime() / 86400)
    if (today ~= GetTask(NEW_TASK_1)) then
        Talk(1, "no", "ĞÂµÄÒ»Ìì¿ªÊ¼, ÄãµÄMa T­íng Chi LinhÔªÆøÏûÉ¢, Çëµ½±¾¹ú¹ÖÎïÄÁ³¡ÖØĞÂ×¢ÈëÁéÆø, ÔÙÀ´ÅàÑø!")
        return 0
    end

    if (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", "ÔÚ³µÄÚ²»ÄÜÅàÑøMa T­íng Chi Linh.")
        return 0
    end
    if (IsOwnerCity() == 1) then
        if (GetFightState() == 1) then
            if (GetFreeNpcCount() >= 200) then
                if (GetTaskByte(NEW_eggs[1].info, 3) >= 3) then
                    Talk(1, "no", "Xin lçi, Ã¿¸öÈËÃ¿Ìì×î¶àÖ»ÄÜÅàÑø 3 c¸i Ma T­íng Chi Linh, Èç¹ûÄú½ñÌì»¹Ã»ÓĞÅàÑøMa T­íng Chi Linh, ¿ÉÒÔÈ¥²éÑ¯Ò»ÏÂ¹ÖÎïÄÁ³¡µÄ¼ÇÂ¼.")
                    return
                end

                if (IsGetAnother() > 0) then
                    MsgBox("HiÖn ta cÇn <c=g>2 giê<c> ®Ó chó nhËp linh khİ! H·y ®­a thøc ¨n cho ta!", "SetEgg1", "no")
                elseif (IsGetFree() > 0) then
                    MsgBox("HiÖn ta cÇn <c=g>2 giê<c> ®Ó chó nhËp linh khİ! H·y ®­a thøc ¨n cho ta!", "SetEgg", "no")
                elseif (IsOneDis() > 0) then
                    Talk(1, "no", "ÄãÒÑ¾­ÅàÑøÁË3 Ma T­íng Chi Linh, ĞèÒª°ÑËü·õ»¯³öÀ´²ÅÄÜÊÍ·Å³öĞÂµÄ¹ÖÎï.Èç¹ûÄãµÄMa T­íng Chi LinhÏûÊ§ÁË, ¿ÉÒÔ³¢ÊÔÈ¥¹ÖÎïÄÁ³¡ÖØĞÂÁìÈ¡.")
                else
                    Talk(1, "no", "Äã×î¶àÖ»ÄÜÍ¬Ê±ÅàÑø3 Ma T­íng Chi Linh, ÇëÉÔºòÔÙÊÔ!")
                end
            else
                Talk(1, "no", "·Ç³£±§Ç¸, Ma T­íng Chi LinhÔÚ´ËÊ±ÉèÖÃ¹ı¶à, ÇëÉÔºóÔÙÊÔ.")
            end
        else
            Talk(1, "no", "ÔÚ·ÇÕ½Õù×´Ì¬ÏÂ²»ÄÜÑøMa T­íng Chi Linh")
        end
    else
        Talk(1, "no", "²»¿ÉÔÚc¸c Thµnh thŞ kh¸cÖĞÅàÑøMa T­íng Chi Linh")
    end
end;

function no()
    CloseDialog()
end;

function SetEgg()
    ifExchangeTong()
    local taskNum = IsGetFree()
    if (taskNum <= 0) then
        Talk(1, "no", "·Ç³£±§Ç¸, Ma T­íng Chi LinhÍ¬Ò»Ê±¿Ì²»¿ÉÒÔÉèÖÃ¹ı¶à, ÇëÉÔºóÔÙÊÔ.")
        return
    end

    local w, x, y = GetWorldPos()
    local npcEggIdx = AddNpc(2185, 1, SubWorld, x * 32, y * 32)
    if (npcEggIdx > 0 and GetTask(NEW_eggs[taskNum].index) == 0) then
        if (HaveNormalItem(6, 1, 1180, 0) > 0) then
            SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\mojiangeggs.lua")
            SetNpcName(npcEggIdx, "Ma T­íng Chi Linh")
            SetNpcTask(npcEggIdx, 2, GetTaskByte(NEW_eggs[2].info, 3))
            SetNpcTask(npcEggIdx, 3, 1)
            SetNpcTimer(npcEggIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 7200)
            local nTimes = GetTaskByte(NEW_eggs[1].info, 3)
            SetTaskByte(NEW_eggs[1].info, 3, nTimes + 1)
            SetTaskByte(NEW_eggs[taskNum].info, 2, 0)
            SetTaskByte(NEW_eggs[taskNum].info, 4, 0)

            SetTask(NEW_eggs[taskNum].index, npcEggIdx)
            SetTask(NEW_eggs[taskNum].id, GetNpcID(npcEggIdx))

            DelNormalItem(6, 1, 1180, 0)
            Talk(1, "no", "Ta cÇn ph¶i ®­îc chó nhËp linh hån trong <c=g>1 giê ®ång hå<c>, nÕu kh«ng ta sÏ bŞ tan ch¶y ra!")

            local H, M, S = GetHMS()
            local today = math.floor(LocalSystemTime() / 86400)
            local sTongName = GetTongName()
            local _, _, sTime, nState = GetShortBattleToInfo(sTongName)

            if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40 and (GetByte(GetCityTask(CITY_build), 2) ~= 2)) then
                SetNpcTask(npcEggIdx, 4, 1)
            elseif (math.floor(sTime / 86400) == today - 1) and (nState == 2) and (H == 20 and M < 30) then
                SetNpcTask(npcEggIdx, 4, 1)
            end
            WriteLog("[Trõ ma VÖ thµnh cao cÊp][ÖÖµ°][1]")

        else
            DelNpc(npcEggIdx)
        end
    else
        Talk(1, "no", "·Ç³£±§Ç¸, Ma T­íng Chi LinhÍ¬Ò»Ê±¿Ì²»¿ÉÒÔÉèÖÃ¹ı¶à, ÇëÉÔºóÔÙÊÔ.")
    end
end

function SetEgg1()
    ifExchangeTong()
    local taskNum = IsGetAnother()
    if (taskNum <= 0) then
        Talk(1, "no", "·Ç³£±§Ç¸, Ma T­íng Chi LinhÍ¬Ò»Ê±¿Ì²»¿ÉÒÔÉèÖÃ¹ı¶à, ÇëÉÔºóÔÙÊÔ.")
    end

    local w, x, y = GetWorldPos()
    local npcEggIdx = AddNpc(2185, 1, SubWorld, x * 32, y * 32)
    if (npcEggIdx > 0 and GetTask(NEW_eggs[taskNum].index) == -1) then
        if (HaveNormalItem(6, 1, 1180, 0) > 0) then
            SetNpcScript(npcEggIdx, "\\script\\¼´Ê±¹úÕ½\\mojiangeggs.lua")
            SetNpcName(npcEggIdx, "Ma T­íng Chi Linh")
            SetNpcTask(npcEggIdx, 1, GetTaskByte(NEW_eggs[taskNum].info, 2))
            SetNpcTask(npcEggIdx, 2, GetTaskByte(NEW_eggs[2].info, 3))
            SetNpcTask(npcEggIdx, 3, 1)
            SetNpcTimer(npcEggIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 7200)

            local nTimes = GetTaskByte(NEW_eggs[1].info, 3)
            SetTaskByte(NEW_eggs[1].info, 3, nTimes + 1)
            SetTaskByte(NEW_eggs[taskNum].info, 4, 0)

            SetTask(NEW_eggs[taskNum].index, npcEggIdx)
            SetTask(NEW_eggs[taskNum].id, GetNpcID(npcEggIdx))

            DelNormalItem(6, 1, 1180, 0)
            Talk(1, "no", "Ta cÇn ph¶i ®­îc chó nhËp linh hån trong <c=g>1 giê ®ång hå<c>, nÕu kh«ng ta sÏ bŞ tan ch¶y ra!")

            local H, M, S = GetHMS()
            local today = math.floor(LocalSystemTime() / 86400)
            local sTongName = GetTongName()
            local _, _, sTime, nState = GetShortBattleToInfo(sTongName)

            if (IsInMonsterAttackDay() == 1 and H == 20 and M < 40 and (GetByte(GetCityTask(CITY_build), 2) ~= 2)) then
                SetNpcTask(npcEggIdx, 4, 1)
            elseif (math.floor(sTime / 86400) == today - 1) and (nState == 2) and (H == 20 and M < 30) then


                SetNpcTask(npcEggIdx, 4, 1)
            end
            WriteLog("[Trõ ma VÖ thµnh cao cÊp][ÖÖµ°][2]")
        else
            DelNpc(npcEggIdx)
        end
    else
        Talk(1, "no", "·Ç³£±§Ç¸, Ma T­íng Chi LinhÍ¬Ò»Ê±¿Ì²»¿ÉÒÔÉèÖÃ¹ı¶à, ÇëÉÔºóÔÙÊÔ.")
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

