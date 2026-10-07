thisTimes = 72

require("¼×¹ÇÎÄ»î¶¯.luax")

function ClearTask()

    local y, m, d = GetYMD()
    if (GetGlobalStoreValueByte(30, 1) ~= thisTimes) then
        SetGlobalStoreValueByte(30, 1, thisTimes, 1)
        SetGlobalStoreValueByte(30, 2, d, 1)
        SetGlobalStoreValueWord(30, 2, 0, 1)
        SetGlobalStoreValueByte(29, 2, 0, 1)
    end

    if (GetGlobalStoreValueByte(30, 2) ~= d) then
        SetGlobalStoreValueByte(30, 2, d, 1)
        SetGlobalStoreValueByte(29, 2, 0, 1)
    end
end

g_Item = { 6, 1, 1656, 1 }

g_Name = "B¶o r­¬ng Phóc vËn"

g_Magnitude = 100000

g_NeedSpace = 3

g_ItemList = {

    [1] = { name = "S¸ch Ch­ HÇu (M¶nh)", ID = { 8, 193, 5, 0, 0, 0 }, count = 1, probability = 15.3, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [2] = { name = "ThÇn CÈu phï", ID = { 8, 133, 0, 0, 0, 0 }, count = 1, probability = 15, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [3] = { name = "Håi thµnh phï (Siªu cÊp)", ID = { 8, 291, 2, 0, 0, 0 }, count = 1, probability = 15, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [4] = { name = "M¶nh Hoµng thñy tinh", ID = { 3, 88, 0, 0, 0, 0 }, count = 1, probability = 10, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [5] = { name = "M¶nh Lôc Thñy tinh", ID = { 3, 248, 0, 0, 0, 0 }, count = 1, probability = 5, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [6] = { name = "ChØ nh©n", ID = { 8, 135, 2, 0, 0, 0 }, count = 1, probability = 12.5, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [7] = { name = "La H¸n hiÖu gi¸c", ID = { 8, 233, 0, 0, 0, 0 }, count = 1, probability = 15, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [8] = { name = "100 v¹n l­îng", ID = { 1000000, 0, 0, 0, 0, 0 }, count = 1, probability = 10, needSpace = 1, addtype = "EarnBind", isnotice = 1, },
    [9] = { name = "Vi Quang Qu¸i Phï", ID = { 3, 374, 0, 0, 0, 0 }, count = 1, probability = 0.2, needSpace = 1, addtype = "AddNormalItemPile", isnotice = 2, },
    [10] = { name = "Tinh Th¸i Qu¸i Phï", ID = { 3, 383, 2, 0, 0, 0 }, count = 1, probability = 0, needSpace = 1, addtype = "AddNormalItemPile", isnotice = 2, },
    [11] = { name = "M¶nh Phï Th¹ch", ID = { 6, 1, 1276, 0, 0, 0 }, count = 1, probability = 2, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },


}

function main()


    if (IsOpen() <= 0) then
        return
    end

    AddItem()
end

function IsItemIdRight()
    if (g_Item[1] == nil or g_Item[2] == nil or g_Item[3] == nil or g_Item[4] == nil) then
        return 0
    end
    return 1
end

function IsOpen()


    if (IsItemIdRight() <= 0) then
        return 0
    end

    if not (HaveNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) > 0) then
        return 0
    end

    return 1
end

function AddItem()
    ClearTask()

    local nIndex, nRand = GetRandIndex()
    if (nIndex < 0) then
        return -1
    end

    nIndex = GetPseudo(nIndex)

    if (nIndex <= 0) then
        return -1
    end

    if (g_ItemList[nIndex] == nil or g_ItemList[nIndex].name == nil or g_ItemList[nIndex].ID == nil or g_ItemList[nIndex].count == nil or g_ItemList[nIndex].needSpace == nil or g_ItemList[nIndex].addtype == nil or g_ItemList[nIndex].isnotice == nil) then
        return -1
    else
        for j = 1, 6 do
            if (g_ItemList[nIndex].ID[j] == nil) then
                return -1
            end
        end
    end

    if (IsHaveSpaceForTreasure(g_ItemList[nIndex].needSpace + 1 + g_NeedSpace) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄ±³°ü¿Õ¼ä²»×ã" .. (g_ItemList[nIndex].needSpace + g_NeedSpace) .. "¸ñ, ÇëÕûÀíºóÔÙ´ò¿ª.")
        return 0
    end

    if (DelNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) <= 0) then
        Talk(1, "no", "Ó¢ÐÛ, ÄãµÄ" .. g_Name .. "Àï³äÂú×ÅÉñÆæµÄÁ¦Á¿, ºÜÄÑ´ò¿ª°¡!")
        WriteLog("[" .. g_Name .. "][" .. g_Name .. "É¾³ýÊ§°Ü]")
        return 0
    end

    local times = GetGlobalStoreValueWord(30, 2) + 1
    if (times <= 600) then
        SetGlobalStoreValueWord(30, 2, times, 1)
    end

    local boneTimes = GetGlobalStoreValueByte(71, 3)
    local playerTimes = GetTaskByte(2167, 2)
    SetTaskByte(2167, 2, playerTimes + 1)
    if (playerTimes + 1 == boneTimes) then
        local OrableBoneID = GetGlobalStoreValueByte(71, 4)
        ORACLEBONE.GiveCardToPlayer(OrableBoneID)
    end

    local wxLog = WanXinJiaGu()

    local nItem = 0
    for i = 1, g_ItemList[nIndex].count do


        if (g_ItemList[nIndex].addtype == "AddNormalItem") then
            AddNormalItem(g_ItemList[nIndex].ID[1], g_ItemList[nIndex].ID[2], g_ItemList[nIndex].ID[3], g_ItemList[nIndex].ID[4], g_ItemList[nIndex].ID[5], g_ItemList[nIndex].ID[6])
        elseif (g_ItemList[nIndex].addtype == "AddNormalItemPile") then
            AddNormalItemPile(g_ItemList[nIndex].ID[1], g_ItemList[nIndex].ID[2], g_ItemList[nIndex].ID[3], g_ItemList[nIndex].ID[4], g_ItemList[nIndex].ID[5], g_ItemList[nIndex].ID[6])
        elseif (g_ItemList[nIndex].addtype == "AddNormalItemBind") then
            AddNormalItemBind(g_ItemList[nIndex].ID[1], g_ItemList[nIndex].ID[2], g_ItemList[nIndex].ID[3], g_ItemList[nIndex].ID[4], g_ItemList[nIndex].ID[5], g_ItemList[nIndex].ID[6], 1)
        elseif (g_ItemList[nIndex].addtype == "AddIBBuff") then
            AddIBBuff(g_ItemList[nIndex].ID[1], g_ItemList[nIndex].ID[2])
        elseif (g_ItemList[nIndex].addtype == "Earn") then
            Earn(g_ItemList[nIndex].ID[1])
        elseif (g_ItemList[nIndex].addtype == "EarnBind") then
            EarnBind(g_ItemList[nIndex].ID[1])
        end

    end
    local strMust = AddItemMust()
    local strShow = "Chóc mõng ngµi më " .. g_Name .. " nhËn ®­îc " .. strMust .. "," .. g_ItemList[nIndex].name .. "½±Àø."

    if (g_ItemList[nIndex].isnotice >= 1) then

        local str = "Chóc mõng " .. GetName() .. " më " .. g_Name .. " nhËn ®­îc " .. strMust .. "," .. g_ItemList[nIndex].name .. "½±Àø."
        Msg2CurMapAnnounce(str)

        if (g_ItemList[nIndex].isnotice >= 2) then

            AddGlobalNews(str)
        end
    end

    Msg2Player(strShow)

    strShow = "[" .. g_Name .. "] nhËn ®­îc :" .. g_ItemList[nIndex].name .. "|" .. strMust .. wxLog
    WriteLog(strShow)
end

function GetRandIndex()

    if (g_ItemList == nil) then
        return -1, -1
    end

    local nRand = math.random(1, 100 * g_Magnitude)
    local nRandSum = 0

    local nlenth = table.getn(g_ItemList)

    for i = 1, nlenth do

        if (g_ItemList[i] == nil or g_ItemList[i].probability == nil) then
            return -1, -1
        end

        nRandSum = nRandSum + (g_ItemList[i].probability * g_Magnitude)

        if (nRand <= nRandSum) then
            return i, nRand
        end
    end

    return 1, nRand
end

function GetPseudo(nIndex)

    if (nIndex == nil or g_ItemList[nIndex] == nil or g_ItemList[nIndex].name == nil) then
        return -1
    end

    local times = GetGlobalStoreValueWord(30, 2) + 1
    if (times == 588) then
        WriteLog("588 ÖÐ Tinh Th¸i Qu¸i Phï")
        return 10


    elseif (nIndex == 9) then
        local n = GetGlobalStoreValueByte(29, 2) + 1
        if (n <= 3) then
            SetGlobalStoreValueByte(29, 2, n, 1)
        else
            WriteLog("Î¢¹â¸øÃ»ÁË»»³ÉM¶nh s¸ch Ch­ HÇu")
            return 1
        end
    end

    return nIndex
end

function AddItemMust()
    AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
    AddNormalItemBind(8, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(6, 1, 1370, 1, 0, 0, 1)
    local str = "Phï nhiÖm vô Chñ ®Ò ngµy, Tiªu Dao ThÇn Tiªn T¸n, ThÎ cÇu Phóc vËn, "

    if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
        local Exp = 1000 * GetPlayerExtLevel()
        AddOwnExtendExp(Exp)
        str = str .. Exp .. " tu luyÖn"
    else
        local Exp = 1000 * GetLevel()
        AddOwnExp(Exp)
        str = str .. Exp .. " kinh nghiÖm"
    end

    return str
end

function no()
    CloseDialog()
end;

function WanXinJiaGu()
    local wxLog = ""
    if (GetGlobalStoreValueByte(112, 2) == 0) then
        return wxLog
    end

    local StartDay = GetGlobalStoreValue(110)
    local EndDay = GetGlobalStoreValue(111)
    local y, m, d = GetYMD()
    local today = y * 10000 + m * 100 + d

    if (today >= StartDay and today <= EndDay) then
        local Times = GetGlobalStoreValueByte(112, 1)
        if (Times ~= GetTaskByte(2218, 1)) then
            SetTask(2218, Times)
        end

        local boneTimes = GetGlobalStoreValueByte(112, 3)
        local playerTimes = GetTaskByte(2218, 2) + 1
        SetTaskByte(2218, 2, playerTimes)
        if (playerTimes == boneTimes) then
            local OrableBoneID = GetGlobalStoreValueByte(112, 4)
            ORACLEBONE.GiveCardToPlayer(OrableBoneID)
            wxLog = "[Æ½ÍòÏÉµÃ¼×¹Ç±àºÅ: " .. OrableBoneID .. "]"
        end
    end
    return wxLog
end

