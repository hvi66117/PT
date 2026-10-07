require("Ê®ÖÜÄê»î¶¯.luax")

g_ItemList = {
    [1] = { name = "§Æc QuyÒn B¹ch Hæ¿¨(7 ngµy)", ID = { 6, 1, 1304, 1 }, count = 1, needSpace = 1 },
    [2] = { name = "ThÎ Kim DËt*1", ID = { 8, 1316, 6, 0 }, count = 1, needSpace = 1 },
    [3] = { name = "T­íng Qu©n LÖnh*3", ID = { 3, 100, 0, 0 }, count = 3, needSpace = 1 },
    [4] = { name = "Vi Quang Qu¸i Phï(Ch­a mµi)*1", ID = { 3, 374, 0, 0 }, count = 1, needSpace = 1 },
    [5] = { name = "Cöu Tiªu Long Ng©m Trang", ID = { 6, 1, 906, 1 }, count = 1, needSpace = 2 },
}

function main(itemID)
    no()
    if (HaveNormalItem(6, 1, 1568, 1) <= 0) then
        if (HaveNormalItem(6, 1, 1568, 0) > 0) then
            DelNormalItem(6, 1, 1568, 0)
            AddNormalItemBind(6, 1, 1568, 1, 0, 0, 1)
        else
            InfoBox("ThËt xin lçi, »Ø¹éÀñºĞÎŞ·¨´ò¿ª!")
            WriteLog("[ThËp Chu Niªn][»Ø¹éÀñºĞ][ThÊt b¹i]")
            return
        end
    end

    if (TENYEAR.Pub_IsTENYEAR(3) < 1) then
        DelNormalItem(6, 1, 1568, 1)
        InfoBox("»î¶¯½áÊø, »Ø¹éÀñºĞÒÑ¾­×÷·ÏÁË!")
        WriteLog("[ThËp Chu Niªn][»Ø¹éÀñºĞ][ÊÕ»Ø]")
        return 0
    end

    if (GetTaskBit(2186, 2) == 0) then
        Talk(1, "no", "ThËt xin lçi, Äã²»ÊÇ»Ø¹éÕß, »Ø¹éÀñºĞ×÷·Ï±»ÊÕ»Ø!")
        DelNormalItem(6, 1, 1568, 1)
        WriteLog("[ThËp Chu Niªn][»Ø¹éÀñºĞ][Òì³;îÔ¾ÕßÊÕ»Ø]")
        return 0
    end

    local nLeftTimes = GetTaskByte(2186, 3) + 1
    if (nLeftTimes > table.getn(g_ItemList)) then
        DelNormalItem(6, 1, 1568, 1)
        InfoBox("ThËt xin lçi, »Ø¹éÀñºĞÒÑ¾­Ê¹ÓÃÁË<c=r>5´Î<c>, ¸ÃÀñºĞ1 ngµy ¿ÉÊ¹ÓÃÒ»´Î, Ò»¹²¿ÉÊ¹ÓÃ5´Î, sö dông 5´Î»òÀñºĞµ½ÆÚºó¸ÃÀñºĞ½«ÏûÊ§!")
        WriteLog("[ThËp Chu Niªn][»Ø¹éÀñºĞ][ÊÕ»Ø]")
        return 0
    end

    local nYear, nMon, nDay = GetYMD()
    if (GetTaskByte(2186, 2) == nDay) then
        Talk(1, "no", "ThËt xin lçi, »Ø¹éÀñºĞ mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    local list = g_ItemList[nLeftTimes]
    if (IsHaveSpaceForTreasure(list.needSpace + 1) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã" .. list.needSpace .. "¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    SetTaskByte(2186, 2, nDay)
    SetTaskByte(2186, 3, nLeftTimes)

    for i = 1, list.count do

        AddNormalItemBind(list.ID[1], list.ID[2], list.ID[3], list.ID[4], 0, 0, 1)
    end

    local strShow = "Më »Ø¹éÀñºĞ nhËn ®­îc " .. list.name
    Msg2CurMapAnnounce("Chóc mõng " .. GetName() .. strShow)

    if (nLeftTimes == 5) then
        AddNormalItem(6, 1, 1569, 1, 0, 0)
        Msg2Player("Chóc m­õng ngµi " .. strShow .. ", ³ı´ËÖ®ÍâÎÒÕâÀï»¹ÓĞÒ»·İ»½ÓÑ»ØÀñ, Çë½«¸Ã»ØÀñËÍµ½ÕÙ»½Äã»Ø¹é·âÉñÊÀ½çµÄĞÖµÜÊÖÖĞ°É")
        DelNormalItem(6, 1, 1568, 1)
        WriteLog("[ThËp Chu Niªn]" .. strShow .. ", »½ÓÑ»ØÀñ")
    else
        Msg2Player("Chóc m­õng ngµi " .. strShow)
        WriteLog("[ThËp Chu Niªn]" .. strShow)
    end
end

function no()
    CloseDialog()
end;
