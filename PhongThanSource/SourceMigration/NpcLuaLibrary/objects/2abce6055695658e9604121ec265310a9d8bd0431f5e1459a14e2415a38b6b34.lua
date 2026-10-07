Task_newer13 = 1416

function OnDeath()
    if (GetPlayerType() == 2) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(235) == 0) then
        if (HaveEventItem(236) == 0) then
            Msg2Player("Thu thËp má thñ lÜnh Cuång §iªu, vÉn cßn thiÕt n­íc m¾t §µi Yªu.")
        else
            SetTaskByte(Task_newer13, 1, 2)
            Msg2Player("§i t×m §¹i Phu ë Du Hån dïng Tam Muéi Ch©n Háa nÊu vËt phÈm nµy thµnh Linh ®¬n!")
            TaskNote(205, 1)
        end
        AddEventItem(235)
        TopMessage("NhËn ®­îc má Cuång §iÓu")
    end
end;
