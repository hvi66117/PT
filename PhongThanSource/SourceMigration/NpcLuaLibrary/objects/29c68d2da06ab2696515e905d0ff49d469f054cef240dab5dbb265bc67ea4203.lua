Task_star = 1417

Task_hengcai = 1214;

star_dream = 1419

star_dream2 = 1607

npc_name = {
    [20] = "Vâ Quy",
    [22] = "Háa Ng­",
}

mapname = {
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong ThÇn",
    [25] = "Lôc Ch©u",
    [26] = "Sa M¹c chÕt",
    [27] = "Hiªn Viªn tÇng 1",
    [28] = "Hiªn Viªn tÇng 2",
    [29] = "Hiªn Viªn tÇng 3",
    [30] = "Hiªn Viªn tÇng 4",
    [31] = "Hiªn Viªn tÇng 5",
    [32] = "Ngäc TuyÒn",
    [33] = "TuyÕt Cèc",
    [34] = "§¹i Phong",
    [35] = "§¹i Th¹ch",
    [36] = "B¨ng Xuyªn Cùc",
    [37] = "Thñy Vùc",
    [38] = "Long Cung",
    [39] = "H¶i C©u",
    [40] = "Long Vùc",
    [41] = "Long Uyªn",
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
        local i = GetLevel() - 40
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

            if (GetTask(854) > 0) then
                liesha_city(w)
            end

            if (GetTask(897) == 20) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)
                end
            end

            local mapid2, x2, y2 = GetWorldPos()
            if (mapgid == mapid2) then
                processJiangshan(npcindex)
            end

        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(854) > 0) then
            liesha_city(w)
        end

        processJiangshan(npcindex, mapgid)

    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 20)
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 37) and (mapgid < 42) then
            Frenwu31()
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)
    end

    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 0) then
        chuewujin()
    end

    processJiangshanNote(npcindex, mapgid)

    if (GetTaskByte(star_dream, 1) == 3 and HaveIBBuff(660) > 0 and HaveItemInAllRoom(4, 246, 0, 1, 0, 0, 0) == 0) then
        StarDream(npcindex)
    end


end

function StarDream(npcidx)
    local wushiguiIdx = GetTask(star_dream2)
    if (wushiguiIdx > 0 and GetPlayerID() == GetNpcTask(wushiguiIdx, 2)) then
        return
    end

    local killNum = GetTaskByte(star_dream, 2)
    if (killNum < 31) then
        killNum = killNum + 1
        SetTaskByte(star_dream, 2, killNum)
    end

    local rate = 20
    if (killNum > 10 and killNum < 21) then
        rate = 40
    elseif (killNum > 20 and killNum < 31) then
        rate = 60
    elseif (killNum > 30) then
        rate = 100
    end

    if (math.random(1, 100) <= rate) then
        local _, x, y = GetNpcWorldPos(npcidx)
        local idx = AddNpc(990, 40, SubWorld, x * 32, y * 32)
        local PID = GetPlayerID()
        if (idx ~= 0) then
            Msg2Player("¶o c¶nh Vâ Quy ®· xuÊt hiÖn")
            SetNpcTask(idx, 1, 1)
            SetNpcTask(idx, 2, PID)
            local mtimes = 600
            if (mtimes > GetIBBuffLeftTimes(660)) then
                mtimes = GetIBBuffLeftTimes(660)
            end
            SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", mtimes)
            ScrollMessage("¶o c¶nh Vâ Quy ®· xuÊt hiÖn")
            SetTask(star_dream2, idx)
        else
            ScrollMessage("Thªm ¶o c¶nh Vâ Quy thÊt b¹i!")
        end

    else
        ScrollMessage("¶o c¶nh Vâ Quy vÉn ch­a xuÊt hiÖn, h·y tiÕp tôc cè g¾ng!")
    end

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
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Vâ Quy!")
                if (math.mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Vâ Quy!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Vâ Quy!")
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

    local task_id = 854
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 20 and count1 > 0) then
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
    elseif (type2 == 20 and count2 > 0) then
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

function Frenwu31()
    if (GetTask(55) ~= 24) then
        return 0
    end

    local r_sx = math.random(1, 100)
    local plvl = GetLevel()
    local item_four = {
        [1] = { 50, 30 },
        [2] = { 90, 20 },
        [3] = { 120, 25 },
        [4] = { 300, 30 },
    }
    for i = 1, 4 do
        if (plvl <= item_four[i][1]) then
            if (r_sx <= item_four[i][2]) then
                TopMessage("May m¾n nhËn ®­îc 1 Thñy Hån")
                AddNormalItemPile(3, 24, 1, 0, 0, 0)
            end
            return 0
        end
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
                TopMessage("Th¶ thµnh c«ng linh hån cña Vâ Quy")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Vâ sÜ H¹n Quy ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Vâ Quy", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Vâ sÜ H¹n Quy ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña Vâ Quy")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Vâ sÜ H¹n Quy ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Vâ Quy", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Vâ sÜ H¹n Quy ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

function Frenwu65(mapgid)
    local gmapIdx1 = GetByte(GetTask(1022), 1)
    if (gmapIdx1 == mapgid) then
        local guanKey = math.mod((gmapIdx1 - 22), 5) + 1

        if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then
            local level_add = { 20, 20, 15, 15, 10 }
            local mgshu = GetByte(GetTask(1022), 2) + 1
            local sgzxs = level_add[guanKey]
            local r_Luck = math.random(1, 1000)

            if (r_Luck <= (sgzxs * mgshu)) then
                if (guanKey == 5) then
                    SetTask(1022, 0)
                    RemoveIBBuff(305 + gmapIdx1 - 22)
                    AddIBBuff(305 + gmapIdx1 - 21)
                    TaskNote(54, 2)
                    Msg2Player("Chóc mõng! B¹n ®· gi¶i phãng ®­îc c¸c tinh linh trong mª cung! Mau quay vÒ phôc mÖnh!")
                    TopMessage("Th«ng qua Tø Linh, v­ît qua cöa kh¶o nghiÖm thø <c=g>" .. guanKey .. "<c>.")
                else
                    if (guanKey > 1) then
                        RemoveIBBuff(305 + gmapIdx1 - 22)
                    end
                    AddIBBuff(305 + gmapIdx1 - 21)
                    SetTask(1022, SetByte(GetTask(1022), 1, (gmapIdx1 + 1)))
                    SetTask(1022, SetByte(GetTask(1022), 2, 0))

                    local mw0 = mapname[gmapIdx1]
                    local mw1 = mapname[(gmapIdx1 + 1)]
                    Msg2Player("Chóc mõng b¹n ®· phãng thÝch thµnh c«ng" .. mw0 .. "Tø Tinh trong mª cung, b¹n cã thÓ vµo" .. mw1 .. "mª cung tiÕp theo gi¶i cøu Tø tinh cao cÊp h¬n!")
                    TopMessage("Th«ng qua Tø Linh, v­ît qua cöa kh¶o nghiÖm thø <c=g>" .. guanKey .. "<c>.")
                    TaskNote(54, 1, mw0, mw1)
                end
            else
                SetTask(1022, SetByte(GetTask(1022), 2, mgshu))

                if (guanKey == 5) then
                    if (SuanMingBuffTime(mapgid, GetLevel()) == 1) then
                        SetTask(1022, 0)
                        RemoveIBBuff(305 + gmapIdx1 - 22)
                        AddIBBuff(305 + gmapIdx1 - 21)
                        TaskNote(54, 2)
                        Msg2Player("Chóc mõng! B¹n ®· gi¶i phãng ®­îc c¸c tinh linh trong mª cung! Mau quay vÒ phôc mÖnh!")
                        TopMessage("Th«ng qua Tø Linh, v­ît qua cöa kh¶o nghiÖm thø <c=g>" .. guanKey .. "<c>.")
                    end
                end

            end
        end
    else
        local mw0 = mapname[gmapIdx1]
        Msg2Player("Ng­¬i cÇn ph¶i ®Õn" .. mw0 .. "§Ó gi¶i cøu Tø T­îng Tinh Linh! Thêi gian rÊt gÊp! Xin h·y nhanh chãng khëi hµnh!")
    end
end

function SuanMingBuffTime(gmapIdx1, plvl)
    if (gmapIdx1 < 22) or (gmapIdx1 > 41) then
        return 0
    end

    local nkey = 0
    map_idx = {
        [1] = { 331, 326, 327, 328 },
        [2] = { 351, 342, 343, 344 },
        [3] = { 352, 345, 346, 347 },
        [4] = { 353, 348, 349, 350 }
    }
    local gmapIdx2 = math.floor((gmapIdx1 - 22) / 5) + 1
    local lvl = 4
    if (plvl < 100) then
        if (plvl >= 95) then
            lvl = 3
        elseif (plvl >= 65) then
            lvl = math.floor((plvl - 55) / 10)
        end
    end

    if (GetIBBuffLeftTimes(map_idx[gmapIdx2][lvl]) < 10) then
        nkey = 1
    end
    return nkey
end

function suanming(gmapIdx1, plvl)
    if (gmapIdx1 < 22) or (gmapIdx1 > 41) then
        return 0
    end

    local nkey = 0
    map_idx = {
        [1] = { 331, 326, 327, 328 },
        [2] = { 351, 342, 343, 344 },
        [3] = { 352, 345, 346, 347 },
        [4] = { 353, 348, 349, 350 }
    }
    local gmapIdx2 = math.floor((gmapIdx1 - 22) / 5) + 1
    local lvl = 4
    if (plvl < 100) then
        if (plvl >= 95) then
            lvl = 3
        elseif (plvl >= 65) then
            lvl = math.floor((plvl - 55) / 10)
        end
    end

    if (HaveIBBuff(map_idx[gmapIdx2][lvl]) > 0) then
        nkey = 1
    end
    return nkey
end

function chuewujin()
    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 0) then
        local rand = math.random(1, 100)
        if (rand > 15) then
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Msg2Player("Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ lÊy [H¹t H¶i T©m Th¶o]")
            return
        end

        Msg2Player("§­îc h¹t H¶i T©m Th¶o.")
        TopMessage("§­îc h¹t H¶i T©m Th¶o")
        AddNormalItem(6, 1, 512, 0, 0, 0)
        SetTaskByte(Task_star, 3, 1)
    end
end

TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

RAND_JS_NOTE = {
    { total = 100, ratio = 2, desc = "Bót Ký 1" },
    { total = 100, ratio = 3, desc = "Bót Ký 2" },
}

RAND_JS_NOTE_INDEX = 2

function processJiangshanNote(npcindex, mapgid)
    if ((HaveIBBuff(293) >= 1) and (mapgid >= 37) and (mapgid <= 42) and (GetTask(55) == 24)) then
    else
        return 0
    end
    if (GetLevel() < 40) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    if (mainStatus > 0 or oneStep > 0) then
        return 0
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local rand = math.random(1, 100)
    if (rand <= RAND_JS_NOTE[RAND_JS_NOTE_INDEX].ratio) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1, 2)
        AddNormalItem(4, 244, 0, 0, 0, 0)
        TaskNote(Task_Info_JIANGSHAN_TWO, 0)
        TopMessage("NhËn <c=yel>Bót Ký 2")
        Msg2Player("NhËn Bót Ký 2, xem trªn ®ã viÕt g×.")
    end
end

function processJiangshan(npcindex)
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    if (mainStatus > 0 or oneStep ~= 3 or page2Step ~= 1) then
        return 0
    end
    local twoStepStatus = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3)
    if (twoStepStatus ~= 1) then
        return 0
    end
    local killCount = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4)
    killCount = killCount + 1
    SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4, killCount)
    if (killCount >= 50) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3, 2)
        TaskNote(Task_Info_JIANGSHAN_TWO, 2)
        FinishNpcCollection(4)
        TopMessage("Vâ Quy: Anh hïng dòng m·nh kh«ng kÐm D­ t­íng qu©n n¨m x­a")
        Msg2Player("Xin chóc mõng, tõ Vâ Quy ®· chøng thùc ®­îc sù anh dòng cña D­ Kh¸nh n¨m x­a, cã thÓ vÒ TriÒu Ca phôc mÖnh D­ Kh¸nh.")
    else
        TaskNote(Task_Info_JIANGSHAN_TWO, 1, killCount)
        ScrollMessage("Giang S¬n Y Cùu: Hµng phôc" .. killCount .. "Vâ Quy")
    end
end

NationalDay_Info = {

    { nTaskID = { 1731, 1732 }, mapList = { 27, 28, 29, 30, 31 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1136, 0, 0, }, itemName = "V¹n Viªm Ch©u", },
    { nTaskID = { 1731, 1732 }, mapList = { 22, 23, 24, 25, 26 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1134, 0, 0, }, itemName = "HuyÒn Hoang Th¸p", },
    { nTaskID = { 1731, 1732 }, mapList = { 32, 33, 34, 35, 36 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1137, 0, 0, }, itemName = "Tö Yªu LÖnh", },
    { nTaskID = { 1731, 1732 }, mapList = { 37, 38, 39, 40, 41 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1135, 0, 0, }, itemName = "H¶i ThÇn Ch©m", },
}

function NationalDay_Activity()
    local nYear, nMonth, nDay = GetYMD()
    local mapID, nX, nY = GetWorldPos()

    for i = 1, table.getn(NationalDay_Info) do
        local taskInfo = NationalDay_Info[i]
        local mapList = taskInfo.mapList
        for j = 1, table.getn(mapList) do
            if (mapID == mapList[j]) then
                local nRand = math.random(1, 100)
                local nTaskDay = GetTaskByte(taskInfo.nTaskID[1], i)
                local nFlopItem = GetTaskByte(taskInfo.nTaskID[2], i)

                if (IsHaveSpaceForTreasure(2) == 0) then
                    Msg2Player("Hµnh trang ®· ®Çy")
                    ScrollMessage("Hµnh trang ®· ®Çy")
                    return 0
                end

                if (nDay ~= nTaskDay and nRand <= taskInfo.upperLimit[j][1]) then
                    AddNormalItem(taskInfo.itemInfo[1], taskInfo.itemInfo[2], taskInfo.itemInfo[3], taskInfo.itemInfo[4], 0, 0)
                    SetTaskByte(taskInfo.nTaskID[1], i, nDay)
                    SetTaskByte(taskInfo.nTaskID[2], i, 1)
                    Msg2Player("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    ScrollMessage("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    WriteLog(GetName() .. "NhËn ®­îc 1" .. taskInfo.itemName)
                elseif (nDay == nTaskDay and nFlopItem == 1 and nRand <= taskInfo.upperLimit[j][2]) then
                    AddNormalItem(taskInfo.itemInfo[1], taskInfo.itemInfo[2], taskInfo.itemInfo[3], taskInfo.itemInfo[4], 0, 0)
                    SetTaskByte(taskInfo.nTaskID[2], i, nFlopItem + 1)
                    Msg2Player("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    ScrollMessage("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    WriteLog(GetName() .. "NhËn ®­îc 1" .. taskInfo.itemName)
                end
                return 0
            end
        end
    end
end







































































































