module("XUANWUSL", package.seeall)

TrialMission = 27

Mapid = 86
MaxTimes = 2

XuanwuTrialTask = 2018

XuanwuTrial = 672

XuanwuQuest = 2034

XuanwuQuesTime = 2035

XuanwuFirst = 2036

SLTime = {
    [1] = { ApplicantsTime = { 11, 20 }, BeginTime = { 11, 30 }, EndTime = { 11, 50 }, },
    [2] = { ApplicantsTime = { 14, 20 }, BeginTime = { 14, 30 }, EndTime = { 14, 50 }, },
    [3] = { ApplicantsTime = { 17, 20 }, BeginTime = { 17, 30 }, EndTime = { 17, 50 }, },
    [4] = { ApplicantsTime = { 19, 20 }, BeginTime = { 19, 30 }, EndTime = { 19, 50 }, },

}

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

QuestList = {

    [1] = { TaskInfo = "ChiÕm lÜnh VËt tæ HuyÒn Vò, sè l­îng vËt tæ chiÕm lÜnh cµng nhiÒu, kinh nghiÖm th­ëng lóc hoµn thµnh cµng lín.", Count = { 1, 2, 3, 4 }, ExpType = 1, Exp = { 5000, 5500, 6000, 7500 }, PowerNeed = -1, BeginStep = 1, FinishStep = 2, CampNeed = -1,
            Power2Percent1 = { { 999999, 20 }, },
            Power2Percent2 = { { 24999, 70 }, { 999999, 50 }, },
    },

    [2] = { TaskInfo = "§¸nh b¹i ng­êi khiªu chiÕn, ®¸nh b¹i cµng nhiÒu ng­êi, kinh nghiÖm th­ëng lóc hoµn thµnh cµng lín.", Count = { 5, 10, 15, 20, 25 }, ExpType = 1, Exp = { 4000, 5500, 7000, 8500, 11000 }, PowerNeed = -1, BeginStep = 1, FinishStep = 2, CampNeed = 1,
            Power2Percent1 = { { 999999, 40 }, },
            Power2Percent2 = { { -1, -1 }, },
    },

    [3] = { TaskInfo = "§¸nh b¹i 1 HuyÒn Vò Chi ¶nh, lµ ng­êi kÕt thóc míi ®­îc tİnh.", Count = { 1 }, ExpType = 1, Exp = { 8500 }, PowerNeed = 25000, BeginStep = 1, FinishStep = 2, CampNeed = 2,
            Power2Percent1 = { { -1, -1 }, },
            Power2Percent2 = { { 24999, 0 }, { 999999, 20 }, },
    },

    [4] = { TaskInfo = "Th¾ng 1 lÇn thİ luyÖn.", Count = { 1 }, ExpType = 1, Exp = { 8000 }, PowerNeed = -1, BeginStep = 1, FinishStep = 2, CampNeed = -1,
            Power2Percent1 = { { 999999, 10 }, },
            Power2Percent2 = { { 24999, 30 }, { 999999, 30 }, },
    },

    [5] = { TaskInfo = "Trong thİ luyÖn lµ HuyÒn Vò Chi ¶nh vµ sèng sãt İt nhÊt 5 phót", Count = { 5 }, ExpType = 1, Exp = { 8500 }, PowerNeed = -1, BeginStep = 1, FinishStep = 2, CampNeed = 1,
            Power2Percent1 = { { 999999, 30 }, },
            Power2Percent2 = { { -1, -1 }, },
    },
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
    ClearQuest()
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)

    if (GetLevel() >= 80) then
        if (QuestType == 0 and QuestStep == 0) then
            state = 1
            subState = 0
        elseif (QuestStep == 1) then
            state = 1
            subState = 0
        elseif (QuestStep == 2) then
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

function no()
    CloseDialog()
end

function EnterCheck()
    local PLvl = GetLevel()
    local TrialMissionState = GetGlobalValueByte(XuanwuTrial, 1)
    local PlayerNum = GetGlobalValueByte(XuanwuTrial, 2)
    local EnterState = GetTaskByte(XuanwuTrialTask, 1)
    local nFlag = 1
    local week = GetWeekDay()

    if (PLvl < 80) then
        Talk(1, "no", "Thİ luyÖn HuyÒn Vò cÇn nh÷ng anh hïng cã thùc lùc nhÊt ®Şnh míi cã thÓ tham gia, ch­a ®¹t <c=g>80 cÊp<c>, thø cho t¹i h¹ kh«ng thÓ ®­a ngµi vµo trong.")
        nFlag = 0
    elseif (GetPK() > 0) then
        Talk(1, "no", "HuyÒn Vò ThÇn Vùc lµ n¬i tu hµnh thanh tŞnh, ngµi mang trªn ng­êi tµ khİ kh«ng thÓ tiÕn vµo. H·y thanh trõ tµ khİ tr­íc råi l¹i tíi.")
        nFlag = 0
    elseif (GetCamp() ~= 7) then
        Talk(1, "no", "HuyÒn Vò ThÇn Vùc lµ n¬i tu hµnh thanh tŞnh, phe chiÕn ®Êu hoµ b×nh míi cã thÓ tham gia.")
        nFlag = 0
    elseif (GetMorphType() > 0) or (IsPlayerInsideWeapon(_G.PlayerIndex) > 0) then
        Talk(1, "no", "Tr¹ng th¸i hiÖn t¹i cña ngµi kh«ng phï hîp ®Ó tiÕn vµo HuyÒn Vò ThÇn Vùc.")
        nFlag = 0
    elseif (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Ngµi cã qu¸ nhiÒu tr¹ng th¸i buff, xin h·y dän dÑp bít tr­íc khi vµo.")
        nFlag = 0
    elseif (TrialMissionState ~= 2 and HaveIBBuff(1751) <= 0) then
        Talk(1, "no", "Thêi gian b¸o danh Thİ luyÖn HuyÒn Vò ®· qua, xin lÇn sau l¹i tíi.")
        nFlag = 0
    elseif (PlayerNum >= 50 and EnterState ~= 1) then
        Talk(1, "no", "Sè ng­êi xin tham gia Thİ luyÖn HuyÒn Vò ®· ®¹t tèi ®a 50 ng­êi, xin anh hïng h·y ®îi lÇn sau l¹i ®Õn.")
        nFlag = 0
    elseif (week == 9 or week == 10) then
        Talk(1, "no", "Thİ luyÖn HuyÒn Vò më vµo Chñ NhËt vµ thø 2, anh hïng h·y chó ı ®Õn ®óng giê.")
        nFlag = 0
    end

    return nFlag
end

function RemainTimes(Type)
    local H, M, S = GetHMS()
    local H1, M1, S1 = 0,0,0
    local Rtimes = 0
    local TimeType = {}

    if (Type == 1) then
        for i = 1, #SLTime do
            TimeType[i] = SLTime[i].ApplicantsTime
        end
    elseif (Type == 2) then
        for i = 1, #SLTime do
            TimeType[i] = SLTime[i].BeginTime
        end
    elseif (Type == 3) then
        for i = 1, #SLTime do
            TimeType[i] = SLTime[i].EndTime
        end
    end

    for i = 1, #SLTime do
        if ((H == TimeType[4][1] and M > TimeType[4][2]) or H > TimeType[4][1]) then
            Rtimes = ((TimeType[1][1] + 24) * 3600 + TimeType[1][2] * 60) - (H * 3600 + M * 60 + S)
            if (Rtimes > 0) then
                H1 = math.floor(Rtimes / 3600)
                M1 = math.floor(math.mod(Rtimes, 3600) / 60)
                S1 = math.floor(math.mod(Rtimes, 60))
                break
            end
        elseif ((H == TimeType[i][1] and M < TimeType[i][2]) or H < TimeType[i][1]) then
            Rtimes = ((TimeType[i][1]) * 3600 + TimeType[i][2] * 60) - (H * 3600 + M * 60 + S)
            if (Rtimes > 0) then
                H1 = math.floor(Rtimes / 3600)
                M1 = math.floor(math.mod(Rtimes, 3600) / 60)
                S1 = math.floor(math.mod(Rtimes, 60))
                break
            end
        end
    end

    return H1, M1, S1, Rtimes
end

function EnterSL()
    local PLvl = GetLevel()
    local TrialMissionState = GetGlobalValueByte(XuanwuTrial, 1)
    local PlayerNum = GetGlobalValueByte(XuanwuTrial, 2)
    local EnterState = GetTaskByte(XuanwuTrialTask, 1)

    if (TrialMissionState == 0 or TrialMissionState == 1) then
        local H, M, S, Rtime = RemainTimes(1)
        Talk(1, "no", "Thİ luyÖn HuyÒn Vò ch­a b¾t ®Çu, thø lçi cho t¹i h¹ kh«ng thÓ ®­a ngµi vµo. Ngµi cã thÓ chê lÇn Thİ luyÖn HuyÒn Vò kÕ tiÕp më th× b¸o danh tham gia\n\nC¸ch lÇn më thİ luyÖn tiÕp theo cßn: " .. H .. " giê " .. M .. " phót " .. S .. " gi©y")
    elseif (TrialMissionState == 2) then
        if (EnterCheck() == 0) then
            return
        end
        if (HaveIBBuff(1750) <= 0) then
            MsgBox("B¸o danh tham gia Thİ luyÖn HuyÒn Vò cÇn nép <c=g>5 c¸i Tø T­îng Tinh Hoa<c>, hiÖn t¹i ®· cã " .. PlayerNum .. " vŞ anh hïng xin tham gia thİ luyÖn, ngµi x¸c ®Şnh muèn vµo sao?", "EnterSLSure", "no")
        else
            local H0, M0, S0, Rtime = RemainTimes(2)
            MsgBox("Thİ luyÖn HuyÒn Vò sÏ më sau " .. H0 .. " giê" .. M0 .. " phót" .. S0 .. ", hiÖn t¹i ®· cã " .. PlayerNum .. " vŞ anh hïng xin tham gia thİ luyÖn, ngµi x¸c ®Şnh muèn vµo sao?", "DoEnter", "no")
        end

    elseif (TrialMissionState == 3) then
        if (HaveIBBuff(1751) > 0) then
            local H0, M0, S0, Rtime = RemainTimes(3)
            MsgBox("Thİ luyÖn HuyÒn Vò sÏ kÕt thóc sau " .. H0 .. " giê" .. M0 .. " phót" .. S0 .. ", hiÖn t¹i ®· cã " .. PlayerNum .. " vŞ anh hïng xin tham gia thİ luyÖn, ngµi x¸c ®Şnh muèn vµo sao?", "DoEnter", "no")
        else
            local H0, M0, S0, Rtime = RemainTimes(1)
            Talk(1, "no", "Thİ luyÖn HuyÒn Vò ®· b¾t ®Çu, t¹i h¹ kh«ng thÓ ®­a ngµi gia nhËp, ngµi cã thÓ chê lÇn Thİ luyÖn HuyÒn Vò tiÕp theo b¸o danh vµ tham gia\n\nC¸ch lÇn më thİ luyÖn tiÕp theo cßn: " .. H0 .. " giê " .. M0 .. " phót " .. S0 .. " gi©y")
        end
    end
end

function EnterSLSure()
    local PlayerNum = GetGlobalValueByte(XuanwuTrial, 2)
    local H0, M0, S0, Rtime = RemainTimes(2)

    if (EnterCheck() == 0) then
        return
    end

    if (HaveNormalItem(3, 115, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 115, 0, 0)
        end
        AddIBBuff(1750, Rtime)
        SetTask(XuanwuTrialTask, 1, 1)
        SetGlobalValueByte(XuanwuTrial, 2, PlayerNum + 1)
        MsgBox("Ngµi thµnh c«ng b¸o danh tham gia Thİ luyÖn HuyÒn Vò lÇn nµy, trong thêi gian b¸o danh cã thÓ tiÕn vµo HuyÒn Vò ThÇn Vùc, ngµi muèn vµo b©y giê sao?\n\n<c=g>Chó ı: NÕu lóc thİ luyÖn b¾t ®Çu ngµi kh«ng cã trong HuyÒn Vò ThÇn Vùc sÏ tù ®éng bŞ mÊt t­ c¸ch tham gia.<c>", "DoEnter", "no")
        WriteLog("[Thİ luyÖn HuyÒn Vò][" .. GetName() .. "][B¸o danh tham gia]")
    else
        Talk(1, "no", "B¸o danh tham gia Thİ luyÖn HuyÒn Vò cÇn nép <c=g>5 c¸i Tø T­îng Tinh Hoa<c> ngµi ch­a cã ®ñ Tø T­îng Tinh Hoa")
    end
end

function DoEnter()
    local TrialMissionState = GetGlobalValueByte(XuanwuTrial, 1)
    local CampType = GetTaskByte(XuanwuTrialTask, 2)
    LeaveTeam()
    SetTempRevPos(Mapid, 1216 * 32, 2886 * 32)
    SetPunish(0)
    LockCamp(1)
    SetCamp(7)
    local oldworld = _G.SubWorld
    _G.SubWorld = SubWorldID2Idx(Mapid)
    AddMSPlayer(TrialMission, 1)
    _G.SubWorld = oldworld
    SetTeamFreezeFlag(1)
    if (TrialMissionState > 2 and TrialMissionState < 4) then
        SetFightState(1)
        if (CampType == 2) then
            SetCamp(4)

            PolyMorph(38, 1, 0, -1, 25 * 60, 1, 1)
            LockPolyMorph(1)

        end

    else
        SetFightState(0)
    end
    NewWorld(Mapid, 1216, 2886)
end

function ExitSL()
    if (IsPlayerInsideWeapon(_G.PlayerIndex) > 0) then
        Talk(1, "no", "Ngµi ®ang trong tr¹ng th¸i ThÇn Hån Phô ThÓ, kh«ng thÓ ra khái HuyÒn Vò ThÇn Vùc.")
        return
    end

    MsgBox("Sau khi rêi khái Tø T­îng ThÇn Vùc cã thÓ t×m Thİ LuyÖn ThÇn Sø ®Ó quay l¹i, ngµi x¸c ®Şnh rêi khái Tø T­îng ThÇn Vùc sao?", "ExitSLSure", "no")
end

function ExitSLSure()
    SetPunish(1)
    LockCamp(1)
    SetCamp(7)
    SetTeamFreezeFlag(0)
    SetFightState(0)
    NewWorld(21, 1770, 3042)
end

function SLExplain()
    Talk(1, "SLExplain1", "Thêi gian më thİ luyÖn:\n<c=g>Hµng ngµy lóc 11:20, 14:20, 17:20, 19:20<c>\n§iÒu kiÖn tham gia:\n<c=g>§¼ng cÊp 80 trë lªn<c>\n\nThêi gian b¸o danh lµ 10 phót, tÊt c¶ anh hïng kh«ng cã trong thİ luyÖn tr­êng tr­íc thêi ®iÓm b¸o danh kÕt thóc sÏ kh«ng thÓ tham gia thİ luyÖn\n\n<c=g>Khi b¸o danh cÇn nép 5 Tø T­îng Tinh Hoa cho Bæn thÇn<c>")
end

function SLExplain1()
    Talk(2, "no", "Trong thêi gian thİ luyÖn 1 bé phËn anh hïng sÏ ngÉu nhiªn trë thµnh HuyÒn Vò Chi ¶nh, nÕu cã thÓ gi÷ tr¹ng th¸i HuyÒn Vò Chi ¶nh tíi lóc KÕt thóc Thİ luyÖn sÏ giµnh chiÕn th¾ng. C¸c anh hïng cßn l¹i cÇn ®¸nh b¹i HuyÒn Vò Chi ¶nh míi giµnh th¾ng lîi.\n\n<c=g>Thİ luyÖn tèi ®a 50 ng­êi tham gia, İt h¬n 5 ng­êi thİ luyÖn sÏ bŞ huû<c>", "Ngoµi ra trong thİ luyÖn tr­êng cã 4 vËt tæ, lµ mÊu chèt cña th¾ng b¹i\n\nAnh hïng giµnh th¾ng lîi sÏ nhËn ®­îc chóc phóc ThÇn Thó, nhËn ®­îc <c=y>Phï Th¹ch ThÇn Bİ<c> gióp c­êng ho¸ kü n¨ng\n\n<c=g>§Õn gÇn vËt tæ sÏ b¾t ®Çu chiÕm lÜnh vËt tæ, cµng ®«ng ng­êi chiÕm cµng nhanh<c>")
end

function SkillStone()
    no()
    Talk(3, "SkillStone1", "Phï th¹ch lµ do Ngò Th¸i Linh Th¹ch cña N÷ Oa biÕn thµnh, anh hïng ®o¹t ®­îc phï th¹ch cã thÓ nhËn ®­îc ph¸p lùc cña ThÇn Thó, c­êng ho¸ kü n¨ng. Phï Th¹ch cã thÓ kh¶m ë giao diÖn Ng­ng-F5 gióp c­êng ho¸ ®Æc hiÖu, thay ®æi ph¹m vi, c¸ch xuÊt chiªu, s¸t th­¬ng, bæ sung thªm ®Æc hiÖu.", "Tham gia Thİ luyÖn HuyÒn Vò cã thÓ nhËn ®­îc M¶nh Phï Th¹ch, 100 M¶nh Phï Th¹ch cã thÓ hîp thµnh 1 Phï Th¹ch s¬ cÊp, mçi anh hïng tèi ®a cã thÓ dïng 6 Phï Th¹ch c­êng ho¸ b¶n th©n", "NÕu nhËn ®­îc phï th¹ch cÊp cao h¬n, cã thÓ th¸o phï th¹ch hiÖn t¹i xuèng hoÆc thay thÕ ®Ó sö dông.\n\n<c=g>Xİch Tïng Tö t¹i Diªu Tr× biÕt c¸ch hîp thµnh vµ n©ng cÊp Phï Th¹ch<c>")
end

function SkillStone1()
    no()
    Talk(1, "SkillStone2", "<c=g>Quy t¾c ng­ng tô Phï Th¹ch:<c>\nNg­ng tô Phï Th¹ch cÊp 1: Phï Th¹ch cÊp 1 +Ng­ng ThÇn Sa+ 50 v¹n b¹c\nNg­ng tô Phï Th¹ch cÊp 2: Phï Th¹ch cÊp 2 +Ng­ng ThÇn Sa*3+ 80 v¹n b¹c\nNg­ng tô Phï Th¹ch cÊp 3: Phï Th¹ch cÊp 3 +Ng­ng ThÇn Th¹ch+ 110 v¹n b¹c\nNg­ng tô Phï Th¹ch cÊp 4: Phï Th¹ch cÊp 4 +Ng­ng ThÇn Th¹ch*3+ 140 v¹n b¹c\nNg­ng tô Phï Th¹ch cÊp 5: Phï Th¹ch cÊp 5 +Ng­ng ThÇn Ch©u+ 170 v¹n b¹c\n<c=g>Tû lÖ thµnh c«ng: 100%<c>")
end

function SkillStone2()
    no()
    Talk(2, "no", "<c=g>Quy t¾c rót Phï Th¹ch<c>\nPhï Th¹ch cÊp 1:  200 v¹n b¹c+ Tinh Th¹ch S¬ cÊp +Ng­ng ThÇn Sa\nPhï Th¹ch cÊp 2:  320 v¹n b¹c+ Tinh Th¹ch S¬ cÊp *3+Ng­ng ThÇn Sa*3\nPhï Th¹ch cÊp 3:  440 v¹n b¹c+Tinh Th¹ch Trung CÊp+Ng­ng ThÇn Th¹ch\nPhï Th¹ch cÊp 4:  560 v¹n b¹c+Tinh Th¹ch Trung CÊp*3+Ng­ng ThÇn Th¹ch*3\nPhï Th¹ch cÊp 5:  680 v¹n b¹c+Tinh Th¹ch Cao CÊp+Ng­ng ThÇn Ch©u\n<c=g>Phï Th¹ch ®­îc gi÷ l¹i, tØ lÖ thµnh c«ng 100%<c>", "<c=g>Quy t¾c Xo¸ Phï Th¹ch<c>\nPhï Th¹ch cÊp 1:  200 v¹n b¹c\nPhï Th¹ch cÊp 2:  320 v¹n b¹c\nPhï Th¹ch cÊp 3:  440 v¹n b¹c\nPhï Th¹ch cÊp 4:  560 v¹n b¹c\nPhï Th¹ch cÊp 5:  680 v¹n b¹c\n<c=g>Phï th¹ch sÏ biÕn mÊt, tØ lÖ thµnh c«ng 100%<c>")
end

function GetQuest()
    no()
    ClearQuest()
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)
    local PlayerLvl = GetLevel()
    local PlayerPower = GetPowerValue()

    if (QuestTime >= MaxTimes and QuestStep == 0) then
        Talk(1, "main", "Ngµi h«m nay ®· hoµn thµnh " .. QuestTime .. " lÇn nhiÖm vô Thİ luyÖn HuyÒn Vò, kh«ng thÓ nhËn thªm. Xin ngµy mai h·y quay l¹i.")
        return
    end

    local tasks = {
        [1] = { "NhËn nhiÖm vô", "GetQuestEnter"; show = 0 },
        [2] = { "Hoµn thµnh nhiÖm vô", "GetQuestEnter"; show = 0 },
        [3] = { "Hñy nhiÖm vô", "GiveUpQuest"; show = 0 },
        [4] = { "Quay l¹i", "main"; show = 1 },
    }

    if (QuestStep == 0 and PlayerLvl >= 80) then
        tasks[1].show = 1
    end

    if (QuestStep > 0 and QuestType > 0 and QuestType <= #QuestList) then
        tasks[3].show = 1
        if (QuestStep == QuestList[QuestType].FinishStep) then
            tasks[2].show = 1
        end
    end

    SayTask("Thiªn ®¹o v·ng phôc, chu nhi phôc thuû. Ta mang ®Õn thİ luyÖn cho anh hïng tam giíi, nÕu cã thÓ hoµn thµnh nhiÖm vô ta giao, cã thÓ nhËn phÇn th­ëng kinh nghiÖm phong phó!", tasks)
end

function GetQuestEnter()
    no()
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)
    local PlayerLvl = GetLevel()
    local PlayerPower = GetPowerValue()
    local nFirstFlag = GetTaskByte(XuanwuFirst, 1)
    local nExp = 0

    if (QuestType < 0 or QuestType > #QuestList) then
        Talk(1, "main", "NhiÖm vô anh hïng nhËn tr­íc ®ã ®· qu¸ h¹n, h·y huû vµ nhËn l¹i.")
        WriteLog("[NhiÖm vô Thİ luyÖn HuyÒn Vò][VÊn ®Ò khi nhËn nhiÖm vô][Lo¹i nhiÖm vô " .. QuestType .. "]")
        return
    end

    if (QuestStep == 0 and QuestType == 0) then
        MsgBox("Xem ra anh hïng ®· s½n sµng tiÕp nhËn nhiÖm vô cña ta, néi dung nhiÖm vô sau khi tham gia Thİ luyÖn HuyÒn Vò, lóc thİ luyÖn b¾t ®Çu ta sÏ th«ng b¸o. Anh hïng x¸c ®Şnh muèn nhËn nhiÖm vô sao?", "GetQuestSure", "GetQuest")
    elseif (QuestStep >= QuestList[QuestType].FinishStep) then
        for i = 1, #QuestList[QuestType].Count do
            if (QuestCount >= QuestList[QuestType].Count[i]) then
                if (QuestList[QuestType].ExpType == 1) then
                    nExp = QuestList[QuestType].Exp[i] * PlayerLvl
                elseif (QuestList[QuestType].ExpType == 2) then
                    nExp = QuestList[QuestType].Exp[i]
                end
            else
                break
            end
        end

        if (nFirstFlag == 0) then
            AddNormalItemBind(6, 1, 1297, 0, 0, 0, 1)
            SetTaskByte(XuanwuFirst, 1, 1)
        end

        Talk(1, "no", "NhiÖm vô lÇn nµy cña anh hïng lµ " .. QuestList[QuestType].TaskInfo .. "\n\nC¨n cø vµo biÓu hiÖn lÇn nµy, nhËn ®­îc " .. nExp .. " ®iÓm kinh nghiÖm. ")
        AddOwnExp(nExp)
        SetTaskByte(XuanwuQuest, 1, 0)
        SetTaskByte(XuanwuQuest, 2, 0)
        SetTaskByte(XuanwuQuest, 3, 0)
        SetTaskByte(XuanwuQuest, 4, (QuestTime + 1))
        TaskNote(XuanwuQuest, -1)
        WriteLog("[NhiÖm vô Thİ luyÖn HuyÒn Vò][Hoµn thµnh nhiÖm vô]")
    end
    refreshNpcTaskState()
end

function GetQuestSure()
    no()
    Talk(1, "no", "§· thµnh c«ng nhËn nhiÖm vô, néi dung nhiÖm vô sau khi tham gia Thİ luyÖn HuyÒn Vò, lóc thİ luyÖn b¾t ®Çu ta sÏ th«ng b¸o\n\n<c=g>NhiÖm vô sÏ ®­îc lµm míi lóc 0h, xin h·y sím hoµn thµnh tr­íc thêi gian nµy.")
    SetTaskByte(XuanwuQuest, 2, 1)
    TaskNote(XuanwuQuest, 0)
    refreshNpcTaskState()
    WriteLog("[NhiÖm vô Thİ luyÖn HuyÒn Vò][NhËn nhiÖm vô]")
end

function GiveUpQuest()
    no()
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)

    MsgBox("Anh hïng x¸c nhËn muèn huû nhiÖm vô lÇn nµy chø?\n\n<c=g>Nh¾c nhë: Huû nhiÖm vô vÉn tİnh sè lÇn nhiÖm vô.<c>", "GiveUpQuestSure", "GetQuest")

end

function GiveUpQuestSure()
    no()
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)

    QuestTime = QuestTime + 1
    Talk(1, "no", "§· huû nhiÖm vô lÇn nµy, h«m nay cßn cã thÓ nhËn <c=g>" .. (math.max((MaxTimes - QuestTime), 0)) .. "<c> lÇn nhiÖm vô thİ luyÖn.")
    SetTaskByte(XuanwuQuest, 1, 0)
    SetTaskByte(XuanwuQuest, 2, 0)
    SetTaskByte(XuanwuQuest, 3, 0)
    SetTaskByte(XuanwuQuest, 4, QuestTime)
    TaskNote(XuanwuQuest, -1)
    WriteLog("[NhiÖm vô Thİ luyÖn HuyÒn Vò][Huû nhiÖm vô]")

end

function SayQuest()
    no()
end

function ClearQuest()
    local Lastday = GetTask(XuanwuQuesTime)
    local Today = math.floor(LocalSystemTime() / 86400)
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    if (Lastday ~= Today and ((QuestType == 0) or (QuestType > 0 and QuestType <= #QuestList and QuestStep < QuestList[QuestType].FinishStep))) then
        SetTask(XuanwuQuesTime, Today)
        SetTask(XuanwuQuest, 0)
        SetTask(XuanwuFirst, 0)
        TaskNote(XuanwuQuest, -1)
    end
end

function RandomQuest(Camp)
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)
    local PlayerLvl = GetLevel()
    local PlayerPower = GetPowerValue()
    local nRandom = math.random(1, 100)
    local oper = 1
    local TaskList = {}
    local TaskChance = {}

    if (QuestStep ~= 1 or QuestType ~= 0) then
        return
    end

    for i = 1, #QuestList do
        if ((QuestList[i].CampNeed == -1 or QuestList[i].CampNeed == Camp) and PlayerPower >= QuestList[i].PowerNeed) then
            TaskList[oper] = i

            if (Camp == 1) then
                for j = 1, #QuestList[i].Power2Percent1 do
                    if (PlayerPower <= QuestList[i].Power2Percent1[j][1]) then
                        TaskChance[oper] = QuestList[i].Power2Percent1[j][2]
                        break
                    end
                end
            elseif (Camp == 2) then
                for j = 1, #QuestList[i].Power2Percent2 do
                    if (PlayerPower <= QuestList[i].Power2Percent2[j][1]) then
                        TaskChance[oper] = QuestList[i].Power2Percent2[j][2]
                        break
                    end
                end
            end

            oper = oper + 1
        end
    end

    for i = 1, #TaskChance do
        local Chance = 0
        for j = 1, i do
            Chance = Chance + TaskChance[j]
        end

        if (nRandom < Chance) then
            SetTaskByte(XuanwuQuest, 1, TaskList[i])
            if (GetIBBuffCount() >= 32 and TaskList[i] == 5) then
                SetTaskByte(XuanwuQuest, 1, 1)
            end
            break
        end
    end

    if (GetTaskByte(XuanwuQuest, 1) == 5) then
        AddIBBuff(1779, 60)
    end
    QuestType = GetTaskByte(XuanwuQuest, 1)
    if (QuestType > #QuestList or QuestType <= 0) then
        QuestType = 1
        SetTaskByte(XuanwuQuest, 1, 1)
    end

    Msg2Player("NhiÖm vô lÇn nµy cña ngµi lµ " .. QuestList[QuestType].TaskInfo)
    WriteLog("[NhiÖm vô Thİ luyÖn HuyÒn Vò][NhiÖm vô ngÉu nhiªn][Lo¹i" .. QuestType .. "]")
    TaskCheck(-1)
    refreshNpcTaskState()
end

function TaskCheck(index)
    local QuestType = GetTaskByte(XuanwuQuest, 1)
    local QuestStep = GetTaskByte(XuanwuQuest, 2)
    local QuestCount = GetTaskByte(XuanwuQuest, 3)
    local QuestTime = GetTaskByte(XuanwuQuest, 4)
    local PlayerLvl = GetLevel()
    local Param = {}

    if (QuestType == index or (index == -1 and QuestType > 0)) then
        local Max = #QuestList[QuestType].Count
        if (QuestCount < QuestList[QuestType].Count[Max] and index ~= -1) then
            QuestCount = QuestCount + 1
            SetTaskByte(XuanwuQuest, 3, QuestCount)
        end

        if (QuestCount >= QuestList[QuestType].Count[1]) then
            SetTaskByte(XuanwuQuest, 2, 2)
        end

        for i = 1, #QuestList[QuestType].Count do
            if (QuestCount >= QuestList[QuestType].Count[i]) then
                Param[i] = QuestList[QuestType].Count[i]
            else
                Param[i] = QuestCount
            end
        end

        if (QuestType == 1) then
            TaskNote(XuanwuQuest, QuestType, Param[1], Param[2], Param[3], Param[4])
        elseif (QuestType == 2) then
            TaskNote(XuanwuQuest, QuestType, Param[1], Param[2], Param[3], Param[4], Param[5])
        else
            TaskNote(XuanwuQuest, QuestType, Param[1])
        end
    end
    refreshNpcTaskState()
end



