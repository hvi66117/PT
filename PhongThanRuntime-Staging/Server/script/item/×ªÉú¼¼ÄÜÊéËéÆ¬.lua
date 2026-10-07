function no()
    CloseDialog()
end

function main()
    no()
    if (HaveNormalItem(6, 1, 1529, 1) <= 0) then
        return
    end

    local tasks = {
        "DÜ ChiÕn D­ìng ChiÕn/item_1",
        "H¹o Nhiªn ChÝnh KhÝ/item_2",
        "Cæ HoÆc Chóng Sinh/item_3",
        "HuyÕt ChiÕn Sa Tr­êng/item_4",
        "NghiÖp Ho¶ PhÇn T©m/item_5",
        "§éc Hµnh Thiªn H¹/item_6",
    }
    Say("ÇëÑ¡ÔñÏëÒªºÏ³ÉµÄ¼¼ÄÜÊéÀàÐÍ: ", table.getn(tasks), tasks)
end

function item_1()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>ÒÔÕ½ÑøÕ½<c> sao?", "item_1_Yes", "no")
    end
end

function item_1_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 959, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return
    end

    for i = 1, 50 do
        DelNormalItem(6, 1, 959, 1)
    end
    AddNormalItem(7, 61, 1482, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc ÒÔÕ½ÑøÕ½")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: ÒÔÕ½ÑøÕ½")
end

function item_2()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>ºÆÈ»ÕýÆø<c> sao?", "item_2_Yes", "no")
    end
end

function item_2_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 959, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return
    end

    for i = 1, 50 do
        DelNormalItem(6, 1, 959, 1)
    end
    AddNormalItem(7, 64, 1485, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc ºÆÈ»ÕýÆø")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: ºÆÈ»ÕýÆø")
end

function item_3()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>¹Æ»óÖÚÉú<c> sao?", "item_3_Yes", "no")
    end
end

function item_3_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 50) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>50<c> c¸i.")
        return
    end

    for i = 1, 50 do
        DelNormalItem(6, 1, 1529, 1)
    end
    AddNormalItem(7, 67, 1488, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc ¹Æ»óÖÚÉú")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: ¹Æ»óÖÚÉú")
end

function item_4()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>ÑªÕ½É³³¡<c> sao?", "item_4_Yes", "no")
    end
end

function item_4_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return
    end

    for i = 1, 30 do
        DelNormalItem(6, 1, 1529, 1)
    end
    AddNormalItem(7, 60, 1481, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc ÑªÕ½É³³¡")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: ÑªÕ½É³³¡")
end

function item_5()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>Òµ»ð·ÙÐÄ<c> sao?", "item_5_Yes", "no")
    end
end

function item_5_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return
    end

    for i = 1, 30 do
        DelNormalItem(6, 1, 1529, 1)
    end
    AddNormalItem(7, 63, 1484, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc Òµ»ð·ÙÐÄ")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: Òµ»ð·ÙÐÄ")
end

function item_6()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return

    else
        MsgBox("È·¶¨ÒªÑ¡ÔñºÏ³É<c=g>¶¾ÐÐÌìÏÂ<c> sao?", "item_6_Yes", "no")
    end
end

function item_6_Yes()
    CloseDialog()
    if (HaveNormalItem(6, 1, 1529, 1) < 30) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ M¶nh s¸ch kü n¨ng ChuyÓn sinh²»×ã<c=g>30<c> c¸i.")
        return
    end

    for i = 1, 30 do
        DelNormalItem(6, 1, 1529, 1)
    end
    AddNormalItem(7, 66, 1487, 1, 0, 0)
    Msg2Player("Ngµi nhËn ®­îc ¶¾ÐÐÌìÏÂ")
    WriteLog("M¶nh s¸ch kü n¨ng ChuyÓn sinh: ¶¾ÐÐÌìÏÂ")
end


