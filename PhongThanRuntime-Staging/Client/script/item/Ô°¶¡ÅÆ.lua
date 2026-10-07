global_time = 165
global_get_count = 166

function main()

    if (HaveNormalItem(6, 1, 446, 1) == 0) then
        return
    end

    local nAccTime = GetGlobalValue(global_time)
    local nNowTime = LocalSystemTime()
    if (nAccTime == 0) or (math.floor(nAccTime / (24 * 3600)) ~= math.floor(nNowTime / (24 * 3600))) then
        SetGlobalValue(global_time, nNowTime)
        SetGlobalValue(global_get_count, 0)
    end

    if (GetLevel() > 80) then

        Msg2Player("Äú»ñµÃ 250000 ®iÓm¾­Ñé vµ 200 ®iÓm¾«Á¦")
        TopMessage("Äú»ñµÃ 250000 ®iÓm¾­Ñé vµ 200 ®iÓm¾«Á¦")
        AddOwnExp(250000)
        AddVigour(200)


    else

        local nExp = GetLevel() * 3000
        Msg2Player("B¹n nhËn ®­îc " .. math.floor(nExp) .. " ®iÓm kinh nghiÖm vµ 200 ®iÓm Tinh Lùc")
        TopMessage("B¹n nhËn ®­îc " .. math.floor(nExp) .. " ®iÓm kinh nghiÖm vµ 200 ®iÓm Tinh Lùc")
        AddOwnExp(nExp)
        AddVigour(200)


    end

    DelNormalItem(6, 1, 446, 1)
    WriteLog("ÈıÔÂáªÉ½: " .. GetName() .. "»î¶¯Íê³É, ³É¹¦ nhËn ½±Àø")

end
