--description: À×Õð×Ó-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27

GLOBAL_VALUE_ENTER_COUNT = 198
TASK_ASW_STAR_STATE = 1403
TASK_ASW_TIME = 1404
TASK_ASW_STAR_STATE_1 = 1405
TASK_ASW_STAT_STATE_2 = 1406

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --´óÊÆËùÇ÷
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    tasks = {
        { "ThÕ Së", "renwu1"; show = 0 },
        { "<c=yel>V¨n Khóc h¹ phµm<c>", "subject"; show = 0 },
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

-------------------------------------ÎÄÇúÏÂ·²»î¶¯------------------------------------------

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
            local nRandSeed = random(1, 100)
            for i = 1, getn(LIB_RANDOM), 1 do

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

        nQueIndex = random(1, GetQuestionNum(nLibIndex))

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

    local nRand = random(1, 100)
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
        MsgBox(" Muèn ®­îc TrÝ §a Tinh gióp ®ì, ph¶i nép cho ta <c=g>" .. Cfs .. "TiÒn ®ång<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i! NÕu <c=g> x¸c ®Þnh <c>, TrÝ ®a tinh nhÊt ®Þnh sÏ gióp ng­¬i hoµn thµnh c©u hái hiÖn t¹i, chØ lµ kh«ng biÕt ý ng­¬i thÕ nµo ?", "useIBFin", "no")
    else
        Talk(1, "subject", " Muèn ®­îc TrÝ §a Tinh gióp ®ì, ph¶i nép cho ta <c=g>" .. Cfs .. "TiÒn ®ång<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i!")
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

-----------------------------------------------------------------------------------

function fangchenmi()
    --if  it return 0, the 5-hour limit rules executed
    local state
    local mark
    --	if  you don't want this function executed then	you can set state equal to zero
    --		state=0
    --	else
    state = GetWeakState()    --state=0, not in limited time; state=1, in 3 hours-limit; state=2, in 5 hours limit
    --	end
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
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
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
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;
