Task_Improve = 1351

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

    startLevel = 35
    if (GetLevel() >= startLevel and GetTask(997) == 0 and GetTaskByte(813, 2) == 0 and GetTask(815) ~= 0 and (HaveEventItem(49) >= 1 or HaveEventItem(164) >= 1)) then
        if (GetLevel() - startLevel <= 5) then
            if ((HaveNormalItem(3, GetTaskByte(322, 1), 0, 0) >= GetTaskByte(322, 2) and (GetCash() >= 1000) and GetTask(322) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 0
            elseif (GetTask(322) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if ((HaveNormalItem(3, GetTaskByte(322, 1), 0, 0) >= GetTaskByte(322, 2) and (GetCash() >= 1000) and GetTask(322) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 1
            elseif (GetTask(322) ~= 0) then
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

function main(sel)
    local treeStr = "Bãn ph©n"

    if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
        treeStr = "<c=pk>Bãn ph©n<c>"
    elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
        treeStr = "<c=g>Bãn ph©n<c>"
    end
    tasks = {
        { treeStr, "renwu"; show = 0 },
        { "B¾t s©u", "chuansong1"; show = 0 },
        { "T­íi n­íc", "chuansong2"; show = 0 },
        { "Mua ®Ìn", "ma"; show = 1 },
    }

    if (GetLevel() >= 35) and (HaveEventItem(49) >= 1) and (GetTask(321) == 0) and (GetTask(323) == 0) and (GetTask(804) == 1) then
        tasks[1].show = 1
        tasks[2].show = 1
        tasks[3].show = 1
        SayTask(11155, tasks)
    elseif (GetLevel() >= 35) and (HaveEventItem(164) >= 1) and (GetTask(321) == 0) and (GetTask(323) == 0) and (GetTask(804) == 2) then
        tasks[1].show = 1
        tasks[2].show = 1
        tasks[3].show = 1
        SayTask(11155, tasks)
    else
        SayTask(10142, tasks)
    end ;
end;

function chuansong1()
    MsgBox("C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Sïng øng B­u<c> ë Sïng Thµnh lo viÖc <c=r>B¾t s©u<c>. Ta cã thÓ giíi thiÖu ng­¬i ®Õn ®ã, cã muèn t×m h¾n kh«ng?", "cs_1", "no")
end

function chuansong2()
    MsgBox("C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Linh B¶o ®¹i ph¸p s­<c> ë Ngäc H­ Cung lo viÖc <c=r>T­íi n­íc<c>. Ta cã thÓ giíi thiÖu ng­¬i ®Õn ®ã, cã muèn t×m ph¸p s­ kh«ng?", "cs_2", "no")
end

function cs_1()
    CloseDialog()
    local cost = gettranscost()
    if (GetCash() >= cost) then
        NewWorld(2, 1690, 3120)
        PrePay(cost)
    else
        Msg2Player("B¹n kh«ng ®ñ tiÒn!")
    end
end

function cs_2()
    CloseDialog()
    local cost = gettranscost()
    if (GetCash() >= cost) then
        NewWorld(3, 1664, 3142)
        PrePay(cost)
    else
        Msg2Player("B¹n kh«ng ®ñ tiÒn!")
    end
end

function gettranscost()
    local penny
    if (GetLevel() <= 30) then
        penny = 200
    elseif (GetLevel() > 30) and (GetLevel() <= 50) then
        penny = 500
    elseif (GetLevel() > 50) and (GetLevel() <= 70) then
        penny = 1000
    elseif (GetLevel() > 70) and (GetLevel() <= 90) then
        penny = 2000
    else
        penny = 5000
    end ;
    return penny
end

function ma()
    if (GetCash() >= 5000) then
        Talk(1, "no", 10144)
        Pay(5000);
        AddEventItem(41)
    else
        Talk(1, "no", 10145)
    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    CloseDialog()
    if (GetTask(320) >= 11) then

        local ZZtype = GetTask(804)
        if ((ZZtype == 1) and (HaveEventItem(49) >= 1)) then
            DelEventItem(49)
        elseif ((ZZtype == 2) and (HaveEventItem(164) >= 1)) then
            DelEventItem(164)
        end

        local er = GetLevel() * 2800
        AddOwnExp(er)
        Talk(1, "no", "Th­ëng ng­¬i" .. er .. " kinh nghiÖm, h·y nhËn l¹i nhiÖm vô ®i")
        SetTask(320, 0)
        SetTask(321, 0)
        SetTask(322, 0)
        SetTask(323, 0)
        SetTask(324, 0)
        SetTask(325, 0)
        SetTask(326, 0)
        SetTask(327, 0)
        SetTask(815, 0)
        SetTaskWord(813, 2, 0)
        SetTask(804, 0)
        TaskNote(60, -1)
        return
    end

    if (GetTask(320) >= 10) then
        Talk(1, "no", 11156)
        TaskNote(60, 6)
        return
    end ;
    local failNum = GetTaskByte(Task_Improve, 2)
    local j = GetTaskByte(322, 1)
    if (j == 0) then
        local i = math.random(1, 4);
        local w = ""
        if (i == 1) then
            w = "§Þa T©m"
        elseif (i == 2) then
            w = "Phong LÖ"
        elseif (i == 3) then
            w = "Thñy Hån"
        elseif (i == 4) then
            w = "Háa Linh"
        end ;

        if (GetLevel() <= 90) then
            Talk(2, "no", "Tèt! Nguyªn liÖu lÇn nµy ta cÇn lµ 10 <c=r>" .. w .. "<c>.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(322, 1, i + 21)
            Msg2Player("§ång ý t×m cho Cao Gi¸c 10" .. w .. ".")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 5, w)
            SetTaskByte(322, 2, 10)
        else
            Talk(2, "no", "Tèt! Nguyªn liÖu lÇn nµy ta cÇn lµ 10 <c=r>" .. w .. "<color> 20.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(322, 1, i + 21)
            Msg2Player("§ång ý t×m cho Cao Gi¸c 10" .. w .. "20.")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 8, w)
            SetTaskByte(322, 2, 20)
        end ;

        refreshNpcTaskState()

    else


        local xuqiu = GetTaskByte(322, 2)
        if (HaveNormalItem(3, j, 0, 0) >= xuqiu) and (GetCash() >= 1000) then
            for a = 1, xuqiu do
                DelNormalItem(3, j, 0, 0)
            end ;
            Pay(1000)
            TaskNote(60, 2)
            local k = GetTask(325)

            local l = math.random(1, 100)

            if (failNum >= 2) then
                l = 100

            elseif (GetTask(320) >= 8) and (failNum >= 1) then
                if (l <= k) then
                    l = math.random(1, 100)
                end
            end

            local times = math.floor((GetTask(320) + 1) / 2)

            if ((l > k or HaveIBBuff(1481) > 0) and ((GetGlobalValue(6) == 0) or (GetTask(327) <= 46))) then


                local n1 = math.random(1, 9)
                if (n1 == 1) then
                    chengzhang = 6
                elseif (n1 == 2) or (n1 == 3) then
                    chengzhang = 7
                elseif (n1 == 4) or (n1 == 5) or (n1 == 6) then
                    chengzhang = 8
                elseif (n1 == 7) or (n1 == 8) then
                    chengzhang = 9
                else
                    chengzhang = 10
                end

                if (HaveIBBuff(1481) > 0) then
                    local nExc1 = math.random(1, 2)
                    chengzhang = chengzhang + nExc1
                    RemoveIBBuff(1481)
                    Msg2Player("C©y mÇm nhËn ®­îc chóc phóc cña Thiªn §×nh, ch¨m sãc nhËn thªm" .. nExc1 .. " ®iÓm tr­ëng thµnh.")
                end

                local jieguo = chengzhang + GetTask(327)
                if (jieguo >= 55) then
                    chengzhang = 54 - GetTask(327)
                end

                SetTask(327, GetTask(327) + chengzhang)
                local nExp = 500 * GetLevel()
                if (GetTask(320) >= 8) then
                    nExp = 1200 * GetLevel()
                end

                local nexp1 = nExp * 0.5
                if (GetTaskByte(813, 3) == 0) and (GetWeekDay() == 5) and (math.floor(LocalSystemTime() / 86400) == math.floor(GetTask(816) / 86400)) then

                    Msg2Player("Chñ ®Ò nhiÖm vô h«m nay lµ Thiªn Thô! Chóc mõng b¹n nhËn ®­îc phÇn th­ëng nh©n ®«i!")
                    local nDoubel = 2
                    local nDoubleBuff = 1480

                    if (HaveIBBuff(1523) > 0) then
                        nDoubel = nDoubel + 1
                        CostIBBuff(1523, 1)
                        Msg2Player("Do sö dông Phï nhiÖm vô chñ ®Ò ngµy, phÇn th­ëng t¨ng thªm 100%. ")
                    end

                    local bHaveBuff = HaveIBBuff(nDoubleBuff)
                    local nBuffLevel = GetIBBuffLevel(nDoubleBuff) + 1
                    if (bHaveBuff > 0 and nBuffLevel > 0 and nBuffLevel <= 10) then
                        nDoubel = nDoubel + nBuffLevel
                        Msg2Player("HiÖn t¹i lµ thêi gian ho¹t ®éng chñ ®Ò x2, nhËn ®­îc nhiÒu phÇn th­ëng h¬n. ")
                    end
                    nExp = math.floor(nExp * nDoubel)

                end

                if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
                    nExp = nExp + nexp1 * 2
                elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
                    nExp = nExp + nexp1
                end
                if (GetTaskByte(813, 4) == 2) then
                    nExp = nExp * 2
                end
                AddOwnExp(nExp)
                Msg2Player("MÇm c©y cña ng­¬i ®· trång ®­îc" .. times .. "lÇn, nhËn ®­îc " .. nExp .. " kinh nghiÖm, ®é tr­ëng thµnh hiÖn t¹i: <c=g>" .. GetTask(327) .. "<c>.")
                TopMessage("NhËn ®­îc <color = green>" .. nExp .. "<c> kinh nghiÖm")
                SetTask(320, GetTask(320) + 1)
                Talk(1, "no", "Tèt l¾m! MÇm c©y cña ng­¬i ®· ®­îc nu«i <c=g>" .. times .. "<c> lÇn. LÇn nµy ®· nhËn ®­îc <color=green>" .. chengzhang .. "<c> ®iÓm tr­ëng thµnh, ®é tr­ëng thµnh hiÖn t¹i lµ <c=g>" .. GetTask(327) .. "<color>.C©y gièng nµy chØ ®­îc trång tæng céng 5 lÇn, vµ nÕu bãn ph©n nhiÒu qu¸ sÏ ¶nh h­ëng xÊu ®Õn qu¸ tr×nh sinh tr­ëng cña c©y.")
            else
                failNum = failNum + 1
                SetTaskByte(Task_Improve, 2, failNum)
                SetTask(327, GetTask(327) + 2)
                SetTask(320, GetTask(320) + 1)

                AddIBBuff(1481)
                Msg2Player("LÇn ch¨m sãc nµy ®­îc Thiªn §×nh chóc phóc, c©y trång lÇn sau sÏ nhËn ®­îc ®é tr­ëng thµnh. ")

                Talk(1, "no", "Ng­¬i bãn ph©n nhiÒu qu¸, mÇm nµy kh«ng lý t­ëng l¾m, dï sao c©y còng ®­îc nu«i <c=g>" .. times .. "<c> lÇn, lÇn nµy nã thu ®­îc <color=green>2 ®iÓm<color> ®é thµnh tr­ëng, ®é thµnh tr­ëng hiÖn nay lµ <color=green>" .. GetTask(327) .. "<c>.")
            end ;
            SetTask(322, 0)

            refreshNpcTaskState()

            local m = GetTask(325) + 13
            if m > 100 then
                m = 100
            end ;
            SetTask(325, m)

            local n = GetTask(324) - 7
            if n <= 0 then
                n = 7
            end ;
            SetTask(324, n)

            local o = GetTask(326) - 7
            if o <= 0 then
                o = 5
            end ;
            SetTask(326, o)
        elseif (HaveNormalItem(3, j, 0, 0) < xuqiu) then
            local w = ""
            if (j == 22) then
                w = "§Þa T©m"
            elseif (j == 23) then
                w = "Phong LÖ"
            elseif (j == 24) then
                w = "Thñy Hån"
            elseif (j == 25) then
                w = "Háa Linh"
            end ;
            Talk(1, "no", "LÇn ch¨m bãn nµy, cÇn t×m <color=green>" .. xuqiu .. "." .. w .. "<c>, ng­¬i mau ®i lÊy vÒ, nÕu trÔ sÏ háng hÕt.")
        elseif (GetCash() < 1000) then
            Talk(1, "no", 12338)
        else
            Talk(1, "no", 11157)
        end ;
    end ;
end;
