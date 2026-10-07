--Descript:ÕÔÌì¾ı.lua
--Author:GaoJingwei
--Date:090912
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--4byte:  3ÈÎÎñ³É¹¦
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 End

function OnDeath(npcIdx)
    local flagNum = GetNpcTask(npcIdx, 3) - 1
    local flagIndex = 0

    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcIdx, 2)

    for i = 4, flagNum do
        flagIndex = GetNpcTask(npcIdx, i)
        if (GetNpcTask(npcIdx, i + 60) == GetNpcID(flagIndex)) then
            DelNpc(flagIndex)
        end
    end

    local rank = random(1, 100)
    if (rank <= 10) then
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 2, 0, 0)
    else
        ThrowItem(npcIdx, PlayerIndex, 0, 12, 0, 1, 0, 0)
    end

    --InstanceMsg2All(InstanceIndex, "",GetName().."ÕÔÌì¾ıËÀÁË")
    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 1) == 8) then
            SetTaskByte(instence_Task, 1, 9)
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 1) == 8) then
                SetTaskByte(instence_Task, 1, 9)
                TaskNote(1205, 2)
            end
        end
        PlayerIndex = oldPlayer
    end

    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcIdx, 61))
    local lefttime2 = 40 * 60

    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime2 = abs(LocalSystemTime() - nFirstEnterTime)
    end

    WriteLog("TriÖu Thiªn Qu©n tö vong, mÊt " .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcIdx, 61))
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 begin
    local lefttime1 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime1 = lefttime1 - abs(LocalSystemTime() - nFirstEnterTime)
    end
    local dooridx = AddNpc(999, 1, SubWorld, 1637 * 32, 3108 * 32)--¼ÓÃÅ
    if (dooridx == 0) or (SubWorld < 0) then
        dooridx = 0
        local _, _, _, _, nSubWorldIdx = GetInstanceBaseInfo(GetNpcTask(npcIdx, 61))
        if (nSubWorldIdx >= 0) then
            dooridx = AddNpc(999, 1, nSubWorldIdx, 1637 * 32, 3108 * 32)--¼ÓÃÅ
        end
        if (dooridx == 0) then
            WriteLog("Vµo phã b¶n thÊt b¹i")
            DelNpc(npcIdx)
            return 0
        end
    end

    SetNpcScript(dooridx, "\\script\\instance\\µØÁÒÕó´«ËÍÃÅ.lua")
    SetNpcTimer(dooridx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime1)

    --ÉèÖÃÃÅ£¬±ãÓÚ¸±±¾ÊÍ·ÅÊ±É¾³ı
    SetInstanceTempValue(21, dooridx);
    SetInstanceTempValue(22, GetNpcID(dooridx));
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    DelNpc(npcIdx)
    InstanceIndex = oldInstance
end


