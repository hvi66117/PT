TASK_WANJING = 1384
TASKNOTE_WANJING = 1042

function main()

    local status = GetTaskByte(TASK_WANJING, 1)
    if ((status >= 1) and (status <= 7)) then
        wanjing()
    elseif (status == 8) then
        Msg2Player("NhiÖm vô V¹n c¶nh chi viªn ®· hoµn thµnh, quay vÒ håi b¸o Chóc Dung.")
    else
        ClearItem(6, 1, 483, 1)
        DelNormalItemInQuick(6, 1, 483, 1)
        Msg2Player("<c=g>HuyÔn Quang KÝnh<c> chØ cã thÓ sö dông trong nhiÖm vô <c=r>V¹n C¶nh Chi Viªn<c>.")
    end
end

function wanjing()

    local PicPos = {

        [1] = { 2, { ["x"] = 1616, ["y"] = 3280 }, "<c=yel>Doanh tr¹i<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\³ç³Ç´óÓª1.spr" },
        [2] = { 1, { ["x"] = 1696, ["y"] = 3280 }, "<c=yel>N¬i qui hån<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\·âÉñÌ¨1.spr" },
        [3] = { 52, { ["x"] = 1704, ["y"] = 3008 }, "<c=yel>N¬i ë thÇn tiªn<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\Ñþ³Ø1.spr" },
        [4] = { 7, { ["x"] = 1664, ["y"] = 3120 }, "<c=yel>Thu s¾c hoang s¬n<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ÑàÉ½1.spr" },
        [5] = { 13, { ["x"] = 1608, ["y"] = 2816 }, "<c=yel>BÝch d· tiÓu khª<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\¾ÞÂ¹1.spr" },
        [6] = { 11, { ["x"] = 1840, ["y"] = 3088 }, "<c=yel>Lôc l©m u c¶nh<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ÓÎ»ê¹Ø1.spr" },
        [7] = { 10, { ["x"] = 1544, ["y"] = 3168 }, "<c=yel>TuyÕt vùc cao s¬n<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\Ê×ÑôÉ½1.spr" },
        [8] = { 15, { ["x"] = 1680, ["y"] = 3104 }, "<c=yel>Th¹ch kiÒu s¬n cèc<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ÃÏ½ò1.spr" },
        [9] = { 17, { ["x"] = 1816, ["y"] = 3456 }, "<c=yel>Phong hång th¾ng c¶nh<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\áªÉ½1.spr" },
        [10] = { 14, { ["x"] = 1720, ["y"] = 3664 }, "<c=yel>Hång nguyªn th©m ®×nh<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\äü¹Ø1.spr" },
        [11] = { 18, { ["x"] = 1688, ["y"] = 2928 }, "<c=yel>ChiÕn tr­êng cuèi cïng<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ÄÁÒ°1.spr" },
        [12] = { 19, { ["x"] = 1520, ["y"] = 3104 }, "<c=yel>Phïng tuyÕt chi ®Þa<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\¾øÁúÁë1.spr" },
        [13] = { 65, { ["x"] = 1872, ["y"] = 2784 }, "<c=yel>§­êng th«ng Tiªn ®¶o<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\³ÂÌÁ¹Ø1.spr" },
        [14] = { 23, { ["x"] = 1472, ["y"] = 3008 }, "<c=yel>Th­îng cæ hoang thµnh<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\É³Ä®ÍÁ³Ç1.spr" },
        [15] = { 26, { ["x"] = 1488, ["y"] = 2880 }, "<c=yel>Huúnh sa mai cèt<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ËÀÍöÉ³Ä®1.spr" },
        [16] = { 41, { ["x"] = 2008, ["y"] = 3216 }, "<c=yel>Th©m h¶i linh th¹ch<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\¶«º£ÁúÔ¨1.spr" },
        [17] = { 27, { ["x"] = 1760, ["y"] = 2928 }, "<c=yel>Ma háa luyÖn ngôc<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\ÐùÔ¯¶´Ò»²ã1.spr" },
        [18] = { 50, { ["x"] = 1544, ["y"] = 3200 }, "<c=yel>V¾n tiªn chi ®Þa<c>", "\\spr\\Ui4\\¶Ô»°±³¾°Í¼\\À¦ÏÉ¹¬ËÄ²ã1.spr" },
    }

    local PicIdx = GetTaskByte(TASK_WANJING, 2)

    while (PicIdx > 32) do
        PicIdx = PicIdx - 32
    end

    if (PicIdx > 18) then
        Msg2Player("HuyÒn Quang kÝnh bÊt th­êng, t×m Chóc Dung b¾t ®Çu l¹i tõ ®Çu.")
        return
    end

    local w1, x1, y1 = GetWorldPos()

    if ((w1 == PicPos[PicIdx][1]) and ((x1 - PicPos[PicIdx][2]["x"]) ^ 2 + (y1 - PicPos[PicIdx][2]["y"]) ^ 2) <= 320) then


        SetTaskBit(TASK_WANJING, PicIdx + 14, 1)

        local status = GetTaskByte(TASK_WANJING, 1)
        if (status < 7) then
            zhaopian_wj()
            TopMessage("Sö dông thµnh c«ng nhÊt së c¶nh quan")
            Msg2Player("Sö dông thµnh c«ng, theo gîi ý cña HuyÔn Quang KÝnh t×m ®Þa ®iÓm kÕ tiÕp.")
            SetTaskByte(TASK_WANJING, 1, status + 1)
            TaskNote(TASKNOTE_WANJING, 0, status)
        elseif (status == 7) then
            SetTaskByte(TASK_WANJING, 1, 8)
            TaskNote(TASKNOTE_WANJING, 1)
            TopMessage("V¹n c¶nh chi viªn hoµn thµnh")
            Msg2Player("V¹n c¶nh chi viªn hoµn thµnh, ®Õn Chóc Dung (<HyperLinkWorldPos=\"BÊt Chu Thiªn Quan[73, 209, 235]\">) giao nhiÖm vô.")
        end
    else

        Talk(2, "no", PicPos[PicIdx][3], "BGI=" .. PicPos[PicIdx][4])
    end
end

function zhaopian_wj()
    while (1) do
        local i = math.random(1, 18)
        if (GetTaskBit(TASK_WANJING, i + 14) == 0) then
            local tmp = GetTaskByte(TASK_WANJING, 2)

            tmp = (math.floor(tmp / 32)) * 32
            SetTaskByte(TASK_WANJING, 2, tmp + i)
            break
        end
    end
end

function no()
    CloseDialog()
end;
