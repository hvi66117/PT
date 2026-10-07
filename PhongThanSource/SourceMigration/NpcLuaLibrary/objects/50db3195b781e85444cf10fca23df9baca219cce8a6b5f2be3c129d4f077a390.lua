Task_shangzhou = 1276

GLOBAL_VALUE_ENTER_COUNT = 198
TASK_ASW_STAR_STATE = 1403
TASK_ASW_TIME = 1404
TASK_ASW_STAR_STATE_1 = 1405
TASK_ASW_STAT_STATE_2 = 1406

Task_Newyear = 1642

Task_Partener = 1643
Guibin_Index = 1644
Guibin_ID = 1645
Task_GetBaojian = 1646
yaopai = { name = "T­ LÔ Yªu Bµi", Item = { 3, 1154, 0, 0, 0, 0 } }
Yucilibao = { name = "Tói Vua ban", Item = { 6, 1, 724, 0, 0, 0 } }

set_name = {
    { "Vò Khóc", "Tinh Cang", "Khai Thiªn", "ChÊn §¸n" },
    { "XÝch Tïng", "Th¸i Êt", "Th«ng Thiªn", "Hång Qu©n" },
    { "B¸o ThÇn", "Gi¸c thó", "Lam §iªu", "Kh¸ng Long" }
}
part_name = {
    { "Gi¸p", "ChiÕn Ngoa", "Yªu §¸i", "Kh«i", "Phi Phong" },
    { "§¹o Bµo", "Lý", "C©n", "Qu¸n", "LÖnh" },
    { "Hé Gi¸p", "Ngoa", "Yªu §¸i", "Trô", "KÕt" }
}
task_lvl_2_sel_lvl = { [3] = 5, [9] = 7 }
task_lvl_2_sel_idx = { [3] = 2, [9] = 3 }

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

    startLevel = 75
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 62) or (taskWizard == 62) or (taskDruid == 62)) and (HaveEventItem(4) >= 1) then
                state = 3
                subState = 0
            elseif ((taskKnight == 63) or (taskWizard == 63) or (taskDruid == 63)) and (HaveEventItem(6) >= 1) and (HaveEventItem(7) >= 1) and (HaveEventItem(8) >= 1) and (GetTask(42) == 7) then
                state = 3
                subState = 0
            elseif ((taskKnight == 63) or (taskWizard == 63) or (taskDruid == 63)) then
                state = 2
                subState = 0
            end
        else
            if ((taskKnight == 62) or (taskWizard == 62) or (taskDruid == 62)) and (HaveEventItem(4) >= 1) then
                state = 3
                subState = 1
            elseif ((taskKnight == 63) or (taskWizard == 63) or (taskDruid == 63)) and (HaveEventItem(6) >= 1) and (HaveEventItem(7) >= 1) and (HaveEventItem(8) >= 1) and (GetTask(42) == 7) then
                state = 3
                subState = 1
            elseif ((taskKnight == 63) or (taskWizard == 63) or (taskDruid == 63)) then
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
        { "Tam s¸ch", "renwu1"; show = 0 },
        { "PhÇn th­ëng", "renwu"; show = 0 },
        { "V× quèc lËp c«ng", "renwu2"; show = 0 },
        { "§¼ng cÊp", "renwu3"; show = 1 },
        { "Di b¸o", "dongyi"; show = 0 },
        { "Hµng Chu", "dongyi1"; show = 0 },
        { "PhÇn th­ëng", "org_book"; show = 1 },
        { "<c=yel>V¨n Khóc h¹ phµm<c>", "processAnswerStar"; show = 1 },
        { "T­ LÔ T­íng Qu©n", "Finish_General"; show = 0 },
    }
    UTask_Wizard = GetTask(1)
    UTask_Knight = GetTask(3)
    UTask_Druid = GetTask(2)
    local UTask_num = GetTask(42);
    if (UTask_Knight == 62) or (UTask_Druid == 62) or (UTask_Wizard == 62) then
        if (HaveEventItem(4) >= 1) then
            tasks[1].show = 1;
        end ;
    end ;
    if (UTask_Knight == 63) or (UTask_Druid == 63) or (UTask_Wizard == 63) then
        if (HaveEventItem(6) >= 1) and (HaveEventItem(7) >= 1) and (HaveEventItem(8) >= 1) and (UTask_num == 7) then
            tasks[1].show = 1;
        end ;
    end ;
    if (GetLevel() >= 35) and (GetTask(330) == 2) and (SystemTime() < 1111917600) then
        tasks[2].show = 1;
    end ;
    if (1 == GetTask(Task_shangzhou)) or (2 == GetTask(Task_shangzhou)) then
        if (20 > GetTask(420)) then
            tasks[3].show = 1;
        end ;
    end ;
    if (25 == GetTask(597)) and (HaveEventItem(110) >= 1) and (GetTask(592) ~= 1) then
        tasks[5].show = 1;
    end ;
    if (27 == GetTask(597)) then
        tasks[6].show = 1;
    end ;

    SayTask(10484, tasks)
end;

function Finish_General()
    CloseDialog()
    local nStep = GetTaskByte(Task_Newyear, 1)

    local nYear, nMonth, nDay = GetYMD()
    if (((nYear == 2011) and (nMonth == 12) and (nDay >= 31)) or (nYear == 2012 and nMonth == 1 and nDay >= 1 and nDay <= 3)) then
        local task = {
            { "Thu håi Yªu Bµi", "Callback_Asure"; show = 1 }
        }
        if (nStep == 2) then
            str = "NhiÖm vô T­ LÔ T­íng Qu©n <c=r>thÊt b¹i<c>, nh­ng b¹n cã thÓ giao T­ LÔ Yªu Bµi cho ta ®Ó ®æi lÊy mét sè thï lao!"
            SayTask(str, task)
        elseif (nStep == 3 or nStep == 4) then
            if (nYear == (GetTaskByte(Task_Newyear, 2) + 2000) and nMonth == GetTaskByte(Task_Newyear, 3) and nDay == GetTaskByte(Task_Newyear, 4)) then
                Talk(1, "Get_Rewards", "Chóc mõng t­íng qu©n ®· hé tèng Quý Binh ®Õn n¬i an toµn! Ta tÆng <c=yel>Tói Vua ban<c> cho ng­¬i!")
            else
                MsgBox("HÕt h¹n nhËn phÇn th­ëng. Giao nép T­ LÔ Yªu Bµi nhËn ®­îc mét sè thï lao, ®ång ý giao nép?", "Callback_Card", "no")
            end
        end
    end
end

function Callback_Asure()
    MsgBox("§ång ý giao nép T­ LÔ Yªu Bµi?", "Callback_Card", "no")
end

function Callback_Card()
    CloseDialog()
    local item = yaopai.Item
    if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
        ClearItem(item[1], item[2], item[3], item[4])
        EarnBind(50000)
        Msg2Player("Chóc mõng nhËn ®­îc 50000 b¹c khãa")
        SetTaskByte(Task_Newyear, 1, 5)
        SetTask(Task_Partener, 0)
        SetTask(Guibin_ID, 0)
        SetTask(Guibin_Index, 0)
        TaskNote(1105, -1)
        WriteLog(GetName() .. "NhiÖm vô T­ LÔ T­íng Qu©n giao T­ LÔ Yªu Bµi")
    else
        InfoBox("C¸c h¹ kh«ng mang theo <c=yel>T­ LÔ Yªu Bµi<c>, kh«ng thÓ chøng minh lµ <c=g>T­ LÔ T­íng Qu©n<c>, ta kh«ng thÓ trao phÇn th­ëng cho ng­¬i.")
    end
end

function Get_Rewards()
    CloseDialog()
    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang cña c¸c h¹ ®· ®Çy, h·y s¾p xÕp råi quay l¹i t×m ta nhËn th­ëng.")
        return
    end

    local item = yaopai.Item
    ClearItem(item[1], item[2], item[3], item[4])
    item = Yucilibao.Item
    local nLevel = GetLevel()
    local nExp = 0
    if (nLevel >= 30 and nLevel < 50) then
        nExp = nLevel * 2000
    elseif (nLevel >= 50 and nLevel < 80) then
        nExp = nLevel * 3000
    elseif (nLevel >= 80) then
        nExp = nLevel * 4000
    end
    AddOwnExp(nExp)
    ScrollMessage("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
    Msg2Player("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6])
    SetTaskByte(Task_Newyear, 1, 5)
    SetTask(Task_Partener, 0)
    SetTask(Guibin_ID, 0)
    SetTask(Guibin_Index, 0)
    TaskNote(1105, -1)
    Msg2Player("Chóc mõng nhËn ®­îc Tói Vua ban")
    WriteLog(GetName() .. "NhiÖm vô T­ LÔ T­íng Qu©n giao T­ LÔ Yªu Bµi" .. " nhËn ®­îc 1 Tói Vua ban")
end

function Have_CardBoth()
    local returnValue = 1
    local oldPlayerIndex = PlayerIndex
    local newPlayerIndex = 0
    if (IsCaptain() == 0) then
        newPlayerIndex = GetTeamMember(1)
    else
        newPlayerIndex = GetTeamMember(2)
    end
    local item = yaopai.Item
    if (HaveNormalItem(item[1], item[2], item[3], item[4]) == 0) then
        InfoBox("C¸c h¹ kh«ng mang theo T­ LÔ Yªu Bµi, kh«ng thÓ chøng minh lµ T­ LÔ T­íng Qu©n, ta kh«ng thÓ trao phÇn th­ëng cho ng­¬i. NÕu ®Õn khi 2 Quý Binh rêi khái mµ vÉn ch­a nhËn th­ëng th× xem nh­ nhiÖm vô <c=r>thÊt b¹i<c>, lóc ®ã chØ cã thÓ giao T­ LÔ Yªu Bµi cho ta ®Ó ®æi mét sè thï lao.")
        returnValue = 0
        PlayerIndex = newPlayerIndex
        Msg2Player("§ång ®éi cña c¸c h¹ kh«ng mang theo T­ LÔ Yªu Bµi, kh«ng thÓ chøng minh lµ T­ LÔ T­íng Qu©n, ta kh«ng thÓ trao phÇn th­ëng cho c¸c ng­¬i.")
        PlayerIndex = oldPlayerIndex
    end
    PlayerIndex = newPlayerIndex
    if (HaveNormalItem(item[1], item[2], item[3], item[4]) == 0) then
        InfoBox("C¸c h¹ kh«ng mang theo T­ LÔ Yªu Bµi, kh«ng thÓ chøng minh lµ T­ LÔ T­íng Qu©n, ta kh«ng thÓ trao phÇn th­ëng cho ng­¬i. NÕu ®Õn khi 2 Quý Binh rêi khái mµ vÉn ch­a nhËn th­ëng th× xem nh­ nhiÖm vô <c=r>thÊt b¹i<c>, lóc ®ã chØ cã thÓ giao T­ LÔ Yªu Bµi cho ta ®Ó ®æi mét sè thï lao.")
        returnValue = 0
        PlayerIndex = oldPlayerIndex
        Msg2Player("§ång ®éi cña c¸c h¹ kh«ng mang theo T­ LÔ Yªu Bµi, kh«ng thÓ chøng minh lµ T­ LÔ T­íng Qu©n, ta kh«ng thÓ trao phÇn th­ëng cho c¸c ng­¬i.")
    end
    PlayerIndex = oldPlayerIndex
    return returnValue
end

function Have_SpaceOfBoth()
    local returnValue = 1
    local oldPlayerIndex = PlayerIndex
    local newPlayerIndex = 0
    if (IsCaptain() == 0) then
        newPlayerIndex = GetTeamMember(1)
    else
        newPlayerIndex = GetTeamMember(2)
    end
    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang c¸c h¹ ®· ®Çy, h·y s¾p xÕp råi quay l¹i t×m ta nhËn th­ëng. NÕu ®Õn khi 2 Quý Binh rêi khái mµ vÉn ch­a nhËn th­ëng th× xem nh­ nhiÖm vô <c=r>thÊt b¹i<c>, lóc ®ã chØ cã thÓ giao T­ LÔ Yªu Bµi cho ta ®Ó ®æi mét sè thï lao.")
        returnValue = 0
        PlayerIndex = newPlayerIndex
        Msg2Player("Hµnh trang ®ång ®éi cña c¸c h¹ ®· ®Çy, h·y s¾p xÕp råi quay l¹i t×m ta nhËn th­ëng.")
        PlayerIndex = oldPlayerIndex
    end
    PlayerIndex = newPlayerIndex
    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang c¸c h¹ ®· ®Çy, h·y s¾p xÕp råi quay l¹i t×m ta nhËn th­ëng. NÕu ®Õn khi 2 Quý Binh rêi khái mµ vÉn ch­a nhËn th­ëng th× xem nh­ nhiÖm vô <c=r>thÊt b¹i<c>, lóc ®ã chØ cã thÓ giao T­ LÔ Yªu Bµi cho ta ®Ó ®æi mét sè thï lao.")
        returnValue = 0
        PlayerIndex = oldPlayerIndex
        Msg2Player("Hµnh trang ®ång ®éi cña c¸c h¹ ®· ®Çy, h·y s¾p xÕp råi quay l¹i t×m ta nhËn th­ëng.")
    end
    PlayerIndex = oldPlayerIndex
    return returnValue
end

function Get_TeamState()
    if (GetTeamSize() ~= 2) then
        return 0
    end

    if (GetMateTask(Task_Partener) == GetNameID() and GetTask(Task_Partener) == GetMateNameID()) then
        local oldPlayerIndex = PlayerIndex
        local newPlayerIndex = 0
        local Leader = GetTeamMember(1)

        if (GetTaskByte(Task_Newyear, 1) == 3) then
            if (Leader == PlayerIndex) then
                newPlayerIndex = GetTeamMember(2)
                PlayerIndex = newPlayerIndex
                local mapid, x, y = GetWorldPos()
                PlayerIndex = oldPlayerIndex
                if (mapid ~= 20) then
                    return 5
                end
                return 1
            else
                return 3
            end
        elseif (GetTaskByte(Task_Newyear, 1) == 4) then
            if (Leader == PlayerIndex) then
                return 3
            else
                return 2
            end
        end
    elseif (GetTask(Task_Partener) == GetMateNameID()) then
        return 4
    else
        return 0
    end
end

function processAnswerStar()

    CloseDialog()

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()
    local w, x, y = GetWorldPos()
    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    local ntime = GetTask(TASK_ASW_TIME)
    local nowtime = SystemTime()

    if ((d1 == 1) or (d1 == 15)) and (H >= 19) and (H < 22) and (w == 20) and ((state == 1) or (state == 2)) then

        if (HaveIBBuff(651) > 0) then
            subject()
        else
            answerStarAward()
        end

    elseif ((((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19))) and (state == 2) and (nowtime > ntime) and (nowtime - ntime <= 24 * 3600) then

        answerStarAward()

    else

        local task = {

            { "V¨n Khóc h¹ ph¹m xÕp h¹ng", "awardList"; show = 1 },
            { "NhËn danh hiÖu", "getTitle"; show = 1 },

        }

        SayTask("Ho¹t ®éng <c=g>V¨n Khóc H¹ phµm<c> lµ chØ V¨n Khóc Tinh qu©n ngµy 1 vµ 15 mçi th¸ng xuèng T©y Kú, lËp kh¶o tr­êng gióp bæn v­¬ng tuyÓn chän hiÒn tµi, nh÷ng anh tµi ®Õn kh¶o nghiÖm, nÕu xuÊt s¾c ®­îc vµo b¶ng xÕp h¹ng, nhÊt ®Þnh lµ thÕ gian kú tµi, bæn v­¬ng sÏ phong danh hiÖu cao quý cho ng­êi ®ã!", task)

    end

end

function awardList()

    CloseDialog()

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()
    local currentDay = math.floor(LocalSystemTime() / 86400)

    if ((d1 == 1) or (d1 == 15)) and (H < 22) and (H >= 19) and (SortDate ~= currentDay) then
        loadSortList()
    end

    if (table.getn(arySortList) <= 0) then
        loadSortList()
    end

    if (table.getn(arySortList) <= 0) then

        Talk(1, "no", "HoÆc lµ do ho¹t ®éng míi b¾t ®Çu, hoÆc lµ do c¸c c©u hái cña V¨n Khóc Tinh qu©n qu¸ khã, t¹m thêi ch­a cã ai cã thÓ hoµn thµnh toµn bé 36 c©u hái, nÕu muèn xem thø h¹ng nµy th× e lµ ph¶i l¸t sau quay l¹i, lóc ®ã danh s¸ch thø h¹ng cã lÏ sÏ cã biÕn ®æi!")

    else

        local message = ""

        for i = 1, table.getn(arySortList) do

            if (arySortList[i].name == "") then
                break
            end

            local rankSec = arySortList[i].time
            local rankName = arySortList[i].name
            local useSecondStr = (rankSec < 60) and "" or ("" .. math.floor(rankSec / 60) .. "m")
            local useSecondStr = useSecondStr .. math.mod(rankSec, 60) .. "s"
            message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. useSecondStr .. "\n"

        end

        if (message == "") then
            message = "HoÆc lµ do ho¹t ®éng míi b¾t ®Çu, hoÆc lµ do c¸c c©u hái cña V¨n Khóc Tinh qu©n qu¸ khã, t¹m thêi ch­a cã ai cã thÓ hoµn thµnh toµn bé 36 c©u hái, nÕu muèn xem thø h¹ng nµy th× e lµ ph¶i l¸t sau quay l¹i, lóc ®ã danh s¸ch thø h¹ng cã lÏ sÏ cã biÕn ®æi!"
        end

        Talk(1, "no", message)

    end

end

function getTitle()

    CloseDialog()

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()

    if ((d1 == 1) or (d1 == 15)) and (H < 22) and (H >= 19) then

        Talk(1, "no", "Khi ho¹t ®éng ch­a kÕt thóc, thø tù xÕp h¹ng cã thÓ thay ®æi bÊt cø lóc nµo! danh hiÖu sÏ ®­îc ban ph¸t khi ho¹t ®éng h«m nay hoµn toµn kÕt thóc, sau khi thø h¹ng kh«ng cßn thay ®æi míi tiÕn hµnh ®­îc!")
        return

    end

    local nRank = isInSortList(GetName())

    if (nRank <= 0) or (nRank > 3) then

        Talk(1, "no", "RÊt tiÕc, do ng­¬i kh«ng cã tªn trong 3 thø h¹ng ®Çu cña ho¹t ®éng V¨n Khóc h¹ phµm, nªn bæn v­¬ng kh«ng thÓ cho ng­¬i danh hiÖu nµo. Nh­ng ®õng n¶n lßng, chØ cÇn cè g¾ng sÏ cã ngµy nhËn ®­îc s¾c phong cña ta, ta mong ®îi ngµy ®ã, vµ chóc ng­¬i sím cã thµnh c«ng!")
        return

    end

    if (nRank == 1) then

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(14) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                MsgBox("Do ng­¬i biÓu hiÖn kh¸ xuÊt s¾c trong ho¹t ®éng <c=g>V¨n Khóc H¹ phµm<c>, nªn bæn v­¬ng s¾c phong ng­¬i danh hiÖu <c=g>Qu¶ng ThÕ Kú Tµi<c>, h·y <c=g>x¸c nhËn<c> cã lËp tøc nhËn danh hiÖu nµy hay kh«ng.", "getTitleFin", "no")
            else
                Talk(1, "no", "RÊt tiÕc, do V¨n Khóc Tinh qu©n s¾p ®Õn T©y Kú lÇn n÷a, nªn bæn v­¬ng ®µnh thu danh hiÖu cña ng­¬i vÒ ®Ó ph¸t l¹i cho ng­êi xøng ®¸ng lÇn nµy! NÕu ng­¬i vÉn muèn cã danh hiÖu nµy, vËy h·y chøng tá hÕt thùc lùc trong ho¹t ®éng lÇn nµy ®i!")
            end

        else
            SetCurTitle(14)
            Talk(1, "no", "Ng­¬i ®· nhËn ®­îc danh hiÖu <c=g>Qu¶ng ThÕ Kú Tµi<c>, tr­íc ngµy b¾t ®Çu cña ho¹t ®éng lÇn sau, danh hiÖu nµy chØ thuéc vÒ ng­¬i! NÕu ng­¬i muèn ®æi danh hiÖu, th× tr­íc khi ho¹t ®éng sau b¾t ®Çu, tíi chç bæn v­¬ng ®æi l¹i lµ ®­îc!")
        end

    elseif (nRank == 2) then

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(15) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                MsgBox("Do ng­¬i biÓu hiÖn kh¸ xuÊt s¾c trong ho¹t ®éng <c=g>V¨n Khóc H¹ phµm<c>, nªn bæn v­¬ng s¾c phong ng­¬i danh hiÖu <c=g>Häc Phó Ngò Xa<c>. H·y <c=g>x¸c nhËn<c> cã lËp tøc nhËn danh hiÖu nµy hay kh«ng.", "getTitleFin", "no")
            else
                Talk(1, "no", "RÊt tiÕc, do V¨n Khóc Tinh qu©n s¾p ®Õn T©y Kú lÇn n÷a, nªn bæn v­¬ng ®µnh thu danh hiÖu cña ng­¬i vÒ ®Ó ph¸t l¹i cho ng­êi xøng ®¸ng lÇn nµy! NÕu ng­¬i vÉn muèn cã danh hiÖu nµy, vËy h·y chøng tá hÕt thùc lùc trong ho¹t ®éng lÇn nµy ®i!")
            end

        else
            SetCurTitle(15)
            Talk(1, "no", "Ng­¬i ®· nhËn ®­îc danh hiÖu <c=g>Häc Phó Ngò Xa<c>, tr­íc ngµy b¾t ®Çu cña ho¹t ®éng lÇn sau, danh hiÖu nµy chØ thuéc vÒ ng­¬i! NÕu ng­¬i muèn ®æi danh hiÖu, th× tr­íc khi ho¹t ®éng sau b¾t ®Çu, tíi chç bæn v­¬ng ®æi l¹i lµ ®­îc!")
        end

    else

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(16) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                MsgBox("Do ng­¬i biÓu hiÖn kh¸ xuÊt s¾c trong ho¹t ®éng <c=g>V¨n Khóc H¹ phµm<c>, nªn bæn v­¬ng s¾c phong ng­¬i danh hiÖu <c=g>Tµi Hoa Hoµnh DËt<c>, h·y <c=g>x¸c nhËn<c> cã lËp tøc nhËn danh hiÖu nµy hay kh«ng.", "getTitleFin", "no")
            else
                Talk(1, "no", "RÊt tiÕc, do V¨n Khóc Tinh qu©n s¾p ®Õn T©y Kú lÇn n÷a, nªn bæn v­¬ng ®µnh thu danh hiÖu cña ng­¬i vÒ ®Ó ph¸t l¹i cho ng­êi xøng ®¸ng lÇn nµy! NÕu ng­¬i vÉn muèn cã danh hiÖu nµy, vËy h·y chøng tá hÕt thùc lùc trong ho¹t ®éng lÇn nµy ®i!")
            end

        else
            SetCurTitle(16)
            Talk(1, "no", "Ng­¬i ®· nhËn ®­îc danh hiÖu <c=g>Tµi Hoa Hoµnh DËt<c>, tr­íc ngµy b¾t ®Çu cña ho¹t ®éng lÇn sau, danh hiÖu nµy chØ thuéc vÒ ng­¬i! NÕu ng­¬i muèn ®æi danh hiÖu, th× tr­íc khi ho¹t ®éng sau b¾t ®Çu, tíi chç bæn v­¬ng ®æi l¹i lµ ®­îc!")
        end

    end

end

function getTitleFin()

    CloseDialog()

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()

    if ((d1 == 1) or (d1 == 15)) and (H < 22) and (H >= 19) then
        return
    end

    local nRank = isInSortList(GetName())

    if (nRank <= 0) or (nRank > 3) then
        return
    end

    if (nRank == 1) then

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(14) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                ActiveTitleQualify(14)
                SetCurTitle(14)
                AddEvent("%s nhËn ®­îc danh hiÖu [Qu¶ng ThÕ Kú Tµi]!", 1)
                TopMessage("NhËn ®­îc danh hiÖu <c=g>Qu¶ng ThÕ Kú Tµi<c>")
                Msg2Player("Chóc mõng b¹n, do b¹n vÒ h¹ng nhÊt trong ho¹t ®éng V¨n Khóc h¹ phµm, Vò V­¬ng  ban ph¸t cho b¹n danh hiÖu <Qu¶ng ThÕ Kú Tµi>, xem nh­ phÇn th­ëng!")
                Talk(1, "no", "Do ng­¬i biÓu hiÖn xuÊt s¾c trong ho¹t ®éng V¨n Khóc h¹ phµm lÇn nµy, vµ ®¹t ®­îc h¹ng nhÊt, bæn v­¬ng vµ V¨n Khóc Tinh qu©n cïng ®ång ý ng­¬i lµ <c=g>Qu¶ng ThÕ Kú Tµi<c>, vµ trao danh hiÖu nµy cho ng­¬i thay cho sù khen ngîi, tr­íc ngµy ho¹t ®éng lÇn sau b¾t ®Çu, danh hiÖu nµy chØ thuéc vÒ ng­¬i!")
                WriteLog("NhËn ®­îc danh hiÖu [Qu¶ng ThÕ Kú Tµi]")
            end

        end

    elseif (nRank == 2) then

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(15) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                ActiveTitleQualify(15)
                SetCurTitle(15)
                AddEvent("%s nhËn ®­îc danh hiÖu [Häc Phó Ngò Xa]!", 1)
                TopMessage("NhËn ®­îc danh hiÖu <c=g>Häc Phó Ngò Xa<c>")
                Msg2Player("Chóc mõng b¹n, do b¹n vÒ h¹ng nh× trong ho¹t ®éng V¨n Khóc h¹ phµm, Vò V­¬ng  ban ph¸t cho b¹n danh hiÖu <Häc Phó Ngò Xa>, xem nh­ phÇn th­ëng!")
                Talk(1, "no", "Do ng­¬i biÓu hiÖn xuÊt s¾c trong ho¹t ®éng V¨n Khóc h¹ phµm lÇn nµy, vµ ®¹t ®­îc h¹ng nhÊt, bæn v­¬ng vµ V¨n Khóc Tinh qu©n cïng ®ång ý ng­¬i lµ <c=g>Häc Phó Ngò Xa<c>, vµ trao danh hiÖu nµy cho ng­¬i thay cho sù khen ngîi, tr­íc ngµy ho¹t ®éng lÇn sau b¾t ®Çu, danh hiÖu nµy chØ thuéc vÒ ng­¬i!")
                WriteLog("NhËn ®­îc danh hiÖu [Häc Phó Ngò Xa]")
            end

        end

    else

        if (GetTitleFunc() == 0) then
            ActiveTitleFunc(1)
        end

        if (HaveQualify(16) == 0) then

            if (((d1 == 1) or (d1 == 15)) and (H >= 22)) or (((d1 == 2) or (d1 == 16)) and (H < 19)) then
                ActiveTitleQualify(16)
                SetCurTitle(16)
                AddEvent("%s nhËn ®­îc danh hiÖu [Tµi Hoa Hoµnh DËt]!", 1)
                TopMessage("NhËn ®­îc danh hiÖu <c=g>Tµi Hoa Hoµnh DËt<c>")
                Msg2Player("Chóc mõng b¹n, do b¹n vÒ h¹ng ba trong ho¹t ®éng V¨n Khóc h¹ phµm, Vò V­¬ng  ban ph¸t cho b¹n danh hiÖu <Tµi Hoa Hoµnh DËt>, xem nh­ phÇn th­ëng!")
                Talk(1, "no", "Do ng­¬i biÓu hiÖn xuÊt s¾c trong ho¹t ®éng V¨n Khóc h¹ phµm lÇn nµy, vµ ®¹t ®­îc h¹ng nhÊt, bæn v­¬ng vµ V¨n Khóc Tinh qu©n cïng ®ång ý ng­¬i lµ <c=g>Tµi Hoa Hoµnh DËt<c>, vµ trao danh hiÖu nµy cho ng­¬i thay cho sù khen ngîi, tr­íc ngµy ho¹t ®éng lÇn sau b¾t ®Çu, danh hiÖu nµy chØ thuéc vÒ ng­¬i!")
                WriteLog("NhËn ®­îc danh hiÖu [Tµi Hoa Hoµnh DËt]")
            end

        end

    end

end

function answerStarAward()

    if (HaveIBBuff(651) > 0) then
        return
    end

    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)

    if (state ~= 2) then
        Talk(1, "no", "RÊt tiÕc, do ng­¬i ch­a hoµn thµnh tèi thiÓu 12 c©u, do ®ã bæn v­¬ng kh«ng thÓ ban ph¸t bÊt kú phÇn th­ëng cho ng­¬i. Nh­ng ®õng n¶n lßng,  chØ cÇn cè g¾ng sÏ cã ngµy nhËn ®­îc s¾c phong cña ta, ta mong ®îi ngµy ®ã, vµ chóc ng­¬i sím cã thµnh c«ng!")
        return
    end

    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)
    local nRightCount = GetTaskByte(TASK_ASW_STAR_STATE_1, 4)

    local nTotalAnswer = (npctype - 1) * 3 + answerTime

    local nExp = 0
    local nLevel = GetLevel()

    if (nTotalAnswer >= 36) then

        if (nLevel < 80) then
            nExp = nLevel * 3000
        else
            nExp = nLevel * 6000
        end

        local nStartTime = GetTask(TASK_ASW_TIME)
        local nEndTime = SystemTime()
        local nUseTime = nEndTime - nStartTime
        local nUseSec = math.mod(nUseTime, 60)
        local nUseMin = math.floor(nUseTime / 60)

        local nTUseTime = nUseTime + (36 - nRightCount) * 10
        local nTUseSec = math.mod(nTUseTime, 60)
        local nTUseMin = math.floor(nTUseTime / 60)

        addSortList(GetName(), nTUseTime)
        Talk(3, "no", "Ng­¬i ®· v­ît qua kh¶o nghiÖm cña V¨n Khóc Tinh qu©n, thêi gian hoµn thµnh trong ho¹t ®éng lÇn nµy lµ <c=g>" .. nUseMin .. "m" .. nUseSec .. " gi©y<c>, nh­ng trong ®ã cã <c=g>" .. (36 - nRightCount) .. "<c> c©u tr¶ lêi sai, cho nªn ®Ó xem nh­ sù ph¹t mçi c©u tr¶ lêi sai sÏ céng thªm <c=g>10<c> gi©y vµo thêi gian hoµn thµnh cña ng­¬i,", "Do ®ã thêi gian hoµn thµnh cuèi cïng cña ng­¬i trong ho¹t ®éng lÇn nµy lµ <c=g>" .. nTUseMin .. "m" .. nTUseSec .. " gi©y<c>, do biÓu hiÖn cña ng­¬i qu¸ xuÊt s¾c, bæn v­¬ng ®Æc biÖt th­ëng ng­¬i <c=g>" .. nExp .. "<c> ®iÓm kinh nghiÖm!", "Ngoµi ra, <c=g>3 thø h¹ng ®Çu<c> cã thêi gian hoµn thµnh Ýt nhÊt trong ho¹t ®éng lÇn nµy cßn nhËn ®­îc thªm <c=g>phÇn th­ëng danh hiÖu<c>, nÕu muèn biÕt thø h¹ng cña m×nh, h·y lu«n chó ý b¶ng xÕp h¹ng, ngoµi ra bæn v­¬ng sÏ th«ng b¸o t×nh h×nh thø h¹ng vµo thêi gian thø nhÊt!")
        Msg2Player("B¹n ®· v­ît qua kh¶o nghiÖm cña V¨n Khóc Tinh qu©n, thêi gian hoµn thµnh trong ho¹t ®éng lÇn nµy lµ" .. nTUseMin .. "m" .. nTUseSec .. " gi©y,Vò V­¬ng ®Æc biÖt th­ëng b¹n" .. nExp .. " §iÓm kinh nghiÖm, coi nh­ biÓu d­¬ng!")
        WriteLog("V¨n Khóc h¹ phµm tæng thêi gian dïng lµ" .. nUseMin .. "m" .. nUseSec .. " gi©y; thêi gian sö dông cuèi cïng lµ" .. nTUseMin .. "m" .. nTUseSec .. "s")

    elseif (nTotalAnswer >= 24) and (nTotalAnswer < 36) then

        if (nLevel < 80) then
            nExp = nLevel * 2000
        else
            nExp = nLevel * 4000
        end

        Talk(1, "no", "Ng­¬i tuy ch­a v­ît qua kh¶o nghiÖm cña V¨n Khóc Tinh qu©n, nh­ng ®· hoµn thµnh <c=g>" .. nTotalAnswer .. "<c> c©u, trong ®ã tr¶ lêi ®óng <c=g>" .. nRightCount .. "<c> c©u, do ®ã bæn v­¬ng th­ëng ng­¬i <c=g>" .. nExp .. "<c> ®iÓm kinh nghiÖm, ®Ó lµm khÝch lÖ!")

    elseif (nTotalAnswer >= 12) and (nTotalAnswer < 24) then

        if (nLevel < 80) then
            nExp = nLevel * 1000
        else
            nExp = nLevel * 2000
        end

        Talk(1, "no", "Ng­¬i tuy ch­a v­ît qua kh¶o nghiÖm cña V¨n Khóc Tinh qu©n, nh­ng ®· hoµn thµnh <c=g>" .. nTotalAnswer .. "<c> c©u, trong ®ã tr¶ lêi ®óng <c=g>" .. nRightCount .. "<c>c©u, cã thÓ t¹m xem nh­ mét nh©n tµi, do ®ã bæn v­¬ng th­ëng ng­¬i <c=g>" .. nExp .. "<c> ®iÓm kinh nghiÖm, ®Ó lµm khÝch lÖ!")

    else

        Talk(1, "no", "RÊt tiÕc, do ng­¬i ch­a hoµn thµnh tèi thiÓu 12 c©u, do ®ã bæn v­¬ng kh«ng thÓ ban ph¸t bÊt kú phÇn th­ëng cho ng­¬i. Nh­ng ®õng n¶n lßng,  chØ cÇn cè g¾ng sÏ cã ngµy nhËn ®­îc s¾c phong cña ta, ta mong ®îi ngµy ®ã, vµ chóc ng­¬i sím cã thµnh c«ng!")
        return

    end

    AddOwnExp(nExp)
    Msg2Player("Trong ho¹t ®éng V¨n Khóc h¹ phµm, hoµn thµnh" .. nTotalAnswer .. " C©u,Vò V­¬ng th­ëng" .. nExp .. " §iÓm kinh nghiÖm, ®Ó biÓu thÞ khuyÕn khÝch!")
    TopMessage("NhËn ®­îc " .. nExp .. " kinh nghiÖm.")
    SyncBibleState(1050, 3, 1)

    SetTaskByte(TASK_ASW_STAR_STATE, 1, 0)

end

arySortList = {}
SortDate = 0

Save_Section_Ring_Date = "AnswerStar_RingDate"
Save_Section_Ring_Usetime = "AnswerStar_RingUsetime"
Save_Section_Ring_Playername = "AnswerStar_RingPlayername"

function addSortList(Name, Time)

    if (table.getn(arySortList) <= 0) then
        loadSortList()
    end

    local currentDay = math.floor(LocalSystemTime() / 86400)
    if (SortDate ~= currentDay) then
        loadSortList()
    end

    if (isInSortList(Name) ~= 0) then
        return
    end

    for i = table.getn(arySortList), 1, -1 do

        if (arySortList[i].time > Time) or (arySortList[i].name == "") then

            if (i < 3) then

                arySortList[i + 1].time = arySortList[i].time
                arySortList[i + 1].name = arySortList[i].name

            end

            if (i == 1) then

                arySortList[i].time = Time
                arySortList[i].name = Name

            end

        else

            if (i < 3) then

                arySortList[i + 1].time = Time
                arySortList[i + 1].name = Name
                break

            elseif (i == 3) and (arySortList[i].time <= Time) and (arySortList[i].name ~= "") then

                break

            end

        end

    end

    saveSortList()

end

function isInSortList(Name)

    if (table.getn(arySortList) <= 0) then
        return 0
    end

    for i = table.getn(arySortList), 1, -1 do

        if (arySortList[i].name == Name) then
            return i
        end

    end

    return 0

end

function saveSortList()

    local currentDay = math.floor(LocalSystemTime() / 86400)
    SaveIniInteger(Save_Section_Ring_Usetime, 1, currentDay)

    for i = 1, table.getn(arySortList), 1 do

        SaveIniString(Save_Section_Ring_Playername, i, arySortList[i].name)
        SaveIniInteger(Save_Section_Ring_Usetime, i, arySortList[i].time)

    end

end

function loadSortList()

    local saveDate = LoadIniInteger(Save_Section_Ring_Date, 1)
    local currentDay = math.floor(LocalSystemTime() / 86400)

    SortDate = saveDate

    arySortList[1] = { name = "", time = 0 }
    arySortList[2] = { name = "", time = 0 }
    arySortList[3] = { name = "", time = 0 }

    if (saveDate ~= nil) and (saveDate ~= 0) then

        local top1Name = LoadIniString(Save_Section_Ring_Playername, 1)
        local top2Name = LoadIniString(Save_Section_Ring_Playername, 2)
        local top3Name = LoadIniString(Save_Section_Ring_Playername, 3)

        local top1Sec = LoadIniInteger(Save_Section_Ring_Usetime, 1)
        local top2Sec = LoadIniInteger(Save_Section_Ring_Usetime, 2)
        local top3Sec = LoadIniInteger(Save_Section_Ring_Usetime, 3)

        arySortList[1] = { name = top1Name, time = top1Sec }
        arySortList[2] = { name = top2Name, time = top2Sec }
        arySortList[3] = { name = top3Name, time = top3Sec }

    end

end

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

function subject()

    CloseDialog()

    if (HaveIBBuff(651) ~= 1) then
        Talk(1, "no", "RÊt tiÕc, do ho¹t ®éng ng­¬i tham dù ®· kÕt thóc, theo giao hÑn víi V¨n Khóc Tinh qu©n ta kh«ng thÓ ®­a bÊt kú c©u hái nµo cho ng­¬i tr¶ lêi! NÕu muèn l·nh phÇn th­ëng , th× h·y ®Õn n¬i Vâ V­¬ng xem cã phÇn th­ëng hay kh«ng!")
        return
    end

    if (GetMorphType() ~= 787) then
        Talk(1, "no", "RÊt tiÕc, do h×nh t­îng biÕn th©n cña ng­¬i kh«ng hîp víi giao hÑn cña V¨n Khóc Tinh qu©n, nªn ta kh«ng thÓ ®­a bÊt kú c©u hái nµo cho ng­¬i tr¶ lêi, xin h·y l­îng thø!")
        return
    end

    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    if (state ~= 1) then
        Talk(1, "no", "RÊt tiÕc, do ng­¬i ch­a ®Õn chç LÔ Quan ë T©y Kú ®Ó b¸o danh thi ®Êu , heo giao hÑn víi V¨n Khóc Tinh qu©n ta kh«ng thÓ ®­a bÊt kú c©u hái nµo cho ng­¬i tr¶ lêi, nÕu muèn tham gia ho¹t ®éng nµy th× h·y mau chãng ®Õn chç LÔ Quan b¸o danh lµ ®­îc, c¸c th«ng tin ho¹t ®éng liªn quan ng­¬i tíi sÏ biÕt th«i!")
        return
    end

    if (npctype ~= 12) then
        Talk(1, "no", "Theo giao hÑn víi V¨n Khóc Tinh qu©n, giê ng­¬i ph¶i ®Õn <c=g>" .. aryAnswerNpc[npctype] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
        return
    end

    if (answerTime >= 3) then
        SetTaskByte(TASK_ASW_STAR_STATE, 4, npctype + 1)
        Talk(1, "no", "Theo giao hÑn víi V¨n Khóc Tinh qu©n, giê ng­¬i ph¶i ®Õn <c=g>" .. aryAnswerNpc[npctype] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
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

    SayTask("Tinh qu©n ®Æc biÖt ñy quyÒn cho ta, nÕu thÝ sinh nhê ta sÏ hÕt lßng gióp ®ì!  trong c¸c lùa chän d­íi nÕu ng­¬i ®Þnh lôc läi thiªn c¬, th× cã 50%  tr¶ lêi chÝnh x¸c  c©u hái, nÕu ®Þnh nhê TrÝ ®a thiªn tinh gióp ®ì, th× sÏ qua ¶i thuËn lîi, ý ng­¬i thÕ nµo xin h·y ®Þnh ®o¹t !", task)

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
        Talk(1, "no", "TrÝ ®a tinh ë thiªn ®×nh lo rÊt nhiÒu viÖc, nh­ng nÓ mÆt V¨n Khóc Tinh qu©n míi ®ång ý gióp ®ì, nh­ng nãi tr­íc ng­êi tham gia chØ ®­îc xin gióp ®ì <c=g>5<c> lÇn, nÕu v­ît qu¸ giíi h¹n trªn th× kh«ng gióp n÷a! sè lÇn ng­¬i nhê gióp ®· v­ît giíi h¹n, nªn trong ho¹t ®éng lÇn nµy  ng­¬i sÏ  kh«ng thÓ nhËn tiÕp ®­îc sù gióp ®ì cña TrÝ ®a tinh!")
        return
    end

    local i = FindAValidIBItem(8, 423, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(73)

    if (i > 0) or (GetCoin() >= Cv) then
        MsgBox("Muèn cã ®­îc sù gióp ®ì cña TrÝ ®a tinh, ng­¬i ph¶i nép cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i! NÕu <c=g> x¸c ®Þnh <c>, TrÝ ®a tinh nhÊt ®Þnh sÏ gióp ng­¬i hoµn thµnh c©u hái hiÖn t¹i, chØ lµ kh«ng biÕt ý ng­¬i thÕ nµo?", "useIBFin", "no")
    else
        Talk(1, "subject", "Muèn cã ®­îc sù gióp ®ì cña TrÝ ®a tinh, ng­¬i ph¶i nép cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i!")
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

    if (npctype ~= 12) then
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
            Msg2Player("B¹n tr¶ lêi hoµn toµn chÝnh x¸c, khi hoµn thµnh toµn bé 36 c©u th× v­ît qua cuéc kh¶o nghiÖm cña V¨n Khóc Tinh qu©n!")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
            TaskNote(1050, npctype)
            answerGameSuccess()
        else
            Msg2Player("Tr¶ lêi sai, khi hoµn thµnh toµn bé 36 c©u th× v­ît qua cuéc kh¶o nghiÖm cña V¨n Khóc Tinh qu©n!")
            TopMessage("RÊt tiÕc, tr¶ lêi sai!")
            TaskNote(1050, npctype)
            answerGameSuccess()
        end

    else

        if (IsRight == 1) then
            Talk(1, "subject", "Chóc mõng ng­¬i, c©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, giê lµ c©u hái kÕ tiÕp, h·y chuÈn bÞ tr¶ lêi!")
            Msg2Player("C©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, h·y tr¶ lêi c©u tiÕp.")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
        else
            Talk(1, "subject", "RÊt tiÕc, c©u tr¶ lêi cña ng­¬i sai råi, thµnh tÝch cuèi cña ng­¬i sÏ t¨ng thªm <c=g>10 gi©y<c>! Nh­ng ng­¬i vÉn cßn c¬ héi, giê lµ c©u hái kÕ tiÕp, h·y chuÈn bÞ tr¶ lêi!")
            Msg2Player("B¹n tr¶ lêi sai, h·y tiÕp tôc tr¶ lêi c©u tiÕp theo.")
            TopMessage("RÊt tiÕc, tr¶ lêi sai!")
        end

    end

end

function answerGameSuccess()

    local npctype = GetTaskByte(TASK_ASW_STAR_STATE, 4)
    local answerTime = GetTaskByte(TASK_ASW_STAR_STATE, 3)

    local nTotalAnswer = (npctype - 1) * 3 + answerTime

    if (nTotalAnswer < 12) then
        SetTaskByte(TASK_ASW_STAR_STATE, 1, 0)
        RemoveIBBuff(651)
        PolyMorph(-1, 0, 0, 0, 0)
        Talk(1, "no", "RÊt tiÕc, do sè lÇn tr¶ lêi sai cña ng­¬i ®· lµ <c=g>6 lÇn<c>, nªn ®· kh«ng hoµn thµnh v­ît ¶i <c=g>tèi thiÓu 12 c©u hái<c>, nªn ng­¬i bÞ xö thua vµ kh«ng nhËn ®­îc phÇn th­ëng nµo. Nh­ng ®õng n¶n chÝ, ®îi ®Õn lÇn gÆp sau, hy väng ng­¬i sÏ v­ît qua!")
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

        TaskNote(1050, -1)
        answerStarAward()
        RemoveIBBuff(652)
        RemoveIBBuff(653)
        RemoveIBBuff(654)
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
        Talk(1, "no", "RÊt tiÕc, do sè lÇn tr¶ lêi sai cña ng­¬i ®· lµ <c=g>6 lÇn<c>, nªn ®· kh«ng hoµn thµnh v­ît ¶i <c=g>tèi thiÓu 12 c©u hái<c>, nªn ng­¬i bÞ xö thua vµ kh«ng nhËn ®­îc phÇn th­ëng nµo. Nh­ng ®õng n¶n chÝ, ®îi ®Õn lÇn gÆp sau, hy väng ng­¬i sÏ v­ît qua!")
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

        TaskNote(1050, -1)
        answerStarAward()
        RemoveIBBuff(652)
        RemoveIBBuff(653)
        RemoveIBBuff(654)
    end

end

function renwu1()
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    local UTask_num = GetTask(42);
    if (UTask_Knight == 62) or (UTask_Druid == 62) or (UTask_Wizard == 62) then
        Talk(2, "func_sun", 10485, 10486)
    end ;

    if (UTask_Knight == 63) or (UTask_Druid == 63) or (UTask_Wizard == 63) then
        if (HaveEventItem(6) >= 1) and (HaveEventItem(7) >= 1) and (HaveEventItem(8) >= 1) and (UTask_num == 7) then
            Talk(1, "no", 10487)
            DelEventItem(6)
            DelEventItem(7)
            DelEventItem(8)
            local i = math.random(14, 17)
            AddNormalItem(0, 4, i, 1, 0, 0)
            AddOwnExp(3000000)
            Msg2Player("Gióp Vâ V­¬ng t×m ®­îc 3 quyÓn ®iÓn tÞch, nhËn ®­îc ph¸p b¶o cÊp 70 vµ 3000000 kinh nghiÖm.")
            TopMessage(11739)
            if (GetPlayerType() == 1) then
                SetTask(1, 70)
                TaskNote(28, 30)
            end ;
            if (GetPlayerType() == 0) then
                SetTask(3, 70)
                TaskNote(27, 26)
            end ;
            if (GetPlayerType() == 2) then
                SetTask(2, 70)
                TaskNote(29, 25)
            end ;

            refreshNpcTaskState()


        end ;
    end ;
end;

function func_sun()
    Talk(2, "func_sun1", 10488, 10623)
end;

function func_sun1()
    Talk(2, "func_sun2", 10489, 10490)
end;

function func_sun2()
    Talk(1, "no", 10491)
    Msg2Player("NhËn sù ñy th¸c cña Vâ V­¬ng, ®i t×m 3 bé s¸ch HuyÒn N÷ Binh Ph¸p, Huúnh §Õ Néi Kinh, LuyÖn Kim thuËt")
    if (GetPlayerType() == 1) then
        SetTask(1, 63)
        TaskNote(28, 29)
    end ;
    if (GetPlayerType() == 0) then
        SetTask(3, 63)
        TaskNote(27, 25)
    end ;
    if (GetPlayerType() == 2) then
        SetTask(2, 63)
        TaskNote(29, 24)
    end ;
    DelEventItem(4)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetTask(330) == 2) then
        local i = math.random(1, 6)
        if (i == 1) then
            AddNormalItem(3, 41, 0, 0, 1, 0)
            Msg2Player("B¹n nhËn ®­îc 1 viªn Lam B¶o Th¹ch")

            Talk(1, "no", 11740)
        elseif (i == 2) then
            if (GetSeries() == 0) then
                AddNormalItem2(0, 10, 0, 7, 1, 0)
                Msg2Player("B¹n nhËn ®­îc U Hån Lang")

            elseif (GetSeries() == 1) then
                AddNormalItem2(0, 10, 1, 7, 1, 0)
                Msg2Player("B¹n nhËn ®­îc Phiªu TuyÕt H¹c")

            elseif (GetSeries() == 2) then
                AddNormalItem2(0, 10, 2, 7, 1, 0)
                Msg2Player("B¹n nhËn ®­îc TrÇm H­¬ng hå ®iÖp.")

            end ;
            Talk(1, "no", 11741)
        elseif (i == 3) then
            if (GetSeries() == 0) then
                local j = math.random(1, 5)
                if (j == 1) then
                    AddNormalItem2(0, 2, 3, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc Vò Khóc Gi¸p")

                elseif (j == 2) then
                    AddNormalItem2(0, 5, 3, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc Vò Khóc ChiÕn Ngoa")

                elseif (j == 3) then
                    AddNormalItem2(0, 6, 3, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc Vò Khóc Yªu §¸i")

                elseif (j == 4) then
                    AddNormalItem2(0, 7, 3, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc Vò Khóc Kh«i")

                elseif (j == 5) then
                    AddNormalItem2(0, 9, 3, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc Vò Khóc Phi Phong")

                end ;
            elseif (GetSeries() == 1) then
                local k = math.random(1, 5)
                if (k == 1) then
                    AddNormalItem2(0, 2, 4, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc XÝch Tïng §¹o Bµo.")

                elseif (k == 2) then
                    AddNormalItem2(0, 5, 4, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc XÝch Tïng Lý")

                elseif (k == 3) then
                    AddNormalItem2(0, 6, 4, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc XÝch Tïng C©n")

                elseif (k == 4) then
                    AddNormalItem2(0, 7, 4, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc XÝch Tïng Qu¸n")

                elseif (k == 5) then
                    AddNormalItem2(0, 9, 4, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc XÝch Tïng LÖnh")

                end ;
            elseif (GetSeries() == 2) then
                local l = math.random(1, 5)
                if (l == 1) then
                    AddNormalItem2(0, 2, 5, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Hé Gi¸p")

                elseif (l == 2) then
                    AddNormalItem2(0, 5, 5, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc B¸o ThÇn ngoa")

                elseif (l == 3) then
                    AddNormalItem2(0, 6, 5, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Yªu §¸i")

                elseif (l == 4) then
                    AddNormalItem2(0, 7, 5, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc B¸o ThÇn Trô")

                elseif (l == 5) then
                    AddNormalItem2(0, 9, 5, 4, 1, 0)
                    Msg2Player("B¹n nhËn ®­îc B¸o ThÇn KÕt")

                end ;
            end ;
            Talk(1, "no", 11742)
        elseif (i == 4) then
            Earn(100000)
            Msg2Player("B¹n nhËn ®­îc 10 v¹n")

            Talk(1, "no", 11743)
        elseif (i == 5) then
            AddOwnExp(200000)
            Msg2Player("B¹n ®­îc th¨ng lªn mét cÊp.")

            Talk(1, "no", 11744)
        elseif (i == 6) then
            UseSilver(1, 1, 1)
            Msg2Player("B¹n nhËn ®­îc mét ngµy ch¬i miÔn phÝ")

            Talk(1, "no", 11745)
        end ;
        SetTask(330, 3)
    else
        Talk(1, "no", 11746)
    end ;
end;

function renwu2()
    if (1 == GetTask(Task_shangzhou)) or (2 == GetTask(Task_shangzhou)) then

        if ((3 == GetTask(420)) or (9 == GetTask(420))) and (GetTask(373) == 1) then

            reward_add()
        else
            Talk(1, "no", 11747)
            reward_normal()
        end ;
    else
        CloseDialog()
    end ;
end;

function renwu3()
    local sz_level
    if (GetTask(420) >= 20) then
        sz_level = GetTask(420) - 20
    else
        sz_level = GetTask(420)
    end ;
    Talk(1, "no", "§¼ng cÊp chiÕn tr­êng hiÖn t¹i cña ng­¬i lµ <c=g>" .. sz_level .. "<c>.")
end;

function reward_normal()
    local sz_level = GetTask(420)
    TaskNote(85, -1)

    if (10 == sz_level) then
        AddOwnExp(GetLevel() * (1000 + GetTask(Task_shangzhou) * 1000) * 2);
    else
        AddOwnExp(GetLevel() * (sz_level * 100 + GetTask(Task_shangzhou) * 1000) * 2);
        if (4 == sz_level) and (60 > GetLevel()) then
            Msg2Player("§¼ng cÊp cña b¹n ch­a ®Õn 60, kh«ng thÓ vµo chiÕn tr­êng Th­¬ng Chu.")
        else
            if (1 == GetTask(373)) then
                SetTask(420, sz_level + 1)
                SetTask(373, 0)
                Msg2Player("§¼ng cÊp chiÕn tr­êng cña ng­¬i t¨ng" .. GetTask(420))
            elseif (GetTask(373) < 1) and (GetTask(373) >= 0) then
                SetTask(373, GetTask(373) + 1)
            else
                SetTask(373, 1)
            end ;
        end ;
    end ;
    WriteLog("[ÉÌÖÜÕ½³¡][¾­Ñé½±Àø][µÈ¼¶" .. sz_level .. "][¾­ÑéÖµ" .. GetTask(373))
    SetTask(Task_shangzhou, 0)
end;

function reward_add()
    local sz_level = GetTask(420)
    local sel_idx = task_lvl_2_sel_idx[sz_level]
    if (sel_idx ~= nil) then
        local sel_type = GetPlayerType() + 1
        local item_list = {}
        if (sz_level == 9) and (1 == GetTask(373)) then
            for i = 2, 4 do
                item_list[i - 1] = set_name[sel_type][sel_idx] .. part_name[sel_type][i] .. "/item_" .. i
            end ;
            Say(11748, 3, item_list)
        elseif (1 == GetTask(373)) then
            for i = 1, 5 do
                item_list[i] = set_name[sel_type][sel_idx] .. part_name[sel_type][i] .. "/item_" .. i
            end ;
            Say(11748, 5, item_list)
        end ;
    end ;
end;

function item_1()
    CloseDialog()
    local sz_level = GetTask(420)
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1

        AddNormalItem(0, 2, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end ;
end;

function item_2()
    CloseDialog()
    local sz_level = GetTask(420)
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1

        AddNormalItem(0, 5, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end ;

end;

function item_3()
    CloseDialog()
    local sz_level = GetTask(420)
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1

        AddNormalItem(0, 6, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end ;
end;
function item_4()
    CloseDialog()
    local sz_level = GetTask(420)
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1

        AddNormalItem(0, 7, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end ;
end;
function item_5()
    CloseDialog()
    local sz_level = GetTask(420)
    local sel_lvl = task_lvl_2_sel_lvl[sz_level]
    if (sel_lvl ~= nil) then
        local player_type = GetPlayerType() + 1
        local sel_idx = task_lvl_2_sel_idx[sz_level]
        sz_level = sz_level + 1

        AddNormalItem(0, 9, player_type + 5, sel_lvl, 0, 0, 0)
        reward_normal()
    end ;
end;

function dongyi()
    if (HaveEventItem(110) >= 1) then
        if (GetTask(593) == 0) then
            Talk(1, "no", 11749)
            SetTask(592, 1)
            AddCredit(25)
            AddOwnExp(4000)
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
            TopMessage(11750)
        elseif (GetTask(593) == 1) then
            DelEventItem(110)
            SetTask(592, 1)
            Talk(1, "no", 11749)
            SetTask(597, 26)
            TaskNote(35, 33)
            AddCredit(25)
            AddOwnExp(4000)
            Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 25 ®iÓm danh väng!")
            TopMessage(11750)
            Msg2Player("Phôc mÖnh §Æng Cöu C«ng")
        end ;
    end ;
end;

function dongyi1()
    Talk(1, "no", 11751)
    SetTask(597, 28)
    TaskNote(35, 35)
    AddCredit(30)
    AddOwnExp(4000)
    Msg2Player("NhËn ®­îc 4000 ®iÓm kinh nghiÖm vµ 30 ®iÓm danh väng")
    TopMessage(11752)
    Msg2Player("§èi tho¹i víi Kh­¬ng Tö Nha")
end;

book_part = { "Ph¸ Qu©n-Tr¶m Long", "Ph¸ Qu©n-Nguyªn Thñy", "Ph¸ Qu©n-ThÇn ¦ng" }
book_name = {
    { "Yªu §¸i", "ChiÕn Ngoa", "Gi¸p" },
    { "C©n", "Lý", "§¹o Bµo" },
    { "Yªu §¸i", "Ngoa", "Hé Gi¸p" },
}
function org_book()
    local point = GetByte(GetTask(1268), 1)
    if (point >= 4) then
        local sel_type = GetPlayerType() + 1
        local item_list = {}
        for i = 1, 3 do
            item_list[i] = book_part[sel_type] .. book_name[sel_type][i] .. "/book" .. i
        end
        if (sel_type == 1) then
            item_list[3] = "Ph¸ Qu©n-HuyÒn thiÕt Tr¶m Long gi¸p/book3"
        end
        Say("Ng­¬i ®· tÝch lòy ®­îc 4 ®iÓm chiÕn c«ng, xin chän mét ®å phæ phÇn th­ëng cña m×nh!", 3, item_list)
    else
        Talk(1, "no", "C¸c anh hïng trªn cÊp 90 vµ ®¹t 9 cÊp chiÕn tr­êng, mçi lÇn tham gia chiÕn tr­êng sÏ ®­îc 1 ®iÓm chiÕn c«ng nÕu phe m×nh th¾ng. Sau khi ®¹t ®­îc 4 ®iÓm cã thÓ ®æi ®­îc ®å phæ ®å Cam. ChiÕn c«ng hiÖn t¹i cña ng­¬i lµ <c=g>" .. point .. "<c>.")
    end
end

function book1()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn §å phæ Ph¸ Qu©n 3 lÇn råi. Giê trõ phi cã <c=g>2 viªn Thä S¬n Th¹ch<c> ta míi cã thÓ cho ng­¬i ®æi thªm!", "book12", "no")
        else
            fgetBook(1, 280)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function book12()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(1, 280)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch! Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr× cã b¶o th¹ch nµy, ng­¬i ®Õn ®ã thö xem!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function book2()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn §å phæ Ph¸ Qu©n 3 lÇn råi. Giê trõ phi cã <c=g>2 viªn Thä S¬n Th¹ch<c> ta míi cã thÓ cho ng­¬i ®æi thªm!", "book22", "no")
        else
            fgetBook(2, 283)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function book22()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(2, 283)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch! Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr× cã b¶o th¹ch nµy, ng­¬i ®Õn ®ã thö xem!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function book3()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        local ntime = GetByte(GetTask(1268), 2) + 1
        if (ntime > 3) then
            MsgBox("Ng­¬i ®· nhËn §å phæ Ph¸ Qu©n 3 lÇn råi. Giê trõ phi cã <c=g>2 viªn Thä S¬n Th¹ch<c> ta míi cã thÓ cho ng­¬i ®æi thªm!", "book32", "no")
        else
            fgetBook(3, 289)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, ntime))
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function book32()
    CloseDialog()
    local winpoint = GetByte(GetTask(1268), 1)
    if (winpoint >= 4) then
        if (HaveNormalItem(3, 135, 0, 0) > 1) then
            DelNormalItem(3, 135, 0, 0)
            DelNormalItem(3, 135, 0, 0)
            fgetBook(3, 289)
            SetTask(1268, SetByte(GetTask(1268), 1, 0))
            SetTask(1268, SetByte(GetTask(1268), 2, 4))
        else
            Talk(1, "no", "Ng­¬i kh«ng ®ñ 2 viªn Thä S¬n Th¹ch! Nghe nãi TrÊn Nguyªn §¹i Tiªn ë Diªu Tr× cã b¶o th¹ch nµy, ng­¬i ®Õn ®ã thö xem!")
        end
    else
        Talk(1, "no", "Ng­¬i ch­a ®ñ ®iÓm chiÕn c«ng mµ! Quay L¹i sau nhÐ!")
    end
end

function fgetBook(key, itemidx)
    local tp = GetPlayerType() + 1
    local str = "§å phæ:" .. book_part[tp] .. book_name[tp][key]
    if (tp == 1) and (key == 3) then
        str = "§å phæ:Ph¸ Qu©n-Tr¶m Long Gi¸p"
    end

    TopMessage("B¹n nhËn ®­îc <c=g>" .. str)
    Msg2Player("B¹n nhËn ®­îc <c=g>" .. str)
    AddNormalItem(6, 1, itemidx + tp, 0, 0, 0)
end
