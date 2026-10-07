--description: É³»ê
--author: yaoxin 
--date: 2008/07/29

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ð¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ð¡ÊÔ

TASK_lateral = 1200 --30-50Ö§Ïß, 10bit¿ªÆôÎªÃñ³ýº¦,11bitÊÇ·ñÍê³ÉÎªÃñ³ýº¦, 12bitÊÇ·ñ½ÓÁËÒ½ÕßÈÊÐÄ,13bitÊÇ·ñÍê³ÉÒ½ÕßÈÊÐÄ£¬14bitÊÇ·ñ½ÓÀ§ÊÞÓÌ¶·,15bitÊÇ·ñÍê³ÉÀ§ÊÞÓÌ¶·,16bit¿ªÆôÕ¶²Ý³ý¸ù,17bitÊÇ·ñÍê³ÉÕ¶²Ý³ý¸ù, 20bit¿ªÆôÁéÆøÈáºÍ,21bitÊÇ·ñÍê³ÉÁéÆøÈáºÍ, 26bit¿ªÆôºìÉ·Ö®»¼,27bitÊÇ·ñÍê³ÉºìÉ·Ö®»¼,,30bitÊÇ·ñ¼¤»îÀ§ÊÞÓÌ¶·,29bitÊÇ·ñÍê³ÉËÍ»õÉÏÃÅ
TASK_lateral_3 = 1203 -- 1byteÉ³»ê·´»÷µÄ¹ÖÎïidx£¬2byteÉ³»ê·´»÷µÄ¸öÊý, 17bit¿ªÆôÉ³»ê¿ËÐÇ,18bitÊÇ·ñÍê³ÉÉ³»ê¿ËÐÇ, 19bit¿ªÆôÉ³»ê·´»÷,20bitÊÇ·ñÍê³ÉÉ³»ê·´»÷,22bitÊÇ·ñµ½Ê±¼äÀ§ÊÞÓÌ¶·

-----------³õÏÖ¶ËÄß ÈýÓãÖ®ÂÒ-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚÐÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈýÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂÞÓã¶Ô»° 10Óë¾Þ¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø
--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ðÀëÐ¡Ñý£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ðÀë¾«ÆÇ
--2byte: 1½Óµ½¹ý³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ýÈýÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ý»ðÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ý±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÏûÃð»ðÀëÐ¡ÑýµÄÊýÄ¿
--4Byte:±¾´ÎÏûÃð¾úÈËµÄÊýÄ¿
Task_Time_Stemp = 1390        --¼ÇÂ¼É±µ¥´¿É³»ê£¬ºÍÈý¸öÓãµÄÊ±¼ä
Task_NpcID = 1391            --¼ÇÂ¼µ¥´¿É³»êºÍÈý¸öÓãµÄÊ±¼ä
puteGhost = 956                --µ¥´¿É³»êµÄtemplateID
bigHeadFish = 952            --´óÍ·ÓãµÄµÄtemplateID
foldFish = 952                --ÕÛÂáÓãµÄtemplateID
greatTongueFish = 952        --¾Þ¹ÇÉàÓãµÄtemplateID

Coordinate = --Èý¸öÓãµÄ×ø±ê
{
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045
-----------³õÏÖ¶ËÄß ÈýÓãÖ®ÂÒ-----------------
npc_name = {
    [15] = "ThiÕt Trïng",
    [18] = "Sa Hån",
    [21] = "§ao CÇm",
}

mapname = {
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong Than",
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

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý
function OnDeath(npcindex)
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
    --local nYear, nMonth, nDay = GetYMD()
    --if ( nYear == 2010 and ( (nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7 ) ) ) then
    --	NationalDay_Activity()
    --end
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØÐÂ¸³Öµ----------------------

    ------Add by Gaojingwei at 2009/04/16 begin--------------
    sifang(npcindex)
    ------Add by Gaojingwei at 2009/04/16 end--------------

    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 35
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (GetTeam() ~= 0) then
        -- ÓÐ¶ÓÎé(°üÀ¨Ö»ÓÐ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖÐ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(854) > 0) then
                liesha_city(w)
            end

            --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ			
            if (GetTask(888) >= 7) and (GetTask(888) < 10) and (GetTask(894) > 0) then
                huahui_open_task(w, GetTask(894))
            end

            if (GetTask(897) == 18) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)    --Ê¦Í½ÁÔÉ±ÈÎÎñ
                end
            end

            --30-50Ö§Ïß
            if (w == 22) then
                renwu_lateral(npcchr)
            end

            -- Added by Zhaoqingsong at 2009-5-5 Begin ½­É½ÒÀ¾É
            local mapid2, x2, y2 = GetWorldPos()
            if (mapgid == mapid2) then
                processJiangshan(npcindex)
            end
            -- Added by Zhaoqingsong at 2009-5-5 End
        end
        PlayerIndex = oldPlayer
    else
        -- ÎÞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(854) > 0) then
            liesha_city(w)
        end

        --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ
        if (GetTask(888) >= 7) and (GetTask(888) < 10) and (GetTask(894) > 0) then
            huahui_open_task(w, GetTask(894))
        end

        --30-50Ö§Ïß
        if (w == 22) then
            renwu_lateral(npcchr)
        end

        -- Added by Zhaoqingsong at 2009-5-5 Begin ½­É½ÒÀ¾É
        processJiangshan(npcindex)
        -- Added by Zhaoqingsong at 2009-5-5 End
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 18)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 22) and (mapgid <= 26) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    -- Added by Zhaoqingsong at 2009-5-5 Begin
    processJiangshanNote(npcindex, mapgid)
    -- Added by Zhaoqingsong at 2009-5-5 End

    --²¢·þ»î¶¯ 2009/10/27
    --	taskPeace()
    --²¢·þ»î¶¯ 2009/10/27
end

------Add by Gaojingwei at 2009/04/16 begin--------------
function sifang(npcindex)
    local flag = 0
    if (GetTeam() == 0 and GetTaskByte(Task_Variety_Process, 1) == 3 and (GetTask(Task_Time_Stemp) + 180 < SystemTime())) then
        flag = 1
    elseif (GetTeam() ~= 0) then
        local oldPlayerIndex = PlayerIndex
        local memberNum = GetTeamSize()
        for i = 1, memberNum do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_Variety_Process, 1) == 3 and (GetTask(Task_Time_Stemp) + 180 < SystemTime())) then
                flag = 1
                break
            end
        end
        PlayerIndex = oldPlayerIndex
    end

    if (flag == 1) then
        --Èç¹û¶ÓÎéÖÐÓÐÈËÓÐÈÎÎñ²ÅÓÐ¿ÉÄÜ·Å³öµ¥´¿É³»ê
        local randomValue = random(1, 100)
        if (flag == 1 and randomValue >= 1 and randomValue <= 15) then
            local id, x, y = GetNpcWorldPos(npcindex)

            local ghostIndex = AddNpc(puteGhost, 1, SubWorldID2Idx(id), x * 32, y * 32)        --Ôö¼ÓÒ»Ö»¹Ö
            SetNpcScript(ghostIndex, "\\script\\ÁúÌ×\\µ¥´¿µÄÉ³»ê.lua")
            SetNpcTimer(ghostIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)                    --3·ÖÖÓºó×Ô¶¯ÏûÊ§
            local ghostID = GetNpcID(ghostIndex)
            ----±éÀú¶ÓÎéÄÚµÄÍæ¼Ò£¬¶ÔÓÚÓÐÏàÍ¬ÈÎÎñµÄÍæ¼Ò£¬°ÑghostIDºÍÉ±¹ÖÊ±¼ä¼ÇÂ¼µ½ÈÎÎñ±äÁ¿ÖÐ
            if (GetTeam() == 0) then
                --Íæ¼ÒÒ»ÈË£¬Ã»ÓÐ×é¶Ó
                SetTask(Task_NpcID, ghostID)
                SetTask(Task_Time_Stemp, SystemTime())
                TopMessage("XuÊt hiÖn 1 Sa Hån l¹")
                Msg2Player("§· xuÊt hiÖn 1 Sa Hån, h·y mau ®i tra hái nã!")
                return
            end

            if (GetTeam() ~= 0) then
                local oldPlayerIndex = PlayerIndex
                local memberNum = GetTeamSize()
                for i = 1, memberNum do
                    PlayerIndex = GetTeamMember(i)
                    if (GetTaskByte(Task_Variety_Process, 1) == 3) then
                        --Ö»ÓÐ½ÓÁËÈÎÎñ²ÅÓÐÐ§
                        SetTask(Task_Time_Stemp, SystemTime())
                        SetTask(Task_NpcID, ghostID)
                        TopMessage("XuÊt hiÖn 1 Sa Hån l¹")
                        Msg2Player("§· xuÊt hiÖn 1 Sa Hån, h·y mau ®i tra hái nã!")
                    end
                end
                PlayerIndex = oldPlayerIndex
            end
        end
    end
end
------Add by Gaojingwei at 2009/04/16 end--------------

--Ê¦Í½ÁÔÉ±ÈÎÎñ
function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = -1
    if (GetTeam() ~= 0) then
        -- ÓÐ¶ÓÎé	
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
    local mark = HaveIBBuff(215)    --ÅÐ¶ÏÁÔÉ±ÈÎÎñµÄ±êÖ¾buff
    local w, x, y = GetWorldPos()
    if (world == w) then
        if (mark ~= 0) then
            if (count > 1) then
                SetTask(898, count - 1)
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Sa Hån!")
                if (mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Sa Hån!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Sa Hån!")
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

    local task_id = 854
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 18 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
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
    elseif (type2 == 18 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
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
                if (t == 18 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt " .. npc_name[t] .. "(" .. c .. "/50)")
                    else
                        ScrollMessage(" ®· hoµn thµnh tiªu diÖt " .. npc_name[t] .. " cña nhiÖm vô Hoa thÇn bÝ")
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
function renwu_lateral(HardNpc)
    local w, x, y = GetWorldPos()
    if (w == 22) then
        local val = GetTask(TASK_lateral)
        local val3 = GetTask(TASK_lateral_3)

        if (GetBit(val3, 17) == 1) and (GetBit(val3, 18) == 0) then
            if (HaveNormalItem(3, 216, 0, 0) == 0) and (HardNpc >= 0) then
                AddNormalItemPile(3, 216, 0, 0, 0, 0)
                Msg2Player("B¹n nhËn ®­îc 1 LÞch Th¹ch!")
                TopMessage("B¹n nhËn ®­îc 1 <c=g>LÞch Th¹ch<c>")
                TaskNote(711, 1)
            end
        end

        if (GetBit(val3, 19) == 1) and (GetBit(val3, 20) == 0) then
            local killidx = GetByte(val3, 1)
            if (killidx == 1) then
                local count1 = GetByte(val3, 2) - 1
                if (count1 >= 1) then
                    SetTask(TASK_lateral_3, SetByte(val3, 2, count1))
                    TaskNote(712, 1, count1, "Sa Hån")
                    ScrollMessage("Sa Hån ph¶n kÝch: B¹n cßn ph¶i diÖt " .. count1 .. " Sa Hån")
                elseif (count1 == 0) then
                    SetTask(TASK_lateral_3, SetByte(val3, 2, 0))
                    TaskNote(712, 2)
                    ScrollMessage("B¹n ®· hoµn thµnh nhiÖm vô Sa Hån")
                end
            end
        end
    end
end

------------------------------------ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶------------------------
function Frenwu31()
    --mapgid µØÍ¼ÐòºÅ
    if (GetTask(55) ~= 22) then
        -- Èç¹ûºÍ½ÓµÄÈÎÎñ²»¶ÔÓ¦Ôò²»ÄÜµô
        return 0
    end

    local r_sx = random(1, 100)
    local plvl = GetLevel()
    item_four = {--µÈ¼¶(<=) ¸ÅÂÊ
        [1] = { 50, 50 },
        [2] = { 90, 30 },
        [3] = { 300, 20 },
    }
    for i = 1, 3 do
        if (plvl <= item_four[i][1]) then
            if (r_sx <= item_four[i][2]) then
                TopMessage(" BÊt ngê nhËn ®­îc 1 §Þa T©m")
                AddNormalItemPile(3, 22, 1, 0, 0, 0)
            end
            return 0
        end
    end
end

--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
--964 ¹ÖÎï1±êºÅ
--965 ¹ÖÎï2±êºÅ
--966 ÕÐ»ê·«ËùÔÚµØÍ¼id
--967 ÕÐ»ê·«µÄÖÐÐÄÎ»ÖÃx
--968 ÕÐ»ê·«µÄÖÐÐÄÎ»ÖÃy
--969 ÕÐ»ê·«µÄÉèÖÃÆðÊ¼Ê±¼ä
--970 ¹ÖÎï1µÄÁé»ê¸öÊý
--971 ¹ÖÎï2µÄÁé»ê¸öÊý
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
                TopMessage("Th¶ thµnh c«ng linh hån Sa Hån")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Sa Hån ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Sa Hån", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Sa Hån ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Sa Hån")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Sa Hån ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Sa Hån", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Sa Hån ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

--------------   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶---------------------------------
--mapgid µØÍ¼ÐòºÅ
--1022 1=¹ÖÎïµØÍ¼ºÅ 2=´ò¹Ö¸öÊý  
--1023 ÁéÏ¬Öµ
function Frenwu65(mapgid)
    local gmapIdx1 = GetByte(GetTask(1022), 1)
    if (gmapIdx1 == mapgid) then
        local guanKey = mod((gmapIdx1 - 22), 5) + 1

        if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then
            local level_add = { 20, 20, 10, 10, 10 }--Ç§·ÖÖ®Ò» tu
            local mgshu = GetByte(GetTask(1022), 2) + 1
            local sgzxs = level_add[guanKey]--Ôö³¤ÏµÊý(Y)
            local r_Luck = random(1, 1000)

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
            end
        end
    else
        local mw0 = mapname[gmapIdx1]
        Msg2Player("Ng­¬i cÇn ph¶i ®Õn " .. mw0 .. " §Ó gi¶i cøu Tø T­îng Tinh Linh! Thêi gian rÊt gÊp! Xin h·y nhanh chãng khëi hµnh!")
    end
end

function suanming(gmapIdx1, plvl)
    if (gmapIdx1 < 22) or (gmapIdx1 > 41) then
        return 0
    end

    local nkey = 0
    map_idx = {
        [1] = { 331, 326, 327, 328 }, --tu	, "É³Ä®"
        [2] = { 351, 342, 343, 344 }, --huo, "ÐùÔ¯¶´"
        [3] = { 352, 345, 346, 347 }, --bing, "±ù´¨"
        [4] = { 353, 348, 349, 350 }--hai, "¶«º£"
    }
    local gmapIdx2 = floor((gmapIdx1 - 22) / 5) + 1
    local lvl = 4
    if (plvl < 100) then
        if (plvl >= 95) then
            lvl = 3
        elseif (plvl >= 65) then
            lvl = floor((plvl - 55) / 10)
        end
    end

    if (HaveIBBuff(map_idx[gmapIdx2][lvl]) > 0) then
        nkey = 1
    end
    return nkey
end

-- Added by Zhaoqingsong at 2009-5-5 Begin  ½­É½ÒÀ¾É 5-15 ÉÏÏß

-- 1Byte 0Î´½øÐÐ¾íÒ»£»1 ¾íÒ»Íê³É£»2 ¾í¶þÍê³É£»3 ¾íÈýÍê³É
-- 2Byte 0Î´¿ªÊ¼£»1 »ÃÏó1Íê³É£»2 »ÃÏó2Íê³É£»...ÒÀ´ÎÀàÍÆ
TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

-- µ÷Õû¸ÅÂÊÓÅ»¯ 2009-6-5
RAND_JS_NOTE = {
    { total = 100, ratio = 2, desc = "Bót Ký 1" },
    { total = 100, ratio = 3, desc = "Bót Ký 2" },
}

RAND_JS_NOTE_INDEX = 1

function processJiangshanNote(npcindex, mapgid)
    if ((HaveIBBuff(293) >= 1) and (mapgid >= 22) and (mapgid <= 26) and (GetTask(55) == 22)) then
    else
        return 0
    end
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    if (mainStatus > 0 or oneStep > 0) then
        return 0
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local rand = random(1, 100)
    if (rand <= RAND_JS_NOTE[RAND_JS_NOTE_INDEX].ratio) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1, 1)
        AddNormalItem(4, 243, 0, 0, 0, 0)  -- ²ÐÆÆµÄ±Ê¼Ç1
        TaskNote(Task_Info_JIANGSHAN_ONE, 0)
        TopMessage("NhËn <c=yel>Bót Ký 1")
        Msg2Player("NhËn Bót Ký 1, xem trªn ®ã viÕt g×.")
    end
end

function processJiangshan(npcindex)
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page1Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 2)
    if (mainStatus > 0 or oneStep ~= 3 or page1Step ~= 1) then
        return 0
    end
    local oneStepStatus = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 1)
    if (oneStepStatus ~= 1) then
        return 0
    end
    local killCount = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 2)
    killCount = killCount + 1
    SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 2, killCount)
    if (killCount >= 50) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 1, 2)
        TaskNote(Task_Info_JIANGSHAN_ONE, 2)
        FinishNpcCollection(1)
        TopMessage("Sa Hån: Anh hïng rÊt cã phong c¸ch cña D­ Kh¸nh")
        Msg2Player("Xin chóc mõng, tõ Sa Hån ®· chøng thùc sù anh dòng cña D­ Kh¸nh n¨m x­a, cã thÓ vÒ TriÒu Ca phôc mÖnh D­ Kh¸nh.")
    else
        TaskNote(Task_Info_JIANGSHAN_ONE, 1, killCount)
        ScrollMessage("Giang S¬n Y Cùu: Hµng phôc" .. killCount .. " Sa Hån")
    end
end

-- Added by Zhaoqingsong at 2009-5-5 End

-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
NationalDay_Info = {
    -- ÈÎÎñ±äÁ¿¼ÇÂ¼{ÈÕÆÚ£¬µôÂä¸öÊý} µØÍ¼±àºÅ¼¯ºÏ(1µ½5²ã) µôÂä¸ÅÂÊ(¶ÔÓ¦1µ½5²ã){µÚÒ»¸ö£¬µÚ¶þ¸ö} µôÂäÎïÆ·±àºÅ  µôÂäÎïÆ·Ãû×Ö
    { nTaskID = { 1731, 1732 }, mapList = { 27, 28, 29, 30, 31 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1136, 0, 0, }, itemName = "V¹n Viªm Ch©u", }, -- »ð1byte
    { nTaskID = { 1731, 1732 }, mapList = { 22, 23, 24, 25, 26 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1134, 0, 0, }, itemName = "HuyÒn Hoang Th¸p", }, -- ÍÁ2byte
    { nTaskID = { 1731, 1732 }, mapList = { 32, 33, 34, 35, 36 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1137, 0, 0, }, itemName = "Tö Yªu LÖnh", }, -- ±ù3byte
    { nTaskID = { 1731, 1732 }, mapList = { 37, 38, 39, 40, 41 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1135, 0, 0, }, itemName = "H¶i ThÇn Ch©m", }, -- Ë®4byte
}

function NationalDay_Activity()
    local nYear, nMonth, nDay = GetYMD()
    local mapID, nX, nY = GetWorldPos()

    for i = 1, getn(NationalDay_Info) do
        local taskInfo = NationalDay_Info[i]
        local mapList = taskInfo.mapList
        for j = 1, getn(mapList) do
            if (mapID == mapList[j]) then
                local nRand = random(1, 100)
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
-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

----²¢·þ»î¶¯ 2009/10/27
--Task_Peace_Day = 1595			--½ÓÈÎÎñµÄÈÕÆÚ
--Task_Peace_Process = 1596		--1byte£ºÃÔ¹¬ÀàÐÍ 1É³Ä®£¬2±ù´¨ 3ÐùÔ¯¶´ 4¶«º££» 2byte£ºÃÔ¹¬µÚ¼¸²ã£¬·¶Î§1~4£» 2World É±¹Ö¸öÊý
--BuffIndex = 1091					--buff±àºÅ
--function taskPeace()
--	
--	local today = floor(LocalSystemTime()/86400)
--	if (GetTask(Task_Peace_Day) ~= today) or (GetTaskByte(Task_Peace_Process, 1) ~= 1) or (GetTaskByte(Task_Peace_Process, 2) ~= 1) then
--		return
--	end
--	
--	local w,x,y=GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
--	if (w ~= 22) then --ÅÐ¶Ï´ò¹ÖÊÇ·ñÔÚ¸ÃµØÍ¼
--		return 0
--	end
--
--	if (GetTeam() ~= 0) then
--		local oldPlayer = PlayerIndex
--		
--		for i=1, GetTeamSize() do
--			PlayerIndex = GetTeamMember(i)
--			if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 1) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then 
--				
--				
--				local killNum = GetTaskWord(Task_Peace_Process, 2)
--				if ((HaveIBBuff(BuffIndex) > 0) ) then
--					killNum = killNum + 1
--					SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊýÐèÒªÐÞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊýÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "É³»ê", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊýÁ¿£¬µÚ¶þµµ×îµÍ»÷É±ÊýÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶þµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "É³»ê", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶þµµ»÷É±ÊýÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "É³»ê", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶þµµ»÷É±ÊýÁ¿£¬µÚÈýµµ×îµÍ»÷É±ÊýÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶þµµÍê³É£¬µÚÈýµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "É³»ê", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈýµµ»÷É±ÊýÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "É³»ê", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 1501) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					end
--				end
--			end
--		end
--		
--		PlayerIndex = oldPlayer
--	else
--		--local killNum = GetTaskWord(Task_Peace_Process, 2)
--		if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 1) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then 
--			
--			
--			local killNum = GetTaskWord(Task_Peace_Process, 2)
--			if ((HaveIBBuff(BuffIndex) > 0) ) then
--				killNum = killNum + 1
--				SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊýÐèÒªÐÞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊýÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "É³»ê", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊýÁ¿£¬µÚ¶þµµ×îµÍ»÷É±ÊýÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶þµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "É³»ê", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶þµµ»÷É±ÊýÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "É³»ê", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶þµµ»÷É±ÊýÁ¿£¬µÚÈýµµ×îµÍ»÷É±ÊýÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶þµµÍê³É£¬µÚÈýµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "É³»ê", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈýµµ»÷É±ÊýÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "É³»ê", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 1501) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					end
--			end
--		end
--	end
--	
--	
--end
----²¢·þ»î¶¯ 2009/10/27
