--description: 虫鬼
--author: yaoxin
--date: 2009/2/10

function OnDeath(npcindex)
    DelNpc(npcindex)--猪笼之草，杀死虫鬼不会获得经验与掉落物品
end