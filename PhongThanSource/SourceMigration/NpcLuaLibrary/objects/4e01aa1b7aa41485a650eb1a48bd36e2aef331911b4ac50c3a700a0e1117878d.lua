--description: ÇØÌì¾ı.lua
--author: yaoxin
--date: 2009/09/9
instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒıµ¼ÈÎÎñ 7=½Ó¹ı¹Ø 8=¹ıÌì¾ø 9=¹ıµØÁÒ 10=¹ı·çºğ 11=Íê³É¹ı¹Ø

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊı
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊı
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇĞÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñĞòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--4byte:  3ÈÎÎñ³É¹¦
--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 End

function OnDeath(npcindex)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcindex, 9))

    --AddGlobalCountNews("¸±±¾Ö÷½Å±¾-Ìì¾øÕó£¬ÇØÌì¾ıËÀÁË£¡", 1)

    local idx = -1
    for i = 23, 35 do
        idx = GetNpcTask(npcindex, i)
        if (GetNpcTemplateID(idx) == 1336) then
            DelNpc(idx)
        end
    end

    local rank = random(1, 100)
    if (rank <= 2) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 2, 0, 0)
    else
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 1, 0, 0)
    end
    local lefttime2 = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime2 = abs(LocalSystemTime() - nFirstEnterTime)
    end
    WriteLog("TÇn Thiªn Qu©n tö vong, mÊt " .. lefttime2 .. " gi©y, id: " .. GetNpcTask(npcindex, 9))

    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 1) == 7) then
            SetTaskByte(instence_Task, 1, 8)
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 1) == 7) then
                SetTaskByte(instence_Task, 1, 8)
                TaskNote(1205, 1)
            end
        end
        PlayerIndex = oldPlayer
    end
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 begin
    local lefttime = 40 * 60
    if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
        lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
    end
    local dooridx = AddNpc(999, 1, SubWorld, 1624 * 32, 3228 * 32)--¼ÓÃÅ
    if (dooridx == 0) or (SubWorld < 0) then
        dooridx = 0
        if (GetNpcTask(npcindex, 2) >= 0) then
            dooridx = AddNpc(999, 1, GetNpcTask(npcindex, 2), 1624 * 32, 3228 * 32)--¼ÓÃÅ
        end
        if (dooridx == 0) then
            WriteLog("Phã b¶n thÊt b¹i!")
            DelNpc(npcindex)
            return 0
        end
    end

    SetNpcScript(dooridx, "\\script\\instance\\Ìì¾øÕó´«ËÍÃÅ.lua")
    SetNpcTimer(dooridx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime)
    -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    DelNpc(npcindex)
end
