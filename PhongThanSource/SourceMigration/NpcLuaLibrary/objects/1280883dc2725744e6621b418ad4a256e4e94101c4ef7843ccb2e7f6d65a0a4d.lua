--description: Â½Îá´óÉñ
--author: yaoxin
--date: 2008/07/23

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒı»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊı;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊıÎªÏÉ,Å¼ÊıÎªÄ§
Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊı 2=³õÊ¼ÏµÊıx 3=µ±Ç°Ôö³¤ÏµÊı(Y)
Task_xianmo_npcIndex = 1299    -- °ó¶¨µÄNpcIndex
Task_xianmo_npcID = 1300    -- °ó¶¨µÄNpcID
Task_faery = 1301 --1word  x×ø±ê   2word y×ø±ê

--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®²É¼¯ÈÎÎñ at 2010.1.5 Begin
Task_Count = 1665     --1Byte: ÈÎÎñÀàĞÍ
--2Byte£ºÒÑÁÔÉ±ÊıÁ¿
--3Byte: 1´ú±íÊÇÍ½µÜ 2´ú±íÊ¦¸µ
--4byte: 1ÒÑ¾­ÕĞ³öboss 2ÈÎÎñÊ§°Ü 3ÈÎÎñ³É¹¦
Forbidden_Buff = 1242  --ÓĞ´ËBuff²»ÄÜ½øÈë³µÄÚ
Task_CarID = 1667  --²É¼¯³µµÄNpcID
Task_Carriagenpcidx = 1666  --²É¼¯³µµÄNpcIndex
--Add By Guoqun for ¸ß¼¶Ê¦ÃÅÖ®²É¼¯ÈÎÎñ at 2010.1.5 End

npc_name = {
    [49] = "§íi Tr¹i",
    [50] = "Lôc Ng« ThÇn"
}

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
        local i = GetLevel() - 100
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
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(858) > 0) then
                liesha_city(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(858) > 0) then
            liesha_city(w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 50)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (HaveIBBuff(493) > 0) and (GetByte(GetTask(Task_xianmo_renwu), 3) == 51) then
        Frenwu110(mapgid, px, py)--ÏÉÄ§ÉùÍû ³à¾«×Ó£¨»ò¸ßÃ÷) --110Ö÷Ïßºó
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

    if (type1 == 50 and count1 > 0) then
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
    elseif (type2 == 50 and count2 > 0) then
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

function no()
    CloseDialog()
end;

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
                TopMessage("Th¶ thµnh c«ng linh hån Lôc Ng« ThÇn")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Lôc Ng« ThÇn ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Lôc Ng« ThÇn", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Lôc Ng« ThÇn ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Lôc Ng« ThÇn")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Lôc Ng« ThÇn ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Lôc Ng« ThÇn", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Lôc Ng« ThÇn ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
-- 4 Byte ÈÎÎñ²½Öè£¬0 Î´¿ªÊ¼£¬1ÏÉ½Ó£¬2Ä§½Ó£¬3ÏÉ·Åá¦£¬4Ä§·Åá¦£¬5 ÏÉ·Å»ê£¬6Ä§·ÅÆÇ, 7ÏÉÊ¹ÓÃÒı»êÏã,8Ä§Ê¹ÓÃÔ¦ÆÇÖé,9ÏÉÒ½Éú,10Ä§Ò½Éú
--Task_xianmo_renwu = 1297 --1byte Ê±¼ä; 2byte ´ÎÊı;3byte µØÍ¼ºÅ;4byte Íê³ÉµÄ½ø¶È ÆæÊıÎªÏÉ,Å¼ÊıÎªÄ§
--Task_xianmo_npc = 1298 --1=´ò¹Ö¸öÊı 2=³õÊ¼ÏµÊıx 3=µ±Ç°Ôö³¤ÏµÊı(Y)
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
        Msg2Player("C¸c qu¸i vËt bŞ tiªu diÖt kh«ng ë trong ph¹m vi Chó TrËn, kh«ng thÓ thu ®­îc hå ph¸ch.")
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
