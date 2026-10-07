Task_DevilDisaster = 1097
Task_DevilNum = 1098

Task_newer13 = 1416

npc_name = {
    [3] = "§¹i Chñng Nh©n",
    [6] = "§µi Yªu",
    [7] = "Cuång §iªu",
    [10] = "Th¶o Tiªn",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 10
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end ;
    end ;

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(852) > 0) then
                liesha_city(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end
    end ;

    if (GetLevel() <= 20) then
        MonsterDropScroll()
    end

    if (GetPlayerType() == 2) then

        if (GetTask(Task_DevilDisaster) >= 1 and GetTask(Task_DevilDisaster) <= 6
        ) and (GetByte(GetTask(Task_DevilNum), 1) == 5) then
            FNewPlan(w, x, y)
        end

        if (w == 11) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(236) == 0) then
            FNewPlan13()
        end
    end

    if (GetTask(955) == 6) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end
end

function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 852
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 6 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 6 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    end

    if (count1 == 0 and count2 == 0) then
        TaskNote(task_id, 1)
    end
end

function no()
    CloseDialog()
end;

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn §µi Yªu" .. (20 - nums) .. ".")
        TaskNote(50, 1, "§µi Yªu", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu42()

    local rand_buff = math.random(1, 1000)
    local today_buff = math.floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

function MonsterDropScroll()
    if (GetTask(1119) == 0 and HaveNormalItem(6, 1, 309, 1) < 1) then
        local nProp = math.random(1, 100)
        if (nProp <= 1) then
            AddNormalItem(6, 1, 309, 1, 0, 0)
            TopMessage(11612)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 MËt tÞch Thu ThËp.")
        end
    end
end

function FNewPlan(w, x, y)
    local nTaskInfo = GetTask(Task_DevilNum)
    local nNum = GetByte(nTaskInfo, 2)
    local nRealNum = GetByte(nTaskInfo, 3) + 1
    local membercount = GetTeamSize()

    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, nRealNum))
    if (membercount == 0) then
        if (nRealNum < nNum) then
            TaskNote(1007, "§µi Yªu", nRealNum, nNum)
            Msg2Player("NhiÖm vô §µi Yªu: Cßn ph¶i tiªu diÖt " .. (nNum - nRealNum) .. " §µi Yªu.")
        else
            if (GetTask(Task_DevilDisaster) == 1) or (GetTask(Task_DevilDisaster) == 3) or (GetTask(Task_DevilDisaster) == 5) then
                SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
            end
            local newnpcidx = AddNpc(607, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>§µi Yªu V­¬ng<c>")
            TopMessage(11630)
            Msg2Player("§µi Yªu V­¬ng xuÊt hiÖn")
            SetTask(Task_DevilNum, SetByte(nTaskInfo, 3, 0))
        end

    else
        local nCountTmp = 0
        local oldPlayer = PlayerIndex
        local wX, xX, yX
        local nTempRealNum = 0
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            wX, xX, yX = GetWorldPos()
            nTempRealNum = GetByte(GetTask(Task_DevilNum), 3)
            if (wX == w) then
                nCountTmp = nCountTmp + nTempRealNum
            end
        end
        PlayerIndex = oldPlayer

        if (nCountTmp < nNum) then
            oldPlayer = PlayerIndex
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    Msg2Player("NhiÖm vô §µi Yªu: Cßn ph¶i tiªu diÖt " .. (nNum - nCountTmp) .. " §µi Yªu.")
                end
            end
            PlayerIndex = oldPlayer
        else
            local newnpcidx = AddNpc(607, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>§µi Yªu V­¬ng<c>")
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                    TopMessage(11630)
                    Msg2Player("§µi Yªu V­¬ng xuÊt hiÖn")
                    if (GetTask(Task_DevilDisaster) == 1) or (GetTask(Task_DevilDisaster) == 3) or (GetTask(Task_DevilDisaster) == 5) then
                        SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

function FNewPlan13()
    local r = math.random(1, 10)
    if (r <= 3) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(236) == 0) then
        if (HaveEventItem(235) == 0) then
            Msg2Player("Thu thËp ®­îc n­íc m¾t §µi Yªu, cßn thiÕu má Cuång §iªu")
        else
            SetTaskByte(Task_newer13, 1, 2)
            Msg2Player("§i t×m §¹i Phu ë Du Hån dïng Tam Muéi Ch©n Háa nÊu vËt phÈm nµy thµnh Linh ®¬n!")
            TaskNote(205, 1)
        end
        AddEventItem(236)
        TopMessage("NhËn 1 giät n­íc m¾t §µi Yªu")
    end
end
