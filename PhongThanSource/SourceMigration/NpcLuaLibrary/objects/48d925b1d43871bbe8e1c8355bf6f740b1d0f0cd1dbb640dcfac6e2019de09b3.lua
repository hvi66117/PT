function OnDeath(npcidx)
    SetGlobalValue(111, 0)
    local i = GetName()
    AddGlobalCountNews("LiÖt diÖm cña <c=g>Di Long<c> ®· bŞ dËp t¾t, trªn vò khİ cña <c=g>" .. i .. "<c> cßn dİnh ®Çy m¸u t­¬i nãng hæi cña ThÇn Long.", 20)

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 3)--ÊÀ½çÊÂ¼ş´´½¨
        WriteLog("S¸ng lËp mét sù kiÖn thÕ giíi")
    else
        local prog = GetWorldEventProgress(1)
        if (prog < 3) then
            --3Ê±,Ë¢npc,5Ê±Ë¢ÍêÉùÍû 6Ê±ÒÑ¾­¿ªÆô,
            beginWorldevent()--ÊÀ½çÊÂ¼ş¿ªÆô
        elseif (prog == 5) then
            if (GetTaskByte(1296, 1) >= 1) then
                --ÊÇ·ñÔÚÑş³ØÎåÏÔÁé¹Ù±¨Ãû
                beginWorldevent()--µØÍ¼¿ªÆô
            else
                WriteLog("Ng­¬i ch­a b¸o danh s¸t Rång")
            end
        end
    end
    --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
    Throw_Equip(npcidx, PlayerIndex)
    --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end

    DelNpc(npcidx)
end;

--------------------------ÊÀ½çÊÂ¼ş---------------------
--nEventID 1 : ÊÀ½ç¿ªÆôÊÂ¼şÏµÁĞ
--ValueIdx ¼ûÏÂ
--1 : ´òËÀĞ¡ÁúµÄÊ±¼ä
--2 : ´òËÀÖĞÁúµÄÊ±¼ä
--3 : ´òËÀ´óÁúµÄÊ±¼ä
--Progress 1µÚÒ»ÌìË³É±3Áú 2Á¬ĞøÁ½Ìì,3 Á¬Ğø3ÌìÈÎÎñÍê³É,4Ë¢³önpc,5Ê±Ë¢ÍêÉùÍû 6Ê±ÒÑ¾­¿ªÆô,
function beginWorldevent()
    local mDeathday = GetWorldEventValue(1, 2)--ÖĞÁúËÀÍöÊ±¼ä
    local today = floor(LocalSystemTime() / 86400)
    if (mDeathday == today) then
        local Proglvl = GetWorldEventProgress(1) + 1
        if (Proglvl <= 3) then
            local bDeathday = GetWorldEventValue(1, 3)--´óÁúËÀÍöÊ±¼ä
            SetWorldEventValue(1, 3, today)
            if (bDeathday == 0) or (bDeathday ~= today - 1) then
                SetWorldEventProgress(1, 1)
                WriteLog("Sù kiÖn thÕ giíi võa b¾t ®Çu §¹i Long ®· chÕt")
                AddGlobalCountNews("Di Long tõ tõ gôc xuèng, trËn ph¸p nhèt c¸c Tiªn nh©n h×nh nh­ ®· cã chót chuyÓn ®éng", 20)
            else
                SetWorldEventProgress(1, Proglvl)
                if (Proglvl == 2) then
                    WriteLog("Ba Ma Long mét lÇn n÷a l¹i bŞ ®¸nh b¹i")
                    AddGlobalCountNews("Ba Ma Long ®· lÇn l­ît bŞ ®¸nh b¹i. TrËn ph¸p nhèt c¸c Tiªn nh©n h×nh nh­ ®· cã chót chuyÓn ®éng", 20)
                end
            end
        elseif (Proglvl == 6) then
            SetWorldEventValue(1, 3, today)
            SetWorldEventProgress(1, Proglvl)
            AddGlobalCountNews("Di Long tõ tõ gôc xuèng, ®¹i m«n ë Diªu Tr× (200,196) ®ang tõ tõ më ra.", 20)
            if (IsWorldEventExist(2) == 0) then
                CreateWorldEvent(2, 1, 0, 1)
                WriteLog("S¸ng lËp 2 sù kiÖn thÕ giíi")
            end

            if (GetTeam() ~= 0) then
                local oldPlayer = PlayerIndex
                local membercount = GetTeamSize()
                -- »ñµÃ³ÆºÅ­û
                for i = 1, membercount do
                    PlayerIndex = GetTeamMember(i)
                    if (GetTaskByte(1296, 1) >= 1) then
                        --? ÊÇ·ñÔÚÑş³ØÎåÏÔÁé¹Ù±¨Ãû
                        set_Qualify(1)--¸ø³ÆºÅ
                    end
                end
                PlayerIndex = oldPlayer
            elseif (GetTaskByte(1296, 1) >= 1) then
                --? ÊÇ·ñÔÚÑş³ØÎåÏÔÁé¹Ù±¨Ãû
                set_Qualify(1)--¸ø³ÆºÅ
            end
        else
            WriteLog("Sai råi!" .. Proglvl)
        end
    else
        WriteLog("§¹i Long: ch­a theo thø tù ®¸nh b¹i ")
    end
end

function set_Qualify(id)
    if (GetCurTitle() == 0) then
        --  »ñÈ¡µ±Ç°³ÆºÅID
        Msg2Player("Thu phôc Di Long, khai th«ng ®­êng ®Õn Tiªn Ma Giíi, nhËn ®­îc danh hiÖu: “Anh Hïng C¸i ThÕ”.")
    else
        Msg2Player("Thu phôc Di Long, khai th«ng ®­êng ®Õn Tiªn Ma Giíi, nhËn ®­îc danh hiÖu: “Anh Hïng C¸i ThÕ”. Danh hiÖu cò ®· bŞ thay thÕ! Cã thÓ ®Õn n¬i ®· nhËn tr­íc ®Ó phôc håi l¹i.")
    end

    --add by mayining 2008.10.16
    AddEvent("%s nhËn ®­îc x­ng hiÖu [Anh hïng c¸i thÕ]!", 1)
    --end

    ActiveTitleQualify(id)--¼¤»î¡°¸ÇÊÀÓ¢ĞÛ¡±
    SetCurTitle(id) --¸Ä±äµ±Ç°³ÆºÅ
end

--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 4
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do
        --¹Ì¶¨ÂÖÑ¯
        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)

        --Ëæ»úÂÖÑ¯
        if (random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bŞ cam cao cÊp: rít trang bŞ tr¾ng" .. nFlag .. ",npcID:Di Long")
end
--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end