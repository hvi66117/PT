Title_List = { { name = "∞◊Ω°§œ≤∆¯—Û—Û", id = { 6, 1, 1383 }, title = 122, },
               { name = "◊Í Ø°§œ≤∆¯—Û—Û", id = { 6, 1, 1384 }, title = 123, },
               { name = "«±¡˙°§œ≤∆¯—Û—Û", id = { 6, 1, 1385 }, title = 124, },
               { name = "ŒﬁÀ´°§œ≤∆¯—Û—Û", id = { 6, 1, 1386 }, title = 125, },
               { name = "Ch› T´n°§œ≤∆¯—Û—Û", id = { 6, 1, 1387 }, title = 126, },
}
Item_Index = 5

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
