Task_DefectorPlan = 1043;
function OnDeath(npcindex)
    local membercount = GetTeamSize()
    if (membercount == 0) then
        local nTaskInfo = GetTask(Task_DefectorPlan)
        if (nTaskInfo >= 2) then
            if (nTaskInfo == 2) then
                AddEventItem(190)
                SetTask(Task_DefectorPlan, 4)
                TopMessage(11608)
                Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
            elseif (nTaskInfo == 3) then
                AddEventItem(190)
                SetTask(Task_DefectorPlan, 6)
                TopMessage(11608)
                Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
            elseif (nTaskInfo == 5) then
                AddEventItem(190)
                SetTask(Task_DefectorPlan, 7)
                TopMessage(11608)
                Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
            elseif (nTaskInfo == 8) then
                AddEventItem(190)
                SetTask(Task_DefectorPlan, 9)
                TaskNote(902, 2)
                TopMessage(11606)
                Msg2Player("Hoµn thµnh nhiÖm vô.")
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local nTaskInfo = GetTask(Task_DefectorPlan)
            if (nTaskInfo >= 2) then
                if (nTaskInfo == 2) then
                    AddEventItem(190)
                    SetTask(Task_DefectorPlan, 4)
                    TopMessage(11608)
                    Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
                elseif (nTaskInfo == 3) then
                    AddEventItem(190)
                    SetTask(Task_DefectorPlan, 6)
                    TopMessage(11608)
                    Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
                elseif (nTaskInfo == 5) then
                    AddEventItem(190)
                    SetTask(Task_DefectorPlan, 7)
                    TopMessage(11608)
                    Msg2Player("NhËn ®­îc Ph¶n Qu©n LÖnh Bµi")
                elseif (nTaskInfo == 8) then
                    AddEventItem(190)
                    SetTask(Task_DefectorPlan, 9)
                    TaskNote(902, 2)
                    TopMessage(11606)
                    Msg2Player("Hoµn thµnh nhiÖm vô.")
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end