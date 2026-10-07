function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        if (HaveNormalItem(6, 1, 1597, 0) > 0) then
            DelNormalItem(6, 1, 1597, 0)
            AddNormalItemBind(6, 1, 1597, 1, 0, 0, 1)
        else
            return
        end
    end

    if (GetGlobalStoreValueByte(101, 1) == 0) then
        DelNormalItem(6, 1, 1597, 1)
        InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
        WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][»î¶¯¹Ø±Õ]")
        return 0
    else
        local y, m, d = GetYMD()
        local today = y * 10000 + m * 100 + d
        local StartStr = GetGlobalStoreValue(99)
        local EndDay = GetGlobalStoreValue(100)
        if (today < StartStr or today > EndDay) then
            DelNormalItem(6, 1, 1597, 1)
            InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
            WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][»î¶¯½áÊø]")
            return 0
        end
    end

    local tasks = {
        { "¸Ğ¶÷ÖúÕ½Àñ", "freeGift"; show = 1 },
        { "ÖúÕ½Àñ¡¤Ò»", "shop1"; show = 1 },
        { "ÖúÕ½Àñ¡¤¶ş", "shop2"; show = 1 },
        { "ÖúÕ½Àñ¡¤Èı", "shop3"; show = 1 },
        { "ÖúÕ½Àñ¡¤ËÄ", "shop4"; show = 1 },
    }
    SayTask("¸Ğ¶÷ÖúÕ½ËÍºÃÀñ¡;î¶¯ÆÚ¼ä, 45¼¶ÒÔÉÏÍæ¼Ò, nhÊp vµo ÏÂ·½[¸Ğ¶÷ÖúÕ½Àñ]¼´¿É<c=g>Ãâ·ÑÁìÈ¡<c>\nThÇn T­íng Dô LÖnh*2+1 ngµy  tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.Ã¿ÌìÏŞÁì1´Î.\n¸üÓĞ³¬Öµ¸Ğ¶÷ÖúÕ½Àñ°ü¿É¹©Äú¹ºÂò, ·è¿ñÓÅ»İ²»ÏŞÁ¿!", tasks)
end

function freeGift()
    MsgBox("<c=y>Mçi ngµy chØ cã thÓ 1 lÇn<c>, ¿ÉÃâ·ÑÁìÈ¡: ThÇn T­íng Dô LÖnh*2+24 giê tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy, ÄãÏÖÔÚÒªÊ¹ÓÃÃ´?", "Yes_Item", "main")
end

function Yes_Item()
    no()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ")
        return
    end

    if (GetLevel() < 45) and (GetNewBirthTimes() < 1) then
        Talk(1, "no", "ThËt xin lçi, ÄãµÈ¼¶²»×ã45¼¶.")
        return
    end

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (GetTaskByte(2193, 3) == today) then
        Talk(1, "no", "ThËt xin lçi, ¸Ğ¶÷ÖúÕ½ÀñºĞ mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
        return
    end
    SetTaskByte(2193, 3, today)
    local ncishu = GetTaskByte(2193, 4) + 1
    if (ncishu <= 255) then
        SetTaskByte(2193, 4, ncishu)
    else
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ,ÁìÈ¡³¬¹ı255´Î")
        return
    end

    for i = 1, 2 do
        AddNormalItemBind(3, 1637, 0, 0, 0, 0, 1)
    end
    local nBuffLevel = GetIBBuffLevel(1480) + 1
    local nLeftTime = GetIBBuffLeftTimes(1480)
    RemoveIBBuff(1480)
    AddIBBuff(1480, nLeftTime + 24 * 3600)
    Msg2Player("Më ¸Ğ¶÷ÖúÕ½ÀñºĞ nhËn ®­îc 2 c¸i ThÇn T­íng Dô LÖnh vµ 24 giê tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy.")
    InfoBox("Ngµi nhËn ®­îc 2 c¸i ThÇn T­íng Dô LÖnh vµ 24 giê tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy!")
    WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ]ThÇn T­íng Dô LÖnh*2+[tr¹ng th¸i gÊp ®«i chñ ®Ò ngµy]Ô­Ê£ÓàÊ±¼ä: " .. nLeftTime .. "s µÈ¼¶: " .. nBuffLevel)
end

function shop1()
    MsgBox("ÖúÕ½Àñ¡¤Ò»: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Vò khİ Tinh Hoa (cao)\n<c=y>Ô­¼Û739 Th«ng B¶oÏÖ¼Û459 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop1", "main")
end

function Yes_shop1()
    no()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(284)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ÖúÕ½Àñ¡¤Ò»<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(284) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÖúÕ½Àñ¡¤Ò»Ê§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 372, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÖúÕ½Àñ¡¤Ò», nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Hoa (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËÖúÕ½Àñ¡¤Ò», nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Hoa (cao) 1 c¸i.")
    WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][ÖúÕ½ÀñÒ»]")
end

function shop2()
    MsgBox("ÖúÕ½Àñ¡¤¶ş: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Trang bŞ Tinh Hoa (cao)\n<c=y>Ô­¼Û639 Th«ng B¶oÏÖ¼Û399 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop2", "main")
end

function Yes_shop2()
    no()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(285)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ÖúÕ½Àñ¡¤¶ş<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(285) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÖúÕ½Àñ¡¤¶şÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 373, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÖúÕ½Àñ¡¤¶ş, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Hoa (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËÖúÕ½Àñ¡¤¶ş, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Hoa (cao) 1 c¸i.")
    WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][ÖúÕ½Àñ¶ş]")
end

function shop3()
    MsgBox("ÖúÕ½Àñ¡¤Èı: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Vò khİ Tinh Nguyªn (cao)\n<c=y>Ô­¼Û439 Th«ng B¶oÏÖ¼Û279 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop3", "main")
end

function Yes_shop3()
    no()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(286)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ÖúÕ½Àñ¡¤Èı<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(286) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÖúÕ½Àñ¡¤ÈıÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 283, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÖúÕ½Àñ¡¤Èı, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Nguyªn (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËÖúÕ½Àñ¡¤Èı, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Vò khİ Tinh Nguyªn (cao) 1 c¸i.")
    WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][ÖúÕ½ÀñÈı]")
end

function shop4()
    MsgBox("ÖúÕ½Àñ¡¤ËÄ: Vi Quang Qu¸i Phï + T­íng Qu©n LÖnh*3 + Trang bŞ Tinh Nguyªn (cao) \n<c=y>Ô­¼Û339 Th«ng B¶oÏÖ¼Û219 Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop4", "main")
end

function Yes_shop4()
    no()
    if (HaveNormalItem(6, 1, 1597, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢¸Ğ¶÷ÖúÕ½ÀñºĞ")
        return
    end

    if (IsHaveSpaceForTreasure(4) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã3¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(287)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>ÖúÕ½Àñ¡¤ËÄ<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(287) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÖúÕ½Àñ¡¤ËÄÊ§°Ü!")
        return
    end

    for i = 1, 3 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 284, 2, 0, 0, 0, 1)
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁËÖúÕ½Àñ¡¤ËÄ, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Nguyªn (cao) 1 c¸i.")
    Msg2Player("Äã¹ºÂòÁËÖúÕ½Àñ¡¤ËÄ, nhËn ®­îc Vi Quang Qu¸i Phï 1 c¸i, T­íng Qu©n LÖnh 3 c¸i ÒÔ¼°Trang bŞ Tinh Nguyªn (cao) 1 c¸i.")
    WriteLog("[¸Ğ¶÷ÖúÕ½ÀñºĞ][ÖúÕ½ÀñËÄ]")
end
