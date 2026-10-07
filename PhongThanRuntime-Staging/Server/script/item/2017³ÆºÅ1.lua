Title_List = { { name = "∞◊Ω°§Ωº¶±®œ≤", id = { 6, 1, 1667 }, title = 146, },
               { name = "◊Í Ø°§Ωº¶±®œ≤", id = { 6, 1, 1668 }, title = 147, },
               { name = "«±¡˙°§Ωº¶±®œ≤", id = { 6, 1, 1669 }, title = 148, },
               { name = "Ch› T´n°§Ωº¶±®œ≤", id = { 6, 1, 1670 }, title = 149, },
               { name = "ŒﬁÀ´°§Ωº¶±®œ≤", id = { 6, 1, 1671 }, title = 150, },
               { name = "µ€Õı°§Ωº¶±®œ≤", id = { 6, 1, 1672 }, title = 151, },
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
