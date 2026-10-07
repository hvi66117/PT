require("³£ÓÃ»î¶¯.luax")

g_ItemMax = 7
G_GlobalMax = 500
g_ItemList = {
    [1] = { bag = 4, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*2, ", ID = { 6, 1, 1872, 0 }, count = 2 },
            [2] = { name = "Di Ngo¹i Phï*1, ", ID = { 8, 35, 2, 0 }, count = 1 },
            [3] = { name = "ÉúÃüÇåÂ¶*1, ", ID = { 8, 162, 3, 0 }, count = 1 },
            [4] = { name = "NhËt NguyÖt Ch©n Khİ*1.", ID = { 8, 163, 4, 0 }, count = 1 },
    },

    [2] = { bag = 3, num = 5,
            [1] = { name = "Phï chñ §Ò ngµy*2, ", ID = { 6, 1, 1872, 0 }, count = 2 },
            [2] = { name = "Thiªn H­¬ng Tôc MÖnh×´Ì¬x2 giê, ", ID = { 229, 7200 }, count = 0 },
            [3] = { name = "Ìì½µ²ÆÉñ×´Ì¬x2 giê, ", ID = { 228, 7200 }, count = 0 },
            [4] = { name = "°×»¢7 ngµy ÌØÈ¨, ", ID = { 6, 1, 1105, 1 }, count = 1 },
            [5] = { name = "ThÎ Chİ H÷u*1.", ID = { 8, 1916, 2, 0 }, count = 1 },
    },
    [3] = { bag = 2, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*3, ", ID = { 6, 1, 1872, 0 }, count = 3 },
            [2] = { name = "Tiªu Dao ThÇn Tiªn T¸nx1, ", ID = { 8, 374, 0, 0 }, count = 1 },
            [3] = { name = "ThÇn C©u Phï×´Ì¬x2 giê, ", ID = { 133, 7200 }, count = 0 },
            [4] = { name = "LÔ bao Chİ T«n*1, ", ID = { 8, 289, 2, 0 }, count = 1 },
    },
    [4] = { bag = 4, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*3, ", ID = { 6, 1, 1872, 0 }, count = 3 },
            [2] = { name = "Bİ C¶nh ThÇn Tiªn truyÒn tèng phï*1, ", ID = { 8, 1709, 2, 0 }, count = 1 },
            [3] = { name = "PhiÕu khÊu trõ Tæ hîp Kü n¨ng Linh Sñng*1, ", ID = { 3, 1638, 0, 0 }, count = 1 },
            [4] = { name = "ThÎ Kim DËt*1.", ID = { 8, 1316, 4, 0 }, count = 1 },
    },
    [5] = { bag = 4, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*4, ", ID = { 6, 1, 1872, 0 }, count = 4 },
            [2] = { name = "ThiÖp Nh­ ı*10, ", ID = { 3, 138, 0, 0 }, count = 10 },
            [3] = { name = "ÇÉ¿ËÁ¦*10, ", ID = { 1, 6, 0, 0 }, count = 10 },
            [4] = { name = "Vi Quang Qu¸i Phï (ch­a khai quang)x2.", ID = { 3, 374, 0, 0 }, count = 2 },
    },
    [6] = { bag = 4, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*4, ", ID = { 6, 1, 1872, 0 }, count = 4 },
            [2] = { name = "ThÇn T­íng Dô LÖnh*10, ", ID = { 3, 1637, 0, 0 }, count = 10 },
            [3] = { name = "Tói Nh­ ı*20, ", ID = { 8, 1454, 2, 0 }, count = 20 },
            [4] = { name = "B¶o r­¬ng Phï Th¹ch*1, ", ID = { 8, 1776, 2, 0 }, count = 1 },
    },
    [7] = { bag = 4, num = 4,
            [1] = { name = "Phï chñ §Ò ngµy*6, ", ID = { 6, 1, 1872, 0 }, count = 6 },
            [2] = { name = "¸ß¼¶×°±¸¾«»ê*1, ", ID = { 8, 1951, 2, 0 }, count = 1 },
            [3] = { name = "Ngäc Thanh Toµn Gia Phóc tiªn hµox1, ", ID = { 8, 1807, 2, 0 }, count = 1 },
            [4] = { name = "§¹i lÔ h¹p Håi quy*1.", ID = { 8, 2183, 2, 0 }, count = 1 },
    },
}

g_BuyList = {
    { name = "³éTói Nh­ ı", fun = "buyRuyidai", ID = { 8, 1454, 2, 0 }, oldCfs = "1 c¸i Tói Nh­ ıÎª1 Linh B¶o", cIdx = 304, count = 1 },
    { name = "Méc Nh©nx2", fun = "buySelMain", ID = { 8, 174, 2, 0 }, oldCfs = "3.00¡Á2", cIdx = 23, count = 2 },
    { name = "ThÎ Kim DËtx1", fun = "buySelMain", ID = { 8, 1316, 4, 0 }, oldCfs = "15.00", cIdx = 195, count = 1 },
    { name = "¸ß¼¶ÎäÆ÷¾«»êx1", fun = "buySelMain", ID = { 8, 1950, 2, 0 }, oldCfs = "699.00", cIdx = 305, count = 1 },
    { name = "Vò khİ Tinh Hoa (cao)x1", fun = "buySelMain", ID = { 8, 372, 2, 0 }, oldCfs = "699.00", cIdx = 305, count = 1 },
    { name = "Vò khİ Tinh Nguyªn (cao)x1", fun = "buySelMain", ID = { 8, 283, 2, 0 }, oldCfs = "399.00", cIdx = 307, count = 1 },
    { name = "Trang bŞ Tinh Hoa (cao)x1", fun = "buySelMain", ID = { 8, 373, 2, 0 }, oldCfs = "599.00", cIdx = 306, count = 1 },
    { name = "Trang bŞ Tinh Nguyªn (cao)x1", fun = "buySelMain", ID = { 8, 284, 2, 0 }, oldCfs = "299.00", cIdx = 308, count = 1 },
    { name = "ThÎ b¹c LuyÖn Hån Phïx2", fun = "buySelMain", ID = { 8, 1680, 2, 0 }, oldCfs = "22.00x2", cIdx = 196, count = 2 },
    { name = "Tinh Hoa Tiªn Sñngx1", fun = "buySelMain", ID = { 3, 1634, 0, 0 }, oldCfs = "249.00", cIdx = 290, count = 1 },
    { name = "B¶o r­¬ng Phï Th¹chx1", fun = "buySelMain", ID = { 8, 1776, 2, 0 }, oldCfs = "50.00", cIdx = 265, count = 1 },
    { name = "Khİ Linh Tinh Tóy¡Á4", fun = "buySelMain", ID = { 3, 1242, 0, 0 }, oldCfs = "20.00", cIdx = 278, count = 4 },
    { name = "S¬ cÊp Chİ T«n Tinh tuş¡Á1", fun = "buySelMain", ID = { 8, 1716, 2, 1 }, oldCfs = "15.00", cIdx = 257, count = 1 },
    { name = "S¬ cÊp Chİ T«n Tinh nguyªn¡Á1", fun = "buySelMain", ID = { 8, 1717, 2, 1 }, oldCfs = "49.00", cIdx = 258, count = 1 },
    { name = "S¬ cÊp Chİ T«n Tinh hoa¡Á1", fun = "buySelMain", ID = { 8, 1718, 2, 1 }, oldCfs = "169.00", cIdx = 259, count = 1 },
    { name = "Cao cÊp Chİ T«n Tinh Tuş¡Á1", fun = "buySelMain", ID = { 8, 2031, 2, 1 }, oldCfs = "49.00", cIdx = 295, count = 1 },
    { name = "Cao cÊp Chİ T«n Tinh nguyªn¡Á1", fun = "buySelMain", ID = { 8, 2032, 2, 1 }, oldCfs = "129.00", cIdx = 296, count = 1 },
    { name = "Cao cÊp Chİ T«n Tinh hoa¡Á1", fun = "buySelMain", ID = { 8, 2033, 2, 1 }, oldCfs = "499.00", cIdx = 297, count = 1 },


}

function main(nLevel, nTime, nTNpcIdx, itemID)
    no()

    local temp = GetGlobalStoreValueByte(25, 2)
    if (GetBit(temp, 7) == 1) then
        G_GlobalMax = 100
    elseif (UActivitie.back_IsGetGift() == 0) then
        Talk(1, "no", "ThËt xin lçi, Äã²»ÊÇ»Ø¹éÕß, »Ø¹éÀñºĞ×÷·Ï±»ÊÕ»Ø!")
        DelItemByID(itemID)
        WriteLog("[Ho¹t ®éng håi quy][»Ø¹éÀñ°ü][Òì³£²»ÊÇ»Ø¹éÕßÊÕ»Ø]")
        return 0
    end

    local tasks = {
        { "Ã¿ÈÕ¸£Àû", "feeGetGift"; show = 1 },
        { "ÓÅ»İ¹º", "buyItemGeft"; show = 1 },
    }
    SayTask("[Ã¿ÈÕ¸£Àû]: ÔÚÀñ°üÓĞĞ§ÆÚÄÚ, Ã¿Ìì¿ÉÒÔ¿ªÆôÒ»´Î, Ã¿´Î½±Æ·¶¼²»Ò»Ñù, ËùÓĞµÀ¾ß½ÔÊÇ°ó¶¨µÄ\n[ÓÅ»İ¹º]: ËùÓĞÓÅ»İ¹ºÂòµÄµÀ¾ß¶¼ÊÇ°ó¶¨.ÇëÑ¡ÔñÄãĞèÒªµÄ¹¦ÄÜ:", tasks)
end

function feeGetGift()
    no()
    local nLeftTimes = GetTaskByte(2285, 4) + 1
    if (nLeftTimes > g_ItemMax) then
        InfoBox("ThËt xin lçi, »Ø¹éÀñºĞÒÑ¾­Ê¹ÓÃÁË<c=r>" .. g_ItemMax .. "´Î<c>, ¸ÃÀñºĞ1 ngµy ¿ÉÊ¹ÓÃÒ»´Î, Ò»¹²¿ÉÊ¹ÓÃ" .. g_ItemMax .. "lÇn!")
        return 0
    end

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    local temp = GetTaskWord(2286, 2)
    if (GetByte(temp, 2) == today) then
        Talk(1, "no", "ThËt xin lçi, »Ø¹éÀñ°ü mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    local listTemp = g_ItemList[nLeftTimes]
    if (IsHaveSpaceForTreasure(listTemp.bag + 1) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã" .. listTemp.bag .. "¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end

    SetTaskWord(2286, 2, SetByte(temp, 2, today))
    SetTaskByte(2285, 4, nLeftTimes)

    local list = {}
    local strlog = ""
    for i = 1, listTemp.num do

        list = listTemp[i]
        if (list.count == 0) then
            AddIBBuff(list.ID[1], list.ID[2])
        else
            for j = 1, list.count do
                AddNormalItemBind(list.ID[1], list.ID[2], list.ID[3], list.ID[4], 0, 0, 1)
            end
        end

        strlog = strlog .. list.name
    end

    Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÂúĞÄ»¶Ï²µÄ më »Ø¹éÀñ°ü, nhËn ®­îc ´óÁ¿ÀñÆ·!Öú¾ıÖØ·µÉ³³¡, ³Æ°Ô·âÉñÖ¸ÈÕ¿É´ı!")
    Msg2Player("¹§Ï²ÄúµÚ" .. nLeftTimes .. "Ìì, nhËn ®­îc : " .. strlog)
    Talk(1, "no", "¹§Ï²ÄúµÚ" .. nLeftTimes .. "Ìì´ò¿ª»Ø¹éÀñ°ü, nhËn ®­îc : " .. strlog)
    WriteLog("[Ho¹t ®éng håi quy][»Ø¹éÀñ°ü]µÚ" .. nLeftTimes .. "Ngµy" .. strlog)
end

function no()
    CloseDialog()
end;

function buyItemGeft()
    no()
    local tasks = {}
    for i = 1, table.getn(g_BuyList) do
        tasks[i] = g_BuyList[i].name .. "/" .. g_BuyList[i].fun
    end
    Say("ÇëÑ¡ÔñÄãÒª¹ºÂòµÄµÀ¾ß, ËùÓĞµÀ¾ß¶¼ÊÇÒÑ°ó¶¨µÄ: ", table.getn(tasks), tasks)
end

function buySelMain(idx)
    no()
    idx = idx + 1
    if (idx <= 0) or (idx > table.getn(g_BuyList)) then
        buyItemGeft()
        TopMessage("Sè liÖu bÊt th­êng, xin h·y chän l¹i")
        return 0
    end

    local temp = g_BuyList[idx]
    SetTask(140, idx)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(temp.cIdx)
    MsgBox("<c=y>" .. temp.name .. "<c>: Ô­¼Û" .. temp.oldCfs .. " Th«ng B¶o, ÏÖ¼Û<c=g>" .. Cfs .. " Th«ng B¶o<c>, Àñ°üÄÚµÀ¾ß½ÔÎª°ó¶¨µÄ, ÄãÏÖÔÚÒª¹ºÂòÃ´?", "Yes_shop1", "no")
end

function Yes_shop1()
    no()
    local idx = GetTask(140)
    if (idx <= 0) or (idx > table.getn(g_BuyList)) then
        buyItemGeft()
        TopMessage("Sè liÖu bÊt th­êng, xin h·y chän l¹i")
        return 0
    end

    local temp = g_BuyList[idx]
    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang kh«ng ®ñ 2 « trèng, vui lßng s¾p xÕp l¹i.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(temp.cIdx)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, <c=r>" .. temp.name .. "<c> cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(temp.cIdx) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, mua <c=r>" .. temp.name .. "<c>Ê§°Ü!")
        return
    end

    for i = 1, temp.count do
        AddNormalItemBind(temp.ID[1], temp.ID[2], temp.ID[3], temp.ID[4], 0, 0, 1)
    end
    Talk(1, "no", "B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁË" .. temp.name .. ".")
    Msg2Player("B¹n bá ra  " .. Cfs .. " Th«ng B¶o¹ºÂòÁË" .. temp.name)
    WriteLog("[Ho¹t ®éng håi quy][»Ø¹éÀñ°ü]tiªu phİ " .. Cfs .. " Th«ng B¶o mua " .. temp.name)
end

function buyRuyidai()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(304)
    MsgBox("<c=y>³éTói Nh­ ı»î¶¯<c>: »¨·Ñ<c=g>" .. Cfs .. "<c> Th«ng B¶oÓĞ»ú»á³éµ½ 30 c¸i Tói Nh­ ı!1 c¸i Tói Nh­ ı¿ÉÒÔ¶Ò»»1 Linh B¶o\nÃ¿Ìì´ÓÔçÉÏ6: 00µ½Ò¹Àï1: 59ÎªÖ¹, È«ÇøÃ¿¸ö giêÏŞ" .. G_GlobalMax .. "´Î, ÏÈµ½ÏÈµÃ.ÄãÏÖÔÚÒª³é sao?", "Yes_Ruyidai", "no")
end

function Yes_Ruyidai()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ 1 «, h·y ®Õn sau nhĞ.")
        return
    end

    local h, m, s = GetHMS()
    if (h >= 2) and (h < 6) then
        Talk(1, "no", "ThËt xin lçi, Ã¿Ìì´ÓÔçÉÏ6: 00µ½Ò¹Àï1: 59ÎªÖ¹, È«ÇøÃ¿¸ö giêÏŞ" .. G_GlobalMax .. "´Î, ÏÈµ½ÏÈµÃ.")
        return
    end

    local hh = GetGlobalValueByte(674, 1)
    if (hh ~= h) then
        SetGlobalValueByte(674, 1, h)
        SetGlobalValue(675, 0)
    end

    local total = GetGlobalValue(675) + 1
    if (total > G_GlobalMax) then
        Talk(1, "no", "ThËt xin lçi, Ã¿Ìì´ÓÔçÉÏ6: 00µ½Ò¹Àï1: 59ÎªÖ¹, È«ÇøÃ¿¸ö giêÏŞ" .. G_GlobalMax .. "´Î, ÏÈµ½ÏÈµÃ.")
        return
    end

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(304)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, ³éTói Nh­ ı cÇn <c=r>" .. Cfs .. "<c> Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    if (CostCoinByIdx(304) <= 0) then
        Talk(1, "no", "ThËt xin lçi, ÄúµÄÍ¨±¦²»×ã, ¿Û·ÑÊ§°Ü!")
        return
    end

    SetGlobalValue(675, total)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (GetGlobalValueByte(674, 2) ~= today) then
        SetGlobalValueByte(674, 2, today)
        SetGlobalValueByte(674, 3, 0)
    end

    local LuckList = { { 5, 30 }, { 10, 25 }, { 15, 20 }, { 20, 15 }, { 25, 9 }, { 30, 1 } }
    local rLuck = math.random(1, 100)
    local id = 1454
    local num = 5
    local nAll = 0
    for i = 1, table.getn(LuckList) do
        nAll = nAll + LuckList[i][2]
        if (rLuck <= nAll) then
            num = LuckList[i][1]
            break
        end
    end

    local cishu = GetGlobalValueByte(674, 3) + 1
    local isBand = 1
    local str = ""
    local name = "»Ø¹éÕß"
    local temp = GetGlobalStoreValueByte(25, 2)
    if (GetBit(temp, 7) == 1) then
        name = "Ó¢ĞÛ"
    end

    if (cishu <= 20) and (math.random(1, 1000) == 888) then
        id = 1393
        isBand = 0
        str = "¿É½»Ò×µÄ"
        SetGlobalValueByte(674, 3, cishu)
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ³éTói Nh­ ı, ¹§Ï²»ñµÃ<c=y>¿É½»Ò×µÄ" .. num .. " c¸i<c>Tói Nh­ ı, ±¾ giêÊ£ÓàÊıÁ¿Îª<c=g>" .. (G_GlobalMax - total) .. "<c> lÇn.")
    elseif (num > 15) then
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c>ÔÚ³éTói Nh­ ı, ¹§Ï²»ñµÃ<c=y>" .. num .. " c¸i<c>Tói Nh­ ı, ±¾ giêÊ£ÓàÊıÁ¿Îª<c=g>" .. (G_GlobalMax - total) .. "<c> lÇn.")
    end

    for i = 1, num do
        AddNormalItemBind(8, id, 2, 0, 0, 0, isBand)
    end

    ScrollMessage("³éµ½<c=y>" .. num .. "." .. str .. "<c>Tói Nh­ ı")
    Msg2Player("Chóc m­õng ngµi ³éµ½[" .. num .. " c¸i]" .. str .. "Tói Nh­ ı, xin nhËn lÊy!")
    Talk(1, "no", "Chóc m­õng ngµi ³éµ½<c=y>" .. num .. "." .. str .. "<c>Tói Nh­ ı, xin nhËn lÊy!")
    WriteLog("[Ho¹t ®éng håi quy][³éTói Nh­ ı]" .. num .. "." .. str .. "È«Çø: " .. total)
end
