changvariable = 1286
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
    SayTask("Phong ThÇn b¶ng ®¹i lÔ bao ®ang ®îi c¸c anh hïng ®Õn nhËn l·nh!", tasks)
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
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 9, "T©n thñ Ngoa (CÇn cÊp: 4" .. zt_name[1] .. ")/v1", "trùc tiÕp t¨ng ®Õn cÊp 9 (CÇn cÊp: 8" .. zt_name[2] .. ")/v2", "Thó c­ìi xanh cÊp 15 (CÇn cÊp: 12" .. zt_name[3] .. ")/v3", "10 Håi thµnh phï, (CÇn cÊp: 16" .. zt_name[4] .. ")/v4", "1 trang bÞ lôc cÊp 20 (CÇn cÊp: 20" .. zt_name[5] .. ")/v5", "La H¸n HiÖu Gi¸c (Nh­ ý) (CÇn cÊp: 24" .. zt_name[6] .. ")/v6", "Vò khÝ Hoµng Kim cÊp 30 (CÇn cÊp: 28" .. zt_name[7] .. ")/v7", "TiÓu sinh mÖnh Thanh Lé (CÇn cÊp: 32" .. zt_name[8] .. ")/v8", "Trang tr­íc/main")
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
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 9, "B¹ch Kh«ng Th­ (CÇn cÊp: 36" .. zt_name[9] .. ")/v9", "Lôc Tïng Th¹ch (CÇn cÊp: 40" .. zt_name[10] .. ")/v10", "T¸ Thanh Lé (Nh­ ý) (CÇn cÊp: 44" .. zt_name[11] .. ")/v11", "1 M¶nh V¶i, (CÇn cÊp: 48" .. zt_name[12] .. ")/v12", "1 Dao Tiªn t¸n (Nh­ ý), (CÇn cÊp: 52" .. zt_name[13] .. ")/v13", "Trang bi lôc cÊp 60(CÇn cÊp: 56" .. zt_name[14] .. ")/v14", "Vò khÝ Hoµng Kim cÊp 60 (CÇn cÊp: 60" .. zt_name[15] .. ")/v15", "1 quyÓn s¸ch kü n¨ng cÊp 65 hoÆc 66 (CÇn cÊp: 64" .. zt_name[16] .. ")/v16", "Trang tr­íc/main")
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
                AddNormalItem(0, 5, 0, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>HuyÒn Vò ChiÕn Ngoa<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>HuyÒn Vò ChiÕn Ngoa<c>!")
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 5, 1, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>Thiªn QuyÒn Lý<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Thiªn QuyÒn Lý<c>!")
            else
                AddNormalItem(0, 5, 2, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>Lang Nha Ngoa<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Lang Nha Ngoa<c>!")
            end
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· nhËn ®­îc <c=g>T©n Thñ Ngoa<c>!")
    end

end
function v2()
    if (GetTaskBit(changvariable, 1) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 2) == 0) then
        if (GetLevel() == 8) then
            SetTaskBit(changvariable, 2, 1)
            AddOwnExp(GetNextExp())
            Msg2Player("B¹n trùc tiÕp t¨ng ®Õn <c=g>cÊp 9<c=r>!")
            Talk(1, "jieshu", "B¹n trùc tiÕp t¨ng ®Õn <c=g>cÊp 9<c=r>!")
        elseif (GetLevel() > 8) then
            SetTaskBit(changvariable, 2, 1)
            Talk(1, "jieshu", "B¹n ®· qu¸ cÊp <c=r>9<c>!")
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13454)
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
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>Thanh T«ng M·<c=r>!")
                Talk(1, "jieshu", 13455)
            elseif (GetPlayerType() == 1) then
                AddNormalItem2(0, 10, 1, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>BÝch Ngäc T­íc<c=r>!")
                Talk(1, "jieshu", 13456)
            else
                AddNormalItem2(0, 10, 2, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>Lôc Ngäc hå ®iÖp<c=r>!")
                Talk(1, "jieshu", 13457)
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
            for i = 1, 10 do
                AddNormalItemPile(5, 0, 0, 1, 0, 0)
            end
            Msg2Player("B¹n nhËn ®­îc 10 <c=g>Håi thµnh phï<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 10 <c=g>Håi thµnh phï<c>!")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13460)
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
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>trang bÞ Lôc cÊp 20<c=r>!")
                Talk(1, "jieshu", 13461)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>trang bÞ Lôc cÊp 20<c=r>!")
                Talk(1, "jieshu", 13461)
            else
                AddNormalItem(0, j, 11, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 <c=g>trang bÞ Lôc cÊp 20<c=r>!")
                Talk(1, "jieshu", 13461)
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
            SetTaskBit(changvariable, 6, 1)
            AddNormalItem(8, 399, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>La H¸n HiÖu Gi¸c (Nh­ ý)<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>La H¸n hiÖu gi¸c (Nh­ ý) <c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>La H¸n hiÖu gi¸c (Nh­ ý)<c> !")
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

            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Vò khÝ Hoµng Kim cÊp 30<c=r>!")
            Talk(1, "jieshu", 13480)

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
            AddNormalItem(8, 28, 3, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Thanh Lé (tiÓu)<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc <c=g>Thanh lé (tiÓu)<c>!")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Thanh lé (tiÓu)<c>!")
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
            SetTask(changvariable, SetBit(GetTask(changvariable), 9, 1))
            AddNormalItem(8, 139, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>B¹ch Kh«ng Th­<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>B¹ch Kh«ng Th­<c>")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>B¹ch Kh«ng Th­<c>!")
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
            AddNormalItem(8, 239, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Lôc Tïng th¹ch<c=r>!")
            Talk(1, "jieshu", 13486)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13487)
    end

end
function v11()
    if (GetTaskBit(changvariable, 10) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 11) == 0) then
        if (GetLevel() >= 44) then
            SetTaskBit(changvariable, 11, 1)
            AddNormalItem2(8, 383, 3, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>T¸ Thanh Lé (Nh­ ý)<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>T¸ Thanh Lé (Nh­ ý)<c> !")

        else
            Talk(1, "no", 13451)
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
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>M¶nh V¶i<c=r>!")
            Talk(1, "jieshu", 13494)

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
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Dao Tiªn t¸n (Nh­ ý)<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Dao Tiªn t¸n (Nh­ ý)<c> !")

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
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 60<c=r>!")
                Talk(1, "jieshu", 13496)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 60<c=r>!")
                Talk(1, "jieshu", 13496)
            else
                AddNormalItem(0, j, 11, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 60<c=r>!")
                Talk(1, "jieshu", 13496)
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
            Msg2Player("B¹n nhËn ®­îc <c=g>Vò khÝ Hoµng Kim cÊp 60<c=r>!")
            Talk(1, "jieshu", 13498)

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
            SetTaskBit(changvariable, 16, 1)
            if (GetPlayerType() == 0) then
                AddNormalItem(7, 35, 38, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>s¸ch kü n¨ng Gi¸p sÜ:Liªn Hoµn Tr¶m<c=r>!")
            elseif (GetPlayerType() == 1) then
                AddNormalItem(7, 17, 20, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>s¸ch kü n¨ng §¹o sÜ:Thiªn B¨ng §Þa LiÖt<c=r>!")
            else
                AddNormalItem(7, 55, 456, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>s¸ch kü n¨ng DÞ nh©n:L­u Tinh TÕ<c=r>!")
            end ;

            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng <c> !")
        else
            Talk(1, "no", 13451)
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
            Msg2Player("B¹n nhËn ®­îc <c=g>Thiªn H­¬ng (Nh­ ý)<c=r>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Thiªn H­¬ng (Nh­ ý)<c> !")
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
            Msg2Player("B¹n nhËn ®­îc <c=g>Lam B¶o th¹ch<c=r>!")
            Talk(1, "jieshu", 13504)

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
            Msg2Player("B¹n nhËn ®­îc <c=g>LÔ bao ChÝ T«n<c=r>!")
            Talk(1, "jieshu", 13506)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", 13507)
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
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý 500<c=r>!")
                WriteLog("80 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                SetTaskBit(changvariable, 26, 1)
                Talk(1, "jieshu", 13509)
            else
                AddItemPileNum(3, 138, 0, 1, 50)
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý 50<c=r>!")
                WriteLog("NhËn ®­îc 50 ThiÖp Nh­ ý<fsb>")
                Talk(1, "jieshu", 13511)
            end


        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", 13512)
    end

end

function v21()
    if (GetTaskBit(changvariable, 20) == 0) then
        Talk(1, "no", "LÔ bao nµy phÇn th­ëng nhËn ®­îc theo thø tù, ph¶i nhËn phÇn tr­íc th× míi nhËn tiÕp ®­îc phÇn sau!")
        return 0
    end

    if (GetTaskBit(changvariable, 21) == 0) then
        if (GetLevel() >= 85) then
            SetTaskBit(changvariable, 21, 1)
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

                AddNormalItem(0, j, 9, 8, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 8, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")
            else
                AddNormalItem(0, j, 11, 8, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")
                Talk(1, "jieshu", "B¹n nhËn ®­îc <c=g>trang bÞ Lôc cÊp 80<c=r>!")
            end

        else
            Talk(1, "no", 13451)
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
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng <c=g>" .. yu_name[r + 1] .. "<c=r>1 viªn!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Danh Ngäc<c=r>!")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", "B¹n ®· l·nh qua <c=g>Danh Ngäc<c>!")
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
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý 500<c=r>!")
                WriteLog("95 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                SetTaskBit(changvariable, 27, 1)
                Talk(1, "jieshu", 13509)

            else
                AddItemPileNum(3, 138, 0, 1, 50)
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý 50<c=r>!")
                WriteLog("NhËn ®­îc 50 ThiÖp Nh­ ý<fsb>")
                Talk(1, "jieshu", 13511)
            end
        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", 13512)
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
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý 500<c=r>!")
                WriteLog("100 nhËn ®­îc 500 ThiÖp Nh­ ý<fsb>")
                Talk(1, "jieshu", 13509)
            else
                AddItemPileNum(3, 138, 0, 1, 100)
                Msg2Player("B¹n nhËn ®­îc <c=g>ThiÖp Nh­ ý100<c=r>!")
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
    DelNormalItem(6, 1, 415, 0)
    return 1
end

function no()
    CloseDialog()
end
