--Descript:½ğ¹âÊ¥Ä¸ËÀÍö½Å±¾
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
    -- Ìí¼ÓÍ¨Íù»¯ÑªÕóµÄ´«ËÍÃÅ
    local mapid = SubWorld

    -- bossËÀÍöµôÂäÓñÅå
    local possibility = random(1, 100)
    if (possibility <= 45) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 1, 0, 0)
    elseif (possibility <= 50) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 2, 0, 0)
    elseif (possibility <= 85) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 3, 0, 0)
    else
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 4, 0, 0)
    end

    -- ¼ÇÂ¼Íæ¼ÒÉ±ËÀ½ğ¹âÊ¥Ä¸ËùÓÃÊ±¼ä£¬´ÓÈëÕó¿ªÊ¼¼ÆËã
    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcindex, 1))
    local lefttime = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime = abs(LocalSystemTime() - nFirstEnterTime)
    end

    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
    Check_cbal()
    -- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end

    WriteLog("Kim Quang Th¸nh MÉu tö vong, mÊt " .. lefttime .. " gi©y, id: " .. GetNpcTask(npcindex, 1))

    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 Begin
    local lefttime1 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime1 = lefttime1 - abs(LocalSystemTime() - nFirstEnterTime)
    end
    local idx = AddNpc(999, 1, SubWorld, 1651 * 32, 3143 * 32)--¼ÓÃÅ
    if (idx == 0) or (SubWorld < 0) then
        idx = 0
        local _, _, _, _, nSubWorldIdx = GetInstanceBaseInfo(GetNpcTask(npcindex, 1))
        if (nSubWorldIdx >= 0) then
            idx = AddNpc(999, 1, nSubWorldIdx, 1651 * 32, 3143 * 32)--¼ÓÃÅ
        end
        if (idx == 0) then
            WriteLog("Vµo phã b¶n thÊt b¹i")
            DelNpc(npcindex)
            return 0
        end
    end

    SetNpcScript(idx, "\\script\\instance\\½ğ¹âÕó´«ËÍÃÅ.lua")
    SetNpcName(idx, "Cöa chuyÓn tiÕp")
    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime1)

    -- ÔÚ¸±±¾±äÁ¿ÖĞ´æÏÂ´«ËÍÃÅ£¬ÎªÉ¾³ıÓÃ

    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 5)

    SetInstanceTempValue(81, idx)
    SetInstanceTempValue(82, GetNpcID(idx))

    InstanceIndex = oldInstance
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    -- É¾³ıboss
    DelNpc(npcindex)
end


-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 begin
function Check_cbal()
    local nSize = GetTeamSize()
    local oldPlayer = PlayerIndex

    for i = 1, nSize do
        PlayerIndex = GetTeamMember(i)
        if (GetTaskByte(instence_Task, 1) == 13) then
            SetTaskByte(instence_Task, 1, 14)
            TaskNote(TaskInfo_cbal, 2)
        end
    end
    PlayerIndex = oldPlayer
end
-- ¸±±¾ÈÎÎñ³ı±©°²Á¼ Add by yangtao at 2010/1/5 end
