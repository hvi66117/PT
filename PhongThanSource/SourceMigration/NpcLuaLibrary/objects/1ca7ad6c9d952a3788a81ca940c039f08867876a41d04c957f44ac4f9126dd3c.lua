require("common.luax")
require("Éñ½«ÏµÍ³.luax")

TASK_renwu = 1139
TASK_Npcindex = 1140
TASK_Lucky = 1141

TaskTimes = {
    [1] = { totalTimes = 630, awardsTimes = 5, },
    [2] = { totalTimes = 390, awardsTimes = 4, },
    [3] = { totalTimes = 270, awardsTimes = 3, },
    [4] = { totalTimes = 210, awardsTimes = 2, },
    [5] = { totalTimes = 180, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1699
G_Double = 370

TASK_TIMES_Max = 4
maps = {
    { mapid = 44, x = 1894, y = 3084, r = 4 },
    { mapid = 44, x = 1894, y = 3084, r = 4 },
    { mapid = 44, x = 1894, y = 3084, r = 4 },


}
item_guard = {
    [1] = { BoxNums = 3, ibnumber = 1, moneynumber = 1 },
    [2] = { BoxNums = 4, ibnumber = 1, moneynumber = 1 },
    [3] = { BoxNums = 9, ibnumber = 2, moneynumber = 2 },
    [4] = { BoxNums = 18, ibnumber = 4, moneynumber = 3 }
}

Task_Yiqi = 1532

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
    local startLevel = 95
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(TASK_renwu, 3) == 0 and (thisday ~= lastday)) then
                state = 1
                subState = 0
            elseif (GetTaskByte(TASK_renwu, 3) == 3 and (thisday ~= lastday)) then
                state = 3
                subState = 0


            end
        else
            if (GetTaskByte(TASK_renwu, 3) == 0 and (thisday ~= lastday)) then
                state = 1
                subState = 1
            elseif (GetTaskByte(TASK_renwu, 3) == 3 and (thisday ~= lastday)) then
                state = 3
                subState = 1


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

function main()
    local tasks = {
        { "Tèng Töu", "Acdept_taskVino"; show = 0 }
    }

    if (GetLevel() >= 95) then
        if (GetTask(TASK_renwu) > 0) then
            tasks[1].show = 1

            SayTask(14654, tasks)
        else
            Talk(1, "no", 14655)
        end ;
    else
        Talk(1, "no", 14656)
    end
end;

function Yes_AcceptDouble()
    local nTimes = GetTaskByte(Double_Optimization, 1)
    local taskDay = GetWeekDay()

    SetTaskByte(Double_Optimization, 1, nTimes + 1)
    SetTaskByte(Double_Optimization, 3, taskDay)
    renwu1()
end

function Acdept_taskVino()

    if (SUPERMAN.CheckTaskIsDoing(1, 7) > 0) then
        Talk(1, "no", "Xin lçi, ®· cã ThÇn T­íng gióp ng­¬i lµm nhiÖm vô nµy råi, h·y ®Õn chç Sø Gi¶ ThÇn T­íng t¹i L·nh ®Þa nhËn th­ëng tr­íc.")
        return
    end

    for i = 1, 6 do
        if (GetTask(1142) >= TaskTimes[i].totalTimes) then
            SetTaskByte(Double_Optimization, 2, TaskTimes[i].awardsTimes)
            break
        end
    end

    local taskDay = GetWeekDay()
    if (GetGlobalValueByte(G_Double, 4) == 0) then
        SetTask(Double_Optimization, 0)
    end
    if (GetGlobalValueByte(G_Double, 4) == 1 and taskDay > GetTaskByte(Double_Optimization, 3)) then
        SetTaskByte(Double_Optimization, 3, 0)
    end

    if (GetGlobalValueByte(G_Double, 4) == 1 and GetTaskByte(Double_Optimization, 4) ~= taskDay and GetTaskByte(Double_Optimization, 1) < GetTaskByte(Double_Optimization, 2)) then
        MsgBox("Chñ töu qu¸n T©y Vùc:TuÇn nµy ng­¬i sÏ cã <c=g>" .. GetTaskByte(Double_Optimization, 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· hÕt <c=g>" .. GetTaskByte(Double_Optimization, 1) .. "<c> ngµy. <c=r>H«m nay b¹n cã muèn nhËn phÇn th­ëng nh©n ®«i kh«ng?<c>", "Yes_AcceptDouble", "renwu1")
        return 0
    end

    renwu1()
end

function renwu1()
    CloseDialog()
    local taskDay = GetWeekDay()
    SetTaskByte(Double_Optimization, 4, taskDay)

    local huanshu = GetTaskByte(TASK_renwu, 3)
    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()

    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end

    local guardindex = COMMON.reSetGuardIndex()
    if (guardindex > 0) then
        if (GetTaskByte(959, 1) >= 1) then
            Talk(1, "no", 14657)
        elseif (GetByte(GetTask(1238), 1) == 1 and HaveIBBuff(463) > 0) then
            Talk(1, "no", 14658)
        elseif (huanshu > 0) then
            Talk(1, "no", 14659)
        else
            Talk(1, "no", 14660)
        end
        return 0
    end

    if (thisday ~= lastday) and (HaveIBBuff(376) == 0) then
        SetTaskByte(Task_Yiqi, 2, 0)
        SetTaskByte(Task_Yiqi, 3, 0)
        refreshNpcTaskState()
    end

    if (GetTaskByte(Task_Yiqi, 2) == 1) or (GetTaskByte(Task_Yiqi, 2) == 2) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i ®· gÆp <c=g>Ng­êi T©y Vùc ë T©y Kú<c> nhËn nhiÖm vô <c=g>Tèng Töu<c>, ng­¬i x¸c nhËn muèn nhËn 2 xe chuyÓn r­îu chø?", "getMyCarriage", "no")
        return
    end

    local alltimes = GetTaskByte(1477, 3)
    if (thisday ~= lastday) or (huanshu == 1) then
        if (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
            MsgBox("Thø ng­¬i muèn lµ h¶o töu! D¹o nµy Ma qu¸i léng hµnh, nguyªn liÖu rÊt khã t×m. Giê cÇn ph¶i cã <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. " l­îng. Gióp ta ®­îc chø?", "yes", "no")
        else
            Talk(1, "no", "Thø ng­¬i muèn lµ h¶o töu! D¹o nµy Ma qu¸i léng hµnh, nguyªn liÖu rÊt khã t×m. Giê cÇn ph¶i cã <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        end
    elseif (times < TASK_TIMES_Max or alltimes >= addtimes) and (huanshu == 0) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹p tµi tu luyÖn", "yes_fsb"; show = 0 },
            { "L­u Ly B«i", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        else
            coin_renwu()
            return 0
        end

        if (times < TASK_TIMES_Max) then
            task[2].show = 1
        end
        SayTask("HiÖn t¹i ng­¬i tæn céng" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. " TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tÝnh vµo chi tiÕt thu phÝ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó chÕ t¹o xe r­îu <c=g>Hång B¶o Th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
    elseif (GetLevel() >= 95) and (huanshu > 0) then
        if (huanshu == 2) then
            MsgBox(14661, "quxiao", "no")
        elseif (huanshu == 3) then
            Talk(1, "no", 14662)
        else
            MsgBox("Thø ng­¬i muèn lµ h¶o töu! D¹o nµy Ma qu¸i léng hµnh, nguyªn liÖu rÊt khã t×m. Giê cÇn ph¶i cã <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. " l­îng. Gióp ta ®­îc chø?", "yes", "no")
        end
    elseif (times >= TASK_TIMES_Max) and (thisday == lastday) then
        Talk(1, "no", " Anh hïng h«m nay ®· chuyÓn r­îu" .. TASK_TIMES_Max .. "LÇn, do kho chøa cã h¹n, mçi ngµy mçi ng­êi chØ ®­îc chuyÓn r­îu" .. TASK_TIMES_Max .. " lÇn, cho nªn ngµy kh¸c anh hïng h·y ®Õn!")
        TaskNote(55, -1)
        SyncBibleState(55, 3, 1)
    end

end;

function coin_renwu()
    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(66)
    TaskNote(55, -1)
    local costtimes = item_guard[times].ibnumber
    local pm = payMoney() * item_guard[times].moneynumber
    Cv = (costtimes - HaveNormalItem(8, 378, 2, 0)) * Cv
    Cfs = costtimes * Cfs

    local scores = GetHelpScore()
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or scores > 0) then
        pm = pm * 0.9
    end

    if (HaveNormalItem(8, 378, 2, 0) >= costtimes) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox("Mçi ngµy mçi ng­êi chØ ®­îc h¹n chÕ sè lÇn cung cÊp nguyªn liÖu. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. " C¸i, ng­¬i cã muèn chuyÓn thªm lÇn n÷a kh«ng?", "yes", "no")
    elseif (GetCoin() >= Cv) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox("Mçi ngµy mçi ng­êi chØ ®­îc h¹n chÕ sè lÇn cung cÊp nguyªn liÖu. Ngoµi <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c>Th«ng B¶o, ng­¬i b»ng lßng kh«ng?", "yes", "no")
    else
        Talk(1, "no", "h¶o töu nµy rÊt khã cã ®­îc nã. Mçi ngµy nÕu muèn cã thªm lÇn n÷a ph¶i cÇn <c=g>1 Hång B¶o th¹ch<c> vµ" .. lastMoney .. "TiÒn vµng, cßn cÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, chuÈn bÞ ®ñ råi h·y ®Õn t×m ta!")
    end
end

function quxiao()
    SetTaskByte(TASK_renwu, 3, 0)
    SetTaskByte(TASK_renwu, 4, 0)
    SetTask(TASK_Npcindex, 0)
    SetTask(TASK_Lucky, 0)
    refreshNpcTaskState()

    SetTaskByte(Task_Yiqi, 2, 0)
    SetTaskByte(Task_Yiqi, 3, 0)

    TaskNote(55, -1)
    refreshNpcTaskState()
    RemoveIBBuff(376)
    RemoveIBBuff(377)

    local playername, guardindex
    playername = GetName()
    guardindex = GetTGuardIndexByPlayerName(playername)
    local _, _, _, _, carriageindex = GetTGuardInfo(guardindex)

    if (carriageindex > 0) and (guardindex > 0) then
        DeleteSiegeWeapon(carriageindex)
    end
    WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng][È¡ÏûÈÎÎñ]guardindex: " .. guardindex .. "carriageindex:" .. carriageindex)

    Talk(1, "no", 14665)
end

function yiqiBuff_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i cã thÓ dïng 1 <c=g>Tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 §iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ®ång ý sö dông kh«ng?", "costYiqi_1", "yes1")
    else
        yes1()
    end
end

function costYiqi_1()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes1()
    else
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc: Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i cã thÓ dïng 1 <c=g>Tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 §iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ®ång ý sö dông kh«ng?", "costYiqi_2", "yes2")
    else
        yes2()
    end
end

function costYiqi_2()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes2()
    else
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc: Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i cã thÓ dïng 1 <c=g>Tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 §iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ®ång ý sö dông kh«ng?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes_freefsb()
    else
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc: Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i cã thÓ dïng 1 <c=g>Tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 §iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ®ång ý sö dông kh«ng?", "costYiqi_4", "yes_2")
    else
        yes_2()
    end
end

function costYiqi_4()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes_2()
    else
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc: Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:Ng­¬i cã thÓ dïng 1 <c=g>Tr¹ng th¸i nghÜa khÝ<c> hoÆc <c=g>1 §iÓm nh©n nghÜa<c> ®Ó tiÕt kiÖm 10% b¹c, ®ång ý sö dông kh«ng?", "costYiqi_5", "yes_freefsb2")
    else
        yes_freefsb2()
    end
end

function costYiqi_5()
    CloseDialog()
    local scores = GetHelpScore()
    if (HaveIBBuff(767) > 0 or scores > 0) then
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes_freefsb2()
    else
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc: Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khÝ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yes()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local tasks = {
        { "Xe chuyÓn r­îu", "yes_1"; show = 1 },
        { "<c=g>ThÇn ThuËt", "yiqiBuff_4"; show = 1 },
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>Th«ng B¶o, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

function yes_1()
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    SetTask(TASK_Npcindex, 1)
    refreshNpcTaskState()
    if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
        yiqiBuff_1()
    else
        yiqiBuff_2()
    end
end

function yes_2()
    CloseDialog()
    SetTask(TASK_Npcindex, 2)
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local ib379 = FindAValidIBItem(8, 379, 2, 0)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    refreshNpcTaskState()
    if (ib379 ~= 0) then
        if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
            if (yes1() ~= 1) then
                return 0
            end
        else
            if (yes2() ~= 1) then
                return 0
            end
        end

        CostIBItem(ib379)
        Msg2Player("B¹n nép ThÇn ThuËt cho BÝch Du Nh©n nhËn ®­îc xe chuyÓn r­îu cao cÊp!")
    elseif (GetCoin() >= Cv) then
        if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
            if (yes1() ~= 1) then
                return 0
            end
        else
            local _, Cv1, Cfs1 = GetCostCoinInfoByIdx(66)
            local ib378 = FindAValidIBItem(8, 378, 2, 0)
            local itemib378 = HaveNormalItem(8, 378, 2, 0)
            local temp = GetTaskByte(TASK_renwu, 2) + 1
            local times, addtimes = todayfreetimes(temp)
            if (times >= TASK_TIMES_Max) then
                times = TASK_TIMES_Max
            end
            local costtimes = item_guard[times].ibnumber

            if (ib378 >= 1 and itemib378 >= costtimes) or (GetCoin() >= (Cv + Cv1 * costtimes)) or (ib378 >= 1 and GetCoin() >= (Cv + Cv1 * (costtimes - itemib378))) then
                if (yes2() ~= 1) then
                    return 0
                end
            else
                Msg2Player("Kh«ng ®ñ vËt liÖu!")
                Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
                return 0
            end
        end

        CostCoinByIdx(67)
        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o nhËn ®­îc Xe chuyÓn r­îu cao cÊp.")
    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
    end
end

function yes1()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)
        return 0
    end

    local mapid = GetWorldPos()
    if (mapid ~= 44) then
        CloseDialog()
        return 0
    end
    local num = math.random(1, 3)
    local px = maps[num].x
    local py = maps[num].y
    local r = math.random(0, 3)
    if (r == 0) then
        px = px + math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    elseif (r == 1) then
        px = px - math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    elseif (r == 2) then
        px = px + math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    else
        px = px - math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    end ;
    px = 32 * px
    py = 32 * py

    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(TASK_renwu, 1)
    local pm = payMoney()
    if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
        times = 1
    else
        pm = pm * item_guard[times].moneynumber
    end

    local scores = GetHelpScore()
    local lastMoney = pm
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end

    if (GetLevel() >= 95) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        local carKey = GetTask(TASK_Npcindex) + 647
        local boxindex = NewSiegeWeapon(mapid, px, py, carKey)

        local boxnpcindex = GetSiegeWeaponNpcIndex(boxindex)
        if (boxnpcindex > 0) then
            local playername = GetName()
            if (carKey == 649) then
                SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ2.lua")
            else
                SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ1.lua")
            end

            SetNpcTask(boxnpcindex, 1, GetPlayerID())
            SetNpcTask(boxnpcindex, 2, LocalSystemTime())
            WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng]Ãâ·Ñ¼Ó³É¹¦")

            SendCarriage(boxindex, playername, 1, 1200)

            SetGuardLevel(boxnpcindex, 1)

            if (thisday ~= lastday) or (GetTaskByte(TASK_renwu, 3) == 1) then
                SetTask(TASK_renwu, SetByte(0, 1, thisday))
                refreshNpcTaskState()
                offlineTotimes()
                temp = 1
            end

            SetTaskByte(TASK_renwu, 2, temp)
            SetTaskWord(TASK_renwu, 2, 2)
            refreshNpcTaskState()

            local scores = GetHelpScore()
            if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
                CostIBBuff(767, 1)
                SetTaskByte(Task_Yiqi, 1, 0)
                refreshNpcTaskState()
                local change = lastMoney - pm

                Msg2Player("Dïng Tr¹ng th¸i nghÜa khÝ hñy nhiÖm vô Tèng Töu" .. change .. ".")
            elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
                PayHelpScore(1)
                SetTaskByte(Task_Yiqi, 1, 0)
                refreshNpcTaskState()
                local change = lastMoney - pm

                Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
            end

            Pay(pm)
            DelNormalItem(3, 79, 0, 0)

            SetTask(TASK_Lucky, 0)
            refreshNpcTaskState()

            RemoveIBBuff(376)
            RemoveIBBuff(377)
            AddIBBuff(376)
            for i = 1, item_guard[times].BoxNums do
                AddIBBuff(377)
            end

            local exp1 = GetLevel() * 1000
            AddOwnExp(exp1)
            TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

            Msg2Player("H«m nay lµ lÇn thø " .. times .. ", b¹n vËn chuyÓn r­îu quý! Xin b¶o träng!")
            TaskNote(55, 1)

            if (times < TASK_TIMES_Max) then
                SyncBibleState(55, 2, 1)
            else
                SyncBibleState(55, 3, 1)
            end ;

            Talk(2, "no", "H«m nay lµ lÇn thø <c=g>" .. times .. "<c>, anh hïng chuyÓn r­îu quý! LÇn nµy cÇn chuyÓn" .. item_guard[times].BoxNums .. "B×nh r­îu! Sè lÇn chuyÓn r­îu trong ngµy cµng nhiÒu, sè r­îu chuyÓn ®­îc cµng nhiÒu!", "LÇn nµy ra ®i mu«n vµn hiÓm nguy, dµnh tÆng b¹n <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm, BÝch Du Nh©n ë gÇn §¹i Phu tÇng 5!")
            return 1
        else
            Talk(1, "no", 14667)
            return 0
        end
    else
        Talk(1, "no", "CÇn cã <c=g>1 Hång B¶o th¹ch<c> vµ" .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        return 0
    end
end

function yes2()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(66)
    local i = FindAValidIBItem(8, 378, 2, 0)
    local temp = GetTaskByte(TASK_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    if (times >= TASK_TIMES_Max) then
        times = TASK_TIMES_Max
    end

    local costtimes = item_guard[times].ibnumber
    local j = HaveNormalItem(8, 378, 2, 0)

    if (i ~= 0) and (j >= costtimes) then
        if (yes1() ~= 1) then
            return 0
        end
        for k = 1, costtimes do
            CostIBItem(FindAValidIBItem(8, 378, 2, 0))
        end
        Msg2Player("B¹n giao cho chñ qu¸n L­u Ly B«i" .. costtimes .. " C¸i, nhËn nhiÖm vô Tèng Töu míi.")
        return 1
    elseif (i ~= 0) and (GetCoin() >= Cv * (costtimes - j)) then
        if (yes1() ~= 1) then
            return 0
        end

        for k = 1, costtimes do
            i = FindAValidIBItem(8, 378, 2, 0)
            if (i ~= 0) then
                CostIBItem(i)
            else
                CostCoinByIdx(66)
            end
        end

        Cfs = (costtimes - j) * Cfs
        Msg2Player("B¹n giao cho chñ qu¸n L­u Ly B«i" .. j .. " C¸i vµ" .. Cfs .. " Th«ng B¶o, nhËn nhiÖm vô Tèng Töu míi!")
        return 1
    elseif (GetCoin() >= Cv * costtimes) then
        Cfs = costtimes * Cfs
        if (yes1() ~= 1) then
            return 0
        end

        for k = 1, costtimes do
            CostCoinByIdx(66)
        end

        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o, nhËn nhiÖm vô Tèng Töu míi!")
        return 1
    else
        Talk(1, "no", "CÇn thªm <c=g>L­u Ly B«i<c>" .. costtimes .. "C¸i hoÆc <c=g>" .. Cfs .. "<c> Th«ng B¶o, chuÈn bÞ ®ñ råi h·y ®Õn t×m ta!")
    end
    return 0
end

function payMoney()
    local m = 300000
    if (GetLevel() > 104) then
        m = m + math.floor((GetLevel() - 95) / 10) * 200000

    end
    return m
end

function no()
    CloseDialog()
end;

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
        refreshNpcTaskState()
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
            refreshNpcTaskState()
        end
    end
    return value, free
end

function payMoneyfree(nums)
    if (nums > 7) then
        nums = 7
    end
    local n_times = { 50, 50, 50, 100, 100, 100, 100 }
    local m = 60 * n_times[nums] * GetLevel()
    return m
end

function yes_fsb()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local tasks = {
        { "Xe chuyÓn r­îu", "yes_freefsb1"; show = 1 },
        { "<c=g>ThÇn ThuËt", "yiqiBuff_5"; show = 1 },
    }
    SayTask("Xe chuyÓn r­îu th«ng th­êng cång kÒnh nh­ng rÊt mong manh! NÕu ng­¬i cã <c=yel>ThÇn ThuËt<c> hoÆc <c=g>" .. Cfs .. "<c>Th«ng B¶o, sÏ söa thµnh xe kiªn cè vµ ch¹y nhanh!", tasks)
end

function yes_freefsb1()
    SetTask(TASK_Npcindex, 1)
    refreshNpcTaskState()
    yiqiBuff_3()
end

function yes_freefsb()
    CloseDialog()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)
        return 0
    end

    local mapid = GetWorldPos()
    if (mapid ~= 44) then
        CloseDialog()
        return 0
    end
    local num = math.random(1, 3)
    local px = maps[num].x
    local py = maps[num].y
    local r = math.random(0, 3)
    if (r == 0) then
        px = px + math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    elseif (r == 1) then
        px = px - math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    elseif (r == 2) then
        px = px + math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    else
        px = px - math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    end ;
    px = 32 * px
    py = 32 * py

    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)

    local scores = GetHelpScore()
    local pm = payMoney()
    if ((HaveIBBuff(767) > 0 or scores > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        pm = pm * 0.9
    end
    pm = pm + apm

    if (GetLevel() >= 95) and (HaveNormalItem(3, 79, 0, 0) >= 1) and (GetCash() >= pm) then
        local carKey = GetTask(TASK_Npcindex) + 647
        local boxindex = NewSiegeWeapon(mapid, px, py, carKey)

        local boxnpcindex = GetSiegeWeaponNpcIndex(boxindex)
        if (boxnpcindex > 0) then
            local playername = GetName()
            if (carKey == 649) then
                SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ2.lua")
            else
                SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ1.lua")
            end

            SetNpcTask(boxnpcindex, 1, GetPlayerID())
            SetNpcTask(boxnpcindex, 2, LocalSystemTime())
            WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng]ÄÉ²Æ¼Ó³É¹¦")

            SendCarriage(boxindex, playername, 1, 1200)

            SetGuardLevel(boxnpcindex, 1)

            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                    refreshNpcTaskState()
                else
                    temp = SetBit(temp, 5 + i, 0)
                    refreshNpcTaskState()
                end
            end
            SetTaskByte(TASK_renwu, 2, temp)
            SetTaskByte(TASK_renwu, 3, 2)
            SetTaskByte(TASK_renwu, 4, 0)
            refreshNpcTaskState()

            local scores = GetHelpScore()
            if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
                CostIBBuff(767, 1)
                SetTaskByte(Task_Yiqi, 1, 0)
                refreshNpcTaskState()
                local change = payMoney() + apm - pm

                Msg2Player("Dïng Tr¹ng th¸i nghÜa khÝ hñy nhiÖm vô Tèng Töu" .. change .. ".")
            elseif (scores > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
                PayHelpScore(1)
                SetTaskByte(Task_Yiqi, 1, 0)
                refreshNpcTaskState()
                local change = payMoney() + apm - pm

                Msg2Player("Dïng §iÓm nh©n nghÜa hñy nhiÖm vô Tèng Töu" .. change .. ".")
            end

            Pay(pm)
            DelNormalItem(3, 79, 0, 0)

            SetTask(TASK_Lucky, 0)
            refreshNpcTaskState()

            RemoveIBBuff(376)
            RemoveIBBuff(377)
            AddIBBuff(376)
            for i = 1, item_guard[1].BoxNums do
                AddIBBuff(377)
            end

            local exp1 = GetLevel() * 1000
            AddOwnExp(exp1)
            TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")

            local nTemp = GetTaskByte(Double_Optimization, 3)
            nTemp = SetBit(nTemp, 6, 1)
            SetTaskByte(Double_Optimization, 3, nTemp)

            Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
            Msg2Player("§©y lµ lÇn tæng kÕt ­u ®·i khi b¹n rêi m¹ng h«m nay thø" .. addtimes .. ", b¹n vËn chuyÓn r­îu quý! Xin b¶o träng!")
            TaskNote(55, 1)

            Talk(2, "no", "H«m nay lµ lÇn thø <c=g>" .. addtimes .. "<c>N¹p tµi hé tèng Töu, lÇn nµy cÇn hé tèng" .. item_guard[1].BoxNums .. "B×nh r­îu! Sè lÇn chuyÓn r­îu trong ngµy cµng nhiÒu, sè r­îu chuyÓn ®­îc cµng nhiÒu!", "LÇn nµy ra ®i mu«n vµn hiÓm nguy, dµnh tÆng b¹n <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm, BÝch Du Nh©n ë gÇn §¹i Phu tÇng 5!")
            return 1
        else
            Talk(1, "no", 14667)
            return 0
        end
    else
        Talk(1, "no", "CÇn cã <c=g>1 Hång B¶o th¹ch<c> vµ" .. pm .. " l­îng. Cã ®ñ råi h·y ®Õn t×m ta nhÐ!")
        return 0
    end
end

function yes_freefsb2()
    CloseDialog()
    SetTask(TASK_Npcindex, 2)
    refreshNpcTaskState()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(67)
    local ib379 = FindAValidIBItem(8, 379, 2, 0)
    if (ib379 ~= 0) then
        if (yes_freefsb() ~= 1) then
            return 0
        end

        CostIBItem(ib379)
        Msg2Player("B¹n nép ThÇn ThuËt cho BÝch Du Nh©n nhËn ®­îc xe chuyÓn r­îu cao cÊp!")
    elseif (GetCoin() >= Cv) then
        if (yes_freefsb() ~= 1) then
            return 0
        end
        CostCoinByIdx(67)
        Msg2Player("B¹n ®· ®­a" .. Cfs .. " Th«ng B¶o nhËn ®­îc Xe chuyÓn r­îu cao cÊp.")
    else
        Msg2Player("Xin lçi! B¹n kh«ng ®ñ vËt liÖu!")

        Talk(1, "no", "Xin lçi! VËt liÖu kh«ng ®ñ! Muèn söa xe chuyÓn r­îu cÇn cã <c=r>ThÇn ThuËt<c> hoÆc <c=r>" .. Cfs .. "<c> Th«ng B¶o. ChuÈn bÞ ®ñ h·y ®Õn t×m ta!")
    end
end

function getMyCarriage()
    CloseDialog()
    if (GetTaskByte(Task_Yiqi, 2) == 2) then
        MsgBox(14661, "quxiao", "no")
        return
    end

    if (HaveIBBuff(376) <= 0) then
        MsgBox("Chñ töu qu¸n T©y Vùc:HÕt thêi gian, nhiÖm vô thÊt b¹i, ng­¬i muèn hñy bá nhiÖm vô chø", "quxiao", "no")
        return
    end

    if (GetTaskByte(TASK_renwu, 3) ~= 2) then
        Talk(1, "no", "Chñ töu qu¸n T©y Vùc:Cã thÓ ®Õn gÆp Ng­êi T©y Vùc ë T©y Kú hoÆc ta ®Ó nhËn nhiÖm vô Tèng Töu.")
        return
    end

    CloseDialog()
    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14666)
        return 0
    end

    local mapid = GetWorldPos()
    if (mapid ~= 44) then
        return
    end

    local num = math.random(1, 3)
    local px = maps[num].x
    local py = maps[num].y
    local r = math.random(0, 3)

    if (r == 0) then
        px = px + math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    elseif (r == 1) then
        px = px - math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    elseif (r == 2) then
        px = px + math.random(maps[num].r)
        py = py - math.random(maps[num].r)
    else
        px = px - math.random(maps[num].r)
        py = py + math.random(maps[num].r)
    end ;

    px = 32 * px
    py = 32 * py

    local temp = GetTaskByte(TASK_renwu, 2)
    local times, addtimes = todayfreetimes(temp)

    local carKey = GetTask(TASK_Npcindex) + 647
    local boxindex = NewSiegeWeapon(mapid, px, py, carKey)

    local boxnpcindex = GetSiegeWeaponNpcIndex(boxindex)
    if (boxnpcindex > 0) then
        local playername = GetName()
        if (carKey == 649) then
            SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ2.lua")
        else
            SetNpcScript(boxnpcindex, "\\script\\±ÌÓÎ¹¬\\½õºÏ1.lua")
        end

        SetNpcTask(boxnpcindex, 1, GetPlayerID())
        SetNpcTask(boxnpcindex, 2, LocalSystemTime())
        WriteLog("[VËn chuyÓn R­îu][B¸ch Niªn TrÇn Nh­ìng]²¹¼Ó³É¹¦")

        SendCarriage(boxindex, playername, 1, GetIBBuffLeftTimes(376))
        SetGuardLevel(boxnpcindex, 1)
        SetTaskByte(Task_Yiqi, 2, 2)
        refreshNpcTaskState()

        local nNum = 3
        if (GetTaskByte(Task_Yiqi, 3) == 1) then
            nNum = item_guard[times].BoxNums
        end

        RemoveIBBuff(377)

        for i = 1, nNum do
            AddIBBuff(377)
        end

        TaskNote(55, 1)
    end
end
