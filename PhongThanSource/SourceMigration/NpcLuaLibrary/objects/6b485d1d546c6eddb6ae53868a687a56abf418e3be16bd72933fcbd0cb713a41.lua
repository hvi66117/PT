npc_name = {
    [3] = "§¹i Chñng Nh©n",
    [6] = "§µi Yªu",
    [7] = "Cuång §iªu",
    [10] = "Th¶o Tiªn",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }
function OnDeath(npcindex)

    local w, x, y = GetWorldPos()
    local mapgid, px, py = GetNpcWorldPos(npcindex)
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)
    local playerlevel = GetLevel()

    if (GetTaskBit(2089, 17) == 1 and GetNewBirthTimes() == 1 and GetPlayerType() == 2 and GetTaskBit(2089, 18) == 0) then
        NewBirthdayTask()
    end

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 5
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
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

    if (GetByte(GetTask(1126), 1) == 1) then
        MonsterTip()
    end

    if (GetTask(1087) == 1) and (GetByte(GetTask(1088), 1) == 2) then
        NewPlayerTask()
    end

    if (GetByte(GetTask(993), 1) == 3) then
        Frenwu1()
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()
    end

    if (GetTask(1089) == 3) then
        Frenwu100()
    end

    if (HaveIBBuff(2148) >= 1) then
        if (mapgid >= 11) and (mapgid <= 13) then
            Fliudao(playerlevel)
        end
    end
end

function Frenwu100()

    local nRank = math.random(1, 100)
    if (nRank <= 50) then
        local nBookPiece = HaveNormalItem(3, 333, 0, 0)
        if (nBookPiece < 5) then
            AddNormalItem(3, 333, 0, 0, 0, 0)
            nBookPiece = nBookPiece + 1
            ScrollMessage("NhËn ®­îc " .. nBookPiece .. "/5 trang s¸ch r¸ch")
            Msg2Player("NhËn ®­îc " .. nBookPiece .. "/5 trang s¸ch r¸ch")
            TaskNote(1002, 1, nBookPiece)
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

    if (type1 == 3 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: Hµng phôc " .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage("Hoµn thµnh hµng phôc " .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 3 and count2 > 0) then
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

function Frenwu1()
    local testNums = GetTask(994) + 1
    local L_nums = GetByte(GetTask(993), 2) * 10
    if (testNums < L_nums) then
        SetTask(994, testNums)
        ScrollMessage("KÕ Tôc: Cßn ph¶i tiªu diÖt " .. (L_nums - testNums) .. " §¹i Chñng Nh©n")
        TaskNote(51, 1, "§¹i Chñng Nh©n", testNums, L_nums)

    elseif (testNums <= L_nums + 30) then
        SetTask(994, testNums)
        if (math.mod(testNums, 10) == 0) then
            ScrollMessage(11643)
            TaskNote(51, 2)
        end
    end
end

function Fliudao(plvl)
    local r_sx = math.random(1, 100)
    local task_rand = 10
    if (GetNewBirthTimes() >= 1) then
        plvl = 200
        task_rand = 60
    elseif (plvl > 64) then
        task_rand = math.floor((plvl - 50) / 15) * 5 + 10
    end

    if (r_sx <= task_rand) then
        TopMessage("Lùc Cóng TÕ: NhËn ®­îc thªm 1 <c=g>Quû DiÖn<c>")
        AddNormalItemPile(3, 12, 0, 0, 0, 0)
    end
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

function MonsterDropScroll()
    if (GetTask(1126) == 0) and (HaveNormalItem(6, 1, 305, 1) < 1) then
        local nProp = math.random(1, 100)
        local nlv = GetLevel()
        if (nlv >= 9) and (nlv <= 13) then
            if (nProp <= 10) then
                AddNormalItem(6, 1, 305, 1, 0, 0)
                TopMessage(11616)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 §¹i Chñng Nh©n mËt tÞch")
            end
        else
            if (nProp <= 4) then
                AddNormalItem(6, 1, 305, 1, 0, 0)
                TopMessage(11616)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 §¹i Chñng Nh©n mËt tÞch")
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
    local val = GetTask(1126)
    local L_DzrID = GetByte(val, 2)
    local L_DzrNum = GetByte(val, 3)
    if (2 == L_DzrID) then
        local L_KillNum = GetByte(val, 4) + 1
        SetTask(1126, SetByte(val, 4, L_KillNum))
        if (L_KillNum >= L_DzrNum) then
            SetTask(1126, SetByte(val, 1, 2))
            TaskNote(1009, 2)
            TopMessage(11622)
            Msg2Player("Hoµn thµnh nhiÖm vô §¹i Chñng Nh©n, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(1009, 1, L_KillNum, L_DzrNum)
            TopMessage("Tiªu diÖt §¹i Chñng Nh©n" .. L_KillNum .. "/" .. L_DzrNum .. ".")
            Msg2Player("Tiªu diÖt §¹i Chñng Nh©n" .. L_KillNum .. "/" .. L_DzrNum .. ".")
        end
    end
end

function NewPlayerTask()
    local nTaskInfo = GetTask(1088)
    local nNum = GetByte(nTaskInfo, 3) + 1
    if (nNum < 8) then
        SetTask(1088, SetByte(nTaskInfo, 3, nNum))
        TaskNote(1001, 1, "§¹i Chñng Nh©n", nNum, 8)
        Msg2Player("T©n thñ thÝ luyÖn: Cßn ph¶i tiªu diÖt §¹i Chñng Nh©n" .. (8 - nNum) .. ".")
    elseif (nNum == 8) then
        SetTask(1087, 2)
        TaskNote(1001, 2)
        TopMessage(11625)
        Msg2Player("Hoµn thµnh nhiÖm vô, trë vÒ Thî ®ång phôc mÖnh!")
    end
end

function NewBirthdayTask()
    local num = GetTaskByte(2089, 4)
    num = num + 1
    if (num < 20) then
        SetTaskByte(2089, 4, num)
        TaskNote(2046, 1, num)
        Msg2Player("§· tiªu diÖt ®­îc " .. num .. " §¹i Chñng Nh©n.")
    else
        SetTaskByte(2089, 4, num)
        TaskNote(2046, 2)
        Msg2Player("T×m vËt tæ Khoa Phô hoµn thµnh nhiÖm vô.")
    end
end

