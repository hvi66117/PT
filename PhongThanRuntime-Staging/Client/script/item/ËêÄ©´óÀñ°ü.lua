GUPTIME = 625

CoinList = {
    [1] = { { "µÚ1-5´Î mua", 5, 2 }, { "µÚ6-25´Î", 25, 4 }, { "µÚ26´ÎÒÔÉÏ", 1000, 6 }, },
    [2] = { { "µÚ1-5´Î mua", 5, 3 }, { "µÚ6-25´Î", 25, 5 }, { "µÚ26´ÎÒÔÉÏ", 1000, 7 }, },
    [3] = { { "µÚ1-5´Î mua", 5, 4 }, { "µÚ6-25´Î", 25, 8 }, { "µÚ26´ÎÒÔÉÏ", 1000, 12 }, },
}
StoneList = {
    [1] = {
        { "Phï Th¹ch-TriÖu Håi trung cÊp (CÊp 1):Liªn Nç TÕ", 1564, 2 },
        { "Phï Th¹ch-TriÖu Håi trung cÊp (CÊp 1):To¸i Cèt TÕ", 1578, 2 },
        { "Phï Th¹ch-Tr­êng §ao trung cÊp (CÊp 1):Tinh Th«ng Tr­êng §ao", 1333, 0 },
        { "Phï Th¹ch-Tr­êng §ao trung cÊp (CÊp 1):L¹c §Þa Tr¶m", 1347, 0 },
        { "Phï Th¹ch-HÖ Thæ Trung CÊp (CÊp 1):Ngò Nh¹c TriÒu T«ng", 1445, 1 },
        { "Phï Th¹ch-Ma Ph¸p Trung cÊp (CÊp 1):Ph¸ Gi¸p Chó", 1515, 2 },
        { "Phï Th¹ch-HÖ Háa Trung cÊp (CÊp 1):ThËp Ph­¬ng LiÖt Háa", 1382, 1 },
        { "Phï Th¹ch-§o¶n §ao trung cÊp (CÊp 1):Tinh Th«ng §o¶n §ao", 1284, 0 },
        { "Phï Th¹ch-§o¶n §ao trung cÊp (CÊp 1):Liªn Hoµn Tr¶m", 1291, 0 },
        { "Phï Th¹ch-HÖ B¨ng Trung cÊp (CÊp 1):B¨ng Phong B¹o", 1417, 1 },


        { "Phï Th¹ch-TriÖu Håi s¬ cÊp (CÊp 1):Tr­êng Cung TÕ", 1550, 2 },
        { "Phï Th¹ch-Tr­êng §ao s¬ cÊp (CÊp 1):§iÖn Quang Tr¶m", 1326, 0 },
        { "Phï Th¹ch-Tr­êng §ao s¬ cÊp (CÊp 1):Tam §Çu Lôc Thñ", 1340, 0 },
        { "Phï Th¹ch-Ma Ph¸p s¬ cÊp (CÊp 1):Th«i Th©n Chó", 1501, 2 },
        { "Phï Th¹ch-Ma Ph¸p s¬ cÊp (CÊp 1):Bæ T©m Chó", 1508, 2 },
        { "Phï Th¹ch-HÖ L«i S¬ cÊp (CÊp 1):Phong V©n L«i §éng", 1473, 1 },
        { "Phï Th¹ch-HÖ Háa S¬ cÊp (CÊp 1):Phong L©m Háa S¬n", 1375, 1 },
        { "Phï Th¹ch-§o¶n §ao s¬ cÊp (CÊp 1):Håi Phong Tr¶m", 1277, 0 },
        { "Phï Th¹ch-HÖ B¨ng s¬ cÊp (CÊp 1):ThiÕt M· B¨ng Qua", 1410, 1 }, },
    [2] = {
        { "Phï Th¹ch-TriÖu Håi Cao cÊp (CÊp 1):Truy Hån TÕ", 1585, 2 },
        { "Phï Th¹ch-TriÖu Håi Cao cÊp (CÊp 1):Phong QuyÓn Tµn V©n", 1592, 2 },
        { "Phï Th¹ch-Tr­êng §ao cao cÊp (CÊp 1):Khuynh Thµnh NhÊt KÝch", 1354, 0 },
        { "Phï Th¹ch-HÖ Thæ Cao cÊp (CÊp 1):HuyÒn N÷ Bæ Thiªn", 1452, 1 },
        { "Phï Th¹ch-Ma Ph¸p Cao cÊp (CÊp 1):Tr¶m T©m Chó", 1522, 2 },
        { "Phï Th¹ch-HÖ L«i Cao cÊp (CÊp 1):L«i §éng Cöu Thiªn", 1480, 1 },
        { "Phï Th¹ch-HÖ Háa Cao cÊp (CÊp 1):Tam Muéi Ch©n Háa", 1389, 1 },
        { "Phï Th¹ch-§o¶n §ao cao cÊp (CÊp 1):ThuÇn D­¬ng Hé ThÓ", 1298, 0 },
        { "Phï Th¹ch-§o¶n §ao cao cÊp (CÊp 1):Thiªn Qu©n Tr¶m", 1305, 0 },
        { "Phï Th¹ch-HÖ B¨ng Cao cÊp (CÊp 1):B¨ng Phong V¹n Lý", 1424, 1 }, },
    [3] = {
        { "Phï Th¹ch-Hån Chó TriÖu Håi (CÊp 1):Cuång §µo TÕ", 1599, 2 },
        { "Phï Th¹ch-Hån Chó TriÖu Håi (CÊp 1):SËu Vò B¹o Phong", 1606, 2 },
        { "Phï Th¹ch-Hån Chó Tr­êng §ao (CÊp 1):Thiªn Hµn Tr¶m", 1361, 0 },
        { "Phï Th¹ch-Hån Chó Tr­êng §ao (CÊp 1):BÝch NguyÖt Tr¶m", 1368, 0 },
        { "Phï Th¹ch-Hån Chó HÖ Thæ (CÊp 1):Phi Sa TÈu Th¹ch", 1459, 1 },
        { "Phï Th¹ch-Hån Chó HÖ Thæ (CÊp 1):§Þa Háa PhÇn Thiªn", 1466, 1 },
        { "Phï Th¹ch-Hån Chó Ma Ph¸p (CÊp 1):Phóc Tr¹ch Thiªn H÷u", 1529, 2 },
        { "Phï Th¹ch-Hån Chó Ma Ph¸p (CÊp 1):TuyÖt T©m Chó", 1536, 2 },
        { "Phï Th¹ch-Hån Chó Ma Ph¸p (CÊp 1):Ph¸ Qu©n Chó", 1543, 2 },
        { "Phï Th¹ch-Hån Chó HÖ L«i (CÊp 1):PhÖ ¶nh L«i Quang", 1487, 1 },
        { "Phï Th¹ch-Hån Chó HÖ L«i (CÊp 1):LuyÖn Ngôc ThiÓm §iÖn", 1494, 1 },
        { "Phï Th¹ch-Hån Chó HÖ Háa (CÊp 1):PhÇn Háa §å §»ng", 1396, 1 },
        { "Phï Th¹ch-Hån Chó HÖ Háa (CÊp 1):Háa Tinh Trôy L¹c", 1403, 1 },
        { "Phï Th¹ch-Hån Chó §o¶n §ao (CÊp 1):§o¹n Kh«ng Tr¶m", 1312, 0 },
        { "Phï Th¹ch-Hån Chó §o¶n §ao (CÊp 1):Cuång T©m Tr¶m", 1319, 0 },
        { "Phï Th¹ch-Hån Chó HÖ B¨ng (CÊp 1):TuyÕt Vò B¨ng Phong", 1431, 1 },
        { "Phï Th¹ch-Hån Chó HÖ B¨ng (CÊp 1):Thiªn Lý Truy Hån", 1438, 1 }, },
}

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, 1673, 1) <= 0) then
        if (HaveNormalItem(6, 1, 1673, 0) > 0) then
            DelNormalItem(6, 1, 1673, 0)
            AddNormalItemBind(6, 1, 1673, 1, 0, 0, 1)
        else
            return
        end
    end

    local tasks = {
        { "Ò»ÖØ¸£Àñ", "shop1"; show = 1 },
        { "¶þÖØºñÀñ", "shop2"; show = 1 },
        { "ÈýÖØºÀÀñ", "shop3"; show = 1 },
        { "NhËn ÇÉ¿ËÁ¦", "freeGift"; show = 1 },
    }
    SayTask("·ûÊ¯ÓÅ»Ý°ü¾ªÏ²ÉÏÏß!´ËÀñºÐÓÐÐ§ÆÚ¼ä, Äú¿É<c=y>Ã¿ÈÕ<c>ÁìÈ¡ÇÉ¿ËÁ¦*1, Ç¿Á¦Ò©Ð§, Ë²¼äÂúÑª!\nÍ¬Ê±Äú»¹¿ÉÒÔ¹ºÂòÌØ¹©ÏÞÁ¿Àñ°ü, bªn trong chøa Ò»¼¶·ûÊ¯ (¿ÉÖ¸¶¨¼¼ÄÜ, khãa) vµ Èô¸ÉT­íng Qu©n LÖnh (Kh«ng kho¸), ÏêÇéÇëµã»÷ÒÔÏÂÀñ°üÁË½â: ", tasks)
end

function freeGift()
    MsgBox("Mçi ngµy chØ cã thÓ 1 lÇn, ¿ÉÃâ·ÑÁìÈ¡<c=y>ÇÉ¿ËÁ¦<c>1 viªn , ÄãÏÖÔÚÒªÊ¹ÓÃÃ´?", "Yes_Item", "main")
end

function Yes_Item()
    no()
    if (HaveNormalItem(6, 1, 1673, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢·ûÊ¯ÓÅ»Ý°ü")
        return
    end

    local nYear, nMon, nDay = GetYMD()
    if (GetTaskByte(2220, 2) == nDay) then
        Talk(1, "no", "ThËt xin lçi, ·ûÊ¯ÓÅ»Ý°ü mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
        return
    end
    SetTaskByte(2220, 2, nDay)

    AddNormalItemBind(1, 6, 0, 0, 1, 0, 1)
    Msg2Player("´ò¿ª·ûÊ¯ÓÅ»Ý°ü nhËn ®­îc 1 viªn °ó¶¨µÄÇÉ¿ËÁ¦.")
    Talk(1, "no", "Ngµi nhËn ®­îc 1 viªn °ó¶¨µÄÇÉ¿ËÁ¦!")
    WriteLog("[·ûÊ¯ÓÅ»Ý°ü][°ó¶¨ÇÉ¿ËÁ¦]")
end

function ShowText(idx)
    local showstr = ""
    local temp = {}
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    for i = 1, getn(CoinList) do
        if (idx == i) then
            temp = CoinList[i]
            for j = 1, 3 do
                showstr = showstr .. temp[j][1] .. ", Ðètiªu phÝ " .. (Cfs * temp[j][3]) .. " Th«ng B¶o;"
            end
            break
        end
    end

    return showstr
end

function shop1()
    no()
    local str = ShowText(1)
    local tasklist = {}
    local pType = GetPlayerType()
    local num = 1
    tasklist[num] = "·µ»ØÖ÷Ò³/main"
    for i = 1, getn(StoneList[1]) do
        if (StoneList[1][i][3] == pType) then
            num = num + 1
            tasklist[num] = StoneList[1][i][1] .. "/shop1_yes"
        end
    end
    Say("Ò»ÖØ¸£Àñ: 1¼¶·ûÊ¯(ÖÐµÍ¼¶¼¼ÄÜÈÎÑ¡, °ó¶¨)+ 1 c¸i T­íng Qu©n LÖnh(²»°ó¶¨).\n" .. str .. "\nÇëÑ¡ÔñÀñ°üÖÐµÄ·ûÊ¯: ", getn(tasklist), tasklist)
end

function shop1_yes(index)
    no()
    local ntime = GetTaskWord(2220, 2) + 1
    if (ntime > GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    local temp = {}
    local num = 0
    local pType = GetPlayerType()
    for i = 1, getn(StoneList[1]) do
        if (StoneList[1][i][3] == pType) then
            num = num + 1
            temp[num] = i
        end
    end
    if (index == 0) or (index > num) then
        Msg2Player("Ñ¡ÔñÓÐÎóxin h·y chän l¹i!")
        shop1()
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 2
    for i = 1, 3 do
        if (ntime <= CoinList[1][i][2]) then
            lvlnum = CoinList[1][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    SetTask(142, temp[index])
    MsgBox("ÄúÒÑ¹ºÂò´ËµµÀñ°ü´ÎÊýÎª<c=g>" .. ntime .. "<c> lÇn, ½«»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o, nhËn ®­îc " .. StoneList[1][temp[index]][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 1 c¸i (Kh«ng kho¸), È·ÈÏ¹ºÂò sao?", "Yes_shop1", "no")
end

function Yes_shop1()
    no()
    if (HaveNormalItem(6, 1, 1673, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢·ûÊ¯ÓÅ»Ý°ü")
        return
    end

    local index = GetTask(142)
    SetTask(142, 0)
    if (index == 0) or (index > getn(StoneList[1])) then
        Talk(1, "shop1", "ThËt xin lçi, Sè liÖu bÊt th­êngÇëÖØÐÂ¹ºÂò!")
        return
    end

    local ntime = GetTaskWord(2220, 2) + 1
    if (ntime > GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng ®ñ 2 « trèng, vui lßng s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 2
    for i = 1, 3 do
        if (ntime <= CoinList[1][i][2]) then
            lvlnum = CoinList[1][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(293) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂò´ËµµÀñ°üÊ§°Ü!")
        return
    end
    for i = 2, lvlnum do
        CostCoinByIdx(293)
    end
    SetTaskWord(2220, 2, ntime)
    AddNormalItemPile(3, 100, 0, 0, 0, 0)
    AddNormalItemBind(3, StoneList[1][index][2], 0, 0, 0, 0, 1)
    local str = "NhËn ®­îc " .. StoneList[1][index][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 1 c¸i (Kh«ng kho¸)"
    Talk(1, "shop1", "ÄãµÚ" .. ntime .. "´Î¹ºÂòÁËÒ»ÖØ¸£Àñ, tiªu phÝ " .. Cfs .. " Th«ng B¶o ," .. str)
    Msg2Player("ÄãµÚ" .. ntime .. "´Î¹ºÂòÁËÒ»ÖØ¸£Àñ, " .. str)
    WriteLog("[·ûÊ¯ÓÅ»Ý°ü][Ò»ÖØ¸£Àñ]" .. ntime .. "´Î|" .. Cfs .. " Th«ng B¶o|T­íng Qu©n LÖnh 1 c¸i +" .. StoneList[1][index][1])
end

function shop2()
    no()
    local str = ShowText(2)
    local tasklist = {}
    local pType = GetPlayerType()
    local num = 1
    tasklist[num] = "·µ»ØÖ÷Ò³/main"
    for i = 1, getn(StoneList[2]) do
        if (StoneList[2][i][3] == pType) then
            num = num + 1
            tasklist[num] = StoneList[2][i][1] .. "/shop2_yes"
        end
    end
    Say("¶þÖØºñÀñ: 1¼¶·ûÊ¯(¸ß¼¶¼¼ÄÜÈÎÑ¡, °ó¶¨)+ 2 c¸i T­íng Qu©n LÖnh(²»°ó¶¨).\n" .. str .. "\nÇëÑ¡ÔñÀñ°üÖÐµÄ·ûÊ¯: ", getn(tasklist), tasklist)
end

function shop2_yes(index)
    no()
    local ntime = GetTaskWord(2221, 1) + 1
    if (ntime > GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    local temp = {}
    local num = 0
    local pType = GetPlayerType()
    for i = 1, getn(StoneList[2]) do
        if (StoneList[2][i][3] == pType) then
            num = num + 1
            temp[num] = i
        end
    end
    if (index == 0) or (index > num) then
        Msg2Player("Ñ¡ÔñÓÐÎóxin h·y chän l¹i!")
        shop2()
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 3
    for i = 1, 3 do
        if (ntime <= CoinList[2][i][2]) then
            lvlnum = CoinList[2][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    SetTask(142, temp[index])
    MsgBox("ÄúÒÑ¹ºÂò´ËµµÀñ°ü´ÎÊýÎª<c=g>" .. ntime .. "<c> lÇn, ½«»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o, nhËn ®­îc " .. StoneList[2][temp[index]][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 2 c¸i  (Kh«ng kho¸), È·ÈÏ¹ºÂò sao?", "Yes_shop2", "no")
end

function Yes_shop2()
    no()
    if (HaveNormalItem(6, 1, 1673, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢·ûÊ¯ÓÅ»Ý°ü")
        return
    end

    local index = GetTask(142)
    SetTask(142, 0)
    if (index == 0) or (index > getn(StoneList[2])) then
        Talk(1, "shop2", "ThËt xin lçi, Sè liÖu bÊt th­êngÇëÖØÐÂ¹ºÂò!")
        return
    end

    local ntime = GetTaskWord(2221, 1) + 1
    if (ntime > GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng ®ñ 2 « trèng, vui lßng s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 3
    for i = 1, 3 do
        if (ntime <= CoinList[2][i][2]) then
            lvlnum = CoinList[2][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(293) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂò´ËµµÀñ°üÊ§°Ü!")
        return
    end
    for i = 2, lvlnum do
        CostCoinByIdx(293)
    end
    SetTaskWord(2221, 1, ntime)
    AddNormalItemPile(3, 100, 0, 0, 0, 0)
    AddNormalItemPile(3, 100, 0, 0, 0, 0)
    AddNormalItemBind(3, StoneList[2][index][2], 0, 0, 0, 0, 1)
    local str = "NhËn ®­îc " .. StoneList[2][index][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 2 c¸i  (Kh«ng kho¸)"
    Talk(1, "shop2", "ÄãµÚ" .. ntime .. "´Î¹ºÂòÁË¶þÖØºñÀñ, tiªu phÝ " .. Cfs .. " Th«ng B¶o ," .. str)
    Msg2Player("ÄãµÚ" .. ntime .. "´Î¹ºÂòÁË¶þÖØºñÀñ, " .. str)
    WriteLog("[·ûÊ¯ÓÅ»Ý°ü][¶þÖØºñÀñ]" .. ntime .. "´Î|" .. Cfs .. " Th«ng B¶o|T­íng Qu©n LÖnh 2 c¸i +" .. StoneList[2][index][1])
end

function shop3()
    no()
    local str = ShowText(3)
    local tasklist = {}
    local pType = GetPlayerType()
    local num = 1
    tasklist[num] = "·µ»ØÖ÷Ò³/main"
    for i = 1, getn(StoneList[3]) do
        if (StoneList[3][i][3] == pType) then
            num = num + 1
            tasklist[num] = StoneList[3][i][1] .. "/shop3_yes"
        end
    end
    Say("ÈýÖØºÀÀñ: 1¼¶·ûÊ¯(»êÖä¼¼ÄÜÈÎÑ¡, °ó¶¨)+ 3 c¸i T­íng Qu©n LÖnh(²»°ó¶¨).\n" .. str .. "\nÇëÑ¡ÔñÀñ°üÖÐµÄ·ûÊ¯: ", getn(tasklist), tasklist)
end

function shop3_yes(index)
    no()
    local ntime = GetTaskWord(2221, 2) + 1
    if (ntime >= GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    local temp = {}
    local num = 0
    local pType = GetPlayerType()
    for i = 1, getn(StoneList[3]) do
        if (StoneList[3][i][3] == pType) then
            num = num + 1
            temp[num] = i
        end
    end
    if (index == 0) or (index > num) then
        Msg2Player("Ñ¡ÔñÓÐÎóxin h·y chän l¹i!")
        shop3()
        return
    end
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 4
    for i = 1, 3 do
        if (ntime <= CoinList[3][i][2]) then
            lvlnum = CoinList[3][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end
    SetTask(142, temp[index])
    MsgBox("ÄúÒÑ¹ºÂò´ËµµÀñ°ü´ÎÊýÎª<c=g>" .. ntime .. "<c> lÇn, ½«»¨·Ñ<c=y>" .. Cfs .. "<c> Th«ng B¶o, nhËn ®­îc " .. StoneList[3][temp[index]][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 3 c¸i  (Kh«ng kho¸), È·ÈÏ¹ºÂò sao?", "Yes_shop3", "no")
end

function Yes_shop3()
    no()
    if (HaveNormalItem(6, 1, 1673, 1) <= 0) then
        WriteLog("[BÊt th­êng]Ë¢·ûÊ¯ÓÅ»Ý°ü")
        return
    end

    local index = GetTask(142)
    SetTask(142, 0)
    if (index == 0) or (index > getn(StoneList[3])) then
        Talk(1, "shop3", "ThËt xin lçi, Sè liÖu bÊt th­êngÇëÖØÐÂ¹ºÂò!")
        return
    end

    local ntime = GetTaskWord(2221, 2) + 1
    if (ntime > GUPTIME) then
        Talk(1, "no", "ThËt xin lçi, ´ËµµÀñ°üÒÑµ½´ï¹ºÂòÉÏÏÞ, kh«ng thÓ tiÕp tôc mua.¿ÉÒÔÑ¡ÔñÆäËûµµÎ»!")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng ®ñ 2 « trèng, vui lßng s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(293)
    local lvlnum = 4
    for i = 1, 3 do
        if (ntime <= CoinList[3][i][2]) then
            lvlnum = CoinList[3][i][3]
            break
        end
    end

    Cfs = Cfs * lvlnum
    if (GetCoin() < Cv * lvlnum) then
        Talk(1, "no", "ThËt xin lçi, ´ËÀñ°ü cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(293) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¹ºÂò´ËµµÀñ°üÊ§°Ü!")
        return
    end
    for i = 2, lvlnum do
        CostCoinByIdx(293)
    end
    SetTaskWord(2221, 2, ntime)
    for i = 1, 3 do
        AddNormalItemPile(3, 100, 0, 0, 0, 0)
    end
    AddNormalItemBind(3, StoneList[3][index][2], 0, 0, 0, 0, 1)
    local str = "NhËn ®­îc " .. StoneList[3][index][1] .. "(Kho¸), vµ T­íng Qu©n LÖnh 3 c¸i  (Kh«ng kho¸)"
    Talk(1, "shop3", "ÄãµÚ" .. ntime .. "´Î¹ºÂòÁËÈýÖØºÀÀñ, tiªu phÝ " .. Cfs .. " Th«ng B¶o ," .. str)
    Msg2Player("ÄãµÚ" .. ntime .. "´Î¹ºÂòÁËÈýÖØºÀÀñ, " .. str)
    WriteLog("[·ûÊ¯ÓÅ»Ý°ü][ÈýÖØºÀÀñ]" .. ntime .. "´Î|" .. Cfs .. " Th«ng B¶o|T­íng Qu©n LÖnh 3 c¸i +" .. StoneList[3][index][1])
end
