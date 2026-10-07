Task_FuTouBang_First = 1877

Task_FuTouBang_InstanceID = 1879

Task_FuTouBang_InstanceIndex = 1880
MAXKILLCOUNT = 100
BOSSTABLE = { 1968, 214 * 8, 206 * 16 }
function OnDeath(npcIdx)
    local oldInstance = InstanceIndex
    InstanceIndex = GetTask(Task_FuTouBang_InstanceIndex)
    local nInstanceID = GetTask(Task_FuTouBang_InstanceID)
    local nInstanceState = GetTaskByte(Task_FuTouBang_First, 3)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(nInstanceID)

    local nLevel = GetLevel()
    local nNpcLevel = GetNpcLevel(npcIdx)
    local nDisLevel = nLevel - nNpcLevel
    local nRandom = math.random(1, 100)

    if (nDisLevel <= 10) then
        if (nRandom <= 5) then
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
        elseif (nRandom <= 40) then
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
        end
    elseif (nDisLevel <= 20) then
        if (nRandom <= 25) then
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
        end
    elseif (nDisLevel <= 30) then
        if (nRandom <= 10) then
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
        end
    else
        if (nRandom <= 5) then
            ThrowItem(npcIdx, -1, 3, 1196, 0, 1, 0, 0)
        end
    end

    local nKillCount = (GetInstanceTempValue(4) + 1)
    SetInstanceTempValue(4, nKillCount)
    if (nKillCount < MAXKILLCOUNT and math.mod(nKillCount, 10) == 0) then
        InstanceMsg2All(InstanceIndex, "Th«ng b¸o", "<c=yel> c¸c ng­¬i ®· bÞ ®¸nh b¹i" .. nKillCount .. " thµnh viªn Phñ §Çu Bang, h·y cè g¾ng thªm, ®¹t sè l­îng nhÊt ®Þnh sÏ dÉn dô ra thñ lÜnh Phñ §Çu Bang!<c>")
    elseif (nKillCount == MAXKILLCOUNT) then

        local BossLevel = GetInstanceTempValue(5)
        if (BossLevel <= 0) then
            BossLevel = 30
        end
        local bossidx = AddNpc(BOSSTABLE[1], BossLevel, nSubWorldIdx, BOSSTABLE[2] * 32, BOSSTABLE[3] * 32)
        if (bossidx > 0) then
            SetNpcTask(bossidx, 8, InstanceIndex)
            SetNpcTask(bossidx, 9, nInstanceID)
            InstanceMsg2All(InstanceIndex, "Háa Tµ ThÇn", "<c=yel>Hai phÕ vËt ë phÝa tr­íc kh«ng thÓ ng¨n c¹n c¸c ng­¬i sao? Xem ra ta ph¶i ®Ých th©n ra tay!<c>")
            SetInstanceTempValue(12, bossidx)
            SetInstanceTempValue(15, GetNpcID(bossidx))
        end
    end
    InstanceIndex = oldInstance

end

