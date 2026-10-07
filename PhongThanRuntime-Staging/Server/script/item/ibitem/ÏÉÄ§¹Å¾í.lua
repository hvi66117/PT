XianMoGuJuan = 2111
ItemID = { 6, 1, 1477, 1 }
function main(itemID)
    local Y, M, D = GetYMD()
    if (GetTaskByte(XianMoGuJuan, 4) ~= D) then
        SetTaskByte(XianMoGuJuan, 4, D)
        SetTaskByte(XianMoGuJuan, 3, 0)
    end
    if (GetTaskByte(XianMoGuJuan, 3) >= 5) then
        Talk(1, "no", "S¸ch Cæ Tiªn MaÃ¿Ìì×î¶àÊ¹ÓÃ5´Î, Çë¸ôÌìºóÔÙÊ¹ÓÃ.")
        return
    end

    if (DelNormalItem(ItemID[1], ItemID[2], ItemID[3], ItemID[4]) <= 0) then
        Talk(1, "no", "µÀ¾ßSö dông thÊt b¹i.")
        WriteLog("[S¸ch Cæ Tiªn Ma][Sö dông thÊt b¹i]")
        return
    end

    local times = GetTaskByte(XianMoGuJuan, 3)
    times = times + 1
    SetTaskByte(XianMoGuJuan, 3, times)

    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        ChangeJusticEvilCredit(-50)
        Msg2Player("Më S¸ch Cæ Tiªn Ma, nhËn ®­îc ÏÉÄ§ÉùÍû 50 ®iÓm")
        WriteLog("[S¸ch Cæ Tiªn Ma][NhËn ®­îcÄ§½çÉùÍû]")
    else
        ChangeJusticEvilCredit(50)
        Msg2Player("Më S¸ch Cæ Tiªn Ma, nhËn ®­îc ÏÉÄ§ÉùÍû 50 ®iÓm")
        WriteLog("[S¸ch Cæ Tiªn Ma][NhËn ®­îcÏÉ½çÉùÍû]")
    end

end

function no()
    CloseDialog()
end
