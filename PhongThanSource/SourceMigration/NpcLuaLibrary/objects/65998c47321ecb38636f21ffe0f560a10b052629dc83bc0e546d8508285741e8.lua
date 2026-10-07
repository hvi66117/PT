--Õ½¶·ÓÂÕßÖ®»ê.lua
--author:Laiyongcong
--date:2009-7-15


--add by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ£ºÓÂÕßÖ®»ê
BanQuan = 1498        --1Byte,ÈÎÎñ×´Ì¬£¬0Î´½ÓÈÎÎñ£¬1½ÓÊÜÁËÓÂÊ¿Ö®»êÈÎÎñ£¬2Ìá½»ÁËÓÂÕßÖ®»êÈÎÎñºóÕÒ¼§Ðþ·â£¬3ÌáÊ¾ÕÒ½ªØ®Îý
--2Byte£¬5¸öNPCµÄ×´Ì¬¡£ÒÑÍê³ÉµÄÏàÓ¦bitÖÃÎª1


Curr_HeroNPC_idx = 1499 --Íæ¼ÒÕÙ»½³öµÄµ±Ç°NPCµÄIdx,ÓÃÓÚÅÐ¶ÏÍæ¼ÒÕÙ»½³öµÄNPCÊÇ·ñ´æÔÚ
Curr_HeroNPC_ID = 1500    --Íæ¼ÒÕÙ»½³öµÄµ±Ç°NPCµÄIdx
--end by laiyongcong 2009.7.15 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:ÓÂÕßÖ®»ê


function OnDeath(npcindex)
    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local pid = GetNpcTask(npcindex, 1)
        if (pid ~= GetPlayerID()) then
            ------------------------±»±ðÈËÉ±ËÀÁË¡£
            local pidx = SearchPlayerById(pid)
            if (pidx ~= 0) then
                local str = GetName()
                local tempidx = PlayerIndex
                PlayerIndex = pidx
                Msg2Player("Dòng Gi¶ Trung Hån cña b¹n ®· bÞ " .. str .. " ®¸nh b¹i!")
                PlayerIndex = tempidx
            end
        else
            TopMessage("Siªu ®é thµnh c«ng 1 <c=g>Dòng Gi¶ Trung Hån <c>")
            Msg2Player("1 Dòng Gi¶ Trung Hån ®· hãa thµnh lµn khãi, tiªu diªu t¸n biÕn vµo kh«ng trung!")
            AddIBBuff(751)
            ----------------------------------------------Ìí¼ÓÒ»¸öÄÜÁ¦buff
            SetTask(Curr_HeroNPC_idx, 0)
            SetTask(Curr_HeroNPC_ID, 0)
            SetTaskBit(BanQuan, 8 + GetNpcTask(npcindex, 2), 1)-------------------------------------¸ø¶ÔÓ¦µÄNPCÎ»ÖÃÎ»
            --ÊýÄ¿¼ÓÒ»¸ö
            local num = GetTaskByte(BanQuan, 4)
            num = num + 1
            if num < 5 then
                SetTaskByte(BanQuan, 4, num)
                TaskNote(1086, 1, num)
            else
                TaskNote(1086, 2)
            end
        end
    end
    DelNpc(npcindex)
end;
