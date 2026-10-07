Task_hengcai = 1214;

function main()
    local mapname = {
        [1] = "Phong ThÇn ®µi",
        [2] = "Sïng Thµnh doanh",
        [3] = "Ngäc H­ cung",
        [4] = "Xi V­u Mé",
        [5] = "Phong Yªn",
        [6] = "Phong Yªn",
        [7] = "Phong Yªn",
        [8] = "Mang Mang TuyÕt Nguyªn",
        [9] = "Mang Mang TuyÕt Nguyªn",
        [10] = "Mang Mang TuyÕt Nguyªn",
        [11] = "Lôc L©m Th©m Xø",
        [12] = "Lôc L©m Th©m Xø",
        [13] = "Lôc L©m Th©m Xø",
        [14] = "Phong DiÖp Thô L©m",
        [15] = "Th¹ch KiÒu TiÓu KÝnh",
        [16] = "Th¹ch L©m TiÔu BÝch",
        [17] = "Phong DiÖp Thô L©m",
        [18] = "Th¹ch KiÒu TiÓu KÝnh",
        [19] = "TuyÖt Long lÜnh",
        [20] = "T©y Kú",
        [21] = "TriÒu Ca",
        [22] = "Hoang m¹c",
        [23] = "Thæ Thµnh",
        [24] = "Phong ThÇn",
        [25] = "Lôc Ch©u",
        [26] = "Sa M¹c chÕt",
        [27] = "Hiªn Viªn tÇng 1",
        [28] = "Hiªn Viªn tÇng 2",
        [29] = "Hiªn Viªn tÇng 3",
        [30] = "Hiªn Viªn tÇng 4",
        [31] = "Hiªn Viªn tÇng 5",
        [32] = "Ngäc TuyÒn",
        [33] = "TuyÕt Cèc",
        [34] = "§¹i Phong",
        [35] = "§¹i Th¹ch",
        [36] = "B¨ng Xuyªn Cùc",
        [37] = "Thñy Vùc",
        [38] = "Long Cung",
        [39] = "H¶i C©u",
        [40] = "Long Vùc",
        [41] = "Long Uyªn",
        [42] = "BÝch Du tÇng 1",
        [43] = "BÝch Du tÇng 2",
        [44] = "BÝch Du tÇng 3",
        [45] = "BÝch Du tÇng 4",
        [46] = "BÝch Du tÇng 5",
        [47] = "Khæn Tiªn tÇng 1",
        [48] = "Khæn Tiªn tÇng 2",
        [49] = "Khæn Tiªn tÇng 3",
        [50] = "Khæn Tiªn tÇng 4",
        [51] = "Khæn Tiªn tÇng 5",
        [52] = "Diªu Tr×",
        [53] = "§¹i H¶i",
        [54] = "Bång Lai",
        [55] = "§«ng Doanh",
        [56] = "Ph­¬ng Tr­îng",
        [57] = "Kho¸ng tr­êng",
        [58] = "D­îc V­¬ng cèc",
        [59] = "Sïng Thµnh (kho¸ng tr­êng)",
        [65] = "Vïng ®Êt Èm ­ít"
    }

    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }

    local maptask = GetTask(381)
    mapid, x1, y1 = GetWorldPos()
    if (maptask == 5) or (maptask == 11) or (maptask == 14) or (maptask == 15) or (maptask == 16) or (maptask == 8) or (maptask == 65) then
        if (GetTask(382) == 0) or (GetTask(849) ~= 0) or (GetTask(561) == 8) then
            if (HaveNormalItem(6, 1, 110, 0) >= 1) then
                DelNormalItem(6, 1, 110, 0)
            elseif (HaveNormalItemInQuick(6, 1, 110, 0) >= 1) then
                DelNormalItemInQuick(6, 1, 110, 0)
            end ;
            Talk(1, "no", 13204)
        else
            if (GetTask(381) ~= mapid) then
                Talk(1, "no", "Täa ®é kho b¸u ghi trong MËt tÞch da dª lµ <c=r>" .. mapname[maptask] .. "<c>!")
            else
                local px = GetTask(382)
                local py = GetTask(383)
                local distance = math.abs((x1 - px) * (x1 - px) + (y1 - py) * (y1 - py))
                local light = 1;
                if (distance <= 25) then
                    light = 4;
                elseif (distance <= 400) then
                    light = 3;
                elseif (distance <= 2500) then
                    light = 2;
                end ;
                local msg = "¾íÖá·¢³ö" .. lightname[light]
                local lastdist = GetTask(378)
                if (light == 4) and (lastdist >= 0) then
                    msg = msg .. ", B¶o tµng h×nh nh­ ®ang ë gÇn ®©y, h·y thö vËn may cña m×nh xem!"
                    if (GetTask(826) ~= 0) or (GetTask(561) ~= 0) then
                        MsgBox(msg, "wabao1", "no")
                    else
                        MsgBox(msg, "wabao", "no")
                    end
                else
                    if (lastdist == -1) then
                        msg = msg .. ", B¶o tµng h×nh nh­ ë ngay trong khu vùc nµy!"
                        SetTask(380, SystemTime())
                    elseif (lastdist < distance) then
                        msg = msg .. ", ÄãËÆºõ<color=red>Ô¶Àë<color>±¦²Ø"
                    else
                        msg = msg .. ", ÄãËÆºõ<color=green>½Ó½ü<color>±¦²Ø"
                    end ;
                    TopMessage(msg)
                end ;
                SetTask(378, distance)
            end ;
        end ;
    else
        if (HaveNormalItem(6, 1, 110, 0) >= 1) then
            DelNormalItem(6, 1, 110, 0)
        elseif (HaveNormalItemInQuick(6, 1, 110, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 110, 0)
        end ;
        Talk(1, "no", 13204)
    end
end;

function no()
    CloseDialog()
end;

function wabao()

    if (GetTask(382) == 0) or (GetTask(383) == 0) then
        no()
        return
    end

    if ((HaveNormalItemInQuick(6, 1, 110, 0) >= 1) or (HaveNormalItem(6, 1, 110, 0) >= 1)) then
        if (HaveNormalItem(6, 1, 110, 0) >= 1) then
            DelNormalItem(6, 1, 110, 0)
        elseif (HaveNormalItemInQuick(6, 1, 110, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 110, 0)
        end ;

        local hengcain = GetTask(Task_hengcai)
        if (GetBit(hengcain, 5) == 1 and GetBit(hengcain, 7) == 0) then
            AddNormalItem(3, 230, 0, 0, 0, 0)
            Msg2Player(" B¹n nhËn ®­îc 1 Con rèi")
            TopMessage(14343)
            TaskNote(76, 1)
            SetTask(382, 0)
            SetTask(383, 0)
            SetTask(395, SystemTime() - GetTask(380))
            MsgBox(14344, "no")
            return 0
        end
        SetTask(382, 0)
        SetTask(383, 0)
        SetTask(395, SystemTime() - GetTask(380))
        local x = math.random(1, 1000)
        if (x <= 20) then
            local y = math.random(1, 10)
            local num = 1
            if (y > 8) then
                num = 3
            elseif (y > 5) then
                num = 2
            end
            for i = 1, num do
                AddNormalItemPile(3, 77, 0, 0, 0, 0)
            end ;
            Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. num .. "m¶nh Hång Thñy tinh!")
            MsgBox("Chóc mõng! B¹n nhËn ®­îc " .. num .. "m¶nh <c=r>Hång Thñy Tinh<c>.", "no")
        elseif ((x > 100) and (x <= 110)) then
            local y = math.random(1, 10)
            local num = 1
            if (y > 9) then
                num = 3
            elseif (y > 7) then
                num = 2
            end
            for i = 1, num do
                AddNormalItemPile(3, 28, 0, 0, 0, 0)
            end ;
            Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. num .. "Hång Thñy tinh.")
            MsgBox("Chóc mõng! B¹n nhËn ®­îc " .. num .. "<c=r>Hång Thñy tinh<c>.", "no")
        elseif ((x > 160) and (x <= 180)) then
            local y = math.random(1, 10)
            local num = 1
            if (y > 8) then
                num = 3
            elseif (y > 5) then
                num = 2
            end
            for i = 1, num do
                AddNormalItemPile(3, 78, 0, 0, 0, 0)
            end ;
            Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. num .. "m¶nh Lam Thñy tinh.")
            MsgBox("Chóc mõng! B¹n nhËn ®­îc " .. num .. "m¶nh <c=r>Lam Thñy tinh<c>.", "no")
        elseif (x > 190) and (x <= 200) then
            local y = math.random(1, 10)
            local num = 1
            if (y > 9) then
                num = 3
            elseif (y > 7) then
                num = 2
            end
            for i = 1, num do
                AddNormalItemPile(3, 80, 0, 0, 0, 0)
            end ;
            Msg2Player("Chóc mõng! B¹n nhËn ®­îc " .. num .. "Lam Thñy tinh.")
            MsgBox("Chóc mõng! B¹n nhËn ®­îc " .. num .. "<c=r>Lam Thñy tinh<c>.", "no")
        elseif (x > 200) and (x <= 250) then
            local p = math.random(0, 5)
            AddNormalItem(0, 4, p, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Ph¸p b¶o cÊp 10.")
            MsgBox(13205, "no")
        elseif (x > 250) and (x <= 280) then
            local p = math.random(6, 9)
            AddNormalItem(0, 4, p, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Ph¸p b¶o cÊp 30.")
            MsgBox(13206, "no")
        elseif (x > 280) and (x <= 295) then
            local p = math.random(10, 13)
            AddNormalItem(0, 4, p, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Ph¸p b¶o cÊp 50.")
            MsgBox(13207, "no")
        elseif (x > 295) and (x <= 300) then
            local p = math.random(14, 17)
            AddNormalItem(0, 4, p, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Ph¸p b¶o cÊp 70.")
            MsgBox(13208, "no")
        elseif ((x > 300) and (x <= 480)) or ((x > 20) and (x <= 90)) then
            AddNormalItem(3, 62, 0, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Thæ Linh phï.")
            MsgBox(13209, "no")
        elseif (x > 480) and (x <= 520) then
            AddNormalItem(3, 63, 0, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Thñy Linh phï.")
            MsgBox(13210, "no")
        elseif (x > 520) and (x <= 535) then
            AddNormalItem(3, 64, 0, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Háa Linh phï.")
            MsgBox(13211, "no")
        elseif (x > 535) and (x <= 540) then
            AddNormalItem(3, 65, 0, 0, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Phong Linh phï.")
            MsgBox(13212, "no")
        elseif (x > 540) and (x <= 590) then
            local y = 100 * math.random(5, 12)
            local money = GetLevel() * y
            Earn(money)
            Msg2Player("B¹n nhËn ®­îc " .. money .. ".")
            MsgBox("B¹n nhËn ®­îc <c=r>" .. money .. "<c>.", "no")
        else
            local lv = GetLevel()
            local exp = 0
            if (lv < 40) then
                exp = lv * 200
            elseif (lv < 60) then
                exp = lv * 300
            else
                exp = 20000
            end
            AddOwnExp(exp)
            Msg2Player("Chóc mõng nhËn ®­îc ®iÓm kinh nghiÖm" .. exp .. ".")
            MsgBox("B¹n nhËn ®­îc kinh nghiÖm <c=r>" .. exp .. "<c>.", "no")
        end ;

        if (x >= 130) and (x < 140) then

            AddNormalItem(3, 88, 0, 0, 0, 0, 0)
            Msg2Player("Chóc mõng! B¹n may m¾n nhËn ®­îc 1 m¶nh Hoµng Thñy Tinh!")

        end


    end ;
end;
function wabao1()

    if (GetTask(382) == 0) or (GetTask(383) == 0) then
        no()
        return
    end

    if ((HaveNormalItemInQuick(6, 1, 110, 0) >= 1) or (HaveNormalItem(6, 1, 110, 0) >= 1)) then
        if (HaveNormalItem(6, 1, 110, 0) >= 1) then
            DelNormalItem(6, 1, 110, 0)
        elseif (HaveNormalItemInQuick(6, 1, 110, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 110, 0)
        end ;
        local x = math.random(1, 100)
        if (x <= 3) then
            RemoveIBBuff(304)
            AddIBBuff(304)
            Msg2Player("Chóc mõng b¹n lÜnh ngé ®­îc huyÒn c¬ cña quÎ thiªn, nhËn ®­îc tr¹ng th¸i Phôc Hy!")
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> ®· dÔ dµng hoµn thµnh ThÊt qu¸i thÝ luyÖn, nhËn ®­îc sù chiÕu cè cña Phôc Hi thÇn!")
            Talk(1, "no", 13213)
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> lÜnh ngé huyÒn bÝ quÎ thiªn vµ hoµn thµnh nhiÖm vô ThÊt Qu¶i, nhËn ®­îc <c=g>phÇn th­ëng nh©n ®«i ®iÓm kinh nghiÖm<c>, xin Chóc mõng!", 3)


        elseif (x <= 75) then
            Earn(100000)
            Msg2Player("Chóc mõng, b¹n nhËn ®­îc 100000 l­îng")
            Talk(1, "no", 13214)
        else
            Talk(1, "no", 13215)
        end

        local step = GetTask(826) + 826
        if (GetTask(step) == 1) then
            SetTask(step, 2)
        end
        if (GetTask(826) ~= 0) then
            TopMessage(13216)
            TaskNote(62, 9)
        end

        SetTask(382, 0)
        SetTask(383, 0)
        SetTask(395, SystemTime() - GetTask(380))


    end ;
end;

