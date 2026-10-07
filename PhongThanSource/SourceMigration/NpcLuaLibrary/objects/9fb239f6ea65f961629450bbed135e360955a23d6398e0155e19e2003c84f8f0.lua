function OnDeath(npcidx)
    if (GetTeam() ~= 0) then
        -- 有队伍(包括只有自己一个人的)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- 遍历队中队员
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            calc_task(w)
        end
        PlayerIndex = oldPlayer
    else
        -- 无队伍
        calc_task(w)
    end ;
    DelNpc(npcidx)
end;

function calc_task(w1)
    if (GetTask(728) == 3) then
        --有杀该boss的任务
        SetTask(728, 9)        --已杀死标记
        TopMessage(11670)
        AddNormalItem(6, 1, 177, 1, 0, 0, 0)        --屈原的魂魄
    end
end;