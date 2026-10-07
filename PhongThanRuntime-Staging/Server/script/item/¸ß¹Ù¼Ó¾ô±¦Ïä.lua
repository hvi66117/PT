ItemName = "B¶o r­¬ng Quý Téc Hoµng Gia"
ItemID = { 6, 1, 1517, 1 }
CREDIT = 1000
BINDCOIN = 80
RewardTable = {
    [1] = { name = "1000Õ½³¡ÉùÍû" },
    [2] = { name = "Tinh Hoa Tiªn Sñng" },
}
function main(nLevel, nTime, nTNpcIdx, itemID)

    if (HaveNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) < 0) then
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        Msg2Player("ÄãµÄ±³°ü¿Õ¼ä²»×ã, ÇëÕûÀíºóÔÙ´ò¿ª±¦Ïä!")
        return
    end
    SelectItem(1)


end

function SelectItem(nIndex)
    CloseDialog()
    nIndex = nIndex + 1
    if (nIndex < 0 or nIndex > table.getn(RewardTable)) then
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        Msg2Player("ÄãµÄ±³°ü¿Õ¼ä²»×ã, ÇëÕûÀíºóÔÙ´ò¿ª±¦Ïä!")
        return
    end
    if (DelNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) > 0) then
        if (nIndex == 1) then
            AddZhanCredit()
            AddBindCoin(BINDCOIN * 100)
            Talk(1, "no", "Chóc m­õng ngµi nhËn ®­îc 80 Linh B¶o vµ 1000Õ½³¡ÉùÍû.")
        elseif (nIndex == 2) then
            AddNormalItemBind(3, 1634, 0, 0, 0, 0, 1)
            AddBindCoin(BINDCOIN * 100)
            AddZhanCredit()
            Talk(1, "no", "Chóc m­õng ngµi nhËn ®­îc 80 Linh B¶o, 1000Õ½³¡ÉùÍû vµ Tinh Hoa Tiªn Sñng.")
        end
    end
end
function AddZhanCredit()
    no()
    local addnum = CREDIT
    local credit = GetTask(1062)
    if (GetLevel() <= 80) then
        if (credit + addnum > 3000) then
            SetTask(1062, 3000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏÞ3000µã.")
            return
        else
            SetTask(1062, credit + addnum)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc Õ½³¡ÉùÍû" .. addnum .. ".")
            return
        end
    elseif (GetLevel() > 80 and GetLevel() <= 100) then
        if (credit + addnum > 10000) then
            SetTask(1062, 10000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏÞ10000µã.")
            return
        else
            SetTask(1062, credit + addnum)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc Õ½³¡ÉùÍû" .. addnum .. ".")
            return
        end
    elseif (GetLevel() > 100) then
        if (credit + addnum > 50000) then
            SetTask(1062, 50000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏÞ50000µã.")
            return
        else
            SetTask(1062, credit + addnum)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc Õ½³¡ÉùÍû" .. addnum .. ".")
            return
        end
    end
end
function no()
    CloseDialog()
end
