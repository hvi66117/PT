instence_Task = 1606

function OnDeath(npcindex)
    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 1) == 4) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn MËt LÖnh!")
            else
                AddEventItem(286)
                TaskNote(1204, 3)
                SetTaskByte(instence_Task, 1, 5)
                TopMessage("NhËn ®­îc <c=g>MËt LÖnh<c>")
                Msg2Player("NhËn ®­îc 1 MËt LÖnh, ®i t×m D­¬ng TiÔn hái vÒ t¸c dông cña vËt nµy.")
            end
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 1) == 4) then
                if (IsHaveSpaceForTreasure(1) == 1) then
                    SetTaskByte(instence_Task, 1, 5)
                    AddEventItem(286)
                    TopMessage("NhËn ®­îc <c=g>MËt LÖnh<c>")
                    Msg2Player("NhËn ®­îc 1 MËt LÖnh, ®i t×m D­¬ng TiÔn hái vÒ t¸c dông cña vËt nµy.")
                    TaskNote(1204, 3)
                else
                    Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn MËt LÖnh!")
                end
            else
                if (GetTaskByte(instence_Task, 1) == 5) then
                    Msg2Player("§em MËt LÖnh cho D­¬ng TiÔn, ®Ó sím ngµy ®o¹t l¹i Hån Ph¸ch Kh­¬ng Tö Nha!")
                end
            end
        end
        PlayerIndex = oldPlayer
    end
    DelNpc(npcindex)
end
