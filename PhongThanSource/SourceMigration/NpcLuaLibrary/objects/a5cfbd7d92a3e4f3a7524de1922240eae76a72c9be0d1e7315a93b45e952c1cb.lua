Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;

Task_hengcai = 1214;

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
        local i = GetLevel() - 15
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
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

    if (GetByte(GetTask(1127), 1) == 1 and GetByte(GetTask(1127), 2) == 9) then
        MonsterTip()
    end

    if (GetTask(Task_PrepareMaterial) == 1) then
        if (GetPlayerType() == 2) and (GetByte(GetTask(Task_PrepareMaterNum), 1) == 9) then
            FPreGoodsNew()
        end
    end

    if (GetTask(955) == 10) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) > 0) then
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

    if (type1 == 10 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 10 and count2 > 0) then
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
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Th¶o Tiªn" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Th¶o Tiªn", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu42()
    if (GetTask(936) < 5) then
        local r = math.random(1, 10000)
        local zyCNums = GetByte(GetTask(938), 3) + 1
        local key = 0
        if (zyCNums == 1) and (r <= 100) then
            key = 1
        elseif (zyCNums == 2) and (r >= 100) and (r <= 110) then
            key = 1
        elseif (zyCNums >= 3) and (r == 5000) then
            key = 1
        end
        if (key == 1) then
            AddNormalItemPile(3, 101, 1, 0, 0, 0)
            TopMessage(11645)
            SetTask(938, SetByte(GetTask(938), 3, zyCNums))
        end
    else

        local rand_buff = math.random(1, 1000)
        local today_buff = math.floor(LocalSystemTime() / 86400)
        if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
            AddIBBuff(369)
            TopMessage(11647)
            SetTask(991, today_buff)
        end
    end
end

function MonsterDropScroll()
    if (GetTask(1127) == 0) and (HaveNormalItem(6, 1, 306, 1) < 1) then
        local nProp = math.random(1, 100)
        local nlv = GetLevel()
        if (nlv >= 9) and (nlv <= 13) then
            if (nProp <= 10) then
                AddNormalItem(6, 1, 306, 1, 0, 0)
                TopMessage(11617)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Th¶o Tiªn mËt tÞch")
            end
        else
            if (nProp <= 4) then
                AddNormalItem(6, 1, 306, 1, 0, 0)
                TopMessage(11617)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Th¶o Tiªn mËt tÞch")
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
    local val = GetTask(1127)
    local L_DzrNum = GetByte(val, 3)
    local L_KillNum = GetByte(val, 4) + 1

    SetTask(1127, SetByte(val, 4, L_KillNum))
    if (L_KillNum >= L_DzrNum) then
        SetTask(1127, SetByte(val, 1, 2))
        TaskNote(1010, 2)
        TopMessage(11623)
        Msg2Player("Hoµn thµnh nhiÖm vô Th¶o Tiªn mËt tÞch, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
    else
        TaskNote(1010, 1, L_KillNum, L_DzrNum)
        TopMessage("Tiªu diÖt Th¶o Tiªn" .. L_KillNum .. "/" .. L_DzrNum .. ".")
        Msg2Player("Tiªu diÖt Th¶o Tiªn" .. L_KillNum .. "/" .. L_DzrNum .. ".")
    end
end

function FPreGoodsNew()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local L_RealNum = HaveNormalItem(3, 146, 0, 0)
    if (L_RealNum < L_ObjectNum) then
        local nProp = math.random(1, 10)
        if (nProp <= 3) then
            AddNormalItemPile(3, 146, 0, 0, 0, 0)
            L_RealNum = L_RealNum + 1
            if (L_RealNum >= L_ObjectNum) then
                TopMessage(11635)
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>Tróc<c>.")
            else
                TopMessage(11636)
                Msg2Player("B¹n nhËn ®­îc 1 Tróc.")
            end
        end
    end
end
