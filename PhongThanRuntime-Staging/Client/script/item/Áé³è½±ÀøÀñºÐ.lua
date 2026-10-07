NitemName = "Áé³è½±ÀøÀñºÐ"
NItemid = 1659

r1ItemName = "Trung KhuyÓn Tuú Chñ: Hao Thiªn KhuyÓn+D­¬ng TiÔn"
r1ItemCount = 1
r1Itemid1 = 6
r1Itemid2 = 1
r1Itemid3 = 1643

r2ItemName = "TuyÖt §¹i Song KiÒu: §¸t Kû+Hå HØ MÞ"
r2ItemCount = 1
r2Itemid1 = 6
r2Itemid2 = 1
r2Itemid3 = 1639

r3ItemName = "Y B¸t T­¬ng TruyÒn: Th¸i Êt+Na Tra"
r3ItemCount = 1
r3Itemid1 = 6
r3Itemid2 = 1
r3Itemid3 = 1640

r4ItemName = "Tinh Hoa Tiªn Sñng"
r4ItemCount = 20
r4Itemid1 = 3
r4Itemid2 = 1634
r4Itemid3 = 0

function main()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        Talk(1, "no", "Áé³è½±ÀøÀñºÐ´ò¿ªÊ§°Ü")
        return
    elseif (GetLevel() < 140) and (GetNewBirthTimes() < 1) and (GetServerStartTime() < 90) then
        Talk(1, "no", "¸ÃÀñ°üµÄ¿ªÆôÌõ¼þÎª: Çø·þ¿ªÇø90 ngµy ¼°ÒÔÉÏ, »ò¸öÈËµÈ¼¶140¼¶¼°ÒÔÉÏ.µ±Ç°Äú²»·ûºÏÌõ¼þ, ÎÞ·¨¿ªÆô¸ÃÀñ°ü")
        return
    end

    local nTask = {
        r1ItemName .. "/item_1",
        r2ItemName .. "/item_2",
        r3ItemName .. "/item_3",
        r4ItemName .. r4ItemCount .. " c¸i/item_4",
    }

    Say("ÇëÑ¡Ôñ 1 c¸i ÄúÏëÒªµÄÎïÆ·, µÀ¾ßÁìÈ¡ºó¾ùÎª°ó¶¨: ", table.getn(nTask), nTask)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r1ItemCount) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r1ItemCount) .. " « trèng.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r1ItemCount do
            AddNormalItemBind(r1Itemid1, r1Itemid2, r1Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. NitemName .. "][" .. r1ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r1ItemName .. r1ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r2ItemCount) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r2ItemCount) .. " « trèng.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r2ItemCount do
            AddNormalItemBind(r2Itemid1, r2Itemid2, r2Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. NitemName .. "][" .. r2ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r2ItemName .. r2ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function item_3()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(r3ItemCount) == 0) then
        Talk(1, "no", "Hµnh trang cÇn cã ®ñ " .. (r3ItemCount) .. " c¸i ¿Õ¸ñ.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r3ItemCount do
            AddNormalItemBind(r3Itemid1, r3Itemid2, r3Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. NitemName .. "][" .. r3ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r3ItemName .. r3ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end

function item_4()
    CloseDialog()
    if (HaveNormalItem(6, 1, NItemid, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, NItemid, 1) > 0) then
        for i = 1, r4ItemCount do
            AddNormalItemBind(r4Itemid1, r4Itemid2, r4Itemid3, 0, 0, 0, 1)
        end
        WriteLog("[" .. NitemName .. "][" .. r4ItemName .. "]")
        Msg2Player("Ngµi sö dông " .. NitemName .. ", nhËn" .. r4ItemName .. r4ItemCount .. " c¸i, xin nhËn lÊy!")
    end
end
function no()
    CloseDialog()
end
