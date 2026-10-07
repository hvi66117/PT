--description: Ä§ÇÕÔ­É½
--author: yaoxin
--date:2009/3/10

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàĞÍ(Ç¬1,¶Ò2,Àë3,Õğ4,Ùã5,¿²6,ôŞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåĞÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ĞèÉ±(ÊÕ)¸öÊı 2byte Êµ¼Ê¸öÊı
--ôŞ,Ùã ÎªÕĞ³ö¹ÖÎïµÄnpcidx

function OnDeath(npcidx)
    local pid = GetNpcTask(npcidx, 1)
    if (GetPlayerID() == pid) then
        if (GetTaskByte(gua8_renwu, 3) == 2) and (GetTaskByte(gua8_renwu, 4) == 7) then
            Msg2Player("B¹n ®· tiªu diÖt Ma Kh©m Nguyªn (S¬n), h·y vÒ b¸o tin cho Chóc Dung!")
            SetTask(gua8_task, 0)
            SetTaskByte(gua8_renwu, 3, 3)
            TaskNote(97, 1)
            DelNpc(npcidx)
            return
        end
    end
    ----lijing09-9-24
    local oldPlayer = PlayerIndex
    PlayerIndex = GetNpcTask(npcidx, 2)

    if (GetPlayerID() == pid) then
        --Ê§°ÜÔÙÕÙ»½Ò»´Î
        SetTaskByte(gua8_renwu, 4, 7)
        SetTaskByte(gua8_renwu, 3, 2)
        SetTask(gua8_task, 0)
        Msg2Player("Ma Kh©m Nguyªn (S¬n) cña b¹n bŞ ng­êi kh¸c tiªu diÖt, tiÕp tôc hµng phôc Ma Kh©m Nguyªn sÏ khiÕn Ma Kh©m Nguyªn (S¬n) xuÊt hiÖn.")
        TaskNote(97, 12)
    end

    PlayerIndex = oldPlayer
    DelNpc(npcidx)
end;