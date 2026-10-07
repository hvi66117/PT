--Author:liujifang
--Desc£∫Ï∫∆ÏÕÊ∑®
--Date:2013-05-08

--modified by liujifang for Ï∫∆ÏÕÊ∑® at 2013-05-08 begin
TONG_TASK_BANNER = 52  --1byte∂‘∑Ω≥«√≈ «∑Òπ•∆∆(0Œ¥π•∆∆2π•∆∆),
--2byte «∑Ò¥ÚÀ¿ ÿª§ ﬁ(0¥ÊªÓ1À¿Õˆ)£¨
--3byte «∑Òª˜∆∆ÕºÃ⁄(1π•∆∆0Œ¥π•∆∆)
--4byte «∑Ò¡Ïπ˝π•≥«¿Ò∞¸
CITY_BANNER_BREAK = 64 --1byte÷˜∆Ï «∑Ò±ª≤
--2byte∏±∆Ï «∑Ò±ª≤
--3byte∏±±æ±ª≤µƒ¥Œ ˝
--4byte÷˜∆Ï±ª≤µƒ¥Œ ˝
CITY_BANNER_TIME1 = 65 --÷˜∆Ï±ª≤µƒ ±º‰
CITY_BANNER_TIME2 = 66 --∏±∆Ï±ª≤µƒ ±º‰
tbl_BANNER_POS = {
    [0] = { { x = 1672, y = 3147, npc = 1950 },
            { x = 1675, y = 3146, npc = 1957 }, }, -- "ª∆…≥÷Æ≥«"
    [1] = { { x = 1665, y = 3141, npc = 1950 },
            { x = 1668, y = 3140, npc = 1957 }, }, -- "∫Ï“∂÷Æ≥«"
    [2] = { { x = 1661, y = 3146, npc = 1950 },
            { x = 1664, y = 3145, npc = 1957 }, }, -- "∫⁄∞µ÷Æ≥«"
    [3] = { { x = 1675, y = 3154, npc = 1950 },
            { x = 1678, y = 3153, npc = 1957 }, }, -- "«Ô∑Á÷Æ≥«"
    [4] = { { x = 1804, y = 3051, npc = 1950 },
            { x = 1807, y = 3050, npc = 1957 }, }, -- "œƒ»’÷Æ≥«"
}
Task_Banner_Buff = 1862
G_BannerBuffDec = 1482
G_BannerBuffAdd = 1483
--modified by liujifang for Ï∫∆ÏÕÊ∑® at 2013-05-08 begin

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
        ScrollMessage("Bπn kh´ng ph∂i lµ phe c∂nh giÌi t›m.")
        return
    end

    local CityName, CityMode, CityMoney, CityMat, CityLevel, CityTemplet, TongName = GetCityInfo()
    local w, nMapX, nMapY = GetWorldPos()
    if (isinarea(CityTemplet, nMapX, nMapY) == 0) then
        ScrollMessage("Bπn kh´ng ngÂi thi“n g«n tinh k˙ chi’n.")
        return
    end

    if (IsOwnerCity() == 0) then
        ScrollMessage("Bπn kh´ng ngÂi thi“n trong thµnh thﬁ l∑nh Æﬁa nµy.")
        return
    end

    local nTongName = GetTongName()
    local nTongID = GetTongIDByName(nTongName)
    local nBannerState = GetTongTaskByID(nTongID, TONG_TASK_BANNER)
    local nExp = 1
    if (GetByte(nBannerState, 3) == 1 and GetByte(nBannerState, 2) ~= 1) then
        --ÕºÃ⁄
        nExp = 2
    elseif (GetByte(nBannerState, 3) == 1 and GetByte(nBannerState, 2) == 1) then
        --ÕºÃ⁄
        nExp = 2.5
    elseif (GetByte(nBannerState, 2) == 1) then
        -- ÿª§ ﬁ
        nExp = 1.5
    end

    local nLevel = GetLevel()
    local nExtendLevel = GetPlayerExtLevel()
    if (nExp > 0) then
        if (nLevel >= 200 and nExtendLevel >= 12 and GetJusticEvilCredit() ~= 0) then
            if (nExtendLevel >= 12 and nExtendLevel < 24) then
                nExp = floor(nExp * nExtendLevel * 20)
            elseif (nExtendLevel >= 24 and nExtendLevel < 31) then
                nExp = floor(nExp * nExtendLevel * 30)
            elseif (nExtendLevel >= 31 and nExtendLevel < 41) then
                nExp = floor(nExp * nExtendLevel * 40)
            elseif (nExtendLevel >= 41 and nExtendLevel < 51) then
                nExp = floor(nExp * nExtendLevel * 46)
            elseif (nExtendLevel >= 51 and nExtendLevel < 61) then
                nExp = floor(nExp * nExtendLevel * 53)
            elseif (nExtendLevel >= 61) then
                nExp = floor(nExp * nExtendLevel * 66)
            end
            AddOwnExtendExp(nExp)
            ScrollMessage("NhÀn Æ≠Óc" .. nExp .. " ßi”m tu hµnh.")
        else
            if (nLevel >= 30 and nLevel < 60) then
                nExp = floor(nExp * nLevel * 40)
            elseif (nLevel >= 60 and nLevel < 90) then
                nExp = floor(nExp * nLevel * 80)
            elseif (nLevel >= 90 and nLevel < 120) then
                nExp = floor(nExp * nLevel * 100)
            elseif (nLevel >= 120) then
                nExp = floor(nExp * nLevel * 135)
            end
            AddOwnExp(nExp)
            ScrollMessage("NhÀn Æ≠Óc" .. nExp .. " Æi”m kinh nghi÷m.")
        end
    end
end

function isinarea(cityttempId, x, y)
    if (cityttempId < 0 or cityttempId > 4) then
        return 0
    end
    local temp = tbl_BANNER_POS[cityttempId][1]
    if (abs(x - temp.x) <= 10 and abs(y - temp.y) <= 10) then
        return 1
    end

    return 0
end

function no()
    CloseDialog()
end