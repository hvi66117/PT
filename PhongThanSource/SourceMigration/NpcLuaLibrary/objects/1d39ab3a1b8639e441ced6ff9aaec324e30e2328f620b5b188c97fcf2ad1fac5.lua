Task_newer13 = 1416

function OnDeath()
    if (GetPlayerType() == 1) and (GetTaskByte(Task_newer13, 1) == 3) and (HaveEventItem(239) == 0) then
        SetTaskByte(Task_newer13, 1, 4)
        Msg2Player("Trªn [Tr©n Long Kú] cã vÕt tÝch cña [Nam Hoa Kinh].")
        TaskNote(207, 3)
        AddEventItem(239)
        TopMessage("NhËn ®­îc <c=yel>Tr©n Long Kú<c>")
    end
end;
