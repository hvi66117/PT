require("common.luax")

module("WELFALE", package.seeall)

g_LiHeID = { 6, 1, 1250, 1 }

g_NBLiHeID = { 6, 1, 1087, 1 }

g_BoxName = "´Èº½ÔùÀñ"

g_ExtraBoxName = "Å®æ´µÄÀ¡Ôù"

g_nTitleDays = 7

g_ActivitieMenu = {
    [1] = { taskname = "VËn l­¬ng", itemname = "B¹ch V©n Th¹ch", str = "", id = { 6, 1, 1402, 1 }, id2 = { 3, 1623, 0, 0 }, },
    [2] = { taskname = "Tø Linh", itemname = "H¾c DiÖu Th¹ch", str = "", id = { 6, 1, 1403, 1 }, id2 = { 3, 1624, 0, 0 }, },
    [3] = { taskname = "Thiªn Thô", itemname = "Kª HuyÕt Th¹ch", str = "", id = { 6, 1, 1404, 1 }, id2 = { 3, 1625, 0, 0 }, },
    [4] = { taskname = "½µ·ş¿ªÃ÷Éñ", itemname = "Tö Huúnh Th¹ch", str = "", id = { 6, 1, 1405, 1 }, id2 = { 3, 1626, 0, 0 }, },
    [5] = { taskname = "Th¸m qu©n", itemname = "§iÒn Hoµng Th¹ch", str = "", id = { 6, 1, 1406, 1 }, id2 = { 3, 1627, 0, 0 }, },
    [6] = { taskname = "Long Ch©u", itemname = "Khæng T­íc Th¹ch", str = "", id = { 6, 1, 1407, 1 }, id2 = { 3, 1628, 0, 0 }, },
}

g_ActivitieTask = 2013

function PubFuncWelfareActivitie1_Item()

    if (IsWelfareActivitieOpen(1) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 25) == 1) then
        return 0
    end

    SetTaskBit(g_ActivitieTask, 25, 1)

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[1].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[1].itemname, g_ActivitieMenu[1].id[1], g_ActivitieMenu[1].id[2], g_ActivitieMenu[1].id[3], g_ActivitieMenu[1].id[4], 0, 0, 0, 0, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[1].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][VËn L­¬ng][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[1].itemname)

    return 1

end

function PubFuncWelfareActivitie2_Item()


    if (IsWelfareActivitieOpen(2) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 30) == 1) then
        return 0
    end

    SetTaskBit(g_ActivitieTask, 30, 1)

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[2].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[2].itemname, g_ActivitieMenu[2].id[1], g_ActivitieMenu[2].id[2], g_ActivitieMenu[2].id[3], g_ActivitieMenu[2].id[4], 0, 0, 0, 0, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[2].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][Tø T­îng Linh Tª][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[2].itemname)

    return 1
end

function PubFuncWelfareActivitie3_Item()


    if (IsWelfareActivitieOpen(3) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 26) == 1) then
        return 0
    end

    SetTaskBit(g_ActivitieTask, 26, 1)

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[3].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[3].itemname, g_ActivitieMenu[3].id[1], g_ActivitieMenu[3].id[2], g_ActivitieMenu[3].id[3], g_ActivitieMenu[3].id[4], 0, 0, 0, 0, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[3].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][Thiªn §×nh ThÇn Thô][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[3].itemname)

    return 1
end

function PubFuncWelfareActivitie4_Debris(npcidx)


    if (IsWelfareActivitieOpen(4) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 28) == 1) then
        return 0
    end

    local monstername = "Khai Minh ThÇn"
    if (GetNpcName(npcidx) ~= monstername) then
        return 0
    end

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[4].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[4].itemname, g_ActivitieMenu[4].id[1], g_ActivitieMenu[4].id[2], g_ActivitieMenu[4].id[3], g_ActivitieMenu[4].id[4], 0, 0, 0, 0, 1)
    SetTaskBit(g_ActivitieTask, 28, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[3].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][É±¹ÖµôÂä][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[3].itemname)

    return 1
end

function PubFuncWelfareActivitie5_Item()


    if (IsWelfareActivitieOpen(5) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 29) == 1) then
        return 0
    end

    SetTaskBit(g_ActivitieTask, 29, 1)

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[5].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[5].itemname, g_ActivitieMenu[5].id[1], g_ActivitieMenu[5].id[2], g_ActivitieMenu[5].id[3], g_ActivitieMenu[5].id[4], 0, 0, 0, 0, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[5].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][Th¸m Qu©n][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[5].itemname)

    return 1
end

function PubFuncWelfareActivitie6_Item()


    if (IsWelfareActivitieOpen(6) <= 0) then
        return 0
    end

    if (GetTaskBit(g_ActivitieTask, 27) == 1) then
        return 0
    end

    SetTaskBit(g_ActivitieTask, 27, 1)

    SendSysItemMailToTarget("Hép th­", GetName(), g_ActivitieMenu[6].itemname, "Ç×°®µÄÍæ¼Ò, ÄúµÃµ½ÁËÒ»Ã¶" .. g_ActivitieMenu[6].itemname, g_ActivitieMenu[6].id[1], g_ActivitieMenu[6].id[2], g_ActivitieMenu[6].id[3], g_ActivitieMenu[6].id[4], 0, 0, 0, 0, 1)
    Msg2Player("ÄúÓĞÒ»·âĞÂµÄÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[6].itemname .. ", Çë×¢Òâ²é¿´.")
    WriteLog("[ÊÕ¼¯ÆæÊ¯][B¨ng Ho¶ Long Ch©u][" .. GetName() .. "ÊÕµ½ÓÊ¼ş, ²¢ nhËn ®­îc 1 " .. g_ActivitieMenu[6].itemname)

    return 1
end

function GetText(num)
    local textList = GetTextList()

    if (num == nil or num < 0 or num > table.getn(textList)) then
        return ""
    end

    if (textList[num] ~= nil) then
        return textList[num]
    else
        return ""
    end

end

function PubFuncIsButtonShow()
    return IsOpenByTime()
end

function PubFuncWelfareActivitie_GiveGift()
    no()
    ClearWelfareActivitieTask()
    g_ActivitieIndex = GetActiveIndexTable()
    if (GetTaskBit(g_ActivitieTask, 31) > 0) then
        Talk(1, "no", "¹ıÓÌ²»¼°, mêi ngµy mai l¹i tíi ®i!")
        return 0
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng ®ñ , h·y s¾p xÕp l¹i råi ®Õn ®æi.")
        return 0
    end

    local nTitleDays = g_nTitleDays
    local nItemID = g_LiHeID

    if (IsHaveAllItem() == 1) then

        local str = ""
        local nTemp = 0

        DelAllItem()

        if not (g_LiHeID[1] ~= nil and g_LiHeID[2] ~= nil and g_LiHeID[3] ~= nil and g_LiHeID[4] ~= nil and g_NBLiHeID[1] ~= nil and g_NBLiHeID[2] ~= nil and g_NBLiHeID[3] ~= nil and g_NBLiHeID[4] ~= nil) then
            return 0
        end
        AddNormalItemBind(g_LiHeID[1], g_LiHeID[2], g_LiHeID[3], g_LiHeID[4], 0, 0, 1)
        WriteLog("[¸£Àû»î¶¯][NhËn ®­îcÆÕÍ¨ÀñºĞ]")

        str = "ÌìµÀ³êÇÚ, ÕâÊÇ phÇn th­ëng!xin nhËn lÊy"
        local nTaskTimes = GetTaskByte(g_ActivitieTask, 2) + 1
        SetTaskByte(g_ActivitieTask, 2, nTaskTimes)

        if (math.mod(nTaskTimes, 4) == 0) then
            nTemp = 1
            AddNormalItemBind(g_LiHeID[1], g_LiHeID[2], g_LiHeID[3], g_LiHeID[4], 0, 0, 1)
            WriteLog("[¸£Àû»î¶¯][NhËn ®­îc¶îÍâÀñºĞ]")
            str = str .. ",¿´ÄãÈç´ËÇÚ·Ü, ÎÒÔÙ¸øÄãÒ»·İ¶îÍâ½±Àø°É, ÔÙ½ÓÔÙÀø"
        elseif (math.random(1, 100) < 5) then
            nTemp = 1
            AddNormalItemBind(g_LiHeID[1], g_LiHeID[2], g_LiHeID[3], g_LiHeID[4], 0, 0, 1)
            WriteLog("[¸£Àû»î¶¯][NhËn ®­îc¶îÍâÀñºĞ]")
            str = str .. ",¿´ÄãÈç´ËÇÚ·Ü, ÎÒÔÙ¸øÄãÒ»·İ¶îÍâ½±Àø°É, ÔÙ½ÓÔÙÀø"
        end

        local nVipLevel = GetPlayerVipLevel()
        if (nTemp == 0 and nVipLevel <= 0) then
            local nRand = math.random(1, 100)
            if (nRand <= 20) then
                if (nRand <= 2) then
                    AddNormalItemBind(6, 1, 1084, 1, 0, 0, 1)
                    str = str .. ",Ó¢ĞÛÕæÊÇĞÒÔË, ÎÒÕâÕıºÃÓĞ1 ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ,¾ÍËÍÓèÄã°É"
                elseif (nRand <= 8) then
                    AddNormalItemBind(6, 1, 1083, 1, 0, 0, 1)
                    str = str .. ",Ó¢ĞÛÕæÊÇĞÒÔË, ÎÒÕâÕıºÃÓĞ1 ThÎ tr¶i nghiÖm §Æc QuyÒn Chu T­íc,¾ÍËÍÓèÄã°É"
                elseif (nRand <= 20) then
                    AddNormalItemBind(6, 1, 1082, 1, 0, 0, 1)
                    str = str .. ",Ó¢ĞÛÕæÊÇĞÒÔË, ÎÒÕâÕıºÃÓĞ1 ThÎ tr¶i nghiÖm §Æc QuyÒn HuyÒn Vò,¾ÍËÍÓèÄã°É"
                end
            end
        end

        if (nTaskTimes == g_nTitleDays) then
            ActiveTitleFunc(1)
            ActiveTitleQualify(98)
            SetCurTitle(98)
            Msg2Player("Chóc mõng ng­¬i nhËn ®­îc danh hiÖu NhÊt Minh Kinh Nh©n.")
            WriteLog("Danh hiÖu NhÊt Minh Kinh Nh©n")
        end

        str = str .. "."
        Talk(1, "no", str)

        SetTaskBit(g_ActivitieTask, 31, 1)
    else
        local itemstr = ""
        for i = 1, table.getn(g_ActivitieIndex) do
            if (i < table.getn(g_ActivitieIndex)) then
                itemstr = itemstr .. g_ActivitieMenu[g_ActivitieIndex[i]].itemname .. ","
            else
                itemstr = itemstr .. g_ActivitieMenu[g_ActivitieIndex[i]].itemname .. "."
            end
        end
        Talk(1, "main", "ºÜÒÅº¶!Äã»¹Ã»ÓĞÊÕ¼¯Æë<c=g>" .. itemstr .. "<c>\nÈç¹ûÄãÁ¬Ğø<c=g>" .. nTitleDays .. "<c>Ìì¶¼³É¹¦¶Ò»», ÎÒ»¹»á¶îÍâ½±ÀøÄã<c=g>ÊôĞÔ³ÆºÅ<c>!")

    end

    return 1
end

function IsWelfareActivitieOpen(num)


    ClearWelfareActivitieTask()
    g_ActivitieIndex = GetActiveIndexTable()

    if (IsOpenByTime() <= 0) then
        return 0
    end

    if (GetLevel() < 65) then
        return 0
    end
    for i = 1, table.getn(g_ActivitieIndex) do
        if (num == g_ActivitieIndex[i]) then
            break
        end
        if (i == table.getn(g_ActivitieIndex) and num ~= g_ActivitieIndex[i]) then
            return 0
        end
    end

    return 1
end

function IsOpenByTime()
    local b_year = tostring(GetGlobalStoreValueWord(54, 1))
    local b_month = tostring(GetGlobalStoreValueByte(54, 3))
    local b_day = tostring(GetGlobalStoreValueByte(54, 4))
    local e_year = tostring(GetGlobalStoreValueWord(55, 1))
    local e_month = tostring(GetGlobalStoreValueByte(55, 3))
    local e_day = tostring(GetGlobalStoreValueByte(55, 4))
    if (string.len(b_month) == 1) then
        b_month = "0" .. b_month
    end
    if (string.len(b_day) == 1) then
        b_day = "0" .. b_day
    end
    if (string.len(e_month) == 1) then
        e_month = "0" .. e_month
    end
    if (string.len(e_day) == 1) then
        e_day = "0" .. e_day
    end

    local BeginDate = b_year .. "-" .. b_month .. "-" .. b_day .. " 00:00:00"
    local EndDate = e_year .. "-" .. e_month .. "-" .. e_day .. " 23:59:59"

    if (COMMON.IsInDateTimeRange(BeginDate, EndDate)) then
        return 1
    end
    return 0
end

function ClearWelfareActivitieTask()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local g_ActivitieTimes = GetActiveTimes()

    if (GetTaskByte(g_ActivitieTask, 3) ~= g_ActivitieTimes) then

        SetTaskByte(g_ActivitieTask, 3, g_ActivitieTimes)
        SetTaskByte(g_ActivitieTask, 2, 0)
        SetTaskByte(g_ActivitieTask, 1, nToday)
        SetTaskByte(g_ActivitieTask, 4, 0)

    else
        local nTaskDay = GetTaskByte(g_ActivitieTask, 1)
        if (nTaskDay ~= nToday) then
            SetTaskByte(g_ActivitieTask, 1, nToday)
            SetTaskByte(g_ActivitieTask, 4, 0)
        end
    end
end

function GetActiveTimes()
    local times = GetGlobalStoreValueByte(56, 3)
    return times
end

function IsHaveAllItem()
    g_ActivitieIndex = GetActiveIndexTable()
    local flag = 1
    for i = 1, table.getn(g_ActivitieIndex) do
        local index = g_ActivitieIndex[i]
        local have1 = HaveNormalItem(g_ActivitieMenu[index].id[1], g_ActivitieMenu[index].id[2], g_ActivitieMenu[index].id[3], g_ActivitieMenu[index].id[4])
        local have2 = HaveNormalItem(g_ActivitieMenu[index].id2[1], g_ActivitieMenu[index].id2[2], g_ActivitieMenu[index].id2[3], g_ActivitieMenu[index].id2[4])
        if (have1 <= 0 and have2 <= 0) then
            flag = 0
            break
        end
    end
    return flag
end
function DelAllItem()
    g_ActivitieIndex = GetActiveIndexTable()
    for i = 1, table.getn(g_ActivitieIndex) do
        local index = g_ActivitieIndex[i]
        DelNormalItem(g_ActivitieMenu[index].id[1], g_ActivitieMenu[index].id[2], g_ActivitieMenu[index].id[3], g_ActivitieMenu[index].id[4])
        DelNormalItem(g_ActivitieMenu[index].id2[1], g_ActivitieMenu[index].id2[2], g_ActivitieMenu[index].id2[3], g_ActivitieMenu[index].id2[4])
    end
end
function GetActiveIndexTable()
    local s_flag = GetGlobalStoreValueWord(56, 1)
    if (string.len(tostring(s_flag)) ~= 4) then
        return { 1, 2, 3, 4 }
    end
    local t_index = {}
    t_index[1] = math.floor(s_flag / 1000)
    t_index[2] = math.floor(s_flag / 100) % 10
    t_index[3] = math.floor(s_flag / 10) % 100 % 10
    t_index[4] = s_flag % 1000 % 100 % 10
    return t_index
end
function GetTextList()
    local t_index = GetActiveIndexTable()
    local item1 = g_ActivitieMenu[t_index[1]].itemname
    local item2 = g_ActivitieMenu[t_index[2]].itemname
    local item3 = g_ActivitieMenu[t_index[3]].itemname
    local item4 = g_ActivitieMenu[t_index[4]].itemname

    local task1 = g_ActivitieMenu[t_index[1]].taskname
    local task2 = g_ActivitieMenu[t_index[2]].taskname
    local task3 = g_ActivitieMenu[t_index[3]].taskname
    local task4 = g_ActivitieMenu[t_index[4]].taskname

    local textList = {
        [1] = "<c=y>" .. g_BoxName .. "<c>",
        [2] = "§æi " .. g_BoxName,
        [3] = "ÊÕ¼¯Æ·ËµÃ÷",
        [4] = "ÎÒĞèÒªµÄµÚ1 ÎïÆ·ÊÇ<c=g>" .. item1 .. "<c>, Äú¿ÉÒÔÍ¨¹ıÃ¿ÌìÊ×´Î³É¹¦Hoµn thµnh nhiÖm vô <c=g>" .. task1 .. "<c>»ñµÃËü,ÓÒ¼üÊ¹ÓÃ»ñµÃÏàÓ¦»î¶¯Ë«±¶×£¸£.",
        [5] = "ÎÒĞèÒªµÄµÚ¶ş¸öÎïÆ·ÊÇ<c=g>" .. item2 .. "<c>, Äú¿ÉÒÔÍ¨¹ıÃ¿ÌìÊ×´Î³É¹¦Hoµn thµnh nhiÖm vô <c=g>" .. task2 .. "<c>»ñµÃËü,ÓÒ¼üÊ¹ÓÃ»ñµÃÏàÓ¦»î¶¯Ë«±¶×£¸£.",
        [6] = "ÎÒĞèÒªµÄµÚ3 ÎïÆ·ÊÇ<c=g>" .. item3 .. "<c>, Äú¿ÉÒÔÍ¨¹ıÃ¿ÌìÊ×´Î³É¹¦Hoµn thµnh nhiÖm vô <c=g>" .. task3 .. "<c>»ñµÃËü,ÓÒ¼üÊ¹ÓÃ»ñµÃÏàÓ¦»î¶¯Ë«±¶×£¸£.",
        [7] = "ÎÒĞèÒªµÄµÚËÄ¸öÎïÆ·ÊÇ<c=g>" .. item4 .. "<c>, Äú¿ÉÒÔÍ¨¹ıÃ¿ÌìÊ×´Î³É¹¦Hoµn thµnh nhiÖm vô <c=g>" .. task4 .. "<c>»ñµÃËü,ÓÒ¼üÊ¹ÓÃ»ñµÃÏàÓ¦»î¶¯Ë«±¶×£¸£.",
        [8] = "ÔÚ±¾´Î¸£Àû»î¶¯ÆÚ¼ä, Ó¢ĞÛÈçÄÜÊÕ¼¯µ½±êÊ¶Îª[Thu thËp] µÄ<c=g>" .. item1 .. "<c>, <c=g>" .. item2 .. "<c>, <c=g>" .. item3 .. "<c>, <c=g>" .. item4 .. "<c>²¢½»¸¶ÓèÎÒ, lµ cã thÓ nhËn <c=y>" .. g_BoxName .. "<c> phÇn th­ëng, »¹ÓĞ»ú»áNhËn ®­îc thªm <c=y>" .. g_ExtraBoxName .. "<c>Å¶£.¨ÉÏÊö½±Àø¾ùÎª°ó¶¨£©",


    }
    return textList
end

function no()
    CloseDialog()
end
