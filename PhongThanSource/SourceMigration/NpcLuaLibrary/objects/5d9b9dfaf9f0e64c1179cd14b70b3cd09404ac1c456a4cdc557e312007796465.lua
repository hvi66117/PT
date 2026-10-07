require("¸ß¼¶³ýÄ§ÎÀ³Ç.luax")
MonsterOnDeath = NEWMONSTERTASK.MonsterOnDeath

TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433
TASK_ITEM_IDX = 1434
TASK_JS_HX_TIME = 1435
TASK_JS_DIST = 1436
TASK_JS_COUNT = 1437

Task_hengcai = 1214;

T_unattack = 1197
TUAtt_nums = 1198

TASK_CRLH = 1513
TASK_GET_PROBABILITY = 2

Task_Yibo = 1664

Task_Count = 1665

IBBuff_Kill = 1246
IBBuff_Boss = 1245

Boss_Index = 1670
Boss_ID = 1671
Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

YiboTasks = {
    [3] = { taskname = "BÝch Du Cung¶þ²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "L«i Tr¹ch thÇn", id = 40 }, apprentice = { name = "Lam qu¸i", id = 42 }, boss = { name = "L«i Tr¹ch Yªu", id = 1731 } },
    [5] = { taskname = "BÝch Du CungÈý²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "Vò La ThÇn", id = 42 }, apprentice = { name = "L«i Tr¹ch thÇn", id = 44 }, boss = { name = "Vò Tr¹ch ThÇn La", id = 1733 } },
}

npc_name = {
    [40] = "Lam qu¸i",
    [41] = "Tr­êng Thõa ThÇn",
    [42] = "L«i Tr¹ch thÇn",
    [44] = "Vò La ThÇn",
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

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) ~= 2093 then
        local i = GetLevel() - 70
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

            if (HaveIBBuff(360) >= 1) and (w == 43) then
                ogre_field(w)
            end

            MonsterOnDeath(npcindex)

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


        if (GetTask(856) > 0) then
            liesha_city(w)
        end

        MonsterOnDeath(npcindex)

        if (HaveIBBuff(360) >= 1) and (w == 43) then
            ogre_field(w)
        end

        if (att_pmidx == w) then
            fteam_attack(1, w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 42)
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

    if (GetByte(GetTask(1014), 1) == 42) and (w >= 42) and (w <= 51) then
        if (GetByte(GetTask(1013), 3) == 1) then
            Frenwu75(x, y)
        end
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)
    end

    if ((mapgid >= 27) and (mapgid <= 31)) then
        if (npcchr >= 0) and (npcchr <= 7) then
            if (GetTeam() ~= 0) then

                local oldPlayer = PlayerIndex
                local membercount = GetTeamSize()

                for i = 1, membercount do
                    PlayerIndex = GetTeamMember(i)

                    if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 2) == 8)) then
                        jsyj(mapgid)
                    end
                end

                PlayerIndex = oldPlayer

            else

                if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 2) == 8)) then
                    jsyj(mapgid)
                end

            end

        else
            if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 2) == 8)) then
                jsyj_call(mapgid)
            end

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

    if (mapgid == 43 and GetTaskByte(Task_Count, 1) == 3 and GetTaskByte(Task_Count, 4) <= 1 and IsMantleMaster(PlayerIndex) > 0) then
        Do_Hunttask(GetTaskByte(Task_Count, 1), 2)
    end
    if (mapgid == 44 and GetTaskByte(Task_Count, 1) == 5 and GetTaskByte(Task_Count, 4) <= 1 and IsMantlePrentice(PlayerIndex) > 0) then
        Do_Hunttask(GetTaskByte(Task_Count, 1), 1)
    end

    if (npcchr >= 0) and (npcchr <= 7) and GetNpcTemplateID(npcindex) == 2093 then
        DelNpc(npcindex)
    end ;

end

function Do_Hunttask(tasknum, bShifu)
    local tBossInfo = 0
    tBossInfo = YiboTasks[tasknum].boss
    local tHuntTargetInfo = 0
    local nHuntCount = 0
    local nHuntCount2 = 0
    local strBaowu = ""
    if (bShifu == 2) then
        nHuntCount = 50
        nHuntCount2 = 30
        strBaowu = "Phôc Ma Gi¶n"
        tHuntTargetInfo = YiboTasks[tasknum].master
    else
        nHuntCount = 30
        nHuntCount2 = 50
        strBaowu = "Hµng Yªu Lôc"
        tHuntTargetInfo = YiboTasks[tasknum].apprentice
    end
    local teamstate = Team_State(bShifu)

    if (teamstate == 1) then
        if (GetTaskByte(Task_Count, 4) == 1) then
            local bossindex = GetTask(Boss_Index)
            local bossid = GetTask(Boss_ID)
            if (GetNpcID(bossindex) == bossid) then
                local bInArea = Check_BossDistance(bossindex)
                if (bInArea == 1) then
                    Msg2Player("ÇëÓ¢ÐÛËÙÈ¥½µ·þ" .. tBossInfo.name)
                end
            else
                Msg2Team("B¹n gäi ra " .. tBossInfo.name .. " ®· biÕn mÊt, nhiÖm vô thÊt b¹i!")
                SetTaskByte(Task_Count, 4, 2)
                Set_MateTaskByte(Task_Count, 4, 2)
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
            if (count < nHuntCount) then
                count = count + 1
                SetTaskByte(Task_Count, 2, count)
                if (count == nHuntCount) then
                    if (Get_MateTaskByte(Task_Count, 2) == nHuntCount2 and HaveIBBuff(IBBuff_Kill) > 0) then

                        callBoss(tasknum)

                    elseif (Get_MateTaskByte(Task_Count, 2) < nHuntCount2) then

                        ScrollMessage(strBaowu .. " ®· kÝch ho¹t, mau ®i thu phôc " .. tBossInfo.name)
                        TeamAction("Team_AddBuff", 0, 0, 0)
                    end
                else
                    ScrollMessage("Phôc Ma TÕ ThÕ: Cßn ph¶i tiªu diÖt " .. tHuntTargetInfo.name .. (nHuntCount - count) .. ".")
                end
            else
                ScrollMessage(strBaowu .. " ®· kÝch ho¹t, mau ®i thu phôc " .. tBossInfo.name)
            end
        end
    elseif (teamstate == 5) then
        Msg2Player("§ång ®éi cña b¹n ®· hñy nhiÖm vô, xin vÒ gÆp D­¬ng TiÔn ®Ó hñy nhiÖm vô nµy!")
    end
end

function callBoss(tasknum)
    local bossInfo = 0
    bossInfo = YiboTasks[tasknum].boss
    local id, x, y = GetWorldPos()
    local monsterIndex = AddNpc(bossInfo.id, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 15 * 60)
    SetNpcName(monsterIndex, bossInfo.name)
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)
    SetTask(Boss_ID, GetNpcID(monsterIndex))
    SetMateTask(Boss_Index, monsterIndex)
    SetMateTask(Boss_ID, GetNpcID(monsterIndex))
    SetTaskByte(Task_Count, 4, 1)
    Set_MateTaskByte(Task_Count, 4, 1)
    Msg2Team("§· dô ra " .. bossInfo.name)
    TopMessage("§· dô ra " .. bossInfo.name)
    TeamAction("Team_AddBuff", IBBuff_Kill, 0, 0)
end

function Team_AddBuff(buffid)
    if (buffid == IBBuff_Kill) then
        local taskNum = GetTaskByte(Task_Count, 1)
        local bossInfo = YiboTasks[taskNum].boss
        Msg2Player("H·y mau ®i tiªu diÖt " .. bossInfo.name .. "! B¹n chØ cã 15 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, bossInfo.name)
        return
    end
    AddIBBuff(IBBuff_Kill)
end

function Team_State(nType)


    if (GetTeamSize() ~= 2) then
        return 2
    end
    if (nType == 2) then
        if (IsMantleMaster(PlayerIndex) == 0) then
            return 4
        end

        local strName = GetName()
        local mateIdx = 0
        local selfIdx = PlayerIndex
        if (IsCaptain() == 0) then
            mateIdx = GetTeamMember(1)
        else
            mateIdx = GetTeamMember(2)
        end

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
    else
        if (IsMantlePrentice(PlayerIndex) == 0) then
            return 4
        end

        local mateIdx = 0
        local selfIdx = PlayerIndex
        if (IsCaptain() == 0) then
            mateIdx = GetTeamMember(1)
        else
            mateIdx = GetTeamMember(2)
        end

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

function jsyj_call(world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    if (HaveIBBuff(315) > 0) then
        local nRandom = math.random(1, 100)
        if (nRandom <= 2) then
            local nNpcID = AddNpc(2093, 70, SubWorld, js_x * 32, js_y * 32, 1)
            if (nNpcID > 0) then

                SetNpcTimer(nNpcID, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            end
        end
    end
end

function jsyj(world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    if (HaveIBBuff(315) > 0) then
        SetTaskByte(TASK_JS_BOOK2, 2, 9)
        FinishNpcCollection(11)
        TopMessage("Ta muèn biÕt ai ®· b¸n ®øng ta.")
        Msg2Player("T×m ®­îc ký øc siªu ®é L«i Tr¹ch ThÇn, ®i b¸o víi D­ Kh¸nh.")
        TaskNote(1056, 9)
    else
        Msg2Player("Ta nªn xem chóng nh­ Tø T­îng Tinh Linh Èn")

    end
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

    if (type1 == 42 and count1 > 0) then
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
    elseif (type2 == 42 and count2 > 0) then
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
        if (42 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " L«i Tr¹ch thÇn")
                TaskNote(69, 0, "BÝch Du tÇng 2", "L«i Tr¹ch thÇn", count)
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
                TaskNote(72, 0, "tÇng 4 vµ 5 Hiªn Viªn ®éng", nums, 80000)
            else


                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, "tÇng 4 vµ 5 Hiªn Viªn ®éng", nums, 80000)


            end

            if (nums >= 80000) then
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
                TopMessage("Th¶ thµnh c«ng linh hån L«i Tr¹ch thÇn")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", L«i Tr¹ch thÇn ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "L«i Tr¹ch thÇn", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", L«i Tr¹ch thÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån L«i Tr¹ch thÇn")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. L«i Tr¹ch thÇn ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "L«i Tr¹ch thÇn", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. L«i Tr¹ch thÇn ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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


