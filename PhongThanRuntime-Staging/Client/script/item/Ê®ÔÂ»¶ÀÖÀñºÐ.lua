thisTimes = 108

function ClearTask()

    local y, m, d = GetYMD()
    if (GetGlobalStoreValueByte(30, 1) ~= thisTimes) then
        SetGlobalStoreValueByte(30, 1, thisTimes, 1)
        SetGlobalStoreValueByte(30, 2, d, 1)
        SetGlobalStoreValueWord(30, 2, 0, 1)
        SetGlobalStoreValueByte(29, 2, 0, 1)
    end


end

g_Item = { 6, 1, 1352, 1 }

g_Name = "Ê®ÔÂ»¶ÀÖÀñºÐ"

g_Magnitude = 100000

g_NeedSpace = 4

g_ItemList = {
    [1] = { name = "Tinh Th¸i Qu¸i Phï", ID = { 3, 383, 0, 0, 0, 0 }, count = 1, probability = 0, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [2] = { name = "Vi Quang Qu¸i Phï", ID = { 3, 374, 0, 0, 0, 0 }, count = 1, probability = 1, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [3] = { name = "Tói Quµ Danh Ngäc", ID = { 8, 1447, 2, 0, 0, 0 }, count = 1, probability = 20, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [4] = { name = "LÔ hép Phï Th¹ch", ID = { 8, 1775, 2, 0, 0, 0 }, count = 1, probability = 20, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [5] = { name = "Tói quµ §å phæ Ph¸ Qu©n", ID = { 6, 1, 1046, 1, 0, 0 }, count = 1, probability = 10, needSpace = 1, addtype = "AddNormalItemBind", isnotice = 1, },
    [6] = { name = "", ID = {}, count = 1, probability = 49, needSpace = 0, addtype = "nil", isnotice = 0, },
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
    elseif (g_ItemList[nIndex].addtype ~= "nil") then
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
        elseif (g_ItemList[nIndex].addtype == "nil") then

        end
    end

    local strMust = AddItemMust()
    local strShow = "Chóc mõng ngµi më " .. g_Name .. " nhËn ®­îc " .. strMust

    if (g_ItemList[nIndex].isnotice >= 1) then

        local str = "Chóc mõng " .. GetName() .. " më " .. g_Name .. " nhËn ®­îc " .. strMust .. "," .. g_ItemList[nIndex].name .. "½±Àø."
        Msg2CurMapAnnounce(str)
        Msg2TongMember(str)

        if (g_ItemList[nIndex].isnotice >= 2) then

            AddGlobalNews(str)
        end

        strShow = strShow .. ", Í¬Ê±nhËn ®­îc " .. g_ItemList[nIndex].name
    end

    strShow = strShow .. "."
    Msg2Player(strShow)

    strShow = "[" .. GetName() .. strShow .. "]"
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
        nIndex = -1
    end

    local times = GetGlobalStoreValueWord(30, 2) + 1
    if (times == 188) then
        WriteLog("188 ÖÐ Tinh Th¸i Qu¸i Phï")
        nIndex = 1


    elseif (nIndex == 2) then
        local n = GetTaskByte(2070, 1) + 1
        if (n <= 1) then
            SetTaskByte(2070, 1, n)
        else
            WriteLog("Î¢¹â¸øÃ»ÁË»»³ÉLÔ bao Danh Ngäc")
            nIndex = 3
        end
    end

    return nIndex
end

function AddItemMust()

    local str = "ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ, M¶nh s¸ch Ch­ HÇu/Tµn trang, T­íng Qu©n LÖnh, Phï nhiÖm vô Chñ ®Ò ngµyx3"

    if (GetLevel() >= 200 and GetJusticEvilCredit() ~= 0) then
        AddNormalItemBind(6, 1, 1084, 1, 0, 0, 1)
        AddNormalItemBind(8, 1422, 5, 0, 0, 0, 1)
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        for i = 1, 3 do
            AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
        end
        str = "ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ, M¶nh s¸ch Ch­ HÇu, T­íng Qu©n LÖnh, Phï nhiÖm vô Chñ ®Ò ngµyx3"
    else
        AddNormalItemBind(6, 1, 1084, 1, 0, 0, 1)
        AddNormalItemBind(8, 193, 5, 0, 0, 0, 1)
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        for i = 1, 3 do
            AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
        end
        str = "ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ, M¶nh s¸ch Ch­ HÇu, T­íng Qu©n LÖnh, Phï nhiÖm vô Chñ ®Ò ngµyx3"
    end
    return str
end

function no()
    CloseDialog()
end;
