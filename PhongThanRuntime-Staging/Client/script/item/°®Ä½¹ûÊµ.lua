g_ItemList = {
    [1] = { name = "Vi Quang Qu¸i Phï", ID = { 3, 374, 0, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 2, w_probability = 1, itemtype = "normal" },
    [2] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 8, w_probability = 2, itemtype = "normal" },
    [3] = { name = "Kinh NghiÖm §¬n-Siªu cÊp", ID = { 6, 1, 1355, 1, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 15, w_probability = 30, itemtype = "normal" },
    [4] = { name = "Phï nhiÖm vô chñ ®Ò ngµy", ID = { 6, 1, 1005, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 20, w_probability = 20, itemtype = "normal" },
    [5] = { name = "B¶o T¸ Thanh lé", ID = { 8, 198, 3, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 20, w_probability = 10, itemtype = "normal" },
    [6] = { name = "S¬n Thñy ch©n khÝ", ID = { 8, 199, 4, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, m_probability = 20, w_probability = 10, itemtype = "normal" },
    [7] = { name = "500 v¹n b¹c khãa", ID = { 5000000 }, count = 1, uint = "Ã¶", needSpace = 1, m_probability = 15, w_probability = 27, itemtype = "coin" }
}
g_TimesAward = {
    [1] = { name = "T­íng Qu©n LÖnh", ID = { 3, 100, 0, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, times = 5, itemtype = "normal" },
    [2] = { name = "Tö B¶o Th¹ch", ID = { 3, 1151, 0, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, times = 10, itemtype = "normal" },
    [3] = { name = "×ÔÑ¡ÃûÓñ", ID = { 8, 1669, 2, 0, 0, 0 }, count = 1, unit = ".", needSpace = 1, times = 20, itemtype = "normal" },
    [4] = { name = "¾ø´ú¼ÑÈË", ID = { 6, 1, 1563, 1, 0, 0 }, count = 1, unit = ".", needSpace = 1, times = 40, itemtype = "normal" }
}

g_Err = "Sö dông thÊt b¹i, ÇëÓë vµ ÄúÏàÍ¬¹ú¼Ò, ÊÕµ½¹ûÊµÊýÁ¿Îª40´ÎÒÔÏÂµÄ cÊp 90 ÒÔÉÏÅ®ÐÔ½ÇÉ«×é¶Ó."

function main()
    local OpenTime = GetGlobalStoreValue(96)
    local CloseTime = GetGlobalStoreValue(97)
    local yr, mo, day = GetYMD()
    if mo < 10 then
        mo = "0" .. mo
    end
    if day < 10 then
        day = "0" .. day
    end
    local NowTime = string.format("%s%s%s", yr, mo, day)
    OpenTime = string.format("%s", OpenTime)
    CloseTime = string.format("%s", CloseTime)

    _, _, day = GetYMD()
    if (NowTime < OpenTime) or (NowTime > CloseTime) then
        Talk(1, "no", g_Err)
        return
    end

    if not ((GetNewBirthTimes() > 0 or GetLevel() >= 90) and (GetSex() == 0)) then
        Talk(1, "no", g_Err)
        return
    end

    if (GetTeamSize() ~= 2) or (GetSex() ~= 0) then
        Talk(1, "no", g_Err)
        return
    end

    local oldPlayerIndex = PlayerIndex
    local goddess, goddessName, goddessLevel, goddessSex, goddessTongName, goddessBirth, god, godName, GodLevel, GodSex, GodTongName, godBirth = 0, "", 0, 0, "", 0, 0, "", 0, 0, "", 0
    for i = 1, 2 do
        local TeamMemberPlayerIndex = GetTeamMember(i)
        PlayerIndex = TeamMemberPlayerIndex
        if (GetSex() == 1) then
            goddessSex = GetSex()
            goddess = TeamMemberPlayerIndex
            goddessName = GetName()
            goddessLevel = GetLevel()
            goddessTongName = GetTongName()
            goddessBirth = GetNewBirthTimes()
        else
            godSex = GetSex()
            god = TeamMemberPlayerIndex
            godName = GetName()
            godLevel = GetLevel()
            godTongName = GetTongName()
            godBirth = GetNewBirthTimes()
        end
    end
    PlayerIndex = oldPlayerIndex

    PlayerIndex = goddess
    local ActivityTimes = GetGlobalStoreValueByte(98, 1)
    if (ActivityTimes ~= GetTaskByte(2183, 2)) then
        SetTaskByte(2183, 1, 0)
        SetTaskByte(2183, 2, ActivityTimes)
    end
    PlayerIndex = oldPlayerIndex
    if (goddessTongName == godTongName) and (goddessTongName ~= "" and godTongName ~= "") and (goddessLevel >= 90 or goddessBirth > 0) and (godLevel >= 90 or godBirth > 0) and (GetTeamSize() == 2) and (goddessSex ~= godSex) and (goddessName ~= godName) and (goddess ~= god) then

        PlayerIndex = goddess
        local w_needSpace, m_needSpace = 1, 1
        local AwardTimes = GetTaskByte(2183, 1) + 1
        local g_TimesAwardIndex = 0
        if (AwardTimes <= 40) then
            for i = 1, table.getn(g_TimesAward) do
                if (g_TimesAward[i].times == AwardTimes) then
                    w_needSpace = 2
                    g_TimesAwardIndex = i
                    break
                end
                if (g_TimesAward[i].times > AwardTimes) then
                    g_TimesAwardIndex = i
                    break
                end
            end
        else
            PlayerIndex = god
            Talk(1, "no", g_Err)
            PlayerIndex = oldPlayerIndex
            return
        end

        PlayerIndex = god
        if (IsHaveSpaceForTreasure(m_needSpace) <= 0) then
            Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. m_needSpace .. "¸ñ, ÇëÕûÀíºóÔÙ´ò¿ª.")
            PlayerIndex = oldPlayerIndex
            return
        end
        PlayerIndex = goddess
        if (IsHaveSpaceForTreasure(w_needSpace) <= 0) then
            PlayerIndex = god
            Talk(1, "no", "ThËt xin lçi, Å®ÉñµÄ±³°ü¿Õ¼ä²»×ã" .. w_needSpace .. "¸ñ, ÎÞ·¨Ê¹ÓÃ°®Ä½¹ûÊµ")
            PlayerIndex = oldPlayerIndex
            return
        end

        PlayerIndex = goddess
        local w_randNumber = math.random(1, 100)
        local w_nRand, w_nIndex = W_GetItemListIndex(w_randNumber)

        if (w_nRand < 0) or (w_nIndex <= 0) or (g_ItemList[w_nIndex] == nil) then
            Talk(1, "no", "µÀ¾ßÐÅÏ¢È±Ê§")
            return
        end
        PlayerIndex = god
        local m_randNumber = math.random(1, 100)
        local m_nRand, m_nIndex = M_GetItemListIndex(m_randNumber)

        if (m_nRand < 0) or (m_nIndex <= 0) or (g_ItemList[m_nIndex] == nil) then
            Talk(1, "no", "µÀ¾ßÐÅÏ¢È±Ê§")
            return
        end

        DelNormalItem(6, 1, 1562, 1)

        PlayerIndex = goddess
        PlayerCastSkill(1, 212, 1)
        PlayerIndex = oldPlayerIndex

        PlayerIndex = goddess
        local w_log = ""
        SetTaskByte(2183, 1, AwardTimes)
        if (g_ItemList[w_nIndex].itemtype == "coin") then
            EarnBind(g_ItemList[w_nIndex].ID[1])
            w_log = g_ItemList[w_nIndex].name
        else
            AddNormalItemBind(g_ItemList[w_nIndex].ID[1], g_ItemList[w_nIndex].ID[2], g_ItemList[w_nIndex].ID[3], g_ItemList[w_nIndex].ID[4], g_ItemList[w_nIndex].ID[5], g_ItemList[w_nIndex].ID[6], 1)
            w_log = g_ItemList[w_nIndex].count .. g_ItemList[w_nIndex].unit .. g_ItemList[w_nIndex].name
        end
        local w_str = ""

        if (g_TimesAward[g_TimesAwardIndex].times == AwardTimes) then
            AddNormalItemBind(g_TimesAward[g_TimesAwardIndex].ID[1], g_TimesAward[g_TimesAwardIndex].ID[2], g_TimesAward[g_TimesAwardIndex].ID[3], g_TimesAward[g_TimesAwardIndex].ID[4], g_TimesAward[g_TimesAwardIndex].ID[5], g_TimesAward[g_TimesAwardIndex].ID[6], 1)
            w_str = "NhËn ®­îc ¶îÍâ½±Àø" .. g_TimesAward[g_TimesAwardIndex].name .. ","
            w_log = "," .. w_log .. "nhËn thªm" .. g_TimesAward[g_TimesAwardIndex].name
        end

        if (g_TimesAwardIndex == table.getn(g_TimesAward) and g_TimesAward[g_TimesAwardIndex].times == AwardTimes) then
            Msg2Player("ÄúÊÕµ½À´×Ô" .. godName .. "µÄ°®Ä½¹ûÊµ, ®ång thêi nhËn ®­îc phÇn th­ëng: " .. g_ItemList[w_nIndex].name .. ".ÕâÊÇÄúµÚ" .. AwardTimes .. "´ÎµÃµ½°®Ä½¹ûÊµ, " .. w_str .. "´Ë´Î»î¶¯ÖÐÄú»ñµÃ¹ûÊµÊýÁ¿ÒÑ´ïµ½ÉÏÏÞ, ½«ÎÞ·¨ÔÙÊÕÈ¡°®Ä½¹ûÊµ.")
        elseif (g_TimesAward[g_TimesAwardIndex].times == AwardTimes) then
            Msg2Player("ÄúÊÕµ½À´×Ô" .. godName .. "µÄ°®Ä½¹ûÊµ, ®ång thêi nhËn ®­îc phÇn th­ëng: " .. g_ItemList[w_nIndex].name .. ".ÕâÊÇÄúµÚ" .. AwardTimes .. "´ÎµÃµ½°®Ä½¹ûÊµ, " .. w_str .. "Thiªn C­¬ng ¶nh thø" .. g_TimesAward[g_TimesAwardIndex + 1].times .. "´Î¼´¿ÉµÃµ½¶îÍâ½±Àø" .. g_TimesAward[g_TimesAwardIndex + 1].name)
        else
            Msg2Player("ÄúÊÕµ½À´×Ô" .. godName .. "µÄ°®Ä½¹ûÊµ, ®ång thêi nhËn ®­îc phÇn th­ëng: " .. g_ItemList[w_nIndex].name .. ".ÕâÊÇÄúµÚ" .. AwardTimes .. "´ÎµÃµ½°®Ä½¹ûÊµ, " .. w_str .. "Thiªn C­¬ng ¶nh thø" .. g_TimesAward[g_TimesAwardIndex].times .. "´Î¼´¿ÉµÃµ½¶îÍâ½±Àø" .. g_TimesAward[g_TimesAwardIndex].name)
        end
        WriteLog("[°®Ä½¹ûÊµ][" .. goddessName .. "] NhËn ®­îc ÁË: " .. w_log .. ".")

        PlayerIndex = god
        local m_log = ""
        if (g_ItemList[m_nIndex].itemtype == "coin") then
            EarnBind(g_ItemList[m_nIndex].ID[1])
            m_log = g_ItemList[m_nIndex].name
        else
            AddNormalItemBind(g_ItemList[m_nIndex].ID[1], g_ItemList[m_nIndex].ID[2], g_ItemList[m_nIndex].ID[3], g_ItemList[m_nIndex].ID[4], g_ItemList[m_nIndex].ID[5], g_ItemList[m_nIndex].ID[6], 1)
            m_log = g_ItemList[m_nIndex].count .. g_ItemList[m_nIndex].unit .. g_ItemList[m_nIndex].name
        end
        WriteLog("[°®Ä½¹ûÊµ][" .. godName .. "] NhËn ®­îc ÁË: " .. m_log .. ".")

        Msg2Player("ÄúÎªÄúµÄÅ®Éñ" .. goddessName .. "Ï×³öÁË×Ô¼ºµÄ°®Ä½¹ûÊµ, ®ång thêi nhËn ®­îc phÇn th­ëng: " .. g_ItemList[m_nIndex].name)

        if (IsTongMember() > 0) then
            Msg2TongMember("¹§Ï²Å®Éñ" .. goddessName .. " nhËn ®­îc ¹ú¼ÒÄÚÓ¢ÐÛÔùËÍµÄ°®Ä½¹ûÊµ, ÍòÇ§³è°®¼¯Ò»Éí, °®Ä½¹ûÊµÔù¼ÑÈË!")
        end
        PlayerIndex = oldPlayerIndex
    else
        Talk(1, "no", g_Err)
        return
    end
end

function M_GetItemListIndex(m_randNumber)
    local randNum = m_randNumber
    local sum = 0
    for i = 1, table.getn(g_ItemList) do

        if (g_ItemList[i] == nil) then
            return -1
        end
        sum = sum + g_ItemList[i].m_probability
        if (sum >= randNum) then
            return g_ItemList[i].m_probability, i
        end
    end
end

function W_GetItemListIndex(w_randNumber)
    local randNum = w_randNumber
    local sum = 0
    for i = 1, table.getn(g_ItemList) do

        if (g_ItemList[i] == nil) then
            return -1
        end
        sum = sum + g_ItemList[i].w_probability
        if (sum >= randNum) then
            return g_ItemList[i].w_probability, i
        end
    end
end

function no()
    CloseDialog()
end;
