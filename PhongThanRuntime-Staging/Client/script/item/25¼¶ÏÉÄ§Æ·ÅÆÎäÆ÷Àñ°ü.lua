tblItem = {
    [1] = { { name = "VÚ kh› ph»m ch t-Ngæn (Th≠¨ng Khung)", id = { 0, 0, 84, 1, 0, 0, 0 } },
            { name = "VÚ kh› ph»m ch t-Dµi (ßoπn Nhπc)", id = { 0, 0, 85, 1, 0, 0, 0 } } },
    [2] = { { name = "Ng˘ Phong", id = { 0, 0, 86, 1, 0, 0, 0 } } },
    [3] = { { name = "Tµn Dπ", id = { 0, 0, 87, 1, 0, 0, 0 } } },
}
gItemName = "R≠¨ng VÚ kh› Ti™n Ma c p 25"

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
    local item = {}
    if (nType == 1) then
        SetTask(140, itemID)
        Say("H∑y ch‰n loπi vÀt ph»m ng≠¨i muËn nhÀn: ", 2, tblItem[nType][1].name .. "/YesItem", tblItem[nType][2].name .. "/YesItem")
    else
        DelItemByID(itemID)
        item = tblItem[nType][1].id
        AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
        Msg2Player("Ngµi mÎ " .. gItemName .. ", nhÀn" .. tblItem[nType][1].name .. ".")
        WriteLog("[Khuy’n mπi nπp thŒ][NhÀn Æ≠Óc ]:" .. tblItem[nType][1].name)
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

    local nType = GetPlayerType() + 1
    local item = {}
    DelItemByID(itemID)
    item = tblItem[nType][nIndex].id
    AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
    Msg2Player("Ngµi mÎ " .. gItemName .. ", nhÀn" .. tblItem[nType][nIndex].name .. ".")
    WriteLog("[Khuy’n mπi nπp thŒ][NhÀn Æ≠Óc ]:" .. tblItem[nType][nIndex].name)
end

function no()
    CloseDialog()
end
