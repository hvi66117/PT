function main()

    local TABLE_MooncakeMaterial = {
        [1] = { id = 1130, name = "§­êng" },
        [2] = { id = 1131, name = "Tr¸i C©y" },
        [3] = { id = 1132, name = "H¹t sen" },
        [4] = { id = 1133, name = "§Ëu" },
    }

    if (HaveNormalItem(6, 1, 856, 0) == 0) then
        InfoBox("B¹n ch­a nhËn lÔ bao Trung Thu.")
        return
    end

    DelNormalItem(6, 1, 856, 0)

    local rand1 = math.random(1, 100)

    if (rand1 <= 40) then
        local rand2 = math.random(1, 4)
        AddNormalItem(3, TABLE_MooncakeMaterial[rand2].id, 0, 0, 0, 0)
        TopMessage("NhËn ®­îc " .. TABLE_MooncakeMaterial[rand2].name)
        Msg2Player("NhËn ®­îc " .. TABLE_MooncakeMaterial[rand2].name)
    elseif (rand1 <= 60) then
        EarnBind(10000)
        TopMessage("NhËn ®­îc 10000 b¹c khãa")
        Msg2Player("NhËn ®­îc 10000 b¹c khãa")
    elseif (rand1 <= 80) then
        AddNormalItem(6, 1, 852, 0, 0, 0)
        TopMessage("NhËn ®­îc mËt tÝch chóc phóc Trung thu")
        Msg2Player("NhËn ®­îc mËt tÝch chóc phóc Trung thu")
    else
        AddOwnExp(10000)
        TopMessage("NhËn ®­îc 10000 kinh nghiÖm")
        Msg2Player("NhËn ®­îc 10000 kinh nghiÖm")
    end


end

