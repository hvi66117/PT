--description: ºìÉ·
--author: yaoxin 
--date: 2008/07/14

Task_DeliverCarbon = 1045;
Task_DriveOutNum = 1046;
Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

Task_HelpDoctor = 1099 --   Ñ©ÖĞËÍÌ¿ÈÎÎñ¿ØÖÆ±äÁ¿

TASK_lateral = 1200 --30-50Ö§Ïß, 10bit¿ªÆôÎªÃñ³ıº¦,11bitÊÇ·ñÍê³ÉÎªÃñ³ıº¦, 12bitÊÇ·ñ½ÓÁËÒ½ÕßÈÊĞÄ,13bitÊÇ·ñÍê³ÉÒ½ÕßÈÊĞÄ£¬14bitÊÇ·ñ½ÓÀ§ÊŞÓÌ¶·,15bitÊÇ·ñÍê³ÉÀ§ÊŞÓÌ¶·,16bit¿ªÆôÕ¶²İ³ı¸ù,17bitÊÇ·ñÍê³ÉÕ¶²İ³ı¸ù, 20bit¿ªÆôÁéÆøÈáºÍ,21bitÊÇ·ñÍê³ÉÁéÆøÈáºÍ, 26bit¿ªÆôºìÉ·Ö®»¼,27bitÊÇ·ñÍê³ÉºìÉ·Ö®»¼,,30bitÊÇ·ñ¼¤»îÀ§ÊŞÓÌ¶·,29bitÊÇ·ñÍê³ÉËÍ»õÉÏÃÅ
TASK_lateral_1 = 1201 -- 2byteÎªÃñ³ıº¦µÄ¼×¿Ç³æ¸öÊı£¬3byteÎªÃñ³ıº¦µÄºµ¹ê¸öÊı,4byteºìÉ·Ö®»¼µÄ¸öÊı,
Task_unending = 1236 -- Âí²»Í£Ìã, 1byte ÊÇ·ñ¼¤»îÁËÈÎÎñ1,2½ÓÁË,3ÊÇÍê³ÉÎ´½», 10ÎªÈÎÎñÓÀ¾ÃÍê³É,2byte ×éºÅ(1-3),3,4byte ·Ö±ğÎª¹ÖÎï1,2µÄÁé»ê¸öÊı
Task_wugu1 = 1352;
--Î×¹ÆÖ®¶¾µÚÒ»²½ÈÎÎñ±äÁ¿

npc_name = {
    [11] = "Cæ §iªu",
    [13] = "Ng­u S¸t",
    [16] = "D¹ Xoa",
    [17] = "Thiªn H¹o",
}

-- Ö²Ê÷
task_Tree = 1315
task_TreeNpcIndex = 1316
task_TreeNpcId = 1318

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı
function OnDeath(npcindex)
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ
    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØĞÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 20
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage(14371)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;
    --ÎŞ¶ÓÎé
    --Î×¹ÆÖ®¶¾ÈÎÎñ-------------------------------Add by yangmeng   2009/10/20   begin  
    local wu = GetTask(Task_wugu1)
    if (wu >= 2) and (wu <= 4) and (HaveEventItem(222) < 1) then
        WuGuDropScroll()
    end
    -----------------------------------------------Add by yangmeng   2009/10/20   end

    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ			
            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            if (GetTask(897) == 13) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)    --Ê¦Í½ÁÔÉ±ÈÎÎñ
                end
            end

            if (w == 14) then
                renwu_lateral(w)--30-50Ö§Ïß
            end

            if (GetByte(GetTask(1206), 1) == 1 and GetByte(GetTask(1206), 2) == 12) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ			
        if (GetTask(888) > 0) and (GetTask(888) < 12) then
            huahui_open_task(w, GetTask(894))
        end

        if (w == 14) then
            --30-50Ö§Ïß
            renwu_lateral(w)
        end

        if (GetByte(GetTask(1206), 1) == 1 and GetByte(GetTask(1206), 2) == 12) then
            NewMonsterTip(w)
        end
    end ;

    ---ĞÂÔö7¹ÖÎï¾íÖáµôÂä
    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1206), 1) == 0 and HaveNormalItem(6, 1, 352, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    --Çı³ıÒş»¼
    if (GetPlayerType() < 2) then
        if (GetTask(Task_DeliverCarbon) == 12) then
            if (GetByte(GetTask(Task_DriveOutNum), 1) == 12) then
                FNewjinghua()
            end
        end
    else
        local L_HelpDoctor = GetTask(Task_HelpDoctor)
        if (GetByte(L_HelpDoctor, 1) == 13) then
            if (GetByte(L_HelpDoctor, 2) == 12) then
                FNewjinghua()
            end
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 13)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé

            if (HaveIBBuff(458) > 0) and (GetByte(GetTask(Task_unending), 2) == 1) then
                if (GetByte(GetTask(Task_unending), 4) < 3) then
                    Lrenwu58(px, py)-- Âí²»Í£Ìã
                end
            end
        end
    end ;

    if (GetTask(955) == 13) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (checkTeamCondition() == 1) then
        judge_Tree()
    end
end

function judge_Tree()

    -- ÓĞÊ÷µÄÍæ¼ÒÔö¼ÓÊ÷µÄ³É³¤¶È
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
                    ScrollMessage("MÇm c©y cña b¹n ®· thµnh c©y xanh")
                    Msg2Player("MÇm c©y cña b¹n ®· thµnh c©y xanh<HyperLinkWorldPos=\"Î÷Æç[17," .. floor(nNpcX / 8) .. "," .. floor(nNpcY / 16) .. "]\">")
                    TaskNote(1029, 2)

                else

                    ScrollMessage("MÇm c©y cña b¹n ®· tr­ëng thµnh, hiÖn ®é tr­ëng thµnh cña MÇm c©y lµ" .. nGrowRank .. " / 100")
                    Msg2Player("MÇm c©y cña b¹n ®· tr­ëng thµnh, hiÖn ®é tr­ëng thµnh cña MÇm c©y lµ" .. nGrowRank .. " / 100")
                    TaskNote(1029, 1, nGrowRank)

                end

                SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 3600)

            else

                if (GetNpcTask(npcindex, 1) == 0) then
                    Msg2Player("MÇm c©y cña b¹n ®· lín thµnh c©y xanh!")
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

    -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
    local oldPlayer = PlayerIndex
    local membercount = GetTeamSize()

    local careerAry = { [0] = 0, [1] = 0, [2] = 0 }

    local TaskCount = 0

    -- ±éÀú¶ÓÖĞ¶ÓÔ±
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

--Ê¦Í½ÁÔÉ±ÈÎÎñ
function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = -1
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé	
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
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
                mark = n --·µ»Ø¶ÓÓÑµÄplayerindex
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
    local mark = HaveIBBuff(215)    --ÅĞ¶ÏÁÔÉ±ÈÎÎñµÄ±êÖ¾buff
    local w, x, y = GetWorldPos()
    if (world == w) then
        if (mark ~= 0) then
            if (count > 1) then
                SetTask(898, count - 1)
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Ng­u S¸t!")
                if (mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Ng­u S¸t!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Ng­u S¸t!")
            end
        else
            if (count > 0) then
                Msg2Player("Trõ Yªu: Vßng s¸ng trõ yªu biÕn mÊt, nhiÖm vô Trõ yªu thÊt b¹i.")
            end
        end
    end
end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
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

    if (type1 == 13 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    elseif (type2 == 13 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    end
end

--¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ
function huahui_open_task(world, task_target)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(889)
        local param = { 894, floor(GetTask(888) / 2) + 1 }
        for i = 1, 4 do
            local t = GetByte(task_target, i)
            local c = GetByte(task_val, i)
            if (t ~= 0) then
                if (t == 13 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt Ng­u S¸t (" .. c .. "/50)")
                    else
                        ScrollMessage("T×m hoa: §· hoµn thµnh tiªu diÖt Ng­u S¸t")
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

--30-50Ö§Ïß
function renwu_lateral(WorldID)
    local w, x, y = GetWorldPos()
    if (w == WorldID) then
        local val = GetTask(TASK_lateral)
        local val1 = GetTask(TASK_lateral_1)

        if (GetBit(val, 26) == 1) and (GetBit(val, 27) == 0) then
            local count3 = GetByte(val1, 4) - 1
            if (count3 >= 1) then
                SetTask(TASK_lateral_1, SetByte(val1, 4, count3))
                TaskNote(709, 1, count3)
                ScrollMessage("N¹n Ng­u S¸t: B¹n cßn ph¶i diÖt " .. count3 .. " Ng­u S¸t")
            elseif (count3 == 0) then
                SetTask(TASK_lateral_1, SetByte(val1, 4, 0))
                TaskNote(709, 2)
                ScrollMessage("B¹n ®· hoµn thµnh nhiÖm vô: N¹n Ng­u S¸t")
            end
        end
    end
end

function NewMonsterDropScroll()
    local nProp = random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 352, 1, 0, 0)
        TopMessage(14382)
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Ng­u S¸t mËt tŞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1206)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1206, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1206, SetByte(GetTask(1206), 1, 2))
            TaskNote(921, 2)
            TopMessage(14383)
            Msg2Player("Hoµn thµnh nhiÖm vô Ng­u S¸t lÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(921, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Ng­u S¸t" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Ng­u S¸t" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Ng­u S¸t" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Ng­u S¸t", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
--964 ¹ÖÎï1±êºÅ
--965 ¹ÖÎï2±êºÅ
--966 ÕĞ»ê·«ËùÔÚµØÍ¼id
--967 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃx
--968 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃy
--969 ÕĞ»ê·«µÄÉèÖÃÆğÊ¼Ê±¼ä
--970 ¹ÖÎï1µÄÁé»ê¸öÊı
--971 ¹ÖÎï2µÄÁé»ê¸öÊı
function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = random(1, 3) --µôÂäÁé»ê¸ÅÂÊ33%
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                SetTask(971, dd2 + 1)
                TopMessage(14384)
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Ng­u S¸t ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Ng­u S¸t", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Ng­u S¸t ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage(14384)
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Ng­u S¸t ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Ng­u S¸t", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Ng­u S¸t ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

-- Âí²»Í£Ìã
function Lrenwu58(px, py)
    --xiaoque
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = random(1, 3) --µôÂäÁé»ê¸ÅÂÊ33%
        local val = GetTask(Task_unending)
        local dd1 = GetByte(val, 3)
        local dd2 = GetByte(val, 4)

        if (p ~= 2) then
            dd2 = dd2 + 1
            SetTask(Task_unending, SetByte(val, 4, dd2))
            TopMessage(14384)
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Cæ §iªu ®· gi¶i tho¸t" .. dd1 .. ", Ng­u S¸t ®· gi¶i tho¸t" .. dd2 .. ".")
            TaskNote(81, 1, "Cæ §iªu", dd1, "Ng­u S¸t", dd2)
        else
            Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Cæ §iªu ®· gi¶i tho¸t" .. dd1 .. ", Ng­u S¸t ®· gi¶i tho¸t" .. dd2 .. ".")
        end

        if (dd1 >= 3) and (dd2 >= 3) then
            for i = 2, 5 do
                RemoveIBBuff(260 + i)
            end
            Msg2Player("Chiªu Hån ph­ín: th¶ hoµn tÊt, b¹n cã thÓ ®i t×m H¾c Phong, D¹ Xoa")
            SetTask(Task_unending, SetByte(GetByte(val, 1), 2, 2))
            TaskNote(81, 0, "H¾c Phong", "D¹ Xoa")
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
end
-------------------------------ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶-----------------------------
function Frenwu42()
    --991	»ñµÃ¼ÓÕòÔ­ÉùÍûbuffµÄÊ±¼ä,¾«È·µ½Ìì
    local rand_buff = random(1, 1000)--
    local today_buff = floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

--¾»»¯É½´¨Áø
function FNewjinghua()
    local nProp = random(1, 5)
    if (nProp == 1) then
        AddNormalItemPile(6, 1, 277, 0, 0, 0)
        TopMessage(11634)
        Msg2Player("NhËn ®­îc TŞnh Hãa Phï, cã thÓ tŞnh hãa S¬n Xuyªn LiÔu!")
    end
end
function WuGuDropScroll()
    local nProp = random(1, 100)
    if (nProp <= 5) then
        AddEventItem(222)
        Msg2Player("B¹n nhËn ®­îc Ng­u S¸t huyÕt")
        TopMessage("B¹n nhËn ®­îc <c=yel>Ng­u S¸t HuyÕt<c>.")
    end
end
