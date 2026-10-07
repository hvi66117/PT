Task_hengcai = 1214;

Task_unending = 1236

Task_renwu20 = 1377

npc_name = {
    [11] = "Cæ §iªu",
    [13] = "Hång S¸t",
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
                TopMessage(14371)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        local duanwu_nums = 0

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            if (GetByte(GetTask(1204), 1) == 1 and GetByte(GetTask(1204), 2) == 10) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        if (GetByte(GetTask(1204), 1) == 1 and GetByte(GetTask(1204), 2) == 10) then
            NewMonsterTip(w)
        end
    end ;

    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1204), 1) == 0 and HaveNormalItem(6, 1, 350, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (GetTask(955) == 11) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (HaveIBBuff(632) > 0) and (GetTaskByte(Task_renwu20, 2) == 1) then
        Frenwu20()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            if (HaveIBBuff(458) > 0) and (GetByte(GetTask(Task_unending), 2) == 1) then
                if (GetByte(GetTask(Task_unending), 3) < 3) then
                    Lrenwu58(px, py)
                end
            end
        end
    end ;
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

    if (type1 == 11 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    elseif (type2 == 11 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    end
end

function no()
    CloseDialog()
end;

function NewMonsterDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 350, 1, 0, 0)
        TopMessage(14387)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Cæ §iªu mËt tÞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1204)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1204, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1204, SetByte(GetTask(1204), 1, 2))
            TaskNote(925, 2)
            TopMessage(14388)
            Msg2Player("Hoµn thµnh nhiÖm vô Cæ §iªu lÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(925, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Cæ §iªu" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Cæ §iªu" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Cæ §iªu" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Cæ §iªu", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu20()
    local nums = GetTaskByte(Task_renwu20, 3) + 1

    if (nums < 5) then
        SetTaskByte(Task_renwu20, 3, nums)
        ScrollMessage("Hång Loan Tinh §éng: Xin tiÕp tôc s¨n Cæ §iªu.")
        TaskNote(202, 2)
    elseif (nums >= 5) then

        SetTaskByte(Task_renwu20, 3, 21)
        SetTaskByte(Task_renwu20, 2, 2)
        if (DelNormalItem(6, 1, 474, 0) == 0) then
            DelNormalItemInQuick(6, 1, 474, 0)
        end
        RemoveIBBuff(632)
        AddEventItem(229)
        ScrollMessage("NhËn ®­îc <c=yel>Tö Linh Minh Ch©u<c>")
        Msg2Player("T×m ®­îc Tö Linh Minh Ch©u, ®i t×m V¨n Th¸i S­ ë §ång Quan.")
        TaskNote(202, 3)
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

function Lrenwu58(px, py)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = math.random(1, 3)
        local val = GetTask(Task_unending)
        local dd1 = GetByte(val, 3)
        local dd2 = GetByte(val, 4)

        if (p ~= 2) then
            dd1 = dd1 + 1
            SetTask(Task_unending, SetByte(val, 3, dd1))
            TopMessage(14389)
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Cæ §iªu ®· gi¶i tho¸t" .. dd1 .. ", Hång S¸t ®· gi¶i tho¸t" .. dd2 .. ".")
            TaskNote(81, 1, "Cæ §iªu", dd1, "Hång S¸t", dd2)
        else
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Cæ §iªu ®· gi¶i tho¸t" .. dd1 .. ", Hång S¸t ®· gi¶i tho¸t" .. dd2 .. ".")
        end

        if (dd1 >= 3) and (dd2 >= 3) then
            for i = 2, 5 do
                RemoveIBBuff(260 + i)
            end
            Msg2Player("Chiªu Hån ph­ín: th¶ hoµn tÊt, b¹n cã thÓ ®i t×m H¾c Phong, Quû Ngù")
            SetTask(Task_unending, SetByte(GetByte(val, 1), 2, 2))
            TaskNote(81, 0, "H¾c Phong", "Quû Ngù")
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
end
