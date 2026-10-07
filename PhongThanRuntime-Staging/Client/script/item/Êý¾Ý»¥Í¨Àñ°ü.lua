TaskID_BFHD2 = 2111

g_Item = { 6, 1, 1460, 1 }

function main()


    if (HaveNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) < 0) then
        return
    end

    local Y, M, D = GetYMD()
    if (GetTaskByte(TaskID_BFHD2, 1) ~= D) then
        SetTaskByte(TaskID_BFHD2, 1, D)
        SetTaskByte(TaskID_BFHD2, 2, 0)
    end

    AddGift()
end

RewardList = {
    [0] = { Exp1 = -1, Exp2 = -1, Exp3 = -1, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = "", },
    [1] = { Exp1 = -1, Exp2 = -1, Exp3 = -1, XSExp1 = 6000, XSExp2 = 12000, XSExp3 = 20000, ExpType = "Ti猲 Ma", },
    [2] = { Exp1 = -1, Exp2 = -1, Exp3 = -1, XSExp1 = 12000, XSExp2 = 25000, XSExp3 = 45000, ExpType = "Ti猲 Ma", },
    [3] = { Exp1 = 5000, Exp2 = 10000, Exp3 = 18000, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = "转生经验", },
    [4] = { Exp1 = 15000, Exp2 = 30000, Exp3 = 50000, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = "转生经验", },
    [5] = { Exp1 = 30000, Exp2 = 60000, Exp3 = 100000, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = "转生经验", },
    [6] = { Exp1 = 15000, Exp2 = 30000, Exp3 = 50000, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = " kinh nghi謒", },
    [7] = { Exp1 = 30000, Exp2 = 60000, Exp3 = 100000, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = " kinh nghi謒", },
    [8] = { Exp1 = -1, Exp2 = -1, Exp3 = -1, XSExp1 = -1, XSExp2 = -1, XSExp3 = -1, ExpType = " kinh nghi謒", },
}

function AddGift()
    local PlayerType = GetType()

    local nList = {}
    if (PlayerType == 0) then
        Msg2Player("您目前的经验/转生经验/仙魔经验均不满足提升的要求, 无法开启这个礼包")
        return
    elseif (PlayerType == 8) then
        Msg2Player("您未满80级, 无法开启这个礼包")
        return
    elseif (PlayerType == 1) then
        local LV = GetPlayerExtLevel()
        nList = {
            LV * RewardList[PlayerType].XSExp1 .. "仙魔修为 (免费开启) /v1",
            LV * RewardList[PlayerType].XSExp2 .. "仙魔修为 (5 Th玭g B秓开启) /v2",
            LV * RewardList[PlayerType].XSExp3 .. "仙魔修为 (15 Th玭g B秓开启) /v3",
        }
    elseif (PlayerType == 2) then
        local LV = GetPlayerExtLevel()
        nList = {
            LV * RewardList[PlayerType].XSExp1 .. "仙魔修为 (免费开启) /v1",
            LV * RewardList[PlayerType].XSExp2 .. "仙魔修为 (5 Th玭g B秓开启) /v2",
            LV * RewardList[PlayerType].XSExp3 .. "仙魔修为 (15 Th玭g B秓开启) /v3",
        }
    elseif (PlayerType == 3 or PlayerType == 4 or PlayerType == 5) then
        local LV = GetLevel()
        nList = {
            LV * RewardList[PlayerType].Exp1 .. "转生经验 (免费开启) /v1",
            LV * RewardList[PlayerType].Exp2 .. "转生经验 (5 Th玭g B秓开启) /v2",
            LV * RewardList[PlayerType].Exp3 .. "转生经验 (15 Th玭g B秓开启) /v3",
        }
    elseif (PlayerType == 6 or PlayerType == 7) then
        local LV = GetLevel()
        nList = {
            LV * RewardList[PlayerType].Exp1 .. " Kinh nghi謒 (免费开启) /v1",
            LV * RewardList[PlayerType].Exp2 .. " Kinh nghi謒 (5 Th玭g B秓开启) /v2",
            LV * RewardList[PlayerType].Exp3 .. " 经验 (15 Th玭g B秓开启) /v3",
        }
    end

    Say("请选择您想获取的奖励!", table.getn(nList), nList)
end

function v1()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end
    local PlayerType = GetType()
    local LV = GetLevel()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end

    local Str = ""
    if (RewardList[PlayerType].XSExp1 > 0) then
        Str = (LV * RewardList[PlayerType].XSExp1) .. RewardList[PlayerType].ExpType
    end
    if (RewardList[PlayerType].Exp1 > 0) then
        Str = (LV * RewardList[PlayerType].Exp1) .. RewardList[PlayerType].ExpType
    end
    MsgBox("您是否要直接开启这个礼包, 您将获得<c=g>" .. Str .. "<c>, 今天您还可以开启" .. (10 - OpenTimes) .. "次数据互通礼包.", "v1_ok", "no")
end

function v1_ok()
    no()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end

    local LV = GetLevel()
    local PlayerType = GetType()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end

    local Str = ""
    if (DelNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) > 0) then
        SetTaskByte(TaskID_BFHD2, 2, OpenTimes + 1)
        if (RewardList[PlayerType].XSExp1 > 0) then
            AddOwnExtendExp(LV * RewardList[PlayerType].XSExp1)
            Str = (LV * RewardList[PlayerType].XSExp1) .. RewardList[PlayerType].ExpType
        end
        if (RewardList[PlayerType].Exp1 > 0) then
            AddOwnExp(LV * RewardList[PlayerType].Exp1)
            Str = (LV * RewardList[PlayerType].Exp1) .. RewardList[PlayerType].ExpType
        end
        WriteLog("[开启数据互通礼包][免费开启][当天第" .. (OpenTimes + 1) .. " l莕][Nh薾 頲 " .. Str .. "]")
        Msg2Player("您开启了数据互通礼包, nh薾 頲 " .. Str .. ", 今天您还可以开启" .. (9 - OpenTimes) .. "次数据互通礼包.")
    else
        Talk(1, "no", "您的数据互通礼包呢?")
        return
    end
end

function v2()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end

    local LV = GetLevel()
    local PlayerType = GetType()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end
    local Str = ""
    if (RewardList[PlayerType].XSExp2 > 0) then
        Str = (LV * RewardList[PlayerType].XSExp2) .. RewardList[PlayerType].ExpType
    end
    if (RewardList[PlayerType].Exp1 > 0) then
        Str = (LV * RewardList[PlayerType].Exp2) .. RewardList[PlayerType].ExpType
    end
    MsgBox("您是否要<c=g>花费5 Th玭g B秓<c>开启这个礼包, 您将获得<c=g>" .. Str .. "<c>, 今天您还可以开启" .. (10 - OpenTimes) .. "次数据互通礼包.", "v2_ok", "no")
end

function v2_ok()
    no()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end

    if (GetCoin() < 500) then
        Talk(1, "no", "您身上不足5 Th玭g B秓无法开启这档奖励.")
        return
    end

    if (DelNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) <= 0) then
        Talk(1, "no", "您的数据互通礼包呢?")
        return
    end

    local LV = GetLevel()
    local PlayerType = GetType()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end

    local Str = ""
    if (CostCoinByIdx(142) > 0) then
        SetTaskByte(TaskID_BFHD2, 2, OpenTimes + 1)
        if (RewardList[PlayerType].XSExp2 > 0) then
            AddOwnExtendExp(LV * RewardList[PlayerType].XSExp2)
            Str = (LV * RewardList[PlayerType].XSExp2) .. RewardList[PlayerType].ExpType
        end
        if (RewardList[PlayerType].Exp2 > 0) then
            AddOwnExp(LV * RewardList[PlayerType].Exp2)
            Str = (LV * RewardList[PlayerType].Exp2) .. RewardList[PlayerType].ExpType
        end
        WriteLog("[开启数据互通礼包][5 Th玭g B秓开启][当天第" .. (OpenTimes + 1) .. " l莕][Nh薾 頲 " .. Str .. "]")
        Msg2Player("您开启了数据互通礼包, nh薾 頲 " .. Str .. ", 今天您还可以开启" .. (9 - OpenTimes) .. "次数据互通礼包.")
    else
        Talk(1, "no", "您的通宝不足.")
        return
    end
end

function v3()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end

    local LV = GetLevel()
    local PlayerType = GetType()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end

    local Str = ""
    if (RewardList[PlayerType].XSExp3 > 0) then
        Str = (LV * RewardList[PlayerType].XSExp3) .. RewardList[PlayerType].ExpType
    end
    if (RewardList[PlayerType].Exp1 > 0) then
        Str = (LV * RewardList[PlayerType].Exp3) .. RewardList[PlayerType].ExpType
    end
    MsgBox("您是否要<c=g>花费15 Th玭g B秓<c>开启这个礼包, 您将获得<c=g>" .. Str .. "<c>, 今天您还可以开启" .. (10 - OpenTimes) .. "次数据互通礼包.", "v3_ok", "no")
end

function v3_ok()
    no()

    local OpenTimes = GetTaskByte(TaskID_BFHD2, 2)
    if (OpenTimes >= 10) then
        Talk(1, "no", "您今日最多开启 10 c竔 数据互通礼包.")
        return
    end

    if (GetCoin() < 1500) then
        Talk(1, "no", "您身上通宝不足15, 无法开启这档奖励.")
        return
    end

    if (DelNormalItem(g_Item[1], g_Item[2], g_Item[3], g_Item[4]) <= 0) then
        Talk(1, "no", "您的数据互通礼包呢?")
        return
    end

    local LV = GetLevel()
    local PlayerType = GetType()
    if (PlayerType == 1 or PlayerType == 2) then
        LV = GetPlayerExtLevel()
    end
    local Str = ""

    if (CostCoinByIdx(163) > 0) then
        SetTaskByte(TaskID_BFHD2, 2, OpenTimes + 1)
        if (RewardList[PlayerType].XSExp3 > 0) then
            AddOwnExtendExp(LV * RewardList[PlayerType].XSExp3)
            Str = (LV * RewardList[PlayerType].XSExp3) .. RewardList[PlayerType].ExpType
        end
        if (RewardList[PlayerType].Exp3 > 0) then
            AddOwnExp(LV * RewardList[PlayerType].Exp3)
            Str = (LV * RewardList[PlayerType].Exp3) .. RewardList[PlayerType].ExpType
        end
        WriteLog("[开启数据互通礼包][15 Th玭g B秓开启][当天第" .. (OpenTimes + 1) .. " l莕][Nh薾 頲 " .. Str .. "]")
        Msg2Player("您开启了数据互通礼包, nh薾 頲 " .. Str .. ", 今天您还可以开启" .. (9 - OpenTimes) .. "次数据互通礼包.")
    else
        Talk(1, "no", "您的通宝不足.")
        return
    end
end

function GetType()
    if (GetNewBirthTimes() > 0) then
        if (GetLevel() == 200) then
            if (GetPlayerExtLevel() == 0) then
                return 0
            else
                if (GetPlayerExtLevel() == 80) then
                    return 0
                elseif (GetPlayerExtLevel() > 30) then
                    return 2
                elseif (GetPlayerExtLevel() >= 1) then
                    return 1
                end
            end
        elseif (GetLevel() >= 120) then
            return 5
        elseif (GetLevel() >= 80) then
            return 4
        elseif (GetLevel() >= 30) then
            return 3
        else
            return 0
        end
    else
        if (GetLevel() == 200) then
            if (GetPlayerExtLevel() == 0) then
                return 0
            else
                if (GetPlayerExtLevel() == 80) then
                    return 0
                elseif (GetPlayerExtLevel() > 30) then
                    return 2
                elseif (GetPlayerExtLevel() >= 1) then
                    return 1
                end
            end
        elseif (GetLevel() >= 120) then
            return 7
        elseif (GetLevel() >= 80) then
            return 6
        else
            return 8
        end
    end
end

function no()
    CloseDialog()
end;

