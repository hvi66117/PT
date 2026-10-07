Task_bingjiao = 1110;
Task_bingjiaoInfo = 1111;
function OnDeath(npcindex)
    local membercount = GetTeamSize()
    if (membercount == 0) then
        local nTaskInfo = GetTask(Task_bingjiao)
        if (nTaskInfo == 2 or nTaskInfo == 4 or nTaskInfo == 6) then
            nTaskInfo = nTaskInfo + 1
            SetTask(Task_bingjiao, nTaskInfo)
            SetTask(Task_bingjiaoInfo, 0)
            SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 1, 4))
            SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 2, 12))
            if (nTaskInfo == 7) then
                TaskNote(913, 2)
                TopMessage(11606)
                Msg2Player("Hoµn thµnh nhiÖm vô.")
            else
                TopMessage(11607)
                Msg2Player("Tiªu diÖt B¨ng Lang V­¬ng.")
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local nTaskInfo = GetTask(Task_bingjiao)
            if (nTaskInfo == 2 or nTaskInfo == 4 or nTaskInfo == 6) then
                nTaskInfo = nTaskInfo + 1
                SetTask(Task_bingjiao, nTaskInfo)
                if (nTaskInfo == 7) then
                    TaskNote(913, 2)
                    TopMessage(11606)
                    Msg2Player("Hoµn thµnh nhiÖm vô.")
                else
                    TopMessage(11607)
                    Msg2Player("Tiªu diÖt B¨ng Lang V­¬ng.")
                end
            end
            PlayerIndex = oldPlayer
        end
    end
    DelNpc(npcindex)
end