Task_Dur = 981;

function main()
    local mapname = {
        [19] = "TuyÖt Long lÜnh"
    }
    local lightname = {
        [1] = "<color=Earth>¸nh s¸ng yÕu<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }
    local maptask = GetTask(381)
    local mapid, x1, y1 = GetWorldPos()
    if (GetTask(Task_Dur) == 2) then
        if (maptask ~= mapid) then
            Talk(1, "no", "Kú L©n phæ- ghi l¹i vÞ trÝ kho b¸u, h×nh nh­ ®ang <color = red>" .. mapname[maptask] .. "<c>!")
            return
        end
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
        if (light == 4) and (lastdist ~= 0) then
            msg = msg .. ", B¶o tµng h×nh nh­ ®ang ë gÇn ®©y, h·y thö vËn may cña m×nh xem!"
            MsgBox(msg, "wabao", "no")
        else
            if (lastdist == 0) then
                msg = msg .. ", B¶o tµng h×nh nh­ ë ngay trong khu vùc nµy!"
            elseif (lastdist < distance) then
                msg = msg .. ", ÄãËÆºõ<color=red>Ô¶Àë<color>±¦²Ø"
            else
                msg = msg .. ", ÄãËÆºõ<color=green>½Ó½ü<color>±¦²Ø"
            end ;
            TopMessage(msg)
        end ;
        SetTask(378, distance)
    else
        if (HaveNormalItem(6, 1, 263, 0) >= 1) then
            DelNormalItem(6, 1, 263, 0)
            Talk(1, "no", 13226)
        elseif (HaveNormalItemInQuick(6, 1, 263, 0) >= 1) then
            DelNormalItemInQuick(6, 1, 263, 0)
            Talk(1, "no", 13226)
        end
    end


end

function no()
    CloseDialog()
end;
function wabao()

    if (GetTask(382) == 0) or (GetTask(383) == 0) then
        no()
        return
    end

    if (HaveNormalItem(6, 1, 263, 0) >= 1) then
        DelNormalItem(6, 1, 263, 0)
    elseif (HaveNormalItemInQuick(6, 1, 263, 0) >= 1) then
        DelNormalItemInQuick(6, 1, 263, 0)
    end
    SetTask(Task_Dur, 0)
    SetTask(378, 0)
    SetTask(381, 0)
    SetTask(382, 0)
    SetTask(383, 0)
    TaskNote(63, 4)
    local k = math.random(1, 100)
    local ntimes = GetTask(1030)
    if (ntimes <= 50) then
        if (k <= 45) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                end
                Talk(1, "no", 13227)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                Talk(1, "no", 13228)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        elseif (k <= 97) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13229)
            else
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13230)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        else
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13231)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13232)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(555, 80, SubWorld, x * 32, y * 32)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> trong lóc ®i t×m Long Ch©u, ®· may m¾n t×m thÊy B¨ng Long Ch©u vµ HáaLong Ch©u!")
            AddGlobalCountNews(GetName() .. "Trong lóc b¹n t×m Long Ch©u ®· v« t×nh ®¸nh thøc Chóc Long. NÕu kh«ng kÞp thêi dËp löa, e nh©n gian sÏ thªm 1 lÇn ®¹i n¹n!", 3)
        end
    elseif (ntimes <= 100) then
        if (k <= 47) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                end
                Talk(1, "no", 13227)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                Talk(1, "no", 13228)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        elseif (k <= 97) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13229)
            else
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13230)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        else
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13231)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13232)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(555, 80, SubWorld, x * 32, y * 32)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> trong lóc ®i t×m Long Ch©u, ®· may m¾n t×m thÊy B¨ng Long Ch©u vµ HáaLong Ch©u!")
            AddGlobalCountNews(GetName() .. "Trong lóc b¹n t×m Long Ch©u ®· v« t×nh ®¸nh thøc Chóc Long. NÕu kh«ng kÞp thêi dËp löa, e nh©n gian sÏ thªm 1 lÇn ®¹i n¹n!", 3)
        end
    elseif (ntimes <= 200) then
        if (k <= 48) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13229)
            else
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13230)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        elseif (k <= 97) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                end
                Talk(1, "no", 13227)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                Talk(1, "no", 13228)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        else
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13231)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13232)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(555, 80, SubWorld, x * 32, y * 32)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> trong lóc ®i t×m Long Ch©u, ®· may m¾n t×m thÊy B¨ng Long Ch©u vµ HáaLong Ch©u!")
            AddGlobalCountNews(GetName() .. "Trong lóc b¹n t×m Long Ch©u ®· v« t×nh ®¸nh thøc Chóc Long. NÕu kh«ng kÞp thêi dËp löa, e nh©n gian sÏ thªm 1 lÇn ®¹i n¹n!", 3)
        end
    elseif (ntimes > 200) then
        local Num = math.random(1, 200)
        if (Num <= 97) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                end
                Talk(1, "no", 13227)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                Talk(1, "no", 13228)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        elseif (Num <= 194) then
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13229)
            else
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13230)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(557, 80, SubWorld, x * 32, y * 32)
        else
            if (GetWeekDay() == 7) then

                Msg2Player("H«m nµy lµ chñ ®Ò B¨ng Háa Long Ch©u, hoµn thµnh nhiÖm vô B¨ng Háa Long Ch©u nhËn phÇn th­ëng x2! ")
                local nDoubel = 2
                local nDoubleBuff = 1480

                if (HaveIBBuff(1523) > 0) then
                    nDoubel = nDoubel + 1
                    CostIBBuff(1523, 1)
                    Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                end

                local bHaveBuff = HaveIBBuff(nDoubleBuff)
                local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                    nDoubel = nDoubel + nBuffLevel
                    Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                end
                for i = 1, nDoubel do
                    AddNormalItemPile(3, 124, 0, 0, 0, 0)
                    AddNormalItemPile(3, 125, 0, 0, 0, 0)
                end
                Talk(1, "no", 13231)
            else
                AddNormalItemPile(3, 124, 0, 0, 0, 0)
                AddNormalItemPile(3, 125, 0, 0, 0, 0)
                Talk(1, "no", 13232)

            end
            local w, x, y = GetWorldPos()
            local newnpcidx = AddNpc(555, 80, SubWorld, x * 32, y * 32)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> trong lóc ®i t×m Long Ch©u, ®· may m¾n t×m thÊy B¨ng Long Ch©u vµ HáaLong Ch©u!")
            AddGlobalCountNews(GetName() .. "Trong lóc b¹n t×m Long Ch©u ®· v« t×nh ®¸nh thøc Chóc Long. NÕu kh«ng kÞp thêi dËp löa, e nh©n gian sÏ thªm 1 lÇn ®¹i n¹n!", 3)
        end
    end
end
