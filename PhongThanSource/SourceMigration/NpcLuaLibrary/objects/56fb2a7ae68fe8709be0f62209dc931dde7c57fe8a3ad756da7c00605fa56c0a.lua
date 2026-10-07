--ÂÌÉ«»ðÀëÐ¡Ñý.lua
--author:Laiyongcong
--date:2009-05-06
-------------ÐÇÃÎÆæÔµ,¹ÛÐÇÍ²Ö®ÃÕ Added by Laiyongcong 2009/05/04 start-----
star_dream = 1419            --ÐÇÃÎÆæÔµÈÎÎñ±äÁ¿£¬1Byte:ÈÎÎñ²½Öè,1½Óµ½ÈÎÎñ,2ÌáÊ¾ÕÒÒ½Éú£¬3È¡µÃÐÇÏóÍ¼£¬4»ÃÏñ³öÏÖ,5ÈÎÎñÍê³É£¬6È¡µÃÃÜÐÅ
--				   7½Óµ½¿½ÎÊÈÎÎñ£¬8¿½ÎÊ³É¹¦£¬9½Óµ½»ðÀëÑýÍõÈÎÎñ£¬10³É¹¦±£»¤ÁË»ðÀëÑýÍõÖ®»ê£¬11½Óµ½ÕÒ±ù»ðÄ§ÈÎÎñ£¬
--					12ÊÕ·þ±ù»ðÄ§£¬13ÈÎÎñÍê³É
--  2Byte£ºÉ±ËÀÎäÊ¿¹êµÄÊýÄ¿,»òÕßË®ÁáççµÄ³É¹¦¸ÅÂÊ
function OnDeath(npcindex)

    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then
            ------------------------±»±ðÈËÉ±ËÀÁË¡£
            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng, ®Ó xem h¾n muèn nãi g×.")
                ScrollMessage("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng")
                RemoveIBBuff(659)
                SetTaskByte(star_dream, 1, 10)
                refreshNpcTaskState()
                TaskNote(1052, 13)
                PlayerIndex = tempidx
            end
        else
            Msg2Player("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng, ®Ó xem h¾n muèn nãi g×.")
            ScrollMessage("B¹n ®· b¶o vÖ thµnh c«ng ph¸ch cña Háa Li Yªu V­¬ng")
            RemoveIBBuff(659)
            SetTaskByte(star_dream, 1, 10)
            refreshNpcTaskState()
            TaskNote(1052, 13)
            AddOwnExp(100)--Ìí¼Ó¶îÍâµÄ¾­Ñé
            TopMessage("B¹n nhËn ®­îc <c=g>100<c> kinh nghiÖm")
            Msg2Player("B¹n nhËn ®­îc 100 kinh nghiÖm")
        end
    end
    DelNpc(npcindex)
end;
