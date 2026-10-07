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

function OnDeath(npcidx)
    local mapid, x, y = GetNpcWorldPos(npcidx)
    local isSTTeam, masterFlag, teammateID, prenticeLevel, prenticeStatus = getTeamStatus()
    local taskStatus = GetByte(GetTask(Task_XJFS_Status), 1)
    local isSummonNewBoss = 1
    local selfID = GetPlayerID()
    if (taskStatus == 2 and isSTTeam == 1 and masterFlag == 0
            and teammateID == GetTask(Task_XJFS_BindingID) and selfID == getTeammateBindingID()) then


        local playerIndexCache = PlayerIndex
        local playerIdx = SearchPlayerById(teammateID)
        PlayerIndex = playerIdx
        local mapid2, x2, y2 = GetWorldPos()
        PlayerIndex = playerIndexCache

        local killCount = GetByte(GetTask(Task_XJFS_Status), 3) + 1

        if (mapid2 ~= mapid) then
        elseif (killCount <= 20) then
            SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 3, killCount))
        else
            local rand = math.random(1, 100)
            if (rand <= 10) then
                isSummonNewBoss = 0
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 3))
                local playerIndexCache = PlayerIndex
                PlayerIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 3))
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 3, 0))
                for i = 1, HaveNormalItem(6, 1, 384, 1) do
                    DelNormalItem(6, 1, 384, 1)
                end
                AddNormalItem(6, 1, 384, 1, 0, 0)
                local redCount = GetByte(GetTask(Task_XJFS_Status), 4)
                TaskNote(Task_Info_XJFS, 5)
                Msg2Player("NhËn ®­îc 1 §an Ph«i.")
                TopMessage(14491)
                PlayerIndex = playerIndexCache
                TaskNote(Task_Info_XJFS, 4, (5 - redCount))
                Msg2Player("S­ phô ®· luyÖn thµnh c«ng §an Ph«i")
                TopMessage(14492)
                Talk(1, "no", GetName() .. ":§an Ph«i ®· ng­ng tô thµnh c«ng, b­íc tiÕp theo lµ vµo <c=r>V¹n Tiªn TrËn<c> luyÖn thµnh nã thµnh TÈy Tñy ®¬n.")
            end
        end
    elseif (isSTTeam == 1 and masterFlag == 0 and teammateID == GetTask(Task_XJFS_BindingID)
            and taskStatus == 3) then
        isSummonNewBoss = 0
    end
    if (isSummonNewBoss == 1) then
        local npcIndex = AddNpc(Boss_CopperMan_ID, 40, SubWorld, x * 32, y * 32)
        if (npcIndex > 0) then
            local newNpcName = "<c=r>§ång Nh©n<c>"
            SetNpcName(npcIndex, newNpcName)
            SetNpcScript(npcIndex, "\\script\\¹ÖÎï\\Í­ÈË.lua")
            SetNpcTimer(npcIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        end
    end
    DelNpc(npcidx)
end

function no()
    CloseDialog()
end
