--description:npc
--author: zhujialiang
--date:2005/4/13

--taskÊéÐ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-28
------------ÎÊÃüÖ®Ç© Add by gaojignwei at 2009/04/08 begin--------
Task_Divination = 1375        --1byte:1ÔÚØÔÊ¦´¦ÁìÈÎÎñ 2ÔÚËãÃüÏÈÉú´¦ÁìÈÎÎñ 3ÔÚÄÏ¼«ÏÉÎÌ´¦ÁìÈÎÎñ 4»Ø¸´ÄÏ¼«ÏÉÎÌ¼ÓbuffA 5Áìµ½¾Å×ªµ¤ 6ÔÚËãÃüÏÈÉú´¦¾­Ñé½±Àø
--7µÃµ½Ç© 8Íê³ÉÓ¦Ç©ÈÎÎñ 2byte ²É¼¯ºìÓñ²ÝµÄ¸öÊý 3byte²É¼¯ÓÄÚ¤²ÝµÄ¸öÊý 4byteÉ±ËÀ¹íÔ¦µÄ¸öÊý
Task_Label_Type = 1376      --1byte: 1ÄÉ²ÆÇ© 2Ñª¹âÇ© 3ÒËÉ«Ç©
Buff_Make_Drug = 636           --1·ÖÖÓÖÆÒ©buff
Buff_Add_Life = 635           --1Ð¡Ê±»Ø¸´ÉúÃü¼°ÄÚÁ¦buff
Buff_Polymorph = 404        --°ëÐ¡Ê±±äÉíbuff
Buff_Plutus = 228            --Ìì½«²ÆÉñbuff
Task_Num = 1039                --taskinfoµÄ±àºÅ
------------ÎÊÃüÖ®Ç© Add by gaojignwei at 2009/04/08 end--------

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

    --ÎÊÃüÖ®Ç©
    startLevel = 27
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Divination, 1)
        local labelType = GetTaskByte(Task_Label_Type, 1)
        local playerType = GetPlayerType()
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
            if (step == 7 and labelType == 1) then
                state = 3
                subState = 0
            elseif (step == 7 and labelType == 1 and HaveNormalItem(3, 13, 0, 0) >= 10 and HaveNormalItem(3, 9, 0, 0) >= 10) then
                state = 3
                substate = 0
            elseif (step == 7 and HaveNormalItem(3, 13, 0, 0) < 10 and HaveNormalItem(3, 9, 0, 0) < 10) then
                state = 2
                substate = 0
            end
        else
            if (step == 7 and labelType == 1) then
                state = 3
                subState = 1
            elseif (step == 7 and labelType == 1 and HaveNormalItem(3, 13, 0, 0) >= 10 and HaveNormalItem(3, 9, 0, 0) >= 10) then
                state = 3
                substate = 1
            elseif (step == 7 and HaveNormalItem(3, 13, 0, 0) < 10 and HaveNormalItem(3, 9, 0, 0) < 10) then
                state = 2
                substate = 0
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
        { "<c=yel>VÊn MÖnh Chi Thiªm<c>", "divination"; show = 0 },
        { "<c=yel>V¨n Khóc h¹ phµm<c>", "subject"; show = 0 },
    }

    local step = GetTaskByte(Task_Divination, 1)
    local labelType = GetTaskByte(Task_Label_Type, 1)
    if (step == 7 and labelType == 1) then
        tasks[1].show = 1
    end

    local H, M, S = GetHMS()
    local y1, m1, d1 = GetYMD()
    local w, x, y = GetWorldPos()
    local state = GetTaskByte(TASK_ASW_STAR_STATE, 1)
    if ((d1 == 1) or (d1 == 15)) and (H >= 19) and (H < 22) and (w == 20) and (state == 1) then
        tasks[2].show = 1
    end

    SayTask(11215, tasks)
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
    30,
    50,
    70,
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

    if (npctype ~= 4) then
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
        Talk(1, "no", "TrÝ ®a tinh ë thiªn ®×nh lo rÊt nhiÒu viÖc, nh­ng nÓ mÆt V¨n Khóc Tinh qu©n míi ®ång ý gióp ®ì, nh­ng nãi tr­íc ng­êi tham gia chØ ®­îc xin gióp ®ì <c=g>5<c> lÇn, nÕu v­ît qu¸ giíi h¹n trªn th× kh«ng gióp n÷a! sè lÇn ng­¬i nhê gióp ®· v­ît giíi h¹n, nªn trong ho¹t ®éng lÇn nµy  ng­¬i sÏ  kh«ng thÓ nhËn tiÕp ®­îc sù gióp ®ì cña TrÝ ®a tinh!")
        return
    end

    local i = FindAValidIBItem(8, 423, 2, 0)
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(73)

    if (i > 0) or (GetCoin() >= Cv) then
        MsgBox("Muèn cã ®­îc sù gióp ®ì cña TrÝ ®a tinh, ng­¬i ph¶i nép cho ta <c=g>" .. Cfs .. " TiÒn ®ång<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i! NÕu <c=g> x¸c ®Þnh <c>, TrÝ ®a tinh nhÊt ®Þnh sÏ gióp ng­¬i hoµn thµnh c©u hái hiÖn t¹i, chØ lµ kh«ng biÕt ý ng­¬i thÕ nµo ?", "useIBFin", "no")
    else
        Talk(1, "subject", "Muèn cã ®­îc sù gióp ®ì cña TrÝ ®a tinh, ng­¬i ph¶i nép cho ta <c=g>" .. Cfs .. " TiÒn ®ång<c> hoÆc <c=g>1 TrÝ ®a tinh<c>, ®Ó ta tiÖn truyÒn ®¹t lêi thØnh cÇu cña ng­¬i vµ khã kh¨n gÆp ph¶i!")
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

    if (npctype ~= 4) then
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
            Talk(1, "no", "Chóc mõng ng­¬i, c©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, vµ hoµn thµnh tÊt c¶ c©u hái chç ta, b©y giê ng­¬i cã thÓ ®i ®Õn <c=g>" .. aryAnswerNpc[npctype + 1] .. "<c> tiÕp tôc tr¶ lêi c©u hái v­ît ¶i, thêi gian h÷u h¹n h·y mau mau hµnh ®éng!")
            Msg2Player("C©u tr¶ lêi hoµn toµn chÝnh x¸c, vµ hoµn thµnh tÊt c¶ c©u hái chç T©n Gi¸p, h·y lËp tøc ®Õn" .. aryAnswerNpc[npctype + 1] .. "TiÕp tôc tr¶ lêi c©u hái v­ît ¶i!")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
            TaskNote(1050, npctype)
        else
            Talk(1, "no", "Tr¶ lêi sai, ®Ó ph¹t ng­¬i thµnh tÝch cuèi cña ng­¬i sÏ t¨ng thªm <c=g>10 gi©y<c>! Nh­ng do ng­¬i ®· hoµn thµnh tÊt c¶ c©u hái chç ta, nªn lÇn sai nµy ng­¬i vÉn v­ît ¶i, b©y giê ng­¬i cã thÓ ®Õn <c=g>" .. aryAnswerNpc[npctype + 1] .. "<c>TiÕp tôc tr¶ lêi, thêi gian cã h¹n h·y nhanh lªn!")
            Msg2Player("Tr¶ lêi sai, nh­ng do c¸c c©u hái n¬i T©n Gi¸p ®· hoµn thµnh, h·y lËp tøc ®Õn" .. aryAnswerNpc[npctype + 1] .. "TiÕp tôc tr¶ lêi c©u hái v­ît ¶i!")
            TopMessage("RÊt tiÕc, tr¶ lêi sai!")
            TaskNote(1050, npctype)
        end

    else

        if (IsRight == 1) then
            Talk(1, "subject", "Chóc mõng ng­¬i, c©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, giê lµ c©u hái kÕ tiÕp, h·y chuÈn bÞ tr¶ lêi!")
            Msg2Player("C©u tr¶ lêi cña ng­¬i hoµn toµn chÝnh x¸c, h·y tr¶ lêi c©u tiÕp.")
            TopMessage("Chóc mõng ng­¬i, tr¶ lêi chÝnh x¸c!")
        else
            Talk(1, "subject", "Tr¶ lêi sai, ®Ó ph¹t ng­¬i thµnh tÝch cuèi cña ng­¬i sÏ t¨ng thªm <c=g>10 gi©y<c>! Nh­ng ng­¬i vÉn cßn c¬ héi, giê lµ c©u hái kÕ tiÕp, h·y chuÈn bÞ tr¶ lêi!")
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
        Talk(1, "no", "RÊt tiÕc, do sè lÇn ng­¬i tr¶ lêi sai ®· ®Õn <c=g>6 lÇn<c>,nªn ng­¬i bÞ xö thua! Tuy ch­a v­ît ¶i ®­îc, nh­ng biÓu hiÖn cña ng­¬i kh¸ xuÊt s¾c, nªn vÉn nhËn ®­îc phÇn th­ëng! Trong vßng <c=g>1 ngµy<c> ®Õn n¬i Vâ V­¬ng nhËn phÇn th­ëng, nÕu qu¸ thêi h¹n trªn sÏ kh«ng cßn ®­îc nhËn!")
        Msg2Player("Sè lÇn tr¶ lêi sai ®· 6 lÇn, V¨n Khóc Tinh qu©n xö ng­¬i thua cuéc,nh­ng biÓu hiÖn cña ng­¬i kh¸ xuÊt s¾c, nªn vÉn nhËn ®­îc phÇn th­ëng! Trong vßng 1 ngµy ®Õn n¬i Vâ V­¬ng nhËn phÇn th­ëng, nÕu qu¸ thêi h¹n trªn sÏ kh«ng cßn ®­îc nhËn!")
        TaskNote(1050, 12)
        RemoveIBBuff(652)
        RemoveIBBuff(653)
        RemoveIBBuff(654)
    end

end

-----------------------------------------------------------------------------------

function divination()
    CloseDialog()
    local step = GetTaskByte(Task_Divination, 1)
    local labelType = GetTaskByte(Task_Label_Type, 1)
    local playerType = GetPlayerType()
    if (step == 7 and labelType == 1) then
        if (playerType == 1) then
            MsgBox("NÕu ng­¬i ®em ®Õn cho ta 10 <c=r>B¨ng C¬<c> hoÆc <c=r>Ngäc Cèt<c>, ta sÏ cho ng­¬i nhiÒu phÇn th­ëng.", "yes_divination", "no")
        elseif (playerType == 2) then
            MsgBox("NÕu ng­¬i ®em ®Õn cho ta 10 <c=r>MÆt Quû<c> hoÆc <c=r>Háa Vò<c>, ta sÏ cho ng­¬i nhiÒu phÇn th­ëng.", "yes_divination", "no")
        else
            MsgBox("NÕu ng­¬i ®em ®Õn cho ta 10 <c=r>§o¶n KiÕm<c> hoÆc <c=r>M¶nh Gi¸p<c>, ta sÏ cho ng­¬i nhiÒu phÇn th­ëng.", "yes_divination", "no")
        end
    end
end

function yes_divination()
    CloseDialog()

    if (GetIBBuffCount() >= 32) then
        Talk(1, "no", "Tr¹ng th¸i hiÖn t¹i cña ng­¬i qu¸ nhiÒu, h·y gi¶i bá 1 vµi tr¹ng th¸i h·y quay l¹i tiÕp tôc nhiÖm vô ®i.")
        return
    end

    local playerType = GetPlayerType()
    local a = random(0, 1)
    if (playerType == 1) then
        if (HaveNormalItem(3, 13, 0, 0) < 10 and HaveNormalItem(3, 9, 0, 0) < 10) then
            Talk(1, "no", "Ng­¬i kh«ng ®ñ <c=r>B¨ng C¬<c> hoÆc <c=r>Ngäc Cèt<c>.")
            Msg2Player("Kh«ng ®ñ B¨ng C¬ hoÆc Ngäc Cèt")
            TaskNote(Task_Num, 7, "B¨ng c¬", "Ngäc cèt")
            refreshNpcTaskState()
            return
        end

        if (HaveNormalItem(3, 13, 0, 0) >= 10 and HaveNormalItem(3, 9, 0, 0) >= 10) then
            if (a == 0) then
                for i = 1, 10 do
                    DelNormalItem(3, 13, 0, 0)
                end
            else
                for i = 1, 10 do
                    DelNormalItem(3, 9, 0, 0)
                end
            end
        elseif (HaveNormalItem(3, 13, 0, 0) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, 13, 0, 0)
            end
        else
            for i = 1, 10 do
                DelNormalItem(3, 9, 0, 0)
            end
        end
        AddIBBuff(Buff_Plutus, 86400)
        SetTaskByte(Task_Divination, 1, 8)
        Talk(1, "no", "Th­ëng ng­¬i 1 ngµy tr¹ng th¸i thÇn tµi.")
        TaskNote(Task_Num, -1)
        refreshNpcTaskState()
    elseif (playerType == 2) then
        if (HaveNormalItem(3, 12, 0, 0) < 10 and HaveNormalItem(3, 8, 0, 0) < 10) then
            Talk(1, "no", "B¹n kh«ng ®ñ <c=r>Háa Vò<c> hoÆc <c=r>MÆt Quû<c>.")
            Msg2Player("Kh«ng ®ñ MÆt Quû hoÆc Háa Vò")
            TaskNote(Task_Num, 7, "Háa vò", "MÆt Quû")
            return
        end

        if (HaveNormalItem(3, 12, 0, 0) >= 10 and HaveNormalItem(3, 8, 0, 0) >= 10) then
            if (a == 0) then
                for i = 1, 10 do
                    DelNormalItem(3, 12, 0, 0)
                end
            else
                for i = 1, 10 do
                    DelNormalItem(3, 8, 0, 0)
                end
            end
        elseif (HaveNormalItem(3, 12, 0, 0) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, 12, 0, 0)
            end
        else
            for i = 1, 10 do
                DelNormalItem(3, 8, 0, 0)
            end
        end
        AddIBBuff(Buff_Plutus, 86400)
        SetTaskByte(Task_Divination, 1, 8)
        Talk(1, "no", "Th­ëng ng­¬i 1 ngµy tr¹ng th¸i thÇn tµi.")
        TaskNote(Task_Num, -1)
        refreshNpcTaskState()
    else
        if (HaveNormalItem(3, 11, 0, 0) < 10 and HaveNormalItem(3, 10, 0, 0) < 10) then
            Talk(1, "no", "B¹n kh«ng ®ñ <c=r>§o¶n KiÕm<c> hoÆc <c=r>M¶nh Gi¸p<c>.")
            Msg2Player("Kh«ng ®ñ §o¶n KiÕm hoÆc M¶nh Gi¸p")
            TaskNote(Task_Num, 7, "§o¶n KiÕm", "M¶nh Gi¸p")
            return
        end

        if (HaveNormalItem(3, 11, 0, 0) >= 10 and HaveNormalItem(3, 10, 0, 0) >= 10) then
            if (a == 0) then
                for i = 1, 10 do
                    DelNormalItem(3, 11, 0, 0)
                end
            else
                for i = 1, 10 do
                    DelNormalItem(3, 10, 0, 0)
                end
            end
        elseif (HaveNormalItem(3, 11, 0, 0) >= 10) then
            for i = 1, 10 do
                DelNormalItem(3, 11, 0, 0)
            end
        else
            for i = 1, 10 do
                DelNormalItem(3, 10, 0, 0)
            end
        end
        AddIBBuff(Buff_Plutus, 86400)
        SetTaskWord(Task_Divination, 1, 8)--log¸Ä°æ
        Talk(1, "no", "Th­ëng ng­¬i 1 ngµy tr¹ng th¸i thÇn tµi.")
        TaskNote(Task_Num, -1)
        refreshNpcTaskState()
    end
end

function no()
    CloseDialog()
end;
