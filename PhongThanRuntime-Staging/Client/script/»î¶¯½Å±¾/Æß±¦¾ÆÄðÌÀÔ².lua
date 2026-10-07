function main()

    if (HaveNormalItem(6, 1, 873, 0) <= 0) then
        return
    end

    local Exp = CheckExpLevel()

    DelNormalItem(6, 1, 873, 0)
    AddNormalItem(3, 1149, 0, 0, 0, 0)
    AddOwnExp(Exp)
    AddIBBuff(1357)
    AddEmoteBalloon(PlayerIndex, 17)
    Msg2Player("B¹n ®· dïng B¸nh Tr«i ThÊt B¶o Töu, nhËn ®­îc " .. Exp .. " ®iÓm kinh nghiÖm vµ m¶nh Tö thuû tinh.")
    AddGlobalNews("<c=g>" .. GetName() .. "<c>sau khi dïng B¸nh Tr«i ThÊt B¶o Töu, ph¸t hiÖn 1 <c=g>m¶nh Tö thuû tinh<c>, thËt lµ may m¾n!")
    if (math.random(1, 100) <= 20) then
        Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c>sau khi dïng B¸nh Tr«i ThÊt B¶o Töu, vç bông mét c¸ch tháa m·n, nhµn nh· nh­ thÇn tiªn!")
    end
    WriteLog(GetName() .. "§· sö dông B¸nh Tr«i ThÊt B¶o Töu")
end

function CheckExpLevel()
    no()
    local pLvl = GetLevel()
    if (pLvl <= 59) then
        return pLvl * 200
    elseif (pLvl > 59 and pLvl <= 89) then
        return pLvl * 400
    else
        return pLvl * 800
    end
end

function no()
    CloseDialog()
end
