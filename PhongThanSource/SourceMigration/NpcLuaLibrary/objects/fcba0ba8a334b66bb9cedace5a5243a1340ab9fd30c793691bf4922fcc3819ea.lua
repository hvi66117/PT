--description: 红砂阵-传送门左
--author: liujifang
--date: 2010-10-29

--副本变量：
instance_RightHideNpc = 21                   --记录右侧红砂走廊npc的隐藏NPC
instance_LeftHideNpc = 22                   --记录左侧红砂走廊npc的隐藏NPC
instance_Step = 30                         --副本进度(1杀死一侧的特殊怪，2杀死两只特殊怪，3杀死鸣沙仙，4杀死沙龙，5杀死张天君，6武王死亡)
instance_ShaHun_Num = 31                   --巨大沙魂存在的个数
instance_ShaLingLeft_Num = 32              --左侧地图红色沙灵存在的个数
instance_ShaLingRight_Num = 33             --右侧地图红色沙灵存在的个数
instance_BossIdx = 34                      --1号BOSS鸣沙仙的index
instance_DoorMid = 35                      --中间的阻挡门
instance_LastNpc = 36                      --36-40为武王和雕像的index
instance_WuWangBoss = 41                   --战斗武王的index
instance_TrapDoor = 42                     --42-44传送门的index
--副本变量

--NPCTASK: 2=记录每次刷怪的个数，3=记录停止刷怪的时间，4=记录是否已经刷出2号BOSS(1是0否)
--5=判断是否可以刷红砂阵灵(0可以1不可以)，6=记录刷怪的次数，

function OnTimer(npcidx)
    local oldInstance = InstanceIndex
    local instanceID = GetNpcTask(npcidx, 1)
    local nState, nType, nFirstEnterTime, nCurrentEnterCount, nSubWorldIdx = GetInstanceBaseInfo(instanceID)
    InstanceIndex = GetNpcTask(npcidx, 0)
    local LeftTime = 7200 - (LocalSystemTime() - nFirstEnterTime)
    local mapid, mapX, mapY = GetNpcWorldPos(npcidx)
    local npcIdx = 0

    for i = 1, 5 do
        npcIdx = AddNpc(1845, 150, SubWorld, (mapX + random(1, 5)) * 32, (mapY + random(1, 5)) * 32)

        if (npcIdx > 0) then

            SetNpcScript(npcIdx, "\\script\\instance\\death\\沙魔.lua")
            SetNpcTimer(npcIdx, "\\script\\ontimer\\删掉自己.lua", 300)
            SetNpcTask(npcIdx, 0, InstanceIndex)
            SetNpcTask(npcIdx, 1, instanceID)

        end
    end

    DelNpc(npcidx)
    InstanceIndex = oldInstance
end;
