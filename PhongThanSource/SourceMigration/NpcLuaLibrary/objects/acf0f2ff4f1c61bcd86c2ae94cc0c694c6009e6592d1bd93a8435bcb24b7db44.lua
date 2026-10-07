--ĞÅÎï.lua
--author: Gaojingwei
--date: 2009/04/21

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø
--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ
--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿
Task_Time_Stemp = 1390        --¼ÇÂ¼É±µ¥´¿É³»ê£¬ºÍÈı¸öÓãµÄÊ±¼ä
Task_NpcID = 1391            --¼ÇÂ¼µ¥´¿É³»êºÍÈı¸öÓãµÄÊ±¼ä
puteGhost = 956                --µ¥´¿É³»êµÄtemplateID
bigHeadFish = 952            --´óÍ·ÓãµÄµÄtemplateID
foldFish = 952                --ÕÛÂáÓãµÄtemplateID
greatTongueFish = 952        --¾Ş¹ÇÉàÓãµÄtemplateID

Coordinate = --Èı¸öÓãµÄ×ø±ê
{
    [1] = { desc = "[203,202]", link = "§«ng H¶i Thñy Vùc [37,203,202]" },
    [2] = { desc = "[216,199]", link = "§«ng H¶i Thñy Vùc [37,216,199]" },
    [3] = { desc = "[219,192]", link = "§«ng H¶i Thñy Vùc [37,219,192]" }
}

Task_Info_First = 1044
Task_Info_Second = 1045
-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ-----------------

function main()
    if (GetTaskByte(Task_Variety_Process, 1) == 24) then
        local linkPos = "<HyperLinkWorldPos=\"¾øÁúÁë[19,201,183]\">"
        ClearItem(6, 1, 490, 0)
        SetTaskByte(Task_Variety_Process, 1, 25)
        Talk(1, "no", "<c=r>T«n L­¬ng<c> chñ nh©n, tiÓu nh©n ®· liªn l¹c Chiªu ThÇn gióp ta tÊn c«ng Tam S¬n. Chóng ta tËp kÕt binh m·, chê hiÖu lÖnh cña ®¹i nh©n!")
        Msg2Player("KÎ Chñ m­u lµ T«n L­¬ng, h¾n ë" .. linkPos)
        TaskNote(1047, 6)
    end
end

function no()
    CloseDialog()
end
