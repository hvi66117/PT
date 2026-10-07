function main()
    CloseDialog()
    DelNormalItem(6, 1, 323, 0)
    local rand_ks = math.random(1, 1000)
    if (rand_ks > 970) then
        TopMessage("NhËn ®­îc ph¸p b¶o <c=g>Kim S¬n<c>")
        AddNormalItem(0, 4, 37, 1, 0, 0)
        WriteLog("Kim S¬n Ph¸p B¶o")
    elseif (rand_ks == 800) then
        local w, x, y = GetWorldPos()
        local times = GetGlobalValue(83) + 1
        if (w >= 20) and (w <= 21) and (times <= 3) then
            TopMessage("NhËn ®­îc ph¸p b¶o <c=g>Kim S¬n (sè l­îng cã h¹n)<c>")
            AddNormalItem(0, 4, 38, 1, 0, 0)
            SetGlobalValue(83, times)
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> khi më ra <c=yel>ThiÖp mõng 20 n¨m Kim S¬n<c> may m¾n nhËn ®­îc ph¸p b¶o <c=yel>Kim S¬n (sè l­îng cã h¹n)<c>!", 3)

            local strMsg = "Kim S¬n ph¸p b¶o"
            WriteLog(strMsg)
        else
            Talk(1, "no", "Ch©n thµnh c¶m t¹ quý ®ång ®¹o ®· ñng hé vµ s¸t c¸nh cïng Phong ThÇn!")
        end
    else
        Talk(1, "no", "Ch©n thµnh c¶m t¹ quý ®ång ®¹o ®· ñng hé vµ s¸t c¸nh cïng Phong ThÇn!")
    end
end;

function no()
    CloseDialog()
end
