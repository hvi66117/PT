--description: »ìÌìç±ÓÒ»÷½Å±¾
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

Global_Ring_EntryCount = 164 -- È«¾Ö±äÁ¿£¬±¨ÃûÈËÊý

Buff_Ring_Going = 487   -- ½øÐÐBuff
Buff_Ring_BuffA = 488   -- ËÙ¶È¼õ°ëBuff
Buff_Ring_BuffB = 489   -- ·´ÏòÅÜ¶¯Buff
Buff_Ring_BuffC = 490   -- ËÙ¶È¼Ó±¶Buff
Buff_Ring_BuffD = 491   -- ¼õËÙ10%Buff

Task_Info_Ring = 1020   -- ·ç»ðÂÖ´óÈüF11

Task_Ring_Match_Second = 600 -- Ê®·ÖÖÓÒ»³¡±ÈÈü

-- ·ç»ðÂÖÍ¶·Å×ø±ê
Ring_XY = {
    { x = 217 * 32, y = 191 * 32, desc = "[217.191]" },
    { x = 218 * 32, y = 191 * 32, desc = "[218.191]" },
    { x = 219 * 32, y = 191 * 32, desc = "[219.191]" },
    { x = 220 * 32, y = 191 * 32, desc = "[220.191]" },
    { x = 221 * 32, y = 191 * 32, desc = "[221.191]" },
    { x = 217 * 32, y = 190 * 32, desc = "[217.190]" },
    { x = 218 * 32, y = 190 * 32, desc = "[218.190]" },
    { x = 219 * 32, y = 190 * 32, desc = "[219.190]" },
    { x = 220 * 32, y = 190 * 32, desc = "[220.190]" },
    { x = 221 * 32, y = 190 * 32, desc = "[221.190]" },
}

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
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            DelNpc(TrapNpcIdx)
            return
        end
    end
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 21) then
        Talk(1, "no", "VËt nµy chØ cã thÓ sö dông ë <c=g>TriÒu Ca<c>!")
        return
    end

    local localTime = LocalSystemTime()
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
    local nStartHour = 19
    if nNoonActiveOn > 0 then
        nStartHour = 11
    end
    local taskTime = mod(localTime, 86400) - 3600 * nStartHour
    --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End

    local taskNumber = floor(taskTime / Task_Ring_Match_Second) + 1
    local taskGotime = mod(taskTime, Task_Ring_Match_Second)

    local taskStatus = GetTaskByte(Task_Ring_Status, 1)
    local taskStep = GetTaskByte(Task_Ring_Status, 2)
    if (taskStatus == 0) then
        Talk(1, "no", "VËt nµy chØ cã ng­êi nµo ®· ®· b¸o danh tham gia <c=g>Phong Háa L«i ®µi<c> ë LÔ quan (TriÒu Ca)míi cã thÓ sö dông!")
        return
    else
        local lastEntryTime = GetTask(Task_Ring_Accept_Time)
        --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 Begin
        local entryNumber = floor((mod(lastEntryTime, 86400) - 3600 * nStartHour) / Task_Ring_Match_Second) + 1
        if (floor(localTime / 86400) ~= floor(lastEntryTime / 86400)) then
            --Modified By Guoqun for Ã¿ÈÕÎç¼ä»î¶¯ at 2010-09-20 End
            Talk(1, "no", "Hçn Thiªn L¨ng: §· qu¸ thêi h¹n <c=g>trËn Phong H¶o L«i §µi mµ b¹n<c> ®¨ng ký, h·y sö dông vµo lÇn sau.")        --Modified By Guoqun for ÎÄ×ÖÐÞÕý
            return
        elseif (entryNumber < taskNumber) then
            Talk(1, "no", "Hçn Thiªn L¨ng: §· qu¸ thêi h¹n thi ®Êu cña <c=g>trËn Phong H¶o L«i §µi mµ b¹n<c> ®¨ng ký, h·y sö dông vµo lÇn sau.") --Modified By Guoqun for ÎÄ×ÖÐÞÕý
            return
        elseif (taskStep > 0) then
            Talk(1, "no", "TrËn thi ®Êu nµy b¹n ®· sö dông Hçn Thiªn L¨ng, kh«ng thÓ sö dông tiÕp!")
            return
        elseif (GetIBBuffCount() >= 26) then
            -- ¼õÐ¡¿ÉÓÃBuffµÄÊýÁ¿£¬ÒÔ±¸±ÈÈüÖÐÊ¹ÓÃ
            Talk(1, "no", "Trªn ng­êi b¹n cã qu¸ nhiÒu tr¹ng th¸i, kh«ngthÓ më Hçn Thiªn L¨ng nµy! Xin sö dông trang bÞ kh¸c vµo thi ®Êu!")
            return
        else
            local xyIdx = GetTaskByte(Task_Ring_Status, 3)
            local remainSecond = Task_Ring_Match_Second - taskGotime - 1
            if (HaveNormalItem(6, 1, 398, 1) > 0) then
                DelNormalItem(6, 1, 398, 1)
            else
                DelNormalItemInQuick(6, 1, 398, 1)
            end
            SetTaskByte(Task_Ring_Status, 2, 1)
            AddIBBuff(Buff_Ring_Going, remainSecond)
            TaskNote(Task_Info_Ring, 1)
            TopMessage("Mau mang Phong Háa lu©n ®Õn T©y m«n gÆp §¹i phu")
            Msg2Player("B¹n ®· cã thÓ kÝch ho¹t Phong Háa lu©n råi, mau mang nã ®Õn T©y m«n gÆp §¹i phu. Phong Háa lu©n cña b¹n ®ang ë täa ®é" .. Ring_XY[xyIdx].desc .. ".")
            Talk("B¹n ®· cã thÓ kÝch ho¹t Phong Háa lu©n råi, mau mang nã ®Õn T©y m«n gÆp §¹i phu. Phong Háa lu©n cña b¹n ®ang ë täa ®é" .. Ring_XY[xyIdx].desc .. ".")
        end
    end
end

function no()
    CloseDialog()
end
