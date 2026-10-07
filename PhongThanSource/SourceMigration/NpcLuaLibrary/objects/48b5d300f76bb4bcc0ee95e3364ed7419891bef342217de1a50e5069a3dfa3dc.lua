Task_hengcai = 1214;

Task_xianmo_renwu = 1297
Task_xianmo_npc = 1298
Task_xianmo_npcIndex = 1299
Task_xianmo_npcID = 1300
Task_faery = 1301

TASK_JIANGSHAN = 1426
TASK_JIANGSHAN_THIRD_NOTE = 1439

TASK_CRLH = 1513
TASK_GET_PROBABILITY = 2

npc_name = {
    [45] = "Tö Linh",
    [46] = "T­¬ng LiÔu ThÇn",
    [47] = "HuyÔn Tinh",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

Task_Yibo = 1664

Task_Count = 1665

Boss_Index = 1670
Boss_ID = 1671
IBBuff_Kill = 1246
IBBuff_Boss = 1245

Forbidden_Buff = 1242
Task_CarID = 1667
Task_Carriagenpcidx = 1666

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

YiboTasks = {
    [6] = { taskname = "NhiÖm vô Tæ ®éi s¸t thñ Khæn Tiªn cung tÇng 2", master = { name = "T­¬ng LiÔu ThÇn", id = 30 }, apprentice = { name = "Tö Linh", id = 24 }, boss = { name = "T­¬ng LiÔu Tö ThÇn", id = 1734 } },
}

function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) ~= 2097 then
        local i = GetLevel() - 85
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (npcchr < 0 or npcchr > 7) then
        jsyj_call()
    end

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(858) > 0) then
                liesha_city(w)
            end

            if (HaveIBBuff(360) >= 1) and (w == 48) then
                ogre_field(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(858) > 0) then
            liesha_city(w)
        end

        if (HaveIBBuff(360) >= 1) and (w == 48) then
            ogre_field(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 46)
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (GetByte(GetTask(1014), 1) == 46) then
        if (GetByte(GetTask(1013), 3) == 1) and (w >= 42) and (w <= 51) then
            Frenwu75(x, y)
            GetBookNote3()
        end

    end

    if (mapgid == 46) then
        if (HaveIBBuff(376) > 0) and (GetIBBuffTimes(377) >= 1) then
            Frenwu95()
        end
    end

    if (HaveIBBuff(493) > 0) then
        local xianmo_m = GetByte(GetTask(Task_xianmo_renwu), 3)
        if (xianmo_m == 48) or (xianmo_m == 49) then
            Frenwu110(mapgid, px, py)
        end
    end

    if (GetLevel() >= 96) and (w >= 42) and (w <= 46) then
        if (IsHaveSpaceForTreasure(1) == 0 or GetTaskByte(TASK_CRLH, 1) > 0) then


        else
            if (HaveItemInAllRoom(6, 1, 557, 0, 0, 0, 0) == 0 and GetTaskByte(TASK_CRLH, 4) < 2) then
                local t = math.random(1, 100)

                if (t <= TASK_GET_PROBABILITY) then
                    SetTaskByte(TASK_CRLH, 4, 2)
                    AddNormalItem(6, 1, 557, 0, 0, 0)
                    Msg2Player("B¹n may m¾n nhËn ®­îc ThÎ phï.")
                    TopMessage("B¹n may m¾n nhËn ®­îc ThÎ phï.")

                end

            end

        end

    end

    if (mapgid == 49 and GetTaskByte(Task_Count, 1) == 16 and IsMantlePrentice(PlayerIndex) > 0 and GetNpcID(GetTask(Task_Carriagenpcidx)) == GetTask(Task_CarID) and GetTask(Task_CarID) ~= 0 and GetTaskByte(Task_Count, 1) == 16) then
        if (HaveIBBuff(Forbidden_Buff) == 0) then
            AddIBBuff(Forbidden_Buff)
        end
    end

    if (mapgid == 48 and GetTaskByte(Task_Count, 1) == 6 and IsMantleMaster(PlayerIndex) > 0 and GetTaskByte(Task_Count, 4) <= 1) then
        local teamstate = Team_State()
        if (teamstate == 1) then
            if (GetTaskByte(Task_Count, 4) == 1) then
                local bossindex = GetTask(Boss_Index)
                local bossid = GetTask(Boss_ID)
                if (GetNpcID(bossindex) == bossid and bossindex ~= 0) then
                    local bInArea = Check_BossDistance(bossindex)
                    if (bInArea == 1) then
                        Msg2Player("ÇëÓ¢ÐÛËÙÈ¥ÏûÃðÏàÁøËÀÉñ")
                    end
                else
                    Msg2Team("T­¬ng LiÔu Tö ThÇn b¹n gäi ra ®· biÕn mÊt, nhiÖm vô thÊt b¹i!")
                    SetTaskByte(Task_Count, 4, 2)
                    Set_MateTaskByte(Task_Count, 4, 2)
                end
            else
                local bHave1, bHave2, mateIdx = Have_Baowu()
                if (bHave1 == 0 or bHave2 == 0) then
                    if (IsMantlePrentice(PlayerIndex) == 0) then
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                            PlayerIndex = selfIdx
                        end
                    else
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o<c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
                            PlayerIndex = selfIdx
                        end
                    end
                    return
                end

                local count = GetTaskByte(Task_Count, 2)
                if (count < 50) then
                    count = count + 1
                    SetTaskByte(Task_Count, 2, count)

                    if (count == 50) then
                        if (Get_MateTaskByte(Task_Count, 2) == 30 and HaveIBBuff(IBBuff_Kill) > 0) then

                            callBoss(npcindex)
                        elseif (Get_MateTaskByte(Task_Count, 2) < 30) then

                            ScrollMessage("Phôc Ma Gi¶n ®· kÝch ho¹t, h·y mau ®i thu phôc T­¬ng LiÔu Tö ThÇn")
                            TeamAction("Team_AddBuff", 0, 0, 0)
                        end
                    else
                        ScrollMessage("Phôc Ma TÕ ThÕ: Cßn ph¶i tiªu diÖt T­¬ng LiÔu ThÇn" .. (50 - count) .. ".")
                    end
                else
                    ScrollMessage("Phôc Ma Gi¶n ®· ®­îc kÝch ho¹t, h·y mau ®i thu phôc T­¬ng LiÔu Tö ThÇn")
                end
            end
        elseif (teamstate == 5) then
            Msg2Player("§ång ®éi cña b¹n ®· hñy NhiÖm vô S¸t thñ! Xin vÒ gÆp D­¬ng TiÔn ®Ó huû nhiÖm vô nµy!")
        end
    end

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) == 2097 then
        DelNpc(npcindex)
    end ;

end

function callBoss()
    local id, x, y = GetWorldPos()
    local monsterIndex = AddNpc(1734, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 15)
    SetNpcName(monsterIndex, "T­¬ng LiÔu Tö ThÇn")
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)
    SetTask(Boss_ID, GetNpcID(monsterIndex))
    SetMateTask(Boss_Index, monsterIndex)
    SetMateTask(Boss_ID, GetNpcID(monsterIndex))
    SetTaskByte(Task_Count, 4, 1)
    Set_MateTaskByte(Task_Count, 4, 1)
    Msg2Player("§· dô ra T­¬ng LiÔu Tö ThÇn")
    TopMessage("§· dô ra T­¬ng LiÔu Tö ThÇn")
    TeamAction("Team_AddBuff", IBBuff_Kill, 0, 0)
end

function jsyj_call()
    local js_w, js_x, js_y = GetWorldPos()
    local TASK_JIANGSHAN = 1426
    local TASK_JIANGSHAN_PAGE5_STATUS = 1438
    if (GetTaskByte(TASK_JIANGSHAN, 1) == 2 and GetTaskByte(TASK_JIANGSHAN_PAGE5_STATUS, 4) == 2) then
        local nRandom = math.random(1, 100)
        if (nRandom <= 2) then
            local nNpcID = AddNpc(2097, 85, SubWorld, js_x * 32, js_y * 32, 1)
            if (nNpcID > 0) then

                SetNpcTimer(nNpcID, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            end
        end
    end
end

function Team_AddBuff(buffid)
    if (buffid == IBBuff_Kill) then
        Msg2Player("H·y lËp tøc ®i tiªu diÖt T­¬ng LiÔu Tö ThÇn! B¹n chØ cã 15 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, "T­¬ng LiÔu Tö ThÇn")
        return
    end
    AddIBBuff(IBBuff_Kill)
end

function Team_State()


    if (GetTeamSize() ~= 2) then
        return 2
    end

    if (IsMantleMaster(PlayerIndex) == 0) then
        return 4
    end

    local strName = GetName()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex

    PlayerIndex = mateIdx

    local strMasterName = GetMantleMasterName()
    local taskState = GetTask(Task_Count)

    PlayerIndex = selfIdx

    if (strMasterName ~= strName) then
        return 3
    end

    if (GetTask(Task_Count) ~= 0 and taskState == 0) then
        return 5
    end

    return 1
end

function Get_MateTaskByte(taskid, nByte)
    local oldplayer = PlayerIndex
    local otherindex = Get_MatePlayerIndex()
    PlayerIndex = otherindex
    local value = GetTaskByte(Task_Count, 2)
    PlayerIndex = oldplayer
    return value
end

function Set_MateTaskByte(taskid, nByte, value)
    local oldplayer = PlayerIndex
    local otherindex = Get_MatePlayerIndex()

    PlayerIndex = otherindex
    SetTaskByte(taskid, nByte, value)
    PlayerIndex = oldplayer
end

function Get_MateUUID()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    PlayerIndex = mateIdx
    local mateUUID = GetPlayerID()
    PlayerIndex = selfIdx
    return mateUUID
end

function Get_MatePlayerIndex()
    local prindex = 0
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    return prindex
end

function Get_TeamBuffState()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    local selfCount = GetIBBuffCount()
    PlayerIndex = mateIdx
    local mateCount = GetIBBuffCount()
    PlayerIndex = selfIdx
    if (selfCount < 32 and mateCount < 32) then
        return 1
    elseif (selfCount == 32 and mateCount == 32) then
        return 4
    elseif (selfCount == 32) then
        return 2
    else
        return 3
    end
end

function Have_Baowu()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    local item1 = 0
    local item2 = 0
    if (IsMantlePrentice(PlayerIndex) > 0) then
        item1 = Baowu[2].Item
        item2 = Baowu[1].Item
    else
        item1 = Baowu[1].Item
        item2 = Baowu[2].Item
    end

    local bHaveItem1 = HaveNormalItem(item1[1], item1[2], item1[3], item1[4])
    PlayerIndex = mateIdx
    local bHaveItem2 = HaveNormalItem(item2[1], item2[2], item2[3], item2[4])
    PlayerIndex = selfIdx
    return bHaveItem1, bHaveItem2, mateIdx
end

function Check_BossDistance(bossIdx)
    local nMap, nX, nY = GetNpcWorldPos(bossIdx)
    local pMap, pX, pY = GetWorldPos()

    if (nMap == pMap) then
        if ((nX - pX) ^ 2 + (nY - pY) ^ 2) <= 800 then
            return 1
        end
    end

    return 0
end

function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 858
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 46 and count1 > 0) then
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
    elseif (type2 == 46 and count2 > 0) then
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
        if (46 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " T­¬ng LiÔu ThÇn")
                TaskNote(69, 0, "Khæn Tiªn tÇng 2", "T­¬ng LiÔu ThÇn", count)
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
                TopMessage("Th¶ thµnh c«ng linh hån T­¬ng LiÔu ThÇn")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", T­¬ng LiÔu ThÇn ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "T­¬ng LiÔu ThÇn", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", T­¬ng LiÔu ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån T­¬ng LiÔu ThÇn")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. T­¬ng LiÔu ThÇn ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "T­¬ng LiÔu ThÇn", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. T­¬ng LiÔu ThÇn ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

function Frenwu75(x, y)
    local circle1 = GetByte(GetTask(1013), 3)
    local tgrand = math.random(1, 1000)
    local tgcan1 = GetByte(GetTask(1014), 4)
    local tgadd1 = GetByte(GetTask(1014), 3)
    local tgtime1 = GetByte(GetTask(1014), 2) + 1
    local tglucy = tgcan1 + tgadd1 * (tgtime1 - 1)

    if (tgrand <= tglucy) then
        SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
        SetTask(1014, 0)
        Msg2Player("Thiªn C­¬ng ¶nh thø 1 ®· xuÊt hiÖn!")
        TopMessage(11648)
        TaskNote(53, 1, 1)
        local npcTGIdx = AddNpc(571, 60, SubWorld, x * 32, y * 32)
        SetTask(1017, npcTGIdx)
    else
        SetTask(1014, SetByte(GetTask(1014), 2, tgtime1))
        Msg2Player("Thiªn C­¬ng Tinh t¹m thêi ch­a xuÊt hiÖn, xin tiÕp tôc tiªu diÖt qu¸i vËt ®Ó dô ra Thiªn C­¬ng Tinh.")
    end
end

function Frenwu95()
    local key = GetByte(GetTask(1139), 4)
    if (key == 0) then
        local Lucky_r = math.random(35000001, 35001000) - 35000000
        local line95 = math.floor(GetTask(1141) / 40) * 8 + 8
        local up95 = 30

        if (GetTask(1140) == 2) then
            line95 = math.floor(GetTask(1141) / 20) * 8 + 8
        end

        if (GetTaskByte(1139, 2) > 1) then
            line95 = line95 + 7
            up95 = 60
        end

        if (Lucky_r <= line95) then
            AddIBBuff(377)
            SetTask(1139, SetByte(GetTask(1139), 4, 1))
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 b×nh r­îu quý!")
            TopMessage("BÊt ngê nhËn ®­îc 1 b×nh <c=g>r­îu quý<c>")
            AddGlobalCountNews("Anh hïng thiÕu niªn <c=g>" .. GetName() .. "<c> khi chuyÓn r­îu quý, ®¸nh yªu ma vµ ®o¹t vÒ 1 b×nh <c=r>r­îu quý<c> bÞ chóng lÊy c¾p!", 1)
        elseif (line95 < up95) then
            local kill95 = GetTask(1141) + 1
            SetTask(1141, kill95)
        end
    end
end

function Frenwu110(nm, nx, ny)
    local nums = GetTaskByte(Task_xianmo_npc, 1) + 1
    if (nums > 50) then
        RemoveIBBuff(493)
        return 0
    end

    local px1, py1 = GetTaskWord(Task_faery, 1), GetTaskWord(Task_faery, 2)
    local rv = (nx - px1) ^ 2 + (ny - py1) ^ 2
    if (rv > 400) then
        Msg2Player("C¸c qu¸i vËt bÞ tiªu diÖt kh«ng ë trong ph¹m vi Chó TrËn, kh«ng thÓ thu ®­îc hå ph¸ch.")
        return 0
    end

    local growth = nums * GetTaskByte(Task_xianmo_npc, 3) + GetTaskByte(Task_xianmo_npc, 2)
    local ty = GetTaskByte(Task_xianmo_renwu, 4)
    if (math.random(1, 1000) <= growth) then
        local newNpcName = GetName()
        local npcIdx = 0
        local Newindex = 0
        if (ty == 3) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 756)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=water>" .. newNpcName .. "_Tiªn hån<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                TaskNote(90, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        elseif (ty == 4) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 782)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=yel>" .. newNpcName .. "_Ma ph¸ch<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                TaskNote(91, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        else
            return 0
        end
        SetNpcScript(npcIdx, "\\script\\item\\worldevent\\ÏÉ»êÄ§ÆÇ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\ÏÉ»êÄ§ÆÇ.lua", 300)
        SetNpcName(npcIdx, newNpcName)
        SetTask(Task_xianmo_npcIndex, npcIdx)
        SetTask(Task_xianmo_npcID, math.mod(GetNpcID(npcIdx), 2 ^ 31))
        SetCamp(ty)
        SetNpcCurCamp(npcIdx, ty)

        SetTaskByte(Task_xianmo_renwu, 4, (ty + 2))
        RemoveIBBuff(493)
        AddIBBuff(494)
        SetTaskByte(Task_xianmo_npc, 1, 51)
    else
        SetTaskByte(Task_xianmo_npc, 1, nums)
        growth = math.floor(growth / 10)
        if (math.mod(growth, 10) == 0) then
            Msg2Player("Chó trËn ch­a tô hîp ®ñ c¸c hån ph¸ch, h·y tranh thñ thêi gian!")
        end
        TaskNote(87 + ty, 1)
    end
end

RAND_JS_NOTE = {
    { total = 100, ratio = 3 },
    { total = 100, ratio = 3 },
}
RAND_JS_NOTE_INDEX = 2

function GetBookNote3()

    if (IsHaveSpaceForTreasure(1) > 0) then

        local rand = math.random(1, 100)

        if (GetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1) ~= 1 and GetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1) ~= 2 and GetTaskByte(TASK_JIANGSHAN, 1) == 2) then

            if (rand <= RAND_JS_NOTE[RAND_JS_NOTE_INDEX].ratio) then
                local mapid, x, y = GetWorldPos()

                if (mapid < 47 or mapid > 51) then
                    return
                end

                SetTaskByte(TASK_JIANGSHAN_THIRD_NOTE, 1, 1)
                AddNormalItem(4, 245, 0, 0, 0, 0)

                Msg2Player("Xin chóc mõng, nhËn ®­îc 1 quyÓn Bót Ký 3.")
                TopMessage("NhËn 1 quyÓn <c=yel>Bót Ký 3")
            end

        end

    end

end


