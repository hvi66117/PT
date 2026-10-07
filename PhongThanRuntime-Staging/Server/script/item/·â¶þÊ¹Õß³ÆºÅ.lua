Title_List = {
    { name = "∑‚∂˛ π’ﬂ", id = { 6, 1, 1462 }, title = 129, },
    { name = "∑‚∂˛ Kim Ti™n", id = { 6, 1, 1463 }, title = 130, },
}
Item_Index = 1

function main()
    local nItemList = Title_List[Item_Index]
    if ((HaveNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) or (HaveNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1)) then
        if (HaveNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) then
            DelNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1)
        elseif (HaveNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) then
            DelNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1)
        end
        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end
        ActiveTitleQualify(Title_List[Item_Index].title)
        SetCurTitle(Title_List[Item_Index].title)
        Msg2Player("Bπn nh©n Æ≠Óc " .. Title_List[Item_Index].name .. " Danh hi÷u!")
        InfoBox("Bπn nhÀn Æ≠Óc ph«n th≠Îng <c=g>" .. Title_List[Item_Index].name .. "<c> Danh hi÷u!")
    else
        Talk(1, "no", "Sˆ dÙng th t bπi.")
    end
end

function no()
    CloseDialog()
end
