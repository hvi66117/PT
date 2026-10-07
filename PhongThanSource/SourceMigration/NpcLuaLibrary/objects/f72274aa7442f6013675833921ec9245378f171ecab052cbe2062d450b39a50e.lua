--description: 首领怪掉落内丹碎片和生活技能种子
--author: xiaolei
--date:2009/10/11
function OnDeath(npcindex)
    ThrowItem(npcindex, PlayerIndex, 3, 1006, 0, 0, 0, 0) --掉生活技能种子     
    local p = random(1, 2)----掉落内丹碎片概率为50%
    if (p == 1) then
        ThrowItem(npcindex, PlayerIndex, 3, 1012, 0, 0, 0, 0) --掉内丹碎片
    end

    DelNpc(npcindex)
end