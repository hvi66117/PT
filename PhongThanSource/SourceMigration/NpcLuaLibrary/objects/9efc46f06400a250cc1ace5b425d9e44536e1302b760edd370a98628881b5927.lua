function OnDeath(npcidx)
    SetGlobalValue(110, 0)
    local i = GetName()
    AddGlobalCountNews("H¬i thë cña <c=g>Ly Long<c> ®· t¾t, c¸nh cña nã treo trªn <c=g>" .. i .. "<c>.", 20)

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 2)--ÊÀ½çÊÂ¼ş´´½¨
        WriteLog("S¸ng lËp mét sù kiÖn thÕ giíi")
    else
        local prog = GetWorldEventProgress(1)
        if (prog < 3) then
            --3Ê±,Ë¢npc,5Ê±Ë¢ÍêÉùÍû 6Ê±ÒÑ¾­¿ªÆô,
            beginWorldevent()--ÊÀ½çÊÂ¼ş¿ªÆô
        elseif (prog == 5) then
            if (GetTaskByte(1296, 1) >= 1) then
                --? ÊÇ·ñÔÚÑş³ØÎåÏÔÁé¹Ù±¨Ãû
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
    local sDeathday = GetWorldEventValue(1, 1)--Ğ¡ÁúËÀÍöÊ±¼ä
    local today = floor(LocalSystemTime() / 86400)
    if (sDeathday == today) then
        SetWorldEventValue(1, 2, today)
    else
        WriteLog("Ly Long: ch­a theo thø tù ®¸nh b¹i ")
    end
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
    WriteLog("Trang bŞ cam cao cÊp: rít trang bŞ tr¾ng" .. nFlag .. ",npcID:Ly Long")
end
--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end