require("Ë«11»î¶¯.luax")
CardName = "Ë«Ê®Ò»¹ºÎï¿¨"
Item_Id = { 6, 1, 1531, 1 }

function main(nLevel, t, nNpcIdx, nItemId)

    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (DOUBLE11.Pub_IsShoppingCard() <= 0) then
        Talk(1, "no", "»î¶¯Ê±¼äÒÑ¹ı, ÇëÏÂ´Î»î¶¯Ê±ÔÙÊ¹ÓÃ°É.")
        DelNormalItem(Item_Id[1], Item_Id[2], Item_Id[3], Item_Id[4])
        return
    end

    local info = "Ë«Ê®Ò»²»¹Âµ¥, ³¬ÖµÌØÂô´ó¿ñ»¶!Ó¢ĞÛ¿´¿´ÓĞÊ²Ã´ĞèÒªµÄÂğ: "
    local betton = "<c=orange>1111ÏŞÊ±ÇÀ<c>"
    if (GetTaskByte(2166, 3) == 1 and GetTaskByte(2166, 4) == 1) then
        betton = "1111ÏŞÊ±ÇÀ"
    end
    local menu = {
        { betton, "LimitBuy"; show = 1 },
        { "Ô¸Íû¿¨»î¶¯", "WishCardInfo"; show = 1 },
        { "Méc Nh©n1Ôª", "ReliefWoodenInfo"; show = 1 },
        { "×øÆìË«±¶¾­Ñé", "FlagDoubleInfo"; show = 1 },
    }
    SayTask(info, menu)
end
function LimitBuy()
    local info = "ÒÔÏÂÀñ°ü½öÏŞÊ¹ÓÃÍ¨±¦¹ºÂò, ÇÒÃ¿ÈËÃ¿ÑùÏŞ¹º 1 c¸i (Àñ°ü vµ Àñ°üÄÚÎïÆ·¾ùÎª°ó¶¨): \n<c=orange>Ë«Ê®Ò»Àñ´ü<c>: bªn trong chøa <c=g>T­íng Qu©n LÖnh*3+Vi Quang Qu¸i Phï*1<c> ½öÊÛ<c=orange>11.11 Th«ng B¶o<c>.\n<c=orange>Ë«Ê®Ò»ÀñºĞ<c>: bªn trong chøa <c=g>T­íng Qu©n LÖnh*33+Tinh Th¸i Qu¸i Phï*1<c> ½öÊÛ<c=orange>111.1 Th«ng B¶o<c>."
    local menu = {
        { "Ë«Ê®Ò»Àñ´ü", "Bag11"; show = 1 },
        { "Ë«Ê®Ò»ÀñºĞ", "Box11"; show = 1 },
    }
    SayTask(info, menu)
end
function Bag11()
    local YY, MM, DD = GetYMD()
    if (GetTaskByte(2166, 3) == 1) then
        Talk(1, "no", "»î¶¯ÆÚ¼äÖ»ÄÜ¹ºÂò 1 c¸i Ë«Ê®Ò»Àñ´ü, ÄúÒÑ¾­¹ºÂò¹ıÁË.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(275)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, mua <c=y>" .. Cname .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    MsgBox("Mua <c=y>" .. Cname .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, È·¶¨¹ºÂò sao?", "Bag11_Pay", "no")
end
function Bag11_Pay()
    if (CostCoinByIdx(275) ~= 0) then
        SetTaskByte(2166, 3, 1)
        AddNormalItemBind(6, 1, 1532, 1, 0, 0, 1)
        Talk(1, "no", "NhËn ®­îc Ë«Ê®Ò»Àñ´ü.")
        WriteLog("[Ë«Ê®Ò»Àñ´ü][¹ºÂò³É¹¦]")
    else
        Talk(1, "no", "ThËt xin lçi, khÊu trõ Th«ng B¶o thÊt b¹i.")
        WriteLog("[Ë«Ê®Ò»Àñ´ü][khÊu trõ Th«ng B¶o thÊt b¹i]")
    end
end

function Box11()
    local YY, MM, DD = GetYMD()
    if (GetTaskByte(2166, 4) == 1) then
        Talk(1, "no", "»î¶¯ÆÚ¼äÖ»ÄÜ¹ºÂò 1 c¸i Ë«Ê®Ò»ÀñºĞ, ÄúÒÑ¾­¹ºÂò¹ıÁË.")
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(276)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, mua <c=y>" .. Cname .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    MsgBox("Mua <c=y>" .. Cname .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, È·¶¨¹ºÂò sao?", "Box11_Pay", "no")

end
function Box11_Pay()
    if (CostCoinByIdx(276) ~= 0) then
        SetTaskByte(2166, 4, 1)
        AddNormalItemBind(6, 1, 1533, 1, 0, 0, 1)
        Talk(1, "no", "NhËn ®­îc Ë«Ê®Ò»ÀñºĞ.")
        WriteLog("[Ë«Ê®Ò»ÀñºĞ][¹ºÂò³É¹¦]")
    else
        Talk(1, "no", "ThËt xin lçi, khÊu trõ Th«ng B¶o thÊt b¹i.")
        WriteLog("[Ë«Ê®Ò»ÀñºĞ][khÊu trõ Th«ng B¶o thÊt b¹i]")
    end
end

function no()
    CloseDialog()
end;
function WishCardInfo()
    no()
    local str = "11ÔÂ11ÈÕÖÁ17ÈÕ, Ã¿Íí20:00-20:05·Ö, 30¼¶ÒÔÉÏÍæ¼Ò´òËÀÈÎÒâÒ»Ö»¹Ölµ cã thÓ nhËn ¡°B¶o r­¬ng Phóc vËn¡±, më B¶o r­¬ng Phóc vËn cã c¬ héi nhËn ®­îc<c=g>Tinh Th¸i Qu¸i Phï (Kh«ng kho¸), Vi Quang Qu¸i Phï (Kh«ng kho¸), M¶nh Phï Th¹ch, Ngo¹i trang Linh Khİ<c>Å¶~\n<c=orange>µÚÎå´Î¿ªÆô¡°B¶o r­¬ng Phóc vËn¡±Ê±lµ cã thÓ nhËn [Hoµng Kim Quang C«n]¼×¹Ç!<c>"
    Talk(1, "no", str)
end
function ReliefWoodenInfo()
    no()
    local str = "11ÔÂ11ÈÕÖÁ11ÔÂ17ÈÕ, Ã¿ÌìÔÚ[Ì«ËêÊ¦]´¦Ê×´ÎÊ¹ÓÃÍ¨±¦Ö±½ÓÊ¹ÓÃ<c=g>[Méc Nh©n]<c>Ê±, Ö»ĞèÏûºÄ<c=r>1 Th«ng B¶o<c>¼´¿ÉÊ¹ÓÃÔ­±¾¼ÛÖµ<c=r>3 Th«ng B¶o<c>µÄ[Méc Nh©n]×ª¶¯Vßng th¸i tuÕ."
    Talk(1, "no", str)
end
function FlagDoubleInfo()
    no()
    local str = "11ÔÂ11ÈÕÖÁ11ÔÂ17ÈÕ, ½øĞĞ¡°<c=g>Õ°ÑöìºÆì<c>¡±ÏíÊÜ<c=r>»î¶¯¾­Ñé·­±¶<c>."
    Talk(1, "no", str)
end
