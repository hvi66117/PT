-- Project compatibility patch, appended to the hash-verified VNG normal.lua.
-- Quest IDs, targets, limits, messages and hard-monster drop tuples remain
-- those in the original source; this fixes execution context, not quest rules.

function PTQuestNpcName(templateID)
    local name = npc_name[templateID]
    if name then return name end
    name = GetNpcTempName(templateID - 1)
    if name and name ~= "" then return name end
    return tostring(templateID)
end

function OnDeath(npcindex)
    local killer = PlayerIndex
    if not killer or killer <= 0 then return end
    local world = GetNpcWorldPos(npcindex)
    local killerWorld = GetWorldPos()
    if not world or world <= 0 or killerWorld ~= world then return end

    local npcID = GetNpcTemplateID(npcindex)
    local lvl = GetNpcLevel(npcindex)
    local npcchr = GetHardNpcAttrib(npcindex)
    -- The eight original ThrowItem tuples, unchanged.
    if npcchr >= 0 and GetLevel() - lvl <= 10 then
        if npcchr == 0 then
            ThrowItem(npcindex, PlayerIndex,3,15,0,1,0,0)
        elseif npcchr == 1 then
            ThrowItem(npcindex, PlayerIndex,3,17,0,1,0,0)
        elseif npcchr == 2 then
            ThrowItem(npcindex, PlayerIndex,3,16,0,1,0,0)
        elseif npcchr == 3 then
            ThrowItem(npcindex, PlayerIndex,3,21,0,1,0,0)
        elseif npcchr == 4 then
            ThrowItem(npcindex, PlayerIndex,3,18,0,1,0,0)
        elseif npcchr == 5 then
            ThrowItem(npcindex, PlayerIndex,3,20,0,1,0,0)
        elseif npcchr == 6 then
            ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
        elseif npcchr == 7 then
            ThrowItem(npcindex, PlayerIndex,3,19,0,1,0,0)
        end
    end

    -- GetTeam() is nil for solo and 0 is a valid team ID in the server.
    -- Snapshot members before changing PlayerIndex; otherwise an invalid or
    -- offline member can change the team from which the next slot is read.
    local membercount = GetTeamSize()
    local members = {}
    if membercount > 0 then
        for i=1,membercount do
            local member = GetTeamMember(i)
            if member and member > 0 then
                members[getn(members)+1] = member
            end
        end
    else
        members[1] = killer
    end

    local credited = {}
    for i=1,getn(members) do
        local member = members[i]
        if not credited[member] then
            credited[member] = 1
            PlayerIndex = member
            local memberWorld = GetWorldPos()
            if memberWorld == world then
                liesha_city(npcID+1, world, lvl)
                huahui_open_task(npcID+1, world)
                -- Read each member's own target, not the killer's task 897.
                if membercount == 2 and GetTask(897) == npcID+1 and
                    GetTask(898) > 0 and judge_relation() == 1 then
                    mission_PR()
                end
            end
        end
    end
    PlayerIndex = killer
end
