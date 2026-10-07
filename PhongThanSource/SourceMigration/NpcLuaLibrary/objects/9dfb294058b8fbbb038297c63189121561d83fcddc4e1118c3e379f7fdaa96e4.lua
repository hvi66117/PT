Task_DevilDisaster = 1097;
--	 “Ï»À…±À¿Ã¶—˝ ˝ƒø
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
                Msg2Player("NhÀn Æ≠Óc LÙc Qu∏i V≠¨ng l÷nh bµi.")
                SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                if (GetTask(Task_DevilDisaster) == 7) then
                    TaskNote(1007, 2)
                    SetTask(Task_DevilDisaster, 8)
                    TopMessage(11606)
                    Msg2Player("Hoµn thµnh nhi÷m vÙ.")
                end
            end
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            local nTaskInfo = GetTask(Task_DevilDisaster)
            --			if( nTaskInfo>=2 and nTaskInfo <=4)then
            --            	AddNormalItem(3,140,0,0,0,0)
            --				SetTask( Task_DevilDisaster ,GetTask(Task_DevilDisaster)+1 )
            --				TopMessage("ªÒµ√Ã¶—˝Õı¡Ó≈∆")
            --				Msg2Player("ªÒµ√Ã¶—˝Õı¡Ó≈∆°£")			
            --				if(GetTask(Task_DevilDisaster) == 5)then
            --					TaskNote(1007,2)
            --					TopMessage("ÕÍ≥…»ŒŒÒ")
            --					Msg2Player("ÕÍ≥…»ŒŒÒ°£")
            --				end
            --			end
            if (nTaskInfo == 2 or nTaskInfo == 4 or nTaskInfo == 6) then
                if (nTaskInfo <= 6 and nTaskInfo >= 2) then
                    SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
                    AddNormalItemPile(3, 140, 0, 0, 0, 0)
                    TopMessage(11667)
                    Msg2Player("NhÀn Æ≠Óc LÙc Qu∏i V≠¨ng l÷nh bµi.")
                    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                    if (GetTask(Task_DevilDisaster) == 7) then
                        TaskNote(1007, 2)
                        SetTask(Task_DevilDisaster, 8)
                        TopMessage(11606)
                        Msg2Player("Hoµn thµnh nhi÷m vÙ.")
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
    DelNpc(npcindex)
end