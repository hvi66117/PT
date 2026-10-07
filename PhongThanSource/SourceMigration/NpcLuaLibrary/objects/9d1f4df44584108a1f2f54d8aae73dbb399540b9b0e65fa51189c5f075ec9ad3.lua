
function OnDeath(npcidx)
    local w, x, y = GetWorldPos()
    if (GetTeam() ~= 0) then
        -- 有队伍(包括只有自己一个人的)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- 遍历队中队员
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            blessing(w)
        end
        PlayerIndex = oldPlayer
    else
        -- 无队伍
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