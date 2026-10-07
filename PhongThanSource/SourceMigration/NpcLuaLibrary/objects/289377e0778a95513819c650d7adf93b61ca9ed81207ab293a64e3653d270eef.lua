--Descript:红砂阵-沙龙
--Author:liujifang
--Date:2010-11-01

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
instance_TrapDoor = 42                     --42-44战斗武王的index
--副本变量


function OnDeath(npcIndex)

    DelNpc(npcIndex)

end