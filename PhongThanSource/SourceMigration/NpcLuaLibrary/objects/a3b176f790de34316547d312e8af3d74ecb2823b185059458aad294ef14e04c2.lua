function OnDeath(npcidx)
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            calc_task(w)
        end
        PlayerIndex = oldPlayer
    else

        calc_task(w)
    end ;
    DelNpc(npcidx)
end;

function calc_task(w1)
    if (GetTask(728) == 3) then
        SetTask(728, 9)
        TopMessage(11670)
        AddNormalItem(6, 1, 177, 1, 0, 0, 0)
    end
end;
