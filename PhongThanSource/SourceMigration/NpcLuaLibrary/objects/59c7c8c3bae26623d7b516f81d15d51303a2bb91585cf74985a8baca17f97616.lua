--description:ÐÞÐÐÊ¦Ä§
--author: Gaojingwei
--date:2009/3/11

-----------Ë®»ðÖ®Õù begin-----------
Task_Stone_MonsterID = 1335            --¼ÇÂ¼Ê¯¹ÖID
Task_Sequence = 1336                --1bit:ÊÇ·ñÁìÈ¡»ðÉñ·¨Á¦ 2bit:ÊÇ·ñÁìÈ¡ÁËË®ÉñµÄ·¨Á¦
Global_Stone_MonsterCount = 175        --¼ÇÂ¼È«ÇøÊ¯¹ÖµÄ¸öÊý
MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --???
    [1] = { task = 1, note = 87 }, --???
    [2] = { task = 2, note = 88 }, --???
}

Fire_GodID = 856        --???
Water_GodID = 857        --???
StoneID = 876        --???
-------------ÁìÃü¹éÕæ--------------------------
Task_Process = 1345      --???1byte: 1:ÒÑÓÚÐÞÐÐÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑýµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø

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

    --Ë®»ðÖ®Õù
    startLevel = 45
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (taskKnight == 150) or (taskWizard == 150) or (taskDruid == 150) then
                state = 1
                subState = 0
            end
        else
            if (taskKnight == 150) or (taskWizard == 150) or (taskDruid == 150) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 begin
    --ÁìÃü¹éÕæ µÚÒ»²½
    startLevel = 30
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 0) then
                state = 1
                subState = 0
            elseif (process == 8) then
                state = 3
                subState = 0
            elseif (process >= 1) and (process <= 7) then
                state = 2
                subState = 0
            end
        else
            if (process == 0) then
                state = 1
                subState = 1
            elseif (process == 8) then
                state = 3
                subState = 1
            elseif (process >= 1) and (process <= 7) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end
    --ÁìÃü¹éÕæ µÚ¶þ²½
    startLevel = 31
    if (GetPlayerExtLevel() >= startLevel) and (GetJusticEvilCredit() < 0) then
        local process = GetTaskByte(Task_Process, 1)
        if (GetPlayerExtLevel() - startLevel <= 5) then
            if (process == 9) then
                state = 1
                subState = 0
            elseif (process == 11) then
                state = 3
                subState = 0
            elseif (process == 10) then
                state = 2
                subState = 0
            end
        else
            if (process == 9) then
                state = 1
                subState = 1
            elseif (process == 11) then
                state = 3
                subState = 1
            elseif (process == 10) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end
    --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29 end

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
    local tasks = {
        { "Thñy Háa t­¬ng tranh", "waterAndFire"; shwo = 0 },
        { "LÜnh MÖnh Quy Ch©n", "listenTask"; show = 0 },
        { "Hñy N.vô", "cancel"; show = 0 },
        { "Th«ng lé: Ngôc Ph¸p S¬n", "ontheway"; show = 1 },
        -- modified by yaoxin for ÏÉÄ§µãÀ¶×øÆï 2010-02 begin
        { "MaGiíiKúTr©n", "opensale"; show = 1 },
        --modified by liujifang for ÏÉÄ§½ç»Æ½ð×øÆï at 2012-12-25 begin
        { "Th¸nh Thó Ma Giíi", "Horse_Info"; show = 1 },
        --modified by liujifang for ÏÉÄ§½ç»Æ½ð×øÆï at 2012-12-25 end
        -- modified by yaoxin for ÏÉÄ§µãÀ¶×øÆï 2010-02 end
    }

    local playerType = GetPlayerType()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)
    local extLevel = GetPlayerExtLevel()
    if (mainTaskValue >= 150 and mainTaskValue < 160 and extLevel >= 45) then
        tasks[1].show = 1
    end

    local process = GetTaskByte(Task_Process, 1)
    -- modified by yaoxin for ºÏ²¢°´Å¥ 2010-02 begin
    if (process >= 1 and process < 8) or (process == 10) then
        if (GetJusticEvilCredit() < 0) then
            tasks[3].show = 1
        end
    elseif (process >= 0 and process <= 11 and GetPlayerExtLevel() >= 30) then
        tasks[2].show = 1
    end
    -- modified by yaoxin for ºÏ²¢°´Å¥ 2010-02 end
    -----------------added by huangbin for Óü·¨É½¿ªÆô at 2009/10/10----------------------
    local yufashan = GetWorldEventValue(3, 18)
    if (yufashan == 4) then
        tasks[4].show = 0
    end
    -------------------------------------------------------------------------------------
    SayTask("§¼ng cÊp Nh©n giíi cña ng­¬i sÏ ¶nh h­ëng tíi viÖc tu luyÖn Tiªn Ma giíi, chØ khi ®¼ng cÊp Nh©n giíi cao h¬n Tiªn Ma giíi <c=g>110 cÊp<c> trë lªn, míi nhËn ®­îc hiÖu qu¶ tu luyÖn.", tasks)
end;

function listenTask()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    local extCredit = GetJusticEvilCredit()
    if (extCredit >= 0) then
        Talk(1, "no", "Tiªn Ma thuËt ph¸p ta ®Òu tinh th«ng, nh­ng nãi ra víi ng­¬i còng v« dông th«i. Ng­¬i h·y ®i thØnh gi¸o ng­êi cña phe m×nh ®i!")
        return
    end

    if (process == 0) then
        MsgBox("BÊt Chu S¬n cao nh©n nhiÒu nh­ m©y, mçi ng­êi ®Òu cã c¸i tinh diÖu riªng cña m×nh. NÕu ng­¬i muèn nge hä gi¶ng ph¸p, th× b©y giê lµ c¬ hé tèt nhÊt!", "accept_listen", "no")
        return
    end

    if (process >= 2 and process <= 7 and HaveIBBuff(548) == 0) then
        process = 0
        SetTaskByte(Task_Process, 1, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        Talk(1, "no", "ThËt tiÕc ng­¬i ®· bá qua c¬ héi quý gi¸ lÇn nµy! Nh­ng vÉn cã thÓ quay l¹i!")
        TaskNote(1031, 7)
        return
    elseif (process == 1 or (process >= 2 and process <= 7 and HaveIBBuff(548) > 0)) then
        Talk(1, "no", "Tranh thñ thêi gian vÉn cßn, h·y mau ®i gÆp c¸c Ma s­ ®i!")
        return
    end

    if (process == 8) then
        RemoveIBBuff(548)
        local er = AddOwnExtendExp(650000)
        SetTaskByte(Task_Process, 1, 9)                            --ÈÎÎñµÚÒ»²½½áÊø
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        if (GetPlayerExtLevel() >= 30) then
            --Èô´óÓÚ31¼¶£¬Ö±½Ó½øÈëµÚ¶þ²½
            Talk(1, "listenTask", "NÕu muèn t×m hiÓu con ®­êng ng¾n nhÊt ®Ó ®¾c ®¹o, th× khi ®¼ng cÊp Tiªn Ma ®¹t <c=g>31<c> h·y quay l¹i gÆp ta!")
            TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. er .. "<c> tu luyÖn")
            Msg2Player("Nghe xong c¸c Ma s­ gi¶ng ph¸p, nhËn ®­îc" .. er .. " ®iÓm tu luyÖn!")
            TaskNote(1031, 4, er)
        end
        return
    end

    if (process == 9) then
        if (GetPlayerExtLevel() >= 31) then
            SetTaskByte(Task_Process, 1, 10)
            refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
            Talk(1, "no", "LiÒu m×nh vµo nªn nguy hiÓm cã khi l¹i nhanh chãng ®¾c ®¹o. <c=g>Ma Phong Yªu<c> ®ang léng hµnh ë BÊt Chu S¬n, ng­¬i ®i ®é ho¸ chóng, biÕt ®©u sÏ lÜnh héi ®­îc Quy Ch©n ®¹o.")
            TaskNote(1031, 5)
        else
            Talk(1, "no", "NÕu muèn t×m hiÓu con ®­êng ng¾n nhÊt ®Ó ®¾c ®¹o, th× khi ®¼ng cÊp Tiªn Ma ®¹t <c=g>31<c> h·y quay l¹i gÆp ta!")
        end
        return
    end

    if (process == 10) then
        Talk(1, "no", "<c=g>Ma Phong Yªu<c> ®ang léng hµnh ë BÊt Chu S¬n, ng­¬i ®i ®é ho¸ chóng, biÕt ®©u sÏ lÜnh héi ®­îc Quy Ch©n ®¹o.")
        return
    end

    if (process == 11) then
        MsgBox("Xem d¸ng vÎ ng­¬i hín hë nh­ vËy, ch¾c ®· lÜnh ngé ®­îc nhiÒu råi?", "yes_GetBonus", "no")
        return
    end

end

function accept_listen()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    if (process == 0) then
        SetTaskByte(Task_Process, 1, 1)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        SetSubTask(1031, 1, 1)
        Talk(1, "no", "Nghe gi¶ng ph¸p ph¶i biÕt tranh thñ c¬ duyªn. Sau khi nghe døt 1 vÞ gi¶ng xong, néi trong <c=g>1 phót<c> ph¶i t×m ®Õn vÞ tiªn s­ thø 2. Giê h·y ®i thØnh gi¸o <c=g>BÇn Minh T«n gi¶<c>!")
        TopMessage("§i gÆp <c=g>BÇn Minh T«n gi¶<c> nghe gi¶ng ph¸p")
        Msg2Player("BÇn Minh T«n gi¶ ®¹o ph¸p cao siªu, h·y ®i thØnh gi¸o «ng Êy!")
        TaskNote(1031, 1)
    end
end

function yes_GetBonus()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    local playerType = GetPlayerType()
    if (process == 11) then
        SetTaskByte(Task_Process, 1, 12)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        local er = AddOwnExtendExp(1000000)
        if (playerType == 0) then
            --¼×Ê¿
            AddNormalItem(0, 7, 18, 3, 0, 0, 1)
        elseif (playerType == 1) then
            --µÀÊ¿
            AddNormalItem(0, 7, 19, 3, 0, 0, 1)
        elseif (playerType == 2) then
            --ÒìÈË
            AddNormalItem(0, 7, 20, 3, 0, 0, 1)
        end
        Talk(1, "no", "Ng­¬i ®· l·nh ngé ®­îc kh«ng Ýt, xem ra còng lµ do c¬ duyªn vËy. Ta cã 1 mãn Ma khÝ, tÆng cho ng­¬i ®Ó khÝch lÖ!")
        TopMessage("nhËn ®­îc phÇn th­ëng <c=g>" .. er .. "<c> tu luyÖn")
        Msg2Player("Nghe xong c¸c Ma s­ gi¶ng ph¸p, nhËn ®­îc" .. er .. " tu luyÖn vµ 1 mãn trang bÞ.")
        SetSubTask(1031, -1, 1)
        TaskNote(1031, -1)
    end
end

function cancel()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    if (process >= 1 and process <= 8) then
        if (HaveIBBuff(548) > 0) then
            Talk(1, "no", "Tranh thñ thêi gian vÉn cßn, h·y mau ®i gÆp c¸c Tiªn s­ ®i!")
        else
            MsgBox("§¹o duyªn khã cÇu! Ng­¬i quyÕt ®Þnh huû bá ­?", "first_Cancel", "no")
        end
    end

    if (process >= 10 and process <= 11) then
        MsgBox("§¹o duyªn khã cÇu! Ng­¬i quyÕt ®Þnh huû bá ­?", "second_Cancel", "no")
    end
end

function first_Cancel()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    if (process >= 1 and process <= 8 and HaveIBBuff(548) == 0) then
        SetTaskByte(Task_Process, 1, 0)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        Msg2Player("Hñy bá nhiÖm vô LÜnh MÖnh Quy Ch©n.")
        TaskNote(1031, -1)
    end
end

function second_Cancel()
    CloseDialog()
    local process = GetTaskByte(Task_Process, 1)
    if (process >= 10 and process <= 11) then
        SetTaskByte(Task_Process, 1, 9)
        refreshNpcTaskState() --Add by Doubiao for ÎÊºÅÌáÊ¾at 2009/12/29
        Msg2Player("Hñy bá nhiÖm vô LÜnh MÖnh Quy Ch©n.")
        TaskNote(1031, -1)
    end
end
--------------------Ë®»ðÖ®Õù---------------------------------
function waterAndFire()
    CloseDialog()
    local playerType = GetPlayerType()
    local extCredit = GetJusticEvilCredit()
    local mainTaskValue = GetTask(MainTask_GD_Conf[playerType].task)

    if (extCredit >= 0) then
        Talk(1, "no", "Danh väng Ma giíi cña ng­¬i ch­a ®ñ, sau nµy h·y quay l¹i nhÐ!")
        return
    end

    if (mainTaskValue == 150) then
        Talk(4, "no", " B¹n trÎ tõ ®©u ®Õn? Vµ muèn ®i ®©u?\n V·n bèi phông mÖnh ®i t×m Phong ThÇn b¶ng. Nh­ng kh«ng biÕt ph¶i b¾t ®Çu tõ ®©u!", " BÊt Chu S¬n réng lín nh­ vÇy, biÕt t×m ë ®©u? Nh­ng ë ®©y cã <c=g>Háa thÇn<c> vµ <c=g>Thñy thÇn<c> kiÕn thøc uyªn th©m, ng­¬i ®i hái hä biÕt ®©u sÏ cã manh mèi!", " Hai ng­êi ®ã cø ®¸nh nhau triÒn miªn, kh«ng biÕt ®Õn bao giê míi døt...Ng­¬i muèn t×m hiÓu tin tøc, tr­íc tiªn ph¶i ho¸ gi¶i mèi bÊt hoµ cña hä!", "Ng­êi ch¬i:T¹i h¹ ®· nghÜ ra c¸ch ho¸ gi¶i, ®a t¹ tiÒn bèi chØ gi¸o!")
        SetTask(MainTask_GD_Conf[playerType].task, 151)        --ÓëÐÞÐÐÊ¦¶Ô»°,±íÊ¾ÒÑ¾­ÁìÈ¡ÁËÈÎÎñ
        TaskNote(MainTask_GD_Conf[playerType].note, 20)

        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    else
        Talk(1, "no", "NÕu vËy th× ®õng do dù n÷a, nÕu muèn biÕt tin tøc Phong ThÇn b¶ng th× h·y lËp tøc ®i gÆp <c=g>Háa thÇn<c> vµ <c=g>Thñy thÇn<c> ®i!")
        TaskNote(MainTask_GD_Conf[playerType].note, 20)
    end
end

function no()
    CloseDialog()
end;

------------------------Óü·¨É½¿ªÆô begin----------------------------------------------
function ontheway()

    CloseDialog()
    -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-08 begin
    local times = GetWorldEventValue(3, 1)
    if (times < 18) then
        Talk(1, "no", "Muèn ®Õn Ngôc Ph¸p s¬n, cÇn ph¶i cã Léc thÇn trî gióp, mµ Léc thÇn xuÊt hiÖn cÇn cã 18 vÞ nh©n sÜ cÇu ®¹o th«ng qua kh¶o nghiÖm “Thñy Háa t­¬ng tranh“. HiÖn ®· cã <c=g>" .. times .. "<c> ng­êi th«ng qua kh¶o nghiÖm.")
    else
        local prog = GetWorldEventProgress(3)
        if (prog < 1) then
            Talk(1, "no", "Muèn ®Õn Ngôc Ph¸p s¬n, cÇn ph¶i cã Léc thÇn trî gióp, chØ cÇn xuÊt hiÖn thªm <c=g>1<c> nh©n sÜ cÇu ®¹o th«ng qua kh¶o nghiÖm “Thñy Háa t­¬ng tranh“, Léc thÇn sÏ hiÖn th©n ë BÊt Chu S¬n!")
        else
            Talk(1, "no", "§· ®ñ 18 vÞ nh©n sÜ cÇu ®¹o th«ng qua kh¶o nghiÖm “Thñy Háa t­¬ng tranh“, <c=g>Léc thÇn<c> ®· hiÖn th©n ë <c=g>BÊt Chu S¬n [241, 201]<c>. Ch­ vÞ nÕu muèn ®Õn Ngôc Ph¸p s¬n, h·y nhanh chãng ®Õn thØnh gi¸o Léc thÇn!")
        end
    end
    -- modified by yaoxin for Óü·¨É½¿ªÆô 2010-08 end
end
------------------------Óü·¨É½¿ªÆô end------------------------------------------------


-- modified by yaoxin for ÏÉÄ§µãÀ¶×øÆï 2010-02 begin
HorseNeedTable = {
    { PlayerType = 0, Name = "PhÖ Thiªn Long Hèng", HorseType = { 33, 1 }, OutHorseType = { 39, 5 }, ItemNeedType = { 51, 326 }, WhiteHorseIBItem = 732, IBCostIdx = 134 },
    { PlayerType = 1, Name = "BÝch Vò Minh T«n", HorseType = { 34, 1 }, OutHorseType = { 40, 5 }, ItemNeedType = { 51, 326 }, WhiteHorseIBItem = 732, IBCostIdx = 134 },
    { PlayerType = 2, Name = "B¨ng Uyªn Minh Dùc", HorseType = { 35, 1 }, OutHorseType = { 41, 5 }, ItemNeedType = { 51, 326 }, WhiteHorseIBItem = 732, IBCostIdx = 134 },
}

function CheckHorseNeed()
    for i = 1, getn(HorseNeedTable) do
        if (HorseNeedTable[i].PlayerType == GetPlayerType()) then
            --songbei by 2009.9.25 Ö°ÒµµãÀ¶ÏÞÖÆ¿ªÆô
            local HorseCount = HaveNormalItem(0, 10, HorseNeedTable[i].HorseType[1], HorseNeedTable[i].HorseType[2])
            if (HorseCount >= 1) then
                if (HaveNormalItem(3, HorseNeedTable[i].ItemNeedType[1], 0, 0) > 0) and
                        (HaveNormalItem(3, HorseNeedTable[i].ItemNeedType[2], 0, 0) > 0) then
                    return i
                end
            end
        end
    end

    return 0
end

function SetHorseBlue(HorseIdx)
    DelNormalItem(3, HorseNeedTable[HorseIdx].ItemNeedType[1], 0, 0)
    DelNormalItem(3, HorseNeedTable[HorseIdx].ItemNeedType[2], 0, 0)
    DelNormalItem(0, 10, HorseNeedTable[HorseIdx].HorseType[1], HorseNeedTable[HorseIdx].HorseType[2])

    AddNormalItem2(0, 10, HorseNeedTable[HorseIdx].OutHorseType[1], HorseNeedTable[HorseIdx].OutHorseType[2], 0)

    MsgBox("<c=g>Hèng L©n<c> ®· phô thÓ vµo thó c­ìi Tiªn Ma cña ng­¬i! H·y c­ìi lªn nã thÓ thö thµnh qu¶ cña m×nh ®i!", "no")
end

function OnSelBlueHorse()
    CloseDialog()
    MsgBox(" Muèn trïng sinh thó c­ìi Tiªn Ma, tèt nhÊt lµ cho th¸nh thó th­îng cæ <c=g>Hèng L©n<c> phô thÓ vµo thó c­ìi, nh­ng cÇn cã thªm <c=g>B¸ L¹c Nh·n cÊp 15<c> sÏ trïng sinh cho <c=g>thó c­ìi Tiªn Ma cÊp 55<c>! (Xin x¸c nhËn trong hµnh trang chØ cã mét thó c­ìi Tiªn Ma tr¾ng cÊp 55).", "OnStartSetHorseBlue", "no")
end

function OnStartSetHorseBlue()
    CloseDialog()
    local Idx = CheckHorseNeed()
    if (Idx == 0) then
        Talk(1, "no", " NÕu ng­¬i muèn trïng sinh cho <c=g>" .. HorseNeedTable[GetPlayerType() + 1].Name .. "<c> cÇn chuÈn bÞ ®ñ<c=g>Hèng L©n<c> vµ <c=g>B¸ L¹c Nh·n cÊp 15<c>, ta sÏ tËn lùc gióp ®ì!")  --songbei by 2009.9.25 Ö°ÒµµãÀ¶ÏÞÖÆ¿ªÆô
        return
    end

    MsgBox(" Ng­¬i ®ång ý ®­a <c=g>Hèng L©n<c> vµo <c=g>" .. HorseNeedTable[Idx].Name .. "<c>?", "OnEndSetHorseBlue", "no")
end

function OnEndSetHorseBlue()
    CloseDialog()
    local Idx = CheckHorseNeed()
    if (Idx == 0) then
        Talk(1, "no", " NÕu ng­¬i muèn trïng sinh cho <c=g>" .. HorseNeedTable[GetPlayerType() + 1].Name .. "<c> cÇn chuÈn bÞ ®ñ<c=g>Hèng L©n<c> vµ <c=g>B¸ L¹c Nh·n cÊp 15<c>, ta sÏ tËn lùc gióp ®ì!")  --songbei by 2009.9.25 Ö°ÒµµãÀ¶ÏÞÖÆ¿ªÆô
        return
    end

    SetHorseBlue(Idx)
end

---------------------------------------------
--¼ì²é»¹Ô­×øÆïµÄÌõ¼þÊÇ·ñ¾ß±¸
function CheckRetHorseNeed()

    local nTotalCount = 0

    for i = 1, getn(HorseNeedTable) do

        local HorseCount = HaveItem2(0, 10, HorseNeedTable[i].OutHorseType[1], HorseNeedTable[i].OutHorseType[2], 0, 0)
        if (HorseCount == 1) then
            nTotalCount = nTotalCount + HorseCount
        elseif (HorseCount > 1) then
            Talk(1, "no", " thuËt <c=g>B¸ L¹c trïng sinh<c> ®· thi triÓn th× sÏ kh«ng thÓ phôc håi. Xin chó ý trong ng¨n ®Çu tiªn cña hµnh trang chØ cã duy nhÊt 1 thó c­ìi Tiªn Ma xanh cÊp 55 mµ th«i!")
            return 0, 1
        end

    end

    if (nTotalCount > 1) then
        Talk(1, "no", " thuËt <c=g>B¸ L¹c trïng sinh<c> ®· thi triÓn th× sÏ kh«ng thÓ phôc håi. Xin chó ý trong ng¨n ®Çu tiªn cña hµnh trang chØ cã duy nhÊt 1 thó c­ìi Tiªn Ma xanh cÊp 55 mµ th«i!")
        return 0, 1
    end

    for i = 1, getn(HorseNeedTable) do

        local HorseCount = HaveItem2(0, 10, HorseNeedTable[i].OutHorseType[1], HorseNeedTable[i].OutHorseType[2], 0, 0)
        if (HorseCount == 1) then
            local ItemID = FindAValidIBItem(8, HorseNeedTable[i].WhiteHorseIBItem, 2, 0)
            local ItemID1 = FindAValidIBItem(8, 861, 2, 0)
            if (ItemID > 0) then
                return i, ItemID, 0
            elseif (ItemID1 > 0) then
                return i, ItemID1, 0
            else
                costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(HorseNeedTable[i].IBCostIdx)
                if (GetCoin() >= costIBNum) then
                    return i, 0, HorseNeedTable[i].IBCostIdx
                end
            end
        elseif (HorseCount > 1) then
            Talk(1, "no", " thuËt <c=g>B¸ L¹c trïng sinh<c> ®· thi triÓn th× sÏ kh«ng thÓ phôc håi. Xin chó ý trong ng¨n ®Çu tiªn cña hµnh trang chØ cã duy nhÊt 1 thó c­ìi Tiªn Ma xanh cÊp 55 mµ th«i!")
            return 0, 1
        end

    end

    return 0, 0
end

function OnRetWhiteHorse()
    MsgBox("Tu Hµnh S­: Ngoµi kh¶ n¨ng gióp trïng sinh cho thó c­ìi Tiªn Ma, ta cßn cã thÓ dïng thó c­ìi Tiªn Ma xanh cÊp 55 hoµn nguyªn cho B¸ L¹c Nh·n, chØ cÇn ®­a cho ta <c=g>B¸ L¹c Linh KÝnh<c> hoÆc <c=g>Kim Nguyªn B¶o<c> lµ ®­îc. ThuËt <c=g>B¸ L¹c trïng sinh<c> nµy chØ m×nh ta biÕt! (Xin x¸c nhËn trong hµnh trang chØ cã mét thó c­ìi Tiªn Ma xanh cÊp 55).", "OnStartRetWhiteHorse", "no")
end

function OnStartRetWhiteHorse()
    CloseDialog()
    local Idx, IBItemID, IBCostIdx = CheckRetHorseNeed()
    if (Idx == 0) then
        if (IBItemID == 0) then
            MsgBox("Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ c¸c vËt phÈm ta cÇn, kh«ng thÓ thi triÓn thuËt <c=g>B¸ L¹c trïng sinh<c>!", "no")
        end
        return
    end

    local costName, costIBNum, costDisNum = GetCostCoinInfoByIdx(HorseNeedTable[Idx].IBCostIdx)
    MsgBox("ChØ cÇn ®­a ta 1 <c=g>B¸ L¹c Linh KÝnh<c> hoÆc <c=g>" .. costDisNum .. " Kim Nguyªn B¶o <c>, ta sÏ thi triÓn thuËt <c=g>B¸ L¹c trïng sinh<c>, gióp thó c­ìi Tiªn Ma xanh cÊp 55 trong hµnh trang cña ng­¬i hoµn nguyªn thµnh <c=g>B¸ L¹c Nh·n cÊp 15<c>, sao h¶? (Xin x¸c nhËn trong hµnh trang chØ cã mét thó c­ìi Tiªn Ma xanh cÊp 55).", "OnEndRetWhiteHorse", "no")
end

function OnEndRetWhiteHorse()
    CloseDialog()
    local Idx, IBItemID, IBCostIdx = CheckRetHorseNeed()
    if (Idx == 0) then
        if (IBItemID == 0) then
            MsgBox("Ng¹i qu¸! Ng­¬i kh«ng cã ®ñ c¸c vËt phÈm ta cÇn, kh«ng thÓ thi triÓn thuËt <c=g>B¸ L¹c trïng sinh<c>!", "no")
        end
        return
    end

    RetWhiteHorse(Idx, IBItemID, IBCostIdx)
end

function RetWhiteHorse(HorseIdx, IBItemID, IBCostIdx)
    if (IBItemID > 0) then
        CostIBItem(IBItemID)
    end

    if (IBCostIdx > 0) then
        CostCoinByIdx(IBCostIdx)
    end

    DelItem2(0, 10, HorseNeedTable[HorseIdx].OutHorseType[1], HorseNeedTable[HorseIdx].OutHorseType[2])
    AddNormalItemPile(3, HorseNeedTable[HorseIdx].ItemNeedType[1], 0, 0, 0, 0)
    TopMessage("B¹n nhËn ®­îc <c=g>B¸ L¹c Nh·n cÊp 15<c>")
    MsgBox(" §©y chÝnh lµ <c=g>B¸ L¹c Nh·n cÊp 15<c>, Phôc ch­a?! Sau nµy muèn hoµn nguyªn cho thó c­ìi Tiªn Ma xanh cÊp 55 th× l¹i ®Õn t×m ta nhÐ!", "no")
end

function opensale()
    CloseDialog()
    OpenMonsterSale(52)
end
-- modified by yaoxin for ÏÉÄ§µãÀ¶×øÆï 2010-02 end

--modified by liujifang for ÏÉÄ§½ç»Æ½ð×øÆï at 2012-12-25 begin
function Horse_Info()
    local tasks = {
        { "Th¸nhThóHåiSinh", "OnSelBlueHorse"; show = 1 },
        { "Trïng sinh", "OnRetWhiteHorse"; show = 1 },
        { "Th¸nh Thó Hoµng Kim", "ChangeHorse"; show = 1 },
    }
    SayTask("Tu Hµnh S­:Ta nhiÒu n¨m tu ®¹o trong Ma Giíi, tinh th«ng<c=g>Ma Giíi Th¸nh Thó<c> khã cã ai mµ s¸nh ®­îc.", tasks)
end

Horse_probability = {
    [1] = {
        [0] = {
            ["name"] = "ChÝ T«n ThÇn L«i Gi¸c Tª",
            ["prob"] = { 1, 2, 3, 0, 0 },
            ["value"] = { "10%", "10%", "30%", "", "" },
            ["coin"] = "§»ng Vô ThÇn L«i Gi¸c Tª, B¸ L¹c Nh·n cÊp 15,tiÒn ®ång 1000 v¹n, Lam B¶o Th¹ch 10 c¸i, T­íng Qu©n LÖnh 250 c¸i",
            ["coin1"] = "",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 60, 1 },
            ["addid"] = { 0, 10, 48, 1 },
        },
        [1] = {
            ["name"] = "NghÞch Thiªn ThÇn L«i Gi¸c Tª",
            ["prob"] = { 4, 5, 2, 3, 0 },
            ["value"] = { "20%", "5%", "15%", "50%", "" },
            ["coin"] = "§»ng Vô ThÇn L«i Gi¸c Tª, B¸ L¹c Nh·n cÊp 15*2, tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 400 c¸i, B¸ L¹c Tinh*6",
            ["coin1"] = "§»ng Vô ThÇn L«i Gi¸c Tª, B¸ L¹c Nh·n cÊp 15*2,tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 1300 c¸i",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 60, 1 },
            ["addid"] = { 0, 10, 54, 1 },
        },
        [2] = {
            ["name"] = "ChÝ T«n PhÖ Thiªn Long Hèng",
            ["prob"] = { 4, 2, 6, 0, 0 },
            ["value"] = { "20%", "15%", "700 ®iÓm", "", "" },
            ["coin"] = "§»ng Vô PhÖ Thiªn Long Hèng, B¸ L¹c Nh·n cÊp 16, tiÒn ®ång 3000 v¹n, Lam B¶o Th¹ch 80 c¸i, T­íng Qu©n LÖnh 500 c¸i",
            ["coin1"] = "",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 63, 1 },
            ["addid"] = { 0, 10, 51, 1 },
        },
        [3] = {
            ["name"] = "NghÞch Thiªn PhÖ Thiªn Long Hèng",
            ["prob"] = { 5, 2, 6, 7, 0 },
            ["value"] = { "10%", "20%", "1200 ®iÓm", "10%", "" },
            ["coin"] = "§»ng Vô PhÖ Thiªn Long Hèng, B¸ L¹c Nh·n cÊp 16*2, Lam B¶o Th¹ch 120 c¸i, tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 950 c¸i, B¸ L¹c Tinh 15 c¸i",
            ["coin1"] = "§»ng Vô PhÖ Thiªn Long Hèng, B¸ L¹c Nh·n cÊp 16*2 c¸i, Lam B¶o Th¹ch 120 c¸i, tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 3200 c¸i",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 63, 1 },
            ["addid"] = { 0, 10, 57, 1 },
        },
    },
    [2] = {
        [0] = {
            ["name"] = "ChÝ T«n Tø Dùc Minh T«n",
            ["prob"] = { 8, 9, 3, 0, 0 },
            ["value"] = { "10%", "10%", "30%", "", "" },
            ["coin"] = "§»ng Vô Tø Dùc Minh T«n, B¸ L¹c Nh·n cÊp 15 ,tiÒn ®ång 1000 v¹n, Lam B¶o Th¹ch 10 c¸i, T­íng Qu©n LÖnh 250 c¸i",
            ["coin1"] = "",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 61, 1 },
            ["addid"] = { 0, 10, 49, 1 },
        },
        [1] = {
            ["name"] = "NghÞch Thiªn Tø Dùc Minh T«n",
            ["prob"] = { 10, 9, 11, 3, 0 },
            ["value"] = { "20%", "15%", "20%", "50%", "" },
            ["coin"] = "§»ng Vô Tø Dùc Minh T«n, B¸ L¹c Nh·n cÊp 15 * 2 c¸i, tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 400 c¸i, B¸ L¹c Tinh 6 c¸i",
            ["coin1"] = "§»ng Vô Tø Dùc Minh T«n, B¸ L¹c Nh·n cÊp 15* 2 c¸i, tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 1300 c¸i",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 61, 1 },
            ["addid"] = { 0, 10, 55, 1 },
        },
        [2] = {
            ["name"] = "ChÝ T«n BÝch Vò Minh T«n",
            ["prob"] = { 10, 12, 6, 0, 0 },
            ["value"] = { "20%", "10%", "500 ®iÓm", "", "" },
            ["coin"] = "§»ng Vô BÝch Vò Minh T«n, B¸ L¹c Nh·n cÊp 16  ,tiÒn ®ång 3000 v¹n, Lam B¶o Th¹ch 80 c¸i, T­íng Qu©n LÖnh 500 c¸i",
            ["coin1"] = "",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 64, 1 },
            ["addid"] = { 0, 10, 52, 1 },
        },
        [3] = {
            ["name"] = "NghÞch Thiªn BÝch Vò Minh T«n",
            ["prob"] = { 10, 12, 13, 6, 0 },
            ["value"] = { "30%", "15%", "20%", "800 ®iÓm", "" },
            ["coin"] = "§»ng Vô BÝch Vò Minh T«n, B¸ L¹c Nh·n cÊp 16*2 c¸i, Lam B¶o Th¹ch 120 c¸i,tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 950 c¸i, B¸ L¹c Tinh 15 c¸i",
            ["coin1"] = "§»ng Vô BÝch Vò Minh T«n, B¸ L¹c Nh·n cÊp 16*2 c¸i, Lam B¶o Th¹ch 120 c¸i,tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 3200 c¸i",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 64, 1 },
            ["addid"] = { 0, 10, 58, 1 },
        },
    },
    [3] = {
        [0] = {
            ["name"] = "ChÝ T«n LiÖt Kh«ng DiÖu Dùc",
            ["prob"] = { 2, 14, 3, 0, 0 },
            ["value"] = { "15%", "200 ®iÓm", "30%", "", "" },
            ["coin"] = "§»ng Vô LiÖt Kh«ng DiÖu Dùc, B¸ L¹c Nh·n cÊp 15, tiÒn ®ång 1000 v¹n, Lam B¶o Th¹ch 10 c¸i, T­íng Qu©n LÖnh 250 c¸i",
            ["coin1"] = "",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 62, 1 },
            ["addid"] = { 0, 10, 50, 1 },
        },
        [1] = {
            ["name"] = "NghÞch Thiªn LiÖt Kh«ng DiÖu Dùc",
            ["prob"] = { 4, 5, 15, 3, 0 },
            ["value"] = { "20%", "20%", "200 ®iÓm", "50%", "" },
            ["coin"] = "§»ng Vô LiÖt Kh«ng DiÖu Dùc, B¸ L¹c Nh·n cÊp 15*2, tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 400 c¸i, B¸ L¹c Tinh 6 c¸i",
            ["coin1"] = "§»ng Vô LiÖt Kh«ng DiÖu Dùc, B¸ L¹c Nh·n cÊp 15*2, tiÒn ®ång 2000 v¹n, Lam B¶o Th¹ch 50 c¸i, T­íng Qu©n LÖnh 1300 c¸i",
            ["lvl"] = 20,
            ["speed"] = 110,
            ["needid"] = { 0, 10, 62, 1 },
            ["addid"] = { 0, 10, 56, 1 },
        },
        [2] = {
            ["name"] = "ChÝ T«n B¨ng Uyªn Minh Dùc",
            ["prob"] = { 1, 2, 6, 0, 0 },
            ["value"] = { "10%", "20%", "600 ®iÓm", "", "" },
            ["coin"] = "§»ng Vô B¨ng Uyªn Minh Dùc, B¸ L¹c Nh·n cÊp 16, tiÒn ®ång 3000 v¹n, Lam B¶o Th¹ch 80 c¸i, T­íng Qu©n LÖnh 500 c¸i",
            ["coin1"] = "",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 65, 1 },
            ["addid"] = { 0, 10, 53, 1 },
        },
        [3] = {
            ["name"] = "NghÞch Thiªn B¨ng Uyªn Minh Dùc",
            ["prob"] = { 4, 2, 1, 6, 0 },
            ["value"] = { "20%", "25%", "10%", "1000 ®iÓm", "" },
            ["coin"] = "§»ng Vô B¨ng Uyªn Minh Dùc, B¸ L¹c Nh·n cÊp 16*2 c¸i, Lam B¶o Th¹ch 120 c¸i, tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 950 c¸i, B¸ L¹c Tinh 15 c¸i",
            ["coin1"] = "§»ng Vô B¨ng Uyªn Minh Dùc, B¸ L¹c Nh·n cÊp 16*2 c¸i, Lam B¶o Th¹ch 120 c¸i, tiÒn ®ång 8000 v¹n, T­íng Qu©n LÖnh 3200 c¸i",
            ["lvl"] = 60,
            ["speed"] = 160,
            ["needid"] = { 0, 10, 65, 1 },
            ["addid"] = { 0, 10, 59, 1 },
        },
    }
}
tbl_Horse_Item = {
    [0] = {--"15¼¶²®ÀÖÖ®ÑÛ£¬½ðÇ®1000Íò£¬À¶±¦Ê¯10¸ö£¬½«¾üÁî250¸ö"
        item = {--id1,id2,id3,id4,num
            { 3, 51, 0, 0, 1 }, --²®ÀÖÖ®ÑÛ
            { 3, 41, 0, 0, 10 }, --À¶±¦Ê¯
            {
                { 3, 100, 0, 0, 250 }, --½«¾üÁî
                { 3, 100, 0, 0, 250 }, --½«¾üÁî
            },
        },
        money = 10000000,
    },
    [1] = {--"15¼¶²®ÀÖÖ®ÑÛ2¸ö£¬½ðÇ®2000Íò£¬À¶±¦Ê¯50¸ö£¬½«¾üÁî400¸ö£¬²®ÀÖ¾«½ð6¸ö"
        item = {--id1,id2,id3,id4,num
            { 3, 51, 0, 0, 2 },
            { 3, 41, 0, 0, 50 },
            { 3, 100, 0, 0, 400 },
            {
                { 3, 1181, 0, 0, 6 }, --²®ÀÖ¾«½ð
                { 3, 100, 0, 0, 900 },
            },
        },
        money = 20000000,
    },
    [2] = {--"16¼¶²®ÀÖÖ®ÑÛ£¬½ðÇ®3000Íò£¬À¶±¦Ê¯80¸ö£¬½«¾üÁî500¸ö"
        item = {--id1,id2,id3,id4,num
            { 3, 1180, 0, 0, 1 },
            { 3, 41, 0, 0, 80 },
            {
                { 3, 100, 0, 0, 500 },
                { 3, 100, 0, 0, 500 },
            },
        },
        money = 30000000,
    },
    [3] = {--"16¼¶²®ÀÖÖ®ÑÛ2¸ö£¬À¶±¦Ê¯200¸ö£¬½ðÇ®8000Íò£¬½«¾üÁî950¸ö£¬²®ÀÖ¾«½ð15¸ö"
        item = {--id1,id2,id3,id4,num
            { 3, 1180, 0, 0, 2 },
            { 3, 41, 0, 0, 120 },
            { 3, 100, 0, 0, 950 },
            {
                { 3, 1181, 0, 0, 15 },
                { 3, 100, 0, 0, 2250 },
            },
        },
        money = 80000000,
    },
}
--ÊôÐÔÃû³ÆÉèÖÃ: ¸½¼ÓÊôÐÔp1....p14
prop_name = { [1] = "TÊt c¶ kh¸ng tÝnh", [2] = "S¸t th­¬ng c¬ b¶n", [3] = "Tû lÖ sinh lùc", [4] = "Vò khÝ xuÊt chiªu", [5] = "B¹o kÝch", [6] = "Sinh lùc", [7] = "Gi¶m s¸t th­¬ng c¬ b¶n", [8] = "ChuyÓn hãa S¸t th­¬ng thµnh Néi lùc", [9] = "Háa s¸t t¨ng", [10] = "XuÊt chiªu", [11] = "§ãng b¨ng", [12] = "ChÝnh x¸c -háa", [13] = "Thæ s¸t", [14] = "Phßng ngù", [15] = "Bá qua phßng ngù", }

function ChangeHorse()
    CloseDialog()
    local PType = GetPlayerType() + 1
    local item_list = {}
    local strl = ""
    if (PType <= 0 or PType > getn(Horse_probability)) then
        Talk(1, "no", "Tu Hµnh S­:Chän sai nghÒ nghiÖp")
        return
    end

    SetTask(1009, 0) --Ä¬ÈÏ
    SetTask(140, 0)
    for i = 0, getn(Horse_probability[PType]) do
        strl = "(§.cÊp y.cÇu:" .. Horse_probability[PType][i]["lvl"] .. ")"
        item_list[i + 1] = Horse_probability[PType][i]["name"] .. strl .. "/item_h"
    end

    Say("Tu Hµnh S­:H·y chän Thó C­ìi muèn ghÐp", getn(item_list), item_list)
end

function item_h(nNum)
    CloseDialog()
    local strItems = ""
    local zh = GetPlayerType() + 1
    if (zh <= 0 or zh > getn(Horse_probability)) then
        Talk(1, "no", "Tu Hµnh S­:Sai nöa råi, h·y chän l¹i.")
        return
    end
    if (nNum < 0 or nNum > getn(Horse_probability[zh])) then
        Talk(1, "no", "Tu Hµnh S­:Sai nöa råi, h·y chän l¹i.")
        return
    end
    strItems = getstring(zh, nNum)
    SetTask(1009, nNum)
    if (strItems == "") then
        Talk(1, "no", "Tu Hµnh S­:Sai nöa råi, h·y chän l¹i.")
    elseif (Horse_probability[zh][nNum]["coin1"] ~= "") then
        Talk(1, "ChooseCailiao", strItems)
    else
        MsgBox(strItems .. "Yªu cÇu <c=g>" .. Horse_probability[zh][nNum]["coin"] .. ". <c> B¹n cã muèn ghÐp kh«ng?", "CoinCailiao", "no")
    end
end;

function getstring(zh, id)
    -- zhÖ°Òµ,id±àºÅ
    if (zh <= 0 or zh > getn(Horse_probability)) then
        return ""
    end

    if (id < 0 or id > getn(Horse_probability[zh])) then
        return ""
    end

    local str1 = ""
    local str = ""
    str1 = Horse_probability[zh][id]["name"]

    if (str1 ~= "") then
        local str2, str3, str4, str5 = 0, "", "", ""

        for k = 1, getn(Horse_probability[zh][id]["value"]) do
            str2 = Horse_probability[zh][id]["prob"][k]
            if (str2 > 0 and str2 <= getn(prop_name)) then
                str3 = prop_name[str2] .. ":" .. Horse_probability[zh][id]["value"][k]
                if (str3 ~= "") then
                    str4 = str4 .. "<c=water>" .. str3 .. "<c>\n"--¸½¼ÓÊôÐÔÏîµÄ×Ö·û´®ËµÃ÷
                end ;
                str3 = ""
            else
                break
            end ;
        end ;

        if (str4 ~= "") then
            str = "<c=yel>" .. str1 .. "<c>:<c=r> (§.cÊp:" .. Horse_probability[zh][id]["lvl"] .. ", t.®é:" .. Horse_probability[zh][id]["speed"] .. "%)</c>\n" .. str4 .. "<c><c=red> ghÐp sÏ kh«ng gi÷ th«ng tin kh¶m lç.<c>"
        end
    end
    return str
end

function ChooseCailiao()
    CloseDialog()
    local item_list = {
        "B¸ L¹c Tinh +T­íng Qu©n LÖnh /ChooseCailiao1",
        "T­íng Qu©n LÖnh /ChooseCailiao1",
    }
    Say("Tu Hµnh S­:H·y chän nguyªn liÖu\nB¸ L¹c Tinh dïng ®Ó thay thÕ NghÞch Thiªn Hoµng Kim Th¸nh Thó chÕ t¸c T­íng Qu©n LÖnh.", getn(item_list), item_list)
end

function ChooseCailiao1(nIndex)
    CloseDialog()
    if (nIndex < 0 or nIndex > 1) then
        Talk(1, "no", "Tu Hµnh S­:Chän sai råi!")
        return
    end

    local strItems = ""
    local zh = GetPlayerType() + 1
    local id = GetTask(1009)
    if (zh <= 0 or zh > getn(Horse_probability)) then
        Talk(1, "no", "Tu Hµnh S­:Chän sai råi!")
        return
    end

    if (id < 0 or id > getn(Horse_probability[zh])) then
        Talk(1, "no", "Tu Hµnh S­:Chän sai råi!")
        return
    end

    SetTask(140, nIndex)
    if (nIndex == 0) then
        MsgBox("Tu Hµnh S­:GhÐp" .. Horse_probability[zh][id]["name"] .. "Nguyªn liÖu cÇn <c=g>" .. Horse_probability[zh][id]["coin"] .. "<c>. Muèn ghÐp kh«ng?", "CoinCailiao", "no")
    else
        MsgBox("Tu Hµnh S­:GhÐp" .. Horse_probability[zh][id]["name"] .. "Nguyªn liÖu cÇn <c=g>" .. Horse_probability[zh][id]["coin1"] .. "<c>. Muèn ghÐp kh«ng?", "CoinCailiao", "no")
    end
end

function CoinCailiao()
    CloseDialog()
    local zhty = GetPlayerType() + 1
    local CheckIndex = GetTask(1009)
    local nIndex = GetTask(140)
    if (CheckIndex < 0 or CheckIndex > getn(tbl_Horse_Item) or zhty <= 0 or zhty > getn(Horse_probability) or nIndex < 0 or nIndex > 1) then
        Talk(1, "no", "Tu Hµnh S­:L¹i sai n÷a råi, h·y chän l¹i.")
        return
    end

    local bFlag = 0
    local nItem = tbl_Horse_Item[CheckIndex].item
    local nSpecItem = Horse_probability[zhty][CheckIndex]["needid"]
    for i = 1, getn(nItem) - 1 do
        if (HaveNormalItem(nItem[i][1], nItem[i][2], nItem[i][3], nItem[i][4]) < nItem[i][5]) then
            bFlag = 1
            break
        end
    end

    local nChooseItem = nItem[getn(nItem)][1]
    local str = Horse_probability[zhty][CheckIndex]["coin"]
    if (nIndex == 1 and Horse_probability[zhty][CheckIndex]["coin1"] ~= "") then
        nChooseItem = nItem[getn(nItem)][2]
        str = Horse_probability[zhty][CheckIndex]["coin1"]
        if (HaveNormalItem(nChooseItem[1], nChooseItem[2], nChooseItem[3], nChooseItem[4]) < (nChooseItem[5] + nItem[getn(nItem) - 1][5])) then
            bFlag = 1
        end
    else
        if (HaveNormalItem(nChooseItem[1], nChooseItem[2], nChooseItem[3], nChooseItem[4]) < nChooseItem[5]) then
            bFlag = 1
        end
    end

    if (bFlag == 1 or GetCash() < tbl_Horse_Item[CheckIndex].money or HaveNormalItem(nSpecItem[1], nSpecItem[2], nSpecItem[3], nSpecItem[4]) <= 0) then
        Talk(1, "no", "Tu Hµnh S­:Nguyªn liÖu kh«ng ®ñ, cÇn nh­ sau:" .. str .. ".")
        return
    end

    for i = 1, getn(nItem) - 1 do
        for j = 1, nItem[i][5] do
            DelNormalItem(nItem[i][1], nItem[i][2], nItem[i][3], nItem[i][4])
        end
    end

    for j = 1, nChooseItem[5] do
        DelNormalItem(nChooseItem[1], nChooseItem[2], nChooseItem[3], nChooseItem[4])
    end

    DelNormalItem(nSpecItem[1], nSpecItem[2], nSpecItem[3], nSpecItem[4])
    Pay(tbl_Horse_Item[CheckIndex].money)
    local nAddItem = Horse_probability[zhty][CheckIndex]["addid"]
    AddNormalItem(nAddItem[1], nAddItem[2], nAddItem[3], nAddItem[4], 0, 0)
    Talk(1, "no", "Tu Hµnh S­:NhËn ®­îc <c=g>" .. Horse_probability[zhty][CheckIndex]["name"] .. "<c>.")
    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. Horse_probability[zhty][CheckIndex]["name"])
    WriteLog("Thó c­ìi Hoµng Kim Tiªn Ma:" .. Horse_probability[zhty][CheckIndex]["name"])
    AddGlobalNews("Chóc mõng" .. GetName() .. "GhÐp thó c­ìi quý hiÕm ë Tiªn Ma Giíi" .. Horse_probability[zhty][CheckIndex]["name"] .. ", nguyªn c¶ Tiªn Ma Giíi ®Òu bÞ chÊn ®éng!")
end
--modified by liujifang for ÏÉÄ§½ç»Æ½ð×øÆï at 2012-12-25 end