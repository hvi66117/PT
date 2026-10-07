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

InstanceType = 1884

FirstInit_TEMPVALUE = 100
INSTANCETYPE_TEMPVALUE = 101
TABLE_Npc = {

    [1] = { id = 1853, lvl = 145, lvl2 = 170, x = 1625, y = 3158, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [2] = { id = 1854, lvl = 145, lvl2 = 170, x = 1654, y = 3188, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [3] = { id = 1855, lvl = 145, lvl2 = 170, x = 1623, y = 3216, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },
    [4] = { id = 1856, lvl = 145, lvl2 = 170, x = 1592, y = 3190, npcscript = "\\script\\instance\\µñÏñ.lua", istimer = 0, aisrcipt = "", npcname = "T­îng" },

}

function main()
    local tasks = {
        { "B¶o vÖ Vò V­¬ng", "HongShangZhen"; show = 1 },
    }

    SetTask(140, DialogNpcIdx)
    SayTask("Vò V­¬ng: §¹i hiÖp, cuèi cïng còng ®· tíi!", tasks)

end

function HongShangZhen()
    no()
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
    local npcidx = GetTask(140)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    InstanceIndex = GetNpcTask(npcidx, 0)

    local trapIdx = 0
    local step = GetInstanceTempValue(instance_Step)
    local npcIdx = 0
    local mapid, x, y = GetNpcWorldPos(npcidx)

    if (GetInstanceTempValue(INSTANCETYPE_TEMPVALUE) == 2) then
        npcIdx = AddNpc(1861, 170, nSubWorldIdx, 1625 * 32, 3186 * 32)
    else
        npcIdx = AddNpc(1861, 145, nSubWorldIdx, 1625 * 32, 3186 * 32)
    end

    if (npcIdx > 0) then

        SetNpcScript(npcIdx, "\\script\\instance\\death\\ÎäÍõ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
        SetNpcName(npcIdx, "<c=g>Vò V­¬ng<c>")

        SetNpcTask(npcIdx, 0, InstanceIndex);
        SetNpcTask(npcIdx, 1, instanceID);
        SetGuardLevel(npcIdx, 1)
        SetNpcCamp(npcIdx, 0)
        SetInstanceTempValue(instance_WuWangBoss, npcIdx)
        SetInstanceTempValue(51, 0)

        for i = 1, 3 do
            trapIdx = GetInstanceTempValue(41 + i)
            if (trapIdx > 0 and GetNpcTemplateID(trapIdx) == 1867) then
                if (step < 5) then
                    SetNpcTask(trapIdx, 2, 0)
                    SetNpcTask(trapIdx, 3, 0)
                    SetNpcTask(trapIdx, 4, 0)
                    SetNpcTask(trapIdx, 6, 0)
                    SetInstanceTempValue(instance_Step, 3)
                else
                    SetNpcTask(trapIdx, 2, 0)
                    SetNpcTask(trapIdx, 3, 0)
                    SetNpcTask(trapIdx, 6, 5)
                    SetInstanceTempValue(instance_Step, 5)
                end
            end
        end

        if (step >= 5) then

            for i = 1, 4 do
                if (GetNpcTemplateID(GetInstanceTempValue(36 + i)) == (1852 + i)) then
                    DelNpc(GetInstanceTempValue(36 + i))
                end
            end

            local temp = -1
            local diaoXiang = 0
            for i = 1, table.getn(TABLE_Npc) do
                temp = TABLE_Npc[i]

                if (GetInstanceTempValue(INSTANCETYPE_TEMPVALUE) == 2) then
                    diaoXiang = AddNpc(temp.id, temp.lvl2, nSubWorldIdx, temp.x * 32, temp.y * 32)
                else
                    diaoXiang = AddNpc(temp.id, temp.lvl, nSubWorldIdx, temp.x * 32, temp.y * 32)
                end

                if (diaoXiang > 0) then

                    SetNpcName(diaoXiang, "T­îng")
                    if (temp.istimer > 0) then
                        SetNpcScript(diaoXiang, temp.npcscript)
                        SetNpcTimer(diaoXiang, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
                    else
                        SetNpcTimer(diaoXiang, temp.npcscript, LeftTime)
                    end

                    SetInstanceTempValue(36 + i, diaoXiang);
                    SetNpcTask(diaoXiang, 0, InstanceIndex);
                    SetNpcTask(diaoXiang, 1, instanceID);
                end
            end
        end
    end

    DelNpc(npcidx)

    InstanceIndex = oldInstance
end

function no()
    CloseDialog()
end
