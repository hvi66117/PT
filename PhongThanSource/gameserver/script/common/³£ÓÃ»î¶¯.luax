module("UActivitie", package.seeall)

require("common.luax")

g_Day = {
    [1] = { { 2015, 5, 26 }, { 2015, 6, 1 } },
    [2] = { { 2015, 5, 28 }, { 2015, 6, 1 } },
}

function Pub_AddBuff(dayIndex, taskId, taskIndex, isEveryDay, buffId, buffTime, buffLevel, buffName)

    if (dayIndex == nil or taskId == nil or taskIndex == nil or isEveryDay == nil
            or buffId == nil or buffTime == nil or buffName == nil or buffTime <= 0) then
        WriteLog("Pub_AddBuff²ÎÊýÓÐÎó")
        return 0
    end

    if (buffLevel == nil or buffLevel <= 0) then
        buffLevel = 1
    end

    if not (Pub_IsInDate(dayIndex) > 0) then
        SetTaskByte(taskId, taskIndex, 0)
        return 0
    end

    local value = 100
    local y, m, d = GetYMD()

    if (isEveryDay > 0) then
        value = d
    end

    if (y == 2015 and m == 5 and d == 28) then

        if (HaveIBBuff(1480) <= 0 and GetTaskByte(taskId, taskIndex) == 28) then
            local n = AddIBBuff(1480, 3600 * 8, 2)
            if (n > 0) then
                SetTaskByte(taskId, taskIndex, 28)
                Msg2Player("Chóc mõng ngµi nhËn ®­îc Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ.")
                WriteLog("ÌØÊâ²¹³¥¼ÓµÄÖ÷ÌâÈÕ¿ñ»¶buff")
                return
            end
        end
    end

    if (GetTaskByte(taskId, taskIndex) == value) then
        return 0
    end

    local nRet = 0

    if (HaveIBBuff(buffId) > 0) then

        local nLeftTime = GetIBBuffLeftTimes(buffId)
        if (nLeftTime < 0) then
            WriteLog("Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ¹ýÆÚ ÀÛ¼Æ¼ÆËãµÃ: " .. buffTime .. " " .. nLeftTime)
        else
            buffTime = buffTime + nLeftTime
            WriteLog("Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎÊ£Óà ÀÛ¼Æ¼ÆËãµÃ: " .. buffTime)
        end

        if (RemoveIBBuff(buffId) > 0 and buffTime > 0) then

            nRet = AddIBBuff(buffId, buffTime, buffLevel - 1)
        else
            WriteLog("Tr¹ng th¸i Chñ ®Ò ngµy Vui vÎ Ìí Thªm thÊt b¹i")
            return
        end
    else

        nRet = AddIBBuff(buffId, buffTime, buffLevel - 1)
    end

    if (nRet > 0) then
        SetTaskByte(taskId, taskIndex, value)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc " .. buffName)
        WriteLog("NhËn ®­îc " .. buffName)
    end
end

function Pub_IsInDate(index)
    if (index == nil) then
        return 0
    end

    if (g_Day == nil) then
        return 0
    end

    local time1 = LocalYMD2Time(g_Day[index][1][1], g_Day[index][1][2], g_Day[index][1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_Day[index][2][1], g_Day[index][2][2], g_Day[index][2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return 1
    end
    return 0
end

function no()

    CloseDialog()
end

function AddMonster(npcIndex, timelong, maplist)

    if (npcIndex == nil or timelong == nil or timelong <= 0) then
        return 0
    end

    local w, x, y = GetNpcWorldPos(npcIndex)
    if (maplist ~= nil) then
        local b = 0
        for i = 1, #maplist do
            if (w == maplist[i]) then
                b = 1
            end
        end
        if (b <= 0) then
            return 0
        end
    end

    local npcid = GetNpcTemplateID(npcIndex)
    local npcname = GetNpcName(npcIndex)
    local npccamp = GetNpcCamp(npcIndex)

    local nNpcIndex = AddNpc(npcid, GetNpcLevel(npcIndex), SubWorldID2Idx(w), x * 32, y * 32)
    if (nNpcIndex > 0) then
        SetNpcCamp(nNpcIndex, 7)
        SetNpcTimer(nNpcIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", timelong)
        SetNpcName(nNpcIndex, "<c=green>" .. GetName() .. "." .. npcname)
        return 1
    else
        WriteLog("ÕÙ»½ÓÑ¾ü¹ÖÎïÊ§°Ü")
        return 1
    end
end

function back_IsInDate()
    local nKey = GetGlobalStoreValueByte(25, 2)
    if (GetBit(nKey, 1) == 0) then
        return 0
    end

    local StartM = GetGlobalStoreValueByte(22, 1)
    local StartD = GetGlobalStoreValueByte(22, 2)
    local EndM = GetGlobalStoreValueByte(22, 3)
    local EndD = GetGlobalStoreValueByte(22, 4)
    local y, m, d = GetYMD()
    local today = y * 10000 + m * 100 + d
    local year = GetGlobalStoreValueByte(84, 4) + 2000
    local StartDay = year * 10000 + StartM * 100 + StartD
    local EndDay = year * 10000 + EndM * 100 + EndD
    if (StartM > EndM) then
        EndDay = EndDay + 10000
    end

    if (today >= StartDay and today <= EndDay) then
        return 1
    elseif (today > EndDay) then
        SetGlobalStoreValueByte(25, 2, SetBit(nKey, 1, 0), 1)
    end
    return 0
end

function back_IsGetGift()
    if (GetExtPoint(5) <= 0) then
        return 0
    end

    if (GetTaskByte(2285, 2) > 0) and (GetBit(GetTaskWord(2286, 2), 1) == 1) then
        return 1
    end

    if (GetLevel() < 81 and GetNewBirthTimes() < 1) then
        return 0
    end
    return 0
end

function back_IsGetAll()
    if (GetExtPoint(5) <= 0) then
        return 0
    end

    local temp = GetGlobalStoreValueByte(25, 2)
    if (GetBit(temp, 7) == 1) then
        return 1
    end

    if (GetLevel() < 81 and GetNewBirthTimes() < 1) then
        return 0
    end
    return 0
end

function back_IsOpen(idx)
    if (back_IsInDate() ~= 1) then
        return 0
    end

    local temp = GetGlobalStoreValueByte(25, 2)
    if (GetBit(temp, idx) == 1) then
        return 1
    end

    return 0
end

function back_IsHopeCard(idx, npcIdx, pIdx, killName)
    if (back_IsOpen(idx) ~= 1) then
        return 0
    end

    if (npcIdx == nil) then
        return 0
    end

    local oldPIdx = _G.PlayerIndex
    if (pIdx == nil) or (pIdx <= 0) then
        pIdx = GetPlayerIndexByName(killName)
        if (pIdx == nil) or (pIdx <= 0) then
            return 0
        end
    end

    _G.PlayerIndex = pIdx
    local NpcMap, nNpcx, nNpcy = GetNpcWorldPos(npcIdx)
    local nKey = 0
    local w, x, y = GetWorldPos()
    local str = killName .. "¶ÓÓÑ: "
    if (GetTeam() > 0) then

        local nPeople = GetTeamSize()
        for i = 1, nPeople do
            _G.PlayerIndex = GetTeamMember(i)
            str = str .. GetName()
            w, x, y = GetWorldPos()
            if (w == NpcMap) and (math.sqrt((x - nNpcx) ^ 2 + ((y - nNpcy) ^ 2)) * 32 < 800) then
                if (back_IsGetGift() == 1) then
                    nKey = 1
                    str = str .. "B"
                else
                    str = str .. "F"
                end
                SetTask(142, idx)
            else
                str = str .. "X"
                SetTask(142, 0)
            end
        end

    elseif (back_IsGetGift() == 1) then
        nKey = 1
        str = str .. "V"
    end

    _G.PlayerIndex = oldPIdx

    if (nKey == 0) then
        WriteLog("[Ho¹t ®éng håi quy]" .. idx .. "[ÐíÔ¸¿¨ÎÞ×Ê¸ñ][" .. str)
        return 0
    end

    if (GetTeam() > 0) then

        local nPeople = GetTeamSize()
        for i = 1, nPeople do
            _G.PlayerIndex = GetTeamMember(i)
            if (GetTask(142) == idx) then
                back_GetCard()
            end
        end

    else
        back_GetCard()
    end

    _G.PlayerIndex = oldPIdx
end

function back_GetCard()
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (GetTaskByte(2285, 2) ~= today) then
        SetTaskByte(2285, 2, today)
        SetTaskByte(2285, 3, 0)
    end

    local cishu = GetTaskByte(2285, 3) + 1
    if (cishu > 5) then
        Msg2Player("ThËt xin lçi, Ã¿Ìì×î¶àÖ»ÄÜ»ñµÃ 5 c¸i .")
        return 0
    end

    if (GetTask(142) == 4) and (math.random(1, 2) == 1) then
        WriteLog("[Ho¹t ®éng håi quy][ThÎ cÇu Phóc vËn][Ëæ»úÊ§°Ü]")
        return 0
    end

    SetTaskByte(2285, 3, cishu)

    local str = ""
    if (IsHaveSpaceForTreasure(2) < 1) then
        SendItemMailToSelf(4, "Hép th­", "²ÎÓë»ØÁ÷»î¶¯, nhËn ®­îc ThÎ cÇu Phóc vËn 1 c¸i !ÒòÎª±³°ü¿Õ¼äÓÐÏÞ, ÌØ·¢´ËÓÊ¼þ, ÇëÄúÊÕºÃ!!", 6, 1, 1370, 1, 0, 0, 0, 1)
        str = "ÒòÎª±³°ü¿Õ¼äÓÐÏÞ, ÒÑÓÊ¼Ä¸øÄú, ÇëÄú²éÊÕ!"
    else
        AddNormalItemBind(6, 1, 1370, 1, 0, 0, 1)
    end
    Msg2Player("²ÎÓë»ØÁ÷»î¶¯, nhËn ®­îc ThÎ cÇu Phóc vËn 1 c¸i!" .. str)
    WriteLog("[Ho¹t ®éng håi quy][ThÎ cÇu Phóc vËn][" .. str)
end


