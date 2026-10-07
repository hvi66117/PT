--description: ½Ø½ÌÅÑÍ½.lua
--author: yaoxin
--date: 2009/4/30

--yaoxin 13-18Ö§Ïß 
--ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ıº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ı4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ı6ÕÒ·ç²®Í¼ÌÚ7»Ø¸´ÕÇÌì¾ı8Íê³É£©
--2byteÖØ»ñÏÉµ¤ÈÎÎñ²½Öè (1ÕÒ¿ä¸¸Í¼ÌÚ2±¸×ã²ÄÁÏ3Ãç½®Ò½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³É²İÏÉ5²İÏÉÏÖ³öÔ­ĞÎ6»Ø·ç²®Í¼ÌÚ¸´Ãü,7Íê³É)

--µÀÊ¿
--Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓĞş¶¼´ó·¨Ê¦ÕÒÏôÉı2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³ÉÑ©Ô­¾ŞÊŞ5Ñ©Ô­¾ŞÊŞÏÖ³öÔ­ĞÎ6»ØĞş¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)

--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

--¼×Ê¿
--Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓğ£¬3µÃµ½ĞÅ´òÃºÓÍ£¬4ÉÕËş£¬5Íê³É£©
--2byte ÓÀ³ıºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²İÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©
function OnDeath(npcidx)
    if (GetPlayerID() == GetNpcTask(npcidx, 1)) then
        local ty = GetPlayerType()
        local w, x, y = GetWorldPos() --npcµØÍ¼¼°×ø±ê
        if (w == 12) and (ty == 2) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("Mang Ph¶n §å TriÖt Gi¸o thu phôc vµo Thiªn Niªn B¶o T©n §¬n thËt sù, h·y vÒ giao cho VËt Tæ Phong B¸ ®i.")
            SetTaskByte(Task_newer13, 2, 6)
            AddEventItem(237)
            TaskNote(206, 5)
        elseif (w == 9) and (ty == 1) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("§o¹t ®­îc Tiªn C¬ Häa trªn ng­êi Ph¶n §å TriÖt Gi¸o, mang vÒ giao cho ph¸p s­ HuyÒn §«.")
            SetTaskByte(Task_newer13, 2, 6)
            TaskNote(208, 5)
            AddEventItem(241)
        elseif (w == 6) and (ty == 0) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("Ph¶n §å TriÖt Gi¸o ®· bŞ tiªu diÖt, vÒ b¸o c¸o víi Sïng HÇu hæ#")
            SetTaskByte(Task_newer13, 2, 6)
            TaskNote(210, 5)
        end
    end
    DelNpc(npcidx)
end;

function no()
    CloseDialog()
end;