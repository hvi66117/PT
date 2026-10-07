TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

Task_hengcai = 1214;

Task_Variety_Process = 1389

npc_name = {
    [28] = "B¨ng Linh",
    [33] = "Phi Gi¸p",
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
        local i = GetLevel() - 50
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

            if (GetTask(897) == 28) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)
                end
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(854) > 0) then
            liesha_city(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 28)
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 32) and (mapgid < 37) then
            Frenwu31()
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)
    end

    local m_step = GetTaskByte(Task_Variety_Process, 1)
    if (m_step == 17 or m_step == 18) then
        ProcessVariety(m_step)
    end

    if ((mapgid >= 32) and (mapgid <= 36)) then
        if (GetTeam() ~= 0) then

            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)

                if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 3) == 1)) then
                    jsyj(mapgid)
                end
            end

            PlayerIndex = oldPlayer

        else

            if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 3) == 1)) then
                jsyj(mapgid)
            end
        end
    end

    processJiangshan(mapgid)


end

function jsyj(world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    local js_n = GetTaskByte(TASK_JS_COUNT, 1)
    if (js_n == 49) then
        SetTaskByte(TASK_JS_COUNT, 1, 50)
        TopMessage("B¨ng Linh: Xin anh hïng tha m¹ng!")
        Msg2Player("§· chøng thùc sù anh dòng cña D­ Kh¸nh n¨m x­a khi tiªu diÖt B¨ng Linh, vÒ phôc mÖnh D­ Kh¸nh")
        FinishNpcCollection(12)
        TaskNote(1057, 1)
    elseif (js_n < 49) then
        SetTaskByte(TASK_JS_COUNT, 1, js_n + 1)
        ScrollMessage("Giang S¬n Y Cùu: Hµng phôc" .. (js_n + 1) .. " B¨ng Linh")
        TaskNote(1057, 0, js_n + 1)
    end
end

function ProcessVariety(step)
    if (step == 17) then
        if (math.random(1, 100) <= 50) then
            ScrollMessage("B¨ng Linh kh«ng dÔ hµng phôc, ph¶i t×m c¸ch kh¸c vËy")
            Msg2Player("§i t×m Kh­¬ng Tö Nha, cã thÓ «ng ta sÏ cã c¸ch hµng B¨ng Linh")
            SetTaskByte(Task_Variety_Process, 1, 18)
            TaskNote(1047, 1)
        end
    else
        ScrollMessage("B¨ng Linh kh«ng dÔ hµng phôc, ph¶i t×m c¸ch kh¸c vËy")
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
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "B¨ng Linh!")
                if (math.mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "B¨ng Linh!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt B¨ng Linh!")
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

    if (type1 == 28 and count1 > 0) then
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
    elseif (type2 == 28 and count2 > 0) then
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
    if (GetTask(55) ~= 23) then
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
                TopMessage("May m¾n nhËn ®­îc 1 Phong LÖ")
                AddNormalItemPile(3, 23, 1, 0, 0, 0)
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
                TopMessage("Gi¶i tho¸t linh hån B¨ng Linh thµnh c«ng")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", B¨ng Linh ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "B¨ng Linh", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", B¨ng Linh ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Gi¶i tho¸t linh hån B¨ng Linh thµnh c«ng")
                Msg2Player("Chiªu Hån ph­ín: Th¶ thµnh c«ng! B¨ng Linh ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "B¨ng Linh", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: Th¶ thÊt b¹i! B¨ng Linh ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
            local level_add = { 20, 20, 15, 15, 15 }
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

TASK_JIANGSHAN_ONE_TWO = 1475
TASK_JIANGSHAN_ONE_TWO_INFO = 1081

CONST_JS_XIANGSHU = {
    { name = "Th­ hµng cña B¨ng Linh", boss = "B¨ng Linh B¨ng Xuyªn", item = { 4, 258, 0, 1 } },
    { name = "Th­ hµng cña Háa Ma", boss = "Háa Ma Hiªn Viªn §éng", item = { 4, 259, 0, 1 } },
}

CONST_JS_DROP_RAND = {
    { name = "X¸c suÊt thÊp", total = 1000, ratio = 1, fakebyte = 1, fakecount = 30 },
    { name = "X¸c suÊt cao", total = 1000, ratio = 30, fakebyte = 2, fakecount = 100 },
}
MonsterKillCountTask = 1897

function processJiangshan(mapgid)

    local taskStatus = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1)
    local bossIndex = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 2)

    if (taskStatus ~= 1 or bossIndex ~= 1) then
        return
    end
    local class, detail, particular, level = myunpack(CONST_JS_XIANGSHU[bossIndex].item)
    local haveItem = HaveNormalItem(class, detail, particular, level)
    if (haveItem == 0) then
        return
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local randIndex = 1
    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        local gmapIdx1 = GetByte(GetTask(1022), 1)
        if (gmapIdx1 == mapgid) then
            local guanKey = math.mod((gmapIdx1 - 22), 5) + 1
            if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then

                randIndex = 2
            end
        end
    end
    if (randIndex == 1) then
        if (GetLevel() < 55) then
            return
        end
    end

    local rand = math.random(1, CONST_JS_DROP_RAND[randIndex].total)
    if (rand <= CONST_JS_DROP_RAND[randIndex].ratio) then
        DelNormalItem(class, detail, particular, level)
        SetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1, 2)
        AddNormalItem(4, 260, 0, 1, 0, 0)
        TaskNote(TASK_JIANGSHAN_ONE_TWO_INFO, 1)
        TopMessage("NhËn 1 <c=yel>Hµng biÓu")
        Msg2Player("NhËn 1 Hµng biÓu, cã thÓ ®­a cho D­ Kh¸nh ë TriÒu Ca.")
        SetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[1].fakebyte, 0)
        SetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[2].fakebyte, 0)
    else
        local nKillCount = GetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[randIndex].fakebyte) + 1
        SetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[randIndex].fakebyte, nKillCount)
        if (nKillCount >= CONST_JS_DROP_RAND[randIndex].fakecount) then
            DelNormalItem(class, detail, particular, level)
            SetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1, 2)
            AddNormalItem(4, 260, 0, 1, 0, 0)
            TaskNote(TASK_JIANGSHAN_ONE_TWO_INFO, 1)
            TopMessage("NhËn 1 <c=yel>Hµng biÓu")
            Msg2Player("NhËn 1 Hµng biÓu, cã thÓ ®­a cho D­ Kh¸nh ë TriÒu Ca.")
            SetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[1].fakebyte, 0)
            SetTaskByte(MonsterKillCountTask, CONST_JS_DROP_RAND[2].fakebyte, 0)
        end
    end


end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
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







































































































