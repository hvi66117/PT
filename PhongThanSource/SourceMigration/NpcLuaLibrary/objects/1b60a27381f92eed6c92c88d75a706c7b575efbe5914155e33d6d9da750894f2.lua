function main()
    if (HaveNormalItem(6, 1, 984, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(8) == 0) then
        InfoBox("Tói kh«ng ®ñ 7 «, h·y s¾p xÕp tói.")
        return
    end

    DelNormalItem(6, 1, 984, 1)
    if (GetSex() == 0) then
        AddNormalItemBind(6, 1, 964, 0, 0, 0, 1)
    else
        AddNormalItemBind(6, 1, 965, 0, 0, 0, 1)
    end
    AddNormalItemBind(8, 162, 3, 0, 0, 0, 1)
    AddNormalItemBind(8, 163, 4, 0, 0, 0, 1)
    AddNormalItemBind(8, 233, 0, 0, 0, 0, 1)
    AddNormalItemBind(3, 41, 0, 0, 0, 0, 1)
    local nType = GetPlayerType()
    if (nType == 0) then
        AddNormalItem4(0, 10, 24, 1, 0, 0, 0, 30, 0)
    elseif (nType == 1) then
        AddNormalItem4(0, 10, 25, 1, 0, 0, 0, 30, 0)
    elseif (nType == 2) then
        AddNormalItem4(0, 10, 26, 1, 0, 0, 0, 30, 0)
    end
    AddNormalItemBind(8, 1397, 2, 0, 0, 0, 1)

    ScrollMessage("Më Hép Tói quµ Phong ThÇn T©n Lang")
    WriteLog("Më Hép Tói quµ Phong ThÇn T©n Lang")
end

function no()
    CloseDialog()
end
