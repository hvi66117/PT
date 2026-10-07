instence_Task = 1606

function OnDeath(npcindex)
    local oldInstance = InstanceIndex
    InstanceIndex = GetNpcTask(npcindex, 1)
    if (GetTeam() == 0) then
        if (GetTaskByte(instence_Task, 2) == 1) then
            local m, x, y = GetNpcWorldPos(npcindex)
            local secnpcidx = AddNpc(1520, 1, SubWorld, x * 32, y * 32)
            SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾ü½«Áì.lua")
            SetInstanceTempValue(25, secnpcidx);
            SetInstanceTempValue(26, GetNpcID(secnpcidx))
            Msg2Player("D­êng nh­ ®· b¾t ®­îc 1 Binh sÜ Qu©n Chu, mau qua ®ã xem thö!")
        end
    else
        local oldPlayer = PlayerIndex
        local oldPlayer = PlayerIndex
        local AddNum = 0
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(instence_Task, 2) == 1) then
                if (AddNum == 0) then
                    local m, x, y = GetNpcWorldPos(npcindex)
                    local secnpcidx = AddNpc(1520, 1, SubWorld, x * 32, y * 32)
                    SetNpcScript(secnpcidx, "\\script\\instance\\ÖÜ¾ü½«Áì.lua")
                    SetInstanceTempValue(25, secnpcidx);
                    SetInstanceTempValue(26, GetNpcID(secnpcidx))
                    Msg2Player("D­êng nh­ ®· b¾t ®­îc 1 Binh sÜ Qu©n Chu, mau qua ®ã xem thö!")
                    AddNum = AddNum + 1
                end
            end
        end
        PlayerIndex = oldPlayer
    end

    DelNpc(npcidx)
    InstanceIndex = oldInstance
end
