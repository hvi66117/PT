-- 修正脚本报错 modify by yangtao at 2010/1/6 start
--取得npc的状态
function GetPlayerTaskState()
    return 0, 0
end
-- 修正脚本报错 modify by yangtao at 2010/1/6 end

function OnDeath(npcidx)
    DelNpc(npcidx)
end;

function no()
    CloseDialog()
end;