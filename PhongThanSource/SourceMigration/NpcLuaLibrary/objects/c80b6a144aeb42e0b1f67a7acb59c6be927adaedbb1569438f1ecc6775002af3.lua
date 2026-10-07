--description: 狱法山和阪泉首领怪落内丹碎片和生活技能种子
--author: xiaolei
--date:2009/12/23
function OnDeath(npcindex)
    ThrowItem(npcindex, PlayerIndex, 3, 1006, 0, 0, 0, 0) --掉生活技能种子     		        
    ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
    ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)
    ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0)---掉落3个内丹碎片

    DelNpc(npcindex)
end