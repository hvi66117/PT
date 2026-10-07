function OnDeath(npcindex)
    SetGlobalValue(945, -1)

    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcindex)
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (GetTask(936) >= 1) and (GetTask(936) < 4) then
                city_shouji(w)
            end
        end
        PlayerIndex = oldPlayer
    else

        if (GetTask(936) >= 1) and (GetTask(936) < 4) then
            city_shouji(w)
        end
    end ;
end;

function city_shouji(world)
    local w, x, y = GetWorldPos()
    if (w == world) then

        if (GetTask(949) == 0) then
            SetTask(936, GetTask(936) + 1)
            Msg2Player("Chinh phôc ®­îc Thùc Khİ Quû.")

            SetTask(949, 1)
        end

        if (GetTask(936) < 5) and (GetTask(949) == 1) then
            if (GetTask(936) == 2) then
                TaskNote(49, 2)
            elseif (GetTask(936) == 3) and (GetTask(947) >= 1) then
                TaskNote(49, 6)
            elseif (GetTask(936) == 3) and (GetTask(948) >= 1) then
                TaskNote(49, 7)
            else
                TaskNote(49, 8)
            end

            SetTask(949, 2)
        end
    end
end
