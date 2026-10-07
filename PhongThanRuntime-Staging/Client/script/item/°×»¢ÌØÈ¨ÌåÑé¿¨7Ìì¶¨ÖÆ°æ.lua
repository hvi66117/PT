ItemID = { 6, 1, 1304, 1 }
ItemName = "ThÎ §Æc QuyÒn B¹ch Hæ 7 ngµy"
GeiveLevel = 3

function main()
    local times = GetTaskByte(2058, 4) + 1
    if (times <= 5) then
        if (HaveNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) <= 0) then
            return
        end

        local nVipLevel = GetPlayerVipLevel()
        if not (nVipLevel == GeiveLevel or nVipLevel == 0) then
            Talk(1, "no", "Xin lçi, cÊp ®Æc quyÒn hiÖn t¹i vµ thÎ tr¶i nghiÖm kh«ng phï hîp, t¹m thêi kh«ng thÓ sö dông.")
            return
        end

        if (DelNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) > 0) then
            SetTaskByte(2058, 4, times)
            SetPlayerVipLevel(GeiveLevel, 7 * 86400)
            Msg2Player("Chóc mõng ngµi nhËn ®­îc §Æc QuyÒn B¹ch Hæ tr¶i nghiÖm 7 ngµy, Kho tïy th©n, cöa hµng tïy th©n cao cÊp, mçi ngµy miÔn phİ 2 lÇn quy Th¸i TuÕ vµ 15 ®Æc quyÒn kh¸c, cã thÓ nhÊn F2 më B¸t B¶o C¸c ®Ó xem chi tiÕt ®Æc quyÒn.")
            WriteLog("[Sö dông][" .. ItemName .. "]")
        end
    else
        InfoBox("<c=g>ThËt xin lçi, mçi ng­êi ch¬i chØ cã th sö dông 5 tÊm ThÎ tr¶i nghiÖm ®Æc quyÒn B¹ch Hæ.<c>")
    end
end

function no()
    CloseDialog()
end
