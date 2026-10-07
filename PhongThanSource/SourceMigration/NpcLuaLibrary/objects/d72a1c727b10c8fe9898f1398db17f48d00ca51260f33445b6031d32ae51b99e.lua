Task_zhixian = 1471 --1byte£º1½ÓÈÎÎñ£¬2ÕÒ¶¾À¼²İ£¬3ÕÒÁúÉàÀ¼£¬4ÕÒµ½2¶ä»¨£¬5µ÷Åä£¬6Íê³ÉÖ§ÏßÒ»£»
-- 8½ÓÊ§ÂäÖ®Êé£¬9»ñµÃ¹ÅÍ¼²ĞÆ¬£¬10Íê³ÉÖ§Ïß¶ş
--11½ÓÒÔ¾Æ»áÓÑ£¬12µÚÒ»´ÎÓëÙÈ×ÓÃ÷¶Ô»°£¬13ÃÜÌ½¸æÖªÒÔ¾Æ»áÓÑ£¬14ÓëÙÈ×ÓÃ÷Æ´¾Æ£¬15Íæ¼ÒÊ§°Ü£¬16Íæ¼ÒÊ¤³ö£¬17Íê³ÉÖ§ÏßÈı
--2byte:´ğÌâ¶ÔµÄ´ÎÊı
--3byte:´ğÌâ´íµÄ´ÎÊı
function OnDeath(npcidx)

    if (GetTeam() == 0) then
        if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0) then
            AddNormalItem(4, 257, 0, 1, 0, 0)  --¹ÅÍ¼²ĞÆ¬
            SetTaskByte(Task_zhixian, 1, 19)
            TaskNote(107, 5)
        end
    else
        local oldPlayer = PlayerIndex
        for i = 1, GetTeamSize() do
            PlayerIndex = GetTeamMember(i)
            if (GetTaskByte(Task_zhixian, 1) == 18 and GetJusticEvilCredit() > 0) then
                AddNormalItem(4, 257, 0, 1, 0, 0)  --¹ÅÍ¼²ĞÆ¬
                SetTaskByte(Task_zhixian, 1, 19)
                TaskNote(107, 5)
            end
        end
        PlayerIndex = oldPlayer
    end
    Msg2CurMapAnnounce("MËt th¸m Ma Giíi ®· bŞ tiªu diÖt, nh©n sÜ Tiªn Giíi thu ®­îc 1 m¶nh Cæ §å Tµn PhiÕn trªn ng­êi anh ta!")
    SetNpcTimer(GetNpcTask(npcidx, 3), "\\script\\ontimer\\¹ÅÍ¼ÖØÉúÊ®·ÖÖÓ¶¨Ê±.lua", 60 * 10)--¸ø¶Ô»°NPC ¼ÓÊ®·ÖÖÓONTIMER
    DelNpc(npcidx)
end
