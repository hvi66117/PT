Task_hengcai = 1214;

TASK_CRLH = 1513
TASK_GET_PROBABILITY = 2

npc_name = {
    [38] = "Quû §¨ng",
    [40] = "Lam qu¸i",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

Task_Yibo = 1664

Task_Count = 1665

Boss_Index = 1670
Boss_ID = 1671
IBBuff_Kill = 1246
IBBuff_Boss = 1245

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

YiboTasks = {
    [2] = { taskname = "NhiÖm vô S¸t thñ BÝch Du cung tÇng 1", master = { name = "Quû §¨ng", id = 38 }, apprentice = { name = "Lam qu¸i", id = 40 }, boss = { name = "Quû L©n §¨ng", id = 30 } },
}

function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 60
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

            if (GetTask(856) > 0) then
                liesha_city(w)
            end
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(856) > 0) then
            liesha_city(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 38)
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
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

    if (mapgid == 42 and GetTaskByte(Task_Count, 1) == 2 and IsMantlePrentice(PlayerIndex) > 0 and GetTaskByte(Task_Count, 4) <= 1) then
        local teamstate = Team_State()
        if (teamstate == 1) then
            if (GetTaskByte(Task_Count, 4) == 1) then
                local bossindex = GetTask(Boss_Index)
                local bossid = GetTask(Boss_ID)
                if (GetNpcID(bossindex) == bossid and bossindex ~= 0) then
                    local bInArea = Check_BossDistance(bossindex)
                    if (bInArea == 1) then
                        Msg2Player("Xin anh hïng h·y cÊp tèc ®i tiªu diÖt Quû L©n §¨ng")
                    end
                else
                    Msg2Team("Quû L©n §¨ng ®· biÕn mÊt, lµm l¹i tõ ®Çu!")
                    SetTaskByte(Task_Count, 4, 0)
                    SetTaskByte(Task_Count, 2, 0)
                    Set_MateTaskByte(Task_Count, 4, 0)
                    Set_MateTaskByte(Task_Count, 2, 0)
                end
            else
                local bHave1, bHave2, mateIdx = Have_Baowu()
                if (bHave1 == 0 or bHave2 == 0) then
                    if (IsMantlePrentice(PlayerIndex) == 0) then
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("Trªn ng­êi c¸c ng­¬i kh«ng mang theo ph¸p b¶o hµng yªu <c=yel>Phôc Ma Gi¶n<c> cïng <c=yel>Hµng Yªu Lôc<c>, phôc ma kh«ng cã hiÖu qu¶")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> trªn ng­êi kh«ng cã ph¸p b¶o hµng yªu <c=yel>Phôc Ma Gi¶n<c>, phôc ma kh«ng cã hiÖu qu¶")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Hµng Yªu Lôc<c>, phôc ma kh«ng cã hiÖu qu¶")
                            PlayerIndex = selfIdx
                        end
                    else
                        if (bHave1 == 0 and bHave2 == 0) then
                            Msg2Team("Trªn ng­êi c¸c ng­¬i kh«ng mang theo ph¸p b¶o hµng yªu <c=yel>Phôc Ma Gi¶n<c> cïng <c=yel>Hµng Yªu Lôc<c>, phôc ma kh«ng cã hiÖu qu¶")
                        elseif (bHave1 == 0) then
                            Msg2Team("<c=g>" .. GetName() .. "<c> trªn ng­êi kh«ng cã ph¸p b¶o hµng yªu <c=yel>Hµng Yªu Lôc<c>, phôc ma kh«ng cã hiÖu qu¶")
                        elseif (bHave2 == 0) then
                            local selfIdx = PlayerIndex
                            PlayerIndex = mateIdx
                            Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Phôc Ma Gi¶n<c>, phôc ma kh«ng cã hiÖu qu¶")
                            PlayerIndex = selfIdx
                        end
                    end
                    return
                end
                local count = GetTaskByte(Task_Count, 2)
                if (count < 30) then
                    count = count + 1
                    SetTaskByte(Task_Count, 2, count)
                    if (count == 30) then
                        if (Get_MateTaskByte(Task_Count, 2) == 50 and HaveIBBuff(IBBuff_Kill) > 0) then

                            callBoss(npcindex)
                        elseif (Get_MateTaskByte(Task_Count, 2) < 50) then

                            ScrollMessage("Hµng Yªu Lôc ®· kÝch ho¹t, mau ®i thu phôc Quû L©n §¨ng")
                            TeamAction("Team_AddBuff", 0, 0, 0)
                        end
                    else
                        ScrollMessage("Phôc Ma TÕ ThÕ: Cßn cÇn tiªu diÖt ¹íµÆ" .. (30 - count) .. ".")
                    end
                else
                    ScrollMessage("Hµng Yªu Lôc ®· kÝch ho¹t, mau ®i thu phôc Quû L©n §¨ng")
                end
            end
        elseif (teamstate == 5) then
            Msg2Player("§ång ®éi ®· hñy nhiÖm vô, xin vÒ gÆp D­¬ng TiÔn ®Ó hñy nhiÖm vô, sau ®ã nhËn l¹i nhiÖm vô nµy!")
        end
    end

end

function callBoss()
    local id, x, y = GetWorldPos()
    local monsterIndex = AddNpc(1730, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 15)
    SetNpcName(monsterIndex, "Quû L©n §¨ng")
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)
    SetTask(Boss_ID, GetNpcID(monsterIndex))
    SetMateTask(Boss_Index, monsterIndex)
    SetMateTask(Boss_ID, GetNpcID(monsterIndex))
    SetTaskByte(Task_Count, 4, 1)
    Set_MateTaskByte(Task_Count, 4, 1)
    Msg2Player("§· dô ra Quû L©n §¨ng")
    TopMessage("§· dô ra Quû L©n §¨ng")
    TeamAction("Team_AddBuff", IBBuff_Kill, 0, 0)
end

function Team_AddBuff(buffid)
    if (buffid == IBBuff_Kill) then
        Msg2Player("H·y lËp tøc ®i tiªu diÖt Quû L©n §¨ng! B¹n chØ cã 10 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, "Quû L©n §¨ng")
        return
    end
    AddIBBuff(IBBuff_Kill)
end

function Team_State()


    if (GetTeamSize() ~= 2) then
        return 2
    end

    if (IsMantleMaster(PlayerIndex) > 0) then
        return 4
    end

    local strName = GetName()
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex

    PlayerIndex = mateIdx
    local strMasterName = GetName()
    local taskState = GetTask(Task_Count)

    PlayerIndex = selfIdx
    if (strMasterName ~= GetMantleMasterName()) then
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

    local task_id = 856
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 38 and count1 > 0) then
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
    elseif (type2 == 38 and count2 > 0) then
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
                TopMessage("Th¶ thµnh c«ng linh hån Quû §¨ng")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Quû §¨ng ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Quû §¨ng", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Quû §¨ng ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Quû §¨ng")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Quû §¨ng ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Quû §¨ng", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Quû §¨ng ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
