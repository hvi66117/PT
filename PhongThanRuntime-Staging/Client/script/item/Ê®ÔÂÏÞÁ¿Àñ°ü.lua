Task_Buy_Item = 2069
g_OpenTimes = 11

GlobalFakeCount = 3

function no()
    CloseDialog()
end

function main(itemId)
    CloseDialog()
    if (HaveNormalItem(6, 1, 1353, 1) <= 0) then
        return
    end

    local nYear, nMon, nDay = GetYMD()

    if (GetTaskByte(Task_Buy_Item, 4) == nDay) then
        Talk(1, "no", "ThËt xin lçi, LÔ bao Th¸ng 10 (giíi h¹n) mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    local nUseTimes = GetTaskByte(Task_Buy_Item, 1)
    if (nUseTimes >= g_OpenTimes) then
        Talk(1, "no", "ThËt xin lçi, LÔ bao Th¸ng 10 (giíi h¹n) trong thêi gian ho¹t ®éng chØ cã thÓ sö dông <c=g>" .. g_OpenTimes .. "lÇn<c>, sè lÇn ®· dïng hÕt, tói Tói quµ biÕn mÊt. ")
        DelNormalItem(6, 1, 1353, 1)
    else
        MsgBox("LÔ bao Th¸ng 10 (giíi h¹n) trong thêi gian ho¹t ®éng cã thÓ sö dông <c=g>" .. g_OpenTimes .. "lÇn<c>, mçi ngµy chØ më 1 lÇn, hiÖn t¹i ®· sö dông <c=g>" .. nUseTimes .. "lÇn<c>, hiÖn t¹i sö dông kh«ng?", "Yes_Item", "no")
    end
end

function Yes_Item()
    no()
    if (HaveNormalItem(6, 1, 1353, 1) <= 0) then
        return
    end

    local nYear, nMon, nDay = GetYMD()

    if (GetTaskByte(Task_Buy_Item, 4) == nDay) then
        Talk(1, "no", "ThËt xin lçi, LÔ bao Th¸ng 10 (giíi h¹n) mçi ngµy chØ cã thÓ 1 lÇn.")
        return
    end

    if (IsHaveSpaceForTreasure(6) == 0) then
        Talk(1, "no", "Xin lçi, tói kh«ng ®ñ, h·y s¾p xÕp tói.")
        return
    end

    local nUseTimes = GetTaskByte(Task_Buy_Item, 1)
    local nLeftTimes = g_OpenTimes - nUseTimes
    local str = ""
    SetTaskByte(Task_Buy_Item, 4, nDay)
    SetTaskByte(Task_Buy_Item, 1, nUseTimes + 1)

    if (nUseTimes + 1 < g_OpenTimes) then
        DelNormalItem(6, 1, 1353, 1)
        AddNormalItem(6, 1, 1353, 1, 0, 0)
    end

    if (nUseTimes + 1 >= g_OpenTimes) then
        DelNormalItem(6, 1, 1353, 1)
    end

    if (nLeftTimes == g_OpenTimes) then
        for i = 1, 14 do
            AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        end
        str = "14 T­íng Qu©n LÖnh,"
    else
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        str = "1 T­íng Qu©n LÖnh, "
    end

    for i = 1, 100 do
        AddNormalItemBind(3, 6, 0, 0, 0, 0, 0)
    end
    AddNormalItemBind(6, 1, 1028, 1, 0, 0, 0)
    AddNormalItemBind(6, 1, 1029, 1, 0, 0, 0)
    AddNormalItemBind(6, 1, 1030, 1, 0, 0, 0)
    str = str .. "100 thanh ®ång, tói quµ TiÓu Lôc §¹o, 1 Tói quµ TiÓu Tø T­îng, 1 tói quµ ph¸p b¶o"

    local nRand = math.random(1, 1000)
    if (nRand <= 695) then
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        str = str .. "vµ 1 Di Ngo¹i Phï"
        WriteLog("Më LÔ bao Th¸ng 10 (giíi h¹n): Di Ngo¹i Phï")
    elseif (nRand <= 895) then
        AddNormalItemBind(3, 41, 0, 0, 0, 0, 1)
        str = str .. "vµ 1 Lam B¶o Th¹ch"
        WriteLog("Më LÔ bao Th¸ng 10 (giíi h¹n): Lam B¶o Th¹ch")
    elseif (nRand <= 995) then
        AddNormalItemBind(8, 374, 0, 0, 0, 0, 1)
        str = str .. "vµ 1 Tiªu Dao ThÇn Tiªn T¸n"
        WriteLog("Më LÔ bao Th¸ng 10 (giíi h¹n): Tiªu Dao T¸n")
    else

        local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
        local nTaskDay = GetGlobalStoreValueByte(GlobalFakeCount, 1)
        if (nToday ~= nTaskDay) then
            SetGlobalStoreValueByte(GlobalFakeCount, 2, 0, 1)
            SetGlobalStoreValueByte(GlobalFakeCount, 1, nToday, 1)
        end

        local nItemCount = GetTaskByte(Task_Buy_Item, 2)
        local nTaskCount = GetGlobalStoreValueByte(GlobalFakeCount, 2) + 1
        if (nTaskCount > 10 or nItemCount >= 1) then

            AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
            str = str .. "vµ 1 Di Ngo¹i Phï"
            WriteLog("Më LÔ bao Th¸ng 10 (giíi h¹n)(Gi¶): Di Ngo¹i Phï")
        else
            SetTaskByte(Task_Buy_Item, 2, nItemCount + 1)
            AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
            str = str .. "vµ 1 Vi Quang Qu¸i Phï"
            WriteLog("Më LÔ bao Th¸ng 10 (giíi h¹n): Vi Quang Qu¸i Phï")
            SetGlobalStoreValueByte(GlobalFakeCount, 2, nTaskCount, 1)
        end
    end
    Msg2Player("Më LÔ bao Th¸ng 10 (giíi h¹n) nhËn ®­îc " .. str .. ".")
    Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> më LÔ bao Th¸ng 10 (giíi h¹n), nhËn ®­îc " .. str .. ".")
    if (IsTongMember() > 0) then
        Msg2TongMember("<c=g><RoleName=\"" .. GetName() .. "\"><c> më LÔ bao Th¸ng 10 (giíi h¹n), nhËn ®­îc " .. str .. ".")
    end
end
