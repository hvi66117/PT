--Descript:ºìÉ°Õó-É³Áú
--Author:liujifang
--Date:2010-11-01

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ£¬4É±ËÀÉ³Áú£¬5É±ËÀÕÅÌì¾ı£¬6ÎäÍõËÀÍö)
instance_ShaHun_Num = 31                   --¾Ş´óÉ³»ê´æÔÚµÄ¸öÊı
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊı
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖĞ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44Õ½¶·ÎäÍõµÄindex
--¸±±¾±äÁ¿


function OnDeath(npcIndex)
    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcIndex, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcIndex, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local WuWangIdx = GetInstanceTempValue(instance_WuWangBoss)
    local npcLife = GetNpcLifeMax(WuWangIdx)
    local nowLife = GetNpcLife(WuWangIdx)
    SetInstanceTempValue(instance_Step, 5)

    -- bossËÀÍöµôÂäÓñÅå
    local possibility = random(1, 1000)
    if (possibility <= 654) then
        ThrowItem(npcIndex, -1, 0, 12, 0, 9, 0, 0)
        WriteLog("Sa long tö vong, r¬i ra long hån cÊp 2. ID=" .. instanceID .. "Index=" .. InstanceIndex)
    elseif (possibility <= 984) then
        ThrowItem(npcIndex, -1, 0, 12, 0, 10, 0, 0)
        WriteLog("Sa long tö vong, r¬i ra long hån cÊp 3. ID=" .. instanceID .. "Index=" .. InstanceIndex)
    else
        ThrowItem(npcIndex, -1, 0, 12, 0, 11, 0, 0)
        WriteLog("Sa long tö vong, r¬i ra long hån cÊp 4. ID=" .. instanceID .. "Index=" .. InstanceIndex)
    end

    if (random(1, 100) <= 6) then
        ThrowItem(npcIndex, -1, 6, 1, 703, 0, 0, 0)
        WriteLog("Sa Long cña Hång Sa TrËn tö vong, r¬i ra M¶nh Hoµng thuû tinh")
    end

    if (nowLife < npcLife) then
        SetNpcLife(WuWangIdx, npcLife)
    end

    DelNpc(npcIndex)
    Msg2CurMapAnnounce("C¸c vŞ anh hïng! Sa Long ®· chÕt, mäi ng­êi h·y tiÕp tôc cè g¾ng!")

    InstanceIndex = oldInstance
end