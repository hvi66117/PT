instance_RightHideNpc = 21
instance_LeftHideNpc = 22
instance_Step = 30
instance_ShaHun_Num = 31
instance_ShaLingLeft_Num = 32
instance_ShaLingRight_Num = 33
instance_BossIdx = 34
instance_DoorMid = 35
instance_LastNpc = 36

InstanceType = 1884
FirstInit_TEMPVALUE = 100
INSTANCETYPE_TEMPVALUE = 101

TABLE_Npc = {

    [1] = { id = 1862, lvl = 145, lvl2 = 170, x = 1626, y = 3186, npcscript = "\\script\\instance\\ÎäÍõ¶Ô»°.lua", istimer = 1, aisrcipt = "", npcname = "Vâ V­¬ng" },
    [2] = { id = 1853, lvl = 145, lvl2 = 170, x = 1625, y = 3158, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [3] = { id = 1854, lvl = 145, lvl2 = 170, x = 1654, y = 3188, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [4] = { id = 1855, lvl = 145, lvl2 = 170, x = 1623, y = 3216, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [5] = { id = 1856, lvl = 145, lvl2 = 170, x = 1592, y = 3190, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },

}

InstanceType = 1884

function OnDeath(npcindex)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcindex, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local nNum = table.getn(TABLE_Npc)
    local temp = -1
    local npcidx = 0
    local i = 0

    for i = 1, nNum do
        temp = TABLE_Npc[i]

        if (GetInstanceTempValue(INSTANCETYPE_TEMPVALUE) == 2) then
            npcidx = AddNpc(temp.id, temp.lvl2, nSubWorldIdx, temp.x * 32, temp.y * 32)
        else
            npcidx = AddNpc(temp.id, temp.lvl, nSubWorldIdx, temp.x * 32, temp.y * 32)
        end

        if (npcidx > 0) then

            SetNpcName(npcidx, temp.npcname)
            if (temp.istimer > 0) then
                SetNpcScript(npcidx, temp.npcscript)
                SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
            else
                SetNpcTimer(npcidx, temp.npcscript, LeftTime)
            end

            SetInstanceTempValue(instance_LastNpc + i - 1, npcidx);
            SetNpcTask(npcidx, 0, InstanceIndex);
            SetNpcTask(npcidx, 1, instanceID);
        end
    end

    DelNpc(GetInstanceTempValue(instance_DoorMid))
    SetInstanceTempValue(instance_Step, 3)
    Msg2CurMapAnnounce("Minh Sa Tiªn ®· chÕt, ®¹i hiÖp h·y dòng c¶m tiÕn vÒ phÝa tr­íc.")

    local possibility = math.random(1, 1000)

    local nInstanceType = GetTaskByte(InstanceType, 1)
    if (nInstanceType == 2) then
        ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 11, 0, 0)
        local rank2 = math.random(1, 100)
        if (rank2 <= 5) then
            ThrowItem(npcindex, PlayerIndex, 0, 12, 0, 11, 0, 0)
        end
    else
        if (possibility <= 654) then
            ThrowItem(npcindex, -1, 0, 12, 0, 9, 0, 0)
            WriteLog("Minh Sa Tiªn ®· chÕt, r¬i ra long hån cÊp 2")
        elseif (possibility <= 984) then
            ThrowItem(npcindex, -1, 0, 12, 0, 10, 0, 0)
            WriteLog("Minh Sa Tiªn ®· chÕt, r¬i ra long hån cÊp 3")
        else
            ThrowItem(npcindex, -1, 0, 12, 0, 11, 0, 0)
            WriteLog("Minh Sa Tiªn ®· chÕt, r¬i ra long hån cÊp 4")
        end
    end

    if (math.random(1, 100) <= 5) then
        ThrowItem(npcindex, -1, 6, 1, 703, 0, 0, 0)
        WriteLog("Minh Sa Tiªn cña Hång Sa TrËn ®· chÕt, r¬i ra M¶nh Hoµng thuû tinh.")
    end

    local strLogType = "[Th­¬ng]"
    if (GetTaskByte(InstanceType, 1) == 2) then
        strLogType = "[Anh hïng]"
    end

    WriteLog("Minh Sa Tiªn" .. strLogType .. "tö vong, " .. LeftTime .. " gi©y, ID=" .. instanceID .. ",idx=" .. InstanceIndex)
    DelNpc(npcindex)

    InstanceIndex = oldInstance

end
