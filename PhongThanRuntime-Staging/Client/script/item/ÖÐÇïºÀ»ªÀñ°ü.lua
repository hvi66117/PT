Global_AwardInfo = 634

function main()

    local TABLE_MooncakeMaterial = {
        [1] = { id = 1131, name = "Tr¸i C©y" },
        [2] = { id = 1132, name = "H¹t sen" },
        [3] = { id = 1133, name = "§Ëu" },
    }

    if (HaveNormalItem(6, 1, 858, 0) == 0) then
        InfoBox("B¹n kh«ng nhËn ®­îc ®¹i lÔ bao Trung thu")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("Tói kh«ng ®ñ chç trèng, kh«ng thÓ nhËn hÕt toµn bé phÇn th­ëng, cÇn cã 2 « trèng.")
        return
    end

    DelNormalItem(6, 1, 858, 0)

    AddItemPileNum(3, 1130, 0, 0, 1)
    local rand2 = math.random(1, 3)
    AddItemPileNum(3, TABLE_MooncakeMaterial[rand2].id, 0, 0, 1)
    TopMessage("NhËn ®­îc §­êng vµ " .. TABLE_MooncakeMaterial[rand2].name)
    Msg2Player("NhËn ®­îc §­êng vµ " .. TABLE_MooncakeMaterial[rand2].name)

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local awardsTable = {
        [1] = { prob = 200, Item = { 8, 162, 3 }, name = "Thanh Lé" },
        [2] = { prob = 400, Item = { 8, 163, 4 }, name = "Ch©n KhÝ" },
        [3] = { prob = 520, Item = { 8, 733, 2 }, name = "Siªu cÊp Håi Thµnh Phï-nhá" },
        [4] = { prob = 600, Item = { 8, 35, 2 }, name = "Di ngo¹i phï" },
        [5] = { prob = 770, Item = { 8, 48, 2 }, name = "Phóc Hé phï" },
        [6] = { prob = 830, Item = { 8, 1345, 2 }, name = "HuyÒn S¾c Thñy Ng©n" },
        [7] = { prob = 890, Item = { 8, 30, 2 }, name = "ChØ Nam Ch©u" },
        [8] = { prob = 990, Item = { 3, 1149, 0 }, name = "M¶nh Tö thuû tinh" },
        [9] = { prob = 999, Item = { 3, 88, 0 }, name = "M¶nh Hoµng thñy tinh" },
        [10] = { prob = 1000, Item = { 8, 1346, 2 }, name = "Tinh chÕ HuyÒn S¾c Thñy Ng©n" },
    }
    local i = 1
    local awardsRand = math.random(1, 1000)

    while i <= table.getn(awardsTable) do

        if awardsRand <= awardsTable[i].prob then

            if i == 9 then

                local nTimes = GetGlobalValueByte(Global_AwardInfo, 1)
                local lastday = GetGlobalValueByte(Global_AwardInfo, 2)

                if lastday ~= today then

                    nTimes = 1
                    SetGlobalValueByte(Global_AwardInfo, 1, 0)
                    SetGlobalValueByte(Global_AwardInfo, 2, today)

                end

                if nTimes <= 5 then


                    SetGlobalValueByte(Global_AwardInfo, 1, nTimes + 1)

                    break

                else


                    i = 0

                    awardsRand = math.random(1, 1000)


                end

            elseif i == 10 then

                local lastday = GetGlobalValueByte(Global_AwardInfo, 4)

                if lastday ~= today then

                    SetGlobalValueByte(Global_AwardInfo, 4, today)
                    break

                else


                    i = 0

                    awardsRand = math.random(1, 1000)

                end

            elseif i >= 1 and i <= 8 then

                break

            end

        end

        i = i + 1

    end

    AddNormalItemBind(awardsTable[i]["Item"][1], awardsTable[i]["Item"][2], awardsTable[i]["Item"][3], 0, 0, 0, 1)
    TopMessage("NhËn ®­îc " .. awardsTable[i].name)
    Msg2Player("NhËn ®­îc " .. awardsTable[i].name)
    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më lÔ bao Trung Thu (hµo hoa) may m¾n nhËn ®­îc <c=g>" .. awardsTable[i].name .. "<c>")
    AddGlobalNews("<RoleName=\"" .. GetName() .. "\">Më lÔ bao Trung Thu (hµo hoa) may m¾n nhËn ®­îc <c=g>" .. awardsTable[i].name .. "<c>")
    WriteLog("NhËn ®­îc " .. awardsTable[i].name)


end

