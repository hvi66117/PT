--±ù»ğÄ§.lua
--author:Laiyongcong
--date:2009-05-06

-------------ĞÇÃÎÆæÔµ,¹ÛĞÇÍ²Ö®ÃÕ Added by Laiyongcong 2009/05/06 start-----
star_dream = 1419            --ĞÇÃÎÆæÔµÈÎÎñ±äÁ¿£¬1Byte:ÈÎÎñ²½Öè,1½Óµ½ÈÎÎñ,2ÌáÊ¾ÕÒÒ½Éú£¬3È¡µÃĞÇÏóÍ¼£¬4»ÃÏñ³öÏÖ,5ÈÎÎñÍê³É£¬6È¡µÃÃÜĞÅ
--				   7½Óµ½¿½ÎÊÈÎÎñ£¬8¿½ÎÊ³É¹¦£¬9½Óµ½»ğÀëÑıÍõÈÎÎñ£¬10È¡µÃÑªÈ¾×Ö¼££¬11½Óµ½ÕÒ±ù»ğÄ§ÈÎÎñ£¬
--					12ÊÕ·ş±ù»ğÄ§£¬13ÈÎÎñÍê³É
--  2Byte£ºÉ±ËÀÎäÊ¿¹êµÄÊıÄ¿,»òÕßË®ÁáççµÄ³É¹¦¸ÅÂÊ
ice_fireIdx = 1420                --ÈÎÎñµÄºóÃæ£¬¸Ã±äÁ¿¼ÇÂ¼Íæ¼ÒÕÙ»½³öÀ´µÄ±ù»ğÄ§µÄidx
ice_fireID = 1423                --±ù»ğÄ§µÄid
-------------ĞÇÃÎÆæÔµ£¬¹ÛĞÇÍ²Ö®ÃÕ Added by Laiyongcong 2009/05/06 end-----

function no()
    CloseDialog()
end;

function OnDeath(npcindex)
    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then
            ------------------------±»±ğÈËÉ±ËÀÁË¡£

            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local str = GetName()
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("B¨ng Háa Ma b¹n t×m ®­îc ®· bŞ" .. str .. " tiªu diÖt, nh­ng b¹n cã thÓ quay l¹i n¬i cò ®Ó triÖu håi l¹i.")
                PlayerIndex = tempidx
            end
        else
            if (GetTaskByte(star_dream, 1) ~= 12) then
                Talk(1, "no", GetName() .. "Sao yÕu thÕ, liÖu cã ph¶i B¨ng Háa Ma thËt kh«ng? Ta t×m thö xem.")
                Msg2Player("B¨ng Háa Ma ®· bŞ b¹n tiªu diÖt, cã thÓ quay l¹i n¬i cò ®Ó triÖu håi l¹i.")
            end
        end
    end
    DelNpc(npcindex)
end;
