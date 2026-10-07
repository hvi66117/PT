--Descript:ËïÌì¾ıËÀÍö½Å±¾
--Author:yangtao
--Date:2009/12/22

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--4byte:  3ÈÎÎñ³É¹¦
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 End

-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
TaskInfo_cbal = 1514
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø
--9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø 12=ÁìÈ¡ÁË³ı±©°²Á¼ÈÎÎñ 13=É±ËÀÔ¬Ìì¾ı 14=É±ËÀ½ğ¹âÊ¥Ä¸ 15=É±ËÀËïÌì¾ı 16=Íê³ÉÁË³ı±©°²Á¼ÈÎÎñ
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

function OnDeath(npcindex)
    -- Ìí¼ÓÍ¨ÍùÎ÷áªµÄ´«ËÍÃÅ
    local mapid = SubWorld

    -- bossËÀÍöµôÂäÓñÅå
    local possibility = random(1, 100)
    if (possibility <= 32) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 1, 0, 0)
    elseif (possibility <= 35) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 2, 0, 0)
    elseif (possibility <= 83) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 3, 0, 0)
    elseif (possibility <= 95) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 4, 0, 0)
    elseif (possibility <= 99) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 5, 0, 0)
    else
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 6, 0, 0)
    end


    -- É¾³ıÕÙ»½µÄºÚÉ³¾«Áé
    for i = 10, 19 do
        local npcidx = GetNpcTask(npcindex, i)
        if (npcidx > 0) then
            local npcID = GetNpcTask(npcindex, i + 10)
            if (npcID == GetNpcID(npcidx)) then
                DelNpc(npcidx)
            end
        end
    end

    -- ¼ÇÂ¼Íæ¼ÒÉ±ËÀËïÌì¾ıËùÓÃÊ±¼ä£¬´ÓÈëÕó¿ªÊ¼¼ÆËã
    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcindex, 5))
    local lefttime = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime = abs(LocalSystemTime() - nFirstEnterTime)
    end

    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
    Check_cbal(npcindex)
    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®¸±±¾ÈÎÎñ at 2010.1.4 Begin
    Check_ShituExist(npcindex)
    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÖ®¸±±¾ÈÎÎñ at 2010.1.4 End

    --add by liujifang for ºìÉ°ÕóÈÎÎñµÀ¾ßµôÂä at 2010-11 begin
    local year, month, day = GetYMD()
    if (year == 2010 and month == 11 and day >= 23 and day <= 25 and random(1, 100) <= 15) then
        ThrowItem(npcindex, -1, 3, 1142, 0, 1, 0, 0)
    elseif (random(1, 100) <= 10) then
        ThrowItem(npcindex, -1, 3, 1142, 0, 1, 0, 0)
    end
    --add by liujifang for ºìÉ°ÕóÈÎÎñµÀ¾ßµôÂä at 2010-11 end

    WriteLog("T«n Thiªn Qu©n tö vong, mÊt " .. lefttime .. " gi©y, id: " .. GetNpcTask(npcindex, 5))

    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 begin
    local lefttime1 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime1 = lefttime1 - abs(LocalSystemTime() - nFirstEnterTime)
    end
    local idx = AddNpc(999, 1, SubWorld, 1613 * 32, 3196 * 32)--¼ÓÃÅ
    if (idx == 0) or (SubWorld < 0) then
        idx = 0
        local _, _, _, _, nSubWorldIdx = GetInstanceBaseInfo(GetNpcTask(npcindex, 5))
        if (nSubWorldIdx >= 0) then
            idx = AddNpc(999, 1, nSubWorldIdx, 1613 * 32, 3196 * 32)--¼ÓÃÅ
        end
        if (idx == 0) then
            WriteLog("Vµo phã b¶n thÊt b¹i")
            DelNpc(npcindex)
            return 0
        end
    end

    SetNpcScript(idx, "\\script\\instance\\»¯ÑªÕó´«ËÍÃÅ.lua")
    SetNpcName(idx, "Cöa chuyÓn tiÕp")
    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime1)

    -- ÔÚ¸±±¾±äÁ¿ÖĞ´æÏÂ´«ËÍÃÅ£¬ÎªÉ¾³ıÓÃ
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 1)
    SetInstanceTempValue(21, idx)
    SetInstanceTempValue(22, GetNpcID(idx))
    InstanceIndex = oldInstance
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    -- É¾³ıboss
    DelNpc(npcindex)
end



--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®½ÙÄÑÈÎÎñ at 2009.12.28 Begin
function Check_ShituExist(npcidx)
    -- ±éÀúËùÔÚ¶ÓÎéµÄÍæ¼Ò£¬ÅĞ¶ÏÄ³Íæ¼ÒÊÇ·ñÔÚ¶ÓÎéÖĞ
    local nSize = GetTeamSize()
    if (nSize > 0) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Count, 1) == 11) then
                if (IsMantlePrentice(PlayerIndex) > 0) then
                    --Èç¹ûÍæ¼ÒÊÇÒÂ²§µÜ×Ó£¬Ôò²éÕÒÊ¦¸¸ÊÇ·ñÔÚ¶ÓÎéÖĞ
                    local masterIdx = Check_MasterIdx(PlayerIndex)
                    if (masterIdx > 0) then
                        SetTaskByte(Task_Count, 4, 3)
                        Msg2Player("Hoµn thµnh nhiÖm vô c«ng ph¸ ThËp TuyÖt TrËn!")
                        TaskNote(1521, 1)
                        PlayerIndex = masterIdx
                        SetTaskByte(Task_Count, 4, 3) --ÈÎÎñÍê³É
                        Msg2Player("Hoµn thµnh nhiÖm vô c«ng ph¸ ThËp TuyÖt TrËn!")
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

-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
function Check_cbal(npcindex)
    local nSize = GetTeamSize()
    local oldPlayer = PlayerIndex
    local bDrop = 0

    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if ((GetTaskByte(instence_Task, 1) == 14) or (GetTaskByte(instence_Task, 1) == 15)) then
            SetTaskByte(instence_Task, 1, 15)
            TaskNote(TaskInfo_cbal, 3)
            bDrop = 1
        end
    end

    -- µôÂäËïÌì¾ıÊÖÁî
    if (bDrop == 1) then
        local possibility = random(1, 100)
        if (possibility <= 15) then
            ThrowItem(npcindex, PlayerIndex, 3, 1089, 0, 1, 0, 0)
        end
    end
    PlayerIndex = oldPlayer
end
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end
