function main()

    local TABLE_MooncakeMaterial = {
        [1] = { id = 1130, name = "§­êng" },
        [2] = { id = 1131, name = "Tr¸i C©y" },
        [3] = { id = 1132, name = "H¹t sen" },
        [4] = { id = 1133, name = "§Ëu" },
    }

    if (HaveNormalItem(6, 1, 857, 0) == 0) then
        InfoBox("B¹n kh«ng nhËn ®­îc ®¹i lÔ bao Trung thu")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("Tói kh«ng ®ñ chç trèng, kh«ng thÓ nhËn hÕt toµn bé phÇn th­ëng, cÇn cã 2 « trèng.")
        return
    end

    DelNormalItem(6, 1, 857, 0)

    AddNormalItem(6, 1, 852, 0, 0, 0)
    TopMessage("NhËn ®­îc mËt tÝch chóc phóc Trung thu")
    Msg2Player("NhËn ®­îc mËt tÝch chóc phóc Trung thu")

    local rand1 = math.random(1, 100)

    if (rand1 <= 40) then
        local rand2 = math.random(1, 4)
        local rand3 = math.random(1, 4)
        AddItemPileNum(3, TABLE_MooncakeMaterial[rand2].id, 0, 0, 1)
        AddItemPileNum(3, TABLE_MooncakeMaterial[rand3].id, 0, 0, 1)
        if (rand2 == rand3) then
            TopMessage("NhËn ®­îc 2 " .. TABLE_MooncakeMaterial[rand2].name)
            Msg2Player("NhËn ®­îc 2 " .. TABLE_MooncakeMaterial[rand2].name)
        else
            TopMessage("NhËn ®­îc 1 " .. TABLE_MooncakeMaterial[rand2].name .. " vµ 1 " .. TABLE_MooncakeMaterial[rand3].name)
            Msg2Player("NhËn ®­îc 1 " .. TABLE_MooncakeMaterial[rand2].name .. " vµ 1 " .. TABLE_MooncakeMaterial[rand3].name)
        end
    elseif (rand1 <= 60) then
        AddNormalItemBind(8, 28, 3, 0, 0, 0, 1)
        TopMessage("NhËn ®­îc Thanh Lé (tiÓu)")
        Msg2Player("NhËn ®­îc Thanh Lé (tiÓu)")
        WriteLog("NhËn ®­îc Thanh Lé (tiÓu)")
    elseif (rand1 <= 80) then
        AddNormalItemBind(8, 29, 3, 0, 0, 0, 1)
        TopMessage("NhËn ®­îc Ch©n KhÝ (tiÓu)")
        Msg2Player("NhËn ®­îc Ch©n KhÝ (tiÓu)")
        WriteLog("NhËn ®­îc Ch©n KhÝ (tiÓu)")
    else
        AddNormalItemBind(8, 733, 3, 0, 0, 0, 1)
        TopMessage("NhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá")
        Msg2Player("NhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá")
        WriteLog("NhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá")
    end


end

