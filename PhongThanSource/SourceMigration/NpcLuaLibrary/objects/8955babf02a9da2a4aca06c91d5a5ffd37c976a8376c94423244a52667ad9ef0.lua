--ÖòÒõÉñÚæÈªµÄËÀÍö½Å±¾

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

--add by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ
BanQuan = 1498        --1Byte,ÈÎÎñ×´Ì¬£¬0Î´½ÓÈÎÎñ£¬1½ÓÊÜÁËÓÂÊ¿Ö®»êÈÎÎñ£¬2Ìá½»ÁËÓÂÕßÖ®»êÈÎÎñºó
--2Byte£¬5¸öNPCµÄ×´Ì¬¡£ÒÑÍê³ÉµÄÏàÓ¦bitÖÃÎª1£¨ÓÂÕßÖ®»ê£©
--2Byte£¬ÊÇ·ñÒÑ¾­»ñµÃ¿ø¼×ºÍĞø¹ÇÉú¼¡Á«£¬1bitÒÂ¼×£¬2bitĞø¹ÇÉú¼¡Á«£¨×îºóĞÄÔ¸£©
--3Byte£¬1±íÊ¾ÕÒ¼§Ğş·â£¬2±íÊ¾ÕÒ½ªØ®Îı
Curr_HeroNPC_idx = 1499 --Íæ¼ÒÕÙ»½³öµÄµ±Ç°NPCµÄIdx,ÓÃÓÚÅĞ¶ÏÍæ¼ÒÕÙ»½³öµÄNPCÊÇ·ñ´æÔÚ
Curr_HeroNPC_ID = 1500    --Íæ¼ÒÕÙ»½³öµÄµ±Ç°NPCµÄIdx
--end by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:ÓÂÕßÖ®»ê

---³ÁÃßÖ®ÑÛ
Task_eye_renwu = 1530 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2Ñ°µã3Ê±¼äµ½Ê§°Ü£¬4·ÅÁú»ê5·Å£¬Ê§°Ü 4byte ÅàÑø¶È£¨µØµãĞòºÅ1-5£©

----------------------- Added by yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ---------------------------
Task_xianmo_wdjx = 1542        -- 1byte: µ±Ç°ÈÎÎñ½ø¶È   0Î´ÁìÈ¡£¬1ÒÑ¾­ÁìÈ¡£¬2ÒÑ¾­½»ÈÎÎñ
-- 2byte: ½ñÌìÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊı
-- 3byte: ¼ÇÂ¼Ó¦¸ÃÈ¥µÄÁú¶ÕĞòºÅ£¬Ë³Ğò¼ûDragonNpcs
-- 4byte: ¼ÇÂ¼ÈÕÆÚ
Task_info_xian = 1097        -- ÎÈ¶¨¾üĞÄÏÉtaskinfoĞòºÅ
Task_info_mo = 1098        -- ÎÈ¶¨¾üĞÄÄ§taskinfoĞòºÅ
----------------------- End of add yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ---------------------------
function OnDeath(npcidx)
    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcidx)--À¶¹ÖÊôĞÔ
    local mob_lvl = GetNpcLevel(npcidx) --¹ÖÎïµÈ¼¶
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcidx, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end
    --add by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£ºÓÂÕßÖ®»ê
    if (GetTaskByte(BanQuan, 1) == 1 and GetTaskByte(BanQuan, 2) < 31 and HaveIBBuff(749) == 0) then
        ---------------------¾ßÓĞËÍÎïÆ·µÄbuffÊ±²»ÄÜË¢³öĞÂµÄNPC
        HeroSoul(npcidx)
    end
    --end by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:ÓÂÕßÖ®»ê

    --add by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£º×îºóĞÄÔ¸
    if (GetTaskByte(BanQuan, 1) == 4 and GetTaskBit(BanQuan, 11) == 0) then
        ---------------------¾ßÓĞËÍÎïÆ·µÄbuffÊ±²»ÄÜË¢³öĞÂµÄNPC
        LastWish()
    end
    --end by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:×îºóĞÄÔ¸

    ---³ÁÃßÖ®ÑÛ--add yao xin by 2009/08/11 -----
    if (GetTaskByte(Task_eye_renwu, 3) == 1) then
        sleepeye()
    end
    ---³ÁÃßÖ®ÑÛ--add yao xin by 2009/08/11 -----

    --- added by yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ ---
    if (GetTaskByte(Task_xianmo_wdjx, 1) == 1) then
        if (HaveIBBuff(789) == 0) then
            Msg2Player("B¹n kh«ng mang theo <Ngäc Thanh Ch©n Khİ>, Th¸nh §Şa B¸ch Hîp kh«ng thÓ në ra.")
        else
            wendingjunxin(npcidx)
        end
    end
    --- end of add yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ ---


end;

--add by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£º×îºóĞÄÔ¸
function LastWish()
    if (random(1, 100) <= 15) then
        local mstr = "Kh­¬ng Ngu Tİch"
        local idx = 262
        if (GetTaskByte(BanQuan, 3) == 2) then
            mstr = "C¬ HuyÒn Phong"
            idx = 261
        end
        mstr = "T×m thÊy " .. mstr .. "-Y Gi¸p"
        ClearItem(4, idx, 0, 1)
        AddNormalItem(4, idx, 0, 1, 0, 0)
        ------------------------------Ìí¼ÓÒÂ¼×µÀ¾ß
        TopMessage(mstr)
        Msg2Player(mstr)
        SetTaskBit(BanQuan, 11, 1)

        SetTaskNote()
    end
end

function SetTaskNote()
    local otherMsg = ""
    local NpcName = "C¬ HuyÒn Phong"
    local NpcName1 = "Y Gi¸p C¬ HuyÒn Phong"
    local NpcName2 = "Y Gi¸p Kh­¬ng Ngu Tİch"
    local Npc1Pos = "<c=g>[246,236]<c>"            --¼§Ğş·âÄ¹
    local Npc2Pos = "<c=g>[210,201]<c>"            --½ªØ®ÎıÄ¹
    local strPos = "[76,238,237]\">"

    if (GetTaskByte(BanQuan, 1) == 4) then
        if (GetTaskByte(BanQuan, 3) == 2) then
            otherMsg = ", Y Gi¸p C¬ HuyÒn Phong ®· bŞ mÊt, nhÊt ®Şnh lµ do <c=g>Chóc ThÇn<c> ë gÇn ®©y lÊy ®i."
            strPos = "[76,212,204]\">"
        else
            otherMsg = ", Y Gi¸p Kh­¬ng Ngu Tİch ®· bŞ mÊt, nhÊt ®Şnh lµ do <c=g>Chóc ThÇn<c> ë gÇn ®©y lÊy ®i."
        end
    end

    if (GetTaskByte(BanQuan, 3) == 2) then

        NpcName1 = "Y Gi¸p Kh­¬ng Ngu Tİch"
        NpcName2 = "Y Gi¸p C¬ HuyÒn Phong"
        NpcName = "Kh­¬ng Ngu Tİch"
        Npc2Pos = "<c=g>[246,236]<c>"            --¼§Ğş·âÄ¹
        Npc1Pos = "<c=g>[210,201]<c>"            --½ªØ®ÎıÄ¹
    end

    local bit1 = GetTaskBit(BanQuan, 9)
    local bit2 = GetTaskBit(BanQuan, 10)
    local bit3 = GetTaskBit(BanQuan, 11)

    if (bit1 == 1 and bit2 == 1 and bit3 == 1) then
        TaskNote(1087, 3, "<HyperLinkWorldPos=\"" .. NpcName .. strPos)
        return
    end

    if (bit1 == 0 and bit2 == 0 and bit3 == 0) then
        TaskNote(1087, 4, NpcName2)
        return
    end

    local str1 = ""        --ÒÑ¾­ÕÒµ½µÄ¶«Î÷
    local str2 = ""        --Ã»ÕÒµ½µÄ¶«Î÷

    if (bit1 == 1) then
        str1 = NpcName1
    end

    if (bit2 == 1) then
        if (str1 ~= "") then
            str1 = str1 .. ", Tôc Cèt Sinh C¬ Liªn"
        else
            str1 = "Tôc Cèt Sinh C¬ Liªn"
        end
    end

    if (bit3 == 1) then
        if (str1 ~= "") then
            str1 = str1 .. "," .. NpcName2
        else
            str1 = NpcName2
        end
        otherMsg = ""
    end
    --Ã»ÕÒµ½µÄ¶«Î÷
    if (bit1 == 0) then
        str2 = NpcName1 .. Npc1Pos
    end

    if (bit2 == 0) then
        if (str2 ~= "") then
            str2 = str2 .. ", Tôc Cèt Sinh C¬ Liªn <c=g>[225,226]<c>"
        else
            str2 = "Tôc Cèt Sinh C¬ Liªn <c=g>[225,226]<c>"
        end
    end

    if (bit3 == 0) then
        if (str2 ~= "") then
            str2 = str2 .. "," .. NpcName2 .. Npc2Pos
        else
            str2 = NpcName2 .. Npc2Pos
        end
    end

    TaskNote(1087, 2, str1, str2, otherMsg)
end
--end by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£º×îºóĞÄÔ¸

--add by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£ºÓÂÕßÖ®»ê
function HeroSoul(npcidx)
    local id, x, y = GetNpcWorldPos(npcidx)--npcµÄÎ»ÖÃ
    if (id ~= 76) then
        --------------------------²»ÔÚÚæÈªÊ¥µØ£¬ÎŞĞ§
        return
    end
    local heroNpc_idx = GetTask(Curr_HeroNPC_idx)
    local heroNpc_ID = GetTask(Curr_HeroNPC_ID)

    --NPCÓëÍæ¼ÒÊÇÏà»¥°ó¶¨µÄ£¬Íæ¼ÒÈÎÎñ±äÁ¿ÉÏ°ó¶¨ÁËNPCµÄidxºÍID£¬¶øNPCµÄµÚÒ»¸öÈÎÎñ±äÁ¿°ó¶¨ÁËÍæ¼ÒµÄID
    if (heroNpc_idx ~= 0 and GetNpcID(heroNpc_idx) == heroNpc_ID and GetNpcTask(heroNpc_idx, 1) == GetPlayerID()) then
        --Íæ¼ÒµÄNPC»¹´æÔÚ
        ScrollMessage("Dòng Gi¶ Trung Hån cßn ch­a ®­îc siªu ®é, h·y ®i gióp nã hoµn thµnh t©m nguyÖn!")
        --ÌáÊ¾Íæ¼ÒËûµÄNPC»¹´æÔÚ£¿
        return
    end

    if (random(1, 5) ~= 2) then
        --²»ÔÚ20%·¶Î§ÄÚ
        --ScrollMessage("ÓÂÕßÖ®»ê»¹Ã»ÓĞ³öÏÖ£¬Çë¼ÌĞøÅ¬Á¦£¡")
        return
    end

    --Ëæ»ú¼Ó³öÏÂÒ»¸öNPC
    local status = GetTaskByte(BanQuan, 2)

    local k = 0

    if (status == 30) then
        k = 1
    elseif (status == 29) then
        k = 2
    elseif (status == 27) then
        k = 3
    elseif (status == 23) then
        k = 4
    elseif (status == 15) then
        k = 5
    end

    if (k ~= 0) then
        --Ìí¼Ó¸ÃNPC
        local nidx = AddNpc(1160, 1, SubWorld, x * 32, y * 32)--------Ìí¼ÓÄ¿±êNPC

        SetNpcTimer(nidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)
        SetNpcScript(nidx, "\\script\\ÁúÌ×\\¶Ô»°ÓÂÕßÖ®»ê.lua")
        SetNpcTask(nidx, 1, GetPlayerID())
        SetNpcTask(nidx, 2, k)                --¼ÇÂ¼NPCµÄ±àºÅ£¬³¬¶È³É¹¦ÓÃÓÚÖÃÈÎÎñ±äÁ¿ÏàÓ¦µÄbit£¬ËùÓĞÎå¸öNPC¼ÓÆğÀ´ÒÔºó¾ÍµÈÓÚ31ÁË£¬¾ÍÍê³ÉÀ²

        --Íæ¼ÒÉíÉÏ°ó¶¨NPC
        SetTask(Curr_HeroNPC_idx, nidx)
        SetTask(Curr_HeroNPC_ID, GetNpcID(nidx))
        ScrollMessage("Dòng Gi¶ Trung Hån ®· xuÊt hiÖn!")
        -------------------------------------ĞŞ¸Ä¶Ô°×
        Msg2Player("Dòng Gi¶ Trung ®· xuÊt hiÖn!")
        return
    end

    repeat
        local i = random(1, 5)
        --1bit£º¶Ô»°npc1£¬2bit£º¶Ô»°NPC2£¬3bit£ºÕ½¶·npc1£¬4bit£ºÕ½¶·npc2£¬5bit£ºÎïÆ·npc£¬Íê³ÉÏàÓ¦NPCµÄÈÎÎñÔòÖÃÏàÓ¦Î»Îª1
        if (GetTaskBit(BanQuan, i + 8) == 0) then
            --------Ö¤Ã÷µÚiÎ»Îª0£¬¼´¸ÃNPC»¹Ã»ÓĞ³¬¶È³É¹¦
            --Msg2Player("AddNPC")
            --Ìí¼Ó¸ÃNPC
            local nidx = AddNpc(1160, 1, SubWorld, x * 32, y * 32)--------Ìí¼ÓÄ¿±êNPC

            SetNpcTimer(nidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 180)
            SetNpcScript(nidx, "\\script\\ÁúÌ×\\¶Ô»°ÓÂÕßÖ®»ê.lua")
            SetNpcTask(nidx, 1, GetPlayerID())
            SetNpcTask(nidx, 2, i)                --¼ÇÂ¼NPCµÄ±àºÅ£¬³¬¶È³É¹¦ÓÃÓÚÖÃÈÎÎñ±äÁ¿ÏàÓ¦µÄbit£¬ËùÓĞÎå¸öNPC¼ÓÆğÀ´ÒÔºó¾ÍµÈÓÚ31ÁË£¬¾ÍÍê³ÉÀ²

            --Íæ¼ÒÉíÉÏ°ó¶¨NPC
            SetTask(Curr_HeroNPC_idx, nidx)
            SetTask(Curr_HeroNPC_ID, GetNpcID(nidx))
            ScrollMessage("Dòng Gi¶ Trung Hån ®· xuÊt hiÖn!")
            -------------------------------------ĞŞ¸Ä¶Ô°×
            Msg2Player("Dòng Gi¶ Trung Hån ®· xuÊt hiÖn!")
            break                                ------------³É¹¦Ìí¼ÓNPCºóÌø³ö¸ÃËÀÑ­»·
        end

        k = k + 1
    until k >= 100

end;
--end by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:ÓÂÕßÖ®»ê

---³ÁÃßÖ®ÑÛ--add yao xin by 2009/08/11 -----
function sleepeye()
    if (HaveIBBuff(764) > 0) then
        local nums = GetTaskByte(Task_eye_renwu, 4) + 8
        SetTaskByte(Task_eye_renwu, 4, nums)
        ScrollMessage("Møc ch¨m sãc To¸i phiÕn t¨ng 8%")
        if (nums >= 100) then
            SetTaskByte(Task_eye_renwu, 3, 2)
            ScrollMessage(" ®· chøa ®Çy linh khİ!")
            SetTaskByte(Task_eye_renwu, 4, random(1, 5))
            RemoveIBBuff(764)
            if (GetJusticEvilCredit() < 0) then
                TaskNote(116, 1)
            else
                TaskNote(115, 1)
            end
        end
    else
        SetTaskByte(Task_eye_renwu, 3, 3)
        if (GetJusticEvilCredit() < 0) then
            TaskNote(116, 5)
        else
            TaskNote(115, 5)
        end
    end
end
---³ÁÃßÖ®ÑÛ--add yao xin by 2009/08/11 -----

--- added by yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ ---
function wendingjunxin(npcidx)
    local DragonNpcs = {
        [1] = { x = 1944, y = 3568, name = "Gß Thæ Long" },
        [2] = { x = 1904, y = 3376, name = "Gß Háa Long" },
        [3] = { x = 1680, y = 3408, name = "Gß B¨ng Long" },
        [4] = { x = 1752, y = 3536, name = "Gß L«i Long" },
    }
    if ((isrightarea(npcidx, 1) == 1) or (isrightarea(npcidx, 2) == 1) or (isrightarea(npcidx, 3) == 1) or (isrightarea(npcidx, 4) == 1)) then
        local dragonidx = GetTaskByte(Task_xianmo_wdjx, 3)
        if (isrightarea(npcidx, dragonidx) == 1) then
            -- ÁÔÉ±Ìõ¼ş·ûºÏ
            local probability = random(1, 100)
            if (probability <= 20) then
                local w, x, y = GetNpcWorldPos(npcidx)
                local idx = AddNpc(1246, 1, SubWorld, x * 32, y * 32)

                if (idx ~= 0) then
                    SetNpcTask(idx, 1, GetPlayerID())
                    SetNpcName(idx, "Th¸nh §Şa B¸ch Hîp")
                    SetNpcScript(idx, "\\script\\ÚæÈªÊ¥µØ\\Ê¥µØ°ÙºÏ.lua")
                    SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 30)
                    Msg2Player("Th¸nh §Şa B¸ch Hîp ®· në, xin h·y nhanh chãng thu ho¹ch!")
                    ScrollMessage("Th¸nh §Şa B¸ch Hîp ®· në, xin h·y nhanh chãng thu ho¹ch!")
                end
            else
                Msg2Player("Dï ®· ®¸nh b¹i yªu ma, nh­ng B¸ch Hîp vÉn ch­a në!")
            end
        else
            Msg2Player("N¬i ®©y B¸ch Hîp ch­a në, h·y sang n¬i kh¸c xem sao!" .. DragonNpcs[dragonidx].name .. "Thu thËp B¸ch Hîp l©n cËn.")
        end

    else
        Msg2Player("N¬i ®©y linh khİ sung m·n, cã thÓ trång ®­îc Th¸nh Hoa.")
    end
end

function isrightarea(npcidx, dragonidx)
    local DragonNpcs = {
        [1] = { x = 1944, y = 3568, name = "Gß Thæ Long" },
        [2] = { x = 1904, y = 3376, name = "Gß Háa Long" },
        [3] = { x = 1680, y = 3408, name = "Gß B¨ng Long" },
        [4] = { x = 1752, y = 3536, name = "Gß L«i Long" },
    }
    local w, x, y = GetNpcWorldPos(npcidx)
    local distance = floor((x - DragonNpcs[dragonidx].x) ^ 2 + (y - DragonNpcs[dragonidx].y) ^ 2)
    if (distance <= 400) then
        return 1
    end
    return 0
end
--- end of add yangtao 2009.9.1 ÎÈ¶¨¾üĞÄ ---