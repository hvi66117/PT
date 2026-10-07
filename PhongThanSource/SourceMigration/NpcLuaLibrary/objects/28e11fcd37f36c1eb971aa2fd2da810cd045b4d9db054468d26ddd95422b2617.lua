Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;

Task_hengcai = 1214;

Task_unending = 1236

build_renwu = 1255
build_npcIdx = 1256
build_nums = 1258
build_var_up = 80

task_Tree = 1315
task_TreeNpcIndex = 1316
task_TreeNpcId = 1318

Task_wugu1 = 1352;

Task_Divination = 1375

Task_Label_Type = 1376
Buff_Make_Drug = 636
Buff_Add_Life = 635
Buff_Polymorph = 404
Buff_Plutus = 228
Task_Num = 1039

npc_name = {
    [12] = "Cèt Tinh",
    [13] = "Hång S¸t",
    [16] = "Quû Ngù",
    [17] = "Thiªn Ng«",
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
        local i = GetLevel() - 25
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage(14371)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (GetTaskByte(Task_Divination, 1) == 3 and HaveEventItem(231) < 1) then
        gatherGhost()
    end

    local wu = GetTask(Task_wugu1)
    if (wu >= 2) and (wu <= 4) and (HaveEventItem(220) < 1) then
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

            if (GetTask(897) == 16) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)
                end
            end

            if (GetByte(GetTask(1208), 1) == 1 and GetByte(GetTask(1208), 2) == 15) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer

        if (w == 17) and (GetLevel() >= 35) then
            local buildkey = GetByte(GetTask(build_renwu), 4)
            if (buildkey == 1) or (buildkey == 2) then
                if (SystemTime() <= (GetTask(build_nums) + 1800)) then
                    frenwu35(buildkey)
                else
                    SetTask(build_renwu, SetByte(GetTask(build_renwu), 4, 0))
                end
            end
        end
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        if (GetTask(888) > 0) and (GetTask(888) < 12) then
            huahui_open_task(w, GetTask(894))
        end

        if (GetByte(GetTask(1208), 1) == 1 and GetByte(GetTask(1208), 2) == 15) then
            NewMonsterTip(w)
        end
    end ;

    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1208), 1) == 0 and HaveNormalItem(6, 1, 355, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (GetTask(Task_PrepareMaterial) == 9) then
        if (GetByte(GetTask(Task_PrepareMaterNum), 1) == 15) then
            FPreGoods()
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 16)

            if (HaveIBBuff(458) > 0) and (GetByte(GetTask(Task_unending), 2) == 2) then
                if (GetByte(GetTask(Task_unending), 4) < 3) then
                    Lrenwu58(px, py)
                end
            end
        end
    end ;

    if (GetTask(955) == 16) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (checkTeamCondition() == 1) then
        judge_Tree()
    end

    GetGiftHosr(npcindex)


end

function gatherGhost()
    local step = GetTaskByte(Task_Divination, 1)
    local ghostNum = HaveEventItem(231)
    local killNum = GetTaskByte(Task_Divination, 4)
    killNum = killNum + 1

    if (killNum < 255) then
        SetTaskByte(Task_Divination, 4, killNum)
    elseif (killNum == 255) then
        SetTaskByte(Task_Divination, 4, 21)
    end

    local r = math.random(1, 100)
    local flag = 0
    if (step == 3 and ghostNum < 1) then
        if (killNum <= 10) then
            if (r >= 1 and r <= 5) then
                flag = 1
            end
        elseif (killNum <= 20) then
            if (r >= 1 and r <= 10) then
                flag = 1
            end
        elseif (killNum > 20) then
            if (r >= 0 and r <= 30) then
                flag = 1
            end
        end
    end

    if (flag == 1) then
        AddEventItem(231)
        SetTaskByte(Task_Divination, 3, 1)
        TopMessage("H¸i ®­îc 1 U Minh Th¶o")
        Msg2Player("H¸i ®­îc 1 U Minh Th¶o")
    end
end

function judge_Tree()


    local oldPlayer = PlayerIndex

    for i = 1, 3 do

        PlayerIndex = GetTeamMember(i)

        local npcindex = GetTask(task_TreeNpcIndex)
        local npcid = GetTask(task_TreeNpcId)
        local playerID = GetNpcTask(npcindex, 2)
        if (GetTaskByte(task_Tree, 2) == 2) and (npcid ~= 0) and (GetNpcID(npcindex) == npcid) and (playerID == GetPlayerID()) then

            local nGrowRank = GetNpcTask(npcindex, 0)
            nGrowRank = nGrowRank + 1

            if (nGrowRank <= 100) then

                SetNpcTask(npcindex, 0, nGrowRank)

                if (nGrowRank == 100) then

                    local nNpcWorldID, nNpcX, nNpcY = GetNpcWorldPos(npcindex)

                    SetNpcName(npcindex, "<c=g>" .. GetName() .. "<c>,")
                    NpcPolyMorph(npcindex, 816)
                    ScrollMessage("MÇm c©y cña b¹n ®· thµnh c©y xanh")
                    Msg2Player("MÇm c©y cña b¹n ®· thµnh c©y xanh<HyperLinkWorldPos=\"Î÷Æç[17," .. math.floor(nNpcX / 8) .. "," .. math.floor(nNpcY / 16) .. "]\">")
                    TaskNote(1029, 2)

                else

                    ScrollMessage("MÇm c©y cña b¹n ®· tr­ëng thµnh, hiÖn ®é tr­ëng thµnh cña MÇm c©y lµ" .. nGrowRank .. " / 100")
                    Msg2Player("MÇm c©y cña b¹n ®· tr­ëng thµnh, hiÖn ®é tr­ëng thµnh cña MÇm c©y lµ" .. nGrowRank .. " / 100")
                    TaskNote(1029, 1, nGrowRank)

                end

                SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 3600)

            else

                if (GetNpcTask(npcindex, 1) == 0) then
                    Msg2Player("MÇm c©y cña b¹n ®· lín thµnh c©y xanh!")
                end

            end

        end

    end

    PlayerIndex = oldPlayer

end

function checkTeamCondition()

    if (GetTeam() == 0) then
        return 0
    end

    if (GetTeamSize() ~= 3) then
        return 0
    end

    local oldPlayer = PlayerIndex
    local membercount = GetTeamSize()

    local careerAry = { [0] = 0, [1] = 0, [2] = 0 }

    local TaskCount = 0

    for i = 1, membercount do

        PlayerIndex = GetTeamMember(i)
        local nWorldID, nX, nY = GetWorldPos()

        if (nWorldID == 17) and (GetLevel() >= 30) then
            careerAry[GetSeries()] = 1
        end

        if (GetTaskByte(task_Tree, 2) == 2) then
            TaskCount = TaskCount + 1
        end

    end
    PlayerIndex = oldPlayer

    if (TaskCount <= 0) then
        return 0
    end

    local nSeriseCount = 0
    for i = 0, 2 do
        if (careerAry[i] ~= 0) then
            nSeriseCount = nSeriseCount + 1
        end
    end

    if (nSeriseCount >= 3) then
        return 1
    end

    return 0
end

function judge_relation()
    local mark = -1
    if (GetTeam() ~= 0) then
        if (GetTeamSize() == 2) then
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end

            if (IsMasterPRRelation(n) == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                mark = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = -1
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function mission_PR(world, masterindex)
    local count = GetTask(898)
    local mark = HaveIBBuff(215)
    local w, x, y = GetWorldPos()
    if (world == w) then
        if (mark ~= 0) then
            if (count > 1) then
                SetTask(898, count - 1)
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Quû Ngù!")
                if (math.mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Quû Ngù!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Quû Ngù!")
            end
        else
            if (count > 0) then
                Msg2Player("Trõ Yªu: Vßng s¸ng trõ yªu biÕn mÊt, nhiÖm vô Trõ yªu thÊt b¹i.")
            end
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

    if (type1 == 16 and count1 > 0) then
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
    elseif (type2 == 16 and count2 > 0) then
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
                if (t == 16 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt Quû Ngù (" .. c .. "/50)")
                    else
                        ScrollMessage("T×m hoa: §· hoµn thµnh tiªu diÖt Quû Ngù.")
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

function NewMonsterDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 2) then
        AddNormalItem(6, 1, 355, 1, 0, 0)
        TopMessage(14390)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Quû Ngù mËt tÞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1208)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1208, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1208, SetByte(GetTask(1208), 1, 2))
            TaskNote(924, 2)
            TopMessage(14391)
            Msg2Player("Hoµn thµnh nhiÖm vô Quû Ngù lÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(924, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Quû Ngù" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Quû Ngù" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Quû Ngù " .. (20 - nums) .. ".")
        TaskNote(50, 1, "Quû Ngù", nums)
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
                TopMessage(14392)
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Quû Ngù ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Quû Ngù", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Quû Ngù ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage(14392)
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Quû Ngù ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Quû Ngù", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Quû Ngù ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

function Lrenwu58(px, py)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = math.random(1, 3)
        local val = GetTask(Task_unending)
        local dd1 = GetByte(val, 3)
        local dd2 = GetByte(val, 4)

        if (p ~= 2) then
            dd2 = dd2 + 1
            SetTask(Task_unending, SetByte(val, 4, dd2))
            TopMessage(14392)
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

function FPreGoods()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local nRealNum = HaveEventItemCount(200)
    if (nRealNum < L_ObjectNum) then
        local nProp = math.random(1, 10)
        if (nProp <= 1) then
            AddNormalItemPile(4, 200, 0, 1, 0, 0)
            nRealNum = nRealNum + 1
            if (nRealNum >= L_ObjectNum) then
                TopMessage(14393)
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>Cæ")
            else
                TopMessage(14394)
                Msg2Player("B¹n nhËn ®­îc 1 Cæ")
            end
        else
            Msg2Player("Anh hïng ch­a cãc <c=g>Ng­u B× Cæ")
        end
    end
end

function frenwu35(key)
    local idx = GetTask(build_npcIdx)
    local oldPlayer = PlayerIndex
    local PlayerIndex1 = GetTeamMember(1)
    PlayerIndex = PlayerIndex1
    if (idx ~= GetTask(build_npcIdx)) then
        PlayerIndex = oldPlayer
        Msg2Player("§éi tr­ëng hiÖn t¹i kh«ng ph¶i lµ b»ng h÷u mµ b¹n muèn gióp!")
        return 0
    end
    PlayerIndex = oldPlayer

    local idx = key + 235
    AddNormalItemPile(3, idx, 0, 0, 0, 0)
    local itemname = { "Chuyªn Th¹ch", "H¹t Gièng" }
    local nums = HaveNormalItem(3, idx, 0, 0)
    if (nums >= build_var_up) then
        nums = math.mod((nums - build_var_up), build_var_up / 4)
        if (nums == 0) then
            ScrollMessage("T×m ®ñ nguyªn liÖu cã thÓ vÒ phôc mÖnh")
            local pname = GetName()
            PlayerIndex = PlayerIndex1
            ScrollMessage(pname .. "T×m ®­îc kh«ng Ýt råi, ®Ó anh ta vÒ giao nép")
            PlayerIndex = oldPlayer
        end
    else
        ScrollMessage("B¹n nhËn ®­îc <c=g>" .. itemname[key])
    end
end

function WuGuDropScroll()
    local nProp = math.random(1, 100)
    if (nProp <= 8) then
        AddEventItem(220)
        Msg2Player("B¹n nhËn ®­îc Quû Hå L«")
        TopMessage("B¹n nhËn ®­îc <c=yel>Quû Hå L«<c>.")
    end
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

