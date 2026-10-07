--description: ÊÏ×åÕ½ÆìËÀÍö.lua
--author: yangyankun
--date: 09-11-23

gCityHeavenTask = 53    -- 1byte: ´Ë¶´Ìì±»³É¹¦ÐûÕ½µÄÈÕÆÚ 2byte:·ÀÊØ·½ID 3byte:½ø¹¥·½ID 
-- 4byte: 1bit:Éñ±® 2bit:³ÇÃÅ 3bit:ºé»ÄÉñÊÞ 4bit:Í¼ÌÚ 5bit:Õ½Æì 8bit:Õ½ÕùÊÇ·ñ½áÊø		ÊÇ·ñÒÑ±»Ëð»µ
gTongHeavenTask = 31    -- 1byte: ¸ÃÊÏ×å³É¹¦ÐûÕ½±ðÈËµÄÈÕÆÚ 2byte: ÐûÕ½µÄµØÍ¼ÀàÐÍ 3byte:É±ËÀµÐÈËµÄÊýÁ¿ 4byte:´Ý»Ù½¨ÖþµÄÊýÁ¿
gTongHeavenTask2 = 32    -- 1byte: ¸ÃÊÏ×å±»±ðÈËÐûÕ½µÄÈÕÆÚ 2byte:  3byte: É±ËÀ½ø¹¥·½µÄÊýÁ¿ 4byte:

-- ÒâÎ¶×Å½ø¹¥·½Ê§°Ü
function OnDeath(npcidx)
    local CityID = GetNpcMapCityID(npcidx)
    local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemp, TongName = GetCityInfoByID(CityID)

    local isWarServer = IsWarServer() -- ÊÇ·ñÊÇ¿ç·þ add by yangyankun at 09-11-18
    if (isWarServer == 1) then
        -- Èç¹ûÊÇ¿ç·þ
        local CityName, CityMode, CityMoney, CityBronze, CityLevel, CityTemplet, TongName = GetCityInfoByID(CityID)
        if (CityTemplet >= 5) and (CityTemplet <= 7) then
            local heavenType = CityTemplet - 4 -- 1.Óñ·å 2.»ÔÃ÷ 3.×ÏÐþ
            -- 1bit:Éñ±® 2bit:³ÇÃÅ 3bit:ºé»ÄÉñÊÞ 4bit:Í¼ÌÚ 5bit:Õ½Æì 8bit:Õ½ÕùÊÇ·ñ½áÊø
            SetCityTaskByID(nCityID, gCityHeavenTask, SetBit(SetBit(GetCityTaskByID(nCityID, gCityHeavenTask), 3 * 8 + 8, 1), 3 * 8 + 5, 1))

            -- É¾³ýËùÓÐNPC
            local w, x, y = GetNpcWorldPos(npcidx)
            local nSubWorld = SubWorldID2Idx(w)
            local nCount1 = DeleteSubWorldKindNpcs(nSubWorld, 8)-- »úÐµ
            local nCount2 = DeleteSubWorldKindNpcs(nSubWorld, 0)-- ¹ÖÎï

            local nFamilyId = GetHeavenCityUnion(heavenType)    -- ¶´Ìì¹éÊôÊÏ×å
            if (nFamilyId == 0) then
                -- ÎÞÖ÷¶´Ìì
                WarEnd(CityID)
            elseif (nFamilyId >= 1) and (nFamilyId <= 5) then
                -- ¿ªÊ¼¸ø½±Àø
                GiveGift(npcidx, CityID)
            else
                Talk(1, "no", "§éng Thiªn nµy kh«ng thuéc bÊt cø thÞ téc nµo")
                return -1
            end
        else
            DebugPrint("ChiÕn Kú ®· bÞ ph¸, nh­ng thµnh thÞ nµy kh«ng tån t¹i")
        end
    end
    DelBuildingNpc(npcidx)
end

function GiveGift(npcidx, CityID)
    local defendUnion = GetByte(GetCityTaskByID(CityID, gCityHeavenTask), 2)    -- ·ÀÊØ·½ÊÏ×å
    local attackUnion = GetByte(GetCityTaskByID(CityID, gCityHeavenTask), 3)    -- ½ø¹¥·½ÊÏ×å
    local mapid, xp, yp = GetNpcWorldPos(npcidx)
    local id = SubWorldID2Idx(mapid)
    if (id ~= -1) then
        local nPlayerCount = GetSubWorldPlayerCount(id)
        if (nPlayerCount > 0) then
            for j = 1, nPlayerCount do
                PlayerIndex = GetSubWorldPlayerIdxByNum(id, j)
                if (PlayerIndex > 0) then
                    local shizu = GetPosterityType()
                    if ((shizu == attackUnion) and (IsTongMember(2) == 1)) then
                        -- Èç¹ûÊÇ½ø¹¥·½	
                        local attackTongID = GetUnionTongIDByPosterityType(shizu)
                        local DeclearDate = GetByte(GetTongTaskByID(attackTongID, gTongHeavenTask), 1)
                        local killPeopleCount = GetByte(GetTongTaskByID(attackTongID, gTongHeavenTask), 3)
                        local destroyBuildingCount = GetByte(GetTongTaskByID(attackTongID, gTongHeavenTask), 4)
                        local today = mod(floor(LocalSystemTime() / 86400), 255)
                        if (today == DeclearDate) then
                            local value = min(200, 3 * killPeopleCount) + min((killPeopleCount / 60), 10) * destroyBuildingCount * 70
                            local Exploit = GetExploit() + value
                            local ExploitV = GetExploitV() + value
                            SetExploit(Exploit)
                            SetExploitV(ExploitV)
                            Msg2Player("Phe c«ng: l·nh ®Þa nµy ®· tiªu diÖt " .. killPeopleCount .. " ®èi ph­¬ng, tiªu hñy " .. destroyBuildingCount .. " kiÕn tróc, nhËn ®­îc " .. value .. " ®iÓm th­ëng C«ng tr¹ng!")
                            TopMessage("Phe c«ng: l·nh ®Þa nµy ®· tiªu diÖt " .. killPeopleCount .. " ®èi ph­¬ng, tiªu hñy " .. destroyBuildingCount .. " kiÕn tróc, nhËn ®­îc " .. value .. " ®iÓm th­ëng C«ng tr¹ng!")
                        else
                            Msg2Player("Phe c«ng: kh«ng ph¶i h«m nay tuyªn chiÕn ")
                        end
                    elseif ((shizu == defendUnion) and (IsTongMember(2) == 1)) then
                        -- Èç¹ûÊÇ·ÀÊØ·½£¬±»ÐûÕ½·½£¬Ê¤Àû
                        local defendTongID = GetUnionTongIDByPosterityType(shizu)
                        local deDeclearDate = GetByte(GetTongTaskByID(defendTongID, gTongHeavenTask2), 1)
                        local killPeopleCount = GetByte(GetTongTaskByID(defendTongID, gTongHeavenTask2), 3)
                        local today = mod(floor(LocalSystemTime() / 86400), 255)
                        if (today == deDeclearDate) then
                            local value = min(200, 3 * killPeopleCount) + 200
                            local Exploit = GetExploit() + value
                            local ExploitV = GetExploitV() + value
                            SetExploit(Exploit)
                            SetExploitV(ExploitV)
                            Msg2Player("Phe thñ: l·nh ®Þa nµy ®· tiªu diÖt " .. killPeopleCount .. " ®èi ph­¬ng, nhËn ®­îc " .. value .. " ®iÓm th­ëng C«ng tr¹ng!")
                            TopMessage("Phe thñ: l·nh ®Þa nµy ®· tiªu diÖt " .. killPeopleCount .. " ®èi ph­¬ng, nhËn ®­îc " .. value .. " ®iÓm th­ëng C«ng tr¹ng!")
                        else
                            Msg2Player("Phe thñ: kh«ng ph¶i h«m nay bÞ khiªu chiÕn ")
                        end
                    end
                end
            end
        end
    end

    --> add by yangyankun for °ÔÖ÷»ý·Ö½±Àø at 09-12-4
    local defendTongName = GetUnionTongNameByPosterityType(defendUnion)
    ModifyUnionTongWarPowerByName(defendTongName, 80)
    Msg2TongMemberByTongName(defendTongName, "L·nh ®Þa nµy phßng thñ th¾ng lîi, nhËn ®­îc 80 ®iÓm tÝch lòy B¸ Chñ")
    local attackTongName = GetUnionTongNameByPosterityType(attackUnion)
    ModifyUnionTongWarPowerByName(attackTongName, 40)
    Msg2TongMemberByTongName(attackTongName, "L·nh ®Þa nµy tÊn c«ng thÊt b¹i, nhËn ®­îc 40 ®iÓm tÝch lòy B¸ Chñ")
    --< add by yangyankun for °ÔÖ÷»ý·Ö½±Àø at 09-12-4
end

-- ÎÞÖ÷¶´ÌìÕù¶áÕ½½áÊø´¦Àí
function WarEnd(CityID)
    local attackUnion = GetByte(GetCityTaskByID(CityID, gCityHeavenTask), 3)    -- ½ø¹¥·½ÊÏ×å
    AddGlobalNews("Tranh ®o¹t §éng Thiªn V« Chñ ®· kÕt thóc, phe ThÞ téc thÊt b¹i!")
    Msg2TongMemberByTongName(GetUnionTongNameByPosterityType(AttackID), "ChiÕn Kú ThÞ téc bÞ ph¸ hñy, ThÞ téc ch­a thÓ chiÕm lÜnh §éng Thiªn, nhËn ®­îc 20 ®iÓm tÝch lòy B¸ Chñ.")
    ModifyUnionTongWarPowerByName(GetUnionTongNameByPosterityType(attackUnion), 20)        -- Ôö¼Ó°ÔÖ÷»ý·Ö20µã
end