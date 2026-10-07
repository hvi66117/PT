Task_Zongxian = 1072;

Task_xianmo_renwu = 1297
Task_xianmo_npc = 1298
Task_xianmo_npcIndex = 1299
Task_xianmo_npcID = 1300

xianmo_UPtimes = 4
xianmo_UPcredit = 5000
JECT_LIMIT_CREDIT = 15000
JECT_LIMIT_CREDIT_1 = 45000
JECT_LIMIT_CREDIT_2 = 180000

Task_change_credit = 1350

Task_faery_renwu = 1296

azimuth = {
    [1] = "Khæn Tiªn cung-tÇng 1-§¹i phu §«ng b¾c",
    [2] = "Khæn Tiªn cung-tÇng 2-§¹i phu chÝnh b¾c",
    [3] = "Khæn Tiªn cung-tÇng 3-§¹i phu chÝnh nam",
    [4] = "Khæn Tiªn cung-tÇng 4-§¹i phu T©y nam",
    [5] = "Khæn Tiªn cung-tÇng 5-§¹i phu chÝnh ®«ng",
}

Task_LongAgo = 1529

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

    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(10)
            if (taskProcess == 1) or (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(10)
            if (taskProcess == 1) or (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess1 = GetTask(11)
            if (GetTask(11) == 0) then
                state = 1
                subState = 0
            elseif (GetTask(11) == 4) and (HaveEventItemCount(20) >= 1) and (HaveNormalItem(3, 13, 0, 0) >= 2) then
                state = 3
                subState = 0
            elseif (GetTask(11) >= 1) and (GetTask(11) <= 4) then
                state = 2
                subState = 0
            end
        else
            local taskProcess1 = GetTask(11)
            if (GetTask(11) == 0) then
                state = 1
                subState = 1
            elseif (GetTask(11) == 4) and (HaveEventItemCount(20) >= 1) and (HaveNormalItem(3, 13, 0, 0) >= 2) then
                state = 3
                subState = 1
            elseif (GetTask(11) >= 1) and (GetTask(11) <= 4) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Zongxian)
            if (taskProcess == 0) and (GetTask(11) == 5) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Zongxian)
            if (taskProcess == 0) and (GetTask(11) == 5) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 57
    if (GetLevel() >= startLevel) then
        local UTask_xq_0 = GetTask(50)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_xq_0 == 4) then
                state = 3
                subState = 0
            elseif (UTask_xq_0 == 7) then
                state = 3
                subState = 0
            elseif ((UTask_xq_0 == 5) and (HaveEventItem(39) == 1) and (HaveEventItem(40) == 1) and (GetItemCount(41) >= 1) and (GetTask(52) == 2)) then
                state = 3
                subState = 0
            elseif ((UTask_xq_0 == 5) or (UTask_xq_0 == 6)) then
                state = 2
                subState = 0
            end

        else
            if (UTask_xq_0 == 4) then
                state = 3
                subState = 1
            elseif (UTask_xq_0 == 7) then
                state = 3
                subState = 1
            elseif ((UTask_xq_0 == 5) and (HaveEventItem(39) == 1) and (HaveEventItem(40) == 1) and (GetItemCount(41) >= 1) and (GetTask(52) == 2)) then
                state = 3
                subState = 1
            elseif ((UTask_xq_0 == 5) or (UTask_xq_0 == 6)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 110
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        local taskProcess = GetTaskByte(Task_LongAgo, 2)
        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 111) or (taskWizard == 111) or (taskDruid == 111)) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 0 or taskProcess == 3)) then
                state = 3
                subState = 0
            elseif ((taskKnight == 119) or (taskWizard == 119) or (taskDruid == 119)) then
                state = 3
                subState = 0
            elseif (taskKnight == 114) or (taskWizard == 114) or (taskDruid == 114) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 1)) then
                state = 1
                subState = 0
            elseif (taskKnight == 116) or (taskWizard == 116) or (taskDruid == 116) then
                state = 3
                subState = 0
            elseif (taskKnight == 115) or (taskWizard == 115) or (taskDruid == 115) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 2)) then
                state = 2
                subState = 0
            end
        else
            if ((taskKnight == 111) or (taskWizard == 111) or (taskDruid == 111)) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 0 or taskProcess == 3)) then
                state = 3
                subState = 1
            elseif ((taskKnight == 119) or (taskWizard == 119) or (taskDruid == 119)) then
                state = 3
                subState = 1
            elseif (taskKnight == 114) or (taskWizard == 114) or (taskDruid == 114) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 1)) then
                state = 1
                subState = 1
            elseif (taskKnight == 116) or (taskWizard == 116) or (taskDruid == 116) then
                state = 3
                subState = 1
            elseif (taskKnight == 115) or (taskWizard == 115) or (taskDruid == 115) or (GetTaskByte(Task_LongAgo, 1) == 1 and (taskProcess == 2)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 120
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 124) or (taskWizard == 124) or (taskDruid == 124) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 124) or (taskWizard == 124) or (taskDruid == 124) then
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

    local result = directgettitle()
    if (result == 0) then
        taskshow()
    end
end;

function taskshow()
    tasks = {
        { "<c=yel>B¸ch Lý<c>", "renwu1"; show = 0 },
        { "<c=yel>Ngò ThÊt<c>", "renwu3"; show = 0 },
        { "<c=yel>Kh¶o nghiÖm míi<c>", "renwuNewTest"; show = 0 },
        { "<c=yel>Vi Lao<c>", "renwu2"; show = 0 },
        { "Cöu Lai", "renwu110"; show = 0 },
        { "Tu Tiªn ®¹o", "faery"; show = 0 },
        { "Tu Tiªn ®¹o", "faery_info"; show = 0 },
        { "Hñy bá Tu Tiªn ®¹o", "faery_cancel"; show = 0 },
        { "Tu Tiªn ®¹o hoµn thµnh", "faery_complete"; show = 0 },
        { "Th¨ng Tiªn NhËp Ma", "renwu120"; show = 0 },
        { "Thiªn Th­îng Nh©n Gian", "tofaery"; show = 0 },
        { "Tiªn Giíi Kh«i", "opensale"; show = 1 },
        { "NhËn X­ng hiÖu Tiªn giíi", "gettitle"; show = 0 },
        { "Khuyªn hµng", "changeCredit"; show = 0 },
    }

    if (havecurtitle() == 1 and GetTitleFunc() == 1) then
        tasks[13].show = 1
    end

    UTask_00 = GetTask(10);
    if (UTask_00 == 1) or (UTask_00 == 3) then
        tasks[1].show = 1;
    end ;
    UTask_xq_0 = GetTask(50);
    if (UTask_xq_0 == 7) then
        tasks[4].show = 1;
    end ;
    if (UTask_xq_0 == 5) and (HaveEventItem(39) == 1) and (HaveEventItem(40) == 1) and (GetItemCount(41) >= 1) and (GetTask(52) == 2) then
        tasks[4].show = 1;
    end ;
    if (UTask_xq_0 == 4) then
        tasks[4].show = 1;
    end ;
    local UTask_01 = GetTask(11);
    if (UTask_01 == 4) and (HaveEventItemCount(20) >= 1) and (HaveNormalItem(3, 13, 0, 0) >= 2) then
        tasks[2].show = 1;
    elseif (UTask_01 == 0) and (GetLevel() >= 3) and (GetPlayerType() == 1) then
        tasks[2].show = 1;
    end ;
    if (UTask_01 == 5 and GetTask(Task_Zongxian) == 0) then
        tasks[3].show = 1
    end

    if (GetLevel() >= 110) then
        local UTask_Wizard = GetTask(1)
        local UTask_Knight = GetTask(3)
        local UTask_Druid = GetTask(2)

        local taskProcess = GetTaskByte(Task_LongAgo, 2)

        if (UTask_Knight == 111) or (UTask_Wizard == 111) or (UTask_Druid == 111) then
            tasks[5].show = 1
        elseif (UTask_Knight == 113) or (UTask_Wizard == 113) or (UTask_Druid == 113) then
            tasks[5].show = 1
        elseif (UTask_Knight == 114) or (UTask_Wizard == 114) or (UTask_Druid == 114) then
            tasks[5].show = 1
        elseif (UTask_Knight == 116) or (UTask_Wizard == 116) or (UTask_Druid == 116) then
            tasks[5].show = 1


        elseif (GetTaskByte(Task_LongAgo, 1) == 1) and (taskProcess == 0 or (taskProcess == 1) or (taskProcess == 3)) then
            tasks[5].show = 1

        end

        if (IsMainTaskComplete() == 1) then
            local taskStatus = GetTaskByte(Task_xianmo_renwu, 4)
            if (GetTaskByte(Task_xianmo_renwu, 3) == 0) or (taskStatus == 0) then
                tasks[6].show = 1
            elseif (math.mod(taskStatus, 2) == 0) then
                tasks[7].show = 1
            elseif (taskStatus == 9) then
                tasks[9].show = 1
            else
                tasks[8].show = 1
            end
        end

        if (GetLevel() >= 121) then
            if (UTask_Knight == 124) or (UTask_Wizard == 124) or (UTask_Druid == 124) then
                tasks[10].show = 1
            end
            if (IsNewBirthComplete() == 0) then
                tasks[11].show = 1
            end
        end
    end

    if (GetJusticEvilCredit() < 0) then
        tasks[14].show = 1
    end

    SayTask(10570, tasks)
end;

aryPayCount = {
    [1] = 1,
    [2] = 2,
    [3] = 4,
    [4] = 6,
}

function changeCredit()

    CloseDialog()

    local credit = GetJusticEvilCredit()

    if (credit == 0) then
        Talk(1, "no", "Ng­¬i vÉn ch­a cã Danh väng")
        return
    end

    if (credit > 0) then
        Talk(1, "no", "H·y ®Õn")
        return
    end

    if (IsJEMainTaskComplete(2) == 1) and (IsJEMainTaskComplete(3) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT_2)) then

        local nNeedLV = 4
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Tiªn giíi, chØ cÇn giao nép <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ý!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
            return

        end

    elseif (IsJEMainTaskComplete(1) == 1) and (IsJEMainTaskComplete(2) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT_1)) then

        local nNeedLV = 3
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Tiªn giíi, chØ cÇn giao nép <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ý!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
            return

        end

    elseif (IsNewBirthComplete() == 1) and (IsJEMainTaskComplete(1) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT)) then

        local nNeedLV = 2
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Tiªn giíi, chØ cÇn giao nép <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ý!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
            return

        end

    elseif (IsNewBirthComplete() ~= 1) and (credit <= (-xianmo_UPcredit)) then

        local nNeedLV = 1
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Tiªn giíi, chØ cÇn giao nép <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ý!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. math.floor(nTotalIB / 100) .. "<c> Th«ng B¶o hoÆc <c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
            return

        end

    end

    local nShowCredit = 0
    if (IsJEMainTaskComplete(2) == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 4) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
        else
            nShowCredit = JECT_LIMIT_CREDIT_2
            Talk(2, "no", "Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", " Danh väng Ma giíi cña m×nh lªn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>§é KiÕp cÊp 70<c>, ta sÏ gióp ng­¬i gia nhËp Tiªn giíi!")
        end
    elseif (IsJEMainTaskComplete(1) == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 3) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
        else
            nShowCredit = JECT_LIMIT_CREDIT_1
            Talk(2, "no", "Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", " Danh väng Ma giíi cña m×nh lªn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>L«i §×nh Khëi LiÖt<c>, ta sÏ gióp ng­¬i gia nhËp Tiªn giíi!")
        end
    elseif (IsNewBirthComplete() == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 2) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
        else
            nShowCredit = JECT_LIMIT_CREDIT
            Talk(2, "no", "Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", " Danh väng Ma giíi cña m×nh lªn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>Thiªn KiÕp<c>, ta sÏ gióp ng­¬i gia nhËp Tiªn giíi!")
        end
    else
        if (GetTaskByte(Task_change_credit, 1) == 1) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i!")
        else
            nShowCredit = xianmo_UPcredit
            Talk(2, "no", "Ma giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Tiªn giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", " Danh väng Ma giíi cña m×nh lªn <c=g>" .. nShowCredit .. "c> ®iÓm, vµ th«ng qua <c=g>Trïng Sinh<c><c>, ta sÏ nhËn ng­¬i gia nhËp Tiªn giíi!")
        end
    end

    return

end

function changeCreditFin()

    CloseDialog()

    local credit = GetJusticEvilCredit()

    if (credit == 0) then
        return
    end

    if (credit > 0) then
        return
    end

    if (IsJEMainTaskComplete(2) == 1) and (IsJEMainTaskComplete(3) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT_2)) then

        local nNeedLV = 4
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                payIBCC(aryPayCount[nNeedLV])

                local credit = GetJusticEvilCredit()
                ChangeJusticEvilCredit(-(credit * 2))
                SetTaskByte(Task_change_credit, 1, nNeedLV)

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chÝnh thøc nhËn ng­¬i lµm chiÕn binh cña Tiªn giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Tiªn giíi")

                Title_Change(2)

                return

            end

        end

    elseif (IsJEMainTaskComplete(1) == 1) and (IsJEMainTaskComplete(2) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT_1)) then

        local nNeedLV = 3
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                payIBCC(aryPayCount[nNeedLV])

                local credit = GetJusticEvilCredit()
                ChangeJusticEvilCredit(-(credit * 2))
                SetTaskByte(Task_change_credit, 1, nNeedLV)

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chÝnh thøc nhËn ng­¬i lµm chiÕn binh cña Tiªn giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Tiªn giíi")

                Title_Change(2)

                return

            end

        end

    elseif (IsNewBirthComplete() == 1) and (IsJEMainTaskComplete(1) ~= 1) and (credit <= (-JECT_LIMIT_CREDIT)) then

        local nNeedLV = 2
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                payIBCC(aryPayCount[nNeedLV])

                local credit = GetJusticEvilCredit()
                ChangeJusticEvilCredit(-(credit * 2))
                SetTaskByte(Task_change_credit, 1, nNeedLV)

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chÝnh thøc nhËn ng­¬i lµm chiÕn binh cña Tiªn giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Tiªn giíi")

                Title_Change(2)

                return

            end

        end

    elseif (IsNewBirthComplete() ~= 1) and (credit <= (-xianmo_UPcredit)) then

        local nNeedLV = 1
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                payIBCC(aryPayCount[nNeedLV])

                local credit = GetJusticEvilCredit()
                ChangeJusticEvilCredit(-(credit * 2))
                SetTaskByte(Task_change_credit, 1, nNeedLV)

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chÝnh thøc nhËn ng­¬i lµm chiÕn binh cña Tiªn giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Tiªn giíi")

                Title_Change(2)

                return

            end

        end

    end

end

function checkIBCount(nCount)

    if (nCount == 0) then
        return 1
    end

    local i = HaveNormalItem(8, 566, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)

    local nNeedPay = nCount

    nNeedPay = nNeedPay - i

    if (nNeedPay <= 0) then
        return 1
    end

    if (GetCoin() >= (Cv * nNeedPay)) then
        return 1
    end

    return 0

end

function payIBCC(nCount)

    if (nCount == 0) then
        return
    end

    local nItemCount = HaveNormalItem(8, 566, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)

    local nNeedPay = nCount

    if (nItemCount > 0) then

        local nCostItem = 0
        if (nNeedPay > nItemCount) then
            nCostItem = nItemCount
        else
            nCostItem = nNeedPay
        end

        for i = 1, nCostItem do

            local id = FindAValidIBItem(8, 566, 2, 0)
            CostIBItem(id)

        end

        nNeedPay = nNeedPay - nCostItem
        if (nNeedPay <= 0) then
            return
        end

    end

    if (nNeedPay > 0) then

        for i = 1, nNeedPay do

            CostCoinByIdx(108)

        end

    end
end

function ArenwuNewTest()
    local Tasks2 = {
        { "<c=yel>Kh¶o nghiÖm míi<c>", "renwuNewTest"; show = 1 }
    }
    SayTask(10570, Tasks2)
end
function renwuNewTest()
    MsgBox(12135, "AcceptZongxian", "no")
end

function AcceptZongxian()
    SetTask(Task_Zongxian, 1)
    AddNormalItem(3, 141, 0, 0, 0, 0)
    TaskNote(895, 0)

    SetSubTask(895, 1, 1)

    TopMessage(12136)
    Msg2Player("NhËn ®­îc Chóng tiªn kh¶o ®Ò")
    Talk(1, "no", 12137)

    refreshNpcTaskState()

end
function renwu3()
    local UTask_01 = GetTask(11);
    if (UTask_01 == 4) and (HaveEventItemCount(20) >= 1) and (HaveNormalItem(3, 13, 0, 0) >= 2) then
        for i = 1, 2 do
            DelNormalItem(3, 13, 0, 0)
        end ;
        DelEventItem(20)
        Earn(600)
        AddOwnExp(600)
        SetTask(11, 5)
        AddNormalItem(0, 6, 1, 1, 0, 0)

        SetSubTask(2, -1, 1)

        TaskNote(2, -1)
        TopMessage(12138)
        Msg2Player("T×m ®­îc Háa Th¹ch vµ B¨ng C¬, XÝch Tïng Tö tÆng 600 l­îng, 600 ®iÓm kinh nghiÖm vµ Thiªn QuyÒn C©n!")
        Talk(1, "ArenwuNewTest", 10534)

        refreshNpcTaskState()

    end ;

    if (UTask_01 == 0) and (GetLevel() >= 3) then
        MsgBox(10536, "yes_10", "no")
    end ;
end

function yes_10()
    MsgBox(10537, "no")
    SetTask(11, 1)

    SetSubTask(2, 1, 1)

    TaskNote(2, 0)
    Msg2Player("§Õn Thî ®ång lÊy B¨ng C¬, ®Õn Kim Hµ §ång Tö nhËn Háa Th¹ch!")

    refreshNpcTaskState()

end;

function renwu1()
    UTask_00 = GetTask(10);
    if (UTask_00 == 1) then
        AddOwnExp(50)
        TopMessage(12133)
        Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm.")
        Talk(3, "no", 10571, 10572, 10573)
        TaskNote(1, 1)
        Msg2Player("XÝch Tinh Tö ®· chän ra ®Ö tö m×nh yªu thÝch.")
        SetTask(10, 2)

        refreshNpcTaskState()

    end ;
    if (UTask_00 == 3) then
        AddOwnExp(50)
        TopMessage(12133)
        Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm.")
        Talk(3, "no", 10571, 10572, 10573)
        TaskNote(1, 3)
        Msg2Player("XÝch Tïng Tö ®· chän ®­îc ®Ö tö t©m ®¾c! Cã thÓ b¸o cho Tõ Hµng ®¹o nh©n!")
        SetTask(10, 4)

        refreshNpcTaskState()

    end ;


end;

function renwu2()
    UTask_xq_0 = GetTask(50);
    if (UTask_xq_0 == 7) then

        local i = math.random(1, 10);
        if (i <= 5) then
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            Talk(1, "no", 11396)
            TopMessage(12139)
        elseif (5 < i) and (i <= 9) then
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            Talk(1, "no", 11397)
            TopMessage(12140)
        elseif (i == 10) then
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            AddNormalItemPile(3, 28, 0, 0, 0, 0)
            Talk(1, "no", 11398)
            TopMessage(12141)
        end ;

        TaskNote(21, -1)
        Msg2Player("Cøu ®­îc Vâ C¸t, nhËn ®­îc Hång thñy tinh vµ 5000 ®iÓm kinh nghiÖm")
        AddOwnExp(5000)
        SetTask(50, 8)
        SetTask(52, 0)
        refreshNpcTaskState()
    end ;

    if (UTask_xq_0 == 5) and (HaveEventItem(39) == 1) and (HaveEventItem(40) == 1) and (GetItemCount(41) >= 1) and (GetTask(52) == 2) then
        Talk(1, "no", 10629)
        TaskNote(21, 5)
        Msg2Player("Thu thËp ®ñ b¶o bèi, ®Õn T©y Kú cøu Vâ C¸t.")
        SetTask(50, 6)
        refreshNpcTaskState()
    end ;

    if (UTask_xq_0 == 4) then
        Talk(4, "yes_4", 10575, 10576, 10577, 10578)
    end ;
end;

function yes_4()
    Talk(1, "yes_2", 10579)
end;

function yes_2()
    MsgBox(10580, "yes_3", "no")
end;

function yes_3()
    TaskNote(21, 4)
    Msg2Player("Thu thËp liÔu méc, C«n L«n kÝnh, §Ìn thÇn cøu Vâ C¸t, cã lÏ biÕn th©n phï sÏ gióp Ých cho b¹n.")
    SetTask(52, 1)
    SetTask(50, 5)
    CloseDialog()
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;

function renwu110()
    CloseDialog()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (UTask_Knight == 111) or (UTask_Wizard == 111) or (UTask_Druid == 111) then
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 112)
            TaskNote(27, 43)
        elseif (pt == 1) then
            SetTask(1, 112)
            TaskNote(28, 47)
        else
            SetTask(2, 112)
            TaskNote(29, 42)
        end ;

        refreshNpcTaskState()

        Talk(3, "renwu110_1", " B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng?", "Xin tiÒn bèi chØ gi¸o!", " Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trÞ lµm t«n chØ!")
    elseif (UTask_Knight == 113) or (UTask_Wizard == 113) or (UTask_Druid == 113) then
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 114)
        elseif (pt == 1) then
            SetTask(1, 114)
        else
            SetTask(2, 114)
        end ;

        refreshNpcTaskState()

        Talk(3, "renwu110_2", " B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng?", "Xin tiÒn bèi chØ gi¸o!", " Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trÞ lµm t«n chØ!")
    elseif (UTask_Knight == 114) or (UTask_Wizard == 114) or (UTask_Druid == 114) then
        Talk(3, "no", " Ng­¬i gia nhËp bæn ph¸i, xem ra còng lµ kÎ thøc thêi!", " Kh«ng ngê Linh Quang ®¹i tiªn gi¸ng l©m h¹ giíi l¹i bÞ Giao Long khèng chÕ trªn c« ®¶o. Mong anh hïng khuÊt phôc Giao Long, cøu tho¸t Tiªn nh©n!", "Sù viÖc kh«ng thÓ chËm trÔ, Tiªn nh©n yªn t©m, ta nhÊt ®Þnh dèc hÕt søc m×nh gi¶i cøu Ngò HiÖn Linh Quan.")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 115)
            TaskNote(27, 46)
        elseif (pt == 1) then
            SetTask(1, 115)
            TaskNote(28, 50)
        else
            SetTask(2, 115)
            TaskNote(29, 45)
        end ;

        refreshNpcTaskState()


    elseif (UTask_Knight == 116) or (UTask_Wizard == 116) or (UTask_Druid == 116) then
        Talk(1, "no", " §a t¹ anh hïng ®· cøu gióp lÇn nµy! Xin tÆng anh hïng x­ng hiÖu vinh dù! Giê nÕu cã thêi gian xin anh hïng h·y ®Õn BÊt Chu Thiªn quan b¸i kiÕn HuyÒn §« §¹i Ph¸p s­, thØnh gi¸o tiªn ®¹o!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 123)
            TaskNote(27, 48)
        elseif (pt == 1) then
            SetTask(1, 123)
            TaskNote(28, 52)
        else
            SetTask(2, 123)
            TaskNote(29, 47)
        end ;

        ActiveTitleFunc(1)
        MainTaskComplete()
        AddOwnExp(30000000)
        WriteLog("110 chñ tuyÕn")
        Msg2Player("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")

        refreshNpcTaskState()

    elseif (GetTaskByte(Task_LongAgo, 2) == 0) then
        Talk(3, "no", " B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng?", "Xin tiÒn bèi chØ gi¸o!", " Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trÞ lµm t«n chØ!")
        SetTaskByte(Task_LongAgo, 2, 1)

        refreshNpcTaskState()
    elseif (GetTaskByte(Task_LongAgo, 2) == 1) then
        Talk(4, "no", "Ng­¬i gia nhËp phe ta, xem ra còng lµ kÎ thøc thêi!", " Kh«ng ngê Linh Quang ®¹i tiªn gi¸ng l©m h¹ giíi l¹i bÞ Giao Long khèng chÕ trªn c« ®¶o. Mong anh hïng khuÊt phôc Giao Long, cøu tho¸t Tiªn nh©n!", "Sù viÖc kh«ng thÓ chËm trÔ, Tiªn nh©n yªn t©m, ta nhÊt ®Þnh dèc hÕt søc m×nh gi¶i cøu Ngò HiÖn Linh Quan.", "Phe ta ®ang cÇn nh÷ng ng­êi anh dòng nh­ ng­¬i, sau khi hoµn thµnh viÖc nµy, ta sÏ tiÕn cö ng­¬i vµo Tiªn giíi.")

        SetTaskByte(Task_LongAgo, 2, 2)
        if (GetPlayerType() == 0) then
            TaskNote(27, 46)
        elseif (GetPlayerType() == 1) then
            TaskNote(28, 50)
        elseif (GetPlayerType() == 2) then
            TaskNote(29, 45)
        end

        refreshNpcTaskState()

    elseif (GetTaskByte(Task_LongAgo, 2) == 3) then
        Talk(2, "no", "§a t¹ anh hïng ®· cøu gióp lÇn nµy!", "Ng­¬i ®· lµ mét thµnh viªn cña Tiªn giíi, mai nµy khi ®Õn BÊt Chu Thiªn Quan ë Tiªn Ma Giíi, cã thÓ t×m HuyÒn §« §¹i Ph¸p S­ ®Ó ®­îc h­íng dÉn thªm.")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 123)
            TaskNote(27, 48)
        elseif (pt == 1) then
            SetTask(1, 123)
            TaskNote(28, 52)
        else
            SetTask(2, 123)
            TaskNote(29, 47)
        end ;

        SetTaskByte(Task_LongAgo, 2, 4)

        ActiveTitleFunc(1)
        MainTaskComplete()
        AddOwnExp(30000000)
        ChangeJusticEvilCredit(500)

        WriteLog("110 chñ tuyÕn")
        Msg2Player("Chóc mõng ng­¬i ®· gia nhËp Tiªn giíi, ®ång thêi nhËn ®­îc 500 danh väng Tiªn giíi vµ danh hiÖu do XÝch Tinh Tö ban tÆng, cïng víi 3000 v¹n kinh nghiÖm.")
        TopMessage("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")
        refreshNpcTaskState()
    end
end

function renwu110_1()
    Talk(2, "no", " Ta phông mÖnh thiªn th­îng tiÕp dÉn c¸c ®Ö tö Tiªn giíi. Ng­¬i cã khã kh¨n g× cø ®Õn t×m ta!", " §a t¹ ®· chØ ®iÓm! (§i t×m Cao Minh tr­íc ®·, råi míi quyÕt ®Þnh)")
end

function renwu110_2()
    Talk(2, "no", " Ta phông mÖnh thiªn th­îng tiÕp dÉn c¸c ®Ö tö Tiªn giíi. Ng­¬i cã khã kh¨n g× cø ®Õn t×m ta!", " §a t¹ ®· chØ ®iÓm!")
end

function faery_info()
    Talk(1, "no", " Ng­¬i mÆc dï ®· lÇm lÉn gia nhËp Ma giíi, nh­ng ta vÉn s½n sµng h­íng dÉn ng­¬i ®i vÒ Tiªn ®¹o. Cã ®iÒu hiÖn ng­¬i ®ang tiÕp nhËn kh¶o nghiÖm <c=g>NhËp ma ph¸p m«n<c>, ph¶i tõ bá hÕt tÊt c¶ míi cã thÓ gia nhËp bæn giíi!")
end

function faery()
    local credit = GetJusticEvilCredit()
    if (credit >= xianmo_UPcredit) then
        Talk(1, "no", " Ph¸p m«n Tiªn thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Lµ thµnh hay b¹i lµ cßn tuú ë ng­¬i vËy!")
        return 0
    end
    local lastday = GetTaskByte(Task_xianmo_renwu, 1)
    local today = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local times = GetTaskByte(Task_xianmo_renwu, 2)
    if (credit >= 0) then
        if (lastday ~= today) then
            MsgBox(" C¸c chiÕn binh tö trËn trong cuéc chiÕn nµy hån ph¸ch ®Òu bÞ l­u gi÷ ë Khæn Tiªn Cung. NÕu ng­¬i cã thÓ siªu ®é cho c¸c hån ph¸ch ®ã, Danh väng sÏ cã chót biÕn chuyÓn. §ång thêi ph¶i ®ãng gãp cho bæn giíi 10 v¹n l­îng ®Ó ®óc t¹o Tiªn khÝ nhËp m«n. Sao h¶?", "faery_yes", "no")
        elseif (times < xianmo_UPtimes) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
            MsgBox("Giíi ta tuy gÊp rót chiªu hiÒn n¹p tµi, nh­ng ®Ó tr¸nh do vµo gÊp mµ tÈu háa nhËp ma, cho nªn mçi ngµy cã thÓ häc lªn tiªn ph¸p m«n c¬ héi cã h¹n, nÕu ng­¬i cã thÓ lÊy <c=g>Tu Th©n QuyÕt<c> hoÆc <c=g>" .. Cfs .. " Th«ng B¶o<c>, ta sÏ miÔn c­ìng cho ng­¬i thªm c¬ héi kh¶o nghiÖm. §ång thêi ph¶i ®ãng gãp cho bæn giíi 10 v¹n l­îng ®Ó ®óc t¹o Tiªn khÝ nhËp m«n", "faery_coin_yes", "no")
        else
            Talk(1, "no", " Kh¶o nghiÖm tu tiªn ®· kÕt thóc. Danh väng Tiªn giíi cña ng­¬i còng ®· cã chót biÕn chuyÓn, cø kiªn tr× nh­ vËy, uy chÊn Tiªn ma l­ìng giíi sÏ kh«ng cßn xa!")
        end
    else
        if (lastday ~= today) then
            MsgBox(" Ng­¬i mÆc dï ®· lÇm lÉn gia nhËp Ma giíi, nh­ng ta vÉn s½n sµng h­íng dÉn ng­¬i ®i vÒ Tiªn ®¹o. C¸c chiÕn binh tö trËn trong cuéc chiÕn nµy hån ph¸ch ®Òu bÞ l­u gi÷ ë Khæn Tiªn Cung. NÕu ng­¬i cã thÓ siªu ®é cho c¸c hån ph¸ch ®ã, sÏ thanh tÈy ®­îc danh väng Ma giíi cña ng­¬i. Sau khi thanh tÈy <c=g>Danh väng Ma giíi vÒ 0<c>, sÏ chÝnh thøc ®øng trong hµng ngò Tiªn giíi. §ång thêi ph¶i ®ãng gãp cho bæn giíi 20 v¹n l­îng ®Ó ®óc t¹o Tiªn khÝ nhËp m«n. Sao h¶?", "faery1_yes", "no")
        elseif (times < xianmo_UPtimes) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
            MsgBox(" Ng­¬i ch¨m chØ tu luyÖn nh­ vËy, ta rÊt c¶m kÝch. Nh­ng kh¶o nghiÖm mçi ngµy chØ cã h¹n. NÕu ng­¬i cã <c=g>Tu Th©n QuyÕt<c> hoÆc <c=g>" .. Cfs .. " Th«ng B¶o<c> ta sÏ miÔn c­ìng cho ng­¬i thªm c¬ héi kh¶o nghiÖm. §ång thêi ph¶i ®ãng gãp cho bæn giíi 20 v¹n l­îng ®Ó ®óc t¹o Tiªn khÝ nhËp m«n. X¸c ®Þnh ch­a?", "faery1_coin_yes", "no")
        else
            Talk(1, "no", " Kh¶o nghiÖm tu tiªn h«m nay t¹m kÕt thóc, nh­ng d­ ©m Ma giíi cña ng­¬i vÉn cßn, sÏ ph¶i tÈy hÕt Danh väng Ma giíi vÒ 0. NÕu cø kiªn tr× nh­ vËy, gia nhËp hµng ngò Tiªn giíi chØ lµ vÊn ®Ò thêi gian!")
        end
    end
end

function faery_yes()
    if (GetCash() >= 100000) then
        local lastday = GetTaskByte(Task_xianmo_renwu, 1)
        local today = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(Task_xianmo_renwu, 2) + 1

        if (lastday ~= today) then
            SetTask(Task_xianmo_renwu, today)
            times = 1
        end
        SetTaskByte(Task_xianmo_renwu, 2, times)
        Pay(100000)

        local credit = GetJusticEvilCredit()
        local key = faery_set(credit)
        AddNormalItem(6, 1, 410, 0, 0, 0)
        AddNormalItem(6, 1, 412, 0, 0, 0)

        Msg2Player("§©y lµ lÇn thø " .. times .. " Kh¶o nghiÖm tu tiªn, giê h·y ®Õn Khæn Tiªn Cung siªu ®é cho c¸c hån ph¸ch Tiªn giíi.")
        TaskNote(90, 0, azimuth[key])

        if (times < xianmo_UPtimes) then
            SyncBibleState(90, 2, 1)
        else
            SyncBibleState(90, 3, 1)
        end ;
        Talk(1, "no", " H«m nay ®©y lµ lÇn thø " .. times .. " Kh¶o nghiÖm tu tiªn, giê h·y lËp tøc ®Õn Khæn Tiªn Cung, t¹i <c=g>" .. azimuth[key] .. "<c> sö dông <c=g>Tô Hån Linh ph­ín<c> lËp Tô Hån trËn. §îi sau khi ®· hµng phôc ®ñ c¸c hån ph¸ch ma vËt xung quanh th× dïng <c=g>§é Hån h­¬ng<c> dÉn ®é chóng vÒ gÆp §¹i phu tÇng nµy!")
        return 1
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ 20 v¹n, kh«ng thÓ chÕ t¹o Tiªn khÝ cho ng­¬i tu luyÖn ®­îc.")
    end
    return 0
end

function faery_coin_yes()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
    local i = FindAValidIBItem(8, 498, 2, 0)
    if (i ~= 0) then
        if (faery_yes() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Giao 1 Tu Th©n QuyÕt cho XÝch Tinh Tö")
    elseif (GetCoin() >= Cv) then
        if (faery_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(93)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. " Th«ng B¶o cho XÝch Tinh Tö")
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng ®ñ Th«ng B¶o,kh«ng thÓ gia nhËp hµng ngò Tiªn ®¹o")
    end
end

function faery_set(credit_val)
    item_faery = {
        [1] = { 0, 1000, 47, 0, 25 },
        [2] = { 1001, 2000, 48, 0, 25 },
        [3] = { 2001, 3000, 49, 0, 25 },
        [4] = { 3001, 4000, 50, 0, 25 },
        [5] = { 4001, 5000, 51, 0, 25 },
    }
    local temp1 = 0
    for i = 1, 5 do
        temp1 = item_faery[i]
        if (credit_val >= temp1[1]) and (credit_val <= temp1[2]) then
            SetTaskByte(Task_xianmo_renwu, 3, temp1[3])
            SetTaskByte(Task_xianmo_renwu, 4, 1)
            SetTask(Task_xianmo_npc, 0)
            SetTaskByte(Task_xianmo_npc, 2, temp1[4])
            SetTaskByte(Task_xianmo_npc, 3, temp1[5])
            return i
        end
    end

    SetTaskByte(Task_xianmo_renwu, 3, item_faery[1][3])
    SetTaskByte(Task_xianmo_renwu, 4, 1)
    SetTask(Task_xianmo_npc, 0)
    SetTaskByte(Task_xianmo_npc, 2, item_faery[1][4])
    SetTaskByte(Task_xianmo_npc, 3, item_faery[1][5])
    return 1
end

function faery1_yes()
    if (GetCash() >= 200000) then
        local lastday = GetTaskByte(Task_xianmo_renwu, 1)
        local today = math.mod(math.floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(Task_xianmo_renwu, 2) + 1

        if (lastday ~= today) then
            SetTask(Task_xianmo_renwu, today)
            times = 1
        end
        SetTaskByte(Task_xianmo_renwu, 2, times)
        Pay(200000)

        local credit = GetJusticEvilCredit()
        local key = faery_set(math.abs(credit))
        AddNormalItem(6, 1, 410, 0, 0, 0)
        AddNormalItem(6, 1, 412, 0, 0, 0)

        Msg2Player("§©y lµ lÇn thø " .. times .. " Kh¶o nghiÖm tu tiªn, giê h·y ®Õn Khæn Tiªn Cung siªu ®é cho c¸c hån ph¸ch Tiªn giíi.")
        TaskNote(90, 0, azimuth[key])

        if (times < xianmo_UPtimes) then
            SyncBibleState(90, 2, 1)
        else
            SyncBibleState(90, 3, 1)
        end ;
        Talk(1, "no", " H«m nay ®©y lµ lÇn thø " .. times .. " Kh¶o nghiÖm tu tiªn, giê h·y lËp tøc ®Õn Khæn Tiªn Cung, t¹i <c=g>" .. azimuth[key] .. "<c> sö dông <c=g>Tô Hån Linh ph­ín<c> lËp Tô Hån trËn. §îi sau khi ®· hµng phôc ®ñ c¸c hån ph¸ch ma vËt xung quanh th× dïng <c=g>§é Hån h­¬ng<c> dÉn ®é chóng vÒ gÆp §¹i phu tÇng nµy!")
        return 1
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ 20 v¹n, kh«ng thÓ chÕ t¹o Tiªn khÝ cho ng­¬i tu luyÖn ®­îc.")
    end
    return 0
end

function faery1_coin_yes()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
    local i = FindAValidIBItem(8, 498, 2, 0)
    if (i ~= 0) then
        if (faery1_yes() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Giao 1 Tu Th©n QuyÕt cho XÝch Tinh Tö")
    elseif (GetCoin() >= Cv) then
        if (faery1_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(93)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. " Th«ng B¶o cho XÝch Tinh Tö")
    else
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i kh«ng ®ñ Th«ng B¶o,kh«ng thÓ gia nhËp hµng ngò Tiªn ®¹o")
    end
end

function faery_cancel()
    MsgBox("Xem ra ng­¬i ®· cã vÎ n¶n chÝ! X¸c ®Þnh huû nhiÖm vô Tu Tiªn ®¹o lÇn nµy ­?", "cancel_faery", "no")
end

function cancel_faery()
    CloseDialog()
    SetTaskByte(Task_xianmo_renwu, 3, 0)
    SetTaskByte(Task_xianmo_renwu, 4, 0)
    SetTask(Task_xianmo_npc, 0)
    RemoveIBBuff(493)
    RemoveIBBuff(494)
    ClearItem(6, 1, 410, 0)
    ClearItem(6, 1, 412, 0)
    SetTask(Task_xianmo_npcID, 0)
    SetTask(Task_xianmo_npcIndex, 0)
    TaskNote(90, -1)

    Msg2Player("B¹n ®· huû nhiÖm vô Tu Tiªn ®¹o lÇn nµy!")
end

function faery_complete()
    CloseDialog()
    if (GetTaskByte(Task_xianmo_renwu, 4) == 9) then
        SetTaskWord(Task_xianmo_renwu, 2, 0)
        SetTask(Task_xianmo_npc, 0)
        SetTask(Task_xianmo_npcID, 0)
        SetTask(Task_xianmo_npcIndex, 0)
        TaskNote(90, -1)
        local credit = GetJusticEvilCredit()
        local temp = 60
        local str = " Kh¶o nhiÖm tu tiªn gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! Danh väng cña ng­¬i ®· t¨ng thªm <c=g>60<c> ®iÓm. Cø kiªn tr× nh­ vËy, uy chÊn Tiªn ma l­ìng giíi sÏ kh«ng cßn xa!"

        if (credit < 0) then
            temp = temp * 4
        end

        if (credit >= xianmo_UPcredit) then
            Talk(1, "no", " Ph¸p m«n Tiªn thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Lµ thµnh hay b¹i lµ cßn tuú ë ng­¬i vËy!")
            return 0
        elseif (credit > xianmo_UPcredit - 60) then
            temp = xianmo_UPcredit - credit
            str = " Kh¶o nhiÖm tu tiªn gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! Danh väng cña ng­¬i ®· t¨ng thªm <c=g>" .. temp .. "<c> ®iÓm! H·y tiÕp tôc nç lùc nhÐ!"
        elseif (credit >= (-temp)) and (credit <= 0) then
            local showtemp = temp
            temp = temp + 500
            str = " Kh¶o nhiÖm tu tiªn gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! LÇn nµy ng­¬i ngoµi viÖc nhËn ®­îc <c=g>" .. showtemp .. "<c> ®iÓm danh väng, ta cßn th­ëng thªm <c=g>500 ®iÓm<c> danh väng n÷a! H·y tiÕp tôc nç lùc nhÐ!"
        elseif (credit < (-temp)) then
            str = " Kh¶o nhiÖm tu tiªn gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng. Danh väng Tiªn giíi cña ng­¬i ®· t¨ng <c=g>" .. temp .. "<c> ®iÓm. Nh­ng v× danh väng Ma giíi cña ng­¬i vÉn ch­a tiªu trõ hÕt, nªn ta gióp ng­¬i t¨ng mÆt kh¸c. Hy väng ng­¬i sím tÈy röa c¸c tµn d­ cña Ma giíi!"
        end

        ChangeJusticEvilCredit(temp)

        Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô Tu Tiªn ®¹o lÇn nµy")
        Talk(1, "no", str)

        if (IsWorldEventExist(1) == 1) then
            if (GetWorldEventProgress(1) <= 4) and (credit > 0) then
                WorldEventrenwu()
            end
        end
    end
end

function WorldEventrenwu()
    local times = GetWorldEventValue(1, 5) + 1
    if (times < 1200) then
        local key = math.mod(times, 150)
        if (GetWorldEventProgress(1) == 4) and (key == 0) then
            AddGlobalCountNews("Anh hïng <c=yel>" .. GetName() .. "<c> hoµn thµnh nhiÖm vô danh väng lÇn thø <c=yel>" .. times .. "<c>, gióp Linh Quan håi phôc linh lùc, hy väng c¸c anh hïng tiÕp tôc nç lùc!")

        end
        SetWorldEventValue(1, 5, times)
    elseif (GetWorldEventProgress(1) == 4) and (times == 1200) then
        SetWorldEventValue(1, 5, 1201)
        SetWorldEventProgress(1, 5)
        AddGlobalCountNews("Anh hïng <c=yel>" .. GetName() .. "<c>Hoµn thµnh nhiÖm vô ÁËµÚ<c=yel>1200<c>´ÎÉùÍû, ÎåÏÔÁé¹ÙÒÑ»Ö¸´ÁéÁ¦, ¿ÉÈ¥Ñþ³Ø´¦ÕÒËûÁË½âÈçºÎ¿ªÆôÏÉÄ§Ö®½ç")
        WriteLog("Hoµn thµnh nhiÖm vô 1200´ÎÉùÍû")
    end
end

function renwu120()
    CloseDialog()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (UTask_Knight == 124) or (UTask_Wizard == 124) or (UTask_Druid == 124) then
        Talk(3, "no", " Ng­¬i ®i lÇn nµy cã thuËn lîi kh«ng?", " LÇn nµy xem nh­ thuËn lîi. §­îc HuyÒn §« §¹i Ph¸p s­ chØ ®iÓm khiÕn ®Ö tö më tÇm m¾t!", " VËy tèt l¾m! Mãn vò khÝ nµy lµ phÇn cña ng­¬i. T­¬ng lai trong Tiªn Ma giíi lµ do ng­¬i tù quyÕt ®Þnh! Cè g¾ng nhÐ!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 130)
            TaskNote(27, 52)
            if (math.random(1, 2) == 1) then
                AddBlueEquip(0, 0, 35, 1, 0, 0, 1)
            else
                AddBlueEquip(0, 0, 62, 1, 0, 0, 1)
            end
        elseif (pt == 1) then
            SetTask(1, 130)
            TaskNote(28, 56)
            AddBlueEquip(0, 0, 36, 1, 0, 0, 1)
        else
            SetTask(2, 130)
            TaskNote(29, 51)
            AddBlueEquip(0, 0, 37, 1, 0, 0, 1)
        end ;

        Msg2Player("B¹n nhËn ®­îc 1 mãn vò khÝ!")
        TopMessage("B¹n nhËn ®­îc 1 mãn vò khÝ Tiªn Ma giíi")

        WriteLog("120 chñ tuyÕn")

        refreshNpcTaskState()

    end
end

function tofaery()
    local credit = GetJusticEvilCredit()
    if (credit >= xianmo_UPcredit) then
        if (GetTaskByte(Task_faery_renwu, 2) == 0) then
            SetTaskByte(Task_faery_renwu, 2, 1)
        end

        local Proglvl = GetWorldEventProgress(1)
        if (Proglvl < 3) then
            Talk(1, "no", " Ph¸p m«n Tiªn thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Danh väng cña ng­¬i còng ®· truyÒn ®Õn Tiªn giíi, vèn ng­¬i ®· cã thÓ th«ng qua Nam Thiªn m«n ®Ó vµo Thiªn Th­îng Nh©n Gian, nh­ng nghe ®©u vÞ tiªn nh©n gi÷ cæng nµy ®ang bÞ v©y khèn ë Tam Tiªn ®¶o. Ng­¬i h·y ®Õn ®¶o ®ã t×m §¹i phu xem cã ®óng vËy kh«ng!")
        elseif (Proglvl < 6) then
            Talk(1, "no", " Ph¸p m«n Tiªn thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Danh väng cña ng­¬i còng ®· truyÒn ®Õn Tiªn giíi, vèn ng­¬i ®· cã thÓ th«ng qua Nam Thiªn m«n ®Ó vµo Thiªn Th­îng Nh©n Gian, nh­ng ta nghe nãi muèn ®i qua ®ã ph¶i qua kh¶o nghiÖm. Ng­¬i h·y ®Õn Diªu Tr× gÆp Ngò HiÖn Linh Quang hái râ xem sao!")
        else
            Talk(1, "no", " Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Lµ thµnh hay b¹i lµ cßn tuú ë ng­¬i vËy! Giê nÕu nh­ c¸nh cña th«ng qua <c=g>Thiªn Th­îng Nh©n Gian<c> ®· më, th× ng­¬i cã thÓ ®Õn <c=g>Nam Thiªn m«n ë Diªu Tr×<c> ®i vµo Tiªn Ma giíi")
        end
    else
        Talk(1, "no", " NÕu muèn th¨ng tiªn trùc tiÕp vµo Thiªn Th­îng Nh©n Gian, cÇn cã chót danh tiÕng t¹i Nh©n giíi (§¼ng cÊp Nh©n giíi ®¹t 121) vµ Danh väng Tiªn giíi ph¶i ®¹t ®Õn 5000 ®iÓm). Cã thÓ ®Õn <c=g>Nam Thiªn m«n ë Diªu Tr×<c> ®Ó vµo Tiªn Ma giíi!")
    end
end

function opensale()
    CloseDialog()
    OpenImmortalSale(34)
end

titletab = {
    [1] = { titleid = 1, titlename = "Anh hïng c¸i thÕ", titlecamp = 0, titlefunc = "get1", low = 0, heigh = 0 },
    [2] = { titleid = 2, titlename = "Tiªn Vò Kh¸ch", titlecamp = 1, titlefunc = "get2", low = 500, heigh = 5000 },
    [3] = { titleid = 3, titlename = "Tiªn §¹i S­", titlecamp = 1, titlefunc = "get3", low = 5000, heigh = 15000 },
    [4] = { titleid = 4, titlename = "Du T¸n Tiªn", titlecamp = 1, titlefunc = "get4", low = 15000, heigh = 45000 },
    [5] = { titleid = 5, titlename = "Ma U Sø", titlecamp = 2, titlefunc = "get5", low = 500, heigh = 5000 },
    [6] = { titleid = 6, titlename = "Tiªn LuyÖn S­", titlecamp = 2, titlefunc = "get6", low = 5000, heigh = 15000 },
    [7] = { titleid = 7, titlename = "D¹ Du Ma", titlecamp = 2, titlefunc = "get7", low = 15000, heigh = 45000 },
    [8] = { titleid = 20, titlename = "Linh §éng Tiªn", titlecamp = 1, titlefunc = "get8", low = 45000, heigh = 179999 },
    [9] = { titleid = 21, titlename = "HuyÒn Vùc Ma", titlecamp = 2, titlefunc = "get9", low = 45000, heigh = 179999 },
}

function havecurtitle()
    local curtitle = GetCurTitle()
    local nNum = 0

    if (curtitle == 1 and GetJusticEvilCredit() < 0) then
        return 0
    end

    for i = 1, table.getn(titletab) do
        if (HaveQualify(titletab[i].titleid) == 1 and titletab[i].titleid ~= curtitle) then

            if (titletab[i].titlecamp ~= 2) then
                nNum = nNum + 1

            elseif (titletab[i].titlecamp == 2 and curtitle == 1) then
                nNum = nNum + 1
            end
        end
    end

    if (nNum > 0) then
        return 1
    end

    return 0
end

function directgettitle()

    if (IsMainTaskComplete() == 0) then
        return 0
    end

    if (GetTitleFunc() == 0) then
        return 0
    end

    if (isnotitle() == 1) then
        local result1 = notitle()
        return result1
    end

    if (iscamptitle() == 1) then
        local result2 = havecamptitle()
        return result2
    end

    if (notcamptitle() == 1) then
        local result3 = havenocamptitle()
        return result3
    end
end

function autoFixJECredit()

    local curtitle = GetCurTitle()
    local curextype = getextype()

    if (iscamptitle() == 1) then

        local exglory = GetJusticEvilCredit()
        local curtitlecamp = getsomeidtype(curtitle)

        if (exglory > 4500) and (curtitlecamp == 2) then
            ChangeJusticEvilCredit(-2 * exglory)
        end
    end

end

function gettitle()
    CloseDialog()

    if (directgettitle() == 1) then
        return
    end

    local shownum = 0
    local curtitle = GetCurTitle()
    local navigation = {}

    for k = 1, 9 do
        if (HaveQualify(titletab[k].titleid) == 1 and curtitle ~= titletab[k].titleid) then
            shownum = shownum + 1

            navigation[shownum] = titletab[k].titlename .. "/" .. titletab[k].titlefunc
        end
    end

    if (shownum > 0) then

        Say(" Nh÷ng cèng hiÕn cña ng­¬i ®· ®­îc Tiªn giíi ghi nhËn, cã thÓ lùa chän 1 X­ng hiÖu cho m×nh, ®ã lµ minh chøng cho nh÷ng nç lùc cña ng­¬i!", table.getn(navigation), navigation)
    end
end

function isnotitle()
    local curtitle = GetCurTitle()
    if (curtitle == 0) then
        return 1
    end
    return 0
end

function iscamptitle()
    local curtitle = GetCurTitle()

    for i = 2, table.getn(titletab) do
        if (curtitle == titletab[i].titleid) then
            return 1
        end
    end

    return 0
end

function notcamptitle()
    local curtitle = GetCurTitle()

    if (curtitle ~= 0) then
        for i = 2, table.getn(titletab) do
            if (curtitle == titletab[i].titleid) then
                return 0
            end
        end
    end

    return 1
end

function notitle()

    local curtitle = GetCurTitle()

    if (curtitle ~= 0) then
        return 0
    end

    local nIdx = canhavecamptitle()
    if (nIdx ~= 0) then


        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)

        ActiveTitleQualify(titletab[nIdx].titleid)
        SetCurTitle(titletab[nIdx].titleid)
        Talk(1, "no", " Nh÷ng cèng hiÕn cña ng­¬i ®· ®­îc Tiªn giíi ghi nhËn. Ta tÆng cho ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>! Cuéc chiÕn nµy sÏ cßn kÐo dµi ch­a døt, hy väng ng­¬i sÏ gãp søc gióp Tiªn giíi b×nh gi¶i ®­îc cuéc chiÕn nµy!")
        return 1
    end

    return 0
end

function havecamptitle()

    local curtitle = GetCurTitle()
    local curextype = getextype()

    if (iscamptitle() == 1) then

        local nIdx = canhavecamptitle()

        if (nIdx == 0) then
            return 0
        end

        if (curtitle == titletab[nIdx].titleid) then
            return 0
        end

        local curtitlecamp = getsomeidtype(curtitle)

        if (curtitlecamp == titletab[nIdx].titlecamp and curtitlecamp == 1) then
            for i = 2, 9 do
                UnActiveTitleQualify(titletab[i].titleid)
            end
            ActiveTitleQualify(titletab[nIdx].titleid)
            SetCurTitle(titletab[nIdx].titleid)

            AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)

            if (curtitle > titletab[nIdx].titleid) then
                Talk(1, "no", " Tiªn giíi v× sî ng­¬i th¨ng tiÕn qu¸ nhanh sÏ h¸o th¾ng mµ g©y nhiÒu tæn h¹i cho bæn giíi. Ta cùc ch¼ng ®· ®µnh ph¶i gi¸ng x­ng hiÖu cña ng­¬i xuèng lµ <c=g>" .. titletab[nIdx].titlename .. "<c>. Ng­¬i ®õng n¶n chÝ, h·y tiÕp tôc lËp c«ng, chøng minh n¨ng lùc!")
            else
                Talk(1, "no", " Ng­¬i v­ît qua giai ®o¹n Kh¶o nghiÖm tu tiªn nhanh h¬n ta t­ëng, ®Ó khÝch lÖ bæn giíi tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>. Hy väng ng­¬i tiÕp tôc ph¸t huy, mang vinh quang vÒ cho Tiªn giíi!")
            end
            return 1
        end

        if (curtitlecamp ~= titletab[nIdx].titlecamp and curtitlecamp == 2) then
            for i = 2, 9 do
                UnActiveTitleQualify(titletab[i].titleid)
            end
            ActiveTitleQualify(titletab[nIdx].titleid)
            SetCurTitle(titletab[nIdx].titleid)

            AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)

            Talk(1, "no", " Chóc mõng! Ng­¬i ®· hoµn toµn tho¸t khái Ma giíi, ®Ó biÓu d­¬ng ng­¬i lµm r¹ng danh Tiªn giíi, ta tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>! Hy väng trong kú Kh¶o nghiÖm tu tiªn lÇn sau, ng­¬i sÏ kh«ng lµm bæn giíi thÊt väng!")
            return 1
        end
    end
    return 0
end

function havenocamptitle()
    local curtitle = GetCurTitle()
    local nIdx = canhavecamptitle()

    if (notcamptitle() == 0) then


        return 0
    end

    if (nIdx == 0) then
        return 0
    end

    if (titletab[nIdx].titlecamp == 2) then
        return 0
    end

    if (HaveQualify(titletab[nIdx].titleid) == 0) then
        MsgBox(" Nh÷ng cèng hiÕn cña ng­¬i ®Òu ®­îc Tiªn giíi ghi nhËn, ta vèn muèn tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>, nh­ng hiÖn t¹i ng­¬i ®· cã X­ng hiÖu kh¸c, cã muèn ®æi kh«ng? NhÊp \"È·¶¨\" sÏ lËp tøc thay ®æi X­ng hiÖu cña bæn giíi. nÕu \"È¡Ïû\" h«m kh¸c cã thÓ quay l¹i l·nh nhËn.", "yes_change", "no_keep")
        return 1
    end
    return 0
end

function getextype()
    local exglory = GetJusticEvilCredit()
    if (exglory > 0) then
        return 1
    elseif (exglory < 0) then
        return 2
    end
end

function getsomeidtype(id)
    for i = 1, table.getn(titletab) do
        if (titletab[i].titleid == id) then
            return titletab[i].titlecamp
        end
    end
    return 0
end

function canhavecamptitle()
    local exglory = GetJusticEvilCredit()
    local extype = getextype()
    local level = GetLevel()
    local exlevel = GetPlayerExtLevel()
    local nIdx = 0
    if (extype == 1) then
        if (exglory >= titletab[8].low and (IsJEMainTaskComplete(2) == 1)) then
            nIdx = 8
        elseif (exglory >= titletab[4].low and (IsJEMainTaskComplete(1) == 1)) then
            nIdx = 4
        elseif (exglory >= titletab[3].low and
                exglory <= titletab[3].heigh and
                level >= 121) then
            nIdx = 3
        elseif (exglory >= titletab[2].low and
                exglory < titletab[2].heigh) then
            nIdx = 2
        end
    elseif (extype == 2) then
        exglory = -exglory
        if (exglory >= titletab[9].low and (IsJEMainTaskComplete(2) == 1)) then
            nIdx = 9
        elseif (exglory >= titletab[7].low and (IsJEMainTaskComplete(1) == 1)) then
            nIdx = 7
        elseif (exglory >= titletab[6].low and
                exglory <= titletab[6].heigh and
                level >= 121) then
            nIdx = 6
        elseif (exglory >= titletab[5].low and
                exglory < titletab[5].heigh) then
            nIdx = 5
        end
    end
    return nIdx
end

function yes_change()
    CloseDialog()
    local curtitle = GetCurTitle()
    local nIdx = canhavecamptitle()

    if (notcamptitle() == 1 and nIdx > 1 and nIdx <= table.getn(titletab)) then


        for i = 2, 9 do
            UnActiveTitleQualify(titletab[i].titleid)
        end
        ActiveTitleQualify(titletab[nIdx].titleid)
        SetCurTitle(titletab[nIdx].titleid)

        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)

    end

end

function no_keep()
    CloseDialog()
    local curtitle = GetCurTitle()
    local nIdx = canhavecamptitle()

    if (notcamptitle() == 1 and nIdx > 1 and nIdx < table.getn(titletab)) then


        for i = 2, 9 do
            UnActiveTitleQualify(titletab[i].titleid)
        end
        ActiveTitleQualify(titletab[nIdx].titleid)

        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)


    end
end

function get1()
    CloseDialog()
    ActiveTitleQualify(titletab[1].titleid)
    SetCurTitle(titletab[1].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Anh hïng c¸i thÕ<c>")
end

function get2()
    CloseDialog()
    ActiveTitleQualify(titletab[2].titleid)
    SetCurTitle(titletab[2].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Tiªn Vò Kh¸ch<c>")
end

function get3()
    CloseDialog()
    ActiveTitleQualify(titletab[3].titleid)
    SetCurTitle(titletab[3].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Tiªn §¹i S­<c>")
end

function get4()
    CloseDialog()
    ActiveTitleQualify(titletab[4].titleid)
    SetCurTitle(titletab[4].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Du T¸n Tiªn<c>")
end

function get8()
    CloseDialog()
    ActiveTitleQualify(titletab[8].titleid)
    SetCurTitle(titletab[8].titleid)
    TopMessage("B¹n nhËn ®­îc danh x­ng <c=g>Linh §éng Tiªn<c>")
end

gTitleCampInfo = {
    [1] = {
        [1] = { titleID = 2, titleCamp = 1 },
        [2] = { titleID = 5, titleCamp = 2 },
    },
    [2] = {
        [1] = { titleID = 3, titleCamp = 1 },
        [2] = { titleID = 6, titleCamp = 2 },
    },
    [3] = {
        [1] = { titleID = 4, titleCamp = 1 },
        [2] = { titleID = 7, titleCamp = 2 },
    },
    [4] = {
        [1] = { titleID = 20, titleCamp = 1 },
        [2] = { titleID = 21, titleCamp = 2 },
    },
}

function Title_Change(srcCamp)
    no()
    local desCamp = 0
    if (srcCamp == 1) then
        desCamp = 2
    elseif (srcCamp == 2) then
        desCamp = 1
    end

    if (desCamp > 0) then
        for i = 1, table.getn(gTitleCampInfo) do
            local titleSubInfo = gTitleCampInfo[i]
            if (HaveQualify(titleSubInfo[srcCamp].titleID) > 0) then
                if (GetCurTitle() == titleSubInfo[srcCamp].titleID) then
                    UnActiveTitleQualify(titleSubInfo[srcCamp].titleID)
                    ActiveTitleFunc(1)
                    ActiveTitleQualify(titleSubInfo[desCamp].titleID)
                    SetCurTitle(titleSubInfo[desCamp].titleID)
                else
                    UnActiveTitleQualify(titleSubInfo[srcCamp].titleID)
                    ActiveTitleFunc(1)
                    ActiveTitleQualify(titleSubInfo[desCamp].titleID)
                end


            end
        end
    end
end

