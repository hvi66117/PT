--description: ÉÝ±È·òÈË
--author: yaoxin
--date: 2008/07/23

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ð¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ð¡ÊÔ

--Byte1 ¿ªÆôÈýÏÉµºµÄÈÎÎñ±äÁ¿ Byte2 ¿ªÆôÈýÏÉµºÐèÒªÏûÃð¹ÖÎïµÄÊýÁ¿
Task_SXD_KaiQi = 1146
--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó-- ÈÎÎñ×´Ì¬±äÁ¿
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒý»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊý;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊýÎªÏÉ,Å¼ÊýÎªÄ§
Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊý 2=³õÊ¼ÏµÊýx 3=µ±Ç°Ôö³¤ÏµÊý(Y)
Task_xianmo_npcIndex = 1299    -- °ó¶¨µÄNpcIndex
Task_xianmo_npcID = 1300    -- °ó¶¨µÄNpcID
Task_faery = 1301 --1word  x×ø±ê   2word y×ø±ê

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®²É¼¯ÈÎÎñ at 2010.1.5 Begin
Task_Count = 1665     --1Byte: ÈÎÎñÀàÐÍ
--2Byte£ºÒÑÁÔÉ±ÊýÁ¿
--3Byte: 1´ú±íÊÇÍ½µÜ 2´ú±íÊ¦¸µ
--4byte: 1ÒÑ¾­ÕÐ³öboss 2ÈÎÎñÊ§°Ü 3ÈÎÎñ³É¹¦
Forbidden_Buff = 1242  --ÓÐ´ËBuff²»ÄÜ½øÈë³µÄÚ
Task_CarID = 1667  --²É¼¯³µµÄNpcID
Task_Carriagenpcidx = 1666  --²É¼¯³µµÄNpcIndex
--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®²É¼¯ÈÎÎñ at 2010.1.5 End

npc_name = {
    [47] = "Ma N÷",
    [49] = "§íi Tr¹i",
    [50] = "Lôc Ng« ThÇn"
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý
function OnDeath(npcindex)
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ
    local tRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1) --¶«å­µº¿ªÆôÈÎÎñ ½øÐÐµÄ½×¶Î2Íê³É1Î´
    local tRenWuBuff = HaveIBBuff(404) --¶«å­µº¿ªÆôÈÎÎñ

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØÐÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 95
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
            if (GetTask(858) > 0) then
                liesha_city(w)
            end

            ---¶«å­µº¿ªÆôÈÎÎñ

            -- add by mayining 2009.6.1 for ¶«å­µº¿ªÆôÓÅ»¯£¬Ö»ÒªÓÐÈÎÎñµÄÍæ¼Ò¶¼¹²Ïí
            local tTeamRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1) --¶«å­µº¿ªÆôÈÎÎñ ½øÐÐµÄ½×¶Î2Íê³É1Î´
            local tTeamRenWuBuff = HaveIBBuff(404) --¶«å­µº¿ªÆôÈÎÎñ

            if (tTeamRenWuBuff > 0) and ((tTeamRenWu == 1) or (tTeamRenWu == 2)) then
                SXD_KaiQi_kill(w)
            end
            -- end by mayining

        end
        PlayerIndex = oldPlayer
    else
        -- ÎÞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(858) > 0) then
            liesha_city(w)
        end

        ---¶«å­µº¿ªÆôÈÎÎñ
        if (tRenWuBuff > 0) and (tRenWu == 1) then
            SXD_KaiQi_kill(w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 49)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (HaveIBBuff(493) > 0) then
        local xianmo_m = GetByte(GetTask(Task_xianmo_renwu), 3)
        if (xianmo_m == 50) or (xianmo_m == 51) then
            Frenwu110(mapgid, px, py)--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
        end
    end

    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 begin
    if (mapgid == 51 and GetTaskByte(Task_Count, 1) == 17 and IsMantlePrentice(PlayerIndex) > 0 and GetNpcID(GetTask(Task_Carriagenpcidx)) == GetTask(Task_CarID) and GetTask(Task_CarID) ~= 0 and GetTaskByte(Task_Count, 1) == 17) then
        if (HaveIBBuff(Forbidden_Buff) == 0) then
            AddIBBuff(Forbidden_Buff)
        end
    end
    --¸ß¼¶Ê¦ÃÅÑ­»·ÈÎÎñ Add By guoqun at 2009.12.7 end
end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 858
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 49 and count1 > 0) then
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
    elseif (type2 == 49 and count2 > 0) then
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

---¶«å­µº¿ªÆôÈÎÎñ
function GetKillNum()
    local nKillNum1 = GetByte(GetTask(Task_SXD_KaiQi), 2)
    local nKillNum2 = GetByte(GetTask(Task_SXD_KaiQi), 3)

    if (nKillNum1 >= 254 and nKillNum2 ~= 0) then
        nKillNum1 = nKillNum2 + nKillNum1
    end

    return nKillNum1
end

function SetKillNum(nKillNum)
    if (nKillNum > 254) then
        SetTask(Task_SXD_KaiQi, SetByte(SetByte(GetTask(Task_SXD_KaiQi), 2, 254), 3, nKillNum - 254))
    else
        SetTask(Task_SXD_KaiQi, SetByte(GetTask(Task_SXD_KaiQi), 2, nKillNum))
    end
end

function SXD_KaiQi_kill(WorldID)
    if (GetLevel() < 92) or (HaveIBBuff(404) == 0) then
        return 0
    end

    local tRenWu = GetByte(GetTask(Task_SXD_KaiQi), 1)
    if (tRenWu == 1) then
        local wSB, xSB, ySB = GetWorldPos()
        if (wSB == WorldID) then
            local tKillNUM = GetKillNum()
            if (tKillNUM < 499) then
                local shenyu = 500 - tKillNUM - 1
                SetKillNum(tKillNUM + 1)
                ScrollMessage("B¹n cßn ph¶i tiªu diÖt  " .. shenyu .. "§íi Tr¹i!")
                TaskNote(57, 1, tKillNUM + 1)
            else
                SetKillNum(tKillNUM + 1)
                SetTask(Task_SXD_KaiQi, SetByte(GetTask(Task_SXD_KaiQi), 1, 2))
                ScrollMessage("B¹n ®· tiªu diÖt ®ñ sè §íi Tr¹i!")
                Msg2Player("B¹n ®· tiªu diÖt ®ñ sè §íi Tr¹i!")
                TaskNote(57, 2)
            end
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
                TopMessage("Th¶ thµnh c«ng linh hån cña §íi Tr¹i")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", §íi Tr¹i ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "§íi Tr¹i", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", §íi Tr¹i ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña §íi Tr¹i")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. §íi Tr¹i ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "§íi Tr¹i", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. §íi Tr¹i ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒý»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
--Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊý;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊýÎªÏÉ,Å¼ÊýÎªÄ§
--Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊý 2=³õÊ¼ÏµÊýx 3=µ±Ç°Ôö³¤ÏµÊý(Y)
--Task_xianmo_npcIndex	= 1299	-- °ó¶¨µÄNpcIndex
--Task_xianmo_npcID = 1300	-- °ó¶¨µÄNpcID
--Task_faery = 1301 --1word  x×ø±ê   2word y×ø±ê
function Frenwu110(nm, nx, ny)
    local nums = GetTaskByte(Task_xianmo_npc, 1) + 1
    if (nums > 50) then
        RemoveIBBuff(493)
        return 0
    end

    local px1, py1 = GetTaskWord(Task_faery, 1), GetTaskWord(Task_faery, 2)
    local rv = (nx - px1) ^ 2 + (ny - py1) ^ 2
    if (rv > 400) then
        Msg2Player("C¸c Ma vËt bÞ diÖt ®Òu kh«ng n»m trong ph¹m vi Chó trËn, kh«ng thÓ tô tËp hån ph¸ch")
        return 0
    end

    local growth = nums * GetTaskByte(Task_xianmo_npc, 3) + GetTaskByte(Task_xianmo_npc, 2)
    local ty = GetTaskByte(Task_xianmo_renwu, 4)
    if (random(1, 1000) <= growth) then
        --¸ÅÂÊ´¥·¢(Ç§·ÖÖ®)
        local newNpcName = GetName()
        local npcIdx = 0
        local Newindex = 0
        if (ty == 3) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 756)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=water>" .. newNpcName .. "_Tiªn hån<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Tô Hån trËn biÕn thµnh Tiªn hån")
                TaskNote(90, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        elseif (ty == 4) then
            Newindex = NewSiegeWeapon(nm, nx * 32, ny * 32, 782)
            npcIdx = GetSiegeWeaponNpcIndex(Newindex)
            if (npcIdx > 0) then
                newNpcName = "<c=yel>" .. newNpcName .. "_Ma ph¸ch<c>"
                TopMessage("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                Msg2Player("§· tô tËp tÊt c¶ hån ph¸ch, Gi¸ng Ma chó biÕn thµnh Ma ph¸ch")
                TaskNote(91, 2)
            else
                Msg2Player("Tô tËp Ma ph¸ch thÊt b¹i, xin h·y tiÕp tôc cè g¾ng!")
                return 0
            end
        else
            return 0
        end
        SetNpcScript(npcIdx, "\\script\\item\\worldevent\\ÏÉ»êÄ§ÆÇ.lua")
        SetNpcTimer(npcIdx, "\\script\\ontimer\\ÏÉ»êÄ§ÆÇ.lua", 300)
        SetNpcName(npcIdx, newNpcName)
        SetTask(Task_xianmo_npcIndex, npcIdx)
        SetTask(Task_xianmo_npcID, mod(GetNpcID(npcIdx), 2 ^ 31))
        SetCamp(ty)--ÏÉÀ¶3,Ä§»Æ4
        SetNpcCurCamp(npcIdx, ty)--ÏÉÀ¶3,Ä§»Æ4

        SetTaskByte(Task_xianmo_renwu, 4, (ty + 2))
        RemoveIBBuff(493)
        AddIBBuff(494)
        SetTaskByte(Task_xianmo_npc, 1, 51)
    else
        SetTaskByte(Task_xianmo_npc, 1, nums)
        growth = floor(growth / 10) --°Ù·ÖÖÆ¸ÅÂÊ
        if (mod(growth, 10) == 0) then
            Msg2Player("Chó trËn ch­a tô hîp ®ñ c¸c hån ph¸ch, h·y tranh thñ thêi gian!")
        end
        TaskNote(87 + ty, 1)
    end
end
