--Á¬ÀíÊ÷Ãç.lua
--author:gaojingwei
--date:090814

--ÐÄÓÐÁéÏ¬Ç©
Task_Tree_Day = 1533            --1½ÓÈÎÎñÈÕÆÚ
Task_Tree_Partner = 1534        --Í¬°éID
Task_Tree_Process = 1535        --1byte =1 ÕªÈ¡ÁËÊÖÁ´

TaskInfo = 1093

PlantTree = {
    [1] = { event = "T­íi n­íc", templateID = 566, },
    [2] = { event = "B¾t s©u", templateID = 565, },
    [3] = { event = "Trõ cá", templateID = 564, }
}

-- È¡µÃ·òÆÞ×é¶ÓÇé¿ö
function getCoupleTeamStatus()
    if (IsMarried() ~= 1) then
        return 0
    elseif (GetTeamSize() ~= 2) then
        return 0
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local playerIndexCache = PlayerIndex
    PlayerIndex = teammateIndex
    local teammateID = mod(GetUUID(), 2 ^ 31)
    local teammateSpouseID = mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    PlayerIndex = playerIndexCache
    local selfID = mod(GetUUID(), 2 ^ 31)
    local selfSpouseID = mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    if (selfID == teammateSpouseID and selfSpouseID == teammateID) then
        return 1, teammateIndex
    else
        return 0
    end
end

function isFitThreeTask()
    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "Ph¶i cã 2 ng­êi tæ ®éi míi cã thÓ tham gia ho¹t ®éng.")
        return 0
    end

    --ÅÐ¶ÏbufÊÇ·ñÂú
    local oldPlayer = PlayerIndex
    for i = 1, GetTeamSize() do
        PlayerIndex = GetTeamMember(i)
        if (GetIBBuffCount() >= 32) then
            Msg2Team(GetName() .. "Cã qu¸ nhiÒu tr¹ng th¸i buff, xin xãa bít råi quay l¹i!")
            PlayerIndex = oldPlayer
            return 0
        end
    end

    PlayerIndex = oldPlayer

    playerIndex1 = GetTeamMember(1)
    playerIndex2 = GetTeamMember(2)

    PlayerIndex = playerIndex1
    local playerID1 = GetPlayerID()
    local partnerID1 = GetTask(Task_Tree_Partner)
    local taskProcess1 = GetTaskByte(Task_Tree_Process, 1)
    local w1, x1, y1 = GetWorldPos()
    local isHaveBuff1 = HaveIBBuff(770)

    PlayerIndex = playerIndex2
    local playerID2 = GetPlayerID()
    local partnerID2 = GetTask(Task_Tree_Partner)
    local taskProcess2 = GetTaskByte(Task_Tree_Process, 1)
    local w2, x2, y2 = GetWorldPos()
    local isHaveBuff2 = HaveIBBuff(770)

    PlayerIndex = oldPlayer

    if (playerID1 ~= partnerID2) or (playerID2 ~= partnerID1) then
        Msg2Team("Ph¶i cã ng­êi lÇn tr­íc cïng b¹n nhËn nhiÖm vô nµy tæ ®éi víi nhau, míi cã thÓ tiÕp tôc tiÕn hµnh!")
        return 0
    end

    if ((isHaveBuff1 <= 0) or (isHaveBuff2 <= 0)) and (GetNpcTask(DialogNpcIdx, 3) < 10) then
        return 0
    end

    if (w1 ~= 14) or (w2 ~= 14) then
        Msg2Team("Hai ng­êi trong tæ ®éi ph¶i cïng ë §ång Quan míi cã thÓ tiÕp tôc ho¹t ®éng!")
        return 0
    end

    return 1
end

--AS GaoJingwei 2009/08/02 
--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    return 0, 0
end
--AE GaoJingwei 2009/08/02 

function main()

    if (GetNpcPolyMorph(DialogNpcIdx) == 1229) then
        return
    end

    local seq = GetNpcTask(DialogNpcIdx, 3)

    if (isFitThreeTask() == 0) then
        return
    end

    local playerID = GetPlayerID()
    if (playerID ~= GetNpcTask(DialogNpcIdx, 1)) and (playerID ~= GetNpcTask(DialogNpcIdx, 2)) then
        Talk(1, "no", "C©y nµy kh«ng ph¶i cña b¹n!")
        return
    end

    if (seq < 10) then

        if (GetSex() == 0) then
            Talk(1, "no", "ChØ cã nh©n vËt n÷ nhÊp vµo MÇm c©y míi cã thÓ nh×n thÊy tr¹ng th¸i tr­ëng thµnh cña C©y l­¬ng duyªn.")
            return
        end

        if (HaveNormalItem(3, 472, 0, 0) == 0) then
            Talk(1, "no", "B¹n kh«ng cã QuyÖn Tiªn PhÊn, kh«ng thÓ tiÕn hµnh ch¨m sãc c©y!")
            return
        end

        local taskType = mod((seq + 1), 3)

        if (taskType == 0) then
            taskType = 3
        end

        SetTask(142, DialogNpcIdx)
        processTree()

    elseif (seq == 10) then
        --ÕªÈ¡ÊÖÁ´
        if (GetTaskByte(Task_Tree_Process, 1) == 0) then
            SetTaskByte(Task_Tree_Process, 1, 1)
            AddNormalItem(6, 1, 569, 0, 0, 0)
            Talk(1, "no", "B¹n nhËn ®­îc Thiªn Duyªn Thñ Liªn, h·y mau cïng víi nöa kia cña m×nh ®Õn gÆp øng Tiªm Th­¬ng nhËn th­ëng!")
            Msg2Player("NhËn ®­îc 1 vßng ®eo tay")

            local count = GetNpcTask(DialogNpcIdx, 4)
            count = count + 1
            SetNpcTask(DialogNpcIdx, 4, count)
            TaskNote(TaskInfo, 5)
        elseif (GetTaskByte(Task_Tree_Process, 1) == 1) then
            Talk(1, "no", "B¹n ®· nhËn ®­îc Thiªn Duyªn Thñ Liªn, h·y ®Õn TriÒu Ca gÆp øng Tiªm Th­¬ng nhËn th­ëng!")
            Msg2Player("B¹n ®· nhËn ®­îc Thiªn Duyªn Thñ Liªn, h·y ®Õn TriÒu Ca gÆp øng Tiªm Th­¬ng nhËn th­ëng!")
        end
    end
end

function processTree()
    CloseDialog()

    if (isFitThreeTask() == 0) then
        return
    end

    local dialog = GetTask(142)
    if (dialog == 0) or (dialog ~= DialogNpcIdx) then
        return
    end

    local nWorldId, nX, nY = GetNpcWorldPos(dialog)
    local oldPlayer = PlayerIndex
    PlayerIndex = GetTeamMember(1)
    local w1, x1, y1 = GetWorldPos()

    PlayerIndex = GetTeamMember(2)
    local w2, x2, y2 = GetWorldPos()

    PlayerIndex = oldPlayer

    local distance1 = (nX - x1) ^ 2 + (nY - y1) ^ 2
    local distance2 = (nX - x2) ^ 2 + (nY - y2) ^ 2

    if (distance1 > 160) or (distance2 > 160) then
        Msg2Team("B¹n c¸ch MÇm c©y qu¸ xa, cÇn ®Õn gÇn MÇm c©y míi cã thÓ ch¨m sãc!")
        return
    end

    local seq = GetNpcTask(dialog, 3)
    seq = seq + 1

    local tasks = {
        [1] = "T­íi n­íc.",
        [2] = "B¾t s©u.",
        [3] = "Trõ cá."
    }

    if (seq == 3) or (seq == 7) or (seq == 9) and (GetNpcTask(dialog, 5) == 0) then
        local r = random(1, 3)
        Talk(1, "no", "Xin ®Ó nöa kia cña ng­¬i giao cho ta " .. tasks[r])
        Msg2Player("Xin ®Ó nöa kia cña ng­¬i giao cho ta " .. tasks[r])
        SetNpcTask(dialog, 5, r)
    elseif (seq == 3) or (seq == 7) or (seq == 9) then
        local r = GetNpcTask(dialog, 5)
        Talk(1, "no", "Xin ®Ó nöa kia cña ng­¬i giao cho ta " .. tasks[r])
        Msg2Player("Xin ®Ó nöa kia cña ng­¬i giao cho ta " .. tasks[r])
    else
        SetNpcTask(dialog, 3, seq)
        if (seq ~= 10) then
            Talk(1, "no", "Ch¨m sãc thµnh c«ng, MÇm c©y ®· lín rÊt kháe")
        elseif (seq == 10) then
            Msg2Team("C©y l­¬ng duyªn ®· lín v÷ng vµng! Xin hai vÞ h·y nhÊp vµo c©y ®Ó nhËn thµnh qu¶ t×nh yªu cña m×nh!")
        end
    end

end

function no()
    CloseDialog()
end
