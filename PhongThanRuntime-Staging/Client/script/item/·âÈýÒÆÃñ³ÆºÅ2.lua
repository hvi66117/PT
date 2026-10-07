Title_List = {
    { name = "·âÈý¾ø°æ³ÆºÅ(ÇÀÏÈ°æ)", id = { 6, 1, 1523 }, title = 134, },
    { name = "·âÈý¾ø°æ³ÆºÅ(×ðÏí°æ)", id = { 6, 1, 1524 }, title = 135, },
    { name = "·âÈý¾ø°æ³ÆºÅ(ChÝ T«n°æ)", id = { 6, 1, 1525 }, title = 136, },
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
        Msg2Player("B¹n nh©n ®­îc " .. Title_List[Item_Index].name .. " Danh hiÖu!")
        InfoBox("B¹n nhËn ®­îc phÇn th­ëng <c=g>" .. Title_List[Item_Index].name .. "<c> Danh hiÖu!")
        WriteLog("Sö dông" .. Title_List[Item_Index].name .. "Danh hiÖu. ")
    else
        Talk(1, "no", "Sö dông thÊt b¹i.")
    end
end

function no()
    CloseDialog()
end
