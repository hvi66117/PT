CardIndex = 1598

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, CardIndex, 1) <= 0) then
        if (HaveNormalItem(6, 1, CardIndex, 0) > 0) then
            DelNormalItem(6, 1, CardIndex, 0)
            AddNormalItemBind(6, 1, CardIndex, 1, 0, 0, 1)
        else
            return
        end
    end

    local y, m, d = GetYMD()
    if (GetGlobalStoreValueByte(104, 1) == 0) then
        DelNormalItem(6, 1, CardIndex, 1)
        ScrollMessage("ºèÔËÀñ°üÒÑ¾­<c=r>×÷·Ï<c>ÁË")
        InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
        WriteLog("[ºèÔË¸£´ü][»î¶¯¹Ø±Õ]")
        return 0
    else
        local today = y * 10000 + m * 100 + d
        local StartStr = GetGlobalStoreValue(102)
        local EndDay = GetGlobalStoreValue(103)
        if (today < StartStr or today > EndDay) then
            DelNormalItem(6, 1, CardIndex, 1)
            ScrollMessage("ºèÔËÀñ°üÒÑ¾­<c=r>×÷·Ï<c>ÁË")
            InfoBox("»î¶¯½áÊø, Àñ°üÒÑ¾­×÷·ÏÁË!")
            WriteLog("[ºèÔË¸£´ü][»î¶¯½áÊø]")
            return 0
        end
    end

    if (GetTaskByte(2216, 3) == 0) then
        SetTaskByte(2216, 3, d)
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        Msg2Player("»î¶¯ÆÚ¼äÊ×´ÎMë ra cã thÓ nhËn ®­îc phÇn th­ëng: T­íng Qu©n LÖnh(Kho¸) 1 c¸i")
        ScrollMessage("Ê×´Î´ò¿ª»ñµÃ: <c=y>T­íng Qu©n LÖnh<c>")
    end

    local upperLimit = GetGlobalStoreValueByte(84, 3)
    if (GetTaskByte(2216, 4) >= upperLimit) then
        MsgBox("ThËt xin lçi, ±¾´Î»î¶¯ÆÚ¼äÃ¿¸ö½ÇÉ«×î¶à¿É mua " .. upperLimit .. " c¸iTinh Hoa Tiªn Sñng!\n<c=r>ÏÖÔÚ´Ë¸£´üÒÑ¾­¿ÕÁË, ÄãÊÇ·ñÏÖÔÚÒªÏú»Ù´ËÀñ°üÁË sao?<c>", "Yes_del", "no")
    else
        MsgBox("»î¶¯ÆÚ¼ä¼´¿ÉÊ®·ÖÓÅ»İµÄ¼Û¸ñ¹ºÂòµ½: \nTinh Hoa Tiªn Sñng(Kho¸) 1 c¸i : <c=y>Ô­¼Û249 Th«ng B¶oÏÖ¼Û129 Th«ng B¶o<c>\n»î¶¯ÆÚ¼äÊ×´Î¹ºÂò»¹¿É»ñµÃ<c=y>6666 v¹n<c>·âÉñ±ÒµÄ hång vËn ®­¬ng ®Çu½±Àø.Ã¿¸ö½ÇÉ«×î¶à¿É¹ºÂò<c=g>" .. upperLimit .. "<c> c¸i Tinh Hoa Tiªn Sñng!\nÄãÏÖÔÚÒª¹ºÂò sao?", "shop1", "no")
    end
end

function shop1()
    no()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(290)
    MsgBox("ÄãÏÖÔÚÈ·¶¨Òª»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o mua <c=g>Tinh Hoa Tiªn Sñng(Kho¸)<c> 1 c¸i sao?", "Yes_shop1", "no")
end

function Yes_shop1()
    no()
    local total = GetTaskByte(2216, 4) + 1
    local upperLimit = GetGlobalStoreValueByte(84, 3)
    if (total > upperLimit) then
        Talk(1, "no", "ThËt xin lçi, Ã¿¸ö½ÇÉ«×î¶à¿É mua " .. upperLimit .. " C¸i!")
        return
    end

    if (HaveNormalItem(6, 1, CardIndex, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢ºèÔË¸£´ü")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ 1 «, h·y ®Õn sau nhĞ.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(290)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, mua <c=r>Tinh Hoa Tiªn Sñng<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(290) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂòTinh Hoa Tiªn SñngÊ§°Ü!")
        return
    end

    SetTaskByte(2216, 4, total)
    AddNormalItemBind(3, 1634, 0, 0, 0, 0, 1)
    ScrollMessage("Mua ÁË: <c=y>Tinh Hoa Tiªn Sñng<c> 1 c¸i")

    if (total == 1) then
        Earn(66660000)
        Msg2Player("Äã¹ºÂòÁËTinh Hoa Tiªn Sñng 1 c¸i, »î¶¯ÆÚ¼äÊ×´Î¹ºÂò»¹¿É»ñµÃ6666Íò·âÉñ±ÒµÄ hång vËn ®­¬ng ®Çu½±Àø.")
        Talk(1, "no", "Äã»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o¹ºÂòÁË<c=g>Tinh Hoa Tiªn Sñng<c> 1 c¸i \n»î¶¯ÆÚ¼äÊ×´Î¹ºÂò»¹¿É»ñµÃ<c=y>6666Íò·âÉñ±Ò<c>µÄ hång vËn ®­¬ng ®Çu½±Àø.")
        WriteLog("[ºèÔË¸£´ü][Tinh Hoa Tiªn Sñng][Ê×´Î6666Íò·âÉñ±Ò]ÀÛ¼Æ: " .. total)
    else
        MsgBox("Äã»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o¹ºÂòÁË<c=g>Tinh Hoa Tiªn Sñng<c> 1 c¸i \nÄãÊÇ·ñ»¹Òª¼ÌĞø¹ºÂò£¿\n<c=g>È·¶¨<c>ÊÇ¹ºÂò, <c=r>È¡Ïû<c>ÊÇ¹Ø±Õ´°¿Ú", "shop1", "no")
        Msg2Player("Äã¹ºÂòÁËTinh Hoa Tiªn Sñng 1 c¸i")
        WriteLog("[ºèÔË¸£´ü][Tinh Hoa Tiªn Sñng]ÀÛ¼Æ: " .. total)
    end
end

function Yes_del()
    MsgBox("ÄãÈ·¶¨ÒªÏú»Ù´ËºèÔËÀñ°ü sao?Ïú»ÙÁË¾Í²»ÄÜÕÒ»ØÁË!", "delbag", "no")
end

function delbag()
    no()
    DelNormalItem(6, 1, CardIndex, 1)
    ScrollMessage("ºèÔËÀñ°üÒÑ¾­<c=r>Ïú»Ù<c>ÁË")
    Talk(1, "no", "ºèÔËÀñ°üÒÑ¾­Ïú»ÙÁË!")
    WriteLog("[ºèÔË¸£´ü][ÊÖ¶¯Ïú»Ù]")
end

