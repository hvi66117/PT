FunctionName = "VIP»ØÀ¡"

NitemName = "Ç±ÁúVIPÀñºÐ"
NItemid = 1380

r1ItemName = "LÔ hép Phï Th¹ch cÊp 2"
r1ItemCount = 2
r1Itemid1 = 8
r1Itemid2 = 1818
r1Itemid3 = 2

r2ItemName = "Tinh Th¸i Qu¸i Phï (ch­a mµi)"
r2ItemCount = 1
r2Itemid1 = 3
r2Itemid2 = 383
r2Itemid3 = 0

r3ItemName = "3000¹¦Ñ«»Õ¼Ç"
r3ItemCount = 1
r3Itemid1 = 6
r3Itemid2 = 1
r3Itemid3 = 1164

function main()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        Talk(1, "no", "Ç±ÁúVIPMë lÔ bao thÊt b¹i")
        return
    elseif (GetLevel() < 140) and (GetNewBirthTimes() < 1) and (GetServerStartTime() < 90) then
        Talk(1, "no", "¸ÃÀñ°üµÄ¿ªÆôÌõ¼þÎª: Çø·þ¿ªÇø90 ngµy ¼°ÒÔÉÏ, »ò¸öÈËµÈ¼¶140¼¶¼°ÒÔÉÏ.µ±Ç°Äú²»·ûºÏÌõ¼þ, ÎÞ·¨¿ªÆô¸ÃÀñ°ü")
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

    if (IsHaveSpaceForTreasure(r1ItemCount + 1 + 1) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r1ItemCount + 1 + 1) .. " « trèng.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r1ItemCount do
            AddNormalItemBind(r1Itemid1, r1Itemid2, r1Itemid3, 0, 0, 0, 1)
        end
        for i = 1, r3ItemCount do
            AddNormalItemBind(r3Itemid1, r3Itemid2, r3Itemid3, 1, 0, 0, 1)
        end
        WriteLog("[" .. FunctionName .. "][" .. NitemName .. "][" .. r1ItemName .. "][" .. r3ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r1ItemName .. r1ItemCount .. "." .. r3ItemName .. r3ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r2ItemCount + r3ItemCount + 1) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r2ItemCount + r3ItemCount + 1) .. " « trèng.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r2ItemCount do
            AddNormalItemBind(r2Itemid1, r2Itemid2, r2Itemid3, 0, 0, 0, 1)
        end
        for i = 1, r3ItemCount do
            AddNormalItemBind(r3Itemid1, r3Itemid2, r3Itemid3, 1, 0, 0, 1)
        end
        WriteLog("[" .. FunctionName .. "][" .. NitemName .. "][" .. r2ItemName .. "][" .. r3ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r2ItemName .. r2ItemCount .. "." .. r3ItemName .. r3ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
