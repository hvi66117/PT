require("common.luax")

gFriendItemID1 = { 6, 1, 1522, 0 }
Task_Friend_Day = 2156
Task_Friend_PartnerID = 2157
Task_Friend_Coin = 2158
Task_Friend_AllBindCoin = 2159
Task_Friend_BindCoin = 2160
MAX_DAY = 28
LIMIT_DAY = 7
LIMITMAX_ALLBINDCOIN = 1000000
MAX_ALLBINDCOIN = 200000
LIMIT_MAX = 999900
LIMIT_MIN = 99900

function main()
    local tasks = {
        { "NhËn phóc lîi hoµn tr¶", "get_bindcoin"; show = 0 },
        { "Huû thÎ phóc lîi", "clearkar"; show = 0 },
        { "Giíi thiÖu thÎ phóc lîi", "shuoming"; show = 1 },
    }

    local str = nReSetTask()
    local nAll = GetTask(Task_Friend_AllBindCoin)
    local nNow = GetTask(Task_Friend_BindCoin)
    local cfs1 = COMMON.isShowCoinString(nNow)
    local cfs = COMMON.isShowCoinString(nAll)
    local fs = COMMON.isShowCoinString(GetTask(Task_Friend_Coin))
    local str1 = "\nTheo thèng kª tõ B¸t B¶o C¸c, t¹i kú chİ h÷u lÇn nµy: \nNg­¬i ®· tİch lòy tiªu phİ: " .. fs .. " Th«ng B¶o"

    if (nAll >= MAX_ALLBINDCOIN) then
        if (nNow >= MAX_ALLBINDCOIN) then
            str = "\nT¹i kú chİ h÷u lÇn nµy, ®· nhËn phóc lîi tèi ®a. NÕu muèn lµm míi phóc lîi Linh B¶o cã thÓ cïng h¶o h÷u <c=y>tæ ®éi gi¶i trõ quan hÖ, vµ KÕt thµnh chİ h÷u l¹i lÇn n÷a<c>." .. str1
        else
            str = str .. "\n<c=y>Phóc lîi ®· nhËn<c>/Phóc lîi tİch lòy: <c=y>" .. cfs1 .. "<c>/<c=g>" .. cfs .. "<c> Linh B¶o (Tèi ®a lµ " .. math.floor(MAX_ALLBINDCOIN / 100) .. ")" .. str1
        end
    elseif (nAll >= MAX_ALLBINDCOIN / 2) then
        str = str .. "\nÄã<c=y>Phóc lîi ®· nhËn<c>/Phóc lîi tİch lòy: <c=y>" .. cfs1 .. "<c>/<c=g>" .. cfs .. "<c> Linh B¶o (Tèi ®a lµ " .. math.floor(MAX_ALLBINDCOIN / 100) .. ")" .. str1
    else
        str = str .. "\nÄã<c=y>Phóc lîi ®· nhËn<c>/Phóc lîi tİch lòy: <c=y>" .. cfs1 .. "<c>/<c=g>" .. cfs .. "<c> Linh B¶o " .. str1
    end

    if (nAll - nNow > 0) then
        tasks[1].show = 1
    elseif (GetTaskWord(Task_Friend_Day, 1) <= 0) then
        str = str .. "\n<c=r>kú chİ h÷u nµy ®· hoµn thµnh nhËn phóc lîi, cã thÓ bÊm [Huû thÎ phóc lîi] t¹i ThÎ hoµn tr¶ Chİ H÷u."
        tasks[2].show = 1
    end
    SayTask(str, tasks)
end

function no()
    CloseDialog()
end

function shuoming()
    Talk(2, "shuoming1", "Trong thêi gian lµm chİ h÷u kh«ng thÓ huû quan hÖ chİ h÷u vµ tèi ®a chØ cã 1 chİ h÷u, Linh B¶o hoµn tr¶ nhËn ®­îc th«ng qua thÎ nµy, <c=y>Mçi ngµy tèi ®a tÊt to¸n 1 lÇn tiªu phİ<c>, ph¶i chê ®èi ph­¬ng tÊt to¸n míi cã thÓ nhËn hoµn tr¶!", "Sau khi quan hÖ chİ h÷u kÕt thóc sÏ cã <c=g>7 ngµy<c> b¶o hé; trong thêi gian nµy <c=r>kh«ng cã hoµn tr¶ tiªu phİ<c>, kh«ng thÓ kÕt chİ h÷u míi, trõ khi 2 bªn ®· hoµn thµnh nhËn phóc lîi.\nCã thÓ tra xem sè Th«ng B¶o tiªu phİ trong kú, sè Linh B¶o nhËn ®­îc vµ trùc tiÕp nhËn phóc lîi.")
end

function shuoming1()
    CloseDialog()
    Talk(1, "main", "C«ng thøc tİnh Linh B¶o hoµn tr¶: \n<c=g>1-999<c> Th«ng B¶o, cã thÓ h­ëng <c=y>5%<c> hoµn tr¶\n<c=g>1000-9999<c> Th«ng B¶o, cã thÓ h­ëng <c=y>6%<c> hoµn tr¶\n<c=g>10000 trë lªn<c> Th«ng B¶o, cã thÓ h­ëng <c=y>7%<c> hoµn tr¶.\nPh­¬ng ph¸p tİnh dùa trªn ®iÓm vµ lµm trßn xuèng, chØ trong thêi gian chİ h÷u tiªu phİ míi nhËn ®­îc hoµn tr¶!")
end

function get_bindcoin()
    CloseDialog()

    local nAll = GetTask(Task_Friend_AllBindCoin)

    local cnAll = COMMON.isShowCoinString(nAll)
    if (nAll > MAX_ALLBINDCOIN) then
        WriteLog("[Chİ h÷u][ThÎ]NhËn Linh B¶o giíi h¹n ph¸t sinh lçi, söa l¹i gi¸ trŞ : " .. cnAll)
        nAll = MAX_ALLBINDCOIN
        SetTask(Task_Friend_AllBindCoin, nAll)
    end

    local nBindCoin = nAll - GetTask(Task_Friend_BindCoin)
    if (nBindCoin > 0) then
        SetTask(Task_Friend_BindCoin, nAll)
        local cfs = COMMON.isShowCoinString(nBindCoin)
        AddBindCoin(nBindCoin)
        Msg2Player("Ng­¬i nhËn ®­îc " .. cfs .. " Linh B¶o")
        WriteLog("[Chİ h÷u][ThÎ][NhËn Linh B¶o ]" .. cfs .. "[Tæng Linh B¶o]" .. cnAll)
        if (GetTask(Task_Friend_Day) == 0) then
            Talk(1, "no", "§©y lµ <c=g>" .. cfs .. "<c> Linh B¶o, xin nhËn lÊy!\nTrong thêi gian lµm chİ h÷u, nÕu tÊt c¶ phóc lîi ®· nhËn hÕt, cã thÓ tíi t×m ta kÕt quan hÖ chİ h÷u míi")
        else
            Talk(1, "no", "§©y lµ <c=g>" .. cfs .. "<c> Linh B¶o, xin nhËn lÊy!\nMçi ngµy tèi ®a tÊt to¸n 1 lÇn tiªu phİ, ph¶i chê ®èi ph­¬ng tÊt to¸n míi cã thÓ nhËn hoµn tr¶, ngµy mai l¹i tíi nhĞ")
        end
    else
        Talk(1, "no", "ThËt xin lçi, Linh B¶o cña ngµi ®· hÕt")
        WriteLog("[Chİ h÷u][ThÎ][NhËn Linh B¶o bÊt th­êng]" .. nBindCoin)
    end

end

function nReSetTask()
    local fday = GetTaskWord(Task_Friend_Day, 1)
    local lastday = GetTaskWord(Task_Friend_Day, 2)
    local thisday = math.floor(LocalSystemTime() / 86400)
    local leftDay = 28 - thisday + fday
    local strLeftday = "<c=r>Thêi gian chİ h÷u ®· hÕt, tiÕp tôc tiªu phİ kh«ng nhËn ®­îc thªm phóc lîi hoµn tr¶.<c>"
    if (leftDay > 0) then
        strLeftday = "HiÖn chİ h÷u cßn <c=y>" .. leftDay .. " ngµy<c>, sau"
    end

    local str = strLeftday .. " dùa trªn tÊt to¸n chİ h÷u lÇn tr­íc: "

    if (fday == 0) then
        return strLeftday
    elseif (lastday == thisday) and (thisday < fday + MAX_DAY) then
        return str
    elseif (lastday >= fday + MAX_DAY) then
        return str
    end

    local nPlayerID = GetPlayerID()
    local nPartnerId = GetTask(Task_Friend_PartnerID)
    if (LoadIniInteger(nPartnerId, 1) == nPlayerID) then
        local partnerDay = LoadIniInteger(nPartnerId, 2)
        local key = 0
        if (lastday == 2) and (LoadIniInteger(nPlayerID, 2) == thisday) then
            if (partnerDay == thisday) then
                if (partnerDay >= fday + MAX_DAY) then
                    SetTask(Task_Friend_Day, 0)
                    SetTask(Task_Friend_PartnerID, 0)
                else
                    SetTaskWord(Task_Friend_Day, 2, thisday)
                end
            elseif (partnerDay < fday + MAX_DAY) then
                return str
            else
                SetTask(Task_Friend_Day, 0)
                SetTask(Task_Friend_PartnerID, 0)
            end
        elseif (thisday < fday + MAX_DAY) then
            if (thisday < fday) then
                WriteLog("[Chİ h÷u][ThÎ]Thêi gian m¸y chñ bŞ sai " .. thisday)
                SetTask(Task_Friend_Day, thisday)
            end
            SetTaskWord(Task_Friend_Day, 2, 2)
        else
            key = 1
            if (partnerDay >= fday + MAX_DAY) then
                SetTask(Task_Friend_Day, 0)
                SetTask(Task_Friend_PartnerID, 0)
            else
                SetTaskWord(Task_Friend_Day, 2, 2)
            end
        end

        local nCoin = LoadIniInteger(nPartnerId, 3)
        local nBindCoin = 0
        if (nCoin >= LIMIT_MAX) then
            nBindCoin = math.floor((nCoin - LIMIT_MAX) * 7 / 100) + math.floor((LIMIT_MAX - LIMIT_MIN) * 6 / 100) + math.floor(LIMIT_MIN * 5 / 100)
        elseif (nCoin >= LIMIT_MIN) then
            nBindCoin = math.floor((nCoin - LIMIT_MIN) * 6 / 100) + math.floor(LIMIT_MIN * 5 / 100)
        else
            nBindCoin = math.floor(nCoin * 5 / 100)
        end

        if (LoadIniInteger(nPartnerId, 4) == 1) then
            nBindCoin = nBindCoin + math.floor(nCoin * 2 / 100)
        end

        if (nBindCoin > MAX_ALLBINDCOIN) then
            nBindCoin = MAX_ALLBINDCOIN
        end

        local allBindCoin = GetTask(Task_Friend_AllBindCoin)

        local callBindCoin = COMMON.isShowCoinString(allBindCoin)
        local cfs = COMMON.isShowCoinString(nBindCoin)
        local cnCoin = COMMON.isShowCoinString(nCoin)
        if (nBindCoin > allBindCoin) then
            SetTask(Task_Friend_AllBindCoin, nBindCoin)
        elseif (nBindCoin < allBindCoin) then
            SetTask(Task_Friend_AllBindCoin, nBindCoin)
            WriteLog("[Chİ h÷u][ThÎ]bug Linh B¶o, sè hoµn tr¶ thùc tÕ" .. nBindCoin .. " bÊt hîp lÖ: " .. allBindCoin)
        end

        SaveIniInteger(nPlayerID, 2, thisday)
        SaveIniInteger(nPlayerID, 3, GetTask(Task_Friend_Coin))

        if (key == 1) then
            WriteLog("[Chİ h÷u][ThÎ]Th«ng B¶o ®èi ph­¬ng " .. cnCoin .. "Th«ng B¶o cña ta " .. COMMON.isShowCoinString(GetTask(Task_Friend_Coin)))
        else
            WriteLog("[Chİ h÷u][TÊt to¸n hoµn tr¶][ThÎ]Sè th«ng b¶o cña ®èi ph­¬ng" .. cnCoin .. "[Tæng Linh B¶o]" .. cfs .. "Linh B¶o lÇn tr­íc" .. callBindCoin)
        end

    else
        local pIDsd = LoadIniInteger(nPartnerId, 1)
        if (pIDsd ~= 0) then
            if (LoadIniString(nPartnerId, "name") == GetName()) then
                if (LoadIniInteger(nPlayerID, 1) == nPartnerId) then
                    WriteLog("[Chİ h÷u][ThÎ][HÖ thèng tù ®éng söa]D÷ liÖu bŞ mÊt: B¶n th©n " .. nPlayerID .. "/" .. pIDsd .. "id ®ång ®éi:" .. nPartnerId)
                    SaveIniInteger(nPartnerId, 1, nPlayerID)
                    nReSetTask()
                else
                    WriteLog("[Chİ h÷u][ThÎ]D÷ liÖu bŞ mÊt: B¶n th©n " .. nPlayerID .. "/" .. pIDsd .. "id ®ång ®éi:" .. nPartnerId)
                    Msg2Player("ThËt xin lçi, kh«ng thÓ TÊt to¸n hoµn tr¶ chİ h÷u, sè liÖu cña b¹n cã bÊt th­êng, h·y liªn hÖ hç trî ®Ó kh¾c phôc!")
                end
            else
                WriteLog("[Chİ h÷u][ThÎ] gi¶i trõ: B¶n th©n " .. nPlayerID .. "id ®ång ®éi:" .. nPartnerId)
                Msg2Player("Ng­¬i vµ chİ h÷u ®· c­ìng chÕ gi¶i trõ quan hÖ, kh«ng thÓ nhËn Linh B¶o hoµn tr¶. Cã thÓ ®Õn Nhµ Kh¶o Cæ t¹i T©y Kú ®Ó TÊt to¸n hoµn tr¶ chİ h÷u.")
            end
            return str
        end
        ScrollMessage("T¹i <c=g>T©y Kú<c=r> míi cã thÓ tÊt to¸n phóc lîi Linh B¶o hoµn tr¶")
        Msg2Player("ChØ ë <c=y>T©y Kú<c=r> míi cã thÓ tÊt to¸n phóc lîi Linh B¶o hoµn tr¶")
        return str
    end
    str = strLeftday .. " dùa theo chİ h÷u [<c=y>" .. LoadIniString(nPlayerID, "name") .. "<c>] lÇn tÊt to¸n gÇn nhÊt: "
    return str
end

function clearkar()
    CloseDialog()
    TopMessage("ThÎ hoµn tr¶ Chİ H÷u ®· bŞ huû")
    Msg2Player("[ThÎ hoµn tr¶ Chİ H÷u] ®· bŞ huû")
    ClearItem(gFriendItemID1[1], gFriendItemID1[2], gFriendItemID1[3], gFriendItemID1[4])
end
