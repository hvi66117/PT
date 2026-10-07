changvariable = 1979
packagevarable = 1980
function main()
    if (jieshu() == 1) then
        Talk(1, "no", "B¹n ®· nhËn hÕt phÇn th­ëng trong tói quµ!")
        return 0
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 2 « trèng, xin h·y s¾p xÕp l¹i!.")
        return
    end

    tasks = {
        { "Trang 1", "page1"; show = 1 },
        { "Trang 2", "page2"; show = 1 },
        { "Trang 3", "page3"; show = 1 },
        { "Trang 4", "page4"; show = 1 },
        { "Trang 5", "page5"; show = 1 },
    }
    SayTask("Anh Hïng Phong ThÇn-§¹i LÔ Bao, v« sè b¶o vËt chê anh hïng ®Õn lÊy!<enter>CÊp cµng cao, phÇn th­ëng nhËn cµng nhiÒu!<enter>H·y theo thø tù nhËn th­ëng!", tasks)
end
function page1()
    local zt_name = {}
    for i = 1, 9 do
        if (GetTaskBit(changvariable, i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else
            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end

    local opra = {
        "D­îc phÈm t©n thñ + ThÇn C©u Phï (CÇn cÊp: 1, " .. zt_name[1] .. ")/v0",
        "Giµy T©n Thñ (Lam) +Di Ngo¹i Phï (CÇn cÊp: 4, " .. zt_name[2] .. ")/v1",
        "Siªu cÊp Håi Thµnh Phï-nhá (CÇn cÊp: 8, " .. zt_name[3] .. ")/v2",
        "Thó c­ìi xanh cÊp 15 (CÇn cÊp: 12, " .. zt_name[4] .. ")/v3",
        "Di Ngo¹i Phï+PhiÕu ­u ®·i ThÎ Kim DËt (CÇn cÊp: 16, " .. zt_name[5] .. ")/v4",
        "1 trang bÞ lôc cÊp 20+§¹i LÔ Bao NhËp Quèc (CÇn cÊp: 20, " .. zt_name[6] .. ")/v5",
        "Bµo th­¬ng håi thµnh (CÇn cÊp: 24, " .. zt_name[7] .. ")/v6",
        "Vò khÝ Hoµng Kim cÊp 30 (CÇn cÊp: 28, " .. zt_name[8] .. ")/v7",
        "B¹ch Kh«ng Th­+Thiªn Tiªn Thuû (CÇn cÊp: 32, " .. zt_name[9] .. ")/v8",
        "Trang ®Çu/main",
    }
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function page2()
    local zt_name = {}
    for i = 10, 18 do
        if (GetTaskBit(changvariable, i) == 0) then
            zt_name[i - 9] = "<c=g>ch­a nhËn<c>"
        else
            zt_name[i - 9] = "<c=r> ®· nhËn <c>"
        end
    end
    local opra = {
        "Phï nhiÖm vô Chñ ®Ò ngµy+Trang bÞ lôc cÊp 40 (CÇn cÊp: 36, " .. zt_name[1] .. ")/v9",
        "Vò khÝ Hoµng Kim cÊp 40 (CÇn cÊp: 40, " .. zt_name[2] .. ")/v10",
        "4 Tói TruyÒn Tèng (nhá)+PhiÕu ­u ®·i M¶nh s¸ch Ch­ HÇu (CÇn cÊp: 42, " .. zt_name[3] .. ")/v11",
        "B¶o H÷u Thanh Lé (Nh­ ý)+Tö Kim Hå L« (CÇn cÊp: 44, " .. zt_name[4] .. ")/v12",
        "Thó c­ìi lam cÊp 45 (CÇn cÊp: 46, " .. zt_name[5] .. ")/v13",
        "1 M¶nh V¶i +2 ThÇn T­íng Dô LÖnh (CÇn cÊp: 48, " .. zt_name[6] .. ")/v14",
        "M¶nh S¸ch Ch­ HÇu (CÇn cÊp: 50, " .. zt_name[7] .. ")/v15",
        "Tiªu Dao ThÇn Tiªn T¸n (Nh­ ý)+Lß LuyÖn §¬n (CÇn cÊp: 52, " .. zt_name[8] .. ")/v16",
        "Tói Ph¸p B¶o Cao CÊp+Tói Danh Ngäc (CÇn cÊp: 54, " .. zt_name[9] .. ")/v17",
        "Trang ®Çu/main"
    }

    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function page3()
    local zt_name = {}
    for i = 19, 28 do
        if (GetTaskBit(changvariable, i) == 0) then
            zt_name[i - 18] = "<c=g>ch­a nhËn<c>"
        else
            zt_name[i - 18] = "<c=r> ®· nhËn <c>"
        end
    end
    local opra = {
        "Trang bi lôc cÊp 60(CÇn cÊp: 56, " .. zt_name[1] .. ")/v18",
        "Khao Qu©n LÖnh+7 ngµy ®Æc quyÒn B¹ch Hæ (CÇn cÊp: 58, " .. zt_name[2] .. ")/v19",
        "Vò khÝ Hoµng Kim cÊp 60 (CÇn cÊp: 60, " .. zt_name[3] .. ")/v20",
        "S¸ch kü n¨ng (CÇn cÊp: 64, " .. zt_name[4] .. ")/v21",
        "Thiªn H­¬ng Tôc MÖnh (Nh­ ý)+Ch×a Kho¸ Linh Tª (CÇn cÊp: 68, " .. zt_name[5] .. ")/v22",
        "Lam B¶o Th¹ch+Tói ThÇn T­íng Dô LÖnh (CÇn cÊp: 72, " .. zt_name[6] .. ")/v23",
        "LÔ bao ChÝ T«n (CÇn cÊp: 76, " .. zt_name[7] .. ")/v24",
        "ThÎ Kim DËt 3 tÊm + ThiÖp Nh­ ý (CÇn cÊp: 80, " .. zt_name[8] .. ") /v25",
        "Trang bÞ lôc cÊp 80+ N÷ Oa Th¹ch(CÇn cÊp: 85, " .. zt_name[9] .. ") /v26",
        "1 Danh ngäc, (CÇn cÊp: 90, " .. zt_name[10] .. ") /v27",
        "Trang ®Çu/main",
    }
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function page4()

    local zt_name = {}
    for i = 1, 9 do
        if (GetTaskBit(packagevarable, i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else
            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    local opra = {
        "Trang bÞ lôc cÊp 100 (cã thêi h¹n) (CÇn cÊp: 95, " .. zt_name[1] .. ") /v28",
        "ThÎ Kim DËt 6 tÊm»òThiÖp Nh­ ý (CÇn cÊp: 100, " .. zt_name[2] .. ") /v29",
        "TrÇm §iÖn (CÇn cÊp: 103,  " .. zt_name[3] .. ") /v30",
        "Tö B¶o Th¹ch (CÇn cÊp: 106,  " .. zt_name[4] .. ") /v31",
        "Hoµng Ngäc ®Æc biÖt (CÇn cÊp: 109,  " .. zt_name[5] .. ") /v32",
        "Tói quµ Hån Chó trung-cÊp 1 (CÇn cÊp: 112,  " .. zt_name[6] .. ") /v33",
        "Phôc Hæ Ngäc Béi bËc 2 (CÇn cÊp: 115,  " .. zt_name[7] .. ") /v34",
        "LÔ bao Thñ CÊp Hung Thó (CÇn cÊp: 118,  " .. zt_name[8] .. ") /v35",
        "Tói quµ §å phæ Ph¸ Qu©n (CÇn cÊp: 120,  " .. zt_name[9] .. ") /v36",
        "Trang ®Çu/main",
    }
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function page5()

    local zt_name = {}

    for i = 10, 12 do
        if (GetTaskBit(packagevarable, i) == 0) then
            zt_name[i - 9] = "<c=g>ch­a nhËn<c>"
        else
            zt_name[i - 9] = "<c=r> ®· nhËn <c>"
        end
    end

    local opra = {
        "¸ß¼¶LÔ bao Hån Chó¡¤ cÊp 2 (CÇn cÊp: 130, " .. zt_name[1] .. ")/v37",
        "Vi Quang Qu¸i Phï (CÇn cÊp: 140, " .. zt_name[2] .. ")/v38",
        "TruyÒn Thõa Th¹ch (CÇn cÊp: 150, " .. zt_name[3] .. ")/v39",
        "Trang ®Çu/main",
    }
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", table.getn(opra), opra)
end

function v0()
    no()
    if (GetTaskBit(changvariable, 1) == 0) then
        if (GetLevel() >= 1) then
            SetTaskBit(changvariable, 1, 1)
            for i = 1, 3 do
                AddNormalItemBind(1, 29, 0, 1, 0, 0, 1)
            end
            for i = 1, 3 do
                AddNormalItemBind(1, 30, 0, 1, 0, 0, 1)
            end
            AddNormalItemBind(8, 133, 0, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc 3 TiÓu Hång §an, 3 TiÓu Hoµn §an vµ 1 ThÇn C©u Phï!")
            Talk(1, "jieshu", "Ngµi nhËn ®­îc 3 <c=g>TiÓu Hång §an<c>, 3 <c=g>TiÓu Hoµn §an<c> vµ 1 <c=g>ThÇn C©u Phï<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=water>D­îc phÈm t©n thñ + ThÇn C©u Phï<c>!")
    end

end

function v1()
    if (GetTaskBit(changvariable, 1) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 2) == 0) then
        if (GetLevel() >= 4) then
            SetTaskBit(changvariable, 2, 1)
            AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)

            if (GetPlayerType() == 0) then
                AddBlueEquip(0, 5, 0, 1, 0, 0, 1)
                Msg2Player("Ngµi nhËn ®­îc HuyÒn Vò ChiÕn Ngoa vµ 1 Di Ngo¹i Phï!")
                Talk(1, "jieshu", "Ngµi nhËn ®­îc <c=water>HuyÒn Vò ChiÕn Ngoa<c>, 1 <c=g>Di Ngo¹i Phï<c>!")
            elseif (GetPlayerType() == 1) then
                AddBlueEquip(0, 5, 1, 1, 0, 0, 1)
                Msg2Player("Ngµi nhËn ®­îc Thiªn QuyÒn Lý vµ 1 Di Ngo¹i Phï!")
                Talk(1, "jieshu", "Ngµi nhËn ®­îc <c=water>Thiªn QuyÒn Lý<c>, 1 <c=g>Di Ngo¹i Phï<c>!")
            else
                AddBlueEquip(0, 5, 2, 1, 0, 0, 1)
                Msg2Player("Ngµi nhËn ®­îc Lang Nha Ngoa vµ 1 Di Ngo¹i Phï!")
                Talk(1, "main", "Ngµi nhËn ®­îc <c=water>Lang Nha Ngoa<c>, 1 <c=g>Di Ngo¹i Phï<c>!")
            end
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=water>Giµy T©n Thñ+Di Ngo¹i Phï<c>!")
    end

end
function v2()
    if (GetTaskBit(changvariable, 2) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 3) == 0) then
        if (GetLevel() >= 8) then
            SetTaskBit(changvariable, 3, 1)
            AddNormalItemBind(8, 733, 2, 0, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá!")
            Talk(1, "main", "B¹n nhËn ®­îc 1 <c=g>Siªu cÊp Håi Thµnh Phï-nhá<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "B¹n ®· nhËn <c=g>Siªu cÊp Håi Thµnh Phï-nhá<c> råi!")
    end

end
function v3()
    if (GetTaskBit(changvariable, 3) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 4) == 0) then
        if (GetLevel() >= 12) then
            SetTaskBit(changvariable, 4, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem2(0, 10, 0, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 Thanh T«ng M·!")
                Talk(1, "main", 13455)
            elseif (GetPlayerType() == 1) then
                AddNormalItem2(0, 10, 1, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 BÝch Ngäc T­íc!")
                Talk(1, "main", 13456)
            else
                AddNormalItem2(0, 10, 2, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 Lôc Ngäc hå ®iÖp!")
                Talk(1, "main", 13457)
            end


        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13458)
    end

end
function v4()
    if (GetTaskBit(changvariable, 4) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 5) == 0) then
        if (GetLevel() >= 16) then
            SetTaskBit(changvariable, 5, 1)
            AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
            AddNormalItemBind(6, 1, 1137, 1, 0, 0, 1)

            Msg2Player("Ngµi nhËn ®­îc Di Ngo¹i Phï 1 c¸i! PhiÕu ­u ®·i ThÎ Kim DËt 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc Di Ngo¹i Phï 1 c¸i! PhiÕu ­u ®·i ThÎ Kim DËt 1 c¸i!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Di Ngo¹i Phï+PhiÕu ­u ®·i ThÎ Kim DËt<c>!")
    end

end
function v5()
    if (GetTaskBit(changvariable, 5) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 6) == 0) then
        if (GetLevel() >= 20) then
            SetTaskBit(changvariable, 6, 1)
            AddNormalItemBind(6, 1, 1095, 1, 0, 0, 1)
            local i = math.random(1, 2)
            local j = 0
            if (i == 1) then
                j = 9
            else
                j = 2
            end

            if (GetPlayerType() == 0) then
                AddNormalItem(0, j, 9, 2, 0, 0)
                Msg2Player("Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")
                Talk(1, "main", "Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 2, 0, 0)
                Msg2Player("Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")
                Talk(1, "main", "Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")
            else
                AddNormalItem(0, j, 11, 2, 0, 0)
                Msg2Player("Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")
                Talk(1, "main", "Anh hïng ®· nhËn 1 trang bÞ lôc cÊp 20, vµ nhËn thªm 1 §¹i LÔ Bao NhËp Quèc!")
            end

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>trang bÞ lôc cÊp 20<c> vµ <c=g>§¹i LÔ Bao NhËp Quèc<c>!")
    end

end

function v6()
    if (GetTaskBit(changvariable, 6) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 7) == 0) then
        if (GetLevel() >= 24) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(121)
            local tasks = {
                { "§æi ", "v6_coin"; show = 1 },
                { "NhËn", "v6_yes"; show = 1 }
            }

            SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï<Enter>Chän NhËn-nhËn ®­îc 1 tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï", tasks)
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "B¹n ®· nhËn <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c> råi!")
    end
end

function v6_yes()
    if (GetTaskBit(changvariable, 7) == 0) then
        SetTaskBit(changvariable, 7, 1)
        AddIBBuff(738)

        Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï!")
        Talk(1, "main", "B¹n nhËn ®­îc 1 <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c>!")
    else
        Talk(1, "main", "B¹n ®· nhËn <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c> råi!")
    end
end

function v6_coin()
    no()
    if (GetTaskBit(changvariable, 7) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(121)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 7, 1)
            CostCoinByIdx(121)
            AddNormalItemBind(8, 258, 2, 0, 0, 0, 1)
            ScrollMessage("§æi mua Bµo th­¬ng Håi Thµnh Phï 1 c¸i")
            Msg2Player("Ngµi thªm " .. Cfs .. " Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï")
            Talk(1, "main", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï")
        else
            Talk(1, "main", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "main", "B¹n ®· nhËn 1 lo¹t <c=g>Bµo th­¬ng Håi Thµnh Phï<c>!")
    end
end

function v7()
    if (GetTaskBit(changvariable, 7) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 8) == 0) then
        if (GetLevel() >= 28) then
            SetTaskBit(changvariable, 8, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 3, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 3, 1, 0)
            else
                AddNormalItem(0, 0, 30, 3, 1, 0)
            end ;

            Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 30!")
            Talk(1, "main", 13480)

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13481)
    end

end
function v8()
    if (GetTaskBit(changvariable, 8) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 9) == 0) then
        if (GetLevel() >= 32) then
            SetTaskBit(changvariable, 9, 1)
            AddNormalItemBind(8, 139, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 206, 5, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc B¹ch Kh«ng Th­ 1 c¸i! Thiªn Tiªn Thuû 1 c¸i")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>B¹ch Kh«ng Th­<c> 1 c¸i, <c=g>Thiªn Tiªn Thuû<c> 1 c¸i!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>B¹ch Kh«ng Th­<c>!, <c=g>Thiªn Tiªn Thuû<c> 1 c¸i!")
    end

end
function v9()
    if (GetTaskBit(changvariable, 9) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 10) == 0) then
        if (GetLevel() >= 36) then
            SetTaskBit(changvariable, 10, 1)
            AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
            local nType = GetPlayerType() + 1
            if (nType == 1) then
                AddNormalItem(0, 7, 9, 3, 0, 0)
            elseif (nType == 2) then
                AddNormalItem(0, 7, 10, 3, 0, 0)
            else
                AddNormalItem(0, 7, 11, 3, 0, 0)
            end
            Msg2Player("Ngµi nhËn ®­îc Phï nhiÖm vô Chñ ®Ò ngµy 1 c¸i vµ Trang bÞ lôc cÊp 40!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Phï nhiÖm vô Chñ ®Ò ngµy<c> 1 c¸i vµ <c=g>Trang bÞ lôc cÊp 40<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Phï nhiÖm vô Chñ ®Ò ngµy<c> cïng <c=g>Trang bÞ lôc cÊp 40<c>!")
    end

end

function v10()
    if (GetTaskBit(changvariable, 10) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 11) == 0) then
        if (GetLevel() >= 40) then
            SetTaskBit(changvariable, 11, 1)
            AddNormalItem(6, 1, 1045, 1, 0, 0)
            Msg2Player("Anh hïng ®· nhËn Tói quµ Vò khÝ Hoµng Kim cÊp 40 x1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ Vò khÝ Hoµng Kim cÊp 40<c> x1!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ Vò khÝ Hoµng Kim cÊp 40<c>!")
    end

end
function v11()
    if (GetTaskBit(changvariable, 11) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 12) == 0) then
        if (GetLevel() >= 42) then
            SetTaskBit(changvariable, 12, 1)
            AddNormalItemBind(8, 1514, 2, 0, 0, 0, 1)
            AddNormalItemBind(6, 1, 1193, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Tói quµ TruyÒn tèng Tø TiÓu 1 c¸i vµ PhiÕu ­u ®·i M¶nh s¸ch Ch­ HÇu!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Tói quµ TruyÒn tèng Tø TiÓu<c> vµ <c=g>PhiÕu ­u ®·i M¶nh s¸ch Ch­ HÇu<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Tói quµ TruyÒn tèng Tø TiÓu<c> cïng <c=g>PhiÕu ­u ®·i M¶nh s¸ch Ch­ HÇu<c>!")
    end
end
function v12()
    if (GetTaskBit(changvariable, 12) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 13) == 0) then
        if (GetLevel() >= 44) then

            local _, Cv, Cfs = GetCostCoinInfoByIdx(122)
            local tasks = {
                { "§æi ", "v12_coin"; show = 1 },
                { "NhËn", "v12_yes"; show = 1 }
            }

            SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi mua Siªu cÊp B¶o H÷u Thanh Lé (Nh­ ý) vµ ³¬¼¶ÈçÒâS¬n Thuû Ch©n KhÝ×éºÏ+Tö Kim Hå L«<Enter>Chän nhËn: NhËn ®­îc B¶o H÷u Thanh Lé (Nh­ ý) 1 c¸i +Tö Kim Hå L«", tasks)
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>B¶o H÷u Thanh Lé (Nh­ ý)+Tö Kim Hå L«<c>!")
    end
end

function v12_yes()
    if (GetTaskBit(changvariable, 13) == 0) then
        SetTaskBit(changvariable, 13, 1)
        AddNormalItem(8, 383, 3, 0, 0, 0)
        AddNormalItemBind(8, 257, 2, 0, 0, 0, 1)
        Msg2Player("Ngµi nhËn ®­îc B¶o H÷u Thanh Lé (Nh­ ý), 1 Tö Kim Hå L« 1 c¸i!")
        Talk(1, "main", "Ngµi nhËn ®­îc <c=g>B¶o H÷u Thanh Lé (Nh­ ý)<c>, 1 <c=g>Tö Kim Hå L«<c>!")
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>B¶o H÷u Thanh Lé (Nh­ ý)+Tö Kim Hå L«<c>!")
    end
end

function v12_coin()
    no()
    if (GetTaskBit(changvariable, 13) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(122)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 13, 1)
            CostCoinByIdx(122)
            AddNormalItem(8, 735, 3, 0, 0, 0)
            AddNormalItem(8, 736, 4, 0, 0, 0)
            AddNormalItemBind(8, 257, 2, 0, 0, 0, 1)
            ScrollMessage("§· ®æi mua Siªu cÊp B¶o H÷u Thanh Lé (Nh­ ý) vµ ³¬¼¶ÈçÒâS¬n Thuû Ch©n KhÝ×éºÏ")
            Msg2Player("Ngµi thªm " .. Cfs .. " Th«ng B¶o ®æi mua Siªu cÊp B¶o H÷u Thanh Lé (Nh­ ý) vµ ³¬¼¶ÈçÒâS¬n Thuû Ch©n KhÝ×éºÏ, cßn nhËn ®­îc Tö Kim Hå L« 1 c¸i!")
            Talk(1, "main", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi mua Siªu cÊp B¶o H÷u Thanh Lé (Nh­ ý) vµ ³¬¼¶ÈçÒâS¬n Thuû Ch©n KhÝ×éºÏ!")
        else
            Talk(1, "main", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>B¶o H÷u Thanh Lé (Nh­ ý)+Tö Kim Hå L«<c>!")
    end
end
function v13()
    if (GetTaskBit(changvariable, 13) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 14) == 0) then
        if (GetLevel() >= 46) then
            SetTaskBit(changvariable, 14, 1)
            local nCreerType = GetPlayerType()
            if (nCreerType == 0) then
                AddNormalItem2(0, 10, 0, 8, 1, 0)
            elseif (nCreerType == 1) then
                AddNormalItem2(0, 10, 1, 8, 1, 0)
            else
                AddNormalItem2(0, 10, 2, 8, 1, 0)
            end ;

            Msg2Player("Anh hïng ®· nhËn thó c­ìi lam cÊp 45 x1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>thó c­ìi lam cÊp 45<c> x1!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>thó c­ìi lam cÊp 45<c>!")
    end
end

function v14()
    if (GetTaskBit(changvariable, 14) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 15) == 0) then
        if (GetLevel() >= 48) then
            SetTaskBit(changvariable, 15, 1)
            AddNormalItemBind(8, 269, 2, 0, 0, 0, 1)
            AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
            AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc M¶nh V¶i 1 c¸i, 2 ThÇn T­íng Dô LÖnh!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>M¶nh V¶i<c>1 c¸i, <c=g>ThÇn T­íng Dô LÖnh<c> 2 c¸i!")

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>M¶nh V¶i<c>1 c¸i, <c=g>ThÇn T­íng Dô LÖnh<c> 2 c¸i!")
    end

end

function v15()
    if (GetTaskBit(changvariable, 15) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 16) == 0) then
        if (GetLevel() >= 50) then
            SetTaskBit(changvariable, 16, 1)
            AddNormalItemBind(8, 193, 5, 0, 0, 0, 1)
            Msg2Player("Anh hïng nhËn m¶nh S¸ch Ch­ HÇu!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>M¶nh S¸ch Ch­ HÇu<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>M¶nh S¸ch Ch­ HÇu<c>!")
    end

end

function v16()
    if (GetTaskBit(changvariable, 16) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 17) == 0) then
        if (GetLevel() >= 52) then
            SetTaskBit(changvariable, 17, 1)
            AddNormalItem(8, 395, 2, 0, 0, 0)
            AddNormalItemBind(8, 207, 5, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Tiªu Dao ThÇn Tiªn T¸n (Nh­ ý) 1 c¸i, Lß LuyÖn §¬n 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Tiªu Dao ThÇn Tiªn T¸n (Nh­ ý)<c> 1 c¸i, <c=g>Lß LuyÖn §¬n<c> 1 c¸i!")

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Tiªu Dao ThÇn Tiªn T¸n (Nh­ ý)+Lß LuyÖn §¬n<c>!")
    end

end
function v17()
    if (GetTaskBit(changvariable, 17) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 18) == 0) then
        if (GetLevel() >= 54) then
            SetTaskBit(changvariable, 18, 1)
            AddNormalItemBind(8, 449, 2, 0, 0, 0, 1)
            AddNormalItemBind(8, 1669, 2, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Tói Ph¸p B¶o Cao CÊp 1 c¸i, Tói Danh Ngäc 1 c¸i")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Tói Ph¸p B¶o Cao CÊp<c> 1 c¸i, <c=g>Tói Danh Ngäc<c> 1 c¸i")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Tói Ph¸p B¶o Cao CÊp+Tói Danh Ngäc<c>!")
    end

end

function v18()
    if (GetTaskBit(changvariable, 18) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 19) == 0) then
        if (GetLevel() >= 56) then
            SetTaskBit(changvariable, 19, 1)
            local i = math.random(1, 5)
            local j = 0
            if (i == 1) then
                j = 7
            elseif (i == 2) then
                j = 6
            elseif (i == 3) then
                j = 5
            elseif (i == 4) then
                j = 9
            else
                j = 2
            end

            if (GetPlayerType() == 0) then

                AddNormalItem(0, j, 9, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 60!")
                Talk(1, "main", 13496)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 60!")
                Talk(1, "main", 13496)
            else
                AddNormalItem(0, j, 11, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 60!")
                Talk(1, "main", 13496)
            end

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13497)
    end

end

function v19()
    if (GetTaskBit(changvariable, 19) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 20) == 0) then
        if (GetLevel() >= 58) then
            SetTaskBit(changvariable, 20, 1)
            AddNormalItemBind(8, 268, 2, 0, 0, 0, 1)
            AddNormalItemBind(6, 1, 1105, 1, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Khao Qu©n LÖnh 1 c¸i, ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ 1 c¸i")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Khao Qu©n LÖnh<c> 1 c¸i, <c=g>ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ<c> 1 c¸i!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Khao Qu©n LÖnh+ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ<c>!")
    end

end

function v20()
    if (GetTaskBit(changvariable, 20) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 21) == 0) then
        if (GetLevel() >= 60) then
            SetTaskBit(changvariable, 21, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 6, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 6, 1, 0)
            else
                AddNormalItem(0, 0, 30, 6, 1, 0)
            end ;
            Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 60!")
            Talk(1, "main", 13498)

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13499)
    end

end
function v21()
    if (GetTaskBit(changvariable, 21) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 22) == 0) then
        if (GetLevel() >= 64) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(123)
            local tasks = {
                { "§æi ", "v21_coin"; show = 1 },
                { "NhËn", "v21_yes"; show = 1 }
            }

            SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 s¸ch kü n¨ng vµ 1 Th¸i Cùc §¬n<Enter>Chän NhËn-nhËn ®­îc 1 s¸ch kü n¨ng (Liªn Hoµn, Thiªn B¨ng, L­u Tinh tïy theo tõng hÖ ph¸i)", tasks)
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v21_yes()
    if (GetTaskBit(changvariable, 22) == 0) then
        SetTaskBit(changvariable, 22, 1)
        if (GetPlayerType() == 0) then
            AddNormalItemBind(7, 35, 38, 1, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng Gi¸p SÜ: Liªn Hoµn Tr¶m!")
        elseif (GetPlayerType() == 1) then
            AddNormalItemBind(7, 17, 20, 1, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng §¹o SÜ: Thiªn B¨ng §Þa LiÖt!")
        else
            AddNormalItemBind(7, 55, 456, 1, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng DÞ Nh©n: L­u Tinh TÕ!")
        end ;

        Talk(1, "main", "B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng <c> !")
    else
        Talk(1, "main", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v21_coin()
    no()
    if (GetTaskBit(changvariable, 22) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(123)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 22, 1)
            CostCoinByIdx(123)
            ScrollMessage("§æi mua ¼¼ÄÜÊéÒ»±¾+B¸t c¶nh Th¸i Cùc §¬n 1 c¸i")
            AddNormalItemBind(8, 165, 2, 0, 0, 0, 1)
            if (GetPlayerType() == 0) then
                AddNormalItemBind(7, 35, 38, 1, 0, 0, 1)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng Gi¸p SÜ: Liªn Hoµn Tr¶m vµ 1 Th¸i Cùc §¬n!")
            elseif (GetPlayerType() == 1) then
                AddNormalItemBind(7, 17, 20, 1, 0, 0, 1)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng §¹o SÜ: Thiªn B¨ng §Þa LiÖt vµ 1 Th¸i Cùc §¬n!")
            else
                AddNormalItemBind(7, 55, 456, 1, 0, 0, 1)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng DÞ Nh©n: L­u Tinh TÕ vµ 1 Th¸i Cùc §¬n!")
            end ;

            Talk(1, "main", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 S¸ch kü n¨ng vµ 1 Th¸i Cùc §¬n")
        else
            Talk(1, "main", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "main", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v22()
    if (GetTaskBit(changvariable, 22) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 23) == 0) then
        if (GetLevel() >= 68) then
            SetTaskBit(changvariable, 23, 1)
            AddNormalItem(8, 398, 2, 0, 0, 0)
            AddNormalItemBind(8, 329, 2, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Thiªn H­¬ng Tôc MÖnh (Nh­ ý) 1 c¸i, Ch×a Kho¸ Linh Tª 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Thiªn H­¬ng Tôc MÖnh (Nh­ ý)<c> 1 c¸i, <c=g>Ch×a Kho¸ Linh Tª<c> 1 c¸i!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Thiªn H­¬ng Tôc MÖnh (Nh­ ý)+Ch×a Kho¸ Linh Tª<c>!")
    end

end
function v23()
    if (GetTaskBit(changvariable, 23) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 24) == 0) then
        if (GetLevel() >= 72) then
            SetTaskBit(changvariable, 24, 1)
            AddNormalItem(3, 41, 0, 0, 0, 0)
            AddNormalItemBind(8, 1947, 2, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Lam B¶o Th¹ch 1 c¸i, Tói ThÇn T­íng Dô LÖnh!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Lam B¶o Th¹ch<c> 1 c¸i, <c=g>ThÇn T­íng Dô LÖnh<c> 1 tói!")

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Lam B¶o Th¹ch+ThÇn T­íng Dô LÖnh 1 tói<c>!")
    end

end
function v24()
    if (GetTaskBit(changvariable, 24) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 25) == 0) then
        if (GetLevel() >= 76) then
            SetTaskBit(changvariable, 25, 1)
            AddNormalItemBind(8, 289, 2, 0, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1 LÔ bao ChÝ T«n!")
            Talk(1, "main", 13506)

        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13507)
    end

end

function v25()
    if (GetTaskBit(changvariable, 25) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetLevel() < 80) then
        Talk(1, "main", 13451)
        return
    end
    if (GetTaskBit(changvariable, 26) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
        local tasks = {
            { "§æi ", "v25_coin"; show = 1 },
            { "NhËn", "v25_yes"; show = 1 }
        }

        SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi mua Áé±¦<Enter>Chän nhËn: NhËn ®­îc ThiÖp Nh­ ý»òÕßThÎ Kim DËt 3 tÊm\n<c=g> Linh B¶o<c>Îª°ó¶¨»õ±Ò, ¿ÉÔÚ°Ë±¦¸óÖÐ¹ºÂòÎïÆ·, ÓëÍ¨±¦µÈÖµ.Ñ¡Ôñ ®æi mua ¿ÉÄÜµÃµ½50»òÕß500 Linh B¶o", tasks)
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>ThÎ Kim DËt 3 c¸i »òThiÖp Nh­ ý<c>!")
    end
end

function v25_yes()
    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 4 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (GetTaskBit(changvariable, 26) == 0) then
        if (GetLevel() >= 80) then
            SetTaskBit(changvariable, 26, 1)
            local j = math.random(1, 1000)
            if (j <= 5) then
                AddItemPileNum(3, 138, 0, 1, 500)
                SetTaskBit(changvariable, 29, 1)
                SetTaskBit(changvariable, 30, 1)
                Msg2Player("B¹n nhËn ®­îc 500 ThiÖp Nh­ ý!")
                WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 80]ThiÖp Nh­ ý500:" .. j)
                Talk(1, "main", 13509)
            elseif (j >= 901) then
                AddItemPileNum(3, 138, 0, 1, 50)
                SetTaskBit(changvariable, 30, 1)
                Msg2Player("B¹n nhËn ®­îc 50 ThiÖp Nh­ ý!")
                WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 80]ThiÖp Nh­ ý50:" .. j)
                Talk(1, "main", 13511)
            else
                for i = 1, 3 do
                    AddNormalItemBind(8, 1316, 6, 0, 0, 0, 1)
                end
                Msg2Player("Ngµi nhËn ®­îc ThÎ Kim DËt 3 tÊm!")
                Talk(1, "main", "Ngµi nhËn ®­îc <c=g>ThÎ Kim DËt<c> 3 tÊm!")
            end
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>ThÎ Kim DËt 3 c¸i »òThiÖp Nh­ ý<c>!")
    end
end

function v25_coin()
    no()
    if (GetTaskBit(changvariable, 26) == 0) then
        if (GetLevel() >= 80) then

            local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
            if (GetCoin() < Cv) then
                Talk(1, "main", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
                return
            end

            CostCoinByIdx(124)
            SetTaskBit(changvariable, 26, 1)
            local j = math.random(1, 100)
            if (j <= 1) then
                AddBindCoin(50000)
                Msg2Player("B¹n nhËn ®­îc 500 Linh B¶o!")
                WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 80]Áé±¦500:" .. j)
                Talk(1, "main", "B¹n nhËn ®­îc <c=g>500 Linh B¶o<c>!")
                ScrollMessage("§· ®æi mua <c=g>500 Linh B¶o<c>")
            else
                AddBindCoin(5000)
                Msg2Player("B¹n nhËn ®­îc 50 Linh B¶o!")
                WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 80]Áé±¦50")
                Talk(1, "main", "B¹n nhËn ®­îc <c=g>50 Linh B¶o<c>!")
                ScrollMessage("§· ®æi mua <c=g>50 Linh B¶o<c>")
            end
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", 13512)
    end
end

function v26()
    if (GetTaskBit(changvariable, 26) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 27) == 0) then
        if (GetLevel() >= 85) then
            SetTaskBit(changvariable, 27, 1)
            AddNormalItemBind(8, 380, 2, 0, 0, 0, 1)
            local i = math.random(1, 2)
            local j = 2
            if (i == 1) then
                j = 9
            end

            if (GetPlayerType() == 0) then
                AddNormalItem(0, j, 9, 8, 0, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 8, 0, 0)
            else
                AddNormalItem(0, j, 11, 8, 0, 0)
            end
            Msg2Player("Ngµi nhËn ®­îc Trang bÞ lôc cÊp 80, N÷ Oa Th¹ch 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Trang bÞ lôc cÊp 80<c>, <c=g>N÷ Oa Th¹ch<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Trang bÞ lôc cÊp 80+N÷ Oa Th¹ch<c>!")
    end
end

function v27()
    if (GetTaskBit(changvariable, 27) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 28) == 0) then
        if (GetLevel() >= 90) then
            SetTaskBit(changvariable, 28, 1)
            local r = math.random(0, 2)
            local yu_name = { "XÝch Viªm Danh Ngäc", "Thanh Minh Danh Ngäc", "Tö Hµ Danh Ngäc" }
            AddNormalItem(3, (256 + r * 7), 0, 0, 0, 0)
            Msg2Player("B¹n nh©n ®­îc " .. yu_name[r + 1] .. " 1 viªn!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 90]" .. yu_name[r + 1])
            Talk(1, "main", "B¹n nhËn ®­îc 1 <c=g>Danh Ngäc<c>!")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "B¹n ®· l·nh qua <c=g>Danh Ngäc<c>!")
    end

end
function v28()
    if (GetTaskBit(changvariable, 28) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 1) == 0) then
        if (GetLevel() >= 95) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
            local tasks = {
                { "§æi ", "v28_coin"; show = 1 },
                { "NhËn", "v28_yes"; show = 1 }
            }

            SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi mua Trang bÞ lôc cÊp 100 (thêi h¹n 30 ngµy)Chän nhËn: NhËn ®­îc Trang bÞ lôc cÊp 100 (thêi h¹n 7 ngµy)", tasks)
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>trang bÞ lôc cÊp 100<c> råi!")
    end
end

function v28_yes()
    if (GetTaskBit(packagevarable, 1) == 0) then
        SetTaskBit(packagevarable, 1, 1)

        local i = math.random(1, 2)
        local j = 2
        if (i == 1) then
            j = 9
        end

        if (GetPlayerType() == 0) then
            AddNormalItem4(0, j, 9, 9, 0, 0, 0, 7, 0)
        elseif (GetPlayerType() == 1) then
            AddNormalItem4(0, j, 10, 9, 0, 0, 0, 7, 0)
        else
            AddNormalItem4(0, j, 11, 9, 0, 0, 0, 7, 0)
        end

        Msg2Player("Ngµi nhËn ®­îc 7 ngµy hiÖu lùc Trang bÞ lôc cÊp 100!")
        Talk(1, "no", "Ngµi nhËn ®­îc 7 ngµy hiÖu lùc <c=g>Trang bÞ lôc cÊp 100<c>!")
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>trang bÞ lôc cÊp 100<c> råi!")
    end
end

function v28_coin()
    if (GetTaskBit(packagevarable, 1) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
        if (GetCoin() < Cv) then
            Talk(1, "no", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
            return
        end

        CostCoinByIdx(124)
        SetTaskBit(packagevarable, 1, 1)

        local i = math.random(1, 2)
        local j = 2
        if (i == 1) then
            j = 9
        end

        if (GetPlayerType() == 0) then
            AddNormalItem4(0, j, 9, 9, 0, 0, 0, 30, 0)
        elseif (GetPlayerType() == 1) then
            AddNormalItem4(0, j, 10, 9, 0, 0, 0, 30, 0)
        else
            AddNormalItem4(0, j, 11, 9, 0, 0, 0, 30, 0)
        end

        Msg2Player("Ngµi nhËn ®­îc 30 ngµy hiÖu lùc Trang bÞ lôc cÊp 100!")
        Talk(1, "no", "Ngµi nhËn ®­îc 30 ngµy hiÖu lùc <c=g>Trang bÞ lôc cÊp 100<c>!")
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>trang bÞ lôc cÊp 100<c> råi!")
    end
end

function v29()
    if (GetTaskBit(packagevarable, 1) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    CloseDialog()
    if (GetTaskBit(packagevarable, 2) == 0) then
        if (GetLevel() >= 100) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(141)
            local tasks = {
                { "§æi ", "v29_coin"; show = 1 },
                { "NhËn", "v29_yes"; show = 1 }
            }

            SayTask("Chän ®æi-thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi mua Áé±¦<Enter>Chän nhËn: NhËn ®­îc ThiÖp Nh­ ý»òThÎ Kim DËt 6 c¸i \n<c=g> Linh B¶o<c>Îª°ó¶¨»õ±Ò, ¿ÉÔÚ°Ë±¦¸óÖÐ¹ºÂòÎïÆ·, ÓëÍ¨±¦µÈÖµ.Ñ¡Ôñ ®æi mua ¿ÉÄÜµÃµ½50»òÕß500 Linh B¶o", tasks)
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>ThÎ Kim DËt 6 tÊm»òThiÖp Nh­ ý<c>!")
    end

end

function v29_yes()
    CloseDialog()
    if (IsHaveSpaceForTreasure(7) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 6 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (GetTaskBit(packagevarable, 2) == 0) then
        SetTaskBit(packagevarable, 2, 1)
        local j = math.random(1, 100)
        if (j <= 1) and (GetTaskBit(changvariable, 30) == 0) then
            AddItemPileNum(3, 138, 0, 1, 500)
            SetTaskBit(changvariable, 29, 1)
            SetTaskBit(changvariable, 30, 1)
            Msg2Player("B¹n nhËn ®­îc 500 ThiÖp Nh­ ý!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 100]ThiÖp Nh­ ý500: " .. j)
            Talk(1, "main", 13509)
        elseif (j <= 11) and (GetTaskBit(changvariable, 29) == 0) then
            AddItemPileNum(3, 138, 0, 1, 100)
            SetTaskBit(changvariable, 30, 1)
            Msg2Player("B¹n nhËn ®­îc 100 ThiÖp Nh­ ý!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 100]ThiÖp Nh­ ý100: " .. j)
            Talk(1, "main", 13510)
        else
            for i = 1, 6 do
                AddNormalItemBind(8, 1316, 6, 0, 0, 0, 1)
            end
            Msg2Player("Ngµi nhËn ®­îc ThÎ Kim DËt 6 tÊm!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>ThÎ Kim DËt<c> 6 tÊm!")
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>ThÎ Kim DËt 6 tÊm»òThiÖp Nh­ ý<c>!")
    end
end

function v29_coin()
    CloseDialog()
    if (GetTaskBit(packagevarable, 2) == 0) then

        local _, Cv, Cfs = GetCostCoinInfoByIdx(141)
        if (GetCoin() < Cv) then
            Talk(1, "main", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
            return
        end

        CostCoinByIdx(141)
        SetTaskBit(packagevarable, 2, 1)

        local j = math.random(1, 100)
        if (j <= 5) then
            AddBindCoin(50000)
            Msg2Player("B¹n nhËn ®­îc 500 Linh B¶o!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 100]Áé±¦500:" .. j)
            Talk(1, "main", "B¹n nhËn ®­îc <c=g>500 Linh B¶o<c>")
            ScrollMessage("§· ®æi mua <c=g>500 Linh B¶o<c>")
        else
            AddBindCoin(10000)
            Msg2Player("B¹n nhËn ®­îc 100 Linh B¶o!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][cÊp 100]Áé±¦100")
            Talk(1, "main", "B¹n nhËn ®­îc <c=g>100 Linh B¶o<c>")
            ScrollMessage("§· ®æi mua <c=g>100 Linh B¶o<c>")
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g> Linh B¶o<c>!")
    end
end

function v30()
    if (GetTaskBit(packagevarable, 2) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 3) == 0) then
        if (GetLevel() >= 103) then
            SetTaskBit(packagevarable, 3, 1)
            AddNormalItemBind(8, 191, 2, 0, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn 1 TrÇm §iÖn!")
            Talk(1, "main", "B¹n nhËn ®­îc <c=g>TrÇm §iÖn<c>!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][103][TrÇm §iÖn]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>TrÇm §iÖn<c>!")
    end
end

function v31()
    if (GetTaskBit(packagevarable, 3) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 4) == 0) then
        if (GetLevel() >= 106) then
            SetTaskBit(packagevarable, 4, 1)
            AddNormalItemBind(3, 1151, 0, 0, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn 1 Tö B¶o Th¹ch!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tö B¶o Th¹ch<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][106][Tö B¶o Th¹ch]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tö B¶o Th¹ch<c>!")
    end
end
function v32()
    if (GetTaskBit(packagevarable, 4) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 5) == 0) then
        if (GetLevel() >= 109) then
            SetTaskBit(packagevarable, 5, 1)
            AddNormalItemBind(8, 238, 2, 0, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn Hoµng Ngäc ®Æc biÖt x1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Hoµng Ngäc ®Æc biÖt<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][109][ÌØµÈ»ÆÓñ]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Hoµng Ngäc ®Æc biÖt<c>!")
    end
end
function v33()
    if (GetTaskBit(packagevarable, 5) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 6) == 0) then
        if (GetLevel() >= 112) then
            SetTaskBit(packagevarable, 6, 1)
            AddNormalItem(8, 1706, 2, 0, 0, 0)
            Msg2Player("Anh hïng ®· nhËn Tói quµ Hån Chó trung-cÊp 1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ Hån Chó trung-cÊp 1<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][112][ÖÐ¼¶LÔ bao Hån Chó]²»°ó¶¨")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ Hån Chó trung-cÊp 1<c>!")
    end
end
function v34()
    if (GetTaskBit(packagevarable, 6) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 7) == 0) then
        if (GetLevel() >= 115) then
            SetTaskBit(packagevarable, 7, 1)
            AddNormalItemBind(0, 12, 0, 5, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn Phôc Hæ Ngäc Béi bËc 2 x1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Phôc Hæ Ngäc Béi bËc 2<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][115][Ngäc béi Phôc Hæ phÈm 2]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Phôc Hæ Ngäc Béi bËc 2<c>!")
    end
end
function v35()
    if (GetTaskBit(packagevarable, 7) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 8) == 0) then
        if (GetLevel() >= 118) then
            SetTaskBit(packagevarable, 8, 1)
            AddNormalItemBind(6, 1, 1047, 1, 0, 0, 1)
            Msg2Player("Anh hïng ®· nhËn LÔ bao Thñ CÊp Hung Thó x1!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>LÔ bao Thñ CÊp Hung Thó<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][118][LÔ bao Thñ CÊp Hung Thó]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>LÔ bao Thñ CÊp Hung Thó<c>!")
    end
end
function v36()
    if (GetTaskBit(packagevarable, 8) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 9) == 0) then
        if (GetLevel() >= 120) then
            SetTaskBit(packagevarable, 9, 1)
            AddNormalItem(6, 1, 1046, 1, 0, 0)
            Msg2Player("Anh hïng nhËn 1 Tói quµ §å Phæ Ph¸ Qu©n!")
            Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ §å Phæ Ph¸ Qu©n<c> x1!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][120][LÔ bao §å phæ Ph¸ Qu©n]²»°ó¶¨")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Anh hïng ®· nhËn <c=g>Tói quµ §å Phæ Ph¸ Qu©n<c>!")
    end
end

function v37()
    if (GetTaskBit(packagevarable, 9) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 10) == 0) then
        if (GetLevel() >= 130) then
            SetTaskBit(packagevarable, 10, 1)
            AddNormalItem(8, 1705, 2, 0, 0, 0)
            Msg2Player("Ngµi nhËn ®­îc ¸ß¼¶LÔ bao Hån Chó¡¤ cÊp 2  1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>¸ß¼¶LÔ bao Hån Chó¡¤ cÊp 2<c>!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][130][¸ß¼¶LÔ bao Hån Chó¡¤ cÊp 2]²»°ó¶¨")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>¸ß¼¶LÔ bao Hån Chó¡¤ cÊp 2<c>!")
    end
end

function v38()
    if (GetTaskBit(packagevarable, 10) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 11) == 0) then
        if (GetLevel() >= 140) then
            SetTaskBit(packagevarable, 11, 1)
            AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc Vi Quang Qu¸i Phï (ch­a khai quang) 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>Vi Quang Qu¸i Phï (ch­a khai quang)<c>!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][140][Vi Quang Qu¸i Phï (ch­a khai quang)]")
        else
            Talk(1, "main", 13451)
        end
    else
        Talk(1, "main", "Ngµi ®· nhËn <c=g>Vi Quang Qu¸i Phï (ch­a khai quang)<c>!")
    end
end

function v39()
    if (GetTaskBit(packagevarable, 11) == 0) then
        Talk(1, "main", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(packagevarable, 12) == 0) then
        if (GetLevel() >= 150) then
            SetTaskBit(packagevarable, 12, 1)
            AddNormalItemBind(3, 1195, 0, 0, 0, 0, 1)
            Msg2Player("Ngµi nhËn ®­îc TruyÒn Thõa Th¹ch 1 c¸i!")
            Talk(1, "main", "Ngµi nhËn ®­îc <c=g>TruyÒn Thõa Th¹ch<c>!")
            WriteLog("[Anh Hïng Phong ThÇn-§¹i LÔ Bao][150][TruyÒn Thõa Th¹ch]")
            jieshu()
        else
            Talk(1, "jieshu", 13451)
        end
    else
        Talk(1, "jieshu", "Ngµi ®· nhËn <c=g>TruyÒn Thõa Th¹ch<c>!")
    end
end

function jieshu()
    CloseDialog()
    for i = 1, 28 do
        if (GetTaskBit(changvariable, i) == 0) then
            return 0
        end
    end
    for i = 1, 12 do
        if (GetTaskBit(packagevarable, i) == 0) then
            return 0
        end
    end
    if (DelNormalItem(6, 1, 1595, 0) == 0) then
        for i = 1, 10 do
            if (DelNormalItem(6, 1, 1595, i) == 1) then
                return 1
            end
        end
    end

    return 1
end

function no()
    CloseDialog()
end
