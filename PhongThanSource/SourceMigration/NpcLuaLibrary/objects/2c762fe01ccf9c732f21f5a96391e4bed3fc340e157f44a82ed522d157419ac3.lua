ZheFuIdx = 239

BanQuan = 1498

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
            NpcAddIBBuff(zfidx, 750)
        end
    end
end
