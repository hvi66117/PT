Task_affection_Day = 1533
Task_affection_Partner = 1534
Task_affection_Process = 1535
Task_Search_BindingNpc = 1536

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

    playerIndex1 = GetTeamMember(1)
    playerIndex2 = GetTeamMember(2)

    PlayerIndex = playerIndex1
    local w1, x1, y1 = GetWorldPos()
    local name1 = GetName()
    local playerID1 = GetPlayerID()
    local partnerID1 = GetTask(Task_affection_Partner)
    local isHaveBuff1 = HaveIBBuff(772)

    PlayerIndex = playerIndex2
    local w2, x2, y2 = GetWorldPos()
    local name2 = GetName()
    local playerID2 = GetPlayerID()
    local partnerID2 = GetTask(Task_affection_Partner)
    local isHaveBuff2 = HaveIBBuff(772)

    PlayerIndex = oldPlayer

    if (playerID1 ~= partnerID2) or (playerID2 ~= partnerID1) then
        Msg2Team("Ph¶i cã ng­êi lÇn tr­íc cïng b¹n nhËn nhiÖm vô nµy tæ ®éi víi nhau, míi cã thÓ tiÕp tôc tiÕn hµnh!")
        return 0
    end

    if (w1 ~= w2) then
        Msg2Team("B¹n vµ ng­êi yªu cña m×nh ph¶i ë trong cïng mét khu vùc!")
        return 0
    end

    if (isHaveBuff1 == 0) or (isHaveBuff2 == 0) then
        return 0
    end

    return 1

end

function main()
    if (isFitThreeTask() == 0) then
        return
    end

    if (GetSex() == 1) then
        return
    end

    if (GetTaskByte(Task_affection_Process, 1) ~= 1) then
        return
    end

    local bindingNpcID = GetTask(Task_Search_BindingNpc)
    local tGuardIndex = GetTGuardIndexByPlayerName(GetName())

    local a, b, c, d, carriageIndex = GetTGuardInfo(tGuardIndex)
    local carriageNpcIndex = GetSiegeWeaponNpcIndex(carriageIndex)
    local siegeWeaponNpcID = GetNpcID(carriageNpcIndex)

    if (siegeWeaponNpcID == bindingNpcID) then
        PlayerInOrOut(0, carriageNpcIndex)
        SetTaskByte(Task_affection_Process, 1, 2)
        RemoveIBBuff(772)
        Msg2Player("Hoµn thµnh T×nh ý Miªn Miªn, cã thÓ gÆp øng Tiªm Th­¬ng nhËn th­ëng!")
        TopMessage("T×nh ý Miªn Miªn: hoµn thµnh!")
        TaskNote(TaskInfo, 8)

        local playerIndexCache = PlayerIndex
        if (PlayerIndex == GetTeamMember(1)) then
            PlayerIndex = GetTeamMember(2)
        else
            PlayerIndex = GetTeamMember(1)
        end

        SetTaskByte(Task_affection_Process, 1, 2)
        RemoveIBBuff(772)
        Msg2Player("Hoµn thµnh T×nh ý Miªn Miªn, cã thÓ gÆp øng Tiªm Th­¬ng nhËn th­ëng!")
        TopMessage("T×nh ý Miªn Miªn: hoµn thµnh!")
        TaskNote(TaskInfo, 8)

        PlayerIndex = playerIndexCache

        PlayerCastSkill(1, 212, 1)
        DelNormalItem(6, 1, 567, 0)
    end
end

function no()
    CloseDialog()
end
