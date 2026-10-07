require("Ê®ÖÜÄê»î¶¯.luax")

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        if (HaveNormalItem(6, 1, 1566, 0) > 0) then
            DelNormalItem(6, 1, 1566, 0)
            AddNormalItemBind(6, 1, 1566, 1, 0, 0, 1)
        else
            return
        end
    end

    if (TENYEAR.Pub_IsTENYEAR(1) < 1) then
        DelNormalItem(6, 1, 1566, 1)
        InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
        WriteLog("[ThËp Chu Niªn][ÖÜÄê¸Ğ¶÷ÀñºĞ][ÊÕ»Ø]")
        return 0
    end

    local tasks = {
        { "ThËp Chu Niªn¡¤¸Ğ¶÷", "freeGift"; show = 1 },
        { "ThËp Chu NiªnÀñ¡¤Ò»", "shop1"; show = 1 },
        { "ThËp Chu NiªnÀñ¡¤¶ş", "shop2"; show = 1 },
        { "ThËp Chu NiªnÀñ¡¤Èı", "shop3"; show = 1 },
        { "ThËp Chu NiªnÀñ¡¤ËÄ", "shop4"; show = 1 },
    }
    SayTask("Phong ThÇn ThËp Chu Niªn, ¸Ğ¶÷ËÍºÃÀñ.\n7ÔÂ18ÈÕ~7ÔÂ31ÈÕ, nhÊp vµo ÏÂ·½[ThËp Chu Niªn¡¤¸Ğ¶÷]lµ cã thÓ nhËn ThÇn T­íng Dô LÖnh*2+1 ngµy Ö÷ÌâÈÕË«±¶buff.Ã¿ÌìÏŞÁì1´Î.\n¸üÓĞ³¬ÖµThËp Chu NiªnÀñ°ü¿É¹©Äú¹ºÂò, ·è¿ñÓÅ»İ²»ÏŞÁ¿!", tasks)
end

function freeGift()
    MsgBox("Mçi ngµy chØ cã thÓ 1 lÇn, ¿ÉÃâ·ÑÁìÈ¡ThÇn T­íng Dô LÖnh*2+24 giêÖ÷ÌâÈÕË«±¶, ÄãÏÖÔÚÒªÊ¹ÓÃÃ´?", "Yes_Item", "main")
end

function Yes_Item()
    no()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ÖÜÄê¸Ğ¶÷Àñ")
        return
    end

    local nYear, nMon, nDay = GetYMD()
    if (GetTaskByte(2187, 2) == nDay) then
        Talk(1, "no", "ThËt xin lçi, ÖÜÄê¸Ğ¶÷Àñ mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
        return
    end
    SetTaskByte(2187, 2, nDay)

    for i = 1, 2 do
        AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
    end
    local nLeftTime = GetIBBuffLeftTimes(1480)
    RemoveIBBuff(1480)
    AddIBBuff(1480, nLeftTime + 24 * 3600)
    Msg2Player("Më ÖÜÄê¸Ğ¶÷Àñ nhËn ®­îc 2 c¸i ThÇn T­íng Dô LÖnh vµ 24 giê tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
    InfoBox("Ngµi nhËn ®­îc 2 c¸i ThÇn T­íng Dô LÖnh vµ 24 giê tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy!")
    WriteLog("[ThËp Chu Niªn][ÖÜÄê¸Ğ¶÷Àñ][tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy]Ô­: " .. nLeftTime)
end

function shop1()
    MsgBox("ThËp Chu NiªnÀñ¡¤Ò»: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Vò khİ Tinh Hoa (cao)\n<c=y>Ô­¼Û739 Th«ng B¶oÏÖ¼Û459 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop1", "main")
end

function Yes_shop1()
    no()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ÖÜÄê¸Ğ¶÷Àñ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(284)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ThËp Chu NiªnÀñ¡¤Ò»<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(284) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòThËp Chu NiªnÀñ¡¤Ò»Ê§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 372, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËThËp Chu NiªnÀñ¡¤Ò», nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Hoa (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËThËp Chu NiªnÀñ¡¤Ò», nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Hoa (cao) 1 c¸i.")
    WriteLog("[ThËp Chu Niªn][ThËp Chu NiªnÀñÒ»]")
end

function shop2()
    MsgBox("ThËp Chu NiªnÀñ¡¤¶ş: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Trang bŞ Tinh Hoa (cao)\n<c=y>Ô­¼Û639 Th«ng B¶oÏÖ¼Û399 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop2", "main")
end

function Yes_shop2()
    no()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ÖÜÄê¸Ğ¶÷Àñ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(285)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ThËp Chu NiªnÀñ¡¤¶ş<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(285) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòThËp Chu NiªnÀñ¡¤¶şÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 373, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËThËp Chu NiªnÀñ¡¤¶ş, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Hoa (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËThËp Chu NiªnÀñ¡¤¶ş, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Hoa (cao) 1 c¸i.")
    WriteLog("[ThËp Chu Niªn][ThËp Chu NiªnÀñ¶ş]")
end

function shop3()
    MsgBox("ThËp Chu NiªnÀñ¡¤Èı: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Vò khİ Tinh Nguyªn (cao)\n<c=y>Ô­¼Û439 Th«ng B¶oÏÖ¼Û279 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop3", "main")
end

function Yes_shop3()
    no()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ÖÜÄê¸Ğ¶÷Àñ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(286)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ThËp Chu NiªnÀñ¡¤Èı<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(286) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòThËp Chu NiªnÀñ¡¤ÈıÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 283, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËThËp Chu NiªnÀñ¡¤Èı, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Nguyªn (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËThËp Chu NiªnÀñ¡¤Èı, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Nguyªn (cao) 1 c¸i.")
    WriteLog("[ThËp Chu Niªn][ThËp Chu NiªnÀñÈı]")
end

function shop4()
    MsgBox("ThËp Chu NiªnÀñ¡¤ËÄ: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Trang bŞ Tinh Nguyªn (cao) \n<c=y>Ô­¼Û339 Th«ng B¶oÏÖ¼Û219 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop4", "main")
end

function Yes_shop4()
    no()
    if (HaveNormalItem(6, 1, 1566, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ÖÜÄê¸Ğ¶÷Àñ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(287)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ThËp Chu NiªnÀñ¡¤ËÄ<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(287) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòThËp Chu NiªnÀñ¡¤ËÄÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 284, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËThËp Chu NiªnÀñ¡¤ËÄ, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Nguyªn (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËThËp Chu NiªnÀñ¡¤ËÄ, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Nguyªn (cao) 1 c¸i.")
    WriteLog("[ThËp Chu Niªn][ThËp Chu NiªnÀñËÄ]")
end
