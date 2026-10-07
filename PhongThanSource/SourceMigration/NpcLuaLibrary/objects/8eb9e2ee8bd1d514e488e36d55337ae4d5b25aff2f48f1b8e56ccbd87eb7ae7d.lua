Task_DevilDisaster = 1097;

Task_DevilNum = 1098

function OnDeath(npcindex)
    local membercount = GetTeamSize()
    if (membercount == 0) then
        local nTaskInfo = GetTask(Task_DevilDisaster)
        if (nTaskInfo == 2 or nTaskInfo == 4 or nTaskInfo == 6) then
            if (nTaskInfo <= 6 and nTaskInfo >= 2) then
                SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
                AddNormalItemPile(3, 140, 0, 0, 0, 0)
                TopMessage(11667)
                Msg2Player("NhËn ®­îc §µi Yªu V­¬ng lÖnh bµi.")
                SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                if (GetTask(Task_DevilDisaster) == 7) then
                    TaskNote(1007, 2)
                    SetTask(Task_DevilDisaster, 8)
                    TopMessage(11606)
                    Msg2Player("Hoµn thµnh nhiÖm vô.")
                end
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local nTaskInfo = GetTask(Task_DevilDisaster)

            if (nTaskInfo == 2 or nTaskInfo == 4 or nTaskInfo == 6) then
                if (nTaskInfo <= 6 and nTaskInfo >= 2) then
                    SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
                    AddNormalItemPile(3, 140, 0, 0, 0, 0)
                    TopMessage(11667)
                    Msg2Player("NhËn ®­îc §µi Yªu V­¬ng lÖnh bµi.")
                    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                    if (GetTask(Task_DevilDisaster) == 7) then
                        TaskNote(1007, 2)
                        SetTask(Task_DevilDisaster, 8)
                        TopMessage(11606)
                        Msg2Player("Hoµn thµnh nhiÖm vô.")
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
    DelNpc(npcindex)
end
