ItemTable = {
    [1] = { itemName = "Trang Nguy™n (cao c p)", itemID = { 8, 284, 2, 0 }, itemCount = 1, MessageType = 1, MessageCount = 1 },
    [2] = { itemName = "Tr«m ßi÷n", itemID = { 8, 191, 2, 0 }, itemCount = 1, MessageType = 1, MessageCount = 1 },
}
ItemRandom = {
    [1] = { itemName = "Di ngoπi phÔ", itemID = { 8, 35, 2, 0 }, percent = 70, itemCount = 1, MessageType = 1, MessageCount = 1 },
    [2] = { itemName = "Di Quang k›nh", itemID = { 8, 509, 2, 0 }, percent = 10, itemCount = 1, MessageType = 1, MessageCount = 1 },
    [3] = { itemName = "Dao Ti™n t∏n", itemID = { 8, 374, 0, 0 }, percent = 20, itemCount = 1, MessageType = 1, MessageCount = 1 },
}
BoxName = "ßπi l‘ bao C≠Íng ho∏ Trang bﬁ"
boxID = { 6, 1, 1116, 1 }
function no()
    CloseDialog()
end

function main(nItemId)
    if (HaveNormalItem(boxID[1], boxID[2], boxID[3], boxID[4]) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        InfoBox("TÛi kh´ng ÆÒ 3 ´, h∑y sæp x’p tÛi lπi.")
        return
    end

    DelNormalItem(boxID[1], boxID[2], boxID[3], boxID[4])

    local str = ""
    for i = 1, table.getn(ItemTable) do
        for j = 1, ItemTable[i].itemCount do
            AddNormalItemBind(ItemTable[i].itemID[1], ItemTable[i].itemID[2], ItemTable[i].itemID[3], ItemTable[i].itemID[4], 0, 0, 1)
        end
        str = str .. ItemTable[i].itemCount .. "." .. ItemTable[i].itemName
        if (i == (table.getn(ItemTable) - 1)) then
            str = str .. " vµ "
        elseif (i == table.getn(ItemTable)) then
            str = str .. "."
        else
            str = str .. ","
        end
    end
    local nTemp = 0
    local nRandom = math.random(1, 100)
    for i = 1, table.getn(ItemRandom) do
        nTemp = nTemp + ItemRandom[i].percent
        if (nTemp >= nRandom) then
            AddNormalItemBind(ItemRandom[i].itemID[1], ItemRandom[i].itemID[2], ItemRandom[i].itemID[3], ItemRandom[i].itemID[4], 0, 0, 1)
            str = str .. "≤¢∂ÓÕ‚ nhÀn Æ≠Óc " .. ItemRandom[i].itemName .. "."
            break
        end
    end

    Msg2Player("Ng≠¨i Æ∑ nhÀn Æ≠Óc " .. str)
    WriteLog("[" .. BoxName .. "]")
end
