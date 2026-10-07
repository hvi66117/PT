--description: »Æ½ð³àÑÌÊÞ
--author: yaoxin
--date:2009/3/10

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊý 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàÐÍ(Ç¬1,¶Ò2,Àë3,Õð4,Ùã5,¿²6,ôÞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåÐÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ÐèÉ±(ÊÕ)¸öÊý 2byte Êµ¼Ê¸öÊý
--ôÞ,Ùã ÎªÕÐ³ö¹ÖÎïµÄnpcidx

function OnDeath(npcidx)

    local nTargetIndex = GetBossTargetPlayer(npcidx)

    if (nTargetIndex ~= 0) then
        PlayerIndex = NpcIdx2PIdx(nTargetIndex)
    end

    ---- modified by yaoxin at 2009-08-13
    local tTime = LocalSystemTime() - GetNpcTask(npcidx, 0)
    ---- modified by yaoxin at 2009-08-13
    WriteLog(GetName() .. "Tiªu diÖt XÝch Yªn Thó sö dông" .. tTime)

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

    AddGlobalCountNews("ThËt kh©m phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>XÝch Yªn Thó<c>!", 5)
    Msg2CurMapAnnounce("ThËt kh©m phôc! <c=g><RoleName=\"" .. GetName() .. "\"><c> chØ cÇn <c=g>" .. strTime .. "<c> ®· ®¸nh b¹i <c=yel>XÝch Yªn Thó<c>!")

    DelNpc(npcidx)
end;