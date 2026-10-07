StatueTaskValue = 2175

LikeStatueTimes = 2176
LikeStatueAllValue = 2177
DislikeStatueTimes = 2178
DislikeStatueAllValue = 2179

FileStr = "T­îng"
Times = 0
TeamName = ""
Leader = ""
MemberName1 = ""
MemberName2 = ""

LeaderID = 0
Member1ID = 0
Member2ID = 0

LeaderNpcidx = 0
Member1Npcidx = 0
Member2Npcidx = 0

tRankTable_Like = {}
tRankTable_Dislike = {}

tStatueTable = {
    [1] = { name = "²ĞÆÆµÄ", npcid = { 2314, 2315, 2316 }, value = { 0, 2499 }, },
    [2] = { name = "ÆÕÍ¨¼¶", npcid = { 2317, 2318, 2319 }, value = { 2500, 14999 }, },
    [3] = { name = "×¿Ô½¼¶", npcid = { 2320, 2321, 2322 }, value = { 15000, 24999 }, },
    [4] = { name = "²»Ğà¼¶", npcid = { 2323, 2324, 2325 }, value = { 25000, 44999 }, },
    [5] = { name = "Éñ´Í¼¶", npcid = { 2326, 2327, 2328 }, value = { 45000, 1000000 }, },
}
tTaskTable = {
    [1] = { item = "T­íng Qu©n LÖnh*1", count = 1, itemid = { 3, 100, 0, 0 }, pro = 8, gongxun = { 40, 80, 100, 120, 130 }, dislike = 8, like = 10 },
    [2] = { item = "Lam B¶o Th¹ch*1", count = 1, itemid = { 3, 41, 0, 0 }, pro = 7, gongxun = { 40, 80, 100, 120, 130 }, dislike = 8, like = 10 },
    [3] = { item = "Tø T­îng Tinh Hoa*1", count = 1, itemid = { 3, 115, 0, 0 }, pro = 25, gongxun = { 20, 40, 50, 60, 70 }, dislike = 4, like = 5 },
    [4] = { item = "Hång B¶o Th¹ch*1", count = 1, itemid = { 3, 79, 0, 0 }, pro = 20, gongxun = { 20, 40, 50, 60, 70 }, dislike = 4, like = 5 },
    [5] = { item = "Tha S¬n Th¹ch*2", count = 2, itemid = { 3, 82, 0, 0 }, pro = 20, gongxun = { 20, 40, 50, 60, 70 }, dislike = 4, like = 5 },
    [6] = { item = "LiÔu Méc*1", count = 1, itemid = { 4, 39, 1, 1 }, pro = 10, gongxun = { 5, 10, 12, 15, 20 }, dislike = 1, like = 2 },
    [7] = { item = "ÇàÍ­*10", count = 10, itemid = { 3, 6, 0, 0 }, pro = 10, gongxun = { 5, 10, 12, 15, 20 }, dislike = 1, like = 2 },
}

function main()
    if (Times == 0 or TeamName == "" or Leader == "" or MemberName1 == "" or MemberName2 == "") then
        LoadTable()
    end
    local value = GetGlobalStoreValue(45)
    local info = "µÚ<c=y>" .. Times .. "<c>½ìPhong ThÇn Chi ChiÕnÖĞ, ±¾·şÕ½¶Ó<c=y>" .. TeamName .. "<c>µÄ<c=y>" .. Leader .. "<c>, <c=y>" .. MemberName1 .. "<c>, <c=y>" .. MemberName2 .. "<c>\nÎäÒÕ³¬Èº¼¼Ñ¹ÈºĞÛÕª¶á¹ğ¹Ú, ÌØÁ¢´ËÏñ, ¹©ÌìÏÂÓ¢ĞÛ¾´Ñö.Ä¿Ç°µñÏñ·±ÈÙ¶È: <c=y>" .. value .. "<c>\n·±ÈÙ¶ÈµÍÓÚ2500½µ¼¶Îª²ĞÆÆ¼¶, ´ïµ½15000ÉıÎª×¿Ô½¼¶,25000Îª²»Ğà¼¶,45000ÎªÉñ´Í¼¶."

    if (Times ~= 0) then
        if (GetTaskByte(2100, 1) ~= Times) then
            SetTaskByte(2100, 1, Times)
            SetTaskByte(2100, 2, 0)
            SetTask(StatueTaskValue, 0)
            SetTask(LikeStatueTimes, 0)
            SetTask(LikeStatueAllValue, 0)
            SetTask(DislikeStatueTimes, 0)
            SetTask(DislikeStatueAllValue, 0)
        end
    end

    local Y, M, D = GetYMD()
    if (GetTaskByte(StatueTaskValue, 2) ~= D) then
        SetTask(StatueTaskValue, 0)
        SetTaskByte(StatueTaskValue, 2, D)
        SetTaskByte(2100, 2, 0)
        TaskNote(2071, -1)
        WriteLog("[Phong ThÇn Chi ChiÕn][µñÏñ][¿çÌìÇå³ı±äÁ¿]")
    end
    local menu = {
        { "µñÏñÈÎÎñ", "StatueTaskMain"; show = 1 },
        { "µñÏñ°ñµ¥", "StatueList"; show = 1 },
        { "È«ĞÂµñÏñÍæ·¨", "StatueInfo"; show = 1 },
        { "Í¨ÖªµñÏñ¸üĞÂ", "LetUpdate"; show = 0 },
    }
    if (checkLoginIP() > 0) then
        menu[4].show = 1
    end
    SayTask(info, menu)
end
function StatueTaskMain()
    local menu = {
        { "Ä¤°İ", "LikeStatueTask"; show = 1 },
        { "ÍÙÆú", "DislikeStatueTask"; show = 1 },
        { "ÉÏ½»²ÄÁÏ", "CommitTaskItem"; show = 0 },
    }
    local str = "1.ÈôÄúÑ¡Ôñ<c=g>Ä¤°İ<c>, ÔòÄú½«ÔÚÈÎÎñHoµn thµnh nhiÖm vô ºóÎªµñÏñ<c=g>ÌáÉı·±ÈÙ¶È<c>\n2.ÈôÄúÑ¡Ôñ<c=r>ÍÙÆú<c>, ÔòÄú½«ÔÚÍê³ÉºóÎªµñÏñ<c=r>½µµÍ·±ÈÙ¶È<c>.\nÓ¢ĞÛÇë½øĞĞÑ¡Ôñ: "
    if (GetTaskByte(StatueTaskValue, 4) > 0 and GetTaskByte(StatueTaskValue, 1) > 0) then
        CommitTaskItem()
        return
    end
    SayTask(str, menu)
end
function LikeStatueTask()
    CheckLevel()
    local times = GetTaskByte(StatueTaskValue, 3)
    times = times + 1
    if (times > 100) then
        Talk(1, "no", "½ñÌìÒÑ¾­Hoµn thµnh nhiÖm vô °Ù´Î, mêi ngµy mai l¹i tíi ®i.")
        return
    end

    local info = "§©y lµ ÄãlÇn thø <c=y>" .. times .. "<c> trong ngµy´Î½øĞĞµñÏñÈÎÎñ, nhÊp vµo [È·¶¨], Ó¢ĞÛ½«»á½Óµ½Ëæ»úµÄµñÏñÈÎÎñ,"
    local info1 = ""
    local info2 = ""
    if (times == 1) then
        info1 = "Íê³Élµ cã thÓ nhËn ¹¦Ñ«Öµ²¢ÎªµñÏñ<c=y>ÌáÉı<c>·±ÈÙ¶È."
        info2 = "´Ë´ÎÈÎÎñÃâ·Ñ, Ó¢ĞÛÇëÈ·ÈÏ: "
    elseif (times > 1 and times < 5) then
        info1 = "Ã¿ÌìÇ°4´ÎÈÎÎñ, Íê³Élµ cã thÓ nhËn ¹¦Ñ«Öµ²¢ÎªµñÏñ<c=y>ÌáÉı<c>·±ÈÙ¶È."
        info2 = "´Ë´ÎÈÎÎñÏûºÄ2.0 Th«ng B¶oÓ¢ĞÛÇëÈ·ÈÏ: "
    else
        info1 = "ÓÉÓÚÄú½ñÌìÒÑ¾­ÈÎÎñ³¬¹ı4´Î, ´Ë´ÎHoµn thµnh nhiÖm vô ºó½öÄÜÎªµñÏñ<c=y>ÌáÉı<c>·±ÈÙ¶È,<c=r>²»»á»ñµÃ¹¦Ñ«ÖµµÄ½±Àø.<c>"
        info2 = "´Ë´ÎÈÎÎñÏûºÄ2.0 Th«ng B¶oÓ¢ĞÛÇëÈ·ÈÏ: "
    end
    info = info .. info1 .. info2
    MsgBox(info, "LikeStatue_Yes", "no")
end
function LikeStatue_Yes()
    no()
    local Y, M, D = GetYMD()
    local times = GetTaskByte(StatueTaskValue, 3)
    times = times + 1
    if (times == 1) then
        local idx = RangeTask()
        SetTaskByte(StatueTaskValue, 4, 1)
        SetTaskByte(StatueTaskValue, 3, times)
        SetTaskByte(StatueTaskValue, 1, idx)
        SetTaskByte(StatueTaskValue, 2, D)
        local taskinfo = "±¾´ÎÈÎÎñĞèÒªÉÏ½»²ÄÁÏ: " .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃºóÀ´´Ë½»ÈÎÎñ."
        Talk(1, "no", taskinfo)
        Msg2Player(taskinfo)
        local taskinfoidx = idx - 1
        TaskNote(2071, taskinfoidx)
        WriteLog("[µñÏñÈÎÎñ][½ÓÄ¤°İÈÎÎñ][µ±ÌìµÚ" .. times .. " lÇn][Ãâ·Ñ][ÈÎÎñÄÚÈİ: " .. tTaskTable[idx].item .. "]")
    else
        local Cname, Cv, Cfs = GetCostCoinInfoByIdx(176)
        if (GetCoin() < Cv) then
            Talk(1, "no", "±¾´ÎÈÎÎñĞèÒªÏûºÄ2 Th«ng B¶oÄ¿Ç°Í¨±¦²»×ã.")
            return
        end
        CostCoinByIdx(176)
        local idx = RangeTask()
        SetTaskByte(StatueTaskValue, 4, 1)
        SetTaskByte(StatueTaskValue, 3, times)
        SetTaskByte(StatueTaskValue, 1, idx)
        SetTaskByte(StatueTaskValue, 2, D)
        local taskinfo = "±¾´ÎÈÎÎñĞèÒªÉÏ½»²ÄÁÏ: " .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃºóÀ´´Ë½»ÈÎÎñ."
        Talk(1, "no", taskinfo)
        Msg2Player(taskinfo)
        local taskinfoidx = idx - 1
        TaskNote(2071, taskinfoidx)
        WriteLog("[µñÏñÈÎÎñ][½ÓÄ¤°İÈÎÎñ][µ±ÌìµÚ" .. times .. " lÇn][ÏûºÄ2 Th«ng B¶o][ÈÎÎñÄÚÈİ: " .. tTaskTable[idx].item .. "]")
    end
end

function DislikeStatueTask()
    CheckLevel()
    local times = GetTaskByte(StatueTaskValue, 3)
    times = times + 1
    if (times > 100) then
        Talk(1, "no", "½ñÌìÒÑ¾­Hoµn thµnh nhiÖm vô °Ù´Î, mêi ngµy mai l¹i tíi ®i.")
        return
    end
    local info = "§©y lµ ÄãlÇn thø <c=y>" .. times .. "<c> trong ngµy´Î½øĞĞµñÏñÈÎÎñ, nhÊp vµo [È·¶¨], Ó¢ĞÛ½«»á½Óµ½Ëæ»úµÄµñÏñÈÎÎñ,"
    local info1 = ""
    local info2 = ""
    if (times == 1) then
        info1 = "Íê³Élµ cã thÓ nhËn ¹¦Ñ«Öµ²¢ÎªµñÏñ<c=y>½µµÍ<c>·±ÈÙ¶È."
        info2 = "´Ë´ÎÈÎÎñÃâ·Ñ, Ó¢ĞÛÇëÈ·ÈÏ: "
    elseif (times > 1 and times < 5) then
        info1 = "Ã¿ÌìÇ°4´ÎÈÎÎñ, Íê³Élµ cã thÓ nhËn ¹¦Ñ«Öµ²¢ÎªµñÏñ<c=y>½µµÍ<c>·±ÈÙ¶È."
        info2 = "´Ë´ÎÈÎÎñÏûºÄ2.0 Th«ng B¶oÓ¢ĞÛÇëÈ·ÈÏ: "
    else
        info1 = "ÓÉÓÚÄú½ñÌìÒÑ¾­ÈÎÎñ³¬¹ı4´Î, ´Ë´ÎHoµn thµnh nhiÖm vô ºó½öÄÜÎªµñÏñ<c=y>½µµÍ<c>·±ÈÙ¶È,<c=r>²»»á»ñµÃ¹¦Ñ«ÖµµÄ½±Àø.<c>"
        info2 = "´Ë´ÎÈÎÎñÏûºÄ2.0 Th«ng B¶oÓ¢ĞÛÇëÈ·ÈÏ: "
    end
    info = info .. info1 .. info2
    MsgBox(info, "DislikeStatue_Yes", "no")
end
function DislikeStatue_Yes()
    no()
    local Y, M, D = GetYMD()
    local times = GetTaskByte(StatueTaskValue, 3)
    times = times + 1
    if (times == 1) then
        local idx = RangeTask()
        SetTaskByte(StatueTaskValue, 4, 2)
        SetTaskByte(StatueTaskValue, 3, times)
        SetTaskByte(StatueTaskValue, 1, idx)
        SetTaskByte(StatueTaskValue, 2, D)
        local taskinfo = "±¾´ÎÈÎÎñĞèÒªÉÏ½»²ÄÁÏ: " .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃºóÀ´´Ë½»ÈÎÎñ."
        Talk(1, "no", taskinfo)
        Msg2Player(taskinfo)
        local taskinfoidx = idx - 1
        TaskNote(2071, taskinfoidx)
        WriteLog("[µñÏñÈÎÎñ][½ÓÍÙÆúÈÎÎñ][µ±ÌìµÚ" .. times .. " lÇn][Ãâ·Ñ][ÈÎÎñÄÚÈİ: " .. tTaskTable[idx].item .. "]")
    else
        local Cname, Cv, Cfs = GetCostCoinInfoByIdx(176)
        if (GetCoin() < Cv) then
            Talk(1, "no", "±¾´ÎÈÎÎñĞèÒªÏûºÄ2 Th«ng B¶oÄ¿Ç°Í¨±¦²»×ã.")
            return
        end
        CostCoinByIdx(176)
        local idx = RangeTask()
        SetTaskByte(StatueTaskValue, 4, 2)
        SetTaskByte(StatueTaskValue, 3, times)
        SetTaskByte(StatueTaskValue, 1, idx)
        SetTaskByte(StatueTaskValue, 2, D)
        local taskinfo = "±¾´ÎÈÎÎñĞèÒªÉÏ½»²ÄÁÏ: " .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃºóÀ´´Ë½»ÈÎÎñ."
        Talk(1, "no", taskinfo)
        Msg2Player(taskinfo)
        local taskinfoidx = idx - 1
        TaskNote(2071, taskinfoidx)
        WriteLog("[µñÏñÈÎÎñ][½ÓÍÙÆúÈÎÎñ][µ±ÌìµÚ" .. times .. " lÇn][ÏûºÄ2 Th«ng B¶o][ÈÎÎñÄÚÈİ: " .. tTaskTable[idx].item .. "]")
    end
end
function RangeTask()
    local rannum = math.random(1, 100)
    local prosum = 0
    local idx = 1
    for i = 1, table.getn(tTaskTable) do
        prosum = prosum + tTaskTable[i].pro
        if (rannum <= prosum) then
            idx = i
            break
        end
    end
    return idx
end
function CommitTaskItem()
    local idx = GetTaskByte(StatueTaskValue, 1)
    local id = tTaskTable[idx].itemid
    local flag = GetTaskByte(StatueTaskValue, 4)
    local times = GetTaskByte(StatueTaskValue, 3)
    local statuelevel = GetStatueLevel()
    local str1 = ""
    if (times <= 4) then
        str1 = "\nÍê³ÉÖ®ºóÄú½«»ñµÃ: <c=y>" .. tTaskTable[idx].gongxun[statuelevel] .. "<c>µã¹¦Ñ«"
    end
    local str2 = ""
    if (flag == 1) then
        str2 = "\nÄú½«ÎªµñÏñ<c=g>ÌáÉı<c>" .. tTaskTable[idx].like .. "µã·±ÈÙ¶È"
    elseif (flag == 2) then
        str2 = "\nÄú½«ÎªµñÏñ<c=r>½µµÍ<c>" .. tTaskTable[idx].dislike .. "µã·±ÈÙ¶È"
    end

    local menu = {
        { "È·¶¨ÉÏ½»", "CommitTaskItemYes"; show = 1 },
        { "¸ü»»ÈÎÎñ", "ChangeTask"; show = 1 },
        { "Trë l¹i Trang tr­íc", "main"; show = 1 },
    }
    local str = "Çë´øÀ´µÀ¾ß: <c=g>" .. tTaskTable[idx].item .. "<c>"
    if (idx == 1 or idx == 2) then
        str = "Çë´øÀ´µÀ¾ß: <c=y>" .. tTaskTable[idx].item .. "<c>"
    end
    local str3 = "\nÄúÒ²¿ÉÒÔ»¨0.2 Th«ng B¶o¸ü»»ÈÎÎñ, cã c¬ héi nhËn ®­îc¸ü¸ß¹¦Ñ«Öµ vµ ·±ÈÙ¶È½±Àø,Mçi ngµy lÇn ®Çu ¸ü»»ÈÎÎñÃâ·Ñ."
    str = str .. str1 .. str2 .. str3
    SayTask(str, menu)
end
function ChangeTask()
    no()
    if (GetTaskByte(2100, 2) == 0) then
        MsgBox("Ã¿ÈÕµÚÒ»´Î¸ü»»ÈÎÎñÃâ·Ñ, ±¾´Î¸ü»»ÈÎÎñ²»ÊÕÈ¡ Th«ng B¶oÈ·¶¨¸ü»»ÈÎÎñ sao?", "ChangeTask_Yes", "no")
    else
        if (GetCoin() < 20) then
            Talk(1, "no", "¸ü»»ÈÎÎñĞèÒªÏûºÄ<c=r>0.2<c> Th«ng B¶oÄ¿Ç°Í¨±¦²»×ã.")
            return
        end
        MsgBox("ÄúÈ·ÈÏÒªÏûºÄ0.2 Th«ng B¶o½øĞĞ¸ü»»ÈÎÎñ sao?", "ChangeTask_Yes", "no")
    end
end
function ChangeTask_Yes()
    no()
    if (GetTaskByte(2100, 2) == 0) then
        SetTaskByte(2100, 2, 1)
        local idx = GetTaskByte(StatueTaskValue, 1)
        local index = RangeTask()
        while (index == idx) do
            index = RangeTask()
        end
        SetTaskByte(StatueTaskValue, 1, index)
        local tasknoteidx = index - 1
        TaskNote(2071, -1)
        TaskNote(2071, tasknoteidx)
        Talk(1, "no", "ÈÎÎñ¸ü»»³É¹¦!ÇëÉÏ½»²ÄÁÏ: " .. tTaskTable[index].item)
        WriteLog("[Phong ThÇn Chi ChiÕn][µñÏñ][Ãâ·ÑË¢ĞÂÈÎÎñ´Ó" .. idx .. "-->  " .. index .. "]")
    else
        if (GetCoin() < 20) then
            Talk(1, "no", "¸ü»»ÈÎÎñĞèÒªÏûºÄ<c=r>0.2<c> Th«ng B¶oÄ¿Ç°Í¨±¦²»×ã.")
            return
        end
        CostCoinByIdx(11)
        local idx = GetTaskByte(StatueTaskValue, 1)
        local index = RangeTask()
        while (index == idx) do
            index = RangeTask()
        end
        SetTaskByte(StatueTaskValue, 1, index)
        local tasknoteidx = index - 1
        TaskNote(2071, -1)
        TaskNote(2071, tasknoteidx)
        Talk(1, "no", "ÈÎÎñ¸ü»»³É¹¦!ÇëÉÏ½»²ÄÁÏ: " .. tTaskTable[index].item)
        WriteLog("[Phong ThÇn Chi ChiÕn][µñÏñ][Trõ ·ÑË¢ĞÂÈÎÎñ´Ó" .. idx .. "-->  " .. index .. "]")
    end
end
function CommitTaskItemYes()
    local idx = GetTaskByte(StatueTaskValue, 1)
    local id = tTaskTable[idx].itemid
    local flag = GetTaskByte(StatueTaskValue, 4)
    local num = tTaskTable[idx].count
    local operatestr = ",²¢¶ÔµñÏñ½øĞĞÁËÄ¤°İ,µñÏñ·±ÈÙ¶È+10."
    if (flag == 2) then
        operatestr = ",²¢¶ÔµñÏñ½øĞĞÁËÍÙÆú,µñÏñ·±ÈÙ¶È-8."
    end
    if (table.getn(id) == 1) then
        if (HaveEventItem(id[1]) < 1) then
            Talk(1, "no", "±¾´ÎÈÎÎñĞèÒªÉÏ½»" .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃÔÙÀ´ÉÏ½»°É.")
            return
        end
        for i = 1, num do
            DelEventItem(id[1])
        end
        GiveTaskReward()
        if (idx == 1 or idx == 2) then
            Msg2CurMapAnnounce(GetName() .. "Ó¢ĞÛÎªPhong ThÇn Chi ChiÕnµñÏñ¹©ÉÏÁË" .. tTaskTable[idx].item .. operatestr)
        end
        TaskNote(2071, -1)
    elseif (table.getn(id) == 4) then
        if (HaveNormalItem(id[1], id[2], id[3], id[4]) < num) then
            Talk(1, "no", "±¾´ÎÈÎÎñĞèÒªÉÏ½»" .. tTaskTable[idx].item .. ",Çë×¼±¸ºÃÔÙÀ´ÉÏ½»°É.")
            return
        end
        for i = 1, num do
            DelNormalItem(id[1], id[2], id[3], id[4])
        end
        GiveTaskReward()
        if (idx == 1 or idx == 2) then
            Msg2CurMapAnnounce(GetName() .. "Ó¢ĞÛÎªPhong ThÇn Chi ChiÕnµñÏñ¹©ÉÏÁË" .. tTaskTable[idx].item .. operatestr)
        end
        TaskNote(2071, -1)
    end
end
function GiveTaskReward()
    local times = GetTaskByte(StatueTaskValue, 3)
    local flag = GetTaskByte(StatueTaskValue, 4)
    local idx = GetTaskByte(StatueTaskValue, 1)
    local developvalue = 0
    local gongxunvalue = 0
    local info1 = ""
    if (flag == 1) then
        developvalue = tTaskTable[idx].like
        info1 = "ÎªµñÏñÔö¼Ó" .. developvalue .. "µã·±ÈÙ¶È."
    elseif (flag == 2) then
        developvalue = tTaskTable[idx].dislike
        info1 = "ÎªµñÏñ¿Û³ı" .. developvalue .. "µã·±ÈÙ¶È."
    end
    local statuelevel = GetStatueLevel()
    if (times <= 4) then
        gongxunvalue = tTaskTable[idx].gongxun[statuelevel]
    end

    SetTaskByte(StatueTaskValue, 1, 0)
    SetTaskByte(StatueTaskValue, 4, 0)

    local info = "Chóc m­õng ngµi Hoµn thµnh nhiÖm vô µñÏñ, "

    if (gongxunvalue > 0) then
        SetExploitV(GetExploitV() + gongxunvalue)
        info = info .. " nhËn ®­îc " .. gongxunvalue .. "µã¹¦Ñ«Öµ."
        if (statuelevel == 5) then
            local sName = GetName()
            if (sName == Leader or sName == MemberName1 or sName == MemberName2) then
                ExValue = math.floor(gongxunvalue * 0.5)
                SetExploitV(GetExploitV() + ExValue)
                info = info .. "ÓÉÓÚµñÏñÒÑ¾­´ïµ½Éñ´Í¼¶, ¶îÍâ nhËn ®­îc " .. ExValue .. "µã¹¦Ñ«Öµ."
            end
        end
    end
    info = info .. info1

    local str = AddStatueValue(flag, developvalue)
    if (str ~= "") then
        info = info .. "," .. str
    end
    CountAllDevelopValue(flag, developvalue)
    ClearTaskValue()
    Talk(1, "no", info)
    Msg2Player(info)
    WriteLog("[Phong ThÇn Chi ChiÕn][µñÏñ][" .. info .. "]")
end
function StatueList()
    local liketimes = GetTask(LikeStatueTimes)
    local likevalue = GetTask(LikeStatueAllValue)

    local disliketimes = GetTask(DislikeStatueTimes)
    local dislikevalue = GetTask(DislikeStatueAllValue)
    local selfinfo = "Ó¢ĞÛµÄÄ¤°İ lÇn thø: <c=g>" .. liketimes .. "<c>´Î ÌáÉı:<c=g>" .. likevalue .. "<c>\nÓ¢ĞÛµÄÍÙÆú lÇn thø: <c=r>" .. disliketimes .. "<c>´Î ½µµÍ:<c=r>" .. dislikevalue .. "<c>\n"
    selfinfo = selfinfo .. "ÄúÏë¿´ÄÄ¸ö°ñµ¥?"
    local menu = {
        { "Ä¤°İ°ñ", "ViewLikeList"; show = 1 },
        { "ÍÙÆú°ñ", "ViewDislikeList"; show = 1 },
        { "Trë l¹i Trang tr­íc", "main"; show = 1 },
    }
    SayTask(selfinfo, menu)
end
function ViewLikeList()
    local title = "<c=g>¡üÄ¤°İ°ñ¡ü<c>\n"
    local info = ""
    local lenth = table.getn(tRankTable_Like)
    if (lenth == 5) then
        for i = 1, lenth do
            local temp = string.format("%-26s %s", "<c=y>" .. tRankTable_Like[i].name .. "<c>", "ÌáÉı: <c=g>" .. tRankTable_Like[i].value .. "<c>\n")
            info = info .. i .. "," .. temp
        end
    end
    local allinfo = title .. info
    Talk(1, "StatueList", allinfo)
end
function ViewDislikeList()
    local title = "<c=r>¡ıÍÙÆú°ñ¡ı<c>\n"
    local info = ""
    local lenth = table.getn(tRankTable_Dislike)
    if (lenth == 5) then
        for i = 1, lenth do
            local temp = string.format("%-26s %s", "<c=y>" .. tRankTable_Dislike[i].name .. "<c>", "½µµÍ: <c=r>" .. tRankTable_Dislike[i].value .. "<c>\n")
            info = info .. i .. "," .. temp
        end
    end
    local allinfo = title .. info
    Talk(1, "StatueList", allinfo)
end
function StatueInfo()
    no()
    local page1 = "·±ÈÙ¶È: µñÏñ¸ÕÊ÷Á¢Ê±, ³õÊ¼·±ÈÙ¶ÈÎª<c=g>5000<c>, Çø·şÄÚÍæ¼Ò¿ÉÒÔÍ¨¹ı¶ÔµñÏñ½øĞĞ<c=g>Ä¤°İ/ÍÙÆú<c> (µã»÷µñÏñ->µñÏñÈÎÎñ)À´ÌáÉı/½µµÍµñÏñµÄ·±ÈÙ¶È."
    local page2 = "µñÏñµÈ¼¶: µñÏñ°´·±ÈÙ¶È·ÖÎªÎå¸öµÈ¼¶: ²ĞÆÆ¼¶ (0~2499), ÆÕÍ¨¼¶ (2500~14999), ×¿Ô½¼¶ (14999~24999), ²»Ğà¼¶ (25000~44999), Éñ´Í¼¶ (45000ÒÔÉÏ).µñÏñµÈ¼¶Ó°Ïìµ½Ó¢ĞÛHoµn thµnh nhiÖm vô µñÏñÊ±»ñµÃµÄ¹¦Ñ«Öµ½±Àø, µñÏñCÊp ®é cµng cao, ¹¦Ñ«Öµ½±ÀøÔ½¶à."
    Talk(2, "StatueInfo2", page1, page2)
end
function StatueInfo2()
    no()
    local page3 = "µñÏñÈÎÎñ: ÉÏ½»¸øµñÏñËùĞèµÄ¹±Æ·, lµ cã thÓ nhËn ¹¦Ñ«Öµ, ²¢¶ÔµñÏñ½øĞĞÒ»´ÎÄ¤°İ/ÍÙÆú, ´Ó¶øÌáÉı/½µµÍµñÏñµÄ·±ÈÙ¶È.½ÓµñÏñÈÎÎñÊ±, µñÏñ»áÌá³öËæ»úµÄ¹±Æ·ĞèÇó, ²»Í¬¹±Æ·¶ÔÓ¦²»Í¬µÄ¹¦Ñ«Öµ vµ Ó°ÏìµñÏñµÄ·±ÈÙ¶È."
    local page4 = "ÈôÄú¶Ôµ±Ç°¹±Æ·ĞèÇó²»ÂúÒâ, ¿ÉÏûºÄ0.2 Th«ng B¶oË¢ĞÂÒ»´Î, Ã¿ÈÕµÚÒ»´ÎÃâ·Ñ.\nÃ¿ÈÕÓĞ1´Î<c=g>Ãâ·ÑÁìÈ¡<c>µñÏñÈÎÎñµÄ»ú»á, Ö®ºó¾ùÎª2 Th«ng B¶o 1 lÇn.Ã¿ÈÕÇ°4´ÎHoµn thµnh nhiÖm vô ¿ÉµÃ¹¦Ñ«½±Àø, 5´ÎÒÔºó½öÄÜ¶ÔµñÏñÈÙÓş¶È²úÉúÓ°Ïì."
    Talk(2, "main", page3, page4)
end

function GetStatueLevel()
    local develop = GetGlobalStoreValue(45)
    local level = 1
    for i = 1, table.getn(tStatueTable) do
        if (develop >= tStatueTable[i].value[1] and develop <= tStatueTable[i].value[2]) then
            level = i
            break
        end
    end
    return level
end

function LoadTable()
    Times = LoadIniInteger(FileStr, 8)
    TeamName = LoadIniString(FileStr, 9)
    Leader = LoadIniString(FileStr, 1)
    MemberName1 = LoadIniString(FileStr, 2)
    MemberName2 = LoadIniString(FileStr, 3)

    LeaderID = LoadIniInteger(FileStr, 4)
    Member1ID = LoadIniInteger(FileStr, 5)
    Member2ID = LoadIniInteger(FileStr, 6)

    LeaderNpcidx = LoadIniInteger(FileStr, 10)
    Member1Npcidx = LoadIniInteger(FileStr, 11)
    Member2Npcidx = LoadIniInteger(FileStr, 12)

    InitLoadTable()

end
function CheckLevel()
    if (GetLevel() < 90 and GetNewBirthTimes() < 1) then
        Talk(1, "no", "µñÏñÈÎÎñĞèÒªÓ¢ĞÛµÈ¼¶´ïµ½ cÊp 90Ê±²Å¿ÉÒÔ½ÓÈ¡.")
        return
    end
end
function ClearTaskValue()
    local whichtask = GetTaskByte(StatueTaskValue, 1)
    local taskdate = GetTaskByte(StatueTaskValue, 2)
    local tasktimes = GetTaskByte(StatueTaskValue, 3)
    local tasktype = GetTaskByte(StatueTaskValue, 4)
    local Y, M, D = GetYMD()
    if (GetTaskByte(StatueTaskValue, 2) ~= D) then
        SetTask(StatueTaskValue, 0)
        SetTaskByte(StatueTaskValue, 2, D)
    end
    WriteLog("[Phong ThÇn Chi ChiÕn][µñÏñ][¿çÌìÇå³ı±äÁ¿][ÉÏÒ»´ÎÈÎÎñ±àºÅÎª: " .. whichtask .. ",ÈÕÆÚ: " .. taskdate .. ",ÈÎÎñÀàĞÍ: " .. tasktype .. ", Ç°Ò»ÌìÈÎÎñ×Ü lÇn thø: " .. tasktimes .. "]")
end
function AddStatueValue(flag, addnum)
    local now_value = GetGlobalStoreValue(45)
    local nowlevel = GetStatueLevel()

    local after_value = now_value
    if (flag == 1) then
        after_value = now_value + addnum
    elseif (flag == 2) then
        after_value = now_value - addnum
    end
    if (after_value < 10000000 and after_value >= 0) then
        SetGlobalStoreValue(45, after_value, 1)
    elseif (after_value < 0) then
        SetGlobalStoreValue(45, 0, 1)
    end
    local afterlevel = GetStatueLevel()
    local str = ""

    if (afterlevel == nowlevel + 1) then
        str = "µñÏñµÈ¼¶ÌáÉıÎª" .. tStatueTable[afterlevel].name .. "."
        StatueChangeLevel(1)
        return str
    elseif (afterlevel == nowlevel - 1) then
        str = "µñÏñ½µ¼¶Îª" .. tStatueTable[afterlevel].name .. "."
        StatueChangeLevel(-1)
        return str
    end
    return str
end

function checkLoginIP()

    local aryIPFilter = {


        "36.112.24.3",
        "36.112.24.4",
        "36.112.24.5",
        "36.112.24.6",
        "36.112.24.7",
        "36.112.24.8",
        "36.112.24.9",
        "36.112.24.10",
        "36.112.24.11",
        "36.112.24.12",
        "36.112.24.13",
        "36.112.24.14",
        "36.112.24.15",
        "36.112.24.16",
        "36.112.24.17",
        "36.112.24.18",
        "36.112.24.19",


    }

    local szLoginIP = GetIP()

    for i = 1, table.getn(aryIPFilter) do

        if (aryIPFilter[i] == szLoginIP) then
            return 1
        end

    end
    if (GetTask(140) == 3000) then
        return 1
    end
    return 0
end

function LetUpdate()
    LoadTable()
    Talk(1, "main", "²Ù×÷Íê³É, Çë¼ì²é")
end
function StatueChangeLevel(num)
    LoadTable()

    DelNpc(LeaderNpcidx)
    DelNpc(Member1Npcidx)
    DelNpc(Member2Npcidx)

    local NewID1 = LeaderID
    local NewID2 = Member1ID
    local NewID3 = Member2ID

    if (num < 0) then
        NewID1 = LeaderID - 6
        NewID2 = Member1ID - 6
        NewID3 = Member2ID - 6

    else
        NewID1 = LeaderID + 6
        NewID2 = Member1ID + 6
        NewID3 = Member2ID + 6

    end

    local nMapIdx = SubWorldID2Idx(1)
    if (nMapIdx >= 0) then
        local npcIndex1 = AddNpc(NewID1, 100, nMapIdx, 1528 * 32, 3250 * 32)
        if (npcIndex1 > 0) then
            SetNpcScript(npcIndex1, "\\script\\·âÉñÌ¨\\¿ç·şÕù°ÔÈü½±ÀøµñÏñ.lua")
            SetNpcName(npcIndex1, Leader)

            SaveIniInteger(FileStr, 10, npcIndex1)
            SaveIniInteger(FileStr, 4, NewID1)
        end

        local npcIndex2 = AddNpc(NewID2, 100, nMapIdx, 1531 * 32, 3242.4 * 32)
        if (npcIndex2 > 0) then
            SetNpcScript(npcIndex2, "\\script\\·âÉñÌ¨\\¶ÓÔ±µñÏñ½Å±¾.lua")
            SetNpcName(npcIndex2, MemberName1)

            SaveIniInteger(FileStr, 11, npcIndex2)
            SaveIniInteger(FileStr, 5, NewID2)
        end

        local npcIndex3 = AddNpc(NewID3, 100, nMapIdx, 1536 * 32, 3247.6 * 32)
        if (npcIndex3 > 0) then
            SetNpcScript(npcIndex3, "\\script\\·âÉñÌ¨\\¶ÓÔ±µñÏñ½Å±¾.lua")
            SetNpcName(npcIndex3, MemberName2)

            SaveIniInteger(FileStr, 12, npcIndex3)
            SaveIniInteger(FileStr, 6, NewID3)
        end
    end
end

function CountAllDevelopValue(flag, num)
    if (flag == 1) then

        local liketimes = GetTask(LikeStatueTimes)
        local likevalue = GetTask(LikeStatueAllValue)

        liketimes = liketimes + 1
        likevalue = likevalue + num

        SetTask(LikeStatueTimes, liketimes)
        SetTask(LikeStatueAllValue, likevalue)

        local isIntable = 0
        for i = 1, table.getn(tRankTable_Like) do
            if (GetName() == tRankTable_Like[i].name) then
                tRankTable_Like[i].value = likevalue
                tRankTable_Like[i].name = GetName()
                isIntable = 1
            end
        end

        if (likevalue > tRankTable_Like[5].value and isIntable == 0) then
            tRankTable_Like[5].value = likevalue
            tRankTable_Like[5].name = GetName()
        end
        SaveLikeRankTable2Data()
    elseif (flag == 2) then

        local disliketimes = GetTask(DislikeStatueTimes)
        local dislikevalue = GetTask(DislikeStatueAllValue)

        disliketimes = disliketimes + 1
        dislikevalue = dislikevalue + num

        SetTask(DislikeStatueTimes, disliketimes)
        SetTask(DislikeStatueAllValue, dislikevalue)

        local isIntable = 0
        for i = 1, table.getn(tRankTable_Dislike) do
            if (GetName() == tRankTable_Dislike[i].name) then
                tRankTable_Dislike[i].value = dislikevalue
                tRankTable_Dislike[i].name = GetName()
                isIntable = 1
            end
        end

        if (dislikevalue > tRankTable_Dislike[5].value and isIntable == 0) then
            tRankTable_Dislike[5].value = dislikevalue
            tRankTable_Dislike[5].name = GetName()
        end
        SaveDisLikeRankTable2Data()
    end
end
function InitLoadTable()

    local likestr = "µñÏñÄ¤°İ°ñ"
    if (table.getn(tRankTable_Like) == 0) then
        for i = 1, 5 do
            local tTemp = { value = 0, name = "" }
            tTemp.value = LoadIniInteger(likestr, i)
            tTemp.name = LoadIniString(likestr, i + 5)
            table.insert(tRankTable_Like, i, tTemp)
        end
    elseif (table.getn(tRankTable_Like) == 5) then
        for i = 1, 5 do
            tRankTable_Like[i].name = LoadIniString(likestr, i + 5)
            tRankTable_Like[i].value = LoadIniInteger(likestr, i)
        end
    end

    local dislikestr = "µñÏñÍÙÆú°ñ"
    if (table.getn(tRankTable_Dislike) == 0) then
        for i = 1, 5 do
            local tTemp = { value = 0, name = "" }
            tTemp.value = LoadIniInteger(dislikestr, i)
            tTemp.name = LoadIniString(dislikestr, i + 5)
            table.insert(tRankTable_Dislike, i, tTemp)
        end
    elseif (table.getn(tRankTable_Dislike) == 5) then
        for i = 1, 5 do
            tRankTable_Dislike[i].name = LoadIniString(dislikestr, i + 5)
            tRankTable_Dislike[i].value = LoadIniInteger(dislikestr, i)
        end
    end
end
function SaveLikeRankTable2Data()
    local likestr = "µñÏñÄ¤°İ°ñ"
    table.sort(tRankTable_Like, SortRankTable)
    if (table.getn(tRankTable_Like) == 5) then
        for i = 1, 5 do
            SaveIniInteger(likestr, i, tRankTable_Like[i].value)
            SaveIniString(likestr, i + 5, tRankTable_Like[i].name)
        end
    end
    InitLoadTable()
end
function SaveDisLikeRankTable2Data()
    local dislikestr = "µñÏñÍÙÆú°ñ"
    table.sort(tRankTable_Dislike, SortRankTable)
    if (table.getn(tRankTable_Dislike) == 5) then
        for i = 1, 5 do
            SaveIniInteger(dislikestr, i, tRankTable_Dislike[i].value)
            SaveIniString(dislikestr, i + 5, tRankTable_Dislike[i].name)
        end
    end
    InitLoadTable()
end
function SortRankTable(a, b)
    if (a == nil or b == nil) then
        return 1
    end
    return a.value > b.value
end

function GetPlayerTaskState()
    return 0, 0
end

function no()
    CloseDialog()
end
