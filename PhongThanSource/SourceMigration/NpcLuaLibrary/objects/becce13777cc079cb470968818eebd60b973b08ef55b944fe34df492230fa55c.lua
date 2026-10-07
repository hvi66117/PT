--ÊÉÃÎÄ§.lua
--author:laiyongcong
--date:2009-07-16

ZheFuIdx = 239        --´æ´¢òØ·üidxµÄÈ«¾Ö±äÁ¿

--add by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:×îºóµÄĞÄÔ¸
BanQuan = 1498        --1Byte,ÈÎÎñ×´Ì¬£¬3½Óµ½×îºóĞÄÔ¸ÈÎÎñ£¬4´¥·¢É±¹ÖÕÒ±øÆ÷ÈÎÎñ£¬5Íê³ÉĞÄÔ¸
--2Byte£¬1bit¶ÔÓ¦¿ø¼×¡¢2bit¶ÔÓ¦Ğø¹ÇÉú¼¡Á«
--3Byte£¬1±íÊ¾ÕÒ¼§Ğş·â£¬2±íÊ¾ÕÒ½ªØ®Îı
--end by laiyongcong 2009.7.16 for ÚæÈªÊ¥µØÖ§ÏßÈÎÎñ:×îºóµÄĞÄÔ¸

function OnDeath(npcindex)

    if (PlayerIndex ~= nil and PlayerIndex > 0) then
        local step = GetTaskByte(BanQuan, 1)
        if (step > 2 and step < 5) then
            local zfidx = GetGlobalValue(ZheFuIdx)

            if (zfidx <= 0) then
                return
            end
            local id1, x1, y1 = GetNpcWorldPos(npcindex)
            local id2, x2, y2 = GetNpcWorldPos(zfidx)

            local distance = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ 0.5 * 32
            if (distance > 200) then
                ScrollMessage("C¸ch ChËp Phôc qu¸ xa!")
                Msg2Player("PhÖ Méng Ma bŞ tiªu diÖt c¸ch TriÕt Phôc qu¸ xa, kh«ng thÓ khiÕn TriÕt Phôc r¬i vµo tr¹ng th¸i ngñ mª.")
                return
            end
            TopMessage("TriÕt Phôc r¬i vµo tr¹ng th¸i ngñ mª.")
            Msg2Player("TriÕt Phôc r¬i vµo tr¹ng th¸i ngñ mª, thêi gian cã h¹n! H·y mau ®i thu thËp Tôc Cèt Sinh C¬ Liªn.")
            NpcAddIBBuff(zfidx, 750)----¸øòØ·ü¼Óbuff
        end
    end
end
