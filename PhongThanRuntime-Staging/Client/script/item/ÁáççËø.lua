mapname = {
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
    [57] = "Thanh §ång s¬n",
    [58] = "D­îc V­¬ng cèc",
    [59] = "Sïng Thµnh (kho¸ng tr­êng)",
    [60] = "Thiªn Lao",
    [61] = "Ngäc H­ 10 n¨m tr­íc",
    [62] = "Ngäc H­ 10 n¨m sau",
    [63] = "TriÒu Ca 10 n¨m sau",
    [64] = "ChiÕn tr­êng ViÔn Cæ",
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
    [92] = "Thiªn Lao",
    [93] = "Thiªn Lao",
    [94] = "Thiªn Lao",
    [95] = "Thiªn Lao",
    [96] = "Thiªn Lao",
    [97] = "Diªm La ®iÖn",
    [98] = "Hoµng TuyÒn phñ",
    [99] = "Nam Kha quËn"
}

MAP_ID_SET = {
    [1] = 20,
    [2] = 21,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6,
    [8] = 7,
    [9] = 8,
    [10] = 9,
    [11] = 10,
    [12] = 11,
    [13] = 12,
    [14] = 13
}

PLAYER_PROTECT_INCREASE_DAY = 3
PLAYER_DEPROTECT_CHANCE = 3

TASK_ID_PROTECT_MAPS = 1250
TASK_ID_DEPROTECT_TIME = 1251
TASK_ID_DEPROTECT_CONTROLS = 1252

function main(itemID)

    if (IsPlayerOpenProtect() == 1) then

        if (IsPlayerInProtect() == 0) and (IsPlayerInProtectIP() == 1) then
            local szProtectIP = GetPlayerProtectIP()
            local mapString = getMapDesc()
            local ProtectEndTime = GetPlayerProtectEndTime()
            local ProtecEndTimeDesc = TimeStampToString(ProtectEndTime)
            Talk(1, "no", "Linh Lung Táa ®· c¨n cø IP: <c=g>" .. szProtectIP .. "<c> mµ tiÕn hµnh b¶o hé. MËt m· lÇn nµy lµ:" .. mapString .. ", thêi gian b¶o hé cña ®Õn: <c=g>" .. ProtecEndTimeDesc .. "<c>.")
        elseif (IsPlayerInProtect() == 0) then
            Talk(1, "no", "B¹n ®· t¹m thêi gi¶i bá b¶o hé! Sau khi b¹n tho¸t khái trß ch¬i, Linh Lung Táa sÏ l¹i tiÕp tôc duy tr× b¶o hé!")
        else
            local nRet, nLeftTime = unProtect()
            if (nRet == 1) then
                TopMessage("§· nhËp chÝnh x¸c MËt m· khu vùc thø nhÊt")
                Msg2Player("§· nhËp chÝnh x¸c MËt m· khu vùc thø nhÊt, xin nhËp mËt m· thø hai!")
            elseif (nRet == 2) then
                TopMessage("§· nhËp chÝnh x¸c MËt m· khu vùc thø hai!")
                Msg2Player("§· nhËp chÝnh x¸c MËt m· khu vùc thø hai! T¹m thêi gi¶i trõ b¶o hé cña Linh Lung Táa")
                if (HaveIBBuff(467) > 0) then
                    RemoveIBBuff(467)
                end

                SetProtectPlayer(0)
            else
                local nCurMap = GetTaskByte(TASK_ID_DEPROTECT_CONTROLS, 2) + 1
                TopMessage("NhËp MËt m· khu vùc bÞ sai!")
                if (nLeftTime > 0) then
                    Msg2Player("NhËp MËt m· khu vùc bÞ sai! H«m nay kh¸ch quan cßn" .. nLeftTime .. "_c¬ héi thö t¹m thêi gi¶i bá b¶o hé cña Linh Lung Táa. Xin t×m MËt m· khu vùc lÇn " .. nCurMap .. "!")
                else
                    Msg2Player("TiÕc qu¸! H«m nay kh¸ch quan nhËp mËt m· sai qu¸ 3 lÇn, nªn t¹m thêi kh«ng thÓ gi¶i trõ t¹m thêi b¶o hé cña Linh Lung Táa")
                end
            end
        end
    end
end

function unProtect()

    local NowTime = SystemTime()
    local DeprotectTime = GetTask(TASK_ID_DEPROTECT_TIME)
    local nTime = GetByte(GetTask(TASK_ID_DEPROTECT_CONTROLS), 1)
    local nCurMap = GetByte(GetTask(TASK_ID_DEPROTECT_CONTROLS), 2)
    local nMapTime = GetByte(GetTask(TASK_ID_DEPROTECT_CONTROLS), 3)

    local NY, NM, ND = Time2LocalYMD(NowTime)
    local LY, LM, LD = Time2LocalYMD(DeprotectTime)

    if (DeprotectTime > NowTime) then
        return 0, 0
    end

    if (NowTime > DeprotectTime) and ((NY ~= LY) or (NM ~= LM) or (ND ~= LD)) then
        nTime = 0
        nMapTime = 0
    end

    DeprotectTime = NowTime

    if (nTime >= PLAYER_DEPROTECT_CHANCE) then
        return 0, 0
    end

    if (nCurMap > 1) then
        nCurMap = 0
    end

    local Map1 = GetByte(GetTask(TASK_ID_PROTECT_MAPS), 1)
    local Map2 = GetByte(GetTask(TASK_ID_PROTECT_MAPS), 2)

    local nMap = 0
    if (nCurMap == 0) then
        nMap = Map1
    else
        nMap = Map2
    end

    SetTask(TASK_ID_DEPROTECT_TIME, DeprotectTime)

    local WorldID, WorldX, WorldY = GetWorldPos()
    if (nMap == WorldID) then
        nCurMap = nCurMap + 1
        local nControls = GetTask(TASK_ID_DEPROTECT_CONTROLS)

        nControls = SetByte(nControls, 1, nTime)

        nControls = SetByte(nControls, 2, math.mod(nCurMap, 2))
        nControls = SetByte(nControls, 3, nMapTime)
        SetTask(TASK_ID_DEPROTECT_CONTROLS, nControls)
        return nCurMap, (PLAYER_DEPROTECT_CHANCE - nTime)
    else
        nTime = nTime + 1
        local nControls = GetTask(TASK_ID_DEPROTECT_CONTROLS)
        nControls = SetByte(nControls, 1, nTime)
        nControls = SetByte(nControls, 2, 0)
        nControls = SetByte(nControls, 3, nMapTime)
        SetTask(TASK_ID_DEPROTECT_CONTROLS, nControls)
        return 0, (PLAYER_DEPROTECT_CHANCE - nTime)
    end
end

function getMapDesc()
    local mapString = "<c=g>"
    local Map1 = GetByte(GetTask(TASK_ID_PROTECT_MAPS), 1)
    mapString = mapString .. mapname[Map1] .. "<c>-><c=g>"
    local Map2 = GetByte(GetTask(TASK_ID_PROTECT_MAPS), 2)
    mapString = mapString .. mapname[Map2] .. "<c>"
    return mapString
end

function no()
    CloseDialog()
end
