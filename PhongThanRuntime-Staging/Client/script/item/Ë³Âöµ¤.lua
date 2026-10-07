Task_HeartEvil_Status = 1242
Task_HeartEvil_PrenticeID = 1243
Task_HeartEvil_SummonTime = 1244
Task_HeartEvil_BossID = 1245

Task_Info_HeartEvil = 1017

Buff_HE_Evil = 464
Buff_HE_Medicine = 465

Random_Maps = {
    [0] = { mapid = 0, name = "Khu vùc v« hiÖu" },
    [1] = { mapid = 2, name = "Sïng Thµnh doanh" },
    [2] = { mapid = 3, name = "Ngäc H­ cung" },
    [3] = { mapid = 4, name = "Xi V­u Mé" },
    [4] = { mapid = 20, name = "T©y Kú" },
    [5] = { mapid = 21, name = "TriÒu Ca" },
}

function main()
    if (GetTeamSize() ~= 2) then
        Talk(1, "no", 14352)
        return
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local masterIndex = GetMasterPlayerIndex(teammateIndex)
    if (masterIndex ~= teammateIndex) then
        Talk(1, "no", GetName() .. ": VËt nµy quý hiÕm, hay lµ ®Ó cho S­ phô dïng vËy!")
        return
    end
    if (GetWorldPos() ~= 9) then
        Talk(1, "no", GetName() .. ":VËt nµy chØ cã thÓ sö dông ë T©y C«n L«n!")
        return
    end
    local playerIndexCache = PlayerIndex
    PlayerIndex = masterIndex
    if (GetWorldPos() ~= 9) then
        PlayerIndex = playerIndexCache
        Talk(1, "no", GetName() .. ": S­ phô l¹i kh«ng ë ®©y!")
        return
    end
    local taskPrenticeID = GetTask(Task_HeartEvil_PrenticeID)
    PlayerIndex = playerIndexCache

    local taskStatus = GetByte(GetTask(Task_HeartEvil_Status), 1)
    local masterFlag = GetByte(GetTask(Task_HeartEvil_Status), 3)
    if (masterFlag ~= 2) then
        Talk(1, "no", GetName() .. "Ph¶i nhËn nhiÖm vô Gi¶i Trõ T©m Ma th× ®å ®Ö míi cã thÓ sö dông!")
    elseif (taskStatus ~= 1) then
        Talk(1, "no", 14353)
    elseif (taskPrenticeID ~= math.mod(GetUUID(), 2 ^ 31)) then
        Talk(1, "no", 14354)
    else
        local taskMapID = GetByte(GetTask(Task_HeartEvil_Status), 4)
        playerIndexCache = PlayerIndex
        PlayerIndex = masterIndex
        local isHaveBuff1 = HaveIBBuff(Buff_HE_Evil)
        local isHaveBuff2 = HaveIBBuff(Buff_HE_Medicine)
        if (isHaveBuff1 ~= 0 or isHaveBuff2 ~= 0) then
            RemoveIBBuff(Buff_HE_Evil)
            RemoveIBBuff(Buff_HE_Medicine)
            AddIBBuff(Buff_HE_Medicine)
            SetTask(Task_HeartEvil_Status, SetByte(GetTask(Task_HeartEvil_Status), 4, taskMapID))
            TopMessage(14355)
            Msg2Player("§å ®Ö ®· dïng thuèc gi¶i gióp b¹n gi¶i trõ bµu chó T©m Ma")
            PlayerIndex = playerIndexCache
            DelNormalItem(6, 1, 382, 1)
            Msg2Player("B¹n gióp S­ phô gi¶i trõ ®­îc Bïa chó T©m Ma")
            TopMessage(14356)
            Talk(1, "no", 14357)
        else
            PlayerIndex = playerIndexCache
            Talk(1, "no", GetName() .. ": S­ phô ®· ®­îc b×nh an!")
        end
    end
end

function no()
    CloseDialog()
end
