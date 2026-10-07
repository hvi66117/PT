require("newserver.luax")
require("ÊôĞÔÁé³è.luax")

g_Task_Card = 2065

GufuList = {
    { wenzi = "Vi Quang Qu¸i Phï (ch­a khai quang) 1 c¸i", lvl = 70, bit = 26, num = 1, item = { 3, 374, 0, 0 } },
    { wenzi = "Vi Quang Qu¸i Phï (ch­a khai quang) 1 c¸i", lvl = 80, bit = 27, num = 1, item = { 3, 374, 0, 0 } },
    { wenzi = "Vi Quang Qu¸i Phï (ch­a khai quang)Á½¸ö", lvl = 90, bit = 28, num = 2, item = { 3, 374, 0, 0 } },
    { wenzi = "Tinh Th¸i Qu¸i Phï (ch­a khai quang) 1 c¸i", lvl = 100, bit = 29, num = 1, item = { 3, 383, 0, 0 } },
    { wenzi = "Tinh Th¸i Qu¸i Phï (ch­a khai quang)Á½¸ö", lvl = 110, bit = 30, num = 2, item = { 3, 383, 0, 0 } },
    { wenzi = "Tinh Th¸i Qu¸i Phï (ch­a khai quang)Á½¸ö", lvl = 120, bit = 31, num = 2, item = { 3, 383, 0, 0 } },
}

function main(nLevel, t, nNpcIdx, nItemId)
    if (GetTaskBit(g_Task_Card, 25) ~= 1) then
        Talk(1, "no", "¶Ô²»ÆğÄãÃ»ÓĞ×Ê¸ñÁìÈ¡³É³¤ØÔ·ûÀñ°ü.")
        WriteLog("[Ho¹t ®éng m¸y chñ míi][³É³¤ØÔ·ûÀñ°ü]Òì³£É¾³ı.")
        ClearItem(6, 1, 1674, 1)
        ClearItem(6, 1, 1674, 0)
        return
    end
    local tblTask = {}
    local nTaskNum = 0
    for i = 1, table.getn(GufuList) do
        if (GetTaskBit(g_Task_Card, GufuList[i].bit) == 0) then
            nTaskNum = nTaskNum + 1
            tblTask[i] = GufuList[i].lvl .. "¼¶, ÁìÈ¡<c=g>" .. GufuList[i].wenzi .. "<c>/selGufu"
        else
            tblTask[i] = GufuList[i].lvl .. "¼¶, §· nhËn/no"
        end
    end
    if (nTaskNum == 0) then
        tblTask = {}
        tblTask[1] = "É¾³ıÀñ°ü/delbox"
    end

    Say("[³É³¤ØÔ·ûÀñ°ü]ÊÇĞÂ·şÌØÓĞµÄÓÅ»İÀñ°ü, Äú¿ÉÔÚµÈ¼¶³É³¤¹ı³ÌÖĞ»ñµÃ·áºñµÄØÔ·û½±Àø.Àñ°üÓÀ¾ÃÓĞĞ§, ÁìÍêËùÓĞØÔ·ûºó, ÓÒ¼ü´ËÀñ°ü¿É½«Àñ°üÉ¾³ı.", getn(tblTask), tblTask)
end

function no()
    CloseDialog()
end;

function selGufu(nIndex)
    CloseDialog()
    nIndex = nIndex + 1
    if (GetTaskBit(g_Task_Card, GufuList[nIndex].bit) == 1) then
        Talk(1, "no", "Xin lçi, Äã´ËÏî½±ÀøÒÑ¾­ÁìÈ¡¹ıÁË.")
        return
    end

    if (GetLevel() < GufuList[nIndex].lvl) then
        Talk(1, "no", "Xin lçi, ÄãµÈ¼¶»¹²»×ã<c=r>" .. GufuList[nIndex].lvl .. "<c>¼¶, ÎŞ·¨ÁìÈ¡´ËÏî½±Àø.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    for i = 1, GufuList[nIndex].num do
        AddNormalItemBind(GufuList[nIndex].item[1], GufuList[nIndex].item[2], GufuList[nIndex].item[3], GufuList[nIndex].item[4], 0, 0, 1)
    end

    SetTaskBit(g_Task_Card, GufuList[nIndex].bit, 1)
    ScrollMessage("NhËn ®­îc " .. GufuList[nIndex].wenzi)
    WriteLog("[Ho¹t ®éng m¸y chñ míi][³É³¤ØÔ·ûÀñ°ü]" .. GufuList[nIndex].wenzi)
    Talk(1, "no", "¹§Ï²Äú nhËn <c=y>" .. GufuList[nIndex].wenzi .. "<c>.ÕâÊÇÄú" .. GufuList[nIndex].lvl .. "¼¶ÕâµµµÄØÔ·û, xin nhËn lÊy!")
end

function delbox()
    CloseDialog()
    for i = 1, getn(GufuList) do
        if (GetTaskBit(g_Task_Card, GufuList[i].bit) == 0) then
            Talk(1, "no", "Xin lçi, ²»ÄÜÉ¾³ıÀñ°ü, Äã»¹ÓĞÃ»ÓĞÁìÈ¡µÄØÔ·û!")
            return
        end
    end
    TopMessage("³É³¤ØÔ·ûÀñ°üÒÑ¾­È«²¿ÁìÈ¡")
    Talk(1, "no", "³É³¤ØÔ·ûÀñ°üÒÑ¾­È«²¿´ò¿ª, ±»ÏµÍ³»ØÊÕÁË, Èç¹ûÓĞÒÉÎÊ¿ÉÒÔ×ÉÑ¯¿Í·ş!")
    ClearItem(6, 1, 1674, 1)
    ClearItem(6, 1, 1674, 0)
    WriteLog("[Ho¹t ®éng m¸y chñ míi][³É³¤ØÔ·ûÀñ°ü]È«²¿´ò¿ªÉ¾³ı.")
end
