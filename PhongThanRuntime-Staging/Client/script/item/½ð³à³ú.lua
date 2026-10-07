Task_Tree_Day = 1533
Task_Tree_Partner = 1534
Task_Tree_Process = 1535

TaskInfo = 1093

PlantTree = {
    [1] = { event = "T­íi n­íc", templateID = 566, },
    [2] = { event = "B¾t s©u", templateID = 565, },
    [3] = { event = "Trõ cá", templateID = 564, },
}

function getCoupleTeamStatus()
    if (IsMarried() ~= 1) then
        return 0
    elseif (GetTeamSize() ~= 2) then
        return 0
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local playerIndexCache = PlayerIndex
    PlayerIndex = teammateIndex
    local teammateID = math.mod(GetUUID(), 2 ^ 31)
    local teammateSpouseID = math.mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    PlayerIndex = playerIndexCache
    local selfID = math.mod(GetUUID(), 2 ^ 31)
    local selfSpouseID = math.mod((GetTask(801) + 2 ^ 31), (2 ^ 31))
    if (selfID == teammateSpouseID and selfSpouseID == teammateID) then
        return 1, teammateIndex
    else
        return 0
    end
end

function isFitThreeTask()

    if (GetTeamSize() ~= 2) then
        Talk(1, "no", "Ph¶i cã hai ng­êi tæ ®éi míi cã thÓ tham gia ho¹t ®éng!")
        return 0
    end

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

    if (isHaveBuff1 <= 0) or (isHaveBuff2 <= 0) then
        return 0
    end

    if (w1 ~= 14) or (w2 ~= 14) then
        Msg2Team("Hai ng­êi trong tæ ®éi ph¶i cïng ë §ång Quan míi cã thÓ tiÕp tôc ho¹t ®éng!")
        return 0
    end

    return 1
end

function main(l, t, TargetNpcIndex)
    if (isFitThreeTask() == 0) then
        return
    end

    if (TargetNpcIndex == 0) or (GetNpcTemplateID(TargetNpcIndex) ~= 1224) then
        Talk(1, "no", "ChØ chuét vµo th©n c©y,Cuèc Kim XÝch ®Æt vµo thanh phÝm t¾t sö dông míi cã thÓ trõ cá cho MÇm c©y!")
        return
    end

    local playerID = GetPlayerID()
    if (GetNpcTask(TargetNpcIndex, 1) ~= playerID) and (GetNpcTask(TargetNpcIndex, 2) ~= playerID) then
        Talk(1, "no", "C©y nµy kh«ng ph¶i cña b¹n!")
        return
    end

    local seq = GetNpcTask(TargetNpcIndex, 3)
    seq = seq + 1

    if (seq == 7) or (seq == 3) or (seq == 9) then
        if (GetNpcTask(TargetNpcIndex, 5) == 3) then
            SetMotion(TargetNpcIndex, eventType)
        else
            Talk(1, "no", "B¹n sö dông kh«ng ®óng ®¹o cô.")
        end
    elseif (seq <= 10) then
        Talk(1, "no", "MÇm c©y ®· lín v÷ng ch¾c, kh«ng cÇn ch¨m sãc n÷a.")
    elseif (seq > 10) then
        Talk(1, "no", "MÇm c©y ®· tr­ëng thµnh, kh«ng cÇn ph¶i ch¨m sãc n÷a!")
    end
end

function SetMotion(TargetNpcIndex)
    local nWorldId, nX, nY = GetNpcWorldPos(TargetNpcIndex)
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

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 0)
    nInterrupt = SetBit(nInterrupt, 3, 0)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 9, 1)

    oldPlayer = PlayerIndex
    PlayerIndex = GetTeamMember(1)
    BeginMotion(TargetNpcIndex, 1, 5, "\\script\\motion\\ÅàÑøÊ÷Ãç.lua", nInterrupt)

    PlayerIndex = GetTeamMember(2)
    BeginMotion(TargetNpcIndex, 1, 5, "\\script\\motion\\ÅàÑøÊ÷Ãç.lua", nInterrupt)

    PlayerIndex = oldPlayer
end

function no()
    CloseDialog()
end
