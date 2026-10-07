--description: ±ù½¾³æÍ·Áì-ÈÎÎñ¹ÖÎï
--author: yaoxin
--date: 2009/4/29

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓĞş¶¼´ó·¨Ê¦ÕÒÏôÉı2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³ÉÑ©Ô­¾ŞÊŞ5Ñ©Ô­¾ŞÊŞÏÖ³öÔ­ĞÎ6»ØĞş¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)

function OnDeath()
    if (GetPlayerType() == 1) and (GetTaskByte(Task_newer13, 1) == 3) and (HaveEventItem(239) == 0) then
        SetTaskByte(Task_newer13, 1, 4)
        Msg2Player("Trªn [Tr©n Long Kú] cã vÕt tİch cña [Nam Hoa Kinh].")
        TaskNote(207, 3)
        AddEventItem(239)--ÕæÁúÆå
        TopMessage("NhËn ®­îc  <c=yel>Tr©n Long Kú<c>")
    end
end;
