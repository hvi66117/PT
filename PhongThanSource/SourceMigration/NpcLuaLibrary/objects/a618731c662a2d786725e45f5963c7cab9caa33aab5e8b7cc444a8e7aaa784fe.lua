function OnDeath(npcidx)
    for i = 131, 140 do
        if GetGlobalValue(i) == npcidx then
            SetGlobalValue(i, 0)
        end
    end
    DelNpc(npcidx)

    local w, x, y = GetWorldPos()
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            renwu1(w)
        end
        PlayerIndex = oldPlayer
    else

        renwu1(w)
    end ;
end;

function renwu1(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        if (taskval1 == 84) or (taskval2 == 84) or (taskval3 == 84) then
            AddIBBuff(222)
            Msg2Player("Bπn nhÀn Æ≠Óc Vi‘n CÊ H·a Di÷m")
            TopMessage(11669)
        end
    end
end
