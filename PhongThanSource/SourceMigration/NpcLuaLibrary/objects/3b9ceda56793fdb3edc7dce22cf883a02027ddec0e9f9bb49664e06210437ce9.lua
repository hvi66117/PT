Task_hengcai = 1214;

Task_unending = 1236
Task_wugu1 = 1352;

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
        local i = GetLevel() - 20
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage(14371)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    local wu = GetTask(Task_wugu1)
    if (wu >= 2) and (wu <= 4) and (HaveEventItem(219) < 1) then
        WuGuDropScroll()
    end

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            if (GetByte(GetTask(1209), 1) == 1 and GetByte(GetTask(1209), 2) == 18) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        if (GetTask(888) > 0) and (GetTask(888) < 12) then
            huahui_open_task(w, GetTask(894))
        end

        if (GetByte(GetTask(1209), 1) == 1 and GetByte(GetTask(1209), 2) == 18) then
            NewMonsterTip(w)
        end
    end ;

    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1209), 1) == 0 and HaveNormalItem(6, 1, 354, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 19)

            if (HaveIBBuff(458) > 0) and (GetByte(GetTask(Task_unending), 2) == 2) then
                if (GetByte(GetTask(Task_unending), 3) < 3) then
                    Lrenwu58(px, py)
                end
            end
        end
    end ;

    if (GetTask(955) == 19) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    GetGiftHosr(npcindex)


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

    if (type1 == 19 and count1 > 0) then
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
    elseif (type2 == 19 and count2 > 0) then
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

function huahui_open_task(world, task_target)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(889)
        local param = { 894, math.floor(GetTask(888) / 2) + 1 }
        for i = 1, 4 do
            local t = GetByte(task_target, i)
            local c = GetByte(task_val, i)
            if (t ~= 0) then
                if (t == 19 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt H¾c Phong (" .. c .. "/50)")
                    else
                        ScrollMessage("T×m hoa: hoµn thµnh tiªu diÖt H¾c Phong ")
                    end
                    SetTask(889, SetByte(task_val, i, c))
                end
                param[table.getn(param) + 1] = c
            end
        end
        TaskNote(894, -1)
        pcall(TaskNote, param)
    end
end

Task_HorseGift = 1908
ActivityHorseStart = 107
function GetGiftHosr(npcindex)
    if (GetLevel() < 65) then
        return
    end

    if (ClearHorseTodayTask() <= 0) then
        return
    end

    if (GetTaskBit(Task_HorseGift, 27) == 1 or HaveNormalItem(3, 1225, 0, 0) >= 1 or HaveNormalItem(6, 1, 1079, 1) >= 50) then
        return
    end
    local Mapid, PosX, PosY = GetNpcWorldPos(npcindex)
    local nRandom = math.random(1, 100)
    if (nRandom <= 25) then
        local npcIdx = AddNpc(2167, 65, SubWorld, PosX * 32, PosY * 32)
        if (npcIdx > 0) then
            SetNpcTimer(npcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 120)
        end


    end

end

function ClearHorseTodayTask()
    if (GetGameServerName() == "ÐÛ°ÔÔ¶Õ÷") then
        return 0
    end
    local nYear, nMon, nDay = GetYMD()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    if (nYear == 2014 and nMon == 11 and nDay >= 21 and nDay <= 30) then
        if (GetTaskByte(Task_HorseGift, 3) ~= ActivityHorseStart) then
            SetTask(Task_HorseGift, 0)
            SetTaskBit(Task_HorseGift, 29, 1)
            SetTaskByte(Task_HorseGift, 1, nToday)
            SetTaskByte(Task_HorseGift, 3, ActivityHorseStart)
        else
            local nTaskDay = GetTaskByte(Task_HorseGift, 1)
            if (nTaskDay ~= nToday) then
                SetTaskByte(Task_HorseGift, 4, 0)
                SetTaskByte(Task_HorseGift, 1, nToday)
            end
        end
        return 1
    end
    return 0
end

function no()
    CloseDialog()
end;

function NewMonsterDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 354, 1, 0, 0)
        TopMessage(14395)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 H¾c Phong LÖnh.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1209)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1209, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1209, SetByte(GetTask(1209), 1, 2))
            TaskNote(922, 2)
            TopMessage(14396)
            Msg2Player("Hoµn thµnh nhiÖm vô H¾c Phong LÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(922, 1, KillNum, Num)
            TopMessage("Tiªu diÖt H¾c Phong" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt H¾c Phong" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn H¾c Phong" .. (20 - nums) .. ".")
        TaskNote(50, 1, "H¾c Phong", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = math.random(1, 3)
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                dd2 = dd2 + 1
                SetTask(971, dd2)
                TopMessage(14397)
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", H¾c Phong ®· gi¶i tho¸t" .. dd2 .. ".")
                TaskNote(48, 1, npc_name[d1], dd1, "H¾c Phong", dd2)
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", H¾c Phong ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                dd1 = dd1 + 1
                SetTask(970, dd1)
                TopMessage(14397)
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. H¾c Phong ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "H¾c Phong", dd1, npc_name[d2], dd2)
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. H¾c Phong ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
            end
        end

        if (dd1 >= 3) and (dd2 >= 3) then
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            TaskNote(48, 2)
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
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
            TopMessage(14397)
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. H¾c Phong ®· gi¶i tho¸t" .. dd1 .. ", Quû Ngù ®· gi¶i tho¸t" .. dd2 .. ".")
            TaskNote(81, 1, "H¾c Phong", dd1, "Quû Ngù", dd2)
        else
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. H¾c Phong ®· gi¶i tho¸t" .. dd1 .. ", Quû Ngù ®· gi¶i tho¸t" .. dd2 .. ".")
        end

        if (dd1 >= 3) and (dd2 >= 3) then
            for i = 2, 5 do
                RemoveIBBuff(260 + i)
            end
            Msg2Player("Chiªu Hån ph­ín: th¶ hoµn tÊt, b¹n cã thÓ ®i t×m KhuÈn Nh©n, Chiªu ThÇn")
            SetTask(Task_unending, SetByte(GetByte(val, 1), 2, 3))
            TaskNote(81, 0, "KhuÈn Nh©n", "Chiªu ThÇn")
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
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

function WuGuDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 5) then
        AddEventItem(219)
        TopMessage("B¹n nhËn ®­îc <c=yel>V« ¶nh ThÝch<c>.")
        Msg2Player("B¹n nhËn ®­îc V« ¶nh ThÝch")
    end
end
