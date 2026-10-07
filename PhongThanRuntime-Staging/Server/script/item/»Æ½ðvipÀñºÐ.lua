function main()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    local nTask = {
        "ìÅ²ÊÓñ¾§(Ch­a mµi) 1 c¸i /item_1",
        "Tinh Th¸i Qu¸i Phï(Ch­a mµi) 1 c¸i /item_2",
    }

    Say("ÇëÑ¡Ôñ 1 c¸i ÄúÏëÒªµÄÎïÆ·: ", table.getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu ph¶i ®ñ 2 «.")
        return
    end

    if (DelNormalItem(6, 1, 943, 1) > 0) then
        AddNormalItemBind(3, 1206, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][»Æ½ðvipÀñºÐ][ìÅ²ÊÓñ¾§]")
        Msg2Player("Ngµi sö dông »Æ½ðVIPÀñºÐ, nhËn ®­îc ìÅ²ÊÓñ¾§ (ch­a khai quang) 1 c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 943, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu ph¶i ®ñ 2 «.")
        return
    end

    if (DelNormalItem(6, 1, 943, 1) > 0) then
        AddNormalItemBind(3, 383, 0, 0, 0, 0, 1)
        WriteLog("[2014vip»ØÀ¡][»Æ½ðvipÀñºÐ][Tinh Th¸i Qu¸i Phï]")
        Msg2Player("Ngµi sö dông »Æ½ðVIPÀñºÐ, nhËn ®­îc Tinh Th¸i Qu¸i Phï (ch­a khai quang) 1 c¸i, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
