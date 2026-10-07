--Descript:¶­Ìì¾ı.lua
--Author:yangtao
--Date:09/9/28
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--4byte: 3ÈÎÎñ³É¹¦
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 End

function OnDeath(npcindex)
    -- É¾³ıÁÒ·ç²¢ÖØÖÃÁÒ·ç¸öÊı
    local isdropitem = 0
    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcindex, 41))
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 0)

    local AddNum = 0
    for i = 0, GetNpcTask(npcindex, 4) - 1 do
        local windidx = GetNpcTask(npcindex, 6 + i)
        local tempid = GetNpcTemplateID(windidx)
        if (tempid == 1339) then
            DelNpc(windidx)
        end
    end
    SetNpcTask(npcindex, 4, 0)

    -- ÈôÒÑ¾­Ë¢³öÌØÊâĞı·ç£¬É¾³ı
    if (GetNpcTask(npcindex, 60) ~= 0) then
        local windidx = GetNpcTask(npcindex, 60)
        local tempid = GetNpcTemplateID(windidx)
        if (tempid == 1578) then
            DelNpc(windidx)
        end
        SetNpcTask(npcindex, 60, 0)
    end

    local mapid = SubWorld

    local rank = random(1, 100)
    if (rank <= 10) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 2, 0, 0)
    else
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 1, 0, 0)
    end

    if (GetTeam() == 0) then
        local lefttime = 40 * 60
        if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
            lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
        end
        if (lefttime > 10 * 60) then
            ---×¢ÒâĞŞÕı²ÎÊı
            if (GetTaskByte(instence_Task, 2) == 2 and AddNum == 0) then
                local secnpcidx = AddNpc(1521, 1, SubWorld, 1400 * 32, 3165 * 32)
                SetInstanceTempValue(35, secnpcidx)
                SetInstanceTempValue(36, GetNpcID(secnpcidx))
                SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾üÇ°·æ.lua")
                AddNum = AddNum + 1
            end
        end

        if (GetTaskByte(instence_Task, 1) == 9) then
            SetTaskByte(instence_Task, 1, 10)
            TaskNote(1205, 3)
        end

        if ((GetTaskByte(instence_Task, 1) == 9) or (GetTaskByte(instence_Task, 1) == 10)) then
            isdropitem = isdropitem + 1
        end
    else
        local oldPlayer = PlayerIndex
        local lefttime = 40 * 60
        if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
            lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
        end
        if (lefttime > 10 * 60) then
            ---×¢ÒâĞŞÕı²ÎÊı
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                if (GetTaskByte(instence_Task, 2) == 2 and AddNum == 0) then
                    local secnpcidx = AddNpc(1521, 1, SubWorld, 1400 * 32, 3165 * 32)
                    SetInstanceTempValue(37, secnpcidx)
                    SetInstanceTempValue(38, GetNpcID(secnpcidx))
                    SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾üÇ°·æ.lua")
                    AddNum = AddNum + 1
                end
                if (GetTaskByte(instence_Task, 1) == 9) then
                    SetTaskByte(instence_Task, 1, 10)
                    TaskNote(1205, 3)
                end

                if ((GetTaskByte(instence_Task, 1) == 9) or (GetTaskByte(instence_Task, 1) == 10)) then
                    isdropitem = isdropitem + 1
                end

            end
        end
        PlayerIndex = oldPlayer
    end
    local rank = random(1, 100)

    if ((rank <= 30) and (isdropitem > 0)) then
        ThrowItem(npcindex, PlayerIndex, 3, 1050, 0, 1, 0, 0)
    end

    local lefttime2 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime2 = abs(LocalSystemTime() - nFirstEnterTime)
    end

    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®¸±±¾ÈÎÎñ at 2010.1.4 Begin
    Check_ShituExist(npcindex)
    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®¸±±¾ÈÎÎñ at 2010.1.4 End

    --add by liujifang for ºìÉ°ÕóÈÎÎñµÀ¾ßµôÂä at 2010-11 begin
    local year, month, day = GetYMD()
    if (year == 2010 and month == 11 and day >= 23 and day <= 25 and random(1, 100) <= 30) then
        ThrowItem(npcindex, -1, 3, 1141, 0, 1, 0, 0)
    elseif (random(1, 100) <= 12) then
        ThrowItem(npcindex, -1, 3, 1141, 0, 1, 0, 0)
    end
    --add by liujifang for ºìÉ°ÕóÈÎÎñµÀ¾ßµôÂä at 2010-11 end

    DelNpc(npcindex)
    --AddGlobalCountNews("¸±±¾Ö÷½Å±¾-·çºğÕó£¬¶­Ìì¾ıËÀÁË£¡", 1)
    WriteLog("§æng Thiªn Qu©n tö vong, mÊt " .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcindex, 41))
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 begin
    local lefttime1 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime1 = lefttime1 - abs(LocalSystemTime() - nFirstEnterTime)
    end
    local idx = AddNpc(999, 1, SubWorld, 1396 * 32, 3165 * 32)--¼ÓÃÅ
    if (idx == 0) or (SubWorld < 0) then
        idx = 0
        local _, _, _, _, nSubWorldIdx = GetInstanceBaseInfo(GetNpcTask(npcindex, 41))
        if (nSubWorldIdx >= 0) then
            idx = AddNpc(999, 1, nSubWorldIdx, 1396 * 32, 3165 * 32)--¼ÓÃÅ
        end
        if (idx == 0) then
            WriteLog("Vµo phã b¶n thÊt b¹i")
            DelNpc(npcindex)
            return 0
        end
    end

    SetNpcScript(idx, "\\script\\instance\\·çºğÕó´«ËÍÃÅ.lua")
    SetNpcName(idx, "Cöa chuyÓn tiÕp")
    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime1)

    -- ÔÚ¸±±¾±äÁ¿ÖĞ´æÏÂ´«ËÍÃÅ£¬ÎªÉ¾³ıÓÃ
    SetInstanceTempValue(33, idx)
    SetInstanceTempValue(34, GetNpcID(idx))
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    InstanceIndex = oldInstance
end

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin
function Check_ShituExist(npcidx)
    -- ±éÀúËùÔÚ¶ÓÎéµÄÍæ¼Ò£¬ÅĞ¶ÏÄ³Íæ¼ÒÊÇ·ñÔÚ¶ÓÎéÖĞ
    local nSize = GetTeamSize()
    if (nSize > 0) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Count, 1) == 10) then
                if (IsMantlePrentice(PlayerIndex) > 0) then
                    --Èç¹ûÍæ¼ÒÊÇÒÂ²§µÜ×Ó£¬Ôò²éÕÒÊ¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖĞ
                    local masterIdx = Check_MasterIdx(PlayerIndex)
                    if (masterIdx > 0) then
                        SetTaskByte(Task_Count, 4, 3)
                        Msg2Player("Hoµn thµnh nhiÖm vô §¹i ph¸ ThËp TuyÖt TrËn")
                        TaskNote(1521, 1)
                        PlayerIndex = masterIdx
                        SetTaskByte(Task_Count, 4, 3) --ÈÎÎñÍê³É
                        Msg2Player("Hoµn thµnh nhiÖm vô §¹i ph¸ ThËp TuyÖt TrËn")
                        TaskNote(1521, 1)
                    end
                end
            end
        end
    end
    return 0
end

function Check_MasterIdx(playerIdx)
    --±éÀú¶ÓÎé£¬Ñ°ÕÒÊ¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖĞ(ÕâÀïĞèÒª½Ó¿Ú) ÕâÀï²é¿´ Ê¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖĞ
    local nSize = GetTeamSize()
    local strMasterName = GetMantleMasterName()
    local selfIdx = PlayerIndex
    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if (strMasterName == GetName()) then
            PlayerIndex = selfIdx
            return GetTeamMember(i)
        end
    end
    return 0
end

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 End
