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

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(15)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(15)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 35
    if (GetLevel() >= startLevel and GetTask(997) == 0 and GetTaskByte(813, 2) == 0 and GetTask(815) ~= 0 and (HaveEventItem(49) >= 1 or HaveEventItem(164) >= 1)) then
        if (GetLevel() - startLevel <= 5) then
            if ((HaveNormalItem(3, GetTaskByte(321, 1), 0, 0) >= GetTaskByte(321, 2) and GetCash() >= 1000 and GetTask(321) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 0
            elseif (GetTask(321) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if ((HaveNormalItem(3, GetTaskByte(321, 1), 0, 0) >= GetTaskByte(321, 2) and GetCash() >= 1000 and GetTask(321) ~= 0) or (GetTask(320) < 10 and GetTask(321) == 0 and GetTask(322) == 0 and GetTask(323) == 0)) then
                state = 3
                subState = 1
            elseif (GetTask(321) ~= 0) then
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
    local treeStr = "T­íi n­íc"

    if (GetLevel() >= 110) and (GetTask(1027) >= 400) then
        treeStr = "<c=pk>T­íi n­íc<c>"
    elseif (GetLevel() >= 75) and (GetTask(1027) >= 130) then
        treeStr = "<c=g>T­íi n­íc<c>"
    end
    tasks = {
        { "<c=yel>Kh¶o nghiÖm<c>", "renwu2"; show = 0 },


        { treeStr, "renwu"; show = 0 },
        { "B¾t s©u", "chuansong1"; show = 0 },
        { "Bãn ph©n", "chuansong2"; show = 0 },

        { "Ph¸p b¶o ChÝ T«n", "ExchangeAmulet"; show = 1 },

    }

    UTask_05 = GetTask(15);
    if (UTask_05 == 1) then
        tasks[1].show = 1;
    end ;

    if (GetLevel() >= 35) and (HaveEventItem(49) >= 1) and (GetTask(322) == 0) and (GetTask(323) == 0) and (GetTask(804) == 1) then
        tasks[2].show = 1
        tasks[3].show = 1
        tasks[4].show = 1
        SayTask(11383, tasks)
    elseif (GetLevel() >= 35) and (HaveEventItem(164) >= 1) and (GetTask(322) == 0) and (GetTask(323) == 0) and (GetTask(804) == 2) then
        tasks[2].show = 1
        tasks[3].show = 1
        tasks[4].show = 1
        SayTask(11383, tasks)
    else
        SayTask(10538, tasks)
    end ;
end;

function chuansong1()
    MsgBox("Linh B¶o ®¹i ph¸p s­:C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Sïng øng B­u<c> ë Sïng Thµnh phô tr¸ch viÖc <c=r>b¾t s©u<c>. Ta cã thÓ giíi thiÖu ng­¬i, cã muèn t×m h¾n kh«ng?", "cs_1", "no")
end

function chuansong2()
    MsgBox("Linh B¶o ®¹i ph¸p s­:C©y thÇn bÝ ph¶i trång trong m«i tr­êng ®Æc biÖt. <c=g>Cao Gi¸c<c> ë Xi V­u Mé phô tr¸ch viÖc <c=r>bãn ph©n<c>. Ta cã thÓ giíi thiÖu ng­¬i, cã muèn t×m h¾n kh«ng?", "cs_2", "no")
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
        NewWorld(4, 1648, 3172)
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

function renwu1()
    UTask_00 = GetTask(10);
    if (UTask_00 == 1) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 3)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thÝch.")
    end ;
    if (UTask_00 == 5) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 4)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thÝch.")
    end ;
    if (UTask_00 == 9) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 6)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thÝch.")
    end ;
    if (UTask_00 == 13) then
        Talk(1, "no", 10539)
        SetTask(10, UTask_00 + 2)
        TaskNote(1, 7)
        Msg2Player("Linh B¶o ®¹i ph¸p s­ ®· chän ra ®Ö tö m×nh yªu thÝch.")
    end ;
end;

function renwu2()

    Say(10540, 3, "Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1", "Thiªn H¹ chi chÝ nhu, tr× sÝnh thiªn h¹ chi chÝ kiªn (®Ò cö)/yes_1", "Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")

end;

function yes_1()

    Say(10541, 3, "§¹i ®¹o phÕ khÝ, míi cho thÊy nh©n nghÜa (§Ò cö)/yes_2", "§¹i ®¹o phÕ khÝ liÔu, tµi s¶n sinh liÔu nh©n nghÜa/no1", "§¹i ®¹o phÕ khÝ liÔu, hoµn h÷u nh©n nghÜa t¹i/no1")

end;

function yes_2()

    Say(10542, 3, "GiÕt kh«ng ®¸ng tiÕc/no1", "Dô chi ®Ò chuyÓn bÜ/no1", "TÜnh ®·i m¹c tu cÊp (®Ò cö)/yes_3")

end;

function yes_3()

    AddOwnExp(1600)
    TopMessage("NhËn ®­îc 1600 kinh nghiÖm.")
    Msg2Player("NhËn ®­îc 1600 kinh nghiÖm.")

    Talk(1, "no", 10543)
    TaskNote(5, 1)
    Msg2Player("ThuËn lîi th«ng qua kh¶o v¨n, ®Õn cÊp 10 quay l¹i gÆp V©n Trung Tö!")
    SetTask(15, 2)

    refreshNpcTaskState()

end;

function no1()
    Talk(1, "check", 10544)
end;

function check()
    Say(10545, 3, "Tiªn thiªn h¹ chi ­u nhi ­u, hËu thiªn h¹ chi l¹c nhi l¹c/no1", "Thiªn H¹ chi chÝ nhu, tr× sÝnh thiªn h¹ chi chÝ kiªn (®Ò cö)/yes_1", "Th­îng binh ph¹t m­u, kú thø ph¹t binh, kú h¹ c«ng thµnh/no1")
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
        Talk(1, "no", "Th­ëng ng­¬i " .. er .. " kinh nghiÖm, h·y nhËn l¹i nhiÖm vô ®i")
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
        Talk(1, "no", 11384)
        TaskNote(60, 6)
        return
    end ;

    local j = GetTaskByte(321, 1)
    local failNum = GetTaskByte(Task_Improve, 2)
    if (j == 0) then
        local i = math.random(1, 6);
        local w = ""
        if (i == 1) then
            w = "Ho¶ Vò"
        elseif (i == 2) then
            w = "Ngäc Cèt"
        elseif (i == 3) then
            w = "§o¹n KiÕm"
        elseif (i == 4) then
            w = "To¸i Gi¸p"
        elseif (i == 5) then
            w = "Quû DiÖn"
        elseif (i == 6) then
            w = "B¨ng C¬"
        end ;

        if (GetLevel() <= 90) then
            Talk(2, "no", "§­îc! LÇn nµy nguyªn liÖu ta cÇn lµ <color=r>" .. w .. "<c>.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(321, 1, i + 7)
            Msg2Player("Gióp Linh B¶o ®¹i ph¸p s­ t×m" .. w .. ".")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 3, w)
            SetTaskByte(321, 2, 10)
        else
            Talk(2, "no", "§­îc! LÇn nµy nguyªn liÖu ta cÇn lµ <color=r>" .. w .. "<color> 20.", "§Ó ta ®i t×m nguyªn liÖu vÒ.")
            SetTaskByte(321, 1, i + 7)
            Msg2Player("Gióp Linh B¶o ®¹i ph¸p s­ t×m" .. w .. "20.")
            SetTask(320, GetTask(320) + 1)
            TaskNote(60, 7, w)
            SetTaskByte(321, 2, 20)
        end

        refreshNpcTaskState()


    else
        local xuqiu = GetTaskByte(321, 2)
        if (HaveNormalItem(3, j, 0, 0) >= xuqiu) and (GetCash() >= 1000) then
            for a = 1, xuqiu do
                DelNormalItem(3, j, 0, 0)
            end ;
            Pay(1000)

            TaskNote(60, 2)
            local k = GetTask(324)

            local l = math.random(1, 100)

            if (failNum >= 2) then
                l = 100

            elseif (GetTask(320) >= 8) and (failNum >= 1) then
                if (l <= k) then
                    l = math.random(1, 100)
                end
            end

            local times = math.floor((GetTask(320) + 1) / 2)

            if (l > k or HaveIBBuff(1481) > 0) and ((GetGlobalValue(6) == 0) or (GetTask(327) <= 47)) then


                local n1 = math.random(1, 4)
                if (n1 == 1) then
                    chengzhang = 6
                elseif (n1 == 2) or (n1 == 3) then
                    chengzhang = 7
                elseif (n1 == 4) then
                    chengzhang = 8
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
                Talk(1, "no", "MÇm c©y cña ng­¬i ®· ch¨m sãc ®­îc <c=g>" .. times .. "<c> lÇn. LÇn nµy nã nhËn ®­îc <c=g>" .. chengzhang .. " ®iÓm tr­ëng thµnh<c>. §é tr­ëng thµnh hiÖn t¹i lµ <c=g>" .. GetTask(327) .. "<c>. MÇn c©y nµy chØ cã thÓ nu«i d­ìng 5 lÇn, nÕu nh­ t­íi n­íc qu¸ nhiÒu sÏ ¶nh h­ëng xÊu ®Õn ®é t¬ëng thµnh cña mÇn non.")
            else
                failNum = failNum + 1
                SetTaskByte(Task_Improve, 2, failNum)
                SetTask(327, GetTask(327) + 2)
                SetTask(320, GetTask(320) + 1)

                AddIBBuff(1481)
                Msg2Player("LÇn ch¨m sãc nµy ®­îc Thiªn §×nh chóc phóc, c©y trång lÇn sau sÏ nhËn ®­îc ®é tr­ëng thµnh. ")

                Talk(1, "no", "Do ng­¬i t­íi n­íc nhiÒu qu¸, mÇm c©y lÇn nµy tr­ëng thµnh kh«ng ®­îc lý t­ëng l¾m. LÇn nµy ng­¬i ch¨m sãc ®­îc <c=g>" .. times .. "<c> lÇn, lÇn nµy nã thu ®­îc <color=green>2 ®iÓm<color> ®é thµnh tr­ëng, ®é thµnh tr­ëng hiÖn nay lµ <color=green>" .. GetTask(327) .. "<c>.")
            end ;
            SetTask(321, 0)

            refreshNpcTaskState()

            local m = GetTask(324) + 13
            if m > 100 then
                m = 100
            end ;
            SetTask(324, m)

            local n = GetTask(325) - 7
            if n <= 0 then
                n = 7
            end ;
            SetTask(325, n)

            local o = GetTask(326) - 7
            if o <= 0 then
                o = 5
            end ;
            SetTask(326, o)
        elseif (HaveNormalItem(3, j, 0, 0) < xuqiu) then
            local w = ""
            if (j == 8) then
                w = "Ho¶ Vò"
            elseif (j == 9) then
                w = "Ngäc Cèt"
            elseif (j == 10) then
                w = "§o¹n KiÕm"
            elseif (j == 11) then
                w = "To¸i Gi¸p"
            elseif (j == 12) then
                w = "Quû DiÖn"
            elseif (j == 13) then
                w = "B¨ng C¬"
            end ;
            Talk(1, "no", "LÇn t­íi n­íc nµy cÇn <color=green>" .. xuqiu .. "." .. w .. "<c>, ng­¬i mau ®i lÊy vÒ! NÕu kh«ng t­íi n­íc kÞp th× sÏ háng hÕt.")
        elseif (GetCash() < 1000) then
            Talk(1, "no", 11951)
        else
            Talk(1, "no", 11385)
        end ;
    end ;
end;

TableAmuletChange = {
    [1] = { name = "Thanh V©n KiÕm", id = { 0, 4, 50, 1 }, newname = "Ch©n-Thanh V©n B¶o KiÕm", newid = { 0, 4, 50, 3 }, levelupID = 2018,
            attribtables = {
                [0] = { { 124, 15 }, { 121, 10 }, { 182, 10 }, },
                [1] = { { 124, 18 }, { 121, 13 }, { 182, 10 }, },
                [2] = { { 124, 21 }, { 121, 16 }, { 182, 10 }, },
                [3] = { { 124, 24 }, { 121, 19 }, { 182, 13 }, },
                [4] = { { 124, 27 }, { 121, 22 }, { 182, 13 }, },
                [5] = { { 124, 30 }, { 121, 25 }, { 182, 13 }, },
                [6] = { { 124, 33 }, { 121, 28 }, { 182, 16 }, },
                [7] = { { 124, 39 }, { 121, 34 }, { 182, 16 }, },
                [8] = { { 124, 45 }, { 121, 40 }, { 182, 16 }, },
                [9] = { { 124, 51 }, { 121, 46 }, { 182, 20 }, },
                [10] = { { 124, 59 }, { 121, 54 }, { 182, 22 }, },
                [11] = { { 124, 67 }, { 121, 62 }, { 182, 24 }, },
                [12] = { { 124, 75 }, { 121, 70 }, { 182, 26 }, },
            },
    },
    [2] = { name = "Ngäc Nh­ ý ", id = { 0, 4, 51, 1 }, newname = "Ch©n-BÝch Ngäc Nh­ ý", newid = { 0, 4, 51, 3 }, levelupID = 2019,
            attribtables = {
                [0] = { { 123, 10 }, { 150, 40 }, { 114, 8 }, },
                [1] = { { 123, 12 }, { 150, 45 }, { 114, 8 }, },
                [2] = { { 123, 14 }, { 150, 50 }, { 114, 8 }, },
                [3] = { { 123, 16 }, { 150, 55 }, { 114, 9 }, },
                [4] = { { 123, 18 }, { 150, 60 }, { 114, 9 }, },
                [5] = { { 123, 20 }, { 150, 65 }, { 114, 9 }, },
                [6] = { { 123, 22 }, { 150, 70 }, { 114, 10 }, },
                [7] = { { 123, 26 }, { 150, 80 }, { 114, 10 }, },
                [8] = { { 123, 30 }, { 150, 90 }, { 114, 10 }, },
                [9] = { { 123, 34 }, { 150, 100 }, { 114, 13 }, },
                [10] = { { 123, 39 }, { 150, 112 }, { 114, 14 }, },
                [11] = { { 123, 44 }, { 150, 124 }, { 114, 15 }, },
                [12] = { { 123, 49 }, { 150, 136 }, { 114, 16 }, },
            },
    },
    [3] = { name = "Háa Tú Bµ", id = { 0, 4, 52, 1 }, newname = "Ch©n-LiÖt DiÖm Tú Bµ", newid = { 0, 4, 52, 3 }, levelupID = 2020,
            attribtables = {
                [0] = { { 122, 15 }, { 166, 40 }, { 216, 50 }, },
                [1] = { { 122, 18 }, { 166, 45 }, { 216, 50 }, },
                [2] = { { 122, 21 }, { 166, 50 }, { 216, 50 }, },
                [3] = { { 122, 24 }, { 166, 55 }, { 216, 55 }, },
                [4] = { { 122, 27 }, { 166, 60 }, { 216, 55 }, },
                [5] = { { 122, 30 }, { 166, 65 }, { 216, 55 }, },
                [6] = { { 122, 33 }, { 166, 70 }, { 216, 60 }, },
                [7] = { { 122, 39 }, { 166, 80 }, { 216, 60 }, },
                [8] = { { 122, 45 }, { 166, 90 }, { 216, 60 }, },
                [9] = { { 122, 51 }, { 166, 100 }, { 216, 70 }, },
                [10] = { { 122, 59 }, { 166, 112 }, { 216, 80 }, },
                [11] = { { 122, 67 }, { 166, 124 }, { 216, 90 }, },
                [12] = { { 122, 75 }, { 166, 136 }, { 216, 100 }, },
            },
    },
    [4] = { name = "An MÖnh Phï", id = { 0, 4, 53, 1 }, newname = "Ch©n-An MÖnh ThÇn Phï", newid = { 0, 4, 53, 3 }, levelupID = 2021,
            attribtables = {
                [0] = { { 177, 15 }, { 179, 20 }, { 118, 10 }, },
                [1] = { { 177, 18 }, { 179, 23 }, { 118, 10 }, },
                [2] = { { 177, 21 }, { 179, 26 }, { 118, 10 }, },
                [3] = { { 177, 24 }, { 179, 29 }, { 118, 12 }, },
                [4] = { { 177, 27 }, { 179, 32 }, { 118, 12 }, },
                [5] = { { 177, 30 }, { 179, 35 }, { 118, 12 }, },
                [6] = { { 177, 33 }, { 179, 38 }, { 118, 14 }, },
                [7] = { { 177, 39 }, { 179, 44 }, { 118, 14 }, },
                [8] = { { 177, 45 }, { 179, 50 }, { 118, 14 }, },
                [9] = { { 177, 53 }, { 179, 58 }, { 118, 18 }, },
                [10] = { { 177, 61 }, { 179, 68 }, { 118, 20 }, },
                [11] = { { 177, 69 }, { 179, 78 }, { 118, 22 }, },
                [12] = { { 177, 77 }, { 179, 88 }, { 118, 25 }, },
            },
    },
}
function ExchangeAmulet()
    no()
    local tasks = {
        { "§æi Ph¸p b¶o ChÝ T«n", "GetNewAmuletFun"; show = 1 },
        { "Thay ®æi Ph¸p b¶o ChÝ T«n", "ExchangeAmuletBasePro"; show = 1 },
        { "Th¨ng cÊp Ph¸p b¶o Cùc PhÈm", "ExchangeAmulet_100"; show = 1 },
        { "Giíi thiÖu Ph¸p b¶o ChÝ T«n", "NewAmuletIntro"; show = 1 },
    }
    SayTask("Ph¸p b¶o ChÝ T«n lµ vËt thÕ gian hiÕm cã, ng­¬i t×m ®ñ nguyªn liÖu cã thÓ ë chç ta ®æi nhiÒu lo¹i <c=g>Ph¸p b¶o ChÝ T«n<c>!", tasks)
end
function ExchangeAmulet_100()
    no()
    MsgBox("NÕu anh hïng cã ph¸p b¶o cÊp 100 Cùc PhÈm(Thanh V©n KiÕm, Ngäc Nh­ ý, Ho¶ Tú Bµ, An MÖnh Phï max thuéc tÝnh) chØ cÇn ®­a thªm cho ta <c=g> 20 c¸i Ph¸p B¶o Tinh Hoa<c> ta cã thÓ gióp ng­¬i th¨ng cÊp thµnh ph¸p b¶o cã thuéc tÝnh cao h¬n!", "ExchangeAmuletSure", "no")

end
function ExchangeAmuletSure()
    MsgBox("Chän Ph¸p b¶o Cùc PhÈm muèn th¨ng cÊp.", "ExchangeAmulet_Select", "no")
end
function ExchangeAmulet_Select()
    CloseDialog()
    MouseSelect(1, 23, "ExchangeAmulet_Select_2", "no")
end
function ExchangeAmulet_Select_2(itemID)
    no()
    local nSelectID = 0
    local itemGen = GetItemGen(itemID)
    local itemdel = GetItemDetail(itemID)
    local itempp = GetItemPartByID(itemID)
    local itemzl = GetItemExpiredTimeByID(itemID)
    local itemlvl = GetLevelByID(itemID)
    local itemup = GetItemLevelUpTimesByID(itemID)
    local lockType = GetItemLockType(itemID)
    local isSxhLock = IsItemSxhLock(itemID)

    for i = 1, table.getn(TableAmuletChange) do
        if (itemGen == TableAmuletChange[i].id[1] and itemdel == TableAmuletChange[i].id[2] and itempp == TableAmuletChange[i].id[3] and itemlvl == TableAmuletChange[i].id[4]) then
            nSelectID = i
            break
        end
    end
    if (nSelectID == 0) then
        Talk(1, "no", "ThËt xin lçi, vËt phÈm ngµi lùa chän kh«ng ph¶i lµ <c=g>ph¸p b¶o cÊp 100<c> hoÆc lo¹i ph¸p b¶o kh«ng ®óng.")
        return
    end

    if (itemzl > 0) then
        Talk(1, "no", "ThËt xin lçi, ph¸p b¶o ngµi chän lµ lo¹i cã thêi h¹n, kh«ng phï hîp yªu cÇu.")
        return
    end

    SetTask(140, itemID)
    MsgBox("§em Ph¸p b¶o Cùc PhÈm nµy th¨ng cÊp thµnh ph¸p b¶o thuéc tÝnh cao h¬n, cÇn tiªu hao <c=g> 20 c¸i Ph¸p B¶o Tinh Hoa<c>, x¸c ®Þnh th¨ng cÊp?", "ExchangeAmulet_Sure", "no")
end
function ExchangeAmulet_Sure()
    no()
    local itemID = GetTask(140)
    if (itemID <= 0) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng.")
        return
    end
    SetTask(140, 0)
    local nSelectID = 0
    local itemGen = GetItemGen(itemID)
    local itemdel = GetItemDetail(itemID)
    local itempp = GetItemPartByID(itemID)
    local itemzl = GetItemExpiredTimeByID(itemID)
    local itemlvl = GetLevelByID(itemID)
    local itemup = GetItemLevelUpTimesByID(itemID)
    local lockType = GetItemLockType(itemID)
    local isSxhLock = IsItemSxhLock(itemID)
    local nItemBind = IsItemBind(itemID)
    local tTable = GetEquipMagicAttribs(itemID)
    local nAllStarts = 1

    for i = 1, table.getn(TableAmuletChange) do
        if (itemGen == TableAmuletChange[i].id[1] and itemdel == TableAmuletChange[i].id[2] and itempp == TableAmuletChange[i].id[3] and itemlvl == TableAmuletChange[i].id[4]) then
            nSelectID = i
            break
        end
    end
    if (nSelectID == 0) then
        Talk(1, "no", "ThËt xin lçi, vËt phÈm ngµi lùa chän kh«ng ph¶i lµ ph¸p b¶o cÊp 100 hoÆc lo¹i ph¸p b¶o kh«ng ®óng.")
        return
    end

    if (itemzl > 0) then
        Talk(1, "no", "ThËt xin lçi, ph¸p b¶o ngµi chän lµ lo¹i cã thêi h¹n, kh«ng phï hîp yªu cÇu.")
        return
    end

    if (itemup < 0 or itemup > 12) then
        Talk(1, "no", "ThËt xin lçi, ngµi lùa chän kh«ng ®óng, kh«ng thÓ ®æi.")
        return
    end
    local tTabke2 = TableAmuletChange[nSelectID].attribtables[itemup]
    for i = 1, table.getn(tTable) do
        for j = 1, table.getn(tTabke2) do
            if (tTable[i][1] == tTabke2[j][1]) then
                if (tTable[i][2] ~= tTabke2[j][2]) then
                    nAllStarts = 0
                    break
                end
            end
        end
    end

    if (nAllStarts == 0) then
        Talk(1, "no", "ThËt xin lçi, ph¸p b¶o cña ngµi ch­a <c=g>®Çy thuéc tÝnh<c> (Ph¸p b¶o Cùc PhÈm cã 2 dßng max thuéc tÝnh).")
        return
    end

    local nItemCount = HaveNormalItem(3, 1265, 0, 0)
    if (nItemCount < 20) then
        Talk(1, "no", "ThËt xin lçi, <c=g>Ph¸p B¶o Tinh Hoa<c> cña ngµi ch­a ®ñ 20 c¸i.")
        return
    end

    for i = 1, 20 do
        DelNormalItem(3, 1265, 0, 0)
    end

    DelItemByID(itemID)
    local nItemID = AddNormalItem4(TableAmuletChange[nSelectID].newid[1], TableAmuletChange[nSelectID].newid[2], TableAmuletChange[nSelectID].newid[3], TableAmuletChange[nSelectID].newid[4], 0, TableAmuletChange[nSelectID].levelupID, itemup)
    if (lockType == 1) then
        SetItemLock(nItemID, 1, 1)
    end
    if (isSxhLock > 0) then
        SetItemSxhLock(nItemID, 1, 0)
    end
    if (nItemBind > 0) then
        SetItemBind(nItemID, 1)
    end
    Talk(1, "no", "Ngµi thµnh c«ng ®æi " .. TableAmuletChange[nSelectID].newname)
    WriteLog("[§æi ph¸p b¶o][" .. TableAmuletChange[nSelectID].name .. "]")
end

TableDecompose = {
    [1] = {
        name = "ChÝ T«n-Thanh Ngäc B¶o Nang",
        { proname = "Th­êng", id = { 0, 4, 99 }, },
        { proname = "Háa", id = { 0, 4, 106 }, },
        { proname = "B¨ng", id = { 0, 4, 113 }, },
        { proname = "L«i", id = { 0, 4, 120 }, },
        { proname = "Thæ", id = { 0, 4, 127 }, },
    },
    [2] = {
        name = "ChÝ T«n-DiÔm V©n Tiªn CÇm",
        { proname = "Th­êng", id = { 0, 4, 100 }, },
        { proname = "Háa", id = { 0, 4, 107 }, },
        { proname = "B¨ng", id = { 0, 4, 114 }, },
        { proname = "L«i", id = { 0, 4, 121 }, },
        { proname = "Thæ", id = { 0, 4, 128 }, },
    },
    [3] = {
        name = "ChÝ T«n-Ch©n Thanh Ngäc B¶o Nang",
        { proname = "Th­êng", id = { 0, 4, 101 }, },
        { proname = "Háa", id = { 0, 4, 108 }, },
        { proname = "B¨ng", id = { 0, 4, 115 }, },
        { proname = "L«i", id = { 0, 4, 122 }, },
        { proname = "Thæ", id = { 0, 4, 129 }, },
    },
    [4] = {
        name = "ChÝ T«n-Ch©n DiÔm V©n Tiªn CÇm",
        { proname = "Th­êng", id = { 0, 4, 102 }, },
        { proname = "Háa", id = { 0, 4, 109 }, },
        { proname = "B¨ng", id = { 0, 4, 116 }, },
        { proname = "L«i", id = { 0, 4, 123 }, },
        { proname = "Thæ", id = { 0, 4, 130 }, },
    },
    [5] = {
        name = "ChÝ T«n-Kim Quang Phiªn Thiªn Ên (VËt lý)",
        { proname = "Th­êng", id = { 0, 4, 103 }, },
        { proname = "Háa", id = { 0, 4, 110 }, },
        { proname = "B¨ng", id = { 0, 4, 117 }, },
        { proname = "L«i", id = { 0, 4, 124 }, },
        { proname = "Thæ", id = { 0, 4, 131 }, },
    },
    [6] = {
        name = "ChÝ T«n-Cöu Long ThÇn Ho¶ Tr¸o",
        { proname = "Th­êng", id = { 0, 4, 104 }, },
        { proname = "Háa", id = { 0, 4, 111 }, },
        { proname = "B¨ng", id = { 0, 4, 118 }, },
        { proname = "L«i", id = { 0, 4, 125 }, },
        { proname = "Thæ", id = { 0, 4, 132 }, },
    },
    [7] = {
        name = "ChÝ T«n-Kim Quang Phiªn Thiªn Ên (Ph¸p thuËt)",
        { proname = "Th­êng", id = { 0, 4, 105 }, },
        { proname = "Háa", id = { 0, 4, 112 }, },
        { proname = "B¨ng", id = { 0, 4, 119 }, },
        { proname = "L«i", id = { 0, 4, 126 }, },
        { proname = "Thæ", id = { 0, 4, 133 }, },
    },
}
function ExchangeAmuletBasePro()
    no()

    MsgBox("Thuéc tÝnh c¬ b¶n cña Ph¸p b¶o ChÝ T«n lµ <c=g>S¸t th­¬ng c¬ b¶n<c>, t¹i chç ta cã thÓ ®em Ph¸p b¶o ChÝ T«n ch­a c­êng ho¸ thay ®æi thµnh nh÷ng lo¹i thuéc tÝnh kh¸c (<c=g>Ho¶ S¸t, L«i S¸t, B¨ng S¸t, Thæ S¸t<c>, h·y chän lo¹i ph¸p b¶o muèn ®æi:", "ExchangeAmuletBasePro_1", "no")
end
function ExchangeAmuletBasePro_1()
    CloseDialog()
    MouseSelect(1, 23, "ExchangeAmuletBasePro_2", "no")
end

function ExchangeAmuletBasePro_2(itemID)

    local nSelectID = 0
    local nSelectSubID = 0
    local itemGen = GetItemGen(itemID)
    local itemdel = GetItemDetail(itemID)
    local itempp = GetItemPartByID(itemID)
    local itemzl = GetItemExpiredTimeByID(itemID)

    local itemup = GetItemLevelUpTimesByID(itemID)
    local lockType = GetItemLockType(itemID)
    local isSxhLock = IsItemSxhLock(itemID)

    for i = 1, table.getn(TableDecompose) do
        for j = 1, table.getn(TableDecompose[i]) do
            if (itemGen == TableDecompose[i][j].id[1] and itemdel == TableDecompose[i][j].id[2] and itempp == TableDecompose[i][j].id[3]) then
                nSelectID = i
                nSelectSubID = j
                break
            end
        end
    end
    if (nSelectID < 1 or nSelectID > table.getn(TableDecompose) or nSelectSubID < 1 or nSelectSubID > table.getn(TableDecompose[nSelectSubID])) then
        Talk(1, "no", "ThËt xin lçi, vËt phÈm ngµi lùa chän kh«ng ph¶i lµ Ph¸p b¶o ChÝ T«n, kh«ng thÓ ®æi.")
        return
    end
    if (itemzl > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän lµ lo¹i cã thêi h¹n, kh«ng thÓ ®æi.")
        return
    end
    if (isSxhLock > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän ®· nhËp chó, h·y gi¶i trõ tr­íc.")
        return
    end
    if (itemup > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän ®· c­êng ho¸, kh«ng thÓ ®æi.")
        return
    end
    local opra = {}
    for i = 1, table.getn(TableDecompose[nSelectID]) do
        opra[table.getn(opra) + 1] = TableDecompose[nSelectID].name .. " (" .. TableDecompose[nSelectID][i].proname .. ")" .. "/ExchangeAmuletBasePro_3"
    end
    SetTask(140, itemID)
    SetTask(141, nSelectID)
    Say("H·y <c=g>chän thuéc tÝnh c¬ b¶n<c> muèn thay ®æi, (®æi cÇn tiªu hao 3 c¸i Ph¸p B¶o Tinh Hoa) ", table.getn(opra), opra)
end
function ExchangeAmuletBasePro_3(nIndex)
    no()
    local itemID = GetTask(140)
    local nSelectID = GetTask(141)
    if (nSelectID < 1 or nSelectID > table.getn(TableDecompose)) then
        Talk(1, "no", "Lùa chän sai.")
        return
    end
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > table.getn(TableDecompose[nSelectID])) then
        Talk(1, "no", "Lùa chän sai.")
        return
    end
    local nameItem = GetItemName(ItemID)
    SetTask(142, nIndex)
    MsgBox("Ngµi x¸c nhËn ®em ph¸p b¶o <c=g>" .. nameItem .. "<c> ®æi thµnh " .. TableDecompose[nSelectID].name .. " (" .. TableDecompose[nSelectID][nIndex].proname .. ")?", "ExchangeAmuletBasePro_4", "no")
end
function ExchangeAmuletBasePro_4()
    no()
    local itemID = GetTask(140)
    local nSelectID = GetTask(141)
    local nSelectSubID = GetTask(142)
    local itemGen = GetItemGen(itemID)
    local itemdel = GetItemDetail(itemID)
    local itempp = GetItemPartByID(itemID)
    local itemzl = GetItemExpiredTimeByID(itemID)

    local itemup = GetItemLevelUpTimesByID(itemID)
    local lockType = GetItemLockType(itemID)
    local isSxhLock = IsItemSxhLock(itemID)
    local nItemBind = IsItemBind(itemID)

    if (nSelectID < 1 or nSelectID > table.getn(TableDecompose) or nSelectSubID < 1 or nSelectSubID > table.getn(TableDecompose[nSelectSubID])) then
        Talk(1, "no", "ThËt xin lçi, vËt phÈm ngµi lùa chän kh«ng ph¶i lµ Ph¸p b¶o ChÝ T«n, kh«ng thÓ ®æi.")
        return
    end
    if (itemzl > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän lµ lo¹i cã thêi h¹n, kh«ng thÓ ®æi.")
        return
    end
    if (isSxhLock > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän ®· nhËp chó, h·y gi¶i trõ tr­íc.")
        return
    end
    if (itemup > 0) then
        Talk(1, "no", "Ph¸p b¶o ngµi chän ®· c­êng ho¸, kh«ng thÓ ®æi.")
        return
    end
    local nItemCount = HaveNormalItem(3, 1265, 0, 0)
    if (nItemCount < 3) then
        Talk(1, "no", "Ngµi ch­a cã ®ñ 3 <c=g>Ph¸p B¶o Tinh Hoa<c> .")
        return
    end
    local nameItem = GetItemName(ItemID)

    DelItemByID(itemID)
    for i = 1, 3 do
        DelNormalItem(3, 1265, 0, 0)
    end

    local nItemID = AddNormalItem(TableDecompose[nSelectID][nSelectSubID].id[1], TableDecompose[nSelectID][nSelectSubID].id[2], TableDecompose[nSelectID][nSelectSubID].id[3], 1, 0, 0)
    if (lockType == 1) then
        SetItemSxhLock(nItemID, 1, 0)
    end
    if (nItemBind > 0) then
        SetItemBind(nItemID, 1)
    end
    Talk(1, "no", "Ngµi thµnh c«ng ®em " .. nameItem .. " ®æi thµnh " .. TableDecompose[nSelectID].name .. " (" .. TableDecompose[nSelectID][nSelectSubID].proname .. ")")
    WriteLog("[§æi ph¸p b¶o][Src " .. nameItem .. "][Dest" .. TableDecompose[nSelectID].name .. " (" .. TableDecompose[nSelectID][nSelectSubID].proname .. "]")
end
TableAmuletSelect = {
    [1] = { name = "ChÝ T«n-Thanh Ngäc B¶o Nang", id = { 0, 4, 99 }, active = "Thanh V©n B¶o KiÕm, BÝch Ngäc Nh­ ý", pro = "S¸t th­¬ng c¬ b¶n, TÊt c¶ thuéc tÝnh, B¨ng S¸t, TÊt c¶ kh¸ng tÝnh", req = "Ph¸p B¶o Tinh Hoa 10 c¸i, b¹c 500 v¹n", reqtable = { 500, 10 } },
    [2] = { name = "ChÝ T«n-DiÔm V©n Tiªn CÇm", id = { 0, 4, 100 }, active = "LiÖt DiÖm Tú Bµ, An MÖnh ThÇn Phï", pro = "Ho¶ S¸t, Thæ S¸t, Phßng ngù, Ph¶n ®ßn s¸t th­¬ng", req = "Ph¸p B¶o Tinh Hoa 10 c¸i, b¹c 500 v¹n", reqtable = { 500, 10 } },
    [3] = { name = "ChÝ T«n-Ch©n Thanh Ngäc B¶o Nang", id = { 0, 4, 101 }, active = "Ch©n-Thanh V©n B¶o KiÕm, Ch©n-BÝch Ngäc Nh­ ý", pro = "S¸t th­¬ng c¬ b¶n, TÊt c¶ thuéc tÝnh, B¨ng S¸t, TÊt c¶ kh¸ng tÝnh", req = "Ph¸p B¶o Tinh Hoa 20 c¸i, b¹c 1000 v¹n", reqtable = { 1000, 20 } },
    [4] = { name = "ChÝ T«n-Ch©n DiÔm V©n Tiªn CÇm", id = { 0, 4, 102 }, active = "Ch©n-LiÖt DiÖm Tú Bµ, Ch©n-An MÖnh ThÇn Phï", pro = "Ho¶ S¸t, Thæ S¸t, Phßng ngù, Ph¶n ®ßn s¸t th­¬ng", req = "Ph¸p B¶o Tinh Hoa 20 c¸i, b¹c 1000 v¹n", reqtable = { 1000, 20 } },
    [5] = { name = "ChÝ T«n-Kim Quang Phiªn Thiªn Ên (VËt lý)", id = { 0, 4, 103 }, active = "Kim S¬n, ThÊt TrÇn Trai (VËt lý)", pro = "TÊt c¶ kh¸ng tÝnh, Sinh lùc tèi ®a, XuÊt chiªu Vò khÝ, S¸t th­¬ng b¹o kÝch", req = "Ph¸p B¶o Tinh Hoa 30 c¸i, b¹c 2000 v¹n", reqtable = { 2000, 30 } },
    [6] = { name = "ChÝ T«n-Cöu Long ThÇn Ho¶ Tr¸o", id = { 0, 4, 104 }, active = "Kim S¬n, Tam Sinh Th¹ch", pro = "TÊt c¶ thuéc tÝnh, Sinh lùc tèi ®a, Gi¶m thêi gian ®ãng b¨ng, Gi¶m thêi gian thä th­¬ng", req = "Ph¸p B¶o Tinh Hoa 30 c¸i, b¹c 2000 v¹n", reqtable = { 2000, 30 } },
    [7] = { name = "ChÝ T«n-Kim Quang Phiªn Thiªn Ên  (Ph¸p thuËt)", id = { 0, 4, 105 }, active = "Kim S¬n, ThÊt TrÇn Trai (Ph¸p thuËt)", pro = "TÊt c¶ kh¸ng tÝnh, Sinh lùc tèi ®a, XuÊt chiªu Ph¸p thuËt, S¸t th­¬ng b¹o kÝch Ph¸p thuËt", req = "Ph¸p B¶o Tinh Hoa 30 c¸i, b¹c 2000 v¹n", reqtable = { 2000, 30 } },
}
function GetNewAmuletFun()
    no()
    local opra = {}
    for i = 1, table.getn(TableAmuletSelect) do
        opra[table.getn(opra) + 1] = TableAmuletSelect[i].name .. "/GetNewAmuletNext"
    end

    Say("Chän lo¹i ph¸p b¶o ngµi muèn ®æi:", table.getn(opra), opra)
end
function GetNewAmuletNext(nIndex)
    no()
    nIndex = nIndex + 1
    if (nIndex < 1 or nIndex > table.getn(TableAmuletSelect)) then
        Talk(1, "no", "Lùa chän sai.")
        return
    end
    local str = ""
    SetTask(140, nIndex)
    str = "<c=g>" .. TableAmuletSelect[nIndex].name .. "<c> do <c=g><enter>" .. TableAmuletSelect[nIndex].active .. "<c> kÝch ho¹t<enter>4 lo¹i thuéc tÝnh kÝch ho¹t lµ: <c=g>" .. TableAmuletSelect[nIndex].pro .. "<c>.<enter>§æi cÇn: <c=yel>" .. TableAmuletSelect[nIndex].req .. "<c>, ngµi x¸c ®Þnh muèn ®æi sao?"
    MsgBox(str, "GetNewAmuletThird", "no")
end
function GetNewAmuletThird()
    local nIndex = GetTask(140)
    if (nIndex < 1 or nIndex > table.getn(TableAmuletSelect)) then
        Talk(1, "no", "Lùa chän sai.")
        return
    end
    local nMoney = TableAmuletSelect[nIndex].reqtable[1]
    local nNeedCount = TableAmuletSelect[nIndex].reqtable[2]
    local nHaveCount = HaveNormalItem(3, 1265, 0, 0)
    if (nHaveCount < nNeedCount) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ " .. nNeedCount .. " <c=g>Ph¸p B¶o Tinh Hoa<c>, kh«ng thÓ ®æi.")
        return
    end
    if (GetCash() < (nMoney * 10000)) then
        Talk(1, "no", "ThËt xin lçi, ngµi ch­a ®ñ <c=r>" .. nMoney .. "<c> v¹n b¹c, kh«ng thÓ ®æi.")
        return
    end

    Pay((nMoney * 10000), 1)
    for i = 1, nNeedCount do
        DelNormalItem(3, 1265, 0, 0)
    end
    AddNormalItem(TableAmuletSelect[nIndex].id[1], TableAmuletSelect[nIndex].id[2], TableAmuletSelect[nIndex].id[3], 1, 0, 0)
    Talk(1, "no", "Chóc mõng ngµi thµnh c«ng ®æi <c=g>" .. TableAmuletSelect[nIndex].name .. "<c>.")
    WriteLog("[NhËn ph¸p b¶o][" .. TableAmuletSelect[nIndex].name .. "]")

end

function NewAmuletIntro()
    no()
    Talk(2, "NewAmuletIntro1", "Ph¸p b¶o ChÝ T«n lµ lo¹i ph¸p b¶o uy lùc thÇn kú, cã thÓ thao t¸c t¹i <c=g>« Ph¸p b¶o ChÝ T«n<c>, H×nh Thiªn t¹i Xi V­u Mé biÕt c¸ch kÝch ho¹t « Ph¸p b¶o ChÝ T«n. Mçi lo¹i ph¸p b¶o ChÝ T«n ®Òu cã 2 lo¹i thuéc tÝnh: <c=g>thuéc tÝnh c¬ b¶n<c> cïng <c=g>thuéc tÝnh kÝch ho¹t<c>", "Thuéc tÝnh c¬ b¶n lµ thuéc tÝnh mÆc ®Þnh cña ph¸p b¶o, cã thÓ th«ng qua <c=g>c­êng ho¸ Ph¸p b¶o ChÝ T«n<c> ®Ó gia t¨ng thuéc tÝnh, thuéc tÝnh kÝch ho¹t do cÊp c­êng ho¸ cña 2 lo¹i ph¸p b¶o liªn quan quyÕt ®Þnh, click vµo <c=g>h×nh th¸i cùc mµu vµng c¹nh ph¸p b¶o<c> ®Ó më giao diÖn Ph¸p b¶o ChÝ T«n.")
end;

function NewAmuletIntro1()
    no()
    Talk(2, "NewAmuletIntro2", "Thuéc tÝnh Èn cña Ph¸p b¶o ChÝ T«n do 2 ph¸p b¶o liªn quan chØ ®Þnh kÝch ho¹t <c=g>lÊy ra ph¸p b¶o liªn quan tõ « Ph¸p b¶o ChÝ T«n<c> sÏ huû kÝch ho¹t Ph¸p b¶o ChÝ T«n, lu«n cÇn ®Æt ®ñ 2 lo¹i ph¸p b¶o cÇn thiÕt míi cã thÓ kÝch ho¹t ®ñ thuéc tÝnh Ph¸p b¶o ChÝ t«n.", "C­êng ho¸ Ph¸p b¶o ChÝ T«n cÇn 3 lo¹i nguyªn liÖu <c=g>ChÝ T«n Chi Hån, ChÝ T«n Chi Linh, Ph¸p B¶o Tinh Hoa<c>, 2 lo¹i ®Çu nhËn ®­îc th«ng qua nhiÖm vô quèc gia <c=g>Tranh ®o¹t Ph¸p B¶o<c>, Ph¸p B¶o Tinh Hoa cÇn ®Õn Xi V­u Mé t×m <c=g>H×nh Thiªn<c> ®Ó t×m hiÓu.")
end;

function NewAmuletIntro2()
    no()
    Talk(2, "NewAmuletIntro3", "C­êng ho¸ ph¸p b¶o ChÝ t«n s¬ cÊp nh­ <c=g>ChÝ T«n-Thanh Ngäc B¶o Nang vµ ChÝ T«n-DiÔm V©n Tiªn CÇm<c>, c­êng ho¸ lÇn 1-3 cÇn 3 lo¹i nguyªn liÖu c­êng ho¸ mçi lo¹i 1 c¸i,4-6 cÇn 2 c¸i, 7-9 cÇn 3 c¸i, 10-12 cÇn 5 c¸i", "C­êng ho¸ Ph¸p b¶o ChÝ T«n cao cÊp nh­ <c=g>ChÝ T«n-Kim Quang Phiªn Thiªn Ên vµ ChÝ T«n-Cöu Long ThÇn Ho¶ Tr¸o<c>lÇn 1-3 cÇn mçi lo¹i 3 c¸i, 4-6 lµ 6 c¸i, 7-9 cÇn 9 c¸i, 10-12 cÇn mçi lo¹i 15 c¸i .")
end;

function NewAmuletIntro3()
    no()
    Talk(2, "no", "C­êng ho¸ Ph¸p b¶o ChÝ T«n vµ ph¸p b¶o th­êng kh«ng gièng nhau, lÇn 1-3 thµnh c«ng 100%, lÇn 4 trë lªn <c=g>Cã x¸c suÊt thÊt b¹i<c>; c­êng ho¸ thÊt b¹i Ph¸p b¶o ChÝ T«n sÏ kh«ng biÕn mÊt mµ sÏ tæn thÊt <c=g>sè lÇn c­êng ho¸ ph¸p b¶o<c>. NÕu lóc c­êng ho¸ bá vµo <c=g>ChÝ T«n B¶o Hé Phï<c> th× c­êng ho¸ thÊt b¹i kh«ng bÞ h¹ cÊp c­êng ho¸.", "C­êng ho¸ Ph¸p b¶o ChÝ T«n thao t¸c t¹i <c=g>XÝch Tïng Tö t¹i Diªu Tr×<c>, h·y cè g¾ng ph¸t huy hÕt n¨ng lùc cña Ph¸p b¶o ChÝ T«n!")
end;
