Task_hengcai = 1214;

Task_unending = 1236

npc_name = {
    [24] = "KhuÈn Nh©n",
    [30] = "Chiªu ThÇn",
}

Task_Yibo = 1664

Task_Count = 1665

Task_Carriagenpcidx = 1666
Task_CarID = 1667

Boss_Index = 1670
Boss_ID = 1671

IBBuff_Kill = 1246
IBBuff_Boss = 1245
Forbidden_Buff = 1242

YiboTasks = {
    [1] = { taskname = "TuyÖt Long LÜnh·üÄ§ÈÎÎñ", master = { name = "Chiªu ThÇn", id = 30 }, apprentice = { name = "KhuÈn Nh©n", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 1729 } },
    [2] = { taskname = "BÝch Du CungÒ»²ã·üÄ§ÈÎÎñ", master = { name = "Quû §¨ng", id = 38 }, apprentice = { name = "Lam qu¸i", id = 40 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [3] = { taskname = "BÝch Du Cung¶þ²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "Lam qu¸i", id = 40 }, apprentice = { name = "L«i Tr¹ch thÇn", id = 42 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [4] = { taskname = "Khæn Thiªn CungÒ»²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "Vò La ThÇn", id = 44 }, apprentice = { name = "Tö Linh", id = 45 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [5] = { taskname = "BÝch Du CungÈý²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "L«i Tr¹ch thÇn", id = 42 }, apprentice = { name = "Vò La ThÇn", id = 44 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [6] = { taskname = "Khæn Thiªn Cung¶þ²ã×é¶Ó·üÄ§ÈÎÎñ", master = { name = "Chiªu ThÇn", id = 30 }, apprentice = { name = "KhuÈn Nh©n", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [7] = { taskname = "·½ÕÉµº·üÄ§ÈÎÎñ", master = { name = "V« Danh Thó", id = 30 }, apprentice = { name = "S¬n Tiªu", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [8] = { taskname = "¶«å­µº·üÄ§ÈÎÎñ", master = { name = "L·o §ång", id = 30 }, apprentice = { name = "Quang Quû", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [9] = { taskname = "ÅîÀ³µº·üÄ§ÈÎÎñ", master = { name = "N÷ TÕ", id = 30 }, apprentice = { name = "H¹ HËu Khëi", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
}

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
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
        local i = GetLevel() - 55
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage(14371)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    local taskType = GetTaskByte(Task_Count, 1)
    if (mapgid == 19 and (taskType == 13 or taskType == 14) and IsMantlePrentice(PlayerIndex) > 0 and GetNpcID(GetTask(Task_Carriagenpcidx)) == GetTask(Task_CarID) and GetTask(Task_CarID) ~= 0) then
        if (HaveIBBuff(Forbidden_Buff) == 0) then
            AddIBBuff(Forbidden_Buff)
        end
    end

    if (mapgid == 19 and GetTaskByte(Task_Count, 1) == 1 and IsMantleMaster(PlayerIndex) > 0 and GetTaskByte(Task_Count, 4) <= 1) then
        High_LevelShimen()
    end

    if (GetTeam() ~= 0) then

        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)

            if (GetTask(854) > 0) then
                liesha_city(w)
            end

            if (GetTask(897) == 30) then
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

    if (mapgid == 19) then
        CheckLiehunTask()
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 30)

            if (HaveIBBuff(458) > 0) and (GetByte(GetTask(Task_unending), 2) == 3) then
                if (GetByte(GetTask(Task_unending), 4) < 3) then
                    Lrenwu58(px, py)
                end
            end
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end
end

function High_LevelShimen()
    local teamstate = Team_State()
    if (teamstate == 1) then
        if (GetTaskByte(Task_Count, 4) == 1) then
            local bossindex = GetTask(Boss_Index)
            local bossid = GetTask(Boss_ID)
            if (GetNpcID(bossindex) == bossid and bossindex ~= 0) then
                local bInArea = Check_BossDistance(bossindex)
                if (bInArea == 1) then
                    Msg2Player("ÇëÓ¢ÐÛËÙÈ¥½µ·þÓ¢ÕÐÉñ¾ý")
                end
            else
                Msg2Team("Anh Chiªu ThÇn Qu©n ®· bÞ ng­êi kh¸c tiªu diÖt, nhiÖm vô thÊt b¹i!")
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
            if (count < 50) then
                count = count + 1
                SetTaskByte(Task_Count, 2, count)

                if (count == 50) then
                    if (Get_MateTaskByte(Task_Count, 2) == 30 and HaveIBBuff(IBBuff_Kill) > 0) then

                        callBoss(npcindex)
                    elseif (Get_MateTaskByte(Task_Count, 2) < 30) then

                        ScrollMessage("Phôc Ma Gi¶n ®· kÝch ho¹t, mau ®i thu phôc Anh Chiªu ThÇn Qu©n")
                        TeamAction("Team_AddBuff", 0, 0, 0)
                    end
                else
                    ScrollMessage("Phôc Ma TÕ ThÕ: Cßn cÇn tiªu diÖt Ó¢ÕÐÉñ" .. (50 - count) .. ".")
                end
            else
                ScrollMessage("Phôc Ma Gi¶n ®· kÝch ho¹t, mau ®i thu phôc Anh Chiªu ThÇn Qu©n")
            end
        end
    elseif (teamstate == 5) then
        Msg2Player("ÄãµÄ¶ÓÓÑÒÑ¾­·ÅÆúÁË½µ·þÈÎÎñ!Çë»ØD­¬ng TiÔnÄÇÀïÈ¡ÏûÈÎÎñ!")
    end
end

function callBoss()
    local id, x, y = GetWorldPos()
    local monsterIndex = AddNpc(1729, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 15 * 60)
    SetNpcName(monsterIndex, "Anh Chiªu ThÇn Qu©n")
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)
    SetTask(Boss_ID, GetNpcID(monsterIndex))
    SetMateTask(Boss_Index, monsterIndex)
    SetMateTask(Boss_ID, GetNpcID(monsterIndex))
    SetTaskByte(Task_Count, 4, 1)
    Set_MateTaskByte(Task_Count, 4, 1)
    Msg2Player("§· dô ra Anh Chiªu ThÇn Qu©n")
    TopMessage("§· dô ra Anh Chiªu ThÇn Qu©n")
    TeamAction("Team_AddBuff", IBBuff_Kill, 0, 0)
end

function Team_AddBuff(buffid)
    if (buffid == IBBuff_Kill) then
        Msg2Player("H·y lËp tøc ®i tiªu diÖt Anh Chiªu ThÇn Qu©n! B¹n chØ cã 15 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, "Anh Chiªu ThÇn Qu©n")
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
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. " Chiªu ThÇn!")
                if (math.mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. " Chiªu ThÇn!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Chiªu ThÇn!")
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

    if (type1 == 30 and count1 > 0) then
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
    elseif (type2 == 30 and count2 > 0) then
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

function CheckLiehunTask()
    if (GetTeamSize() ~= 2) then
        return
    end

    local OldPlayerIndex = PlayerIndex

    PlayerIndex = GetTeamMember(1)
    local MapID1, x1, y1 = GetWorldPos()
    local HaveBuff1 = HaveIBBuff(447)
    local KillCount1 = GetByte(GetTask(1218), 2) + (256 * GetByte(GetTask(1218), 3))
    local Rand1 = GetTask(1220)
    local Level1 = GetLevel()
    PlayerIndex = GetTeamMember(2)
    local MapID2, x2, y2 = GetWorldPos()
    local HaveBuff2 = HaveIBBuff(447)
    local KillCount2 = GetByte(GetTask(1218), 2) + (256 * GetByte(GetTask(1218), 3))
    local Rand2 = GetTask(1220)
    local Level2 = GetLevel()

    if (HaveBuff1 == 0 or HaveBuff2 == 0 or MapID1 ~= 19 or MapID2 ~= 19 or Rand1 ~= Rand2 or KillCount1 ~= KillCount2) then
        PlayerIndex = OldPlayerIndex
        return
    end

    local MaxLevel = Level1
    if (Level2 > Level1) then
        MaxLevel = Level2
    end

    local NeedKillCount = 120
    if (MaxLevel >= 70 and MaxLevel < 80) then

        NeedKillCount = 120

        if (KillCount1 < NeedKillCount) then
            PlayerIndex = GetTeamMember(1)
            TaskNote(77, 0)
            PlayerIndex = GetTeamMember(2)
            TaskNote(77, 0)
        end

    elseif (MaxLevel >= 80 and MaxLevel < 100) then

        NeedKillCount = 240

        if (KillCount1 < NeedKillCount) then
            PlayerIndex = GetTeamMember(1)
            TaskNote(77, 3)
            PlayerIndex = GetTeamMember(2)
            TaskNote(77, 3)
        end

    elseif (MaxLevel >= 100) then

        NeedKillCount = 360

        if (KillCount1 < NeedKillCount) then
            PlayerIndex = GetTeamMember(1)
            TaskNote(77, 4)
            PlayerIndex = GetTeamMember(2)
            TaskNote(77, 4)
        end

    end

    if (KillCount1 < NeedKillCount) then
        PlayerIndex = GetTeamMember(1)
        if (KillCount1 + 1 < 256) then
            SetTask(1218, SetByte(GetTask(1218), 2, KillCount1 + 1))
        else
            local HighByte = math.floor((KillCount1 + 1) / 256)
            SetTask(1218, SetByte(GetTask(1218), 3, HighByte))
            SetTask(1218, SetByte(GetTask(1218), 2, (KillCount1 + 1) - 256 * HighByte))
        end
        if (KillCount1 + 1 < NeedKillCount) then
            ScrollMessage("NhiÕp Hån: Cßn ph¶i tiªu diÖt " .. (NeedKillCount - KillCount1 - 1) .. ".")
        else
            ScrollMessage("NhiÕp Hån: hoµn thµnh nhiÖm vô")
            TaskNote(77, 1)
        end

        PlayerIndex = GetTeamMember(2)
        if (KillCount1 + 1 < 256) then
            SetTask(1218, SetByte(GetTask(1218), 2, KillCount1 + 1))
        else
            local HighByte = math.floor((KillCount1 + 1) / 256)
            SetTask(1218, SetByte(GetTask(1218), 3, HighByte))
            SetTask(1218, SetByte(GetTask(1218), 2, (KillCount1 + 1) - 256 * HighByte))
        end
        if (KillCount1 + 1 < NeedKillCount) then
            ScrollMessage("NhiÕp Hån: Cßn ph¶i tiªu diÖt " .. (NeedKillCount - KillCount1 - 1) .. ".")
        else
            ScrollMessage("NhiÕp Hån: hoµn thµnh nhiÖm vô")
            TaskNote(77, 1)
        end
    end

    PlayerIndex = OldPlayerIndex
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
                TopMessage(14385)
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Chiªu ThÇn ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Chiªu ThÇn", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Chiªu ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage(14385)
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Chiªu ThÇn ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Chiªu ThÇn", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Chiªu ThÇn ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
            TopMessage(14385)
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. KhuÈn Nh©n ®· gi¶i tho¸t" .. dd1 .. ", Chiªu ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            TaskNote(81, 1, "KhuÈn Nh©n", dd1, "Chiªu ThÇn", dd2)
        else
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. KhuÈn Nh©n ®· gi¶i tho¸t" .. dd1 .. ", Chiªu ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
        end

        if (dd1 >= 3) and (dd2 >= 3) then
            for i = 2, 5 do
                RemoveIBBuff(260 + i)
            end
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            SetTask(Task_unending, SetByte(GetTask(Task_unending), 1, 3))
            TaskNote(81, 2)
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
