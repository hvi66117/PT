task_renwu = 1309

task_acceptDay = 1310
totleNumber = 1311
killTimes = 1325

BeadNumber = 15

require("ÊôÐÔÁé³è.luax")
require("king.luax")

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

    startLevel = 22
    if (GetPlayerExtLevel() >= startLevel) then
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 9) == 1 and GetTaskBit(Task_NotDieLamp, 10) == 0) then
                state = 3
                subState = 0
            end
        else
            if (HaveIBBuff(534) >= 1 and GetTaskBit(Task_NotDieLamp, 9) == 1 and GetTaskBit(Task_NotDieLamp, 10) == 0) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    if (GetPlayerExtLevel() >= 1 and IsPartyTime() == 1) then
        if (Is_HaveStone() > 0) then
            state = 3
            subState = 0
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
    local str = "H« Tiªn Ho¸n Ma"
    local completenums = GetTask(totleNumber)
    if (completenums >= 420) then
        str = "<c=yel>H« tiªn ho¸n ma<c>"
    elseif (completenums >= 20) then
        str = "<c=g>H« tiªn ho¸n ma<c>"
    end
    tasks = {
        { str, "GetSign"; show = 0 },
        { "Huû nhiÖm vô", "Cancel"; show = 0 },
        { "BÊt DiÖt §¨ng", "getShiZhongFire"; show = 0 },
        { "Th¸i Th¹ch LuyÖn S¬n", "PreGather_Stone"; show = 1 },
    }

    if (isViewNotDieLamp() == 1) then
        tasks[3].show = 1
    end

    if (GetPlayerExtLevel() >= 12) then
        if (GetTaskByte(task_renwu, 1) == 0) then
            tasks[1].show = 1
        else
            tasks[1].show = 1
            tasks[2].show = 1
        end
        SayTask("Phong thÇn ®¹i chiÕn, nhiÒu ®¹o h÷u v× nghÞch ph¶n mµ bÞ biÕn thµnh Hung Tiªn Phi Thè Ma. V× vËy Tiªn Ma ®· x©y nªn Phong Tiªn To¶ Ma th¸p ®Ó trÊn ¸p c¸c linh hån, cµng khiÕn cho chóng muèn tho¸t ra quËy ph¸. Mong anh hïng gióp ®ì siªu ®é.", tasks)
    else

        SayTask("Kh«ng biÕt ®Õn bao giê cuéc chiÕn Th­¬ng Chu nµy míi chÊm døt ®©y!", tasks)

    end


end

Task_NotDieLamp = 1332

questions = {
    [1] = "Ta n¨m x­a lÊy ®¸ v¸ trêi, tù nhËn thÊy m×nh c«ng ®øc c¸i thÕ. Nµo ngê trong lóc v¸ trêi ta ®· lì tay lµm ®øt 4 ch©n cña mét sinh linh. Ng­¬i ®o¸n xem ®ã lµ g×?",
    [2] = "§¹o h÷u V¨n Thï Qu¶ng Ph¸p Thiªn T«n cña ta trong V¹n Tiªn trËn ®· sö dông Ph¸p khÝ thu phôc ®­îc thó c­ìi Thanh S­, ®ã lµ Ph¸p khÝ g×?",
    [3] = "§¹o h÷u th«ng minh nh­ vËy, th«i ta kh«ng d¸m lµm khã n÷a…1624 nh©n víi 627 b»ng bao nhiªu?",
    [4] = "TÝnh sai råi! Quay l¹i tr¶ lêi tõ ®Çu",
}

function isViewNotDieLamp()
    local nTaskState = GetByte(GetTask(Task_NotDieLamp), 1)
    local nKongFire = GetTaskBit(Task_NotDieLamp, 9)
    local nShiZhong = GetTaskBit(Task_NotDieLamp, 10)

    if (GetPlayerExtLevel() < 22) then
        return 0
    end

    if (nTaskState ~= 2) then
        return 0
    end

    if (nKongFire == 0) then
        return 0
    end

    if (nShiZhong == 1) then
        return 0
    end

    return 1
end

function getShiZhongFire()


    local nIBBuff = HaveIBBuff(534)

    if (nIBBuff == 0) then
        Talk(1, "no", "Thêi gian ®· hÕt, Liªn täa ®· hÐo óa, ta còng bã tay th«i! Hay lµ ®i t×m <c=g>Liªn §¨ng Hé sø<c> hái xem cã c¸ch g× kh«ng?")

        refreshNpcTaskState()

        return
    end
    MsgBox("<c=g>Th¹ch Trung Háa<c> ta ®­¬ng nhiªn cã, nh­ng kh«ng dÔ tÆng nh­ vËy. §¸p ®óng ®­îc mÊy c©u hái cña ta råi h·y tÝnh!", "yesNotDieLamp", "no")
end

function yesNotDieLamp()
    Say(questions[1], 4, "A.Voi/no1", "B.Ngao/yes_1", "C.Bß/no1", "D.Tª gi¸c/no1")
end

function yes_1()
    Say(questions[2], 4, "A.Th¸i Cùc ®å/no1", "B.Phiªn Thiªn Ên/no1", "C.Ph­îc Yªu S¸ch/no1", "D.Bµn Cæ Ph­ín/yes_2")
end;

function yes_2()
    Say(questions[3], 4, "A.1018248/yes_3", "B.1217248/no1", "C.2345678/no1", "D.1120587/no1")
end;

function yes_3()

    local nShiFire = GetTaskBit(Task_NotDieLamp, 10)
    if (nShiFire == 1) then
        Talk(1, "no", "§· cã ®­îc Th¹ch Trung Háa råi, giê h·y ®i gÆp <c=g>Thî §ång<c> ë <c=g>BÊt Chu Thiªn quan<c> ®i!")

        return
    end

    if (isViewNotDieLamp() ~= 1) then
        Talk(1, "no", "LÏ ra ng­¬i kh«ng nªn ®Õn t×m ta!")
        return
    end

    AddNormalItem(3, 344, 0, 0, 0, 0)
    TopMessage("NhËn ®­îc <c=g>Th¹ch Trung Háa<c>")
    Msg2Player("NhËn ®­îc Th¹ch Trung Háa, cã thÓ ®Õn Thî §ång nhËn Méc Trung Háa.")
    SetTaskBit(Task_NotDieLamp, 10, 1)
    Talk(1, "no", " Häc vÊn cña ng­¬i rÊt uyªn th©m, <c=g>Th¹ch Trung Háa<c> ng­¬i xøng ®¸ng ®­îc nhËn. <c=g>Méc Trung Háa<c> ng­¬i cã thÓ ®Õn gÆp <c=g>Thî §ång<c> ®Ó hái!")
    TaskNote(96, 3)

    refreshNpcTaskState()

end

function no1()
    MsgBox(questions[4], "yesNotDieLamp", "no")
end;

function no()
    CloseDialog()
end

function GetSign()
    CloseDialog()
    if (GetTaskByte(task_renwu, 1) ~= 0) then
        if (HaveEventItem(210) == 0 and HaveEventItem(211) == 0) then
            if (HaveIBBuff(515) > 0) then
                Talk(1, "no", "Ng­¬i vÉn ch­a siªu ®é hoµn thµnh Hung Tiªn Phi Thè Ma, ao l¹i quay vÒ?")

            else
                if (GetTaskByte(task_renwu, 4) == 1) then
                    MsgBox("Anh hïng ®· siªu ®é thµnh c«ng, thµnh qu¶ kh«ng nhá! Ta sÏ gióp t¨ng n¨ng lùc tu luyÖn cho anh hïng!", "Bonus", "no")
                else
                    SetTaskByte(task_renwu, 1, 0)
                    SetTaskByte(task_renwu, 3, 0)
                    SetTaskByte(task_renwu, 4, 0)
                    Talk(1, "no", "Ng­¬i ch­a siªu ®é hµn tÊt cho Hung Tiªn Phi Thè Ma! Ph¶i nç lùc thªm n÷a!")
                    TaskNote(1026, -1)

                end
            end
        else
            Talk(1, "no", "Thêi gian gÊp rót! Xin h·y mau ®i siªu ®é c¸c vong linh!")
        end
    else
        tasks = {
            { "M¹n ®µ lµ hoa", "SuperBead"; show = 1 },
            { "M¹n ch©u sa hoa", "EvilBead"; show = 1 }
        }
        SayTask("Lùa chän-<enter>Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c><enter>Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>", tasks)

    end
end

function Cancel()
    MsgBox("Hung Tiªn Phi Thè Ma mÆc dï bÞ nhèt trong th¸p nh­ng ph¸p lùc vÉn cßn rÊt cao c­êng! NÕu anh hïng muèn rót lui th× vÉn cßn kÞp!", "yes", "no")

end

function yes()
    if (HaveEventItem(210) == 0 and HaveEventItem(211) == 0 and HaveIBBuff(515) == 0) then
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 3, 0)
        Msg2Player("B¹n ®· huû nhiÖm vô H« Tiªn Ho¸n Ma!")
        TaskNote(1026, -1)
        no()
    else

        Talk(1, "no", "Thêi gian gÊp rót! Xin h·y mau ®i siªu ®é c¸c vong linh!")
    end
end

function SuperBead()
    no()
    local today = math.floor(LocalSystemTime() / 86400)

    if (today ~= GetTask(task_acceptDay)) then
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 2, 0)
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        SetTask(task_acceptDay, today)
        offlineTotimes()

        SetTaskByte(killTimes, 3, 0)


    end

    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)

    if (times == 0) then
        if (HaveNormalItem(3, 311, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                DelNormalItem(3, 311, 0, 0)
            end

            SetTaskByte(task_renwu, 1, 1)
            SetTaskByte(task_renwu, 2, 1)
            SetTaskByte(task_renwu, 3, 0)
            SetTaskByte(task_renwu, 4, 0)
            times = 1

            SetTaskByte(killTimes, 3, 0)

            SyncBibleState(1026, 2, 1)

            AddEventItem(210)
            Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p mpë phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
            Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
            TaskNote(1026, 0, "TrÊn Ma Kú")
        else
            Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        end


    elseif (times < 5 or alltimes >= addtimes) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹p tµi tu luyÖn", "yes_freefsb"; show = 0 },
            { "Tru Tµ KiÕm", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        end

        if (times < 5) then
            task[2].show = 1
        end
        if (alltimes - addtimes + 1 > 0) then
            SayTask(" Ng­¬i hiÖn ®· tÝch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. " l­îng, cã thÓ nhËn thªm nhiÖm vô kh«ng tÝnh vµo sè vßng nhiÖm vô thu phÝ. NhÊp “N¹p tµi tu luyÖn ”®Ó h­ëng ­u ®·i nµy! Nh­ng ®Ó chÕ t¹o TrÊn ma ph­ín, th× kh«ng thÓ thiÕu 15 M¹n §µ La hoa nhÐ!", task)
        else
            SayTask(" NÕu ng­¬i lo l¾ng v× bËn c«ng viÖc kh«ng thÓ th­êng xuyªn tham gia luyÖn c«ng, ta sÏ gióp ng­¬i c¬ héi <c=g>N¹p tµi tu luyÖn<c>, chØ cÇn bá ra rÊt Ýt b¹c!", task)
        end


    else
        Talk(1, "no", " BÊt luËn thÕ nµo, H« Ma th¸p mçi ngµy chØ cã thÓ më 5 lÇn, nÕu kh«ng thÕ c©n b»ng Tiªn Ma ë BÊt Chu Thiªn Quan sÏ bÞ ph¸ vì! Ngµy mai h·y quay l¹i nhÐ!")

    end
end

function coin_renwu()
    local task = {
        { "Tu luyÖn th­êng", "yes2"; show = 0 },
        { "Tu luyÖn nh©n ®«i", "Yes_Double"; show = 0 },
    }
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    if (times < 5) then
        task[1].show = 1
    end

    if (times < 4) then
        task[2].show = 1
    end

    SayTask("H« Ma th¸p mçi ngµy chØ cã thÓ më 1 lÇn, nÕu muèn më thªm cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Th«ng B¶o <c>, ta sÏ gióp ng­¬i më thªm lÇn n÷a. NÕu ng­¬i muèn cã ®­îc nh©n ®«i phÇn th­ëng, chØ cÇn cung cÊp <c=yel>2 Tru Tµ KiÕm<c> hoÆc <c=yel>" .. (Cfs * 2) .. "<c> Th«ng B¶o.", task)
end

function EvilBead()
    no()
    local today = math.floor(LocalSystemTime() / 86400)

    if (today ~= GetTask(task_acceptDay)) then
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 2, 0)
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        SetTask(task_acceptDay, today)
        offlineTotimes()

        SetTaskByte(killTimes, 3, 0)


    end

    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local alltimes = GetTaskByte(1477, 3)

    if (times == 0) then
        if (HaveNormalItem(3, 312, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                DelNormalItem(3, 312, 0, 0)
            end

            SetTaskByte(task_renwu, 1, 1)
            SetTaskByte(task_renwu, 2, 1)
            SetTaskByte(task_renwu, 3, 0)
            SetTaskByte(task_renwu, 4, 0)
            times = 1

            SetTaskByte(killTimes, 3, 0)

            SyncBibleState(1026, 2, 1)

            AddEventItem(211)
            Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p mpë phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
            Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
            TaskNote(1026, 1, "To¶ Tiªn bµi")
        else
            Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        end


    elseif (times < 5 or alltimes >= addtimes) then
        local pm_free = payMoneyfree(addtimes)
        local task = {
            { "N¹p tµi tu luyÖn", "yes_freefsb1"; show = 0 },
            { "Tru Tµ KiÕm", "coin_renwu1"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        end

        if (times < 5) then
            task[2].show = 1
        end

        if (alltimes - addtimes + 1 > 0) then
            SayTask(" Ng­¬i hiÖn ®· tÝch lòy ®­îc " .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Þnh. NÕu cã" .. pm_free .. " l­îng, cã thÓ nhËn thªm nhiÖm vô kh«ng tÝnh vµo sè vßng nhiÖm vô thu phÝ. NhÊp “N¹p tµi tu luyÖn ”®Ó h­ëng ­u ®·i nµy! Nh­ng ®Ó chÕ t¹o TrÊn ma ph­ín, th× kh«ng thÓ thiÕu 15 M¹n §µ La hoa nhÐ!", task)
        else
            SayTask(" NÕu ng­¬i lo l¾ng v× bËn c«ng viÖc kh«ng thÓ th­êng xuyªn tham gia luyÖn c«ng, ta sÏ gióp ng­¬i c¬ héi <c=g>N¹p tµi tu luyÖn<c>, chØ cÇn bá ra rÊt Ýt b¹c!", task)
        end


    else
        Talk(1, "no", " BÊt luËn thÕ nµo, H« Tiªn th¸p mçi ngµy chØ cã thÓ më 5 lÇn, nÕu kh«ng thÕ c©n b»ng Tiªn Ma ë BÊt Chu Thiªn Quan sÏ bÞ ph¸ vì! Ngµy mai h·y quay l¹i nhÐ!")

    end
end

function coin_renwu1()
    local task = {
        { "Tu luyÖn th­êng", "yes3"; show = 0 },
        { "Tu luyÖn nh©n ®«i", "Yes_Double1"; show = 0 },
    }
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    if (times < 5) then
        task[1].show = 1
    end

    if (times < 4) then
        task[2].show = 1
    end

    SayTask("H« Tiªn th¸p mçi ngµy chØ cã thÓ më 1 lÇn, nÕu muèn më thªm cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Th«ng B¶o <c>, ta sÏ gióp ng­¬i më thªm lÇn n÷a. NÕu ng­¬i muèn cã ®­îc nh©n ®«i phÇn th­ëng, chØ cÇn cung cÊp <c=yel>2 Tru Tµ KiÕm<c> hoÆc <c=yel>" .. (Cfs * 2) .. "<c> Th«ng B¶o.", task)
end

function yes2()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    local temp = GetTaskByte(task_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 311, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) > 0) then
        DelNormalItem(8, 516, 2, 0)
        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 1 Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(95)
        Msg2Player("B¹n tÆng cho N÷ Oa" .. Cfs .. " Th«ng B¶o")

    else
        Talk(1, "no", "Muèn më thªm lÇn n÷a cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Th«ng B¶o<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return

    end

    for i = 1, BeadNumber do
        DelNormalItem(3, 311, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 0)

    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end

    AddEventItem(210)
    Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p mpë phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
    TaskNote(1026, 0, "TrÊn Ma Kú")
end

function yes3()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    local temp = GetTaskByte(task_renwu, 2) + 1
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 312, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) > 0) then
        DelNormalItem(8, 516, 2, 0)
        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 1 Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(95)
        Msg2Player("B¹n tÆng cho N÷ Oa" .. Cfs .. " Th«ng B¶o")

    else
        Talk(1, "no", "Muèn më thªm lÇn n÷a cÇn ph¶i cã <c=g>Tru Tµ KiÕm hoÆc" .. Cfs .. " Th«ng B¶o<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return

    end

    for i = 1, BeadNumber do
        DelNormalItem(3, 312, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 0)

    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end

    AddEventItem(211)
    Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p mpë phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
    TaskNote(1026, 1, "To¶ Tiªn bµi")

end

function getExp()
    local experience
    local monsterNum = GetTaskByte(task_renwu, 3)
    local level = GetPlayerExtLevel()
    local completenums = GetTask(totleNumber)
    local exp1 = 0
    if (completenums >= 420) then
        exp1 = 5000 * level
    elseif (completenums >= 20) then
        exp1 = math.floor(math.floor(completenums / 20) ^ 0.75 * 5) * 100 * level
    end

    if (monsterNum == 0) then
        experience = level * 4800
    elseif (monsterNum <= 4) then
        experience = level * 3600
    elseif (monsterNum <= 8) then
        experience = level * 3000
    else
        experience = level * 2500
    end

    local logstr = "] 1 lÇn"
    experience = experience + exp1
    if (GetTaskByte(killTimes, 3) == 1) then
        experience = experience * 2
        logstr = "] gÊp ®«i"
    end

    if (GetWeekDay() == 4) then
        Msg2Player("NhiÖm vô chñ ®Ò ngµy h«m nay lµ ºôÏÉ»½Ä§, chóc m­õng ngµi, nhËn ®­îc th­ëng tu vi gÊp ®«i")
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

        experience = experience + math.floor(experience * nDoubel)
    end

    local nFactExp = AddOwnExtendExp(experience)
    if (nFactExp < experience) then
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("Ng­¬i ch­a hoµn thµnh §é KiÕp hoÆc cÊp ®é Nh©n gian qu¸ thÊp, kh«ng thÓ lÜnh héi ®ñ tu vi Tiªn Ma, chØ t¨ng lªn " .. nFactExp .. " ®iÓm")
    else
        TopMessage("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
        Msg2Player("§iÓm tu luyÖn Tiªn Ma t¨ng thªm " .. nFactExp .. " ®iÓm")
    end

    WriteLog("[ºôÏÉ»½Ä§][Kinh nghiÖm: " .. nFactExp .. "/" .. experience .. logstr)
    return experience

end

function Bonus()
    CloseDialog()
    if (GetTaskByte(task_renwu, 4) == 1) then
        local today = math.floor(LocalSystemTime() / 86400)
        local acceptDay = GetTask(task_acceptDay)
        local nFactExp = getExp()
        local monsterNum = GetTaskByte(task_renwu, 3)
        if (today ~= acceptDay) then
            SetTaskByte(task_renwu, 2, 0)
            SetTask(task_acceptDay, today)
            offlineTotimes()
        end
        SetTaskByte(task_renwu, 1, 0)
        SetTaskByte(task_renwu, 3, 0)
        SetTaskByte(task_renwu, 4, 0)
        local completenums = GetTask(totleNumber) + 1

        if (GetTaskByte(killTimes, 3) == 1) then
            completenums = completenums + 1
        end

        SetTask(totleNumber, completenums)

        if (monsterNum == 0) then
            Talk(1, "no", "Lµm tèt l¾m! §©y lµ phÇn th­ëng <c=yel>" .. nFactExp .. "<c> tu luyÖn")
            Ksg:OnTaskFinish(task_renwu)
        elseif (monsterNum <= 4) then
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng <c=r>" .. nFactExp .. "<c> tu luyÖn")
        elseif (monsterNum <= 8) then
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng <c=g>" .. nFactExp .. "<c> tu luyÖn")
        else
            Talk(1, "no", "Ng­¬i vÉn cßn" .. monsterNum .. " ng­êi ch­a siªu ®é, xin nhËn tr­íc phÇn th­ëng" .. nFactExp .. " tu luyÖn")
        end
        Able_Pet.AblePetExp(11, nFactExp)
        TaskNote(1026, -1)
    end
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


    local m = 2000 * GetPlayerExtLevel()
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) then
        if (HaveNormalItem(3, 311, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                DelNormalItem(3, 311, 0, 0)
            end

            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end

            Pay(apm)
            SetTaskByte(task_renwu, 1, 1)
            SetTaskByte(task_renwu, 2, temp)
            SetTaskWord(task_renwu, 2, 0)

            SetTaskByte(killTimes, 3, 0)

            AddEventItem(210)
            Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p mpë phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
            Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
            Msg2Player("B¹n nhËn ®­îc TrÊn ma ph­ín, h«m nay b¹n ®· tÝch lòy ­u ®·i rêi m¹ng lÇn thø " .. addtimes .. ".")
            TaskNote(1026, 0, "TrÊn Ma Kú")
        else
            Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        end
    else
        Talk(1, "no", " Ng­¬i kh«ng ®ñ b¹c!")
    end
end

function yes_freefsb1()
    CloseDialog()
    local temp = GetTaskByte(task_renwu, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    if (GetCash() >= apm) then
        if (HaveNormalItem(3, 312, 0, 0) >= BeadNumber) then
            for i = 1, BeadNumber do
                DelNormalItem(3, 312, 0, 0)
            end

            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end

            SetTaskByte(task_renwu, 1, 1)
            SetTaskByte(task_renwu, 2, temp)
            SetTaskWord(task_renwu, 2, 0)

            SetTaskByte(killTimes, 3, 0)

            Pay(apm)

            AddEventItem(211)
            Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p mpë phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
            Msg2Player("N¹p tµi " .. apm .. " h­ëng thô (h«m nay) lÇn thø " .. addtimes .. " ­u ®·i rêi game tÝch lòy")
            Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, h«m nay b¹n ®· tÝch lòy ­u ®·i rêi m¹ng lÇn thø " .. addtimes .. ".")
            TaskNote(1026, 1, "To¶ Tiªn bµi")
        else
            Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        end
    else
        Talk(1, "no", " Ng­¬i kh«ng ®ñ b¹c!")
    end
end

function Yes_Double()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    local temp = GetTaskByte(task_renwu, 2) + 2
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 311, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Ma th¸p cÇn dïng 15 <c=g>M¹n §µ la hoa<c> ®æi lÊy <c=yel>TrÊn ma ph­ín<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n §µ la hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) >= 2) then
        DelNormalItem(8, 516, 2, 0)
        DelNormalItem(8, 516, 2, 0)

        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 2 thanh Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) and (HaveNormalItem(8, 516, 2, 0) >= 1) then
        DelNormalItem(8, 516, 2, 0)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa 1 Tru Tµ KiÕm vµ " .. Cfs .. " Th«ng B¶o")

    elseif (GetCoin() >= 2 * Cv) then
        CostCoinByIdx(95)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa" .. (Cfs * 2) .. " Th«ng B¶o")

    else
        Talk(1, "no", " Muèn më tiÕp cÇn cã 2 <c=g>Tru Tµ KiÕm hoÆc " .. (Cfs * 2) .. " Th«ng B¶o<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return
    end

    for i = 1, BeadNumber do
        DelNormalItem(3, 311, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 1)

    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end

    AddEventItem(210)
    Talk(1, "no", "§©y lµ <c=g>TrÊn ma ph­ín<c>, ng­¬i cã thÓ ®Õn H« Ma th¸p mpë phong Ên, th¶ c¸c Phi Thè Ma ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc TrÊn Ma ph­ín, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
    TaskNote(1026, 0, "TrÊn Ma Kú")
end

function Yes_Double1()
    CloseDialog()

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(95)

    local temp = GetTaskByte(task_renwu, 2) + 2
    local times, addtimes = todayfreetimes(temp)

    if (times > 5) then
        return
    end

    if (HaveNormalItem(3, 312, 0, 0) < BeadNumber) then
        Talk(1, "no", "Më H« Tiªn th¸p cÇn dïng 15 <c=g>M¹n Ch©u Sa hoa<c> ®æi lÊy <c=yel>To¶ Tiªn bµi<c>, ng­¬i kh«ng cã ®ñ <c=g>M¹n Ch©u Sa hoa<c>")
        return
    end

    if (HaveNormalItem(8, 516, 2, 0) >= 2) then
        DelNormalItem(8, 516, 2, 0)
        DelNormalItem(8, 516, 2, 0)

        Msg2Player("B¹n tÆng cho N÷ Oa N­¬ng N­¬ng 2 thanh Tru Tµ KiÕm")

    elseif (GetCoin() >= Cv) and (HaveNormalItem(8, 516, 2, 0) >= 1) then
        DelNormalItem(8, 516, 2, 0)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa 1 Tru Tµ KiÕm vµ " .. Cfs .. " Th«ng B¶o")

    elseif (GetCoin() >= 2 * Cv) then
        CostCoinByIdx(95)
        CostCoinByIdx(95)

        Msg2Player("B¹n tÆng cho N÷ Oa" .. (Cfs * 2) .. " Th«ng B¶o")

    else
        Talk(1, "no", " Muèn më tiÕp cÇn cã 2 <c=g>Tru Tµ KiÕm hoÆc " .. (Cfs * 2) .. " Th«ng B¶o<c>, ng­¬i ch­a ®ñ ®iÒu kiÖn!")
        return
    end

    for i = 1, BeadNumber do
        DelNormalItem(3, 312, 0, 0)
    end

    SetTaskByte(task_renwu, 1, 1)
    SetTaskByte(task_renwu, 2, temp)
    SetTaskByte(task_renwu, 3, 0)
    SetTaskByte(task_renwu, 4, 0)

    SetTaskByte(killTimes, 3, 1)

    if (times >= 1 and times < 5) then
        SyncBibleState(1026, 2, 1)
    elseif (times >= 5) then
        SyncBibleState(1026, 3, 1)
    end

    AddEventItem(211)

    Talk(1, "no", "§©y lµ <c=g>To¶ Tiªn bµi<c>, ng­¬i cã thÓ ®Õn H« Tiªn th¸p mpë phong Ên, th¶ c¸c Hung Tiªn ra ®Ó siªu ®é!")
    Msg2Player("B¹n nhËn ®­îc To¶ Tiªn bµi, ®©y lµ nhiÖm vô lÇn thø " .. times .. ".")
    TaskNote(1026, 1, "To¶ Tiªn bµi")
end

Task_GatherStone = {
    taskID = 1740,
    taskGlobalV = { 602 },
    npcInfo = {
        { name = "§iÓm th¨m dß", templateID = 1870, script = "\\script\\»î¶¯½Å±¾\\¿±²âµã.lua", existTime = 5400 },
        { name = "§¬n S¾c ThÇn Th¹ch", templateID = 1871, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "Song S¾c ThÇn Th¹ch", templateID = 1872, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "Tam S¾c ThÇn Th¹ch", templateID = 1873, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 60 },
        { name = "V« Dông Ngoan Th¹ch", templateID = 1874, script = "\\script\\»î¶¯½Å±¾\\ÉñÊ¯.lua", existTime = 30 },
    },
    globalName = { "Stone_Number", "Total_PerCamp", "Score_PerCamp", "God_CampName", "God_CampScore", "Magic_CampName", "Magic_CampScore" },
    itemInfo = {
        { 3, 1144, 0, "§¬n S¾c ThÇn Th¹ch", 1008, 1 },
        { 3, 1145, 0, "Song S¾c ThÇn Th¹ch", 189, 3 },
        { 3, 1146, 0, "Tam S¾c ThÇn Th¹ch", 63, 15 },
    },
    rewards_Info = {
        { 1, 30, 15 },
        { 31, 45, 45 },
        { 46, 60, 167 },
        { 61, 80, 167 },
    },
}

God_CampPlayer = {}
Magic_CampPlayer = {}

function PreGather_Stone()
    local tasks = {
        { "Nép thÇn th¹ch", "Gather_Stone"; show = 0 },
        { "KiÓm tra thÇn th¹ch t¹o ra ", "Gather_StoneNumber"; show = 0 },
        { "Giíi thiÖu ho¹t ®éng", "Gather_Introduction"; show = 1 },
        { "B¶ng xÕp h¹ng", "Gather_Top"; show = 1 },
        { "L·nh nhËn phÇn th­ëng", "Gather_Bonus"; show = 0 },
    }

    if (GetPlayerExtLevel() >= 1 and IsPartyTime() == 1) then
        if (Is_HaveStone() > 0) then
            tasks[1].show = 1
        end
        tasks[2].show = 1
    end
    if (Is_HaveStone() == 0) then
        TaskNote(1624, -1)
    end
    local nHour, nMin, nSec = GetHMS()
    local nWeek = GetWeekDay()
    local nToday = math.floor(SystemTime() / 86400)
    if (GetTaskWord(1883, 2) == 0 and GetTask(1876) == nToday) and (nWeek == 6 or nWeek == 7) and (nHour > 23 or (nHour == 22 and nMin > 30)) then
        local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
        local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
        if (nGod_CampTop >= 10 and nMagic_CampTop >= 10) then
            tasks[5].show = 1
        end
    end

    SayTask("Kh«ng biÕt ®Õn bao giê cuéc chiÕn Th­¬ng Chu nµy míi chÊm døt ®©y!", tasks)
end

function Gather_Stone()
    CloseDialog()
    MsgBox("Ch¾c ng­¬i biÕt r»ng n¬i nµy lµ m¶nh vì cña BÊt Chu S¬n nªn cã mét Ýt thÇn th¹ch, nh­ng kh«ng ph¶i lµ bÊt tËn, ta còng ph¶i tíi tr­íc ®Ó thu nhÆt, ng­¬i nªn tranh thñ thêi gian ®Õn thu nhÆt thªm lÇn n÷a, ®ång ý giao nép thÇn th¹ch?", "Yes_GatherStone", "no")
end

function Yes_GatherStone()
    CloseDialog()
    local nTime = GetGlobalValue(661)
    local nToday = math.floor(SystemTime() / 86400)
    if (nTime ~= nToday) then
        SetGlobalValue(661, nToday)
        God_CampPlayer = {}
        Magic_CampPlayer = {}
    end

    if (GetTask(1876) ~= nToday) then
        SetTask(1876, nToday)
        SetTask(1883, 0)
    end

    local itemInfo = Task_GatherStone.itemInfo
    local nIndex = Is_HaveStone()
    if (nIndex > 0 and IsPartyTime() == 1) then
        local nStone = IsExistItem(itemInfo[nIndex][1], itemInfo[nIndex][2], itemInfo[nIndex][3], 0)
        local rewards_Info = Task_GatherStone.rewards_Info
        local nExtExp = 0
        local nLevel = GetPlayerExtLevel()
        for i = 1, table.getn(rewards_Info) do
            if (nLevel >= rewards_Info[i][1] and nLevel <= rewards_Info[i][2]) then
                if (nLevel > 60) then
                    nLevel = 60
                end
                nExtExp = nLevel * rewards_Info[i][3] * nStone * itemInfo[nIndex][6]
            end
        end
        for i = 1, nStone do
            ClearItem(itemInfo[nIndex][1], itemInfo[nIndex][2], itemInfo[nIndex][3], 0)
        end

        AddOwnExtendExp(nExtExp)
        ScrollMessage("B¹n nh©n ®­îc " .. nExtExp .. " tu luyÖn")
        Msg2Player("B¹n nh©n ®­îc " .. nExtExp .. " tu luyÖn")
        TaskNote(1624, -1)
        WriteLog(GetName() .. "§· giao " .. nStone .. "." .. itemInfo[nIndex][4] .. ", §iÓm sè: " .. GetTaskWord(1883, 1))
        Talk(1, "no", "Ng­¬i ®· giao <c=y>" .. nStone .. "<c> <c=g>" .. itemInfo[nIndex][4] .. "<c>, nhËn ®­îc <c=y>" .. nExtExp .. "<c> tu luyÖn")

        local H, M, S = GetHMS()
        if (H == 21) or (H == 22 and M <= 30) then

            local nScore = nStone * itemInfo[nIndex][6]
            Load_PlayerTop()
            Insert_PlayerTop(nScore)

            local nCampType = GetJusticEvilCredit()
            if (nCampType > 0) then
                local nTotal_Score = LoadIniInteger(Task_GatherStone.globalName[3], 1) + nScore
                SaveIniInteger(Task_GatherStone.globalName[3], 1, nTotal_Score)
            elseif (nCampType < 0) then
                local nTotal_Score = LoadIniInteger(Task_GatherStone.globalName[3], 2) + nScore
                SaveIniInteger(Task_GatherStone.globalName[3], 2, nTotal_Score)
            end

            local nSingle = GetGlobalValue(655)
            local nDouble = GetGlobalValue(656)
            local nThree = GetGlobalValue(657)
            if (math.mod(nSingle, 56) == 0) then
                SaveIniInteger(Task_GatherStone.globalName[1], 1, nSingle)
            elseif (math.mod(nDouble, 27) == 0) then
                SaveIniInteger(Task_GatherStone.globalName[1], 1, nDouble)
            elseif (math.mod(nThree, 9) == 0) then
                SaveIniInteger(Task_GatherStone.globalName[1], 1, nThree)
            end
        end
    end
    refreshNpcTaskState()
end

function Gather_Introduction()
    CloseDialog()
    refreshNpcTaskState()
    Talk(4, "Next_Introduction", "Mçi <c=y> thø 7, chñ nhËt<c> vµo lóc <c=g>21:00-22:30<c>, ng­êi ch¬i <c=y>Tiªn Ma Giíi<c> cã thÓ ®Õn <c=y>BÊt Chu Thiªn quan<c> thu thËp thÇn th¹ch, giao cho ta sÏ nhËn ®­îc phÇn th­ëng t­¬ng øng. Khi sè ng­êi tham gia vµo 2 phe Tiªn Ma v­ît qu¸ <c=y>10<c> ng­êi sÏ nhËn ®­îc phÇn th­ëng thªm.", "Kh«ng giíi h¹n sè lÇn thu thËp trong thêi gian ho¹t ®éng. Cïng mét lóc th× hµnh trang chØ cã thÓ chøa mét lo¹i thÇn th¹ch. ThÇn th¹ch gåm 3 lo¹i: <c=g>§¬n S¾c ThÇn Th¹ch<c>, <c=g>Song S¾c ThÇn Th¹ch<c>, <c=g>Tam S¾c ThÇn Th¹ch<c>.", "<c=g>§¬n S¾c ThÇn Th¹ch<c> cã thÓ tù thu thËp, <c=g>Song S¾c ThÇn Th¹ch<c> cÇn tæ ®éi <c=y>2<c> hoÆc <c=y>3<c> ng­êi thu thËp, <c=g>Tam S¾c ThÇn Th¹ch<c> cÇn ph¶i tæ ®éi <c=y>3<c>ng­êi míi cã thÓ thu thËp.")
end

function Next_Introduction()
    CloseDialog()
    refreshNpcTaskState()
    local str_Success = "Å®æ´ÄïÄï: ÁìÏÈÒ»·½µÄÇ°ÈýÃû½«·Ö±ð»ñµÃ<c=g>Vi Quang Qu¸i Phï(Ch­a mµi) 2 c¸i<c>, <c=g>Vi Quang Qu¸i Phï(Ch­a mµi) 1 c¸i<c>, <c=g>M¶nh tranh Qu¸i Phï s¬ cÊp 3 tÊm<c>µÄ½±Àø, ÆäÓàÍæ¼Ò½«»ñµÃ<c=y>20 v¹n<c> b¹c."
    local str_Fail = "Å®æ´ÄïÄï: ÂäºóÒ»·½(»òÕßÁ½ÕóÓª»ý·ÖÏàÍ¬Ê±Á½ÕóÓª)µÄÇ°ÈýÃû½«·Ö±ð»ñµÃ<c=g>Vi Quang Qu¸i Phï(Ch­a mµi) 1 c¸i<c>, <c=g>M¶nh tranh Qu¸i Phï s¬ cÊp 3 tÊm<c>, <c=g>M¶nh tranh Qu¸i Phï s¬ cÊp 1 tÊm<c>µÄ½±Àø, ÆäÓàÍæ¼Ò½«»ñµÃ<c=y>10 v¹n<c> b¹c."
    local str_tmp = "Ngoµi ra, ®Ó c¶m ¬n sù gióp ®ì cña c¸c vÞ h¶o h÷u, khi 2 phe Tiªn Ma <c=y>cã 10 ng­êi<c> trë lªn tham gia thu thËp hÇn th¹ch, ta sÏ dïng phe lµm ®¬n vÞ ghi chÐp 1 b¶ng xÕp h¹ng cèng hiÕn, ®Ó trao phÇn th­ëng."

    Talk(3, "no", str_tmp, str_Success, str_Fail)
end

function Gather_StoneNumber()
    CloseDialog()

    local nSingle = 1008 - GetGlobalValue(655)
    local nDouble = 189 - GetGlobalValue(656)
    local nThree = 63 - GetGlobalValue(657)

    Talk(1, "no", "S¶n l­îng c¸c lo¹i thÇn th¹ch d­ ra: \n<c=g>§¬n S¾c ThÇn Th¹ch<c>: <c=y>" .. nSingle .. "<c>; \n<c=g>Song S¾c ThÇn Th¹ch<c>: <c=y>" .. nDouble .. "<c>; \n<c=g>Tam S¾c ThÇn Th¹ch<c>: <c=y>" .. nThree .. "<c>; ")
end

function Is_HaveStone()
    local itemInfo = Task_GatherStone.itemInfo
    for i = 1, 3 do
        if (IsExistItem(itemInfo[i][1], itemInfo[i][2], itemInfo[i][3], 0) > 0) then
            return i
        end
    end
    return 0
end

function IsPartyTime()
    local H, M, S = GetHMS()
    if (GetWeekDay() == 6 or GetWeekDay() == 7) and (H >= 21 and H <= 23) then
        return 1
    end
    return 0
end

function Load_PlayerTop()
    local str_Name = ""
    local Interval = 0
    local tmp_Item = {}
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)

    if (nGod_CampTop > 0 and table.getn(God_CampPlayer) == 0) then
        for i = 1, nGod_CampTop do
            str_Name = LoadIniString(Task_GatherStone.globalName[4], i)
            Interval = LoadIniInteger(Task_GatherStone.globalName[5], i)
            tmp_Item = { str_Name, Interval }
            God_CampPlayer[i] = tmp_Item
        end
    end

    if (nMagic_CampTop > 0 and table.getn(Magic_CampPlayer) == 0) then
        for i = 1, nMagic_CampTop do
            str_Name = LoadIniString(Task_GatherStone.globalName[6], i)
            Interval = LoadIniInteger(Task_GatherStone.globalName[7], i)
            tmp_Item = { str_Name, Interval }
            Magic_CampPlayer[i] = tmp_Item
        end
    end
end

function Save_PlayerTop(nCampType, name, nOldScore)
    local str_Name = ""
    local Interval = 0
    local tmp_Item = {}
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)

    if (nCampType > 0) then
        if (nGod_CampTop > 0) then
            for i = 1, nGod_CampTop do
                local nOldName = LoadIniString(Task_GatherStone.globalName[4], i)
                if (nOldName == name) then
                    SaveIniInteger(Task_GatherStone.globalName[5], i, nOldScore)
                    break
                end
            end
        end
    else
        if (nMagic_CampTop > 0) then
            for i = 1, nMagic_CampTop do
                local nOldName = LoadIniString(Task_GatherStone.globalName[6], i)
                if (nOldName == name) then
                    SaveIniInteger(Task_GatherStone.globalName[7], i, nOldScore)
                    break
                end
            end
        end
    end
end

function Insert_PlayerTop(nScore)
    local nCampType = GetJusticEvilCredit()
    local name = GetName()
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    if (nCampType > 0) then
        if (nGod_CampTop > 0) then
            for i = 1, nGod_CampTop do
                local nOldScore = God_CampPlayer[i][2] + nScore
                if (name == God_CampPlayer[i][1]) then
                    SetTaskWord(1883, 1, nOldScore)
                    God_CampPlayer[i] = { name, nOldScore }
                    Save_PlayerTop(nCampType, name, nOldScore)
                    return i
                end
            end
        end
        SetTaskWord(1883, 1, nScore)
        God_CampPlayer[nGod_CampTop + 1] = { name, nScore }
        SaveIniInteger(Task_GatherStone.globalName[2], 1, nGod_CampTop + 1)
        SaveIniString(Task_GatherStone.globalName[4], nGod_CampTop + 1, name)
        SaveIniInteger(Task_GatherStone.globalName[5], nGod_CampTop + 1, nScore)
    elseif (nCampType < 0) then
        if (nMagic_CampTop > 0) then
            for i = 1, nMagic_CampTop do
                local nOldScore = Magic_CampPlayer[i][2] + nScore
                if (name == Magic_CampPlayer[i][1]) then
                    SetTaskWord(1883, 1, nOldScore)
                    Magic_CampPlayer[i] = { name, nOldScore }
                    Save_PlayerTop(nCampType, name, nOldScore)
                    return i
                end
            end
        end
        SetTaskWord(1883, 1, nScore)
        Magic_CampPlayer[nMagic_CampTop + 1] = { name, nScore }
        SaveIniInteger(Task_GatherStone.globalName[2], 2, nMagic_CampTop + 1)
        SaveIniString(Task_GatherStone.globalName[6], nMagic_CampTop + 1, name)
        SaveIniInteger(Task_GatherStone.globalName[7], nMagic_CampTop + 1, nScore)
    end
    return 0
end

function Gather_Top()
    CloseDialog()
    Load_PlayerTop()
    Sort_CampTop()
    local nTotal_GodScore = LoadIniInteger(Task_GatherStone.globalName[3], 1)
    local nTotal_MagicScore = LoadIniInteger(Task_GatherStone.globalName[3], 2)
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    local str_GodTop = ""
    local str_Success = "N÷ Oa n­¬ng n­¬ng: "
    local str_MagicTop = ""
    local str_Fail = "N÷ Oa n­¬ng n­¬ng: "
    local str_CampName = "Tiªn ph¸i"
    local str_tmp = "HiÖn t¹i, sè ng­êi tham gia cña <c=g>Tiªn ph¸i<c> lµ <c=y>" .. nGod_CampTop .. "<c> ng­êi, sè ng­êi cña <c=g>Ma ph¸i<c> lµ <c=y>" .. nMagic_CampTop .. "<c> ng­êi, ®iÓm tÝch lòy"

    if (nGod_CampTop > 0) then
        str_GodTop = "3 ng­êi ®øng ®Çu cña <c=g>Tiªn ph¸i<c> nh­ sau:\n"
        for i = 1, nGod_CampTop do
            if (i > 3) then
                break
            end
            str_GodTop = str_GodTop .. "Thiªn C­¬ng ¶nh thø" .. i .. "trong ngµy, ®¸nh b¹i ®èi thñ:" .. God_CampPlayer[i][1] .. " " .. " ®iÓm sè:" .. God_CampPlayer[i][2] .. " Phót\n"
        end
    end
    if (nMagic_CampTop > 0) then
        str_MagicTop = "3 ng­êi ®øng ®Çu cña <c=g>Ma ph¸i<c>nh­ sau: \n"
        for i = 1, nMagic_CampTop do
            if (i > 3) then
                break
            end
            str_MagicTop = str_MagicTop .. "Thiªn C­¬ng ¶nh thø" .. i .. "trong ngµy, ®¸nh b¹i ®èi thñ:" .. Magic_CampPlayer[i][1] .. " " .. " ®iÓm sè:" .. Magic_CampPlayer[i][2] .. " Phót\n"
        end
    end

    if nMagic_CampTop > 0 and nTotal_MagicScore > 0 and nTotal_GodScore <= nTotal_MagicScore then
        str_CampName = "Ma ph¸i"
        str_Success = str_Success .. str_MagicTop
        str_Fail = str_Fail .. str_GodTop
        str_tmp = str_tmp .. "<c=g>" .. str_CampName .. "<c> t¹m thêi dÉn tr­íc, tæng ®iÓm nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    elseif (nGod_CampTop > 0 and nTotal_GodScore > 0 and nTotal_GodScore > nTotal_MagicScore) then
        str_Success = str_Success .. str_GodTop
        str_Fail = str_Fail .. str_MagicTop
        str_tmp = str_tmp .. "<c=g>" .. str_CampName .. "<c> t¹m thêi dÉn tr­íc, tæng ®iÓm nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    elseif (nTotal_MagicScore == nTotal_GodScore) then
        str_Success = str_Success .. str_GodTop
        str_Fail = str_Fail .. str_MagicTop
        str_tmp = str_tmp .. "Hai phe thÕ lùc ngang b»ng nhau, ®iÓm sè nh­ sau: \n<c=g>Tiªn<c>: \t<c=y>" .. nTotal_GodScore .. "<c> ®iÓm; \n<c=g>Ma<c>: \t<c=y>" .. nTotal_MagicScore .. "<c> ®iÓm; "
    end

    if (nMagic_CampTop > 0) and (nGod_CampTop > 0) then
        Talk(3, "no", str_tmp, str_Success, str_Fail)
    elseif (nMagic_CampTop == 0) and (nGod_CampTop == 0) then
        Talk(1, "no", str_tmp)
    elseif (nMagic_CampTop > 0) and (nGod_CampTop == 0) then
        Talk(2, "no", str_tmp, str_Success)
    elseif (nMagic_CampTop == 0) and (nGod_CampTop >= 0) then
        Talk(2, "no", str_tmp, str_Success)
    end
end

function Sort_CampTop()
    local nGod_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 1)
    local nMagic_CampTop = LoadIniInteger(Task_GatherStone.globalName[2], 2)
    local nTmp = {}

    if (nGod_CampTop > 1) then
        for i = table.getn(God_CampPlayer) - 1, 1, -1 do
            for j = 1, i do
                if (God_CampPlayer[j][2] ~= nil and God_CampPlayer[j][2] < God_CampPlayer[j + 1][2]) then
                    nTmp = God_CampPlayer[j]
                    God_CampPlayer[j] = God_CampPlayer[j + 1]
                    God_CampPlayer[j + 1] = nTmp
                end
            end
        end
    end

    if (nMagic_CampTop > 1) then
        for i = table.getn(Magic_CampPlayer) - 1, 1, -1 do
            for j = 1, i do
                if (Magic_CampPlayer[j][2] ~= nil and Magic_CampPlayer[j][2] < Magic_CampPlayer[j + 1][2]) then
                    nTmp = Magic_CampPlayer[j]
                    Magic_CampPlayer[j] = Magic_CampPlayer[j + 1]
                    Magic_CampPlayer[j + 1] = nTmp
                end
            end
        end
    end
end

function Gather_Bonus()
    no()
    if (GetTaskWord(1883, 2) > 0) then
        Talk(1, "no", "Anh hïng ®· nhËn phÇn th­ëng ho¹t ®éng Th¸i Th¹ch LuyÖn S¬n råi.")
        return
    end
    local nGod_TotalScore = LoadIniInteger(Task_GatherStone.globalName[3], 1)
    local nMagic_TotalScore = LoadIniInteger(Task_GatherStone.globalName[3], 2)
    local nGodMoney = 100000
    local nMagicMoney = 100000
    local nGodStr = "Phe Tiªn trong ho¹t ®éng Th¸i Th¹ch LuyÖn S¬n toµn th¾ng, nhËn thªm 10 vËn ng©n l­îng!"
    local nMagicStr = "Phe Ma rong ho¹t ®éng Th¸i Th¹ch LuyÖn S¬n toµn th¾ng, nhËn thªm 10 vËn ng©n l­îng!"
    if (nGod_TotalScore > nMagic_TotalScore) then
        nGodMoney = 200000
        nMagicStr = "Ma ph¸i ®· thua Tiªn Ph¸i trong ho¹t ®éng NhÆt ®¸ g©y rõng, nªn chØ ®­îc nhËn 10 v¹n tiÒn th­ëng!"
        nGodStr = "Tiªn ph¸i ®· giµnh chiÕn th¾ng trong ho¹t ®éng NhÆt ®¸ g©y rõng, nhËn thªm 20 v¹n tiÒn th­ëng!"
    elseif (nGod_TotalScore < nMagic_TotalScore) then
        nMagicMoney = 200000
        nMagicStr = "Ma ph¸i ®· giµnh chiÕn th¾ng trong ho¹t ®éng NhÆt ®¸ g©y rõng, nhËn thªm 20 v¹n tiÒn th­ëng!"
        nGodStr = "Thiªn ph¸i ®· thua Ma Ph¸i trong ho¹t ®éng NhÆt ®¸ g©y rõng, nªn chØ ®­îc nhËn 10 v¹n tiÒn th­ëng!"
    end
    SetTaskWord(1883, 2, 1)
    local nCampType = GetJusticEvilCredit()
    if (nCampType > 0) then
        Earn(nGodMoney)
        Talk(1, "no", nGodStr)
        Msg2Player(nGodStr)
    else
        Earn(nMagicMoney)
        Talk(1, "no", nMagicStr)
        Msg2Player(nMagicStr)
    end
end
