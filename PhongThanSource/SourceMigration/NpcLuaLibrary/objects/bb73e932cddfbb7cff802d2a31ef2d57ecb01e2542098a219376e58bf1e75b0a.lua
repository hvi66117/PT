--description: 法阵
--author: yaoxin
--date: 2009/02/25

--天岳阎罗
yanluo_globalnpc = 174 --暗淡法阵的npcidx 

function OnDeath(npcidx)
    local id = SubWorldID2Idx(73)
    if (id ~= -1) then
        local newzhen = AddNpc(873, 1, id, 1836 * 32, 3528 * 32)
        SetGlobalValue(yanluo_globalnpc, newzhen)
        SetGuardLevel(newzhen, 2)
        SetNpcName(newzhen, "")
    end
    DelNpc(npcidx)
end;

