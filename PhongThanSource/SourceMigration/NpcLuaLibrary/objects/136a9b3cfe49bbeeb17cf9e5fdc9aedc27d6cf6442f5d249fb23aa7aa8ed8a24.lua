Task_DeliverCarbon = 1045;
Task_DriveOutNum = 1046;
Task_HelpDoctor = 1099
Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;
Task_wugu2 = 1353;

Task_count = 1349

Task_hengcai = 1214;

TASK_lateral = 1200
TASK_lateral_1 = 1201

npc_name = {
    [8] = "Hoµn CÈu",
    [14] = "Gi¸p Cèt",
    [17] = "Thiªn Ng«",
    [25] = "H¹n Quy",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)

    local wg = GetTask(Task_wugu2)
    if (wg == 2) or (wg == 3) then
        wugu2(npcindex)
    end

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 20
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

            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            if (w == 18) then
                renwu_lateral(w)
            end

            if (GetByte(GetTask(1207), 1) == 1 and GetByte(GetTask(1207), 2) == 13) then
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

        if (w == 18) then
            renwu_lateral(w)
        end

        if (GetByte(GetTask(1207), 1) == 1 and GetByte(GetTask(1207), 2) == 13) then
            NewMonsterTip(w)
        end
    end ;

    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1207), 1) == 0 and HaveNormalItem(6, 1, 353, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (GetPlayerType() < 2) then
        if (GetTask(Task_DeliverCarbon) == 3) then
            if (GetByte(GetTask(Task_DriveOutNum), 2) == 13) then
                FNewquzhu(900, npcindex)
            end
        end
    else
        local L_HelpDoctor = GetTask(Task_HelpDoctor)
        if (GetByte(L_HelpDoctor, 1) == 5) then
            if (GetByte(GetTask(Task_HelpDoctor), 3) == 13) then
                FNewquzhu(1005, npcindex)
            end
        end
    end

    if (GetTask(Task_PrepareMaterial) == 5) then
        if (GetByte(GetTask(Task_PrepareMaterNum), 1) == 13) then
            FPreGoods()
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 14)
        end
    end ;

    if (GetTask(955) == 14) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    processChallenge()

    GetGiftHosr(npcindex)


end

Task_HorseGift = 1908
ActivityHorseStart = 109
function GetGiftHosr(npcindex)
    if (GetLevel() < 65) then
        return
    end

    if (ClearHorseTodayTask() <= 0) then
        return
    end

    if (GetTaskBit(Task_HorseGift, 28) == 1 or HaveNormalItem(3, 1226, 0, 0) >= 1 or HaveNormalItem(6, 1, 1080, 1) >= 50) then
        return
    end

    local mapid, x, y = GetNpcWorldPos(npcindex)
    local npcidx = AddNpc(2116, 1, SubWorld, x * 32, y * 32)
    if npcidx > 0 then
        SetNpcScript(npcidx, "\\script\\npcdeath\\ÂíÉÏÓÐËÄËéÆ¬.lua")
        SetNpcTimer(npcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 10)
        SetNpcTask(npcidx, 1, GetPlayerID())
    end
end

function ClearHorseTodayTask()


    local nYear, nMon, nDay = GetYMD()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    if (nYear == 2015 and nMon == 1 and nDay >= 16 and nDay <= 28) then
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

    if (type1 == 14 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 14 and count2 > 0) then
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

function huahui_open_task(world, task_target)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(889)
        local param = { 894, math.floor(GetTask(888) / 2) + 1 }
        for i = 1, 4 do
            local t = GetByte(task_target, i)
            local c = GetByte(task_val, i)
            if (t ~= 0) then
                if (t == 14 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt Gi¸p Cèt (" .. c .. "/50)")
                    else
                        ScrollMessage("T×m hoa: §· hoµn thµnh tiªu diÖt Gi¸p Cèt")
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

function no()
    CloseDialog()
end;

function renwu_lateral(WorldID)
    local w, x, y = GetWorldPos()
    if (w == WorldID) then
        local val = GetTask(TASK_lateral)
        local val1 = GetTask(TASK_lateral_1)

        if (GetBit(val, 11) == 0) and (GetBit(val, 10) == 1) then
            local count1 = GetByte(val1, 2) - 1
            if (count1 >= 1) then
                SetTask(TASK_lateral_1, SetByte(val1, 2, count1))
                TaskNote(702, 1, count1, GetByte(val1, 3))
                ScrollMessage("V× d©n trõ h¹i: B¹n cßn ph¶i diÖt " .. count1 .. " Gi¸p Cèt")
            elseif (count1 == 0) then
                SetTask(TASK_lateral_1, SetByte(val1, 2, 0))
                TaskNote(702, 1, 0, GetByte(val1, 3))
                ScrollMessage("V× d©n trõ h¹i: hoµn thµnh tiªu diÖt Gi¸p Cèt")
                if (GetByte(val1, 3) == 0) then
                    TaskNote(702, 2)
                end
            end
        end
    end
end

function NewMonsterDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 353, 1, 0, 0)
        TopMessage("B¹n bÊt ngê nhËn ®­îc 1 <c=g>Gi¸p Cèt mËt tÞch<c>.")
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Gi¸p Cèt mËt tÞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1207)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1207, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1207, SetByte(GetTask(1207), 1, 2))
            TaskNote(920, 2)
            TopMessage("Hoµn thµnh tiªu diÖt Gi¸p Cèt, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
            Msg2Player("Hoµn thµnh nhiÖm vô Gi¸p Cèt lÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(920, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Gi¸p Cèt" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Gi¸p Cèt" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Gi¸p Cèt" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Gi¸p Cèt", nums)
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
                SetTask(971, dd2 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Gi¸p Cèt")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Gi¸p Cèt ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Gi¸p Cèt", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Gi¸p Cèt ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Gi¸p Cèt")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Gi¸p Cèt ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Gi¸p Cèt", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Gi¸p Cèt ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
            end
        end

        if (GetTask(971) >= 3) and (GetTask(970) >= 3) then
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            TaskNote(48, 2)
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

function FNewquzhu(note, npcindex)
    local nGoodCount = HaveEventItemCount(191)
    if (nGoodCount >= 5) then
        return 0
    end

    if (HaveIBBuff(335) ~= 0) then
        AddNormalItemPile(4, 191, 0, 1, 0, 0)
        nGoodCount = nGoodCount + 1
        if (nGoodCount >= 5) then
            TaskNote(note, 2)
            TopMessage(11632)
            Msg2Player("Thu thËp ®ñ 5 H¹p ®»ng, trë vÒ phôc mÖnh!")

            RefreshAllNpcTask()

        else
            TopMessage(11633)
            Msg2Player("NhËn ®­îc 1 H¹p ®»ng.")
        end
    end
end

function FPreGoods()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local nRealNum = HaveEventItemCount(196)

    if (nRealNum < L_ObjectNum) then
        local nProp = math.random(1, 10)
        if (nProp <= 5) then
            AddNormalItemPile(4, 196, 0, 1, 0, 0)
            nRealNum = nRealNum + 1
            if (nRealNum >= L_ObjectNum) then
                TopMessage("B¹n ®· thu thËp ®ñ <c=g>D¹ Quang Ch©u")
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>D¹ Quang Ch©u")
            else
                TopMessage("B¹n nhËn ®­îc 1 D¹ Quang Ch©u")
                Msg2Player("B¹n nhËn ®­îc 1 D¹ Quang Ch©u")
            end
        end
    end
end

function wugu2(npcindex)
    local ncount = GetTask(Task_count)
    local wugu = GetTask(Task_wugu2)

    local nWorldID, x, y = GetWorldPos()
    ncount = ncount + 1
    if (ncount < 50) then
        SetTask(1349, ncount)
        ScrollMessage("§éc Cæ: Cßn ph¶i tiªu diÖt Gi¸p Cèt " .. (50 - ncount) .. ".")
    end
    if (wugu == 2) then
        if (ncount == 50) then
            local newnpcidx = AddNpc(897, 25, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B¸ch Niªn Gi¸p Cèt<c>")
            SetNpcScript(newnpcidx, "\\script\\npcdeath\\°ÙÄê¼×¿ÇÈË.lua")
            SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            Msg2Player("B¸ch Niªn Gi¸p Cèt xuÊt hiÖn")
            SetTask(Task_wugu2, 3)
            TaskNote(201, 2)
            SetTask(Task_count, SystemTime())
        end
    elseif (wugu == 3) then
        if (SystemTime() - GetTask(Task_count) > 40) then
            local rate = math.random(1, 3)
            if (rate == 3) then
                local newnpcidx = AddNpc(897, 25, SubWorld, x * 32, y * 32)
                SetNpcName(newnpcidx, "<c=g>B¸ch Niªn Gi¸p Cèt<c>")
                SetNpcScript(newnpcidx, "\\script\\npcdeath\\°ÙÄê¼×¿ÇÈË.lua")
                SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
                Msg2Player("B¸ch Niªn Gi¸p Cèt l¹i xuÊt hiÖn")
                SetTask(Task_count, SystemTime())
            end
        end
    end
end

Task_Challenge_Accept = 1396
Task_Challenge_Enter = 1397
Task_Challenge_Growth = 1398
Task_Challenge_Kill = 1399
Task_Challenge_Begin = 1400

Task_Info_Challenge = 204
Buff_Challenge = 649
Const_Kill_Burst = 4
Const_Kill_Interval = 3

Const_Challenge_Balloon_Begin = 964
Const_Challenge_Balloon_End = 969

Challenge_Burst = {
    { low = 0, high = 30, total = 1000, ratio = 0, balloon = 964, desc = "" },
    { low = 31, high = 50, total = 1000, ratio = 8, balloon = 965, desc = "" },
    { low = 51, high = 70, total = 1000, ratio = 17, balloon = 966, desc = "" },
    { low = 71, high = 90, total = 1000, ratio = 58, balloon = 967, desc = "" },
    { low = 91, high = 100, total = 1000, ratio = 120, balloon = 968, desc = "" },
}

Challenge_Buff = {
    { buffid = 647, total = 1000, ratio = 10, desc = "Ngµn c©n treo sîi tãc" },
    { buffid = 648, total = 1000, ratio = -10, desc = "KhÝ ®Þnh thÇn nhµn" },
    { buffid = 647, total = 1000, ratio = 10, desc = "Ngäc Phong Ch©m" },
    { buffid = 648, total = 1000, ratio = -10, desc = "D­¬ng Chi Lé" },
}

function processChallenge()
    local w, x, y = GetWorldPos()
    if (w ~= 18) then
        return
    end
    local taskDate = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus = GetTaskByte(Task_Challenge_Enter, 4)
    if (taskStatus ~= 1 or HaveIBBuff(Buff_Challenge) == 0) then
        return
    end
    local growth = GetTaskByte(Task_Challenge_Growth, 1)
    local useFill = GetTaskByte(Task_Challenge_Growth, 2)
    local useFillCount = GetTaskByte(Task_Challenge_Growth, 3)
    local preTime = GetTask(Task_Challenge_Kill)
    local localTime = LocalSystemTime()

    local hardBurst = 1000
    if (useFill == 1 and useFillCount < 10) then
        hardBurst = 0
        SetTaskByte(Task_Challenge_Growth, 3, useFillCount + 1)
    end

    local curBurst = 0
    local growthLevel = 1
    local growthLevel2 = 1
    for i = 1, 5 do
        if (growth >= Challenge_Burst[i].low and growth <= Challenge_Burst[i].high) then
            growthLevel = i
            growthLevel2 = i
            if (growth == Challenge_Burst[i].high) then
                growthLevel2 = i + 1
            end
            break
        end
    end
    curBurst = curBurst + Challenge_Burst[growthLevel].ratio
    local buffIdx = 0
    for i = 1, 4 do
        if (HaveIBBuff(Challenge_Buff[i].buffid) > 0) then
            buffIdx = i
            break
        end
    end
    if (buffIdx > 0) then
        curBurst = curBurst + Challenge_Buff[buffIdx].ratio
    end

    local isAdded = 0
    if (hardBurst ~= 0 and growth > Challenge_Burst[1].high) then
        if ((localTime - preTime) < Const_Kill_Interval) then
            isAdded = 1
            curBurst = curBurst + Const_Kill_Burst
        end
    end
    curBurst = (curBurst < 0) and 0 or curBurst
    if (hardBurst == 0) then
        curBurst = 0
    end
    local burstStr = (curBurst == 0) and ("Kh«ng") or (curBurst .. "/1000")

    local rand = math.random(1, 1000)
    if (rand <= curBurst) then

        ClearEffectNpc()
        if (buffIdx > 0) then
            RemoveIBBuff(Challenge_Buff[buffIdx].buffid)
        end
        RemoveIBBuff(Buff_Challenge)
        ClearItem(6, 1, 492, 0)
        ClearItem(6, 1, 493, 0)
        ClearItem(6, 1, 494, 0)
        if (growth >= 60) then
            SetTaskByte(Task_Challenge_Enter, 4, 3)
            TaskNote(Task_Info_Challenge, 2, growth)
            Msg2Player("ThËt tiÕc, KhÝ CÇu cña b¹n ®· bÓ, nh­ng ®é lín KhÝ CÇu ®· ®¹t ®Õn" .. growth .. " §iÓm, vÉn cã thÓ ®Õn gÆp ®¹i phu nhËn th­ëng.")
            TopMessage("KhÝ CÇu cña b¹n bÞ bÓ")
        else
            SetTaskByte(Task_Challenge_Enter, 4, 0)
            TaskNote(Task_Info_Challenge, -1)
            Msg2Player("ThËt tiÕc, KhÝ CÇu cña b¹n ch­a ®¹t 60 ®iÓm ®· bÓ, cuéc thi thÊt b¹i.")
            TopMessage("KhÝ CÇu cña b¹n bÞ bÓ")
        end
        return
    end

    growth = growth + 1
    SetTaskByte(Task_Challenge_Growth, 1, growth)
    SetTask(Task_Challenge_Kill, localTime)
    TaskNote(Task_Info_Challenge, 0, growth, burstStr)

    if (growthLevel ~= growthLevel2 or growth == 100) then
        if (growth == 100) then
            local ballName = GetName() .. "_KhÝ CÇu"

            ModifyEffectNpc(Const_Challenge_Balloon_End)

            SetTaskByte(Task_Challenge_Enter, 4, 2)
            TaskNote(Task_Info_Challenge, 1)
            Msg2Player("Xin chóc mõng, ®é lín KhÝ CÇu cña b¹n ®· ®¹t tèi ®a, mau ®Õn chç ®¹i phu nhËn th­ëng.")
        else

            local ballName = GetName() .. "_KhÝ CÇu"

            ModifyEffectNpc(Challenge_Burst[growthLevel2].balloon)

            Msg2Player("§é lín KhÝ CÇu cña b¹n ®¹t giai ®o¹n thø" .. growthLevel2 .. ", x¸c suÊt bÓ t¨ng lªn.")
        end
    elseif (isAdded == 1) then
        Msg2Player("Tèc ®é giÕt qu¸i qu¸ nhanh lµm t¨ng x¸c suÊt bÓ cña KhÝ CÇu.")
    end

    ScrollMessage("§é lín cña KhÝ CÇu ®· t¨ng ®Õn <c=g>" .. growth .. "<c>")

end


