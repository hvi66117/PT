g_Item = { 6, 1, 1873, 0 }

RewardList = {
    [0] = { Exp = { 0, 0, 0 }, isXM = 1, ExpType = "", },
    [1] = { Exp = { 6000, 12000, 20000 }, isXM = 2, ExpType = "§iÓm tu luyÖn Tiªn Ma", },
    [2] = { Exp = { 12000, 25000, 45000 }, isXM = 2, ExpType = "§iÓm tu luyÖn Tiªn Ma", },
    [3] = { Exp = { 5000, 10000, 18000 }, isXM = 1, ExpType = "×ªÉú¾­Ñé", },
    [4] = { Exp = { 15000, 30000, 50000 }, isXM = 1, ExpType = "×ªÉú¾­Ñé", },
    [5] = { Exp = { 30000, 60000, 100000 }, isXM = 1, ExpType = "×ªÉú¾­Ñé", },
    [6] = { Exp = { 15000, 30000, 50000 }, isXM = 1, ExpType = " kinh nghiÖm", },
    [7] = { Exp = { 30000, 60000, 100000 }, isXM = 1, ExpType = " kinh nghiÖm", },
}
G_Str = { "Ö±½Ó¿ªÆô", "»¨·Ñ5 Th«ng B¶o¿ªÆô", "»¨·Ñ15 Th«ng B¶o¿ªÆô" }
G_Coin = { { 0, -1 }, { 500, 142 }, { 1500, 163 } }

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    SetTask(140, itemID)
    local isNew = GetNewBirthTimes()
    local xmlvl = GetPlayerExtLevel()
    local lvl = GetLevel()
    local idx = 0
    local idxxm = 0
    if (isNew == 0) then
        if (lvl <= 80) then
            Msg2Player("ÄúÎ´Âú cÊp 80 , ÎÞ·¨¿ªÆôÕâ¸öÀñ°ü")
            Talk(1, "no", "ThËt xin lçi, ÄúÎ´Âú cÊp 80 , ÎÞ·¨¿ªÆôÕâ¸öÀñ°ü.")
            return
        elseif (lvl < 120) then
            idx = 6
        elseif (lvl < 200) then
            idx = 7
        end
    else
        if (lvl < 30) then
            idx = 0
        elseif (lvl < 80) then
            idx = 3
        elseif (lvl < 120) then
            idx = 4
        elseif (lvl < 200) then
            idx = 5
        end
    end

    if (xmlvl >= 80) or (xmlvl <= 0) then
        idxxm = 0
    elseif (xmlvl > 30) then
        idxxm = 2
    else
        idxxm = 1
    end
    if (idx == 0) and (idxxm == 0) then
        Msg2Player("ÄúÒÑ¾­Âú¼¶ÁË, ÄúÄ¿Ç°µÄ¾­Ñé/×ªÉú¾­Ñé/ÏÉÄ§¾­Ñé¾ù²»Âú×ãÌáÉýµÄÒªÇó, ÎÞ·¨¿ªÆôÕâ¸öÀñ°ü")
        Talk(1, "no", "ThËt xin lçi, ÄúÄ¿Ç°µÄ¾­Ñé/×ªÉú¾­Ñé/ÏÉÄ§¾­Ñé¾ù²»Âú×ãÌáÉýµÄÒªÇó, ÎÞ·¨¿ªÆôÕâ¸öÀñ°ü.")
        return
    end

    SetTask(142, 0)
    SetTaskByte(142, 1, idx)
    SetTaskByte(142, 2, idxxm)
    local nList = {}
    if (idx >= 3) then
        for i = 1, 3 do
            nList[i] = (lvl * RewardList[idx].Exp[i]) .. RewardList[idx].ExpType .. "(" .. G_Str[i] .. ")/vSel"
        end
    end

    local k = table.getn(nList)
    if (idxxm > 0) then
        for i = 1, 3 do
            nList[k + i] = (xmlvl * RewardList[idxxm].Exp[i]) .. RewardList[idxxm].ExpType .. "(" .. G_Str[i] .. ")/vSel"
        end
    end

    Say("ÇëÑ¡ÔñÄúÏë»ñÈ¡µÄ½±Àø!", table.getn(nList), nList)
end

function vSel(n)
    no()
    n = n + 1
    local idx = GetTaskByte(142, 1)
    local idxxm = GetTaskByte(142, 2)
    if (n < 1) or (n > 6) or (idx <= 0 and idxxm <= 0) or (idx > 7) or (idxxm > 2) then
        Talk(1, "no", "ÍøÂçÒì³£, xin h·y chän l¹i.")
        return
    end

    local LV = GetLevel()
    local key = idx
    if (idx == 0) then
        LV = GetPlayerExtLevel()
        key = idxxm
    elseif (n > 3) then
        LV = GetPlayerExtLevel()
        n = n - 3
        key = idxxm
    end

    SetTaskByte(142, 3, n)
    SetTaskByte(142, 4, key)
    local expStr = (LV * RewardList[key].Exp[n]) .. RewardList[key].ExpType
    MsgBox("ÄúÊÇ·ñÒª<c=y>" .. G_Str[n] .. "<c>Õâ¸öÀñ°ü, Äú½«»ñµÃ<c=g>" .. expStr .. "<c>, ÄãÑ¡ºÃÁË sao?\n[È·¶¨]ÊÇÁìÈ¡, [È¡Ïû]ÊÇÍË³ö", "v1_ok", "no")
end

function v1_ok()
    no()
    local itemID = GetTask(140)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    SetTask(140, 0)

    local key = GetTaskByte(142, 4)
    local n = GetTaskByte(142, 3)
    if (n < 1) or (n > 3) or (key <= 0) or (key > 7) then
        Talk(1, "no", "ÍøÂçÒì³£, xin h·y chän l¹i.")
        return
    end

    if (GetCoin() < G_Coin[n][1]) then
        Talk(1, "no", "ÄúÉíÉÏÍ¨±¦²»×ã, ÎÞ·¨¿ªÆôÕâµµ½±Àø.")
        return
    end

    if (DelItemByID(itemID) > 0) then
        if (G_Coin[n][2] > 0) then
            if (CostCoinByIdx(G_Coin[n][2]) <= 0) then
                Talk(1, "no", "ÄúÉíÉÏÍ¨±¦²»×ã, ÎÞ·¨¿ªÆôÕâµµ½±Àø.")
                return
            end
        end

        local LV = GetLevel()
        if (RewardList[key].isXM == 2) then
            LV = GetPlayerExtLevel()
            AddOwnExtendExp(LV * RewardList[key].Exp[n])
        else
            AddOwnExp(LV * RewardList[key].Exp[n])
        end
        local expStr = (LV * RewardList[key].Exp[n]) .. RewardList[key].ExpType

        WriteLog("[LÔ bao Trî Lùc][Í¨±¦: G_Coin[n][1]][NhËn ®­îc " .. expStr)
        Msg2Player("Äú¿ªÆôÁËLÔ bao Trî Lùc, nhËn ®­îc " .. expStr .. "!")
        ScrollMessage("NhËn ®­îc <c=y>" .. expStr)
    else
        Talk(1, "no", "ÄúµÄLÔ bao Trî LùcÄØ?")
        return
    end
end

function no()
    CloseDialog()
end;

