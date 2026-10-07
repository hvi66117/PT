--description: ÃÀÅ®°ö
--author: yaoxin 
--date: 2008/07/29

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ð¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ð¡ÊÔ

----½µÄ§»¤µÀ------------
T_unattack = 1197 -- byte 1 ÔÂ·Ý ,2 ÈÕÆÚ,  3,Íæ¼ÒµÄµÈ¼¶, 4Ö¸¶¨µØÍ¼ºÅ, 
TUAtt_nums = 1198 --½µÄ§»¤µÀÁÔÉ±µÄ×Ü¸öÊý

npc_name = {
    [32] = "H¶i S©m",
    [35] = "Ngäc N÷",
    [39] = "TiÔn §ao thÇn",
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
    local att_pmidx = GetByte(GetTask(T_unattack), 4) --½µÄ§»¤µÀ Ö¸¶¨µØÍ¼ºÅ
    local att_pl = GetByte(GetTask(T_unattack), 3) --½µÄ§»¤µÀ Ö¸¶¨µÄ²ãÊý

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØÐÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 60
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
            if (GetTask(856) > 0) then
                liesha_city(w)
            end

            --½µÄ§»¤µÀ
            if (att_pmidx == w) or (att_pmidx - 100 == w) then
                if (PlayerIndex == oldPlayer) and (att_pmidx == w) then
                    fteam_attack(1, w)
                else
                    fteam_attack(2, w)
                end
            elseif (att_pl == 4) then
                if (att_pmidx - 1 == w) or (att_pmidx - 100 - 1 == w) then
                    if (PlayerIndex == oldPlayer) and (att_pmidx - 1 == w) then
                        fteam_attack(1, w)
                    else
                        fteam_attack(2, w)
                    end
                end
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎÞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(856) > 0) then
            liesha_city(w)
        end

        --½µÄ§»¤µÀ
        if (att_pmidx == w) then
            fteam_attack(1, w)
        elseif (att_pl == 4) and (att_pmidx - 1 == w) then
            fteam_attack(1, w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 35)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 37) and (mapgid <= 41) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    if (HaveNormalItem(3, 235, 0, 0) > 0) then
        processTaskHHEJKill()  -- ´¦Àíºß¹þ¶þ½«É±¹Ö
    end
end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
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

    if (type1 == 35 and count1 > 0) then
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
    elseif (type2 == 35 and count2 > 0) then
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

function no()
    CloseDialog()
end;

----½µÄ§»¤µÀ------------
--½µÄ§»¤µÀ modified by yaoxin for 2009-12-03
attack_nums = { [0] = -1, [1] = 30000, [2] = 50000, [3] = 80000, [4] = 80000 }
function fteam_attack(key, world)
    -- 1Îª×Ô¼º£¬ÆäËüÎª¹²ÏíÈË
    if (GetLevel() < 60) or (IsTongMember() <= 0) then
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w == world) then
        local att_pmidx = GetByte(GetTask(T_unattack), 4)
        local pl = GetByte(GetTask(T_unattack), 3)
        if (att_pmidx == world) or (pl == 4 and att_pmidx - 1 == world) then
            local nums = GetTask(TUAtt_nums) + 1
            if (key == 1) then
                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, mapname[att_pmidx], nums, attack_nums[pl])
            else
                --local r = random(1,1)--?
                --if (r == 1) then
                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, mapname[att_pmidx], nums, attack_nums[pl])
                --else
                --	return 0
                --end
            end

            if (nums >= attack_nums[pl]) then
                SetTask(T_unattack, SetByte(GetTask(T_unattack), 4, 100 + att_pmidx))
                ScrollMessage("Hé §¹o: <c=g>hoµn thµnh nhiÖm vô<c>")
                TaskNote(72, 1)
            end

            if (mod(nums, 2000) == 0) then
                fteam_luckbuff()
            end
        end
    end
end

function fteam_luckbuff()
    --½µÄ§»¤µÀËÍ½µÄ§Áî
    local fteam_list = {--µÈ¼¶·¶Î§ÏÂÏÞ buff¸øµÄ¸öÊý£¨1µµ£¬2µµ£© buff1µµ»ñµÃ¸ÅÂÊ(100)
        [1] = { 120, 1, 2, 90 },
        [2] = { 100, 1, 2, 90 },
        [3] = { 80, 1, 2, 80 },
        [4] = { 60, 1, 2, 70 },
    }
    local lvl = GetLevel()
    for i = 1, 4 do
        if (lvl >= fteam_list[i][1]) then
            local r = random(1, 100)
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
--½µÄ§»¤µÀ modified by yaoxin for 2009-12-03

------------------------------------ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶------------------------
function Frenwu31()
    --mapgid µØÍ¼ÐòºÅ
    if (GetTask(55) ~= 24) then
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
                TopMessage("May m¾n nhËn ®­îc 1 Thñy Hån")
                AddNormalItemPile(3, 24, 1, 0, 0, 0)
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
                TopMessage("Th¶ thµnh c«ng linh hån Ngäc N÷")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Ngäc N÷ ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Ngäc N÷", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Ngäc N÷ ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Ngäc N÷")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Ngäc N÷ ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Ngäc N÷", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Ngäc N÷ ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
            local level_add = { 20, 20, 15, 15, 10 }--Ç§·ÖÖ®Ò» hai
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

-- Added by zhaoqingsong at 2008-7-23 begin

-- ºß¹þ¶þ½«ÈÎÎñÉ±¹Ö,´òÄ¥¶¨ÒôÖé,·ÖÀëÃÀÅ®°ö½Å±¾Ê±,Á¬´ø±¾¶Î´úÂëÇ¨ÒÆ
function processTaskHHEJKill()
    local taskStatus = GetByte(GetTask(1233), 1)
    local fixVoiceBeadInBag = HaveNormalItem(3, 235, 0, 0)
    local n = GetTaskByte(1233, 4)
    SetTask(1233, SetByte(GetTask(1233), 4, n + 1))
    if (taskStatus ~= 1 and taskStatus ~= 2 or fixVoiceBeadInBag < 1) then
        return
    end
    local rand = random(1, 100);
    if ((GetTeamSize() < 2)) then
        if (taskStatus ~= 1 or rand > n) then
            return
        end
        SetTask(1233, SetByte(GetTask(1233), 1, 2))
        TaskNote(1013, 1)
        Msg2Player("§Þnh ¢m Ch©u ®· ®­îc mµi s¸ng!")
        TopMessage("Mµi s¸ng §Þnh ¢m Ch©u thµnh c«ng!")
    else
        ScrollMessage("Cè g¾ng thªm n÷a còng v« Ých!")
        -- local oldPlayer = PlayerIndex
        -- local memberCount = GetTeamSize()
        -- if (rand > memberCount) then
        -- return
        -- end
        -- PlayerIndex = GetTeamMember(rand)
        -- taskStatus = GetByte(GetTask(1233),1)
        -- fixVoiceBeadInBag = HaveNormalItem(3,235,0,0)
        -- if (taskStatus == 1 and fixVoiceBeadInBag >= 1) then
        -- SetTask(1233,SetByte(GetTask(1233),1,2))
        -- TaskNote(1013,1)
        -- Msg2Player("ÄãµÄ¶¨ÒôÖé´òÄ¥³É¹¦£¡")
        -- local playerName = GetName()
        -- for i = 1, memberCount do
        -- PlayerIndex = GetTeamMember(i)
        -- taskStatus = GetByte(GetTask(1233),1)
        -- fixVoiceBeadInBag = HaveNormalItem(3,235,0,0)
        -- if ((taskStatus == 1 or taskStatus == 2) and fixVoiceBeadInBag >= 1) then
        -- ScrollMessage(playerName.."µÄ¶¨ÒôÖé´òÄ¥³É¹¦£¡")
        -- end
        -- end
        -- end
        -- PlayerIndex = oldPlayer
    end
end

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
