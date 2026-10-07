Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;

Task_cold = 1212;
--º®ÊÒĞ§Ó¦ÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ£¬3Bit±íÊ¾ÈÎÎñ´ı½»£¬4Bit±íÊ¾½«Æä½»¸øÆäËüNPC½áÊøÈÎÎñ
--------------------------- ÖĞÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ıÏÚ 
--                    3:È¥ÈıÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ı´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊı
-- 3byte:Ê±¼ä´Á
-- 4byte:¼ÇÂ¼ÊÇ·ñÒÑ¾­ÔÚ³¬¼¶ÔÂ±ı´¦ÁìÈ¡¹ıÌØÊâ½±Àø
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·şÎñÆ÷ËùÓĞÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊı
TaskNote_zhongqiu = 1103
--------------------------- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------
function main()
    local hNum = HaveEventItemCount(193)
    -- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
    --local Process	= GetTaskByte(Task_zhongqiu, 1)
    --if(Process == 2) then
    --	if(IsHaveSpaceForTreasure (1) == 0) then
    --		Msg2Player("Ã»ÓĞ×ã¹»µÄ¿Õ¼ä,ÎŞ·¨²É¼¯¡£")
    --		return
    --	end
    --	AddNormalItemPile(4,193,0,1,0,0)
    --	SetPropState(1)
    --	if((HaveNormalItem(3, 144, 0, 0) >= 1) and (HaveNormalItem(3, 145, 0, 0) >= 1)) then
    --		Msg2Player("²ÄÁÏÒÑÆë£¬¿ì»Ø³¯¸èÀñ¹Ù´¦°É£¡")
    --		TopMessage("²ÄÁÏÒÑÆë£¬¿ì»Ø³¯¸èÀñ¹Ù´¦°É")
    --		return
    --	else
    --		Msg2Player("²É¼¯µ½Ò»¸ö»ÆÖĞÀî")
    --		TopMessage("²É¼¯µ½Ò»¸ö»ÆÖĞÀî")
    --		return
    --	end
    --end
    -- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
    local valcold = GetTask(Task_cold)
    if (GetBit(valcold, 4) == 0 and hNum < 10 and GetBit(valcold, 1) == 1) then
        SetPropState(1)
        AddNormalItemPile(4, 193, 0, 0, 0, 0)
        hNum = hNum + 1
        if (hNum >= 10) then
            if (HaveNormalItem(3, 217, 0, 0) >= 10) then
                SetTask(Task_cold, SetBit(GetTask(Task_cold), 3, 1))
                TopMessage(14315)
                Msg2Player("§· thu thËp ®ñ tÊt c¶ D­îc liÖu, vÒ giao nhiÖm vô nhËn th­ëng!")
                return 0
            else
                TopMessage(14358)
                Msg2Player("B¹n ®· thu thËp ®ñ bµi thuèc [Lı]")
                return 0
            end
        else
            TopMessage(14359)
            Msg2Player("Thu ®­îc 1 Lı")
        end
        return 0
    end

    if (GetTask(Task_PrepareMaterial) == 1 and GetPlayerType() == 0) then
        local nNum = HaveEventItemCount(193)
        --		if( nNum < 20)then
        AddEventItem(193)
        SetPropState(1)
        nNum = nNum + 1
        if (nNum >= 20) then
            TopMessage(13254)
            Msg2Player("B¹n ®· thu thËp ®ñ Lı.")
        else
            TopMessage(13255)
            Msg2Player("B¹n thu thËp ®­îc 1 Lı.")
        end
        return 0
        --		end
    end

    TopMessage(13256)
end;