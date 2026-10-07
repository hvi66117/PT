Family_hrzq = 20

Task_hrzq = 1610

Task_hrzq_ylt = 1611
Task_hrzq_yl = 1612

Task_ibyq = 1613
Task_yq = 1614

attack_kind = {
    [1] = { num = 80, name = "DŞ Vùc CÈu Mang", id = 1454 },
    [2] = { num = 100, name = "N÷ Xó", id = 1395 },
}

function OnDeath(npcidx)


    local progress = GetTaskByte(Task_hrzq, 1)
    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            if (progress == 1) then
                local kindindex = GetTaskByte(Task_hrzq, 2)
                local nums = attack_kind[kindindex].num
                if ((HaveIBBuff(1093) > 0) and (attack_kind[kindindex].id == 1454)) then
                    local deathnums = GetTaskByte(Task_hrzq, 3)

                    if (deathnums < nums) then
                        deathnums = deathnums + 1
                        SetTaskByte(Task_hrzq, 3, deathnums)
                        if (deathnums == nums) then
                            ScrollMessage("H¹o Nhiªn Chİnh Khİ: <c=g>NhiÖm vô hoµn thµnh<c>")
                            SetTaskByte(Task_hrzq, 1, 2)
                            TaskNote(1502, 1)
                        else
                            ScrollMessage("H¹o Nhiªn Chİnh Khİ: VÉn cßn cÇn tiªu diÖt " .. (nums - deathnums) .. ".")
                            TaskNote(1502, 0, deathnums, nums, attack_kind[kindindex].name)
                        end
                    end
                end
            end
        end
        PlayerIndex = oldPlayer
    else

        if (progress == 1) then
            local kindindex = GetTaskByte(Task_hrzq, 2)
            local nums = attack_kind[kindindex].num
            if ((HaveIBBuff(1093) > 0) and (attack_kind[kindindex].id == 1454)) then
                local deathnums = GetTaskByte(Task_hrzq, 3)

                if (deathnums < nums) then
                    deathnums = deathnums + 1
                    SetTaskByte(Task_hrzq, 3, deathnums)
                    if (deathnums == nums) then
                        ScrollMessage("H¹o Nhiªn Chİnh Khİ: <c=g>NhiÖm vô hoµn thµnh<c>")
                        SetTaskByte(Task_hrzq, 1, 2)
                        TaskNote(1502, 1)
                    else
                        ScrollMessage("H¹o Nhiªn Chİnh Khİ: VÉn cßn cÇn tiªu diÖt " .. (nums - deathnums) .. ".")
                        TaskNote(1502, 0, deathnums, nums, attack_kind[kindindex].name)
                    end
                end
            end
        end
    end ;

    if (progress == 1) then
        if (IsHaveSpaceForTreasure(1) > 0) then

            local possibility = math.random(1, 1000)
            local level = GetExploitLevel()
            if (((level >= 4) and (possibility <= 15)) or (possibility <= 5)) then
                AddNormalItemPile(3, 1057, 0, 0, 0, 0)
            end
        end
    end
end;
