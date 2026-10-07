--description: 鬼怖兽
--author: yaoxin
--date: 2008/4/1

Task_qingming1 = 1193 -- 完成的进度0=未接 1=己放置, 10=完成任务
Task_tree = 1194 -- 树苗的id
Task_tree1 = 1195 -- 树苗的idx

function OnDeath(npcindex)
    DelNpc(npcindex)
end