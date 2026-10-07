Title_List = { { name = "∞◊Ω°§Ω∫Ô±®¥∫", id = { 6, 1, 1551 }, title = 137, },
               { name = "◊Í Ø°§Ω∫Ô±®¥∫", id = { 6, 1, 1552 }, title = 138, },
               { name = "«±¡˙°§Ω∫Ô±®¥∫", id = { 6, 1, 1553 }, title = 139, },
               { name = "ŒﬁÀ´°§Ω∫Ô±®¥∫", id = { 6, 1, 1554 }, title = 140, },
               { name = "Ch› T´n°§Ω∫Ô±®¥∫", id = { 6, 1, 1555 }, title = 141, },
               { name = "µ€Õı°§Ω∫Ô±®¥∫", id = { 6, 1, 1556 }, title = 142, },
}
Item_Index = 2

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
