--description: ×ÏÏ¼·û.lua
--author: jiaruoting
--date: 2009/5/5

Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓð£¬3µÃµ½ÐÅ´òÃºÓÍ£¬4ÉÕËþ£¬5Íê³É£©
--2byte ÓÀ³ýºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²ÝÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function EndMotion(MotionID)
    if (MotionID == Task_newer13) then
        if (GetTaskByte(Task_newer13, 2) == 4) and (GetTaskWord(Task_newer13, 2) == 0) and (HaveNormalItem(6, 1, 496, 0) > 0) then
            local m, x, y = GetWorldPos() --npcµØÍ¼¼°×ø±ê
            if (m ~= 6) then
                Msg2Player("Tö Hµ phï chØ sö dông víi Hoµn CÈu.")
                return 0
            end

            local TargetNpcIdx = GetPlayerTarget()
            if (TargetNpcIdx <= 0) or (GetNpcTemplateID(TargetNpcIdx) ~= 973) then
                Msg2Player("B¹n ch­a chän Hoµn CÈu ®¸ng nghi")
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
                DelNormalItem(6, 1, 496, 0)
                TopMessage("Ph¶n ®å TriÖt gi¸o ®· hiÖn nguyªn h×nh")
                TaskNote(210, 4)
            else
                Msg2Player("Ph¸p lùc kh«ng ®ñ, ph¶n ®å TriÖt gi¸o kh«ng hiÖn nguyªn h×nh, h·y thö l¹i")
            end
        else
            Msg2Player("B¹n kh«ng ®em theo Tö Hµ phï")
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
