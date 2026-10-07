function main()
    if (IsHaveSpaceForTreasure(5) == 0) then
        InfoBox("ÄúĞèÒªÔ¤Áô4¸ñÒÔÉÏ±³°ü.")
        return
    end

    if (DelNormalItem(6, 1, 1596, 0) > 0) then
        local str = ""
        AddNormalItemBind(8, 1775, 2, 0, 0, 0, 1)
        AddNormalItemBind(6, 1, 1005, 0, 0, 0, 1)
        AddNormalItemBind(8, 35, 2, 0, 0, 0, 1)
        if (GetSex() == 0) then
            AddNormalItemBind(8, 1427, 2, 0, 0, 0, 1)
            str = "ThÕ Nh­ TËt Phong*Háa L«i Trang"
        else
            AddNormalItemBind(8, 1428, 2, 0, 0, 0, 1)
            str = "ThÕ Nh­ TËt Phong*Ph­îng L«i Trang"
        end

        Talk(1, "no", "Chóc mõng ngµi më ·âÉñÉúÈÕ×¨ÊôÀñ°ü, nhËn ®­îc <c=g>LÔ hép Phï Th¹ch 1 c¸i, Phï nhiÖm vô Chñ ®Ò ngµy 1 c¸i, Di Ngo¹i Phï 1 c¸iÒÔ¼°" .. str)
        WriteLog("[·âÉñÉúÈÕ×¨ÊôÀñ°ü][¿ªÆô³É¹¦]" .. str)
    else
        Talk(1, "no", "ThËt xin lçi, Më lÔ bao thÊt b¹i")
        WriteLog("[·âÉñÉúÈÕ×¨ÊôÀñ°ü][¿ªÆôÊ§°Ü]")
    end
end

function no()
    CloseDialog()
end
