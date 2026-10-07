--description: ¾Û»êÏ».lua
--author: yaoxin
--date: 2009/4/30

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ıº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ı4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ı6ÕÒ·ç²®Í¼ÌÚ7»Ø¸´ÕÇÌì¾ı8Íê³É£©
--2byteÖØ»ñÏÉµ¤ÈÎÎñ²½Öè (1ÕÒ¿ä¸¸Í¼ÌÚ2±¸×ã²ÄÁÏ3Ãç½®Ò½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³É²İÏÉ5²İÏÉÏÖ³öÔ­ĞÎ6»Ø·ç²®Í¼ÌÚ¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function main()
    CloseDialog()
    if (GetPlayerType() ~= 2) then
        --²»ÊÇÒìÈË£¬·Ç·¨Ê¹ÓÃ
        ClearItem(6, 1, 497, 0)--¾Û»êÏ»
        return 0
    end

    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 < 4) then
        Talk(1, "no", "Ph¸p lùc cña tr¸p Tô Hån cã h¹n, khi sö dông ph¶i cÈn thËn. ViÖc tr­íc m¾t lµ ®i t×m §¹i phu ë Miªu C­¬ng hái hµnh tung cña ph¶n ®å TriÖt gi¸o.")
        return 0
    elseif (state18 >= 5) or (GetTaskWord(Task_newer13, 2) ~= 0) then
        ClearItem(6, 1, 497, 0)--¾Û»êÏ»
        Msg2Player("ChÕ phôc ph¶n ®å TriÖt gi¸o, ®o¹t l¹i B¶o T©n ®¬n ngµn n¨m thËt.")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and (GetNpcTemplateID(TargetNpcIdx) == 975) then
        --²İÏÉ½Ø½ÌÅÑÍ½id
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 0)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 0)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 0)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\¾Û»êÏ».lua", nInterrupt)
    else
        Msg2Player("B¹n ch­a chän Th¶o Tiªn ®¸ng nghi")
    end
end;

function no()
    CloseDialog()
end;