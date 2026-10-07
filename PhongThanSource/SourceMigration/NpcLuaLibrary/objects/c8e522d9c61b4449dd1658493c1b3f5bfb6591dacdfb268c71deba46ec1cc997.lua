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
        ClearItem(6, 1, 495, 0)--ÃºÓÍ
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 3) then
        local w, x, y = GetWorldPos()
        x = floor(x / 8)
        y = floor(y / 16)
        if (((x - 209) ^ 2 + (y - 179) ^ 2) >= 3) then
            Talk(1, "no", "B¹n c¸ch Tiªu Th¸p qu¸ xa!")
            return 0
        else
            local nInterrupt = 0
            nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
            nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
            nInterrupt = SetBit(nInterrupt, 3, 0)    --¼¼ÄÜ
            nInterrupt = SetBit(nInterrupt, 4, 0)    --ÊÜÉË
            nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
            nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
            nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
            BeginMotion(Task_newer13, 1, 5, "\\script\\motion\\ÃºÓÍ.lua", nInterrupt)

        end
    else
        -- modified by yaoxin for 2010-11 begin
        ClearItem(6, 1, 495, 0)--ÃºÓÍ
        Msg2Player("DÇu ho¶ ®· hÕt")
    end


end;

function no()
    CloseDialog()
end;