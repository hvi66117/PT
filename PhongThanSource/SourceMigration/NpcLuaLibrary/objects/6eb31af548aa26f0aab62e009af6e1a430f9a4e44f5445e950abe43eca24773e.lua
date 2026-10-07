--description:Í­ÈËËÀÍö½Å±¾
--author: zhaoqingsong
--date: 2008-8-22

-- ÈÎÎñ×´Ì¬±äÁ¿£¬
-- Ï´½î·¥ËèÈÎÎñ

-- ÈÎÎñ×´Ì¬±äÁ¿£¬
-- 1 Byte ÈÎÎñÖ´ĞĞ×´Ì¬£¬0 ³õÊ¼£¬1 ½ÓÈÎÎñ£¬2 É±Í­ÈË£¬3 É±ÍòÏÉÕóĞ¡¹Ö£¬4 ÈÎÎñÍê³É£»
-- 2 Byte Í½µÜÈÎÎñ×´Ì¬£¬0 Î´×ö¹ı£¬1 ÒÑ×ö¹ı£»
-- 3 Byte Í½µÜ£¨É±ËÀÍ­ÈËÊı£©£¬Ê¦¸µ£¨µ¤ÅßÊ¹ÓÃ´ÎÊı£©£»
-- 4 Byte »ñµÃÏ´Ëèµ¤Êı£»
Task_XJFS_Status = 1248
Task_XJFS_BindingID = 1249 -- Ê¦Í½°ó¶¨ID

Task_Info_XJFS = 1018

Boss_CopperMan_ID = 727     -- Í­ÈËID
Buff_XJFS = 466             -- µ¤ÅßBuff

-- È¡µÃ×é¶ÓÇé¿ö
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

-- È¡µÃ¶ÓÓÑµÄ°ó¶¨ID
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

        -- Added by Zhaoqingsong at 2009-2-11 Begin
        -- Ê¦¸µ²»ÔÚÍ¬Ò»µØÍ¼£¬ÔòÌø¹ı
        local playerIndexCache = PlayerIndex
        local playerIdx = SearchPlayerById(teammateID)
        PlayerIndex = playerIdx
        local mapid2, x2, y2 = GetWorldPos()
        PlayerIndex = playerIndexCache
        -- Added by Zhaoqingsong at 2009-2-11 End

        local killCount = GetByte(GetTask(Task_XJFS_Status), 3) + 1
        -- Modify by Zhaoqingsong at 2009-2-11
        if (mapid2 ~= mapid) then
        elseif (killCount <= 20) then
            SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 3, killCount))
        else
            local rand = random(1, 100)
            if (rand <= 10) then
                isSummonNewBoss = 0
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 3))
                local playerIndexCache = PlayerIndex
                PlayerIndex = (PlayerIndex == GetTeamMember(1) and GetTeamMember(2)) or GetTeamMember(1)
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 1, 3))
                SetTask(Task_XJFS_Status, SetByte(GetTask(Task_XJFS_Status), 3, 0))
                for i = 1, HaveNormalItem(6, 1, 384, 1) do
                    -- Èç¹ûÓĞµ¤Åß£¬É¾³ı£¬Ö»ÏŞ±³°ü
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
