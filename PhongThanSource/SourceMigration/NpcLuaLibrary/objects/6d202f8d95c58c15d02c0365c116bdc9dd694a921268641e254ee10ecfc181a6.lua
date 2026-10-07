Task_PrepareMaterNum = 1050
Task_PrepareMaterial = 1049
--------------------------- ÖÐÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ýÏÚ 
--                    3:È¥ÈýÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ý´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊý
-- 3byte:Ê±¼ä´Á
-- 4byte:¼ÇÂ¼ÊÇ·ñÒÑ¾­ÔÚ³¬¼¶ÔÂ±ý´¦ÁìÈ¡¹ýÌØÊâ½±Àø
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·þÎñÆ÷ËùÓÐÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊý
TaskNote_zhongqiu = 1103
--------------------------- ÖÐÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------
function main()
    local nNum = HaveNormalItem(3, 145, 0, 0)
    -- ÖÐÇï»î¶¯ Added by yangtao 2009.9.14
    --local Process	= GetTaskByte(Task_zhongqiu, 1)
    --if(Process == 2) then
    --	if(IsHaveSpaceForTreasure (1) == 0) then
    --		Msg2Player("Ã»ÓÐ×ã¹»µÄ¿Õ¼ä,ÎÞ·¨²É¼¯¡£")
    --		return
    --	end
    --	AddNormalItemPile(3, 145, 0, 0, 0, 0)
    --	SetPropState(1)
    --	if((HaveEventItemCount(193) >= 1) and (HaveNormalItem(3, 144, 0, 0) >= 1)) then
    --		Msg2Player("²ÄÁÏÒÑÆë£¬¿ì»Ø³¯¸èÀñ¹Ù´¦°É£¡")
    --		TopMessage("²ÄÁÏÒÑÆë£¬¿ì»Ø³¯¸èÀñ¹Ù´¦°É")
    --		return
    --	else
    --		Msg2Player("²É¼¯µ½Ò»¸ö³¤´ºÊ÷")
    --		TopMessage("²É¼¯µ½Ò»¸ö³¤´ºÊ÷")
    --		return
    --	end
    -- ÖÐÇï»î¶¯ end of add yangtao 2009.9.14
    if (GetTask(Task_PrepareMaterial) == 1 and GetPlayerType() == 2) then
        AddNormalItemPile(3, 145, 0, 0, 0, 0)
        SetPropState(1)
        nNum = nNum + 1
        if (nNum >= 10) then
            TopMessage(13125)
            Msg2Player("B¹n ®· Thu thËp ®ñ Thô.")
        else
            TopMessage(13126)
            Msg2Player("B¹n thu thËp ®­îc 1 Thô.")
        end
    else
        TopMessage(13127)
    end
end
