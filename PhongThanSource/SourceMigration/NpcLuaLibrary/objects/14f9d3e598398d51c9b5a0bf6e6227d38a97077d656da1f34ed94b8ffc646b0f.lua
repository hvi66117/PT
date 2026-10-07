Task_hengcai = 1214;

Task_zhongqiu = 1558

Gloal_zhongqiu_num = 257
TaskNote_zhongqiu = 1103

npc_name = {
    [12] = "Cèt Tinh",
    [16] = "Quû Ngù",
    [19] = "H¾c Phong",
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

            if (GetByte(GetTask(1205), 1) == 1 and GetByte(GetTask(1205), 2) == 11) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        if (GetByte(GetTask(1205), 1) == 1 and GetByte(GetTask(1205), 2) == 11) then
            NewMonsterTip(w)
        end
    end ;

    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1205), 1) == 0 and HaveNormalItem(6, 1, 351, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (GetTask(955) == 12) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) >= 1) then
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

    if (type1 == 12 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 12 and count2 > 0) then
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

function NewMonsterDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 351, 1, 0, 0)
        TopMessage("B¹n bÊt ngê nhËn ®­îc 1 <c=g>Cèt Tinh mËt tÞch<c>.")
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Cèt Tinh mËt tÞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1205)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1205, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1205, SetByte(GetTask(1205), 1, 2))
            TaskNote(919, 2)
            TopMessage("Hoµn thµnh tiªu diÖt Cèt Tinh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
            Msg2Player("Hoµn thµnh nv MËt TÞch Cèt Tinh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(919, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Cèt Tinh" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Cèt Tinh" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Cèt Tinh" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Cèt Tinh", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu42()
    if (GetTask(936) < 5) then
        local r = math.random(1, 10000)
        local zyCNums = GetByte(GetTask(938), 4) + 1
        local key = 0
        if (zyCNums == 1) and (r <= 100) then
            key = 1
        elseif (zyCNums == 2) and (r >= 100) and (r <= 110) then
            key = 1
        elseif (zyCNums >= 3) and (r == 5000) then
            key = 1
        end
        if (key == 1) then
            AddNormalItemPile(3, 103, 1, 0, 0, 0)
            TopMessage(11646)
            SetTask(938, SetByte(GetTask(938), 4, zyCNums))
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
