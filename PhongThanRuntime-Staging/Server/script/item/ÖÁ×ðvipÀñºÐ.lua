function main()
    if (HaveNormalItem(6, 1, 946, 1) <= 0) then
        return
    end

    local nList = {
        "ìÅ²ÊÓñĞÄ(Ch­a mµi) 1 c¸i /item_1",
        "ÔÂ»ªØÔ·û(Ch­a mµi) 1 c¸i /item_2",
    }
    Say("ÇëÑ¡Ôñ 1 c¸i ÄúÏëÒªµÄÎïÆ·: ", table.getn(nList), nList)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 946, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 946, 1) > 0) then
        AddNormalItemBind(3, 1207, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][³¬¼¶×êÊ¯vipÀñºĞ][ìÅ²ÊÓñĞÄ]")
        Msg2Player("Ngµi sö dông ³¬¼¶×êÊ¯VIPÀñºĞ, nhËn ®­îc ìÅ²ÊNgäc T©m (Ch­a mµi) 1 c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 946, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 946, 1) > 0) then
        AddNormalItemBind(3, 392, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][³¬¼¶×êÊ¯vipÀñºĞ][ÔÂ»ªØÔ·û]")
        Msg2Player("Ngµi sö dông ³¬¼¶×êÊ¯VIPÀñºĞ, nhËn ®­îc ÔÂ»ªØÔ·û (ch­a khai quang) 1 c¸i, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
