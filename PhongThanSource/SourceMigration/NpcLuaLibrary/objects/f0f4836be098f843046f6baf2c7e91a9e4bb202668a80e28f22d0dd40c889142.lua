--Í¼ÌÚ¶¨Ê±½Å±¾£¬ÓÃÀ´ÕÙ»½¹¥»÷¹ÖÎï
--Rocker 2008.6.20

gMonsterMessageGroup = 160 --¼ÇÂ¼¹ÖÎïÒÑ¾­ÕÙ»½µÄÅú´Î 
gMonsterAttackInitFlag = 159 -- »î¶¯³õÊ¼»¯±ê¼Ç
gMonsterGroup = {}

--¼ÇÂ¼¹ÖÎïÄ£°å
gCityMonsterTemplate = {
    { NpcTemplate = 1420, Level = 40, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Qu¸i ThiÕt trïng ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1420, Level = 40, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "Qu¸i ThiÕt trïng ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1428, Level = 40, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "ThiÕt trïng ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1428, Level = 40, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1436, Message = "ThiÕt trïng ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
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
    { NpcTemplate = 1446, Level = 60, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim ThiÕt Bè ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1423, Level = 70, Count = 10, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "Qu¸i  D· Mao thÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1423, Level = 70, Count = 20, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "Qu¸i  D· Mao thÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1431, Level = 70, Count = 10, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "D· Mao thÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1431, Level = 70, Count = 20, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1439, Message = "D· Mao thÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1447, Level = 60, Count = 2, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Kim Tr¹i ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1424, Level = 80, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Qu¸i  Lam Cèt ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1424, Level = 80, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Qu¸i  Lam Cèt ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1432, Level = 80, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Lam Cèt b¾t ®Çu tÊn c«ng råi", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1432, Level = 80, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1440, Message = "Lam Cèt b¾t ®Çu tÊn c«ng ®iªn cuång", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1448, Level = 60, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim C«n Bèi ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1425, Level = 90, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Qu¸i  Ma N÷ ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1425, Level = 90, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Qu¸i  Ma N÷ ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1433, Level = 90, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Ma N÷ ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1433, Level = 90, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1441, Message = "Ma N÷ ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1449, Level = 60, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim Lam B¸ ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1426, Level = 95, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Qu¸i  §íi Tr¹i ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1426, Level = 95, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "Qu¸i  §íi Tr¹i ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1434, Level = 95, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "§íi Tr¹i ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1434, Level = 95, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1442, Message = "§íi Tr¹i ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1451, Level = 80, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim  §¹i §iªu ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1427, Level = 100, Count = 15, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Qu¸i  Lôc Ng« ThÇn ®· b¾t ®Çu tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1427, Level = 100, Count = 30, LifeTime = 360, IsBlue = 0, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Qu¸i  Lôc Ng« ThÇn ®· b¾t ®Çu ®iªn cuång tÊn c«ng!", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1435, Level = 100, Count = 15, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Lôc Ng« ThÇn ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1435, Level = 100, Count = 30, LifeTime = 360, IsBlue = 1, IsHaveHead = 1, HeadNpcIdx = 1443, Message = "Lôc Ng« ThÇn ®· b¾t ®Çu tÊn c«ng", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
    { NpcTemplate = 1450, Level = 80, Count = 5, LifeTime = 360, IsBlue = 0, Message = "Hoµng Kim  Bµn Cæ ®· xuÊt hiÖn trong thµnh", DeathScript = "\\script\\npcdeath\\¹¥³Ç¹ÖÎïËÀÍö.lua", TimeScript = "\\script\\ontimer\\¹¥³Ç¹ÖÎï¶¨Ê±.lua" },
}

--¼ÇÂ¼¹ÖÎïË¢ĞÂÎ»ÖÃ°´ÕÕ³ÇÊĞµØÍ¼ÀàĞÍ×éÖ¯
gCityMonsterPos = {
    { x = 1728 * 32, y = 3231 * 32 }, --»ÆÉ³Ö®³Ç
    { x = 1735 * 32, y = 3226 * 32 }, --ºìÒ¶Ö®³Ç
    { x = 1734 * 32, y = 3253 * 32 }, --ºÚ°µÖ®³Ç
    { x = 1730 * 32, y = 3251 * 32 }, --Çï·çÖ®³Ç
    { x = 1872 * 32, y = 3160 * 32 }, --ÏÄÈÕÖ®³Ç
}
gMonsterCol = 5        --¹ÖÎïÅÅÁĞÁĞÊı
gXStep = 80
gYStep = 80

--CITY_release =  --¼´Ê±¹úÕ½ÊØ»¤ÉñÊŞ1~3byteÊÍ·ÅÔªÉñÊ±¼ä£¨ÒÔÌì¼ÇÂ¼£©4byte 1ÊÇ³ÇÍâ 2³ÇÄÚ,3×¼±¸ÊÍ·Å
CITY_build = 42 --¸÷¸ö½¨ÖşµÄĞÅÏ¢ 1byte ³ÇÃÅ 0Î´¹¥ÆÆ,2¹¥ÆÆ£¬2byte Í¼ÌÚ 0Î´¹¥ÆÆ£¬2¹¥ÆÆ
--< ¼´Ê±¹úÕ½ add by yaoxin at 2009-09-30

-- Zhaoqingsong add begin 2009/11/03
CITY_Gate_Close = 133 --¹Ø±Õ³ÇÃÅ
-- Zhaoqingsong add end 2009/11/03


function CallMonster(TargetNpcIdx, RefreshGroup, CityPosGroup, TargetNpcIdx2)
    local MessageGroup = GetGlobalValue(gMonsterMessageGroup)

    --	if (SubWorldID2Idx(1) ~= -1) then
    --		AddGlobalCountNews(gCityMonsterTemplate[RefreshGroup].Message, 1)
    --	end

    if (MessageGroup ~= RefreshGroup) then
        --¸ø³ÇÊĞµØÍ¼ÉÏËùÓĞ±¾¹úÍæ¼ÒË¢ÏûÏ¢,ÃâµÃÆäËû³ÇÊĞÒ²·¢ËÍÈ«¾ÖÏûÏ¢
        local OldPlayerIndex = PlayerIndex
        local p = GetFirstPlayerInAll()
        while (p > 0) do
            PlayerIndex = p
            -- Zhaoqingsong modify 2009/11/06
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

    --Added by Hongliang for ´º½Ú¹úÕ½µ÷Õû 2010-2-1 begin
    if (IsInMonsterAttackDay() == 2) then
        MonsterCount = floor(MonsterCount / 2);
    end
    --Added by Hongliang for ´º½Ú¹úÕ½µ÷Õû 2010-2-1 end

    --Æ«ÒÆ¸öÊı
    local OffsetCount = floor((gMonsterCol - 1) / 2)
    --¼ÆËãÒ»¹²µÄĞĞÊı
    local Row = floor((MonsterCount + gMonsterCol - 1) / gMonsterCol)
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
                    TargetNpcIdx2)--µÚ¶şÄ¿±êÍ¼ÌÚ modified by yaoxin for 2009-10
            CurMonster = CurMonster + 1
        end
    end

    if (gCityMonsterTemplate[RefreshGroup].IsHaveHead == 1) then
        CallMonsterAttacker(TargetNpcIdx, -- FirstTarget
                gCityMonsterTemplate[RefreshGroup].HeadNpcIdx, -- npctemplate
                gCityMonsterTemplate[RefreshGroup].Level,
                gCityMonsterPos[CityPosGroup].x,
                gCityMonsterPos[CityPosGroup].y,
                gCityMonsterTemplate[RefreshGroup].TimeScript, --TimeScript
                gCityMonsterTemplate[RefreshGroup].LifeTime, -- LifeTime
                gCityMonsterTemplate[RefreshGroup].DeathScript, --DeathScript
                0, -- IsBlue
                15, -- AttackTime
                TargetNpcIdx2, -- secondTarget
                1) -- isLeader
    end
end

function FindCityIdx(CityID)
    local Idx = 0
    for i = 1, getn(gMonsterGroup), 1 do
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

    local LastRefreshGroup = getn(gCityMonsterTemplate)

    --³õÊ¼»¯±äÁ¿
    if (GetGlobalValue(gMonsterAttackInitFlag) == 0) then
        for i = 1, getn(gMonsterGroup), 1 do
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
        -- ²åÈëĞÂÔªËØ
        Idx = getn(gMonsterGroup)
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

        --Modified by Hongliang for ´º½Ú¹úÕ½µ÷Õû 2010-2-1 begin		
        if (IsInMonsterAttackDay() == 1 or IsInMonsterAttackDay() == 2) and (H == 20) and (M >= 0) and (M <= 40) then
            CallMonster(GetCityGateNpcIdxByNpc(TargetNpcIdx), RefreshGroup, CityTemp + 1,
                    GetCityTotemNpcIdxByNpc(TargetNpcIdx))--µÚ¶şÄ¿±êÍ¼ÌÚ modified by yaoxin for 2009-10
            gMonsterGroup[Idx].group = RefreshGroup
        end

        if (IsInMonsterAttackDay() ~= 1 and IsInMonsterAttackDay() ~= 2) then
            DelNpc(TargetNpcIdx)
        end
        --Modified by Hongliang for ´º½Ú¹úÕ½µ÷Õû 2010-2-1 end

    else
        DelNpc(TargetNpcIdx)
    end
end



