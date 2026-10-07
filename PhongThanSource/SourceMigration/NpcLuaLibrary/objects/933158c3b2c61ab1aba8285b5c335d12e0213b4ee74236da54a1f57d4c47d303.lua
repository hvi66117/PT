--»ê²¯.lua
--author:Laiyongcong
--date:2009-4-21

---------±³ºóÖ÷Ä±-----------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚÐÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈýÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂÞÓã¶Ô»° 10Óë¾Þ¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ðÀëÐ¡Ñý£¬14µÃµ½»ê²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ðÀë¾«ÆÇ

--2byte: 1½Óµ½¹ý³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ýÈýÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ý»ðÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ý±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ðÀëÐ¡ÑýµÄÊýÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊýÄ¿

PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËþnpcindex
-------------±³ºóÖ÷Ä±-------------------

function no()
    CloseDialog()
end;

function main()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step <= 17) then
        --------------------------------------------Íæ¼ÒÃ»ÓÐµ½ÕâÒ»²½£¬ËµÒ»Ð©ÉÔÎ¢Ïà¹ØµÄ»°,¿ÉÄÜÊÇÍ¨¹ýÆäËû¹îÒìµÄÍ¾¾¶»ñµÃÁË¸ÃµÀ¾ß
        Talk(1, "no", "DÉn L«i phï cã thÓ kªu gäi Thiªn L«i trong trËn ph¸p L«i §iÖn Th¸p!")
        return
    end

    local m, x, y = GetWorldPos()  --Íæ¼Òµ±Ç°µÄÎ»ÖÃ
    if (m ~= 32) then
        Msg2Player("DÉn L«i phï chØ cã thÓ sö dông trong Ngäc TuyÒn B¨ng Xuyªn")
    end

    local npcidx = GetTask(PlayerLightIndex) --Íæ¼ÒµãÁÁµÄµÆËþ
    if (npcidx == 0 or GetNpcTask(npcidx, 4) ~= GetPlayerID(PlayerIndex)) then
        --Ã»ÓÐµãÁÁµÆËþ»ñµÃµÆËþ°ó¶¨ÒÑ¾­Ê§Ð§ÁË
        Talk(1, "no", "Ph¶i gi¶i phãng ph¸p lùc cña DÉn L«i phï trong trËn ph¸p L«i §iÖn Th¸p. §Ó ®iÓm s¸ng Lé ®iÖn chi th¸p cÇn cã BÝch L«i phï cña Kh­¬ng Tö Nha.")
        return
    end

    local x1, y1, x2, y2, x3, y3 = 0, 0, 0, 0, 0, 0
    local group = GetNpcTask(npcidx, 1)
    --¼ì²é¸Ã×éÀ×µçÖ®ËþÊÇ·ñ»¹ÔÚµãÁÁ×´Ì¬
    if (group < 10) then
        Talk(1, "no", "L«i §iÖn Th¸p t¾t ®Ìn råi, cÇn sö dông BÝch L«i phï cña Kh­¬ng Tö Nha ®Ó ®iÓm s¸ng l¹i tõ ®Çu!")
        SetTask(PlayerLightIndex, 0) --Çå¿ÕÍæ¼Ò°ó¶¨µÄÀ×µçÖ®Ëþnpcidx
        return
    end

    -----------------------------¼ì²éÊÇ·ñÔÚÈý½ÇÐÎÇøÓòÄÚ²¿£¬Ê×ÏÈ»ñµÃÍæ¼ÒµãÁÁµÄÈý½ÇÐÎÇøÓò
    group = mod(group, 10)
    if (group == 1) then
        x1, y1, x2, y2, x3, y3 = 1800, 2922, 1815, 2922, 1808, 2908
    elseif (group == 2) then
        x1, y1, x2, y2, x3, y3 = 1825, 2974, 1840, 2974, 1833, 2960
    else
        x1, y1, x2, y2, x3, y3 = 1850, 3057, 1865, 3057, 1858, 3043
    end

    if ((IsInTheSameSize(x, y, x1, y1, x2, y2, x3, y3) == 0) or (IsInTheSameSize(x, y, x2, y2, x1, y1, x3, y3) == 0) or (IsInTheSameSize(x, y, x3, y3, x2, y2, x1, y1) == 0)) then
        Talk(1, "no", "Ph¶i gi¶i phãng ph¸p lùc cña DÉn L«i phï trong trËn ph¸p L«i §iÖn Th¸p.")
        return
    end

    PlayerCastSkill(1, 223, 1)-----------------------------------------------------------´¥·¢À×¶¯¾ÅÌì
    --ÔÚ¸±ËþÉÏ°ó¶¨Ò»¸ö¶¨Ê±Æ÷
    local next_npcidx = GetNpcTask(npcidx, 2)

    --²éÕÒÒ»¸ö¿ÕÏÐµÄËþ
    if (GetNpcTask(next_npcidx, 5) ~= 0) then
        ---------------------------------±Ø¶¨ÓÐÒ»¸öÊÇ¿ÕÏÐµÄ
        next_npcidx = GetNpcTask(next_npcidx, 2)
    end

    if (next_npcidx == npcidx or next_npcidx == 0) then
        --ÀíÂÛÉÏ²»»á·¢Éú
        Msg2Player("Khãa dông cô hÑn giê cã sai sãt")
        return
    end

    SetNpcTimer(next_npcidx, "\\script\\ontimer\\À×¶¯¾ÅÌì³ÖÐø¼ÆÊ±.lua", 5) --ÓëÀ×¶¯¾ÅÌìÌØÐ§Ê±¼äÒ»ÖÂ

    ClearItem(6, 1, 488, 1) --É¾³ýÒýÀ×·û
    --	Msg2Player("ÄãÊ§È¥ÁËÒýÀ×·û")
end

---¼ÆËãX0£¬y0  ºÍx1,y1ÊÇ·ñÔÚºóÃæÁ½¸öµãÁ¬ÏßµÄÍ¬Ò»²à
function IsInTheSameSize(x0, y0, x1, y1, x2, y2, x3, y3)

    if (x2 == x3 and y2 == y3) then
        --Á½¸ö²Î¿¼µãÊÇÖØºÏµÄ£¬ÎÞ·¨ÅÐ¶ÏÊÇ·ñÔÚÍ¬Ò»²à
        return 0
    end

    local a, b = (x2 - x3), (y2 - y3) ---¿´×÷Ò»¸ö´Óx3,y3Ö¸Ïòx2,y2µÄÊ¸Á¿
    local line_x0, line_y0 = (x0 - x3), (y0 - y3)
    local line_x1, line_y1 = (x1 - x3), (y1 - y3)

    --×÷Ê¸Á¿³Ë·¨£¬°ÑºóÁ½¸öÏòÁ¿Ðý×ªÒ»¶¨½Ç¶È£¬¸Ã½Ç¶ÈÓÉµÚÒ»¸öÏòÁ¿µÄÓà½Ç¾ö¶¨
    local vector_x0 = line_x0 * b - line_y0 * a
    local vector_x1 = line_x1 * b - line_y1 * a

    if ((vector_x0 >= 0 and vector_x1 >= 0) or (vector_x0 <= 0 and vector_x1 <= 0)) then
        return 1
    else
        return 0
    end
end
