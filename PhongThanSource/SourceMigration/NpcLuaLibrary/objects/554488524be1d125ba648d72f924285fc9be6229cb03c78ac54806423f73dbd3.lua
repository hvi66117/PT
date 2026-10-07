--description: ±»Á÷·ÅµÄÌìî¸ĞÇ
--author: yaoxin
--date:2007/6/20

--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-21
--1013 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı 3 = µ±Ç°½øĞĞµÄ»·½Ú,(5:60 + 1:80) 4 £½  ½ñÌì¶Ò»»½±Àø´ÎÊı
--1014 1=¹ÖÎïĞòºÅ 2=´ò¹Ö¸öÊı 3=µ±Ç°Ôö³¤ÏµÊı(Y) 4= ³õÊ¼ÏµÊıx
--1017 Ììî¸ĞÇnpc, µÄindex
Double_Optimization = 1697
function OnDeath(c)
    local circle1 = GetByte(GetTask(1013), 3)

    local npcTGIdx = GetTask(1017)
    if (npcTGIdx == c) then
        if (circle1 == 7) then
            local r = random(1, 100)
            if (r <= 12) then
                AddNormalItemPile(3, 134, 0, 0, 0, 0)
                TopMessage(13294)
                Msg2Player("§¸nh b¹i Thiªn C­¬ng Tinh, nhËn ®­îc 1 Ph¸ch.")
            end
            SetTask(1013, SetByte(GetTask(1013), 3, 0))
            Msg2Player("§¸nh b¹i Thiªn C­¬ng Tinh, nhËn ®­îc 1 Hån.")
            TaskNote(53, 8)
            AddNormalItemPile(3, 133, 0, 0, 0, 0)
            -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
            if (GetTaskByte(Double_Optimization, 3) > 0 and GetTaskByte(Double_Optimization, 3) < 8) then
                AddNormalItemPile(3, 133, 0, 0, 0, 0)
                Msg2Player("B¹n ®· nhËn phÇn th­ëng nh©n ®«i, bÊt ngê nhËn ®­îc 1 Hån")
                ScrollMessage("B¹n ®· nhËn phÇn th­ëng nh©n ®«i, bÊt ngê nhËn ®­îc 1 Hån")
            elseif (GetTaskByte(Double_Optimization, 3) >= 8) then
                local nTemp = GetTaskByte(Double_Optimization, 3)
                nTemp = SetBit(nTemp, 6, 0)
                SetTaskByte(Double_Optimization, 3, nTemp)
            end
            -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

            SetTaskWord(1014, 1, 0)--log¸Ä°æ
            SetTask(1014, 0)
            SetTask(1017, 0)
            TopMessage(13295)
        end
    else
        WriteLog("§¸nh b¹i Thiªn C­¬ng Tinh bŞ ®µy")
    end
    DelNpc(c)
end;
