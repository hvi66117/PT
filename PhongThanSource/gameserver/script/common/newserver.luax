module("NewServerEx", package.seeall)

g_Task_HadNowGiftBox = 2062
g_Task_Box2 = 2101
g_Task_HadNowBox = 2064

g_ServerName = "§«ng H¶i"
petname = "Lôc ¸p §¹o Nh©n"
PetIdx = 1

g_Time = { { 2021, 10, 22 }, { 2021, 11, 25 } }
g_Time2 = { { 2021, 11, 26 }, { 2021, 12, 26 } }

g_Id = { 6, 1, 1425, 1 }
g_Id2 = { 6, 1, 1464, 1 }
g_IdBox = { 6, 1, 1148, 1 }

g_Text = "Ç×°®µÄÍæ¼Ò:\nÐÂ·þ¡°" .. g_ServerName .. "¡±Ð¯·á¸»»î¶¯µ½À´!È«ÐÂÊôÐÔÁé³èÀ´Ï®, ¸üÇ¿ÊØ»¤¼Ó³Ö.<Õ½>ÆÆ¾üÐ¬, ÆÆ¾üÍ¼Æ×, ¸÷ÖÖØÔ·ûÕâÀï¶¼ÓÐ!Çë±£´æºÃ¸½¼þÖÐµÄÀñºÐ.¼ÇµÃ³£³£¿´¿´ËüÅ¶!"

g_TimeLevel = { { 2021, 10, 22 }, { 2021, 11, 25 } }
g_TimeBox = { { 2021, 10, 22 }, { 2021, 11, 25 } }
g_TimeCard = { { 2021, 10, 22 }, { 2021, 11, 25 } }
g_TimeGift = { { 2021, 10, 19 }, { 2021, 11, 13 } }
g_TimeFuTouBang = { { 2015, 12, 17 }, { 2016, 1, 17 } }
g_TimeTeQuanKa = { { 2016, 06, 24 }, { 2016, 09, 24 } }
g_HuiLiuTime = { { 2016, 09, 23 }, { 2016, 10, 23 } }
g_CreateTongTime = { { 2021, 10, 22 }, { 2021, 11, 25 } }
g_BuyCreateTongBook = { { 2021, 11, 1 }, { 2021, 11, 25 } }
g_TongMonkeyTime = { { 2021, 10, 22 }, { 2021, 11, 25 } }

g_PetTime = { { 2021, 12, 27 }, { 2021, 12, 31 } }
g_PetPiles = { { 2021, 10, 22 }, { 2021, 12, 26 } }
g_GuaFuBox = { { 2021, 06, 18 }, { 2021, 06, 24 } }

g_DuBaWanXian = { { 2021, 11, 26 }, { 2021, 12, 5 } }
g_GongLiTime = { { 2018, 02, 19 }, { 2018, 02, 22 } }
IsOpenGongLiSongLi = 1
IsOpenChongJiSongLi = 0
IsOpenBuyCreatTongBook = 0
IsOpenGongLiHaoLiAll = 0

function Pub_IsNewServer()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_Time[1][1], g_Time[1][2], g_Time[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_Time[2][1], g_Time[2][2], g_Time[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewServerTime2()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_Time2[1][1], g_Time2[1][2], g_Time2[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_Time2[2][1], g_Time2[2][2], g_Time2[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewLevel()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeLevel[1][1], g_TimeLevel[1][2], g_TimeLevel[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeLevel[2][1], g_TimeLevel[2][2], g_TimeLevel[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewPromotion()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeGift[1][1], g_TimeGift[1][2], g_TimeGift[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeGift[2][1], g_TimeGift[2][2], g_TimeGift[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewBox()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeBox[1][1], g_TimeBox[1][2], g_TimeBox[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeBox[2][1], g_TimeBox[2][2], g_TimeBox[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewServerCreateTongTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_CreateTongTime[1][1], g_CreateTongTime[1][2], g_CreateTongTime[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_CreateTongTime[2][1], g_CreateTongTime[2][2], g_CreateTongTime[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewCard()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeCard[1][1], g_TimeCard[1][2], g_TimeCard[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeCard[2][1], g_TimeCard[2][2], g_TimeCard[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewFuTouBang()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeFuTouBang[1][1], g_TimeFuTouBang[1][2], g_TimeFuTouBang[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeFuTouBang[2][1], g_TimeFuTouBang[2][2], g_TimeFuTouBang[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsCreateTongBookTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_BuyCreateTongBook[1][1], g_BuyCreateTongBook[1][2], g_BuyCreateTongBook[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_BuyCreateTongBook[2][1], g_BuyCreateTongBook[2][2], g_BuyCreateTongBook[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsTongMonkeyTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TongMonkeyTime[1][1], g_TongMonkeyTime[1][2], g_TongMonkeyTime[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TongMonkeyTime[2][1], g_TongMonkeyTime[2][2], g_TongMonkeyTime[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsNewTeQuanKa()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_TimeTeQuanKa[1][1], g_TimeTeQuanKa[1][2], g_TimeTeQuanKa[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_TimeTeQuanKa[2][1], g_TimeTeQuanKa[2][2], g_TimeTeQuanKa[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_SendGiftBox()

    if not (Pub_IsNewServer() > 0) then
        return
    end

    if (GetTask(g_Task_HadNowGiftBox) ~= g_Id[3]) then
        SetTask(g_Task_HadNowGiftBox, g_Id[3])

        local playerName = GetName()
        SendSysItemMailToTarget("Hép th­", playerName, "ÐÂ·þÌØ¹©¸£Àû", g_Text, g_Id[1], g_Id[2], g_Id[3], g_Id[4], 0, 0)
        local str = GetNormalItemName(g_Id[1], g_Id[2], g_Id[3], g_Id[4])
        Msg2Player("ÄúÓÐÐÂÓÊ¼þÇë×¢Òâ²é¿´.")
        WriteLog("[" .. playerName .. " nhËn ®­îc " .. str .. "]")
    end
end

function Pub_SendGiftBox2()
    if not (Pub_IsNewServerTime2() > 0) then
        return
    end

    if (GetTaskByte(g_Task_Box2, 1) ~= 2 and HaveNormalItem(g_Id2[1], g_Id2[2], g_Id2[3], g_Id2[4]) == 0) then
        SetTaskByte(g_Task_Box2, 1, 2)

        local playerName = GetName()
        SendSysItemMailToTarget("Hép th­", playerName, "ÐÂ·þÌØ¹©¸£Àû", g_Text, g_Id2[1], g_Id2[2], g_Id2[3], g_Id2[4], 0, 0)
        local str = GetNormalItemName(g_Id2[1], g_Id2[2], g_Id2[3], g_Id2[4])
        Msg2Player("ÄúÓÐÐÂÓÊ¼þÇë×¢Òâ²é¿´.")
        WriteLog("[" .. playerName .. "NhËn ®­îc " .. str .. "]")
    end
end

function Pub_SendBox()

    if not (Pub_IsNewBox() > 0) then
        return
    end

    if (GetTask(g_Task_HadNowBox) ~= g_IdBox[3]) then
        SetTask(g_Task_HadNowBox, g_IdBox[3])

        local playerName = GetName()
        SendSysItemMailToTarget("Hép th­", playerName, "ÐÂ·þÌØ¹©¸£Àû", g_Text, g_IdBox[1], g_IdBox[2], g_IdBox[3], g_IdBox[4], 0, 0)
        local str = GetNormalItemName(g_IdBox[1], g_IdBox[2], g_IdBox[3], g_IdBox[4])
        Msg2Player("ÄúÓÐÐÂÓÊ¼þÇë×¢Òâ²é¿´.")
        WriteLog("[" .. playerName .. "NhËn ®­îc " .. str .. "]")
    end
end

function no()
    CloseDialog()
end

function Pub_IsWanXianTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local time1 = LocalYMD2Time(g_DuBaWanXian[1][1], g_DuBaWanXian[1][2], g_DuBaWanXian[1][3]) - SystemTime()
    local time2 = LocalYMD2Time(g_DuBaWanXian[2][1], g_DuBaWanXian[2][2], g_DuBaWanXian[2][3] + 1) - SystemTime()
    if (time1 <= 0 and time2 > 0) then
        return time2
    end
    return 0
end

function Pub_IsExpectTongFlagTime()
    local yr, mo, day = GetYMD()
    local OpenTime = GetGlobalStoreValue(74)
    local CloseTime = GetGlobalStoreValue(75)
    if mo < 10 then
        mo = "0" .. mo
    end
    if day < 10 then
        day = "0" .. day
    end
    local NowTime = string.format("%s%s%s", yr, mo, day)
    OpenTime = string.format("%s", OpenTime)
    CloseTime = string.format("%s", CloseTime)
    if (NowTime >= OpenTime and NowTime <= CloseTime) then
        return 1
    else
        return 0
    end
end

PetPiles = {
    { name = "ËéÆ¬¡¤ÍòÏÉ", rand = 10, bit = 3, taskId = { 2196, 3 }, success = 150 },
    { name = "ËéÆ¬¡¤ÁúÖé", rand = 30, bit = 4, taskId = { 2196, 4 }, success = 60 },
    { name = "ËéÆ¬¡¤ÁÔÂí", rand = 50, bit = 5, taskId = { 2197, 1 }, success = 30 },
    { name = "ËéÆ¬¡¤Ï´Á¶", rand = 50, bit = 6, taskId = { 2197, 2 }, success = 50 },
    { name = "ËéÆ¬¡¤ÂÞÉ²", rand = 100, bit = 7, taskId = { 2197, 3 }, success = 15 },
    { name = "ËéÆ¬¡¤ÔÔÅà", rand = 200, bit = 8, taskId = { 2197, 4 }, success = 10 },
    { name = "ËéÆ¬¡¤Öîºî", rand = 20, bit = 9, taskId = { 2198, 1 }, success = 80 },
    { name = "ËéÆ¬¡¤³É³¤", rand = 200, bit = 10, taskId = { 2198, 2 }, success = 8 },
    { name = "ËéÆ¬¡¤ºÃÔË", rand = 1, bit = 11, taskId = { 458, -1 }, success = 1500 },
    { name = "ËéÆ¬¡¤¹¥³Ç", rand = 100, bit = 12, taskId = { 2198, 4 }, success = 200 },
}

function Pet_GetPilesTask(nIndex)
    if (GetTaskBit(2196, PetPiles[nIndex].bit) == 1) then
        return
    end

    if (Pet_IsPilesTime() == 0) then
        return
    end

    local nID = PetPiles[nIndex].taskId
    local total = 0
    if (nID[2] <= 0) then
        total = GetTask(nID[1]) + 1
        SetTask(nID[1], total)
    else
        total = GetTaskByte(nID[1], nID[2]) + 1
        SetTaskByte(nID[1], nID[2], total)
    end

    if (total >= PetPiles[nIndex].success) then
        SetTaskBit(2196, PetPiles[nIndex].bit, 1)
        ScrollMessage("NhËn ®­îc <c=y>" .. PetPiles[nIndex].name)
        Msg2Player("Chóc m­õng ngµi »ñÀûÁË" .. PetPiles[nIndex].name .. ", ÒÑ¾­·ÅÈëËéÆ¬ÊÕ¼¯Æ÷ÄÚ, ¿ÉÒÔËæÊ±ÓÒ¼ü²é¿´.")
        WriteLog("[Ho¹t ®éng m¸y chñ míi][ËéÆ¬ÊÕ¼¯Æ÷][ËéÆ¬³É¹¦][ÊÕ¼¯" .. PetPiles[nIndex].name .. "]ÀÛ¼Æ" .. total)
    else
        local r = math.random(1, 1000)
        if (r <= PetPiles[nIndex].rand) then
            SetTaskBit(2196, PetPiles[nIndex].bit, 1)
            ScrollMessage("NhËn ®­îc <c=y>" .. PetPiles[nIndex].name)
            Msg2Player("Chóc m­õng ngµi »ñÀûÁË" .. PetPiles[nIndex].name .. ", ÒÑ¾­·ÅÈëËéÆ¬ÊÕ¼¯Æ÷ÄÚ, ¿ÉÒÔËæÊ±ÓÒ¼ü²é¿´.")

            WriteLog("[Ho¹t ®éng m¸y chñ míi][ËéÆ¬ÊÕ¼¯Æ÷][ËéÆ¬³É¹¦][ÊÕ¼¯" .. PetPiles[nIndex].name .. "]ÀÛ¼Æ" .. total)
        else
            WriteLog("[Ho¹t ®éng m¸y chñ míi][ËéÆ¬ÊÕ¼¯Æ÷][Êµ¼ÊÖµ" .. r .. "/³É¹¦Öµ<=" .. PetPiles[nIndex].rand .. "][ÊÕ¼¯" .. PetPiles[nIndex].name .. "]ÀÛ¼Æ" .. total)
        end

    end
end

function Pet_IsPilesTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local y, m, d = GetYMD()
    local OpenTime = g_PetPiles[1][1] * 10000 + g_PetPiles[1][2] * 100 + g_PetPiles[1][3]
    local CloseTime = g_PetPiles[2][1] * 10000 + g_PetPiles[2][2] * 100 + g_PetPiles[2][3]
    local today = y * 10000 + m * 100 + d
    if (today >= OpenTime) and (today <= CloseTime) then
        return 1
    end
    return 0
end

function Pet_IsPilesCardTime()
    if not (GetGameServerName() == g_ServerName) then
        return 0
    end
    local y, m, d = GetYMD()
    local CloseTime = g_PetTime[2][1] * 10000 + g_PetTime[2][2] * 100 + g_PetTime[2][3]
    local today = y * 10000 + m * 100 + d
    if (today <= CloseTime) then
        return 1
    end
    return 0
end

function Pub_IsGongLiTime()
    local key = 1
    if (GetGameServerName() == g_ServerName) then
        key = 10
    end
    local y, m, d = GetYMD()
    local OpenTime = g_GongLiTime[1][1] * 10000 + g_GongLiTime[1][2] * 100 + g_GongLiTime[1][3]
    local CloseTime = g_GongLiTime[2][1] * 10000 + g_GongLiTime[2][2] * 100 + g_GongLiTime[2][3]
    local today = y * 10000 + m * 100 + d
    if (today > OpenTime) and (today <= CloseTime) then
        key = key + 1
        return key
    elseif (today > CloseTime) then
        return key
    end
    return 0
end
