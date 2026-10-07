NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

Task_Xitie = 1628

Task_MarryState = 800

Task_Partner = 801
JiehunItem = {
    [1] = { name = "ThiÖp mõng", Item = { 3, 1068, 0, 0, 0, 0 } },
    [2] = { name = "Tói quµ 10 ThiÖp mõng", Item = { 6, 1, 777, 0, 0, 0 } },
    [3] = { name = "ThiÖp mêi", Item = { 3, 1067, 0, 0, 0, 0 } },
}

NpcName = { "Trô V­¬ng", "§¾c Kû", "NguyÖt L·o", "Vâ V­¬ng", "ThÓ V©n" }

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
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 40) or (taskWizard == 40) or (taskDruid == 40) then
                state = 1
                subState = 0
            end
        else
            if (taskKnight == 40) or (taskWizard == 40) or (taskDruid == 40) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 75
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if ((taskKnight == 60) and (HaveEventItem(13) >= 1)) or ((taskWizard == 60) and (HaveEventItem(2) >= 1)) or ((taskDruid == 60) and (HaveEventItem(19) >= 1)) then
                state = 1
                subState = 0
            end
        else
            if ((taskKnight == 60) and (HaveEventItem(13) >= 1)) or ((taskWizard == 60) and (HaveEventItem(2) >= 1)) or ((taskDruid == 60) and (HaveEventItem(19) >= 1)) then
                state = 1
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

Task_Get_Fragment = 1520
Task_Get_Fragment1 = 1524
Task_Tong_Fragment = 11
Task_Tong_Fragment1 = 12
Task_Tong_Fragment2 = 13
Global_Fragment = 245
Global_Fragment_Num = 246

function main()
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);

    tasks = {
        { "B×nh An", "renwu1"; show = 0 },
        { "Tam s¸ch", "renwu2"; show = 0 },
        { "Nghe", "listen"; show = 1 },
        { "§Õn Diªu Tr×", "go"; show = 0 },
        { "Thu thËp", "fragment"; show = 1 },
        { "Ph¸t ThiÖp mêi", "shouxitie"; show = 0 },
        { "Å®Éñ½ÚÏÞ¹º", "Goddess"; show = 0 }


    }

    local gyy, gmm, gdd = GetYMD()
    if (gyy == 2017) and (gmm == 3) and (gdd >= 7) and (gdd <= 10) then
        tasks[7].show = 1;
    else
        tasks[7].show = 0;
    end

    if (UTask_Knight == 40) or (UTask_Druid == 40) or (UTask_Wizard == 40) then
        if (GetLevel() >= 65) then
            tasks[1].show = 1;
        end ;
    end ;
    if (UTask_Knight > 40) or (UTask_Druid > 40) or (UTask_Wizard > 40) then
        tasks[4].show = 1;
    end ;
    if (UTask_Knight == 60) or (UTask_Druid == 60) or (UTask_Wizard == 60) then
        if (GetLevel() >= 75) then
            tasks[2].show = 1;
        end ;
    end ;

    local H, M, S = GetHMS()
    local sortDate = LoadIniInteger(Save_Section_Ring_Date, 1)

    if ((IsEightDays() == 1) and (H >= 21) and (sortDate ~= GetGlobalValue(Global_Fragment_Num))) then
        freshSortList()
    end

    if (IsEightDays() == 1) and (IsTongMember() == 1) and (H > 8) then
        local nLastTongTaskTime = GetTongTask(Task_Tong_Fragment1)
        local nLastTongTaskDay = math.floor(nLastTongTaskTime / 86400)
        local nNowDay = math.floor(LocalSystemTime() / 86400)
        if (nLastTongTaskDay ~= nNowDay) then
            SetTongTask(Task_Tong_Fragment, 0)
            SetTongTask(Task_Tong_Fragment2, 0)
            SetTongTask(Task_Tong_Fragment1, LocalSystemTime())
        end
    end

    if (GetTaskBit(Task_Xitie, 1) == 1 and GetTaskBit(Task_Xitie, 2) == 0 and GetSex() == 0) then
        tasks[6].show = 1
    end

    SayTask(10013, tasks)


end;

function Goddess()
    no()
    local tasks = {
        { "Å®ÉñÀñ¡¤Ò»", "Goddess1"; show = 1 },
        { "Å®ÉñÀñ¡¤¶þ", "Goddess2"; show = 1 },
        { "Quay l¹i", "main"; show = 1 }
    }
    local str = ""
    local sex = GetSex()
    if (sex == 0) then
        str = "3ÔÂ7ÈÕ-3ÔÂ10ÈÕ, Å®Éñ½Ú³¬ÖµÀñ°üÏÞÁ¿¹º!\nÅ®ÉñÀñ¡¤Ò»: bªn trong chøa <c=y>T­íng Qu©n LÖnh*10, Vi Quang Qu¸i Phï*2.<c> Ô­¼Û98 Th«ng B¶oÏÖ½öÊÛ<c=y>37<c> Th«ng B¶oÏÞ¹º 1 c¸i ;<c>\nÅ®ÉñÀñ¡¤¶þ: bªn trong chøa <c=y>T­íng Qu©n LÖnh*37, Tinh Th¸i Qu¸i Phï*1.<c> Ô­¼Û378 Th«ng B¶oÏÖ½öÊÛ<c=y>137<c> Th«ng B¶oÏÞ¹º 1 c¸i ;"
    elseif (sex == 1) then
        str = "3ÔÂ7ÈÕ-3ÔÂ10ÈÕ, Å®Éñ½Ú³¬ÖµÀñ°üÏÞÁ¿¹º!\nÅ®ÉñÀñ¡¤Ò»: bªn trong chøa <c=y>T­íng Qu©n LÖnh*10, Vi Quang Qu¸i Phï*2.<c> Ô­¼Û98 Th«ng B¶oÏÖ½öÊÛ<c=y>37<c> Th«ng B¶oÏÞ¹º 1 c¸i ;<c=g>Å®ÐÔ½ÇÉ«¹ºÂò½«NhËn ®­îc thªm Ãµ¹å»¨*10.<c>\nÅ®ÉñÀñ¡¤¶þ: bªn trong chøa <c=y>T­íng Qu©n LÖnh*37, Tinh Th¸i Qu¸i Phï*1.<c> Ô­¼Û378 Th«ng B¶oÏÖ½öÊÛ<c=y>137<c> Th«ng B¶oÏÞ¹º 1 c¸i ;<c=g>Å®ÐÔ½ÇÉ«¹ºÂò½«NhËn ®­îc thªm ÇÉ¿ËÁ¦*5, ÌìÍâ·ÉÏÉ×° (30 ngµy ).<c>"
    end
    SayTask(str, tasks)
end

function Goddess1()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(281)
    if (GetCoin() < costIBNum) then
        InfoBox("ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÊ§°Ü.")
        return
    end
    local sex = GetSex()
    if (sex == 0) then
        MsgBox("Ngµi sÏ tiªu phÝ 37 Th«ng B¶o¹ºÂòÅ®ÉñÀñ¡¤Ò»: <c=y>T­íng Qu©n LÖnh*10, Vi Quang Qu¸i Phï*2.<c>", "Goddess1_Yes", "no")
    elseif (sex == 1) then
        MsgBox("Ngµi sÏ tiªu phÝ 37 Th«ng B¶o¹ºÂòÅ®ÉñÀñ¡¤Ò»: <c=y>T­íng Qu©n LÖnh*10, Vi Quang Qu¸i Phï*2.<c><c=g>¹ºÂò³É¹¦ºóÄú½«NhËn ®­îc thªm Ãµ¹å»¨*10.<c>", "Goddess1_Yes", "no")
    end
end
function Goddess1_Yes()
    no()
    if (GetTaskByte(2183, 3) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­¹ºÂò¹ý¸ÃÀñ°ü, ²»ÄÜÔÙ´Î¹ºÂò.")
        return
    end
    local sex = GetSex()
    if (sex == 0) then
        if (IsHaveSpaceForTreasure(3) <= 0) then
            Msg2Player(IsHaveSpaceForTreasure(2))
            Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 2 « trèng, ÇëÕûÀíºóÔÙ´ò¿ª.")
            return
        end
    elseif (sex == 1) then
        if (IsHaveSpaceForTreasure(4) <= 0) then
            Msg2Player(IsHaveSpaceForTreasure(3))
            Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 3 « trèng, ÇëÕûÀíºóÔÙ´ò¿ª.")
            return
        end
    end

    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(281)
    if (GetCoin() < costIBNum) then
        InfoBox("ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÊ§°Ü.")
        return
    end
    CostCoinByIdx(281)

    SetTaskByte(2183, 3, 1)
    local str = "Ngµi nhËn ®­îc : "
    for i = 1, 10 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    for i = 1, 2 do
        AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
    end
    str = str .. "10 c¸i T­íng Qu©n LÖnh,  2 c¸i Vi Quang Qu¸i Phï"
    if (sex == 1) then
        for i = 1, 10 do
            AddNormalItemBind(6, 1, 22, 1, 0, 0, 1)
        end
        str = str .. ", 10Ö§Ãµ¹å»¨"
    end
    str = str .. "."
    Talk(1, "no", str)
    Msg2Player(str)
    WriteLog("[TriÒu Ca][§¸t Kû][Å®ÉñÀñ¡¤Ò»]" .. GetName() .. "[ Tiªu hao 37 Th«ng B¶o]" .. str)
end

function Goddess2()
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(282)
    if (GetCoin() < costIBNum) then
        InfoBox("ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÊ§°Ü.")
        return
    end
    local sex = GetSex()
    if (sex == 0) then
        MsgBox("Ngµi sÏ tiªu phÝ 137 Th«ng B¶o¹ºÂòÅ®ÉñÀñ¡¤¶þ: <c=y>T­íng Qu©n LÖnh*37, Tinh Th¸i Qu¸i Phï*1.<c>", "Goddess2_Yes", "no")
    elseif (sex == 1) then
        MsgBox("Ngµi sÏ tiªu phÝ 137 Th«ng B¶o¹ºÂòÅ®ÉñÀñ¡¤¶þ: <c=y>T­íng Qu©n LÖnh*37, Tinh Th¸i Qu¸i Phï*1.<c><c=g>¹ºÂò³É¹¦ºóÄú½«NhËn ®­îc thªm ÇÉ¿ËÁ¦*5.ÌìÍâ·ÉÏÉ×° (30 ngµy )<c>", "Goddess2_Yes", "no")
    end
end

function Goddess2_Yes()
    no()
    if (GetTaskByte(2183, 4) == 1) then
        Talk(1, "no", "ÄúÒÑ¾­¹ºÂò¹ý¸ÃÀñ°ü, ²»ÄÜÔÙ´Î¹ºÂò.")
        return
    end
    local sex = GetSex()
    if (sex == 0) then
        if (IsHaveSpaceForTreasure(3) <= 0) then
            Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 2 « trèng, ÇëÕûÀíºóÔÙ´ò¿ª.")
            return
        end
    elseif (sex == 1) then
        if (IsHaveSpaceForTreasure(5) <= 0) then
            Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 4 « trèng, ÇëÕûÀíºóÔÙ´ò¿ª.")
            return
        end
    end
    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(282)
    if (GetCoin() < costIBNum) then
        InfoBox("ÄúµÄÍ¨±¦²»×ã, ¹ºÂòÊ§°Ü.")
        return
    end
    CostCoinByIdx(282)

    SetTaskByte(2183, 4, 1)

    local str = "Ngµi nhËn ®­îc : "
    for i = 1, 37 do
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
    end
    str = str .. "37 c¸i T­íng Qu©n LÖnh"
    AddNormalItemBind(3, 383, 0, 0, 0, 0, 1)
    str = str .. ", 1 c¸i Tinh Th¸i Qu¸i Phï"
    if (sex == 1) then
        for i = 1, 5 do
            AddNormalItemBind(1, 6, 0, 0, 1, 0, 1)
        end
        str = str .. ",  5 c¸i ÇÉ¿ËÁ¦"
        AddNormalItemBind(6, 1, 899, 0, 0, 0, 1)
        str = str .. ", 1 c¸i ÌìÍâ·ÉÏÉ×° (30 ngµy )"
    end
    str = str .. "."
    Talk(1, "no", str)
    Msg2Player(str)
    WriteLog("[TriÒu Ca][§¸t Kû][Å®ÉñÀñ¡¤¶þ]" .. GetName() .. "[ Tiªu hao 137 Th«ng B¶o]" .. str)
end

function shouxitie()
    CloseDialog()
    if (GetTaskBit(Task_Xitie, 3) == 1) then
        Talk(1, "no", "§¾c Kû:Chóc hai ng­¬i b¸ch niªn hßa hîp!")
        return
    end
    local b_pos = pos_ok(500)
    if (b_pos == 2) then
        Talk(1, "no", "§¾c Kû:T©n n­¬ng c¸ch ng­¬i qu¸ xa, h·y ®­a c« Êy ®Õn c¹nh ng­¬i!")
        return
    elseif (b_pos == 3) then
        Talk(1, "no", "§¾c Kû:T©n n­¬ng kh«ng ë khu vùc nµy, h·y ®­a c« ta ®Õn ®©y!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", "§¾c Kû:H«n lÔ lµ chuyÖn cña c¶ hai ng­êi!")
        return
    elseif (b_pos == 1) then
        local qingtie = JiehunItem[3].Item
        if (HaveNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4]) == 0) then
            Talk(1, "no", "§¾c Kû:Ng­¬i kh«ng mang ThiÖp mêi ®Õn lµm sao ®­îc?")
            return
        end
        DelNormalItem(qingtie[1], qingtie[2], qingtie[3], qingtie[4])

        SetTaskBit(Task_Xitie, 3, 1)
        local str = ""

        if (GetTaskBit(Task_Xitie, 4) == 0) then
            if (str == "") then
                str = NpcName[1]
            else
                local tep = str
                str = tep .. "," .. NpcName[1]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 0) then
            if (str == "") then
                str = NpcName[2]
            else
                local tep = str
                str = tep .. "," .. NpcName[2]
            end
        end

        if (GetTaskBit(Task_Xitie, 5) == 0) then
            if (str == "") then
                str = NpcName[3]
            else
                local tep = str
                str = tep .. "," .. NpcName[3]
            end
        end

        if (GetTaskBit(Task_Xitie, 6) == 0 and GetTaskByte(Task_MarryState, 2) == 3) then
            if (str == "") then
                str = NpcName[5]
            else
                local tep = str
                str = tep .. "," .. NpcName[5]
            end
        end

        if (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskBit(Task_Xitie, 6) == 1 and GetTaskByte(Task_MarryState, 2) == 3) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        elseif (GetTaskBit(Task_Xitie, 3) == 1 and GetTaskBit(Task_Xitie, 4) == 1 and GetTaskBit(Task_Xitie, 5) == 1 and GetTaskByte(Task_MarryState, 2) == 2) then
            TaskNote(1507, 2)
            SetTaskBit(Task_Xitie, 2, 1)
            TeamAction("showtalk", 0, 0, 0)
            return
        else
            TaskNote(1507, 0, str, "")
        end
        TeamAction("showtalk", 0, 0, 0)
    end
end

function showtalk()
    CloseDialog()
    SetTaskBit(Task_Xitie, 3, 1)
    Talk(2, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· göi ThiÖp mêi, nh­ng ta kh«ng thÓ tham gia h«n lÔ cña c¸c ng­¬i, ®Ó chóc phóc cho hai ng­¬i, lóc cö hµnh h«n lÔ, ta sÏ tÆng c¸c ng­¬i mét kiÖu hoa thËt ®Ñp.", "§¾c Kû:Th©n b»ng h¶o h÷u cña c¸c ng­¬i chØ cÇn mang theo ThiÖp mõng vµ 1 Hång Thñy Tinh lµ cã thÓ ®Õn chç C©y l­¬ng duyªn ®Ó chóc phóc. §­îc chóc phóccµng nhiÒu, phÇn th­ëng cµng cao.")
end

function teamTaskNote(taskid, index)
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    TaskNote(taskid, index)
    PlayerIndex = n
    TaskNote(taskid, index)
    PlayerIndex = i
end

function pos_ok(distance)
    if (GetMateTask(Task_Partner) ~= GetNameID() or GetMateNameID() ~= GetTask(Task_Partner)) then
        return 4
    end

    local mapid_male, x_male, y_male = GetWorldPos()
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    PlayerIndex = n
    local mapid_female, x_female, y_female = GetWorldPos()
    local w = GetName()
    PlayerIndex = i

    if (mapid_female == mapid_male) then
        if (((x_male * 32 - x_female * 32) ^ 2 + (y_male * 32 - y_female * 32) ^ 2) > distance * distance) then
            return 2
        end
    else
        return 3
    end
    return 1
end

function set_xitiebit(bit)
    if (bit == 0) then
        SetTask(Task_Xitie, 0)
    else
        SetTaskBit(Task_Xitie, bit, 1)
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
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(4, "func_leave1", 10014, 10015, 10016, 10017)
        if (UTask_Wizard == 40) then
            SetTask(1, 41)
            TaskNote(28, 20)
        end ;
        if (UTask_Knight == 40) then
            SetTask(3, 41)
            TaskNote(27, 16)
        end ;
        if (UTask_Druid == 40) then
            SetTask(2, 41)
            TaskNote(29, 15)
        end ;

        refreshNpcTaskState()

    else
        Talk(1, "no", 11718)
    end
end;

function renwu2()
    local mark = fangchenmi()
    if (mark == 1) then
        if (GetPlayerType() == 0) and (UTask_Knight == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(13) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14211)
            end ;
        elseif (GetPlayerType() == 1) and (UTask_Wizard == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(2) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14212)
            end ;
        elseif (GetPlayerType() == 2) and (UTask_Druid == 60) and (GetLevel() >= 75) then
            if (HaveEventItem(19) >= 1) then
                Talk(1, "func_leave2", 10018)
            else
                Talk(1, "no", 14213)
            end ;
        end ;

    else
        Talk(1, "no", 11718)
    end
end;

function listen()
    Talk(1, "func_leave3", 10019)
end;

function go()
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ chuyÓn tiÕp")
    else
        local i = math.random(1, 3)
        if (i == 1) then
            NewWorld(52, 1541, 3190)
        end ;
        if (i == 2) then
            NewWorld(52, 1556, 3202)
        end ;
        if (i == 3) then
            NewWorld(52, 1540, 3205)
        end ;
        SetFightState(0)
    end ;
    CloseDialog()
end;

function func_leave1()
    Talk(1, "main", 10020)
end;

function func_leave2()
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    Talk(2, "no", 10021, 10022)
    if (UTask_Wizard == 60) and (HaveEventItem(2) >= 1) and (GetPlayerType() == 1) and (GetLevel() >= 75) then
        DelEventItem(2)
        AddEventItem(9)
        SetTask(1, 61)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao ThÇn Méc cho §¾c Kû.")
        TaskNote(28, 27)

        refreshNpcTaskState()

    elseif (UTask_Knight == 60) and (HaveEventItem(13) >= 1) and (GetPlayerType() == 0) and (GetLevel() >= 75) then
        SetTask(3, 61)
        DelEventItem(13)
        AddEventItem(9)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao r©u ThÇn Long cho §¾c Kû.")
        TaskNote(27, 23)

        refreshNpcTaskState()

    elseif (UTask_Druid == 60) and (HaveEventItem(19) >= 1) and (GetPlayerType() == 2) and (GetLevel() >= 75) then
        SetTask(2, 61)
        DelEventItem(19)
        AddEventItem(9)
        TaskNote(29, 22)
        Msg2Player("NhËn ®­îc Phong ThÇn b¶ng, giao Ma HuyÕt cho §¾c Kû.")

        refreshNpcTaskState()

    end ;
end;

function func_leave3()
    Talk(1, "func_leave4", 10023)
end;

function func_leave4()
    Talk(2, "func_leave5", 10024, 10025)
end;

function func_leave5()
    Talk(1, "func_leave6", 10026)
end;

function func_leave6()
    Talk(1, "func_leave7", 10027)
end;

function func_leave7()
    Talk(1, "no", 10028)

end;

function no()
    CloseDialog()
end;

function fragment()
    CloseDialog()

    local task1 = {
        { "Nép To¸i phiÕn", "giveBack"; show = 0 },
        { "L·nh nhËn phÇn th­ëng", "getExp"; show = 0 },
        { "ThuyÕt minh", "introduction"; show = 1 },
        { "B¶ng xÕp h¹ng", "ranking"; show = 1 },
    }

    if (isViewMatchTask() == 1) then
        task1[1].show = 1
    end

    local nNowDay = math.floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = math.floor(nLastTaskTime / 86400)
    local jianGe = nNowDay - nLastTaskDay

    if (GetGlobalValueWord(Global_Fragment, 1) >= 2840 and GetTaskByte(Task_Get_Fragment, 3) > 0 and jianGe < 8) then
        task1[2].show = 1
    end

    SayTask("§¾c Kû:To¸i phiÕn Ngäc Hoa B×nh trªn th­îng giíi ®· r¬i xuèng nh©n gian, mäi ng­êi mau thu thËp, l·nh ®Þa nµo thu thËp nhiÒu nhÊt, ta sÏ tÆng phÇn th­ëng hËu hÜ.", task1)
end

function isViewMatchTask()
    if (GetLevel() < 30) then
        return 0
    end

    if (IsTongMember() ~= 1) then
        return 0
    end

    local H, M, S = GetHMS()
    if (IsEightDays() ~= 1 or H < 21 or (H == 23 and M > 58)) then
        return 0
    end

    if (HaveNormalItem(3, 458, 0, 0) <= 0 and HaveNormalItem(3, 459, 0, 0) <= 0 and HaveNormalItem(3, 460, 0, 0) <= 0 and HaveNormalItem(3, 461, 0, 0) <= 0) then
        return 0
    end

    return 1
end

function introduction()
    CloseDialog()

    Talk(2, "introduction1", "§¾c Kû:<c=g>Cø 8 ngµy<c> ®Õn <c=g>9h tèi<c>, Ngäc Hoa B×nh ë th­îng giíi vì tan, To¸i phiÕn sÏ r¬i xuèng nh©n gian, h·y tËp hîp lùc l­îng l·nh ®Þa gióp ta thu thËp, sÏ cã phÇn th­ëng xøng ®¸ng.", "§¾c Kû:T¹p hãa th­¬ng ®ang thu mua Cuèc, h·y thu thËp To¸i phiÕn r¬i ë nh©n gian. To¸i phiÕn nhá chØ do 1 ng­êi nhÆt, To¸i phiÕn trung cÇn <c=g>2 ng­êi cïng l·nh ®Þa<c> kÕt tæ ®éi thu thËp, To¸i phiÕn lín cÇn <c=g>4 ng­êi cïng l·nh ®Þa kÕt tæ ®éi <c> thu thËp, cßn cã c¬ héi nhËn ®­îc To¸i phiÕn cùc lín.")
end

function introduction1()
    CloseDialog()

    Talk(2, "no", "§¾c Kû:6 To¸i phiÕn ®Çu tiªn giao nép míi cã phÇn th­ëng kinh nghiÖm, vÒ sau chØ cã ®iÓm l·nh ®Þa. To¸i phiÕn thu thËp cµng lín, phÇn th­ëng cµng cao. Mçi ng­êi chØ ®­îc mang 1 To¸i phiÕn mçi lo¹i.", "§¾c Kû:Cã thÓ nép To¸i phiÕn tr­íc 12h, sau khi thu thËp ®ñ To¸i phiÕn, ta sÏ tÆng ng­êi ch¬i phÇn th­ëng hËu hÜ. L·nh ®Þa n»m trong 3 vÞ trÝ ®Çu tiªn sÏ t¨ng H­ng thÞnh l·nh ®Þa.")
end

function giveBack()
    CloseDialog()

    local H, M, S = GetHMS()
    if (GetLevel() >= 30 and IsTongMember() == 1 and IsEightDays() == 1 and H >= 21) then
        if (HaveNormalItem(3, 458, 0, 0) < 0 and HaveNormalItem(3, 459, 0, 0) < 0 and HaveNormalItem(3, 460, 0, 0) < 0 and HaveNormalItem(3, 461, 0, 0) < 0) then
            Talk(1, "no", "§¾c Kû:Ng­¬i kh«ng mang theo To¸i phiÕn.")
            return
        end

        qingLing()

        if (HaveNormalItem(3, 461, 0, 0) > 0) then
            ClearItem(3, 461, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 2, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (cùc lín).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 5
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 1000
                AddOwnExp(addExp)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn cùc lín, nhËn ®­îc " .. addExp .. " kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 1000
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn cùc lín, nhËn ®­îc " .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 460, 0, 0) > 0) then
            ClearItem(3, 460, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 2, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (lín).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 3
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 600
                AddOwnExp(addExp)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn lín, nhËn ®­îc " .. addExp .. " kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            elseif (give_num == 5) then
                local addExp = GetLevel() * 600
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn lín, nhËn ®­îc " .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 459, 0, 0) > 0) then
            ClearItem(3, 459, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            SetTaskByte(Task_Get_Fragment, 1, 0)
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 m¶nh To¸i phiÕn (trung).")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 2
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 400
                AddOwnExp(addExp)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn trung, nhËn ®­îc " .. addExp .. " kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 400
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn trung, nhËn ®­îc " .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end

        elseif (HaveNormalItem(3, 458, 0, 0) > 0) then
            ClearItem(3, 458, 0, 0)
            Talk(1, "no", "§¾c Kû:C¶m ¬n ng­¬i ®· nép l¹i To¸i phiÕn.")
            WriteLog(GetTongName() .. " " .. GetName() .. "Giao cho §¾c Kû 1 To¸i phiÕn nhá.")

            local tong_fragment = GetTongTask(Task_Tong_Fragment) + 1
            SetTongTask(Task_Tong_Fragment, tong_fragment)
            addSortList(GetTongName(), tong_fragment)

            local sum_fragment = GetGlobalValueWord(Global_Fragment, 1)
            sum_fragment = sum_fragment + 1
            SetGlobalValueWord(Global_Fragment, 1, sum_fragment)

            local give_num = GetTaskByte(Task_Get_Fragment, 3)
            if (give_num < 5) then
                local addExp = GetLevel() * 300
                AddOwnExp(addExp)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
                Msg2Player("Giao 1 To¸i phiÕn nhá, nhËn ®­îc " .. addExp .. " kinh nghiÖm.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))

            elseif (give_num == 5) then
                local addExp = GetLevel() * 300
                AddOwnExp(addExp)
                AddVigour(200)
                TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                Msg2Player("Giao 1 To¸i phiÕn nhá, nhËn ®­îc " .. addExp .. " kinh nghiÖm vµ 200 ®iÓm Tinh Lùc.")
                give_num = give_num + 1
                SetTaskByte(Task_Get_Fragment, 3, give_num)
                SetTaskWord(Task_Get_Fragment, 1, GetGlobalValue(Global_Fragment_Num))
            end
        end

        if (GetMorphType() == 23) then
            PolyMorph(-1, 0, 0, 0, 0)
        end

        if (GetGlobalValueWord(Global_Fragment, 1) > 0 and math.mod(GetGlobalValueWord(Global_Fragment, 1), 400) == 0) then
            local message = ""
            local rank_num = table.getn(arySortList)
            if (rank_num > 3) then
                rank_num = 3
            end
            for i = 1, rank_num do

                if (arySortList[i].name == "") then
                    break
                end

                local rankSec = arySortList[i].score
                local rankName = arySortList[i].name

                message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " phót"
            end
            if (table.getn(arySortList) >= 1) then
                AddGlobalCountNews("HiÖn t¹i ho¹t ®éng thu thËp To¸i phiÕn, cèng hiÕn tèi ®a " .. rank_num .. "Tªn l·nh ®Þa: " .. message, 1)
            end
        end

        if (GetGlobalValueWord(Global_Fragment, 1) >= 2840) then
            local message = ""
            local rank_num = table.getn(arySortList)
            if (rank_num > 3) then
                rank_num = 3
            end
            local rankscore = 0
            for i = 1, rank_num do
                if (arySortList[i].name == "") then
                    break
                end

                local rankSec = arySortList[i].score
                local rankName = arySortList[i].name

                if (i == 1) then
                    rankscore = 100
                elseif (i == 2) then
                    rankscore = 50
                elseif (i == 3) then
                    rankscore = 30
                end

                local nTongID = GetTongIDByName(rankName)
                AddTongAttrByID(nTongID, 0, rankscore)

                message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " ®iÓm, H­ng thÞnh l·nh ®Þa t¨ng" .. rankscore .. " ®iÓm"
            end
            if (rank_num >= 1) then
                AddGlobalCountNews("Nhê mäi ng­êi gióp ®ì, tÊt c¶ To¸i phiÕn ®· thu thËp ®ñ, nh÷ng ng­êi ch¬i tham gia ho¹t ®éng sÏ nhËn ®­îc phÇn th­ëng hËu hÜ, vÞ trÝ cèng hiÕn nhiÒu nhÊt" .. rank_num .. "Tªn l·nh ®Þa: " .. message, 1)
            end

            WriteLog("Ho¹t ®éng thu thËp To¸i phiÕn lÇn nµy ®· t×m ra vµ giao nép tÊt c¶ To¸i phiÕn.")
        end
    end
end

function getExp()
    CloseDialog()

    local nNowDay = math.floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = math.floor(nLastTaskTime / 86400)
    local jianGe = nNowDay - nLastTaskDay

    if (GetGlobalValueWord(Global_Fragment, 1) >= 2840 and GetTaskByte(Task_Get_Fragment, 3) > 0 and jianGe < 8) then
        local addExp = GetLevel() * 1000
        AddOwnExp(addExp)
        TopMessage("NhËn ®­îc phÇn th­ëng <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
        Msg2Player("Toµn bé To¸i phiÕn ®· t×m ®ñ, §¾c Kû th­ëng cho b¹n" .. addExp .. " kinh nghiÖm.")
        Talk(1, "no", "§¾c Kû:Chóc mõng, ng­¬i ®· t×m ®ñ sè To¸i phiÕn, ta th­ëng cho ng­¬i <c=g>" .. addExp .. "<c> ®iÓm kinh nghiÖm.")
        SetTask(Task_Get_Fragment, 0)
    end
end

Save_Section_Ring_Date = "Save_Frag_Ranking_Data"
Save_Section_Ring_Score = "Save_Frag_Ranking_Score"
Save_Section_Ring_Playername = "Save_Frag_Ranking_Playername"
arySortList = {}

function ranking()
    CloseDialog()

    if (table.getn(arySortList) <= 0) then
        loadSortList()
    end

    if (table.getn(arySortList) <= 0) then

        Talk(1, "no", "§¾c Kû:T¹m thêi ch­a thÓ giao nép To¸i phiÕn, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!")

    else

        local message = ""
        local count = 0

        for i = 1, 10 do
            if (arySortList[i].name == "") then
                break
            end

            count = count + 1
        end

        for i = 1, 5 do

            if (arySortList[i].name == "") then
                break
            end

            local rankSec = arySortList[i].score
            local rankName = arySortList[i].name

            message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " Phót\n"

        end

        if (message == "") then
            message = "§¾c Kû:T¹m thêi ch­a thÓ giao nép To¸i phiÕn, muèn xem b¶ng xÕp h¹ng xin chê l¸t n÷a h·y ®Õn, lóc Êy ch¾c danh s¸ch trªn b¶ng xÕp h¹ng ®· cã thay ®æi!"
        end

        if (count <= 5) then
            Talk(1, "no", message)
        else
            Talk(1, "lastFiveRanking", message)
        end

    end

end

function lastFiveRanking()
    CloseDialog()

    local message = ""
    for i = 6, 10 do
        if (arySortList[i].name == "") then
            break
        end

        local rankSec = arySortList[i].score
        local rankName = arySortList[i].name

        message = message .. "Thiªn C­¬ng ¶nh thø" .. i .. " ng­êi: <c=g>" .. rankName .. "<c> " .. rankSec .. " Phót\n"
    end
    Talk(1, "no", message)
end

function loadSortList()
    local saveDate = LoadIniInteger(Save_Section_Ring_Date, 1)

    for i = 1, 10 do
        arySortList[i] = { name = "", score = 0 }
    end

    local topName = {}
    local topSec = {}

    if (saveDate ~= nil) and (saveDate ~= 0) then

        for i = 1, table.getn(arySortList), 1 do
            topName[i] = LoadIniString(Save_Section_Ring_Playername, i)
            topSec[i] = LoadIniInteger(Save_Section_Ring_Score, i)

            arySortList[i] = { name = topName[i], score = topSec[i] }
        end

    end
end

function freshSortList()

    for i = 1, 10 do
        arySortList[i] = { name = "", score = 0 }
    end

    SaveIniInteger(Save_Section_Ring_Date, 1, math.floor(LocalSystemTime() / 86400))

    for i = 1, table.getn(arySortList), 1 do
        SaveIniString(Save_Section_Ring_Playername, i, arySortList[i].name)
        SaveIniInteger(Save_Section_Ring_Score, i, arySortList[i].score)
    end

    local tongmember = GetTongCount() - 1
    for i = 0, tongmember do
        tongID = GetTongID(i)
        if (tongID ~= nil) then
            idx = GetTongTaskByID(tongID, Task_Tong_Fragment)

            if (idx > 0) then
                SetTongTaskByID(tongID, Task_Tong_Fragment, 0)
            end
        end
    end
end

function addSortList(Name, Score)

    if (table.getn(arySortList) <= 0) then
        loadSortList()
    end

    local isInList = 0
    isInList = isInSortList(Name, Score)

    local equal_mark = 0

    for i = table.getn(arySortList), 1, -1 do

        if (isInList == 0) then
            if (arySortList[i].score < Score) or (arySortList[i].name == "") then
                if (i < 10) then
                    arySortList[i + 1].score = arySortList[i].score
                    arySortList[i + 1].name = arySortList[i].name
                end

                if (i == 1) then
                    arySortList[i].score = Score
                    arySortList[i].name = Name
                end
            else
                if (i < 10) then
                    arySortList[i + 1].score = Score
                    arySortList[i + 1].name = Name
                    break

                elseif (i == 10) and (arySortList[i].score >= Score) and (arySortList[i].name ~= "") then
                    break
                end
            end
        else
            if (arySortList[i].score <= Score) then
                if (equal_mark == 1) then
                    if (i < 10) then
                        if (arySortList[i].score < Score) then
                            arySortList[i + 1].score = arySortList[i].score
                            arySortList[i + 1].name = arySortList[i].name
                        else
                            arySortList[i + 1].score = Score
                            arySortList[i + 1].name = Name
                            break
                        end
                    end
                end

                if (arySortList[i].name == Name) then
                    equal_mark = 1
                end

                if (i == 1) then
                    arySortList[i].score = Score
                    arySortList[i].name = Name
                end
            else
                if (i < 10) then
                    arySortList[i + 1].score = Score
                    arySortList[i + 1].name = Name
                    break

                elseif (i == 10) and (arySortList[i].score >= Score) and (arySortList[i].name ~= "") then
                    break
                end
            end
        end

    end

    saveSortList()

end

function isInSortList(Name, Score)

    if (table.getn(arySortList) <= 0) then
        return 0
    end

    for i = table.getn(arySortList), 1, -1 do
        if (Name == arySortList[i].name) then
            return 1
        end
    end

    return 0
end

function saveSortList()

    for i = 1, table.getn(arySortList), 1 do

        SaveIniString(Save_Section_Ring_Playername, i, arySortList[i].name)
        SaveIniInteger(Save_Section_Ring_Score, i, arySortList[i].score)

    end

end

function qingLing()
    local nNowDay = math.floor(LocalSystemTime() / 86400)
    local nLastTaskTime = GetTask(Task_Get_Fragment1)
    local nLastTaskDay = math.floor(nLastTaskTime / 86400)
    if (nLastTaskDay ~= nNowDay) then
        SetTaskByte(Task_Get_Fragment, 1, 0)
        SetTaskByte(Task_Get_Fragment, 2, 0)
        SetTaskByte(Task_Get_Fragment, 3, 0)
        SetTask(Task_Get_Fragment1, LocalSystemTime())
    end
end





























































































































