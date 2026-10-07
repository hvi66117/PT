Task_bingjiao = 1110;
Task_bingjiaoInfo = 1111;

Task_newer13 = 1416

npc_name = {
    [2] = "TuyÕt Yªu",
    [5] = "B¨ng Kiªu Trïng",
    [9] = "TuyÕt Nguyªn Cù Thó",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local playerlevel = GetLevel()

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

    if (GetPlayerType() == 1) then

        if (GetTask(Task_bingjiao) >= 1 and GetTask(Task_bingjiao) <= 6
        ) and (GetByte(GetTask(Task_bingjiaoInfo), 1) == 4) then
            FNewPlan(w, x, y)
        end

        if (w == 10) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(238) == 0) then
            FNewPlan13()
        end
    end

    if (GetTask(955) == 5) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetByte(GetTask(993), 1) == 5) then
        Frenwu1()
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (HaveIBBuff(2148) >= 1) then
        if (mapgid >= 8) and (mapgid <= 10) then
            Fliudao(playerlevel)
        end
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

    if (type1 == 5 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 5 and count2 > 0) then
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

function Frenwu1()
    local testNums = GetTask(994) + 1
    local L_nums = GetByte(GetTask(993), 2) * 10
    if (testNums < L_nums) then
        SetTask(994, testNums)
        ScrollMessage("KÕ Tôc: Cßn ph¶i tiªu diÖt " .. (L_nums - testNums) .. " B¨ng Kiªu Trïng")
        TaskNote(51, 1, "B¨ng Kiªu Trïng", testNums, L_nums)

    elseif (testNums <= L_nums + 30) then
        SetTask(994, testNums)
        if (math.mod(testNums, 10) == 0) then
            ScrollMessage(11643)
            TaskNote(51, 2)
        end
    end
end

function Fliudao(plvl)
    local r_sx = math.random(1, 100)
    local task_rand = 10
    if (GetNewBirthTimes() >= 1) then
        plvl = 200
        task_rand = 60
    elseif (plvl > 64) then
        task_rand = math.floor((plvl - 50) / 15) * 5 + 10
    end

    if (r_sx <= task_rand) then
        TopMessage("Lùc Cóng TÕ: NhËn ®­îc thªm 1 <c=g>Ngäc Cèt<c>")
        AddNormalItemPile(3, 9, 0, 0, 0, 0)
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn B¨ng Kiªu Trïng" .. (20 - nums) .. ".")
        TaskNote(50, 1, "B¨ng Kiªu Trïng", nums)
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
    local nTaskInfo = GetTask(Task_bingjiaoInfo)
    local nNum = GetByte(nTaskInfo, 2)
    local nRealNum = GetByte(nTaskInfo, 3) + 1
    local membercount = GetTeamSize()
    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 3, nRealNum))
    if (membercount == 0) then
        if (nRealNum < nNum) then
            TaskNote(913, "B¨ng Kiªu Trïng", nRealNum, nNum)
            Msg2Player("NhiÖm vô B¨ng Kiªu Trïng: Cßn ph¶i tiªu diÖt " .. (nNum - nRealNum) .. " B¨ng Kiªu Trïng!")
        else
            if (GetTask(Task_bingjiao) == 1) or (GetTask(Task_bingjiao) == 3) or (GetTask(Task_bingjiao) == 5) then
                SetTask(Task_bingjiao, GetTask(Task_bingjiao) + 1)
            end

            local newnpcidx = AddNpc(606, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B¨ng Kiªu Trïng V­¬ng<c>")
            TopMessage(11629)
            Msg2Player("B¨ng Kiªu Trïng V­¬ng xuÊt hiÖn")
            SetTask(Task_bingjiaoInfo, SetByte(nTaskInfo, 3, 0))
        end

    else
        local nCountTmp = 0
        local oldPlayer = PlayerIndex
        local wX, xX, yX
        local nTempRealNum = 0
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            wX, xX, yX = GetWorldPos()
            nTempRealNum = GetByte(GetTask(Task_bingjiaoInfo), 3)
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
                    Msg2Player("NhiÖm vô B¨ng Kiªu Trïng: Cßn ph¶i tiªu diÖt " .. (nNum - nCountTmp) .. " B¨ng Kiªu Trïng!")
                end
            end
            PlayerIndex = oldPlayer
        else
            local newnpcidx = AddNpc(606, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B¨ng Kiªu Trïng V­¬ng<c>")
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 3, 0))
                    TopMessage(11629)
                    Msg2Player("B¨ng Kiªu Trïng V­¬ng xuÊt hiÖn")
                    if (GetTask(Task_bingjiao) == 1) or (GetTask(Task_bingjiao) == 3) or (GetTask(Task_bingjiao) == 5) then
                        SetTask(Task_bingjiao, GetTask(Task_bingjiao) + 1)
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

function FNewPlan13()
    local r = math.random(1, 10)
    if (r <= 3) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(238) == 0) then
        SetTaskByte(Task_newer13, 1, 3)
        Msg2Player("[Minh ¢m CÇm] ghi l¹i tung tÝch cña [Ch©n Long Kú].")
        TaskNote(207, 2)
        AddEventItem(238)
        TopMessage("NhËn <c=yel>Minh ¢m CÇm<c>")
    end
end
