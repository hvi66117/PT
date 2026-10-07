--description: 狞头目
--author: lisuhui
--date: 2009.08.18

Task_GoAstray = 1541

MainTask_GD_Conf = {
    [0] = { task = 3, note = 86 }, --???
    [1] = { task = 1, note = 87 }, --???
    [2] = { task = 2, note = 88 }, --???
}

function OnDeath(npcindex)
    local taskGoAstray = GetTaskByte(Task_GoAstray, 1)
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- 遍历队中队员
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            local taskGoAstray1 = GetTaskByte(Task_GoAstray, 1)
            local mapid, x, y = GetWorldPos()
            if (taskGoAstray1 == 1 and mapid == 76) then
                AddBloodBuff()
            end
        end
        PlayerIndex = oldPlayer
    else
        if (taskGoAstray == 1) then
            AddBloodBuff()
        end
    end
end

function AddBloodBuff()
    if (HaveIBBuff(784) > 0) then
        RemoveIBBuff(784)--噬狼之血Buff

        if (HaveIBBuff(786) > 0) then
            RemoveIBBuff(786)
        end
        AddIBBuff(786)--混之血Buff

    else
        AddIBBuff(785)--狞之血buff
    end
end