--description: Ã÷ÒÄ
--author: yaoxin
--date:2009/3/10

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàĞÍ(Ç¬1,¶Ò2,Àë3,Õğ4,Ùã5,¿²6,ôŞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåĞÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ĞèÉ±(ÊÕ)¸öÊı 2byte Êµ¼Ê¸öÊı
--ôŞ,Ùã ÎªÕĞ³ö¹ÖÎïµÄnpcidx
boss_day = 176 --Ã¿ÌìÖ»ÓĞÒ»Ö»Ã÷ÒÄ

function OnDeath(npcidx)

    local nTargetIndex = GetBossTargetPlayer(npcidx)
    AddGlobalCountNews("<color=green>" .. GetName() .. "<color> §Õn chç <c=yel>Minh Di<c> rót vò khİ, mét luång ¸nh s¸ng tho¾t Èn tho¾t hiÖn, Minh Di ng· gôc xuèng.", 20)

    if (nTargetIndex ~= 0) then
        PlayerIndex = NpcIdx2PIdx(nTargetIndex)
    end

    ---- modified by yaoxin at 2009-08-13
    local nNowTime = LocalSystemTime()
    ---- modified by yaoxin at 2009-08-13
    local nLastTime = GetGlobalValue(boss_day)
    local tTime = nNowTime - nLastTime
    --modified by liujifang for log¼ÇÂ¼ at 2012-12-11 begin
    local nOldPlayer = PlayerIndex
    local nLogStr = ""
    local nSize = GetTeamSize()
    if (nSize >= 2 and nSize <= 12) then
        for i = 1, nSize do
            PlayerIndex = GetTeamMember(i)
            if (PlayerIndex > 0) then
                nLogStr = nLogStr .. "," .. GetName()
            end
            PlayerIndex = nOldPlayer
        end
    end
    WriteLog(GetName() .. "DiÖt trõ Minh Di dïng" .. tTime .. ", h¶o h÷u:" .. nLogStr)
    --modified by liujifang for log¼ÇÂ¼ at 2012-12-11 end

    local tSecond = mod(tTime, 60)
    local tMinite = mod(floor(tTime / 60), 60)
    local tHour = floor(tTime / 3600)
    local strTime = ""

    if (tHour > 0) then
        strTime = strTime .. tHour .. "giê"
    end

    if (tMinite > 0) then
        strTime = strTime .. tMinite .. "m"
    end

    strTime = strTime .. tSecond .. "s"

    AddGlobalCountNews("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>Minh Di<c>!", 5)
    --modified by liujifang for ÏÉÄ§½çBOSSºÍÍæ·¨µ÷Õû at 2013-1-5 begin
    Msg2CurMapAnnounce("V« cïng th¸n phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c>§· ®¸nh b¹i <c=yel> Minh Di <c>, Minh Di vÉn bá l¹i bİ b¶o dïng ph¸p thuËt trèn tho¸t. Ch­ vŞ anh hïng mau ®i dß th¸m huyÒn c¬ cña bİ b¶o, nÕu kh«ng 10 phót sau bİ b¶o sÏ vÒ tay cña Minh Di.")
    --modified by liujifang for ÏÉÄ§½çBOSSºÍÍæ·¨µ÷Õû at 2013-1-5 end
    if (GetTeam() ~= 0) then
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            AddIBBuff(543)--µØ»ğÓ¡
        end
        PlayerIndex = oldPlayer
    else
        AddIBBuff(543)--µØ»ğÓ¡
    end

    ThrowItem(npcidx, PlayerIndex, 3, 359, 0, 0, 0, 0) -- Áé¹â±¦¾µ

    --modified by liujifang for ÏÉÄ§½çBOSSºÍÍæ·¨µ÷Õû at 2013-1-5 begin
    local nMap, nMapX, nMapY = GetNpcWorldPos(npcidx)
    local nIdx = AddNpc(1941, 1, SubWorld, nMapX * 32, nMapY * 32)
    if (nIdx > 0) then
        SetNpcScript(nIdx, "\\script\\¹ÖÎï\\Ã÷ÒÄÃØ±¦.lua")
        SetNpcTimer(nIdx, "\\script\\ontimer\\É¾³ı×Ô¼º.lua", 60 * 10)
        WriteLog("Minh Di: xuÊt hiÖn bİ b¶o Minh Di.")
    end
    --modified by liujifang for ÏÉÄ§½çBOSSºÍÍæ·¨µ÷Õû at 2013-1-5 end
    DelNpc(npcidx)
end;