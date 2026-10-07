Title_List = {
    { name = "æûÍõµÄ¹óÈË", id = { 6, 1, 1519 }, title = 131, },
    { name = "æûÍõµÄÐÄ¸¹", id = { 6, 1, 1520 }, title = 132, },
    { name = "æûÍõµÄÇ×ÐÅ", id = { 6, 1, 1521 }, title = 133, },
}
Item_Index = 3

function main()
    local nItemList = Title_List[Item_Index]
    if ((HaveNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) or (HaveNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1)) then
        if (HaveNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) then
            local result = DelNormalItem(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1)
        elseif (HaveNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1) >= 1) then
            local result = DelNormalItemInQuick(nItemList.id[1], nItemList.id[2], nItemList.id[3], 1)
        end
        if (result == 0) then
            Talk(1, "no", "Sö dông thÊt b¹i.")
            WriteLog("Sö dông" .. Title_List[Item_Index].name .. "³ÆºÅÊ§°Ü.")
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
