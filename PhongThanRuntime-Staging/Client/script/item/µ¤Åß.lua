Task_XJFS_Status = 1248
Task_XJFS_BindingID = 1249

Task_Info_XJFS = 1018

Boss_CopperMan_ID = 727
Buff_XJFS = 466

function getTeamStatus()
    if (GetTeamSize() ~= 2) then
        return 0
    end
    local teammateIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local masterIndex = GetMasterPlayerIndex(teammateIndex)
    if (masterIndex == PlayerIndex) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = teammateIndex
        local teammateID = GetPlayerID()
        local prenticeLevel = GetLevel()
        local prenticeStatus = GetByte(GetTask(Task_XJFS_Status), 2)
        PlayerIndex = playerIndexCache
        return 1, 1, teammateID, prenticeLevel, prenticeStatus
    elseif (masterIndex == teammateIndex) then
        local playerIndexCache = PlayerIndex
        PlayerIndex = teammateIndex
        local teammateID = GetPlayerID()
        PlayerIndex = playerIndexCache
        local prenticeLevel = GetLevel()
        local prenticeStatus = GetByte(GetTask(Task_XJFS_Status), 2)
        return 1, 0, teammateID, prenticeLevel, prenticeStatus
    else
        return 0
    end
end

function getTeammateBindingID()
    local playerIndexCache = PlayerIndex
    PlayerIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
    local bindingID = GetTask(Task_XJFS_BindingID)
    PlayerIndex = playerIndexCache
    return bindingID
end

function main()
    local isSTTeam, masterFlag, teammateID, prenticeLevel, prenticeStatus = getTeamStatus()
    local taskStatus = GetByte(GetTask(Task_XJFS_Status), 1)
    local mapid, x, y = GetWorldPos()
    local selfID = GetPlayerID()
    if (mapid ~= 68 and mapid ~= 69 and mapid ~= 70 and mapid ~= 79 and mapid ~= 80 and mapid ~= 81 and mapid ~= 82) then
        Talk(1, "no", 14290)
    elseif (isSTTeam ~= 1) then
        Talk(1, "no", 14291)
    elseif (masterFlag ~= 1) then
        Talk(1, "no", 14292)
    elseif (teammateID ~= GetTask(Task_XJFS_BindingID)) then
        Talk(1, "no", 14293)
    elseif (selfID ~= getTeammateBindingID()) then
        Talk(1, "no", 14294)
    elseif (taskStatus == 4) then
        Talk(1, "no", 14295)
    elseif (taskStatus ~= 3) then
        Talk(1, "no", 14296)
    else
        local useTime = GetByte(GetTask(Task_XJFS_Status), 3) + 1
        SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 3, useTime))
        if (useTime < 7) then
            TopMessage("Thiªn C­¬ng ¶nh thø" .. useTime .. " sö dông §an Ph«i")
        elseif (useTime == 7) then
            DelNormalItem(6, 1, 384, 1)
            TopMessage(14297)
        else
            DelNormalItem(6, 1, 384, 1)
            return
        end
        RemoveIBBuff(Buff_XJFS)
        AddIBBuff(Buff_XJFS)
    end
end

function no()
    CloseDialog()
end
