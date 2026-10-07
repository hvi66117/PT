--description: Ê³Ò©ÊŞ
--author: yaoxin
--date:2009/3/10

--°ËØÔÂÖ»Ø
gua8_renwu = 1340 --1byte Ê±¼ä 2byte ´ÎÊı 3byteÈÎÎñ×´Ì¬1½Ó2´ò¿ª3Íê³É 4byte ØÔµÄÀàĞÍ(Ç¬1,¶Ò2,Àë3,Õğ4,Ùã5,¿²6,ôŞ7,À¤8)
gua8_task = 1341--8ÖÖØÔµÄÈÎÎñµÄ¾ßÌåĞÅÏ¢ Èç¹ûÊÇÁÔÉ±ÊÕ¼¯, 1byte ĞèÉ±(ÊÕ)¸öÊı 2byte Êµ¼Ê¸öÊı
--ôŞ,Ùã ÎªÕĞ³ö¹ÖÎïµÄnpcidx

function OnDeath(npcidx)
    local pid = GetNpcTask(npcidx, 1)
    if (GetPlayerID() == pid) then
        if (GetTaskByte(gua8_renwu, 3) == 2) and (GetTaskByte(gua8_renwu, 4) == 5) then
            Msg2Player("B¹n ®· ®¸nh b¹i Thùc D­îc thó, h·y vÒ b¸o tin cho Chóc Dung!")
            SetTask(gua8_task, 0)
            SetTaskByte(gua8_renwu, 3, 3)
            TaskNote(97, 1)
        end
    end
    DelNpc(npcidx)
end;