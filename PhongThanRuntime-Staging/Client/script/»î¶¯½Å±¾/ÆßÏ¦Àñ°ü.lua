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

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "CÇn 3 chç trèng trong hµnh trang míi cã thÓ më Tói quµ.")
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
    DelNormalItem(6, 1, 846, 0)
    AddNormalItemBind(3, 1127, 0, 0, 0, 0, 1)
    local nRand = math.random(1, 3)
    local item = itemList[nRand].id
    AddNormalItemBind(item[1], item[2], item[3], 0, 0, 0, 1)
    Msg2Player("NhËn ®­îc 1 ChØ Th­íc, ®ång thêi nhËn ®­îc 1" .. itemList[nRand].name .. ".")

    local Rand = math.random(1, 100)
    local idx = 0
    local itemNum = LoadIniInteger(Save_Seventh_Festival, 1)
    if (Rand <= 80) then
        if (Rand <= 25) then
            local item1 = itemList[4].id
            idx = 4
            AddNormalItemBind(item1[1], item1[2], item1[3], 0, 0, 0, 1)
        elseif (Rand > 25 and Rand <= 50) then
            local item2 = itemList[5].id
            idx = 5
            AddNormalItemBind(item2[1], item2[2], item2[3], 0, 0, 0, 1)
        elseif (Rand > 50 and Rand <= 70) then
            local item3 = itemList[6].id
            idx = 6
            AddNormalItemBind(item3[1], item3[2], item3[3], 0, 0, 0, 1)
        elseif (Rand > 70 and Rand <= 75 and itemNum <= 50) then
            local item4 = itemList[7].id
            idx = 7
            AddNormalItemBind(item4[1], item4[2], item4[3], 0, 0, 0, 1)
            SaveIniInteger(Save_Seventh_Festival, 1, itemNum + 1)
        elseif (Rand > 75 and Rand <= 80) then
            local playerSex = GetSex()
            local item5 = itemList[8].id
            if (playerSex == 1) then
                item5 = itemList[8].id
                idx = 8
            else
                item5 = itemList[9].id
                idx = 9
            end
            AddNormalItemBind(item5[1], item5[2], item5[3], 0, 0, 0, 1)
        end
    end

    if (idx >= 4 and idx <= 6) then
        Msg2CurMapAnnounce(GetName() .. "Håi hép më Tói quµ ThÊt TÞch, nhËn ®­îc 1 " .. itemList[idx].name .. ".")
    elseif (idx >= 7 and idx <= 9) then
        Msg2CurMapAnnounce(GetName() .. "Më Tói quµ ThÊt TÞch vµ bÊt ngê nhËn ®­îc <c=g>" .. itemList[idx].name .. "<c>, ®óng lµ may m¾n tõ trªn trêi r¬i xuèng.")
        AddGlobalCountNews(GetName() .. "Më Tói quµ ThÊt TÞch vµ bÊt ngê nhËn ®­îc <c=g>" .. itemList[idx].name .. "<c>, ®óng lµ may m¾n tõ trªn trêi r¬i xuèng.", 3)
    end

    WriteLog(GetName() .. "§· më Tói quµ ThÊt TÞch.")
end
