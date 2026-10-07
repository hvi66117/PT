instance_RightHideNpc = 21
instance_LeftHideNpc = 22
instance_Step = 30
instance_ShaHun_Num = 31
instance_ShaLingLeft_Num = 32
instance_ShaLingRight_Num = 33
instance_BossIdx = 34
instance_DoorMid = 35
instance_LastNpc = 36
instance_WuWangBoss = 41
instance_TrapDoor = 42
instance_Boss2Idx = 45
instance_Boss3Idx = 46

FirstInit_TEMPVALUE = 100
INSTANCETYPE_TEMPVALUE = 101

TABLE_Npc = {

    [1] = { id = 1853, lvl = 145, x = 1625, y = 3158, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [2] = { id = 1854, lvl = 145, x = 1654, y = 3188, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [3] = { id = 1855, lvl = 145, x = 1623, y = 3216, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [4] = { id = 1856, lvl = 145, x = 1592, y = 3190, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },

}

function OnTimer(npcidx)
    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcidx, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    InstanceIndex = GetNpcTask(npcidx, 0)

    local trapIdx = 0
    local step = GetInstanceTempValue(instance_Step)
    local npcIdx = 0
    local mapid, x, y = GetNpcWorldPos(npcidx)

    if (step >= 9) then
        DelNpc(npcidx)
        return
    end

    if (GetInstanceTempValue(INSTANCETYPE_TEMPVALUE) == 2) then
        npcIdx = AddNpc(1862, 160, nSubWorldIdx, 1625 * 32, 3186 * 32)
    else
        npcIdx = AddNpc(1862, 145, nSubWorldIdx, 1625 * 32, 3186 * 32)
    end

    if (npcIdx > 0) then
        SetNpcScript(npcIdx, "\\script\\instance\\ÎäÍõË¢ÐÂ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcIdx, "Vâ V­¬ng")
        SetNpcTask(npcIdx, 0, InstanceIndex);
        SetNpcTask(npcIdx, 1, instanceID);
        SetInstanceTempValue(36, npcIdx)
    end

    Msg2CurMapAnnounceEx(mapid, "Ph¸p lùc cña Nhiªn §¨ng §¹o Nh©n vµ Tõ Hµng §¹o Nh©n b¶o vÖ hån ph¸ch cña Vò V­¬ng, ®Ó Vò V­¬ng lu«n bÊt tö, b©y giê Vò V­¬ng ®· phôc sinh, mäi ng­êi h·y ®èi tho¹i víi Vò V­¬ng ®Ó b¾t ®Çu l¹i cuéc chiÕn víi Tr­¬ng Thiªn Qu©n.")

    DelNpc(npcidx)

    InstanceIndex = oldInstance
end

function no()
    CloseDialog()
end
