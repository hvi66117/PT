gMonsterMessageGroup = 160
gMonsterAttackInitFlag = 159
gMonsterGroup = {}

gCityMonsterTemplate = {
    { NpcTemplate = 1420, Level = 40, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Qu¸i Thi Hoµng ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1420, Level = 40, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Qu¸i Thi Hoµng ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1428, Level = 40, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Thi Hoµng ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1428, Level = 40, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Thi Hoµng ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1444, Level = 30, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim ThiÕt §iÓm thÇn ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1421, Level = 55, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1437, Message = "Qu¸i Phi Gi¸p ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1421, Level = 55, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1437, Message = "Qu¸i Phi Gi¸p ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1429, Level = 55, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1437, Message = "Phi Gi¸p ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1429, Level = 55, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1437, Message = "Phi Gi¸p ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1445, Level = 30, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Cöu Linh ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1422, Level = 60, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1438, Message = "Qu¸i Ngäc N÷ ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1422, Level = 60, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1438, Message = "Qu¸i Ngäc N÷ ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1430, Level = 60, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1438, Message = "Ngäc N÷ ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1430, Level = 60, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1438, Message = "Ngäc N÷ ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1446, Level = 60, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Hçn §én ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1423, Level = 70, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "Qu¸i D· Mao thÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1423, Level = 70, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "Qu¸i D· Mao thÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1431, Level = 70, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "D· Mao thÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1431, Level = 70, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "D· Mao thÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1447, Level = 60, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Cïng Kú ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1424, Level = 80, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Qu¸i Tö Linh ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1424, Level = 80, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Qu¸i Tö Linh ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1432, Level = 80, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Tö Linh b¾t ®Çu tÊn c«ng råi", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1432, Level = 80, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Tö Linh b¾t ®Çu tÊn c«ng ®iªn cuång", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1448, Level = 60, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Thao ThiÕt ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1425, Level = 90, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Qu¸i HuyÔn Tinh ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1425, Level = 90, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Qu¸i HuyÔn Tinh ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1433, Level = 90, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "HuyÔn Tinh ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1433, Level = 90, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "HuyÔn Tinh ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1449, Level = 60, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim §µo Ngét ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1426, Level = 95, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Qu¸i Xa BØ Phu Nh©n ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1426, Level = 95, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Qu¸i Xa BØ Phu Nh©n ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1434, Level = 95, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Xa BØ Phu Nh©n ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1434, Level = 95, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Xa BØ Phu Nh©n ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1451, Level = 80, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim  §¹i §iªu ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1427, Level = 100, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Qu¸i Lôc Ng« §¹i ThÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1427, Level = 100, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Qu¸i Lôc Ng« §¹i ThÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1435, Level = 100, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Lôc Ng« §¹i ThÇn ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1435, Level = 100, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Lôc Ng« §¹i ThÇn ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1450, Level = 80, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim  Bµn Cæ ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
}

gCityMonsterPos = {
    { x = 1728 * 32, y = 3231 * 32 },
    { x = 1735 * 32, y = 3226 * 32 },
    { x = 1734 * 32, y = 3253 * 32 },
    { x = 1730 * 32, y = 3251 * 32 },
    { x = 1872 * 32, y = 3160 * 32 },
}
gMonsterCol = 5
gXStep = 80
gYStep = 80

CITY_build = 42

CITY_Gate_Close = 133

function CallMonster(TargetNpcIdx, RefreshGroup, CityPosGroup, TargetNpcIdx2)
    local MessageGroup = GetGlobalValue(gMonsterMessageGroup)

    if (MessageGroup ~= RefreshGroup) then

        local OldPlayerIndex = PlayerIndex
        local p = GetFirstPlayerInAll()
        while (p > 0) do
            PlayerIndex = p

            if (IsOwnerCity() == 1) then
                local playerNpcIdx = PlayerIndexToNpcIndex(PlayerIndex)
                local playerCityID = GetNpcMapCityID(playerNpcIdx)
                if (playerCityID ~= 0) then
                    local playerCityVal = GetCityTaskByID(playerCityID, CITY_build)
                    if (GetByte(playerCityVal, 2) ~= 2) then
                        ScrollMessage(gCityMonsterTemplate[RefreshGroup].Message)
                    end
                end
            end
            p = GetNextPlayerInAll()
        end
        PlayerIndex = OldPlayerIndex
        SetGlobalValue(gMonsterMessageGroup, RefreshGroup)
    end

    local MonsterCount = gCityMonsterTemplate[RefreshGroup].Count

    if (IsInMonsterAttackDay() == 2) then
        MonsterCount = math.floor(MonsterCount / 2);
    end

    local OffsetCount = math.floor((gMonsterCol - 1) / 2)

    local Row = math.floor((MonsterCount + gMonsterCol - 1) / gMonsterCol)
    local CurMonster = 0
    for i = 1, Row, 1 do
        if (CurMonster >= MonsterCount) then
            break
        end

        local StartX = gCityMonsterPos[CityPosGroup].x - (i - 1) * gXStep - OffsetCount * gXStep
        local StartY = gCityMonsterPos[CityPosGroup].y + (i - 1) * gYStep - OffsetCount * gYStep

        for j = 1, gMonsterCol, 1 do
            if (CurMonster >= MonsterCount) then
                break
            end

            local x = StartX + (j - 1) * gXStep
            local y = StartY - (j - 1) * gYStep

            CallMonsterAttacker(TargetNpcIdx,
                    gCityMonsterTemplate[RefreshGroup].NpcTemplate,
                    gCityMonsterTemplate[RefreshGroup].Level,
                    x,
                    y,
                    gCityMonsterTemplate[RefreshGroup].TimeScript,
                    gCityMonsterTemplate[RefreshGroup].LifeTime,
                    gCityMonsterTemplate[RefreshGroup].DeathScript,
                    gCityMonsterTemplate[RefreshGroup].IsBlue,
                    15,
                    TargetNpcIdx2)
            CurMonster = CurMonster + 1
        end
    end

    if (gCityMonsterTemplate[RefreshGroup].IsHaveHead == 1) then
        CallMonsterAttacker(TargetNpcIdx,
                gCityMonsterTemplate[RefreshGroup].HeadNpcIdx,
                gCityMonsterTemplate[RefreshGroup].Level,
                gCityMonsterPos[CityPosGroup].x,
                gCityMonsterPos[CityPosGroup].y,
                gCityMonsterTemplate[RefreshGroup].TimeScript,
                gCityMonsterTemplate[RefreshGroup].LifeTime,
                gCityMonsterTemplate[RefreshGroup].DeathScript,
                0,
                15,
                TargetNpcIdx2,
                1)
    end
end

function FindCityIdx(CityID)
    local Idx = 0
    for i = 1, table.getn(gMonsterGroup), 1 do
        if (gMonsterGroup[i].id == CityID) then
            Idx = i
            break
        end
    end
    return Idx
end

function OnTimer(TargetNpcIdx)
    local CityID = GetNpcMapCityID(TargetNpcIdx)
    if (CityID == 0) then
        return
    end

    local val1 = GetCityTaskByID(CityID, CITY_build)
    if (GetByte(val1, 2) == 2) then
        DelNpc(TargetNpcIdx)
        return 0
    end

    local LastRefreshGroup = table.getn(gCityMonsterTemplate)

    if (GetGlobalValue(gMonsterAttackInitFlag) == 0) then
        for i = 1, table.getn(gMonsterGroup), 1 do
            if (gMonsterGroup[i].id ~= nil) then
                gMonsterGroup[i].group = 0
            end
        end

        SetGlobalValue(gMonsterMessageGroup, 0)
        SetGlobalValue(gMonsterAttackInitFlag, 1)
        SetBarrierState(GetCityGateNpcIdxByNpc(TargetNpcIdx), 1)
    end

    local Idx = FindCityIdx(CityID)
    if (Idx == 0) then
        Idx = table.getn(gMonsterGroup)
        Idx = Idx + 1
        gMonsterGroup[Idx] = { id = CityID, group = 0 }
    end

    local RefreshGroup = gMonsterGroup[Idx].group + 1

    if (RefreshGroup == 1) then
        SetNpcTimer(TargetNpcIdx, "\\script\\ontimer\\Í¼ÌÚ¶¨Ê±.lua", 30)
    end

    local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemp = GetCityInfoByID(CityID)
    if (CityLevel == 0 or CityLevel == 1) then
        LastRefreshGroup = 20
    elseif (CityLevel == 2) then
        LastRefreshGroup = 30
    end

    if (RefreshGroup <= LastRefreshGroup) then

        local H, M, S = GetHMS()

        if (IsInMonsterAttackDay() == 1 or IsInMonsterAttackDay() == 2) and (H == 20) and (M >= 0) and (M <= 40) then
            CallMonster(GetCityGateNpcIdxByNpc(TargetNpcIdx), RefreshGroup, CityTemp + 1,
                    GetCityTotemNpcIdxByNpc(TargetNpcIdx))
            gMonsterGroup[Idx].group = RefreshGroup
        end

        if (IsInMonsterAttackDay() ~= 1 and IsInMonsterAttackDay() ~= 2) then
            DelNpc(TargetNpcIdx)
        end


    else
        DelNpc(TargetNpcIdx)
    end
end



