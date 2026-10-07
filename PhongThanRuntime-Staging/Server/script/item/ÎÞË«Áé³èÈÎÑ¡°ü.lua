FunctionName = "2015VIP»ØÀ¡"

NitemName = "ÎÞË«Áé³èÈÎÑ¡°ü"
NItemid = 1388

r1ItemName = "Áé³è±äÉí·û-ÎÞË«"
r1ItemCount = 1
r1Itemid1 = 6
r1Itemid2 = 1
r1Itemid3 = 1392

r2ItemName = "Áé³è±äÉí·û-Hå HØ MÞ"
r2ItemCount = 1
r2Itemid1 = 6
r2Itemid2 = 1
r2Itemid3 = 1339

function main()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    local nTask = {
        r1ItemName .. r1ItemCount .. " c¸i/item_1",
        r2ItemName .. r2ItemCount .. " c¸i/item_2",
    }

    Say("ÇëÑ¡Ôñ 1 c¸i ÄúÏëÒªµÄÎïÆ·, µÀ¾ßÁìÈ¡ºó¾ùÎª°ó¶¨: ", table.getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r1ItemCount + 1) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r1ItemCount + 1) .. " « trèng.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r1ItemCount do
            AddNormalItemBind(r1Itemid1, r1Itemid2, r1Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. FunctionName .. "][" .. NitemName .. "][" .. r1ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r1ItemName .. r1ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r2ItemCount + 1) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r2ItemCount + 1) .. " c¸i ¿Õ¸ñ.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r2ItemCount do
            AddNormalItemBind(r2Itemid1, r2Itemid2, r2Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. FunctionName .. "][" .. NitemName .. "][" .. r2ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r2ItemName .. r2ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
