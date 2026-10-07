--description: ÃÏŒ‚
--author: yaoxin 
--date: 2008/07/14

Task_hengcai = 1214;
--1bitŒ™ «∑ÒΩ”ÃÏΩµ∫·≤∆»ŒŒÒ;2bitŒ™ «∑ÒÕÍ≥…ÃÏΩµ∫·≤∆»ŒŒÒ;3bitŒ™ «∑ÒΩ´µ¿æﬂΩª∏¯≥Ø∏Ëÿ‘ ¶;4bitŒ™ «∑ÒΩ´µ¿æﬂΩª∏¯Œ˜·™ÿ‘ ¶;5bitŒ™ «∑Ò“—Ω”≈£µ∂–° ‘;6bitŒ™ «∑ÒÕÍ≥…≈£µ∂–° ‘

TASK_lateral = 1200 --30-50÷ßœﬂ, 10bitø™∆ÙŒ™√Ò≥˝∫¶,11bit «∑ÒÕÍ≥…Œ™√Ò≥˝∫¶, 12bit «∑ÒΩ”¡À“Ω’ﬂ» –ƒ,13bit «∑ÒÕÍ≥…“Ω’ﬂ» –ƒ£¨14bit «∑ÒΩ”¿ß ﬁ”Ã∂∑,15bit «∑ÒÕÍ≥…¿ß ﬁ”Ã∂∑,16bitø™∆Ù’∂≤›≥˝∏˘,17bit «∑ÒÕÍ≥…’∂≤›≥˝∏˘, 20bitø™∆Ù¡È∆¯»·∫Õ,21bit «∑ÒÕÍ≥…¡È∆¯»·∫Õ, 26bitø™∆Ù∫Ï…∑÷Æªº,27bit «∑ÒÕÍ≥…∫Ï…∑÷Æªº,,30bit «∑Òº§ªÓ¿ß ﬁ”Ã∂∑,29bit «∑ÒÕÍ≥…ÀÕªı…œ√≈
TASK_lateral_1 = 1201 -- 2byteŒ™√Ò≥˝∫¶µƒº◊ø«≥Ê∏ˆ ˝£¨3byteŒ™√Ò≥˝∫¶µƒ∫µπÍ∏ˆ ˝,4byte∫Ï…∑÷Æªºµƒ∏ˆ ˝,
TASK_lateral_2 = 1202 -- 10∑÷÷”ƒ⁄…±∫µπÍ£¨…±µ√ ˝¡ø‘Ω∂‡Ω±¿¯‘Ω∂‡£¨£®»ŒŒÒø…π≤œÌ£©°£
TASK_lateral_3 = 1203 -- 1byte…≥ªÍ∑¥ª˜µƒπ÷ŒÔidx£¨2byte…≥ªÍ∑¥ª˜µƒ∏ˆ ˝, 17bitø™∆Ù…≥ªÍøÀ–«,18bit «∑ÒÕÍ≥……≥ªÍøÀ–«, 19bitø™∆Ù…≥ªÍ∑¥ª˜,20bit «∑ÒÕÍ≥……≥ªÍ∑¥ª˜,22bit «∑ÒµΩ ±º‰¿ß ﬁ”Ã∂∑

-- ¥Û–ÀÕ¡ƒæ»ŒŒÒ
build_renwu = 1255 --1byte  ±º‰ 2byte  «∑Ò¡Ïπ˝»ŒŒÒ 3byte ◊ˆ∂””—µƒ¥Œ ˝ 4byte ÕÍ≥…Ω◊∂Œ,1 « ’ºØ≤ƒ¡œ1,2 « ’ºØ≤ƒ¡œ2,3 «∂””—ÕÍ≥…, 3“‘…œ «∂”≥§3+–°∂”»À ˝
build_npcIdx = 1256 --Õ∂∑≈npcÀ˜“˝
build_nums = 1258 --∂”≥§Œ™ªπ–Ë ’ºØ≤ƒ¡œµƒ∏ˆ ˝,∂””—Œ™Ω”»ŒŒÒµƒ ±º‰¥¡
build_var_up = 80 --…±π÷∏ˆ ˝∑ß÷µ80

---------¿Îº‰÷Æº∆-----------
Task_Mischief = 1357  --1byte:0√ª¡Ï»ŒŒÒ£ª1£∫¡Ï»°¡À≤∂◊Ω»ŒŒÒ£ª2£∫ÕÍ≥…≤∂◊Ω£¨¡Ï»°¡ÀΩ±¿¯£ª3£∫¡Ï»°¡À¡‘…±∫µπÍ ◊¡Ïµƒ»ŒŒÒ£ª4:“—±‰≥…∫µπÍ◊¥Ã¨£ª5£∫ÕÍ≥…»ŒŒÒ
--2byte:≤∂◊Ω∫µπÍµƒ∏ˆ ˝;3byte:≤∂◊ΩÃÏŒ‚µƒ∏ˆ ˝£ª4£∫¡‘…±ÃÏŒ‚µƒ∏ˆ ˝

hanguiID = 24        --∫µπÍID
tianwuID = 16        --ÃÏŒ‚ID
---------¿Îº‰÷Æº∆-----------
-- ÷≤ ˜
task_Tree = 1315
task_TreeNpcIndex = 1316
task_TreeNpcId = 1318

npc_name = {
    [13] = "Ng≠u S∏t",
    [14] = "Gi∏p CËt",
    [16] = "Dπ Xoa",
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
        local i = GetLevel() - 30
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µÙÿ‘
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage(14371)
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

            if (GetTask(897) == 17) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)    -- ¶ÕΩ¡‘…±»ŒŒÒ
                end
            end

            --30-50÷ßœﬂ
            if (w == 17) or (w == 18) or (w == 65) then
                renwu_lateral(w)
            end
        end
        PlayerIndex = oldPlayer
        -- ¥Û–ÀÕ¡ƒæ»ŒŒÒ
        if (w == 17) and (GetLevel() >= 35) then
            local buildkey = GetByte(GetTask(build_renwu), 4)
            if (buildkey == 2) then
                if (SystemTime() <= (GetTask(build_nums) + 1800)) then
                    frenwu35(buildkey)
                else
                    SetTask(build_renwu, SetByte(GetTask(build_renwu), 4, 0))
                end
            end
        end
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
        if (w == 17) or (w == 18) or (w == 65) then
            renwu_lateral(w)
        end
    end ;

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 17)--¡ÈªÍ≥¨∂»»ŒŒÒ£®40º∂£©--∑‚…ÒÃ®“Û∫È
        end
    end ;

    if (GetTask(955) == 17) and (GetTask(956) < 40) then
        Frenwu18()--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã
    end

    if (GetTask(936) == 5) then
        Frenwu42()--’Ú‘≠¥Ûœ…  ≥»◊∞∫œ≥…  42º∂
    end

    if (checkTeamCondition() == 1) then
        judge_Tree()
    end
    -------------¿Îº‰÷Æº∆ Add by Gaojingwei At 2009/3/26-------------
    local process = GetTaskByte(Task_Mischief, 1)
    local tianwuCount = GetTaskByte(Task_Mischief, 4)
    if (process == 4 and GetMorphType() == 24 and tianwuCount < 30) then
        tianwuCount = tianwuCount + 1
        SetTaskByte(Task_Mischief, 4, tianwuCount)
        ScrollMessage(" Æ∑ ti™u di÷t " .. tianwuCount .. "/30 Thi™n Hπo")
        if (tianwuCount == 30) then
            ScrollMessage("Ti™u di÷t thµnh c´ng Thi™n Hπo")
            Msg2Player("Ti™u di÷t thµnh c´ng Thi™n Hπo, c„ th” v“ b∏o c´ng rÂi!")
            TaskNote(1035, 4)
        end
    end
    -------------¿Îº‰÷Æº∆ Add by Gaojingwei At 2009/3/26-------------

    -- Added by Zhaoqingsong at 2009-4-23 begin
    processChallenge()
    -- Added by Zhaoqingsong at 2009-4-23 end
end

function judge_Tree()

    -- ”– ˜µƒÕÊº“‘ˆº” ˜µƒ≥…≥§∂»
    local oldPlayer = PlayerIndex

    for i = 1, 3 do

        PlayerIndex = GetTeamMember(i)

        local npcindex = GetTask(task_TreeNpcIndex)
        local npcid = GetTask(task_TreeNpcId)
        local playerID = GetNpcTask(npcindex, 2)
        if (GetTaskByte(task_Tree, 2) == 2) and (npcid ~= 0) and (GetNpcID(npcindex) == npcid) and (playerID == GetPlayerID()) then

            local nGrowRank = GetNpcTask(npcindex, 0)
            nGrowRank = nGrowRank + 1

            if (nGrowRank <= 100) then

                SetNpcTask(npcindex, 0, nGrowRank)

                if (nGrowRank == 100) then

                    local nNpcWorldID, nNpcX, nNpcY = GetNpcWorldPos(npcindex)

                    SetNpcName(npcindex, "<c=g>" .. GetName() .. "<c>,")
                    NpcPolyMorph(npcindex, 816)
                    ScrollMessage("M«m c©y cÒa bπn Æ∑ thµnh c©y xanh")
                    Msg2Player("M«m c©y cÒa bπn Æ∑ thµnh c©y xanh<HyperLinkWorldPos=\"Œ˜∆Á[17," .. floor(nNpcX / 8) .. "," .. floor(nNpcY / 16) .. "]\">")
                    TaskNote(1029, 2)

                else

                    ScrollMessage("M«m c©y cÒa bπn Æ∑ tr≠Îng thµnh, hi÷n ÆÈ tr≠Îng thµnh cÒa M«m c©y lµ" .. nGrowRank .. " / 100")
                    Msg2Player("M«m c©y cÒa bπn Æ∑ tr≠Îng thµnh, hi÷n ÆÈ tr≠Îng thµnh cÒa M«m c©y lµ" .. nGrowRank .. " / 100")
                    TaskNote(1029, 1, nGrowRank)

                end

                SetNpcTimer(npcindex, "\\script\\ontimer\\…æµÙ◊‘º∫.lua", 3600)

            else

                if (GetNpcTask(npcindex, 1) == 0) then
                    Msg2Player("M«m c©y cÒa bπn Æ∑ lÌn thµnh c©y xanh!")
                end

            end

        end

    end

    PlayerIndex = oldPlayer

end

function checkTeamCondition()

    if (GetTeam() == 0) then
        return 0
    end

    if (GetTeamSize() ~= 3) then
        return 0
    end

    -- ”–∂”ŒÈ(∞¸¿®÷ª”–◊‘º∫“ª∏ˆ»Àµƒ)
    local oldPlayer = PlayerIndex
    local membercount = GetTeamSize()

    local careerAry = { [0] = 0, [1] = 0, [2] = 0 }

    local TaskCount = 0

    -- ±È¿˙∂”÷–∂”‘±
    for i = 1, membercount do

        PlayerIndex = GetTeamMember(i)
        local nWorldID, nX, nY = GetWorldPos()

        if (nWorldID == 17) and (GetLevel() >= 30) then
            careerAry[GetSeries()] = 1
        end

        if (GetTaskByte(task_Tree, 2) == 2) then
            TaskCount = TaskCount + 1
        end

    end
    PlayerIndex = oldPlayer

    if (TaskCount <= 0) then
        return 0
    end

    local nSeriseCount = 0
    for i = 0, 2 do
        if (careerAry[i] ~= 0) then
            nSeriseCount = nSeriseCount + 1
        end
    end

    if (nSeriseCount >= 3) then
        return 1
    end

    return 0
end

-- ¶ÕΩ¡‘…±»ŒŒÒ
function judge_relation()
    --¬˙◊„ ¶ÕΩ2»À∂”
    local mark = -1
    if (GetTeam() ~= 0) then
        -- ”–∂”ŒÈ	
        if (GetTeamSize() == 2) then
            --2»À∂”
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
                mark = n --∑µªÿ∂””—µƒplayerindex
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
    local mark = HaveIBBuff(215)    --≈–∂œ¡‘…±»ŒŒÒµƒ±Í÷æbuff
    local w, x, y = GetWorldPos()
    if (world == w) then
        if (mark ~= 0) then
            if (count > 1) then
                SetTask(898, count - 1)
                Msg2Player("Trı Y™u: Bπn cﬂn ph∂i di÷t " .. (count - 1) .. "Thi™n Hπo!")
                if (mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trı Y™u: Bπn cﬂn ph∂i di÷t " .. (count - 1) .. "Thi™n Hπo!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trı Y™u: ß∑ hoµn thµnh ti™u di÷t Thi™n Hπo!")
            end
        else
            if (count > 0) then
                Msg2Player("Trı Y™u: Vﬂng s∏ng trı y™u bi’n m t, nhi÷m vÙ Trı y™u th t bπi.")
            end
        end
    end
end

--”∂±¯”™œ˚√»ŒŒÒ
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

    if (type1 == 17 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("Nhi÷m vÙ L›nh Æ∏nh thu™: ti™u di÷t" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s∏t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 17 and count2 > 0) then
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
                if (t == 17 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T◊m hoa: ß∑ ti™u di÷t Thi™n Hπo (" .. c .. "/50)")
                    else
                        ScrollMessage("ß∑ hoµn thµnh nhi÷m vÙ T◊m hoa: ti™u di÷t Thi™n Hπo!")
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

--30-50÷ßœﬂ
function renwu_lateral(WorldID)
    local w, x, y = GetWorldPos()
    if (w == WorldID) then
        local val = GetTask(TASK_lateral)
        local val1 = GetTask(TASK_lateral_1)
        local val3 = GetTask(TASK_lateral_3)

        if (WorldID == 18) then
            if (GetBit(val, 20) == 1) and (GetBit(val, 21) == 0) then
                if (HaveNormalItem(3, 214, 0, 0) == 0) then
                    local xin_drop = random(1, 100)
                    if (xin_drop <= 5) then
                        AddNormalItemPile(3, 214, 0, 0, 0, 0)
                        Msg2Player("Bπn nhÀn Æ≠Óc 1 Thi™n Hπo T©m [LÙc]!")--ÃÏŒ‚÷Æ–ƒ¬Ã
                        TopMessage(14372)
                        if (HaveNormalItem(3, 213, 0, 0) == 0) then
                            TaskNote(706, 3)
                        else
                            TaskNote(706, 4)
                        end
                    end
                end
            end
            return 0
        elseif (WorldID == 17) then
            if (GetBit(val, 20) == 1) and (GetBit(val, 21) == 0) then
                if (HaveNormalItem(3, 213, 0, 0) == 0) then
                    local xin_drop = random(1, 100)
                    if (xin_drop <= 2) then
                        AddNormalItemPile(3, 213, 0, 0, 0, 0)
                        Msg2Player("Bπn nhÀn Æ≠Óc 1 Thi™n Hπo T©m [ßen]!")--ÃÏŒ‚÷Æ–ƒ∫⁄
                        TopMessage(14373)
                        if (HaveNormalItem(3, 214, 0, 0) == 0) then
                            TaskNote(706, 2)
                        else
                            TaskNote(706, 4)
                        end
                    end
                end
            end
            return 0
        elseif (WorldID == 65) then
            local zhu_drop = random(1, 100)
            if (GetBit(val, 15) == 1) and (GetBit(val, 17) == 0) and (GetBit(val, 16) == 1) then
                if (zhu_drop <= 30) then
                    --modify by wingbear 2009.5.10
                    if (HaveNormalItem(3, 212, 0, 0) < 29) then
                        AddNormalItemPile(3, 212, 0, 0, 0, 0)
                        TopMessage(14374)
                    elseif (HaveNormalItem(3, 212, 0, 0) < 30) then
                        AddNormalItemPile(3, 212, 0, 0, 0, 0)
                        TopMessage(14375)
                        Msg2Player("Di÷t c· tÀn gËc: ß∑ hoµn thµnh nhi÷m vÙ thu thÀp LÙc Ch©u!")
                        if (HaveNormalItem(3, 211, 0, 0) >= 30) then
                            TaskNote(705, 1)
                        end
                    end
                end
            end

            if (GetBit(val, 18) == 0) and (HaveNormalItem(6, 1, 347, 0) == 0) then
                --modify by wingbear 2009.5.10begin
                local kill_n = GetTask(1443) + 1
                local ratedp = 0
                if (kill_n <= 20) then
                    ratedp = random(1, 100)
                elseif (kill_n <= 40) then
                    ratedp = random(1, 33)
                else
                    ratedp = random(1, 20)
                end
                if (ratedp == 1) then
                    AddNormalItemPile(6, 1, 347, 0, 0, 0)
                    Msg2Player("Bπn nhÀn Æ≠Óc 1 Thi™n Hπo T©m [ß·]!")--ÃÏŒ‚÷Æ–ƒ
                    TopMessage(14376)
                end
                SetTask(1443, kill_n)                                                                                    --modify by wingbear 2009.5.10end
            end
            return 0
        end
    end
end

--ΩÃ—µπ÷ŒÔ»ŒŒÒ£®30º∂“‘œ¬£©--–¬ ÷¥Â ‘”ªı…Ã-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 40) then
        SetTask(956, nums)
        ScrollMessage("Gi∏o Hu n: Cﬂn ph∂i gi∏o hu n Thi™n Hπo" .. (40 - nums) .. ".")
        TaskNote(50, 4, nums)
    elseif (nums == 40) then
        SetTask(956, 41)
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
                TopMessage(14377)
                Msg2Player("Chi™u HÂn Ph≠Ìn:Ph„ng th›ch thµnh c´ng!" .. npc_name[d1] .. "ß∑ si™u ÆÈ" .. dd1 .. ", Thi™n Hπo Æ∑ gi∂i tho∏t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Thi™n Hπo", GetTask(971))
            else
                Msg2Player("Th∂ th t bπi!" .. npc_name[d1] .. "ß∑ si™u ÆÈ" .. dd1 .. ", Thi™n Hπo Æ∑ gi∂i tho∏t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage(14377)
                Msg2Player("Chi™u HÂn ph≠Ìn: gi∂i tho∏t thµnh c´ng. Thi™n Hπo Æ∑ gi∂i tho∏t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "ß∑ si™u ÆÈ" .. dd2 .. ".")
                TaskNote(48, 1, "Thi™n Hπo", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chi™u HÂn ph≠Ìn: gi∂i tho∏t th t bπi. Thi™n Hπo Æ∑ gi∂i tho∏t" .. dd1 .. "." .. npc_name[d2] .. "ß∑ si™u ÆÈ" .. dd2 .. ".")
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


-- ¥Û–ÀÕ¡ƒæ»ŒŒÒ 35º∂------------------------------
function frenwu35(key)
    local idx = GetTask(build_npcIdx)
    local oldPlayer = PlayerIndex
    local PlayerIndex1 = GetTeamMember(1)
    PlayerIndex = PlayerIndex1
    if (idx ~= GetTask(build_npcIdx)) then
        PlayerIndex = oldPlayer
        Msg2Player("ßÈi tr≠Îng hi÷n tπi kh´ng ph∂i lµ bªng h˜u mµ bπn muËn giÛp!")
        return 0
    end
    PlayerIndex = oldPlayer

    local idx = key + 235
    AddNormalItemPile(3, idx, 0, 0, 0, 0)
    local itemname = { "Chuy™n Thπch", "Hπt m«m" }
    local nums = HaveNormalItem(3, idx, 0, 0)
    if (nums >= build_var_up) then
        nums = mod((nums - build_var_up), build_var_up / 4)
        if (nums == 0) then
            ScrollMessage("T◊m ÆÒ nguy™n li÷u c„ th” v“ phÙc m÷nh")-- ªÿ»•…œΩ…≤ƒ¡œ
            local pname = GetName()
            PlayerIndex = PlayerIndex1
            ScrollMessage(pname .. "T◊m Æ≠Óc kh´ng ›t rÂi, Æ” anh ta v“ giao nÈp")-- Ã· æ∂”≥§£¨∂””—¥Ú¡À≤ª…Ÿ¡À£¨
            PlayerIndex = oldPlayer
        end
    else
        ScrollMessage("Bπn nhÀn Æ≠Óc <c=g>" .. itemname[key])
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
