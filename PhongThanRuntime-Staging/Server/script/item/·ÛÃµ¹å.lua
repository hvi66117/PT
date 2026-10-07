TaskRose = 2181

g_RoseBegin = 90
g_RoseEnd = 91

g_Rose = { 6, 1, 1557, 1, 0, 0 }
g_Clothes = { 6, 1, 1560, 1, 0, 0 }

g_Text = "Ng­êi ch¬i th©n mÕn:\nÄú»î¶¯ÆÚ¼äµÚÒ»´ÎÊ¹ÓÃ·ÛÃµ¹å, nhËn ®­îc ÇéÇ£×°."

g_Human = 1
function no()
    CloseDialog()
end

g_ItemList = {
    [1] = { name = "S« C« La", ID = { 1, 6, 0, 0, 1, 0 }, count = 3, unit = ".", needSpace = 1, isOverlapped = 1 },
    [2] = { name = "Hoa hång", ID = { 6, 1, 1446, 0, 0, 0 }, count = 10, unit = ".", needSpace = 1, isOverlapped = 1 },
    [3] = { name = "Phï nhiÖm vô chñ ®Ò ngµy", ID = { 6, 1, 1005, 0, 0, 0 }, count = 5, unit = ".", needSpace = 1, isOverlapped = 0 }
}
function main()

    local year, month, day = GetYMD()
    if month < 10 then
        month = "0" .. month
    end
    if day < 10 then
        day = "0" .. day
    end
    local NowTime = year .. month .. day
    NowTime = tonumber(NowTime)
    local BeginTime = GetGlobalStoreValue(g_RoseBegin)
    local EndTime = GetGlobalStoreValue(g_RoseEnd)
    BeginTime = tonumber(BeginTime)
    EndTime = tonumber(EndTime)

    if (NowTime < BeginTime) or (NowTime > EndTime) then
        Msg2Player("ÄúµÄÃµ¹åÒÑ¾­¹ıÆÚ, ÎŞ·¨´ò¿ª")
        return

    elseif (GetTaskByte(TaskRose, 3) == day) then
        Msg2Player("Äú½ñÌìÒÑ¾­Ê¹ÓÃ¹ıÒ»´Î·ÛÃµ¹åÁË.")
        return

    elseif (GetTeamSize() ~= 2) then
        Msg2Player("ÄúµÄ×é¶ÓÈËÊı²»ÊÇ2ÈË, Çë½öÓëÒ»Î»ÒìĞÔ×é¶Ó.")
        return

    elseif (GetSex() ~= g_Human) then
        Msg2Player("ÄúÊÇÄĞĞÔ²»ÄÜÊ¹ÓÃ·ÛÃµ¹å, ÇëÓëÅ®ĞÔ½ÇÉ«½»»»À¶Ãµ¹å.")
        return
    end

    local oldPlayerIndex = PlayerIndex
    local nYW, nYX, nYY = 52, 1610, 3183
    local MemNumber1 = GetTeamMember(1)
    PlayerIndex = MemNumber1
    local nWorldID1, nX1, nY1 = GetWorldPos()
    local sex1 = GetSex()
    local MemNumber2 = GetTeamMember(2)
    PlayerIndex = MemNumber2
    local nWorldID2, nX2, nY2 = GetWorldPos()
    local sex2 = GetSex()
    PlayerIndex = oldPlayerIndex

    if (sex1 == sex2) then
        Msg2Player("Äú¶şÈËĞÔ±ğÏàÍ¬, ²»ÄÜ»¨Ç°ÔÂÏÂ")
        return
    end

    if not ((nWorldID1 == nYW and nWorldID2 == nYW) and ((math.sqrt((nX1 - nYX) ^ 2 + (nY1 - nYY) ^ 2)) * 32 <= 300) and ((math.sqrt((nX2 - nYX) ^ 2 + (nY2 - nYY) ^ 2)) * 32 <= 300)) then
        Msg2Player("ÄúÓë×é¶ÓµÄÄĞĞÔÍæ¼Ò²»ÔÚÔÂÀÏ¸½½ü, Çë¿¿½üÔÂÀÏÊ¹ÓÃÀ¶Ãµ¹å")
        return
    end

    local nlenth = table.getn(g_ItemList)
    local room = 0

    for i = 1, nlenth do
        if (g_ItemList[i].isOverlapped == 0) then
            room = room + g_ItemList[i].count
        else
            room = room + g_ItemList[i].needSpace
        end
    end

    if (IsHaveSpaceForTreasure(room) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. room .. "¸ñ, ÇëÕûÀíºóÔÙ´ò¿ª.")
        return 0
    end

    if (DelNormalItem(g_Rose[1], g_Rose[2], g_Rose[3], g_Rose[4]) <= 0) then
        Talk(1, "no", "Ó¢ĞÛ, ÄãµÄ·ÛÃµ¹å³äÂú×ÅÉñÆæµÄÁ¦Á¿, ºÜÄÑ´ò¿ª°¡!")
        WriteLog("[ÇéÈË½Ú»¥ËÍÃµ¹å»î¶¯][·ÛÃµ¹å][É¾³ıÊ§°Ü]")
        return 0
    end

    PlayerCastSkill(1, 212, 1)

    local taskTimes = GetTaskByte(TaskRose, 4)
    taskTimes = taskTimes + 1
    SetTaskByte(TaskRose, 3, day)
    SetTaskByte(TaskRose, 4, taskTimes)

    if (taskTimes == 1) then

        PlayerIndex = oldPlayerIndex
        if (GetSex() == 1) then

            local str = GetNormalItemName(g_Clothes[1], g_Clothes[2], g_Clothes[3], g_Clothes[4])
            local playerName = GetName()

            if (IsHaveSpaceForTreasure(room + 1) <= 0) then
                SendSysItemMailToTarget("Hép th­", playerName, str, g_Text, g_Clothes[1], g_Clothes[2], g_Clothes[3], g_Clothes[4], g_Clothes[5], g_Clothes[6])
                Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc " .. str .. ", Çë×¢Òâ²é¿´.")
                WriteLog("[ÇéÈË½Ú»¥ËÍÃµ¹å»î¶¯][·ÛÃµ¹å][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc " .. str)
            else
                AddNormalItem(g_Clothes[1], g_Clothes[2], g_Clothes[3], g_Clothes[4], g_Clothes[5], g_Clothes[6])
                Msg2Player("Ngµi nhËn ®­îc " .. str .. ", ÒÑ¾­·Åµ½ÄúµÄ±³°üÖĞ")
                WriteLog("[ÇéÈË½Ú»¥ËÍÃµ¹å»î¶¯][·ÛÃµ¹å][" .. GetName() .. "ÔÚ±³°üÖĞ nhËn ®­îc " .. str)
            end
        end
    end

    local nlenth = table.getn(g_ItemList)
    for i = 1, nlenth do
        for j = 1, g_ItemList[i].count do
            AddNormalItemBind(g_ItemList[i].ID[1], g_ItemList[i].ID[2], g_ItemList[i].ID[3], g_ItemList[i].ID[4], g_ItemList[i].ID[5], g_ItemList[i].ID[6], 1)
        end
        Msg2Player("ÄúÊ¹ÓÃÁËÒ»¶ä·ÛÃµ¹å²¢ nhËn ®­îc " .. g_ItemList[i].count .. "." .. g_ItemList[i].name)
        WriteLog("[ÇéÈË½Ú»¥ËÍÃµ¹å»î¶¯][·ÛÃµ¹å]" .. GetName() .. " nhËn ®­îc " .. g_ItemList[i].count .. g_ItemList[i].unit .. g_ItemList[i].name)
    end
end

