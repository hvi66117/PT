--description: ÕÅÌì¾ıËÀÍö.lua
--author: liujifang
--date: 2010-10-28

--¸±±¾±äÁ¿£º
TASK_Instance_HSZ = 601 --1st byte: Òıµ¼ÈÎÎñ²½Öè 0-Î´½Ó;1-ÒÑ½Ó;2-ÒÑºÍµÀÈË¶Ô»°;3-ÒÑ´ğÓ¦ÎäÍõ;4-ÒÑÉ±ËÀboss;5-ÒÑÍê³ÉÈÎÎñ;

instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ)
instance_ShaHun_Num = 31                   --¾Ş´óÉ³»ê´æÔÚµÄ¸öÊı
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖĞ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44Õ½¶·ÎäÍõµÄindex
instance_Boss2Idx = 45                     --2ºÅBOSSÉ³ÁúµÄindex
instance_Boss3Idx = 46                     --3ºÅBOSSÕÅÌì¾ıµÄindex
--¸±±¾±äÁ¿

function OnDeath(npcindex)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)  --modify by liujifang at 2010-12-09
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcindex, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)

    local npcidx = AddNpc(1862, 150, nSubWorldIdx, 1627 * 32, 3188 * 32)
    if (npcidx > 0) then
        SetNpcScript(npcidx, "\\script\\instance\\ÎäÍõ_½áÊø¶Ô»°.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcidx, "Vâ V­¬ng")

        SetInstanceTempValue(36, npcidx);
        DelNpc(GetInstanceTempValue(41))
        SetNpcTask(npcidx, 0, InstanceIndex);
        SetNpcTask(npcidx, 1, instanceID);
    else
        -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 begin
        npcidx = AddNpc(1862, 150, SubWorld, 1627 * 32, 3188 * 32)
        if (npcidx > 0) then
            SetNpcScript(npcidx, "\\script\\instance\\ÎäÍõ_½áÊø¶Ô»°.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
            SetNpcName(npcidx, "Vâ V­¬ng")

            SetInstanceTempValue(36, npcidx);
            DelNpc(GetInstanceTempValue(41))
            SetNpcTask(npcidx, 0, InstanceIndex);
            SetNpcTask(npcidx, 1, instanceID);
        else
            WriteLog("Vµo phã b¶n thÊt b¹i")
        end
        -- modified by yaoxin for ¸±±¾ÓÅ»¯ 2010-12 end
    end

    ---------------É¾³ıNPC--------------------
    if (GetNpcTemplateID(GetInstanceTempValue(41)) == 1862) then
        --ÎäÍõ
        DelNpc(GetInstanceTempValue(41))
    end

    for i = 1, 3 do
        if (GetNpcTemplateID(GetInstanceTempValue(41 + i)) == 1867) then
            --´«ËÍÃÅ
            DelNpc(GetInstanceTempValue(41 + i))
        end
    end

    for i = 1, 4 do
        if (GetNpcTemplateID(GetInstanceTempValue(36 + i)) == (1852 + i)) then
            --µñÏñ
            DelNpc(GetInstanceTempValue(36 + i))
        end
    end

    for i = 47, 50 do
        local doorIdx = GetInstanceTempValue(i)
        if (doorIdx > 0 and (GetNpcTemplateID(doorIdx) == 1866 or GetNpcTemplateID(doorIdx) == 1869)) then
            --×èµ²ÃÅ
            DelNpc(doorIdx)
        end
    end
    ---------------É¾³ıNPC--------------------

    --added by hongliang for ºìÉ°Õó 10/10/29 begin
    Instance_PreTask()
    --added by hongliang for ºìÉ°Õó 10/10/29 end

    SetInstanceTempValue(instance_Step, 7)
    Msg2CurMapAnnounce("Tr­¬ng Thiªn Qu©n tö vong, hoµn thµnh phã b¶n")

    -- bossËÀÍöµôÂäÓñÅå
    local possibility = random(1, 1000)
    if (possibility <= 654) then
        ThrowItem(npcindex, -1, 0, 12, 0, 9, 0, 0)
        WriteLog("Tr­¬ng Thiªn Qu©n tö vong, r¬i ra long hån cÊp 2.")
    elseif (possibility <= 984) then
        ThrowItem(npcindex, -1, 0, 12, 0, 10, 0, 0)
        WriteLog("Tr­¬ng Thiªn Qu©n tö vong, r¬i ra long hån cÊp 3.")
    else
        ThrowItem(npcindex, -1, 0, 12, 0, 11, 0, 0)
        WriteLog("Tr­¬ng Thiªn Qu©n tö vong, r¬i ra long hån cÊp 4.")
    end

    if (random(1, 100) <= 7) then
        ThrowItem(npcindex, -1, 6, 1, 703, 0, 0, 0)
        WriteLog("Tr­¬ng Thiªn Qu©n cña Hång Sa TrËn tö vong, r¬i ra M¶nh Hoµng thuû tinh")
    end

    --¼ÓÁúÑªÁéÖ¥
    AddObj(370, nSubWorldIdx, 1610 * 32, 3176 * 32, "")

    WriteLog("Tr­¬ng Thiªn Qu©n tö vong")
    DelNpc(npcindex)

    InstanceIndex = oldInstance

end


--added by hongliang for ºìÉ°Õó 10/10/29 begin
function Instance_PreTask()

    local TeamSize = GetTeamSize()
    local TmpIdx = PlayerIndex
    for i = 1, TeamSize do
        PlayerIndex = GetTeamMember(i)
        if (PlayerIndex > 0 and GetTaskByte(TASK_Instance_HSZ, 1) == 3
                and GetPlayerState() ~= 10 and GetPlayerState() ~= 21) then
            --modified by hongliang for ËÀÍöÍæ¼Ò²»Í¬²½ÈÎÎñ

            SetTaskByte(TASK_Instance_HSZ, 1, 4)
            TaskNote(1623, 3)
            --            refreshNpcTaskState()
            InfoBox("§¸nh b¹i Tr­¬ng Thiªn Qu©n, mau ®i øng cøu Vò V­¬ng.")
        end
        PlayerIndex = TmpIdx
    end
    PlayerIndex = TmpIdx

end
--added by hongliang for ºìÉ°Õó 10/10/29 end



