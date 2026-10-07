--»ê²¯.lua
--author:Laiyongcong
--date:2009-4-20

Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½»ê²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿

function main(l, t, npcindex)

    if (npcindex == 0) then
        Msg2Player("ChØ chuét vµo L·o Hå l« míi x¸c ®Şnh ®­îc môc tiªu.")
        return
    end

    if (GetTaskByte(Task_Variety_Process, 1) ~= 14) then
        Mag2Player("Hån B¹ch cña b¹n kh«ng phï hîp ®iÒu kiÖn sö dông, sau khi nhËn Háa Ly Tinh Ph¸ch, t×m ®¹i phu lÊy Hån B¹ch míi sö dông ®­îc vËt phÈm nµy.")
        return
    end

    local m, x, y = GetWorldPos()  --Íæ¼Òµ±Ç°µÄÎ»ÖÃ
    local npcTemplateID = GetNpcTemplateID(npcindex)
    local _, npcx, npcy = GetNpcWorldPos(npcindex) --»ñÈ¡npcµÄÎ»ÖÃ

    if (m ~= 27) then
        Msg2Player("Hån B¹ch chØ ®­îc sö dông t¹i Hiªn Viªn ®éng tÇng 1!")
        return
    end

    if (npcTemplateID ~= 22) then
        Msg2Player("ChØ chuét vµo L·o Hå l« míi x¸c ®Şnh ®­îc môc tiªu.")
        return
    end

    if (GetFightState() == 0) then
        Msg2Player("B¹n kh«ng trong tr¹ng th¸i chiÕn ®Êu!")
        return
    end

    local distance = ((npcx - x) ^ 2 + (npcy - y) ^ 2) ^ 0.5 * 32 ---Íæ¼ÒÓë»ğÀëĞ¡ÑıµÄ¾àÀë
    distance = floor(distance)
    if distance > 350 then
        Msg2Player("B¹n c¸ch L·o Hå l« qu¸ xa, Hån B¹ch kh«ng thÓ ph¸t huy t¸c dông!")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
    nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
    nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
    nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
    nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
    nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
    nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö
    nInterrupt = SetBit(nInterrupt, 10, 1)    --¹ÖÎïÄ¿±ê¶ªÊ§
    SetPlayerTarget(npcindex)                --ÉèÖÃÍæ¼ÒÑ¡ÖĞµÄ½ÇÉ«
    BeginMotion(Task_Variety_Process, 0, 4, "\\script\\motion\\ÍµÈ¡»ğÀë¾«ÆÇ.lua", nInterrupt)

end;
