function main()
    CloseDialog()
    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "ThËt xin lçi, hµnh trang cña ngµi kh«ng cã ®ñ 1 « trèng, xin h·y s¾p xÕp l¹i.")
        return
    end

    if (DelNormalItem(6, 1, 1655, 1) <= 0) then
        Talk(1, "no", "H·y ®Æt lÔ bao trong hµnh trang.")
        return
    end
    for i = 1, 3 do
        AddNormalItemBind(3, 135, 0, 0, 0, 0, 1)
    end
    ScrollMessage("NhËn ®­îc <c=y>Thä S¬n Th¹ch 3 c¸i <c>")
    Msg2Player("Ngµi sö dông Tói Thä S¬n Th¹ch-Nhá , nhËn ®­îc Thä S¬n Th¹ch 3 c¸i xin nhËn lÊy!")
    local y, m, d = GetYMD()
    if (y == 2017) and (m == 10) then
        WriteLog("[Tói Thä S¬n Th¹ch-Nhá][Thä S¬n Th¹ch 3 c¸i ]")
    end
end

function no()
    CloseDialog()
end
