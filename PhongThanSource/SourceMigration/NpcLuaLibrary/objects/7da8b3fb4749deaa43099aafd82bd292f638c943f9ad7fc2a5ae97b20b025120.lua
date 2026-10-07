-- mayining create 2008.11.25
-- ∑Áª¬÷¥Û»¸œ›⁄ÂNpc¥•∑¢Ω≈±æ

-- Added by zhaoqingsong at 2008-11-25

-- »ŒŒÒ◊¥Ã¨±‰¡ø
-- 1 Byte »ŒŒÒ◊¥Ã¨£¨0 Œ¥Ω”»ŒŒÒ£¨1 Ω”»ŒŒÒ
-- 2 Byte »ŒŒÒ≤Ω÷Ë£¨0 Œ¥ø™ º£¨1 Œ˜√≈“Ω…˙£¨2 ƒœ√≈“Ω…˙£¨3 ∂´√≈“Ω…˙£¨4 Ê˚Õı
Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278    -- ±®√˚ ±º‰
Task_Ring_BindingIndex = 1279    -- ∞Û∂®µƒNpcIndex
Task_Ring_BindingID = 1280    -- ∞Û∂®µƒNpcID

Task_Ring_NPC_TrapInfo = 0    -- œ›⁄Â–≈œ¢
Task_Ring_NPC_FreezeTime = 1    -- ¿‰»¥ ±º‰¥¡
Task_Ring_NPC_BuffATime = 2    -- BuffA ±º‰¥¡
Task_Ring_NPC_BuffBTime = 3    -- BuffB ±º‰¥¡
Task_Ring_NPC_BuffCTime = 4    -- BuffC ±º‰¥¡
Task_Ring_NPC_BuffDTime = 5    -- BuffD ±º‰¥¡
Task_Ring_NPC_BindingID = 6    -- ∞Û∂®ÕÊº“ID
Task_Ring_NPC_TrapIdx = 8    -- ∞Û∂®œ›⁄ÂIndex
Task_Ring_NPC_TrapTime = 9    -- ∞Û∂®œ›⁄Â ±º‰
Task_Ring_NPC_BindingIDFlag = 7  --∞Û∂®ÕÊº“ID∑˚∫≈

Buff_Ring_Going = 487   -- Ω¯––Buff
Buff_Ring_BuffA = 488   -- ÀŸ∂»ºı∞ÎBuff
Buff_Ring_BuffB = 489   -- ∑¥œÚ≈‹∂ØBuff
Buff_Ring_BuffC = 490   -- ÀŸ∂»º”±∂Buff
Buff_Ring_BuffD = 491   -- ºıÀŸ10%Buff

Buff_Ring_Time = 15 -- ŒÂ√Î÷”µƒBuff ±º‰

Task_Info_Ring = 1020   -- ∑Áª¬÷¥Û»¸F11
Ring_Npc_TemplateID = 738 -- ∑Áª¬÷NpcTemplate
Task_Ring_Match_Second = 600 --  Æ∑÷÷”“ª≥°±»»¸

-- œ›⁄Â∂‘∑Áª¬÷≤˙…˙µƒ–ßπ˚ ˝◊È
Trap_Effect = {
    [1] = {
        { rand = 0, buff = Buff_Ring_BuffA, npctask = Task_Ring_NPC_BuffATime },
        { rand = 50, buff = Buff_Ring_BuffB, npctask = Task_Ring_NPC_BuffBTime },
        { rand = 50 + 50, buff = Buff_Ring_BuffC, npctask = Task_Ring_NPC_BuffCTime },
        { rand = 0, buff = Buff_Ring_BuffD, npctask = Task_Ring_NPC_BuffDTime },
    },
    [2] = {
        { rand = 40, buff = Buff_Ring_BuffA, npctask = Task_Ring_NPC_BuffATime },
        { rand = 40 + 40, buff = Buff_Ring_BuffB, npctask = Task_Ring_NPC_BuffBTime },
        { rand = 40 + 40 + 10, buff = Buff_Ring_BuffC, npctask = Task_Ring_NPC_BuffCTime },
        { rand = 40 + 40 + 10 + 10, buff = Buff_Ring_BuffD, npctask = Task_Ring_NPC_BuffDTime },
    },
}

RAND_TRAP_POS_ARRAY = {
    [0] = {
        [0] = { nWorldX = 1730, nWorldY = 3058 },
        [1] = { nWorldX = 1680, nWorldY = 3019 },
        [2] = { nWorldX = 1675, nWorldY = 3114 },
    },
    [1] = {
        [0] = { nWorldX = 1757, nWorldY = 3099 },
        [1] = { nWorldX = 1778, nWorldY = 3018 },
        [2] = { nWorldX = 1811, nWorldY = 2983 },
    },
}
STATIC_TRAP_POS_ARRAY = {
    [0] = { nWorldX = 1718, nWorldY = 3072 },
    [1] = { nWorldX = 1694, nWorldY = 3042 },
    [2] = { nWorldX = 1694, nWorldY = 3095 },
    [3] = { nWorldX = 1752, nWorldY = 3107 },
    [4] = { nWorldX = 1755, nWorldY = 3039 },
    [5] = { nWorldX = 1661, nWorldY = 3003 },
    [6] = { nWorldX = 1781, nWorldY = 3045 },
    [7] = { nWorldX = 1820, nWorldY = 3168 },
}

--Modified By Guoqun for √ø»’ŒÁº‰ªÓ∂Ø at 2010-09-20 Begin
Noon_Active_Event = 7    --ŒÁº‰ªÓ∂Ø ¿ΩÁ ¬º˛
Noon_Active_Event_Day = 1    --ŒÁº‰ªÓ∂Ø ¿ΩÁ ±º‰- ±º‰±‰¡ø
Noon_Active_Event_Num = 2    --ŒÁº‰ªÓ∂Ø ¿ΩÁ ±º‰-ªÓ∂Ø–Ú∫≈

function Check_NoonActive_ON(nNum)
    if (IsWorldEventExist(Noon_Active_Event) == 0) then
        return 0
    end
    local nCurDay = floor(LocalSystemTime() / 86400);

    if GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Day) == nCurDay
            and GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Num) == nNum then
        return 1
    end

    return 0
end
--Modified By Guoqun for √ø»’ŒÁº‰ªÓ∂Ø at 2010-09-20 End

function OnNpcTrap(NpcIndex)
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()
    --Modified By Guoqun for √ø»’ŒÁº‰ªÓ∂Ø at 2010-09-20 Begin
    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if H < 11 or H >= 14 then
            DelNpc(TrapNpcIdx)
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            DelNpc(TrapNpcIdx)
            return
        end
    end
    --Modified By Guoqun for √ø»’ŒÁº‰ªÓ∂Ø at 2010-09-20 Begin

    if (GetNpcTemplateID(NpcIndex) == Ring_Npc_TemplateID) then
        local localTime = LocalSystemTime()
        local lastTrapIdx = GetNpcTask(NpcIndex, Task_Ring_NPC_TrapIdx)
        if (lastTrapIdx == TrapNpcIdx) then
            local lastTrapTime = GetNpcTask(NpcIndex, Task_Ring_NPC_TrapTime)
            if (localTime < lastTrapTime + 20) then
                return
            end
        end

        local selfBindPlayerID = GetNpcTask(NpcIndex, Task_Ring_NPC_BindingID)
        local selfBindPlayerIDFlag = GetNpcTask(NpcIndex, Task_Ring_NPC_BindingIDFlag)
        local selfPlayerID = (selfBindPlayerIDFlag == 1) and (selfBindPlayerID + 2 ^ 31) or selfBindPlayerID
        local selfPlayerIndex = SearchPlayerById(selfPlayerID)
        if (selfPlayerIndex <= 0) then
            --“Ï≥£«Èøˆœ¬«øªØ≥Ã–Ú
            return
        end
        local playerIndexCache = PlayerIndex
        PlayerIndex = selfPlayerIndex
        local mapid, x, y = GetWorldPos()
        if (mapid ~= 21) then
            PlayerIndex = playerIndexCache
            return
        end
        local trapInfo = GetNpcTask(TrapNpcIdx, Task_Ring_NPC_TrapInfo)
        local trapType = GetByte(trapInfo, 1)
        local trapArray = GetByte(trapInfo, 2)
        local trapIndex = GetByte(trapInfo, 3)
        local rand = random(1, 100)
        local effectType = 1
        local effectBuff = Buff_Ring_BuffA
        local effectTaskVar = Task_Ring_NPC_BuffATime
        local effectTimestap = localTime + Buff_Ring_Time
        for k, v in Trap_Effect[trapType] do
            if (rand <= v.rand) then
                effectType = k
                effectBuff = v.buff
                effectTaskVar = v.npctask
                break
            end
        end
        if (effectType == 4) then
            local nearRingIdx = SearchNearNpcByTemplateId(NpcIndex, Ring_Npc_TemplateID)
            if (nearRingIdx <= 0) then
                PlayerIndex = playerIndexCache
                return
            end
            local selfMapid, selfx, selfy = GetNpcWorldPos(NpcIndex)
            local nearMapid, nearx, neary = GetNpcWorldPos(nearRingIdx)
            local seamDistance = floor(sqrt((selfx - nearx) ^ 2 + (selfy - neary) ^ 2))
            if (seamDistance > 10) then
                PlayerIndex = playerIndexCache
                return
            end

            local nearBindPlayerID = GetNpcTask(nearRingIdx, Task_Ring_NPC_BindingID)
            local nearBindPlayerIDFlag = GetNpcTask(nearRingIdx, Task_Ring_NPC_BindingIDFlag)
            local nearPlayerID = (nearBindPlayerIDFlag == 1) and (nearBindPlayerID + 2 ^ 31) or nearBindPlayerID
            local nearPlayerIndex = SearchPlayerById(nearPlayerID)
            if (nearPlayerIndex <= 0) then
                return
            end
            local playerIndexCache2 = PlayerIndex
            PlayerIndex = nearPlayerIndex
            local mapid, x, y = GetWorldPos()
            if (mapid ~= 21) then
                PlayerIndex = playerIndexCache
                return
            end
            AddIBBuff(effectBuff, Buff_Ring_Time)
            SetNpcTask(nearRingIdx, effectTaskVar, effectTimestap)
            SetNpcTask(nearRingIdx, Task_Ring_NPC_TrapIdx, TrapNpcIdx)
            SetNpcTask(nearRingIdx, Task_Ring_NPC_TrapTime, localTime)

            Msg2Player("Phong H·a lu©n sœ khi’n ÆËi ph≠¨ng gi∂m tËc ÆÈ" .. Buff_Ring_Time .. " gi©y.")
            TopMessage("Phong H·a lu©n sœ lµm ÆËi ph≠¨ng gi∂m tËc ÆÈ" .. Buff_Ring_Time .. " gi©y!")
            local opponentName = GetName()
            PlayerIndex = playerIndexCache2

            Msg2Player("Phong H·a lu©n cÒa bπn ph∏t ra k◊nh l˘c, khi’n Phong H·a lu©n cÒa" .. opponentName .. " gi∂m tËc" .. Buff_Ring_Time .. " gi©y.")
            TopMessage("Phong H·a lu©n ph∏t ra k◊nh l˘c, khi’n ÆËi ph≠¨ng gi∂m tËc" .. Buff_Ring_Time .. " gi©y!")
        else
            AddIBBuff(effectBuff, Buff_Ring_Time)
            SetNpcTask(NpcIndex, effectTaskVar, effectTimestap)
            SetNpcTask(NpcIndex, Task_Ring_NPC_TrapIdx, TrapNpcIdx)
            SetNpcTask(NpcIndex, Task_Ring_NPC_TrapTime, localTime)
            if (effectType == 1) then
                Msg2Player("Phong H·a lu©n cÒa bπn r¨i vµo b…y, gi∂m tËc 1 nˆa" .. Buff_Ring_Time .. " gi©y.")
                TopMessage("Phong H·a lu©n r¨i vµo b…y, gi∂m tËc 1 nˆa" .. Buff_Ring_Time .. " gi©y!")
            elseif (effectType == 2) then
                Msg2Player("Phong H·a lu©n cÒa bπn r¨i vµo b…y, kh´ng th” ki”m so∏t Æ≠Óc n˜a!" .. Buff_Ring_Time .. " gi©y.")
                TopMessage("Phong H·a lu©n r¨i vµo b…y, kh´ng th” ki”m so∏t" .. Buff_Ring_Time .. " gi©y!")
            elseif (effectType == 3) then
                Msg2Player("Phong H·a lu©n cÒa bπn ph∏t huy k◊nh l˘c, t®ng Æ´i tËc ÆÈ" .. Buff_Ring_Time .. " gi©y.")
                TopMessage("Phong H·a lu©n ph∏t huy k◊nh l˘c, t®ng Æ´i tËc ÆÈ" .. Buff_Ring_Time .. " gi©y!")
            end
        end
        if (trapType == 2) then
            local newPos = -1
            local rand = random(1, 2)
            for i = 1, rand do
                newPos = newPos + 1
                if (newPos == trapIndex) then
                    newPos = newPos + 1
                end
            end
            NpcSetPos(TrapNpcIdx, RAND_TRAP_POS_ARRAY[trapArray][newPos].nWorldX * 32, RAND_TRAP_POS_ARRAY[trapArray][newPos].nWorldY * 32)
        end
        PlayerIndex = playerIndexCache
    end
end

