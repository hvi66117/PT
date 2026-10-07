instance_RightHideNpc = 21
instance_LeftHideNpc = 22
instance_HideNpc1 = 23
instance_HideNpc2 = 24
instance_HideNpc3 = 25
instance_Step = 30
instance_ShaHun_Num = 31
instance_ShaLingLeft_Num = 32
instance_ShaLingRight_Num = 33
instance_BossIdx = 34
instance_DoorMid = 35
instance_LastNpc = 36
instance_WuWangBoss = 41
instance_TrapDoor = 42

function OnDeath(npcindex)

    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcindex, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcindex, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local npcidx = 0
    local mapid, x, y = 0, 0, 0
    local step = GetInstanceTempValue(instance_Step)

    if (LeftTime < 300) then
        SetInstanceTempValue(instance_Step, 9)
        Msg2CurMapAnnounce("Thêi gian phã b¶n kh«ng ®ñ 5 phót, khiªu chiÕn thÊt b¹i, cã thÓ dïng TruyÒn phï rêi khái phã b¶n.")
    else
        npcidx = AddNpc(1852, 1, nSubWorldIdx, (1600 + math.random(1, 5)) * 32, (3290 + math.random(1, 5)) * 32)
        if (npcidx > 0) then
            SetNpcTimer(npcidx, "\\script\\instance\\ÎäÍõ¼ÆÊ±.lua", 60 * 5)
            SetNpcTask(npcidx, 0, InstanceIndex)
            SetNpcTask(npcidx, 1, instanceID)
            SetNpcTask(npcidx, 2, step)

            mapid, x, y = GetNpcWorldPos(npcidx)
            Msg2CurMapAnnounceEx(mapid, "Vò V­¬ng ®· chÕt, 5 phót sau sÏ håi sinh, lóc ®ã cã thÓ b¾t ®Çu chiÕn ®Êu l¹i!")
        end
    end

    for i = 23, 25 do
        local hideIdx = GetInstanceTempValue(i)
        local hideNum = GetNpcTask(hideIdx, 0)

        for i = 1, hideNum do
            local bossNpcIdx = GetNpcTask(hideIdx, i)

            if (bossNpcIdx > 0 and GetNpcTemplateID(bossNpcIdx) == 1846) then
                DelNpc(bossNpcIdx)
            end
        end
    end

    local bossIdx = GetInstanceTempValue(45)
    if (bossIdx > 0 and GetNpcTemplateID(bossIdx) == 1849) then
        DelNpc(bossIdx)
    end

    bossIdx = GetInstanceTempValue(46)
    if (bossIdx > 0 and GetNpcTemplateID(bossIdx) == 1851) then
        DelNpc(bossIdx)
    end

    for i = 47, 50 do
        local doorIdx = GetInstanceTempValue(i)
        if (doorIdx > 0 and (GetNpcTemplateID(doorIdx) == 1866 or GetNpcTemplateID(doorIdx) == 1869)) then
            DelNpc(doorIdx)
        end
    end

    SetInstanceTempValue(51, 1)
    DelNpc(npcindex)
    WriteLog("Vò V­¬ng tö vong, ID=" .. instanceID .. "Index=" .. InstanceIndex)
    InstanceIndex = oldInstance
end
