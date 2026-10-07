Task_Date_GetCard = 1496
Task_Respect = 1497

function main()
    if (GetLevel() < 50) then
        Talk(1, "no", "Mé Danh ThiÕp:Ng­êi ch¬i ®¹t cÊp 50 míi cã thÓ tham gia ho¹t ®éng bá phiÕu Th¸i S¬n B¾c §Èu!")
        return
    end

    local y1, m1, d1 = GetYMD()
    local h, m, s = GetHMS()

    if (y1 > 2009) or (m1 > 7) or (d1 > 23) or ((d1 == 23) and (h >= 20)) then
        Talk(1, "no", "Mé Danh ThiÕp:ChØ ®­îc bá phiÕu tr­íc 20:00 ngµy 23-7-2009, hiÖn ®· hÕt thêi gian bá phiÕu!")
        return
    end

    local lastRefresh = math.floor(LoadIniInteger("Vote_Respect_Day", "Day") / 86400)
    local today = math.floor(LocalSystemTime() / 86400)

    if (lastRefresh ~= today) then
        iniMostRespect()
    end

    local tasks = {
        { "øng cö viªn Gi¸p SÜ", "tenWarrior"; show = 1 },
        { "øng cö viªn §¹o SÜ", "tenWizard"; show = 1 },
        { "øng cö viªn DÞ Nh©n", "tenGhost"; show = 1 }
    }
    SayTask("H·y chän øng cö viªn b¹n muèn bá phiÕu:", tasks)
end

function iniMostRespect()


    for i = 1, 100 do
        SaveIniInteger("Save_Day_Respect_Number", i, 0)
        SaveIniString("Save_Day_Respect_Playername", i, "")
        SaveIniString("Save_Day_Respect_tong", i, "")
    end

    SaveIniInteger("Vote_Respect_Day", "Day", LocalSystemTime())
end

function tenWarrior()
    CloseDialog()
    selectPro(1)
end

function tenWizard()
    CloseDialog()
    selectPro(2)
end

function tenGhost()
    CloseDialog()
    selectPro(3)
end

function selectPro(nNum)
    CloseDialog()

    SetTaskByte(Task_Respect, 1, nNum)

    local topTen = GetCompetitionList(nNum * 2)
    local rankWarrior = {}
    local rankNum = 0
    local rankName = ""
    local rankTong = ""
    local TopRanking_Day = {}
    local y1, m1, d1 = GetYMD()

    if (d1 < 23) then
        for i = 1, 100 do
            rankNum = LoadIniInteger("Save_Day_Respect_Number", i)
            rankName = LoadIniString("Save_Day_Respect_Playername", i)
            rankTong = LoadIniString("Save_Day_Respect_tong", i)

            if (rankNum == 0) then
                break
            end

            TopRanking_Day[i] = { num = rankNum, name = rankName, tong = rankTong }
        end
    elseif (d1 == 23) then
        for i = 1, 100 do
            rankNum = LoadIniInteger("Save_All_Respect_Number", i)
            rankName = LoadIniString("Save_All_Respect_Playername", i)
            rankTong = LoadIniString("Save_All_Respect_tong", i)

            if (rankNum == 0) then
                break
            end

            TopRanking_Day[i] = { num = rankNum, name = rankName, tong = rankTong }
        end
    end

    for i = 1, table.getn(topTen) do
        rankName = topTen[i][1]
        rankTong = topTen[i][2]

        if (rankName == "") then
            break
        end

        rankNum = 0

        for j = 1, table.getn(TopRanking_Day) do
            if (rankName == TopRanking_Day[j].name) then
                rankNum = TopRanking_Day[j].num
                break
            end
        end

        if (rankTong == "") then
            rankTong = "--"
        end

        rankNum = math.floor(rankNum / 100)
        if (rankNum == 0) then
            rankNum = "--"
        else
            rankNum = "(" .. (rankNum * 100) .. "+)"
        end

        local numLen = string.len(rankName)
        for i = numLen, 16 do
            rankName = rankName .. " "
        end

        numLen = string.len(rankTong)
        for i = numLen, 16 do
            rankTong = rankTong .. " "
        end

        rankWarrior[i] = rankName .. rankTong .. rankNum .. "/selectWarrior"
    end

    rankWarrior[table.getn(rankWarrior) + 1] = "Quay l¹i/main"
    local sayMsg = "Mé Danh ThiÕp:B¹n cã thÓ bá phiÕu cho c¸c øng cö viªn sau\n\n"
    local str1 = "Tªn"
    local str2 = "L·nh ®Þa"

    for i = 5, 16 do
        str1 = str1 .. " "
        str2 = str2 .. " "
    end

    sayMsg = sayMsg .. str1 .. str2 .. "Sè phiÕu"
    Say(sayMsg, table.getn(rankWarrior), rankWarrior)
end

function selectWarrior(nNum)
    CloseDialog()
    if (nNum < 0 or nNum > 254) then
        return
    end

    if (GetTaskByte(Task_Respect, 1) < 0) then
        return
    end

    nNum = nNum + 1

    SetTaskByte(Task_Respect, 2, nNum)
    local topTen = GetCompetitionList(GetTaskByte(Task_Respect, 1) * 2)
    local rankName = topTen[nNum][1]

    MsgBox("Mé Danh ThiÕp:B¹n chän bá phiÕu cho øng cö viªn <c=g>" .. rankName .. "<c>, b¹n ®ång ý kh«ng?", "yes_sendCard", "no")
end

function yes_sendCard()
    CloseDialog()
    if (GetTaskByte(Task_Respect, 1) <= 0 or GetTaskByte(Task_Respect, 2) <= 0) then
        return
    end

    local topTen = GetCompetitionList(GetTaskByte(Task_Respect, 1) * 2)
    local rankName = topTen[GetTaskByte(Task_Respect, 2)][1]

    if (HaveNormalItem(6, 1, 534, 0) > 0) then
        DelNormalItem(6, 1, 534, 0)
    elseif (HaveNormalItem(6, 1, 533, 0) > 0) then
        DelNormalItem(6, 1, 533, 0)
    else
        return
    end

    SetTaskByte(Task_Respect, 3, 4)

    local nParam1 = 0
    nParam1 = SetByte(nParam1, 1, GetTaskByte(Task_Respect, 1))
    nParam1 = SetByte(nParam1, 2, GetTaskByte(Task_Respect, 2))
    RemoteExecute("\\script\\item\\ÀñÆ·°ü\\Ä½ÃûÌû.lua", "updateRanking", nParam1, GetTaskByte(Task_Respect, 3))

    PlayerCastSkill(1, 207, 1)
    Talk(1, "no", "Mé Danh ThiÕp:B¹n ®· bá 1 phiÕu cho øng cö viªn <c=g>" .. rankName .. "<c>!")
    Msg2Player("§· bá 1 phiÕu cho øng cö viªn" .. rankName .. " thµnh c«ng!")
    if (rankName ~= GetName()) then
        AddEvent("Trong ho¹t ®éng bá phiÕu, %s ñng hé <c=cyan><RoleName=\"" .. rankName .. "\"><c>, bá 1 phiÕu quý b¸u cho <c=cyan><RoleName=\"" .. rankName .. "\"><c>, c¶m ¬n %s ñng hé! H·y theo dâi tin tøc cña <c=cyan><RoleName=\"" .. rankName .. "\"><c>!", 1)
    end
end

function updateRanking(nParam1, nParam2)

    local idx = SubWorldID2Idx(21)

    if (idx == -1) then
        return
    end

    local prof = GetByte(nParam1, 1)
    local seq = GetByte(nParam1, 2)
    local cardType = nParam2

    local y1, m1, d1 = GetYMD()

    if (d1 == 23) then
        updateAllRanking(prof, seq, cardType)
    else
        updateDayRanking(prof, seq, cardType)
        updateAllRanking(prof, seq, cardType)
    end
end

function updateDayRanking(prof, seq, cardType)

    local cardNum = 0
    local TopRanking_Day = {}

    if (prof <= 0 or seq <= 0 or cardType <= 0) then
        return
    end

    if (cardType == 1) then
        cardNum = 9
    elseif (cardType == 2) then
        cardNum = 99
    elseif (cardType == 3) then
        cardNum = 999
    elseif (cardType == 4) then
        cardNum = 1
    else
        return
    end

    local rankNum = 0
    local rankName = ""
    local rankTong = ""

    for i = 1, 100 do
        rankNum = LoadIniInteger("Save_Day_Respect_Number", i)
        rankName = LoadIniString("Save_Day_Respect_Playername", i)
        rankTong = LoadIniString("Save_Day_Respect_tong", i)

        if (rankNum == 0) then
            break
        end

        TopRanking_Day[i] = { num = rankNum, name = rankName, tong = rankTong }
    end

    local topTen = GetCompetitionList(prof * 2)
    rankName = topTen[seq][1]

    local count = table.getn(TopRanking_Day)
    local hasPlace = 0
    local hasIndex = 0

    for i = 1, count do
        if (rankName == TopRanking_Day[i].name) then
            hasPlace = 1
            hasIndex = i
            break
        end
    end

    if (hasPlace == 0) then
        if (count == 0) or (count > 0 and cardNum < TopRanking_Day[count].num) then
            count = count + 1
            TopRanking_Day[count] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
        else
            local insertIdx = count
            for i = count, 0, -1 do
                if (i ~= 0) and ((TopRanking_Day[i].num < cardNum) or (TopRanking_Day[i].num == 0)) then
                    TopRanking_Day[i + 1] = TopRanking_Day[i]
                else
                    insertIdx = i + 1
                    break
                end
            end
            TopRanking_Day[insertIdx] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
        end
    else
        local insertIdx = count
        cardNum = cardNum + TopRanking_Day[hasIndex].num
        for i = hasIndex - 1, 0, -1 do
            if (i ~= 0) and ((TopRanking_Day[i].num < cardNum) or (TopRanking_Day[i].num == 0)) then
                TopRanking_Day[i + 1] = TopRanking_Day[i]
            else
                insertIdx = i + 1
                break
            end
        end
        TopRanking_Day[insertIdx] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
    end

    for i = 1, table.getn(TopRanking_Day) do
        SaveIniInteger("Save_Day_Respect_Number", i, TopRanking_Day[i].num)
        SaveIniString("Save_Day_Respect_Playername", i, TopRanking_Day[i].name)
        SaveIniString("Save_Day_Respect_tong", i, TopRanking_Day[i].tong)
    end
end

function updateAllRanking(prof, seq, cardType)

    local cardNum = 0
    local TopRanking_Day = {}

    if (prof <= 0 or seq <= 0 or cardType <= 0) then
        return
    end

    if (cardType == 1) then
        cardNum = 9
    elseif (cardType == 2) then
        cardNum = 99
    elseif (cardType == 3) then
        cardNum = 999
    elseif (cardType == 4) then
        cardNum = 1
    else
        return
    end

    local rankNum = 0
    local rankName = ""
    local rankTong = ""

    for i = 1, 100 do
        rankNum = LoadIniInteger("Save_All_Respect_Number", i)
        rankName = LoadIniString("Save_All_Respect_Playername", i)
        rankTong = LoadIniString("Save_All_Respect_tong", i)

        if (rankNum == 0) then
            break
        end

        TopRanking_Day[i] = { num = rankNum, name = rankName, tong = rankTong }
    end

    local topTen = GetCompetitionList(prof * 2)
    rankName = topTen[seq][1]

    local count = table.getn(TopRanking_Day)
    local hasPlace = 0
    local hasIndex = 0

    for i = 1, count do
        if (rankName == TopRanking_Day[i].name) then
            hasPlace = 1
            hasIndex = i
            break
        end
    end

    if (hasPlace == 0) then
        if (count == 0) or (count > 0 and cardNum < TopRanking_Day[count].num) then
            count = count + 1
            TopRanking_Day[count] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
        else
            local insertIdx = count
            for i = count, 0, -1 do
                if (i ~= 0) and ((TopRanking_Day[i].num < cardNum) or (TopRanking_Day[i].num == 0)) then
                    TopRanking_Day[i + 1] = TopRanking_Day[i]
                else
                    insertIdx = i + 1
                    break
                end
            end
            TopRanking_Day[insertIdx] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
        end
    else
        local insertIdx = count
        cardNum = cardNum + TopRanking_Day[hasIndex].num
        for i = hasIndex - 1, 0, -1 do
            if (i ~= 0) and ((TopRanking_Day[i].num < cardNum) or (TopRanking_Day[i].num == 0)) then
                TopRanking_Day[i + 1] = TopRanking_Day[i]
            else
                insertIdx = i + 1
                break
            end
        end
        TopRanking_Day[insertIdx] = { num = cardNum, name = rankName, tong = topTen[seq][2] }
    end

    for i = 1, table.getn(TopRanking_Day) do
        SaveIniInteger("Save_All_Respect_Number", i, TopRanking_Day[i].num)
        SaveIniString("Save_All_Respect_Playername", i, TopRanking_Day[i].name)
        SaveIniString("Save_All_Respect_tong", i, TopRanking_Day[i].tong)
    end
end

function no()
    CloseDialog()
end

function VoteOnPanel(prof, seq)

    if (GetLevel() < 50) then
        Talk(1, "no", "Mé Danh ThiÕp:Ng­êi ch¬i ®¹t cÊp 50 míi cã thÓ tham gia ho¹t ®éng bá phiÕu Th¸i S¬n B¾c §Èu!")
        return
    end

    local lastRefresh = math.floor(LoadIniInteger("Vote_Respect_Day", "Day") / 86400)
    local today = math.floor(LocalSystemTime() / 86400)
    local topTen = {}

    local y1, m1, d1 = GetYMD()
    local h, m, s = GetHMS()

    if (y1 > 2009) or (m1 > 7) or (d1 > 23) or ((d1 == 23) and (h >= 20)) then
        Talk(1, "no", "Mé Danh ThiÕp:B¹n chØ ®­îc bá phiÕu cho øng cö viªn tr­íc 20:00 ngµy 23-07-2009, hiÖn t¹i ®· hÕt thêi gian bá phiÕu!")
        return
    end

    if (lastRefresh ~= today) then
        iniMostRespect()
    end

    local rankName = ""
    local rankTong = ""

    prof = prof + 1
    topTen = GetCompetitionList(prof * 2)

    rankName = topTen[seq][1]
    rankTong = topTen[seq][2]

    if (rankName == "") then
        Talk(1, "no", "Mé Danh ThiÕp:øng cö viªn b¹n chän kh«ng cã trong 10 vÞ trÝ ®Çu b¶ng xÕp h¹ng, kh«ng ®ñ t­ c¸ch tham gia! H·y chän øng cö viªn kh¸c ®Ó bá phiÕu!")
        return
    end

    SetTaskByte(Task_Respect, 1, prof)
    SetTaskByte(Task_Respect, 2, seq)

    local tasks = {
        { "Bá 999 thiÕp", "nineHand"; show = 1 },
        { "Bá 99 thiÕp", "nintyCard"; show = 1 },
        { "Bá 9 thiÕp", "nineCard"; show = 1 },
    }
    SayTask("B¹n chän bá phiÕu cho øng cö viªn <c=g>" .. rankName .. "<c>, h·y chän c¸ch thøc bá phiÕu:", tasks)
end

function nineCard()
    CloseDialog()
    SetTaskByte(Task_Respect, 3, 1)
    sendCard(9)
end

function nintyCard()
    CloseDialog()
    sendCard(99)
    SetTaskByte(Task_Respect, 3, 2)
end

function nineHand()
    CloseDialog()
    sendCard(999)
    SetTaskByte(Task_Respect, 3, 3)
end

function sendCard(nNum)
    if (GetTaskByte(Task_Respect, 1) <= 0 or GetTaskByte(Task_Respect, 2) <= 0) then
        return
    end

    local topTen = GetCompetitionList(GetTaskByte(Task_Respect, 1) * 2)
    local rankName = topTen[GetTaskByte(Task_Respect, 2)][1]
    MsgBox("Mé Danh ThiÕp:B¹n x¸c nhËn göi cho øng cö viªn <c=g>" .. rankName .. "<c>" .. nNum .. " Mé Danh ThiÕp?", "sendCardInPanel", "no")
end

function sendCardInPanel()
    CloseDialog()
    if (GetTaskByte(Task_Respect, 1) <= 0 or GetTaskByte(Task_Respect, 2) <= 0) then
        return
    end

    local topTen = GetCompetitionList(GetTaskByte(Task_Respect, 1) * 2)
    local rankName = topTen[GetTaskByte(Task_Respect, 2)][1]

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(128)
    local cardType = GetTaskByte(Task_Respect, 3)

    if (cardType == 1) then
        cardNum = 9
    elseif (cardType == 2) then
        cardNum = 99
    elseif (cardType == 3) then
        cardNum = 999
    else
        return
    end

    local cardTemp = HaveNormalItem(6, 1, 534, 0)
    local cardPerm = HaveNormalItem(6, 1, 533, 0)

    if (cardTemp + cardPerm >= cardNum) then
        if (cardTemp >= cardNum) then
            for i = 1, cardNum do
                DelNormalItem(6, 1, 534, 0)
            end
        else
            for i = 1, cardTemp do
                DelNormalItem(6, 1, 534, 0)
            end

            for i = 1, (cardNum - cardTemp) do
                DelNormalItem(6, 1, 533, 0)
            end
        end

        local nParam1 = 0
        nParam1 = SetByte(nParam1, 1, GetTaskByte(Task_Respect, 1))
        nParam1 = SetByte(nParam1, 2, GetTaskByte(Task_Respect, 2))
        RemoteExecute("\\script\\item\\ÀñÆ·°ü\\Ä½ÃûÌû.lua", "updateRanking", nParam1, GetTaskByte(Task_Respect, 3))

        PlayerCastSkill(1, 207, 1)
        Talk(1, "no", "Mé Danh ThiÕp:B¹n ®· bá 1 phiÕu cho øng cö viªn <c=g>" .. rankName .. "<c> göi" .. cardNum .. " Mé Danh ThiÕp!")
        Msg2Player("§· bá 1 phiÕu cho øng cö viªn" .. rankName .. "§· göi" .. cardNum .. " Mé Danh ThiÕp!")
        if (rankName ~= GetName()) then
            AddEvent("Trong ho¹t ®éng bá phiÕu, %s ñng hé <c=cyan><RoleName=\"" .. rankName .. "\"><c>, bá 1 phiÕu quý b¸u cho <c=cyan><RoleName=\"" .. rankName .. "\"><c>, c¶m ¬n %s ñng hé! H·y theo dâi tin tøc cña <c=cyan><RoleName=\"" .. rankName .. "\"><c>!", 1)
        end
    else
        local diff = cardNum - cardTemp - cardPerm
        MsgBox("Mé Danh ThiÕp:B¹n kh«ng ®ñ Mé Danh ThiÕp, cßn thiÕu <c=g>" .. diff .. "<c> c¸i. Mçi Mé Danh ThiÕp <c=g>" .. Cfs .. "<c> Th«ng B¶o, nÕu cã <c=g>" .. Cfs * diff .. "<c> Th«ng B¶o, sÏ cã thÓ tiÕp tôc hoµn thµnh bá phiÕu, b¹n muèn tiÕp tôc chø?", "yes_Cv", "no")
    end
end

function yes_Cv()
    CloseDialog()
    local cardType = GetTaskByte(Task_Respect, 3)
    local topTen = GetCompetitionList(GetTaskByte(Task_Respect, 1) * 2)
    local rankName = topTen[GetTaskByte(Task_Respect, 2)][1]

    if (cardType == 1) then
        cardNum = 9
    elseif (cardType == 2) then
        cardNum = 99
    elseif (cardType == 3) then
        cardNum = 999
    else
        return
    end

    local cardTemp = HaveNormalItem(6, 1, 534, 0)
    local cardPerm = HaveNormalItem(6, 1, 533, 0)
    local diff = cardNum - cardTemp - cardPerm
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(128)
    if (GetCoin() >= Cv * diff) then
        local nDelCount = 0

        if (diff >= 100) then
            local nLoop = math.floor(diff / 100)
            for i = 1, nLoop do
                CostCoinByIdx(126)
                nDelCount = nDelCount + 100
            end
        end

        diff = diff - nDelCount

        nDelCount = 0

        if (diff >= 10) then
            local nLoop = math.floor(diff / 10)
            for i = 1, nLoop do
                CostCoinByIdx(127)
                nDelCount = nDelCount + 10
            end
        end

        diff = diff - nDelCount

        for i = 1, diff do
            CostCoinByIdx(128)
        end

        for i = 1, cardTemp do
            DelNormalItem(6, 1, 534, 0)
        end

        for i = 1, cardPerm do
            DelNormalItem(6, 1, 533, 0)
        end

        local nParam1 = 0
        nParam1 = SetByte(nParam1, 1, GetTaskByte(Task_Respect, 1))
        nParam1 = SetByte(nParam1, 2, GetTaskByte(Task_Respect, 2))

        RemoteExecute("\\script\\item\\ÀñÆ·°ü\\Ä½ÃûÌû.lua", "updateRanking", nParam1, GetTaskByte(Task_Respect, 3))

        PlayerCastSkill(1, 207, 1)
        Talk(1, "no", "Mé Danh ThiÕp:B¹n ®· bá 1 phiÕu cho øng cö viªn <c=g>" .. rankName .. "<c> göi" .. cardNum .. " Mé Danh ThiÕp!")
        Msg2Player("§· bá 1 phiÕu cho øng cö viªn" .. rankName .. "§· göi" .. cardNum .. " Mé Danh ThiÕp")
        if (rankName ~= GetName()) then
            AddEvent("Trong ho¹t ®éng bá phiÕu, %s ñng hé <c=cyan><RoleName=\"" .. rankName .. "\"><c>, bá 1 phiÕu quý b¸u cho <c=cyan><RoleName=\"" .. rankName .. "\"><c>, c¶m ¬n %s ñng hé! H·y theo dâi tin tøc cña <c=cyan><RoleName=\"" .. rankName .. "\"><c>!", 1)
        end
    else
        Talk(1, "no", "Mé Danh ThiÕp:B¹n kh«ng cã ®ñ Th«ng B¶o!")
    end
end


