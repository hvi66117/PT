--description: ¾Û»êÏ».lua
--author: yaoxin
--date: 2009/4/30

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ýº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ý4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ý6ÕÒ·ç²®Í¼ÌÚ7»Ø¸´ÕÇÌì¾ý8Íê³É£©
--2byteÖØ»ñÏÉµ¤ÈÎÎñ²½Öè (1ÕÒ¿ä¸¸Í¼ÌÚ2±¸×ã²ÄÁÏ3Ãç½®Ò½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×ÈÝ³É²ÝÏÉ5²ÝÏÉÏÖ³öÔ­ÐÎ6»Ø·ç²®Í¼ÌÚ¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function EndMotion(MotionID)
    if (MotionID == Task_newer13) then
        if (GetTaskByte(Task_newer13, 2) == 4) and (GetTaskWord(Task_newer13, 2) == 0) and (HaveNormalItem(6, 1, 497, 0) > 0) then
            local m, x, y = GetWorldPos() --npcµØÍ¼¼°×ø±ê
            if (m ~= 12) then
                Msg2Player("Tr¸p Tô Hån chØ sö dông víi Th¶o Tiªn.")
                return 0
            end

            local TargetNpcIdx = GetPlayerTarget()
            if (TargetNpcIdx <= 0) or (GetNpcTemplateID(TargetNpcIdx) ~= 975) then
                Msg2Player("B¹n ch­a chän Th¶o Tiªn ®¸ng nghi")
                return 0
            end

            local npcidx = AddNpc(976, 20, SubWorld, x * 32, y * 32)
            if (npcidx > 0) then
                PlayerCastSkill(1, 224, 1)
                CaptureNpc(TargetNpcIdx)
                SetNpcTask(npcidx, 1, GetPlayerID())
                local nowtime = mod(SystemTime(), 2 ^ 16)
                SetTaskWord(Task_newer13, 2, nowtime)
                SetTaskByte(Task_newer13, 2, 5)
                DelNormalItem(6, 1, 497, 0)
                TopMessage("Ph¶n ®å TriÖt gi¸o ®· hiÖn nguyªn h×nh")
                TaskNote(206, 4)
            else
                Msg2Player("Ph¸p lùc kh«ng ®ñ, ph¶n ®å TriÖt gi¸o kh«ng hiÖn nguyªn h×nh, h·y thö l¹i")
            end
        else
            Msg2Player("Tr¸p Tô Hån cña b¹n ®©u")
        end
    end
end

function no()
    CloseDialog()
end

--AS GaoJingwei 091118
--½ø¶ÈÌõ±»´ò¶ÏÊ±µ÷
function InteruptMotion(MotionID)
end
--AE GaoJingwei 091118
