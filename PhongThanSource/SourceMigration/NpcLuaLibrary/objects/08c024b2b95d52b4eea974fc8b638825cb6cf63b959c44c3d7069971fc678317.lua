function main()
    if (HaveNormalItem(6, 1, 1060, 1) <= 0) then
        return
    end

    local nTask = {
        "Ñ×÷ëChİ T«n¡¤½ğÅÛ·ïÒÂ/item_1",
        "Áé³èĞşÎäÉñÊŞ±äÉí·û/item_2",
    }

    Say("ÇëÑ¡ÔñÄúÏëÒªµÄÎïÆ·ÀàĞÍ: ", table.getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1060, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 1060, 1) > 0) then
        AddNormalItemBind(6, 1, 1061, 0, 0, 0, 1)
        WriteLog("Më vip»ØÀ¡LÔ bao Chİ T«n: Ñ×÷ëChİ T«n¡¤½ğÅÛ·ïÒÂ")
        Msg2Player("Ngµi sö dông Chİ T«nVIP»ØÀ¡Àñ°ü, nhËn ®­îc 1 c¸i Ñ×÷ëChİ T«n¡¤½ğÅÛ·ïÒÂ, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1060, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 1060, 1) > 0) then
        AddNormalItemBind(8, 1618, 2, 0, 0, 0, 1)
        WriteLog("Më vip»ØÀ¡LÔ bao Chİ T«n: Áé³èĞşÎäÉñÊŞ±äÉí·û")
        Msg2Player("Ngµi sö dông Chİ T«nVIP»ØÀ¡Àñ°ü, nhËn ®­îc 1 c¸i Áé³èĞşÎäÉñÊŞ±äÉí·û, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
