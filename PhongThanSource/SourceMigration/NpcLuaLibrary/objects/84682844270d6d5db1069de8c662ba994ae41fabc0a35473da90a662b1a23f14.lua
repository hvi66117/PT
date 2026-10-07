function OnDeath(npcindex)
    SetGlobalValue(946, -1)

    local w, x, y = GetWorldPos()
    --local lvl = GetNpcLevel(npcindex)
    if (GetTeam() ~= 0) then
        -- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- ¹M¾ú¶¤¤¤¶¤­û
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (GetTask(936) >= 1) and (GetTask(936) < 4) then
                city_shouji(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- µL¶¤¥î		
        if (GetTask(936) >= 1) and (GetTask(936) < 4) then
            city_shouji(w)
        end
    end ;
end;

function city_shouji(world)
    local w, x, y = GetWorldPos()
    if (w == world) then

        if (GetTask(948) == 0) then
            SetTask(936, GetTask(936) + 1)
            Msg2Player("Chinh phôc ®­îc Thùc Thñy Quû.")

            SetTask(948, 1)
        end

        if (GetTask(936) < 5) and (GetTask(948) == 1) then
            if (GetTask(936) == 2) then
                TaskNote(49, 3)
            elseif (GetTask(936) == 3) and (GetTask(947) >= 1) then
                TaskNote(49, 5)
            elseif (GetTask(936) == 3) and (GetTask(949) >= 1) then
                TaskNote(49, 7)
            else
                TaskNote(49, 8)
            end

            SetTask(948, 2)
        end
    end
end