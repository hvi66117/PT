Task_hengcai = 1214;

TASK_lateral = 1200
TASK_lateral_1 = 1201
TASK_lateral_2 = 1202
TASK_lateral_3 = 1203

build_renwu = 1255
build_npcIdx = 1256
build_nums = 1258
build_var_up = 80

Task_Mischief = 1357

hanguiID = 24
tianwuID = 16

task_Tree = 1315
task_TreeNpcIndex = 1316
task_TreeNpcId = 1318

npc_name = {
    [13] = "Hång S¸t",
    [14] = "Gi¸p Cèt",
    [16] = "Quû Ngù",
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

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 30
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

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            if (GetTask(897) == 17) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)
                end
            end

            if (w == 17) or (w == 18) or (w == 65) then
                renwu_lateral(w)
            end
        end
        PlayerIndex = oldPlayer

        if (w == 17) and (GetLevel() >= 35) then
            local buildkey = GetByte(GetTask(build_renwu), 4)
            if (buildkey == 2) then
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

        if (w == 17) or (w == 18) or (w == 65) then
            renwu_lateral(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 17)
        end
    end ;

    if (GetTask(955) == 17) and (GetTask(956) < 40) then
        Frenwu18()
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (checkTeamCondition() == 1) then
        judge_Tree()
    end

    local process = GetTaskByte(Task_Mischief, 1)
    local tianwuCount = GetTaskByte(Task_Mischief, 4)
    if (process == 4 and GetMorphType() == 24 and tianwuCount < 30) then
        tianwuCount = tianwuCount + 1
        SetTaskByte(Task_Mischief, 4, tianwuCount)
        ScrollMessage(" ®· tiªu diÖt " .. tianwuCount .. "/30 Thiªn Ng«")
        if (tianwuCount == 30) then
            ScrollMessage("Tiªu diÖt thµnh c«ng Thiªn Ng«")
            Msg2Player("Tiªu diÖt thµnh c«ng Thiªn Ng«, cã thÓ vÒ b¸o c«ng råi!")
            TaskNote(1035, 4)
        end
    end

    processChallenge()

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
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Thiªn Ng«!")
                if (math.mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Thiªn Ng«!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Thiªn Ng«!")
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

    if (type1 == 17 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 17 and count2 > 0) then
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
                if (t == 17 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt Thiªn Ng« (" .. c .. "/50)")
                    else
                        ScrollMessage("§· hoµn thµnh nhiÖm vô T×m hoa: tiªu diÖt Thiªn Ng«!")
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
        local val3 = GetTask(TASK_lateral_3)

        if (WorldID == 18) then
            if (GetBit(val, 20) == 1) and (GetBit(val, 21) == 0) then
                if (HaveNormalItem(3, 214, 0, 0) == 0) then
                    local xin_drop = math.random(1, 100)
                    if (xin_drop <= 5) then
                        AddNormalItemPile(3, 214, 0, 0, 0, 0)
                        Msg2Player("B¹n nhËn ®­îc 1 Thiªn Ng« T©m [Lôc]!")
                        TopMessage(14372)
                        if (HaveNormalItem(3, 213, 0, 0) == 0) then
                            TaskNote(706, 3)
                        else
                            TaskNote(706, 4)
                        end
                    end
                end
            end
            return 0
        elseif (WorldID == 17) then
            if (GetBit(val, 20) == 1) and (GetBit(val, 21) == 0) then
                if (HaveNormalItem(3, 213, 0, 0) == 0) then
                    local xin_drop = math.random(1, 100)
                    if (xin_drop <= 2) then
                        AddNormalItemPile(3, 213, 0, 0, 0, 0)
                        Msg2Player("B¹n nhËn ®­îc 1 Thiªn Ng« T©m [§en]!")
                        TopMessage(14373)
                        if (HaveNormalItem(3, 214, 0, 0) == 0) then
                            TaskNote(706, 2)
                        else
                            TaskNote(706, 4)
                        end
                    end
                end
            end
            return 0
        elseif (WorldID == 65) then
            local zhu_drop = math.random(1, 100)
            if (GetBit(val, 15) == 1) and (GetBit(val, 17) == 0) and (GetBit(val, 16) == 1) then
                if (zhu_drop <= 30) then
                    if (HaveNormalItem(3, 212, 0, 0) < 29) then
                        AddNormalItemPile(3, 212, 0, 0, 0, 0)
                        TopMessage(14374)
                    elseif (HaveNormalItem(3, 212, 0, 0) < 30) then
                        AddNormalItemPile(3, 212, 0, 0, 0, 0)
                        TopMessage(14375)
                        Msg2Player("DiÖt cá tËn gèc: §· hoµn thµnh nhiÖm vô thu thËp Lôc Ch©u!")
                        if (HaveNormalItem(3, 211, 0, 0) >= 30) then
                            TaskNote(705, 1)
                        end
                    end
                end
            end

            if (GetBit(val, 18) == 0) and (HaveNormalItem(6, 1, 347, 0) == 0) then
                local kill_n = GetTask(1443) + 1
                local ratedp = 0
                if (kill_n <= 20) then
                    ratedp = math.random(1, 100)
                elseif (kill_n <= 40) then
                    ratedp = math.random(1, 33)
                else
                    ratedp = math.random(1, 20)
                end
                if (ratedp == 1) then
                    AddNormalItemPile(6, 1, 347, 0, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc 1 Thiªn Ng« T©m [§á]!")
                    TopMessage(14376)
                end
                SetTask(1443, kill_n)
            end
            return 0
        end
    end
end

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 40) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Thiªn Ng«" .. (40 - nums) .. ".")
        TaskNote(50, 4, nums)
    elseif (nums == 40) then
        SetTask(956, 41)
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
                TopMessage(14377)
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Thiªn Ng« ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Thiªn Ng«", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Thiªn Ng« ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage(14377)
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Thiªn Ng« ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Thiªn Ng«", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Thiªn Ng« ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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


