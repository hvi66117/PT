--description: ¸ßÃ÷-Ç§ÀïÑÛ
--author: yichuan
--date: 2004/6/29

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-21
-- ÈÎÎñ×´Ì¬±äÁ¿
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒı»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊı;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊıÎªÏÉ,Å¼ÊıÎªÄ§
Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊı 2=³õÊ¼ÏµÊıx 3=µ±Ç°Ôö³¤ÏµÊı(Y)
Task_xianmo_npcIndex = 1299    -- °ó¶¨µÄNpcIndex
Task_xianmo_npcID = 1300    -- °ó¶¨µÄNpcID

xianmo_UPtimes = 4 --ĞŞÏÉÖ®µÀÃ¿ÌìÉÏÏŞ (Ãâ·Ñ1+ÊÕ·Ñ3)
xianmo_UPcredit = 5000 --ÏÉÉùÍûÉÏÏŞ
JECT_LIMIT_CREDIT = 15000
JECT_LIMIT_CREDIT_1 = 45000
JECT_LIMIT_CREDIT_2 = 180000

Task_faery_renwu = 1296 --1byteÊÇ·ñ±¨Ãû²Î¼ÓÊÀ½çÊÂ¼ş¿ªÆôÈÎÎñ,2byte ×ªÉú¿ª¹Ø

Task_change_credit = 1350

azimuth = {
    [1] = "Khæn Tiªn cung-tÇng 1§¹i phu §«ng b¾c",
    [2] = "Khæn Tiªn cung-tÇng 2§¹i phu Chİnh b¾c",
    [3] = "Khæn Tiªn cung-tÇng 3§¹i phu Chİnh nam",
    [4] = "Khæn Tiªn cung-tÇng 4§¹i phu t©y nam",
    [5] = "Khæn Tiªn cung-tÇng 5§¹i phu chİnh ®«ng",
}

--AS GaoJingwei 090813
Task_LongAgo = 1529        --1byte: 1ÕÒ³à¾«×Ó£¬2ÕÒ¸ßÃ÷   2byte 1ÁË½âÏÉÄ§½ç  2ÁìÈ¡É±ÁúÈÎÎñ 3³É¹¦É±Áú  4ÁìÈ¡½±Àø
--AE GaoJingwei 090813

-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --ÌìÍâ·ÉÏÉ
    startLevel = 39
    if (GetLevel() >= startLevel) then
        local UTask_xq_1 = GetTask(51)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_xq_1 == 2) then
                state = 3
                subState = 0
            end
        else
            if (UTask_xq_1 == 2) then
                state = 3
                subState = 1
            end
        end
        index = searchForIndex(state, subState, index)
    end

    --ÓÉÀ´ÒÑ¾Ã
    startLevel = 110
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        local taskProcess = GetTaskByte(Task_LongAgo, 2)

        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 111) or (taskWizard == 111) or (taskDruid == 111)) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 0 or taskProcess == 3)) then
                state = 3
                subState = 0
            elseif ((taskKnight == 120) or (taskWizard == 120) or (taskDruid == 120)) then
                state = 3
                subState = 0
            elseif (taskKnight == 114) or (taskWizard == 114) or (taskDruid == 114) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 1)) then
                state = 1
                subState = 0
            elseif (taskKnight == 118) or (taskWizard == 118) or (taskDruid == 118) then
                state = 3
                subState = 0
            elseif (taskKnight == 117) or (taskWizard == 117) or (taskDruid == 117) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 2)) then
                state = 2
                subState = 0
            end
        else
            if ((taskKnight == 111) or (taskWizard == 111) or (taskDruid == 111)) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 0 or taskProcess == 3)) then
                state = 3
                subState = 1
            elseif ((taskKnight == 120) or (taskWizard == 120) or (taskDruid == 120)) then
                state = 3
                subState = 1
            elseif (taskKnight == 114) or (taskWizard == 114) or (taskDruid == 114) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 1)) then
                state = 1
                subState = 1
            elseif (taskKnight == 118) or (taskWizard == 118) or (taskDruid == 118) then
                state = 3
                subState = 1
            elseif (taskKnight == 117) or (taskWizard == 117) or (taskDruid == 117) or (GetTaskByte(Task_LongAgo, 1) == 2 and (taskProcess == 2)) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ÉıÏÉÈëÄ§
    startLevel = 120
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 122) or (taskWizard == 122) or (taskDruid == 122) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 122) or (taskWizard == 122) or (taskDruid == 122) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    local result = directgettitle()
    if (result == 0) then
        taskshow(sel)
    end
end;

function taskshow(sel)
    tasks = {
        --		{"ò¿ÓÈÉñÆ÷","renwu1";show=0},
        --		{"ĞÂÊ½×°±¸","renwu2";show=0},
        { "Phi Tiªn", "renwu3"; show = 0 },
        { "Cöu Lai", "renwu110"; show = 0 },
        { "NhËp ma ph¸p m«n", "faery"; show = 0 },
        { "NhËp ma ph¸p m«n", "faery_info"; show = 0 },
        { "Hñy bá NhËp ma ph¸p m«n", "faery_cancel"; show = 0 },
        { "NhËp ma ph¸p m«n hoµn thµnh", "faery_complete"; show = 0 },
        { "Th¨ng Tiªn NhËp Ma", "renwu120"; show = 0 },
        { "Thiªn Th­îng Nh©n Gian", "tofaery"; show = 0 },
        { "MaGiíiKúTr©n", "opensale"; show = 1 },
        { "NhËn X­ng hiÖu Ma giíi", "gettitle"; show = 0 },
        { "Khuyªn hµng", "changeCredit"; show = 0 },
    }

    if (havecurtitle() == 1 and GetTitleFunc() == 1) then
        tasks[10].show = 1
    end
    --	UTask_25 = GetTask(35);
    --	UTask_21 = GetTask(31);
    --	if (UTask_25==2) then
    --			tasks[1].show=1;
    --	end;
    --	if (UTask_21==4) then
    --			tasks[2].show=1;
    --	end;
    --	if (UTask_21==2) then
    --			tasks[2].show=1;
    --	end;
    UTask_xq_1 = GetTask(51);
    if (UTask_xq_1 == 2) then
        tasks[1].show = 1;
    end ;

    if (GetLevel() >= 110) then
        local UTask_Wizard = GetTask(1)
        local UTask_Knight = GetTask(3)
        local UTask_Druid = GetTask(2)

        local taskProcess = GetTaskByte(Task_LongAgo, 2)

        if (UTask_Knight == 111) or (UTask_Wizard == 111) or (UTask_Druid == 111) then
            tasks[2].show = 1
        elseif (UTask_Knight == 112) or (UTask_Wizard == 112) or (UTask_Druid == 112) then
            tasks[2].show = 1
        elseif (UTask_Knight == 114) or (UTask_Wizard == 114) or (UTask_Druid == 114) then
            tasks[2].show = 1
        elseif (UTask_Knight == 118) or (UTask_Wizard == 118) or (UTask_Druid == 118) then
            tasks[2].show = 1
            --AS GaoJingwei 090812
        elseif (GetTaskByte(Task_LongAgo, 1) == 2) and (taskProcess == 0 or (taskProcess == 1) or (taskProcess == 3)) then
            tasks[2].show = 1
            --AE GaoJingwei 090812
        end

        if (IsMainTaskComplete() == 1) then
            local taskStatus = GetTaskByte(Task_xianmo_renwu, 4)
            if (GetTaskByte(Task_xianmo_renwu, 3) == 0) or (taskStatus == 0) then
                tasks[3].show = 1
            elseif (mod(taskStatus, 2) == 1) then
                tasks[4].show = 1
            elseif (taskStatus == 10) then
                tasks[6].show = 1
            else
                tasks[5].show = 1
            end
        end

        if (GetLevel() >= 121) then
            if (UTask_Knight == 122) or (UTask_Wizard == 122) or (UTask_Druid == 122) then
                tasks[7].show = 1
            end
            if (IsNewBirthComplete() == 0) then
                tasks[8].show = 1
            end
        end
    end

    if (GetJusticEvilCredit() > 0) then
        tasks[11].show = 1
    end

    SayTask(10146, tasks)
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

    if (credit < 0) then
        Talk(1, "no", "H·y ®Õn")
        return
    end

    if (IsJEMainTaskComplete(2) == 1) and (IsJEMainTaskComplete(3) ~= 1) and (credit >= JECT_LIMIT_CREDIT_2) then

        local nNeedLV = 4
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Ma giíi, chØ cÇn giao nép <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ı!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
            return

        end

    elseif (IsJEMainTaskComplete(1) == 1) and (IsJEMainTaskComplete(2) ~= 1) and (credit >= JECT_LIMIT_CREDIT_1) then

        local nNeedLV = 3
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Ma giíi, chØ cÇn giao nép <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ı!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
            return

        end

    elseif (IsNewBirthComplete() == 1) and (IsJEMainTaskComplete(1) ~= 1) and (credit >= JECT_LIMIT_CREDIT) then

        local nNeedLV = 2
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Ma giíi, chØ cÇn giao nép <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ı!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
            return

        end

    elseif (IsNewBirthComplete() ~= 1) and (credit >= xianmo_UPcredit) then

        local nNeedLV = 1
        local nChangeLV = GetTaskByte(Task_change_credit, 1)
        if (nChangeLV < nNeedLV) then

            local Cname, Cv, Cfs = GetCostCoinInfoByIdx(108)
            local nTotalIB = Cv * aryPayCount[nNeedLV]

            if (checkIBCount(aryPayCount[nNeedLV]) == 1) then

                MsgBox("Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! KÎ thøc thêi míi lµ tuÊn kiÖt, giê nÕu ng­¬i muèn gia nhËp Ma giíi, chØ cÇn giao nép <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta sÏ gióp ng­¬i hoµn thµnh t©m ı!", "changeCreditFin", "no")
                return

            else

                Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã <c=g>" .. floor(nTotalIB / 100) .. "<c>tiÒn ®ång hoÆc<c=g>" .. aryPayCount[nNeedLV] .. "<c> <c=g>§Çu Minh gi¶n<c>, ta ch­a thÓ gióp ng­¬i gia nhËp ®­îc!")
                return

            end

        else

            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
            return

        end

    end

    local nShowCredit = 0
    if (IsJEMainTaskComplete(2) == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 4) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
        else
            nShowCredit = JECT_LIMIT_CREDIT_2
            Talk(2, "no", "Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", "Danh väng Tiªn Ma ®Õn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>§é KiÕp cÊp 70<c>, ta sÏ gióp ng­¬i gia nhËp Ma giíi!")
        end
    elseif (IsJEMainTaskComplete(1) == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 3) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
        else
            nShowCredit = JECT_LIMIT_CREDIT_1
            Talk(2, "no", "Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", "Danh väng Tiªn Ma ®Õn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>L«i §×nh Khëi LiÖt<c>, ta sÏ gióp ng­¬i gia nhËp Ma giíi!")
        end
    elseif (IsNewBirthComplete() == 1) then
        if (GetTaskByte(Task_change_credit, 1) == 2) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
        else
            nShowCredit = JECT_LIMIT_CREDIT
            Talk(2, "no", "Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", "Danh väng Tiªn Ma ®Õn <c=g>" .. nShowCredit .. "<c> ®iÓm, vµ ch­a th«ng qua <c=g>Thiªn KiÕp<c>, ta sÏ gióp ng­¬i gia nhËp Ma giíi!")
        end
    else
        if (GetTaskByte(Task_change_credit, 1) == 1) then
            Talk(1, "no", "NÕu ®· thËt t©m, ta còng kh«ng lµm khã ng­¬i, cã ®iÒu hiÖn danh väng cña ng­¬i qu¸ thÊp, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. H·y ®i rÌn luyÖn n©ng cao danh väng cña m×nh ®i! Ta lu«n dang tay chê ®ãn ng­¬i ®Õn gia nhËp Ma giíi!")
        else
            nShowCredit = xianmo_UPcredit
            Talk(2, "no", "Tiªn giíi giê ®· suy yÕu, thiªn h¹ sím muén g× còng thuéc vÒ Ma giíi chóng ta! Cã ®iÒu hiÖn danh väng cña ng­¬i thÊp qu¸, gia nhËp sÏ khiÕn nhiÒu ng­êi kh«ng phôc. ChØ cÇn ng­¬i t¨ng", "Danh väng Tiªn Ma ®Õn <c=g>" .. nShowCredit .. "c> ®iÓm, vµ th«ng qua <c=g>Trïng Sinh<c><c>, ta sÏ nhËn ng­¬i gia nhËp Ma giíi!<c>")
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

    if (credit < 0) then
        return
    end

    if (IsJEMainTaskComplete(2) == 1) and (IsJEMainTaskComplete(3) ~= 1) and (credit >= JECT_LIMIT_CREDIT_2) then

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
                refreshNpcTaskState()
                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chİnh thøc nhËn ng­¬i lµm chiÕn binh cña Ma giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Ma giíi")
                --> add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                Title_Change(1)
                --< add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                return
            end

        end

    elseif (IsJEMainTaskComplete(1) == 1) and (IsJEMainTaskComplete(2) ~= 1) and (credit >= JECT_LIMIT_CREDIT_1) then

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
                refreshNpcTaskState()

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chİnh thøc nhËn ng­¬i lµm chiÕn binh cña Ma giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Ma giíi")
                --> add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                Title_Change(1)
                --< add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                return

            end

        end

    elseif (IsNewBirthComplete() == 1) and (IsJEMainTaskComplete(1) ~= 1) and (credit >= JECT_LIMIT_CREDIT) then

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
                refreshNpcTaskState()

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chİnh thøc nhËn ng­¬i lµm chiÕn binh cña Ma giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Ma giíi")
                --> add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                Title_Change(1)
                --< add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                return

            end

        end

    elseif (IsNewBirthComplete() ~= 1) and (credit >= xianmo_UPcredit) then

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
                refreshNpcTaskState()

                Talk(1, "no", "Ng­¬i ®· chøng minh ®­îc sù thµnh t©m cña m×nh, ta chİnh thøc nhËn ng­¬i lµm chiÕn binh cña Ma giíi!")
                Msg2Player("B¹n ®· thµnh c«ng gia nhËp Ma giíi")
                --> add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
                Title_Change(1)
                --< add by yangyankun for ³ÆºÅÕóÓª×ª»»ÓÉÏÉ×ªÄ§ at 10-1-21
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

--function  renwu1()
--
--		Talk(1,"no",10147)
--		Msg2Player("µ½Ãç½®³ıµô²İÏÉÆÅÆÅ£¬¶á»Øò¿ÓÈÉñÆ÷µÄËéÆ¬¡£")
--		TaskNote(17,2)
--		SetTask(35,3)
--end;

--function   renwu2()
--	UTask_21 = GetTask(31);
--	if (UTask_21==4) then
--		Talk(1,"no",10148)
--		Msg2Player("¾­¹ı¸ßÃ÷µÄ²é¿´£¬Ô­À´ÕâÖÖ²ÄÁÏÊÇ¹íÃæ¡£Ñ°ÕÒ10¸ö¹íÃæ£¬µ½ºóÍÁÄÇÀï¸²Ãü¼´¿É¡£")
--		TaskNote(14,4)
--		SetTask(31,5)
--	end;
--	if (UTask_21==2) then
--		Talk(1,"no",10149)
--		AddEventItem(29)
--		Msg2Player("ÔÚ¸ßÃ÷²é¿´Ô­ÁÏµÄÊ±¼äÀï£¬ÏÈ°ïËû°ÑÒ»·İÇé±¨ËÍ¸øĞÌÌì¡£")
--		TaskNote(14,2)
--		SetTask(31,3)
--	end;
--end;

function renwu3()

    Talk(1, "no", 10150)
    Msg2Player("ChuÈn bŞ ®Õn Hoang m¹c t×m Hoa Tr­ ®Ó lÊy m¶nh L­u tinh")
    TaskNote(22, 2)
    SetTask(51, 3)
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
        Talk(3, "renwu110_1", "B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng", "Xin tiÒn bèi chØ gi¸o!", "Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trŞ lµm t«n chØ!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 113)
            TaskNote(27, 44)
        elseif (pt == 1) then
            SetTask(1, 113)
            TaskNote(28, 48)
        else
            SetTask(2, 113)
            TaskNote(29, 43)
        end ;
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Knight == 112) or (UTask_Wizard == 112) or (UTask_Druid == 112) then
        Talk(3, "renwu110_2", "B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng", "Xin tiÒn bèi chØ gi¸o!", "Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trŞ lµm t«n chØ!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 114)
        elseif (pt == 1) then
            SetTask(1, 114)
        else
            SetTask(2, 114)
        end ;
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Knight == 114) or (UTask_Wizard == 114) or (UTask_Druid == 114) then
        Talk(3, "no", "Ng­¬i gia nhËp bæn ph¸i, xem ra còng lµ kÎ thøc thêi!", "Kh«ng ngê Linh Quang ®¹i tiªn gi¸ng l©m h¹ giíi l¹i bŞ Giao Long khèng chÕ trªn c« ®¶o. Mong anh hïng khuÊt phôc Giao Long, cøu tho¸t Tiªn nh©n!", "Xin h·y yªn t©m! Ta nhÊt ®Şnh sÏ cøu ®­îc Tiªn nh©n")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 117)
            TaskNote(27, 46)
        elseif (pt == 1) then
            SetTask(1, 117)
            TaskNote(28, 50)
        else
            SetTask(2, 117)
            TaskNote(29, 45)
        end ;
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_Knight == 118) or (UTask_Wizard == 118) or (UTask_Druid == 118) then
        Talk(1, "no", "§a t¹ anh hïng ®· cøu gióp lÇn nµy! Xin tÆng anh hïng x­ng hiÖu vinh dù! Giê nÕu cã thêi gian xin anh hïng h·y ®Õn BÊt Chu Thiªn quan b¸i kiÕn HuyÒn §« §¹i Ph¸p s­, thØnh gi¸o tiªn ®¹o!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 121)
            refreshNpcTaskState()
        elseif (pt == 1) then
            SetTask(1, 121)
            refreshNpcTaskState()
        else
            SetTask(2, 121)
            refreshNpcTaskState()
        end ;

        ActiveTitleFunc(1)--·âÉñ³ÆºÅ×Ê¸ñ

        MainTaskComplete()--Ö÷ÏßÍê³É

        WriteLog("110 chñ tuyÕn")
        AddOwnExp(30000000)--3kw
        Msg2Player("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")

        refreshNpcTaskState()
        --AS GaoJingwei 090813
    elseif (GetTaskByte(Task_LongAgo, 2) == 0) then
        Talk(3, "no", "B¹n trÎ ®Õn ®Ó t×m hiÓu t×nh h×nh Tiªn Ma giíi ph¶i kh«ng", "Xin tiÒn bèi chØ gi¸o!", "Tiªn Ma giíi gåm cã XiÓn gi¸o vµ TriÖt gi¸o. XiÓn gi¸o do Nguyªn ThØ ®øng ®Çu, lÊy tu tiªn gi¶i tho¸t lµm ®¹o. TriÖt gi¸o th× l¹i dùa vµo søc m¹nh cña Phong ThÇn b¶ng, lÊy sù thèng trŞ lµm t«n chØ!")

        SetTaskByte(Task_LongAgo, 2, 1)
        refreshNpcTaskState()
    elseif (GetTaskByte(Task_LongAgo, 2) == 1) then
        Talk(4, "no", "Cao Minh:Ng­êi trÎ tuæi thµnh t©m b¸i m«n tiªn ma m«n chóng ta, xem nh­ còng lµ kÎ thøc thêi. L­ìng gi¸o TiÖt XiÓn thï hËn s©u nÆng, ®Ö tö hai bªn xung ®ét, kh«ng thÓ hµnh sù. Th¸i Th­îng L·o Qu©n biÕt c¸ch gióp ng­êi phµm hoµn thµnh ®¹i nghiÖp Phong ThÇn, ph¸i ®Ö tö Ngò HiÖn Linh Quan h¹ giíi hßa gi¶i.", "Kh«ng ngê Linh Quang ®¹i tiªn gi¸ng l©m h¹ giíi l¹i bŞ Giao Long khèng chÕ trªn c« ®¶o. Mong anh hïng khuÊt phôc Giao Long, cøu tho¸t Tiªn nh©n!", "Xin h·y yªn t©m! Ta nhÊt ®Şnh sÏ cøu ®­îc Tiªn nh©n", "Cao Minh:Ta cÇn ng­¬i gióp, sau khi viÖc hoµn thµnh, ta sÏ tiÕn cö ng­¬i vµo Ma Giíi.")

        SetTaskByte(Task_LongAgo, 2, 2)
        refreshNpcTaskState()
        if (GetPlayerType() == 0) then
            TaskNote(27, 46)
        elseif (GetPlayerType() == 1) then
            TaskNote(28, 50)
        elseif (GetPlayerType() == 2) then
            TaskNote(29, 45)
        end

        refreshNpcTaskState()
    elseif (GetTaskByte(Task_LongAgo, 2) == 3) then
        Talk(2, "no", "Cao Minh:Ngò HiÖn Linh Quan ®o¹t ®ñ hån ph¸ch lµ nhê c«ng cña ng­¬i. Xem biÓu hiÖn cña ng­¬i hiÖn nay, sau nµy ¾t h¼n cã thµnh tùu lín.", "Ta ®· tr×nh b¸o chuyÖn cña ng­¬i lªn Ma Giíi, vµ tÆng ng­¬i danh hiÖu Ma Giíi, tõ giê ng­¬i ®· lµ thµnh viªn cña Ma Giíi chóng ta. Ngµy sau ®Õn BÊt Chu Thiªn Quan b¸i kiÕn HuyÒn §« §¹i Ph¸p S­, «ng Êy sÏ dÉn ng­¬i b¾t ®Çu hµnh tr×nh Ma Giíi.")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 121)
            refreshNpcTaskState()
            TaskNote(27, 48)
        elseif (pt == 1) then
            SetTask(1, 121)
            refreshNpcTaskState()
            TaskNote(28, 52)
        else
            SetTask(2, 121)
            refreshNpcTaskState()
            TaskNote(29, 47)
        end ;

        SetTaskByte(Task_LongAgo, 2, 4)
        refreshNpcTaskState()
        ActiveTitleFunc(1)--·âÉñ³ÆºÅ×Ê¸ñ
        MainTaskComplete()--Ö÷ÏßÍê³É
        WriteLog("110 chñ tuyÕn")

        AddOwnExp(30000000)--3kw
        ChangeJusticEvilCredit(-500)        --¼Ó500ÉùÍû

        Msg2Player("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")
        TopMessage("B¹n nhËn ®­îc t­ c¸ch X­ng hiÖu vµ 3 ngh×n v¹n kinh nghiÖm")

        refreshNpcTaskState()
        --AE GaoJingwei 090813
    end
end

function renwu110_1()
    Talk(2, "no", "Ta phông mÖnh thiªn th­îng tiÕp dÉn c¸c ®Ö tö Ma giíi. Ng­¬i cã khã kh¨n g× cø ®Õn t×m ta!", " §a t¹ ®· chØ ®iÓm! (§i t×m Xİch Tinh Tö tr­íc ®·, råi míi quyÕt ®Şnh)")
end

function renwu110_2()
    Talk(2, "no", "Ta phông mÖnh thiªn th­îng tiÕp dÉn c¸c ®Ö tö Ma giíi. Ng­¬i cã khã kh¨n g× cø ®Õn t×m ta!", " §a t¹ ®· chØ ®iÓm!")
end

function faery_info()
    --½ÓÁËÏÉÈÎÎñÈ¥ÕÒÄ§µÄ½éÉÜ
    Talk(1, "no", "Ng­¬i mÆc dï ®· lÇm lÉn gia nhËp Tiªn giíi, nh­ng ta vÉn s½n sµng h­íng dÉn ng­¬i ®i vÒ Ma ®¹o. Cã ®iÒu hiÖn ng­¬i ®ang tiÕp nhËn kh¶o nghiÖm <c=g>Tu Tiªn ®¹o<c>, NÕu muèn gia nhËp Ma giíi th× ph¶i tÈy röa hÕt tµn d­ cña Tiªn ph¸i ®·!")
end

function faery()
    --Ä§½çÉùÍû
    local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
    if (credit <= -1 * xianmo_UPcredit) then
        Talk(1, "no", "Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Lµ thµnh hay b¹i lµ cßn tuú ë ng­¬i vËy!")
        return 0
    end
    local lastday = GetTaskByte(Task_xianmo_renwu, 1)
    local today = mod(floor(LocalSystemTime() / 86400), 256)
    local times = GetTaskByte(Task_xianmo_renwu, 2)
    if (credit >= 0) then
        --ÏÉ½ç
        if (lastday ~= today) then
            MsgBox("Ng­¬i mÆc dï ®· lÇm lÉn gia nhËp Tiªn giíi, nh­ng ta vÉn s½n sµng h­íng dÉn ng­¬i ®i vÒ Ma ®¹o. Nh­ng tr­íc tiªn <c=g>Danh väng Tiªn Ma ph¶i ®­îc tÈy s¹ch hÕt<c> ®·. §ång thêi ph¶i ®ãng gãp cho bæn giíi 20 v¹n l­îng ®Ó ®óc t¹o ma khİ nhËp m«n. Sao h¶!", "faery_yes", "no")
        elseif (times < xianmo_UPtimes) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
            MsgBox("MÆc dï ng­¬i ®ang lµ Tiªn nh©n, nh­ng ta vÉn s½n sµng ®ãn tiÕp ng­¬i gia nh©p Ma giíi. C¬ héi kh¶o nghiÖm cã h¹n. NÕu ng­¬i ®­a ta <c=g>Tu Th©n QuyÕt<c> hoÆc <c=g>" .. Cfs .. "tiÒn §ång<c>, ta sÏ cho ng­¬i c¬ héi kh¶o nghiÖm gia nhËp. §ång thêi ph¶i ñng hé thªm cho bæn giíi 20 v¹n l­îng ®Ó ®óc luyÖn Ma khİ. Ng­¬i cã muèn tiÕn hµnh kh¶o nghiÖm ch­a?", "faery_coin_yes", "no")
        else
            Talk(1, "no", "Kh¶o nghiÖm Ma ®¹o h«m nay t¹m kÕt thóc, nh­ng d­ ©m Tiªn giíi cña ng­¬i vÉn cßn, sÏ ph¶i tÈy hÕt Danh väng Tiªn Ma giíi vÒ 0. NÕu cø kiªn tr× nh­ vËy, gia nhËp hµng ngò Ma giíi chØ lµ vÊn ®Ò thêi gian!")
        end
    else
        --Ä§½ç
        if (lastday ~= today) then
            MsgBox("C¸c chiÕn binh tö trËn trong cuéc chiÕn nµy hån ph¸ch ®Òu bŞ l­u gi÷ ë Khæn Tiªn Cung. NÕu ng­¬i cã thÓ siªu ®é cho c¸c hån ph¸ch ®ã, Danh väng sÏ cã chót biÕn chuyÓn. §ång thêi ph¶i ®ãng gãp cho bæn giíi 10 v¹n l­îng ®Ó ®óc t¹o Ma khİ nhËp m«n. Sao h¶!", "faery1_yes", "no")
        elseif (times < xianmo_UPtimes) then
            local _, Cv, Cfs = GetCostCoinInfoByIdx(93)
            MsgBox("Bæn giíi mÆc dï chØ thu nhËn DŞ nh©n, nh­ng còng t¹o c¬ héi cho c¸c hÖ kh¸c gia nhËp. ChØ cÇn ng­¬i cã <c=g>Tu Th©n QuyÕt<c> hoÆc <c=g>" .. Cfs .. " tiÒn §ång<c>, ta sÏ cho ng­¬i c¬ héi nhËp giíi. §ång thêi ph¶i ñng hé thªm cho bæn giíi 10 v¹n l­îng ®Ó ®óc luyÖn Ma khİ. Sao h¶!", "faery1_coin_yes", "no")
        else
            Talk(1, "no", "Kh¶o nghiÖm Ma ®¹o ®· kÕt thóc. Danh väng Ma giíi cña ng­¬i còng ®· cã chót biÕn chuyÓn, cø kiªn tr× nh­ vËy, uy chÊn Tiªn ma l­ìng giíi sÏ kh«ng cßn xa!")
        end
    end
end

function faery_yes()
    if (GetCash() >= 200000) then
        local lastday = GetTaskByte(Task_xianmo_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(Task_xianmo_renwu, 2) + 1

        if (lastday ~= today) then
            SetTask(Task_xianmo_renwu, today)
            times = 1
        end
        SetTaskByte(Task_xianmo_renwu, 2, times)
        refreshNpcTaskState()
        Pay(200000)--20w

        local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
        local key = faery_set(credit) --Ö¸¶¨¹ÖÎï
        AddNormalItem(6, 1, 411, 0, 0, 0)
        AddNormalItem(6, 1, 413, 0, 0, 0)
        Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. times .. " Kh¶o nghiÖm Ma giíi, m·u mau ®Õn Khæn Tiªn Cung, siªu ®é cho c¸c hån ph¸ch Ma chóng vÒ trêi!")
        TaskNote(91, 0, azimuth[key])

        if (times < xianmo_UPtimes) then
            SyncBibleState(91, 2, 1)
        else
            SyncBibleState(91, 3, 1)
        end ;
        Talk(1, "no", "H«m nay ®©y lµ nhiÖm vô lÇn thø" .. times .. " Kh¶o nghiÖm Ma giíi, giê h·y lËp tøc ®Õn Khæn Tiªn Cung, t¹i <c=g>" .. azimuth[key] .. " <c> sö dông <c=g>Gi¸ng Ma Kim T¸n<c> lËp Gi¸ng Ma chó trËn, ®îi sau khi ®· hµng phôc ®ñ c¸c hån ph¸ch ma vËt xung quanh th× dïng <c=g>Ngù Ph¸ch ch©u<c> dÉn ®é chóng vÒ gÆp §¹i phu tÇng nµy!")
        return 1
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ 20 v¹n, kh«ng thÓ chÕ t¹o Ma khİ cho ng­¬i tu luyÖn ®­îc.")
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
        Msg2Player("Giao 1 Tu Th©n QuyÕt cho Cao Minh")
    elseif (GetCoin() >= Cv) then
        if (faery_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(93)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. " tiÒn §ång cho Cao Minh")
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ tiÒn §ång, kh«ng thÓ gia nhËp Ma giíi!")
    end
end

function faery_set(credit_val)
    item_faery = {--ÉùÍûÏÂÏŞ ÉÏÏŞ µØÍ¼idx ³õÊ¼Öµ Ôö³¤ÏµÊı(10±¶)
        [1] = { -6000, 1000, 47, 0, 25 },
        [2] = { 1001, 2000, 48, 0, 25 },
        [3] = { 2001, 3000, 49, 0, 25 },
        [4] = { 3001, 4000, 50, 0, 25 },
        [5] = { 4001, 6000, 51, 0, 25 },
    }
    local temp1 = 0
    for i = 1, 5 do
        temp1 = item_faery[i]
        if (credit_val >= temp1[1]) and (credit_val <= temp1[2]) then
            SetTaskByte(Task_xianmo_renwu, 3, temp1[3])--µØÍ¼id
            SetTaskByte(Task_xianmo_renwu, 4, 2)--½ÓÄ§
            SetTask(Task_xianmo_npc, 0)
            SetTaskByte(Task_xianmo_npc, 2, temp1[4])
            SetTaskByte(Task_xianmo_npc, 3, temp1[5])
            refreshNpcTaskState()
            return i
        end
    end

    --³ö´í²Å»á×ßµ½ÒÔÏÂ
    SetTaskByte(Task_xianmo_renwu, 3, item_faery[1][3])  --À¦Ò»
    SetTaskByte(Task_xianmo_renwu, 4, 2)--½ÓÄ§
    SetTask(Task_xianmo_npc, 0)
    SetTaskByte(Task_xianmo_npc, 2, item_faery[1][4])
    SetTaskByte(Task_xianmo_npc, 3, item_faery[1][5])
    refreshNpcTaskState()
    return 0
end

function faery1_yes()
    if (GetCash() >= 100000) then
        local lastday = GetTaskByte(Task_xianmo_renwu, 1)
        local today = mod(floor(LocalSystemTime() / 86400), 256)
        local times = GetTaskByte(Task_xianmo_renwu, 2) + 1

        if (lastday ~= today) then
            SetTask(Task_xianmo_renwu, today)
            refreshNpcTaskState()
            times = 1
        end
        SetTaskByte(Task_xianmo_renwu, 2, times)
        refreshNpcTaskState()
        Pay(100000)--10w

        local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
        local key = faery_set(abs(credit)) --Ö¸¶¨¹ÖÎï
        AddNormalItem(6, 1, 411, 0, 0, 0)
        AddNormalItem(6, 1, 413, 0, 0, 0)

        Msg2Player("§©y lµ lÇn nhËn nhiÖm vô thø" .. times .. " Kh¶o nghiÖm Ma giíi, m·u mau ®Õn Khæn Tiªn Cung, siªu ®é cho c¸c hån ph¸ch Ma chóng vÒ trêi!")
        TaskNote(91, 0, azimuth[key])

        if (times < xianmo_UPtimes) then
            SyncBibleState(91, 2, 1)
        else
            SyncBibleState(91, 3, 1)
        end ;
        Talk(1, "no", "H«m nay ®©y lµ nhiÖm vô lÇn thø" .. times .. " Kh¶o nghiÖm Ma giíi, giê h·y lËp tøc ®Õn Khæn Tiªn Cung, t¹i <c=g>" .. azimuth[key] .. " <c> sö dông <c=g>Gi¸ng Ma Kim T¸n<c> lËp Gi¸ng Ma chó trËn, ®îi sau khi ®· hµng phôc ®ñ c¸c hån ph¸ch ma vËt xung quanh th× dïng <c=g>Ngù Ph¸ch ch©u<c> dÉn ®é chóng vÒ gÆp §¹i phu tÇng nµy!")
        return 1
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ 10 v¹n, kh«ng thÓ chÕ t¹o Ma khİ cho ng­¬i tu luyÖn ®­îc.")
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
        Msg2Player("Giao 1 Tu Th©n QuyÕt cho Cao Minh")
    elseif (GetCoin() >= Cv) then
        if (faery1_yes() ~= 1) then
            return 0
        end

        CostCoinByIdx(93)
        Msg2Player("B¹n giao ®­îc" .. Cfs .. " tiÒn §ång cho Cao Minh")
    else
        Talk(1, "no", "Ng¹i qu¸! Ng­¬i kh«ng ®ñ tiÒn §ång, kh«ng thÓ gia nhËp Ma giíi!")
    end
end

function faery_cancel()
    MsgBox("Xem ra ng­¬i ®· cã vÎ n¶n chİ! X¸c ®Şnh huû nhiÖm vô NhËp ma ph¸p m«n lÇn nµy ­?", "cancel_faery", "no")
end

function cancel_faery()
    CloseDialog()
    SetTaskByte(Task_xianmo_renwu, 3, 0)
    SetTaskByte(Task_xianmo_renwu, 4, 0)
    SetTask(Task_xianmo_npc, 0)
    RemoveIBBuff(493)
    RemoveIBBuff(494)
    ClearItem(6, 1, 411, 0)--¾Û»êÁéá¦
    ClearItem(6, 1, 413, 0)--Ô¦»êÏã
    SetTask(Task_xianmo_npcID, 0)
    SetTask(Task_xianmo_npcIndex, 0)
    refreshNpcTaskState()
    TaskNote(91, -1)

    Msg2Player("B¹n ®· huû nhiÖm vô NhËp ma ph¸p m«n lÇn nµy!")
end

function faery_complete()
    CloseDialog()
    if (GetTaskByte(Task_xianmo_renwu, 4) == 10) then
        SetTaskWord(Task_xianmo_renwu, 2, 0)--log¸Ä°æ
        RemoveIBBuff(493)
        RemoveIBBuff(494)
        SetTask(Task_xianmo_npc, 0)
        SetTask(Task_xianmo_npcID, 0)
        SetTask(Task_xianmo_npcIndex, 0)
        refreshNpcTaskState()
        TaskNote(91, -1)
        local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
        local temp = -60
        local str = "Kh¶o nhiÖm nhËp m«n gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! Danh väng cña ng­¬i ®· t¨ng thªm <c=g>60<c> ®iÓm. Cø kiªn tr× nh­ vËy, uy chÊn Tiªn ma l­ìng giíi sÏ kh«ng cßn xa!"

        if (credit > 0) then
            temp = temp * 4
        end

        if (credit <= -1 * xianmo_UPcredit) then
            Talk(1, "no", "Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Lµ thµnh hay b¹i lµ cßn tuú ë ng­¬i vËy!")
            return 0
        elseif (credit < -1 * xianmo_UPcredit + 60) then
            temp = -1 * xianmo_UPcredit - credit
            str = "Kh¶o nhiÖm nhËp m«n gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! Danh väng cña ng­¬i ®· t¨ng thªm <c=g>" .. abs(temp) .. "<c> ®iÓm! H·y tiÕp tôc nç lùc nhĞ!"
        elseif (credit >= 0) and (credit <= temp) then
            local showtemp = temp
            temp = temp - 500--¶îÍâ
            str = "Kh¶o nhiÖm nhËp m«n gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng, bæn giíi ®· cã thªm 1 nh©n tµi! LÇn nµy ng­¬i ngoµi viÖc nhËn ®­îc <c=g>" .. showtemp .. "<c> ®iÓm danh väng, ta cßn th­ëng thªm <c=g>500 ®iÓm<c> danh väng n÷a! H·y tiÕp tôc nç lùc nhĞ!"
        elseif (credit > temp) then
            str = "Kh¶o nhiÖm nhËp m«n gian khæ nh­ vËy mµ ng­¬i ®· v­ît qua dÔ dµng. Danh väng Ma giíi cña ng­¬i ®· t¨ng <c=g>" .. temp .. "<c> ®iÓm. H·y nç lùc thªm nhĞ!"
        end

        ChangeJusticEvilCredit(temp)

        Msg2Player("B¹n ®· hoµn thµnh nhiÖm vô NhËp ma ph¸p m«n lÇn nµy")
        Talk(1, "no", str)

        if (IsWorldEventExist(1) == 1) then
            if (GetWorldEventProgress(1) <= 4) and (credit < 0) then
                --songlei by 2009.9.10
                WorldEventrenwu()--ÊÀ½ç¿ªÆôÈÎÎñ
            end
        end
    end
end

function WorldEventrenwu()
    --ÊÀ½ç¿ªÆôÈÎÎñ
    local times = GetWorldEventValue(1, 5) + 1
    if (times < 1500) then
        local key = mod(times, 150)
        if (GetWorldEventProgress(1) == 4) and (key == 0) then
            --songlei by 2009.9.10
            AddGlobalCountNews("Anh hïng <c=yel>" .. GetName() .. "<c> hoµn thµnh nhiÖm vô danh väng lÇn thø <c=yel>" .. times .. "<c>, gióp Linh Quan håi phôc linh lùc, hy väng c¸c anh hïng tiÕp tôc nç lùc!")
            WriteLog("Hoµn thµnh" .. times .. ".")
        end
        SetWorldEventValue(1, 5, times)
    elseif (GetWorldEventProgress(1) == 4) and (times == 1500) then
        --songlei by 2009.9.10
        SetWorldEventValue(1, 5, 1501)
        SetWorldEventProgress(1, 5)
        AddGlobalCountNews("Anh hïng <c=yel>" .. GetName() .. "<c>. Hoµn thµnh nhiÖm vô danh väng lÇn thø<c=yel>1500<c>, Ngò HiÖn Linh Quan ®· håi phôc linh lùc, cã thÓ ®Õn Diªu Tr× t×m «ng Êy tim hiÓu t×nh h×nh Tiªn Ma giíi")
        WriteLog("Hoµn thµnh 1500 lÇn nhiÖm vô Danh väng")
    end
end

function renwu120()
    CloseDialog()
    local UTask_Wizard = GetTask(1)
    local UTask_Knight = GetTask(3)
    local UTask_Druid = GetTask(2)

    if (UTask_Knight == 122) or (UTask_Wizard == 122) or (UTask_Druid == 122) then
        Talk(3, "no", "Ng­¬i ®i chuyÕn nµy thuËn lîi chø?", " LÇn nµy xem nh­ thuËn lîi. §­îc HuyÒn §« §¹i Ph¸p s­ chØ ®iÓm khiÕn ®Ö tö më tÇm m¾t!", "VËy tèt l¾m! Mãn vò khİ nµy lµ phÇn cña ng­¬i. T­¬ng lai trong Tiªn Ma giíi lµ do ng­¬i tù quyÕt ®Şnh! Cè g¾ng nhĞ!")
        local pt = GetPlayerType()
        if (pt == 0) then
            SetTask(3, 130)
            refreshNpcTaskState()
            TaskNote(27, 52)
            if (random(1, 2) == 1) then
                AddBlueEquip(0, 0, 35, 1, 0, 0, 1)--1¼¶À¶ÎäÆ÷
            else
                AddBlueEquip(0, 0, 62, 1, 0, 0, 1)--1¼¶À¶ÎäÆ÷
            end
        elseif (pt == 1) then
            SetTask(1, 130)
            TaskNote(28, 56)
            refreshNpcTaskState()
            AddBlueEquip(0, 0, 36, 1, 0, 0, 1)--1¼¶À¶ÎäÆ÷
        else
            SetTask(2, 130)
            refreshNpcTaskState()
            TaskNote(29, 51)
            AddBlueEquip(0, 0, 37, 1, 0, 0, 1)--1¼¶À¶ÎäÆ÷
        end ;

        Msg2Player("B¹n nhËn ®­îc 1 mãn binh khİ!")
        TopMessage("B¹n nhËn ®­îc 1 mãn vò khİ Tiªn Ma giíi")
        WriteLog("120 chñ tuyÕn")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

function tofaery()
    local credit = GetJusticEvilCredit() --»ñµÃÉùÍû
    if (credit <= -1 * xianmo_UPcredit) then
        if (GetTaskByte(Task_faery_renwu, 2) == 0) then
            SetTaskByte(Task_faery_renwu, 2, 1)
            refreshNpcTaskState()
        end

        local Proglvl = GetWorldEventProgress(1)
        if (Proglvl < 3) then
            Talk(1, "no", "Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Danh väng cña ng­¬i còng ®· truyÒn ®Õn Ma giíi, vèn ng­¬i ®· cã thÓ th«ng qua Nam Thiªn m«n ®Ó vµo Thiªn Th­îng Nh©n Gian, nh­ng nghe ®©u vŞ tiªn nh©n gi÷ cæng nµy ®ang bŞ v©y khèn ë Tam Tiªn ®¶o. Ng­¬i h·y ®Õn ®¶o ®ã t×m §¹i phu xem cã ®óng vËy kh«ng!")
        elseif (Proglvl < 6) then
            Talk(1, "no", "Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Danh väng cña ng­¬i còng ®· truyÒn ®Õn Ma giíi, vèn ng­¬i ®· cã thÓ th«ng qua Nam Thiªn m«n ®Ó vµo Thiªn Th­îng Nh©n Gian, nh­ng ta nghe nãi muèn ®i qua ®ã ph¶i qua kh¶o nghiÖm. Ng­¬i h·y ®Õn Diªu Tr× gÆp Ngò HiÖn Linh Quang hái râ xem sao!")
        else
            Talk(1, "no", "Ph¸p m«n Ma thuËt ta ®Òu ®· truyÒn thô cho ng­¬i hÕt råi! Danh väng cña ng­¬i còng ®· truyÒn ®Õn Ma giíi. Giê nÕu nh­ c¸nh cña th«ng qua <c=g>Thiªn Th­îng Nh©n Gian<c> ®· më, ng­¬i cã thÓ ®Õn <c=g>Nam Thiªn m«n ë Diªu Tr×<c> ®Ó vµo Tiªn Ma giíi")
        end
    else
        Talk(1, "no", "NÕu muèn ho¸ thµnh Ma chóng trùc tiÕp vµo Thiªn Th­îng Nh©n Gian, cÇn cã chót danh tiÕng t¹i Nh©n giíi (§¼ng cÊp Nh©n giíi ®¹t 121), vµ Danh väng Ma giíi ph¶i ®¹t ®Õn 5000 ®iÓm. Cã thÓ ®Õn <c=g>Nam Thiªn m«n ë Diªu Tr×<c> ®Ó vµo Tiªn Ma giíi!")
    end
end

function opensale()
    CloseDialog()
    OpenMonsterSale(35)
end

----------------------------ÁìÈ¡³ÆºÅ------------------------------------------
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

    if (curtitle == 1 and GetJusticEvilCredit() > 0) then
        return 0
    end

    for i = 1, getn(titletab) do
        if (HaveQualify(titletab[i].titleid) == 1 and titletab[i].titleid ~= curtitle) then
            if (titletab[i].titlecamp ~= 1) then
                nNum = nNum + 1
            elseif (titletab[i].titlecamp == 1 and curtitle == 2) then
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
        local result1 = notitle()            --Ö´ĞĞÖ±½Ó»ñÈ¡£¬µ±Ç°Î´Ğ¯´øÈÎºÎ³ÆºÅ
        return result1
    end

    if (iscamptitle() == 1) then

        -- add by mayining 2009.2.2
        -- autoFixJECredit()		-- ×Ô¶¯ĞŞÕı´íÂÒÊı¾İ
        -- end by mayining

        local result2 = havecamptitle()     --Ö´ĞĞÖ±½Ó»ñÈ¡£¬µ±Ç°Ğ¯´ø³ÆºÅÎªÕóÓª³ÆºÅ
        return result2
    end

    if (notcamptitle() == 1) then
        local result3 = havenocamptitle()   --Ö´ĞĞÑ¡Ôñ»ñÈ¡£¬Ñ¡ÔñÁìÈ¡ÕóÓª³ÆºÅ
        return result3
    end
end

-- add by mayining 2009.2.2
-- ÓÉÓÚĞŞÕıÍâÍøÒòÄ§ÉùÍûÒâÍâ×ª³ÉÏÉÎÊÌâÔì³ÉµÄÊı¾İ´íÂÒ, ¼ì²éµ±Íæ¼ÒÊÇÄ§³ÆºÅ, µ«ÊÇÏÉÉùÍû²¢ÔÚ4500ÒÔÉÏ, ÄÇÃ´×Ô¶¯ĞŞÕı³ÉÄ§ÉùÍû
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
-- end by mayining

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
        Say(" Nh÷ng cèng hiÕn cña ng­¬i ®· ®­îc Ma giíi ghi nhËn, cã thÓ lùa chän 1 X­ng hiÖu cho m×nh, ®ã lµ minh chøng cho nh÷ng nç lùc cña ng­¬i!", getn(navigation), navigation)
    end
end

--ÅĞ¶ÏÊÇ·ñµ±Ç°Î´Ğ¯´øÈÎºÎ³ÆºÅ
--·µ»Ø1Îªµ±Ç°Ã»ÓĞ³ÆºÅ
--·µ»Ø0Îªµ±Ç°ÓĞ³ÆºÅ
function isnotitle()
    local curtitle = GetCurTitle()
    if (curtitle == 0) then
        return 1
    end
    return 0
end

--ÅĞ¶Ïµ±Ç°³ÆºÅÊÇ·ñÎªÕóÓª³ÆºÅ
function iscamptitle()
    local curtitle = GetCurTitle()

    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin
    for i = 2, getn(titletab) do
        if (curtitle == titletab[i].titleid) then
            return 1
        end
    end
    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ end

    return 0
end

--ÅĞ¶Ïµ±Ç°³ÆºÅÎª·ÇÕóÓª³ÆºÅ
function notcamptitle()
    local curtitle = GetCurTitle()

    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin
    if (curtitle ~= 0) then
        for i = 2, getn(titletab) do
            if (curtitle == titletab[i].titleid) then
                return 0
            end
        end
    end
    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ end

    return 1
end
--Ö±½Ó»ñÈ¡ Î´Ğ¯´ø ÈÎºÎ³ÆºÅ
function notitle()

    local curtitle = GetCurTitle()

    if (curtitle ~= 0) then
        return 0
    end

    local nIdx = canhavecamptitle()
    if (nIdx ~= 0) then

        --add by mayining 2008.10.16
        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)
        --end

        ActiveTitleQualify(titletab[nIdx].titleid)
        SetCurTitle(titletab[nIdx].titleid)
        Talk(1, "no", "Nh÷ng cèng hiÕn cña ng­¬i ®· ®­îc Ma giíi ghi nhËn. Ta tÆng cho ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>! Cuéc chiÕn nµy sÏ cßn kĞo dµi ch­a døt, hy väng ng­¬i sÏ gãp søc gióp Ma giíi b×nh gi¶i ®­îc cuéc chiÕn nµy!")
        return 1
    end

    return 0
end


--Ö±½Ó»ñÈ¡ Ğ¯´øÕóÓª³ÆºÅ
function havecamptitle()

    local curtitle = GetCurTitle()
    local curextype = getextype()

    if (iscamptitle() == 1) then
        --Èç¹ûĞ¯´øÁËÕóÓª³ÆºÅ
        local nIdx = canhavecamptitle()

        if (nIdx == 0) then
            return 0
        end

        if (curtitle == titletab[nIdx].titleid) then
            return 0
        end

        --µ±Ç°×îĞÂÄÜÊ¹ÓÃµÄ³ÆºÅ²»ÊÇµ±Ç°µÄ³ÆºÅ
        local curtitlecamp = getsomeidtype(curtitle)
        if (curtitlecamp == titletab[nIdx].titlecamp and curtitlecamp == 2) then
            for i = 2, 9 do
                UnActiveTitleQualify(titletab[i].titleid)
            end
            ActiveTitleQualify(titletab[nIdx].titleid)
            SetCurTitle(titletab[nIdx].titleid)

            --add by mayining 2008.10.16
            AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)
            --end

            if (curtitle > titletab[nIdx].titleid) then
                Talk(1, "no", "Ma giíi v× sî ng­¬i th¨ng tiÕn qu¸ nhanh sÏ h¸o th¾ng mµ g©y nhiÒu tæn h¹i cho bæn giíi. Ta cùc ch¼ng ®· ®µnh ph¶i gi¸ng x­ng hiÖu cña ng­¬i xuèng lµ <c=g>" .. titletab[nIdx].titlename .. "<c>. Ng­¬i ®õng n¶n chİ, h·y tiÕp tôc lËp c«ng, chøng minh n¨ng lùc!")
            else
                Talk(1, "no", "Ng­¬i v­ît qua giai ®o¹n Kh¶o nghiÖm ma ®¹o nhanh h¬n ta t­ëng, ®Ó khİch lÖ bæn giíi tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>. Hy väng ng­¬i tiÕp tôc ph¸t huy, mang vinh quang vÒ cho Ma giíi!")
            end
            return 1
        end

        if (curtitlecamp ~= titletab[nIdx].titlecamp and curtitlecamp == 1) then
            for i = 2, 9 do
                UnActiveTitleQualify(titletab[i].titleid)
            end
            ActiveTitleQualify(titletab[nIdx].titleid)
            SetCurTitle(titletab[nIdx].titleid)

            --add by mayining 2008.10.16
            AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)
            --end

            Talk(1, "no", "Chóc mõng! Ng­¬i ®· hoµn toµn tho¸t khái Tiªn giíi, ®Ó biÓu d­¬ng ng­¬i lµm r¹ng danh Ma giíi, ta tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>Hy väng trong kú kh¶o nghiÖm sau ng­¬i sÏ kh«ng lµm bæn giíi thÊt väng!")
            return 1
        end
    end
    return 0
end

--Ñ¡Ôñ»ñÈ¡ Ğ¯´ø·ÇÕóÓª³ÆºÅ
function havenocamptitle()
    local curtitle = GetCurTitle()
    local nIdx = canhavecamptitle()
    --µ±Ç°³ÆºÅÎª·ÇÕóÓª³ÆºÅ

    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin
    if (notcamptitle() == 0) then
        --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin

        return 0
    end

    if (nIdx == 0) then
        return 0
    end

    if (titletab[nIdx].titlecamp == 1) then
        return 0
    end

    if (HaveQualify(titletab[nIdx].titleid) == 0) then
        --Ã»ÓĞ×Ê¸ñ
        MsgBox("Nh÷ng cèng hiÕn cña ng­¬i ®Òu ®­îc Ma giíi ghi nhËn, ta vèn muèn tÆng ng­¬i X­ng hiÖu <c=g>" .. titletab[nIdx].titlename .. "<c>, nh­ng hiÖn t¹i ng­¬i ®· cã X­ng hiÖu kh¸c, cã muèn ®æi kh«ng? NhÊp \"È·¶¨\" sÏ lËp tøc thay ®æi X­ng hiÖu cña bæn giíi. nÕu \"È¡Ïû\" h«m kh¸c cã thÓ quay l¹i l·nh nhËn.", "yes_change", "no_keep")
        return 1
    end
    return 0
end

--»ñÈ¡ÏÉÄ§ÕóÓªÀàĞÍ
function getextype()
    local exglory = GetJusticEvilCredit()
    if (exglory > 0) then
        return 1
    elseif (exglory < 0) then
        return 2
    end
end

--»ñÈ¡Ä³Ò»¸öidµÄÕóÓªÀàĞÍ
function getsomeidtype(id)
    for i = 1, getn(titletab) do
        if (titletab[i].titleid == id) then
            return titletab[i].titlecamp
        end
    end
    return 0
end

function canhavecamptitle()
    local exglory = GetJusticEvilCredit()      --ÏÉÄ§ÉùÍû
    local extype = getextype()                --ÏÉÄ§ÕóÓª
    local level = GetLevel()               --ÈË¼ä½çµÈ¼¶
    local exlevel = GetPlayerExtLevel()      --ÏÉÄ§µÈ¼¶
    local nIdx = 0
    if (extype == 1) then
        --ÎªÏÉ
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
        --ÎªÄ§
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

    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin
    if (notcamptitle() == 1 and nIdx > 1 and nIdx <= getn(titletab)) then
        --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ end

        for i = 2, 9 do
            UnActiveTitleQualify(titletab[i].titleid)
        end
        ActiveTitleQualify(titletab[nIdx].titleid)
        SetCurTitle(titletab[nIdx].titleid)

        --add by mayining 2008.10.16
        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)
        --end

    end
end

function no_keep()
    CloseDialog()
    local curtitle = GetCurTitle()
    local nIdx = canhavecamptitle()

    --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ begin
    if (notcamptitle() == 1 and nIdx > 1 and nIdx < getn(titletab)) then
        --Add By GaoJingwei at for bugfsb00014649 ³ÆºÅ»ñµÃ end

        for i = 2, 9 do
            UnActiveTitleQualify(titletab[i].titleid)
        end
        ActiveTitleQualify(titletab[nIdx].titleid)

        --add by mayining 2008.10.16
        AddEvent("%s nhËn ®­îc x­ng hiÖu [" .. (titletab[nIdx].titlename) .. "]!", 1)
        --end

    end
end

function get1()
    CloseDialog()
    ActiveTitleQualify(titletab[1].titleid)
    SetCurTitle(titletab[1].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Anh hïng c¸i thÕ<c>")
end

function get5()
    CloseDialog()
    ActiveTitleQualify(titletab[5].titleid)
    SetCurTitle(titletab[5].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Ma U Sø<c>")
end

function get6()
    CloseDialog()
    ActiveTitleQualify(titletab[6].titleid)
    SetCurTitle(titletab[6].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>Tiªn LuyÖn S­<c>")
end

function get7()
    CloseDialog()
    ActiveTitleQualify(titletab[7].titleid)
    SetCurTitle(titletab[7].titleid)
    TopMessage("B¹n ®· nhËn ®­îc X­ng hiÖu <c=g>D¹ Du Ma<c>")
end

function get9()
    CloseDialog()
    ActiveTitleQualify(titletab[9].titleid)
    SetCurTitle(titletab[9].titleid)
    TopMessage("B¹n nhËn ®­îc danh xung<c=g>HuyÒn Vùc Ma<c>")
end

--> add by yangyankun for ÏÉÄ§³ÆºÅ×ª»» at 10-1-21
-- ÏÉÄ§³ÆºÅĞÅÏ¢±í ³É¶Ô³öÏÖ Ò»Ò»¶ÔÓ¦
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
-- srcCamp Ô­Ê¼ÕóÓª 1 ÏÉ 2 Ä§
function Title_Change(srcCamp)
    no()
    local desCamp = 0    -- Ä¿±êÕóÓª
    if (srcCamp == 1) then
        desCamp = 2
    elseif (srcCamp == 2) then
        desCamp = 1
    end

    if (desCamp > 0) then
        for i = 1, getn(gTitleCampInfo) do
            local titleSubInfo = gTitleCampInfo[i]
            if (HaveQualify(titleSubInfo[srcCamp].titleID) > 0) then
                -- Èç¹ûÓĞ×Ê¸ñ
                if (GetCurTitle() == titleSubInfo[srcCamp].titleID) then
                    -- Èç¹ûÊÇµ±Ç°³ÆºÅ
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
--< add by yangyankun for ÏÉÄ§³ÆºÅ×ª»» at 10-1-21