--description: ±˘Ωæ≥Ê
--author: yaoxin 
--date: 2008/07/14

Task_bingjiao = 1110;
Task_bingjiaoInfo = 1111;

--yaoxin 13-18÷ßœﬂ µ¿ ø
Task_newer13 = 1416 --1byte «Ÿ∆Â Èª≠»ŒŒÒ≤Ω÷Ë£®1»ºµ∆µ¿»ÀΩ”»ŒŒÒ£¨»•’“∆’œÕ’Ê»À£¨2…±±˘Ωæ≥Êµ√⁄§“Ù«Ÿ£¨3µ√µΩ«Ÿ“™…±±˘Ωæ≥ÊÕ∑¡Ï£¨4µ√∆Â÷™µ¿’“∂…∂Ú’Ê»À£¨5µ√æ≠’“»ºµ∆£¨6ÕÍ≥…£©
--2byteÃΩƒ“»°ŒÔ»ŒŒÒ≤Ω÷Ë (1Ω”–˛∂º¥Û∑® ¶’“œÙ…˝2±∏◊„≤ƒ¡œ3Œ˜¿•¬ÿ“Ω…˙4ΩÿΩÃ≈—ÕΩ“—æ≠“◊»›≥…—©‘≠æﬁ ﬁ5—©‘≠æﬁ ﬁœ÷≥ˆ‘≠–Œ6ªÿ–˛∂º¥Û∑® ¶∏¥√¸,7ÕÍ≥…)

npc_name = {
    [2] = "Tuy’t qu∏i",
    [5] = "B®ng Lang",
    [9] = "Y”m H·a",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --¿∂π÷µÙÿ‘  Ù–‘∫≈∂‘”¶ÿ‘À˜“˝
function OnDeath(npcindex)
    --∏˜¿‡∞¥µÿÕº◊È∂”π≤œÌ≥…π˚µƒ»ŒŒÒ
    local w, x, y = GetWorldPos() --ÕÊº“µÿÕºº∞◊¯±Í
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµÿÕºº∞◊¯±Í
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--¿∂π÷ Ù–‘

    -------------------------“‘…œŒ™π≤œÌµƒ±‰¡ø Ω˚÷π÷ÿ–¬∏≥÷µ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 10
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µÙÿ‘
        end ;
    end ;

    if (GetTeam() ~= 0) then
        -- ”–∂”ŒÈ(∞¸¿®÷ª”–◊‘º∫“ª∏ˆ»Àµƒ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±È¿˙∂”÷–∂”‘±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --”∂±¯”™¡‘…±»ŒŒÒ
            if (GetTask(852) > 0) then
                liesha_city(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- Œﬁ∂”ŒÈ
        --”∂±¯”™¡‘…±»ŒŒÒ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end
    end ;

    ---µÙ¬‰»ŒŒÒæÌ÷·µÙ¬‰
    if (GetLevel() <= 20) then
        MonsterDropScroll()
    end

    if (GetPlayerType() == 1) then
        --±˘Ωæ÷Æªº
        if (GetTask(Task_bingjiao) >= 1 and GetTask(Task_bingjiao) <= 6
        ) and (GetByte(GetTask(Task_bingjiaoInfo), 1) == 4) then
            FNewPlan(w, x, y)
        end

        if (w == 10) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(238) == 0) then
            FNewPlan13()--«Ÿ∆Â Èª≠
        end
    end

    if (GetTask(955) == 5) and (GetTask(956) < 20) then
        Frenwu18()--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã
    end

    if (GetByte(GetTask(993), 1) == 5) then
        Frenwu1()--–¬ ÷¥Â“Ω…˙ 1º∂“‘…œ  π√¸’ŸªΩ
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()--’Ú‘≠¥Ûœ…  ≥»◊∞∫œ≥…  42º∂
    end
end

--”∂±¯”™¡‘…±»ŒŒÒ
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

    if (type1 == 5 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("Nhi÷m vÙ L›nh Æ∏nh thu™: ti™u di÷t" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s∏t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 5 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("Nhi÷m vÙ L›nh Æ∏nh thu™: ti™u di÷t" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage(" Hoµn thµnh Truy s∏t" .. npc_name[type2] .. ".")
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

--------------------–¬ ÷¥Â“Ω…˙ 1º∂“‘…œ  π√¸’ŸªΩ-----------------------------------
function Frenwu1()
    local testNums = GetTask(994) + 1
    local L_nums = GetByte(GetTask(993), 2) * 10
    if (testNums < L_nums) then
        SetTask(994, testNums)
        ScrollMessage("K’ TÙc: Cﬂn ph∂i ti™u di÷t " .. (L_nums - testNums) .. " B®ng Lang")
        TaskNote(51, 1, "B®ng Lang", testNums, L_nums)
    elseif (testNums == L_nums) then
        SetTask(994, testNums)--πÿ±’
        ScrollMessage(11643)
        TaskNote(51, 2)
    end

    if (testNums <= L_nums) then
        local task_rand = random(1, 100)

        if (GetTeam() ~= 0) then
            local membercount1 = GetTeamSize()

            if (task_rand <= (40 + membercount1 * 10)) then
                TopMessage("K’ TÙc: May mæn nhÀn Æ≠Óc 1 <c=g>Ng‰c CËt<c>")
                AddNormalItemPile(3, 9, 1, 0, 0, 0)
            end
        else
            if (task_rand > 50) then
                TopMessage("K’ TÙc: May mæn nhÀn Æ≠Óc 1 <c=g>Ng‰c CËt<c>")
                AddNormalItemPile(3, 9, 1, 0, 0, 0)
            end
        end ;
    elseif (testNums <= L_nums + 30) and (testNums > L_nums) then
        SetTask(994, testNums)
        if (mod(testNums, 10) == 0) then
            ScrollMessage(11643)
        end
    end
end

--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi∏o Hu n: Cﬂn ph∂i gi∏o hu n B®ng Lang" .. (20 - nums) .. ".")
        TaskNote(50, 1, "B®ng Lang", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhi÷m vÙ Gi∏o hu n")
        TaskNote(50, 2)
    end
end

-------------------------------’Ú‘≠¥Ûœ…  ≥»◊∞∫œ≥…  42º∂-----------------------------
function Frenwu42()
    --991	ªÒµ√º”’Ú‘≠…˘Õ˚buffµƒ ±º‰,æ´»∑µΩÃÏ
    local rand_buff = random(1, 1000)--
    local today_buff = floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

function MonsterDropScroll()
    if (GetTask(1119) == 0 and HaveNormalItem(6, 1, 309, 1) < 1) then
        local nProp = random(1, 100)
        if (nProp <= 1) then
            AddNormalItem(6, 1, 309, 1, 0, 0)
            --- ’ºØæÌ÷·
            TopMessage(11612)
            Msg2Player("Bπn b t ngÍ nhÀn Æ≠Óc 1 Thu thÀp mÀt tﬁch.")
        end
    end
end

--±˘Ωæ÷Æªº
function FNewPlan(w, x, y)
    local nTaskInfo = GetTask(Task_bingjiaoInfo)
    local nNum = GetByte(nTaskInfo, 2)
    local nRealNum = GetByte(nTaskInfo, 3) + 1
    local membercount = GetTeamSize()

    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 3, nRealNum))
    if (membercount == 0) then
        if (nRealNum < nNum) then
            TaskNote(913, "B®ng Lang", nRealNum, nNum)
            Msg2Player("Nhi÷m vÙ B®ng Lang: Cﬂn ph∂i ti™u di÷t " .. (nNum - nRealNum) .. " B®ng Lang!")
        else
            if (GetTask(Task_bingjiao) == 1) or (GetTask(Task_bingjiao) == 3) or (GetTask(Task_bingjiao) == 5) then
                SetTask(Task_bingjiao, GetTask(Task_bingjiao) + 1)
            end

            local newnpcidx = AddNpc(606, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B®ng Lang V≠¨ng<c>")
            TopMessage(11629)
            Msg2Player("B®ng Lang V≠¨ng xu t hi÷n")
            SetTask(Task_bingjiaoInfo, SetByte(nTaskInfo, 3, 0))
        end

    else
        local nCountTmp = 0
        local oldPlayer = PlayerIndex
        local wX, xX, yX
        local nTempRealNum = 0
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            wX, xX, yX = GetWorldPos()
            nTempRealNum = GetByte(GetTask(Task_bingjiaoInfo), 3)
            if (wX == w) then
                nCountTmp = nCountTmp + nTempRealNum
            end
        end
        PlayerIndex = oldPlayer

        if (nCountTmp < nNum) then
            oldPlayer = PlayerIndex
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    Msg2Player("Nhi÷m vÙ B®ng Lang: Cﬂn ph∂i ti™u di÷t " .. (nNum - nCountTmp) .. " B®ng Lang!")
                end
            end
            PlayerIndex = oldPlayer
        else
            local newnpcidx = AddNpc(606, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B®ng Lang V≠¨ng<c>")
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    SetTask(Task_bingjiaoInfo, SetByte(GetTask(Task_bingjiaoInfo), 3, 0))
                    TopMessage(11629)
                    Msg2Player("B®ng Lang V≠¨ng xu t hi÷n")
                    if (GetTask(Task_bingjiao) == 1) or (GetTask(Task_bingjiao) == 3) or (GetTask(Task_bingjiao) == 5) then
                        SetTask(Task_bingjiao, GetTask(Task_bingjiao) + 1)
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

--«Ÿ∆Â Èª≠
function FNewPlan13()
    local r = random(1, 10)
    if (r <= 3) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(238) == 0) then
        SetTaskByte(Task_newer13, 1, 3)
        Msg2Player("[Minh ¢m C«m] ghi lπi tung t›ch cÒa [Ch©n Long K˙].")
        TaskNote(207, 2)
        AddEventItem(238)--⁄§“Ù«Ÿ
        TopMessage("NhÀn <c=yel>Minh ¢m C«m<c>")
    end
end