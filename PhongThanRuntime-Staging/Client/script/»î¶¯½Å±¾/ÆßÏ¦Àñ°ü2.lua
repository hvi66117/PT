Task_SeventhFestival = 1717

Task_BloomLamp = 1718

Task_Cenva = 1719

Task_Answers = 1720
Task_MateID = 1721
Task_QixiState = 1722

Task_QuestOrder = 140

Save_Seventh_Festival = "TheDoubleSeventhFestival"

function no()
    CloseDialog()
end

function main()

    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        Talk(1, "no", "Tói quµ chØ cã thÓ më ë TriÒu Ca.")
        return
    end

    if (IsHaveSpaceForTreasure(6) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i råi ®Õn më Tói quµ.")
        return
    end

    local itemList = {
        [1] = { name = "BiÕn Th©n Phï *Love*", id = { 8, 161, 2 } },
        [2] = { name = "Ph¸o hoa", id = { 6, 1, 850 } },
        [3] = { name = "Hoa hång", id = { 6, 1, 849 } },
        [4] = { name = "Thanh Lé (tiÓu)", id = { 8, 28, 3 } },
        [5] = { name = "Ch©n KhÝ (tiÓu)", id = { 8, 29, 4 } },
        [6] = { name = "Siªu cÊp Håi Thµnh Phï-nhá", id = { 8, 733, 2 } },
        [7] = { name = "S« C« La", id = { 1, 6, 0 } },
        [8] = { name = "T×nh Khiªn Trang", id = { 8, 115, 2 } },
        [9] = { name = "Méng NhiÔu Trang", id = { 8, 114, 2 } },
    }

    DelNormalItem(6, 1, 848, 0)
    AddNormalItemBind(3, 1127, 0, 0, 0, 0, 1)
    AddNormalItemBind(3, 1127, 0, 0, 0, 0, 1)
    AddNormalItemBind(3, 1127, 0, 0, 0, 0, 1)

    local lingXiZhi = GetTaskByte(Task_QixiState, 3)
    local idx = 0
    if (lingXiZhi == 0) then
        idx = 2
        local item = itemList[idx].id
        AddNormalItemBind(item[1], item[2], item[3], 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc 3 ChØ Th­íc, ®ång thêi nhËn ®­îc 1" .. itemList[idx].name .. ".")
    elseif (lingXiZhi == 20 or lingXiZhi == 40) then
        idx = 3
        local item = itemList[idx].id
        AddNormalItemBind(item[1], item[2], item[3], 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc 3 ChØ Th­íc, ®ång thêi nhËn ®­îc 1" .. itemList[idx].name .. ".")
    elseif (lingXiZhi == 60) then
        AddNormalItemBind(6, 1, 849, 0, 0, 0, 1)
        AddNormalItemBind(8, 194, 2, 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc 3 ChØ Th­íc, ®ång thêi nhËn ®­îc 1 Hoa Hång vµ T©m T©m t­¬ng ¸nh phï.")
    elseif (lingXiZhi == 80) then
        AddNormalItemBind(6, 1, 849, 0, 0, 0, 1)
        AddNormalItemBind(8, 194, 2, 0, 0, 0, 1)
        AddNormalItemBind(8, 28, 3, 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc 3 ChØ Th­íc, 1 Hoa Hång vµ T©m T©m t­¬ng ¸nh phï, ®ång thêi nhËn ®­îc 1 Thanh Lé (tiÓu).")
    elseif (lingXiZhi == 100) then
        AddNormalItemBind(6, 1, 849, 0, 0, 0, 1)
        AddNormalItemBind(8, 194, 2, 0, 0, 0, 1)
        AddNormalItemBind(8, 162, 3, 0, 0, 0, 1)
        Msg2Player("NhËn ®­îc 3 ChØ Th­íc, 1 Hoa Hång vµ T©m T©m t­¬ng ¸nh phï, ®ång thêi nhËn ®­îc 1 Thanh Lé.")
    end

    WriteLog(GetName() .. "§· më Tói quµ ThÊt TÞch.")
end
