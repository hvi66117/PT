Task_newer13 = 1416

function OnDeath()
    if (GetPlayerType() == 0) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(242) == 0)
    then
        AddEventItem(242)
        TaskNote(209, 1)
        TopMessage("NhËn ®­îc mËt th­")
        Msg2Player("Mang mËt th­ ®Õn Sïng Thµnh Doanh giao cho T«n Tö Vò.")
        TaskNote(209, 2)
    end
end;
