--description: Á×Ñý
--author: yaoxin
--date: 2008/07/23

-----------jiangshanyijiu add by gongpeng at 2009.05.04---------
-- 1Byte 0Î´½øÐÐ¾íÒ»£»1 ¾íÒ»Íê³É£»2 ¾í¶þÍê³É£»3 ¾íÈýÍê³É
-- 2Byte 0³õÊ¼£»1 »ÃÏó1Íê³É£»2 »ÃÏó2Íê³É£»...ÒÀ´ÎÀàÍÆ
TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433 -- 1Byte:¼ÆÊý; 2Byte:×´Ì¬; 3Byte: ÊÇ·ñÍê³Éµ±Ç°µÄ»ÃÏë
TASK_ITEM_IDX = 1434 -- item's index, GetNpcWorldPos(GetTask(TASK_ITEM_IDX))
TASK_JS_HX_TIME = 1435 -- ÁìÈ¡µØÍ¼µÄÊ±¼ä
TASK_JS_DIST = 1436 -- ½­É½ÒÀ¾É »ÃÏó ÉÏÒ»´ÎµÄ¾àÀë
TASK_JS_COUNT = 1437 -- 1Byte: Ò³4µÄ¼ÆÊýÆ÷


Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ð¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ð¡ÊÔ

----½µÄ§»¤µÀ------------
T_unattack = 1197 -- byte 1 ÔÂ·Ý ,2 ÈÕÆÚ,  3,Íæ¼ÒµÄµÈ¼¶, 4Ö¸¶¨µØÍ¼ºÅ,
TUAtt_nums = 1198 --½µÄ§»¤µÀÁÔÉ±µÄ×Ü¸öÊý

--AS by hyz 090730 for ÖØÈëÂÖ»Ø
TASK_CRLH = 1513
TASK_GET_PROBABILITY = 2
--AE by hyz 090730 for ÖØÈëÂÖ»Ø

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ:ÁÔÉ±ÈÎÎñ at 2009.12.21 Begin

Task_Yibo = 1664      --1Byte: ±¾Ìì½ÓÈÎÎñµÄ´ÎÊý
--2Byte£º±¾ÖÜ½ÓÈÎÎñµÄ´ÎÊý
--3Byte£º×îºóÒ»´Î½ÓÈÎÎñÊÇÐÇÆÚ¼¸
--4byte: ½Óµ½µÄÈÎÎñÐòºÅ
Task_Count = 1665     --1Byte: ÈÎÎñÀàÐÍ
--2Byte£ºÒÑÁÔÉ±ÊýÁ¿
--3Byte: 1´ú±íÊÇÍ½µÜ 2´ú±íÊ¦¸µ
--4byte: 1ÒÑ¾­ÕÐ³öboss 2ÈÎÎñÊ§°Ü 3ÈÎÎñ³É¹¦
IBBuff_Kill = 1246    --20ÃëµÄbuff
IBBuff_Boss = 1245    --15·ÖÖÓµÄbuff
Boss_Index = 1670
Boss_ID = 1671

Baowu = {
    [1] = { name = "Phôc Ma Gi¶n", Item = { 4, 303, 0, 1, 0, 0 } },
    [2] = { name = "Hµng Yªu Lôc", Item = { 4, 304, 0, 1, 0, 0 } },
}

YiboTasks = {
    [1] = { taskname = "TuyÖt Long LÜnh-S¸t thñ", master = { name = "Chiªu ThÇn", id = 30 }, apprentice = { name = "L¹c C¬", id = 24 }, boss = { name = "Anh Chiªu ThÇn Qu©n", id = 30 } },
    [2] = { taskname = "NhiÖm vô S¸t thñ BÝch Du cung tÇng 1", master = { name = "Lam qu¸i", id = 38 }, apprentice = { name = "§¨ng Hån", id = 40 }, boss = { name = "Quû L©n §¨ng", id = 1730 } },
    [3] = { taskname = "NhiÖm vô Tæ ®éi s¸t thñ BÝch Du cung tÇng 2", master = { name = "L«i Tr¹ch thÇn", id = 40 }, apprentice = { name = "Lam qu¸i", id = 42 }, boss = { name = "L«i Tr¹ch Yªu", id = 1731 } },
}
--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ:ÁÔÉ±ÈÎÎñ at 2009.12.21 End

npc_name = {
    [37] = "Hµ Cèt",
    [38] = "§¨ng Hån",
    [40] = "Lam qu¸i",
    [42] = "L«i Tr¹ch thÇn",
    [43] = "D· Mao thÇn",
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
        local i = GetLevel() - 65
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

            --¹ÖÎïÄÁ³¡
            if (HaveIBBuff(360) >= 1) and (w == 43) then
                ogre_field(w)
            end

            --½µÄ§»¤µÀ
            if (att_pmidx == w) or (att_pmidx - 100 == w) then
                if (PlayerIndex == oldPlayer) and (att_pmidx == w) then
                    fteam_attack(1, w)
                else
                    fteam_attack(2, w)
                end
            elseif (att_pl == 4) and (w == 35) then
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

        --¹ÖÎïÄÁ³¡
        if (HaveIBBuff(360) >= 1) and (w == 43) then
            ogre_field(w)
        end

        --½µÄ§»¤µÀ
        if (att_pmidx == w) then
            fteam_attack(1, w)
        elseif (att_pl == 4) and (att_pmidx - 1 == w) and (w == 30) then
            fteam_attack(1, w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 40)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 32) and (mapgid <= 36) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (GetByte(GetTask(1014), 1) == 40) and (w >= 42) and (w <= 51) then
        if (GetByte(GetTask(1013), 3) == 1) then
            Frenwu75(x, y)--Òó½¼ --Ììî¸ÐÇÖ®»ê   75¼¶Ñ­»·ÈÎÎñ
        end
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    -----------jiangshanyijiu add by gongpeng at 2009.05.04 begin---------
    if ((mapgid >= 32) and (mapgid <= 36)) then
        if (GetTeam() ~= 0) then
            -- ÓÐ¶ÓÎé(°üÀ¨Ö»ÓÐ×Ô¼ºÒ»¸öÈËµÄ)
            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)

                linyao(npcindex, mapgid)
            end

            PlayerIndex = oldPlayer

        else
            -- ÎÞ¶ÓÎé
            linyao(npcindex, mapgid)

        end
    end
    -----------jiangshanyijiu add by gongpeng at 2009.05.04 end-----------

    --AS by hyz 090730 for ÖØÈëÂÖ»Ø
    if (GetLevel() >= 96) and (w >= 42) and (w <= 46) then
        if (IsHaveSpaceForTreasure(1) == 0 or GetTaskByte(TASK_CRLH, 1) > 0) then


        else
            if (HaveItemInAllRoom(6, 1, 557, 0, 0, 0, 0) == 0 and GetTaskByte(TASK_CRLH, 4) < 2) then
                local t = random(1, 100)

                if (t <= TASK_GET_PROBABILITY) then
                    SetTaskByte(TASK_CRLH, 4, 2)        --±ê¼ÇÔø¾­»ñµÃ¹ý
                    AddNormalItem(6, 1, 557, 0, 0, 0)        --»ñµÃ·û½Ú
                    Msg2Player("B¹n may m¾n nhËn ®­îc ThÎ phï.")
                    TopMessage("B¹n may m¾n nhËn ®­îc ThÎ phï.")
                end

            end

        end

    end
    --AS by hyz 090730 for ÖØÈëÂÖ»Ø
    --²¢·þ»î¶¯ 2009/10/27
    --	taskPeace()
    --²¢·þ»î¶¯ 2009/10/27

    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÁÔÉ±ÈÎÎñ at 2009.12.21 begin
    if (mapgid == 43 and GetTaskByte(Task_Count, 1) == 3 and GetTaskByte(Task_Count, 4) <= 1 and IsMantlePrentice(PlayerIndex) > 0) then
        -- Í½µÜ ±ÌÓÎ¹¬¶þ²ã
        Do_Hunttask(GetTaskByte(Task_Count, 1), 1)
    end
    if (mapgid == 42 and GetTaskByte(Task_Count, 1) == 2 and GetTaskByte(Task_Count, 4) <= 1 and IsMantleMaster(PlayerIndex) > 0) then
        -- Ê¦¸¸ ±ÌÓÎ¹¬Ò»²ã
        Do_Hunttask(GetTaskByte(Task_Count, 1), 2)
    end
    --Add By guoqun for ¸ß¼¶Ê¦ÃÅÁÔÉ±ÈÎÎñ at 2009.12.21 begin
end

function Do_Hunttask(tasknum, bShifu)
    local tBossInfo = YiboTasks[tasknum].boss
    local tHuntTargetInfo = 0
    local nHuntCount = 0
    local nHuntCount2 = 0
    local strBaowu = ""
    if (bShifu == 2) then
        --Ê¦¸µ
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
    local teamstate = Team_State(bShifu) --±ØÐëÎªÊ¦Í½×é¶ÓÇé¿öÏÂ²ÅÐÐ
    if (teamstate == 1) then
        if (GetTaskByte(Task_Count, 4) == 1) then
            local bossindex = GetTask(Boss_Index)
            local bossid = GetTask(Boss_ID)
            if (GetNpcID(bossindex) == bossid) then
                local bInArea = Check_BossDistance(bossindex)
                if (bInArea == 1) then
                    Msg2Player("Anh hïng h·y cÊp tèc ®i thu phôc" .. tBossInfo.name)
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
                        Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                    elseif (bHave1 == 0) then
                        Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
                    elseif (bHave2 == 0) then
                        local selfIdx = PlayerIndex
                        PlayerIndex = mateIdx
                        Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                        PlayerIndex = selfIdx
                    end
                else
                    if (bHave1 == 0 and bHave2 == 0) then
                        Msg2Team("B¹n kh«ng mang theo Ph¸p b¶o <c=yel>Phôc Ma Gi¶n<c> vµ <c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                    elseif (bHave1 == 0) then
                        Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo Ph¸p b¶o<c=yel>Hµng Yªu Lôc<c>, kh«ng thÓ diÖt qu¸i!")
                    elseif (bHave2 == 0) then
                        local selfIdx = PlayerIndex
                        PlayerIndex = mateIdx
                        Msg2Team("<c=g>" .. GetName() .. "<c> kh«ng mang theo <c=yel>Phôc Ma Gi¶n<c>, kh«ng thÓ diÖt qu¸i!")
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
                        --BÍê³É AÓÐ20Ãëbuff ÔòÕÙ»½ÉñÊÞ
                        --ÕÐ³öBoss£¬È»ºóÌí¼ÓÒ»¸ö10·ÖÖÓBuff, ÒÆ³ý20ÃëµÄBuff
                        callBoss(npcindex, tasknum)

                    elseif (Get_MateTaskByte(Task_Count, 2) < nHuntCount2) then
                        --¸øA¡¢BÌí¼ÓBuff AÍê³ÉÁË¶øBÃ»Íê³É
                        --¸øË«·½Ìí¼Ó20ÃëBuff
                        ScrollMessage(strBaowu .. "®· ®­îc kÝch ho¹t, h·y mau ®i thu phôc " .. tBossInfo.name)
                        TeamAction("Team_AddBuff", 0, 0, 0)
                    end
                else
                    ScrollMessage("Phôc Ma TÕ ThÕ: Cßn ph¶i tiªu diÖt " .. tHuntTargetInfo.name .. (nHuntCount - count) .. ".")
                end
            else
                ScrollMessage(strBaowu .. "®· ®­îc kÝch ho¹t, h·y mau ®i thu phôc " .. tBossInfo.name)
            end
        end
    elseif (teamstate == 5) then
        Msg2Player("§ång ®éi cña b¹n ®· hñy nhiÖm vô, xin vÒ gÆp D­¬ng TiÔn ®Ó hñy nhiÖm vô nµy!")
    end
end


--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 Begin
function callBoss(npcindex, tasknum)
    --ÕÙ»½boss
    local id, x, y = GetWorldPos()
    local bossInfo = YiboTasks[tasknum].boss
    local monsterIndex = AddNpc(bossInfo.id, 0, SubWorld, x * 32, y * 32)
    SetNpcScript(monsterIndex, "\\script\\¹ÖÎï\\Ñ­»·ÈÎÎñboss.lua")
    SetNpcTimer(monsterIndex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 60 * 15)
    SetNpcName(monsterIndex, bossInfo.name)
    SetNpcTask(monsterIndex, 1, GetPlayerID())
    SetNpcTask(monsterIndex, 2, Get_MateUUID())
    SetTask(Boss_Index, monsterIndex)        --ÈÎÎñ±äÁ¿¼ÇÂ¼¹ÖÎïindex
    SetTask(Boss_ID, GetNpcID(monsterIndex)) --ÈÎÎñ±äÁ¿¼ÇÂ¼¹ÖÎïID
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
        local tasknum = GetTaskByte(Task_Count, 1)
        local bossInfo = YiboTasks[tasknum].boss
        Msg2Player("H·y mau ®i tiªu diÖt " .. bossInfo.name .. "! B¹n chØ cã 15 phót ®Ó hoµn thµnh!")
        RemoveIBBuff(IBBuff_Kill)
        AddIBBuff(IBBuff_Boss)
        TaskNote(1519, 1, bossInfo.name)
        return
    end
    AddIBBuff(IBBuff_Kill)
end

function Team_State(nType)
    --·µ»ØÖµËµÃ÷£º1¡¢¶ÓÎéÎªÁ½ÈË¶Ó£¬ÇÒÎªÒÂ²§¹ØÏµ
    --2¡¢¶ÓÎé²»ÊÇÁ½ÈË¶Ó£¬Çë²é¿´×é¶Ó·½Ê½
    --3¡¢¶ÓÎéÊÇÁ½ÈË¶Ó£¬µ«¶ÓÓÑ²»ÊÇ×Ô¼ºµÄÒÂ²§µÜ×Ó£¨ÒÂ²§Ê¦¸¸£©
    --4¡¢×Ô¼ºÃ»ÓÐÊÕÒÂ²§µÜ×Ó(ÒÂ²§Ê¦¸¸)
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
        if (IsMantleMaster(PlayerIndex) > 0) then
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
        local strMasterName = GetName() --»ñµÃÊ¦¸¸µÄÃû×Ö
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
    --»ñµÃ¶ÔÓÐµÄUUID¡£µ÷ÓÃÇ°±ØÐëÏÈÅÐ¶ÏÊÇ²»ÊÇÁ½ÈË¶ÓÎé
    local mateIdx = Get_MatePlayerIndex()
    local selfIdx = PlayerIndex
    PlayerIndex = mateIdx
    local mateUUID = GetPlayerID()
    PlayerIndex = selfIdx
    return mateUUID
end

function Get_MatePlayerIndex()
    --»ñµÃ¶ÓÓÑµÄPlayerIndex£¬±ØÐëÊÇÁ½ÈË¶ÓÎé²Å¿ÉÒÔ
    local prindex = 0
    if (IsCaptain() == 0) then
        prindex = GetTeamMember(1)
    else
        prindex = GetTeamMember(2)
    end
    return prindex
end

function Get_TeamBuffState()
    --·µ»ØÖµ1£ºOK 2×Ô¼ºbuffÊýÄ¿Ì«¶à 3¶ÓÓÑbuffÊýÄ¿Ì«¶à 4Á½ÈËbuffÊýÄ¿Ì«¶à
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
    --·µ»ØÖµ 1£º×Ô¼ºÊÇ·ñÓÐ±¦Îï 2£ºÍ½µÜÊÇ·ñÓÐ±¦Îï 3:¶ÓÓÑµÄidx 4:selfidx
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
    --1£ºÍæ¼ÒÔÚboss 800ÏñËØ·¶Î§Ö®ÄÚ 0£º²»ÔÚ´Ë·¶Î§Ö®ÄÚ
    local nMap, nX, nY = GetNpcWorldPos(bossIdx)
    local pMap, pX, pY = GetWorldPos()

    if (nMap == pMap) then
        if ((nX - pX) ^ 2 + (nY - pY) ^ 2) <= 800 then
            return 1
        end
    end

    return 0
end

--¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end

-----------jiangshanyijiu add by gongpeng at 2009.05.04 begin---------
function linyao(idx, world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    local npcchr = GetHardNpcAttrib(idx)--À¶¹ÖÊôÐÔ

    if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1)) then
        local status = GetTaskByte(TASK_JS_BOOK2, 3)
        if (status == 5) then
            if ((npcchr >= 0) and (npcchr <= 7)) then
                jsyj1()
            end
        elseif (status == 6) then
            if ((npcchr >= 0) and (npcchr <= 7)) then
                jsyj2()
            end
        elseif (status == 7) then
            jsyj3()
        end
    end
end
-- À¶¹Ö
function jsyj1()
    if (GetTaskByte(TASK_JS_COUNT, 1) == 0) then
        SetTaskByte(TASK_JS_COUNT, 1, 1)
        FinishNpcCollection(16)
        TopMessage("Lam Qu¸i:Ng­¬i chØ hñy ho¹i th©n x¸c cña ta")
        Msg2Player("NhËn ký øc chiÕn th¾ng Lam Qu¸i tinh anh, vÒ b¸o D­ Kh¸nh")
        TaskNote(1057, 9)
    end
end

-- É±ËÀ»ÆÑªÀ¶¹Ö
function jsyj2()
    if (GetTaskByte(TASK_JS_COUNT, 1) == 0) then
        --ÌáÊ¾¸ü¸ÄÎª£º¡°¿´Ñù×ÓÏûÃðËûÃÇ²¢²»ÊÇ¸öºÃ·½·¨¡±
        Msg2Player("Tiªu diÖt nã ch­a h¼n lµ c¸ch tèt, xem L­u Ly Tr¶n nã ph­¬ng ph¸p g× hay kh«ng!")
    end
end

-- °×¹Ö
function jsyj3()
    local js_n = GetTaskByte(TASK_JS_COUNT, 1)

    if (js_n == 49) then
        SetTaskByte(TASK_JS_COUNT, 1, 50)
        FinishNpcCollection(18)
        TopMessage("Lam Qu¸i: Sao viÖn qu©n cßn ch­a tíi")
        Msg2Player("NhËn ký øc chinh phôc Lam Qu¸i, vÒ b¸o D­ Kh¸nh")
        TaskNote(1057, 9)
    elseif (js_n < 49) then
        SetTaskByte(TASK_JS_COUNT, 1, js_n + 1)
        ScrollMessage("§· tiªu diÖt " .. (js_n + 1) .. " Lam Qu¸i")
        TaskNote(1057, 8, js_n + 1)
    end
end
-----------jiangshanyijiu add by gongpeng at 2009.05.04 end-----------


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

    if (type1 == 40 and count1 > 0) then
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
    elseif (type2 == 40 and count2 > 0) then
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

--¹ÖÎïÄÁ³¡
function ogre_field(WorldID)
    local mapid = GetByte(GetTask(1077), 2)
    local w, x, y = GetWorldPos()
    if (WorldID == mapid) and (w == WorldID) then
        local kind = GetByte(GetTask(1077), 1)
        if (40 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " Lam Qu¸i")
                TaskNote(69, 0, "BÝch Du tÇng 2", "Lam qu¸i", count)
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
    if (GetTask(55) ~= 23) then
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
                TopMessage("May m¾n nhËn ®­îc 1 Phong LÖ")
                AddNormalItemPile(3, 23, 1, 0, 0, 0)
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
                TopMessage("Th¶ thµnh c«ng linh hån Lam Qu¸i")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Lam Qu¸i ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Lam qu¸i", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Lam Qu¸i ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Lam Qu¸i")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Lam Qu¸i ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Lam qu¸i", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Lam Qu¸i ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

------------------------Òó½¼ --Ììî¸ÐÇÖ®»ê   75¼¶Ñ­»·ÈÎÎñ-----------------------------
--1013 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊý£¬ 2=ÊÕ·Ñ´ÎÊý 3 = µ±Ç°½øÐÐµÄ»·½Ú,(5:60 + 1:80) 4 £½  ½ñÌì¶Ò»»½±Àø´ÎÊý
--1014 1=¹ÖÎïÐòºÅ 2=´ò¹Ö¸öÊý 3=µ±Ç°Ôö³¤ÏµÊý(Y) 4= ³õÊ¼ÏµÊýx
--1017 Ììî¸ÐÇnpc, µÄindex
function Frenwu75(x, y)
    local circle1 = GetByte(GetTask(1013), 3)
    local tgrand = random(1, 1000)
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

--------------   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶---------------------------------
--mapgid µØÍ¼ÐòºÅ
--1022 1=¹ÖÎïµØÍ¼ºÅ 2=´ò¹Ö¸öÊý
--1023 ÁéÏ¬Öµ
function Frenwu65(mapgid)
    local gmapIdx1 = GetByte(GetTask(1022), 1)
    if (gmapIdx1 == mapgid) then
        local guanKey = mod((gmapIdx1 - 22), 5) + 1

        if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then
            local level_add = { 20, 20, 15, 15, 15 }--Ç§·ÖÖ®Ò»
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
--	if (GetTask(Task_Peace_Day) ~= today) or (GetTaskByte(Task_Peace_Process, 1) ~= 2) or (GetTaskByte(Task_Peace_Process, 2) ~= 4) then
--		return
--	end
--
--	local w,x,y=GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
--	if (w ~= 35) then --ÅÐ¶Ï´ò¹ÖÊÇ·ñÔÚ¸ÃµØÍ¼
--		return 0
--	end
--
--	if (GetTeam() ~= 0) then
--		local oldPlayer = PlayerIndex
--
--		for i=1, GetTeamSize() do
--			PlayerIndex = GetTeamMember(i)
--			if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 2) and (GetTaskByte(Task_Peace_Process, 2) == 4) and (HaveIBBuff(BuffIndex) > 0) then
--
--
--				local killNum = GetTaskWord(Task_Peace_Process, 2)
--				if ((HaveIBBuff(BuffIndex) > 0) ) then
--					killNum = killNum + 1
--					SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 1300) then							--???É±¹Ö¸öÊýÐèÒªÐÞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊýÁ¿»¹²î"..(1300-killNum).."Ö»")
--						TaskNote(1501, 1, "Á×Ñý", killNum, 1300)
--					elseif (killNum == 1300) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊýÁ¿£¬µÚ¶þµµ×îµÍ»÷É±ÊýÁ¿Îª2500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶þµµ×îµÍ»÷É±2500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 2500)
--					elseif (killNum < 2500) then
--						ScrollMessage("µÚ¶þµµ»÷É±ÊýÁ¿»¹²î"..(2500-killNum).."Ö»")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 2500)
--					elseif (killNum == 2500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶þµµ»÷É±ÊýÁ¿£¬µÚÈýµµ×îµÍ»÷É±ÊýÁ¿Îª5000Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶þµµÍê³É£¬µÚÈýµµ×îµÍ»÷É±Îª5000Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 5000)
--					elseif (killNum < 5000) then
--						ScrollMessage("µÚÈýµµ»÷É±ÊýÁ¿»¹²î"..(5000-killNum).."Ö»")
--						TaskNote(1501, 4, "Á×Ñý", killNum, 5000)
--					elseif (killNum == 5000) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 5001) and (HaveIBBuff(BuffIndex) > 0) then
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
--		if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 2) and (GetTaskByte(Task_Peace_Process, 2) == 4) and (HaveIBBuff(BuffIndex) > 0) then
--
--
--			local killNum = GetTaskWord(Task_Peace_Process, 2)
--			if ((HaveIBBuff(BuffIndex) > 0) ) then
--				killNum = killNum + 1
--				SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 1300) then							--???É±¹Ö¸öÊýÐèÒªÐÞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊýÁ¿»¹²î"..(1300-killNum).."Ö»")
--						TaskNote(1501, 1, "Á×Ñý", killNum, 1300)
--					elseif (killNum == 1300) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊýÁ¿£¬µÚ¶þµµ×îµÍ»÷É±ÊýÁ¿Îª2500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶þµµ×îµÍ»÷É±2500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 2500)
--					elseif (killNum < 2500) then
--						ScrollMessage("µÚ¶þµµ»÷É±ÊýÁ¿»¹²î"..(2500-killNum).."Ö»")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 2500)
--					elseif (killNum == 2500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶þµµ»÷É±ÊýÁ¿£¬µÚÈýµµ×îµÍ»÷É±ÊýÁ¿Îª5000Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶þµµÍê³É£¬µÚÈýµµ×îµÍ»÷É±Îª5000Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "Á×Ñý", killNum, 5000)
--					elseif (killNum < 5000) then
--						ScrollMessage("µÚÈýµµ»÷É±ÊýÁ¿»¹²î"..(5000-killNum).."Ö»")
--						TaskNote(1501, 4, "Á×Ñý", killNum, 5000)
--					elseif (killNum == 5000) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊýÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏÞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏÞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 5001) and (HaveIBBuff(BuffIndex) > 0) then
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
