require("¿ç·şÕ½³¡.luax")

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

Task_MarryState = 800

Task_Partner = 801

GetBack_Info = {
    { itemInfo = { 3, 1134, 0, 0 }, itemName = "HuyÒn Hoang Th¸p", npcName = "D­ Kh¸nh", mapName = "Hoang m¹c" },
    { itemInfo = { 3, 1135, 0, 0 }, itemName = "H¶i ThÇn Ch©m", npcName = "Hoµng Minh", mapName = "§«ng H¶i" },
    { itemInfo = { 3, 1136, 0, 0 }, itemName = "V¹n Viªm Ch©u", npcName = "Tèng DŞ Nh©n", mapName = "Hiªn Viªn" },
    { itemInfo = { 3, 1137, 0, 0 }, itemName = "Tö Yªu LÖnh", npcName = "Hå Hû MŞ", mapName = "B¨ng Xuyªn" },
}
nNpcIndex = 4
Task_GetBackItem = 1727

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

    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 32) and (HaveEventItem(13) >= 1) then
                state = 3
                subState = 0
            elseif (state == 32) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 32) and (HaveEventItem(13) >= 1) then
                state = 3
                subState = 1
            elseif (state == 32) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 31) then
                state = 3
                subState = 0
            elseif (taskProcess == 33) and (HaveEventItem(2) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 33) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 31) then
                state = 3
                subState = 1
            elseif (taskProcess == 33) and (HaveEventItem(2) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 33) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 34) and (HaveEventItem(19) == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 34) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 34) and (HaveEventItem(19) == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 32) then
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
    UTask_Knight = GetTask(3);
    UTask_Wizard = GetTask(1);
    UTask_Druid = GetTask(2);
    tasks = {
        { "ThÇn Long", "renwu1"; show = 0 },
        { "ThÇn Méc", "renwu2"; show = 0 },
        { "Mêi yÕn héi", "renwu3"; show = 0 },
        { "Ma huyÕt", "renwu4"; show = 0 },
        { "¢m D­¬ng Ho¸n", "changeSex"; show = 1 },
    }
    if (GetLevel() >= 55) and (UTask_Knight == 32) and (HaveEventItem(13) >= 1) then
        tasks[1].show = 1;
    end ;
    if (UTask_Wizard == 33) and (HaveEventItem(2) >= 1) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() >= 55) and (UTask_Wizard == 31) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() >= 25) and (UTask_Druid == 1) then
        tasks[3].show = 1;
    end ;
    if (GetLevel() >= 55) and (UTask_Druid == 34) and (HaveEventItem(19) >= 1) then
        tasks[4].show = 1;
    end ;

    if (GetTaskByte(Task_MarryState, 3) == 1 and GetSex() == 0) then
        local task1 = { { "NhËp linh khİ", "show_over"; show = 1 } }
        SayTask(" Chóc hai ng­êi h¹nh phóc mü m·n, b¹ch ®Çu giai l·o!", task1)
        return
    end
    SayTask(10041, tasks)
end;

function show_over()
    CloseDialog()
    local str = ""
    if (GetTaskByte(Task_MarryState, 3) == 3) then
        str = " vµ tÆng cho mçi ng­êi ch¬i xung quanh 1 <c=yel>ph¸o hoa<c>, chóc h«n lÔ vui vÎ!"
    end
    local b_pos = pos_ok(500)
    if (b_pos == 2) then
        Talk(1, "no", " T©n n­¬ng c¸ch ng­¬i qu¸ xa, xin l¹i gÇn nhau thªm chót n÷a!")
        return
    elseif (b_pos == 3) then
        Talk(1, "no", " T©n n­¬ng kh«ng trong khu vùc nµy, hai ng­êi ph¶i ë bªn c¹nh nhau míi ®­îc!")
        return
    elseif (b_pos == 4) then
        Talk(1, "no", " Hai ng­êi ph¶i tæ ®éi víi nhau míi cã thÓ hoµn thµnh h«n lÔ!")
        return
    elseif (b_pos == 1) then
        MsgBox(" Ta ®· gióp hai ng­êi chó nhËp linh khİ cho h¹t." .. str .. " X¸c nhËn chó nhËp linh khİ cho h¹t chø?", "yes_zhuru", "no")
    end
end

function yes_zhuru()
    CloseDialog()
    local i = PlayerIndex
    local n = 0
    if (IsCaptain() == 0) then
        n = GetTeamMember(1)
    else
        n = GetTeamMember(2)
    end ;
    SetTaskByte(Task_MarryState, 3, 2)
    PlayerIndex = n
    SetTaskByte(Task_MarryState, 3, 2)
    PlayerIndex = i
    if (GetTaskByte(Task_MarryState, 2) == 3) then
        local npcmapid, x, y = GetWorldPos()
        local mapidx = SubWorldID2Idx(npcmapid)
        local nPlayerCount = GetSubWorldPlayerCount(mapidx)
        local nCount = 0
        if (nPlayerCount > 0) then
            for j = 1, nPlayerCount do
                PlayerIndex = GetSubWorldPlayerIdxByNum(mapidx, j)
                if (PlayerIndex > 0 and CheckDis(1000) == 1 and nCount <= 100) then
                    AddNormalItem(6, 0, 20, 1, 0, 0)
                    nCount = nCount + 1
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc 1 Ph¸o hoa!")
                end
            end
        end
    end
    NpcSay(DialogNpcIdx, " Chóc mõng hai vŞ t©n nh©n ®· hoµn thµnh chµo hái quan kh¸ch! Chóng ta h·y chê ®îi hä trång C©y l­¬ng duyªn nhĞ!")
    PlayerIndex = i
    teamTaskNote(1507, 4)
    Talk(1, "no", " Xin h·y ®Õn TriÒu Ca trång C©y l­¬ng duyªn cña hai ng­êi ®i!")
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

function CheckDis(nDis)
    local nMapid1, nX1, nY1 = GetNpcWorldPos(DialogNpcIdx)
    local nMapid2, nX2, nY2 = GetWorldPos()

    if (nMapid1 == nMapid2) then
        local nDisSquare = (nX1 - nX2) ^ 2 + (nY1 - nY2) ^ 2
        if (nDisSquare < nDis * nDis) then
            return 1
        end
    end
    return 0
end

function renwu1()
    UTask_Knight = GetTask(3);
    if (GetLevel() >= 55) and (UTask_Knight == 32) and (HaveEventItem(13) >= 1) then
        Talk(3, "no", 10042, 10043, 10167)
        SetTask(3, 40)
        AddNormalItem(3, 46, 0, 0, 0, 0)
        AddOwnExp(600000)
        Msg2Player("Giao r©u thÇn long cho Hå Hû MŞ, nhËn B¸ L¹c nh·n cÊp 10 vµ 600000 kinh nghiÖm. Cã thÓ tù do ra vµo Léc ®µi.")
        TopMessage(14214)
        TaskNote(27, 15)

        refreshNpcTaskState()

    end
end;

function renwu2()
    UTask_Wizard = GetTask(1);
    if (GetLevel() >= 55) and (UTask_Wizard == 33) and (HaveEventItem(2) >= 1) then
        Talk(1, "no", 10044)
        AddNormalItem(3, 46, 0, 0, 0, 0)
        SetTask(1, 40)
        AddOwnExp(600000)
        Msg2Player("§­a ThÇn méc cho Hå Hû MŞ nhËn B¸ L¹c nh·n cÊp 10 vµ 600000 kinh nghiÖm. Cã thÓ tù do ra vµo Léc ®µi.")
        TopMessage(14214)
        TaskNote(28, 19)

        refreshNpcTaskState()

    end ;

    if (GetLevel() >= 55) and (UTask_Wizard == 31) then
        Talk(3, "no", 10045, 10046, 10047)
        SetTask(1, 32)
        Msg2Player("Muèn gÆp §¾c Kû cÇn ph¶i cã ThÇn Méc.")
        TaskNote(28, 17)

        refreshNpcTaskState()

    end ;
end;

function renwu3()
    Talk(1, "no", 10048)
    AddEventItem(15)
    SetTask(2, 2)
    Msg2Player("NhËn ®­îc thiÕp mêi dù tiÖc.")
    TaskNote(29, 1)

    refreshNpcTaskState()

end;

function renwu4()
    if (GetLevel() >= 55) and (UTask_Druid == 34) and (HaveEventItem(19) >= 1) then
        Talk(1, "no", 10049)
        AddNormalItem(3, 46, 0, 0, 0, 0)
        SetTask(2, 40)
        TaskNote(29, 14)
        AddOwnExp(600000)
        Msg2Player("§­a Ma huyÕt cho Hå Hû MŞ, nhËn B¸ L¹c nh·n cÊp 10 vµ 600000 kinh nghiÖm. Cã thÓ tù do ra vµo Léc ®µi.")
        TopMessage(14214)

        refreshNpcTaskState()

    end
end;

function no()
    CloseDialog()
end;

function changeSex()
    CloseDialog()

    MsgBox(" ThuËt <c=g>¢m D­¬ng BiÕn Ho¸n<c> mét khi ®· thi triÓn th× cã thÓ nghŞch chuyÓn ©m d­¬ng, cã thÓ lµm thay ®æi giíi tİnh cña con ng­êi. NÕu ng­¬i quyÕt ®Şnh muèn <c=g>thay ®æi giíi tİnh<c>, chØ cÇn nhÊp <c=g>§ång ı<c>, ta sÏ gióp ng­¬i!", "confirm", "no")
end

function confirm()
    CloseDialog()

    local thewarseasonnum = GetGlobalStoreValueByte(11, 3)
    local YY, MM, DD = GetYMD()
    local lennum = table.getn(InterService.CompetitionDate1)
    if (GetTask(1950) > 0 and thewarseasonnum == GetTaskByte(1945, 1) and
            YY <= InterService.CompetitionDate1[lennum][1] and
            MM <= InterService.CompetitionDate1[lennum][2] and
            DD <= InterService.CompetitionDate1[lennum][3]) then

        Talk(1, "no", "Hå HØ MŞ: ThËt xin lçi, ÔÚPhong ThÇn Chi ChiÕn±ÈÈüÆÚÄÚ±¨ÃûµÄÓ¢ĞÛ²»ÄÜ½øĞĞ½ÇÉ«±äĞÔÉêÇë, ÇëÔÚ±ÈÈüÆÚ½áÊøºóÔÙÀ´ÉêÇë.")
        return
    end

    local UT_Marry = GetTaskByte(800, 1)
    if (UT_Marry ~= 0) then
        if (UT_Marry == 1) then
            Talk(1, "no", " Do ng­¬i ®· <c=g>cÇu h«n<c> ı trung nh©n cña m×nh, ta kh«ng thÓ khiÕn mèi l­¬ng duyªn cña hai ng­êi tan vì bëi ta, v× vËy kh«ng thÓ gióp ng­¬i thay ®æi giíi tİnh! ChØ khi nµo ng­¬i x¸c ®Şnh <c=g>hñy bá cÇu h«n<c>, th× ta míi gióp ®­îc!")
            Msg2Player("B¹n ®· cÇu h«n víi ı trung nh©n, nªn t¹m thêi kh«ng thÓ thay ®æi giíi tİnh.")
        elseif (UT_Marry == 2) then
            Talk(1, "no", " Do ng­¬i ®· <c=g>®İnh h«n<c> ı trung nh©n cña m×nh, ta kh«ng thÓ khiÕn mèi l­¬ng duyªn cña hai ng­êi tan vì bëi ta, v× vËy kh«ng thÓ gióp ng­¬i thay ®æi giíi tİnh! ChØ khi nµo ng­¬i x¸c ®Şnh <c=g>hñy bá ®İnh h«n<c>, th× ta míi gióp ®­îc!")
            Msg2Player("B¹n ®· ®İnh h«n víi ı trung nh©n, nªn t¹m thêi kh«ng thÓ thay ®æi giíi tİnh.")
        end
        return
    end

    if (IsMarried() == 1) then
        Talk(1, "no", " Do ng­¬i ®· <c=g>kÕt h«n<c> ı trung nh©n cña m×nh, ta kh«ng thÓ khiÕn mèi l­¬ng duyªn cña hai ng­êi tan vì bëi ta, v× vËy kh«ng thÓ gióp ng­¬i thay ®æi giíi tİnh! ChØ khi nµo ng­¬i x¸c ®Şnh <c=g>ly h«n<c>, th× ta míi gióp ®­îc!")
        Msg2Player("B¹n ®· kÕt h«n, nªn t¹m thêi kh«ng thÓ thay ®æi giíi tİnh.")
        return
    end

    if (GetMorphType() ~= -1) then
        Talk(1, "no", " Ng¹i qu¸! Ng­¬i ®ang trong <c=g>tr¹ng th¸i biÕn th©n<c>, ta kh«ng nh×n thÊy ®­îc giíi tİnh cña ng­¬i, nªn kh«ng thÓ gióp ng­¬i thay ®æi giíi tİnh! H·y <c=g>hñy tr¹ng th¸i biÕn th©n<c> råi quay l¹i gÆp ta nhĞ!")
        Msg2Player("Tr¹ng th¸i biÕn th©n ®· che ®i giíi tİnh cña b¹n, nªn t¹m thêi kh«ng thÓ thay ®æi giíi tİnh.")
        return
    end

    local playername = GetName()
    local guardindex = GetTGuardIndexByPlayerName(playername)
    if (guardindex > 0) then
        Talk(1, "no", " Ng¹i qu¸! Do ng­¬i <c=g>ngåi trèn trong xe<c>, ta kh«ng nh×n thÊy ®­îc giíi tİnh cña ng­¬i, nªn kh«ng thÓ gióp ng­¬i thay ®æi giíi tİnh! H·y <c=g>rêi khái xe<c> råi ®Õn gÆp ta nhĞ!")
        Msg2Player("Tr¹ng th¸i hiÖn t¹i ®· che ®i giíi tİnh cña b¹n, nªn t¹m thêi kh«ng thÓ thay ®æi giíi tİnh.")
        return
    end

    if (GetSex() == 0) then
        Say("<pic=\"spr\\Ui4\\¸ü¸ÄĞÔ±ğ\\Å®°æ.spr\">", 3, "Xinh x¾n/v1", "DŞu dµng/v2", "Tao nh·/v3")
    else
        Say("<pic=\"spr\\Ui4\\¸ü¸ÄĞÔ±ğ\\ÄĞ°æ.spr\">", 3, "L¹nh lïng/v1", "TuÊn tó/v2", "Nam tİnh/v3")
    end
end

function v1()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)

    if (GetSex() == 0) then
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu xinh x¾n<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType1", "no")
    else
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu l¹nh lïng<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType1", "no")
    end
end

function v2()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)

    if (GetSex() == 0) then
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu dŞu dµng<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType2", "no")
    else
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu tuÊn tó<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType2", "no")
    end
end

function v3()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)

    if (GetSex() == 0) then
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu tao nh·<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType3", "no")
    else
        MsgBox(" Ng­¬i ®· chän <c=g>KiÓu nam tİnh<c> lµm ch©n dung sau khi thay ®æi giíi tİnh, giê chØ cÇn giao cho ta <c=g>" .. Cfs .. "<c> Th«ng B¶o hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, ta sÏ ®iÒu chÕ thµnh d­îc liÖu, ®Ó ng­¬i sö dông lóc chuyÓn giíi! <c=g>X¸c nhËn<c> giao cho ta chø?", "changeType3", "no")
    end
end

function changeType1()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)
    local i = FindAValidIBItem(8, 755, 2, 0)

    if (i ~= 0) then
        CostIBItem(i)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(129)
    else
        Talk(1, "no", " Ng¹i qu¸! Do ng­¬i ch­a giao cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, nªn ta ch­a thÓ ®iÒu chÕ d­îc liÖu, ch­a thÓ gióp ng­¬i chuyÓn giíi ®­îc, bao giê chuÈn bŞ ®Çy ®ñ råi quay l¹i gÆp ta nhĞ!")
        return
    end

    local H, M, S = GetHMS()
    if (GetSex() == 0) then
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu n÷-xinh x¾n")
        ChangeSexAndPortrait(1, 0)
    else
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu nam-l¹nh lïng")
        ChangeSexAndPortrait(0, 1)
    end
end

function changeType2()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)
    local i = FindAValidIBItem(8, 755, 2, 0)

    if (i ~= 0) then
        CostIBItem(i)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(129)
    else
        Talk(1, "no", " Ng¹i qu¸! Do ng­¬i ch­a giao cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, nªn ta ch­a thÓ ®iÒu chÕ d­îc liÖu, ch­a thÓ gióp ng­¬i chuyÓn giíi ®­îc, bao giê chuÈn bŞ ®Çy ®ñ råi quay l¹i gÆp ta nhĞ!")
        return
    end

    local H, M, S = GetHMS()
    if (GetSex() == 0) then
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu n÷-dŞu dµng")
        ChangeSexAndPortrait(1, 2)
    else
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu nam-tuÊn tó")
        ChangeSexAndPortrait(0, 3)
    end
end

function changeType3()
    CloseDialog()

    local _, Cv, Cfs = GetCostCoinInfoByIdx(129)
    local i = FindAValidIBItem(8, 755, 2, 0)

    if (i ~= 0) then
        CostIBItem(i)
    elseif (GetCoin() >= Cv) then
        CostCoinByIdx(129)
    else
        Talk(1, "no", " Ng¹i qu¸! Do ng­¬i ch­a giao cho ta <c=g>" .. Cfs .. " Th«ng B¶o<c> hoÆc 1 <c=g>Qu¶ ¢m D­¬ng<c>, nªn ta ch­a thÓ ®iÒu chÕ d­îc liÖu, ch­a thÓ gióp ng­¬i chuyÓn giíi ®­îc, bao giê chuÈn bŞ ®Çy ®ñ råi quay l¹i gÆp ta nhĞ!")
        return
    end

    local H, M, S = GetHMS()
    if (GetSex() == 0) then
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu n÷-tao nh·")
        ChangeSexAndPortrait(1, 4)
    else
        WriteLog(GetName() .. " ®Õn " .. H .. ":" .. M .. ":" .. S .. "§æi thµnh kiÓu nam-nam tİnh")
        ChangeSexAndPortrait(0, 5)
    end
end

function Get_BackItem()
    CloseDialog()
    local nStep = GetTaskByte(Task_GetBackItem, 3)
    local nYear, nMonth, nDay = GetYMD()
    local item = GetBack_Info[nNpcIndex].itemInfo

    if (nYear == 2011 and ((nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7)) and GetTaskByte(Task_GetBackItem, 2) == nNpcIndex) then
        if (nStep == 1) then
            TaskNote(1612, 1, GetBack_Info[nNpcIndex].itemName, "Hå Hû MŞ")
            SetTaskByte(Task_GetBackItem, 3, 2)
            Talk(2, "no", "Nghe nãi" .. GetBack_Info[nNpcIndex].mapName .. " bŞ c­íp mÊt råi" .. GetBack_Info[nNpcIndex].itemName .. ", h·y gióp t«i ®o¹t l¹i b¶o khİ tõ tay cña chóng!", "Nghe nãi ®· khuÊt phôc" .. GetBack_Info[nNpcIndex].mapName .. " cµng s©u trong ®éng th× x¸c suÊt nhËn ®­îc b¶o khİ cµng lín, tuy nhiªn b¹n còng cã thÓ mua tõ ng­êi ch¬i kh¸c.")
        elseif (nStep == 2) then
            if (HaveNormalItem(item[1], item[2], item[3], item[4]) > 0) then
                TaskNote(1612, -1)
                SetTaskByte(Task_GetBackItem, 3, 0)
                DelNormalItem(item[1], item[2], item[3], item[4])

                local lv = GetLevel()
                local nExp = 0
                if (lv >= 30 and lv <= 50) then
                    nExp = lv * 1000
                elseif (lv >= 51 and lv <= 90) then
                    nExp = lv * 2000
                elseif (lv >= 91 and lv <= 150) then
                    nExp = lv * 3000
                elseif (lv >= 151 and lv <= 200) then
                    nExp = lv * 4000
                end

                AddOwnExp(nExp)
                ScrollMessage("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
                Msg2Player("B¹n nh©n ®­îc " .. nExp .. " kinh nghiÖm")
                WriteLog(GetName() .. "Hoµn thµnh nhiÖm vô T×m b¶o khİ")
                Talk(1, "no", "T×m ®­îc nhanh thÕ sao, ®a t¹ ®¹i hiÖp, xin h·y nhËn lÊy phÇn th­ëng kinh nghiÖm!")
            else
                Talk(1, "no", "§¹i hiÖp vÉn ch­a gióp ta" .. GetBack_Info[nNpcIndex].itemName .. " tõ tay cña yªu ma, h·y ®i mau, thêi gian kh«ng cßn nhiÒu!")
            end
        end
    end
    refreshNpcTaskState()
end

