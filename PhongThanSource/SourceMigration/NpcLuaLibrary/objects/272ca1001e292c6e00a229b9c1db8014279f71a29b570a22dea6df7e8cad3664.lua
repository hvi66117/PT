--description: ×ÏÏ¼·û.lua
--author: jiaruoting
--date: 2009/5/5

Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓğ£¬3µÃµ½ĞÅ´òÃºÓÍ£¬4ÉÕËş£¬5Íê³É£©
--2byte ÓÀ³ıºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²İÏÉ£¬6É±ÅÑÍ½£¬7Íê³É£©
--2word ¼ÇÂ¼·ÅnpcÈÎÎñÊ±¼äÇømod£¨2^16£©

function main()
    CloseDialog()
    if (GetPlayerType() ~= 0) then
        --²»ÊÇ¼×Ê¿£¬·Ç·¨Ê¹ÓÃ
        ClearItem(6, 1, 496, 0)--×ÏÏ¼·û
        return 0
    end

    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 < 4) then
        Talk(1, "no", GetName() .. "1 con Hoµn C©u ®¸ng nghi? H·y ®Õn chç B¾c H¶i ®¹i phu t×m hiÓu râ viÖc néi gi¸n th× h¬n.")
        return 0
    elseif (state18 >= 5) or (GetTaskWord(Task_newer13, 2) ~= 0) then
        ClearItem(6, 1, 496, 0)
        Msg2Player("Ph¶n ®å TriÖt Gi¸o ®· xuÊt hiÖn, h·y mau thu phôc h¾n.")
        return 0
    end

    local TargetNpcIdx = GetPlayerTarget()
    if (TargetNpcIdx > 0) and (GetNpcTemplateID(TargetNpcIdx) == 973) then
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 0)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 0)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 0)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
        BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\×ÏÏ¼·û.lua", nInterrupt)
    else
        Msg2Player("Môc tiªu v« hiÖu, Tö Hµ Phï chØ sö dông víi Hoµn CÈu kh¶ nghi")
    end
end;

function no()
    CloseDialog()
end;