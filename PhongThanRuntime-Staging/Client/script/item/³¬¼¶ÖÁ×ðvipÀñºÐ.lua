function main()
    if (HaveNormalItem(6, 1, 947, 1) <= 0) then
        return
    end

    local nList = {
        "ìÅ²ÊÓñĞÄ(Ch­a mµi) 3 c¸i /item_1",
        "ÔÂ»ªØÔ·û(Ch­a mµi) 3 c¸i /item_2",
        "M¶nh Vò khİ HiÕm ThÕ 75 c¸i /item_3",
    }
    Say("ÇëÑ¡Ôñ 1 c¸i ÄúÏëÒªµÄÎïÆ·: ", table.getn(nList), nList)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 947, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói ph¶i cã tèi thiÓu 3 «.")
        return
    end

    if (DelNormalItem(6, 1, 947, 1) > 0) then
        AddNormalItemBind(3, 1207, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 1207, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 1207, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][ÖÁ×ğvipÀñºĞ][ìÅ²ÊÓñĞÄ]")
        Msg2Player("Ngµi sö dông ÖÁ×ğVIPÀñºĞ, nhËn ®­îc ìÅ²ÊNgäc T©m (Ch­a mµi) 3 c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 947, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói ph¶i cã tèi thiÓu 3 «.")
        return
    end

    if (DelNormalItem(6, 1, 947, 1) > 0) then
        AddNormalItemBind(3, 392, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 392, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 392, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][ÖÁ×ğvipÀñºĞ][ÔÂ»ªØÔ·û]")
        Msg2Player("Ngµi sö dông ÖÁ×ğVIPÀñºĞ, nhËn ®­îc ÔÂ»ªØÔ·û (ch­a khai quang) 3 c¸i, xin nhËn lÊy!")
    end
end

function item_3()
    CloseDialog()
    if (HaveNormalItem(6, 1, 947, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 947, 1) > 0) then
        for i = 1, 75 do
            AddNormalItemBind(3, 1201, 0, 0, 0, 0, 1)
        end
        WriteLog("[2014vip»ØÀ¡][ÖÁ×ğvipÀñºĞ][M¶nh Vò khİ HiÕm ThÕ]")
        Msg2Player("Ngµi sö dông ÖÁ×ğVIPÀñºĞ, nhËn ®­îc M¶nh Vò khİ HiÕm ThÕ 75 c¸i, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
