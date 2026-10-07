changvariable = 1174
function main()
    if (jieshu() == 1) then
        Talk(1, "no", "B¹n ®· nhËn tÊt c¶ phÇn th­ëng trong ®¹i lÔ bao!")
        return 0
    end

    tasks = {
        { "Më « trªn", "shang"; show = 1 },
        { "Më « d­íi", "xia"; show = 1 },

    }
    SayTask("Tói b×nh yªn, b¸ch b¶o Nh­ ý!", tasks)
end
function shang()
    local zt_name = {}
    for i = 1, 20 do

        if (GetBit(GetTask(changvariable), i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else

            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 10, "T©n Thñ Yªu §¸i (CÇn cÊp: 4" .. zt_name[1] .. ")/v1", "§iÓm kinh nghiÖm (CÇn cÊp: 8" .. zt_name[2] .. ")/v2", "Thó c­ìi xanh cÊp 15 (CÇn cÊp: 12" .. zt_name[3] .. ")/v3", "5 Håi thµnh phï (CÇn cÊp: 16" .. zt_name[4] .. ")/v4", "1 trang bÞ lôc cÊp 20 (CÇn cÊp: 20" .. zt_name[5] .. ")/v5", "La H¸n HiÖu Gi¸c (Nh­ ý) (CÇn cÊp: 24" .. zt_name[6] .. ")/v6", "Vò khÝ Hoµng Kim cÊp 30 (CÇn cÊp: 28" .. zt_name[7] .. ")/v7", "TiÓu sinh mÖnh Thanh Lé (CÇn cÊp: 32" .. zt_name[8] .. ")/v8", "B¹ch Kh«ng Th­ (CÇn cÊp: 36" .. zt_name[9] .. ")/v9", "Trang tr­íc/main")
end

function xia()
    local zt_name = {}
    for i = 1, 20 do

        if (GetBit(GetTask(changvariable), i) == 0) then
            zt_name[i] = "<c=g>ch­a nhËn<c>"
        else

            zt_name[i] = "<c=r> ®· nhËn <c>"
        end
    end
    Say("B¸ch b¶o kh¾p n¬i, ®õng cã hoa m¾t ®ã!", 12, "Lôc Tïng Th¹ch (CÇn cÊp: 40" .. zt_name[10] .. ")/v10", "T¸ Thanh Lé (Nh­ ý) (CÇn cÊp: 44" .. zt_name[11] .. ")/v11", "Dao Tiªn t¸n (Nh­ ý) (CÇn cÊp: 48" .. zt_name[12] .. ")/v12", "M¶nh V¶i (CÇn cÊp: 52" .. zt_name[13] .. ")/v13", "Trang bi lôc cÊp 60(CÇn cÊp: 56" .. zt_name[14] .. ")/v14", "Vò khÝ Hoµng Kim cÊp 60 (CÇn cÊp: 60" .. zt_name[15] .. ")/v15", "1 quyÓn s¸ch kü n¨ng cÊp 65 hoÆc 66 (CÇn cÊp: 64" .. zt_name[16] .. ")/v16", "Thiªn H­¬ng (Nh­ ý)(CÇn cÊp: 68" .. zt_name[17] .. ")/v17", "Lam B¶o Th¹ch (CÇn cÊp: 72" .. zt_name[18] .. ")/v18", "LÔ bao ChÝ T«n (CÇn cÊp: 76" .. zt_name[19] .. ")/v19", "ThiÖp Nh­ ý (CÇn cÊp: 80" .. zt_name[20] .. ")/v20", "Trang tr­íc/main")
end

function v1()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 1) == 0) then
        if (Level >= 4) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 1, 1))
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 6, 0, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>HuyÒn Vò Yªu §¸i<c>!")
                Talk(1, "jieshu", 13448)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 6, 1, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Thiªn QuyÒn C©n<c>!")
                Talk(1, "jieshu", 13449)
            else
                AddNormalItem(0, 6, 2, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Lang Nha Yªu §¸i<c>!")
                Talk(1, "jieshu", 13450)
            end

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13452)
    end

end
function v2()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 2) == 0) then
        if (Level >= 8) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 2, 1))
            AddOwnExp(800)
            Msg2Player("B¹n nhËn ®­îc <c=g>800<c> ®iÓm kinh nghiÖm!")
            Talk(1, "jieshu", 13453)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13454)
    end

end
function v3()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 3) == 0) then
        if (Level >= 12) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 3, 1))
            if (GetPlayerType() == 0) then
                AddNormalItem2(0, 10, 0, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Thanh T«ng M·<c>!")
                Talk(1, "jieshu", 13455)
            elseif (GetPlayerType() == 1) then
                AddNormalItem2(0, 10, 1, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>BÝch Ngäc T­íc<c>!")
                Talk(1, "jieshu", 13456)
            else
                AddNormalItem2(0, 10, 2, 2, 1, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Lôc Ngäc Hå §iÖp<c>!")
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
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 4) == 0) then
        if (Level >= 16) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 4, 1))
            for i = 1, 5 do
                AddNormalItemPile(5, 0, 0, 1, 0, 0)
            end
            Msg2Player("B¹n nhËn ®­îc 5 <c=g>Håi Thµnh Phï<c>!")
            Talk(1, "jieshu", 13459)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13460)
    end

end
function v5()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 5) == 0) then
        if (Level >= 20) then
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
            SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))
            if (GetPlayerType() == 0) then

                AddNormalItem(0, j, 9, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 20<c>!")
                Talk(1, "jieshu", 13461)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 20<c>!")
                Talk(1, "jieshu", 13461)
            else
                AddNormalItem(0, j, 11, 2, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 20<c>!")
                Talk(1, "jieshu", 13461)
            end

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13462)
    end

end

function tou()
    SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))

    if (GetPlayerType() == 0) then
        AddNormalItem(0, 7, 6, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Cù §Êu Kh«i<c>!")
        Talk(1, "jieshu", 13463)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 7, 7, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>V©n Trung Qu¸n<c>!")
        Talk(1, "jieshu", 13464)
    else
        AddNormalItem(0, 7, 8, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>KhuyÓn V¨n Trô<c>!")
        Talk(1, "jieshu", 13465)
    end
end
function yao()
    SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))

    if (GetPlayerType() == 0) then
        AddNormalItem(0, 6, 6, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Cù §Êu Yªu §¸i<c>!")
        Talk(1, "jieshu", 13466)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 6, 7, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>V©n Trung C©n<c>!")
        Talk(1, "jieshu", 13467)
    else
        AddNormalItem(0, 6, 8, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>KhuyÓn V¨n Yªu §¸i<c>!")
        Talk(1, "jieshu", 13468)
    end
end
function xie()
    SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))

    if (GetPlayerType() == 0) then
        AddNormalItem(0, 5, 6, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Cù §Êu ChiÕn Ngoa<c>!")
        Talk(1, "jieshu", 13469)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 5, 7, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>V©n Trung Lý<c>!")
        Talk(1, "jieshu", 13470)
    else
        AddNormalItem(0, 5, 8, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>KhuyÓn V¨n Hµi<c>!")
        Talk(1, "jieshu", 13471)
    end
end
function pifeng()
    SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))

    if (GetPlayerType() == 0) then
        AddNormalItem(0, 9, 6, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Cù §Êu Phi Phong<c>!")
        Talk(1, "jieshu", 13472)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 9, 7, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>V©n Trung LÖnh<c>!")
        Talk(1, "jieshu", 13473)
    else
        AddNormalItem(0, 9, 8, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>KhuyÓn V¨n KÕt<c>!")
        Talk(1, "jieshu", 13474)
    end

end
function jia()
    SetTask(changvariable, SetBit(GetTask(changvariable), 5, 1))

    if (GetPlayerType() == 0) then
        AddNormalItem(0, 2, 6, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Cù §Êu Gi¸p<c>!")
        Talk(1, "jieshu", 13475)
    elseif (GetPlayerType() == 1) then
        AddNormalItem(0, 2, 7, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>V©n Trung §¹o Bµo<c>!")
        Talk(1, "jieshu", 13476)
    else
        AddNormalItem(0, 2, 8, 2, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>KhuyÓn V¨n Hé Gi¸p<c>!")
        Talk(1, "jieshu", 13477)
    end

end
function v6()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 6) == 0) then
        if (Level >= 24) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 6, 1))
            AddNormalItem(8, 399, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>La H¸n hiÖu gi¸c (Nh­ ý) <c> !")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>La H¸n hiÖu gi¸c (Nh­ ý) <c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>La H¸n hiÖu gi¸c (Nh­ ý)<c> !")
    end

end
function v7()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 7) == 0) then
        if (Level >= 28) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 7, 1))
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 3, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 3, 1, 0)
            else
                AddNormalItem(0, 0, 30, 3, 1, 0)
            end ;

            Msg2Player("B¹n nhËn ®­îc <c=g>Vò khÝ Hoµng Kim cÊp 30<c>!")
            Talk(1, "jieshu", 13480)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13481)
    end

end
function v8()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 8) == 0) then
        if (Level >= 32) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 8, 1))
            AddNormalItem(8, 28, 3, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc <c=g>Thanh lé (tiÓu)<c>!")
            Talk(1, "jieshu", "B¹n nhËn ®­îc <c=g>Thanh lé (tiÓu)<c>!")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Thanh lé (tiÓu)<c>!")
    end

end
function v9()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 9) == 0) then
        if (Level >= 36) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 9, 1))
            AddNormalItem(8, 139, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>B¹ch Kh«ng Th­<c> !")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>B¹ch Kh«ng Th­<c>")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>B¹ch Kh«ng Th­<c>!")
    end

end
function v10()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 10) == 0) then
        if (Level >= 40) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 10, 1))
            AddNormalItem(8, 239, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc <c=g>Lôc Tïng Th¹ch<c>!")
            Talk(1, "jieshu", 13486)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13487)
    end

end
function v11()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 11) == 0) then
        if (Level >= 44) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 11, 1))

            AddNormalItem2(8, 383, 3, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>T¸ Thanh Lé (Nh­ ý)<c> !")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>T¸ Thanh Lé (Nh­ ý)<c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>T¸ Thanh Lé (Nh­ ý)<c>!")
    end

end
function v12()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 12) == 0) then
        if (Level >= 48) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 12, 1))
            AddNormalItem(8, 395, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Dao Tiªn t¸n (Nh­ ý)<c> !")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Dao Tiªn t¸n (Nh­ ý)<c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Dao Tiªn t¸n (Nh­ ý)<c>!")
    end

end
function v13()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 13) == 0) then
        if (Level >= 52) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 13, 1))
            AddNormalItem(8, 269, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>M¶nh V¶i<c>!")
            Talk(1, "jieshu", 13494)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13495)
    end

end
function v14()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 14) == 0) then
        if (Level >= 56) then
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
            SetTask(changvariable, SetBit(GetTask(changvariable), 14, 1))
            if (GetPlayerType() == 0) then

                AddNormalItem(0, j, 9, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 60<c>!")
                Talk(1, "jieshu", 13496)

            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, j, 10, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 60<c>!")
                Talk(1, "jieshu", 13496)
            else
                AddNormalItem(0, j, 11, 6, 0, 0)
                Msg2Player("B¹n nhËn ®­îc <c=g>Trang bÞ lôc cÊp 60<c>!")
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
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 15) == 0) then
        if (Level >= 60) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 15, 1))
            if (GetPlayerType() == 0) then
                AddNormalItem(0, 0, 28, 6, 1, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(0, 0, 29, 6, 1, 0)
            else
                AddNormalItem(0, 0, 30, 6, 1, 0)
            end ;
            Msg2Player("B¹n nhËn ®­îc <c=g>Vò khÝ Hoµng Kim cÊp 60<c>!")
            Talk(1, "jieshu", 13498)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13499)
    end

end
function v16()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 16) == 0) then
        if (Level >= 64) then
            if (GetPlayerType() == 0) then
                AddNormalItem(7, 35, 38, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng gi¸p sÜ: Liªn Hoµn Tr¶m<c> !")
            elseif (GetPlayerType() == 1) then
                AddNormalItem(7, 17, 20, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng ®¹o sÜ: Thiªn B¨ng §Þa LiÖt<c> !")
            else
                AddNormalItem(7, 55, 456, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng dÞ nh©n: L­u Tinh tÕ<c> !")

            end ;

            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 quyÓn <c=g>s¸ch kü n¨ng <c> !")
            SetTask(changvariable, SetBit(GetTask(changvariable), 16, 1))


        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>s¸ch kü n¨ng <c>!")
    end

end
function v17()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 17) == 0) then
        if (Level >= 68) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 17, 1))
            AddNormalItem(8, 398, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 <c=g>Thiªn H­¬ng (Nh­ ý)<c> !")
            Talk(1, "jieshu", "B¹n nhËn ®­îc 1 <c=g>Thiªn H­¬ng (Nh­ ý)<c> !")

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", "B¹n ®· l·nh <c=g>Thiªn H­¬ng (Nh­ ý)<c>!")
    end

end
function v18()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 18) == 0) then
        if (Level >= 72) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 18, 1))
            AddNormalItem(3, 41, 0, 0, 1, 0)
            Msg2Player("B¹n nhËn ®­îc <c=g>Lam B¶o Th¹ch<c>!")
            Talk(1, "jieshu", 13504)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "no", 13505)
    end

end
function v19()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 19) == 0) then
        if (Level >= 76) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 19, 1))
            AddNormalItem(8, 289, 2, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc <c=g>LÔ bao ChÝ T«n<c>!")
            Talk(1, "jieshu", 13506)

        else
            Talk(1, "no", 13451)
        end
    else
        Talk(1, "jieshu", 13507)
    end

end
function v20()
    MsgBox(13508, "yes_1", "no")

end
function yes_1()
    local Level = GetLevel()
    if (GetBit(GetTask(changvariable), 20) == 0) then
        if (Level >= 80) then
            SetTask(changvariable, SetBit(GetTask(changvariable), 20, 1))
            local j = math.random(1, 100)
            if (j <= 5) then
                AddItemPileNum(3, 138, 0, 1, 500)
                Msg2Player("B¹n nhËn ®­îc <c=g>500 ThiÖp Nh­ ý<c>!")
                WriteLog("NhËn ®­îc 500 Nh­ ý QuyÓn <TuÕ>")
                Talk(1, "jieshu", 13509)
            elseif (j <= 15) then
                AddItemPileNum(3, 138, 0, 1, 100)
                Msg2Player("B¹n nhËn ®­îc <c=g>100 ThiÖp Nh­ ý<c>!")
                WriteLog("NhËn ®­îc 100 Nh­ ý QuyÓn <TuÕ>")
                Talk(1, "jieshu", 13510)
            else
                AddItemPileNum(3, 138, 0, 1, 50)
                Msg2Player("B¹n nhËn ®­îc <c=g>50 ThiÖp Nh­ ý<c>!")
                WriteLog("NhËn ®­îc 50 Nh­ ý QuyÓn <TuÕ>")
                Talk(1, "jieshu", 13511)
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
    for i = 1, 20 do
        if (GetTaskBit(changvariable, i) == 0) then
            return 0
        end
    end

    DelNormalItem(6, 1, 342, 0)
    return 1
end

function no()
    CloseDialog()
end
