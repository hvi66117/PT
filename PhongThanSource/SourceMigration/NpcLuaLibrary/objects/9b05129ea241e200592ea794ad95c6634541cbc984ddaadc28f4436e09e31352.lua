--Descript:ºìÉ°Õó-ÎäÍõ
--Author:liujifang
--Date:2010-10-27

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒş²ØNPC
instance_HideNpc1 = 23                   --ÖĞ¼ä´«ËÍÃÅÒş²ØNCP
instance_HideNpc2 = 24                   --×ó²à´«ËÍÃÅÒş²ØNCP
instance_HideNpc3 = 25                   --ÓÒ²à´«ËÍÃÅÒş²ØNCP
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

function OnDeath(npcindex)

    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcindex, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcindex, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local npcidx = 0
    local mapid, x, y = 0, 0, 0
    local step = GetInstanceTempValue(instance_Step)

    ----------------¼Ó¼ÆÊ±NPC---------------------
    if (LeftTime < 300) then
        SetInstanceTempValue(instance_Step, 9)  --¸±±¾½áÊø
        Msg2CurMapAnnounce("Thêi gian phã b¶n kh«ng ®ñ 5 phót, khiªu chiÕn thÊt b¹i, cã thÓ dïng TruyÒn phï rêi khái phã b¶n.")
    else
        npcidx = AddNpc(1852, 1, nSubWorldIdx, (1600 + random(1, 5)) * 32, (3290 + random(1, 5)) * 32)
        if (npcidx > 0) then
            SetNpcTimer(npcidx, "\\script\\instance\\ÎäÍõ¼ÆÊ±.lua", 60 * 5)
            SetNpcTask(npcidx, 0, InstanceIndex)
            SetNpcTask(npcidx, 1, instanceID)
            SetNpcTask(npcidx, 2, step)

            mapid, x, y = GetNpcWorldPos(npcidx)
            Msg2CurMapAnnounceEx(mapid, "Vò V­¬ng ®· chÕt, 5 phót sau sÏ håi sinh, lóc ®ã cã thÓ b¾t ®Çu chiÕn ®Êu l¹i!")
        end
    end
    ----------------¼Ó¼ÆÊ±NPC---------------------

    ----------------É¾ºìÉ°ÕóÁé--------------------
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
    ----------------É¾ºìÉ°ÕóÁé--------------------

    ----------------É¾BOSS------------------------
    local bossIdx = GetInstanceTempValue(45) --É³Áú
    if (bossIdx > 0 and GetNpcTemplateID(bossIdx) == 1849) then
        DelNpc(bossIdx)
    end

    bossIdx = GetInstanceTempValue(46) --ÕÅÌì¾ı
    if (bossIdx > 0 and GetNpcTemplateID(bossIdx) == 1851) then
        DelNpc(bossIdx)
    end
    ----------------É¾BOSS------------------------

    ----------------É¾×èµ²------------------------
    for i = 47, 50 do
        local doorIdx = GetInstanceTempValue(i)
        if (doorIdx > 0 and (GetNpcTemplateID(doorIdx) == 1866 or GetNpcTemplateID(doorIdx) == 1869)) then
            DelNpc(doorIdx)
        end
    end
    ----------------É¾×èµ²------------------------
    SetInstanceTempValue(51, 1)
    DelNpc(npcindex)
    WriteLog("Vò V­¬ng tö vong, ID=" .. instanceID .. "Index=" .. InstanceIndex)
    InstanceIndex = oldInstance
end