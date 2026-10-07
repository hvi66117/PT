instence_Task = 1606

function OnDeath(npcindex)
    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 2) == 0 and HaveNormalItem(6, 1, 749, 0) < 1) then
            if (IsHaveSpaceForTreasure(1) < 1) then
                Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn Th­ nhuém m¸u!")
            else
                AddNormalItem(6, 1, 749, 0, 0, 0)
                TopMessage("NhËn ®­îc <c=g>Th­ nhuém m¸u<c>")
                Msg2Player("NhËn ®­îc 1 Th­ nhuém m¸u, më ra xem bªn trong viÕt g×.")
            end
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 2) == 0 and HaveNormalItem(6, 1, 749, 0) < 1) then
                if (IsHaveSpaceForTreasure(1) == 1) then
                    AddNormalItem(6, 1, 749, 0, 0, 0)
                    TopMessage("NhËn ®­îc <c=g>Th­ nhuém m¸u<c>")
                    Msg2Player("NhËn ®­îc 1 Th­ nhuém m¸u, më ra xem bªn trong viÕt g×.")
                else
                    Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn Th­ nhuém m¸u!")
                end
            end
        end
        PlayerIndex = oldPlayer
    end
    DelNpc(npcidx)
end

