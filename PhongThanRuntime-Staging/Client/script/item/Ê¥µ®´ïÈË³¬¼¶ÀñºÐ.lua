Task_Christmas = 1742

Task_ChristmasState = 1743

Task_ChristamasPoint = 1839

Task_ChristmasMan = 1840

Task_ChristmasNum = 1842

Global_ChristmasIndex = 603
Global_ChristmasID = 604
Global_SnowPosVal1 = 605
Global_SnowPosVal2 = 606

SaveChrismasData = "SaveChrismasData"
SaveDay = 1
SnowBallNumber = 2
ChrismasManNum = 3
MoneyNum = 4
ChocolateNumber = 5

ItemList = {
    [1] = { itemID = { 6, 1, 901, 0, 0, 0 }, itemName = "Thiªn Ngo¹i Phi Tiªn Trang", nRand = 10000, nNum = -1, itemNum = 1, nBind = -1 },
    [2] = { itemID = { 8, 1422, 2, 0, 0, 0 }, itemName = "S¸ch Ch­ HÇu (Tµn trang)", nRand = 2000, nNum = -1, itemNum = 2, nBind = -1 },
    [3] = { itemID = { 3, 374, 0, 0, 0, 0 }, itemName = "Vi Quang Qu¸i Phï", nRand = 2000, nNum = -1, itemNum = 1, nBind = -1 },
    [4] = { nMoney = 50000000, itemName = "5000 v¹n b¹c", nRand = 2000, nNum = -1, itemNum = 1, nBind = -1 },
    [5] = { nMoney = 50000000, itemName = "5000 v¹n b¹c khãa", nRand = 2000, nNum = -1, itemNum = 1, nBind = 1 },
    [6] = { itemID = { 3, 252, 0, 0, 0, 0 }, itemName = "Hoµng BÝch TØ", nRand = 1000, nNum = -1, itemNum = 1, nBind = -1 },
    [7] = { itemID = { 3, 1152, 0, 0, 0, 0 }, itemName = "Tö BÝch TØ", nRand = 1000, nNum = -1, itemNum = 1, nBind = -1 },
}

function ClearTaskInfo()
    local lastDay = GetTaskByte(Task_ChristmasState, 1)
    local nDay = math.mod(math.floor(LocalSystemTime() / 86400), 256)

    if (nDay ~= lastDay) then
        SetTaskByte(Task_ChristmasState, 1, nDay)
        SetTask(Task_Christmas, 0)
        SetTaskByte(Task_ChristmasState, 2, 0)
        SetTaskByte(Task_ChristmasState, 3, 0)
        SetTaskByte(Task_ChristmasState, 4, 0)
        SetTaskWord(Task_ChristamasPoint, 1, 0)

        SetTask(Task_ChristmasMan, 0)
        SetTask(Task_ChristmasNum, 0)
        TaskNote(1625, -1)
        RemoveIBBuff(1419)
    end
end

function main()
    ClearTaskInfo()

    local mapid, x, y = GetWorldPos()

    if (mapid ~= 21) then
        Talk(1, "no", "Quµ tÆng chØ cã thÓ më ë TriÒu Ca.")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ chç trèng, h·y s¾p xÕp råi h·y më tói quµ")
        return
    end

    if (HaveNormalItem(6, 1, 898, 0) <= 0) then
        return
    end

    DelNormalItem(6, 1, 898, 0)

    local order = SearchItemID()
    local flag = 1
    if (order <= 0 or order > table.getn(ItemList)) then
        order = 2
    end

    local itemName = ItemList[order].itemName
    local itemNum = ItemList[order].itemNum

    for i = 1, 20 do
        AddNormalItemPile(1, 6, 0, 1, 0, 0)
    end
    for i = 1, 5 do
        AddNormalItemPile(8, 1420, 2, 0, 0, 0)
    end

    if (GetTaskBit(Task_ChristamasPoint, 31, 0) == 0) then
        local itemID = ItemList[1].itemID
        SetTaskBit(Task_ChristamasPoint, 31, 1)
        AddNormalItemPile(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6])
        AddGlobalNews("<c=g>" .. GetName() .. "<c>¿ªÆôÊ¥µ®Àñ°üÒâÍâµÄ nhËn ®­îc 1 c¸i <c=yel>ÌìÍâ·ÉÏÉ×°<c>.")
        Msg2Player("Chóc m­õng ngµi nhËn ®­îc 1 c¸i <c=yel>ÌìÍâ·ÉÏÉ×°<c>.")
        WriteLog(GetName() .. "ÔÚ¿ªÆôÀñ°üÊ± nhËn ®­îc ÌìÍâ·ÉÏÉ×°")
    end

    if (order == 4) then
        local nMoney = ItemList[order].nMoney
        Earn(nMoney)
        Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemName .. ".")
        WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemName)
    elseif (order == 5) then
        local nMoney = ItemList[order].nMoney
        EarnBind(nMoney)
        Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemName .. ".")
        WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemName)
    else
        local itemID = ItemList[order].itemID
        local nBind = ItemList[order].nBind
        itemName = ItemList[order].itemName
        itemNum = ItemList[order].itemNum
        for i = 1, itemNum do
            if nBind == 1 then
                AddNormalItemBind(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6], 1)
            else
                AddNormalItem(itemID[1], itemID[2], itemID[3], itemID[4], itemID[5], itemID[6])
            end
        end
        Msg2Player("Chóc mõng nhËn ®­îc quµ Gi¸ng sinh: " .. itemNum .. "." .. itemName .. ".")
        WriteLog(GetName() .. "Khi më tói quµ nhËn ®­îc " .. itemNum .. "." .. itemName)
    end
end

function SearchItemID()
    no()
    local Rand = math.random(1, 10000)
    local nRand = 0
    for i = 2, table.getn(ItemList) do
        nRand = nRand + ItemList[i].nRand
        if (Rand <= nRand) then
            return i
        end
    end
    return 2
end

function no()
    CloseDialog();
end
