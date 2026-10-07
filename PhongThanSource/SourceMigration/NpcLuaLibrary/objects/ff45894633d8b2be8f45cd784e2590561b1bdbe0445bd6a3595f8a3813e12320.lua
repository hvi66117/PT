--description: º³Áúá¦É¾³ı×Ô¼º
--author: liuzhiqiang
--date: 2009/06/02

-------------------------------Óü·¨É½Ö§Ïß-------------------------------
Task_zhixian = 1471 --1byte£º1½ÓÈÎÎñ£¬2ÕÒ¶¾À¼²İ£¬3ÕÒÁúÉàÀ¼£¬4ÕÒµ½2¶ä»¨£¬5µ÷Åä£¬6Íê³ÉÖ§ÏßÒ»£»
-- 8½ÓÊ§ÂäÖ®Êé£¬9»ñµÃ¹ÅÍ¼²ĞÆ¬£¬10Íê³ÉÖ§Ïß¶ş
--11½ÓÒÔ¾Æ»áÓÑ£¬12µÚÒ»´ÎÓëÙÈ×ÓÃ÷¶Ô»°£¬13ÃÜÌ½¸æÖªÒÔ¾Æ»áÓÑ£¬14ÓëÙÈ×ÓÃ÷Æ´¾Æ£¬15Íæ¼ÒÊ§°Ü£¬16Íæ¼ÒÊ¤³ö£¬17Íê³ÉÖ§ÏßÈı
--2byte:´ğÌâ¶ÔµÄ´ÎÊı
--3byte:´ğÌâ´íµÄ´ÎÊı
Global_HanLongFan = 211  --¼ÇÂ¼º³Áúá¦ËùÔÚËşÖù£¨1byte£ºËşÖù1£¬2byte£ºËşÖù2£¬3byte£ºËşÖù3£¬4byte£ºËşÖù4£©

function OnTimer(npcidx)
    local playerIdx = GetNpcTask(npcidx, 2)
    PlayerIndex = playerIdx

    if (GetNpcTask(npcidx, 1) == GetPlayerID()) then
        if (GetTaskByte(Task_zhixian, 1) == 8) then
            Msg2Player("Hµm Long Ph­ín biÕn mÊt, vÉn ch­a ®¹t ®­îc [Cæ §å Tµn PhiÕn], xin sö dông l¹i Hµm Long Ph­ín.")
            TopMessage("Hµm Long Ph­ín biÕn mÊt.")
        end
    end

    SetGlobalValue(Global_HanLongFan, SetByte(GetGlobalValue(Global_HanLongFan), GetNpcTask(npcidx, 3), 0))
    DelNpc(npcidx)
end;
