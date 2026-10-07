--description: Ììí¶Öé.lua
--author: yaoxin
--date: 2009/4/30

--yaoxin 13-18Ö§Ïß µÀÊ¿
Task_newer13 = 1416 --1byte ÇÙÆåÊé»­ÈÎÎñ²½Öè£¨1È¼µÆµÀÈË½ÓÈÎÎñ£¬È¥ÕÒÆÕÏÍÕæÈË£¬2É±±ù½¾³æµÃÚ¤ÒôÇÙ£¬3µÃµ½ÇÙÒªÉ±±ù½¾³æÍ·Áì£¬4µÃÆåÖªµÀÕÒ¶É¶òÕæÈË£¬5µÃ¾­ÕÒÈ¼µÆ£¬6Íê³É£©
--2byteÌ½ÄÒÈ¡ÎïÈÎÎñ²½Öè (1½ÓÐþ¶¼´ó·¨Ê¦ÕÒÏôÉý2±¸×ã²ÄÁÏ3Î÷À¥ÂØÒ½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×ÈÝ³ÉÑ©Ô­¾ÞÊÞ5Ñ©Ô­¾ÞÊÞÏÖ³öÔ­ÐÎ6»ØÐþ¶¼´ó·¨Ê¦¸´Ãü,7Íê³É)
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function EndMotion(MotionID)
    if (MotionID == Task_newer13) then
        if (GetTaskByte(Task_newer13, 2) == 4) and (GetTaskWord(Task_newer13, 2) == 0) and (HaveNormalItem(6, 1, 498, 0) > 0) then
            local m, x, y = GetWorldPos() --npcµØÍ¼¼°×ø±ê
            if (m ~= 9) then
                Msg2Player("Thiªn C¬ Ch©u chØ sö dông víi YÓm Háa ®¸ng nghi.")
                return 0
            end
            local TargetNpcIdx = GetPlayerTarget()
            if (TargetNpcIdx <= 0) or (GetNpcTemplateID(TargetNpcIdx) ~= 974) then
                Msg2Player("B¹n ch­a chän YÓm Háa ®¸ng nghi.")
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
                DelNormalItem(6, 1, 498, 0)
                TopMessage("Ph¶n ®å TriÖt gi¸o ®· hiÖn nguyªn h×nh")
                TaskNote(208, 4)
            else
                Msg2Player("Ph¸p lùc kh«ng ®ñ, ph¶n ®å TriÖt gi¸o kh«ng hiÖn nguyªn h×nh, h·y thö l¹i")
            end
        else
            Msg2Player("Thiªn C¬ Ch©u cña b¹n ®©u råi")
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
