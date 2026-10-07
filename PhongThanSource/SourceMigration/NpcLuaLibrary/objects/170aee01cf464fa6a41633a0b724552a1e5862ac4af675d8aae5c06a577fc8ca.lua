--description: Ììî¸ÐÇÓ°×Ó
--author: yaoxin
--date:2007/6/20

--1013 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊý£¬ 2=ÊÕ·Ñ´ÎÊý 3 = µ±Ç°½øÐÐµÄ»·½Ú,(5:60 + 1:80) 4 £½  ½ñÌì¶Ò»»½±Àø´ÎÊý
--1014 1=¹ÖÎïÐòºÅ 2=´ò¹Ö¸öÊý 3=µ±Ç°Ôö³¤ÏµÊý(Y) 4= ³õÊ¼ÏµÊýx
--1017 Ììî¸ÐÇnpc, µÄindex

function OnDeath(c)
    local circle1 = GetByte(GetTask(1013), 3)
    local npcTGIdx = GetTask(1017)
    if (npcTGIdx == c) then
        if (circle1 > 1) and (circle1 <= 5) then
            local r = random(1, 100)
            SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
            Msg2Player("§¸nh b¹i Thiªn C­¬ng ¶nh.")

            if (r <= 12) then
                AddNormalItemPile(3, 134, 0, 0, 0, 0)
                TopMessage(13294)
            end

            r = random(1, 100)
            if (r == 21) or (r == 75) then
                AddNormalItemPile(3, 133, 0, 0, 0, 0)
                TopMessage(13296)
                AddGlobalCountNews("<c=g>" .. GetName() .. "<c> ®¸nh b¹i Thiªn C­¬ng ¶nh, may m¾n nhËn ®­îc 1 <c=yel>hån<c>!", 20)
            end

            if (GetFightState() == 1) then
                local w, x, y = GetWorldPos()
                npcTGIdx = AddNpc(571, 60, SubWorld, x * 32, y * 32)
                SetTask(1017, npcTGIdx)
                TaskNote(53, 1, circle1)
                Msg2Player("Thiªn C­¬ng ¶nh thø" .. circle1 .. "§· xuÊt hiÖn!")
            end
        elseif (circle1 == 6) then
            local r = random(1, 100)
            SetTask(1013, SetByte(GetTask(1013), 3, (circle1 + 1)))
            Msg2Player("§¸nh b¹i Thiªn C­¬ng ¶nh.")

            if (r <= 12) then
                AddNormalItemPile(3, 134, 0, 0, 0, 0)
                TopMessage(13294)
            end

            r = random(1, 100)
            if (r == 21) or (r == 75) then
                AddNormalItemPile(3, 133, 0, 0, 0, 0)
                TopMessage(13296)
                AddGlobalCountNews("<c=g>" .. GetName() .. "<c> ®¸nh b¹i Thiªn C­¬ng ¶nh, may m¾n nhËn ®­îc 1 <c=yel>hån<c>!", 20)
            end

            if (GetFightState() == 1) then
                local w, x, y = GetWorldPos()
                npcTGIdx = AddNpc(572, 80, SubWorld, x * 32, y * 32)
                SetTask(1017, npcTGIdx)

                TaskNote(53, 2)
                Msg2Player("Thiªn C­¬ng Tinh cuèi cïng ®· xuÊt hiÖn!")
            end
        end
    else
        WriteLog("Thiªn C­¬ng Tinh ¶nh")
    end
    DelNpc(c)
end;
