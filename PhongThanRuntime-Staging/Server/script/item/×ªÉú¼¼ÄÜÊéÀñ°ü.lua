tblItem_jiashi = {
    [1] = { name = "D‹ Chi’n D≠Ïng Chi’n", id = { 7, 61, 1482, 1, 0, 0 } },
    [2] = { name = "Huy’t Chi’n Sa Tr≠Íng", id = { 7, 60, 1481, 1, 0, 0 } },
}
tblItem_daoshi = {
    [1] = { name = "Hπo Nhi™n Ch›nh Kh›", id = { 7, 64, 1485, 1, 0, 0 } },
    [2] = { name = "Nghi÷p Ho∂ Ph«n T©m", id = { 7, 63, 1484, 1, 0, 0 } },
}
tblItem_yiren = {
    [1] = { name = "CÊ Ho∆c ChÛng Sinh", id = { 7, 67, 1488, 1, 0, 0 } },
    [2] = { name = "ßÈc Hµnh Thi™n Hπ", id = { 7, 66, 1487, 1, 0, 0 } },
}

gItemName = "L‘ bao S∏ch k¸ n®ng Chuy”n sinh"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end
    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang kh´ng c„ ÆÒ 1 ´ trËng.")
        return
    end
    local nType = GetPlayerType() + 1
    local tblItem = {}
    SetTask(140, itemID)
    if (nType == 1) then
        tblItem = tblItem_jiashi
        Say("H∑y ch‰n loπi s∏ch k¸ n®ng Chuy”n sinh muËn nhÀn: ", 2, tblItem[1].name .. "/YesItem", tblItem[2].name .. "/YesItem")
    elseif (nType == 2) then
        tblItem = tblItem_daoshi
        Say("H∑y ch‰n loπi s∏ch k¸ n®ng Chuy”n sinh muËn nhÀn: ", 2, tblItem[1].name .. "/YesItem", tblItem[2].name .. "/YesItem")
    elseif (nType == 3) then
        tblItem = tblItem_yiren
        Say("H∑y ch‰n loπi s∏ch k¸ n®ng Chuy”n sinh muËn nhÀn: ", 2, tblItem[1].name .. "/YesItem", tblItem[2].name .. "/YesItem")
    end
end

function YesItem(nIndex)
    no()
    local itemID = GetTask(140)
    nIndex = nIndex + 1
    if (nIndex <= 0 or nIndex > 2) then
        return
    end
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end
    local tblItem = {}
    local nType = GetPlayerType() + 1
    if (nType == 1) then
        tblItem = tblItem_jiashi
    elseif (nType == 2) then
        tblItem = tblItem_daoshi
    elseif (nType == 3) then
        tblItem = tblItem_yiren
    end
    local item = {}
    item = tblItem[nIndex].id
    if (DelItemByID(itemID) > 0) then
        AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], 1)
        Msg2Player("Ngµi mÎ " .. gItemName .. ", nhÀn" .. tblItem[nIndex].name .. ".")
        WriteLog("[Khuy’n mπi nπp thŒ][NhÀn Æ≠Óc]:" .. tblItem[nIndex].name)
    else
        Talk(1, "no", "MÎ l‘ bao th t bπi.")
        WriteLog("[Khuy’n mπi nπp thŒ][MÎ l‘ bao s∏ch k¸ n®ng Chuy”n sinh-th t bπi]")
    end
end

function no()
    CloseDialog()
end

