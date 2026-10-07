--description: ·ç»ðÂÖ£¬·ç»ðÂÖ´óÈü»î¶¯Npc
--author: zhaoqingsong
--date: 2008-11-25

-- ·ç»ðÂÖ´óÈü»î¶¯

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ
-- 2 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1 Î÷ÃÅÒ½Éú£¬2 ÄÏÃÅÒ½Éú£¬3 ¶«ÃÅÒ½Éú£¬4 æûÍõ
Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278    -- ±¨ÃûÊ±¼ä
Task_Ring_BindingIndex = 1279    -- °ó¶¨µÄNpcIndex
Task_Ring_BindingID = 1280    -- °ó¶¨µÄNpcID

Task_Ring_NPC_FreezeTime = 1    -- ÀäÈ´Ê±¼ä´Á
Task_Ring_NPC_BuffATime = 2    -- BuffAÊ±¼ä´Á
Task_Ring_NPC_BuffBTime = 3    -- BuffBÊ±¼ä´Á
Task_Ring_NPC_BuffCTime = 4    -- BuffCÊ±¼ä´Á
Task_Ring_NPC_BuffDTime = 5    -- BuffDÊ±¼ä´Á
Task_Ring_NPC_BindingID = 6    -- °ó¶¨Íæ¼ÒID
Task_Ring_NPC_BindingIDFlag = 7  --°ó¶¨Íæ¼ÒID·ûºÅ

Global_Ring_EntryCount = 164 -- È«¾Ö±äÁ¿£¬±¨ÃûÈËÊý

Buff_Ring_Going = 487   -- ½øÐÐBuff
Buff_Ring_BuffA = 488   -- ËÙ¶È¼õ°ëBuff
Buff_Ring_BuffB = 489   -- ·´ÏòÅÜ¶¯Buff
Buff_Ring_BuffC = 490   -- ËÙ¶È¼Ó±¶Buff
Buff_Ring_BuffD = 491   -- ¼õËÙ10%Buff

Task_Info_Ring = 1020   -- ·ç»ðÂÖ´óÈüF11

Task_Ring_Match_Second = 600 -- Ê®·ÖÖÓÒ»³¡±ÈÈü

--AS GaoJingwei 2009/08/02
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02

--Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
Noon_Active_Event = 7    --Îç¼ä»î¶¯ÊÀ½çÊÂ¼þ
Noon_Active_Event_Day = 1    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-Ê±¼ä±äÁ¿
Noon_Active_Event_Num = 2    --Îç¼ä»î¶¯ÊÀ½çÊ±¼ä-»î¶¯ÐòºÅ

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
--Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End

function main()
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()

    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if (H < 11 or H >= 14) then
            DelNpc(DialogNpcIdx)
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            DelNpc(DialogNpcIdx)
            return
        end
    end
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin

    local taskStatus = GetTaskByte(Task_Ring_Status, 1)
    local taskStep = GetTaskByte(Task_Ring_Status, 2)
    local haveDriveBuff = HaveIBBuff(Buff_Ring_Going)
    if (haveDriveBuff == 0) then
        Msg2Player("ChØ cã sö dông Hçn Thiªn L¨ng míi cã thÓ kÝch ®éng ®­îc Phong Háa lu©n!!!")
        return
    elseif (taskStatus == 0 or taskStep == 0) then
        return
    else
        local localTime = LocalSystemTime()
        local timestapFreeze = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_FreezeTime)
        local selfRingIndex = GetTask(Task_Ring_BindingIndex)
        if (selfRingIndex ~= DialogNpcIdx) then
            local rand = random(1, 100)
            if (rand > 50) then
                Msg2Player("B¹n kh«ng ®ñ søc sö dông Hçn Thiªn L¨ng!")
                return
            end
            if (localTime < timestapFreeze) then
                Msg2Player("B¹n ®Èy Hçn Thiªn L¨ng kh«ng ®ñ uy lùc!")
                return
            end
        end
        local timestapA = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BuffATime)
        local timestapB = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BuffBTime)
        local timestapC = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BuffCTime)
        local timestapD = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BuffDTime)
        local npcMapid, npcx, npcy = GetNpcWorldPos(DialogNpcIdx)
        local mapid, x, y = GetWorldPos()
        if ((npcx - x) == 0 and (npcy - y) == 0) then
            x = npcx + random(1, 4)
            y = npcy + random(1, 4)
        end
        local seamDistance = floor(sqrt((npcx - x) ^ 2 + (npcy - y) ^ 2))
        local seamX = (9) * ((npcx - x) / seamDistance)
        local seamY = (9) * ((npcy - y) / seamDistance)
        if (timestapB > localTime) then
            seamX = seamX * (-1)
            seamY = seamY * (-1)
        end
        local ringSpeed = GetNpcBaseRunSpeed(DialogNpcIdx)
        if (timestapA > localTime) then
            ringSpeed = floor(ringSpeed * 0.5)
        end
        if (timestapC > localTime) then
            ringSpeed = ringSpeed * 2
        end
        if (timestapD > localTime) then
            ringSpeed = floor(ringSpeed * 0.2)
        end
        SetNpcRunSpeed(DialogNpcIdx, ringSpeed)
        NpcRun(DialogNpcIdx, npcx + seamX, npcy + seamY)
        if (selfRingIndex ~= DialogNpcIdx) then
            SetNpcTask(DialogNpcIdx, Task_Ring_NPC_FreezeTime, localTime + 20)
        end

        if (selfRingIndex ~= DialogNpcIdx) then
            -- ²»ÊÇ×Ô¼ºµÄÂÖ×Ó

            local bindPlayerID = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BindingID)
            local bindPlayerIDFlag = GetNpcTask(DialogNpcIdx, Task_Ring_NPC_BindingIDFlag)
            local masterPlayerID = (bindPlayerIDFlag == 1) and (bindPlayerID + 2 ^ 31) or bindPlayerID
            local masterPlayerIndex = SearchPlayerById(masterPlayerID)
            local opponentName = "®èi thñ"
            if (masterPlayerIndex > 0) then
                local playerIndexCache = PlayerIndex
                PlayerIndex = masterPlayerIndex
                local mapid, x, y = GetWorldPos()
                if (mapid == 21) then
                    Msg2Player("Phong Háa lu©n ®· bÞ ng­êi kh¸c ®ông ph¶i! Xin cÈn thËn!")
                    TopMessage("Phong Háa lu©n ®· bÞ ng­êi kh¸c ®ông ph¶i!")
                end
                opponentName = GetName()
                PlayerIndex = playerIndexCache
            end


        end
    end
end
