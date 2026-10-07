module("COMMON", package.seeall)

MAX_KILL_FORCEBOSS = 30
MAX_PLAYER_LEVEL = 149
MAX_BUFF_COUNT = 32

IB_CHUMOLING = {
    name = "Trõ Ma LÖnh",
    IdTable = { 8, 2032, 2 },
    ItemID = 86,
}

GLOBALMAPNAME = {
    [1] = "Phong ThÇn ®µi",
    [2] = "Sïng Thµnh doanh",
    [3] = "Ngäc H­ cung",
    [4] = "Xi V­u Mé",
    [5] = "Sïng thµnh",
    [6] = "B¾c H¶i",
    [7] = "YÕn S¬n",
    [8] = "Ch©n nói C«n L«n",
    [9] = "T©y C«n L«n",
    [10] = "Thñ D­¬ng s¬n",
    [11] = "Du Hån",
    [12] = "Miªu C­¬ng",
    [13] = "Cù Léc",
    [14] = "§ång Quan",
    [15] = "M¹nh T©n",
    [16] = "Tam S¬n",
    [17] = "Kú S¬n",
    [18] = "Môc D·",
    [19] = "TuyÖt Long lÜnh",
    [20] = "T©y Kú",
    [21] = "TriÒu Ca",
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong ThÇn",
    [25] = "Lôc Ch©u",
    [26] = "Sa M¹c chÕt",
    [27] = "Hiªn Viªn tÇng 1",
    [28] = "Hiªn Viªn tÇng 2",
    [29] = "Hiªn Viªn tÇng 3",
    [30] = "Hiªn Viªn tÇng 4",
    [31] = "Hiªn Viªn tÇng 5",
    [32] = "Ngäc TuyÒn",
    [33] = "TuyÕt Cèc",
    [34] = "§¹i Phong",
    [35] = "§¹i Th¹ch",
    [36] = "B¨ng Xuyªn Cùc",
    [37] = "Thñy Vùc",
    [38] = "Long Cung",
    [39] = "H¶i C©u",
    [40] = "Long Vùc",
    [41] = "Long Uyªn",
    [42] = "BÝch Du tÇng 1",
    [43] = "BÝch Du tÇng 2",
    [44] = "BÝch Du tÇng 3",
    [45] = "BÝch Du tÇng 4",
    [46] = "BÝch Du tÇng 5",
    [47] = "Khæn Tiªn tÇng 1",
    [48] = "Khæn Tiªn tÇng 2",
    [49] = "Khæn Tiªn tÇng 3",
    [50] = "Khæn Tiªn tÇng 4",
    [51] = "Khæn Tiªn tÇng 5",
    [52] = "Diªu Tr×",
    [53] = "§¹i H¶i",
    [54] = "Bång Lai",
    [55] = "§«ng Doanh",
    [56] = "Ph­¬ng Tr­îng",
    [57] = "Kho¸ng tr­êng",
    [58] = "D­îc V­¬ng cèc",
    [59] = "Sïng Thµnh (kho¸ng tr­êng)",
    [60] = "Thiªn Lao",
    [61] = "Ngäc H­ 10 n¨m tr­íc",
    [62] = "Ngäc H­ 10 n¨m sau",
    [63] = "TriÒu Ca 10 n¨m sau",
    [64] = "ViÔn Cæ",
    [65] = "TrÇn §­êng",
    [66] = "Tr­ Lung tr¹i",
    [67] = "V¹n Tiªn (Thæ)",
    [68] = "V¹n Tiªn (Thñy)",
    [69] = "V¹n Tiªn (Háa)",
    [70] = "V¹n Tiªn (Phong)",
    [71] = "ChiÕn tr­êng",
    [72] = "Khai Minh ®¶o",
    [73] = "BÊt Chu Thiªn quan",
    [74] = "BÊt Chu S¬n",
    [75] = "Ngôc Ph¸p s¬n",
    [76] = "Th¸nh §Þa",
    [77] = "L­u Ba s¬n",
    [78] = "Kh«ng Tang Linh",
    [79] = "V¹n Tiªn TrËn-HuyÔn (Thæ)",
    [80] = "V¹n Tiªn TrËn-HuyÔn (Thñy)",
    [81] = "V¹n Tiªn TrËn-HuyÔn (Háa)",
    [82] = "V¹n Tiªn TrËn-HuyÔn (Phong)",
    [83] = "TÕ Uyªn Cèc",
    [84] = "Hiªn Viªn §éng 10 n¨m tr­íc",
    [85] = "§Êu Tr­êng",
    [86] = "Tø T­îng ThÇn Vùc",
    [87] = "Kh«ng",
    [88] = "Kh«ng",
    [89] = "Kh«ng",
    [90] = "Kh«ng",
    [91] = "Kh«ng",
    [92] = "Khe nøt ViÔn Cæ",
    [93] = "Tö HuyÒn §éng Thiªn",
    [94] = "Ngäc Phong §éng Thiªn",
    [95] = "Huy Minh §éng Thiªn",


    [96] = "Thiªn Lao",
    [97] = "Diªm La ®iÖn",
    [98] = "Hoµng TuyÒn phñ",
    [99] = "Nam Kha quËn"
}

function Check_Distance(mapidx, nNpcx, nNpcy, distance)
    local w, x, y = GetWorldPos()
    if w == mapidx then
        local nDis = math.sqrt((x - nNpcx) ^ 2 + ((y - nNpcy) ^ 2)) * 32
        if nDis <= distance then
            return 1
        end
    end
    return 0
end

function Is_NpcInDistance(npcIdx, nDistance)
    local mapidx, nNpcx, nNpcy = GetNpcWorldPos(npcIdx)
    return Check_Distance(mapidx, nNpcx, nNpcy, nDistance)
end

function RndTable(t)
    if type(t) == "table" then
        local count = #t
        if count < 0 then
            return nil
        end
        for i = 1, count do
            local temp = t[i]
            table.remove(t, i)
            table.insert(t, math.random(1, count), temp)
        end
        return t
    end
    return nil
end

function RndProbabilityTable(t)
    if type(t) == "table" then
        local count = #t
        local sum = 0
        local rnd = math.random(1, 10000)
        for i = 1, count do
            local probability = t[i]
            local value = probability * 10000
            sum = sum + value
            if rnd <= sum then
                return i
            end
        end
        return count
    else
        return nil
    end
end

function IsInDateTimeRange(datetime1, datetime2)
    local yr, mo, day = GetYMD()
    if mo < 10 then
        mo = "0" .. mo
    end
    if day < 10 then
        day = "0" .. day
    end
    local h, m, s = GetHMS()
    if h < 10 then
        h = "0" .. h
    end
    if m < 10 then
        m = "0" .. m
    end
    if s < 10 then
        s = "0" .. s
    end

    local todaystr = string.format("%s-%s-%s %s:%s:%s", yr, mo, day, h, m, s)
    return todaystr >= datetime1 and todaystr <= datetime2
end

function IsInDateRange(date1, date2)
    local yr, mo, day = GetYMD()
    if mo < 10 then
        mo = "0" .. mo
    end
    if day < 10 then
        day = "0" .. day
    end

    local todaystr = string.format("%s-%s-%s", yr, mo, day)
    return todaystr >= date1 and todaystr <= date2
end

function IsInTimeRange(time1, time2, weekdays)
    local weekday = GetWeekDay()
    if weekdays ~= nil then
        local found = false
        for i = 1, #weekdays do
            if weekdays[i] == weekday then
                found = true
                break
            end
        end
        if not found then
            return false
        end
    end

    local h, m, s = GetHMS()
    if h < 10 then
        h = "0" .. h
    end
    if m < 10 then
        m = "0" .. m
    end
    if s < 10 then
        s = "0" .. s
    end

    local nowstr = string.format("%s:%s:%s", h, m, s)
    return nowstr >= time1 and nowstr <= time2
end

function FormatTime(s)
    if s == 0 then
        return "0"
    end
    local ss =  math.fmod(s, 60)
    local mm = math.floor( math.fmod(s, 3600) / 60)
    local hh =  math.floor( math.fmod(s, 86400) / 3600)
    local dd =  math.floor(s / 86400)

    local str = ""
    local ss_str = tostring(ss) .. "s"
    local mm_str = tostring(mm) .. "m"
    local hh_str = tostring(hh) .. "h"
    local dd_str = tostring(dd) .. "d"
    if dd > 0 then
        str = dd_str
    end
    if hh > 0 then
        str = str .. hh_str
    end
    if mm > 0 then
        str = str .. mm_str
    end
    if ss > 0 then
        str = str .. ss_str
    end
    return str
end

function FormatTimeToStr(s)
    if s <= 0 then
        return "0Ãë"
    end
    local ss = math.fmod(s, 60)
    local mm = math.floor(math.fmod(s, 3600) / 60)
    local hh = math.floor(math.fmod(s, 86400) / 3600)

    local str = ""
    local ss_str = ss .. "s"
    local mm_str = mm .. "m"
    local hh_str = hh .. "h"
    if hh >= 0 then
        str = str .. hh_str
    end
    if mm >= 0 then
        str = str .. mm_str
    end
    if ss >= 0 then
        str = str .. ss_str
    end
    return str
end

function GiveTitleActivity(titleID, titleName)
    UnActiveTitleQualify(titleID)
    ActiveTitleFunc(1)
    ActiveTitleQualify(titleID)
    SetCurTitle(titleID)
    TopMessage("Ng­¬i ®· nhËn ®­îc Danh hiÖu " .. titleName .. ".")
    Msg2Player("Ng­¬i ®· nhËn ®­îc Danh hiÖu " .. titleName .. ". ")
end

function IsSpecialMorph()
    local nType = GetMorphType()
    if CanPolyMorph() == 0
            and (GetCompeteFlag() ~= 1)
            and (nType ~= 2491 and nType ~= 2490)
            and (Is_InCamel() == false)
            and (IsPlayerInsideWeapon(PlayerIndex) <= 0)
            and (not ((nType >= 1396 and nType <= 1398) or (nType >= 1401 and nType <= 1406))) then

        return false
    end
    return true
end

function Is_CanTrans(consider_camp, ismsg)
    local smsg = ""
    if (ismsg == nil) or (ismsg ~= 0) then
        ismsg = 1
    end
    local mapID, _, _ = GetWorldPos()
    if HaveIBBuff(849) > 0 then

        smsg = "§ang trong tr¹ng th¸i c©u c¸, kh«ng thÓ truyÒn tèng."
    elseif COMMON.Is_InCamel() == true then

        smsg = "§ang trong tr¹ng th¸i bµo th­¬ng, kh«ng thÓ truyÒn tèng."
    elseif IsPlayerInsideWeapon(PlayerIndex) > 0 then

        smsg = "§ang trong tr¹ng th¸i vËn l­¬ng, kh«ng thÓ truyÒn tèng."
    elseif HaveIBBuff(1027) > 0 or HaveIBBuff(901) > 0 then

        smsg = "§ang trong tr¹ng th¸i chuyÓn kiÕp, kh«ng thÓ truyÒn tèng."
    elseif mapID <= 0 or mapID == 97 then

        smsg = "§ang trong b¶n ®å ®Æc biÖt, kh«ng thÓ truyÒn tèng."
    elseif mapID == 72 then

        smsg = "§iÓm PK cña ng­¬i lín h¬n 3, kh«ng thÓ truyÒn tèng."
    elseif mapID == 37 then

        smsg = "§ang trong chiÕn tr­êng ViÔn Cæ, kh«ng thÓ truyÒn tèng."
    elseif (GetTaskStep(442) == 2) or (GetTaskStep(442) == 1 and GetTaskByte(442, 15, 2) == 1) then

        smsg = "§ang trong tr¹ng th¸i l«i ®µi, kh«ng thÓ truyÒn tèng."
    elseif IsWarServer() ~= 0 then
        smsg = "§ang trong chiÕn tr­êng liªn server, kh«ng thÓ truyÒn tèng."
    elseif GetCamp() == 8 then

        smsg = "§ang trong tr¹ng th¸i phe hång, kh«ng thÓ truyÒn tèng."
    elseif consider_camp ~= nil and consider_camp ~= false and consider_camp ~= 0 then

        if GetCamp() ~= 0 and GetCamp() ~= 7 then

            smsg = "Kh«ng trong tr¹ng th¸i hoµ b×nh, kh«ng thÓ truyÒn tèng."
        end
    end
    if (smsg == "") then
        return true
    elseif (ismsg == 1) then
        Msg2Player(smsg)
    end
    return false
end

function Set_PlayerStandState()

end

TRANS_BUFF_EFFECT = 2204
Trands_List = { "Håi thµnh phï", "Håi thµnh phï (Siªu cÊp)", "§én §Þa Phï", "§én §Þa Phï (Siªu cÊp)", "Di Ngo¹i Phï", "Di Ngo¹i Phï (nhá)", "L­u Kh«ng Phï", "Tiªn Lý Phï", "Håi Quèc Phï" }
function Get_TransCondition()
    local nBuffId = TRANS_BUFF_EFFECT
    local nTime = 3
    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 7, 0)
    nInterrupt = SetBit(nInterrupt, 8, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 10, 0)
    nInterrupt = SetBit(nInterrupt, 11, 1)
    nInterrupt = SetBit(nInterrupt, 12, 1)
    return nBuffId, nTime, nInterrupt
end

NpcState = {
    [1] = { state = 3, subState = 2, str = "Hoµng më" },
    [2] = { state = 3, subState = 0, str = "Vµng më" },
    [3] = { state = 3, subState = 1, str = "Lam më" },
    [4] = { state = 3, subState = 3, str = "Cam më" },
    [5] = { state = 1, subState = 2, str = "Hoµng ®ãng" },
    [6] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [7] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [8] = { state = 1, subState = 3, str = "Cam ®ãng" },
    [9] = { state = 2, subState = 2, str = "X¸m tuÇn hoµn më" },
    [10] = { state = 2, subState = 0, str = "X¸m më" },
    [11] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, #NpcState do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetPlayerTaskState()
    local state, subState = _G.GetNpcTaskState()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = _G.GetNpcTaskState()
    SetPlayerTaskState(state, subState)
end

function GetDir(x0, y0, x1, y1)
    local x = x1 - x0
    local y = y1 - y0
    local arrDir = { "ChÝnh B¾c", "§«ng B¾c", "ChÝnh §«ng", "§«ng Nam", "ChÝnh Nam", "T©y Nam", "ChÝnh T©y", "T©y B¾c" }

    if (x == 0 and y < 0) then

        return (arrDir[1])
    elseif (x == 0 and y > 0) then

        return (arrDir[5])
    end

    local tan = y / x
    if (tan >= -3.732 and tan <= -0.268 and x < 0 and y > 0) then

        return (arrDir[6])
    elseif (tan >= -3.732 and tan <= -0.268 and x > 0 and y < 0) then

        return (arrDir[2])
    elseif (tan >= 0.268 and tan <= 3.732 and x < 0 and y < 0) then

        return (arrDir[8])
    elseif (tan >= 0.268 and tan <= 3.732 and x > 0 and y > 0) then

        return (arrDir[4])
    elseif (tan > -0.268 and tan < 0.268 and x <= 0) then

        return (arrDir[7])
    elseif (tan > -0.268 and tan < 0.268 and x >= 0) then

        return (arrDir[3])
    elseif ((tan > 3.732 or tan < -3.732) and y < 0) then

        return (arrDir[1])
    elseif ((tan > 3.732 or tan < -3.732) and y > 0) then

        return (arrDir[5])
    end
    return (arrDir[5])
end

function Get_DistanceTips(nCurrDis, nLastDis)
    local TABLE_Light = {
        [1] = "<color=Earth>¸nh s¸ng yÕu ít<c>",
        [2] = "<color=Pink>¸nh s¸ng mê ¶o<c>",
        [3] = "<color=Fire>¸nh s¸ng m¹nh<c>",
        [4] = "<c=yel>¸nh s¸ng chãi chang<c>",
    }

    local idx = 0;
    local sLightTips = ""

    if (nCurrDis <= 25) then

        idx = 4;
    elseif (nCurrDis <= 400) then
        idx = 3;
    elseif (nCurrDis <= 2500) then
        idx = 2;
    else
        idx = 1;
    end

    sLightTips = TABLE_Light[idx]

    local sDisTips = ""
    if (nLastDis == -1) then

        return -1, nil, nil
    elseif (idx == 4) then

        return 1, nil, nil
    else
        if (nCurrDis < nLastDis) then
            sDisTips = "<color=green>®Õn gÇn<color>";
        else
            sDisTips = "<color=red>c¸ch xa<color>";
        end

        return 0, sDisTips, sLightTips
    end
end

function Is_BuffCountLimit(requireBuff)
    local nBuffCount = GetIBBuffCount()
    if (nBuffCount + requireBuff <= MAX_BUFF_COUNT) then
        return 1
    else
        return 0
    end
end

function in_polygon(point, point_table)
    local vec_a, vec_b
    for i = 1, #point_table do
        vec_a = { [1] = point[1] - point_table[i][1], [2] = point[2] - point_table[i][2] }
        if i < #point_table then
            vec_b = { [1] = point_table[i + 1][1] - point_table[i][1], [2] = point_table[i + 1][2] - point_table[i][2] }
        elseif i == #point_table then
            vec_b = { [1] = point_table[1][1] - point_table[i][1], [2] = point_table[1][2] - point_table[i][2] }
        end
        if cross_product(vec_a, vec_b) > 0 then

            return false
        end
    end
    return true
end

function cross_product(vec_a, vec_b)
    return vec_a[1] * vec_b[2] - vec_a[2] * vec_b[1]
end

function Is_HaveFreeSpace(nCount)
    if (IsHaveSpaceForTreasure(nCount) <= 0) then
        InfoBox("Hµnh trang cña ngµi ®· ®Çy, cÇn chõa l¹i " .. nCount .. " « trèng hµnh trang, xin h·y s¾p xÕp l¹i!")
        return false
    end
    return true
end

function Is_HaveSpace(idTable, nPileCount)
    local nFlag = false

    if #idTable == 4 then
        local nCurCountInBox = HaveNormalItem(idTable[1], idTable[2], idTable[3], 1, 1, idTable[4])

        if ((nCurCountInBox > 0 and nCurCountInBox < nPileCount) or IsHaveSpaceForTreasure(2) == 1) then
            nFlag = true
        end
    end
    return nFlag
end

function Get_MapInfoByForce(forceID)

    local forceInfo = {
        [1] = { forceName = "T©y Kú", mapID = 15, kingName = "C¬ X­¬ng", },
        [2] = { forceName = "§«ng Lç", mapID = 13, kingName = "Kh­¬ng Hoµn Së", },
        [3] = { forceName = "Nam C­¬ng", mapID = 16, kingName = "Ng¹c Sïng Vò", },
        [4] = { forceName = "B¾c H¶i", mapID = 14, kingName = "Sïng HÇu Hæ", },
        [5] = { forceName = "TriÒu Ca", mapID = 17, kingName = "Trô V­¬ng", },
    }

    if forceID == nil then
        forceID = GetPlayerForce()
    end

    for i = 1, #forceInfo do
        if i == forceID then
            return forceInfo[forceID].mapID, forceInfo[forceID].forceName, forceInfo[forceID].kingName
        end
    end
    return -1, "", ""
end

function Is_OwnForceMap()
    local nMap, nMapX, nMapY = GetWorldPos()
    local nForce = GetPlayerForce()
    local ForceMapList = { 15, 13, 16, 14, 17 }
    if (nForce > 0 and nForce <= 5 and ForceMapList[nForce] == nMap) then
        return true
    end
    return false
end

function Get_ForceByMap(mapid)

    local forceInfo = {
        [15] = { forceName = "T©y Kú", forceID = 1, },
        [13] = { forceName = "§«ng Lç", forceID = 2, },
        [16] = { forceName = "Nam C­¬ng", forceID = 3, },
        [14] = { forceName = "B¾c H¶i", forceID = 4, },
        [17] = { forceName = "TriÒu Ca", forceID = 5, },
    }

    if mapid == nil then
        mapid, _, _ = GetWorldPos()
    end

    if mapid >= 13 and mapid <= 17 then
        return forceInfo[mapid].forceID, forceInfo[mapid].forceName
    end

    return GetMapForce(mapid), GetMapNameByID(mapid)
end

function Get_MapForce()
    local nMap, nMapX, nMapY = GetWorldPos()
    local ForceMapList = { 15, 13, 16, 14, 17 }
    for i = 1, #ForceMapList do
        if (ForceMapList[i] == nMap) then
            return i
        end
    end
    return 0
end

function Cost_IBItem_Num(costIndex, IdTable, needNum, itemName)
    local _, Cv, Cfs = GetCostCoinInfoByIdx(costIndex);
    local IBIdx = FindAValidIBItem(IdTable[1], IdTable[2], IdTable[3], 0)
    local nums = HaveNormalItem(IdTable[1], IdTable[2], IdTable[3], 0)
    local str = "Ng­¬i tiªu hao "

    if (nums > 0) and (IBIdx == 0) then
        nums = 0
    end
    local mycoin = nums * Cv + GetCoin()

    if (mycoin >= Cv * needNum) then
        local costIBNum = math.min(needNum, nums)
        local haveCostNum = 0

        if costIBNum >= 1 then
            for i = 1, costIBNum do
                if CostIBItem(FindAValidIBItem(IdTable[1], IdTable[2], IdTable[3], 0)) == 1 then
                    haveCostNum = haveCostNum + 1
                end

                if haveCostNum == 0 then
                    Msg2Player("Xin lçi, khÊu trõ " .. itemName .. " thÊt b¹i!")
                    return -1
                end
            end

            str = str .. costIBNum .. " " .. itemName

            if haveCostNum < costIBNum then
                WriteLog("[NhiÖm vô tr¶ phÝ thÊt b¹i][®· khÊu trõ " .. haveCostNum .. "." .. itemName .. "]")
                Msg2Player("Xin lçi, khÊu trõ " .. itemName .. " thÊt b¹i!")
                return -1
            end
        end

        local costTimes = needNum - costIBNum

        if costTimes >= 1 then
            local nRet = -1
            local nRet1 = 0
            local nRet2 = 0
            for i = 1, costTimes do
                nRet = CostCoinByIdx(costIndex)
                if (nRet == 0) then
                    nRet1 = nRet1 + 1
                elseif (nRet == 1) then
                    nRet2 = nRet2 + 1
                end

                if (nRet2 == 0 and nRet1 == 0) then
                    Msg2Player("Xin lçi, khÊu trõ Th«ng B¶o thÊt b¹i!")
                    return -1
                end
            end

            if (nRet1 + nRet2) < costTimes then

                WriteLog("[NhiÖm vô tr¶ phÝ thÊt b¹i][®· khÊu trõ" .. (nRet2 * Cfs) .. " Th«ng B¶o vµ " .. (nRet1 * Cfs) .. " Linh B¶o]")
                Msg2Player("Xin lçi, khÊu trõ Th«ng B¶o thÊt b¹i!")
                return -1
            end

            if costIBNum >= 1 then
                str = str .. " vµ "
            end

            if (nRet1 == 0) then
                str = str .. (costTimes * Cfs) .. " Th«ng B¶o."
            elseif (nRet2 == 0) then
                str = str .. (costTimes * Cfs) .. " Linh B¶o."
            else
                str = str .. (nRet2 * Cfs) .. " Th«ng B¶o vµ " .. (nRet1 * Cfs) .. " Linh B¶o."
            end
        end
        Msg2Player(str)
        return 1
    else
        Talk(1, "no", "Trªn ng­êi kh«ng ®ñ <c=red>" .. itemName .. "<c> hoÆc Th«ng B¶o, xin h·y chuÈn bÞ råi quay l¹i!")
        return -1;
    end
end

function Pay_Money(amount, nBindOrNot, nPay)
    if (nBindOrNot == nil) then
        nBindOrNot = 2
    end
    if (nPay == nil) then
        nPay = 1
    end
    local sInfo = ""
    if nBindOrNot == 1 then

        if GetBindCash() < amount then
            if (GetCash() < amount) then
                Msg2Player("B¹c hoÆc b¹c kho¸ kh«ng ®ñ!")
                return false
            else
                if (nPay ~= 0) then
                    Pay(amount, 1)
                    sInfo = sInfo .. amount .. " b¹c"
                end
            end
        else
            if (nPay ~= 0) then
                PayBind(amount)
                sInfo = sInfo .. amount .. " b¹c khãa"
            end
        end
    else
        if GetCash() < amount then
            Msg2Player("Kh«ng ®ñ b¹c")
            return false
        end
        if (nPay ~= 0) then
            if nBindOrNot == 0 then

                Pay(amount, 1)
            else

                Pay(amount)
            end
            sInfo = sInfo .. amount .. " b¹c"
        end
    end
    return true, sInfo
end

TongDutyName_List = {
    [1] = "Quèc v­¬ng",
    [2] = "Gi¸m quèc",
    [3] = "Thõa T­íng",
    [4] = "Th¸i Uý",
    [5] = "Th¸i Th­¬ng",
    [6] = "T­ Kh«ng",
    [7] = "T­ M·",
    [8] = "T­ §å",
    [9] = "§×nh Uý",
    [10] = "§« Uý",
    [11] = "VÖ Uý",
    [12] = "T«n B¸",
    [13] = "ThiÕu B¶o",
    [14] = "Trñng TÕ",
    [15] = "Phong TÕ T­",
    [16] = "§iÒu TÕ T­",
    [17] = "Vâ TÕ T­",
    [18] = "ThuËn TÕ T­",
    [19] = "§×nh Uý dÞch",
    [20] = "§« Uý dÞch",
    [21] = "VÖ Uý dÞch",
    [22] = "T«n B¸ vÖ",
    [23] = "ThiÕu B¶o vÖ",
    [24] = "Trñng TÕ vÖ",
    [25] = "Phong Sø",
    [26] = "§iÒu Sø",
    [27] = "Vâ Sø",
    [28] = "ThuËn Sø",
    [29] = "D©n chóng",
}

function Get_TongDutyName()
    local nDuty = GetTongMemberDuty()

    if TongDutyName_List[nDuty] == nil then
        return ""
    else
        return TongDutyName_List[nDuty]
    end
end

function Get_PlayerTransLevel()
    local nList = GetParentIDList()

    if (nList[1][1] >= 29) then

        return 3
    elseif (nList[1][1] < 29) and (nList[1][1] >= 13) then

        return 2
    elseif (nList[1][1] < 13) and (nList[1][1] >= 5) then

        return 1
    elseif (nList[1][1] < 5) and (nList[1][1] >= 1) then

        return 0
    end

    return -1
end

function Summon_Back()
    ClearAllCreature()
end

function Cost_Item(id1, id2, id3, nDelNum, nBindOrNot)

    if nDelNum == nil or nDelNum <= 0 then
        Msg2Player("Vui lßng ®Æt sè l­îng vËt phÈm tiªu thô hîp lÖ")
        return false
    end

    local nItem = 0

    if id1 == 8 then
        nItem = HaveNormalItem(id1, id2, id3, 5)
        if nItem < nDelNum then
            Msg2Player("Kh«ng ®ñ ®¹o cô cÇn thiÕt, vui lßng ®Æt ®¹o cô cÇn thiÕt vµo hµnh trang.")
            return false
        else
            local nCostID = 0
            for i = 1, nDelNum do
                nCostID = FindAValidIBItem(id1, id2, id3, 0)
                CostIBItem(nCostID)
            end
            return true
        end
    end

    if nBindOrNot == 0 then
        nItem = HaveNormalItem(id1, id2, id3, 5, 1, 0)
        if nItem < nDelNum then
            Msg2Player("Kh«ng ®ñ ®¹o cô (kh«ng kho¸) cÇn thiÕt, vui lßng ®Æt ®¹o cô cÇn thiÕt vµo hµnh trang.")
            return false
        else
            for i = 1, nDelNum do
                DelNormalItem(id1, id2, id3, 5, 1, 0)
            end
            return true
        end
    elseif nBindOrNot == 1 then
        nItem = HaveNormalItem(id1, id2, id3, 5, 1, 1)
        if nItem < nDelNum then
            Msg2Player("Kh«ng ®ñ ®¹o cô (kho¸) cÇn thiÕt, vui lßng ®Æt ®¹o cô cÇn thiÕt vµo hµnh trang.")
            return false
        else
            for i = 1, nDelNum do
                DelNormalItem(id1, id2, id3, 5, 1, 1)
            end
            return true
        end
    else
        nItem = HaveNormalItem(id1, id2, id3, 5)
        if nItem < nDelNum then
            Msg2Player("Kh«ng ®ñ ®¹o cô cÇn thiÕt, vui lßng ®Æt ®¹o cô cÇn thiÕt vµo hµnh trang.")
            return false
        else
            for i = 1, nDelNum do
                DelNormalItem(id1, id2, id3, 5)
            end
            return true
        end
    end
end

function New_Carriage(nCarType, nLevel)
    local mapid, x, y = GetExactWorldPos()
    local nCarriageIndex = NewSiegeWeapon(mapid, x, y, nCarType, nLevel)
    local nCarriageNpcIndex = GetSiegeWeaponNpcIndex(nCarriageIndex)
    return nCarriageIndex, nCarriageNpcIndex
end

function Record_PlayerSkill()
    local Task_SumAppliance = 698
    local nLeftSkill = GetClientLeftSkill()
    local nRightSkill = GetClientRightSkill()
    SetTask(Task_SumAppliance, 47, nLeftSkill)
    SetTask(Task_SumAppliance, 48, nRightSkill)
end

function Restore_PlayerSkill()
    local Task_SumAppliance = 698
    local nLeftSkill = GetTask(Task_SumAppliance, 47)
    local nRightSkill = GetTask(Task_SumAppliance, 48)
    if (nRightSkill > 0) then
        SetClientRightSkill(nRightSkill)
        SetTask(Task_SumAppliance, 47, 0)
    end
    if (nLeftSkill > 0) then
        SetClientLeftSkill(nLeftSkill)
        SetTask(Task_SumAppliance, 48, 0)
    end
end

function Get_EnmityList(nDeadNpcIndex, nDistance)

    local hurtList = {}
    if nDeadNpcIndex == nil or nDeadNpcIndex <= 0 then
        return hurtList
    end

    local nAttackers = GetNpcEnmityCount(nDeadNpcIndex)
    if nAttackers ~= nil and nAttackers < 1 then
        return hurtList
    end

    local npcMapid, npcX, npcY = GetNpcWorldPos(nDeadNpcIndex)
    local mapid, x, y = 0, 0, 0
    local nDis = 0
    local npcIndex, npcID = 0, 0
    local selfIndex = _G.PlayerIndex
    for i = 1, nAttackers do
        npcIndex, npcID, _ = GetNpcEnmityItem(nDeadNpcIndex, i)
        if npcIndex > 0 and GetNpcID(npcIndex) == npcID then
            _G.PlayerIndex = NpcIdx2PIdx(npcIndex)
            if _G.PlayerIndex > 0 then
                if nDistance ~= nil and nDistance > 1 then
                    if Check_Distance(npcMapid, npcX, npcY, nDistance) == 1 then
                        hurtList[#hurtList + 1] = _G.PlayerIndex
                    end
                else
                    hurtList[#hurtList + 1] = _G.PlayerIndex
                end
            end
        end
    end
    _G.PlayerIndex = selfIndex

    return hurtList
end

function Is_InCamel()
    local nType = GetMorphType()
    if (nType == 1231 or nType == 1232 or nType == 3056 or nType == 3057) then

        return true
    else
        return false
    end
end

function Is_PlayerOnList(playerList)
    if playerList == nil then
        return false
    end
    local pAccount = GetPlayerAccount()
    local pName = GetName()
    if (playerList[pName]) ~= nil and (playerList[pName] == pAccount) then
        return true
    else
        return false
    end
end

function SetPlayerFameMaxLevelForAllForce(maxLevel)
    for i = 1, 5 do
        SetPlayerFameMaxLevel(i, maxLevel)
    end
end

function Reward_ExpAndMoney(nExp, nCash, nBindCash, nBindCoin)
    local msg = ""
    local flag = 0
    local Punc = function()
        if flag ~= 0 then
            msg = msg .. ","
        end
    end

    if nExp ~= nil and nExp > 0 then
        Punc()
        AddOwnExp(nExp)
        flag = SetByte(flag, 1, 1)
        msg = msg .. nExp .. " §iÓm kinh nghiÖm"
    end

    if nCash ~= nil and nCash > 0 then
        Punc()
        Earn(nCash)
        flag = SetByte(flag, 2, 1)
        msg = msg .. nCash .. " b¹c"
    end

    if nBindCash ~= 0 and nBindCash > 0 then
        Punc()
        EarnBind(nBindCash)
        flag = SetByte(flag, 3, 1)
        msg = msg .. nBindCash .. " b¹c khãa"
    end

    if nBindCoin ~= 0 and nBindCoin > 0 then
        Punc()
        AddBindCoin(nBindCoin)
        flag = SetByte(flag, 4, 1)
        msg = msg .. nBindCoin .. " Linh B¶o"
    end

    if flag ~= 0 then
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. msg .. ".")
        return true
    end
    return false
end

function DelNpcSafely(npcIndex, npcID)
    if (npcIndex <= 0) or (GetNpcID(npcIndex) ~= npcID) then
        return false
    end
    if (GetNpcKind(npcIndex) == 9) and (CanBuildingDestroy(npcIndex) ~= 0) then
        return DestroyBuilding(npcIndex) == 0 and true or false
    elseif (GetNpcKind(npcIndex) == 8) then
        local carriageindex = GetSiegeWeaponIndexByNpcIndex(npcIndex)
        DeleteSiegeWeapon(carriageindex)
    else
        DelNpc(npcIndex)
    end
    return true
end

function Reward_FameAndCredit(nValue, nRewardWhich)
    local msg = ""
    if (nValue <= 0) then
        return false
    end
    if (nRewardWhich == nil) then
        nRewardWhich = 3
    end
    if (nRewardWhich == 3) then
        ChangePlayerFame(GetPlayerForce(), nValue)
        msg = nValue .. " ®iÓm danh väng vµ vinh dù thÕ lùc"
    elseif (nRewardWhich == 2) then
        ChangePlayerFameValue(GetPlayerForce(), nValue)
        msg = nValue .. " ®iÓm vinh dù thÕ lùc"
    elseif (nRewardWhich == 1) then
        ChangePlayerFamePoint(GetPlayerForce(), nValue)
        msg = nValue .. " ®iÓm danh väng thÕ lùc"
    end
    if msg ~= "" then
        Msg2Player("Ng­¬i ®· nhËn ®­îc " .. msg .. ".")
        return true
    end
    return false
end

function Sort_Table(list, nIndex)
    if (list == nil) or (#list <= 0) then
        return false
    end
    if (nIndex == nil) or (nIndex <= 0) or (nIndex > #list) then
        nIndex = 1
    end
    for i = 1, #list do
        local temp = list[i][nIndex]
        list[i][nIndex] = list[i][1]
        list[i][1] = temp
    end
    sortFunc = function(a, b)
        return b[1] < a[1]
    end
    table.sort(list, sortFunc)
    for i = 1, #list do
        local temp = list[i][nIndex]
        list[i][nIndex] = list[i][1]
        list[i][1] = temp
    end
    return true
end

function FinishTask_All(nTaskID)

    local GlobalValue_Task = 429
    local TaskID__RewardPublic = 724

    if (nTaskID <= 0) then
        return
    end

    local nStoreTaskId = GetGlobalValue(GlobalValue_Task)
    if (nTaskID == nStoreTaskId) then
        local nDate = math.mod(math.floor(LocalSystemTime() / 86400), 65534) + 1
        SetTaskWord(TaskID__RewardPublic, 1, nTaskID)
        SetTaskWord(TaskID__RewardPublic, 2, nDate)
    end
end

function AddOwnExpDecay(ExpValue)
    if HaveIBBuff(2320) > 0 then
        TopMessage("§ang ë tr¹ng th¸i bÞ trõng ph¹t, kh«ng thÓ nhËn ®iÓm tu vi.")
        ExpValue = 0
    end

    local nReturnExp = AddOwnExtendExp(ExpValue)
    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nReturnExp .. " ®iÓm tu luyÖn!")
    return nReturnExp
end

function GetMapNameByID(nIndex)
    if (nIndex < 1 or nIndex > #GLOBALMAPNAME) then
        return ""
    end
    return GLOBALMAPNAME[nIndex]
end

function GetRandTable(t)
    local count = #t
    if (type(t) ~= "table" or count <= 0) then
        return t
    end

    local nTemp = 0
    local nRandSeed = GetPlayerID()
    local nExchangeTime = math.max(math.fmod(nRandSeed, count), math.ceil(count / 3))
    math.randomseed(nRandSeed)
    for i = 1, nExchangeTime do
        nTemp = math.random(1, count)
        local temp = t[i]
        t[i] = t[nTemp]
        t[nTemp] = temp
    end
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    return t
end

function isShowCoinString(nValue)
    local temp = math.fmod(nValue, 100)
    local cfs = math.floor(nValue / 100)
    if (temp >= 10) then
        cfs = cfs .. "." .. temp
    else
        cfs = cfs .. ".0" .. temp
    end

    return cfs
end

function reNewSetPos(x, y, rand)
    local NewX = x
    local NewY = y
    local pos =  math.random(1, rand)
    local ax =  math.random(-1, 1)
    local ay =  math.random(-1, 1)
    NewX = NewX + ax * pos
    pos =  math.random(1, rand)
    NewY = NewY + ay * pos
    return NewX, NewY
end

Escrot_Food_Task = 959
Escort_Food_Fake = 1052
ESCORTFOOD_LASTTIME = 1800

function reSetGuardIndex()
    local playername = GetName()
    local guardindex = GetTGuardIndexByPlayerName(playername)

    if (guardindex > 0) then
        local _, _, _, pName, carriageindex, _, _ = GetTGuardInfo(guardindex)
        if (GetTGuardTaskValue(guardindex, 2) > 0) then

            return guardindex
        end

        local carriagenpcindex = GetSiegeWeaponNpcIndex(carriageindex)
        local nPID = GetPlayerID()
        if (carriagenpcindex > 0) then
            local pID = GetNpcTask(carriagenpcindex, 1)
            local nTime = GetNpcTask(carriagenpcindex, 2)

            if (nPID == pID) then
                if ((LocalSystemTime() - nTime) > ESCORTFOOD_LASTTIME) then

                    SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\É¾µôÁ¸âÃ³µ.lua", 5)
                    WriteLog("[VËn L­¬ng[ Xo¸ bá xe l­¬ng qu¸ thêi gian carriagenpcindex=" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername .. " Thêi gian nhËn xe:" .. nTime)
                    return 0
                end
            elseif (pID == 0) and (playername == pName) then
                if (nTime > 0) then
                    if ((LocalSystemTime() - nTime) > ESCORTFOOD_LASTTIME) then

                        SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\É¾µôÁ¸âÃ³µ.lua", 5)
                        WriteLog("[VËn L­¬ng[ Xo¸ bá xe l­¬ng qu¸ thêi gian carriagenpcindex=" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername .. " Thêi gian nhËn xe:" .. nTime)
                        return 0
                    end
                else
                    if (GetTaskByte(Escrot_Food_Task, 1) == 1 or GetTaskByte(Escort_Food_Fake, 1) > 0) then
                        WriteLog("[VËn L­¬ng] - DÞ th­êng carriagenpcindex:" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername)
                        local HH, MM, SS = GetHMS()
                        local temp = (HH * 60 + MM) - GetTaskByte(Escrot_Food_Task, 3) * 60 + GetTaskByte(Escrot_Food_Task, 4)
                        if (temp > ESCORTFOOD_LASTTIME) then
                            SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\É¾µôÁ¸âÃ³µ.lua", 5)
                            return 0
                        elseif (temp < 0) then
                            temp = temp + 24 * 60
                            if (temp > ESCORTFOOD_LASTTIME) then
                                SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\É¾µôÁ¸âÃ³µ.lua", 5)
                                return 0
                            end
                        end
                    else
                        WriteLog("[VËn Töu] - DÞ th­êng carriagenpcindex:" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername)
                    end
                end
            else
                SetNpcTimer(carriagenpcindex, "\\script\\ÔËïÚ\\É¾µôÁ¸âÃ³µ.lua", ESCORTFOOD_LASTTIME)
                WriteLog("[VËn L­¬ng] - DÞ th­êng carriagenpcindex=" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername .. "pID:" .. pID .. "/ ID ng­êi ch¬i" .. nPID .. " Thêi gian nhËn xe:" .. nTime)
                CancleCarriage(guardindex)
                return 0
            end
        else
            CancleCarriage(guardindex)
            WriteLog("[VËn L­¬ng] - DÞ th­êng guardindex=" .. guardindex .. "carriagenpcindex=" .. carriagenpcindex .. " Tªn ng­êi ch¬i:" .. playername)
            return 0
        end
    end
    return guardindex
end

function oneExpDan(lvl, num)
    if (num == nil) then
        num = 100
    elseif (num <= 0) or (lvl < 40) then
        return 0
    end

    local nExp = math.floor((7.51 * lvl * lvl + 1829.65 * lvl - 66382) * num / 100)
    return nExp
end

function isWildSuperTrap(nType)
    local w, x, y = GetWorldPos()

    if (w == 64) then
        Talk(1, "no", 10625)
        return 0
    elseif (w == 66) then
        Talk(1, "no", 11062)
        return 0
    elseif (w == 71) then
        Talk(1, "no", 11061)
        return 0
    elseif (w == 72) then
        Talk(1, "no", 13122)
        return 0
    elseif (w == 83) or (w == 85) or (w == 86) then
        Talk(1, "no", GLOBALMAPNAME[w] .. " thêi ®iÓm nµy kh«ng thÓ sö dông truyÒn tèng phï.")
        return 0
    elseif (GetCamp() == 8) then
        Talk(1, "no", "Phe ph¸i nµy kh«ng thÓ sö dông TruyÒn phï")
        return 0
    elseif (GetPK() >= 88) then
        Talk(1, "no", "§iÓm PK nµy kh«ng thÓ dïng TruyÒn tèng phï")
        return 0
    elseif (IsWarServer() ~= 0) then
        Talk(1, "no", "Khu vùc nµy kh«ng thÓ sö dông TruyÒn phï")
        return 0
    elseif (GetCompeteFlag() == 1 and ((w >= 1 and w <= 4) or w == 28)) then
        Talk(1, "no", "N¬i nµy lµ khu vùc chiÕn ®Êu, kh«ng thÓ truyÒn tèng.")
        return 0
    elseif (GetMorphType() == 364) then
        Talk(1, "no", "Tr¹ng th¸i bµo th­¬ng kh«ng thÓ dïng truyÒn tèng phï.")
        return 0
    elseif (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", "Trong xe kh«ng thÓ dïng truyÒn tèng phï.")
        return 0
    else
        for i = 1920, 1929 do
            if (HaveIBBuff(i) > 0) then
                Talk(1, "no", "Trong tr¹ng th¸i Thiªn KiÕp kh«ng thÓ sö dông TruyÒn tèng phï")
                return 0
            end
        end
    end

    if (nType >= 2) then
        if (GetCamp() == 0) then
            Talk(1, "no", "T©n Thñ kh«ng thÓ dïng truyÒn tèng phï")
            return 0
        elseif (IsNewBirthComplete() == 0) then
            Talk(1, "no", "Ch­a chuyÓn sinh Tiªn Ma, kh«ng thÓ sö dông truyÒn tèng ë thiªn th­îng.")
            return 0
        end
    end
    return 1
end

function RepayBindCoin()
    local BuffID = 1934
    local LeftBuffTimes = GetIBBuffTimes(BuffID)
    local LB = GetBindCoin()
    local LB1 = math.floor(LB / 100)
    if (LeftBuffTimes >= 1 and LB1 >= 1) then
        if (LB1 <= LeftBuffTimes) then
            if (DecBindCoin(LB1 * 100) == 1) then
                CostIBBuff(BuffID, LB1)
                WriteLog("[VÐ Truy Thu Linh B¶o][§· khÊu trõ " .. LB1 .. " Linh B¶o vµ tr¹ng th¸i vÐ ph¹t][Cßn nî: " .. GetIBBuffTimes(BuffID) .. "]")
                return LB1
            end
        elseif (LB1 > LeftBuffTimes) then
            CostIBBuff(BuffID, LeftBuffTimes)
            WriteLog("[VÐ Truy Thu Linh B¶o][§· khÊu trõ " .. LeftBuffTimes .. " Linh B¶o vµ tr¹ng th¸i vÐ ph¹t][Cßn nî: " .. GetIBBuffTimes(BuffID) .. "]")
            DecBindCoin(LeftBuffTimes * 100)
            return LeftBuffTimes
        else
            return 0
        end
    else
        return 0
    end
end

UNPACK_PAYMONEY = 100000
Unpack_TABLE = {
    [1] = { item = { 6, 1, 1571, 1 }, name = "Ho¶ Vò", nums = 250, malterItem = { 3, 8, 0, 0 }, },
    [2] = { item = { 6, 1, 1572, 1 }, name = "Quû DiÖn", nums = 250, malterItem = { 3, 12, 0, 0 }, },
    [3] = { item = { 6, 1, 1573, 1 }, name = "B¨ng C¬", nums = 250, malterItem = { 3, 13, 0, 0 }, },
    [4] = { item = { 6, 1, 1574, 1 }, name = "Ngäc Cèt", nums = 250, malterItem = { 3, 9, 0, 0 }, },
    [5] = { item = { 6, 1, 1575, 1 }, name = "§o¹n KiÕm", nums = 250, malterItem = { 3, 10, 0, 0 }, },
    [6] = { item = { 6, 1, 1576, 1 }, name = "To¸i Gi¸p", nums = 250, malterItem = { 3, 11, 0, 0 }, },
    [7] = { item = { 6, 1, 1577, 1 }, name = "Phong LÖ", nums = 250, malterItem = { 3, 23, 0, 0 }, },
    [8] = { item = { 6, 1, 1578, 1 }, name = "§Þa T©m", nums = 250, malterItem = { 3, 22, 0, 0 }, },
    [9] = { item = { 6, 1, 1579, 1 }, name = "Thñy Hån", nums = 250, malterItem = { 3, 24, 0, 0 }, },
    [10] = { item = { 6, 1, 1580, 1 }, name = "Háa Linh", nums = 250, malterItem = { 3, 25, 0, 0 }, },
    [11] = { item = { 6, 1, 1581, 1 }, name = "§¹i ®Þa nh·n", nums = 250, malterItem = { 3, 116, 0, 0 }, },
    [12] = { item = { 6, 1, 1582, 1 }, name = "Hoµn Quan nh·n", nums = 250, malterItem = { 3, 117, 0, 0 }, },
    [13] = { item = { 6, 1, 1583, 1 }, name = "LiÖt DiÖm nh·n", nums = 250, malterItem = { 3, 118, 0, 0 }, },
    [14] = { item = { 6, 1, 1584, 1 }, name = "Phong B¹o nh·n", nums = 250, malterItem = { 3, 119, 0, 0 }, },
    [15] = { item = { 6, 1, 1585, 1 }, name = "HuyÔn Linh Nh·n", nums = 250, malterItem = { 3, 1173, 0, 0 }, },
    [16] = { item = { 6, 1, 1586, 1 }, name = "Tiªn Lé", nums = 250, malterItem = { 3, 1011, 0, 0 }, },
    [17] = { item = { 6, 1, 1587, 1 }, name = "Tiªn Lé Tinh Hoa", nums = 250, malterItem = { 3, 1184, 0, 0 }, },
    [18] = { item = { 6, 1, 1588, 1 }, name = "§ång Bèi", nums = 250, malterItem = { 3, 233, 0, 0 }, },
    [19] = { item = { 6, 1, 1589, 1 }, name = "M¹n ch©u sa hoa", nums = 250, malterItem = { 3, 312, 0, 0 }, },
    [20] = { item = { 6, 1, 1590, 1 }, name = "M¹n ®µ lµ hoa", nums = 250, malterItem = { 3, 311, 0, 0 }, },
    [21] = { item = { 6, 1, 1591, 1 }, name = "Th«i Phong LÖnh", nums = 250, malterItem = { 3, 174, 0, 0 }, },
    [22] = { item = { 6, 1, 1592, 1 }, name = "Tinh Anh LÖnh", nums = 250, malterItem = { 3, 1056, 0, 0 }, },
    [23] = { item = { 6, 1, 1593, 1 }, name = "Thøc ¨n gia sóc", nums = 250, malterItem = { 3, 137, 0, 0 }, },


}
function UnPackMain()
    local tasks = {
        { "<c=g>§ãng gãi vËt phÈm<c>", "UnPackBag"; show = 1 },
        { "<c=y>§æi D­îc PhÈm<c>", "PotionBag"; show = 1 },
        { "Giíi thiÖu", "UnPackInfo"; show = 1 },
    }
    SayTask("GÇn ®©y ta nghiªn cøu ra mét lo¹i tói ®ùng míi, cã thÓ ®em mét phÇn vËt phÈm cña ngµi ®em ®ãng gãi l¹i, chØ cÇn bá ra 10 v¹n b¹c kho¸ lµ ta cã thÓ gióp ®ãng gãi l¹i nh÷ng vËt phÈm chiÕm nhiÒu vÞ trÝ trong hµnh trang. H·y chän lo¹i vËt phÈm muèn ®ãng gãi.", tasks)
end

function no()
    CloseDialog()
end

function UnPackInfo()
    Talk(1, "UnPackInfo1", "HiÖn t¹i cã thÓ ®ãng gãi:\nLôc §¹o, Tø T­îng, c¸c lo¹i Nh·n V¹n Tiªn TrËn, M¹n §µ La Hoa, M¹n Ch©u Sa Hoa, Th«i Phong LÖnh, Tinh Anh LÖnh, Tiªn Lé, Tiªn Lé Tinh hoa, Thøc ¨n gia sóc,\nVËt phÈm kh«ng kho¸ kh«ng thÓ ®ãng gãi cïng vËt phÈm kho¸, mçi nhãm (1 «) ®ãng gãi thµnh 1 tói lín. Khi ®ãng gãi quy t¾c kho¸/kh«ng kho¸ cña vËt phÈm kh«ng thay ®æi.")
end

function UnPackInfo1()
    Talk(1, "UnPackMain", "HiÖn ta cã thÓ th¨ng cÊp giíi h¹n chøa cña, Tói Thanh Lé (tiÓu), Tói Ch©n KhÝ (tiÓu), Tói B¶o H÷u Thanh Lé vµ Tói S¬n Thñy Ch©n KhÝ, chØ cÇn cÇm tíi <c=g>4 c¸i<c> tói d­îc phÈm vµ <c=g>10 v¹n b¹c khãa<c> lµ cã thÓ <c=y>më réng dung l­îng gÊp 4 lÇn<c> d­îc phÈm t­¬ng øng. Thêi h¹n d­îc phÈm ®­îc gi÷ nguyªn nh­ d­îc phÈm gèc.")
end

function UnPackPay(amount)

    local temp = GetBindCash()
    if (temp < amount) then
        if (GetCash() + temp < amount) then
            Msg2Player("B¹c kho¸ hoÆc b¹c cña ng­¬i kh«ng ®ñ " .. amount)
            return 0
        else
            PayBind(amount)
            Pay(amount - temp)
            Msg2Player("B¹c kho¸ cña ng­¬i chØ cã " .. temp .. ", dïng b¹c thay thÕ " .. (amount - temp))
            return 1
        end
    else
        PayBind(amount)
        return 1
    end
end

function PotionBag()
    local tasks = {
        { "<c=r>Tói Thanh Lé (tiÓu)", "PotionBagYes"; show = 1 },
        { "<c=b>Tói Ch©n KhÝ (tiÓu)", "PotionBagYes1"; show = 1 },
        { "<c=r>Tói B¶o H÷u Thanh Lé", "PotionBagYes2"; show = 1 },
        { "<c=b>Tói S¬n Thñy Ch©n KhÝ", "PotionBagYes3"; show = 1 },
        { "Quay l¹i", "UnPackMain"; show = 1 },
    }
    SayTask("HiÖn ta cã thÓ th¨ng cÊp giíi h¹n chøa cña: Tói Thanh Lé (tiÓu), Tói Ch©n KhÝ (tiÓu), Tói B¶o H÷u Thanh Lé vµ Tói S¬n Thñy Ch©n KhÝ, chØ cÇn cÇm tíi <c=g>4 c¸i<c> tói d­îc phÈm vµ <c=g>10 v¹n b¹c khãa<c> lµ cã thÓ <c=y>më réng dung l­îng gÊp 4 lÇn<c> d­îc phÈm t­¬ng øng. Thêi h¹n d­îc phÈm ®­îc gi÷ nguyªn nh­ d­îc phÈm gèc. H·y chän lo¹i muèn thao t¸c:", tasks)
end

function PotionBagYes()
    if (GetBindCash() < UNPACK_PAYMONEY) then
        MsgBox("ChØ cÇn cÇm theo <c=g>4 Tói Thanh Lé (tiÓu)<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn <c=y>Thanh Lé Sinh MÖnh<c>, x¸c nhËn muèn ®æi chø?\n<c=r>B¹c kho¸ kh«ng ®ñ sÏ kh¸u trõ b¹c thay thÕ<c>.", "PotionBag_Yes", "PotionBag")
    else
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói Thanh Lé (tiÓu)<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn <c=y>Thanh Lé Sinh MÖnh<c>, x¸c nhËn muèn ®æi chø?", "PotionBag_Yes", "PotionBag")
    end
end

function PotionBag_Yes()
    no()
    if (HaveNormalItem(6, 1, 1118, 0) <= 3) then
        Talk(1, "PotionBag", "ThËt xin lçi, Tói D­îc PhÈm cña ngµi ch­a ®ñ <c=r>4 c¸i <c>.")
        return
    end

    if (UnPackPay(UNPACK_PAYMONEY) < 1) then
        Talk(1, "no", "ThËt xin lçi, b¹c kho¸ hoÆc b¹c cña ngµi ch­a ®ñ <c=r>" .. UNPACK_PAYMONEY .. "<c>.")
        return
    end

    for i = 1, 4 do
        DelNormalItem(6, 1, 1118, 0)
    end

    AddNormalItem(8, 162, 3, 0, 0, 0)
    Msg2Player("Ngµi ®· ®æi 1 c¸i Thanh Lé Sinh MÖnh")
    WriteLog("[§ãng gãi vËt phÈm][§æi D­îc PhÈm][Thanh Lé Sinh MÖnh]")
end

function PotionBagYes1()
    if (GetBindCash() < UNPACK_PAYMONEY) then
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói Ch©n KhÝ<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>NhËt NguyÖt Ch©n KhÝ<c>, x¸c nhËn muèn ®æi chø?\n<c=r>B¹c kho¸ kh«ng ®ñ sÏ kh¸u trõ b¹c thay thÕ<c>.", "PotionBag_Yes1", "PotionBag")
    else
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói Ch©n KhÝ<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>NhËt NguyÖt Ch©n KhÝ<c>, x¸c nhËn muèn ®æi chø?", "PotionBag_Yes1", "PotionBag")
    end
end

function PotionBag_Yes1()
    no()
    if (HaveNormalItem(6, 1, 1119, 0) <= 3) then
        Talk(1, "PotionBag", "ThËt xin lçi, Tói D­îc PhÈm cña ngµi ch­a ®ñ <c=r>4 c¸i <c>.")
        return
    end

    if (UnPackPay(UNPACK_PAYMONEY) < 1) then
        Talk(1, "no", "ThËt xin lçi, b¹c kho¸ hoÆc b¹c cña ngµi ch­a ®ñ <c=r>" .. UNPACK_PAYMONEY .. "<c>.")
        return
    end

    for i = 1, 4 do
        DelNormalItem(6, 1, 1119, 0)
    end

    AddNormalItem(8, 163, 4, 0, 0, 0)
    Msg2Player("Ngµi ®· ®æi 1 c¸i NhËt NguyÖt Ch©n KhÝ")
    WriteLog("[§ãng gãi vËt phÈm][§æi D­îc PhÈm][NhËt NguyÖt Ch©n KhÝ]")
end

function PotionBagYes2()
    if (GetBindCash() < UNPACK_PAYMONEY) then
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói B¶o H÷u Thanh Lé<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>B¶o H÷u Thanh Lé (Siªu)<c>, x¸c nhËn muèn ®æi chø?\n<c=r>B¹c kho¸ kh«ng ®ñ sÏ kh¸u trõ b¹c thay thÕ<c>.", "PotionBag_Yes2", "PotionBag")
    else
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói B¶o H÷u Thanh Lé<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>B¶o H÷u Thanh Lé (Siªu)<c>, x¸c nhËn muèn ®æi chø?", "PotionBag_Yes2", "PotionBag")
    end
end

function PotionBag_Yes2()
    no()
    if (HaveNormalItem(6, 1, 1120, 0) <= 3) then
        Talk(1, "PotionBag", "ThËt xin lçi, Tói D­îc PhÈm cña ngµi ch­a ®ñ <c=r>4 c¸i <c>.")
        return
    end

    if (UnPackPay(UNPACK_PAYMONEY) < 1) then
        Talk(1, "no", "ThËt xin lçi, b¹c kho¸ hoÆc b¹c cña ngµi ch­a ®ñ <c=r>" .. UNPACK_PAYMONEY .. "<c>.")
        return
    end

    for i = 1, 4 do
        DelNormalItem(6, 1, 1120, 0)
    end

    AddNormalItem(8, 1953, 3, 0, 0, 0)
    Msg2Player("Ngµi ®· ®æi 1 c¸i B¶o H÷u Thanh Lé (Siªu)")
    WriteLog("[§ãng gãi vËt phÈm][§æi D­îc PhÈm][B¶o H÷u Thanh Lé (Siªu)]")
end

function PotionBagYes3()
    if (GetBindCash() < UNPACK_PAYMONEY) then
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói S¬n Thñy Ch©n KhÝ<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>S¬n Thuû Ch©n KhÝ (Siªu)<c>, x¸c nhËn muèn ®æi chø?\n<c=r>B¹c kho¸ kh«ng ®ñ sÏ kh¸u trõ b¹c thay thÕ<c>.", "PotionBag_Yes3", "PotionBag")
    else
        MsgBox("ChØ cÇn cÇm theo <c=g>4 c¸i Tói S¬n Thñy Ch©n KhÝ<c> vµ <c=g>10 v¹n b¹c khãa<c> lµ ta cã thÓ gióp ng­¬i më réng gÊp 4 lÇn<c=y>S¬n Thuû Ch©n KhÝ (Siªu)<c>, x¸c nhËn muèn ®æi chø?", "PotionBag_Yes3", "PotionBag")
    end
end

function PotionBag_Yes3()
    no()
    if (HaveNormalItem(6, 1, 1121, 0) <= 3) then
        Talk(1, "PotionBag", "ThËt xin lçi, Tói D­îc PhÈm cña ngµi ch­a ®ñ <c=r>4 c¸i <c>.")
        return
    end

    if (UnPackPay(UNPACK_PAYMONEY) < 1) then
        Talk(1, "no", "ThËt xin lçi, b¹c kho¸ hoÆc b¹c cña ngµi ch­a ®ñ <c=r>" .. UNPACK_PAYMONEY .. "<c>.")
        return
    end

    for i = 1, 4 do
        DelNormalItem(6, 1, 1121, 0)
    end

    AddNormalItem(8, 1954, 4, 0, 0, 0)
    Msg2Player("Ngµi ®· ®æi 1 c¸i S¬n Thuû Ch©n KhÝ (Siªu)")
    WriteLog("[§ãng gãi vËt phÈm][§æi D­îc PhÈm][S¬n Thuû Ch©n KhÝ (Siªu)]")
end

function UnPackBag()
    no()
    MsgBox("GÇn ®©y ta nghiªn cøu ra mét lo¹i tói ®ùng míi, cã thÓ ®em mét phÇn vËt phÈm cña ngµi ®em ®ãng gãi l¹i, chØ cÇn bá ra <c=y>10 v¹n b¹c kho¸<c> lµ ta cã thÓ gióp ®ãng gãi l¹i nh÷ng vËt phÈm chiÕm nhiÒu vÞ trÝ trong hµnh trang. \n<c=r>VËt khÈm kho¸ vµ vËt phÈm kh«ng kho¸ kh«ng thÓ ®ãng gãi chung víi nhau<c>\nH·y nhÊp <c=g>chuét tr¸i<c> vµo vËt phÈm muèn ®ãng gãi trong hµnh trang", "Yes_UnPackBag", "UnPackMain")
end

function Yes_UnPackBag()
    no()
    MouseSelect(1, 22, "UnPackBagYes", "UnPackBag")
end

function UnPackBagYes(ItemID)
    SetTask(142, ItemID)
    local name = GetItemName(ItemID)
    local key = 0
    for i = 1, #Unpack_TABLE do
        if (name == Unpack_TABLE[i].name) then
            key = i
            break
        end
    end

    if (key == 0) then
        Talk(1, "UnPackBag", "ThËt xin lçi, <c=r>" .. name .. "<c> cña ngµi kh«ng n»m trong danh s¸ch vËt phÈm ta cã thÓ gióp ®ãng gãi.")
    else
        MsgBox("X¸c nhËn chi <c=g>10 v¹n b¹c khãa<c> ®ãng gãi vËt phÈm <c=y>" .. name .. "<c>\nNhÊn [X¸c nhËn] ®Ó ®ãng gãi, nhÊn [Huû] ®Ó chän l¹i.", "UnPackBag_Yes", "Yes_UnPackBag")
    end

end

function UnPackBag_Yes()
    local ItemID = GetTask(142)
    SetTask(142, 0)
    local name = GetItemName(ItemID)
    local key = 0
    for i = 1, #Unpack_TABLE do
        if (name == Unpack_TABLE[i].name) then
            key = i
            break
        end
    end

    if (name == nil) or (name == "") or (key == 0) then
        Talk(1, "Yes_UnPackBag", "ThËt xin lçi, ®ãng gãi thÊt b¹i, vui lßng chän l¹i!")
        return
    end

    local nCount = GetItemCountByID(ItemID)
    if (nCount < Unpack_TABLE[key].nums) then
        Talk(1, "Yes_UnPackBag", "ThËt xin lçi, ®ãng gãi thÊt b¹i, vËt phÈm nµy ch­a ®ñ mét nhãm <c=r>" .. Unpack_TABLE[key].nums .. " c¸i<c>, xin h·y chän l¹i.")
        return
    end

    if (UnPackPay(UNPACK_PAYMONEY) < 1) then
        Talk(1, "no", "ThËt xin lçi, b¹c kho¸ hoÆc b¹c cña ngµi ch­a ®ñ <c=r>" .. UNPACK_PAYMONEY .. "<c>.")
        return
    end
    local isBind = IsItemBind(ItemID)

    for i = 1, Unpack_TABLE[key].nums do
        DelItemByID(ItemID)
    end

    local id = Unpack_TABLE[key].item
    if (isBind <= 0) then
        AddNormalItemPile(id[1], id[2], id[3], id[4], 0, 0)
    else
        AddNormalItemBind(id[1], id[2], id[3], id[4], 0, 0, 1)
    end

    WriteLog("[§ãng gãi vËt phÈm][µÀ¾ß:" .. name)
    MsgBox("Thñ Khè: §ãng gãi <c=y>" .. name .. "<c> thµnh c«ng, ngµi cã muèn tiÕp tôc ®ãng gãi vËt phÈm kh¸c kh«ng?\nNhÊn [X¸c ®Þnh] ®Ó tiÕp tôc, nhÊn [Huû] ®Ó ®ãng l¹i.", "Yes_UnPackBag", "no")
end

G_sendMsgList = {
    { w = 5, xy = { 1709, 3063 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 6, xy = { 1733, 3013 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 7, xy = { 1766, 3365 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 8, xy = { 1853, 2803 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 9, xy = { 1706, 3452 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 10, xy = { 1436, 3124 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 11, xy = { 1810, 3133 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 12, xy = { 1720, 3319 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 13, xy = { 1835, 3002 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 14, xy = { 1575, 3378 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 15, xy = { 1539, 3403 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 16, xy = { 1633, 3192 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 17, xy = { 1747, 3380 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 18, xy = { 1620, 3150 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 19, xy = { 1645, 3137 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 22, xy = { 1625, 3265 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 23, xy = { 1621, 3353 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 24, xy = { 1608, 3190 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 25, xy = { 1608, 3145 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 26, xy = { 1658, 3180 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 27, xy = { 1823, 2975 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 28, xy = { 1824, 2928 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 29, xy = { 1538, 2918 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 30, xy = { 1595, 2976 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 31, xy = { 1765, 2857 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 32, xy = { 1848, 2913 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 33, xy = { 1753, 3044 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 34, xy = { 1488, 3168 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 35, xy = { 1763, 3382 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 36, xy = { 1425, 3457 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 37, xy = { 1851, 2998 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 38, xy = { 1828, 2983 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 39, xy = { 1879, 2878 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 40, xy = { 1976, 3056 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 41, xy = { 1890, 3394 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 42, xy = { 1825, 3155 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 43, xy = { 1624, 3241 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 44, xy = { 1909, 3086 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 45, xy = { 1525, 3264 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 46, xy = { 1896, 3000 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 47, xy = { 1597, 3141 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 48, xy = { 1578, 3151 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 49, xy = { 1559, 3151 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 50, xy = { 1603, 3156 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 51, xy = { 1506, 3161 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 65, xy = { 1648, 3024 }, npcname = "§¹i phu", key = 0, s = 1, },
    { w = 73, xy = { 245 * 8, 206 * 16 }, npcname = "§¾c Kû", key = 0, s = 1, },
    { w = 73, xy = { 242 * 8, 229 * 16 }, npcname = "Liªn §¨ng Hé sø (Tiªn)", key = 0, s = 1, },
    { w = 73, xy = { 206 * 8, 206 * 16 }, npcname = "Liªn §¨ng Hé sø (Ma)", key = 0, s = 1, },
    { w = 73, xy = { 251 * 8, 208 * 16 }, npcname = "VËt tæ Tiªn KiÕp", key = 0, s = 1, },
    { w = 73, xy = { 242 * 8, 202 * 16 }, npcname = "VËt tæ Ma KiÕp", key = 0, s = 1, },
    { w = 73, xy = { 227 * 8, 216 * 16 }, npcname = "Ng­êi Huynh §Ö h¸i thuèc", key = 0, s = 1, },
    { w = 73, xy = { 204 * 8, 236 * 16 }, npcname = "Khe nøt Minh Giíi", key = 0, s = 1, },
    { w = 74, xy = { 1728, 3745 }, npcname = "§¹i phu (Tiªn)", key = 1, s = 0, },
    { w = 74, xy = { 1636, 3659 }, npcname = "§¹i phu (Ma)", key = 1, s = 0, },
    { w = 74, xy = { 200 * 8, 239 * 16 }, npcname = "Thiªn To¸n Tö", key = 1, s = 1, },
    { w = 74, xy = { 2040, 3570 }, npcname = "Thiªn Niªn §¹i th¹ch", key = 1, s = 1, },
    { w = 74, xy = { 234 * 8, 220 * 16 }, npcname = "BiÕn th©n §¹i Uy Thiªn Long", key = 1, s = 1, },
    { w = 74, xy = { 246 * 8, 229 * 16 }, npcname = "Thiªn Nh¹c ngôc tèt", key = 1, s = 1, },
    { w = 75, xy = { 236 * 8, 215 * 16 }, npcname = "§¹i phu", key = 2, s = 0, },
    { w = 75, xy = { 242 * 8, 199 * 16 }, npcname = "Thanh V©n Kh¸ch", key = 2, s = 1, },
    { w = 75, xy = { 254 * 8, 238 * 16 }, npcname = "Phï Du Tö", key = 2, s = 1, },
    { w = 75, xy = { 2092, 3344 }, npcname = "TiÕu L«i", key = 2, s = 1, },
    { w = 76, xy = { 248 * 8, 240 * 16 }, npcname = "§¹i phu (Tiªn)", key = 3, s = 0, },
    { w = 76, xy = { 203 * 8, 201 * 16 }, npcname = "§¹i phu (Ma)", key = 3, s = 0, },
    { w = 76, xy = { 247 * 8, 211 * 16 }, npcname = "TrÇm Miªn Nh·n", key = 3, s = 1, },
    { w = 76, xy = { 212 * 8, 203 * 16 }, npcname = "Hån Kh­¬ng Ngu TÝch", key = 3, s = 1, },
    { w = 76, xy = { 246 * 8, 236 * 16 }, npcname = "Mé C¬ HuyÒn Phong", key = 3, s = 1, },
    { w = 76, xy = { 224 * 8, 226 * 16 }, npcname = "TriÕt Phôc", key = 3, s = 1, },
    { w = 76, xy = { 254 * 8, 218 * 16 }, npcname = "LÒu v¶i ®æ n¸t", key = 3, s = 1, },
}

function sendMsg_npc(name)
    local idx = GetTaskByte(2253, 3)
    if (idx > 0) or (idx < #G_sendMsgList) then
        if (name == G_sendMsgList[idx].npcname) then
            local w, x, y = GetWorldPos()
            if (w == G_sendMsgList[idx].w) then
                SetTaskByte(2253, 1, 2)
                Talk(1, "no", name .. ": Ta ®· nhËn ®­îc tin tøc, h·y vÒ håi b¸o §¹i phu BÊt Chu Thiªn Quan")
                if (GetJusticEvilCredit() > 0) then
                    TaskNote(122, 1)
                else
                    TaskNote(121, 1)
                end
                return 1
            end
        end
    end
    return 0
end

Gkillact = {
    { w = 73, ss = { "Phi Thè", "Méc thÇn", "Ninh Miªu", "Tiªn Kh©m Nguyªn", "Ma Kh©m Nguyªn", "Tiªn Ly Ch©u", "Ma Ly Ch©u" }, rmax = 7 },
    { w = 74, ss = { "Tiªn Phong Yªu", "Ma Phong Yªu", "Sãi", "Tiªn Phong thó s¬n hån", "Ma Phong thó s¬n hån", "HuyÕt Yªu" }, rmax = 6 },
    { w = 75, ss = { "Thõa Hoµng", "Tiªn-Lª Linh Thi", "Ma-Lª Linh Thi", "KhØ nói" }, rmax = 4 },
    { w = 76, ss = { "Chóc ThÇn", "Tiªn-Chu LÜnh", "Ma-Chu LÜnh", "CÈu Mang" }, rmax = 4 },
}

function killact_npc(npcindex)
    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    if (GetTaskByte(2255, 1) ~= 1) then
        return 0
    end

    local l = 0
    for i = 1, 4 do
        if (Gkillact[i].w == w) then
            l = i
            break
        end
    end

    if (l == 0) then
        return 0
    end

    local idx = 0
    local npcname = GetNpcName(npcindex)
    for i = 1, Gkillact[l].rmax do
        if (Gkillact[l].ss[i] == npcname) then
            idx = i + l * 10
            break
        end
    end

    if (idx == 0) or (GetTaskByte(2255, 2) ~= idx) then
        return 0
    end

    local count = GetTaskByte(2255, 3) - 1
    if (count <= 0) then
        TaskNote(123, 2)
        SetTaskByte(2255, 3, 0)
        SetTaskByte(2255, 1, 2)
        ScrollMessage("Hoµn thµnh nhiÖm vô Hµng phôc " .. npcname .. ".")
    else
        ScrollMessage("NhiÖm vô Hµng phôc: Cßn ph¶i hµng phôc <c=r>" .. count .. "<c> " .. npcname)
        TaskNote(123, 1, count, npcname)
        SetTaskByte(2255, 3, count)
    end
end

Gcapturenpc = Gkillact
function capture_npc(npcindex)
    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) or (w ~= GetTask(966)) then
        return 0
    end

    if (GetTaskByte(2257, 1) ~= 1) then
    end

    if (SystemTime() > (GetTask(969) + 200)) then
        return 0
    end ;

    local l = 0
    for i = 1, 4 do
        if (Gcapturenpc[i].w == w) then
            l = i
            break
        end
    end

    if (l == 0) then
        return 0
    end

    local idx = 0
    local npcname = GetNpcName(npcindex)
    for i = 1, Gcapturenpc[l].rmax do
        if (Gcapturenpc[l].ss[i] == npcname) then
            idx = i + l * 10
            break
        end
    end

    if (idx == 0) or (GetTaskByte(2257, 2) ~= idx) then
        return 0
    end

    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 500) then
        local p = math.random(1, 3)
        local count = GetTaskByte(2257, 3) + 1

        if (p == 3) then
            if (count >= 5) then
                if (GetJusticEvilCredit() > 0) then
                    TaskNote(124, 2)
                else
                    TaskNote(125, 2)
                end

                SetTaskByte(2257, 3, 5)
                SetTaskByte(2257, 1, 2)
                ScrollMessage("Hoµn thµnh nhiÖm vô b¾t " .. npcname .. ".")
            else
                ScrollMessage("B¾t " .. npcname .. " - Tinh Ph¸ch <c=r>" .. count .. "<c>/5")
                if (GetJusticEvilCredit() > 0) then
                    TaskNote(124, 1, npcname, count)
                else
                    TaskNote(125, 1, npcname, count)
                end
                SetTaskByte(2257, 3, count)
            end
        else
            ScrollMessage("HÊp Hån Ph­ín: HÊp thu thÊt b¹i")
        end
    else
        Msg2Player("HÊp Hån Ph­ín:" .. npcname .. " kh«ng n»m trong ph¹m vi cña HÊp Hån TrËn.")
    end ;
end


