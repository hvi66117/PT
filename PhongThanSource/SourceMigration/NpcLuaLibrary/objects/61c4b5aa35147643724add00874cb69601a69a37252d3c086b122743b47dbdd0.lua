Task_renwu = 1263
Task_nidx = 1264
Task_nid = 1265
Task_tree_time = 1266
Task_lucy = 1267

Task_extra = 1552
Task_exnidx = 1553
Task_exnid = 1554
Task_extree_time = 1555

cold_UpTime = 3

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

    startLevel = 90
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (math.mod(math.floor(LocalSystemTime() / 86400), 255) ~= GetTaskByte(Task_renwu, 1) and IsInTime() == 1) then
                state = 1
                subState = 0
            elseif (GetTaskByte(Task_renwu, 2) == 1 and (GetTaskByte(Task_renwu, 4) == 1) or (GetTaskByte(Task_renwu, 4) == 100)) then
                state = 3
                subState = 0
            elseif (GetTaskByte(Task_renwu, 2) == 1 and GetTaskByte(Task_renwu, 3) ~= 0) then
                state = 2
                subState = 0
            end
        else
            if (math.mod(math.floor(LocalSystemTime() / 86400), 255) ~= GetTaskByte(Task_renwu, 1) and IsInTime() == 1) then
                state = 1
                subState = 1
            elseif (GetTaskByte(Task_renwu, 2) == 1 and (GetTaskByte(Task_renwu, 4) == 1) or (GetTaskByte(Task_renwu, 4) == 100)) then
                state = 3
                subState = 1
            elseif (GetTaskByte(Task_renwu, 2) == 1 and GetTaskByte(Task_renwu, 3) ~= 0) then
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

require("themeday_human.luax")

function main()
    local tasks = {
        { "TuÕ Hµn §Þa KhÝ", "renwu_list"; show = 0 },
        { "Hoµn thµnh TuÕ Hµn §Þa KhÝ", "renwu_complete"; show = 0 },
        { "Hñy TuÕ Hµn §Þa KhÝ", "renwu_cancel"; show = 0 },
        { "Th¹ch D­¬ng Gi¸c", "renwu_jiangli"; show = 0 },

        { "T×m hiÓu TuÕ Hµn §Þa KhÝ", "into_cold"; show = 1 }
    }
    if (GetLevel() >= 90) then
        if (GetTaskByte(Task_renwu, 3) == 0) then
            tasks[1].show = 1;
        elseif ((GetTaskByte(Task_renwu, 4) == 1) or (GetTaskByte(Task_renwu, 4) == 100)) then
            tasks[2].show = 1;
        else
            tasks[3].show = 1


        end
        tasks[4].show = 1
    end ;
    SayTask(14571, tasks)
end;

function no()
    CloseDialog()
end

function into_cold()
    Talk(3, "no", 14572, "Ng­êi ®ang thu thËp §Þa KhÝ th× kh«ng ®­îc trång Th¹ch Miªu. BÊt luËn ®¸nh vì Th¹ch Miªu hay Linh Th¹ch ®Òu cã thÓ nhËn ®­îc §Þa KhÝ. Nh÷ng ng­êi thu thËp b¾t buéc ph¶i thuéc <c=yel>Phe vµng<c>.", "Hoµn thµnh trång mÇm cã thÓ nhËn ®­îc <c=g>Thiªn C¬ §ång<c>. Hoµn thµnh Thu ThËp cã thÓ nhËn ®­îc <c=g>ChuyÓn Long Xu<c>. Sö dông ChuyÓn Long Xu sÏ më ®­îc Thiªn C¬ §ång. Ho¹t ®éng '§Þa KhÝ' b¾t ®Çu tõ <c=r>19h: 30 ®Õn 21h: 30<c>. NÕu §Þa KhÝ bÞ mÊt, nhiÖm vô thÊt b¹i!")
end

function IsInTime()
    local h, m, s = GetHMS()
    if (h == 19) and (m >= 30) then
        return 1
    elseif (h == 20) then
        return 1
    elseif (h == 21) and (m <= 30) then
        return 1
    end
    return 0
end

function renwu_list()
    if (IsInTime() ~= 1) then
        Talk(1, "no", 14573)
        return 0
    end

    local today = math.mod(math.floor(LocalSystemTime() / 86400), 255)
    local lastday = GetTaskByte(Task_renwu, 1)
    if (today ~= lastday) then
        SetTask(Task_renwu, today)
    end

    if (GetTaskByte(Task_renwu, 2) >= cold_UpTime) then
        Talk(1, "no", "Thêi vËn cña ng­¬i ®· ®æi! §Þa KhÝ mçi ngµy chØ cã thÓ thu thËp" .. cold_UpTime .. " lÇn. May h·y quay l¹i nhÐ!")
        return 0
    end

    local tasks = {
        { "NhËn ngÉu nhiªn", "renwu"; show = 1 },
        { "Trång mÇm", "renwu_seed"; show = 1 },
        { "Thu thËp", "renwu_pick"; show = 1 },
    }

    local money = GetLevel() * 3000
    SayTask("VËn khÝ cña mçi ng­êi ®Òu kh¸c nhau…NÕu ng­¬i tÆng ta mét Ýt tiÒn, ta cã thÓ nãi víi S­ Tæ ®Æc ©n cho ng­¬i tïy ý chän 'Trång mÇm' hoÆc 'Thu thËp'. NÕu ng­¬i kh«ng cã tiÒn th× xem nh­ do t¹i vËn vËy!...", tasks)
end

function renwu()
    local ntimes = GetTaskByte(Task_renwu, 2)
    local money = GetLevel() * 1500
    if (ntimes == 0) then
        MsgBox("NhËn ®­îc nhiÖm vô nµo lµ do vËn may! NÕu nhËn <c=g>Trång mÇm<c> th× mang §Þa KhÝ t­íi lªn Th¹ch Miªu, chê tr­ëng thµnh sÏ thu ho¹ch. NÕu nhËn <c=g>thu thËp<c> th× kh«ng cÇn trång, chØ cÇn ®¸nh vì Th¹ch Miªu hoÆc Linh Th¹ch thi ®Òu nhËn ®­îc §Þa KhÝ. CÇn giao cho ta" .. money .. " tiÒn cäc míi nhËn ®­îc nhiÖm vô!", "renwu_yes", "no")
    elseif (ntimes >= cold_UpTime) then
        Talk(1, "no", "Thêi vËn cña ng­¬i ®· ®æi! §Þa KhÝ mçi ngµy chØ cã thÓ thu thËp" .. cold_UpTime .. " lÇn. May h·y quay l¹i nhÐ!")
    else

        local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")

        local _, _, Cfs = 1, SalePriceCount, SalePriceName
        local strValue = "Ng­¬i ®· lµm nhiÖm vô nµy råi, giê muèn cã §Þa KhÝ, trõ phi ng­¬i cã <c=g>Cöu Tinh Tø §µn Ch©u<c> hoÆc <c=r>" .. PriceName .. " Th«ng B¶o<c> th× ta cã thÓ ph¸ lÖ. §­¬ng nhiªn ng­¬i vÉn ph¶i ®Æt" .. money .. " tiÒn cäc"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        MsgBox(strValue, "coin_yes", "no")

    end
end

function renwu_yes()
    CloseDialog()
    local key1 = renwu_set()
    if (key1 == 1) then
        Talk(1, "no", 14574)
    elseif (key1 == 2) then
        Talk(1, "facecloth", 14575)
    end
end

function renwu_set()
    CloseDialog()
    if (IsInTime() ~= 1) then
        Talk(1, "no", 14573)
        return 0
    end

    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14576)
        return 0
    end

    local money = GetLevel() * 1500
    if (GetCash() < money) then
        Talk(1, "no", 14577)
        return 0
    else


        Pay(money, 1)

        RemoveIBBuff(477)
        RemoveIBBuff(478)
        RemoveIBBuff(480)
        local r = math.random(1, 4)
        local H, M, S = GetHMS()
        if (H == 21) and (M >= 20) then
            r = 1
        end
        local key = 0
        if (r <= 3) then
            key = 1
            AddNormalItem(6, 1, 391, 0, 0, 0)
            AddIBBuff(477)
            SetCamp(3)
            TaskNote(84, 0)

            refreshNpcTaskState()

            Msg2Player("B¹n lµ ng­êi 'Trång mÇm', biÕn thµnh Phe xanh")
            SetTaskByte(Task_lucy, 3, 0)
            SetTask(1552, 0)
            Talk(1, "no", "H¹c L·o Nh©n:Ng­¬i lµ ng­êi trång c©y, biÕn thµnh <c=water>phe xanh<c>, cã thÓ trång 2 Th¹ch Miªu, chØ cÇn trång thµnh c«ng 1 lÇn, cã thÓ thu ho¹ch tÊt c¶. Hy väng ng­¬i cã thÓ thu ho¹ch Th¹ch Miªu 2 lÇn.")
        else
            key = 2
            AddIBBuff(480)
            SetCamp(4)
            TaskNote(84, 1)

            refreshNpcTaskState()

            Msg2Player("Äãµ±ÊÇ²É¼¯Ö®ÈË, ±ä³É»ÆÉ«ÕóÓª, ¿ÉÒÔÔ¼ÉÏÒ»Á½Î»¡°Í¬µÀ¡±Ö®ÈËÍ¬È¥")
            SetTask(1552, 0)
            Talk(1, "no", "º×ÀÏÈË: Äãµ±ÊÇ²É¼¯Ö®ÈË, ±ä³É<c=yel>»ÆÉ«<c>ÕóÓª, ¿ÉÒÔÔ¼ÉÏÒ»Á½Î»¡°Í¬µÀ¡±Ö®ÈËÍ¬È¥²É¼¯.")
        end

        SetTask(Task_exnidx, 0)
        SetTask(Task_exnid, 0)
        SetTask(Task_extree_time, 0)

        SetTask(Task_nidx, 0)
        SetTask(Task_nid, 0)
        SetTask(Task_tree_time, 0)
        local h, m, s = GetHMS()
        local lefttime = (21 - h) * 60 * 60 + (30 - m - 1) * 60 + 60 - s
        AddIBBuff(478, lefttime)
        local ntimes = GetTaskByte(Task_renwu, 2) + 1
        SetTaskByte(Task_renwu, 2, ntimes)
        SetTaskByte(Task_renwu, 3, key)
        if (ntimes >= cold_UpTime) then
            SyncBibleState(84, 3, 1)
        else
            SyncBibleState(84, 2, 1)
        end
        return key
    end
end

function coin_yes()
    CloseDialog()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")
    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    if (HaveNormalItem(8, 476, 2, 0) > 0) then
        local key1 = renwu_set()
        if (key1 >= 1) then
            Msg2Player("B¹n ®· giao 1 Cöu Tinh Tø §µn Ch©u")
            CostIBItem(FindAValidIBItem(8, 476, 2, 0))
            if (key1 == 1) then
                Talk(1, "no", 14574)
            elseif (key1 == 2) then
                Talk(1, "facecloth", 14575)
            end
        end
    elseif (GetCoin() >= Cv) then
        local key1 = renwu_set()
        if (key1 >= 1) then
            Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o")
            CostCoinByIdx(CostId)
            if (key1 == 1) then
                Talk(1, "no", 14574)
            elseif (key1 == 2) then
                Talk(1, "facecloth", 14575)
            end
        end
    else
        Talk(1, "no", 14578)
    end

end

function renwu_cancel()
    MsgBox(14579, "cold_cancel", "no")
end

function cold_cancel()
    CloseDialog()
    if (GetTaskByte(Task_renwu, 3) > 0) then
        clear()
        Earn(GetLevel() * 500)
        local money = GetLevel() * 500

        refreshNpcTaskState()

        Talk(1, "no", "c¶m ¬n anh hïng ®· ®Õn t­¬ng trî , ®©y lµ" .. money .. " ng©n l­îng ®Ó c¶m t¹!")
    end
end

function renwu_complete()
    CloseDialog()
    if (GetTaskByte(Task_renwu, 4) == 1) or (GetTaskByte(Task_renwu, 4) == 100) then
        local key = GetTaskByte(Task_renwu, 3)
        local str = ""
        if (key == 2) then
            if (GetCamp() == 4) then
                clear()
                local money = GetLevel() * 3000

                local weekDay = GetWeekDay()
                if (weekDay == 3) then

                    Msg2Player("H«m nay lµ ho¹t ®éng TuÕ Hµn §Þa KhÝ, chóc mõng b¹n nhËn ®­îc phÇn th­ëng gÊp ®«i")
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
                    money = math.floor(money * nDoubel)

                end

                Earn(money)

                str = "NhËn ®­îc ng©n l­îng <c=yel>" .. money .. "<c>"
                Msg2Player("NhËn ®­îc ChuyÓn Long Xu vµ b¹c " .. money)

                AddNormalItem(6, 1, 397, 0, 0, 0)
                str = str .. ", ngoµi ra tÆng ng­¬i thªm <c=g>ChuyÓn Long Xu<c> nµy, cã thÓ më ®­îc <c=g>Thiªn C¬ §ång<c>."
                TopMessage(14580)

            else
                str = "Ng­¬i kh«ng thuéc phe vµng, ta kh«ng thÓ nhËn §Þa KhÝ cña ng­¬i!"
            end
        elseif (key == 1) then
            if (GetCamp() == 3) then
                clear()

                local money = GetLevel() * 1500
                local exp1 = GetLevel() * 3000
                local weekDay = GetWeekDay()
                if (weekDay == 3) then

                    Msg2Player("H«m nay lµ ho¹t ®éng TuÕ Hµn §Þa KhÝ, chóc mõng b¹n nhËn ®­îc phÇn th­ëng gÊp ®«i")
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
                    money = math.floor(money * nDoubel)
                    exp1 = math.floor(exp1 * nDoubel)

                end
                AddOwnExp(exp1)
                Earn(money)

                str = "NhËn ®­îc ng©n l­îng <c=yel>" .. money .. "<c> vµ kinh nghiÖm<c=g>" .. exp1 .. "<c> th­ëng"
                Msg2Player("NhËn tiÒn" .. money .. " vµ kinh nghiÖm" .. exp1 .. " th­ëng")
                local r = math.random(1, 100)
                local vLucy = GetTaskByte(Task_lucy, 1) + 1
                if (GetTaskByte(Task_renwu, 4) ~= 100) then
                    r = 100
                end
                if (r <= 20 * vLucy) then
                    AddNormalItem(3, 240, 0, 0, 0, 0)
                    SetTaskByte(Task_lucy, 1, 0)
                    str = str .. "TÆng ng­¬i thªm <c=g>Thiªn C¬ §ång<c> thÇn bÝ nµy. CÇn ph¶i cã <c=g>ChuyÓn Long Xu<c> míi më ®­îc nã!"
                    TopMessage(14581)
                else
                    SetTaskByte(Task_lucy, 1, vLucy)

                    AddNormalItemBind(6, 1, 988, 1, 0, 0, 1)
                    Msg2Player("Anh hïng ®· nhËn 1 Thiªn C¬ §ång. ")

                end
            else
                str = "Ng­¬i kh«ng thuéc phe xanh, ta kh«ng thÓ nhËn §Þa KhÝ cña ng­¬i!"
            end
        end

        refreshNpcTaskState()

        Talk(1, "no", str)
    else
        renwu_cancel()
    end
end

function clear()
    RemoveIBBuff(477)
    RemoveIBBuff(478)
    RemoveIBBuff(480)
    SetTask(Task_nidx, 0)
    SetTask(Task_nid, 0)
    SetTask(Task_tree_time, 0)
    SetTask(Task_exnidx, 0)
    SetTask(Task_exnid, 0)
    SetTask(Task_extree_time, 0)
    SetTask(1552, 0)
    TaskNote(84, -1)
    ClearItem(6, 1, 391, 0)
    SetTaskByte(Task_renwu, 3, 0)
    SetTaskByte(Task_renwu, 4, 0)
    SetTaskByte(Task_lucy, 3, 0)
    if (HaveIBBuff(481) > 0) then
        if (GetMorphType() == 12) then
            PolyMorph(-1, 1, 0, 6, 0)
        end
        RemoveIBBuff(481)
    end
end

function renwu_jiangli()
    local tasks = {
        { "Th¹ch D­¬ng Gi¸c", "jiangli_1"; show = 1 },
        { " 1 ®«i Th¹ch D­¬ng Gi¸c", "jiangli_2"; show = 1 },
        { "Th¹ch Bµi", "jiangli_3"; show = 1 },
    }
    SayTask(14582, tasks)
end

function jiangli_1()
    local exp1 = GetLevel() * 2000
    MsgBox("Ng­¬i ®ång ý dïng 1 Th¹ch D­¬ng Gi¸c ®Ó t¨ng" .. exp1 .. " kinh nghiÖm chø?", "jl_yes1", "no")
end

function jl_yes1()
    CloseDialog()
    if (HaveNormalItem(3, 238, 0, 0) >= 1) then
        DelNormalItem(3, 238, 0, 0)
        local exp1 = GetLevel() * 2000
        AddOwnExp(exp1)
        Msg2Player("B¹n lÊy ®i 1 Th¹ch D­¬ng Gi¸c, nhËn ®­îc " .. exp1 .. " kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")
    else
        Talk(1, "no", 14583)
    end
end

function jiangli_2()
    local exp1 = GetLevel() * 5000
    MsgBox("Ng­¬i ®ång ý dïng 1 Th¹ch D­¬ng Gi¸c ®Ó ®æi" .. exp1 .. " kinh nghiÖm chø?", "jl_yes2", "no")
end

function jl_yes2()
    CloseDialog()
    if (HaveNormalItem(3, 238, 0, 0) >= 2) then
        DelNormalItem(3, 238, 0, 0)
        DelNormalItem(3, 238, 0, 0)
        local exp1 = GetLevel() * 5000
        AddOwnExp(exp1)
        Msg2Player("B¹n sö dông 1 Th¹ch D­¬ng Gi¸c, nhËn ®­îc " .. exp1 .. " kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")
    else
        Talk(1, "no", 14584)
    end
end

function jiangli_3()
    local exp1 = GetLevel() * 10000
    MsgBox("Ng­¬i ®ång ý dïng Th¹ch Bµi vµ 1 ®«i Th¹ch D­¬ng Gi¸c ®Ó t¨ng" .. exp1 .. " kinh nghiÖm chø?", "jl_yes3", "no")
end

function jl_yes3()
    CloseDialog()
    if (HaveNormalItem(3, 238, 0, 0) >= 2) and (HaveNormalItem(3, 239, 0, 0) >= 1) then
        DelNormalItem(3, 238, 0, 0)
        DelNormalItem(3, 238, 0, 0)
        DelNormalItem(3, 239, 0, 0)
        local exp1 = GetLevel() * 10000
        AddOwnExp(exp1)
        Msg2Player(" B¹n sö dông Th¹ch Bµi vµ 1 ®«i Th¹ch D­¬ng Gi¸c, nhËn ®­îc " .. exp1 .. " kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")
    else
        Talk(1, "no", 14585)
    end
end

function facecloth()
    if (HaveIBBuff(481) > 0) then
        CloseDialog()
        return 0
    end
    local _, _, Cfs = GetCostCoinInfoByIdx(81)
    MsgBox("NhiÖm vô lÇn nµy v« vµn khã kh¨n, nh­ng ta cã c¸ch gióp ng­¬i. NÕu ng­¬i cã" .. Cfs .. " Th«ng B¶o, ta sÏ gióp ng­¬i biÕn thµnh Hång S¸t khiÕn qu¸i kh«ng nhËn ra. Sao h¶?", "cloth", "no")
end

function cloth()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(81)
    if (HaveNormalItem(8, 483, 2, 0) > 0) then
        SetTaskByte(Task_lucy, 3, 1)

        PolyMorph(12, 1, 0, -1, 1800, 1, 1)
        AddIBBuff(481)
        Msg2Player("B¹n giao n¹p M«ng DiÖn C©n")
        CostIBItem(FindAValidIBItem(8, 482, 2, 0))
        Talk(1, "no", "Cã M«ng DiÖn C©n nµy råi, ta sÏ gióp ng­¬i Èn th©n. Mau ®i thu thËp ®i!")
    elseif (GetCoin() >= Cv) then
        SetTaskByte(Task_lucy, 3, 1)

        PolyMorph(12, 1, 0, -1, 1800, 1, 1)
        AddIBBuff(481)
        CostCoinByIdx(81)
        Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o")
        Talk(1, "no", "Cã" .. Cfs .. " Th«ng B¶o nµy råi, ta sÏ gióp ng­¬i Èn th©n. Mau ®i thu thËp ®i!")
    else
        Talk(1, "no", " Th«ng B¶o cña ng­¬i kh«ng ®ñ" .. Cfs .. ", ta ®µnh bã tay th«i!")
    end
end

function renwu_seed()
    local ntimes = GetTaskByte(Task_renwu, 2)
    local money = GetLevel() * 3000
    if (ntimes == 0) then
        MsgBox("Ng­¬i muèn <c=g>trång Linh Th¹ch<c>?...Uhm... Ch¾c ph¶i tÆng ta thªm" .. money .. " l­îng th× ta míi gióp ®­îc!", "seed_yes", "no")
    elseif (ntimes >= cold_UpTime) then
        Talk(1, "no", "Thêi vËn cña ng­¬i ®· ®æi! §Þa KhÝ mçi ngµy chØ cã thÓ thu thËp" .. cold_UpTime .. " lÇn. May h·y quay l¹i nhÐ!")
    else


        local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")

        local _, _, Cfs = 1, SalePriceCount, SalePriceName
        local strValue = "Ng­¬i ®· lµm nhiÖm vô nµy råi, giê muèn <c=g>trång Linh Th¹ch<c>, trõ phi ng­¬i cã <c=g>Cöu Tinh Tø §µn Ch©u<c> hoÆc <c=r>" .. PriceName .. " Th«ng B¶o<c> th× ta cã thÓ ph¸ lÖ. §­¬ng nhiªn ng­¬i vÉn ph¶i ®Æt" .. money .. " tiÒn cäc"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        MsgBox(strValue, "coin_seedyes", "no")

    end
end

function seed_yes()
    CloseDialog()
    if (seed_set() == 1) then
        Talk(1, "no", 14574)
    end
end

function seed_set()
    CloseDialog()
    if (IsInTime() ~= 1) then
        Talk(1, "no", 14573)
        return 0
    end

    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14576)
        return 0
    end

    local money = GetLevel() * 3000
    if (GetCash() < money) then
        Talk(1, "no", 14577)
        return 0
    else
        local h, m, s = GetHMS()

        Pay(money, 1)

        RemoveIBBuff(477)
        RemoveIBBuff(478)
        RemoveIBBuff(480)
        AddNormalItem(6, 1, 391, 0, 0, 0)
        AddIBBuff(477)
        SetCamp(3)
        TaskNote(84, 0)

        refreshNpcTaskState()

        Msg2Player("B¹n lµ ng­êi 'Trång mÇm', biÕn thµnh Phe xanh")
        Talk(1, "no", "H¹c L·o Nh©n:Ng­¬i lµ ng­êi trång c©y, biÕn thµnh <c=water>phe xanh<c>, cã thÓ trång 2 Th¹ch Miªu, chØ cÇn trång thµnh c«ng 1 lÇn, cã thÓ thu ho¹ch tÊt c¶. Hy väng ng­¬i cã thÓ thu ho¹ch Th¹ch Miªu 2 lÇn.")
        SetTask(Task_exnidx, 0)
        SetTask(Task_exnid, 0)
        SetTask(Task_extree_time, 0)
        SetTask(1552, 0)

        SetTask(Task_nidx, 0)
        SetTask(Task_nid, 0)
        SetTask(Task_tree_time, 0)
        local lefttime = (21 - h) * 60 * 60 + (30 - m - 1) * 60 + 60 - s
        AddIBBuff(478, lefttime)
        local ntimes = GetTaskByte(Task_renwu, 2) + 1
        SetTaskByte(Task_renwu, 2, ntimes)
        SetTaskByte(Task_renwu, 3, 1)
        SetTaskByte(Task_lucy, 3, 0)
        if (ntimes >= cold_UpTime) then
            SyncBibleState(84, 3, 1)
        else
            SyncBibleState(84, 2, 1)
        end
        return 1
    end
end

function coin_seedyes()
    CloseDialog()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")
    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    if (HaveNormalItem(8, 476, 2, 0) > 0) then
        if (seed_set() >= 1) then
            Msg2Player("B¹n ®· giao 1 Cöu Tinh Tø §µn Ch©u")
            CostIBItem(FindAValidIBItem(8, 476, 2, 0))
            Talk(1, "no", 14574)
        end
    elseif (GetCoin() >= Cv) then
        if (seed_set() >= 1) then
            Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o")
            CostCoinByIdx(CostId)
            Talk(1, "no", 14574)
        end
    else
        Talk(1, "no", 14578)
    end

end

function renwu_pick()
    local ntimes = GetTaskByte(Task_renwu, 2)
    local money = GetLevel() * 3000
    if (ntimes == 0) then
        MsgBox("Ng­¬i muèn <c=g>thu thËp Linh Th¹ch<c>?...Uhm... Ch¾c ph¶i tÆng ta thªm" .. money .. " l­îng th× ta míi gióp ®­îc!", "pick_yes", "no")
    elseif (ntimes >= cold_UpTime) then
        Talk(1, "no", "Thêi vËn cña ng­¬i ®· ®æi! §Þa KhÝ mçi ngµy chØ cã thÓ thu thËp" .. cold_UpTime .. " lÇn. May h·y quay l¹i nhÐ!")
    else

        local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")
        local _, _, Cfs = 1, SalePriceCount, SalePriceName
        local strValue = "Ng­¬i ®· lµm nhiÖm vô nµy råi, giê muèn <c=g>thu thËp Linh Th¹ch<c>, trõ phi ng­¬i cã <c=g>Cöu Tinh Tø §µn Ch©u<c> hoÆc <c=r>" .. PriceName .. " Th«ng B¶o<c> th× ta cã thÓ ph¸ lÖ. §­¬ng nhiªn ng­¬i vÉn ph¶i ®Æt" .. money .. " tiÒn cäc"
        if (1 <= BrokenNumber) then
            strValue = strValue .. strShow
        end
        MsgBox(strValue, "coin_pickyes", "no")
    end
end

function pick_yes()
    CloseDialog()
    if (pick_set() == 1) then
        Talk(1, "facecloth", 14575)
    end
end

function pick_set()
    CloseDialog()
    if (IsInTime() ~= 1) then
        Talk(1, "no", 14573)
        return 0
    end

    if (GetIBBuffCount() >= 31) then
        Talk(1, "no", 14576)
        return 0
    end

    local money = GetLevel() * 3000
    if (GetCash() < money) then
        Talk(1, "no", 14577)
        return 0
    else
        local h, m, s = GetHMS()

        Pay(money, 1)

        RemoveIBBuff(477)
        RemoveIBBuff(478)
        RemoveIBBuff(480)

        AddIBBuff(480)
        SetCamp(4)
        TaskNote(84, 1)

        refreshNpcTaskState()

        Msg2Player("Äãµ±ÊÇ²É¼¯Ö®ÈË, ±ä³É»ÆÉ«ÕóÓª, ¿ÉÒÔÔ¼ÉÏÒ»Á½Î»¡°Í¬µÀ¡±Ö®ÈËÍ¬È¥")
        Talk(1, "no", "º×ÀÏÈË: Äãµ±ÊÇ²É¼¯Ö®ÈË, ±ä³É<c=yel>»ÆÉ«<c>ÕóÓª, ¿ÉÒÔÔ¼ÉÏÒ»Á½Î»¡°Í¬µÀ¡±Ö®ÈËÍ¬È¥²É¼¯.")
        SetTask(Task_exnidx, 0)
        SetTask(Task_exnid, 0)
        SetTask(Task_extree_time, 0)
        SetTask(1552, 0)
        SetTask(Task_nidx, 0)
        SetTask(Task_nid, 0)
        SetTask(Task_tree_time, 0)
        local lefttime = (21 - h) * 60 * 60 + (30 - m - 1) * 60 + 60 - s
        AddIBBuff(478, lefttime)
        local ntimes = GetTaskByte(Task_renwu, 2) + 1
        SetTaskByte(Task_renwu, 2, ntimes)
        SetTaskByte(Task_renwu, 3, 2)
        if (ntimes >= cold_UpTime) then
            SyncBibleState(84, 3, 1)
        else
            SyncBibleState(84, 2, 1)
        end
        return 1
    end
end

function coin_pickyes()
    CloseDialog()

    local TaskTimes, TaskName, BrokenNumber, PriceName, PriceCount, SalePriceName, SalePriceCount, CostId, strShow = ThemeDayForHuman.PubFuncCostTBByHaploid("TuÕ Hµn §Þa KhÝ")
    local _, Cv, Cfs = 1, SalePriceCount, SalePriceName
    if (HaveNormalItem(8, 476, 2, 0) > 0) then
        if (pick_set() >= 1) then
            Msg2Player("B¹n ®· giao 1 Cöu Tinh Tø §µn Ch©u")
            CostIBItem(FindAValidIBItem(8, 476, 2, 0))
            Talk(1, "facecloth", 14575)
        end
    elseif (GetCoin() >= Cv) then
        if (pick_set() >= 1) then
            Msg2Player("B¹n dïng " .. Cfs .. " Th«ng B¶o")
            CostCoinByIdx(CostId)
            Talk(1, "facecloth", 14575)
        end
    else
        Talk(1, "no", 14578)
    end

end
