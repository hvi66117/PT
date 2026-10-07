Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050
Task_hengcai = 1214;

npc_name = {
    [2] = "TuyÕt Yªu",
    [5] = "B¨ng Kiªu Trïng",
    [9] = "TuyÕt Nguyªn Cù Thó",
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
        local i = GetLevel() - 15
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
        end
        PlayerIndex = oldPlayer
    else


        if (GetTask(852) > 0) then
            liesha_city(w)
        end
    end ;

    if (GetLevel() <= 20) then
        MonsterDropScroll()
    end

    if (GetTask(1118) == 1) and (GetByte(GetTask(1124), 1) == 8) then
        MonsterTip()
    end

    if (GetTask(14) == 1) then
        FNewlingli()
    end

    if (GetTask(Task_PrepareMaterial) == 1) then
        if (GetPlayerType() == 1) and (GetByte(GetTask(Task_PrepareMaterNum), 1) == 8) then
            FPreGoodsNew()
        end
    end

    if (GetTask(955) == 9) and (GetTask(956) < 20) then
        Frenwu18()
    end

    if (GetTask(936) > 0) then
        Frenwu42()
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

    if (type1 == 9 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 9 and count2 > 0) then
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

function no()
    CloseDialog()
end;

function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn TuyÕt Nguyªn Cù Thó" .. (20 - nums) .. ".")
        TaskNote(50, 1, "TuyÕt Nguyªn Cù Thó", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

function Frenwu42()
    if (GetTask(936) < 5) then
        local r = math.random(1, 10000)
        local zyCNums = GetByte(GetTask(938), 2) + 1
        local key = 0
        if (zyCNums == 1) and (r <= 100) then
            key = 1
        elseif (zyCNums == 2) and (r >= 100) and (r <= 110) then
            key = 1
        elseif (zyCNums >= 3) and (r == 5000) then
            key = 1
        end
        if (key == 1) then
            AddNormalItemPile(3, 102, 1, 0, 0, 0)
            TopMessage(11644)
            SetTask(938, SetByte(GetTask(938), 2, zyCNums))
        end
    else

        local rand_buff = math.random(1, 1000)
        local today_buff = math.floor(LocalSystemTime() / 86400)
        if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
            AddIBBuff(369)
            TopMessage(11647)
            SetTask(991, today_buff)
        end
    end
end

function MonsterDropScroll()
    if (GetTask(1118) == 0) and (HaveNormalItem(6, 1, 308, 1) < 1) then
        local nProp = math.random(1, 100)
        local nlv = GetLevel()
        if (nlv >= 9) and (nlv <= 13) then
            if (nProp <= 10) then
                AddNormalItem(6, 1, 308, 1, 0, 0)
                TopMessage(11615)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 TuyÕt Nguyªn Cù Thó mËt tÞch")
            end
        else
            if (nProp <= 4) then
                AddNormalItem(6, 1, 308, 1, 0, 0)
                TopMessage(11615)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 TuyÕt Nguyªn Cù Thó mËt tÞch")
            end
        end
    end

    if (GetTask(1119) == 0 and HaveNormalItem(6, 1, 309, 1) < 1) then
        local nProp = math.random(1, 100)
        if (nProp <= 1) then
            AddNormalItem(6, 1, 309, 1, 0, 0)
            TopMessage(11612)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 MËt tÞch Thu ThËp.")
        end
    end
end

function MonsterTip()
    local nTaskInfo = GetTask(1124)
    local nNeedNum = GetByte(nTaskInfo, 2)
    local nReaNum = GetByte(nTaskInfo, 3)
    if (nReaNum < nNeedNum) then
        nReaNum = nReaNum + 1
        SetTask(1124, SetByte(nTaskInfo, 3, nReaNum))
        if (nReaNum >= nNeedNum) then
            SetTask(1118, 2)
            TaskNote(916, 2)
            TopMessage(11621)
            Msg2Player("Hoµn thµnh nhiÖm vô YÓm Ho¶ MËt tÞch, cã thÓ ®i gÆp T¹p hãa Th­¬ng nhËn th­ëng")
        else
            TaskNote(916, 1, nReaNum, nNeedNum)
            TopMessage("Tiªu diÖt TuyÕt Nguyªn Cù Thó" .. nReaNum .. "/" .. nNeedNum .. ".")
            Msg2Player("Tiªu diÖt TuyÕt Nguyªn Cù Thó" .. nReaNum .. "/" .. nNeedNum .. ".")
        end
    end
end

function FNewlingli()
    local nNum = HaveNormalItem(3, 139, 0, 0)

    if (nNum < 4) then
        local nProp = math.random(1, 10)
        if (nProp <= 3) then
            AddNormalItemPile(3, 139, 0, 0, 0, 0)
            nNum = nNum + 1

            if (nNum >= 4) then
                TaskNote(4, 1)
                TopMessage(11627)
                Msg2Player("§· thu thËp ®ñ Cù Thó Chi Cèt, h·y mang giao cho Nam Cùc Tiªn ¤ng. ")
            else
                TopMessage(11628)
                Msg2Player("NhËn 1 Cù Thó Chi Cèt. ")
            end
        end
    end

end

function FPreGoodsNew()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local L_RealNum = HaveNormalItem(3, 143, 0, 0)
    if (L_RealNum < L_ObjectNum) then
        local nProp = math.random(1, 10)
        if (nProp <= 2) then
            AddNormalItemPile(3, 143, 0, 0, 0, 0)
            L_RealNum = L_RealNum + 1
            if (L_RealNum >= L_ObjectNum) then
                TopMessage("B¹n ®· thu thËp ®ñ <c=g>Th¹ch")
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>Th¹ch")
            else
                TopMessage("B¹n nhËn ®­îc 1 Th¹ch")
                Msg2Player("B¹n nhËn ®­îc 1 Th¹ch")
            end
        end
    end
end
