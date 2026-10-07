changvariable = 1492
function main()
    if (jieshu() == 1) then
        Talk(1, "no", "B¹n ®· nhËn tÊt c¶ phÇn th­ëng trong ®¹i lÔ bao!")
        return 0
    end

    tasks = {
        { "Më « trªn", "shang"; show = 1 },
        { "Më « tÇng gi÷a", "zhong"; show = 1 },
        { "Më « d­íi", "xia"; show = 1 },

    }
    SayTask("Tói Hµo Hoa Lín Phong ThÇn, thu hÕt b¸ch b¶o nh­ ý!", tasks)
end
function shang()
    local zt_name = {}
    for i = 1, 8 do

        if (GetBit(GetTask(changvariable), i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else

            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 9, "Giµy t©n thñ mµu lam (CÇn cÊp: 4 " .. zt_name[1] .. ")/v1", "Siªu cÊp Håi Thµnh Phï-nhá (CÇn cÊp: 8 " .. zt_name[2] .. ")/v2", "Thó c­ìi xanh cÊp 15 (CÇn cÊp: 12" .. zt_name[3] .. ")/v3", "Gi¸o huÊn lÇn 1 (CÇn cÊp: 16 " .. zt_name[4] .. ")/v4", "1 trang bÞ lôc cÊp 20 (CÇn cÊp: 20" .. zt_name[5] .. ")/v5", "Bµo th­¬ng Håi Thµnh Phï (CÇn cÊp: 24 " .. zt_name[6] .. ")/v6", "Vò khÝ Hoµng Kim cÊp 30 (CÇn cÊp: 28" .. zt_name[7] .. ")/v7", "B¹ch Kh«ng th­ (CÇn cÊp: 32 " .. zt_name[8] .. ")/v8", "Trang tr­íc/main")
end

function zhong()
    local zt_name = {}
    for i = 9, 16 do

        if (GetBit(GetTask(changvariable), i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else

            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 9, "Lôc Tïng Th¹ch (CÇn cÊp: 36 " .. zt_name[9] .. ")/v9", "Nh­ ý Tö Kim Ên (CÇn cÊp: 40 " .. zt_name[10] .. ")/v10", "T¸ Thanh Lé (Nh­ ý) (CÇn cÊp: 44" .. zt_name[11] .. ")/v11", "1 M¶nh V¶i, (CÇn cÊp: 48" .. zt_name[12] .. ")/v12", "1 Dao Tiªn t¸n (Nh­ ý), (CÇn cÊp: 52" .. zt_name[13] .. ")/v13", "Trang bi lôc cÊp 60(CÇn cÊp: 56" .. zt_name[14] .. ")/v14", "Vò khÝ Hoµng Kim cÊp 60 (CÇn cÊp: 60" .. zt_name[15] .. ")/v15", "S¸ch kü n¨ng (CÇn cÊp: 64 " .. zt_name[16] .. ")/v16", "Trang tr­íc/main")
end

function xia()
    local zt_name = {}
    for i = 17, 24 do

        if (GetBit(GetTask(changvariable), i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else

            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 9, "Thiªn H­¬ng (Nh­ ý)(CÇn cÊp: 68" .. zt_name[17] .. ")/v17", "Lam B¶o Th¹ch (CÇn cÊp: 72" .. zt_name[18] .. ")/v18", "LÔ bao ChÝ T«n (CÇn cÊp: 76" .. zt_name[19] .. ")/v19", "ThiÖp Nh­ ý (CÇn cÊp: 80" .. zt_name[20] .. ")/v20", "1 trang bÞ Lôc cÊp 80, (CÇn cÊp: 85" .. zt_name[21] .. ")/v21", "1 Danh ngäc, (CÇn cÊp: 90" .. zt_name[22] .. ")/v22", "ThiÖp Nh­ ý(yªu cÇu ®¼ng cÊp 95" .. zt_name[23] .. ")/v23", "ThiÖp Nh­ ý(CÇn cÊp: 100" .. zt_name[24] .. ")/v24", "Trang tr­íc/main")
end

function v1()
    if (GetTaskBit(changvariable, 1) == 0) then
        if (GetLevel() >= 4) then
            SetTaskBit(changvariable, 1, 1)

            if (GetPlayerType() == 0) then
                AddBlueEquip(0, 5, 0, 1, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc 1 HuyÒn Vò ChiÕn Ngoa!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=water>HuyÒn Vò ChiÕn Ngoa<c>!")
            elseif (GetPlayerType() == 1) then
                AddBlueEquip(0, 5, 1, 1, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc 1 Thiªn QuyÒn Lý!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=water>Thiªn QuyÒn Lý<c>!")
            else
                AddBlueEquip(0, 5, 2, 1, 0, 0, 1)
                Msg2Player("B¹n nhËn ®­îc 1 Lang Nha Ngoa!")
                Talk(1, "no", "B¹n nhËn ®­îc 1 <c=water>Lang Nha Ngoa<c>!")
            end
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=water>T©n Thñ Ngoa<c> råi!")
    end

end
function v2()
    if (GetTaskBit(changvariable, 1) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 2) == 0) then
        if (GetLevel() >= 8) then
            SetTaskBit(changvariable, 2, 1)
            AddNormalItem(8, 733, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Siªu cÊp Håi Thµnh Phï-nhá!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Siªu cÊp Håi Thµnh Phï-nhá<c>!")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>Siªu cÊp Håi Thµnh Phï-nhá<c> råi!")
    end

end
function v3()
    if (GetTaskBit(changvariable, 2) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 3) == 0) then
        if (GetLevel() >= 12) then
            SetTaskBit(changvariable, 3, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem2(0, 10, 0, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 Thanh T«ng M·!")
                Talk(1, "no", 13455)
            elseif (GetPlayerType() == 1) then
                AddNormalItem2(0, 10, 1, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 BÝch Ngäc T­íc!")
                Talk(1, "no", 13456)
            else
                AddNormalItem2(0, 10, 2, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 Lôc Ngäc hå ®iÖp!")
                Talk(1, "no", 13457)
            end


        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13458)
    end

end
function v4()
    if (GetTaskBit(changvariable, 3) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 4) == 0) then
        if (GetLevel() >= 16) then
            SetTaskBit(changvariable, 4, 1)
            AddIBBuff(734)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i Gi¸o huÊn!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 tr¹ng th¸i Gi¸o huÊn, cã thÓ lµm thªm 1 lÇn nhiÖm vô Gi¸o huÊn!")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>tr¹ng th¸i Gi¸o huÊn<c> råi!")
    end

end
function v5()
    if (GetTaskBit(changvariable, 4) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 5) == 0) then
        if (GetLevel() >= 20) then
            SetTaskBit(changvariable, 5, 1)
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

                AddNormalItem(0, j, 9, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 20!")
                Talk(1, "no", 13461)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 20!")
                Talk(1, "no", 13461)
            else
                AddNormalItem(0, j, 11, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 20!")
                Talk(1, "no", 13461)
            end

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13462)
    end

end

function v6()
    if (GetTaskBit(changvariable, 5) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 6) == 0) then
        if (GetLevel() >= 24) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(121)
            MsgBox("Chän x¸c nhËn-nhËn ®­îc 1 tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<Enter>Chän hñy bá-t¨ng <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï phï (khãa)", "v6_yes", "v6_coin")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c> råi!")
    end
end

function v6_yes()
    if (GetTaskBit(changvariable, 6) == 0) then
        SetTaskBit(changvariable, 6, 1)
        AddIBBuff(738)

        Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï!")
        Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c>!")
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>tr¹ng th¸i Bµo th­¬ng Håi Thµnh Phï<c> råi!")
    end
end

function v6_coin()
    if (GetTaskBit(changvariable, 6) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(121)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 6, 1)
            CostCoinByIdx(121)
            AddNormalItem(8, 737, 2, 0, 0, 0)
            Msg2Player("Ngµi thªm " .. Cfs .. " Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï")
            Talk(1, "no", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 Bµo th­¬ng Håi Thµnh Phï (khãa)")
        else
            Talk(1, "no", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "no", "B¹n ®· nhËn 1 lo¹t <c=g>Bµo th­¬ng Håi Thµnh Phï<c>!")
    end
end

function v7()
    if (GetTaskBit(changvariable, 6) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 7) == 0) then
        if (GetLevel() >= 28) then
            SetTaskBit(changvariable, 7, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 3, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 3, 1, 0)
            else
                AddNormalItem(0, 0, 30, 3, 1, 0)
            end ;

            Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 30!")
            Talk(1, "no", 13480)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13481)
    end

end
function v8()
    if (GetTaskBit(changvariable, 7) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 8) == 0) then
        if (GetLevel() >= 32) then
            SetTaskBit(changvariable, 8, 1)
            AddNormalItem(8, 139, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 B¹ch Kh«ng th­!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>B¹ch Kh«ng Th­<c>")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>B¹ch Kh«ng Th­<c>!")
    end

end
function v9()
    if (GetTaskBit(changvariable, 8) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 9) == 0) then
        if (GetLevel() >= 36) then
            SetTaskBit(changvariable, 9, 1)
            AddNormalItem(8, 239, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Lôc Tïng Th¹ch!")
            Talk(1, "no", 13486)
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13487)
    end

end

function v10()
    if (GetTaskBit(changvariable, 9) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 10) == 0) then
        if (GetLevel() >= 40) then
            SetTaskBit(changvariable, 10, 1)
            AddNormalItem(8, 716, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Nh­ ý Tö Kim Ên!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Nh­ ý Tö Kim Ên<c>!")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn <c=g>Nh­ ý Tö Kim Ên<c> råi!")
    end

end
function v11()
    if (GetTaskBit(changvariable, 10) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 11) == 0) then
        if (GetLevel() >= 44) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(122)
            MsgBox("Chän x¸c nhËn-nhËn ®­îc 1 T¸ Thanh Lé (Nh­ ý)<Enter>Chän hñy bá-t¨ng <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi T¸ Thanh Lé Siªu CÊp (Nh­ ý) vµ Thñy Ch©n KhÝ Siªu CÊp (Nh­ ý)", "v11_yes", "v11_coin")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>T¸ Thanh Lé (Nh­ ý)<c>!")
    end
end

function v11_yes()
    if (GetTaskBit(changvariable, 11) == 0) then
        SetTaskBit(changvariable, 11, 1)
        AddNormalItem(8, 383, 3, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 T¸ Thanh Lé (Nh­ ý)!")
        Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>T¸ Thanh Lé (Nh­ ý)<c> !")
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>T¸ Thanh Lé (Nh­ ý)<c>!")
    end
end

function v11_coin()
    if (GetTaskBit(changvariable, 11) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(122)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 11, 1)
            CostCoinByIdx(122)
            AddNormalItem(8, 735, 3, 0, 0, 0)
            AddNormalItem(8, 736, 4, 0, 0, 0)
            Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi T¸ Thanh Lé Siªu CÊp (Nh­ ý) vµ Thñy Ch©n KhÝ Siªu CÊp (Nh­ ý)")
            Talk(1, "no", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi T¸ Thanh Lé Siªu CÊp (Nh­ ý) vµ Thñy Ch©n KhÝ Siªu CÊp (Nh­ ý)")
        else
            Talk(1, "no", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>T¸ Thanh Lé (Nh­ ý)<c>!")
    end
end

function v12()
    if (GetTaskBit(changvariable, 11) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 12) == 0) then
        if (GetLevel() >= 48) then
            SetTaskBit(changvariable, 12, 1)
            AddNormalItem(8, 269, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 M¶nh V¶i!")
            Talk(1, "no", 13494)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13495)
    end

end
function v13()
    if (GetTaskBit(changvariable, 12) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 13) == 0) then
        if (GetLevel() >= 52) then
            SetTaskBit(changvariable, 13, 1)
            AddNormalItem(8, 395, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Dao Tiªn t¸n (Nh­ ý)!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Dao Tiªn t¸n (Nh­ ý)<c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Dao Tiªn t¸n (Nh­ ý)<c>!")
    end

end
function v14()
    if (GetTaskBit(changvariable, 13) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 14) == 0) then
        if (GetLevel() >= 56) then
            SetTaskBit(changvariable, 14, 1)
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
                Talk(1, "no", 13496)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 60!")
                Talk(1, "no", 13496)
            else
                AddNormalItem(0, j, 11, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 60!")
                Talk(1, "no", 13496)
            end

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13497)
    end

end

function v15()
    if (GetTaskBit(changvariable, 14) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 15) == 0) then
        if (GetLevel() >= 60) then
            SetTaskBit(changvariable, 15, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 6, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 6, 1, 0)
            else
                AddNormalItem(0, 0, 30, 6, 1, 0)
            end ;
            Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 60!")
            Talk(1, "no", 13498)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13499)
    end

end
function v16()
    if (GetTaskBit(changvariable, 15) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 16) == 0) then
        if (GetLevel() >= 64) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(123)
            MsgBox("Chän x¸c nhËn-nhËn ®­îc 1 S¸ch kü n¨ng (Liªn Hoµn, Thiªn B¨ng, L­u Tinh tïy theo tõng hÖ ph¸i)<Enter>Chän hñy bá-t¨ng<c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 S¸ch kü n¨ng vµ 1 Th¸i Cùc §¬n", "v16_yes", "v16_coin")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v16_yes()
    if (GetTaskBit(changvariable, 16) == 0) then
        SetTaskBit(changvariable, 16, 1)
        if (GetPlayerType() == 0) then
            AddNormalItem(7, 35, 38, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng Gi¸p SÜ: Liªn Hoµn Tr¶m!")
        elseif (GetPlayerType() == 1) then
            AddNormalItem(7, 17, 20, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng §¹o SÜ: Thiªn B¨ng §Þa LiÖt!")
        else
            AddNormalItem(7, 55, 456, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 S¸ch kü n¨ng DÞ Nh©n: L­u Tinh TÕ!")
        end ;

        Talk(1, "no", "B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng <c> !")
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v16_coin()
    if (GetTaskBit(changvariable, 16) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(123)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 16, 1)
            CostCoinByIdx(123)
            AddNormalItem(8, 165, 2, 0, 1, 0)
            if (GetPlayerType() == 0) then
                AddNormalItem(7, 35, 38, 1, 0, 0)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng Gi¸p SÜ: Liªn Hoµn Tr¶m vµ 1 Th¸i Cùc §¬n!")
            elseif (GetPlayerType() == 1) then
                AddNormalItem(7, 17, 20, 1, 0, 0)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng §¹o SÜ: Thiªn B¨ng §Þa LiÖt vµ 1 Th¸i Cùc §¬n!")
            else
                AddNormalItem(7, 55, 456, 1, 0, 0)
                Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 S¸ch kü n¨ng DÞ Nh©n: L­u Tinh TÕ vµ 1 Th¸i Cùc §¬n!")
            end ;

            Talk(1, "no", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 S¸ch kü n¨ng vµ 1 Th¸i Cùc §¬n")
        else
            Talk(1, "no", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end
end

function v17()
    if (GetTaskBit(changvariable, 16) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 17) == 0) then
        if (GetLevel() >= 68) then
            SetTaskBit(changvariable, 17, 1)
            AddNormalItem(8, 398, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Thiªn H­¬ng (Nh­ ý)!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Thiªn H­¬ng (Nh­ ý)<c> !")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Thiªn H­¬ng (Nh­ ý)<c>!")
    end

end
function v18()
    if (GetTaskBit(changvariable, 17) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 18) == 0) then
        if (GetLevel() >= 72) then
            SetTaskBit(changvariable, 18, 1)
            AddNormalItem(3, 41, 0, 0, 1, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Lam B¶o Th¹ch!")
            Talk(1, "no", 13504)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13505)
    end

end
function v19()
    if (GetTaskBit(changvariable, 18) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 19) == 0) then
        if (GetLevel() >= 76) then
            SetTaskBit(changvariable, 19, 1)
            AddNormalItem(8, 289, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 LÔ bao ChÝ T«n!")
            Talk(1, "no", 13506)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13507)
    end

end

function v20()
    if (GetTaskBit(changvariable, 19) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    MsgBox(13508, "yes_1", "no")

end
function yes_1()
    if (GetTaskBit(changvariable, 20) == 0) then
        if (GetLevel() >= 80) then
            SetTaskBit(changvariable, 20, 1)
            local j = math.random(1, 100)
            if (j <= 1) then
                AddItemPileNum(3, 138, 0, 1, 500)
                Msg2Player("B¹n nhËn ®­îc 500 ThiÖp Nh­ ý!")
                WriteLog("80 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                SetTaskBit(changvariable, 26, 1)
                Talk(1, "no", 13509)
            else
                AddItemPileNum(3, 138, 0, 1, 50)
                Msg2Player("B¹n nhËn ®­îc 50 ThiÖp Nh­ ý!")
                WriteLog("NhËn ®­îc 50 ThiÖp Nh­ ý<fsb>")
                Talk(1, "no", 13511)
            end


        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13512)
    end

end

function v21()
    if (GetTaskBit(changvariable, 20) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 21) == 0) then
        if (GetLevel() >= 85) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
            MsgBox("Chän x¸c nhËn-nhËn ®­îc 1 trang bÞ lôc cÊp 80 (y phôc, phi phong, khãa)<Enter>Chän hñy bá-t¨ng <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 trang bÞ lôc (y phôc, phi phong, khãa) vµ 2 Lôc Tïng Th¹ch cao cÊp", "v21_yes", "v21_coin")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh qua <c=g>trang bÞ Lôc cÊp 80<c>!")
    end
end

function v21_yes()
    if (GetTaskBit(changvariable, 21) == 0) then
        SetTaskBit(changvariable, 21, 1)
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
        Msg2Player("B¹n nhËn ®­îc 1 trang bÞ lôc cÊp 80!")
        Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>trang bÞ lôc<c> cÊp 80!")
    else
        Talk(1, "no", "B¹n ®· l·nh qua <c=g>trang bÞ Lôc cÊp 80<c>!")
    end
end

function v21_coin()
    if (GetTaskBit(changvariable, 21) == 0) then
        local _, Cv, Cfs = GetCostCoinInfoByIdx(124)
        if (GetCoin() >= Cv) then
            SetTaskBit(changvariable, 21, 1)
            CostCoinByIdx(124)
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
            AddNormalItem(8, 240, 2, 0, 0, 0)
            AddNormalItem(8, 240, 2, 0, 0, 0)
            Msg2Player("Ngµi thªm " .. Cfs .. "Th«ng B¶o ®æi 1 trang bÞ lôc cÊp 80 vµ 2 Lôc Tïng Th¹ch cao cÊp")
            Talk(1, "no", "Ngµi thªm <c=g>" .. Cfs .. "<c> Th«ng B¶o ®æi 1 trang bÞ lôc cÊp 80 vµ 2 Lôc Tïng Th¹ch cao cÊp!")
        else
            Talk(1, "no", "RÊt tiÕc, b¹n kh«ng ®ñ Th«ng B¶o")
        end
    else
        Talk(1, "no", "B¹n ®· l·nh qua <c=g>trang bÞ Lôc cÊp 80<c>!")
    end
end

function v22()
    if (GetTaskBit(changvariable, 21) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 22) == 0) then
        if (GetLevel() >= 90) then
            SetTaskBit(changvariable, 22, 1)
            local r = math.random(0, 2)
            local yu_name = { "XÝch Viªm Danh Ngäc", "Thanh Minh Danh Ngäc", "Tö Hµ Danh Ngäc" }
            AddNormalItem(3, (256 + r * 7), 0, 0, 0, 0)
            Msg2Player("B¹n nh©n ®­îc " .. yu_name[r + 1] .. " 1 viªn!")
            Talk(1, "no", "B¹n nhËn ®­îc 1 <c=g>Danh Ngäc<c>!")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh qua <c=g>Danh Ngäc<c>!")
    end

end

function v23()
    if (GetTaskBit(changvariable, 22) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    MsgBox(13508, "yes_2", "no")

end
function yes_2()
    if (GetTaskBit(changvariable, 23) == 0) then
        if (GetLevel() >= 95) then
            SetTaskBit(changvariable, 23, 1)
            local j = math.random(1, 100)
            if (j <= 3) and (GetTaskBit(changvariable, 26) == 0) then
                AddItemPileNum(3, 138, 0, 1, 500)
                Msg2Player("B¹n nhËn ®­îc 500 ThiÖp Nh­ ý!")
                WriteLog("95 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                SetTaskBit(changvariable, 27, 1)
                Talk(1, "no", 13509)

            else
                AddItemPileNum(3, 138, 0, 1, 50)
                Msg2Player("B¹n nhËn ®­îc 50 ThiÖp Nh­ ý!")
                WriteLog("NhËn ®­îc 50 ThiÖp Nh­ ý<fsb>")
                Talk(1, "no", 13511)
            end
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13512)
    end

end

function v24()
    if (GetTaskBit(changvariable, 23) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    MsgBox(13508, "yes_3", "no")

end
function yes_3()
    if (GetTaskBit(changvariable, 24) == 0) then
        if (GetLevel() >= 100) then
            SetTaskBit(changvariable, 24, 1)
            local j = math.random(1, 100)
            if (j <= 5) and (GetTaskBit(changvariable, 26) == 0) and (GetTaskBit(changvariable, 27) == 0) then
                AddItemPileNum(3, 138, 0, 1, 500)
                Msg2Player("B¹n nhËn ®­îc 500 ThiÖp Nh­ ý!")
                WriteLog("100 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                Talk(1, "jieshu", 13509)
            else
                AddItemPileNum(3, 138, 0, 1, 100)
                Msg2Player("B¹n nhËn ®­îc 100 ThiÖp Nh­ ý!")
                WriteLog("NhËn ®­îc 100 ThiÖp Nh­ ý<fsb>")
                Talk(1, "jieshu", 13510)
            end
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", 13512)
    end

end
function jieshu()
    CloseDialog()
    for i = 1, 24 do
        if (GetTaskBit(changvariable, i) == 0) then
            return 0
        end
    end
    DelNormalItem(6, 1, 530, 0)
    return 1
end

function no()
    CloseDialog()
end
