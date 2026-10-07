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
        local i = GetLevel() - 5
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end ;
    end ;

    if (GetTaskBit(2089, 17) == 1 and GetNewBirthTimes() == 1 and GetPlayerType() == 1 and GetTaskBit(2089, 18) == 0) then
        NewBirthdayTask()
    end

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

    if (GetTask(1117) == 1) and (GetByte(GetTask(1123), 1) == 1) then
        MonsterTip()
    end

    if (GetByte(GetTask(993), 1) == 2) then
        Frenwu1()
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (GetTask(1070) == 1) and (GetByte(GetTask(1071), 1) == 1) then
        NewPlayerTask()
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

    if (type1 == 2 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 2 and count2 > 0) then
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
        ScrollMessage("KÕ Tôc: Cßn ph¶i tiªu diÖt " .. (L_nums - testNums) .. " TuyÕt Yªu")
        TaskNote(51, 1, "TuyÕt Yªu", testNums, L_nums)

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
        TopMessage("Lùc Cóng TÕ: NhËn ®­îc thªm 1 <c=g>B¨ng C¬<c>")
        AddNormalItemPile(3, 13, 0, 0, 0, 0)
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
    if (GetTask(1117) == 0) and (HaveNormalItem(6, 1, 307, 1) < 1) then
        local nProp = math.random(1, 100)
        local nlv = GetLevel()
        if (nlv >= 9) and (nlv <= 13) then
            if (nProp <= 10) then
                AddNormalItem(6, 1, 307, 1, 0, 0)
                TopMessage(11614)
                Msg2Player("B¹n may m¾n nhËn ®­îc 1 TuyÕt Yªu MËt tÞch")
            end
        else
            if (nProp <= 4) then
                AddNormalItem(6, 1, 307, 1, 0, 0)
                TopMessage(11614)
                Msg2Player("B¹n may m¾n nhËn ®­îc 1 TuyÕt Yªu MËt tÞch")
            end
        end
    end

    if (GetTask(1119) == 0 and HaveNormalItem(6, 1, 309, 1) < 1) then
        local nProp = math.random(1, 100)
        if (nProp <= 1) then
            AddNormalItem(6, 1, 309, 1, 0, 0)
            TopMessage(11612)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 MËt tÞch Thu ThËp.")
        end
    end
end

function MonsterTip()
    local nTaskInfo = GetTask(1123)
    local nNeedNum = GetByte(nTaskInfo, 2)
    local nReaNum = GetByte(nTaskInfo, 3)
    if (nReaNum < nNeedNum) then
        nReaNum = nReaNum + 1
        SetTask(1123, SetByte(nTaskInfo, 3, nReaNum))
        if (nReaNum >= nNeedNum) then
            SetTask(1117, 2)
            TaskNote(915, 2)
            TopMessage(11620)
            Msg2Player("Hoµn thµnh nhiÖm vô TuyÕt Yªu MËt tÞch, cã thÓ ®i gÆp T¹p hãa Th­¬ng nhËn th­ëng.")
        else
            TaskNote(915, 1, nReaNum, nNeedNum)
            TopMessage("Tiªu diÖt TuyÕt Yªu" .. nReaNum .. "/" .. nNeedNum .. ".")
            Msg2Player("Tiªu diÖt TuyÕt Yªu" .. nReaNum .. "/" .. nNeedNum .. ".")
        end
    end
end

function NewPlayerTask()
    local nTaskInfo = GetTask(1071)
    local nNum = GetByte(nTaskInfo, 3) + 1
    if (nNum < 8) then
        SetTask(1071, SetByte(nTaskInfo, 3, nNum))
        TaskNote(896, 1, "TuyÕt Yªu", nNum, 8)
        Msg2Player("T©n thñ thÝ luyÖn: Cßn ph¶i tiªu diÖt TuyÕt Yªu" .. (8 - nNum) .. ".")
    elseif (nNum == 8) then
        SetTask(1070, 2)
        TaskNote(896, 2)
        TopMessage(11625)
        Msg2Player("Hoµn thµnh nhiÖm vô, trë vÒ Thî ®ång phôc mÖnh!")
    end
end

function NewBirthdayTask()
    local num = GetTaskByte(2089, 4)
    num = num + 1
    if (num < 20) then
        SetTaskByte(2089, 4, num)
        TaskNote(2045, 1, num)
        Msg2Player("§· tiªu diÖt ®­îc " .. num .. " TuyÕt Yªu.")
    else
        SetTaskByte(2089, 4, num)
        TaskNote(2045, 2)
        Msg2Player("T×m Nhiªn §¨ng §¹o Nh©n hoµn thµnh nhiÖm vô.")
    end
end

