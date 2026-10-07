--Descript:ÎäÍõ¶Ô»°
--Author:liujifang
--Date:2010-10-27

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ)
instance_ShaHun_Num = 31                   --¾Þ´óÉ³»ê´æÔÚµÄ¸öÊý
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖÐ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44´«ËÍÃÅµÄindex
--¸±±¾±äÁ¿

DoorPos = {
    { x = 1550, y = 3263, script = "\\script\\ontimer\\´«ËÍÃÅ×ó.lua" },
    { x = 1553, y = 3112, script = "\\script\\ontimer\\´«ËÍÃÅÖÐ.lua" },
    { x = 1697, y = 3114, script = "\\script\\ontimer\\´«ËÍÃÅÓÒ.lua" },
}


--added by hongliang for ºìÉ°Õó 10/10/29 begin
--------------------------------------
--¸±±¾ÁÙÊ±±äÁ¿
--1 ~ 4: TABLE_NpcÖÐNpcµÄIdx
--5 ~ 8: TABLE_NpcÖÐNpcµÄID

TASK_Instance_HSZ = 601 --1st byte: Òýµ¼ÈÎÎñ²½Öè 0-Î´½Ó;1-ÒÑ½Ó;2-ÒÑºÍµÀÈË¶Ô»°;3-ÒÑ´ðÓ¦ÎäÍõ;4-ÒÑÉ±ËÀboss;5-ÒÑÍê³ÉÈÎÎñ;

NPCTVID_InstanceIdx = 0;
NPCTVID_InstanceId = 1;

INSTANCE_TYPE_HSZ = 10

BUFF_InstanceTime = 1344
Timer_Check = 68
Timer_End = 69
--------------------------------------
--added by hongliang for ºìÉ°Õó 10/10/29 end


function main()
    local tasks = {
        { "B¶o vÖ Vò V­¬ng", "HongShangZhen"; show = 1 },
    }

    SetTask(140, DialogNpcIdx)
    SayTask("Vò V­¬ng: §¹i hiÖp, cuèi cïng còng ®· tíi!", tasks)

end

function HongShangZhen()

    if (GetTeam() == 0) then
        Talk(1, "no", "Vò V­¬ng: §ång ®éi cña ng­¬i ®©u? ë ®©y mét m×nh rÊt nguy hiÓm!")
    else
        if (GetTeamMember(1) ~= PlayerIndex) then
            Talk(1, "no", "Vò V­¬ng: H·y mêi ®éi tr­ëng cña ng­¬i tíi nãi chuyÖn víi ta.")
        else
            MsgBox("Vò V­¬ng: Ng­¬i cã cÇn ®i cïng víi ®ång ®éi ®Ó b¶o vÖ ta kh«ng?", "RefreshNpc", "no")
        end
    end

end

function RefreshNpc()
    no()
    local DialogNpc = GetTask(140)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)  --modify by liujifang at 2010-12-09
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(DialogNpc, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local npcidx = 0
    local doorIdx = 0
    local mapid, x, y = GetWorldPos()

    npcidx = AddNpc(1861, 150, nSubWorldIdx, 1625 * 32, 3186 * 32)    --¼ÓÎäÍõÕ½¶·
    if (npcidx > 0) then

        SetNpcScript(npcidx, "\\script\\instance\\death\\ÎäÍõ.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcidx, "<c=g>Vò V­¬ng<c>")

        SetNpcTask(npcidx, 0, InstanceIndex);
        SetNpcTask(npcidx, 1, instanceID);
        SetGuardLevel(npcidx, 1)
        SetNpcCamp(npcidx, 0)
        SetInstanceTempValue(instance_WuWangBoss, npcidx)

        -----------¼ÓÈý¸ö´«ËÍÃÅ-----------
        for i = 1, 3 do
            doorIdx = AddNpc(1867, 1, nSubWorldIdx, DoorPos[i].x * 32, DoorPos[i].y * 32)  --modify by liujifang at 2010-12-09
            if (doorIdx > 0) then
                SetNpcTimer(doorIdx, DoorPos[i].script, 8)
                SetNpcTask(doorIdx, 0, InstanceIndex);
                SetNpcTask(doorIdx, 1, instanceID);
                SetInstanceTempValue(instance_TrapDoor + i - 1, doorIdx)
            end
        end
        -----------¼ÓÈý¸ö´«ËÍÃÅ-----------

        if (GetNpcTemplateID(GetInstanceTempValue(36)) == 1862) then
            --É¾³ý¶Ô»°ÎäÍõ
            DelNpc(GetInstanceTempValue(36))
        end

        --modified by hongliang for ºìÉ°Õó 10/10/29 begin
        --			InfoBox("ÎäÍõ£ºÎÒ±»ÕÅÌì¾ýÀ§ÓÚ´ËµØ£¬»¹ÇëÓ¢ÐÛÃÇÀ´¾ÈÎÒ³öÈ¥¡£")
        TeamAction("Choose_SyncPreTask", PlayerIndex, 0, 0)
        --modified by hongliang for ºìÉ°Õó 10/10/29 end
    elseif (mapid > 1000) then
        npcidx = AddNpc(1861, 150, SubWorld, 1625 * 32, 3186 * 32)    --¼ÓÎäÍõÕ½¶·
        if (npcidx > 0) then
            SetNpcScript(npcidx, "\\script\\instance\\death\\ÎäÍõ.lua")
            SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
            SetNpcName(npcidx, "<c=g>Vò V­¬ng<c>")

            SetNpcTask(npcidx, 0, InstanceIndex);
            SetNpcTask(npcidx, 1, instanceID);
            SetGuardLevel(npcidx, 1)
            SetNpcCamp(npcidx, 0)
            SetInstanceTempValue(instance_WuWangBoss, npcidx)

            -----------¼ÓÈý¸ö´«ËÍÃÅ-----------
            for i = 1, 3 do
                doorIdx = AddNpc(1867, 1, SubWorld, DoorPos[i].x * 32, DoorPos[i].y * 32)  --modify by liujifang at 2010-12-09
                if (doorIdx > 0) then
                    SetNpcTimer(doorIdx, DoorPos[i].script, 8)
                    SetNpcTask(doorIdx, 0, InstanceIndex);
                    SetNpcTask(doorIdx, 1, instanceID);
                    SetInstanceTempValue(instance_TrapDoor + i - 1, doorIdx)
                end
            end
            -----------¼ÓÈý¸ö´«ËÍÃÅ-----------

            if (GetNpcTemplateID(GetInstanceTempValue(36)) == 1862) then
                --É¾³ý¶Ô»°ÎäÍõ
                DelNpc(GetInstanceTempValue(36))
            end
            --modified by hongliang for ºìÉ°Õó 10/10/29 begin
            --			InfoBox("ÎäÍõ£ºÎÒ±»ÕÅÌì¾ýÀ§ÓÚ´ËµØ£¬»¹ÇëÓ¢ÐÛÃÇÀ´¾ÈÎÒ³öÈ¥¡£")
            TeamAction("Choose_SyncPreTask", PlayerIndex, 0, 0)
            --modified by hongliang for ºìÉ°Õó 10/10/29 end
        else
            WriteLog("T¶i cæng truyÒn tèng Hång Sa TrËn thÊt b¹i")
        end
    end

    WriteLog("Cæng truyÒn tèng Vò V­¬ng, ID=" .. instanceID .. "Index=" .. InstanceIndex)
    InstanceIndex = oldInstance
end

--added by hongliang for ºìÉ°Õó 10/10/29 begin
function Choose_SyncPreTask()
    CloseDialog()
    local str = ""
    local oldPlayer = PlayerIndex
    if (GetTeam() > 0 and PlayerIndex ~= GetTeamMember(1)) then
        PlayerIndex = GetTeamMember(1)
        str = GetName()
    end
    PlayerIndex = oldPlayer

    local TaskStep = GetTaskByte(TASK_Instance_HSZ, 1)
    if (TaskStep == 2) then
        MsgBox("B¹n x¸c ®Þnh cïng víi ®ång ®éi " .. str .. " chiÕn ®Êu ®Ó b¶o vÖ Vò V­¬ng chø?", "Agree_SyncPreTask", "Refuse_SyncPreTask")
    else
        InfoBox("TrËn chiÕn b¶o vÖ Vò V­¬ng ®· b¾t ®Çu, b¹n ph¶i b¶o vÖ Vò V­¬ng chèng l¹i sù tÊn c«ng cña bé h¹ Tr­¬ng Thiªn Qu©n, sau ®ã tiÕp tôc tiªu diÖt Tr­¬ng Thiªn Qu©n, ®¸nh tan trËn ph¸p trong Hång Sa TrËn.")
    end

end

function Agree_SyncPreTask()
    CloseDialog()

    SetTaskByte(TASK_Instance_HSZ, 1, 3)
    TaskNote(1623, 2)
    --    refreshNpcTaskState()

end

function Refuse_SyncPreTask()
    CloseDialog()
    Msg2Player("B¹n ®· tõ bá nhiÖm vô cuèi cïng víi ®ång ®éi.")
end


--added by hongliang for ºìÉ°Õó 10/10/29 end

function no()
    CloseDialog()
end
