ItemName = "Ê¥¶÷ÆÕÕÕÀñ°ü"
ItemID = { 6, 1, 1518, 1 }
CREDIT = 300

function main(nLevel, nTime, nTNpcIdx, itemID)

    if (HaveNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) < 0) then
        return
    end
    if (IsHaveSpaceForTreasure(2) == 0) then
        Msg2Player("ÄãµÄ±³°ü¿Õ¼ä²»×ã, ÇëÕûÀíºóÔÙ´ò¿ª±¦Ïä!")
        return
    end
    if (DelNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) > 0) then
        for i = 1, 20 do
            AddNormalItemBind(6, 1, 1062, 1, 0, 0, 1)
        end
        AddZhanCredit()
        Msg2Player("Chóc mõng ngµi më " .. ItemName .. " nhËn ®­îc Kinh NghiÖm §¬n*20 vµ 300Õ½³¡ÉùÍû.")
    else
        Talk(1, "no", "Më lÔ bao thÊt b¹i.")
    end
end
function AddZhanCredit()
    no()
    local addnum = CREDIT
    local credit = GetTask(1062)
    if (GetLevel() <= 80) then
        if (credit + addnum > 3000) then
            SetTask(1062, 3000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏŞ 3000 ®iÓm.")
            return
        else
            SetTask(1062, credit + addnum)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc Õ½³¡ÉùÍû" .. addnum .. ".")
            return
        end
    elseif (GetLevel() > 80 and GetLevel() <= 100) then
        if (credit + addnum > 10000) then
            SetTask(1062, 10000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏŞ 10000 ®iÓm.")
            return
        else
            SetTask(1062, credit + addnum)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc Õ½³¡ÉùÍû" .. addnum .. ".")
            return
        end
    elseif (GetLevel() > 100) then
        if (credit + addnum > 50000) then
            SetTask(1062, 50000)
            Msg2Player("Äãµ±Ç°µÄÕ½³¡ÉùÍûÒÑ¾­´ïµ½ÉÏÏŞ 50000 ®iÓm.")
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
