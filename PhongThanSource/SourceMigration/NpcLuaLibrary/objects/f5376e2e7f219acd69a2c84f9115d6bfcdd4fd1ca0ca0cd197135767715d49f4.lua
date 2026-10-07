--description: ºìÉ°Õó-µñÏñ
--author: liujifang
--date: 2010-10-29

--¸±±¾±äÁ¿£º
instance_RightHideNpc = 21                   --¼ÇÂ¼ÓÒ²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_LeftHideNpc = 22                   --¼ÇÂ¼×ó²àºìÉ°×ßÀÈnpcµÄÒþ²ØNPC
instance_Step = 30                         --¸±±¾½ø¶È(1É±ËÀÒ»²àµÄÌØÊâ¹Ö£¬2É±ËÀÁ½Ö»ÌØÊâ¹Ö£¬3É±ËÀÃùÉ³ÏÉ£¬4É±ËÀÉ³Áú£¬5É±ËÀÕÅÌì¾ý£¬6ÎäÍõËÀÍö)
instance_ShaHun_Num = 31                   --¾Þ´óÉ³»ê´æÔÚµÄ¸öÊý
instance_ShaLingLeft_Num = 32              --×ó²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_ShaLingRight_Num = 33             --ÓÒ²àµØÍ¼ºìÉ«É³Áé´æÔÚµÄ¸öÊý
instance_BossIdx = 34                      --1ºÅBOSSÃùÉ³ÏÉµÄindex
instance_DoorMid = 35                      --ÖÐ¼äµÄ×èµ²ÃÅ
instance_LastNpc = 36                      --36-40ÎªÎäÍõºÍµñÏñµÄindex
instance_WuWangBoss = 41                   --Õ½¶·ÎäÍõµÄindex
instance_TrapDoor = 42                     --42-44Õ½¶·ÎäÍõµÄindex
--¸±±¾±äÁ¿


function OnDeath(npcidx)
    local oldInstance = InstanceIndex
    local instanceID = GetTask(1741)  --modify by liujifang at 2010-12-09
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcidx, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)

    local oldlift = GetNpcTask(npcidx, 2)
    local npcStep = GetNpcTask(npcidx, 3)--µñÏñ¼¤»îµÄ¸öÊý
    local IsCanBoss = GetNpcTask(npcidx, 9)--ÊÇ·ñ¿ÉÒÔË¢ÕÅÌì¾ý(0ÊÇ1·ñ)
    local mapid, mapX, mapY = GetNpcWorldPos(npcidx)

    if (IsCanBoss == 0) then
        local bossIdx = AddNpc(1851, 150, nSubWorldIdx, (mapX + 1) * 32, (mapY + 1) * 32)
        if (bossIdx > 0) then
            SetNpcScript(bossIdx, "\\script\\instance\\death\\ÕÅÌì¾ý.lua")
            SetAIScript(bossIdx, "\\script\\ai\\ÕÅÌì¾ý.lua")
            SetNpcTimer(bossIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", LeftTime)
            SetNpcTask(bossIdx, 0, InstanceIndex)
            SetNpcTask(bossIdx, 1, instanceID)
            SetNpcTask(bossIdx, 2, npcStep)
            SetNpcTask(bossIdx, 4, oldlift)
            SetNpcTask(bossIdx, 7, 1)
            SetNpcTask(bossIdx, 10, GetInstanceTempValue(41))
            SetNpcLife(bossIdx, oldlift)
            NpcAddIBBuff(bossIdx, 1064)

            SetInstanceTempValue(46, bossIdx)

            InstanceMsg2All(GetNpcTask(npcidx, 0), "Tr­¬ng Thiªn Qu©n", "<c=yel>Ng­¬i h·y ®îi ®Êy xem sù lîi h¹i cña ta!<c>")
        end
    end

    DelNpc(npcidx)

    InstanceIndex = oldInstance
end;
