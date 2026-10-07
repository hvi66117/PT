--±ùÁéÍ·Áì.lua
--author: Laiyongcong
--date:2009-04-21

Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿

function OnDeath(npcindex)
    local pid = GetNpcTask(npcindex, 4)
    if (pid == GetPlayerID(PlayerIndex)) then
        --Íæ¼ÒÉ±ËÀÊôÓÚ×Ô¼ºµÄNPC
        AddNormalItem(6, 1, 489, 1, 0, 0) --»ñµÃÁË±ùÁé¼ÒÊé
        ScrollMessage("Cã ®­îc B¨ng Linh Gia Th­, më ra xem thö")
        Msg2Player("B¹n ®­îc B¨ng Linh Gia Th­, më ra xem bªn trong viÕt gØ.")
        SetTaskByte(Task_Variety_Process, 1, 20) --Íê³ÉÁËÉ±±ùÁéÊ×ÁìµÄÈÎÎñ
        ClearItem(6, 1, 487, 1) --Çå³ıÍæ¼ÒµÄ±ÜÀ×·û
        TaskNote(1047, 3)
    else
        local pidx = SearchPlayerById(pid)
        if (pidx ~= 0) then
            PlayerIndex = pidx
            Msg2Player("§Çu LÜnh B¨ng Linh b¹n gäi ra ®· bŞ ng­êi kh¸c tiªu diÖt, ®îi L«i §iÖn Th¸p t¾t h¼n råi trë vÒ t×m Kh­¬ng Tö Nha nghÜ c¸ch.")
        end
    end

    local towerNpcidx = GetNpcTask(npcindex, 1)
    if (towerNpcidx ~= 0 and GetNpcTask(towerNpcidx, 5) == npcindex) then
        SetNpcTask(towerNpcidx, 5, 0)
    end

    DelNpc(npcindex)
end;

function no()
    CloseDialog()
end;
