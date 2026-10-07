--description: Ììí¶Öé.lua
--author: yaoxin
--date: 2009/4/30

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓĞş¶¼´ó·¨Ê¦ÕÒÏôÉı2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³ÉÑ©Ô­¾ŞÊŞ5Ñ©Ô­¾ŞÊŞÏÖ³öÔ­ĞÎ6»ØĞş¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function main()
    CloseDialog()
    if (GetPlayerType() ~= 1) then
        --²»ÊÇµÀÊ¿£¬·Ç·¨Ê¹ÓÃ
        ClearItem(6, 1, 498, 0)--Ììí¶Öé
        return 0
    end

    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 < 4) then
        Talk(1, "no", "Ph¸p lùc cña Thiªn C¬ ch©u cã h¹n, h·y cÈn thËn. Khi cã viÖc gÊp h·y hái §¹i Phu tr­íc tung tİch cña ph¶n ®å TriÖt gi¸o.")
        return 0
    elseif (state18 >= 5) or (GetTaskWord(Task_newer13, 2) ~= 0) then
        ClearItem(6, 1, 498, 0)--Ììí¶Öé
        Msg2Player("ChÕ ngù ph¶n ®å TriÖt gi¸o, ®o¹t vÒ Tiªn C¬ häa.")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and (GetNpcTemplateID(TargetNpcIdx) == 974) then
        --Ñ©Ô­¾ŞÊŞ½Ø½ÌÅÑÍ½id
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 0)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 0)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 0)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\Ììí¶Öé.lua", nInterrupt)
    else
        Msg2Player("Môc tiªu v« hiÖu, Thiªn C¬ ch©u chØ  sö dông víi YÓm Háa .")
    end
end;

function no()
    CloseDialog()
end;