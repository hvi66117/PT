Global_War_Event_State = 212

TASK_SOUL = 1476

SOUL_NPC_TEMPLETE = 47
SOUL_MAX_ACC_TIMES = 3
SOUL_TASK_CAMP_JUSTICE = 1
SOUL_TASK_CAMP_EVIL = 2
SOUL_TASK_BUFF = 702
SOUL_TASK_ITEM_1 = 708
SOUL_TASK_ITEM_2 = 707
CREDIT_LIMIT_MAX = 180000
CREDIT_LIMIT_MIN = 45000
SOUL_ACC_ITEM_J = 428
SOUL_ACC_ITEM_E = 427
ACC_ITEM_COUNT = 5
SOUL_TASK_IB_ITEM = 706
SOUL_TASK_IB_INDEX = 116

PLAYER_RELEASE_SOUL_BUFF = 704
NPC_RELEASE_SOUL_BUFF = 703
PLAYER_CONFUSE_BUFF = 705

Task_TwelveIdol = 1484

Task_TwelveIdol_StarManIdx = 1485

Task_TwelveStarCommon = 1486

Task_FightStarManNpcID = 1487
Task_FightStarManNpcIdx = 1488

StarManName = {
    [0] = { name = "Ngò Quû Tinh Qu©n", idx = 440, soulidx = 1133, pos = "<HyperLinkWorldPos=\"Îå¹íÐÇ¾ý[75,231,201]\">" },
    [1] = { name = "§¹i Hao Tinh Qu©n", idx = 441, soulidx = 1134, pos = "<HyperLinkWorldPos=\"´óºÄÐÇ¾ý[75,241,204]\">" },
    [2] = { name = "B¹ch Hæ Tinh Qu©n", idx = 442, soulidx = 1135, pos = "<HyperLinkWorldPos=\"°×»¢ÐÇ¾ý[75,261,213]\">" },
    [3] = { name = "Thiªn CÈu Tinh Qu©n", idx = 443, soulidx = 1136, pos = "<HyperLinkWorldPos=\"Ìì¹·ÐÇ¾ý[75,259,221]\">" },
    [4] = { name = "B¸ch ViÖt Tinh Qu©n", idx = 444, soulidx = 1137, pos = "<HyperLinkWorldPos=\"°ÙÔ½ÐÇ¾ý[75,259,234]\">" },
    [5] = { name = "Tö Vi Tinh qu©n", idx = 445, soulidx = 1138, pos = "<HyperLinkWorldPos=\"×ÏÞ±ÐÇ¾ý[75,247,235]\">" },
    [6] = { name = "Thiªn §øc Tinh Qu©n", idx = 446, soulidx = 1139, pos = "<HyperLinkWorldPos=\"ÌìµÂÐÇ¾ý[75,228,236]\">" },
    [7] = { name = "Th¸i ¢m Tinh Qu©n", idx = 447, soulidx = 1140, pos = "<HyperLinkWorldPos=\"Ì«ÒõÐÇ¾ý[75,219,232]\">" },
    [8] = { name = "Th¸i D­¬ng Tinh Qu©n", idx = 436, soulidx = 1129, pos = "<HyperLinkWorldPos=\"Ì«ÑôÐÇ¾ý[75,210,226]\">" },
    [9] = { name = "Th¸i TuÕ Tinh Qu©n", idx = 437, soulidx = 1130, pos = "<HyperLinkWorldPos=\"Ì«ËêÐÇ¾ý[75,204,220]\">" },
    [10] = { name = "TiÓu Hao Tinh Qu©n", idx = 438, soulidx = 1131, pos = "<HyperLinkWorldPos=\"Ð¡ºÄÐÇ¾ý[75,205,210]\">" },
    [11] = { name = "DÞch M· Tinh Qu©n", idx = 439, soulidx = 1132, pos = "<HyperLinkWorldPos=\"æäÂíÐÇ¾ý[75,212,204]\">" },
}
TwelveStarItem = {
    [0] = { name = "Dò T©m Th¶o", idx = 427 },
    [1] = { name = "Tôc MÖnh Hoa", idx = 428 },
}

g_SearchClansMan = 1483
g_AliveStar = 1481

g_Light1 = 218
g_Light2 = 219
g_Light3 = 220
g_Light4 = 221

g_PowerStar = 1480
g_AliveStar = 1481

g_Light1 = 218
g_Light2 = 219
g_Light3 = 220
g_Light4 = 221

g_BUFFSTARPOWER = 696
g_BUFFMOSTER = 698
g_BUFFDEFEND = 697
BUFF_STRAR = 695

g_HellGod = 1482
g_TrueNpcID = 224
g_SaveBuff = 225
g_Teammate = 226

g_BUFFSTARPOWER = 696
g_BUFFMOSTER = 698
g_BUFFDEFEND = 697

task_poluo_renwu = 1525

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 65
    if (GetPlayerExtLevel() >= startLevel and GetTaskByte(g_PowerStar, 1) == 5 and GetTaskByte(g_HellGod, 3) <= 3 and GetTaskByte(g_HellGod, 1) <= 6 and GetTaskByte(g_HellGod, 1) ~= 5) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if GetTaskByte(g_HellGod, 1) == 0 or GetTaskByte(g_HellGod, 1) == 4 then
                state = 1
                subState = 0
            elseif GetTaskByte(g_HellGod, 1) == 3 then
                state = 3
                substate = 0
            elseif GetTaskByte(g_HellGod, 1) == 1 or GetTaskByte(g_HellGod, 1) == 2 then
                state = 2
                subState = 0
            end
        else
            if GetTaskByte(g_HellGod, 1) == 0 or GetTaskByte(g_HellGod, 1) == 4 then
                state = 1
                subState = 1
            elseif GetTaskByte(g_HellGod, 1) == 3 then
                state = 3
                substate = 1
            elseif GetTaskByte(g_HellGod, 1) == 1 or GetTaskByte(g_HellGod, 1) == 2 then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 62
    if (GetPlayerExtLevel() >= startLevel) and (GetTaskByte(g_SearchClansMan, 1) == 5) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if ((GetTaskByte(g_PowerStar, 1) == 0 or GetTaskByte(g_PowerStar, 1) == 4)) then
                state = 1
                subState = 0
            elseif (GetTaskByte(g_PowerStar, 1) == 3) then
                state = 3
                subState = 0
            elseif (GetTaskByte(g_PowerStar, 1) == 1 or GetTaskByte(g_PowerStar, 1) == 2) then
                state = 2
                subState = 0
            end
        else
            if ((GetTaskByte(g_PowerStar, 1) == 0 or GetTaskByte(g_PowerStar, 1) == 4)) then
                state = 1
                subState = 1
            elseif (GetTaskByte(g_PowerStar, 1) == 3) then
                state = 3
                subState = 1
            elseif (GetTaskByte(g_PowerStar, 1) == 1 or GetTaskByte(g_PowerStar, 1) == 2) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 61
    if (IsIdolVisible() == 1) then
        local nProcess = GetTaskByte(Task_TwelveIdol, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (nProcess == 0) or (nProcess == 4) then
                state = 1
                subState = 0
            elseif (nProcess == 3) then
                state = 3
                subState = 0
            elseif (nProcess == 1) or (nProcess == 2) then
                state = 2
                subState = 0
            end
        else
            if (nProcess == 0) or (nProcess == 4) then
                state = 1
                subState = 1
            elseif (nProcess == 3) then
                state = 3
                subState = 1
            elseif (nProcess == 1) or (nProcess == 2) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 66
    if (IsStarManVisible() == 1) then
        local nProcess = GetTaskByte(Task_TwelveIdol, 4)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (nProcess == 0) or (nProcess == 10) then
                state = 1
                subState = 0
            elseif (nProcess == 7) then
                state = 3
                subState = 0
            elseif (nProcess >= 1) and (nProcess <= 6) then
                state = 2
                subState = 0
            end
        else
            if (nProcess == 0) or (nProcess == 10) then
                state = 1
                subState = 1
            elseif (nProcess == 7) then
                state = 3
                subState = 1
            elseif (nProcess >= 1) and (nProcess <= 6) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

Task_Yiqi = 1532

function main()

    local tasks = {
        { "Hån quy cè lý", "soul_backhome"; show = 1 },

        { "ThËp nhÞ nh©n ngÉu", "TwelveIdol"; show = 0 },
        { "Tinh qu©n mËt gi¸p", "StarMan"; show = 0 },
        { "PhÇn th­ëng nh©n ngÉu", "Exchange12"; show = 0 },

        { "Tinh qu©n chi lùc", "acceptPowerfulOne"; show = 0 },
        { "Hoµn thµnh Tinh qu©n chi lùc", "comPowerfulStar"; show = 0 },
        { "Ngôc Ph¸p thÇn", "GodofHell"; show = 0 },
        { "Sa La Song Thô", "sal_begin"; show = 0 },
    }

    local extlvl = GetPlayerExtLevel()
    local credit = GetJusticEvilCredit()

    if (IsIdolVisible() == 1) then
        tasks[2].show = 1
    end

    if (IsStarManVisible() == 1) then
        tasks[3].show = 1
    end

    if (extlvl >= 66 and math.abs(credit) >= 80000) then
        tasks[4].show = 1
    end

    if (extlvl >= 62 and GetTaskByte(g_SearchClansMan, 1) == 5 and GetTaskByte(g_PowerStar, 1) <= 4 and GetTaskByte(g_PowerStar, 1) >= 0 and GetTaskByte(g_PowerStar, 1) ~= 3) then
        tasks[5].show = 1
    elseif (extlvl >= 62 and GetTaskByte(g_SearchClansMan, 1) == 5 and GetTaskByte(g_PowerStar, 1) == 3) then
        tasks[6].show = 1
    end

    if (GetTaskByte(g_PowerStar, 1) == 5 and extlvl >= 65 and GetTaskByte(g_HellGod, 1) == 5) then
        TaskNote(110, -1)
    end

    if (GetTaskByte(g_PowerStar, 1) == 5 and extlvl >= 65 and GetTaskByte(g_HellGod, 3) <= 3 and GetTaskByte(g_HellGod, 1) <= 6 and GetTaskByte(g_HellGod, 1) ~= 5) then
        tasks[7].show = 1
    end

    if (extlvl >= 65) and (IsJEMainTaskComplete(2) == 1) and (credit < 0) then
        if (GetTask(task_poluo_renwu) == 0) and (IsJEMainTaskComplete(3) == 0) then
            tasks[8].show = 1
        end
    end
    SayTask("GÇn ®©y nghe ®ån hai giíi Tiªn Ma l¹i cã xung ®ét, chiÕn tranh l¹i næ ra. §Ó gióp téc nh©n tr¸nh bÞ liªn lôy, ta ®· dèc søc thuyÕt phôc téc tr­ëng liªn minh víi Tiªn giíi. Nh­ng téc tr­ëng l¹i sî ®¾c téi víi Ma giíi nªn l­ìng lù ch­a quyÕt, viÖc ®Õn n­íc nµy ®µnh nhê ch­ Tiªn thÓ hiÖn b¶n lÜnh, ®Ó tranh thñ sù tin t­ëng cña téc tr­ëng, lóc ®ã viÖc liªn minh ¾t thµnh c«ng.", tasks)
end;

function FairyOrDevil()
    if (GetJusticEvilCredit() > 0) then
        return 0
    elseif (GetJusticEvilCredit() < 0) then
        return 1
    end
end

function Exchange12()
    local tasks = {
        { "§æi kinh nghiÖm", "ExchangeExp"; show = 1 },
        { "§æi nh©n ngÉu", "ExchangeIdol"; show = 1 },
    }
    SayTask("<c=yel>Th¹ch Trung Ngäc<c> lµ chÝ b¶o ®­îc Èn chøa trong t­îng ThËp NhÞ Tinh qu©n, tiÒm n¨ng v« h¹n. NÕu ng­¬i t×m cho ta 1 c¸i, ta sÏ dïng nã ®Ó t¨ng kinh nghiÖm cho ng­¬i. Thu thËp ®ñ 12 nh©n ngÉu kh¸c nhau míi cã thÓ ®æi 1 <c=yel>Th¹ch Trung Ngäc<c>.", tasks)
end

function ExchangeIdol()
    for i = 0, 11 do
        if (HaveNormalItem(3, StarManName[i].idx, 0, 0) == 0) then
            Talk(1, "no", "Ng­¬i cÇn thu thËp ®ñ 12 nh©n ngÉu kh¸c nhau míi ®æi ®­îc <c=yel>Th¹ch Trung Ngäc<c>")
            return
        end
    end

    MsgBox("X¸c ®Þnh ®æi 12 nh©n ngÉu thµnh <c=yel>Th¹ch Trung Ngäc<c>?", "Yes_Stone", "no")
end

function Yes_Stone()
    CloseDialog()

    for i = 0, 11 do
        if (HaveNormalItem(3, StarManName[i].idx, 0, 0) == 0) then
            WriteLog("XuÊt hiÖn Nh©n ngÉu")
            return
        end
    end

    for i = 0, 11 do
        DelNormalItem(3, StarManName[i].idx, 0, 0)
    end

    AddNormalItem(3, 435, 0, 0, 0, 0)
    TopMessage("Ng­¬i nhËn ®­îc 1 <c=yel>Th¹ch Trung Ngäc<c>")
end

function ExchangeExp()

    local nAccTime = GetTaskByte(Task_TwelveStarCommon, 4)
    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    if (nAccTime ~= nNowTime) then
        if (HaveNormalItem(3, 435, 0, 0) == 0) then
            Talk(1, "no", "<c=yel>Th¹ch Trung Ngäc<c> lµ chÝ b¶o ®­îc Èn chøa trong t­îng ThËp NhÞ Tinh qu©n, tiÒm n¨ng v« h¹n. NÕu ng­¬i t×m cho ta 1 c¸i, ta sÏ dïng nã ®Ó t¨ng kinh nghiÖm cho ng­¬i.")
            return
        else
            MsgBox("<c=yel>Th¹ch Trung Ngäc<c> lµ chÝ b¶o ®­îc Èn chøa trong t­îng ThËp NhÞ Tinh qu©n, tiÒm n¨ng v« h¹n. NÕu ng­¬i t×m cho ta 1 c¸i, ta sÏ dïng nã ®Ó t¨ng kinh nghiÖm cho ng­¬i!", "Yes_ExchangeExp", "no")
        end
    else
        Talk(1, "no", "H«m nay ng­¬i ®· dïng <c=yel>Th¹ch Trung Ngäc<c> t¨ng tu hµnh 1 lÇn, nÕu n¨ng l­îng n¹p vµo qu¸ nhiÒu, sÏ bÊt lîi cho tu hµnh, mai h·y quay trë l¹i!")
        return
    end

end

function Yes_ExchangeExp()
    if (HaveNormalItem(3, 435, 0, 0) <= 0) then
        WriteLog("Dïng Th¹ch Trung Ngäc xãa kinh nghiÖm")
        return
    end

    DelNormalItem(3, 435, 0, 0)
    local nExp = GetPlayerExtLevel() * 160000
    AddOwnExtendExp(nExp)

    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    SetTaskByte(Task_TwelveStarCommon, 4, nNowTime)
    Talk(1, "no", "Chóc mõng b¹n nhËn ®­îc " .. nExp .. " ®iÓm tu luyÖn")
end

function ResetTwelveIdolTaskTime()
    SetTaskByte(Task_TwelveIdol, 4, 10)

    local nWorldEvent = GetWorldEventProgress(4)

    local nAccTime = GetTaskByte(Task_TwelveStarCommon, 2)
    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    if (nAccTime ~= nNowTime) then
        SetTaskByte(Task_TwelveStarCommon, 2, nNowTime)
        SetTaskByte(Task_TwelveStarCommon, 3, 0)
        offlineTotimes()

        if (nWorldEvent == 12) then
            SyncBibleState(1084, 1, 1)
            SyncBibleState(1084, 1, 1)
        end

    else
        if (nWorldEvent == 12) then
            SyncBibleState(1085, 3, 1)
        end
    end

end

function GetCostDisIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(nIndex)
    return costDisNum
end

function GetCostIB(nIndex)
    local costName, costIBNum, costDisNum
    costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(nIndex)
    return costIBNum
end

function TwelveIdol()
    CloseDialog()

    local nTaskStarMan = GetTaskByte(Task_TwelveIdol, 4)
    if (nTaskStarMan > 0 and nTaskStarMan < 8) then
        Talk(1, "no", "Mçi lÇn ng­¬i chØ ®­îc ®¸nh thøc 1 vÞ Tinh qu©n, hiÖn ng­¬i ®ang trong nhiÖm vô <c=g>Tinh qu©n MËt Gi¸p<c>, kh«ng thÓ ®i ®¸nh thøc Tinh qu©n kh¸c.")
        return
    end

    local nTask = GetTaskByte(Task_TwelveIdol, 1)

    if (nTask == 0) then

        local temp = GetTaskByte(Task_TwelveStarCommon, 3)
        local nNum, addtimes = todayfreetimes(temp)
        local alltimes = GetTaskByte(1477, 3)

        if (nNum == 0) or (IsCurDay() == 0) then
            BeginTwelveIdol()
        elseif (nNum >= 5) and (addtimes > alltimes) then
            Talk(1, "no", "Tu hµnh qu¸ nãng véi sÏ g©y bÊt lîi, h«m nay ng­¬i ®· nhËn 5 lÇn råi, mai h·y tiÕp tôc!")
            return
        else
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹p tµi tu luyÖn", "yiqiBuff_3"; show = 0 },
                { "ThÊt KhiÕu Linh Lung", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end

            if (nNum > 0 and nNum < 5) then
                task[2].show = 1
            end
            SayTask("HiÖn t¹i ng­¬i tÝch lòy" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn sè lÇn nhiÖm vô thªm, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ. NhÊp chän N¹p tµi tu luyÖn lµ cã thÓ h­ëng ­u ®·i nµy.", task)
        end
    else
        BeginTwelveIdol()
    end
    refreshNpcTaskState()
end

function coin_renwu()
    local nItemCount = FindAValidIBItem(8, 710, 2, 0)
    local nCoin = GetCostIB(117)
    if (nItemCount == 0 and GetCoin() < nCoin) then
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. GetCostDisIB(117) .. " Th«ng B¶o<c>, kh«ng thÓ nhËn thªm nhiÖm vô")
        return
    end

    MsgBox("Ng­¬i ®ang cã <c=yel>ThÊt KhiÕu Linh Lung<c> ta cÇn, trao ®æi víi ta cã thÓ nhËn thªm nhiÖm vô", "BeginTwelveIdol", "no")
end

function yiqiBuff_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ng­¬i cã ®ång ý sö dông kh«ng?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        yes_freefsb()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khÝ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function BeginTwelveIdol()
    local nTask = GetTaskByte(Task_TwelveIdol, 1)
    if (nTask == 0) or (nTask >= 3) then
        No_ResetStarMan()
        return 0
    end
    local nNameId = GetTaskByte(Task_TwelveIdol, 2)

    tasks = {
        { "Giao nhiÖm vô", "No_ResetStarMan"; show = 1 },
        { "ThiÕt lËp l¹i Tinh qu©n", "Yes_ResetStarMan"; show = 1 },
    }
    if (GetTaskByte(Task_TwelveIdol, 3) >= 100) then
        tasks[2].show = 0
    end
    SayTask("Xem ra <c=g>" .. StarManName[nNameId].name .. "<c> cã duyªn víi ng­¬i, ThËp NhÞ Tinh qu©n tuy lµ huynh ®Ö, nh­ng còng cã ph©n biÖt Tiªn Ma, nÕu muèn ®¸nh thøc c¸c Tinh qu©n kh¸c, cã thÓ nép <c=yel>Tinh qu©n bµi<c> hoÆc <c=yel>" .. GetCostDisIB(118) .. "<c> Th«ng B¶o.", tasks)

end

function DelStarNpc()
    local NpcIdx = 0
    if (GetJusticEvilCredit() > 0) then
        NpcIdx = 1127
    else
        NpcIdx = 1128
    end

    local oldnpcidx = GetTask(Task_FightStarManNpcIdx)
    if (oldnpcidx ~= 0) then
        local oldnpcid = GetTask(Task_FightStarManNpcID)
        if (GetNpcID(oldnpcidx) == oldnpcid and GetNpcTemplateID(oldnpcidx) == NpcIdx) then
            DelNpc(oldnpcidx)
        end
    end
end

function ResetTwelveIdolForReset()

    if (HaveNormalItem(6, 1, 527, 0) > 0) then
        DelNormalItem(6, 1, 527, 0)
    end

    if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
        DelNormalItemInQuick(6, 1, 528, 0)
    elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
        DelNormalItem(6, 1, 528, 0)
    end

    SetTaskByte(Task_TwelveIdol, 1, 0)
    SetTaskByte(Task_TwelveIdol, 3, 0)

    DelStarNpc()
    SetTask(Task_FightStarManNpcID, 0)
    SetTask(Task_FightStarManNpcIdx, 0)

end

function BeginTwelveIdolAgain()
    local nNameId = math.mod(GetTaskByte(Task_TwelveIdol, 2) + 1, 12)
    SetTaskByte(Task_TwelveIdol, 2, nNameId)
    SetTaskByte(Task_TwelveIdol, 1, 1)
    TaskNote(1084, 0, StarManName[nNameId].name, StarManName[nNameId].pos)
    AddNormalItem(6, 1, 527, 0, 1, 0)
    Msg2Player("Ng­¬i thiÕt lËp l¹i nhiÖm vô ThËp nhÞ nh©n ngÉu lÇn nµy.")
    TopMessage("NhËn ®­îc <c=yel>Hu©n H­¬ng L­")

    Talk(1, "no", "Xem ra anh hïng vµ <c=g>" .. StarManName[nNameId].name .. "<c> rÊt cã duyªn, h·y gióp ta dïng <c=yel>Hu©n H­¬ng L­<c> ®¸nh thøc h¾n!")
end

function Yes_ResetStarMan()
    CloseDialog()

    local i = FindAValidIBItem(8, 711, 2, 0)
    if (i ~= 0) then
        CostIBItem(i)
        Msg2Player("Ng­¬i bÞ trõ mÊt 1 <c=yel>Tinh qu©n bµi<c>")
        ResetTwelveIdolForReset()
        BeginTwelveIdolAgain()

    elseif (GetCoin() >= GetCostIB(118)) then
        CostCoinByIdx(118)
        Msg2Player("Ng­¬i bÞ trõ <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>")
        ResetTwelveIdolForReset()
        BeginTwelveIdolAgain()

    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>Tinh qu©n bµi<c> hoÆc <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>, kh«ng thÓ thiÕt lËp l¹i nhiÖm vô")
    end

end

function No_ResetStarMan()
    CloseDialog()
    local nTask = GetTaskByte(Task_TwelveIdol, 1)
    if (nTask == 0) then
        AwakeStarMan()
        return
    end

    if (nTask == 1) then
        local nStarManID = GetTaskByte(Task_TwelveIdol, 2)
        Talk(1, "no", "LÇn nµy ng­¬i cÇn dïng <c=yel>Hu©n H­¬ng L­<c> ®¸nh thøc <c=g>" .. StarManName[nStarManID].name .. "<c>. Trong qu¸ tr×nh ®¸nh thøc h¾n ng­¬i cã thÓ bÞ khãi ®éc lµm bÞ th­¬ng, ph¶i cÈn thËn.")
        return
    end

    if (nTask == 2) then
        Talk(1, "no", "Mau gióp ta ®i t×m Ho¸n TØnh Tinh qu©n, c¸c h¹ sÏ b¶o vÖ bé téc ta.")
        return
    end

    if (nTask >= 3) then
        if (HaveNormalItem(6, 1, 528, 0) == 0 and HaveNormalItemInQuick(6, 1, 528, 0) == 0 and IsExistItem(6, 1, 528, 0) ~= 0) then
            Talk(1, "no", "Ng­¬i ph¶i ®em theo <c=yel>Bå §Ò KÝnh<c> míi nhËn ®­îc kinh nghiÖm")
            return
        end
        if (IsExistItem(6, 1, 528, 0) == 0) then
            ResetTwelveIdolTask()
            MsgBox("Bå §Ò KÝnh cña ng­¬i ®· mÊt, lÇn nµy Ho¸n TØnh Tinh qu©n kh«ng thµnh c«ng, nÕu cho ta 1 <c=yel>ThÊt KhiÕu Linh Lung<c> cã thÓ nhËn l¹i nhiÖm vô nµy!", "TwelveIdol", "no")
        else
            FinishAwake()
        end
        return
    end
end

function AwakeStarMan()
    if (IsCanReceive() == 0) then
        return
    end

    MsgBox("ThËp NhÞ Tinh qu©n tõng høa <c=g>B¨ng Viªm Song Long<c> sÏ phï hé YÓn téc ta, nay téc ta gÆp n¹n kiÕp, ph¶i nhê ®Õn Ho¸n TØnh Tinh qu©n ®Ó v­ît qua khã kh¨n. NÕu anh hïng ®ång ý gióp ta ®¸nh thøc Tinh qu©n, ta sÏ ban phÐp gióp cho viÖc tu hµnh cña ng­¬i. H·y ®Õn xoay chuyÓn Cµn Kh«n Lu©n nµy, nã sÏ ®­a ng­¬i ®Õn chç Tinh qu©n cã duyªn!", "yiqiBuff_start", "no")
end

function yiqiBuff_start()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ng­¬i cã ®ång ý sö dông kh«ng?", "costYiqi_start", "Yes_Awake")
    else
        Yes_Awake()
    end
end

function costYiqi_start()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        Yes_Awake()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khÝ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function ResetTwelveIdolTask()
    SetTaskWord(Task_TwelveIdol, 1, 0)
    SetTaskByte(Task_TwelveIdol, 3, 0)

    if (IsCurDay() == 0) then
        SetTaskByte(Task_TwelveIdol, 4, 0)
    end

    DelNpc(GetTask(Task_FightStarManNpcIdx))
    SetTask(Task_FightStarManNpcID, 0)
    SetTask(Task_FightStarManNpcIdx, 0)


end

function FinishAwake()

    local nCredit = GetJusticEvilCredit()
    if (GetPlayerExtLevel() < 66 or (math.abs(nCredit) < 80000)) then
        GetExp()
        return
    end

    local tasks = {
        { "NhËn Exp", "GetExp"; show = 1 },
        { "§æi nh©n ngÉu", "ExChange"; show = 1 },
    }

    SayTask("Chän c¸ch nhËn th­ëng", tasks)
end

function ExChange()
    CloseDialog()

    if (HaveNormalItem(6, 1, 528, 0) == 0 and HaveNormalItemInQuick(6, 1, 528, 0) == 0) then
        WriteLog("T¹i chç ®æi Nh©n ngÉu xuÊt hiÖn Nh©n ngÉu")
        return
    end

    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    if (nGrowth < 100) then
        Talk(1, "no", "Bå §Ò KÝnh cña ng­¬i tr­ëng thµnh ch­a ®¹t 100%")
        return
    end

    ChangeWorldEventData()

    if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
        DelNormalItemInQuick(6, 1, 528, 0)
    elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
        DelNormalItem(6, 1, 528, 0)
    end

    RemoveIBBuff(713)
    local nStarManID = GetTaskByte(Task_TwelveIdol, 2)
    AddNormalItem(3, StarManName[nStarManID].idx, 0, 0, 0, 0)
    TopMessage("NhËn ®­îc <c=yel>" .. StarManName[nStarManID].name .. "Nh©n ngÉu")

    ResetTwelveIdolTask()
    TaskNote(1084, -1)
end

function GetExp()

    if (HaveNormalItem(6, 1, 528, 0) == 0 and HaveNormalItemInQuick(6, 1, 528, 0) == 0) then
        WriteLog("T¹i chç nhËn kinh nghiÖm xuÊt hiÖn Nh©n ngÉu")
        return
    end

    ChangeWorldEventData()
    AwardExp()
    ResetTwelveIdolTask()
end

StarManIndex = {
    [0] = { idx = 0 },
    [1] = { idx = 0 },
    [2] = { idx = 0 },
    [3] = { idx = 0 },
    [4] = { idx = 0 },
    [5] = { idx = 0 },
    [6] = { idx = 0 },
    [7] = { idx = 0 },
    [8] = { idx = 0 },
    [9] = { idx = 0 },
    [10] = { idx = 0 },
    [11] = { idx = 0 },
}

function ChangeWorldEventData()

    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    local nStarManID = GetTaskByte(Task_TwelveIdol, 2)

    StarManIndex[0].idx = GetGlobalValue(227)
    StarManIndex[1].idx = GetNpcTask(StarManIndex[0].idx, 9)
    StarManIndex[2].idx = GetNpcTask(StarManIndex[1].idx, 9)
    StarManIndex[3].idx = GetNpcTask(StarManIndex[2].idx, 9)
    StarManIndex[4].idx = GetNpcTask(StarManIndex[3].idx, 9)
    StarManIndex[5].idx = GetNpcTask(StarManIndex[4].idx, 9)
    StarManIndex[6].idx = GetNpcTask(StarManIndex[5].idx, 9)
    StarManIndex[7].idx = GetNpcTask(StarManIndex[6].idx, 9)
    StarManIndex[8].idx = GetNpcTask(StarManIndex[7].idx, 9)
    StarManIndex[9].idx = GetNpcTask(StarManIndex[8].idx, 9)
    StarManIndex[10].idx = GetNpcTask(StarManIndex[9].idx, 9)
    StarManIndex[11].idx = GetNpcTask(StarManIndex[10].idx, 9)

    if (nGrowth >= 100) then

        if (IsWorldEventExist(4) == 0) then
            CreateWorldEvent(4, 1, 0, nStarManID)
        else
            local nWakeNum = GetWorldEventValue(4, nStarManID + 1) + 1
            SetWorldEventValue(4, nStarManID + 1, nWakeNum)

            if (nWakeNum >= 100 and nWakeNum < 400) then
                local nCount = GetWorldEventProgress(4)
                SetWorldEventProgress(4, nCount + 1)
                SetWorldEventValue(4, nStarManID + 1, 400)
                NpcPolyMorph(StarManIndex[nStarManID].idx, StarManName[nStarManID].soulidx)

                Msg2Player(StarManName[nStarManID].name .. "§· hãa th©n thµnh c«ng")
                WriteLog(StarManName[nStarManID].name .. "§· hãa th©n thµnh c«ng")
                if (nCount + 1 == 12) then
                    WriteLog("§· khëi ®éng B¶n TuyÒn Th¸nh §Þa thµnh c«ng")
                    Msg2Player("§· khëi ®éng B¶n TuyÒn Th¸nh §Þa thµnh c«ng")
                end
            end

        end
    end

end

function AwardExp()
    if (HaveNormalItem(6, 1, 528, 0) == 0 and HaveNormalItemInQuick(6, 1, 528, 0) == 0) then
        WriteLog("T¹i chç nhËn kinh nghiÖm xuÊt hiÖn Nh©n ngÉu")
        return
    end

    if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
        DelNormalItemInQuick(6, 1, 528, 0)
    elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
        DelNormalItem(6, 1, 528, 0)
    end

    RemoveIBBuff(713)

    local nLevel = GetPlayerExtLevel()
    local nExp = 0
    local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
    if (nGrowth <= 50) then
        nExp = nLevel * 12000
    elseif (nGrowth > 50 and nGrowth <= 80) then
        nExp = nLevel * 14000
    elseif (nGrowth > 80 and nGrowth < 100) then
        nExp = nLevel * 16000
    elseif (nGrowth >= 100) then
        nExp = nLevel * 18000
    end

    local logstr = "]"
    if (GetWeekDay() == 3) then
        Msg2Player("NhiÖm vô chñ ®Ò ngµy h«m nay lµ Ê®¶þÈËÅ¼, chóc m­õng ngµi, nhËn ®­îc th­ëng tu vi gÊp ®«i")
        logstr = logstr .. "Chñ ®Ò ngµy"
        local nDoubel = 1
        if (HaveIBBuff(2094) > 0) then
            nDoubel = nDoubel + 1
            CostIBBuff(2094, 1)
            Msg2Player("Do ngµi sö dông Phï nhiÖm vô Chñ ®Ò ngµy-Tiªn Ma, phÇn th­ëng lÇn nµy t¨ng 100%.")
            logstr = logstr .. "+ Phï Chñ ®Ò ngµy Tiªn Ma"
        end
        local nBuffLevel = GetIBBuffLevel(2095) + 1
        if (HaveIBBuff(2095) > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
            nDoubel = nDoubel + nBuffLevel
            Msg2Player("HiÖn trong thêi gian ho¹t ®éng gÊp ®«i chñ ®Ò ngµy Tiªn Ma, nhËn ®­îc phÇn th­ëng lín h¬n.")
            logstr = logstr .. "+2095buff" .. nBuffLevel
        end

        nExp = nExp + math.floor(nExp * nDoubel)
    end

    local nFactExp = AddOwnExtendExp(nExp)
    if (nFactExp < nExp) then
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("Ng­¬i ch­a hoµn thµnh §é KiÕp hoÆc cÊp ®é Nh©n gian qu¸ thÊp, kh«ng thÓ lÜnh héi ®ñ tu vi Tiªn Ma, chØ t¨ng lªn " .. nFactExp .. " ®iÓm")
    else
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
    end
    Talk(1, "no", "C¸m ¬n ng­¬i ®· gióp ta ®¸nh thøc Tinh qu©n, c¸c h¹ sÏ phï hé téc ta v­ît qua kiÕp n¹n nµy! <c=g>" .. nFactExp .. "<c> kinh nghiÖm xin tÆng ng­¬i!")
    WriteLog("[Ê®¶þÈËÅ¼][Kinh nghiÖm: " .. nFactExp .. "/" .. nExp .. logstr)

    TaskNote(1084, -1)
end

function Yes_Awake()
    CloseDialog()

    if (IsCanAwake() == 0) then
        return
    end

    ResetTwelveIdolTaskTime()

    local nNameId = GetStarManNameID()
    SetTaskByte(Task_TwelveIdol, 2, nNameId)

    Roulette(nNameId)
end

function Yes_AwakeAgain()
    local nNameId = GetTaskByte(Task_TwelveIdol, 2)

    nNameId = math.mod(nNameId + 1, 11)
    SetTaskByte(Task_TwelveIdol, 2, nNameId)

    Roulette(nNameId)
end

function Finished()

    if (GetTaskByte(Task_TwelveStarCommon, 1) == 3) then
        freefsbFinishStarMan()
    else
        FinishGetStarManNameID()
    end

    refreshNpcTaskState()

end

function Yes_Reset()
    CloseDialog()

    local i = FindAValidIBItem(8, 711, 2, 0)
    if (i ~= 0) then
        CostIBItem(i)
        Msg2Player("Ng­¬i bÞ trõ <c=yel>1 Tinh qu©n bµi<c>")
        Yes_AwakeAgain()
    elseif (GetCoin() >= GetCostIB(118)) then
        CostCoinByIdx(118)
        Msg2Player("Ng­¬i bÞ trõ <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>")
        Yes_AwakeAgain()
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>Tinh qu©n bµi<c> hoÆc <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>, kh«ng thÓ thiÕt lËp l¹i nhiÖm vô")
    end

end

function No_Reset()
    FinishGetStarManNameID()
end

function FinishGetStarManNameID()
    if (IsCanAwake() == 0) then
        return
    end

    local temp = GetTaskByte(Task_TwelveStarCommon, 3) + 1
    local nDoTwelveNum, addtimes = todayfreetimes(temp)
    if (nDoTwelveNum >= 2 and nDoTwelveNum <= 5) then
        local i = FindAValidIBItem(8, 710, 2, 0)
        if (i ~= 0) then
            CostIBItem(i)
            Msg2Player("Ng­¬i bÞ trõ 1 <c=yel>ThÊt KhiÕu Linh Lung<c>, h«m nay ®· lµ lÇn thø " .. nDoTwelveNum .. "LÇn nhËn nhiÖm vô ThËp nhÞ nh©n ngÉu.")
        elseif (GetCoin() >= GetCostIB(117)) then
            CostCoinByIdx(117)
            Msg2Player("BÞ trõ <c=yel>" .. GetCostDisIB(117) .. " Th«ng B¶o<c>, h«m nay ®· lµ lÇn thø " .. nDoTwelveNum .. "LÇn nhËn nhiÖm vô ThËp nhÞ nh©n ngÉu.")
        else
            Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. GetCostDisIB(117) .. " Th«ng B¶o<c>, kh«ng thÓ nhËn l¹i nhiÖm vô")
            return
        end
    end

    if (nDoTwelveNum == 1) then
        Msg2Player("§©y lµ lÇn thø 1 trong ngµy nhËn nhiÖm vô ThËp nhÞ nh©n ngÉu")
        SetTaskByte(Task_TwelveStarCommon, 3, nDoTwelveNum)
    else
        Msg2Player("H«m nay lµ lÇn thø " .. nDoTwelveNum .. " lÇn nhËn nhiÖm vô ThËp nhÞ nh©n ngÉu")
        SetTaskByte(Task_TwelveStarCommon, 3, temp)
    end

    local nWorldEvent = GetWorldEventProgress(4)
    if (nWorldEvent == 12) then
        if (nDoTwelveNum == 5) then
            SyncBibleState(1084, 3, 1)
        elseif (nDoTwelveNum == 1) then
            SyncBibleState(1084, 2, 1)
        end

        SyncBibleState(1085, 3, 1)
    end

    local nNameId = GetTaskByte(Task_TwelveIdol, 2)

    SetTaskWord(Task_TwelveIdol, 1, 1)
    SetTaskByte(Task_TwelveIdol, 2, nNameId)
    TaskNote(1084, 0, StarManName[nNameId].name, StarManName[nNameId].pos)

    if (GetJusticEvilCredit() > 0) then
        DelNormalItem(3, 427, 0, 0)
        DelNormalItem(3, 427, 0, 0)
    elseif (GetJusticEvilCredit() < 0) then
        DelNormalItem(3, 428, 0, 0)
        DelNormalItem(3, 428, 0, 0)
    end

    local pm = 1000000
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        CostIBBuff(767, 1)
        pm = pm * 0.9
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
        Msg2Player("Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
    elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        PayHelpScore(1)
        pm = pm * 0.9
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney - pm
        WriteLog(GetName() .. "Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
        Msg2Player("Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
    end

    Pay(pm)

    AddNormalItem(6, 1, 527, 0, 1, 0)
    Msg2Player("Theo chØ dÉn t×m ®­îc Tinh qu©n t­¬ng øng vµ gióp YÓn Thóc Di ®¸nh thøc h¾n.")
    TopMessage("NhËn ®­îc <c=yel>Hu©n H­¬ng L­")

    Talk(1, "no", "Xem ra anh hïng vµ <c=g>" .. StarManName[nNameId].name .. "<c> rÊt cã duyªn, h·y gióp ta dïng <c=yel>Hu©n H­¬ng L­<c> ®¸nh thøc h¾n!")
end

function GetStarManNameID()
    if (GetJusticEvilCredit() > 0) then
        local n = math.random(1, 4)
        if (n < 4) then
            local nIdx = math.random(8, 13)
            if (nIdx == 12) then
                nIdx = 0
            elseif (nIdx == 13) then
                nIdx = 1
            end
            return nIdx
        elseif (n == 4) then
            return math.random(2, 7)
        end
    end

    if (GetJusticEvilCredit() < 0) then
        local n = math.random(1, 4)
        if (n == 4) then
            local nIdx = math.random(8, 13)
            if (nIdx == 12) then
                nIdx = 0
            elseif (nIdx == 13) then
                nIdx = 1
            end
            return nIdx
        elseif (n < 4) then
            return math.random(2, 7)
        end
    end

end

function IsCurDay()
    local nAccTime = GetTaskByte(Task_TwelveStarCommon, 2)
    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    if (nAccTime == nNowTime) then
        return 1
    else
        return 0
    end
end

function IsCanReceive()

    local st = "Dò T©m Th¶o"
    local nIsHaveYushang = HaveNormalItem(3, 427, 0, 0)
    local nIsHaveXuming = HaveNormalItem(3, 428, 0, 0)
    local nCash = GetCash()
    local bCredit = GetJusticEvilCredit()

    local pm = 1000000
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        pm = pm * 0.9
    end

    if (bCredit > 0 and nIsHaveYushang >= 2 and nCash >= pm) then
        return 1
    end

    if (bCredit < 0 and nIsHaveXuming >= 2 and nCash >= pm) then
        return 1
    end

    if (GetJusticEvilCredit() < 0) then
        st = "Tôc MÖnh Hoa"
    elseif (GetJusticEvilCredit() > 0) then
        st = "Dò T©m Th¶o"
    end
    Talk(1, "no", "Ho¸n TØnh Tinh qu©n cÇn 2 <c=yel>" .. st .. "<c> §Ó chÕ t¹o <c=yel>Hu©n H­¬ng L­<c>, kh«ng cã ph¸p cô nµy sÏ kh«ng c¶m øng ®­îc víi Tinh qu©n, ngoµi ra cßn cÇn <c=yel>100 v¹n b¹c<c>, ®­¬ng nhiªn, nÕu nh­ ng­¬i cã tr¹ng th¸i nghÜa khÝ, cã thÓ dïng tr¹ng th¸i nghÜa khÝ tiÕt kiÖm 10% b¹c, khi nµo cã ®ñ h·y quay l¹i.")
    return 0
end

function IsCanAwake()

    local st = "Dò T©m Th¶o"
    local nIsHaveYushang = HaveNormalItem(3, 427, 0, 0)
    local nIsHaveXuming = HaveNormalItem(3, 428, 0, 0)
    local nCash = GetCash()
    local bCredit = GetJusticEvilCredit()

    local pm = 1000000
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end

    if (bCredit > 0 and nIsHaveYushang >= 2 and nCash >= pm) then
        return 1
    end

    if (bCredit < 0 and nIsHaveXuming >= 2 and nCash >= pm) then
        return 1
    end

    if (GetJusticEvilCredit() < 0) then
        st = "Tôc MÖnh Hoa"
    elseif (GetJusticEvilCredit() > 0) then
        st = "Dò T©m Th¶o"
    end
    Talk(1, "no", "Ho¸n TØnh Tinh qu©n cÇn 2 <c=yel>" .. st .. "<c> §Ó chÕ t¹o <c=yel>Hu©n H­¬ng L­<c>, kh«ng cã ph¸p cô nµy sÏ kh«ng c¶m øng ®­îc víi Tinh qu©n, ngoµi ra cßn cÇn <c=yel>100 v¹n b¹c<c>, ®­¬ng nhiªn, nÕu nh­ ng­¬i cã tr¹ng th¸i nghÜa khÝ, cã thÓ dïng tr¹ng th¸i nghÜa khÝ tiÕt kiÖm 10% b¹c, khi nµo cã ®ñ h·y quay l¹i.")
    return 0
end

function IsIdolVisible()
    local nStarManTask = GetTaskByte(Task_TwelveIdol, 4)

    if (nStarManTask ~= 0 and nStarManTask ~= 10 and IsCurDay() == 1) then

        return 0
    end

    if (GetPlayerExtLevel() >= 61 and math.abs(GetJusticEvilCredit()) >= 60000) then
        return 1
    end

    return 0
end

function IsStarManVisible()
    local nTask = GetTaskByte(Task_TwelveIdol, 4)

    if (nTask == 10 and IsCurDay() == 1) then

        return 0
    end

    if (nTask == 8 and IsCurDay() == 0) then
        SetTask(Task_TwelveIdol, 0)
    end

    if (GetPlayerExtLevel() >= 66 and math.abs(GetJusticEvilCredit()) >= 80000) then
        return 1
    end

    return 0
end

function no()
    CloseDialog()
end

function RestStarManTaskTime()
    local nAccTime = GetTaskByte(Task_TwelveStarCommon, 2)
    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    if (nAccTime ~= nNowTime) then
        SetTaskByte(Task_TwelveStarCommon, 2, nNowTime)
    else
        Talk(1, "no", "NhiÖm vô Tinh qu©n MËt Gi¸p cÇn liªn tiÕp ®¸nh thøc 6 vÞ Tinh qu©n, hao tèn rÊt nhiÒu ph¸p lùc cña ta, 1 ngµy ta chØ cã thÓ ban cho ng­¬i 1 Phï Ph¸p, h«m nay ng­¬i ®· nhËn 1 lÇn nhiÖm vô råi, mau h·y tiÕp tôc!")
        return
    end
end

function StarMan()
    CloseDialog()

    local nTask = GetTaskByte(Task_TwelveIdol, 4)
    if (nTask == 10) then
        SetTask(Task_TwelveIdol, 0)
        nTask = 0
    end

    if (nTask == 8 and IsCurDay() == 1) then
        Talk(1, "no", "H«m nay ph¸p lùc cña ta tiªu hao qu¸ nhiÒu, kh«ng thÓ ban Phï Ph¸p cho ng­¬i n÷a, ngµy mai quay l¹i nhÐ!")
        return
    end

    if (nTask == 0) then
        MsgBox("<c=g>Tinh qu©n MËt Gi¸p<c> lµ trang bÞ thÇn bÝ ®­îc ThËp NhÞ Tinh qu©n cÊt gi÷, Th¸nh DiÖu, H­ Nghi, Loan Vò ®Òu lµ chÝ b¶o thiªn ®Þa, ng­êi th­êng kh«ng thÓ thu phôc. Sö dông 12 viªn <c=yel>Th¹ch Trung Ngäc<c> chÕ t¹o thµnh.", "Yes_StarMan", "no")
        return
    end

    if (nTask >= 1) then
        local nTwelveIdolTask = GetTaskByte(Task_TwelveIdol, 1)
        local nGrowth = GetTaskByte(Task_TwelveIdol, 3)
        local nStarMan = GetTaskByte(Task_TwelveIdol, 2)

        if (nTwelveIdolTask < 3) then
            Talk(1, "no", "Ng­¬i ch­a hoµn thµnh viÖc ®¸nh thøc <c=g>" .. StarManName[nStarMan].name .. "<c>, ta kh«ng thÓ ®Ó ng­¬i tiÕp tôc chÞu thö th¸ch!")
            return
        end

        if (nGrowth < 100 and (HaveIBBuff(713) == 0 or nTwelveIdolTask == 4 or IsExistItem(6, 1, 528, 0) == 0)) then
            local nItemCount = FindAValidIBItem(8, 711, 2, 0)
            local nCoin = GetCostIB(118)
            if (nItemCount == 0 and GetCoin() < nCoin) then
                Talk(1, "no", "Tuy lÇn nµy ng­¬i ch­a hoµn toµn ®¸nh thøc <c=g>" .. StarManName[nStarMan].name .. "<c> dÉn ®Õn thÊt b¹i, nh­ng nÕu cho ta <c=yel>Tinh qu©n bµi" .. GetCostDisIB(118) .. " Th«ng B¶o<c>, ta cã thÓ dïng phÐp triÖu tËp Tinh qu©n 1 lÇn n÷a ®Ó ®¸nh thøc hä.")
            else
                MsgBox("Tuy lÇn nµy ng­¬i ch­a hoµn toµn ®¸nh thøc <c=g>" .. StarManName[nStarMan].name .. "<c> dÉn ®Õn thÊt b¹i, nh­ng nÕu cho ta <c=yel>Tinh qu©n bµi<c> hoÆc <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>, ta cã thÓ dïng phÐp triÖu tËp Tinh qu©n 1 lÇn n÷a ®Ó ®¸nh thøc hä.", "Yes_GoOnStarMan", "no")
            end

            return
        end

        if (nGrowth < 100 and HaveIBBuff(713) > 0 and nTwelveIdolTask ~= 4 and IsExistItem(6, 1, 528, 0) ~= 0) then
            Talk(1, "no", "Ng­¬i vÉn ch­a hoµn toµn ®¸nh thøc" .. StarManName[nStarMan].name .. ", h·y cè g¾ng h¬n!")
            return
        end

        if (nTwelveIdolTask >= 3 and nGrowth >= 100) then
            NextStarMan()
        end
    end

end

function ResetStarManStep()

    SetTaskByte(Task_TwelveIdol, 1, 1)
    if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
        DelNormalItemInQuick(6, 1, 528, 0)
    elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
        DelNormalItem(6, 1, 528, 0)
    end
    AddNormalItem(6, 1, 527, 0, 1, 0)

    SetTaskByte(Task_TwelveIdol, 3, 0)

    local nStarManNum = GetTaskByte(Task_TwelveIdol, 4)
    local nStarManID = GetTaskByte(Task_TwelveIdol, 2)
    TaskNote(1085, 1, nStarManNum - 1, StarManName[nStarManID].name, StarManName[nStarManID].pos)

end

function Yes_GoOnStarMan()
    CloseDialog()
    local i = FindAValidIBItem(8, 711, 2, 0)
    if (i ~= 0) then
        CostIBItem(i)

        Msg2Player("Ng­¬i bÞ trõ <c=yel>1 Tinh qu©n bµi<c>")
        ResetStarManStep()
    elseif (GetCoin() >= GetCostIB(118)) then
        CostCoinByIdx(118)
        Msg2Player("Ng­¬i bÞ trõ <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>")
        ResetStarManStep()
    else
        Talk(1, "no", "Ng­¬i kh«ng cã <c=yel>Tinh qu©n bµi<c> hoÆc <c=yel>" .. GetCostDisIB(118) .. " Th«ng B¶o<c>, ng­¬i kh«ng thÓ chän l¹i.")
    end

end

function NextStarMan()

    local nWakeCount = GetTaskByte(Task_TwelveIdol, 4)
    if (nWakeCount == 6) then
        Talk(1, "no", "Ng­¬i ®· thµnh c«ng ®¸nh thøc 6 vÞ Tinh qu©n, <c=yel>Th¹ch Trung Ngäc<c> nµy Èn chøa toµn bé søc m¹nh cña Tinh qu©n. Khi ng­¬i thu thËp ®ñ 12 viªn, cã thÓ ®Õn XÝch Tïng Tö chÕ t¹o trang bÞ thÇn kú cña riªng m×nh!")
        AddNormalItem(3, 435, 0, 0, 0, 0)
        TopMessage("NhËn ®­îc 1 <c=yel>Th¹ch Trung Ngäc<c>")

        if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
            DelNormalItemInQuick(6, 1, 528, 0)
        elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
            DelNormalItem(6, 1, 528, 0)
        end
        RemoveIBBuff(713)

        DelNpc(GetTask(Task_FightStarManNpcIdx))
        SetTask(Task_FightStarManNpcID, 0)
        SetTask(Task_FightStarManNpcIdx, 0)

        if (IsCurDay() == 0) then
            SetTaskByte(Task_TwelveIdol, 4, 8)
            SetTask(Task_TwelveIdol, 0)
            SetTaskByte(Task_TwelveStarCommon, 3, 0)
        else
            SetTaskByte(Task_TwelveIdol, 4, 8)
        end

        TaskNote(1085, -1)
        return
    end

    SetTaskByte(Task_TwelveIdol, 4, nWakeCount + 1)
    RemoveIBBuff(713)

    local nCurStarManNpcIdx = GetTask(Task_TwelveIdol_StarManIdx)
    local nNextStarMan = GetNpcTask(nCurStarManNpcIdx, 1)

    SetTask(Task_TwelveIdol_StarManIdx, 0)
    SetTaskByte(Task_TwelveIdol, 1, 1)
    SetTaskByte(Task_TwelveIdol, 3, 0)
    DelNpc(GetTask(Task_FightStarManNpcIdx))
    SetTask(Task_FightStarManNpcID, 0)
    SetTask(Task_FightStarManNpcIdx, 0)

    if (HaveNormalItemInQuick(6, 1, 528, 0) > 0) then
        DelNormalItemInQuick(6, 1, 528, 0)
    elseif (HaveNormalItem(6, 1, 528, 0) > 0) then
        DelNormalItem(6, 1, 528, 0)
    end
    AddNormalItem(6, 1, 527, 0, 1, 0)

    if (GetJusticEvilCredit() > 0) then
        if (nNextStarMan == 8) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Th¸i TuÕ Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 9)
        elseif (nNextStarMan == 9) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>TiÓu Hao Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 10)
        elseif (nNextStarMan == 10) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>DÞch M· Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 11)
        elseif (nNextStarMan == 11) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Ngò Quû Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 0)
        elseif (nNextStarMan == 0) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>§¹i Hao Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 1)
        elseif (nNextStarMan == 1) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Th¸i D­¬ng Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 8)
        end
    end

    if (GetJusticEvilCredit() < 0) then
        if (nNextStarMan == 2) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Thiªn CÈu Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 3)
        elseif (nNextStarMan == 3) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>B¸ch ViÖt Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 4)
        elseif (nNextStarMan == 4) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Tö Vy Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 5)
        elseif (nNextStarMan == 5) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Thiªn §øc Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 6)
        elseif (nNextStarMan == 6) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>Th¸i ¢m Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 7)
        elseif (nNextStarMan == 7) then
            Talk(1, "no", "TiÕp theo ph¶i ®¸nh thøc <c=g>B¹ch Hæ Tinh qu©n<c>.")
            SetTaskByte(Task_TwelveIdol, 2, 2)
        end
    end

    local nStarMan = GetTaskByte(Task_TwelveIdol, 2)
    TaskNote(1085, 1, nWakeCount, StarManName[nStarMan].name, StarManName[nStarMan].pos)
end

function Yes_StarMan()
    CloseDialog()
    local nFairyOrDevil = FairyOrDevil()
    local nCostCoin = GetCostDisIB(117) * 12
    MsgBox("Mçi lÇn Tinh qu©n MËt Gi¸p b¸i tÕ ThËp NhÞ Tinh qu©n, cÇn cã <c=yel>12 ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. nCostCoin .. " Th«ng B¶o<c>, <c=yel>600 v¹n ng©n l­îng<c>vµ <c=yel>24 c©y" .. TwelveStarItem[nFairyOrDevil].name .. "<c>.", "yiqiBuff_1", "no")
end

function yiqiBuff_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        MsgBox("Ng­¬i cã thÓ dïng 1 <c=g>tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 ®iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ng­¬i cã ®ång ý sö dông kh«ng?", "costYiqi_1", "Yes_DoStarMan")
    else
        Yes_DoStarMan()
    end
end

function costYiqi_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        Yes_DoStarMan()
    else
        Talk(1, "no", "Xin lçi! B¹n kh«ng cã tr¹ng th¸i nghÜa khÝ hoÆc ®iÓm nh©n nghÜa.")
    end
end

function DeliverMaterial(nFairyOrDevil)
    CloseDialog()

    local nCostCoin = GetCostDisIB(117) * 12

    local pm = 6000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end

    local nItemNum = HaveNormalItem(8, 710, 2, 0)
    local nCoinNum = 12 - nItemNum
    if (GetCoin() < GetCostIB(117) * nCoinNum) then

        Talk(1, "no", "Mçi lÇn Tinh qu©n MËt Gi¸p b¸i tÕ ThËp NhÞ Tinh qu©n, cÇn cã <c=yel>12 ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. nCostCoin .. "Th«ng B¶o<c>, <c=yel>" .. pm .. "TiÒn<c> vµ <c=yel>24 " .. TwelveStarItem[nFairyOrDevil].name .. "<c>. B¹n kh«ng ®ñ ThÊt KhiÕu Linh Lung.")
        return 0
    end

    if (HaveNormalItem(3, TwelveStarItem[nFairyOrDevil].idx, 0, 0) < 24) then
        Talk(1, "no", "Mçi lÇn Tinh qu©n MËt Gi¸p b¸i tÕ ThËp NhÞ Tinh qu©n, cÇn cã <c=yel>12 ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. nCostCoin .. "Th«ng B¶o<c>, <c=yel>" .. pm .. "TiÒn<c> vµ <c=yel>24 " .. TwelveStarItem[nFairyOrDevil].name .. "<c>. B¹n kh«ng cã ®ñ <c=yel>" .. TwelveStarItem[nFairyOrDevil].name .. "<c> 24 c¸i")
        return 0
    end

    if (GetCash() < pm) then
        Talk(1, "no", "Mçi lÇn Tinh qu©n MËt Gi¸p b¸i tÕ ThËp NhÞ Tinh qu©n, cÇn cã <c=yel>12 ThÊt KhiÕu Linh Lung<c> hoÆc <c=yel>" .. nCostCoin .. "Th«ng B¶o<c>, <c=yel>" .. pm .. "TiÒn<c> vµ <c=yel>24 " .. TwelveStarItem[nFairyOrDevil].name .. "<c>. TiÒn trªn ng­êi kh«ng ®ñ " .. pm .. " b¹c")
        return 0
    end

    local itemID = 0
    local nCostNum = 0
    for i = 1, nItemNum do
        itemID = FindAValidIBItem(8, 710, 2, 0)
        if (itemID > 0) then
            CostIBItem(itemID)
            nCostNum = nCostNum + 1
        end
    end

    for i = 1, (12 - nCostNum) do
        CostCoinByIdx(117)
    end

    for i = 1, 24 do
        DelNormalItem(3, TwelveStarItem[nFairyOrDevil].idx, 0, 0)
    end

    if (GetCash() >= pm) then
        Pay(pm)

        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô Tinh Qu©n MËt Gi¸p" .. change .. ".")
            Msg2Player("Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô Tinh Qu©n MËt Gi¸p" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            local change = lastMoney - pm
            WriteLog(GetName() .. "Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô Tinh Qu©n MËt Gi¸p" .. change .. ".")
            Msg2Player("Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô Tinh Qu©n MËt Gi¸p" .. change .. ".")
        end

    end

    RestStarManTaskTime()

    SetTaskByte(Task_TwelveIdol, 4, 1)

    SetTaskByte(Task_TwelveIdol, 1, 1)
    SetTask(Task_TwelveIdol_StarManIdx, 0)

    AddNormalItem(6, 1, 527, 0, 1, 0)
    Msg2Player("Theo chØ dÉn t×m ®­îc Tinh qu©n t­¬ng øng vµ gióp YÓn Thóc Di ®¸nh thøc h¾n.")
    TopMessage("NhËn ®­îc <c=yel>Hu©n H­¬ng L­")

    local nWorldEvent = GetWorldEventProgress(4)
    if (nWorldEvent == 12) then
        SyncBibleState(1084, 3, 1)
        SyncBibleState(1085, 3, 1)
    end

    return 1
end

function Yes_DoStarMan()
    CloseDialog()
    local nFairyOrDevil = FairyOrDevil()

    if (DeliverMaterial(nFairyOrDevil) == 0) then
        return
    end

    if (GetJusticEvilCredit() > 0) then

        TaskNote(1085, 0, StarManName[8].name, StarManName[9].name, StarManName[10].name, StarManName[11].name, StarManName[0].name, StarManName[1].name, StarManName[8].name, StarManName[8].pos)
        SetTaskByte(Task_TwelveIdol, 2, 8)
        Talk(1, "no", "<c=yel>Th¹ch Trung Ngäc<c> Èn chøa søc m¹nh cña c¸c Tinh qu©n, nÕu muèn cã ®­îc nã, ng­¬i ph¶i lÇn l­ît ®¸nh thøc 6 vÞ Tinh qu©n thuéc phe m×nh.")

    end

    if (GetJusticEvilCredit() < 0) then

        TaskNote(1085, 0, StarManName[2].name, StarManName[3].name, StarManName[4].name, StarManName[5].name, StarManName[6].name, StarManName[7].name, StarManName[2].name, StarManName[2].pos)
        SetTaskByte(Task_TwelveIdol, 2, 2)
        Talk(1, "no", "<c=yel>Th¹ch Trung Ngäc<c> Èn chøa søc m¹nh cña c¸c Tinh qu©n, nÕu muèn cã ®­îc nã, ng­¬i ph¶i lÇn l­ît ®¸nh thøc 6 vÞ Tinh qu©n thuéc phe m×nh.")

    end

end

function reset_soul_tasktime()

    local nAccTime = GetTaskByte(TASK_SOUL, 3)
    local nNowTime = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    if (nAccTime ~= nNowTime) then
        SetTaskByte(TASK_SOUL, 2, 0)
        SetTaskByte(TASK_SOUL, 3, nNowTime)
    end

end

function soul_backhome()

    CloseDialog()

    reset_soul_tasktime()

    local nState = GetTaskByte(TASK_SOUL, 1)
    local nAcceptCount = GetTaskByte(TASK_SOUL, 2)

    if (nState == SOUL_TASK_CAMP_EVIL) then

        Talk(1, "no", "C¸c h¹ ®· høa gióp YÓn Tö Minh <c=g>TÜnh Hãa Vong Hån<c>, nh»m gióp téc ta kÕt b¹n víi Ma giíi, sao ph¶i ®Õn gÆp ta bµn b¹c? Nh­ng nÕu ng­¬i ®· tØnh ngé, muèn gãp søc vun vÐn t×nh c¶m gi÷a téc ta vµ Tiªn giíi, ta sÏ mÆc qua chuyÖn cò, ñy th¸c viÖc gi¶i cøu hån ph¸ch téc nh©n cho ng­¬i, nÕu thµnh c«ng ta sÏ ®em chuyÖn cña ng­¬i ca tông kh¾p Tiªn giíi!")

    elseif (nState == SOUL_TASK_CAMP_JUSTICE) then

        local nSoulCount = HaveEffectNpc(SOUL_NPC_TEMPLETE)

        if (nSoulCount > 0) then
            MsgBox("Téc Di Ph­¬ng ta kh«ng mµng thÕ sù, Èn c­ n¬i nµy mµ vÉn bÞ tai v¹. May nhê c¸c h¹ ra tay t­¬ng trî, hån ph¸ch téc nh©n míi ®­îc trë vÒ cè h­¬ng. Kh«ng biÕt c¸c h¹ cã thÓ giao c¸c hån ph¸ch gi¶i cøu ®­îc cho ta, ®Ó téc nh©n th¾p nhang siªu ®é.", "complete_soul_task", "no")
        else
            MsgBox("Ta biÕt viÖc gi¶i cøu hån ph¸ch kh«ng ph¶i dÔ, nÕu muèn bá dë còng kh«ng sao. Tuy c¸c h¹ ch­a thÓ ®­a hån ph¸ch téc nh©n ta vÒ cè h­¬ng, nh­ng tÊm lßng hiÖp nghÜa t¹i h¹ xin ghi nhËn. X¸c ®Þnh muèn <c=g>hñy<c>?", "cancel_soul_task", "no")
        end

    else

        if (nAcceptCount == 0) then
            MsgBox("GÇn ®©y Ngôc Ph¸p S¬n liªn tôc x¶y ra chuyÖn l¹, rÊt nhiÒu téc nh©n ®i l¹i trong nói bÞ Tµ Ma mª hoÆc lµm mÊt t©m trÝ, trë thµnh con rèi. Téc tr­ëng rÊt phiÒn lßng, nÕu c¸c h¹ chÞu ra tay gióp ®ì, ®­a hån ph¸ch ng­êi chÕt trë cè h­¬ng ®Ó ®­îc gi¶i tho¸t, ch¾c ch¾n sÏ gióp Ých cho liªn minh gi÷a téc ta vµ Tiªn giíi, danh väng cña c¸c h¹ còng ®­îc t¨ng lªn. Kh«ng biÕt ý ng­¬i thÕ nµo?", "accept_soul_task", "no")
        else
            local i = FindAValidIBItem(8, SOUL_TASK_IB_ITEM, 2, 0)
            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(SOUL_TASK_IB_INDEX)

            if (i > 0) or (GetCoin() >= Cv) then
                MsgBox("Sù viÖc quan hÖ ®Õn sù tån vong cña téc Di Ph­¬ng, nªn ph­¬ng thuèc dïng ®Ó chÕ t¹o TØnh ThÇn §¬n do téc tr­ëng ®Ých th©n cÊt gi÷, hiÖn ta còng ch¼ng cßn lµ bao. NÕu muèn chÕ ®¬n d­îc míi, ph¶i giao cho ta 1 <c=g>TÝn hµm bé téc<c> hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, ®Ó lµm b»ng chøng nhËn thuèc víi téc tr­ëng. Ng­¬i <c=g>x¸c ®Þnh<c> giao <c=g>TÝn hµm bé téc<c> hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o cho ta chø?", "accept_soul_task_ib", "no")
            else
                Talk(1, "no", "Sù viÖc quan hÖ ®Õn sù tån vong cña téc Di Ph­¬ng, nªn ph­¬ng thuèc dïng ®Ó chÕ t¹o TØnh ThÇn §¬n do téc tr­ëng ®Ých th©n cÊt gi÷, hiÖn ta còng ch¼ng cßn lµ bao. NÕu muèn chÕ ®¬n d­îc míi, ph¶i giao cho ta 1 <c=g>TÝn hµm bé téc<c> hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, ®Ó lµm b»ng chøng nhËn thuèc víi téc tr­ëng.")
            end
        end

    end

end

function complete_soul_task()

    CloseDialog()

    local nSoulCount = HaveEffectNpc(SOUL_NPC_TEMPLETE)
    local nCredit = GetJusticEvilCredit()
    local nCamp = 1
    if (nCredit < 0) then
        nCamp = 2
    end

    if (nSoulCount < 1) then
        nSoulCount = 1
    elseif (nSoulCount > 5) then
        nSoulCount = 5
    end

    local nAward = aryCreditAward[SOUL_TASK_CAMP_JUSTICE][nCamp][nSoulCount]
    local nOriAward = aryCreditAward[SOUL_TASK_CAMP_JUSTICE][SOUL_TASK_CAMP_JUSTICE][nSoulCount]

    if (nCamp == SOUL_TASK_CAMP_JUSTICE) then
        MsgBox("ChuyÕn nµy c¸c h¹ ®· gióp bé l¹c Di Ph­¬ng t×m vÒ <c=g>" .. nSoulCount .. "<c> hån ph¸ch téc nh©n (Tèi ®a lµ 5 hån ph¸ch téc nh©n), nÕu chuyÓn giao cho t¹i h¹ ngay th× uy danh cña c¸c h¹ trong Tiªn giíi sÏ t¨ng <c=g>" .. nAward .. "<c> ®iÓm, x¸c ®Þnh tr¶ hån ph¸ch cho ta?", "complete_soul_task_fin", "no")
    else
        MsgBox("ChuyÕn nµy c¸c h¹ ®· gióp bé l¹c Di Ph­¬ng t×m vÒ <c=g>" .. nSoulCount .. "<c> hån ph¸ch téc nh©n (Tèi ®a lµ 5 hån ph¸ch téc nh©n), nÕu chuyÓn giao cho t¹i h¹ ngay th× uy danh cña c¸c h¹ trong Tiªn giíi sÏ t¨ng <c=g>" .. nOriAward .. "<c> ®iÓm, nh­ng v× ng­¬i ®ang trong Ma giíi, do ®ã danh väng nhËn ®­îc sÏ bÞ xung kh¾c, danh väng Ma giíi sÏ gi¶m ®i <c=g>" .. nAward .. "<c> ®iÓm, x¸c ®Þnh tr¶ hån ph¸ch cho ta?", "complete_soul_task_fin", "no")
    end

end

function accept_soul_task()

    CloseDialog()

    local nItemCount = HaveNormalItem(3, SOUL_ACC_ITEM_J, 0, 0)
    if (nItemCount < ACC_ITEM_COUNT) then
        Talk(1, "no", "NÕu muèn gi¶i cøu hån ph¸ch cña téc nh©n mª thÊt t©m trÝ, ph¶i sö dông TØnh ThÇn §¬n víi hä míi cã thÓ tiÕn hµnh. NÕu c¸c h¹ cho ta <c=g>5 viªn<c> <c=g>Tôc MÖnh Hoa<c> mµ TiÒn Phong Ma giíi hay mang trong ng­êi, cã thÓ kÕt hîp víi ph­¬ng thuèc cña téc ta chÕ thµnh thuèc gi¶i cøu hån ph¸ch. Nh­ng c¸c h¹ vÉn ch­a chuÈn bÞ ®ñ, ®îi khi mäi thø s½n sµng h·y ®Õn t×m ta.")
        return
    end

    MsgBox("NÕu muèn gi¶i cøu hån ph¸ch téc ng­êi Mª ThÊt T©m TrÝ, tr­íc tiªn cÇn cho hä sö dông TØnh ThÇn §¬n TÞnh Hãa hä míi cã hy väng. Trªn ng­êi Tiªn Phong Ma Giíi cã lo¹i <c=g>Tôc MÖnh Hoa<c> rÊt cã hiÖu qu¶ víi viÖc tÞnh t©m tØnh trÝ, c¸c h¹ nÕu nh­ cã thÓ mang cho ta <c=g>5 ®ãa<c>, ta sÏ mang chóng chÕ biÕn thµnh thuèc gi¶i cøu hån ph¸ch cÇn thiÕt. Ng­¬i <c=g>x¸c ®Þnh<c> giao cho ta chø?", "accept_soul_task_fin", "no")

end

function accept_soul_task_ib()

    CloseDialog()

    local nItemCount = HaveNormalItem(3, SOUL_ACC_ITEM_J, 0, 0)
    if (nItemCount < ACC_ITEM_COUNT) then
        Talk(1, "no", "NÕu muèn gi¶i cøu hån ph¸ch cña téc nh©n mª thÊt t©m trÝ, ph¶i sö dông TØnh ThÇn §¬n víi hä míi cã thÓ tiÕn hµnh. NÕu c¸c h¹ cho ta <c=g>5 viªn<c> <c=g>Tôc MÖnh Hoa<c> mµ TiÒn Phong Ma giíi hay mang trong ng­êi, cã thÓ kÕt hîp víi ph­¬ng thuèc cña téc ta chÕ thµnh thuèc gi¶i cøu hån ph¸ch. Nh­ng c¸c h¹ vÉn ch­a chuÈn bÞ ®ñ, ®îi khi mäi thø s½n sµng h·y ®Õn t×m ta.")
        return
    end

    MsgBox("NÕu muèn gi¶i cøu hån ph¸ch téc ng­êi Mª ThÊt T©m TrÝ, tr­íc tiªn cÇn cho hä sö dông TØnh ThÇn §¬n TÞnh Hãa hä míi cã hy väng. Trªn ng­êi Tiªn Phong Ma Giíi cã lo¹i <c=g>Tôc MÖnh Hoa<c> rÊt cã hiÖu qu¶ víi viÖc tÞnh t©m tØnh trÝ, c¸c h¹ nÕu nh­ cã thÓ mang cho ta <c=g>5 ®ãa<c>, ta sÏ mang chóng chÕ biÕn thµnh thuèc gi¶i cøu hån ph¸ch cÇn thiÕt. Ng­¬i <c=g>x¸c ®Þnh<c> giao cho ta chø?", "accept_soul_task_ib_fin", "no")

end

function clear_soul_task_state()

    SetTaskByte(TASK_SOUL, 1, 0)
    RemoveIBBuff(SOUL_TASK_BUFF)
    ClearItem(8, SOUL_TASK_ITEM_1, 2, 0)
    ClearItem(8, SOUL_TASK_ITEM_2, 2, 0)
    ClearEffectNpc()
    TaskNote(1082, -1)

end

function cancel_soul_task()

    CloseDialog()

    clear_soul_task_state()

    Msg2Player("§· hñy bá nhiÖm vô Hån Quy Cè Lý.")
    Talk(1, "no", "Tuy c¸c h¹ tù chän lùa tõ bá, nh­ng víi ta lu«n kh©m phôc ®øc tÝnh hµnh thiÖn cña c¸c h¹, sau nµy nÕu cã viÖc cÇn ®Õn ta cø ®Õn giao b¶o, ta sÏ hÕt lßng gióp ®ì!")

end

function check_soul_accept_condition()

    local nAbsCredit = math.abs(GetJusticEvilCredit())

    if (nAbsCredit >= CREDIT_LIMIT_MAX) and (IsJEMainTaskComplete(3) == 0) then
        Talk(1, "no", "Danh tiÕng c¸c h¹ vang väng c¶ thiªn giíi lÉn nh©n gian, nh­ng nÕu ch­a tõng ®é kiÕp ta e r»ng khã cã ®ét ph¸ lín! ViÖc t­¬ng trî cã thÓ t¹m g¸c qua bªn, c¸c h¹ nªn dån hÕt t©m trÝ vµo viÖc ®é kiÕp, ®îi sau nµy c¸c h¹ hoµn thµnh øng ®é thiªn kiÕp h·y ®Õn gióp ta vÉn ch­a muén!")
        return 0
    end

    if (nAbsCredit < CREDIT_LIMIT_MIN) or (IsJEMainTaskComplete(2) == 0) then
        Talk(1, "no", "ChuyÖn gi¶i cøu hån kh«ng ph¶i lµ chuyÖn ®ïa, nÕu cã s¬ suÊt sÏ mÊt m¹ng! H·y bá qua cho t¹i h¹ nãi th¼ng, c¸c h¹ tuy cã chót tiÕng t¨m, nh­ng e lµ khã cã thÓ hoµn thµnh nhiÖm vô, h·y ®îi khi ng­¬i ®¹t danh väng <c=g>45000 ®iÓm<c> hoÆc sau khi tr¶i qua 50 cÊp ®é kiÕp, ta sÏ an t©m ®Ó ng­¬i gióp ®ì!")
        return 0
    end

    local nAcceptCount = GetTaskByte(TASK_SOUL, 2)
    if (nAcceptCount >= SOUL_MAX_ACC_TIMES) then
        Talk(1, "no", "H«m nay c¸c h¹ hé tèng hån ph¸ch vÒ bé l¹c ®· nhiÒu, téc ta c¶m kÝch mu«n phÇn! c¸c h¹ chí qu¸ lao t©m tæn h¹i ®Õn thÓ lùc, viÖc gi¶i cøu hån ph¸ch h«m nay ®Õn ®©y chÊm døt, mêi c¸c h¹ quay vÒ nghÜ ng¬i lÊy søc, ngµy mai h·y ®Õn gióp ta vÉn ch­a muén.")
        return 0
    end

    local nItemCount = HaveNormalItem(3, SOUL_ACC_ITEM_J, 0, 0)
    if (nItemCount < ACC_ITEM_COUNT) then
        Talk(1, "no", "V× <c=g>Tôc MÖnh Hoa<c> trong hµnh trang cña c¸c h¹ kh«ng ®ñ <c=g>5 ®ãa<c>, nªn ta kh«ng thÓ ®iÒu chÕ TØnh ThÇn §¬n, chuÈn bÞ ®Çy ®ñ h·y ®Õn t×m ta.")
        return 0
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        Talk(1, "no", "V× kh«ng gian trong hµnh trang c¸c h¹ kh«ng ®ñ nªn kh«ng thÓ giao c¸c h¹ TØnh ThÇn §¬n, chuÈn bÞ tháa ®¸ng h·y ®Õn t×m ta.")
        return 0
    end

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "V× sè l­îng tr¹ng th¸i c¸c h¹ mang trªn ng­êi ®· ®¹t giíi h¹n, v× thÓ ta kh«ng thÓ mang viÖc gi¶i cøu hån ph¸ch ñy th¸c ®Õn ngµi, chuÈn bÞ kü l­ìng h·y ®Õn t×m ta.")
        return 0
    end

    if (GetGlobalValueByte(Global_War_Event_State, 2) ~= 0) then
        Talk(1, "no", "TiÒn phong hai giíi tiªn ma ®ang chiÕn ®Êu quyÕt liÖt, ta kh«ng cßn thêi gian ®Ó lo nh÷ng viÖc kh¸c, c¸c h¹ xin chê trong gi©y l¸t, ®îi sau khi hai giíi ph©n th¾ng b¹i, ta sÏ trao ®æi víi ng­¬i vÒ viÖc <c=g>Hån Quy Cè Lý<c>!")
        return 0
    end

    local nSoulCount = HaveEffectNpc(-1)
    if (nSoulCount > 0) then
        if HaveIBBuff(649) > 0 then
            Talk(1, "no", "rÊt xin lçi, c¸c h¹ hiÖn ®ang tham gia ho¹t ®éng <c=g>Khiªu chiÕn cùc h¹n<c>, v× thÕ ta kh«ng thÓ ñy th¸c viÖc gi¶i cøu hån ph¸ch ®Õn ngµi, xin c¸c h¹ quay l¹i sau.")
            return 0
        else
            ClearEffectNpc()
        end
    end

    local nCamp = GetCamp()
    if (nCamp == 8) then
        Talk(1, "no", "Tªn ®á kh«ng thÓ nhËn nhiÖm vô.")
        return 0
    end

    return 1

end

aryMonsterRank = {
    {
        {
            lvMin = 0,
            lvMax = 55,
            aryMonster = {
                { ntype = 1, rate = 100 },
            },
        },
        {
            lvMin = 56,
            lvMax = 60,
            aryMonster = {
                { ntype = 1, rate = 40 },
                { ntype = 4, rate = 100 },
            },
        },
        {
            lvMin = 61,
            lvMax = 65,
            aryMonster = {
                { ntype = 4, rate = 40 },
                { ntype = 2, rate = 100 },
            },
        },
        {
            lvMin = 66,
            lvMax = 200,
            aryMonster = {
                { ntype = 1, rate = 20 },
                { ntype = 4, rate = 50 },
                { ntype = 2, rate = 100 },
            },
        },
    },
    {
        {
            lvMin = 0,
            lvMax = 55,
            aryMonster = {
                { ntype = 1, rate = 100 },
            },
        },
        {
            lvMin = 56,
            lvMax = 60,
            aryMonster = {
                { ntype = 1, rate = 40 },
                { ntype = 3, rate = 100 },
            },
        },
        {
            lvMin = 61,
            lvMax = 65,
            aryMonster = {
                { ntype = 3, rate = 40 },
                { ntype = 2, rate = 100 },
            },
        },
        {
            lvMin = 66,
            lvMax = 200,
            aryMonster = {
                { ntype = 1, rate = 20 },
                { ntype = 3, rate = 50 },
                { ntype = 2, rate = 100 },
            },
        },
    },
}

aryMonsterType = {
    { name = "Thõa Hoµng", id = 930 },
    { name = "KhØ nói", id = 933 },
    { name = "Tiªn-Lª Linh Thi", id = 931 },
    { name = "Ma-Lª Linh Thi", id = 932 },
}

function random_monster()

    local nLevel = GetPlayerExtLevel()
    local nType = 1

    for i = 1, table.getn(aryMonsterRank[SOUL_TASK_CAMP_JUSTICE]), 1 do

        if (nLevel >= aryMonsterRank[SOUL_TASK_CAMP_JUSTICE][i].lvMin) and (nLevel <= aryMonsterRank[SOUL_TASK_CAMP_JUSTICE][i].lvMax) then

            local nRank = math.random(1, 100)
            for j = 1, table.getn(aryMonsterRank[SOUL_TASK_CAMP_JUSTICE][i].aryMonster), 1 do

                if (nRank <= aryMonsterRank[SOUL_TASK_CAMP_JUSTICE][i].aryMonster[j].rate) then
                    nType = aryMonsterRank[SOUL_TASK_CAMP_JUSTICE][i].aryMonster[j].ntype
                    break
                end

            end

        end

    end

    SetTaskByte(TASK_SOUL, 4, nType)

end

function do_accept_soul()

    random_monster()

    AddIBBuff(SOUL_TASK_BUFF)
    SetTaskByte(TASK_SOUL, 1, SOUL_TASK_CAMP_JUSTICE)
    SetCamp(3)

    for i = 1, ACC_ITEM_COUNT, 1 do
        DelNormalItem(3, SOUL_ACC_ITEM_J, 0, 0)
    end

    local nAcceptCount = GetTaskByte(TASK_SOUL, 2)
    local nType = GetTaskByte(TASK_SOUL, 4)
    local szMonster = aryMonsterType[nType].name

    SetTaskByte(TASK_SOUL, 2, nAcceptCount + 1)
    LockEffectNpc()

    if (GetGlobalValueByte(Global_War_Event_State, 1) == SOUL_TASK_CAMP_JUSTICE) then
        Msg2Player("Téc ng­êi di ph­¬ng trµ trén t¹i" .. szMonster .. " bªn trong, sö dông Thøc ThÇn Lé cã thÓ TÞnh Hãa hä.")
        Talk(2, "no", "V× t­íng sÜ tiªn phong cña Tiªn giíi giµnh ®­îc tiªn c¬ trong trËn chiÕn <c=g>Ngôc Ph¸p Phong Yªn<c>, téc tr­ëng v« cïng tin t­ëng nh©n sÜ Tiªn giíi, v× thÕ ®· cho phÐp ta sö dông ®¬n d­îc cã phÈm chÊt tèt ®Ó ®Òu chÕ <c=g>Thøc ThÇn Lé<c>, mong ng­¬i gi÷ kü.", "Ngoµi ra ta nghe nãi, Téc ng­êi di ph­¬ng ®ã hiÖn ®ang trµ trén t¹i <c=red>" .. szMonster .. "<c>, tr­íc tiªn c¸c h¹ cÇn sö dông <c=g>ThøcThÇn Lé<c> gi¶i trõ Tµ Ma Cæ HoÆc, sau ®ã tiªu diÖt chóng lµ cã thÓ khiÕn hån ph¸ch cña téc nh©n ta ®­îc gi¶i tho¸t.")
        AddNormalItem(8, SOUL_TASK_ITEM_2, 2, 0, 0, 0)
        TaskNote(1082, 0, szMonster, "Thøc ThÇn Lé")
    else
        Msg2Player("Téc ng­êi di ph­¬ng trµ trén t¹i" .. szMonster .. " , sö dông thøc thÇn thñy cã thÓ TÞnh Hãa hä.")
        Talk(2, "no", "V× t­íng sÜ tiªn phong cña Tiªn giíi biÓu hiÖn suy nh­îc trong trËn chiÕn <c=g>Ngôc Ph¸p Phong Yªn<c>, téc tr­ëng cã phÇn nghi ng¹i ®Õn kh¶ n¨ng nh©n sÜ Tiªn giíi, v× thÕ ®· cho ta sö dông ®¬n d­îc h¹n chÕ th¶m h¹i, nªn chØ ®Òu chÕ ®­îc 1 <c=g>Thøc ThÇn Thñy<c> th«i, h·y gi÷ lÊy.", "Ngoµi ra ta nghe nãi, Téc ng­êi di ph­¬ng ®ã hiÖn ®ang trµ trén t¹i <c=red>" .. szMonster .. "<c> bªn trong, tr­íc tiªn c¸c cÇn sö dông <c=g>Thøc ThÇn Thñy<c> gi¶i trõ Tµ Ma Cæ HoÆc, sau ®ã tiªu diÖt chóng lµ cã thÓ khiÕn hån ph¸ch cña téc nh©n ta ®­îc gi¶i tho¸t.")
        AddNormalItem(8, SOUL_TASK_ITEM_1, 2, 0, 0, 0)
        TaskNote(1082, 0, szMonster, "Thøc ThÇn Thñy")
    end

end

function accept_soul_task_fin()

    CloseDialog()

    if (check_soul_accept_condition() == 0) then
        return
    end

    do_accept_soul()

end

function accept_soul_task_ib_fin()

    CloseDialog()

    if (check_soul_accept_condition() == 0) then
        return
    end

    local i = FindAValidIBItem(8, SOUL_TASK_IB_ITEM, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(SOUL_TASK_IB_INDEX)

    if (i > 0) then
        CostIBItem(i)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(SOUL_TASK_IB_INDEX)
    else
        Talk(1, "no", "V× c¸c h¹ ch­a giao ta 1 <c=g>Bé Téc TÝn Hµm<c> hoÆc <c=g>" .. Cfs .. "<c> tiªn ®ång, v× thÕ xin c¸c h¹ chuÈn bÞ kü l­ìng h·y ®Õn t×m ta.")
        return
    end

    do_accept_soul()

end

aryCreditAward = {
    {
        {
            10,
            25,
            40,
            60,
            90,
        },
        {
            40,
            100,
            160,
            240,
            360,
        },
    },
    {
        {
            40,
            100,
            160,
            240,
            360,
        },
        {
            10,
            25,
            40,
            60,
            90,
        },
    },
}

function complete_soul_task_fin()

    CloseDialog()

    local nSoulCount = HaveEffectNpc(SOUL_NPC_TEMPLETE)
    local nCredit = GetJusticEvilCredit()
    local nCamp = 1
    if (nCredit < 0) then
        nCamp = 2
    end

    if (nSoulCount < 1) then
        nSoulCount = 1
    elseif (nSoulCount > 5) then
        nSoulCount = 5
    end

    local nAward = aryCreditAward[SOUL_TASK_CAMP_JUSTICE][nCamp][nSoulCount]

    ChangeJusticEvilCredit(nAward)

    local PetTyte = PetGetType()
    if (PetTyte == 138 and HaveIBBuff(2090) > 0) or (PetTyte == 148 and HaveIBBuff(2125) > 0) then
        ChangeJusticEvilCredit(nAward)
        Msg2Player("Íê³É»ê¹é¹ÊÀï, Phi Th¨ng-Th¸i ÊtÎªÄú¶îÍâËÍÀ´" .. nAward .. " ®iÓm Danh väng Tiªn Ma")
    end

    clear_soul_task_state()
    SetTaskByte(TASK_SOUL, 4, 0)

    local nAward = aryCreditAward[SOUL_TASK_CAMP_JUSTICE][nCamp][nSoulCount]
    local nOriAward = aryCreditAward[SOUL_TASK_CAMP_JUSTICE][SOUL_TASK_CAMP_JUSTICE][nSoulCount]

    if (nCamp == SOUL_TASK_CAMP_JUSTICE) then
        Talk(1, "no", "C¸c h¹ ®· gióp téc ta t×m vÒ <c=g>" .. nSoulCount .. "<c> hån ph¸ch cña téc nh©n ®· siªu ®é quy thiªn, ¬n nµy ta kh¾c ghi trong lßng! Ngoµi ra chiÕn c«ng c¸c h¹ gióp bé téc ta thuËn lîi liªn minh víi tiªn giíi ®· vang kh¾p th­îng giíi, danh väng Tiªn giíi cña cac h¹ còng ®· ®­îc n©ng cao <c=g>" .. nAward .. "<c> ®iÓm.")
        Msg2Player("§· hoµn thµnh nhiÖm vô Hån Quy Cè Lý, nhËn ®­îc " .. nAward .. "Danh väng Tiªn giíi")
    else
        Talk(1, "no", "C¸c h¹ ®· gióp téc ta t×m vÒ <c=g>" .. nSoulCount .. "<c> hån ph¸ch téc nh©n ®· ®­îc siªu ®é quy thiªn, ¬n nµy ta kh¾c ghi trong lßng! ChiÕn c«ng c¸c h¹ gióp bé téc ta thuËn lîi liªn minh víi quý giíi ®· vang kh¾p Tiªn giíi, danh väng Tiªn giíi cña c¸c h¹ còng ®· ®­îc n©ng cao <c=g>" .. nAward .. "<c> ®iÓm, nh­ng v× c¸c h¹ lµ ng­êi trong Ma giíi nªn danh väng Ma giíi ®· gi¶m <c=g>" .. nAward .. "<c> ®iÓm.")
        Msg2Player("§· hoµn thµnh nhiÖm vô Hån Quy Cè Lý, nhËn ®­îc " .. nAward .. "Danh väng Tiªn giíi")
    end

end

function no()
    CloseDialog()
end;

function GodofHell()
    CloseDialog()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", "Tr¹ng th¸i trªn ng­êi c¸c h¹ qu¸ nhiÒu.")
        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 3) then
        TopMessage("NhiÖm vô hoµn thµnh")
        ClearItem(6, 1, 525, 0)

        local nFactExp = AddOwnExtendExp(6000000)
        Talk(1, "no", "§a t¹ anh hïng ®· cøu bé l¹c ta trong lóc nguy khèn! §å phæ ph¸p khÝ lµ bÝ mËt ngh×n n¨m cña bé l¹c ta, chØ cã ng­êi tµi kÕ thõa søc m¹nh cña Tinh Qu©n míi cã thÓ sö dông, giê ta xin tÆng cho anh hïng thay cho tÊm lßng thµnh cña ta!")
        Msg2Player("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. math.floor(nFactExp) .. " ®iÓm")
        if (GetJusticEvilCredit() > 0) then
            Msg2Player("NhËn ®­îc ®å phæ Thanh Liªn Ph¸p khÝ")
            if (GetPlayerType() == 0) then
                AddNormalItem(6, 1, 551, 0, 0, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(6, 1, 552, 0, 0, 0)
            elseif (GetPlayerType() == 2) then
                AddNormalItem(6, 1, 553, 0, 0, 0)
            end
        else
            Msg2Player("NhËn ®­îc ®å phæ Hång Liªn Ph¸p khÝ")
            if (GetPlayerType() == 0) then
                AddNormalItem(6, 1, 554, 0, 0, 0)
            elseif (GetPlayerType() == 1) then
                AddNormalItem(6, 1, 555, 0, 0, 0)
            elseif (GetPlayerType() == 2) then
                AddNormalItem(6, 1, 556, 0, 0, 0)
            end

        end

        SetTaskByte(g_HellGod, 1, 5)
        refreshNpcTaskState()
        SetSubTask(111, -1, 1)
        TaskNote(111, -1)
        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 6 and HaveIBBuff(g_BUFFSTARPOWER) ~= 0) then
        Talk(1, "no", "Søc m¹nh cña Tinh qu©n vÉn ch­a biÕn mÊt, anh hïng cã thÓ khiªu chiÕn ThÇn Th­îng Cæ lÇn n÷a.")
        SetTaskByte(g_HellGod, 3, 0)

        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 4 and HaveIBBuff(g_BUFFSTARPOWER) == 0) then
        MsgBox("Søc m¹nh Tinh qu©n trªn ng­êi anh hïng l¹i r¬i vµo tr¹ng th¸i ngñ vïi, ta sÏ vËn phÐp ®¸nh thøc nã lÇn n÷a, c¸c h¹ ®· chuÈn bÞ ch­a?", "HellFail", "no")

        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 1 and IsExistItem(6, 1, 525, 0) == 0) then
        ClearItem(6, 1, 525, 0)
        AddNormalItem(6, 1, 525, 0, 0, 0)
        Msg2Player("NhËn ®­îc Ph¸ Giíi Th¹ch")
        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 1 and IsExistItem(6, 1, 525, 0) ~= 0) then
        Talk(1, "no", "Anh hïng sao kh«ng nhanh chèng ®i nhËn khiªu chiÕn ®i")
        return
    end

    if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 0 and GetTaskByte(g_PowerStar, 1) == 5) then


        if (GetTaskByte(g_HellGod, 4) ~= 1) then
            Talk(1, "AcceptHell1", "ThÇn lùc Tinh qu©n trong ng­êi c¸c h¹ ®· thøc tØnh. Nh­ng c¸c h¹ chØ cßn thÇn lùc cña 6 vÞ Tinh qu©n ta lo ng¹i sÏ kh«ng ®ñ ®Ó tiªu diÖt Ngu C­¬ng.", GetName() .. "NÕu lµ nh­ vËy th× chóng ta nªn lµm thÕ nµo?", "Vµi h«m tr­íc còng cã vµi vÞ anh hïng còng nhËn ®­îc søc m¹nh cña Tinh qu©n, h·y ®i t×m <c=g>1 ng­êi cïng së h÷u søc m¹nh cña Tinh qu©n<c> tæ ®éi cïng ®i th× h¬n.")
            TaskNote(110, -1)
            TaskNote(111, 0)
        end

        if (GetTeamSize() ~= 2) then
            InfoBox("H·y ®i t×m mét ng­êi ®· hoµn thµnh søc m¹nh Tinh Qu©n tæ ®éi ®Õn gÆp ta, ®Ó ta thøc tØnh søc m¹nh cña Tinh Qu©n.")
            SetTaskByte(g_HellGod, 4, 1)
        elseif (GetTeamSize() == 2) then
            MsgBox("Xem ra c¸c h¹ ®· t×m ®­îc ng­êi thÝch hîp, vËy th× ®Ó ta thøc tØnh søc m¹nh Tinh qu©n trong ng­êi 2 vÞ.", "AcceptHell", "no")
            SetTaskByte(g_HellGod, 4, 1)
        end
    end


end

function HellFail()
    CloseDialog()

    local oldPlayer = PlayerIndex
    if (PlayerIndex > 0) then

        if (GetTeam() ~= 0) then
            for i = 1, GetTeamSize() do

                PlayerIndex = GetTeamMember(i)
                if (GetPlayerExtLevel() >= 65 and GetTaskByte(g_HellGod, 1) == 4 and HaveIBBuff(g_BUFFSTARPOWER) == 0) then
                    SetTaskByte(g_HellGod, 3, 0)
                    SetTaskByte(g_HellGod, 1, 0)
                    refreshNpcTaskState()

                    SetTaskByte(g_HellGod, 4, 1)
                end
            end
        else

            SetTaskByte(g_HellGod, 3, 0)
            SetTaskByte(g_HellGod, 1, 0)
            SetTaskByte(g_HellGod, 4, 1)
            refreshNpcTaskState()

        end
    end

    PlayerIndex = oldPlayer
    if (PlayerIndex > 0) then
        GodofHell()
    end
end

function AcceptHell()
    CloseDialog()
    if (GetTeamSize() == 2) then
        if (GetTeamMember(1) == SearchPlayerById(GetPlayerID())) then
            local FirPlayerID = GetPlayerID()
            SetTask(g_TrueNpcID, GetPlayerID())
            local oldIndex = PlayerIndex

            if (IsHaveSpaceForTreasure(1) == 0) then
                Talk(1, "no", "§Ó cã thÓ khiÕn thÇn th­îng cæ Ngu C­¬ng hiÖn th©n, c¸c h¹ cÇn sö dông <c=g>Ph¸ Giíi Th¹ch<c> t¹i n¬i phong Ên h¾n n¨m x­a, thÕ nh­ng hiÖn t¹i hµnh trang cña c¸c h¹ ®· ®Çy, kh«ng thÓ nhËn Ph¸ Giíi Th¹ch nµy ®­îc")
                return
            end

            PlayerIndex = GetTeamMember(2)
            local SecPlayerID = GetPlayerID()
            SetTask(g_TrueNpcID, FirPlayerID)
            SetTask(g_Teammate, GetPlayerID())

            if (IsHaveSpaceForTreasure(1) == 0) then
                Talk(1, "no", "§Ó cã thÓ khiÕn thÇn th­îng cæ Ngu C­¬ng hiÖn th©n, c¸c h¹ cÇn sö dông <c=g>Ph¸ Giíi Th¹ch<c> t¹i n¬i phong Ên h¾n n¨m x­a, thÕ nh­ng hiÖn t¹i hµnh trang cña c¸c h¹ ®· ®Çy, kh«ng thÓ nhËn Ph¸ Giíi Th¹ch nµy ®­îc")
                local PlayerTemp = PlayerIndex
                PlayerIndex = GetTeamMember(1)
                Talk(1, "no", "Hµnh trang cña ®éi viªn c¸c h¹ ®· ®Çy.")
                PlayerIndex = PlayerTemp

                return
            end

            if (GetTaskByte(g_PowerStar, 1) == 5) then
                if (GetPlayerExtLevel() >= 65 and (GetTaskByte(g_HellGod, 1) == 0 or GetTaskByte(g_HellGod, 1) == 4)) then
                    RemoveIBBuff(g_BUFFSTARPOWER)
                    Talk(2, "no", "Søc m¹nh Tinh qu©n ®· ®­îc thøc tØnh!", "§Ó cã thÓ khiÕn thÇn th­îng cæ Ngu C­¬ng hiÖn th©n, c¸c h¹ cÇn sö dông <c=g>Ph¸ Giíi Th¹ch<c> nµy t¹i n¬i phong Ên h¾n n¨m x­a, h¾n nhÊt ®Þnh sÏ ph¸i 3 hãa th©n ra øng chiÕn, cÇn ph¶i tiªu diÖt 3 h¸o th©n tr­íc th× thùc thÓ Ngu C­¬ng míi xuÊt hiÖn.")
                    if (IsExistItem(6, 1, 525, 0) == 0) then

                        ClearItem(6, 1, 525, 0)
                        AddNormalItem(6, 1, 525, 0, 0, 0)
                        Msg2Player("NhËn ®­îc Ph¸ Giíi Th¹ch")
                    end
                    SetTaskByte(g_HellGod, 1, 1)
                    refreshNpcTaskState()
                    SetTaskByte(g_HellGod, 3, 0)

                    SetSubTask(111, 1, 1)
                    TaskNote(111, 1)
                    AddIBBuff(g_BUFFSTARPOWER)
                end
                PlayerIndex = oldIndex

                SetTask(g_Teammate, SecPlayerID)

                RemoveIBBuff(g_BUFFSTARPOWER)

                if (IsExistItem(6, 1, 525, 0) == 0) then
                    ClearItem(6, 1, 525, 0)
                    AddNormalItem(6, 1, 525, 0, 0, 0)
                    Msg2Player("NhËn ®­îc Ph¸ Giíi Th¹ch")
                end

                SetTaskByte(g_HellGod, 3, 0)

                TaskNote(111, 1)

                Talk(2, "no", "Søc m¹nh Tinh qu©n ®· ®­îc thøc tØnh!", "§Ó cã thÓ khiÕn thÇn th­îng cæ Ngu C­¬ng hiÖn th©n, c¸c h¹ cÇn sö dông <c=g>Ph¸ Giíi Th¹ch<c> nµy t¹i n¬i phong Ên h¾n n¨m x­a, h¾n nhÊt ®Þnh sÏ ph¸i 3 hãa th©n ra øng chiÕn, cÇn ph¶i tiªu diÖt 3 h¸o th©n tr­íc th× thùc thÓ Ngu C­¬ng míi xuÊt hiÖn.")
                AddIBBuff(g_BUFFSTARPOWER)

                SetTaskByte(g_HellGod, 1, 1)
                refreshNpcTaskState()

                SetTaskByte(g_HellGod, 4, 0)

            else
                PlayerIndex = oldIndex
                InfoBox("Ng­¬i nhÊt ®Þnh ph¶i t×m mét ng­êi hoµn thµnh søc m¹nh Tinh Qu©n tæ ®éi ®Õn gÆp ta, nh÷ng ng­êi kh¸c ta e r»ng sÏ kh«ng ®Þch l¹i søc m¹nh cña thÇn th­îng cæ ®©u.")
                return
            end
        else

            InfoBox("H·y gäi ®éi tr­ëng c¸c h¹ ®Õn gÆp ta.")
            return
        end
    else
        InfoBox("H·y ®i t×m mét ng­êi ®· hoµn thµnh søc m¹nh Tinh Qu©n tæ ®éi ®Õn gÆp ta.")
        return
    end
end

function acceptPowerfulOne()

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "C¸c h¹ mang qu¸ nhiÒu tr¹ng th¸i råi.")
        return
    end

    if ((GetTaskByte(g_PowerStar, 1) == 0 or GetTaskByte(g_PowerStar, 1) == 4) and GetPlayerExtLevel() >= 60) then
        Talk(2, "powerfulstar", "Ngôc Ph¸p S¬n tõng xuÊt hiÖn 1 ng­êi rÊt ®¸ng sî tªn lµ Ngu C­¬ng, h¾n lµ 1 vÞ thÇn th­îng cæ, n¨m x­a h¾n bÞ 2 vÞ téc tr­ëng hîp lùc cïng 12 vÞ Tinh qu©n phong Ên h¾n xuèng ®¸y Ngôc Ph¸p S¬n. ThÕ nh­ng ngµy nay phong Ên ®ã ®· bÞ ng­êi kh¸c gi¶i ra, h¾n nhÊt ®Þnh sÏ quay vÒ san b»ng bé l¹c Di Ph­¬ng ta ®Ó b¸o thï.", "TiÕc r»ng bé l¹c Di Ph­¬ng ngµy nay v¾ng bãng hiÒn tµi, kh«ng ai cã thÓ nhËn ®­îc thÇn lùc 12 vÞ Tinh qu©n, ta nhËn thÊy c¸c h¹ cã t­ chÊt h¬n ng­êi nªn khÈn xin anh hïng trî gióp bé l¹c ta v­ît qua kiÕp n¹n nµy.")

    elseif (GetTaskByte(g_PowerStar, 1) == 1 and GetPlayerExtLevel() >= 60) then
        InfoBox("anh hïng xin ®i nhanh vÒ nhanh, bé l¹c Di Ph­¬ng cã thÓ v­ît qua tai kiÕp nµy hay kh«ng lµ tr«ng cËy vµo anh hïng")
        return
    elseif (GetTaskByte(g_PowerStar, 1) == 2 and GetPlayerExtLevel() >= 60) then
        InfoBox("anh hïng xin ®i nhanh vÒ nhanh, bé l¹c Di Ph­¬ng cã thÓ v­ît qua tai kiÕp nµy hay kh«ng lµ tr«ng cËy vµo anh hïng")
        return
    end


end

function SubmitAmber()
    CloseDialog()
    local nNeed = 10
    if (HaveNormalItem(3, 425, 0, 0) >= nNeed and HaveNormalItem(3, 426, 0, 0) >= nNeed) then
        for i = 1, nNeed do
            DelNormalItem(3, 425, 0, 0)
            DelNormalItem(3, 426, 0, 0)
        end
        Msg2Player("§· mÊt ®i 10 Hæ Ph¸ch Chi T©m vµ Hæ Ph¸ch Chi Hån.")
        local w, x, y = GetWorldPos()
        local nAddNpcIndex = AddNpc(1114, 75, SubWorld, x * 32, y * 32);
        if (nAddNpcIndex > 0) then
            TaskNote(110, 1)
            local nNorthIndex = GetTaskByte(g_PowerStar, 2)
            local StarList = { g_Light1, g_Light2, g_Light3, g_Light4 }
            SetNpcTask(GetGlobalValue(StarList[nNorthIndex]), 0, 1)
            SetTaskByte(g_PowerStar, 1, 1)

            refreshNpcTaskState()

            SetSubTask(110, 1, 1)
            SetAIScript(nAddNpcIndex, "\\script\\ai\\ÙÈÊåÒÄ»¯Éíai.lua")
            SetNpcTask(nAddNpcIndex, 0, GetPlayerID())
            SetNpcScript(nAddNpcIndex, "\\script\\¹ÖÎï\\ÙÈÊåÒÄ»¯ÉíËÀÍö.lua")
            SetNpcName(nAddNpcIndex, GetName() .. "Hãa th©n cña YÓn Thóc Di")
        end
    else
        Talk(1, "no", "kh«ng ®ñ Hæ Ph¸ch Chi T©m vµ Hæ Ph¸ch Chi Hån lµ kh«ng thÓ huyÒn hãa ra hãa th©n ®­îc!")

        return

    end
end;

function comPowerfulStar()
    if (GetTaskByte(g_PowerStar, 1) == 3 and GetPlayerExtLevel() >= 60) then

        TopMessage("NhiÖm vô hoµn thµnh")
        local nFactExp = AddOwnExtendExp(4000000)
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc " .. nFactExp .. " ®iÓm tu luyÖn!")
        Talk(1, "no", "anh hïng qu¶ nhiªn lîi h¹i, hiÖn c¸c h¹ ®· nhËn ®­îc thÇn lùc cña Tinh qu©n råi. Nh­ng ®¸ng tiÕc lµ chØ cã søc m¹nh cña 6 vÞ Tinh qu©n ®­îc chuyÓn vµo c¸c h¹. Nh÷ng søc m¹nh nµy cÇn cã thêi gian ®Ó thøc tØnh. §¹t ®¼ng cÊp 65 h·y quay vÒ t×m ta.")
        SetSubTask(110, -1, 1)
        TaskNote(110, 4)
        SetTaskByte(g_PowerStar, 1, 5)

        refreshNpcTaskState()

    end
end

function powerfulstar1()
    CloseDialog()

    local StarList = { g_Light1, g_Light2, g_Light3, g_Light4 }

    local FreeStarID = nil
    for i = 1, 4 do
        if (GetNpcTask(GetGlobalValue(StarList[i]), 0) == 0) then
            FreeStarID = i;
            break
        end
    end
    if (FreeStarID == nil or FreeStarID <= 0 or FreeStarID > 4) then
        Talk(1, "no", "L·o phu hiÖn ®ang ®Òu khÝ chØnh h­, vµi kh¾c n÷a míi cã thÓ thi ph¸p huyÒn hãa hãa th©n.");
        return
    end

    SetTaskByte(g_PowerStar, 2, FreeStarID);

    refreshNpcTaskState()

    MsgBox("Nh­ng vËn phÐp huyÒn hãa 1 hãa th©n cÇn 10 Hæ Ph¸ch Chi T©m vµ æ Ph¸ch Chi Hån, ng­¬i sÏ giao cho ta chø?", "SubmitAmber", "no")
    TaskNote(110, 0)
    TaskNote(109, -1)
end

function powerfulstar()
    CloseDialog()
    Talk(3, "powerfulstar1", GetName() .. "Tiªn sinh yªn t©m, t¹i h¹ sÏ ®i thö, nh­ng lµm thÕ nµo míi cã thÓ nhËn ®­îc søc m¹nh cña Tinh qu©n?", "Ta cã thÓ thi ph¸p huyÒn hãa ra 1 hãa th©n, c¸c h¹ chØ cÇn ®i theo hãa th©n tiÕn ®Õn n¬i ë cña Tinh qu©n lµ ®­îc.", "Nh­ng nÕu nh­ nh÷ng ma vËt trªn Ngôc Ph¸p S¬n mµ biÕt ®­îc sÏ ®Õn quÊy nhiÔu, c¸c h¹ nªn thËn träng.", GetName() .. " §a t¹ tiªn sinh nh¾c nhë, nh÷ng tªn ma vËt ®ã kh«ng ®¸ng lo l¾ng!")
end

function offlineTotimes()
    local localday = math.floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = math.mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = math.floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (math.mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)


    local m = 9000 * GetPlayerExtLevel()
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(Task_TwelveStarCommon, 3)
    local nTimes, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)

    local pm = 1000000
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm

    if (GetCash() >= pm) then
        if (IsCanAwake() == 0) then
            return
        end

        ResetTwelveIdolTaskTime()

        local nNameId = GetStarManNameID()
        SetTaskByte(Task_TwelveIdol, 2, nNameId)
        SetTaskByte(Task_TwelveStarCommon, 1, 3)

        Roulette(nNameId)
    else
        Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c!")
    end
end

function freefsbFinishStarMan()
    CloseDialog()
    local temp = GetTaskByte(Task_TwelveStarCommon, 3)
    local nTimes, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    if (nTimes == 0) then
        FinishGetStarManNameID()
        return 1
    else
        for i = 1, 3 do
            if (GetBit(addtimes, i) == 1) then
                temp = SetBit(temp, 5 + i, 1)
            else
                temp = SetBit(temp, 5 + i, 0)
            end
        end
    end

    local apm = payMoneyfree(addtimes)

    local pm = 1000000
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm

    if (GetCash() >= pm) then
        if (IsCanAwake() == 0) then
            return
        end
    else
        Talk(1, "no", "Ng­¬i kh«ng ®ñ b¹c!")
        return
    end

    SetTaskByte(Task_TwelveStarCommon, 1, 0)
    SetTaskByte(Task_TwelveStarCommon, 3, temp)

    local nNameId = GetTaskByte(Task_TwelveIdol, 2)
    SetTaskByte(Task_TwelveIdol, 1, 1)
    TaskNote(1084, 0, StarManName[nNameId].name, StarManName[nNameId].pos)

    if (GetJusticEvilCredit() > 0) then
        DelNormalItem(3, 427, 0, 0)
        DelNormalItem(3, 427, 0, 0)
    elseif (GetJusticEvilCredit() < 0) then
        DelNormalItem(3, 428, 0, 0)
        DelNormalItem(3, 428, 0, 0)
    end

    if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        CostIBBuff(767, 1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney + apm - pm
        WriteLog(GetName() .. "Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
        Msg2Player("Dïng tr¹ng th¸i nghÜa khÝ hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
    elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
        PayHelpScore(1)
        SetTaskByte(Task_Yiqi, 1, 0)
        local change = lastMoney + apm - pm
        WriteLog(GetName() .. "Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
        Msg2Player("Dïng ®iÓm nh©n nghÜa hñy bá nhiÖm vô ThËp nhÞ nh©n ngÉu" .. change .. ".")
    end

    Pay(pm)

    AddNormalItem(6, 1, 527, 0, 1, 0)
    Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
    Msg2Player("§©y lµ ­u ®·i tÝch lòy rêi game lÇn thø " .. addtimes .. " lÇn nhËn thªm nhiÖm vô ThËp nhÞ nh©n ngÉu, theo chØ dÉn t×m Tinh Qu©n vµ gióp YÓn Thóc Di thøc tØnh «ng Êy.")
    TopMessage("NhËn ®­îc <c=yel>Hu©n H­¬ng L­")

    Talk(1, "no", "Xem ra anh hïng vµ <c=g>" .. StarManName[nNameId].name .. "<c> rÊt cã duyªn, h·y gióp ta dïng <c=yel>Hu©n H­¬ng L­<c> ®¸nh thøc h¾n!")
end

function sal_begin()
    CloseDialog()
    MsgBox("Ng­¬i muèn ®Õn B¶n TuyÒn? Theo ta ®­îc biÕt, nÕu ch­a ®é kiÕp, khi ®Õn B¶n TuyÒn Th¸nh §Þa chØ khiÕn Thiªn Nh©n Ngò Suy nhanh chãng ®Õn ®©y. Nh­ng v× ng­¬i ®· gióp ta rÊt nhiÒu, nªn ta sÏ cho ng­¬i biÕt mét vµi ®iÒu.", "sal_begin_yes", "no")
end

function sal_begin_yes()
    CloseDialog()
    if (GetTask(task_poluo_renwu) > 0) then
        return 0
    end
    TaskNote(113, 0)
    Msg2Player("§i t×m <HyperLinkWorldPos=\"Thanh V©n Kh¸ch[75,242,199]\">")
    SetTask(task_poluo_renwu, 1)
    Talk(1, "no", "GÇn ®©y cã 2 nh©n vËt bÝ Èn ®Õn Ngôc Ph¸p S¬n, nghe nãi hä ®Õn tõ B¶n TuyÒn Th¸nh §Þa, lóc nµy hä ®ang thu thËp Th­¬ng Long Gi¸c, nÕu nh­ ng­¬i cã thÓ gióp hä thu thËp b¶o vËt nµy,  cã thÓ hä sÏ cho ng­¬i biÕt c¸ch ®Õn B¶n TuyÒn mµ kh«ng gÆp kiÕp n¹n.")
end

