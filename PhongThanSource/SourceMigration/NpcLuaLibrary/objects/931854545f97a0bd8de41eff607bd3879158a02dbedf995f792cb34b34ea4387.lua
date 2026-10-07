--description: Èýá¦»¤·¨Õß.lua
--author: yaoxin 
--date: 2009/09/09


instence_Task = 1606  --0=Î´½Ó 1=½Ó 2=ÕÒÄÏ¼«ÏÉÎÌ 3=ÕÒÑîê¯ 4=È¥É±BOSS 5=Íê³ÉÉ±BOSS 6=Íê³ÉÒýµ¼ÈÎÎñ 7=½Ó¹ý¹Ø 8=¹ýÌì¾ø 9=¹ýµØÁÒ 10=¹ý·çºð 11=Íê³É¹ý¹Ø


function OnDeath(npcindex)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(GetNpcTask(npcindex, 14))
    local nSubworldIdx = GetNpcTask(npcindex, 13)
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 15)

    local idx = -1
    local tempid = -1
    local flag = 0
    local nums = 0
    for k = 1, 3 do
        idx = GetNpcTask(npcindex, k)
        tempid = GetNpcTemplateID(idx)
        if (tempid >= 1324) and (tempid <= 1326) then
            nums = GetNpcTask(idx, 12) + 1
            SetNpcTask(idx, 12, nums)
        end
    end

    if (nums == 3) then
        InstanceMsg2All(GetNpcTask(GetNpcTask(npcindex, 4), 8), "TÇn Thiªn Qu©n", "<c=yel>Tèt l¾m! §· ®Õn lóc bæn Thiªn Qu©n ra tay råi, h·y mau vµo gi÷a ph¸p trËn, ta sÏ b¸o thï cho Hé Ph­ín!<c>")
        local TasknpcId = 0
        local AddTime = 0
        if (GetTeam() == 0) then
            if (GetTaskByte(instence_Task, 1) == 4) then
                local m, x, y = GetNpcWorldPos(npcindex)
                local lefttime = 40 * 60
                if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
                    lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
                end
                TasknpcId = AddNpc(1501, 80, SubWorld, x * 32, y * 32)
                SetNpcTimer(TasknpcId, "\\script\\ontimer\\É¾µô×Ô¼º.lua", lefttime)
            end
        else
            local oldPlayer = PlayerIndex
            for i = 1, GetTeamSize() do
                PlayerIndex = GetTeamMember(i)
                if (GetTaskByte(instence_Task, 1) == 4) then
                    if (AddTime == 0) then
                        local m, x, y = GetNpcWorldPos(npcindex)
                        local lefttime = 40 * 60
                        if (abs(LocalSystemTime() - nFirstEnterTime) > 0) then
                            lefttime = lefttime - abs(LocalSystemTime() - nFirstEnterTime)
                        end
                        TasknpcId = AddNpc(1501, 80, SubWorld, x * 32, y * 32)
                        SetInstanceTempValue(26, TasknpcId)
                        SetInstanceTempValue(27, GetNpcID(TasknpcId))
                        AddTime = AddTime + 1
                    end
                end
            end
        end
        PlayerIndex = oldPlayer
        flag = 1
    elseif (nums == 2) then
        InstanceMsg2All(GetNpcTask(GetNpcTask(npcindex, 4), 8), "TÇn Thiªn Qu©n", "<c=yel>Ta ®· xem th­êng ng­¬i råi, nh­ng muèn khiªu chiÕn víi bæn Thiªn Qu©n th× h·y ®¸nh b¹i Hé Ph­ín cuèi cïng cña ta ®·!<c>")
    elseif (nums == 1) then
        InstanceMsg2All(GetNpcTask(GetNpcTask(npcindex, 4), 8), "TÇn Thiªn Qu©n", "<c=yel>Kh¸ l¾m, nh­ng ng­¬i chØ míi ®¸nh b¹i 1 Hé Ph­ín, c«ng lùc cßn kÐm l¾m!<c>")
    end

    if (flag == 1) then
        local bossidx = GetNpcTask(npcindex, 4)--ÇØÌì¾ý
        SetNpcTask(bossidx, 0, 1)

        --É¾ÃÅ£¬
        idx = -1
        tempid = -1
        for i = 5, 8 do
            idx = GetNpcTask(npcindex, i)
            tempid = GetNpcTemplateID(idx)
            if (tempid == 1340) or (tempid == 1341) then
                DelNpc(idx)
            end
        end
    end

    DelNpc(npcindex)
    InstanceIndex = oldInstance
end