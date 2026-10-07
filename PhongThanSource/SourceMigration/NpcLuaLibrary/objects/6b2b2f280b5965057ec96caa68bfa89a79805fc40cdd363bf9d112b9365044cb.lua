--description: ¿ñÄñÍ·Áì-ÈÎÎñ¹ÖÎï
--author: yaoxin
--date: 2009/4/29

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ıº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ı4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ı6ÕÒ·ç²®Í¼ÌÚ£©

function OnDeath()
    if (GetPlayerType() == 2) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(235) == 0) then
        --à¹
        if (HaveEventItem(236) == 0) then
            --ÑÛÀá
            Msg2Player("Thu thËp má thñ lÜnh Cuång §iªu, vÉn cßn thiÕt n­íc m¾t Lôc Qu¸i.")
        else
            SetTaskByte(Task_newer13, 1, 2)
            Msg2Player("§i t×m §¹i Phu ë Du Hån dïng Tam Muéi Ch©n Háa nÊu vËt phÈm nµy thµnh Linh ®¬n!")
            TaskNote(205, 1)
        end
        AddEventItem(235)
        TopMessage("NhËn ®­îc má Cuång §iÓu")
    end
end;
