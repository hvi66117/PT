--description: º£ÐÄ²ÝÉ¾³ý×Ô¼º
--author: liuzhiqiang
--date: 2009/05/05

---------------------ÐÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ÐÇ¹Ù´¦½ÓÐÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìýµ½ËµÃ÷ 3£ºÓë¹íÐ°ÑýÈËµÚÒ»´Î¶Ô»° 4: ÐÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑýÂ¯
--6: »Ùµô¹íÐ°ÑýÈËµÄÁé»ê 7: ÐÇ¹â÷öµ­ÈÎÎñÍê³É 8:ÐÇ¹Ù´¦½Ó³ý¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ð¾ 10: ÐÇ¹Ù´¦¸æÖª¹íÐ°ÑýÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ð¾Ê¹¹íÐ°ÑýÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íÐ°ÑýÈËµÄÔªÉñ 13: Íê³É³ý¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊý
-- 3byte: 1£ºÊÕ¼¯µ½º£ÐÄ²ÝµÄÖÖ×Ó 2: ÖÖÖ²º£ÐÄ²Ý 3£ºµÃµ½Ë®Ð¾

---------------------ÐÇ¹â÷öµ­-----------------

function GetPlayerTaskState()
    return 0, 0
end

function main()

    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 2) then
        if (GetNpcTask(DialogNpcIdx, 1) == GetPlayerID()) then
            --added by yangtao 2009.8.17 º£ÐÄ²ÝÖÖÖ²ºóÐè10ÃëÖÓºó²É¼¯
            if (HaveIBBuff(768) == 1) then
                Msg2Player("Sau khi trång H¹t H¶i T©m Th¶o, cÇn ®îi mét lóc sau míi cã thÓ thu ho¹ch!")
                return
            end
            --end of add 
            local rand = random(1, 100)
            if (rand > 40) then
                Msg2Player("H¸i thÊt b¹i, t×m Lôc Quy lÊy h¹t H¶i T©m Th¶o råi trång l¹i.")
                TopMessage("<c=g>Thu thËp thÊt b¹i<c>") --que
                SetTaskByte(Task_star, 3, 0)
                DelNpc(DialogNpcIdx)
                return
            end

            if (IsHaveSpaceForTreasure(1) ~= 1) then
                TopMessage("<c=g>Thu thËp thÊt b¹i<c>")
                Msg2Player("Tói ®· ®Çy, kh«ng thÓ lÊy Thñy T©m, t×m Lôc Quy lÊy h¹t H¶i T©m Th¶o råi trång l¹i.")
                SetTaskByte(Task_star, 3, 0)
                DelNpc(DialogNpcIdx)
                return
            end

            Msg2Player("Thu thËp thµnh c«ng Thñy T©m, mau quay vÒ thØnh gi¸o Tinh Quan c¸ch sö dông Ph¸p b¶o nµy.")
            TopMessage("H¸i thµnh c«ng <c=g>Thñy T©m<c>")
            AddNormalItem(6, 1, 513, 0, 0, 0)  -- Ë®Ð¾
            SetTaskByte(Task_star, 3, 3)
            SetTaskByte(Task_star, 1, 9)
            TaskNote(1060, 1)

            DelNpc(DialogNpcIdx)
        end
    end
end
