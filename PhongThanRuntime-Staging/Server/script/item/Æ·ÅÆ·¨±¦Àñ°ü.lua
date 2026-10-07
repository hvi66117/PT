tblItem = {
    [1] = { name = "Kim S¨n (b∂n giÌi hπn)", id = { 0, 4, 38, 10, 0, 0, 0 } },
    [2] = { name = "Th t Tr«n Trai (vÀt)", id = { 0, 4, 66, 10, 0, 0, 0 } },
    [3] = { name = "Th t Tr«n Trai (Ma)", id = { 0, 4, 67, 10, 0, 0, 0 } },
    [4] = { name = "Tam Sinh Thπch", id = { 0, 4, 77, 10, 0, 0, 0 } },
}
gItemName = "L‘ bao Ph∏p B∂o Truy“n Thuy’t"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang kh´ng c„ ÆÒ 1 ´ trËng.")
        return
    end

    local item = {}
    for i = 1, table.getn(tblItem) do
        item[i] = tblItem[i].name .. "/YesItem"
    end

    SetTask(140, itemID)
    Say("H∑y ch‰n loπi vÀt ph»m ng≠¨i muËn nhÀn: ", table.getn(item), item)

end

function YesItem(nIndex)
    CloseDialog()
    local itemID = GetTask(140)
    nIndex = nIndex + 1
    if (nIndex <= 0 or nIndex > table.getn(tblItem)) then
        return
    end

    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh´ng c„ vÀt ph»m nµy ho∆c vÀt ph»m Æ∑ h’t hπn!")
        return
    end

    DelItemByID(itemID)
    item = tblItem[nIndex].id
    AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
    Msg2Player("Ngµi mÎ " .. gItemName .. ", nhÀn " .. tblItem[nIndex].name .. ".")
    WriteLog("[Khuy’n mπi nπp thŒ][NhÀn Æ≠Óc ]:" .. tblItem[nIndex].name)
end

function no()
    CloseDialog()
end
