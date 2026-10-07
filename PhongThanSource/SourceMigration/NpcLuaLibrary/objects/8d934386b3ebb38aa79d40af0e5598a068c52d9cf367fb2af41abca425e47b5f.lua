function OnDeath(npcidx)
    local w, x, y = GetWorldPos()
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            blessing(w)
        end
        PlayerIndex = oldPlayer
    else

        blessing(w)
    end ;
end;

function blessing(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        AddIBBuff(204)
        TopMessage(11672)
    end
end
