TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

BUFF_ID = 658

Task_hengcai = 1214;

NationalDay_Info = {

    { nTaskID = { 1731, 1732 }, mapList = { 27, 28, 29, 30, 31 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1136, 0, 0, }, itemName = "V¹n Viªm Ch©u", },
    { nTaskID = { 1731, 1732 }, mapList = { 22, 23, 24, 25, 26 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1134, 0, 0, }, itemName = "HuyÒn Hoang Th¸p", },
    { nTaskID = { 1731, 1732 }, mapList = { 32, 33, 34, 35, 36 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1137, 0, 0, }, itemName = "Tö Yªu LÖnh", },
    { nTaskID = { 1731, 1732 }, mapList = { 37, 38, 39, 40, 41 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1135, 0, 0, }, itemName = "H¶i ThÇn Ch©m", },
}

T_unattack = 1197
TUAtt_nums = 1198

npc_name = {
    [23] = "Ho¶ Ly TiÓu Yªu",
    [29] = "Nham Thó",
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
    local att_pmidx = GetByte(GetTask(T_unattack), 4)

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

            if (HaveIBBuff(360) >= 1) and (w == 28) then
                ogre_field(w)
            end

            if (att_pmidx == w) or (att_pmidx - 100 == w) then
                if (PlayerIndex == oldPlayer) and (att_pmidx == w) then
                    fteam_attack(1, w)
                else
                    fteam_attack(2, w)
                end
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(854) > 0) then
            liesha_city(w)
        end

        if (HaveIBBuff(360) >= 1) and (w == 28) then
            ogre_field(w)
        end

        if (att_pmidx == w) then
            fteam_attack(1, w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 29)
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 27) and (mapgid < 32) then
            Frenwu31()
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)
    end

    if ((mapgid >= 27) and (mapgid <= 31)) then
        js_yjsh(npcindex)
    end

    processJiangshan(mapgid)


end

function js_yjsh(idx)
    if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 2) == 1)) then
        local js_n = GetTaskByte(TASK_JS_BOOK2, 1)

        if ((js_n < 9) and (HaveIBBuff(BUFF_ID) <= 0)) then
            SetTaskByte(TASK_JS_BOOK2, 1, 0)
            TaskNote(1056, 0, 0)
            Msg2Player("Tr¹ng th¸i ký øc biÕn mÊt, lÇn thö nµy thÊt b¹i, cÇn siªu ®é l¹i")
            return
        end

        local item_idx = GetTask(TASK_ITEM_IDX)
        if ((js_n < 9) and ((item_idx == 0) or (GetNpcTask(item_idx, 0) ~= GetPlayerID()))) then
            SetTaskByte(TASK_JS_BOOK2, 1, 0)
            TaskNote(1056, 0, 0)
            Msg2Player(GetName() .. "Lµm l¹i tõ ®Çu, DÉn Hån TrËn ®· biÕn mÊt")
            return
        end

        local map, nx, ny = GetNpcWorldPos(GetTask(TASK_ITEM_IDX))
        local w, x, y = GetNpcWorldPos(idx)
        if ((map ~= w) or ((nx - x) ^ 2 + (ny - y) ^ 2) > 400) then
            if (js_n < 9) then
                Msg2Player("Nham Thó kh«ng ë trong DÉn Hån TrËn")
            end
            return
        end

        local js_rand = math.random(1, 100)
        if ((js_n < 9) and (js_rand < 61)) then
            Msg2Player("Siªu ®é thÊt b¹i, xem ra L­u Ly Tr¶n ®ang mÊt dÇn linh lùc!")
            return
        end

        if (GetTeam() ~= 0) then

            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                if (oldPlayer == PlayerIndex) then
                    jsyj(w)
                else
                    local js_rand = math.random(1, 100)
                    if (js_rand <= 50) then
                        jsyj(w)
                    end
                end
            end

            PlayerIndex = oldPlayer

        else

            jsyj(w)
        end
    end
end

function jsyj(world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 2) == 1) and (HaveIBBuff(BUFF_ID) > 0)) then
        local js_n = GetTaskByte(TASK_JS_BOOK2, 1)
        if (js_n == 8) then
            SetTask(TASK_ITEM_IDX, 0)
            RemoveIBBuff(BUFF_ID)
            SetTaskByte(TASK_JS_BOOK2, 1, 9)
            TopMessage("Nham Thó: D­ Kh¸nh tiÓu nh©n, dïng yªu ph¸p h¹i ta")
            Msg2Player("Siªu ®é Nham Thó hoµn tÊt, lÊy l¹i ký øc, vÒ phôc mÖnh D­ Kh¸nh")
            FinishNpcCollection(7)
            TaskNote(1056, 1)
        elseif (js_n < 8) then
            SetTaskByte(TASK_JS_BOOK2, 1, js_n + 1)
            ScrollMessage("Siªu ®é thµnh c«ng" .. (js_n + 1) .. " Nham Thó")
            Msg2Player("Siªu ®é thµnh c«ng" .. (js_n + 1) .. " Nham Thó")
            TaskNote(1056, 0, js_n + 1)
        end
    end
end

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

    if (type1 == 29 and count1 > 0) then
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
    elseif (type2 == 29 and count2 > 0) then
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

function ogre_field(WorldID)
    local mapid = GetByte(GetTask(1077), 2)
    local w, x, y = GetWorldPos()
    if (WorldID == mapid) and (w == WorldID) then
        local kind = GetByte(GetTask(1077), 1)
        if (29 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " Nham Thó")
                TaskNote(69, 0, "Hiªn Viªn tÇng 2", "Nham Thó", count)
            else
                RemoveIBBuff(360)
                SetTask(1078, 0)
                TaskNote(69, 1)
                ScrollMessage("Trõ ma: Hoµn thµnh")
            end
        end
    end
end

function no()
    CloseDialog()
end;

function fteam_attack(key, world)
    if (GetLevel() < 60) or (IsTongMember() <= 0) then
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w == world) then
        local att_pmidx = GetByte(GetTask(T_unattack), 4)
        if (att_pmidx == world) then
            local nums = GetTask(TUAtt_nums) + 1
            if (key == 1) then
                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, "Hiªn Viªn tÇng 2", nums, 30000)
            else


                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, "Hiªn Viªn tÇng 2", nums, 30000)


            end

            if (nums >= 30000) then
                SetTask(T_unattack, SetByte(GetTask(T_unattack), 4, 100 + att_pmidx))
                ScrollMessage("Hé §¹o: <c=g>hoµn thµnh nhiÖm vô<c>")
                TaskNote(72, 1)
            end

            if (math.mod(nums, 2000) == 0) then
                fteam_luckbuff()
            end
        end
    end
end

function fteam_luckbuff()
    local fteam_list = {
        [1] = { 120, 1, 2, 90 },
        [2] = { 100, 1, 2, 90 },
        [3] = { 80, 1, 2, 80 },
        [4] = { 60, 1, 2, 70 },
    }
    local lvl = GetLevel()
    for i = 1, 4 do
        if (lvl >= fteam_list[i][1]) then
            local r = math.random(1, 100)
            local nb = fteam_list[i][2]
            if (r > fteam_list[i][4]) then
                nb = fteam_list[i][3]
            end

            for i = 1, nb do
                AddIBBuff(1157)
            end
            ScrollMessage("Hé §¹o: NhËn ®­îc <c=yel>Hµng Ma LÖnh<c>")
            break
        end
    end
end

function Frenwu31()
    if (GetTask(55) ~= 25) then
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
                TopMessage("May m¾n nhËn ®­îc 1 Háa Linh")
                AddNormalItemPile(3, 25, 1, 0, 0, 0)
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
                TopMessage("Th¶ thµnh c«ng linh hån cña Nham Thó")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Nham Thó ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Nham Thó", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Nham Thó ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña Nham Thó")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Nham Thó ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Nham Thó", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Nham Thó ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

TASK_JIANGSHAN_ONE_TWO = 1475
TASK_JIANGSHAN_ONE_TWO_INFO = 1081

CONST_JS_XIANGSHU = {
    { name = "Th­ hµng cña B¨ng Linh", boss = "B¨ng Linh B¨ng Xuyªn", item = { 4, 258, 0, 1 } },
    { name = "Th­ hµng cña Nham Thó", boss = "Nham Thó Hiªn Viªn §éng", item = { 4, 259, 0, 1 } },
}

CONST_JS_DROP_RAND = {
    { name = "X¸c suÊt thÊp", total = 1000, ratio = 1, fakebyte = 1, fakecount = 30 },
    { name = "X¸c suÊt cao", total = 1000, ratio = 30, fakebyte = 2, fakecount = 100 },
}
MonsterKillCountTask = 1897

function processJiangshan(mapgid)

    local taskStatus = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1)
    local bossIndex = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 2)

    if (taskStatus ~= 1 or bossIndex ~= 2) then
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







































































































