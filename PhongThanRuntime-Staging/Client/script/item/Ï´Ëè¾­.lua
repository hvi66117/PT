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
    local selfID = GetPlayerID()
    if (GetFightState() == 0) then
        Talk(1, "no", 14328)
    elseif (isSTTeam ~= 1) then
        Talk(1, "no", 14329)
    elseif (masterFlag ~= 0) then
        Talk(1, "no", 14330)
    elseif (teammateID ~= GetTask(Task_XJFS_BindingID)) then
        Talk(1, "no", 14331)
    elseif (selfID ~= getTeammateBindingID()) then
        Talk(1, "no", 14332)
    elseif (taskStatus ~= 1) then
        Talk(1, "no", 14333)
    elseif (GetFreeNpcCount() <= 200) then
        Talk(1, "no", 14334)
    else
        local mapid, x, y = GetWorldPos()
        local bossCount = 0
        for i = 1, 5 do
            local npcIndex = AddNpc(Boss_CopperMan_ID, 40, SubWorld, x * 32, y * 32)
            if (npcIndex > 0) then
                bossCount = bossCount + 1
                local newNpcName = "<c=r>уng Nh﹏<c>"
                SetNpcName(npcIndex, newNpcName)
                SetNpcScript(npcIndex, "\\script\\怪物\\铜人.lua")
                SetNpcTimer(npcIndex, "\\script\\ontimer\\删掉自己.lua", 300)
            end
        end
        if (bossCount > 0) then
            SetTask(Task_XJFS_Status, SetByte(SetByte(SetByte(SetByte(0, 1, 2), 2, 0), 3, 0), 4, 0))
            TaskNote(Task_Info_XJFS, 2)
            local playerIndexCache = PlayerIndex
            PlayerIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
            SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 2))
            TaskNote(Task_Info_XJFS, 3)
            PlayerIndex = playerIndexCache
            DelNormalItem(6, 1, 383, 1)
            Talk(1, "no", "Х g鋓 ra" .. bossCount .. " уng Nh﹏")
        else
            Talk(1, "no", 14335)
        end
    end
end

function no()
    CloseDialog()
end
