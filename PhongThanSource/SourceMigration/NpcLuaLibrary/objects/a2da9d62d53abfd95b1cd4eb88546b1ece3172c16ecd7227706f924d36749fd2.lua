--description: ±±º£ÅÑ¾üÍ·Áì-ÈÎÎñ¹ÖÎï
--author: jiaruoting
--date: 2009/5/5

Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓğ£¬3µÃµ½ĞÅ´òÃºÓÍ£¬4ÉÕËş£¬5Íê³É£©
--2byte ÓÀ³ıºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²İÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©
function OnDeath()
    if (GetPlayerType() == 0) and (GetTaskByte(Task_newer13, 1) == 2) and (HaveEventItem(242) == 0)
    then
        AddEventItem(242)
        TaskNote(209, 1)
        TopMessage("NhËn ®­îc mËt th­")
        Msg2Player("Mang mËt th­ ®Õn Sïng Thµnh Doanh giao cho T«n Tö Vò.")
        TaskNote(209, 2)
    end
end;
