SaveChrismasData = "SaveChrismasData"
SaveDay = 1
SnowBallNumber = 2
ChrismasManNum = 3
MoneyNum = 4
ChocolateNumber = 5

Task_Christmas = 1742

Task_ChristmasState = 1743

Task_ChristamasPoint = 1839

Task_ChristmasMan = 1840

Task_ChristmasNum = 1842

ItemList = {
    [1] = { itemID = { 6, 1, 782, 0, 0, 0 }, itemName = "Ph¸o Gi¸ng Sinh", nRand = 3000, nNum = -1, itemNum = 1, nBind = 1 },
    [2] = { itemID = { 6, 1, 783, 0, 0, 0 }, itemName = "KÑo Gi¸ng Sinh", nRand = 1500, nNum = -1, itemNum = 1, nBind = 1 },
    [3] = { itemID = { 8, 223, 2, 0, 0, 0 }, itemName = "BiÕn phï Gi¸ng sinh", nRand = 1000, nNum = -1, itemNum = 1, nBind = 1 },
    [4] = { itemID = { 8, 381, 3, 0, 0, 0 }, itemName = "Thanh Lé (Nh­ ý)", nRand = 1000, nNum = -1, itemNum = 1, nBind = 1 },
    [5] = { itemID = { 8, 382, 3, 0, 0, 0 }, itemName = "Ch©n KhÝ (Nh­ ý)", nRand = 1000, nNum = -1, itemNum = 1, nBind = 1 },
    [6] = { nMoney = 1000000, itemName = "100 v¹n l­îng", nRand = 500, nNum = -1, itemNum = 1, nBind = 1 },
    [7] = { itemID = { 3, 41, 0, 0, 0, 0 }, itemName = "Lam b¶o th¹ch", nRand = 500, nNum = -1, itemNum = 1, nBind = -1 },
    [8] = { itemID = { 3, 1149, 0, 0, 0, 0 }, itemName = "M¶nh Tö thuû tinh", nRand = 300, nNum = -1, itemNum = 1, nBind = -1 },
    [9] = { itemID = { 3, 79, 0, 0, 0, 0 }, itemName = "Hång b¶o th¹ch", nRand = 800, nNum = -1, itemNum = 1, nBind = -1 },
    [10] = { itemID = { 1, 6, 0, 0, 0, 0 }, itemName = "S« C« La", nRand = 375, nNum = 100, itemNum = 2, nBind = -1 },
    [11] = { nMoney = 1000000, itemName = " 100 v¹n b¹c", nRand = 25, nNum = 20, itemNum = 1, nBind = -1 },
}

function ClearIniInfo()
    local iniSaveDay = LoadIniInteger(SaveChrismasData, SaveDay)
    local nYear, nMonth, nDay = GetYMD()

    if iniSaveDay ~= nDay then
        SaveIniInteger(SaveChrismasData, SaveDay, nDay)
        SaveIniInteger(SaveChrismasData, SnowBallNumber, 0)
        SaveIniInteger(SaveChrismasData, ChrismasManNum, 0)
        SaveIniInteger(SaveChrismasData, MoneyNum, 0)
        SaveIniInteger(SaveChrismasData, ChocolateNumber, 0)
    end
end

function main()
    ClearIniInfo()

    local mapid, x, y = GetWorldPos()

    if (mapid ~= 21) then
        Talk(1, "no", "Quµ tÆng chØ cã thÓ më ë TriÒu Ca.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ chç trèng, h·y s¾p xÕp råi h·y më tói quµ")
        return
    end

    if (HaveNormalItem(6, 1, 863, 0) <= 0) then
        return
    end

    DelNormalItem(6, 1, 863, 0)

    local order = SearchItemID()
    local flag = 1
    if (order <= 0 or order > table.getn(ItemList)) then
        order = 1
    end

    local itemName = ItemList[order].itemName
    local itemNum = ItemList[order].itemNum

    if order == 10 then
        local nChocolateNum = LoadIniInteger(SaveChrismasData, ChocolateNumber) + 1
        if nChocolateNum <= ItemList[order].nNum then
            local itemID = ItemList[order].itemID
            for i = 1, itemNum do
                AddNormalItemPile(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6])
            end
            Msg2Player("¹§Ï²»ñµÃÊ¥µ®ÀñÎï:  2 c¸i ÇÉ¿ËÁ¦.")
            AddGlobalNews("<c=g>" .. GetName() .. "<c>Më Tói quµ gi¸ng sinh nhËn ®­îc phÇn th­ëng " .. itemNum .. " <c=yel>" .. itemName .. "<c>.")
            SaveIniInteger(SaveChrismasData, ChocolateNumber, nChocolateNum)
        else
            order = math.random(1, 9)
        end
    elseif order == 11 then
        local nMoneyNum = LoadIniInteger(SaveChrismasData, MoneyNum) + 1

        if nMoneyNum <= ItemList[order].nNum then
            local nMoney = ItemList[order].nMoney

            Earn(nMoney)
            SaveIniInteger(SaveChrismasData, MoneyNum, nMoneyNum)
            Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemName .. ".")
            AddGlobalNews("<c=g>" .. GetName() .. "<c>Më Tói quµ gi¸ng sinh nhËn ®­îc phÇn th­ëng bÊt ngê<c=yel>" .. itemName .. "<c>.")
            WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemName)
        else
            order = math.random(1, 7)
        end
    end

    if order <= 9 then
        if (order == 6) then
            local nMoney = ItemList[order].nMoney
            EarnBind(nMoney)
            Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemName .. ".")
            WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemName)
            return
        else

            local itemID = ItemList[order].itemID
            local nBind = ItemList[order].nBind
            itemName = ItemList[order].itemName
            itemNum = ItemList[order].itemNum

            if nBind == 1 then
                AddNormalItemBind(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6], 1)
            else
                AddNormalItem(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6])
            end
        end
    end

    if order <= 9 and order ~= 6 then
        Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemNum .. "." .. itemName .. ".")
        WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemNum .. "." .. itemName)
    end

end

function SearchItemID()
    no()
    local Rand = math.random(1, 10000)
    local nRand = 0
    for i = 1, table.getn(ItemList) do
        nRand = nRand + ItemList[i].nRand
        if (Rand <= nRand) then
            return i
        end
    end
    return 1
end

function no()
    CloseDialog();
end
