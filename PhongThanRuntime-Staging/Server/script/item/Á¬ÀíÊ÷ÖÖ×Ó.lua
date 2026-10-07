Task_Tree_Day = 1533
Task_Tree_Partner = 1534
Task_Tree_Process = 1535

TaskInfo = 1093

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
        Talk(1, "no", "Ph¶i cã 2 ng­êi tæ ®éi míi cã thÓ tham gia ho¹t ®éng.")
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
    local taskDay1 = GetTaskByte(Task_Tree_Day, 1)
    local taskProcess1 = GetTaskByte(Task_Tree_Process, 1)
    local w1, x1, y1 = GetWorldPos()

    PlayerIndex = playerIndex2
    local playerID2 = GetPlayerID()
    local partnerID2 = GetTask(Task_Tree_Partner)
    local taskDay2 = GetTaskByte(Task_Tree_Day, 1)
    local taskProcess2 = GetTaskByte(Task_Tree_Process, 1)
    local w2, x2, y2 = GetWorldPos()

    PlayerIndex = oldPlayer
    local Y, M, D = GetYMD()

    if (playerID1 ~= partnerID2) or (playerID2 ~= partnerID1) then
        Msg2Team("Ph¶i cã ng­êi lÇn tr­íc cïng b¹n nhËn nhiÖm vô nµy tæ ®éi víi nhau, míi cã thÓ tiÕp tôc tiÕn hµnh!")
        return 0
    end

    if (w1 ~= 14) or (w2 ~= 14) then
        Msg2Team("Hai ng­êi trong tæ ®éi ph¶i cïng ë §ång Quan míi cã thÓ tiÕp tôc ho¹t ®éng!")
        return 0
    end

    if (taskDay1 ~= 7) or (taskDay2 ~= 7) then
        Msg2Team("Trong ®éi cã ng­êi ch­a nhËn nhiÖm vô T©m H÷u Linh Tª.")
        return 0
    end

    if (taskProcess1 ~= 0) or (taskProcess2 ~= 0) then
        Msg2Team("Mçi ngµy chØ cã thÓ tham gia 1 lÇn ho¹t ®éng!")
        return 0
    end

    return 1
end

function main()

    if (isFitThreeTask() == 0) then
        return
    end

    DelNormalItem(6, 1, 568, 0)
    local w, x, y = GetWorldPos()
    local npcidx = AddNpc(1224, 1, SubWorldID2Idx(14), x * 32, y * 32)
    SetNpcScript(npcidx, "\\script\\item\\Á¬ÀíÊ÷Ãç.lua")
    SetNpcTimer(npcidx, "\\script\\ontimer\\Ê÷Ãç±äÉí.lua", 600)

    local oldPlayer = PlayerIndex
    local captainName = ""

    PlayerIndex = GetTeamMember(1)
    playerID1 = GetPlayerID()
    AddIBBuff(770)

    if (IsCaptain() == 1) then
        captainName = GetName()
    end

    PlayerIndex = GetTeamMember(2)
    playerID2 = GetPlayerID()
    AddIBBuff(770)

    if (IsCaptain == 1) then
        captainName = GetName()
    end

    PlayerIndex = oldPlayer

    SetNpcTask(npcidx, 1, playerID1)
    SetNpcTask(npcidx, 2, playerID2)
    SetNpcTask(npcidx, 3, 0)
    SetNpcTask(npcidx, 4, 0)
    SetNpcName(npcidx, captainName .. "_")

    Msg2Team("MÇm c©y ®· trång! ChØ cã nh©n vËt n÷ míi cã thÓ ch¨m sãc cho MÇm c©y.")
end

function no()
    CloseDialog()
end
