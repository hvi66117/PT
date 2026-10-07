function OnDeath(npcindex)

    PrepareForWarOne(npcindex)

    local w, x, y = GetWorldPos()
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            calc_task(w, npcindex, oldPlayer)
        end
        PlayerIndex = oldPlayer
    else

        calc_task(w, npcindex, PlayerIndex)
    end ;


end

function calc_task(w1, npcindex, killplayer)
    local w, x, y = GetWorldPos()
    if (w ~= w1) or (w ~= 67) then
        return 0
    end

    if (GetTask(408) == 3) then
        local today = math.floor(LocalSystemTime() / 86400)
        if (today == GetTask(409)) then
            local count = GetTask(407)
            if (count > 0) then
                count = count - 1
                SetTask(407, count)
                if (count == 0) then
                    ScrollMessage("ÄãHoµn thµnh nhiÖm vô ÁË½µ·þÇ¿»¯·É¼×µÄ")
                    SetTask(408, 100000)
                    TaskNote(65, 3)
                else
                    ScrollMessage("»¹Ðè½µ·þ" .. count .. "Phi Gi¸p")
                    TaskNote(65, 0, count, "Phi Gi¸p")
                end
            end
        else
            SetTask(407, 0)
            SetTask(408, 0)
            TaskNote(65, -1)
            TopMessage(11610)
            Msg2Player("NhiÖm vô V¹n Tiªn trËn ®· qu¸ h¹n")
        end
    end

    local x1 = math.random(1, 10000)
    if ((x1 >= 1) and (x1 <= 20)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 3, 116, 0, 0, 0, 1)
        Msg2Player("Qu¸i Phi Gi¸p ®· bÞ b¹n khuÊt phôc, r¬i ra 1 §¹i ®Þa nh·n")
        PlayerIndex = oldPlayer
    elseif ((x1 > 9990) and (x1 <= 10000)) then
        local oldPlayer = PlayerIndex
        PlayerIndex = killplayer
        ThrowItem(npcindex, PlayerIndex, 6, 1, 717, 0, 0, 1)
        Msg2Player("Qu¸i Phi Gi¸p ®· bÞ b¹n khuÊt phôc, r¬i ra 1 Ng­ng ThÇn §¬n")
        PlayerIndex = oldPlayer
    end ;


end

g_TaskPrepareWar = 1951

WarTaskTable = {
    [1] = { needPower = 50000, needMoney = 500000, needCount = 100, rewardCount = 12 },
    [2] = { needPower = 40000, needMoney = 200000, needCount = 80, rewardCount = 11 },
    [3] = { needPower = 30000, needMoney = 100000, needCount = 70, rewardCount = 10 },
    [4] = { needPower = 25000, needMoney = 50000, needCount = 60, rewardCount = 9 },
    [5] = { needPower = 20000, needMoney = 20000, needCount = 50, rewardCount = 8 },
    [6] = { needPower = 15000, needMoney = 10000, needCount = 40, rewardCount = 7 },
    [7] = { needPower = 10000, needMoney = 5000, needCount = 30, rewardCount = 6 },
    [8] = { needPower = 50000, needMoney = 2000, needCount = 20, rewardCount = 5 },
}
function PrepareForWarOne(npcindex)
    local GetItemPercent = 500
    local ItemID = { 3, 1240, 0, 0 }
    local YY, MM, DD = GetYMD()
    if not (YY == 2014 and ((MM == 9 and DD >= 26) or (MM == 10 and DD <= 9))) then
        return
    end

    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 252) + 1
    local nTaskDay = GetTaskByte(g_TaskPrepareWar, 1)
    if (nToday ~= nTaskDay and nTaskDay ~= 0) then
        Msg2Player("ÄúÉÏ´ÎµÄÈÎÎñÒÑ±»Çå³ý")
        SetTaskByte(g_TaskPrepareWar, 2, 0)
        SetTaskByte(g_TaskPrepareWar, 3, 0)
        SetTaskByte(g_TaskPrepareWar, 1, nToday)
        TaskNote(1945, -1)
    end

    if (HaveIBBuff(1685) <= 0) then
        return
    end

    local nIndex = GetTaskByte(g_TaskPrepareWar, 2)
    local nTaskStep = GetTaskByte(g_TaskPrepareWar, 3)
    if (nTaskStep == 1) then
        if (nIndex < 0 or nIndex > table.getn(WarTaskTable)) then
            nIndex = 1
        end

        local nRand = math.random(1, 10000)
        if (nRand > GetItemPercent) then
            return
        end
        AddNormalItemPile(ItemID[1], ItemID[2], ItemID[3], ItemID[4], 0, 0)
        Msg2Player("ÄúÔÚÍòÏÉÕóÖÐ, ÒâÍâµÄ nhËn ®­îc 1 c¸i Ô¶¹Å²ÐÆ¬, ¿´À´Ô¶¹ÅÐ×ÊÞ¿ÉÄÜÖØÐÂ½µÊÀ.")
        local nItemCount = IsExistItem(3, 1240, 0, 0)
        if (nItemCount >= WarTaskTable[nIndex].needCount) then
            TaskNote(1945, 2, nItemCount, WarTaskTable[nIndex].needCount)
        else
            TaskNote(1945, 1, nItemCount, WarTaskTable[nIndex].needCount)
        end
    end
end

