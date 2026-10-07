require("newserver.luax")

TONG_TASK_BANNER = 52

CITY_BANNER_BREAK = 64

CITY_BANNER_TIME1 = 65
CITY_BANNER_TIME2 = 66

tbl_BANNER_POS = {
    [0] = { { x = 1677, y = 3167, npc = 1950 },
            { x = 1680, y = 3168, npc = 1957 }, },
    [1] = { { x = 1671, y = 3154, npc = 1950 },
            { x = 1674, y = 3155, npc = 1957 }, },
    [2] = { { x = 1670, y = 3162, npc = 1950 },
            { x = 1673, y = 3163, npc = 1957 }, },
    [3] = { { x = 1675, y = 3167, npc = 1950 },
            { x = 1678, y = 3168, npc = 1957 }, },
    [4] = { { x = 1811, y = 3067, npc = 1950 },
            { x = 1814, y = 3068, npc = 1957 }, },
}

Task_Banner_Buff = 1862
G_BannerBuffDec = 1482
G_BannerBuffAdd = 1483

function main()
    if (HaveIBBuff(1488) > 0) then
        AddIBBuff(1490, 6)
    end

    if (IsInCity() == 0 or IsOwnerCity() == 0) then
        return
    end

    local taskstep = GetTaskByte(Task_Banner_Buff, 2)
    local CityName, CityMode, CityMoney, CityMat, CityLevel, CityTemplet, TongName = GetCityInfo()
    local nCityID = GetCityIDByName(CityName)
    local nState = GetByte(GetCityTaskByID(nCityID, CITY_BANNER_BREAK), 1)
    if (taskstep ~= 1 or nState == 1) then
        return
    end

    if (GetPlayerState() ~= 8) then
        ScrollMessage("Hi÷n tπi kh´ng ph∂i trπng th∏i ngÂi thi“n")
        return
    end

    if (GetCamp() ~= 2) then
        ScrollMessage("ƒ˙œ÷‘⁄≤ª «◊œ…´æØΩ‰’Û”™")
        return
    end

    local CityName, CityMode, CityMoney, CityMat, CityLevel, CityTemplet, TongName = GetCityInfo()
    local w, nMapX, nMapY = GetWorldPos()
    if (isinarea(CityTemplet, nMapX, nMapY) == 0) then
        ScrollMessage("Bπn kh´ng ngÂi thi“n g«n tinh k˙ chi’n.")
        return
    end

    if (IsOwnerCity() == 0) then
        ScrollMessage("ƒ˙≤ª‘⁄±æπ˙≥« –¥Ú◊¯")
        return
    end

    if (GetFightState() ~= 1) then
        ScrollMessage("Hi÷n tπi kh´ng ph∂i trπng th∏i chi’n Æ u")
        return
    end

    local nTongName = GetTongName()
    local nTongID = GetTongIDByName(nTongName)
    local nBannerState = GetTongTaskByID(nTongID, TONG_TASK_BANNER)
    local nExp = 1
    if (GetByte(nBannerState, 3) == 1 and GetByte(nBannerState, 2) ~= 1) then
        nExp = 2
    elseif (GetByte(nBannerState, 3) == 1 and GetByte(nBannerState, 2) == 1) then
        nExp = 2.5
    elseif (GetByte(nBannerState, 2) == 1) then
        nExp = 1.5
    end

    local doublestr = ""
    if (NewServerEx.Pub_IsExpectTongFlagTime() > 0) then
        nExp = nExp * 2
        doublestr = "ƒø«∞¥¶”⁄Ï∫∆ÏªÓ∂Ø ±º‰, ’∞—ˆÏ∫∆Ïæ≠—È∑≠±∂,"
    end

    local nLevel = GetLevel()
    local nExtendLevel = GetPlayerExtLevel()
    if (nExp > 0) then
        if (nLevel >= 200 and nExtendLevel >= 12 and GetJusticEvilCredit() ~= 0) then
            if (nExtendLevel >= 12 and nExtendLevel < 24) then
                nExp = math.floor(nExp * nExtendLevel * 20)
            elseif (nExtendLevel >= 24 and nExtendLevel < 31) then
                nExp = math.floor(nExp * nExtendLevel * 30)
            elseif (nExtendLevel >= 31 and nExtendLevel < 41) then
                nExp = math.floor(nExp * nExtendLevel * 40)
            elseif (nExtendLevel >= 41 and nExtendLevel < 51) then
                nExp = math.floor(nExp * nExtendLevel * 46)
            elseif (nExtendLevel >= 51 and nExtendLevel < 61) then
                nExp = math.floor(nExp * nExtendLevel * 53)
            elseif (nExtendLevel >= 61) then
                nExp = math.floor(nExp * nExtendLevel * 66)
            end
            AddOwnExtendExp(nExp)
            ScrollMessage("NhÀn Æ≠Óc " .. nExp .. " ßi”m tu hµnh.")
            Msg2Player(doublestr .. "ChÛc mıng bπn nhÀn Æ≠Óc " .. nExp .. " ßi”m tu hµnh.")
        else
            if (nLevel >= 30 and nLevel < 60) then
                nExp = math.floor(nExp * nLevel * 40)
            elseif (nLevel >= 60 and nLevel < 90) then
                nExp = math.floor(nExp * nLevel * 80)
            elseif (nLevel >= 90 and nLevel < 120) then
                nExp = math.floor(nExp * nLevel * 100)
            elseif (nLevel >= 120) then
                nExp = math.floor(nExp * nLevel * 135)
            end
            AddOwnExp(nExp)
            ScrollMessage("NhÀn Æ≠Óc " .. nExp .. " Æi”m kinh nghi÷m.")
            Msg2Player(doublestr .. "ChÛc mıng bπn nhÀn Æ≠Óc " .. nExp .. " Æi”m kinh nghi÷m.")
        end
    end
end

function isinarea(cityttempId, x, y)
    if (cityttempId < 0 or cityttempId > 4) then
        return 0
    end
    local temp = tbl_BANNER_POS[cityttempId][1]
    if (math.abs(x - temp.x) <= 10 and math.abs(y - temp.y) <= 10) then
        return 1
    end

    return 0
end

function no()
    CloseDialog()
end
