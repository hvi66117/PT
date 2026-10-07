--description: ∫µπÍ
--author: yaoxin 
--date: 2008/07/14

Task_hengcai = 1214;
--1bitŒ™ «∑ÒΩ”ÃÏΩµ∫·≤∆»ŒŒÒ;2bitŒ™ «∑ÒÕÍ≥…ÃÏΩµ∫·≤∆»ŒŒÒ;3bitŒ™ «∑ÒΩ´µ¿æﬂΩª∏¯≥Ø∏Ëÿ‘ ¶;4bitŒ™ «∑ÒΩ´µ¿æﬂΩª∏¯Œ˜·™ÿ‘ ¶;5bitŒ™ «∑Ò“—Ω”≈£µ∂–° ‘;6bitŒ™ «∑ÒÕÍ≥…≈£µ∂–° ‘

TASK_lateral = 1200 --30-50÷ßœﬂ, 10bitø™∆ÙŒ™√Ò≥˝∫¶,11bit «∑ÒÕÍ≥…Œ™√Ò≥˝∫¶, 12bit «∑ÒΩ”¡À“Ω’ﬂ» –ƒ,13bit «∑ÒÕÍ≥…“Ω’ﬂ» –ƒ£¨14bit «∑ÒΩ”¿ß ﬁ”Ã∂∑,15bit «∑ÒÕÍ≥…¿ß ﬁ”Ã∂∑,16bitø™∆Ù’∂≤›≥˝∏˘,17bit «∑ÒÕÍ≥…’∂≤›≥˝∏˘, 20bitø™∆Ù¡È∆¯»·∫Õ,21bit «∑ÒÕÍ≥…¡È∆¯»·∫Õ, 26bitø™∆Ù∫Ï…∑÷Æªº,27bit «∑ÒÕÍ≥…∫Ï…∑÷Æªº,,30bit «∑Òº§ªÓ¿ß ﬁ”Ã∂∑,29bit «∑ÒÕÍ≥…ÀÕªı…œ√≈
TASK_lateral_1 = 1201 -- 2byteŒ™√Ò≥˝∫¶µƒº◊ø«≥Ê∏ˆ ˝£¨3byteŒ™√Ò≥˝∫¶µƒ∫µπÍ∏ˆ ˝,4byte∫Ï…∑÷Æªºµƒ∏ˆ ˝,
TASK_lateral_2 = 1202 -- 10∑÷÷”ƒ⁄…±∫µπÍ£¨…±µ√ ˝¡ø‘Ω∂‡Ω±¿¯‘Ω∂‡£¨£®»ŒŒÒø…π≤œÌ£©°£
TASK_lateral_3 = 1203 -- 1byte…≥ªÍ∑¥ª˜µƒπ÷ŒÔidx£¨2byte…≥ªÍ∑¥ª˜µƒ∏ˆ ˝, 17bitø™∆Ù…≥ªÍøÀ–«,18bit «∑ÒÕÍ≥……≥ªÍøÀ–«, 19bitø™∆Ù…≥ªÍ∑¥ª˜,20bit «∑ÒÕÍ≥……≥ªÍ∑¥ª˜,22bit «∑ÒµΩ ±º‰¿ß ﬁ”Ã∂∑


npc_name = {
    [14] = "Gi∏p CËt",
    [17] = "Thi™n Hπo",
    [25] = "Giang Quy",
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
        local i = GetLevel() - 25
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µÙÿ‘
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("Bπn nhÀn Æ≠Óc 1 <c=yel>Vi™n BÂn<c>")
                Msg2Player("Bπn b t ngÍ nhÀn Æ≠Óc 1 <cVi™n BÂn")
            end ;
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

            --ø™∆Ùª®ª‹»ŒŒÒ”√µƒ¡‘…±»ŒŒÒ			
            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            --30-50÷ßœﬂ
            if (w == 18) or (w == 65) then
                renwu_lateral(w)
            end

            if (GetByte(GetTask(1210), 1) == 1 and GetByte(GetTask(1210), 2) == 24) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- Œﬁ∂”ŒÈ
        --”∂±¯”™¡‘…±»ŒŒÒ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        --ø™∆Ùª®ª‹»ŒŒÒ”√µƒ¡‘…±»ŒŒÒ			
        if (GetTask(888) > 0) and (GetTask(888) < 12) then
            huahui_open_task(w, GetTask(894))
        end

        --30-50÷ßœﬂ
        if (w == 18) or (w == 65) then
            renwu_lateral(w)
        end

        if (GetByte(GetTask(1210), 1) == 1 and GetByte(GetTask(1210), 2) == 24) then
            NewMonsterTip(w)
        end
    end ;

    ---–¬‘ˆ7π÷ŒÔæÌ÷·µÙ¬‰
    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1210), 1) == 0 and HaveNormalItem(6, 1, 356, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 25)--¡ÈªÍ≥¨∂»»ŒŒÒ£®40º∂£©--∑‚…ÒÃ®“Û∫È
        end
    end ;

    if (GetTask(955) == 25) and (GetTask(956) < 20) then
        Frenwu18()--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã
    end

    if (GetTask(936) == 5) then
        Frenwu42()--’Ú‘≠¥Ûœ…  ≥»◊∞∫œ≥…  42º∂
    end

    -- Added by Zhaoqingsong at 2009-4-23 begin
    processChallenge()
    -- Added by Zhaoqingsong at 2009-4-23 end
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

    if (type1 == 25 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("Nhi÷m vÙ L›nh Æ∏nh thu™: ti™u di÷t" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s∏t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 25 and count2 > 0) then
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

--ø™∆Ùª®ª‹»ŒŒÒ”√µƒ¡‘…±»ŒŒÒ
function huahui_open_task(world, task_target)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(889)
        local param = { 894, floor(GetTask(888) / 2) + 1 }
        for i = 1, 4 do
            local t = GetByte(task_target, i)
            local c = GetByte(task_val, i)
            if (t ~= 0) then
                if (t == 25 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T◊m hoa: ß∑ ti™u di÷t Giang Quy (" .. c .. "/50)")
                    else
                        ScrollMessage("T◊m hoa: Æ∑ hoµn thµnh ti™u di÷t Giang Quy")
                    end
                    SetTask(889, SetByte(task_val, i, c))
                end
                param[getn(param) + 1] = c
            end
        end
        TaskNote(894, -1)
        call(TaskNote, param)
    end
end

function no()
    CloseDialog()
end;

function renwu_lateral(WorldID)
    local w, x, y = GetWorldPos()
    if (w == WorldID) then
        local val = GetTask(TASK_lateral)
        local val1 = GetTask(TASK_lateral_1)
        local val3 = GetTask(TASK_lateral_3)

        if (WorldID == 18) then
            if (GetBit(val, 11) == 0) and (GetBit(val, 10) == 1) then
                local count2 = GetByte(val1, 3) - 1
                if (count2 >= 1) then
                    SetTask(TASK_lateral_1, SetByte(val1, 3, count2))
                    TaskNote(702, 1, GetByte(val1, 2), count2)
                    ScrollMessage("V◊ d©n trı hπi: Bπn cﬂn ph∂i di÷t " .. count2 .. " Giang Quy")
                elseif (count2 == 0) then
                    SetTask(TASK_lateral_1, SetByte(val1, 3, 0))
                    TaskNote(702, 1, GetByte(val1, 2), 0)
                    ScrollMessage("V◊ d©n trı hπi: hoµn thµnh ti™u di÷t Giang Quy")
                    if (GetByte(val1, 2) == 0) then
                        TaskNote(702, 2)
                    end
                end
            end

            if (GetBit(val, 13) == 0) and (GetBit(val, 12) == 1) then
                local gui_drop = random(1, 100)
                if (gui_drop <= 15) then
                    if (HaveNormalItem(3, 210, 0, 0) < 14) then
                        AddNormalItemPile(3, 210, 0, 0, 0, 0)
                        TopMessage("Thu thÀp Æ≠Óc 1 <c=g>mai rÔa<c>")
                    elseif (HaveNormalItem(3, 210, 0, 0) < 15) then
                        AddNormalItemPile(3, 210, 0, 0, 0, 0)
                        TopMessage("Hoµn thµnh nhi÷m vÙ thu thÀp <c=g>mai rÔa<c>")
                        Msg2Player("Nh©n t©m: ß∑ hoµn thµnh nhi÷m vÙ thu thÀp mai rÔa!")
                        TaskNote(703, 1)
                    end
                end
            end
            return 0
        elseif (WorldID == 65) then
            local zhu_drop = random(1, 100)
            if (GetBit(val, 30) == 1) and (GetBit(val, 15) == 0) then
                if (HaveIBBuff(436) > 0) then
                    local count4 = GetTask(TASK_lateral_2) + 1
                    SetTask(TASK_lateral_2, count4)
                    ScrollMessage("KhÊn ThÛ: Æ∑ ti™u di÷t " .. count4 .. " Giang Quy")
                    TaskNote(704, 1, count4)
                elseif (GetBit(val3, 22) == 0) then
                    SetTask(TASK_lateral_3, SetBit(val3, 22, 1))
                    ScrollMessage("KhÊn ThÛ: hoµn thµnh ti™u di÷t Giang Quy")
                    TaskNote(704, 2)
                end
            elseif (GetBit(val, 15) == 1) and (GetBit(val, 17) == 0) and (GetBit(val, 16) == 1) then
                if (zhu_drop <= 30) then
                    --modify by wingbear 2009.5.10
                    if (HaveNormalItem(3, 211, 0, 0) < 29) then
                        AddNormalItemPile(3, 211, 0, 0, 0, 0)
                        TopMessage("Thu thÀp Æ≠Óc 1 <c=g>H∑n Ch©u<c>")
                    elseif (HaveNormalItem(3, 211, 0, 0) < 30) then
                        AddNormalItemPile(3, 211, 0, 0, 0, 0)
                        TopMessage("Hoµn thµnh nhi÷m vÙ thu thÀp <c=g>H∑n Ch©u<c>")
                        Msg2Player("Di÷t c· tÀn gËc: ß∑ hoµn thµnh nhi÷m vÙ thu thÀp H∑n Ch©u!")
                        if (HaveNormalItem(3, 212, 0, 0) >= 30) then
                            TaskNote(705, 1)
                        end
                    end
                end
            end
            return 0
        end
    end
end

function NewMonsterDropScroll()
    local nProp = random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 356, 1, 0, 0)
        TopMessage("Bπn may mæn nhÀn Æ≠Óc 1 <c=g>Giang Quy l÷nh<c>!")
        Msg2Player("Bπn b t ngÍ nhÀn Æ≠Óc 1 Giang Quy mÀt tﬁch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1210)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1210, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1210, SetByte(GetTask(1210), 1, 2))
            TaskNote(923, 2)
            TopMessage("Hoµn thµnh ti™u di÷t Giang Quy, c„ th” t◊m Tπp h„a Th≠¨ng l∑nh th≠Îng!")
            Msg2Player("Hoµn thµnh nhi÷m vÙ Giang Quy l÷nh, c„ th” t◊m Tπp h„a Th≠¨ng l∑nh th≠Îng!")
        else
            TaskNote(923, 1, KillNum, Num)
            TopMessage("Ti™u di÷t Giang Quy" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Ti™u di÷t Giang Quy" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi∏o Hu n: Cﬂn ph∂i gi∏o hu n Giang Quy" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Giang Quy", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhi÷m vÙ Gi∏o hu n")
        TaskNote(50, 2)
    end
end

--¡ÈªÍ≥¨∂»»ŒŒÒ£®40º∂£©--∑‚…ÒÃ®“Û∫È
--964 π÷ŒÔ1±Í∫≈
--965 π÷ŒÔ2±Í∫≈
--966 ’–ªÍ∑´À˘‘⁄µÿÕºid
--967 ’–ªÍ∑´µƒ÷––ƒŒª÷√x
--968 ’–ªÍ∑´µƒ÷––ƒŒª÷√y
--969 ’–ªÍ∑´µƒ…Ë÷√∆ º ±º‰
--970 π÷ŒÔ1µƒ¡ÈªÍ∏ˆ ˝
--971 π÷ŒÔ2µƒ¡ÈªÍ∏ˆ ˝
function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = random(1, 3) --µÙ¬‰¡ÈªÍ∏≈¬ 33%
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                SetTask(971, dd2 + 1)
                TopMessage("Th∂ thµnh c´ng linh hÂn Giang Quy")
                Msg2Player("Chi™u HÂn Ph≠Ìn:Ph„ng th›ch thµnh c´ng!" .. npc_name[d1] .. "ß∑ si™u ÆÈ" .. dd1 .. ", Giang Quy Æ∑ gi∂i tho∏t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Giang Quy", GetTask(971))
            else
                Msg2Player("Th∂ th t bπi!" .. npc_name[d1] .. "ß∑ si™u ÆÈ" .. dd1 .. ", Giang Quy Æ∑ gi∂i tho∏t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th∂ thµnh c´ng linh hÂn Giang Quy")
                Msg2Player("Chi™u HÂn ph≠Ìn: gi∂i tho∏t thµnh c´ng. Giang Quy Æ∑ gi∂i tho∏t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "ß∑ si™u ÆÈ" .. dd2 .. ".")
                TaskNote(48, 1, "Giang Quy", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chi™u HÂn ph≠Ìn: gi∂i tho∏t th t bπi. Giang Quy Æ∑ gi∂i tho∏t" .. dd1 .. "." .. npc_name[d2] .. "ß∑ si™u ÆÈ" .. dd2 .. ".")
            end
        end

        if (GetTask(971) >= 3) and (GetTask(970) >= 3) then
            Msg2Player("Si™u ÆÈ thµnh c´ng! Bπn h∑y quay v“ Phong Th«n Æµi g∆p ¢n HÂng nhÀn th≠Îng!")
            TaskNote(48, 2)
            SetTask(966, 0)
        end
    else
        Msg2Player("Y™u qu∏i kh´ng Î trong phπm vi Chi™u HÂn trÀn")
    end ;
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

-- Added by Zhaoqingsong at 2009-4-23 begin
-- ÃÙ’Ωº´œﬁ

Task_Challenge_Accept = 1396  -- 1W ¡Ï∆± ±º‰ 3B ¡Ï∆±¥Œ ˝ 4B √‚∑—¡Ï∆±
Task_Challenge_Enter = 1397  -- 1W ≤Œ»¸ ±º‰ 3B ≤Œ»¸¥Œ ˝ 4B ≤Œ»¸◊¥Ã¨
Task_Challenge_Growth = 1398  -- 1B ≥…≥§∂» 2B ≥‰∆¯Õ∞ π”√ 3B ≥‰∆¯boss
Task_Challenge_Kill = 1399  -- …±π÷ ±º‰
Task_Challenge_Begin = 1400  -- ±»»¸ø™ º ±º‰

Task_Info_Challenge = 204
Buff_Challenge = 649
Const_Kill_Burst = 4
Const_Kill_Interval = 3

Const_Challenge_Balloon_Begin = 964
Const_Challenge_Balloon_End = 969

Challenge_Burst = {
    { low = 0, high = 30, total = 1000, ratio = 0, balloon = 964, desc = "" },
    { low = 31, high = 50, total = 1000, ratio = 8, balloon = 965, desc = "" },
    { low = 51, high = 70, total = 1000, ratio = 17, balloon = 966, desc = "" },
    { low = 71, high = 90, total = 1000, ratio = 58, balloon = 967, desc = "" },
    { low = 91, high = 100, total = 1000, ratio = 120, balloon = 968, desc = "" },
}

Challenge_Buff = {
    { buffid = 647, total = 1000, ratio = 10, desc = "Ngµn c©n treo sÓi t„c" },
    { buffid = 648, total = 1000, ratio = -10, desc = "Kh› Æﬁnh th«n nhµn" },
    { buffid = 647, total = 1000, ratio = 10, desc = "Ng‰c Phong Ch©m" },
    { buffid = 648, total = 1000, ratio = -10, desc = "D≠¨ng Chi LÈ" },
}


--  «∑Òœ‘ æÃÙ’Ωº´œﬁ
function processChallenge()
    local w, x, y = GetWorldPos()
    if (w ~= 18) then
        return
    end
    local taskDate = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus = GetTaskByte(Task_Challenge_Enter, 4)
    if (taskStatus ~= 1 or HaveIBBuff(Buff_Challenge) == 0) then
        return
    end
    local growth = GetTaskByte(Task_Challenge_Growth, 1)
    local useFill = GetTaskByte(Task_Challenge_Growth, 2)
    local useFillCount = GetTaskByte(Task_Challenge_Growth, 3)
    local preTime = GetTask(Task_Challenge_Kill)
    local localTime = LocalSystemTime()

    local hardBurst = 1000
    if (useFill == 1 and useFillCount < 10) then
        hardBurst = 0
        SetTaskByte(Task_Challenge_Growth, 3, useFillCount + 1)
    end

    local curBurst = 0
    local growthLevel = 1
    local growthLevel2 = 1
    for i = 1, 5 do
        if (growth >= Challenge_Burst[i].low and growth <= Challenge_Burst[i].high) then
            growthLevel = i
            growthLevel2 = i
            if (growth == Challenge_Burst[i].high) then
                growthLevel2 = i + 1
            end
            break
        end
    end
    curBurst = curBurst + Challenge_Burst[growthLevel].ratio
    local buffIdx = 0
    for i = 1, 4 do
        if (HaveIBBuff(Challenge_Buff[i].buffid) > 0) then
            buffIdx = i
            break
        end
    end
    if (buffIdx > 0) then
        curBurst = curBurst + Challenge_Buff[buffIdx].ratio
    end

    local isAdded = 0
    if (hardBurst ~= 0 and growth > Challenge_Burst[1].high) then
        if ((localTime - preTime) < Const_Kill_Interval) then
            isAdded = 1
            curBurst = curBurst + Const_Kill_Burst
        end
    end
    curBurst = (curBurst < 0) and 0 or curBurst
    if (hardBurst == 0) then
        curBurst = 0
    end
    local burstStr = (curBurst == 0) and ("Kh´ng") or (curBurst .. "/1000")

    local rand = random(1, 1000)
    if (rand <= curBurst) then
        -- …æ≥˝∆¯«Ú
        ClearEffectNpc()
        if (buffIdx > 0) then
            RemoveIBBuff(Challenge_Buff[buffIdx].buffid)
        end
        RemoveIBBuff(Buff_Challenge)
        ClearItem(6, 1, 492, 0) -- …æ≥˝µ¿æﬂ ≥‰∆¯Õ≤
        ClearItem(6, 1, 493, 0) -- …æ≥˝µ¿æﬂ ”Ò∑‰’Î
        ClearItem(6, 1, 494, 0) -- …æ≥˝µ¿æﬂ —Ú÷¨¬∂
        if (growth >= 60) then
            SetTaskByte(Task_Challenge_Enter, 4, 3)
            TaskNote(Task_Info_Challenge, 2, growth)
            Msg2Player("ThÀt ti’c, Kh› C«u cÒa bπn Æ∑ b”, nh≠ng ÆÈ lÌn Kh› C«u Æ∑ Æπt Æ’n" .. growth .. " ßi”m, v…n c„ th” Æ’n g∆p Æπi phu nhÀn th≠Îng.")
            TopMessage("Kh› C«u cÒa bπn bﬁ b”")
        else
            SetTaskByte(Task_Challenge_Enter, 4, 0)
            TaskNote(Task_Info_Challenge, -1)
            Msg2Player("ThÀt ti’c, Kh› C«u cÒa bπn ch≠a Æπt 60 Æi”m Æ∑ b”, cuÈc thi th t bπi.")
            TopMessage("Kh› C«u cÒa bπn bﬁ b”")
        end
        return
    end

    growth = growth + 1
    SetTaskByte(Task_Challenge_Growth, 1, growth)
    SetTask(Task_Challenge_Kill, localTime)
    TaskNote(Task_Info_Challenge, 0, growth, burstStr)

    if (growthLevel ~= growthLevel2 or growth == 100) then
        if (growth == 100) then
            local ballName = GetName() .. "_Kh› C«u"

            -- add by mayining 2009.6.16 ÷ª «±‰…Ì
            --SetEffectNpc(ballName,Const_Challenge_Balloon_End,0)	
            ModifyEffectNpc(Const_Challenge_Balloon_End)
            -- end by mayining 2009.6.16	

            SetTaskByte(Task_Challenge_Enter, 4, 2)
            TaskNote(Task_Info_Challenge, 1)
            Msg2Player("Xin chÛc mıng, ÆÈ lÌn Kh› C«u cÒa bπn Æ∑ Æπt tËi Æa, mau Æ’n chÁ Æπi phu nhÀn th≠Îng.")
        else
            -- ∆¯«Ú±‰…Ì
            local ballName = GetName() .. "_Kh› C«u"

            -- add by mayining 2009.6.16 ÷ª «±‰…Ì
            --SetEffectNpc(ballName,Challenge_Burst[growthLevel2].balloon,0)	
            ModifyEffectNpc(Challenge_Burst[growthLevel2].balloon)
            -- end by mayining 2009.6.16

            Msg2Player("ßÈ lÌn Kh› C«u cÒa bπn Æπt giai Æoπn th¯" .. growthLevel2 .. ", x∏c su t b” t®ng l™n.")
        end
    elseif (isAdded == 1) then
        Msg2Player("TËc ÆÈ gi’t qu∏i qu∏ nhanh lµm t®ng x∏c su t b” cÒa Kh› C«u.")
    end

    ScrollMessage("ßÈ lÌn cÒa Kh› C«u Æ∑ t®ng Æ’n <c=g>" .. growth .. "<c>")

end

-- Added by Zhaoqingsong at 2009-4-23 end
