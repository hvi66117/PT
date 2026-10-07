require("newserver.luax")
GLOBAL_VALUE_ENTER_COUNT = 198
TASK_ASW_STAR_STATE = 1403
TASK_ASW_TIME = 1404
TASK_ASW_STAR_STATE_1 = 1405
TASK_ASW_STAT_STATE_2 = 1406

session_item = {
    [1] = {
        { "ThÝ luyÖn Phñ §Çu Bang", 30, 3, 3, 11, { 196 * 8, 207 * 8, 214 * 8 }, { 195 * 16, 200 * 16, 204 * 16 }, 120 },
    }
}
TableExchangeCount = { 20, 50, 90, 140, 200 }
TableExchangeRatio = { 0.8, 0.9, 1, 1.1, 1.2 }

Task_FuTouBang_First = 1877

Task_FuTouBang_InstanceID = 1879

Task_FuTouBang_InstanceIndex = 1880

Task_FuTouBang_Exchange = 1881

session_resetlimit = 1

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
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 17) then
                state = 3
                subState = 0
            elseif (taskProcess >= 10) and (taskProcess < 17) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 17) then
                state = 3
                subState = 1
            elseif (taskProcess >= 10) and (taskProcess < 17) then
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

function main()
    tasks = {
        { "ThÕ Së", "renwu1"; show = 0 },
        { "<c=yel>V¨n Khóc h¹ phµm<c>", "subject"; show = 0 },

        { "<c=yel>ThÝ luyÖn Phñ §Çu Bang<c>", "theaxegang"; show = 1 },

    }
    UTask_Wizard = GetTask(1);
    if (UTask_Wizard == 17) then
        tasks[1].show = 1;
    end ;
    if (GetPlayerType() == 1) and (GetLevel() >= 35) and (UTask_Wizard == 2) then
        tasks[1].show = 1;
    end ;

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()
    local w, x, y = GetWorldPos()
    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    if ((d1 == 1) or (d1 == 15)) and (H >= 19) and (H < 22) and (w == 20) and (state == 1) then
        tasks[2].show = 1
    end

    SayTask(10418, tasks)
end;

aryAnswerNpc = {
    "LÔ Quan",
    "Tiªu s­",
    "Vâ s­",
    "T©n Gi¸p",
    "TiÓu B¶o",
    "Du §¹o",
    "Th¸i TuÕ",
    "Ng­êi h¸i thuèc",
    "Phï Ên s­",
    "Na Tra",
    "L«i ChÊn Tö",
    "Vâ V­¬ng",
}

LIB_RANDOM = {
    20,
    50,
    80,
    100,
}

function theaxegang()
    CloseDialog()
    local temp = session_item[1]
    local list_ten = {}
    local strl = ""
    local plvl = GetLevel()
    local pID, nflag = 0, 0
    local n = 1
    for i = 1, table.getn(temp) do
        if (plvl < temp[i][2]) then
            break
        end
        pID, nflag = isOpenshow(temp[i])

        if (nflag <= 2 and nflag >= 1) or (nflag == 0) then
            strl = "(CÇn cÊp:" .. temp[i][2] .. ")"
            list_ten[n] = "Vµo phã b¶n" .. strl .. "/item" .. i
            n = n + 1
        end
    end

    list_ten[n] = "§æi kinh nghiÖm/ChangeExp"
    n = n + 1

    list_ten[n] = "H­íng dÉn Phã b¶n/Instance_Info"
    n = n + 1

    list_ten[n] = "Quay l¹i/main"
    Say("GÇn ®©y ta ph¸t hiÖn 1 lèi vµo, ®ã lµ <c=red>Tr­ Lung Thµnh Tr¹i<c>, n¬i nµy nguy hiÓm kh«n l­êng, cÇn tæ ®éi 3 ng­êi míi vµo. Trong ®ã nhËn ®­îc <c=g>TÝn vËt Phñ §Çu Bang<c> mang ®Õn ®©y ®æi kinh nghiÖm. ", n, list_ten)
end

function isOpenshow(templist)
    local today = math.floor(LocalSystemTime() / 86400)
    local pID, pTime, pLastCount, pTotalCount, nflag = GetInstanceEnterInfo(templist[5])
    if (math.floor(pTime / 86400) ~= today) then
        ClearInstanceEnterInfo(templist[5])
        pID, pTime, pLastCount, pTotalCount, nflag = GetInstanceEnterInfo(templist[5])
    end
    local nState, pID1, pTime1
    local idx = templist[5]
    if (pID == 0) then
        if (nflag == 0) then
            return pID, 0
        else
            nflag = 4
            return pID, nflag
        end
    else
        nState, _, _, _ = GetInstanceActiveInfo(pID)
        if (nState == 1) then
            return pID, nflag
        elseif (today == math.floor(pTime / 86400)) then
            return pID, nflag
        else
            return 0, 0
        end
    end
    return 0, 0
end

function item1()
    CloseDialog()
    item_10(1)
end

function item_10(num)
    local morph = GetMorphType()
    if (morph == 364) or (morph == 85) or (morph == 420) or (morph == 419) or (morph == 411) then
        Msg2Player("L«i ChÊn Tö: Xem ra cßn 1 sè viÖc ch­a hoµn thµnh, h·y chuÈn bÞ l¸t sau h·y ®Õn!")
        return 0
    elseif (IsPlayerInsideWeapon(PlayerIndex) == 1) then
        Msg2Player("L«i ChÊn Tö: Xem ra cßn 1 sè viÖc ch­a hoµn thµnh, h·y chuÈn bÞ l¸t sau h·y ®Õn!")
        return 0
    end

    if (Iscondition(1, num) ~= 1) then
        Msg2Player("L«i ChÊn Tö:RÊt tiÕc, tæ ®éi kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>!")
        return 0
    end
end

function Iscondition(type, nums)
    local tempinfo = session_item[type][nums]
    local pInstanceType = tempinfo[5]
    local pID, pFlag = isOpenshow(tempinfo)

    local isNewInstance = 0

    if (GetTeam() == 0) then
        if (pID == 0) then
            Talk(1, "no", "L«i ChÊn Tö:<c=red>Tr­ Lung Thµnh Tr¹i<c> v« cïng hiÓm trë, c« th­¬ng ®éc m· lµnh Ýt d÷ nhiÒu. T×m <c=g>2 ng­êi<c> huynh ®Ö kÕt Anh hïng ®ång hµnh, chó ý, mçi ngµy chØ vµo <c=g>30 phót<c>. Cßn n÷a <c=g>®éi tr­ëng<c> míi cã thÓ xin vµo. ")
            return 0
        else
            local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(pID)
            if (nState == 0) then
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> thay ®æi liªn tôc, ph¸p lùc cña bÇn ®¹o chØ më 1 cöa trËn ph¸p <c=g>30 phót<c>, ®· qu¸ h¹n, kh«ng thÓ vµo.")
                return 0
            elseif (nCurrentEnterCount < tempinfo[4]) then
                CloseDialog()

                if (GetCamp() == 8) or (GetPK() > 87) then
                    Msg2Player("L«i ChÊn Tö:RÊt tiÕc, ng­¬i lµ phe ®á, kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>. ")
                    return 0
                end

                if (pFlag == 4 or pFlag == 3) then
                    Talk(1, "no", "H«m nay ®· vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> råi, ngµy mai h·y ®Õn. ")
                    PlayerIndex = oldPlayer
                    return 0
                end
                local nTaskState = GetTaskByte(Task_FuTouBang_First, 3)
                if (nTaskState < 1 or nTaskState > 3) then
                    nTaskState = 1
                end
                SetJevilInstance(0)
                EnterInstance(pID, tempinfo[6][nTaskState], tempinfo[7][nTaskState])
                return 1
            else
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> rÊt khã ph¸t hiÖn, ph¸p lùc cña bÇn ®¹o ®· dïng hÕt, kh«ng thÓ gióp anh hïng vµo trËn, h·y chê chót ®Ó vµo.")
                return 0
            end
        end
    else
        local membercount = GetTeamSize()
        local limitmember1 = tempinfo[4]
        if (membercount > limitmember1) then
            Talk(1, "no", "L«i ChÊn Tö:<c=red>Tr­ Lung Thµnh Tr¹i<c> mçi trËn ph¸p chØ cho phÐp 3 ng­êi vµo, tæ ®éi qu¸ nhiÒu ng­êi!")
            return 0
        elseif (IsCaptain() == 0) then
            Talk(1, "no", "L«i ChÊn Tö:<c=red>Tr­ Lung Thµnh Tr¹i<c> v« cïng hiÓm trë, c« th­¬ng ®éc m· lµnh Ýt d÷ nhiÒu, h·y t×m <c=g>2 ng­êi<c> huynh ®Ö ®ång hµnh, chó ý sè lÇn mçi ngµy mçi ng­êi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> cã giíi h¹n. ChØ <c=g>®éi tr­ëng<c> míi cã thÓ xin vµo. ")
            return 0
        end

        if (pID == 0) then
            local H, M, S = GetHMS()
            if (H < 8) or (H >= 23) then
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> rÊt khã ph¸t hiÖn, mçi ngµy <c=g>8h-23h <c>, bÇn ®¹o m­în linh khÝ trêi ®Êt gióp thÝ chñ më cöa <c=red>Tr­ Lung Thµnh Tr¹i<c>, nh­ng hiÖn t¹i anh hïng cßn cã thÓ th«ng qua cöa trËn ®· më quay vÒ trËn ph¸p. ")
                return 0
            end

            local limitmember = tempinfo[3]
            if (membercount < limitmember) then
                Talk(1, "no", "L«i ChÊn Tö:<c=red>Tr­ Lung Thµnh Tr¹i<c> v« cïng hiÓm trë, c« th­¬ng ®éc m· lµnh Ýt d÷ nhiÒu, h·y t×m <c=g>2 ng­êi<c> huynh ®Ö ®ång hµnh, chó ý sè lÇn mçi ngµy mçi ng­êi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> cã giíi h¹n. ChØ <c=g>®éi tr­ëng<c> míi cã thÓ xin vµo. ")
                return 0
            end

            if (math.abs(LocalSystemTime() - GetNpcTask(GetTask(140), 2)) < 5) then
                Talk(1, "no", "L«i ChÊn Tö:BÇn ®¹o võa më 1 cöa trËn, ph¸p lùc ch­a håi phôc, l¸t sau h·y vµo. ")
                return 0
            end

            pID = GetNewInstanceId(pInstanceType)
            if (pID == 0) then
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> rÊt khã ph¸t hiÖn, ph¸p lùc cña bÇn ®¹o ®· dïng hÕt, kh«ng thÓ truyÒn tèng vµo, l¸t sau h·y vµo. ")
                return 0
            end

            SetNpcTask(GetTask(140), 2, LocalSystemTime())
            isNewInstance = 1
        else
            local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(pID)
            if (nState == 0) then
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> thay ®æi liªn tôc, ph¸p lùc cña bÇn ®¹o chØ më 1 cöa trËn ph¸p <c=g>30 phót<c>, ®· qu¸ h¹n, kh«ng thÓ vµo.")
                return 0
            elseif (nCurrentEnterCount > limitmember1 - membercount) then
                Talk(1, "no", "L«i ChÊn Tö: Mçi trËn ph¸p cã thÓ vµo" .. limitmember1 .. " ng­êi, hiÖn t¹i trong ph¸p trËn ®· cã" .. nCurrentEnterCount .. "ng­êi.")
                return 0
            end
        end

        local m, x, y = GetWorldPos()
        if (Isstate(tempinfo, pID, membercount, tempinfo[2], tempinfo[8], m, x, y) == 0) then
            Talk(1, "no", "L«i ChÊn Tö:RÊt tiÕc, hµnh viªn tæ ®éi kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>!")
            return 0
        else
            if (pID == 0) then
                pID = GetNewInstanceId(pInstanceType)
                if (pID == 0) then
                    Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> rÊt khã ph¸t hiÖn, ph¸p lùc cña bÇn ®¹o ®· dïng hÕt, kh«ng thÓ truyÒn tèng vµo, l¸t sau h·y vµo. ")
                    return 0
                end
                isNewInstance = 1
            end

            local oldPlayer = PlayerIndex
            local str = tempinfo[1]
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                SetTask(142, pID)
                SetTaskWord(140, 1, type)
                SetTaskWord(140, 2, nums)
            end
            PlayerIndex = oldPlayer

            TeamAction("isenter", PlayerIndex, 0, 0)
            return 1
        end
    end
end

function Isstate(nInstanceinfo, cID, membercount, minlvl, maxlvl, mapid, x1, y1)
    local oldPlayer = PlayerIndex
    local pID, pFlag = 0, 0
    local w, x, y

    for i = 1, membercount do
        PlayerIndex = GetTeamMember(i)
        if (GetLevel() < minlvl or GetLevel() > maxlvl) then
            Msg2Team(GetName() .. "CÊp kh«ng phï hîp, kh«ng thÓ vµo trËn ph¸p nµy.")
            PlayerIndex = oldPlayer
            return 0
        end

        local morph = GetMorphType()
        if (morph == 364) or (morph == 85) or (morph == 420) or (morph == 419) or (morph == 411) then
            Msg2Team(GetName() .. "Tr¹ng th¸i kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>. ")
            PlayerIndex = oldPlayer
            return 0
        elseif (IsPlayerInsideWeapon(PlayerIndex) == 1) then
            Msg2Team(GetName() .. "Tr¹ng th¸i kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>. ")
            PlayerIndex = oldPlayer
            return 0
        end

        if (GetCamp() == 8) or (GetPK() > 87) then
            Msg2Team(GetName() .. "Lµ phe ®á, kh«ng thÓ vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>. ")
            PlayerIndex = oldPlayer
            return 0
        end

        w, x, y = GetWorldPos()
        if (mapid ~= w) or ((x1 - x) ^ 2 + (y1 - y) ^ 2 >= 625) then
            Msg2Team(GetName() .. "Cù ly qu¸ xa, kh«ng thÓ truyÒn tèng.")
            PlayerIndex = oldPlayer
            return 0
        end

        pID, pFlag = isOpenshow(nInstanceinfo)

        if ((pID ~= 0) and (pID ~= cID)) or (pFlag == 4 or pFlag == 3) then
            Msg2Team(GetName() .. "Kh«ng tháa yªu cÇu, h«m nay ®· vµo <c=red>Tr­ Lung Thµnh Tr¹i<c>")
            PlayerIndex = oldPlayer
            return 0
        end
    end
    PlayerIndex = oldPlayer
    return 1
end

function isenter(nParam)


    local PlayerLevel = 0
    local membercount = GetTeamSize()
    local nOldPlayer = PlayerIndex
    for i = 1, membercount do
        PlayerIndex = GetTeamMember(i)
        PlayerLevel = PlayerLevel + GetLevel()
    end
    PlayerIndex = nOldPlayer
    PlayerLevel = math.floor(PlayerLevel / membercount)
    if (PlayerLevel <= 1) then
        PlayerLevel = 1
    elseif (PlayerLevel >= 200) then
        PlayerLevel = 200
    end
    SetTaskByte(Task_FuTouBang_First, 4, PlayerLevel)

    if (nParam ~= PlayerIndex) then
        local type = GetTaskWord(140, 1)
        local nums = GetTaskWord(140, 2)
        MsgBox("HiÖn t¹i b¹n muèn vµo <c=yel>" .. session_item[type][nums][1] .. "<c> kh«ng?", "yes_enter", "no_enter")
    else
        yes_enter()
    end
end

function yes_enter()
    CloseDialog()
    local type = GetTaskWord(140, 1)
    if (type >= 1) and (type <= table.getn(session_item)) then
        local nums = GetTaskWord(140, 2)
        local temp = session_item[type]

        if (nums >= 1) and (nums <= table.getn(temp)) then
            temp = temp[nums]
            local pID = GetTask(142)
            local nState, nType, nFirstEnterTime, nCurrentEnterCount = GetInstanceActiveInfo(pID)
            if (nState == 0) or (pID == 0) then
                Talk(1, "no", "L«i ChÊn Tö:Lèi vµo <c=red>Tr­ Lung Thµnh Tr¹i<c> thay ®æi liªn tôc, ph¸p lùc cña bÇn ®¹o chØ më 1 cöa trËn ph¸p <c=g>30 phót<c>, ®· qu¸ h¹n, kh«ng thÓ vµo.")
                return 0
            elseif (nCurrentEnterCount < temp[4]) then
                SetJevilInstance(0)
                SetTaskByte(Task_FuTouBang_First, 3, 1)
                EnterInstance(pID, temp[6][1], temp[7][1])
            else

                if (limitmember1 ~= nil) then
                    Talk(1, "no", "L«i ChÊn Tö: Mçi trËn ph¸p chØ cho phÐp" .. limitmember1 .. " ng­êi, hiÖn t¹i trong ph¸p trËn ®· ®ñ ng­êi.")
                else
                    Talk(1, "no", "L«i ChÊn Tö: Ã¿¸ö·¨Õó¿ÉÒÔÈÝÄÉµÄÈËÊýÓÐÏÞ, ÏÖÔÚ·¨ÕóÖ®ÖÐÈËÊýÒÑÂú.")
                end

            end
        end
    end
end

function no_enter()
    CloseDialog()
    local type = GetTaskWord(140, 1)
    local nums = GetTaskWord(140, 2)
    Msg2Player("B¹n hñy c¬ héi vµo" .. session_item[type][nums][1] .. " c¬ héi")
    LeaveTeam()
end

function ChangeExp()
    no()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nLastDay = GetTaskByte(Task_FuTouBang_Exchange, 2)
    if (nToday ~= nLastDay) then
        SetTaskByte(Task_FuTouBang_Exchange, 1, 0)
        SetTaskByte(Task_FuTouBang_Exchange, 2, nToday)
    end
    local nTodayChangeTimes = GetTaskByte(Task_FuTouBang_Exchange, 1)
    if (nTodayChangeTimes >= 5) then
        Talk(1, "main", "H«m nay ®· ®æi 5 lÇn, kh«ng thÓ ®æi n÷a.")
        return
    else
        local nTableTemp = nTodayChangeTimes + 1
        if (nTableTemp < 1 or nTableTemp > 5) then
            return
        end
        local nItemCount = TableExchangeCount[nTableTemp]
        if (HaveNormalItem(3, 1196, 0, 0) < nItemCount) then
            Talk(1, "main", "H«m nay ®· ®æi <c=red> lÇn " .. nTableTemp .. "<c>, cÇn <c=red>" .. nItemCount .. "<c>TÝn vËt Phñ §Çu Bang, sè l­îng kh«ng ®ñ, kh«ng thÓ ®æi.")
            return
        else

            local nReturnExp = 0
            local nLevel = GetLevel()
            if (nLevel < 50) then
                nReturnExp = nLevel * 800
            elseif (nLevel < 70) then
                nReturnExp = nLevel * 1500
            elseif (nLevel < 90) then
                nReturnExp = nLevel * 2000
            else
                nReturnExp = nLevel * 2500
            end

            nReturnExp = TableExchangeRatio[nTableTemp] * nReturnExp
            nReturnExp = math.floor(nReturnExp)
            local str = ""
            if (IsNewServerActivityDay() >= 1) then
                str = "(HiÖn t¹i lµ thêi gian ho¹t ®éng m¸y chñ míi, nhËn thªm <c=g>" .. nReturnExp .. "<c> kinh nghiÖm)"
            end
            MsgBox("H«m nay ®· ®æi <c=red> lÇn " .. nTableTemp .. "®æi <c> lÇn, Anh hïng ®ång ý tiªu hao <c=red>" .. nItemCount .. "<c>TÝn vËt Phñ §Çu Bang, ®æi <c=g>" .. nReturnExp .. "<c> ®iÓm kinh nghiÖm." .. str .. "?", "ChangeExpSure", "no")
        end
    end
end
function ChangeExpSure()
    no()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    local nLastDay = GetTaskByte(Task_FuTouBang_Exchange, 2)
    if (nToday ~= nLastDay) then
        SetTaskByte(Task_FuTouBang_Exchange, 1, 0)
        SetTaskByte(Task_FuTouBang_Exchange, 2, nToday)
    end
    local nTodayChangeTimes = GetTaskByte(Task_FuTouBang_Exchange, 1)
    if (nTodayChangeTimes >= 5) then
        Talk(1, "main", "H«m nay ®· ®æi 5 lÇn, kh«ng thÓ ®æi n÷a.")
        return
    else
        local nTableTemp = nTodayChangeTimes + 1
        if (nTableTemp < 1 or nTableTemp > 5) then
            return
        end
        local nItemCount = TableExchangeCount[nTableTemp]
        if (HaveNormalItem(3, 1196, 0, 0) < nItemCount) then
            Talk(1, "main", "H«m nay ®· ®æi <c=red> lÇn " .. nTableTemp .. "<c>, cÇn <c=red>" .. nItemCount .. "<c>TÝn vËt Phñ §Çu Bang, sè l­îng kh«ng ®ñ, kh«ng thÓ ®æi.")
            return
        else
            for i = 1, nItemCount do
                DelNormalItem(3, 1196, 0, 0)
            end
            SetTaskByte(Task_FuTouBang_Exchange, 1, nTableTemp)

            local nReturnExp = 0
            local nLevel = GetLevel()
            if (nLevel < 50) then
                nReturnExp = nLevel * 800
            elseif (nLevel < 70) then
                nReturnExp = nLevel * 1500
            elseif (nLevel < 90) then
                nReturnExp = nLevel * 2000
            else
                nReturnExp = nLevel * 2500
            end

            nReturnExp = TableExchangeRatio[nTableTemp] * nReturnExp
            local str = ""
            if (IsNewServerActivityDay() >= 1) then
                nReturnExp = nReturnExp + nReturnExp
                str = "HiÖn t¹i lµ ho¹t ®éng m¸y chñ míi, chóc mõng anh hïng nhËn phÇn th­ëng x2."
                Msg2Player(str)
            end
            AddOwnExp(nReturnExp)
            nReturnExp = math.floor(nReturnExp)
            TopMessage("Ng­¬i ®· nhËn ®­îc " .. nReturnExp .. " kinh nghiÖm")
            Msg2Player("Ng­¬i ®· nhËn ®­îc " .. nReturnExp .. " kinh nghiÖm.")
            WriteLog("[CÊp][" .. nLevel .. "][Sè lÇn][" .. nTableTemp .. "][Kinh nghiÖm][" .. nReturnExp .. "][Tiªu hao][" .. nItemCount .. "]")
            Talk(1, "main", "H«m nay ®· ®æi <c=red> lÇn " .. nTableTemp .. " ®æi <c> lÇn, tiªu hao <c=red>" .. nItemCount .. "<c>TÝn vËt Phñ §Çu Bang, nhËn <c=g>" .. nReturnExp .. "<c> ®iÓm kinh nghiÖm.")
        end
    end
end

function Instance_Info()
    no()
    Talk(1, "theaxegang", "¸«Í·°ïÊÔÁ¶¸±±¾ cÊp 30-120 µÄÍæ¼ÒÃ¿ÌìÖ»ÄÜ½øÈëÒ»´Î, Ò»´Î<c=g>30·ÖÖÓ<c>;Ðè3ÈË×é¶Ó²ÅÄÜ½øÈë¸±±¾;¸±±¾ÖÐµÄ¹ÖÎïµôÂäµÄ¸«Í·°ïÐÅÎïÄÜ¶Ò»»´óÁ¿¾­Ñé, Ã¿Ìì¶Ò»»¾­ÑéµÄËùÐèµÄµÀ¾ßÊýÁ¿Öð½¥Ìá¸ß, Ã¿Ìì×î¶à¶Ò»»5´Î¾­Ñé.Èç¹ûÄã¾¾³ö¼äµý²¢´ò°ÜËû, ËüÓÃÀ´ÊÕÂò¸«Í·°ïÖÚµÄÃÜ±£¾Í¹éÄãËùÓÐÁË!")
end

function IsNewServerActivityDay()
    if (NewServerEx.Pub_IsNewFuTouBang() > 0) then
        return 1
    end
    return 0
end

function subject()

    CloseDialog()

    if (HaveIBBuff(651) ~= 1) then
        Talk(1, "no", " Xin lçi, ho¹t ®éng ng­¬i tham gia ®· kÕt thóc, theo giao ­íc cña V¨n Khóc Tinh qu©n, ta kh«ng thÓ ®Æt c©u hái cho b¹n! NÕu muèn nhËn th­ëng, h·y ®Õn chç Vâ v­¬ng!")
        return
    end

    if (GetMorphType() ~= 787) then
        Talk(1, "no", " Xin lçi, h×nh t­îng míi cña ng­¬i kh«ng phï hîp víi giao ­íc cña V¨n Khóc Tinh qu©n, ta kh«ng thÓ ®Æt c©u hái cho b¹n!")
        return
    end

    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    if (state ~= 1) then
        Talk(1, "no", " Xin lçi, ng­¬i ch­a ®Õn LÔ Quan T©y Kú b¸o danh, theo giao ­íc cña V¨n Khóc Tinh qu©n, ta kh«ng thÓ ®Æt c©u hái cho b¹n. NÕu muèn tham gia ho¹t ®éng nµy h·y  mau chãng ®Õn gÆp LÔ Quan b¸o danh vµ t×m hiÓu c¸c th«ng tin ho¹t ®éng!")
        return
    end

    if (npctype ~= 11) then
        Talk(1, "no", "Theo giao ­íc cña V¨n Khóc Tinh qu©n, ng­¬i ph¶i ®i ®Õn <c=g>" .. aryAnswerNpc[npctype] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
        return
    end

    if (answerTime >= 3) then
        SetTaskByte(TASK_ASW_STAR_STATE, 4, npctype + 1)
        Talk(1, "no", "Theo giao ­íc cña V¨n Khóc Tinh qu©n, ng­¬i ph¶i ®i ®Õn <c=g>" .. aryAnswerNpc[npctype] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
        return
    end

    local nLastLibIndex = GetTaskByte(TASK_ASW_STAR_STATE_1, 1)
    local nLastQueIndex = GetTaskByte(TASK_ASW_STAR_STATE_1, 2)
    local nIsAnswer = GetTaskByte(TASK_ASW_STAR_STATE_1, 3)

    local nLibIndex = 0
    local nQueIndex = 0

    if (nIsAnswer == 1) then

        while 1 do

            local nRand = 1
            local nRandSeed = math.random(1, 100)
            for i = 1, table.getn(LIB_RANDOM), 1 do

                if (nRandSeed <= LIB_RANDOM[i]) then
                    nRand = i
                    break
                end

            end

            if (nRand ~= nLastLibIndex) then
                nLibIndex = nRand
                break
            end

        end

        nQueIndex = math.random(1, GetQuestionNum(nLibIndex))

    else

        nLibIndex = nLastLibIndex
        nQueIndex = nLastQueIndex

    end

    local nQueAnswerNum = GetQuestionAnswerNum(nLibIndex, nQueIndex)

    local list = {}
    for i = 1, nQueAnswerNum do
        list[i] = GetQuestionOptionString(nLibIndex, nQueIndex, i) .. "/Option"
    end

    nQueAnswerNum = nQueAnswerNum + 1
    list[nQueAnswerNum] = "Hç trî tr¶ lêi /HelpOption"

    RandQuestion(nLibIndex, nQueIndex, nQueAnswerNum, nQueAnswerNum - 1, list)

    SetTaskByte(TASK_ASW_STAR_STATE_1, 1, nLibIndex)
    SetTaskByte(TASK_ASW_STAR_STATE_1, 2, nQueIndex)
    SetTaskByte(TASK_ASW_STAR_STATE_1, 3, 0)

end

function HelpOption()

    CloseDialog()

    local task = {
        { "Thiªn c¬ tiÕt lé", "useHelp"; show = 0 },
        { "Xin TrÝ ®a tinh gióp ®ì", "useIB"; show = 1 },
    }

    if (HaveIBBuff(652) > 0) then
        task[1].show = 1
    end

    SayTask(" §Ò thi cña V¨n Khóc Tinh qu©n qu¶ rÊt khã, nh­ng Tinh qu©n còng ®Æc biÖt dÆn dß ta ph¶i gióp ®ì c¸c thÝ sinh. NÕu ng­¬i muèn biÕt tr­íc thiªn c¬, sÏ cã 1 nöa c¬ héi ®o¸n tróng; nÕu nhê ®Õn TrÝ §a Thiªn Tinh th× cÇm ch¾c phÇn th¾ng, h·y lùa chän!", task)

end

function useHelp()

    CloseDialog()

    if (checkCondition() ~= 1) then
        return
    end

    if (HaveIBBuff(652) <= 0) then
        return
    end

    CostIBBuff(652, 1)
    Msg2Player("§· theo chØ dÉn cña thiªn c¬ ®­a ra lùa chän, lµ ®óng  hay sai do trêi vËy !")

    local nRand = math.random(1, 100)
    if (nRand <= 50) then
        answerFin(1)
    else
        answerFin(0)
    end

end

function useIB()

    CloseDialog()

    local nIBTimes = GetTaskByte(TASK_ASW_STAT_STATE_2, 1)
    if (nIBTimes >= 5) then
        Talk(1, "no", "TrÝ §a Tinh rÊt bËn, v× nÓ t×nh V¨n Khóc Tinh qu©n míi chÞu gióp ®ì, nh­ng ®iÒu kiÖn lµ mçi thÝ sinh chØ ®­îc <c=g>5<c> lÇn quyÒn trî gióp! Sè lÇn trî gióp cña b¹n ®· ®¹t tèi ®a, do ®ã kh«ng thÓ nhê ®Õn sù gióp ®ì cña TrÝ §a Tinh!")
        return
    end

    local i = FindAValidIBItem(8, 423, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(73)

    if (i > 0) or (GetCoin() >= Cv) then
        MsgBox(" Muèn ®­îc TrÝ §a Tinh gióp ®ì, ph¶i nép cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i! NÕu <c=g> x¸c ®Þnh <c>, TrÝ ®a tinh nhÊt ®Þnh sÏ gióp ng­¬i hoµn thµnh c©u hái hiÖn t¹i, chØ lµ kh«ng biÕt ý ng­¬i thÕ nµo?", "useIBFin", "no")
    else
        Talk(1, "subject", " Muèn ®­îc TrÝ §a Tinh gióp ®ì, ph¶i nép cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i!")
    end

end

function useIBFin()

    CloseDialog()

    local nIBTimes = GetTaskByte(TASK_ASW_STAT_STATE_2, 1)
    if (nIBTimes >= 5) then
        return
    end

    if (checkCondition() ~= 1) then
        return
    end

    local i = FindAValidIBItem(8, 423, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(73)
    if (i > 0) then
        CostIBItem(i)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(73)
    else
        return
    end

    SetTaskByte(TASK_ASW_STAT_STATE_2, 1, nIBTimes + 1)

    answerFin(1)

end

function Option(nindex)

    CloseDialog()

    if (checkCondition() ~= 1) then
        return
    end

    local nLastLibIndex = GetTaskByte(TASK_ASW_STAR_STATE_1, 1)
    local nLastQueIndex = GetTaskByte(TASK_ASW_STAR_STATE_1, 2)

    local correct = GetQuestionAnswerIdx(nLastLibIndex, nLastQueIndex) - 1

    if (nindex == correct) then
        answerFin(1)
    else
        answerFin(0)
    end

end

function checkCondition()

    if (HaveIBBuff(651) ~= 1) then
        return 0
    end

    if (GetMorphType() ~= 787) then
        return 0
    end

    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    if (state ~= 1) then
        return 0
    end

    if (npctype ~= 11) then
        return 0
    end

    if (answerTime >= 3) then
        SetTaskByte(TASK_ASW_STAR_STATE, 4, npctype + 1)
        return 0
    end

    local nIsAnswer = GetTaskByte(TASK_ASW_STAR_STATE_1, 3)

    if (nIsAnswer == 1) then
        return 0
    end

    return 1

end

function answerFin(IsRight)


    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    local nIsAnswer = GetTaskByte(TASK_ASW_STAR_STATE_1, 3)
    local nRightCount = GetTaskByte(TASK_ASW_STAR_STATE_1, 4)

    if (IsRight == 1) then
        nRightCount = nRightCount + 1
    end

    answerTime = answerTime + 1

    SetTaskByte(TASK_ASW_STAR_STATE_1, 4, nRightCount)
    SetTaskByte(TASK_ASW_STAR_STATE_1, 3, 1)
    SetTaskByte(TASK_ASW_STAR_STATE, 3, answerTime)

    local nTotalAnswer = (npctype - 1) * 3 + answerTime
    if (nTotalAnswer - nRightCount >= 6) then
        answerGameFail()
        return
    end

    if (answerTime >= 3) then

        SetTaskByte(TASK_ASW_STAR_STATE, 3, 0)
        SetTaskByte(TASK_ASW_STAR_STATE, 4, npctype + 1)

        if (IsRight == 1) then
            Talk(1, "no", " Xin chóc mõng, ng­¬i tr¶ lêi hoµn toµn chÝnh x¸c, ®ång thêi còng hoµn thµnh tÊt c¶ c©u hái cña ta, ng­¬i cã thÓ ®Õn <c=g>" .. aryAnswerNpc[npctype + 1] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
            Msg2Player("Ng­¬i tr¶ lêi hoµn toµn chÝnh x¸c, ®ång thêi còng hoµn thµnh tÊt c¶ c©u hái cña ta, hiÖn cã thÓ ®Õn" .. aryAnswerNpc[npctype + 1] .. "TiÕp tôc tr¶ lêi c©u hái v­ît ¶i!")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
            TaskNote(1050, npctype)
        else
            Talk(1, "no", "Tr¶ lêi sai, h×nh ph¹t sÏ lµ bÞ céng thªm <c=g>10 gi©y<c> vµo thµnh tÝch chung cuéc! Nh­ng v× ng­¬i ®· hoµn thµnh tÊt c¶ c©u hái, nªn lÇn thÊt b¹i nµy sÏ kh«ng ¶nh h­ëng ®Õn viÖc v­ît ¶i cña b¹n, hiÖn cã thÓ ®Õn <c=g>" .. aryAnswerNpc[npctype + 1] .. "<c>TiÕp tôc tr¶ lêi, thêi gian cã h¹n h·y nhanh lªn!")
            Msg2Player("Tr¶ lêi sai, nh­ng v× ®· hoµn thµnh tÊt c¶ c©u hái cña L«i ChÊn Tö, hiÖn cã thÓ ®Õn" .. aryAnswerNpc[npctype + 1] .. "TiÕp tôc tr¶ lêi c©u hái v­ît ¶i!")
            TopMessage("RÊt tiÕc, tr¶ lêi sai!")
            TaskNote(1050, npctype)
        end

    else

        if (IsRight == 1) then
            Talk(1, "subject", " Xin chóc mõng, ng­¬i ®· tr¶ lêi hoµn toµn chÝnh x¸c, giê sÏ b¾t ®Çu c©u hái kÕ tiÕp, h·y chuÈn bÞ!")
            Msg2Player("C©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, h·y tr¶ lêi c©u tiÕp.")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
        else
            Talk(1, "subject", "Tr¶ lêi sai, h×nh ph¹t sÏ lµ céng thªm <c=g>10 gi©y<c> vµo thµnh tÝch chung cuéc! Nh­ng ng­¬i vÉn cã c¬ héi lËt ng­îc t×nh thÕ, giê sÏ b¾t ®Çu c©u hái kÕ tiÕp, h·y chuÈn bÞ!")
            Msg2Player("Tr¶ lêi sai, h·y tr¶ lêi c©u tiÕp theo.")
            TopMessage("RÊt tiÕc, tr¶ lêi sai!")
        end

    end

end

function answerGameFail()

    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    local nTotalAnswer = (npctype - 1) * 3 + answerTime

    if (nTotalAnswer < 12) then
        SetTaskByte(TASK_ASW_STAR_STATE, 1, 0)
        RemoveIBBuff(651)
        PolyMorph(-1, 0, 0, 0, 0)
        Talk(1, "no", "ThËt tiÕc, sè lÇn tr¶ lêi sai cña ng­¬i ®· ®¹t <c=g>6<c>, ®ång thêi ch­a hoµn thµnh tiªu chuÈn tr¶ lêi ®óng <c=g>Ýt nhÊt 12 c©u hái<c>, ng­¬i bÞ lo¹i vµ kh«ng cã phÇn th­ëng nµo c¶. Mong r»ng lÇn sau gÆp l¹i ng­¬i sÏ kh¸ h¬n.")
        Msg2Player("Sè lÇn tr¶ lêi sai ®· 6 lÇn, V¨n Khóc Tinh qu©n xö ng­¬i thua cuéc, do trong qu¸ tr×nh v­ît ¶i ch­a tr¶ lêi ®­îc tèi thiÓu 12 c©u, nªn kh«ng nhËn ®­îc bÊt kú phÇn th­ëng nµo, tiÕp tôc cè g¾ng!")
        TaskNote(1050, -1)
        SyncBibleState(1050, 3, 1)
        RemoveIBBuff(652)
        RemoveIBBuff(653)
        RemoveIBBuff(654)
    else
        SetTaskByte(TASK_ASW_STAR_STATE, 1, 2)
        RemoveIBBuff(651)
        PolyMorph(-1, 0, 0, 0, 0)
        Talk(1, "no", "ThËt tiÕc, sè lÇn tr¶ lêi sai cña ng­¬i ®· ®¹t <c=g>6<c>, nªn bÞ lo¹i! Tuy ch­a hoµn thµnh toµn bé c¸c ¶i, nh­ng do thµnh tÝch kh¸ nªn vÉn cã phÇn th­ëng! <c=g>Trong vßng 1 ngµy<c> h·y ®Õn chç Vâ v­¬ng nhËn th­ëng, qu¸ thêi h¹n sÏ kh«ng nhËn ®­îc n÷a!")
        Msg2Player("Sè lÇn tr¶ lêi sai ®· 6 lÇn, V¨n Khóc Tinh qu©n xö ng­¬i thua cuéc,nh­ng biÓu hiÖn cña ng­¬i kh¸ xuÊt s¾c, nªn vÉn nhËn ®­îc phÇn th­ëng! Trong vßng 1 ngµy ®Õn n¬i Vâ V­¬ng nhËn phÇn th­ëng, nÕu qu¸ thêi h¹n trªn sÏ kh«ng cßn ®­îc nhËn!")
        TaskNote(1050, 12)
        RemoveIBBuff(652)
        RemoveIBBuff(653)
        RemoveIBBuff(654)
    end

end

function fangchenmi()
    local state
    local mark

    state = GetWeakState()

    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu1()
    local mark = fangchenmi()
    UTask_Wizard = GetTask(1);
    if (UTask_Wizard == 17) then
        Talk(3, "no", 10419, 10420, 10421)
        AddNormalItem(7, 59, 128, 1, 0, 0)
        AddOwnExp(80000)
        Msg2Player("NhËn ®­îc s¸ch Ban M«n Léng Phñ vµ 80000 kinh nghiÖm.")
        TopMessage(11939)
        SetTask(1, 20)
        TaskNote(28, 10)

        refreshNpcTaskState()

    end ;
    if (GetPlayerType() == 1) and (GetLevel() >= 35) and (UTask_Wizard == 2) then
        if (mark == 1) then
            MsgBox(10422, "yes", "no")
        else
            Talk(1, "no", 11718)
        end
    end ;
end;

function yes()
    Talk(1, "no", 10423)
    Msg2Player("NhËn lÖnh Kh­¬ng Tö Nha, khuyªn 3 t­íng lÜnh nhµ Th­¬ng ®Çu Chu.")
    SetTask(1, 10)
    TaskNote(28, 2)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;
